/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : GM_SND
	Card Desc : ��ħ �۽�
	Card Hist :
----------------------------------------------------------------------------------*/
card GM_RESND
{
	#include <include.h>
	#include "globalcard.h"
	#include "Calendar.h"
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
		//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
		
		//�۽�ȭ��
		DEF_BUTTON_ID ( BID_SEND )		//���ü۽�
		DEF_BUTTON_ID ( BID_DAYEND )	//�ϸ���
		DEF_BUTTON_ID ( BID_WORKSCHDL )	//�۾�����
	    DEF_BUTTON_ID ( BID_PHOTO )     //�����۽�
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )
		DEF_OBJECT_ID ( TXT_TITLE )
		
		// �۽�ȭ��
		DEF_OBJECT_ID ( TXT_OBJECT )	//���
		DEF_OBJECT_ID ( TXT_USUAL )		//����
		DEF_OBJECT_ID ( TXT_ABSENCE )	//����
		DEF_OBJECT_ID ( TXT_TOTAL )		//��ü
		DEF_OBJECT_ID ( TXT_SENDCMPLT )	//�۽ſϷ�
		DEF_OBJECT_ID ( TXT_NSEND )		//�̼۽�
		DEF_OBJECT_ID ( TXT_TODAYGM )	//���ϰ�ħ
		DEF_OBJECT_ID ( TXT_SMS )		//���ڰ�ħ
		DEF_OBJECT_ID ( TXT_GOOBOON )	//����
		DEF_OBJECT_ID ( TXT_DATA1 )		//��ü_���
		DEF_OBJECT_ID ( TXT_DATA2 )		//��ü_����
		DEF_OBJECT_ID ( TXT_DATA3 )		//��ü_����
		DEF_OBJECT_ID ( TXT_DATA4 )		//�۽ſϷ�_���
		DEF_OBJECT_ID ( TXT_DATA5 )		//�۽ſϷ�_����
		DEF_OBJECT_ID ( TXT_DATA6 )		//�۽ſϷ�_����
		DEF_OBJECT_ID ( TXT_DATA7 )		//�̼۽�_���
		DEF_OBJECT_ID ( TXT_DATA8 )		//�̼۽�_����
		DEF_OBJECT_ID ( TXT_DATA9 )		//�̼۽�_����
		DEF_OBJECT_ID ( TXT_DATA10 )	//���ϰ�ħ_���
		DEF_OBJECT_ID ( TXT_DATA11 )	//���ϰ�ħ_����
		DEF_OBJECT_ID ( TXT_DATA12 )	//���ϰ�ħ_����
		DEF_OBJECT_ID ( TXT_DATA13 )	//��ħ�Ϸ� �ڷḦ �۽��ϼ���
		DEF_OBJECT_ID ( TXT_DATA14 ) 	//�۾�����
		DEF_OBJECT_ID ( TXT_DATA15 ) 	//�۾�����
		DEF_OBJECT_ID ( TXT_DATA16 )	//���ڰ�ħ
		
		DEF_OBJECT_ID ( ST_PHOTO )		//�����Ǽ�ST
		DEF_OBJECT_ID ( TXT_PHOTO )		//�����Ǽ�TXT
		
		DEF_OBJECT_ID ( LINE_DATA1 )	//LINE_DATA_1
		DEF_OBJECT_ID ( LINE_DATA2 )	//LINE_DATA_2
		DEF_OBJECT_ID ( LINE_DATA3 )	//LINE_DATA_3
		DEF_OBJECT_ID ( LINE_DATA4 )	//LINE_DATA_4
		DEF_OBJECT_ID ( LINE_DATA5 )	//LINE_DATA_5
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN	1
	
	#define GMSNDCNT 100		//��ħ��� �۽� ī��Ʈ(GMSNDCNT���� �۽�)
	
	//---------------------------------------------------------------
	// Struct_��ħ�ǻ� ������
	//---------------------------------------------------------------
	typedef struct _INSPDATA
	{
		char szMtr_num[20];
		char szIndi_insp_vc[20];
		char szIndi_insp_va[20];
		char szIndi_insp_vm[20];
		char szInsp_ymd[50];
		char szMemo[400];
	}	INSPDATA;
	
	INSPDATA m_stInspdata;
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	char m_szMtrnum[50];
	char m_szReqym[50];
	char m_szDeadlineflag[50];
	char m_szCompenstype[50];
	char m_szgmtr_job_ymd[9];
	char m_szScrPht[128];
	long m_nstrt = 0;
	long m_ntot = 0;
	long m_nSendFlag = 0;		// = 0 �ǻ� �������� ����, = 1 �ǻ� ���� ������ ����
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void SetStyle(void);
	void REDRAW(void);
	void SetBtnImg(void);
	void GM_DATASAND(void);
	void GM_WORKEND(void);
	long TR21361(void);
	long TR21366(void);

	void Send_Photo(void);
	long TR24263(void);
	void fsgetitem(char* szSource, char* szTarget, int id, int len );
	void Set_InspData(char* szMtrnum);
	
	void Send_Compens_Remove(void);
	long TR24264(void);
	
	void Snd_mtr_photo( void );
	long TR26001( void );
	
	void Snd_compens_photo( void );
	long TR26002( void );
	
	//---------------------------------------------------------------
	// �����ư
	//---------------------------------------------------------------
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
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),	
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���, �������� �ڷ� �۽�"),
		
		DLG_TEXT(  STARTX,		STARTY+ 65, 1000,  70, 0, 0, 0, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_DATA13, "���, �������� �ڷḦ �۽� �ϼ���."),
		
		DLG_LINE ( STARTX,      STARTY+139, 1000, STARTY+139, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT(  STARTX,		STARTY+144,  250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "�۾�����"),
		DLG_TEXT(  STARTX+250,	STARTY+144,  600,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_BUTTON(STARTX+850,	STARTY+144,  150,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WORKSCHDL, "��"),
		
		DLG_LINE ( STARTX,      STARTY+218, 1000, STARTY+218, DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_TEXT ( STARTX,		STARTY+223,  250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_GOOBOON, "����"),
		DLG_TEXT ( STARTX+250,	STARTY+223,  250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_OBJECT, "���"),
		DLG_TEXT ( STARTX+500,	STARTY+223,  250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_USUAL, "����"),
		DLG_TEXT ( STARTX+750,	STARTY+223,  250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_ABSENCE, "����"),
		DLG_TEXT ( STARTX,		STARTY+293,  250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_TOTAL, "��ü"),
		DLG_TEXT ( STARTX+250,	STARTY+293,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA1, ""),		
		DLG_TEXT ( STARTX+500,	STARTY+293,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA2, ""),		
		DLG_TEXT ( STARTX+750,	STARTY+293,  250,  70, 0, 0, 0, EDITSTY_BORDER			   , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA3, ""),		
		DLG_TEXT ( STARTX,		STARTY+363,  250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_SENDCMPLT, "�۽ſϷ�"),
		DLG_TEXT ( STARTX+250,	STARTY+363,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA4, ""),		
		DLG_TEXT ( STARTX+500,	STARTY+363,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA5, ""),		
		DLG_TEXT ( STARTX+750,	STARTY+363,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA6, ""),		
		DLG_TEXT ( STARTX,		STARTY+433,	 250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_NSEND, "�̼۽�"),
		DLG_TEXT ( STARTX+250,	STARTY+433,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA7, ""),		
		DLG_TEXT ( STARTX+500,	STARTY+433,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA8, ""),		
		DLG_TEXT ( STARTX+750,	STARTY+433,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA9, ""),		
		DLG_TEXT ( STARTX,		STARTY+503,  250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_TODAYGM, "���ϰ�ħ"),
		DLG_TEXT ( STARTX+250,	STARTY+503,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA10, ""),	
		DLG_TEXT ( STARTX+500,	STARTY+503,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA11, ""),	
		DLG_TEXT ( STARTX+750,	STARTY+503,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT ( STARTX,		STARTY+573,  250,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_SMS, "���ڰ�ħ"),
		DLG_TEXT ( STARTX+250,	STARTY+573,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA16, ""),
		
		DLG_LINE ( STARTX,      STARTY+647, 1000, STARTY+647, DARKSLATEBLUE, 10, LINE_DATA3),
		
		DLG_LINE ( STARTX,      STARTY+715, 1000, STARTY+715, DARKSLATEBLUE, 10, LINE_DATA4),

		DLG_TEXT ( STARTX,		STARTY+720,  300,  70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , ST_PHOTO, "�̼۽� ����"),
		DLG_TEXT ( STARTX+300,	STARTY+720,  250,  70, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR   , TXTINCTRLBK, TXT_PHOTO, ""),
		DLG_BUTTON(STARTX+550,	STARTY+720,  450,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "�� �� �� ��"),
		
		DLG_LINE ( STARTX,      STARTY+794, 1000, STARTY+794, DARKSLATEBLUE, 10, LINE_DATA5),
		
		DLG_BUTTON(STARTX,		STARTY+799,  500, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DAYEND, "�� �� ��"),
		DLG_BUTTON(STARTX+500,	STARTY+799,  500, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "�� �� �� ��"),
	};	
	
	//---------------------------------------------------------------
	//	main
	//---------------------------------------------------------------
	bool main(quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
	//---------------------------------------------------------------
	// OnInit Function
	//---------------------------------------------------------------	
	void OnInit(char bFirst)
	{
		char szSql[150];
	
		switch (bFirst)
		{
			case INIT_MAIN:	
			
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				// �����̰�ħ FLAG ������Ʈ
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE REGUMDATA SET SEND_YN = 'S' WHERE SEND_YN = 'I'", 0, 0, 0);		
				g_Sql_DirectExecute(szSql);

				SetBtnImg();
				SetStyle();
				REDRAW();
				
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

	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : 
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOOBOON)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJECT)   , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USUAL)    , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ABSENCE)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TOTAL)    , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SENDCMPLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NSEND)    , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TODAYGM)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SMS)      , EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_PHOTO)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PHOTO)	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		long d, k;
		char szDate[11];
		char szToday[10];
		
		switch(ID)
		{
			/********************************/
			/* ����                         */
			/********************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "��ħ �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
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
				Card_Move("GM_DMMENU");
				break;	
				
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/********************************/
			/* ��ħ�۽�                     */
			/********************************/	
			case BID_WORKSCHDL:
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)m_szgmtr_job_ymd, 0x00, sizeof(m_szgmtr_job_ymd));
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					
					Str_ItoA ( d, m_szgmtr_job_ymd, 10);
					Str_ItoA ( Time_GetDate(), szToday, 10);
					
					if( Str_AtoI(szToday) > Str_AtoI(m_szgmtr_job_ymd) )
					{
						g_Str_DateType(szDate, m_szgmtr_job_ymd);
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), szDate );
					}
				}
				
				break;
				
			case BID_SEND:
				g_SeverConnection();
				GM_DATASAND();
				
				break;
				
			case BID_DAYEND:
				GM_WORKEND();
				
				break;
			
			case BID_PHOTO:
			
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_PHOTO)), "0") != 0 )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "�̼۽� ������ �۽��ϰڽ��ϱ�?")  == MB_OK)
					{
						Snd_mtr_photo();
					}
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "�̼۽� ������ �����ϴ�.");
				}
				
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : 
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		char szToday[10];
		char sztmp[200]; 
		char szSql[500];
		long mtr_cnt = 0;
		long compens_cnt = 0;
		
		Mem_Set( (byte*)m_szgmtr_job_ymd, 0x00, sizeof(m_szgmtr_job_ymd) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		
		Str_ItoA(Time_GetDate(), m_szgmtr_job_ymd, 10);
		Str_ItoA(Time_GetDate(), szToday, 10);
		g_Str_DateType(sztmp, m_szgmtr_job_ymd);
		
		/*********************/
		/* �۾�����          */
		/*********************/
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), sztmp );
		
		/*********************/
		/* ��ü              */
		/*********************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE <> '2' AND MTR_WORK_CODE <> 'L' AND (SEND_YN = 'Y' OR SEND_YN = 'S')", 0 ,0 ,0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE = '2' AND MTR_WORK_CODE <> 'L' AND (SEND_YN = 'Y' OR SEND_YN = 'S')", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), sztmp );
		
		/*********************/
		/* �۽ſϷ�          */
		/*********************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE SEND_YN = 'Y' AND MTR_WORK_CODE <> 'L' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE <> '2' AND MTR_WORK_CODE <> 'L' AND SEND_YN = 'Y'", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE = '2' AND MTR_WORK_CODE <> 'L' AND SEND_YN = 'Y'", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), sztmp );

		/*********************/
		/* �̼۽�            */
		/*********************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE SEND_YN = 'S' AND MTR_WORK_CODE <> 'L'", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), sztmp );
		m_ntot = Str_AtoI(sztmp);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE <> '2' and MTR_WORK_CODE <> '' AND MTR_WORK_CODE <> 'L' AND SEND_YN = 'S'", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), sztmp );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE = '2' AND MTR_WORK_CODE <> 'L' AND SEND_YN = 'S'", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), sztmp );
		
		/*********************/
		/* ���ϰ�ħ          */
		/*********************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cat(szToday, "%");
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE INDI_DATE LIKE '%s' AND MTR_WORK_CODE <> 'L'",szToday, 0, 0   );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE <> '2' AND MTR_WORK_CODE <> 'L' AND INDI_DATE LIKE '%s' AND (SEND_YN = 'Y' OR SEND_YN = 'S')",szToday, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11), sztmp );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE = '2' AND MTR_WORK_CODE <> 'L' AND INDI_DATE LIKE '%s' AND (SEND_YN = 'Y' OR SEND_YN = 'S')",szToday, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), sztmp );

		/*********************/
		/* ���ڰ�ħ          */
		/*********************/
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Sql_RetStr("SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE = 'L'", 10, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), sztmp );
		
		/*********************/
		/* �̼۽Ż���        */
		/*********************/
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		mtr_cnt = g_DirFS_Count(PHOTO_GMMTR, "*");
		compens_cnt = g_DirFS_Count(PHOTO_GMCOMPENS, "*");
		
		Str_ItoA( mtr_cnt + compens_cnt , sztmp, 10 );
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_PHOTO), sztmp );
	}
	
	/*=======================================================================================
	�Լ��� : GM_DATASAND
	��  �� : ��ħ ��� �۽� / FR21361
	Param  : 
	Return : 
	========================================================================================*/
	void GM_DATASAND(void)
	{
		char szUrl[200];
		char szSql[1000];
		char szSql2[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;		
		char szcenter_cd[3];
		char szzone_manage_num[10];
		char szgmtr_job_ymd[9];
		char szgmtr_meths[3];
		char szbranch_cd[7];
		char sznm_kor[64];
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szbuf, 0x00, sizeof( szbuf) );
		
		// REGUMDATA COUNT
		SPRINT( szSql ,"SELECT COUNT(*) FROM REGUMDATA WHERE SEND_YN = 'S' AND MTR_WORK_CODE <> 'L'", 0 ,0 ,0 );
		g_Sql_RetStr(szSql, 4, szbuf );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), szbuf );
		
		m_ntot = Str_AtoI(szbuf);
		
		if( m_ntot == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�۽��� �ڷᰡ �����ϴ�.");
			return;
		}
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szzone_manage_num, 0x00, sizeof( szzone_manage_num) );
		SPRINT( szSql, "SELECT PARAM6 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 5, szzone_manage_num);

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szbranch_cd, 0x00, sizeof( szbranch_cd) );
		SPRINT( szSql, "SELECT PARAM4 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 6, szbranch_cd);
				
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szcenter_cd, 0x00, sizeof( szcenter_cd) );
		SPRINT( szSql, "SELECT PARAM5 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 2, szcenter_cd);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szgmtr_meths, 0x00, sizeof( szgmtr_meths) );
		SPRINT( szSql, "SELECT PARAM7 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 2, szgmtr_meths);
		
		//PROGRESS_DUMP("");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 21361, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "branch_cd",         szbranch_cd );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",         szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",   szzone_manage_num );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_job_ymd",      m_szgmtr_job_ymd );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_meths",        szgmtr_meths );
		
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SQL_ConvUcStr( sznm_kor, stUserinfo.sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_nm",           sznm_kor );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT REQ_YM, DEADLINE_FLAG, MTR_NUM, GMTR_APPLY_YMD, GMTR_OBJ_FLAG \
						     , '%s' AS GMTR_DATA_FLAG, MTR_WORK_CODE AS GMTR_JOB_CD, MTR_WORK_CODE AS SITE_VERIFY_CD, INDI_SET_VM AS INDI_MTR_THIS_MM, INDI_SET_VA AS INDI_COMPENS_THIS_MM_VA \
						     , INDI_SET_VC AS INDI_COMPENS_THIS_MM_VC, INDI_DATE AS INDI_COLL_DTM, '%s' AS GMTR_EMPID, IFNULL(RMK, '') AS RMK, MONITOR_FLAG \
						     , CUSTOM_SIGN, IFNULL(CURR_TEMPER, '') AS CURR_TEMPER, IFNULL(CURR_PRES, '') AS CURR_PRES, IFNULL(CURR_REVIS_PARA, '') AS CURR_REVIS_PARA \
						  FROM REGUMDATA \
						 WHERE SEND_YN = 'S' AND MTR_WORK_CODE <> 'L' "
					 , szgmtr_meths, stUserinfo.szemployee_id, 0 );
		
		Mem_Set((byte*)szSql2, 0x00, sizeof(szSql2));	
		SPRINT( szSql2, "LIMIT %d, %d", m_nstrt, GMSNDCNT, 0);
		Str_Cat(szSql ,szSql2 );
		// PRINT("GM_DATASAND m_nstrt : %d",m_nstrt,0,0);
		callBackfunc = TR21361; //��ſϷ� �Ŀ� ȣ�� �Լ�		
		HTTP_UploadData  ( szUrl, "FR21361_IN",  "FR21361" , sndbuf, szbuf, szSql);
	}
	
	/*=======================================================================================
	�Լ��� : TR21361
	��  �� : FR21361 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR21361(void)
	{
		char szSql[200];
		
		g_Sock_Close();
		
		// PRINT("g_Chk_Json(21361)",0,0,0);
		if(g_Chk_Json(21361) >= 0)
		{
			if(m_ntot > m_nstrt + GMSNDCNT )
			{
				m_nstrt = m_nstrt + GMSNDCNT;
				// PRINT("TR21361 m_nstrt : %d",m_nstrt,0,0);
				Sleep(1000);
				GM_DATASAND();
				
			   	return 1;
			}
			
			g_Sock_Close();
			
			//Send_Photo();
			Send_Compens_Remove();
			
			ON_DRAW();
			
			return 1;
		}
		else
		{
			CloseMessageBox();
			REDRAW();
			ON_DRAW();
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Send_Compens_Remove
	��  �� : ������ ���� / FR24264
	Param  : 
	Return : 
	========================================================================================*/
	void Send_Compens_Remove(void)
	{
		char szUrl[200];
		char szSql[600];
		char szSql2[100];
		char szbuf[128];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		
		char szcenter_cd[3];
		char szzone_manage_num[10];
		char szgmtr_job_ymd[9];
		char szgmtr_meths[3];
		char szbranch_cd[7];
		char sznm_kor[64];
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szbuf, 0x00, sizeof( szbuf) );
		
		SPRINT( szSql ,"SELECT COUNT(*) FROM GUM_COMPENS_REMOVE_REQ WHERE SEND_YN = 'S' ", 0 ,0 ,0 );
		g_Sql_RetStr(szSql, 4, szbuf );
		
		// GUM_COMPENS_REMOVE_REQ�� �۽��ڷ� ������ Send_Photo() �Լ� ȣ��
		if( Str_AtoI(szbuf) <= 0 ) 
		{
			Send_Photo();
			return;	
		}
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 24264, FALSE);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		SPRINT( szSql, " SELECT REQ_YM, DEADLINE_FLAG, MTR_NUM, USE_CONT_NUM, REMOVE_REQ_YMD \
					 		  , REMOVE_REQ_TIME, REMOVE_REQ_EMPID, CONF_NM, SIGN \
                           FROM GUM_COMPENS_REMOVE_REQ WHERE SEND_YN = 'S' "
		             , 0, 0, 0 );

		callBackfunc = TR24264;
					
		HTTP_UploadData  ( szUrl, "FR24264_IN",  "FR24264" , sndbuf, szDbpath, szSql);
		
		return;
	}
	
	
	/*=======================================================================================
	�Լ��� : TR24264
	��  �� : FR24264 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR24264(void)
	{
		char szSql[200];
		
		g_Sock_Close();

		if(g_Chk_Json(24264) >= 0)
		{
			g_Sql_DirectExecute( "UPDATE GUM_COMPENS_REMOVE_REQ SET SEND_YN = 'Y' WHERE SEND_YN = 'S'" );
			
			Send_Photo();
			
			ON_DRAW();
			
			return 1;
		}
		else
		{
			CloseMessageBox();
			REDRAW();
			ON_DRAW();
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Send_Photo
	��  �� : �ǻ� ���� / FR24263
	Param  : 
	Return : 
	========================================================================================*/
	void Send_Photo(void)
	{
		char szTmp[350];
		char szMemo[400];
		char szSql[300];
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char szReqym[20];
		char szDeadlineflag[20];
		char szCenterCd[20];
		char* sndbuf;
		char* szfile;
		char* filedata;
		long ret=0, nRet, filesize, fd;
		long lCnt = 0;
		handle file;		

		Mem_Set((byte*)szReqym, 0x00, sizeof(szReqym));
		g_Sql_RetStr("SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '10'", 10, szReqym );
		
		Mem_Set((byte*)szDeadlineflag, 0x00, sizeof(szDeadlineflag));
		g_Sql_RetStr("SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '10'", 5, szDeadlineflag );

		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_GM );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		
		// ������ �ִ� ���
		if(nRet > 0)
		{
			m_nSendFlag = 0;
		
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 24263, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			JSON_SetValue( g_pjcomm, 'C', "req_ym",          szReqym );
			JSON_SetValue( g_pjcomm, 'C', "deadline_flag",   szDeadlineflag );
			JSON_SetValue( g_pjcomm, 'C', "center_cd",       stUserinfo.szcenter_cd );
			
			Mem_Set((byte*)m_szMtrnum, 0x00, sizeof(m_szMtrnum));
			fsgetitem(m_szScrPht+9, m_szMtrnum, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num",         m_szMtrnum );
			
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "indi_insp_vc",       szdata );
			
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "indi_insp_va",       szdata );
			
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 4, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "indi_insp_vm",       szdata );
			
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 5, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "insp_ymd",       szdata );

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*)szMemo, 0x00, sizeof(szMemo) );
			
			SPRINT( szSql, "SELECT INSP_MEMO FROM REGUMDATA WHERE MTR_NUM = '%s' ", m_szMtrnum, 0, 0 );
			g_Sql_RetStr(szSql, 300, szTmp );
			SQL_ConvUcStr( szMemo, szTmp );
			JSON_SetValue( g_pjcomm, 'C', "memo",       szMemo );

			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);

			sndbuf = JSON_toString(g_pjcomm);
			
			g_Save_JsonFile(sndbuf);
			
			callBackfunc = TR24263;
			HTTP_DownloadData  ( szUrl, "FR24263_IN",  "FR24263" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		// ������ ���� ���
		else
		{
			lCnt = 0;
			
			g_Sql_RetInt("SELECT COUNT(*) FROM REGUMDATA WHERE INSP_SAVE_YN = 'S' AND INSP_YN = 'Y'" , &lCnt );
			
			if( lCnt > 0 )
			{
				m_nSendFlag = 1;
			
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				g_Sql_RetStr("SELECT MTR_NUM FROM REGUMDATA WHERE INSP_SAVE_YN = 'S' AND INSP_YN = 'Y' LIMIT 0,1", 20, szTmp );
				
				// �ǻ� ����ü Setting
				Set_InspData(szTmp);
			
				if( g_pjcomm != NULL)
				{
					JSON_Finalize( g_pjcomm );
					g_pjcomm = NULL;
				}
				
				g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 24263, FALSE);
						
				Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
				GET_FILENM(szDbpath, SQLITE_DB);
				
				JSON_SetValue( g_pjcomm, 'C', "req_ym",          szReqym );
				JSON_SetValue( g_pjcomm, 'C', "deadline_flag",   szDeadlineflag );
				JSON_SetValue( g_pjcomm, 'C', "center_cd",       stUserinfo.szcenter_cd );
				
				JSON_SetValue( g_pjcomm, 'C', "mtr_num",         m_stInspdata.szMtr_num );
				JSON_SetValue( g_pjcomm, 'C', "indi_insp_vc",    m_stInspdata.szIndi_insp_vc );
				JSON_SetValue( g_pjcomm, 'C', "indi_insp_va",    m_stInspdata.szIndi_insp_va );
				JSON_SetValue( g_pjcomm, 'C', "indi_insp_vm",    m_stInspdata.szIndi_insp_vm );
				JSON_SetValue( g_pjcomm, 'C', "insp_ymd",        m_stInspdata.szInsp_ymd );

				SQL_ConvUcStr( szMemo, m_stInspdata.szMemo );
				JSON_SetValue( g_pjcomm, 'C', "memo",            szMemo );
				
				JSON_SetValue( g_pjcomm, 'C', "photo",  "" );
	
				sndbuf = JSON_toString(g_pjcomm);
				
				g_Save_JsonFile(sndbuf);
				
				callBackfunc = TR24263;
				HTTP_DownloadData  ( szUrl, "FR24263_IN",  "FR24263" , sndbuf, szDbpath);
				
				if(file != NULL )
				{
					BASE64_Finalize(file);
					file = NULL;
				}
			}
			else
			{
				g_Sock_Close();
				
				g_Sql_DirectExecute( "UPDATE REGUMDATA SET SEND_YN = 'Y' WHERE SEND_YN = 'S' AND MTR_WORK_CODE <> 'L'" );
	
				MessageBoxEx (CONFIRM_OK, "��ħ �۽��� �Ϸ��Ͽ����ϴ�.");
				
				REDRAW();
			}
		}

		return;
	}

	/*=======================================================================================
	�Լ��� : TR24263
	��  �� : FR24263 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR24263(void)
	{
		long lRet = 0;
		char szTmp[30];
		char szDirPath[256];

		if(g_Chk_Json( 24263 ) >= 0)
		{
			// �ǻ� ������ �ִ� ���
			if( m_nSendFlag == 0 )
			{
				Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
				SPRINT(szDirPath, "UPDATE REGUMDATA SET INSP_SAVE_YN = 'Y' WHERE MTR_NUM = '%s' AND INSP_SAVE_YN = 'S' AND INSP_YN = 'Y' ", m_szMtrnum, 0, 0 );
				g_Sql_DirectExecute( szDirPath );
				
				FFS_Delete(m_szScrPht);
			}
			// �ǻ� ������ ���� ���
			else if( m_nSendFlag == 1 )
			{
				Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
				SPRINT(szDirPath, "UPDATE REGUMDATA SET INSP_SAVE_YN = 'Y' WHERE MTR_NUM = '%s' AND INSP_SAVE_YN = 'S' AND INSP_YN = 'Y' ", m_stInspdata.szMtr_num, 0, 0 );
				g_Sql_DirectExecute( szDirPath );
			}

			Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
			Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
			lRet = 0;
			
			Str_Cpy(szDirPath, PHOTO_GM );
			
			lRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
			
			//���� ������ �ǻ絥���� Ȯ��
			if(lRet <= 0)
			{
				
				lRet = 0;
				g_Sql_RetInt("SELECT COUNT(*) FROM REGUMDATA WHERE INSP_SAVE_YN = 'S' AND INSP_YN = 'Y'" , &lRet );
			}
			
			if(lRet > 0)
			{
				Send_Photo();
				
				return 1;
			}
			else
			{
				g_Sock_Close();
			
				g_Sql_DirectExecute( "UPDATE REGUMDATA SET SEND_YN = 'Y' WHERE SEND_YN = 'S' AND MTR_WORK_CODE <> 'L'" );
				
				MessageBoxEx (CONFIRM_OK, "��ħ �۽��� �Ϸ��Ͽ����ϴ�.");
				
				REDRAW();
				
				return 1;
			}
		}
		else
		{
			g_Sock_Close();
		
			CloseMessageBox();
			REDRAW();
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : fsgetitem
	��  �� : �����̸�
	Param  : 
	Return : 
	========================================================================================*/
	void fsgetitem( char* szSource, char* szTarget, int id, int len )
	{
		int i;
		int idx;
		int ids;
	
		idx = 0;
		ids = 1;
		
		for( i = 0; i < len; i++ )
		{
			if(szSource[i] == '_' || szSource[i] == '.')
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

	/*=======================================================================================
	�Լ��� : Set_InspData
	��  �� : �ǻ� ����ü Setting
	Param  : 
	Return : 
	========================================================================================*/
	void Set_InspData(char* szMtrnum)
	{
		long i;
		char szindex[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&m_stInspdata, 0x00, sizeof(m_stInspdata));

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		//INSP_YN = �ǻ��󿩺�, INSP_SAVE_YN = �ǻ絥���� ���� ����
		hstmt = sql->CreateStatement(sql, "SELECT MTR_NUM, INDI_INSP_VM, INDI_INSP_VA, INDI_INSP_VC, INSP_YMD \
												, INSP_MEMO \
										     FROM REGUMDATA WHERE MTR_NUM = ? AND INSP_SAVE_YN = 'S' AND INSP_YN = 'Y'"
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)szMtrnum, 20, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) m_stInspdata.szMtr_num		, 19 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stInspdata.szIndi_insp_vm	, 19 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stInspdata.szIndi_insp_va	, 19 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stInspdata.szIndi_insp_vc	, 19 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) m_stInspdata.szInsp_ymd		, 49 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stInspdata.szMemo			, 399+ 1, DECRYPT );
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}

Finally:
		DelSqLite(sql);
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : GM_WORKEND
	��  �� : �ϸ��� �۽�
	Param  : 
	Return : 
	========================================================================================*/
	void GM_WORKEND(void)
	{
		char szUrl[200];
		char szSql[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;		
		char szcenter_cd[3];
		char szzone_manage_num[6];
		char szgmtr_job_ymd[9];
		
		if( MessageBoxEx (CONFIRM_YESNO, "�ϸ����� �Ͻðڽ��ϱ�?") != MB_OK  ) 
		{
			return;
		}
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szzone_manage_num, 0x00, sizeof( szzone_manage_num) );
		SPRINT( szSql, "SELECT PARAM6 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 5, szzone_manage_num);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szcenter_cd, 0x00, sizeof( szcenter_cd) );
		SPRINT( szSql, "SELECT PARAM5 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 2, szcenter_cd);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 21366, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",         szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",   szzone_manage_num );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_job_ymd",      m_szgmtr_job_ymd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		callBackfunc = TR21366;
		ret = HTTP_DownloadData(szUrl, "FR21366_IN",  "FR21366" , sndbuf, szbuf );	
	}
	
	/*=======================================================================================
	�Լ��� : TR21366
	��  �� : FR21366 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR21366(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(21366) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "�ϸ����� �Ϸ��Ͽ����ϴ�.");
			ON_DRAW();
			return 1;
		}
		else
		{
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Snd_mtr_photo
	��  �� : �跮�� ���� �۽�, FR26001
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_mtr_photo( void )
	{
		char szTmp[500];
		char szSql[500];
		
		char szUrl[500];
		char szDbpath[300];
		char szDirPath[300];
		char szfilenm[300];
		
		char* sndbuf;
		char* szfile;
		char* filedata;
		
		long ret = 0;
		long nRet = 0;
		long filesize = 0;
		long fd = 0;
		long lCnt = 0;
		
		handle file;		
		
		Mem_Set( (byte*)m_szScrPht, 0x00, sizeof(m_szScrPht) );
		Mem_Set( (byte*)szDirPath, 0x00, sizeof(szDirPath) );
		
		Str_Cpy( szDirPath, PHOTO_GMMTR );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht );
		
		if( nRet > 0 )
		{
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 26001, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
			
			Mem_Set((byte*)m_szMtrnum, 0x00, sizeof(m_szMtrnum));
			g_Fsgetitem(m_szScrPht+13, m_szMtrnum, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num", m_szMtrnum );
			PRINT("MTR_NUM : %s",m_szMtrnum,0,0);
			
			Mem_Set((byte*)m_szReqym, 0x00, sizeof(m_szReqym));
			g_Fsgetitem(m_szScrPht+13, m_szReqym, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "req_ym", m_szReqym );
			PRINT("REQ_YM : %s",m_szReqym,0,0);
			
			Mem_Set((byte*)m_szDeadlineflag, 0x00, sizeof(m_szDeadlineflag));
			g_Fsgetitem(m_szScrPht+13, m_szDeadlineflag, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "deadline_flag", m_szDeadlineflag );
			PRINT("DEADLINE_FLAG : %s",m_szDeadlineflag,0,0);
			
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo_mtr", szfile );
			
			free((byte*)filedata);

			sndbuf = JSON_toString(g_pjcomm);
			
			g_Save_JsonFile(sndbuf);
			
			callBackfunc = TR26001;
			HTTP_DownloadData  ( szUrl, "FR26001_IN",  "FR26001" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			Snd_compens_photo();
		}

		return;
	}
	
	/*=======================================================================================
	�Լ��� : TR26001
	��  �� : FR26001 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR26001( void )
	{
		long lRet = 0;
		char szTmp[500];
		char szDirPath[500];
		
		if( g_Chk_Json(26001) >= 0 )
		{
			VmSleep(100);
			
			// 1. ������ ������Ʈ
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_MTR_YN = 'Y' WHERE REQ_YM = '%s' AND DEADLINE_FLAG = '%s' AND MTR_NUM = '%s'", m_szReqym, m_szDeadlineflag, m_szMtrnum );
			g_Sql_DirectExecute( szTmp ); 
			
			// 2. ���ϻ���
			FFS_Delete(m_szScrPht);
			
			VmSleep(100);
			
			// 3. �ʱ�ȭ
			Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
			Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
			Mem_Set((byte*)m_szMtrnum, 0x00, sizeof(m_szMtrnum));
			Mem_Set((byte*)m_szReqym, 0x00, sizeof(m_szReqym));
			Mem_Set((byte*)m_szDeadlineflag, 0x00, sizeof(m_szDeadlineflag));
			
			lRet = 0;
			
			Str_Cpy(szDirPath, PHOTO_GMMTR );
			
			lRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
			
			if( lRet > 0 )
			{
				Snd_mtr_photo();	
				return 1;
			}
			else
			{
				g_Sock_Close();
				Snd_compens_photo();
				return 1;
			}
		}
		else
		{
			g_Sock_Close();
		
			CloseMessageBox();
			REDRAW();
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Snd_compens_photo
	��  �� : ������ ���� �۽�, FR26002
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_compens_photo( void )
	{
		char szTmp[500];
		char szSql[500];
		
		char szUrl[500];
		char szDbpath[300];
		char szDirPath[300];
		char szfilenm[300];
		
		char* sndbuf;
		char* szfile;
		char* filedata;
		
		long ret = 0;
		long nRet = 0;
		long filesize = 0;
		long fd = 0;
		long lCnt = 0;
		
		handle file;		
		
		Mem_Set( (byte*)m_szScrPht, 0x00, sizeof(m_szScrPht) );
		Mem_Set( (byte*)szDirPath, 0x00, sizeof(szDirPath) );
		
		Str_Cpy( szDirPath, PHOTO_GMCOMPENS );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht );
			
		if( nRet > 0 )
		{
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 26002, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
			
			Mem_Set((byte*)m_szMtrnum, 0x00, sizeof(m_szMtrnum));
			g_Fsgetitem(m_szScrPht+17, m_szMtrnum, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num", m_szMtrnum );
			PRINT("MTR_NUM : %s",m_szMtrnum,0,0);
			
			Mem_Set((byte*)m_szReqym, 0x00, sizeof(m_szReqym));
			g_Fsgetitem(m_szScrPht+17, m_szReqym, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "req_ym", m_szReqym );
			PRINT("REQ_YM : %s",m_szReqym,0,0);
			
			Mem_Set((byte*)m_szDeadlineflag, 0x00, sizeof(m_szDeadlineflag));
			g_Fsgetitem(m_szScrPht+17, m_szDeadlineflag, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "deadline_flag", m_szDeadlineflag );
			PRINT("DEADLINE_FLAG : %s",m_szDeadlineflag,0,0);
			
			Mem_Set((byte*)m_szCompenstype, 0x00, sizeof(m_szCompenstype));
			g_Fsgetitem(m_szScrPht+17, m_szCompenstype, 4, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "type", m_szCompenstype );
			PRINT("TYPE : %s",m_szCompenstype,0,0);
			
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo_compens", szfile );
			
			free((byte*)filedata);

			sndbuf = JSON_toString(g_pjcomm);
			
			g_Save_JsonFile(sndbuf);
			
			callBackfunc = TR26002;
			HTTP_DownloadData  ( szUrl, "FR26002_IN",  "FR26002" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			REDRAW();
		}

		return;
	}
	
	/*=======================================================================================
	�Լ��� : TR26002
	��  �� : FR26002 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR26002( void )
	{
		long lRet = 0;
		char szTmp[300];
		char szDirPath[256];
		
		if( g_Chk_Json(26002) >= 0 )
		{
			VmSleep(100);
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			
			// 1. ������ ������Ʈ
			if( Str_Cmp(m_szCompenstype, "1" ) == 0 )
			{	
				SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_COMPENS_VC_YN = 'Y' WHERE REQ_YM = '%s' AND DEADLINE_FLAG = '%s' AND MTR_NUM = '%s'", m_szReqym, m_szDeadlineflag, m_szMtrnum );
				g_Sql_DirectExecute( szTmp ); 
			}
			else if( Str_Cmp(m_szCompenstype, "2" ) == 0  )
			{
				SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_COMPENS_VA_YN = 'Y' WHERE REQ_YM = '%s' AND DEADLINE_FLAG = '%s' AND MTR_NUM = '%s'", m_szReqym, m_szDeadlineflag, m_szMtrnum );
				g_Sql_DirectExecute( szTmp ); 
			}
			else if( Str_Cmp(m_szCompenstype, "3" ) == 0  )
			{
				SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_COMPENS_VM_YN = 'Y' WHERE REQ_YM = '%s' AND DEADLINE_FLAG = '%s' AND MTR_NUM = '%s'", m_szReqym, m_szDeadlineflag, m_szMtrnum );
				g_Sql_DirectExecute( szTmp ); 
			}
			
			// 2. ���ϻ���
			FFS_Delete(m_szScrPht);
			
			VmSleep(100);
			
			// 3. �ʱ�ȭ
			Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
			Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
			Mem_Set((byte*)m_szMtrnum, 0x00, sizeof(m_szMtrnum));
			Mem_Set((byte*)m_szReqym, 0x00, sizeof(m_szReqym));
			Mem_Set((byte*)m_szDeadlineflag, 0x00, sizeof(m_szDeadlineflag));
			Mem_Set((byte*)m_szCompenstype, 0x00, sizeof(m_szCompenstype));
			
			lRet = 0;
			
			Str_Cpy(szDirPath, PHOTO_GMCOMPENS );
			
			lRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
			
			if( lRet > 0 )
			{
				Snd_compens_photo();	
				return 1;
			}
			else
			{
				g_Sock_Close();
				REDRAW();
				
				return 1;
			}
		}
		else
		{
			g_Sock_Close();
		
			CloseMessageBox();
			REDRAW();
			
			return -1;
		}
	}
}
