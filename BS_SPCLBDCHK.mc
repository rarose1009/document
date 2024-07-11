/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
//Ư�� �ü� ����
card BS_SPCLBDCHK
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
	#define USE_ON_SELECT
	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
//Ư���ü�����
		DEF_BUTTON_ID ( BID_CHECK1 )
		DEF_BUTTON_ID ( BID_CHECK2 )
		DEF_BUTTON_ID ( BID_CHECK3 )
		DEF_BUTTON_ID ( BID_CHECK4 )
		DEF_BUTTON_ID ( BID_OK1 )
		DEF_BUTTON_ID ( BID_BACK )
		
	END_BUTTON_ID()
	
	// ī�峻���� ���� ��Ʈ�� ���̵� ����
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )
//Ư���ü�
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
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( CMB_DATA1 ) 
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 ) 

	END_OBJECT_ID()

	//�⺻���� DLGȭ�� ����
	#define INIT_MAIN		1
	
	long m_bFirst;
	
	void REDRAW(void);
	void SetStyle(void);
	void SetCombo(void);
	bool Save_Result(void);
	bool Validate(void);
	bool Save_Result_Back(void);
	
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	void SetBtnImg(void);
	
	//-----------------------------------------------------------------
	//	main entry map
	//-----------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	//  ���̾�α�:Ư���ü�����
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "Ư���ü� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BACK, ""),

		DLG_BUTTON(STARTX+825,	 STARTY-29, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "����"),
		DLG_BUTTON(STARTX+825,	 STARTY+41, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2,  "����"),
		DLG_BUTTON(STARTX+825,	STARTY+111, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3,  "����"),
		DLG_BUTTON(STARTX+825,	STARTY+181, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK4,  "����"),
		DLG_BUTTON(STARTX+600,	STARTY+450, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1,  "Ȯ��"),
		
		DLG_TEXT ( STARTX,	    STARTY-29, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "���б�"),
		DLG_TEXT ( STARTX+300,	STARTY-29, 525, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT ( STARTX,	    STARTY+41, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "������"),
		DLG_TEXT ( STARTX+300,  STARTY+41, 525, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,	   STARTY+111, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "�������"),
		DLG_TEXT ( STARTX+300, STARTY+111, 525, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	   STARTY+181, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "���������"),
		DLG_TEXT ( STARTX+300, STARTY+181, 525, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT ( STARTX,	   STARTY+251, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "ȫ����"),
		DLG_TEXT ( STARTX,	   STARTY+321, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "��Ʈ����"),
		
		DLG_COMBO (STARTX+300,  STARTY+251, 700, 200, 175, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+300,  STARTY+321, 700, 200, 175, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
	};
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	//  ���̾�α�:Ư���ü�����
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "Ư���ü� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BACK, ""),

		DLG_BUTTON(STARTX+825,	 STARTY-40, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "����"),
		DLG_BUTTON(STARTX+825,	 STARTY+40, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2,  "����"),
		DLG_BUTTON(STARTX+825,	STARTY+120, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK3,  "����"),
		DLG_BUTTON(STARTX+825,	STARTY+200, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK4,  "����"),
		DLG_BUTTON(STARTX+600,	STARTY+500, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1,  "Ȯ��"),
		
		DLG_TEXT ( STARTX,	    STARTY-40, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "���б�"),
		DLG_TEXT ( STARTX+300,	STARTY-40, 525, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT ( STARTX,	    STARTY+40, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "������"),
		DLG_TEXT ( STARTX+300,  STARTY+40, 525, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,	   STARTY+120, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "�������"),
		DLG_TEXT ( STARTX+300, STARTY+120, 525, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	   STARTY+200, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "���������"),
		DLG_TEXT ( STARTX+300, STARTY+200, 525, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT ( STARTX,	   STARTY+280, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "ȫ����"),
		DLG_TEXT ( STARTX,	   STARTY+360, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "��Ʈ����"),
		
		DLG_COMBO (STARTX+300,  STARTY+280, 700, 200, 175, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		DLG_COMBO (STARTX+300,  STARTY+360, 700, 200, 175, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
	};
	
	//----------------------------------------------------------------------
	void	OnInit(char bFirst)
	{
		long i;
		long lCount = 0;
		char szSql[300];
		
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			//�ʱ� ī�� �ε��
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
				
				if(g_lSCMoveFlag == 1)
				{
					Card_Load("BS_START");
					return;
				}

				//ȫ����
				for ( i = 0 ;  SCADV[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), SCADV[i].Str, 0, ICON_NONE);
				}
				
				//��Ʈ����
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), "�̼�ġ", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), "��ġ", 0, ICON_NONE);

				SetBtnImg();
				
				REDRAW();
				
				if( Str_Cmp(stUserinfo.szcenter_cd,"91") == 0 
			  	 || Str_Cmp(stUserinfo.szcenter_cd,"92") == 0 
				 || Str_Cmp(stUserinfo.szcenter_cd,"93") == 0 
				 || Str_Cmp(stUserinfo.szcenter_cd,"94") == 0 
				 || Str_Cmp(stUserinfo.szcenter_cd,"95") == 0 )
				{
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM ='%s' AND GOV_REGTR_FLAG ='10' ", g_szCHK_EXEC_NUM, 0, 0);
					g_Sql_RetInt(szSql, &lCount);
					
					if( lCount > 0 )
					{
						if( g_lGovFlag == 0 )
						{
							g_nWorkChkFlag = 40;
							Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
							Str_Cpy(stBsNogood.CHK_SEC_CD, "21");
							Str_Cpy(stBsNogood.MTR_NUM, "");
							Str_Cpy(stBsNogood.BURNER_NUM, "");
							Str_Cpy(stBsNogood.CHK_SEC_NM, "���б�");
							Card_Move("CHK_BSDTL");
							return;
						}
					}
				}
				
				break;
		}		
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		
		
	}

	//----------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_CHECK1:		//���б�
				g_nWorkChkFlag = 40;
				g_lSCMoveFlag = 1;
				Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stBsNogood.CHK_SEC_CD, "21");
				Str_Cpy(stBsNogood.MTR_NUM, "");
				Str_Cpy(stBsNogood.BURNER_NUM, "");
				Str_Cpy(stBsNogood.CHK_SEC_NM, "���б�");
				Card_Move("CHK_BSDTL");
				break;
			case BID_CHECK2:		//������
				g_nWorkChkFlag = 40;
				g_lSCMoveFlag = 1;
				Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stBsNogood.CHK_SEC_CD, "23");
				Str_Cpy(stBsNogood.MTR_NUM, "");
				Str_Cpy(stBsNogood.BURNER_NUM, "");
				Str_Cpy(stBsNogood.CHK_SEC_NM, "������");
				Card_Move("CHK_BSDTL");
				break;
			case BID_CHECK3:		//�������
				g_nWorkChkFlag = 40;
				g_lSCMoveFlag = 1;
				Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stBsNogood.CHK_SEC_CD, "10");
				Str_Cpy(stBsNogood.MTR_NUM, "");
				Str_Cpy(stBsNogood.BURNER_NUM, "");
				Str_Cpy(stBsNogood.CHK_SEC_NM, "���");
				Card_Move("CHK_BSDTL");
				break;
			case BID_CHECK4:		//���������
				g_nWorkChkFlag = 40;
				g_lSCMoveFlag = 1;
				Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stBsNogood.CHK_SEC_CD, "70");
				Str_Cpy(stBsNogood.MTR_NUM, "");
				Str_Cpy(stBsNogood.BURNER_NUM, "");
				Str_Cpy(stBsNogood.CHK_SEC_NM, "�����");
				Card_Move("CHK_BSDTL");
				break;
			case BID_OK1:
				if( !Validate() )
					break;

				// if( Save_Result() )
				Card_Move("BS_START");
				break;
			case BID_BACK:
				// if( !Validate() )
				// 	break;
				// if( Save_Result_Back() )
				Card_Move("BS_START");
				break;
		}
	}
	
//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		char szSql[400];
		long i;
	
		if( INIT_MAIN == m_bFirst )
		{	
			//ȫ����
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "�̹���") == 0 )
				Str_Cpy(stBs.ADV_DIST_YN, "N");
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "����") == 0 )
				Str_Cpy(stBs.ADV_DIST_YN, "Y");
				
			//��Ʈ����
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "�̼�ġ") == 0 )
				Str_Cpy(stBs.HEAT_PUMP_YN, "N");
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "��ġ") == 0 )
				Str_Cpy(stBs.HEAT_PUMP_YN, "Y");
		}
	}
	
//=======================================================================================
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
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

		for ( i = 0 ; GM_CODE[i].Code[0] != 0 ; i++)
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
				return i;
		}
		
		return -1;
	}
	
//----------------------------------------------------------------------------
//------------------------------------------------------------------------------
	void REDRAW(void)
	{
		char szSql[300];
		long lCount;
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		//�⺻ ������,���б� ���� ��ư FALSE ����. ����� ���� Ȯ�� �� ��ư Ȱ��ȭ ����
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
	
		//����� ������ ����Ȯ��
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM ='%s' AND GOV_REGTR_FLAG ='10' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK1), FALSE );
		}
		else
		{
			Str_Cpy(stBs.GOV_RSLT, "Y");
		}
		//����� ���б� ����Ȯ��
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_GOV_REG WHERE CHK_EXEC_NUM ='%s' AND GOV_REGTR_FLAG ='20' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CHECK2), FALSE );
		}	
		else
		{
			Str_Cpy(stBs.REG_RSLT, "Y");
		}	
	
		//���б� ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='21' AND BETTER_YN = 'N' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "������");	
		}
		else
		{
			if( stBs.GOV_RSLT[0] == '' )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "������");	
			}
			else
			{
				EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA2), TXTFRCOLOR);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), "����");	
			}
		}
		
		//������ ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='23' AND BETTER_YN = 'N'  ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA4), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "������");	
		}
		else
		{	

			if( stBs.REG_RSLT[0] == '' )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "������");	
			}
			else
			{
				EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA4), TXTFRCOLOR);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "����");	
			}	
		}
		
		//��� ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='10' AND BETTER_YN = 'N'  ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA6), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "������");	
		}
		else
		{
			if( stBs.PIPE_RSLT[0] == '' )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "������");	
			}
			else
			{
				EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA6), TXTFRCOLOR);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "����");	
			}
			
		}
		
		//����� ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='70' AND BETTER_YN = 'N'  ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "������");	
		}

		
		else
		{
			if( stBs.PIPEETC_RSLT[0] == '' )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "������");	
			}
			else
			{
				EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8), TXTFRCOLOR);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "����");	
			}
		}
		
		//ȫ����
		if( Str_Cmp(stBs.ADV_DIST_YN, "N") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "�̹���");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), "����");
		}
		
		//��Ʈ����
		if( Str_Cmp(stBs.HEAT_PUMP_YN, "N") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "�̼�ġ");
		}
		else if( Str_Cmp(stBs.HEAT_PUMP_YN, "Y") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "��ġ");
		}
	}
	
//----------------------------------------------------------------------------
	bool Save_Result(void)
	{
		char szSql[300];
		long lCount;
		long lChk = 0;
		long idx;
		long i;
		bool ret = TRUE;
		long lCnt;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//GOV_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='21' AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.GOV_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.GOV_RSLT, "Y");

		// // //REG_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='23' AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.REG_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.REG_RSLT, "Y");
			
		// // //PIPE_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='10'  AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.PIPE_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.PIPE_RSLT, "Y");
			
		// // //PIPEETC_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='70'  AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.PIPEETC_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.PIPEETC_RSLT, "Y");
 
		//�����հ��
		// if( lChk > 0 )
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "N");
		// else
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "Y");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					ADV_DIST_YN = ?, HEAT_PUMP_YN = ?, SPECIAL_RSLT = ? \
					WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.ADV_DIST_YN		,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.HEAT_PUMP_YN	,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_RSLT	,2	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_GOV_REG  WHERE CHK_EXEC_NUM = '%s' AND GOV_REGTR_FLAG ='10' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &lCnt );

		//PRINT("stGovinfo2.NEW_DISJOINT_CHK_YMD : %s",stGovinfo2.NEW_DISJOINT_CHK_YMD,0,0);

		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0) //���б⿡ �߾��̸� �ʼ�.
		{
			if( Str_Len(stGovinfo2.NEW_DISJOINT_CHK_YMD) == 0 )
			{	
				MessageBoxEx (CONFIRM_OK, "���б� ������������ Ȯ���ϼ���.\n(�ʼ�)");
				ret = FALSE;
				return ret;
			}
		}
		else if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 && Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0 )
		//�������̸鼭 1��ġ�� �ƴѰ�
		{
			if( Str_Len(stGovinfo2.NEW_FILTER_CLEAN_YMD) == 0 )
			{
				if(lCnt == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0 )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "������ ����û�Ҹ� Ȯ���ϼ���.\n(�ʼ�)") == MB_OK)
					{	
						ret = FALSE;
						return ret;
					}
				}
				else if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0)
				{
					if( MessageBoxEx (CONFIRM_YESNO, "������ ����û�Ҹ� Ȯ���ϼ���.\n(�ʼ�)") == MB_OK)
					{	
						ret = FALSE;
				return ret;
					}
				}
			}
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

	bool Save_Result_Back(void)
	{
		char szSql[300];
		long lCount;
		long lChk = 0;
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//GOV_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='21' AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.GOV_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.GOV_RSLT, "Y");

		// // //REG_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='23' AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.REG_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.REG_RSLT, "Y");
			
		// // //PIPE_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='10'  AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.PIPE_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.PIPE_RSLT, "Y");
			
		// // //PIPEETC_RSLT
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='70'  AND BETTER_YN = 'N' "
		// 				, g_szCHK_EXEC_NUM, 0, 0);
		// g_Sql_RetInt(szSql, &lCount);
		// if( lCount > 0 )
		// {
		// 	Str_Cpy(stBs.PIPEETC_RSLT, "N");
		// 	lChk++;
		// }
		// else
		// 	Str_Cpy(stBs.PIPEETC_RSLT, "Y");

		// //�����հ��
		// if( lChk > 0 )
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "N");
		// else
		// 	Str_Cpy(stBs.SPECIAL_RSLT, "Y");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					ADV_DIST_YN = ?, HEAT_PUMP_YN = ?, SPECIAL_RSLT = ? \
					WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.ADV_DIST_YN		,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.HEAT_PUMP_YN	,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_RSLT	,2	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		//PRINT("stGovinfo2.NEW_DISJOINT_CHK_YMD : %s",stGovinfo2.NEW_DISJOINT_CHK_YMD,0,0);

		// if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 )
		// {
		// 	if( Str_Len(stGovinfo2.NEW_DISJOINT_CHK_YMD) == 0 )
		// 	{	
		// 		MessageBoxEx (CONFIRM_OK, "���б� ������������ Ȯ���ϼ���.\n(�ʼ�)");
		// 		ret = FALSE;
		// 		return ret;
		// 	}
		// }
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

	bool Validate(void)
	{
		char szSql[300];
		char szTmp[256];
		char szfilenm[256];
		char szDate[256];
		char szYear[256];
		char szChkDate[256];
		long idx;
		bool ret = TRUE;
		long lChk = 0;
		long lCount;
		long lCnt;
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szChkDate, 0x00, sizeof(szChkDate));
		
		Str_ItoA(Time_GetDate(), szDate, 10);
		Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
		Mem_Cpy((byte *)szChkDate, (byte *)stGovinfo2.NEW_DISJOINT_CHK_YMD, 4);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_GOV_REG  WHERE CHK_EXEC_NUM = '%s' AND GOV_REGTR_FLAG ='10' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &lCnt );

		
		if( Str_Cmp(stBs.GOV_RSLT, "") == 0 || Str_Cmp(stBs.REG_RSLT, "") == 0 || Str_Cmp(stBs.PIPE_RSLT, "") == 0 || Str_Cmp(stBs.PIPEETC_RSLT, "") == 0)
		{
			MessageBoxEx (CONFIRM_OK, "�������׸��� Ȯ���ϼ���.");
			ret = FALSE;
			return ret;
		}

		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0)
		{
			if( Str_Len(stGovinfo2.NEW_DISJOINT_CHK_YMD) == 0 )
			{	
				MessageBoxEx (CONFIRM_OK, "���б� ������������ Ȯ���ϼ���.\n(�ʼ�)");
				ret = FALSE;
				return ret;
			}
		}
		else if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "20") == 0 && Str_Cmp(stGovinfo2.REGTR_STD, "10") != 0 )
		//�������̸鼭 1��ġ�� �ƴѰ�
		{
			if( Str_Len(stGovinfo2.NEW_FILTER_CLEAN_YMD) == 0 )
			{
				if(lCnt == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0 )
				{
					if( MessageBoxEx (CONFIRM_OK, "������ ����û�Ҹ� Ȯ���ϼ���.\n(�ʼ�)") == MB_OK)
					{	
						ret = FALSE;
						return ret;
					}
				}
				else if(Str_Cmp(stBs.PRESS_FLAG, "R") == 0)
				{
					if( MessageBoxEx (CONFIRM_OK, "������ ����û�Ҹ� Ȯ���ϼ���.\n(�ʼ�)") == MB_OK)
					{	
						ret = FALSE;
						return ret;
					}
				}
			}
		}

		//GOV_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='21' AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{	
			lChk++;
		}
		

		// // //REG_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='23' AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			lChk++;
		}
		
			
		// // //PIPE_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='10'  AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			lChk++;
		}
		
			
		// // //PIPEETC_RSLT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='70'  AND BETTER_YN = 'N' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			// Str_Cpy(stBs.PIPEETC_RSLT, "N");
			lChk++;
		}
		
 
		//�����հ��
		if( lChk > 0 )
			Str_Cpy(stBs.SPECIAL_RSLT, "N");
		else
			Str_Cpy(stBs.SPECIAL_RSLT, "Y");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					ADV_DIST_YN = ?, HEAT_PUMP_YN = ?, SPECIAL_RSLT = ? \
					WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.ADV_DIST_YN		,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.HEAT_PUMP_YN	,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_RSLT	,2	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
}


