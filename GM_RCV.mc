/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_RCV
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
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_RECV )			//�����ϱ�
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
		DEF_OBJECT_ID ( TXT_TITLE )				//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_WORKDT )			//�۾�����
		DEF_OBJECT_ID ( TXT_CHARGEDT )			//û�����
		DEF_OBJECT_ID ( TXT_PERIODPAY )			//����
		DEF_OBJECT_ID ( TXT_GMSTANDT )			//��ħ������
		DEF_OBJECT_ID ( TXT_CUSTOMCNTR )		//������
		DEF_OBJECT_ID ( TXT_AREAMNGNUM )		//����������ȣ
		DEF_OBJECT_ID ( TXT_GMMETHOD )			//��ħ���
		DEF_OBJECT_ID ( TXT_NOTIFY )			//������
		
		DEF_OBJECT_ID ( EDT_WORKDT )			//�۾����� �Է�
		DEF_OBJECT_ID ( EDT_CUSTOMCNTR )		//������ �Է�
		DEF_OBJECT_ID ( EDT_AREAMNGNUM )		//����������ȣ �Է�
		
		DEF_OBJECT_ID ( ICON_TITLE )
				
		DEF_OBJECT_ID ( CMB_CHARGEDT ) 							//û����� �޺��ڽ�
		DEF_OBJECT_ID ( CMB_PERIODPAY = CMB_CHARGEDT+3 ) 		//���� �޺��ڽ�
		DEF_OBJECT_ID ( CMB_GMSTANDT = CMB_PERIODPAY+3 ) 		//���� �޺��ڽ�
		DEF_OBJECT_ID ( CMB_GMMETHOD = CMB_GMSTANDT+3 ) 		//��ħ��� �޺��ڽ�
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	char m_szPERIODPAY[20];
	long m_lActiveIndex = -1;
	
	void SetBtnImg(void);
	void SetStyle(void);
	void REDRAW(void);
	void Set_zone_manage_num(char *temp, long time );
	void UPdate_Rcvlog(void);
	void UPdate_Re_Rcvlog(void);
	long Rcv_Data(void);
	long TR21341(void);
	long RCV21342(void);
	long TR21342(void);
	long Re_Rcv_Data(void);
	long TR21343(void);
	long RCV21344(void);
	long TR21344(void);
	
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
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�� �� �� ��"),
		
		DLG_BUTTON(STARTX+250, STARTY+770, 500, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECV, "�� �� �� ��"),
		
		DLG_TEXT(STARTX,  STARTY+65, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKDT, "�۾�����"),
		DLG_TEXT(STARTX, STARTY+135, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CHARGEDT, "û�����"),
		DLG_TEXT(STARTX, STARTY+205, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_PERIODPAY, "����"),
		DLG_TEXT(STARTX, STARTY+275, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GMSTANDT, "��ħ������"),
		DLG_TEXT(STARTX, STARTY+345, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CUSTOMCNTR, "������"),
		DLG_TEXT(STARTX, STARTY+415, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_AREAMNGNUM, "����������ȣ"),
		DLG_TEXT(STARTX, STARTY+485, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GMMETHOD, "��ħ���"),
		DLG_TEXT(STARTX, STARTY+590, 1000, 150, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, RED, BRIGHTGRAY, TXT_NOTIFY, "û�����, ����, ��, ����������ȣ, \n ��ħ��� ���� �����ϼ���."),
		
		DLG_TEXT(STARTX+400,  STARTY+65, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, EDT_WORKDT,  ""),
		DLG_TEXT(STARTX+400, STARTY+345, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, EDT_CUSTOMCNTR,   ""),
		DLG_EDIT(STARTX+400, STARTY+415, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_AREAMNGNUM, 5,  ""),
		
		DLG_COMBO (STARTX+400, STARTY+135, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_CHARGEDT, 10),		//û����� �޺��ڽ�
		DLG_COMBO (STARTX+400, STARTY+205, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_PERIODPAY, 10),		//���� �޺��ڽ�
		DLG_COMBO (STARTX+400, STARTY+275, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GMSTANDT, 10),		//��ħ������ �޺��ڽ�
		DLG_COMBO (STARTX+400, STARTY+485, 600, 290, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GMMETHOD, 10),		//��ħ��� �޺��ڽ�
	};	
	
	//----------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
		return TRUE;
	}
	
//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void OnInit(char bFirst)
	{
		switch (bFirst)
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
						
				SetBtnImg();
				SetStyle();
				REDRAW();
				
				break;
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

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

	//-----------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_WORKDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHARGEDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PERIODPAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GMSTANDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUSTOMCNTR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AREAMNGNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GMMETHOD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NOTIFY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_WORKDT), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CUSTOMCNTR), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_AREAMNGNUM), EDITALIGN_MIDDLE);
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CHARGEDT), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_PERIODPAY), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GMSTANDT), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GMMETHOD), EDITALIGN_MIDDLE);
	
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_NOTIFY), TRUE, 2, EDITSEP_NONE );		//�Ű���
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PERIODPAY+2), "10����", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PERIODPAY+2), "20����", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PERIODPAY+2), "26����", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PERIODPAY+2), "30����", 0, ICON_NONE);
		
		// PRINT("stUserinfo.szcenter_cd : %s",stUserinfo.szcenter_cd,0,0);
		if( Str_Cmp(stUserinfo.szcenter_cd, "34" ) == 0 || Str_Cmp(stUserinfo.szcenter_cd, "35" ) == 0 )				
		{
			
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "����", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "���", 0, ICON_NONE);
		}
		else
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "����", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "���", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "��������", 0, ICON_NONE);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMMETHOD+2), "���+��������", 0, ICON_NONE);
		}
	}

//-------------------------------------------------------------------------
	void OnPointing( long nAction, long X, long Y )
	{
		long lActiveIndex = -1;
		long lret;

		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		m_lActiveIndex = lActiveIndex;

		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+415) && Y < DMS_Y(STARTY+485) )
				{
					if( Get_iDlgCtrlByID(EDT_AREAMNGNUM) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);
		
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

//------------------------------------------------------------------
	void OnButton( long ID )
	{	
		switch(ID)
		{					
			case BID_RECV:
				if( Str_Cmp( "����", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD) ) ) == 0 )
				{
					Rcv_Data();
				}
				else
				{
					Re_Rcv_Data();
				}
				
				break;
				
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
				
			case GID_MENU:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
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
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				Card_Move("GM_DMMENU");
				break;
					
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}		
	
	void REDRAW(void)
	{
		char sztmp[20];
		char szDp[20];
		long i;
		long chkmm;
		long date;
	
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szDp, 0x00, sizeof(szDp) );
		Str_ItoA( Time_GetDate(), sztmp, 10);
		//Str_ItoA( 20160310, sztmp, 10);
		g_Str_DateType(szDp, sztmp);
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_WORKDT), szDp);
		
		chkmm = Time_GetDate()- Time_GetDay()+15;
		
		for(i = 0 ; i < 3 ; i++)
		{
			date = Time_DateUpDown ( chkmm, 30-(i*30) ); 
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szDp, 0x00, sizeof(szDp) );
			
			Str_ItoA( date, sztmp, 10);
			Mem_Cpy( (byte*)szDp, (byte*)sztmp, 6);
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CHARGEDT+2), szDp, 0, ICON_NONE);
			if( i == 0)
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CHARGEDT), szDp);
		}
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CUSTOMCNTR), stUserinfo.szcenter_nm);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GMMETHOD), "����");
		Str_Cpy( m_szPERIODPAY, "10����" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_PERIODPAY), "10����");
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GMSTANDT), "��ü");
		
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "��ü", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "16", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "17", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "18", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "19", 0, ICON_NONE);
		ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "20", 0, ICON_NONE);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GMMETHOD), "����");

	}
	
	void	OnSelect(long Index)
	{
	char szcmb[20];
	
		Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
		Str_Cpy( szcmb , EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY) ) );
		//�޺��ڽ� �������� ����Ʈ ��� ���͸�.(��ħ,�̰�ħ,��ü���)
		if( Str_Cmp(m_szPERIODPAY, szcmb ) != 0 )
		{
			Str_Cpy(m_szPERIODPAY, szcmb);
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_GMSTANDT+2)) ;


			if( Str_Cmp(m_szPERIODPAY, "10����" ) == 0 )
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "��ü", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "16", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "17", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "18", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "19", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "20", 0, ICON_NONE);
			}
			else if( Str_Cmp(m_szPERIODPAY, "20����" ) == 0 )
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "��ü", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "26", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "27", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "28", 0, ICON_NONE);
				
			}
			else if( Str_Cmp(m_szPERIODPAY, "26����" ) == 0 )
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "��ü", 0, ICON_NONE);
			}
			else if( Str_Cmp(m_szPERIODPAY, "30����" ) == 0 )
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "��ü", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "06", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "07", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "08", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "09", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMSTANDT+2), "10", 0, ICON_NONE);
			}
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_GMSTANDT), "��ü");
			ON_DRAW();
			

			
		}
	}
	
	long Rcv_Data(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long totcnt;
		long lCnt = 0;
		
		/*******************/
		/* Validation      */
		/*******************/	
		g_Sql_RetInt(" SELECT COUNT(1) FROM GUMDATA", &lCnt);
	
		if( lCnt > 0 )
		{
			MessageBoxEx(CONFIRM_OK, "[�����ħ]�ڷᰡ �ֽ��ϴ�.\n�ڷ���� �� ���� �ϼ���.");
			return -1;
		}
		
		g_Sql_RetInt("SELECT COUNT(1) GUMDATA WHERE SEND_YN = 'S'", &totcnt);
	
		if( totcnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "[�����ħ]�̼۽� �ڷᰡ �ֽ��ϴ�.\n�۽� �� ���� ��������.");
			return -1;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "���������� �Է��ϼ���.");
			return -1;
		}
		
		/*******************/
		/* Start           */
		/*******************/	
		if( MessageBoxEx( CONFIRM_YESNO, "[�����ħ]��ħ�ڷḦ\n���� �����ðڽ��ϱ�?" ) == MB_OK )
		{	
			g_Sql_DirectExecute("DELETE FROM GUMGROUP");
			g_Sql_DirectExecute("DELETE FROM GUMDATA");		
		}
		else
		{
			return -1;
		}
		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead( g_pjcomm, szUrl, 21432, FALSE );
		
		// 1. req_ym
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT) ) );
		JSON_SetValue( g_pjcomm, 'C', "req_ym", sztmp );
		
		// 2. deadline_flag
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_NCpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY) ), 2 );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag", sztmp );
		
		// 3. gmtr_base_day
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		if( Str_Cmp( "��ü", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ) ) == 0)
		{	
			Str_Cpy( sztmp, "%" );
		}
		else
		{
			Str_NCpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ), 2 );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "gmtr_base_day", sztmp );
		
		// 4. branch_cd
		JSON_SetValue( g_pjcomm, 'C', "branch_cd", stUserinfo.szbranch_cd);
		
		// 5. center_cd
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
		
		// 6. zone_manage_num
		Set_zone_manage_num( sztmp, Str_AtoI( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) ) );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  sztmp);
		
		// 7. gmtr_meth
		JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "10");
		
		// 8. gmtr_nm
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SQL_ConvUcStr( sznm_kor, stUserinfo.sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_nm", sznm_kor );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );	
		GET_FILENM( sztmp, SQLITE_DB );
		
		callBackfunc = TR21341;
		ret = HTTP_DownloadData( szUrl, "FR21341_IN",  "FR21341" , sndbuf, sztmp );
	
		return 0 ;
	}
	
	long TR21341(void)
	{
		if(g_Chk_Json(21341) >= 0)
		{
			//��ħ������ �����Ѵ�.
			RCV21342();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	long RCV21342(void)
	{
	char sztmp[32];
	char szUrl[256];
	char sznm_kor[64];
	char* sndbuf;
	long ret;
		
		PROGRESS_DUMP("");
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 21432, FALSE);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT)) );
		JSON_SetValue( g_pjcomm, 'C', "req_ym",    sztmp);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_NCpy (sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY)), 2 );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",    sztmp);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		
		if(Str_Cmp("��ü", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT)) ) == 0)
		{	
			Str_Cpy (sztmp, "%" );
		}
		else
		{
			Str_NCpy (sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT)), 2 );
		}
		JSON_SetValue( g_pjcomm, 'C', "gmtr_base_day",  sztmp );
		JSON_SetValue( g_pjcomm, 'C', "branch_cd",  stUserinfo.szbranch_cd);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );

		Set_zone_manage_num(sztmp, Str_AtoI(EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM)) )  );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    sztmp);
		
		if( Str_Cmp("����", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD)) ) == 0 )
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "10");
		else
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "20");
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SQL_ConvUcStr( sznm_kor, stUserinfo.sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_nm",          sznm_kor );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR21342;
		ret = HTTP_DownloadData(szUrl, "FR21342_IN",  "FR21342" , sndbuf, sztmp );
		
		return 0;
	}
	
	long TR21342(void)
	{
	long totcnt = 0;
	char szmag[128];
		g_Sock_Close();
		
		if(g_Chk_Json(21342) >= 0)
		{
			RCV21344();			
			return 1;
			
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	long Re_Rcv_Data(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long totcnt;
		long lCnt = 0;
		
		/*******************/
		/* Validation      */
		/*******************/	
		g_Sql_RetInt(" SELECT COUNT(1) FROM REGUMDATA", &lCnt);
	
		if( lCnt > 0 )
		{
			MessageBoxEx(CONFIRM_OK, "[��� �� ��������]�ڷᰡ �ֽ��ϴ�.\n�ڷ���� �� ���� �ϼ���.");
			return -1;
		}
		
		g_Sql_RetInt("SELECT COUNT(1) REGUMDATA WHERE SEND_YN = 'S'", &totcnt);
	
		if( totcnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "[��� �� ��������]�̼۽� �ڷᰡ �ֽ��ϴ�.\n�۽� �� ���� ��������.");
			return -1;
		}
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "���������� �Է��ϼ���.");
			return -1;
		}
		
		/*******************/
		/* Start           */
		/*******************/	
		if( MessageBoxEx( CONFIRM_YESNO, "[��� �� ��������]�ڷḦ\n���� �����ðڽ��ϱ�?" ) == MB_OK )
		{	
			g_Sql_DirectExecute("DELETE FROM REGUMDATA");		
		}
		else
		{
			return -1;
		}
		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead( g_pjcomm, szUrl, 21343, FALSE );
		
		// 1. req_ym
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT) ) );
		JSON_SetValue( g_pjcomm, 'C', "req_ym", sztmp );
		
		// 2. deadline_flag
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_NCpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY) ), 2 );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag", sztmp );
		
		// 3. gmtr_base_day
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		if( Str_Cmp( "��ü", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ) ) == 0)
		{	
			Str_Cpy( sztmp, "%" );
		}
		else
		{
			Str_NCpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ), 2 );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "gmtr_base_day", sztmp );
		
		// 4. branch_cd
		JSON_SetValue( g_pjcomm, 'C', "branch_cd", stUserinfo.szbranch_cd);
		
		// 5. center_cd
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
		
		// 6. zone_manage_num
		Set_zone_manage_num( sztmp, Str_AtoI( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) ) );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",  sztmp);
		
		// 7. gmtr_meth
		if( Str_Cmp("���", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD) ) ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "20");
		}
		else if( Str_Cmp("��������", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD) ) ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "21");
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "gmtr_meth",    "22");
		}
		
		// 8. gmtr_nm
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SQL_ConvUcStr( sznm_kor, stUserinfo.sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "gmtr_nm", sznm_kor );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );	
		GET_FILENM( sztmp, SQLITE_DB );
		
		callBackfunc = TR21343;
		ret = HTTP_DownloadData( szUrl, "FR21343_IN",  "FR21343" , sndbuf, sztmp );
	
		return 0 ;
	}
	
	
	long TR21343(void)
	{
		long totcnt = 0;
		char szmag[128];
		
		g_Sock_Close();
		
		if( g_Chk_Json(21343) >= 0 )
		{
			UPdate_Re_Rcvlog();
			g_Sql_RetInt("SELECT COUNT(1) FROM REGUMDATA ", &totcnt);
			
			Mem_Set((byte*)szmag ,0x00, sizeof(szmag) );
			SPRINT(szmag, "[��� �� ��������]�ڷ�\n%d�� ���� �޾ҽ��ϴ�.", totcnt, 0, 0);
			
			if( totcnt > 0 )
			{
				//��ħ ��� ���� �� => ���ڰ�ħ ��� L �ڵ� �Է� �� SEND_YN ������Ʈ
				g_Sql_DirectExecute("UPDATE REGUMDATA SET MTR_WORK_CODE ='L', SEND_YN = 'S' WHERE SMS_GMTR_MAN_YN = 'Y' AND BEFO_GMTR_SMS_YN IS NULL ");
			
				MessageBoxEx( CONFIRM_OK, szmag );
				ON_DRAW();
				
				OnButton(GID_PREV);
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "���ŵ� �� ��ħ����� �����ϴ�.");
				ON_DRAW();
				return 1;	
			}
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

	long RCV21344(void)
	{
		char sztmp[32];
		char szUrl[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		char szCnt[100];
		char szTown[20];
		char szAddr1_m[20];
		char szNew_road_nm[20];
		char szNew_addr_m[20];
		
		PROGRESS_DUMP("");
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 21344, FALSE);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy( sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT)) );
		JSON_SetValue( g_pjcomm, 'C', "req_ym",    sztmp);

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "SELECT SUM(CNT) FROM GUMGROUP",0,0, 0);
		g_Sql_RetStr(sztmp, 10, szCnt);
		JSON_SetValue( g_pjcomm, 'C', "cnt", szCnt );		

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT TOWN FROM GUMGROUP",0,0, 0);	
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szTown, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "town", szTown );

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT ADDR1_M FROM GUMGROUP",0,0, 0);		
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szAddr1_m, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "addr1_m",  szAddr1_m );

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT NEW_ROAD_NM FROM GUMGROUP",0,0, 0);		
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szNew_road_nm, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "new_road_nm",  szNew_road_nm );
		
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set( (byte*) sznm_kor, 0x00, sizeof( sznm_kor) );
		SPRINT(sztmp, "SELECT NEW_ADDR_M FROM GUMGROUP",0,0, 0);	
		g_Sql_RetStr(sztmp, 10, sznm_kor);
		SQL_ConvUcStr( szNew_addr_m, sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_m",  szNew_addr_m );	
		
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_NCpy (sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY)), 2 );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",    sztmp);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );

		JSON_SetValue( g_pjcomm, 'C', "crt_empid",  stUserinfo.szemployee_id);

		JSON_SetValue( g_pjcomm, 'C', "crt_ip",  stUserinfo.szpda_ip);

		Set_zone_manage_num(sztmp, Str_AtoI(EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM)) )  );
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num",    sztmp);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR21344;
		ret = HTTP_DownloadData(szUrl, "FR21344_IN",  "FR21344" , sndbuf, sztmp );
		
		return 0;
	}

	long TR21344(void)
	{
	long totcnt = 0;
	char szmag[128];
		g_Sock_Close();
		
		if(g_Chk_Json(21342) >= 0)
		{
			UPdate_Rcvlog();
			g_Sql_RetInt(" select count(*) from GUMDATA ", &totcnt);
			Mem_Set((byte*)szmag ,0x00, sizeof(szmag) );
			SPRINT(szmag, " ��ħ %d�� ���� �޾ҽ��ϴ�. ", totcnt, 0, 0);
			
			if(totcnt > 0 )
			{
				//��ħ ��� ���� �� => ���ڰ�ħ ��� L �ڵ� �Է� �� SEND_YN ������Ʈ
				g_Sql_DirectExecute("UPDATE GUMDATA SET MTR_WORK_CODE ='L', SEND_YN = 'S' WHERE SMS_GMTR_MAN_YN = 'Y' AND BEFO_GMTR_SMS_YN IS NULL ");
			
				MessageBoxEx (CONFIRM_OK, szmag);
				ON_DRAW();

				// RCV21344();

				//���ŵ� �ڷ� ������ ����
				OnButton(GID_PREV);
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "���ŵ� ��ħ����� �����ϴ�.");
				ON_DRAW();
				return 1;	
			}
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}


	
	/*=======================================================================================
	�Լ��� : Set_zone_manage_num
	��  �� : ���� ������ ��ȯ�Ѵ�.
	Param  : temp: ��� ���ڿ� ������
			 time: ���� long��
	Return : TRUE : ����
			 FALSE : ����
	========================================================================================*/
	void Set_zone_manage_num(char *temp, long num )
	{
	char buffer[10];
	char buffer1[10];
	long i;
	
		Str_ItoA(num, buffer1, 10);
		Mem_Set((byte*)buffer,'0', sizeof(buffer));
		
		i = Str_Len(buffer1);
		Mem_Cpy((byte*)temp, (byte*)buffer, 5-i);
		Mem_Cpy((byte*)temp+5-i, (byte*)buffer1, i);
		temp[5] = 0;
		
	}
	
	
	void UPdate_Rcvlog(void)
	{
	long i=0, tot = 0, ret=0;
	char szSql[400];
	long idx;
	char szPARAM1  [20+1];
	char szPARAM2  [20+1];
	char szPARAM3  [20+1];
	char szPARAM4  [20+1];
	char szPARAM5  [20+1];
	char szPARAM6  [20+1];
	char szPARAM7  [20+1];
	char* szPARAM9;
	char* szPARAM10;
	long nPARAM9;
	long nPARAM10;
	char sztmp[10];
	char szJsonpath[100];
	char szType[2];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		
		Mem_Set((byte*)szPARAM1, 0x00, sizeof(szPARAM1));
		Mem_Set((byte*)szPARAM2, 0x00, sizeof(szPARAM2));
		Mem_Set((byte*)szPARAM3, 0x00, sizeof(szPARAM3));
		Mem_Set((byte*)szPARAM4, 0x00, sizeof(szPARAM4));
		Mem_Set((byte*)szPARAM5, 0x00, sizeof(szPARAM5));
		Mem_Set((byte*)szPARAM6, 0x00, sizeof(szPARAM6));
		Mem_Set((byte*)szPARAM7, 0x00, sizeof(szPARAM7));
		Mem_Set((byte*)szType, 0x00, sizeof(szType));

		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 21341, 0 );
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
	
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szPARAM9 = JSON_GetValue (g_pjcomm, "gmtr_apply_rt", szType);
			nPARAM9 = Str_AtoI(szPARAM9);
			
			szPARAM10 = JSON_GetValue (g_pjcomm, "gmtr_apply_rt2", szType);
			nPARAM10 = Str_AtoI(szPARAM10);
		}
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		Str_Cpy( szPARAM1, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT)) );      //req_ym
		Str_NCpy(szPARAM2, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY)), 2 );  //deadline_flag
		if(Str_Cmp("��ü", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT)) ) == 0)
		{
			
			Str_Cpy (szPARAM3, "%" );
		}
		else
		{
			Str_NCpy (szPARAM3, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT)), 2 ); //gmtr_base_day
		}
		
		Str_Cpy( szPARAM4, stUserinfo.szbranch_cd); //branch_cd
		Str_Cpy( szPARAM5, stUserinfo.szcenter_cd );//center_cd
		
		Set_zone_manage_num(szPARAM6, Str_AtoI(EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM)) )  ); // zone_manage_num

		if(  Str_Cmp("����", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD)) ) == 0  ) // gmtr_meth
		{
			Str_Cpy( szPARAM7,    "10");
		}
		else
		{
			Str_Cpy( szPARAM7,    "20");
		}
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0)
		{
			hstmt = sql->CreateStatement(sql ,"INSERT INTO RCV_LOG ( GUBUN,PARAM1,PARAM2,PARAM3,PARAM4,PARAM5,PARAM6,PARAM7,PARAM8,PARAM9,PARAM10) VALUES ('1',?,?,?,? ,?,?,?, 0, ?,? ) ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql ,"UPDATE RCV_LOG SET PARAM1 =?,PARAM2=?,PARAM3=?,PARAM4=?,PARAM5=?,PARAM6=?,PARAM7=?,PARAM8=0,PARAM9=?,PARAM10=?  WHERE GUBUN = '1' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)szPARAM1, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM2, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM3, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM4, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM5, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM6, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM7, 20, DECRYPT);
		sql->Bind(sql, idx++, 'X', (long *)&nPARAM9,  4, DECRYPT);
		sql->Bind(sql, idx++, 'X', (long *)&nPARAM10, 4, DECRYPT);
		
		//sql->Begin(sql);
		ret = sql->Execute(sql);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;		
	}
	
	void UPdate_Re_Rcvlog(void)
	{
		long i = 0;
		long tot = 0;
		long ret = 0;
		long idx;
		
		char sztmp[10];
		char szJsonpath[100];
		char szType[2];
		
		char szSql[400];
		char szPARAM1[20+1];
		char szPARAM2[20+1];
		char szPARAM3[20+1];
		char szPARAM4[20+1];
		char szPARAM5[20+1];
		char szPARAM6[20+1];
		char szPARAM7[20+1];
		char* szPARAM9;
		char* szPARAM10;
		long nPARAM9;
		long nPARAM10;
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szPARAM1, 0x00, sizeof(szPARAM1));
		Mem_Set((byte*)szPARAM2, 0x00, sizeof(szPARAM2));
		Mem_Set((byte*)szPARAM3, 0x00, sizeof(szPARAM3));
		Mem_Set((byte*)szPARAM4, 0x00, sizeof(szPARAM4));
		Mem_Set((byte*)szPARAM5, 0x00, sizeof(szPARAM5));
		Mem_Set((byte*)szPARAM6, 0x00, sizeof(szPARAM6));
		Mem_Set((byte*)szPARAM7, 0x00, sizeof(szPARAM7));
		Mem_Set((byte*)szType, 0x00, sizeof(szType));

		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		
		SPRINT( szJsonpath, "%sFR%d.JSON", SYSTEM_COMM, 21343, 0 );
		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		
		if( g_pjcomm == NULL )
		{
			return;
		}
	
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szPARAM9 = JSON_GetValue( g_pjcomm, "gmtr_apply_rt", szType );
			nPARAM9 = Str_AtoI( szPARAM9 );
			
			szPARAM10 = JSON_GetValue( g_pjcomm, "gmtr_apply_rt2", szType );
			nPARAM10 = Str_AtoI( szPARAM10 );
		}
		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		Str_Cpy( szPARAM1, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_CHARGEDT) ) ); // req_ym
		Str_NCpy( szPARAM2, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PERIODPAY) ), 2 ); // deadline_flag
		
		if( Str_Cmp( "��ü", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ) ) == 0 )
		{
			Str_Cpy( szPARAM3, "%" );
		}
		else
		{
			Str_NCpy( szPARAM3, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMSTANDT) ), 2 ); // gmtr_base_day
		}
		
		Str_Cpy( szPARAM4, stUserinfo.szbranch_cd ); // branch_cd
		Str_Cpy( szPARAM5, stUserinfo.szcenter_cd ); // center_cd
		
		Set_zone_manage_num( szPARAM6, Str_AtoI( EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_AREAMNGNUM) ) ) ); // zone_manage_num

		if( Str_Cmp( "���", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD)) ) == 0  ) // gmtr_meth
		{
			Str_Cpy( szPARAM7, "20" );
		}
		else if( Str_Cmp( "��������", EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GMMETHOD)) ) == 0  )
		{
			Str_Cpy( szPARAM7, "21" );
		}
		else
		{
			Str_Cpy( szPARAM7, "22" );
		}
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '10'", 0, 0, 0 );
		g_Sql_RetInt(szSql, &tot);
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( tot <= 0 )
		{
			hstmt = sql->CreateStatement(sql, "INSERT INTO RCV_LOG ( GUBUN, PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, PARAM6, PARAM7, PARAM8, PARAM9, PARAM10 ) VALUES ( '10', ?, ?, ?, ?, ?, ?, ?, 0, ?, ? )");
		}
		else
		{
			hstmt = sql->CreateStatement(sql, "UPDATE RCV_LOG SET PARAM1 = ?, PARAM2 = ?, PARAM3 = ?, PARAM4 = ?, PARAM5 = ?, PARAM6 = ?, PARAM7 = ?, PARAM8 = 0, PARAM9 = ?, PARAM10 = ? WHERE GUBUN = '10' ");
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'C', (long *)szPARAM1, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM2, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM3, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM4, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM5, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM6, 20, DECRYPT);
		sql->Bind(sql, idx++, 'C', (long *)szPARAM7, 20, DECRYPT);
		sql->Bind(sql, idx++, 'X', (long *)&nPARAM9,  4, DECRYPT);
		sql->Bind(sql, idx++, 'X', (long *)&nPARAM10, 4, DECRYPT);
		
		ret = sql->Execute(sql);
		
		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
	Finally:
		DelSqLite(sql);
		return;		
	}
}


