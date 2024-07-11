/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_PART
{
	#include <include.h>
	#include "globalcard.h"
	#include "Calendar.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
//	#define USE_ON_UART

	#include "DefEvent.h"
	
//BUTTON ID define
	BEGIN_BUTTON_ID()
//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
//�˻�
		DEF_BUTTON_ID ( BID_SEARCH1 )		//������ȸ
		DEF_BUTTON_ID ( BID_SEARCH2 )		//�ּ���ȸ
		DEF_BUTTON_ID ( BID_ADDRRCV )		//����������ȸ
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )

		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA4 )
				
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
//�˻�
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 )
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 )
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 )
		
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	long m_lBtnId = -1;
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_lActIndex = -1;		//��Ƽ��� index
	char m_szCnt_page[10];		// ������ ǥ�� ����
	char m_szSql[2][1200];
	char m_szCobSel[20];		//
	char m_bFirst;
	char m_szSingle_Flag[10];
	char m_szMtrNum[11];
	char m_szMtrIDNum[11];
	char m_szArea[50];
	char m_szTown[50];
	char m_szBldNm[100];
	
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void SetCombo(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void SetSearch(void);
	void SaveInput(void);
	void SetBtnImg(void);
	long SearchCD(char *CD, CodeTable *CT);		//�ڵ� ���� ã�´�.
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	
	long Rcv_Addr(void);
	void Rcv_Search(long BtnId);
	long TR81601(void);
	long TR81604(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����Ȱ��"),

		DLG_BUTTON(STARTX+600,  STARTY+230, 400, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "�� ȸ"),
		DLG_BUTTON(STARTX,		STARTY+340, 385, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDRRCV, "�ּ��ڷ����"),
		DLG_BUTTON(STARTX+600,	STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "�� ȸ"),

		//üũ�ڽ� �ؽ�Ʈ		
		DLG_TEXT(STARTX,  	  STARTY+65, 385, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�˻�����"),
		DLG_TEXT(STARTX+385,  STARTY+65, 615, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�˻�����"),
		DLG_EDIT(STARTX+385, STARTY+140, 615, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 30,  ""),
		
		DLG_TEXT(STARTX,  	 STARTY+410, 385, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "��/��/��"),
		DLG_TEXT(STARTX,  	 STARTY+480, 385, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "��/��/��"),
		DLG_TEXT(STARTX,  	 STARTY+550, 385, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "����"),
		DLG_EDIT(STARTX+385, STARTY+550, 285, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 10,  ""),
		DLG_TEXT(STARTX+670, STARTY+550,  30, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "-"),
		DLG_EDIT(STARTX+700, STARTY+550, 300, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 10,  ""),
		DLG_TEXT(STARTX,  	 STARTY+620, 385, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "�������ø�"),
		DLG_TEXT(STARTX,  	 STARTY+690, 385, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "�ǹ���"),
		DLG_EDIT(STARTX+385, STARTY+690, 615, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 40,  ""),
		
		DLG_COMBO (STARTX,	   STARTY+140, 385, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+385, STARTY+410, 615, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		DLG_COMBO (STARTX+385, STARTY+480, 615, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		DLG_COMBO (STARTX+385, STARTY+620, 615, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 10),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "����Ȱ��"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
			
		DLG_BUTTON(STARTX+600,  STARTY+130, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "�� ȸ"),
		DLG_BUTTON(STARTX,		STARTY+230, 385, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDRRCV, "����������ȸ"),
		DLG_BUTTON(STARTX+600,	STARTY+765, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "�� ȸ"),

		//üũ�ڽ� �ؽ�Ʈ		
		DLG_TEXT(STARTX,  	  STARTY-40, 385, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�˻�����"),
		DLG_TEXT(STARTX+385,  STARTY-40, 615, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�˻�����"),
		DLG_EDIT(STARTX+385,  STARTY+30, 615, 90, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 30,  ""),
		
		DLG_TEXT(STARTX,  	 STARTY+320, 385, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "��/��/��"),
		DLG_TEXT(STARTX,  	 STARTY+400, 385, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "��/��/��"),
		DLG_TEXT(STARTX,  	 STARTY+480, 385, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "����"),
		DLG_EDIT(STARTX+385, STARTY+480, 285, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 10,  ""),
		DLG_TEXT(STARTX+670, STARTY+480,  30, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "-"),
		DLG_EDIT(STARTX+700, STARTY+480, 300, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 10,  ""),
		DLG_TEXT(STARTX,  	 STARTY+560, 385, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "�������ø�"),
		DLG_TEXT(STARTX,  	 STARTY+640, 385, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "�ǹ���"),
		DLG_EDIT(STARTX+385, STARTY+640, 615, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 50,  ""),
		
		DLG_COMBO (STARTX,	    STARTY+30, 385, 200, 150, 90, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+385, STARTY+320, 615, 200, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		DLG_COMBO (STARTX+385, STARTY+400, 615, 200, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		DLG_COMBO (STARTX+385, STARTY+560, 615, 200, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 10),
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;
				}

				SetBtnImg();
				SetCombo();
				SetStyle();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		
		if( theDevInfo.m_nType > FAMILY_PDA )
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

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		//���ڸ� �Է� ����
		if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex ||
		    Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
		{
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
				return;
			}
		}
	}

	
//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( m_bFirst == INIT_MAIN )
				{
					m_lActiveIndex = lActiveIndex;
				
					if( X > DMS_X(STARTX+385) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+140) && Y < DMS_Y(STARTY+210) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
		
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
				    else if( X > DMS_X(STARTX+385) && X < DMS_X(STARTX+670) && Y > DMS_Y(STARTY+550-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+620-(g_Dlgflag*400)) ||
				             X > DMS_X(STARTX+700) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+550-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+620-(g_Dlgflag*400)) ||
				    	     X > DMS_X(STARTX+385) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+690-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+760-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
						
							ShowSip(FALSE);
							g_Sipflag = 0;

							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						g_Dlgflag = 1;
						g_MOVE_DLG(1);
					
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
				}
				
				ON_DRAW();
			}
		}
		
		return;
	}


//-----------------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long index = -1;
		char szSql[256];
		char szArea[50];
		char szTown[50];
		char szBldNm[100];


		Mem_Set( (byte*)szArea, 0x00, sizeof(szArea) );
		Str_Cpy(szArea, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2 ))   );	
		Str_Cpy(szTown, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3 ))   );	
		if( Str_Cmp(m_szArea,  szArea ) != 0 )
		{
			//��,��,��
			Str_Cpy(m_szArea, szArea);
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DATA3+2 ) );
			SPRINT(szSql, "SELECT TOWN FROM RCV_ADDR WHERE AREA = '%s' GROUP BY TOWN ", m_szArea, 0, 0   );
			g_Sql_SetCombo(szSql, CMB_DATA3+2);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), "");
		}
		else if( Str_Cmp(m_szTown,  szTown ) != 0 )
		{
			//�������ø�
			Str_Cpy(m_szTown, szTown);
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DATA4+2 ) );
			SPRINT(szSql, "SELECT COMPX_FLAG_NM FROM RCV_ADDR WHERE AREA = '%s' AND TOWN = '%s' GROUP BY COMPX_FLAG_NM", m_szArea, m_szTown, 0 );
			g_Sql_SetCombo(szSql, CMB_DATA4+2);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), "");
		}
	}
	
//-----------------------------------------------------------------------------------------------
	void SetCombo(void)
	{
		long i;
	
		//�˻�����
		for ( i = 0 ;  NP_PARTSRCH[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), NP_PARTSRCH[i].Str, 0, ICON_NONE);
		}

		//g_Sql_SetCombo("SELECT AREA FROM C6301_CHANGEDATA GROUP BY AREA ORDER BY AREA", CMB_DATA1+2);

		return;
	}
	
//---------------------------------------------------------------------------------------
	void	OnButton(long ID)
	{
	long d, k;
	char szToday[11];
	char szDate[11];
	
		switch(ID)
		{
			case BID_SEARCH1:
			case BID_SEARCH2:
				Rcv_Search(ID);
				break;
			case BID_ADDRRCV:
				//MessageBoxEx (CONFIRM_OK, "���� �������Դϴ�.");
				//���� ���� �� ����
				Rcv_Addr();
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
				
				if( MessageBoxEx (CONFIRM_YESNO, "ü�� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("C202_MENU");
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
				Card_Move("C6202_MENU");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;

				g_Exit();
				break;
		}
	}

//-----------------------------------------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
		
		
		return;
	}	
	/*=======================================================================================
	�Լ��� : SearchStr
	��  �� : ��Ʈ������ �ڵ��ε����� ã�´�.
	Param  : 
	Return : �ڵ��ε���, ������ -1
	========================================================================================*/
	long	SearchStr( char *Str, CodeTable *CT)
	{
		long i;

		for ( i = 0 ; CT[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
				return i;
		}
		
		return -1;
	}
	
	/*=======================================================================================
	�Լ��� : SearchCD
	��  �� : �ڵ尪���� �ڵ��ε����� ã�´�.
	Param  : 
	Return : �ڵ��ε���, ������ -1
	========================================================================================*/
	long	SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
			{
				return i;
			}
		}
		return -1;
	}


	/*=======================================================================================
	�Լ��� : Set_Index
	��  �� : ���� �ε��� �����Ѵ�.
	Param  : 
	Return : TRUE :����
			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[201];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '9' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}

//------------------------------------------------------------------------------------------
	long Rcv_Addr(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_ADDR");
		
		//PROGRESS_DUMP("");

		g_SeverConnection();

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 81601, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR81601; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR81601_IN",  "FR81601" , sndbuf, sztmp );
		return 0 ;
	}
	
//---------------------------------------------------------------------------------------------
	long TR81601(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(81601) >= 0)
		{
			g_Sql_RetInt("SELECT COUNT(*) FROM RCV_ADDR", &ntotcnt);
			
			if(ntotcnt > 0 )
			{
				g_Sql_SetCombo("SELECT AREA FROM RCV_ADDR GROUP BY AREA", CMB_DATA2+2);
				g_Sql_SetCombo("SELECT TOWN FROM RCV_ADDR GROUP BY TOWN", CMB_DATA3+2);
				g_Sql_SetCombo("SELECT COMPX_FLAG_NM FROM RCV_ADDR GROUP BY COMPX_FLAG_NM", CMB_DATA4+2);
				
				MessageBoxEx (CONFIRM_OK, "��,��,���� ���ſϷ�.");
				ON_DRAW();
				return 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��ȸ ����");
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


//-------------------------------------------------------------------------------
	void Rcv_Search(long BtnId)
	{
		long nRet, i;
		long lCnt;
		char szGubun[5];
		char szNonPayManageZone[10];
		char szCmb[20];
		char szArea[100];
		char szTown[100];
		char szAddr1_m[31];
		char szAddr1_s[31];
		char szCoLiveNm[100];
		char szBldNm[61];
		char szCondition[32];
		char szSql[256];
		char szUrl[256];
		char szPath[256];
		char* sndbuf;

		Mem_Set( (byte*)szGubun, 0x00, sizeof(szGubun) );
		Mem_Set( (byte*)szCondition, 0x00, sizeof(szCondition) );
		Mem_Set( (byte*)szCmb, 0x00, sizeof(szCmb) );
		Mem_Set((byte*)szArea, 0x00, sizeof(szArea));	
		Mem_Set((byte*)szTown, 0x00, sizeof(szTown));	
		Mem_Set((byte*)szAddr1_m, 0x00, sizeof(szAddr1_m));	
		Mem_Set((byte*)szAddr1_s, 0x00, sizeof(szAddr1_s));	
		Mem_Set((byte*)szCoLiveNm, 0x00, sizeof(szCoLiveNm));	
		Mem_Set((byte*)szBldNm, 0x00, sizeof(szBldNm));

		if( BtnId == BID_SEARCH1 )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ȸ������ �־��ּ���.");
				return ;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA1)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ȸ������ �����ϼ���.");
				return ;
			}
			
			Str_Cpy(szCondition, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), NP_PARTSRCH );
			if (i == -1)
			{
				Str_Cpy(szCmb, "");
			}
			else
			{
				Str_Cpy(szCmb, NP_PARTSRCH[i].Code);
			}
			
			if( szCmb[0] == '1' )
			{
				Str_Cpy(szGubun, "4");
			}
			else if( szCmb[0] == '2' )
			{
				Str_Cpy(szGubun, "5");
			}
			else if( szCmb[0] == '3' )
			{
				Str_Cpy(szGubun, "6");
			}
			else if( szCmb[0] == '4' )
			{
				Str_Cpy(szGubun, "7");
			}
			else if( szCmb[0] == '5' )
			{
				Str_Cpy(szGubun, "8");
			}
			else if( szCmb[0] == '6' )
			{
				Str_Cpy(szGubun, "9");
			}
			else if( szCmb[0] == '7' )
			{
				Str_Cpy(szGubun, "10");
			}
		}
		else
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA2)) == 0 ||
				EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA3)) == 0 ||
				EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "�ּ��Է��� Ȯ���ϼ���.");
				return ;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA4)) > 0 )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4)) == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�ǹ����� �Է��ϼ���.");
					return ;
				}
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4)) > 0 )
			{
				Str_Cpy(szGubun, "3");
			}
			else
			{
				Str_Cpy(szGubun, "2");
			}
			
			SQL_ConvUcStr( szArea, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)) );
			SQL_ConvUcStr( szTown, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)) );
			SQL_ConvUcStr( szAddr1_m, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) );
			SQL_ConvUcStr( szAddr1_s, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
			SQL_ConvUcStr( szCoLiveNm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)) );
			SQL_ConvUcStr( szBldNm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) );
		}
		
		g_Sql_DirectExecute("DELETE FROM C6202_NOPAY_OBJ_PART");

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '9' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, szNonPayManageZone);

//----
		//PROGRESS_DUMP("");

		g_SeverConnection();

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 81604, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",  			szGubun );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  		stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone", szNonPayManageZone );
		JSON_SetValue( g_pjcomm, 'C', "condition",			szCondition );
		JSON_SetValue( g_pjcomm, 'C', "area",  				szArea );
		JSON_SetValue( g_pjcomm, 'C', "town",  				szTown );
		JSON_SetValue( g_pjcomm, 'C', "addr1_m",  			szAddr1_m );
		JSON_SetValue( g_pjcomm, 'C', "addr1_s",  			szAddr1_s );
		JSON_SetValue( g_pjcomm, 'C', "co_live_nm", 		szCoLiveNm );
		JSON_SetValue( g_pjcomm, 'C', "bld_nm",  			szBldNm );
		
		sndbuf = JSON_toString(g_pjcomm);

		//�Ѱ��ִ� item������ Ȯ��
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)szPath, 0x00, sizeof(szPath));	
		GET_FILENM(szPath, SQLITE_DB);
		
		callBackfunc = TR81604; //��ſϷ� �Ŀ� ȣ�� �Լ�
		nRet = HTTP_DownloadData(szUrl, "FR81604_IN",  "FR81604" , sndbuf, szPath );
		
		return ;
	}

//---------------------------------------------------------------------------------------------
	long TR81604(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		char szTmp[10];
		
		g_Sock_Close();
		CloseMessageBox();
		
		if(g_Chk_Json(81604) >= 0)
		{
			g_Sql_RetInt("SELECT COUNT(*) FROM C6202_NOPAY_OBJ_PART", &ntotcnt);

			if( ntotcnt > 0 )
			{
				//2017-12-07 Sanghyun Lee
				//����� 1�Ǹ� �˻��Ǵ� ���� ����
				g_nActIndex = 0;
				g_Sql_SaveSeq( "SELECT ROWID FROM C6202_NOPAY_OBJ_PART", SREACH_FILE);
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				g_lDataflag = 0;

				g_lNpMemoChkFlag = 0;
				Card_Move("C6202_NPACTIVE");
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "�ڷᰡ �����ϴ�.");
				ON_DRAW();
			}

			return 1;	
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
}





