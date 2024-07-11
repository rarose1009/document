/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_MEMO
	Card Desc : ���� �޸�
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_MEMO
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
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_EXIT )		// �ݱ�
		DEF_BUTTON_ID ( BID_DEL )		// �޸����
		DEF_BUTTON_ID ( BID_SAVE )		// �޸�����
		DEF_BUTTON_ID ( BID_CANCEL )	// ���
		DEF_BUTTON_ID ( BID_WRITE )		// ���	
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE ) 
		DEF_OBJECT_ID ( TXT_DATA1 ) 
		DEF_OBJECT_ID ( TXT_DATA2 ) 
		DEF_OBJECT_ID ( EDT_MEMO ) 
		DEF_OBJECT_ID ( ICON_TITLE )
		DEF_OBJECT_ID ( CMB_DATA1 )
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	//�⺻���� CTRL��ġ�� �⺻����
	#define 	SX		(STARTX*20)
	#define 	SY		(STARTY*2)
	#define 	SYH		(CHT*2)
	#define 	SXD		(CWD*33)
	#define 	SYD		(CHT*9)

	//�⺻���� DLGȭ�� ����
	#define 	INIT_MAIN		1

	//---------------------------------------------------------------------------------------
	//	main entry map
	//---------------------------------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	long m_lMemoChk = 0;

	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	long TR312315(void);
	void REDRAW(void);		// �ڷḦ ���÷����Ѵ�.
	void SAVE_MEMO(void);   // �޸� �����Ѵ�.
	void SetBtnImg(void);
	void Snd_Memo(void);
	
	//---------------------------------------------------------------------------------------
	// �⺻ �޸�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG  ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, "" ),
		DLG_ICON  ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT  ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�޸�" ),
		DLG_BUTTON( BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, "" ),
		
		DLG_BUTTON( STARTX,		 STARTY  -29, 1000, 800, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  "" ),	
		DLG_TEXT  ( STARTX,		 STARTY  -29, 1000, 800, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_MEMO,  "" ),

		DLG_BUTTON( STARTX,		 STARTY +799,  333, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "�� ��" ),
		DLG_BUTTON( STARTX +333, STARTY +799,  333, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL,   "�� ��" ),	
		DLG_BUTTON( STARTX +666, STARTY +799,  334, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE,  "�� ��" ),	
	};

	//---------------------------------------------------------------------------------------
	// ���� �޸�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_SC[] = 
	{
		NORM_DLG  ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, "" ),
		DLG_ICON  ( P_TTLTX, 0, ICON_TITLE, "" ),
		DLG_TEXT  ( P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�޸�" ),
		DLG_BUTTON( P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, "" ),

		DLG_COMBO ( STARTX,      STARTY  -29, 1000, 200, 200, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20 ),
		DLG_BUTTON( STARTX,      STARTY  +80, 1000, 700, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  "" ),	
		DLG_TEXT  ( STARTX,      STARTY  +80, 1000, 700, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_MEMO,  "" ),

		DLG_BUTTON( STARTX,		 STARTY +799,  333, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "�� ��" ),
		DLG_BUTTON( STARTX +333, STARTY +799,  333, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL,   "�� ��" ),	
		DLG_BUTTON( STARTX +666, STARTY +799,  334, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE,  "�� ��" ),
		
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
		long i;
		
		switch (bFirst)
		{
			//�ʱ� ī�� �ε��
			case INIT_MAIN:
				
				if( g_nMemoFlag == 2 || g_nMemoFlag == 3 || g_nMemoFlag == 4 )
				{
					CREATE_DIALOG_OBJECT (DlgRes_SC, SIZEOF(DlgRes_SC));

					for ( i = 0 ;  CHK_MEMO[i].Str[0] != 0 ; i++)
					{
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), CHK_MEMO[i].Str, 0, ICON_NONE);
					}

					EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
				}
				else
				{
					CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				}
				
				SetBtnImg();
				REDRAW();

				break;	
		}		
	}

	/*=======================================================================================
	�Լ��� : OnPointing
	��  �� : Ű����
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{			
			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+50) && X < DMS_X(STARTX+950) && Y > DMS_Y(STARTY+20) && Y < DMS_Y(STARTY+370) )
				{
					if( Get_iDlgCtrlByID(EDT_MEMO) == lActiveIndex )
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
				
				ON_DRAW();
			}
		}
	}

	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long i;
	
		if( g_nMemoFlag == 2 )
		{	
			//�޸��ڵ�
			i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), CHK_MEMO );

			if (i == -1)
			{
				Str_Cpy(stSc.BEFO_HALF_MEMO_WHY, "");
			}
			else
			{
				Str_Cpy(stSc.BEFO_HALF_MEMO_WHY, CHK_MEMO[i].Code);
			}
		}
		else if( g_nMemoFlag == 3 )
		{
			//�޸��ڵ�
			i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), CHK_MEMO );

			if (i == -1)
			{
				Str_Cpy(stScJjChk.FHALF_MEMO_FLAG, "");
			}
			else
			{
				Str_Cpy(stScJjChk.FHALF_MEMO_FLAG, CHK_MEMO[i].Code);
			}
		}
		else if( g_nMemoFlag == 4 )
		{
			//�޸��ڵ�
			i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), CHK_MEMO );

			if (i == -1)
			{
				Str_Cpy(stBs.BEFO_HALF_MEMO_WHY, "");
			}
			else
			{
				Str_Cpy(stBs.BEFO_HALF_MEMO_WHY, CHK_MEMO[i].Code);
			}
		}
	}

	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		char szMemo[300];
	
		switch(ID)
		{
			//���
			case BID_CANCEL:
				if( g_nMemoFlag == 6 )
				{
					Mem_Set( (byte*)szMemo, 0x00, sizeof(szMemo)  );
					Str_Cpy(szMemo, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_MEMO))) ;
	
					if( Str_Cmp(stMtrChg.MEMO, szMemo) != 0 )
					{
						if( MessageBoxEx (CONFIRM_YESNO, "����� �޸𳻿��� ������� �ʾҽ��ϴ�.\nȭ���� �����ðڽ��ϱ�?")  == MB_OK)
						{
							g_nMemoFlag = 0;
							Card_Prev();
						}
						
						break;
					}
				}
				
				if( g_nMemoFlag != 7 )
				{
					g_nMemoFlag = 0;
				}

				Card_Prev();
				break;
				
			//�޸�����
			case BID_SAVE:
				if( Str_Len(Get_hDlgCtrlByID(EDT_MEMO)) > 0 )
				{
					if( g_nMemoFlag == 2 || g_nMemoFlag == 6)
					{
						Snd_Memo();
					}
					else if( g_nMemoFlag == 7 )
					{
						//�ο��ǻ� �޸� -> �����ֱ�� ȭ��, ���� X
						//g_nMemoFlag �ʱ�ȭ -> �ο��ǻ� ȭ�鿡�� ��.
						//g_nMemoFlag = 0;
						Card_Prev();
					}
					else
					{
						SAVE_MEMO();
						
						if( m_lMemoChk == 0 )
						{
							g_nMemoFlag = 0;
							Card_Prev();
						}
					}
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "�޸� �Է��� �ּ���.");
				}
				break;
				
			case BID_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_MEMO), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_MEMO)) );
				break;
			
			//�޸𳻿� ����
			case BID_DEL:
				if( MessageBoxEx (CONFIRM_YESNO, "�޸� �����ϰڽ��ϱ�?")  == MB_OK)
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_MEMO), "");
				}
				
				break;
		}
	}

	//---------------------------------------------------------------------------------------
	// �Ϲ� FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ��ư �̹���
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
	}

	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : �� �������� ������ �޸� ȭ�鿡 �����ش�.
	Param  : g_nMemoFlag => 1:��ħ , 2:��������, 3:������, 4:Ư������ �޸�, 5:Ư������ �跮�� �޸�, 6:�跮�ⱳü �޸�, 7:�ο��ǻ� �޸�(�����ֱ��?)
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		long i;
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(EDT_MEMO), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetEditableMode( Get_hDlgCtrlByID(EDT_MEMO), EDITMODE_HANGUL );
		EditCtrl_SetMaxChar(Get_hDlgCtrlByID(EDT_MEMO),190);
	
		if( g_nMemoFlag == 1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_MEMO), stGm.RMK );
		}
		else if( g_nMemoFlag == 2)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_MEMO), stSc.BEFO_HALF_MEMO );
			i = g_SearchCD( stSc.BEFO_HALF_MEMO_WHY, CHK_MEMO );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), CHK_MEMO[i].Str);
		}
		else if( g_nMemoFlag == 3 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_MEMO), stScJjChk.FHALF_MEMO );
			i = g_SearchCD( stScJjChk.FHALF_MEMO_FLAG, CHK_MEMO );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), CHK_MEMO[i].Str);
		}
		else if( g_nMemoFlag == 4 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_MEMO), stBs.BEFO_HALF_MEMO );
			i = g_SearchCD( stBs.BEFO_HALF_MEMO_WHY, CHK_MEMO );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), CHK_MEMO[i].Str);
		}
		else if( g_nMemoFlag == 5 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_MEMO), stBsMtr.MEMO );
		}
		else if( g_nMemoFlag == 6 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_MEMO), stMtrChg.MEMO );
		}
	}

	/*=======================================================================================
	�Լ��� : SAVE_MEMO
	��  �� : �� �������� ������ �޸� ȭ�鿡 �����ش�.
	Param  : 
	Return : 
	========================================================================================*/
	void SAVE_MEMO(void)
	{
		char szSql[300];
		char szMemo[300];
		char szScout[200];
		char szTmp[500];
		long idx, ret;
		long nLen;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)szMemo, 0x00, sizeof(szMemo)  );
		Str_Cpy(szMemo ,EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_MEMO)) );

		hdb = sql->Open(sql);

		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nMemoFlag == 3 )
		{	//������ �޸�
			nLen = g_GetUtf8Size(szMemo);
			if( nLen > 100 )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				SPRINT(szTmp, "�������!\n(�޸�� �ѱ� 33��,\n����.���� 100�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
				MessageBoxEx(CONFIRM_OK, szTmp);
				m_lMemoChk = 1;
				goto Finally;
			}
		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE REGTR_DATA SET FHALF_MEMO =?, FHALF_MEMO_FLAG = ? WHERE REGTR_NUM = '%s' AND CHK_PLAN_YM = '%s' AND SAFE_CHK_TYPE = '%s' ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
		   
		    hstmt = sql->CreateStatement(sql, szSql);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}

			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)szMemo		            ,100	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.FHALF_MEMO_FLAG,2  	,DECRYPT);
		}
		else if( g_nMemoFlag == 4 )
		{	//Ư������ �޸�
			nLen = g_GetUtf8Size(szMemo);
			
			if( nLen > 100 )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				SPRINT(szTmp, "�������!\n(�޸�� �ѱ� 33��,\n����.���� 100�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
				MessageBoxEx(CONFIRM_OK, szTmp);
				m_lMemoChk = 1;
				goto Finally;
			}
		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			
			SPRINT( szSql, "UPDATE SPECIAL_DATA SET BEFO_HALF_MEMO = ?, BEFO_HALF_MEMO_WHY = ? WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0 );
		   	
		    hstmt = sql->CreateStatement(sql, szSql);
			
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)szMemo		            ,100	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBs.BEFO_HALF_MEMO_WHY	,2  	,DECRYPT);
		}
		else if( g_nMemoFlag == 5 )
		{	//Ư������ �跮������ �޸�
			nLen = g_GetUtf8Size(szMemo);
			if( nLen > 100 )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				SPRINT(szTmp, "�������!\n(�޸�� �ѱ� 33��,\n����.���� 100�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
				MessageBoxEx(CONFIRM_OK, szTmp);
				m_lMemoChk = 1;
				goto Finally;
			}

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE SPECIAL_MTR SET MEMO =? WHERE SPECIAL_NUM = '%s' AND MTR_NUM = '%s' "
		   , stBsMtr.SPECIAL_NUM, stBsMtr.MTR_NUM, 0);
		   
		    hstmt = sql->CreateStatement(sql, szSql);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}

			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)szMemo		,200	,DECRYPT);
		}
		else if( g_nMemoFlag == 6 )
		{	//�跮�ⱳü �޸�
			nLen = g_GetUtf8Size(szMemo);
			if( nLen > 60 )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				SPRINT(szTmp, "�������!\n(�޸�� �ѱ� 20��,\n����.���� 100�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
				MessageBoxEx(CONFIRM_OK, szTmp);
				m_lMemoChk = 1;
				goto Finally;
			}

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE C6301_CHANGEDATA SET MEMO =? WHERE MTR_NUM = '%s' "
		   , g_szMTR_NUM, 0, 0);
		   
		    hstmt = sql->CreateStatement(sql, szSql);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}

			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)szMemo		,200	,DECRYPT);
		}
		
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			if( g_nMemoFlag == 3 )
			{	//������ �޸�
				Str_Cpy(stScJjChk.FHALF_MEMO, szMemo);
			}
			else if( g_nMemoFlag == 4 )
			{	//Ư������ �޸�
				Str_Cpy(stBs.BEFO_HALF_MEMO, szMemo);
			}
			else if( g_nMemoFlag == 5 )
			{	//Ư������ �跮������ �޸�
				Str_Cpy(stBsMtr.MEMO, szMemo);
			}
			else if( g_nMemoFlag == 6 )
			{	//�跮�ⱳü �޸�
				Str_Cpy(stMtrChg.MEMO, szMemo);
			}		
			MessageBoxEx(CONFIRM_OK, "�޸� ����Ǿ����ϴ�.");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Memo
	��  �� : FR312315
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_Memo(void)
	{
		char szUrl[200];
		char szbuf[128];
		char szMemo[301];
		char szUMemo[601];
		char* sndbuf;
		long ret = 0;
	
		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		Mem_Set((byte*)szMemo, 0x00, sizeof(szMemo));		
		Mem_Set((byte*)szUMemo, 0x00, sizeof(szUMemo));		
		Str_Cpy(szMemo ,EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_MEMO)) );
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}

		if( g_nMemoFlag == 2 )
		{
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312315, FALSE);
		
			JSON_SetValue( g_pjcomm, 'C', "memo_flag",   "2" );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num",   g_szCHK_EXEC_NUM );
			SQL_ConvUcStr( szUMemo, szMemo );
			JSON_SetValue( g_pjcomm, 'C', "chk_memo", szUMemo );
			
			sndbuf = JSON_toString(g_pjcomm);
			
			g_SeverConnection();
					
			Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
			GET_FILENM(szbuf, SQLITE_DB);
			
			callBackfunc = TR312315;
			ret = HTTP_DownloadData(szUrl, "FR312315_IN",  "FR312315" , sndbuf, szbuf );

		}
		else if( g_nMemoFlag == 6 )
		{
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312315, FALSE);
			
			JSON_SetValue( g_pjcomm, 'C', "memo_flag",   "6" );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num",   g_szMTR_NUM );
			SQL_ConvUcStr( szUMemo, szMemo );
			JSON_SetValue( g_pjcomm, 'C', "chk_memo", szUMemo );
			
			sndbuf = JSON_toString(g_pjcomm);
			
			g_SeverConnection();
					
			Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
			GET_FILENM(szbuf, SQLITE_DB);
			
			callBackfunc = TR312315;
			ret = HTTP_DownloadData(szUrl, "FR312315_IN",  "FR312315" , sndbuf, szbuf );

		}
		
		
		return;
	}

	/*=======================================================================================
	�Լ��� : TR312315
	��  �� : Callback FR312315
	Param  : 
	Return : 
	========================================================================================*/
	long TR312315(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(312315) >= 0)
		{
			CloseMessageBox();
			SAVE_MEMO();
			g_nMemoFlag = 0;
			Card_Prev();
			return 1;
		}
		else
		{
			CloseMessageBox();
			return -1;
		}
	}
}


