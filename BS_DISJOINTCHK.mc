/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : BS_DISJOINTCHK
	Card Desc : Ư�� ��������
	Card Hist :
----------------------------------------------------------------------------------*/
card BS_DISJOINTCHK
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()		
		DEF_BUTTON_ID ( BID_CHG )			// ����
		DEF_BUTTON_ID ( BID_CLOSE )			// �ݱ�
		DEF_BUTTON_ID ( BID_SCHDL )			// ���������� �޷�
		DEF_BUTTON_ID ( BID_DATE )			// ���������� ����
		
		DEF_BUTTON_ID ( BID_DETA_LOC_2 )	// ����ġ
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		// ������
		DEF_OBJECT_ID ( ICON_TITLE )			// Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_TITLE )				// Ÿ��Ʋ

		// ���� ����
		DEF_OBJECT_ID ( ST_DIV_1 )				// �и���_1
		
		DEF_OBJECT_ID ( ST_MAKER_1 )			// ���ۻ�_1
		DEF_OBJECT_ID ( TXT_MAKER_1 )			// ���ۻ�_1
		
		DEF_OBJECT_ID ( ST_MODEL_1 )			// ��_1
		DEF_OBJECT_ID ( TXT_MODEL_1 )			// ��_1
		
		DEF_OBJECT_ID ( ST_DJ_CHK_FIRM_1 )		// �������˻�_1
		DEF_OBJECT_ID ( TXT_DJ_CHK_FIRM_1 )		// �������˻�_1
		
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD_1 )		// ����������_1
		DEF_OBJECT_ID ( TXT_DJ_CHK_YMD_1 )		// ����������_1
				
		DEF_OBJECT_ID ( ST_DJ_REG_DATE_1 )		// ���������� �������_1
		DEF_OBJECT_ID ( TXT_DJ_REG_DATE_1 )		// ���������� �������_1

		DEF_OBJECT_ID ( ST_INST_YMD_1 )			// ��ġ����_1
		DEF_OBJECT_ID ( TXT_INST_YMD_1 )		// ��ġ����_1
		
		// �������� �Է�
		DEF_OBJECT_ID ( ST_DIV_2 )				// �и���_2

		DEF_OBJECT_ID ( ST_DJ_CHK_FIRM_2 )		// �������˻�_2
		
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD1_2 )		// ����������1_2
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD2_2 )		// ����������2_2
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD3_2 )		// ����������3_2
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD4_2 )		// ����������4_2
		DEF_OBJECT_ID ( ST_DJ_CHK_YMD5_2 )		// ����������5_2
		
		DEF_OBJECT_ID ( EDT_DJ_CHK_YMD_YEAR_2 )	// ����������_�⵵_2
		DEF_OBJECT_ID ( EDT_DJ_CHK_YMD_MONTH_2 )// ����������_��_2
		DEF_OBJECT_ID ( EDT_DJ_CHK_YMD_DATE_2 )	// ����������_��_2

		DEF_OBJECT_ID ( ST_DETA_LOC_2 )			// ����ġ_2
		DEF_OBJECT_ID ( EDT_DETA_LOC_2 )		// ����ġ_2
		
		// ����
		DEF_OBJECT_ID ( LINE_DATA1 )			// ����1
		DEF_OBJECT_ID ( LINE_DATA2 )			// ����2
		
		// �޺��ڽ�
		DEF_OBJECT_ID ( CMB_DJ_CHK_FIRM )		// �������˻�
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	  1
	
	//---------------------------------------------------------------------------------------
	// Struct
	//---------------------------------------------------------------------------------------
	// ������,���б� ����, ������ ������ ������ ������Ʈ ���ϵ��� ���� ����
	typedef struct _PRESSINFO
	{
		char NEW_DISJOINT_CHK_FIRM_NM   [30 +1]; 
		char NEW_DISJOINT_CHK_YMD    	[15 +1]; 
		char DETA_LOC              		[30 +1];
	} PRESSINFO;
	
	PRESSINFO m_stBsPress;
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	char m_szGOV_REGTR_FLAG[10];
	
	long m_bFirst;
	long m_lEditCtrlIndex = -1;
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void REDRAW(void);
	void SetStruct(void);
	bool Save_PRESSCHG(void);
	bool Compare_Data(void);
	bool isValid(void);
	void move_back(void);
	void move_save(void);
	
	//---------------------------------------------------------------------------------------
	// ���б�/������ �������� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_PRESSCHG[] = 
	{
		NORM_DLG  ( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON  ( POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT  ( POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���б�/������ �������� ����"),
		DLG_BUTTON( BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_TEXT  ( STARTX,	     STARTY -29,  1000, 60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DIV_1, "���� ����"),
		
		DLG_TEXT  ( STARTX,	     STARTY +31,  300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_MAKER_1, "���ۻ�"),
		DLG_TEXT  ( STARTX +300, STARTY +31,  700,  60,  0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MAKER_1, ""),
		
		DLG_TEXT  ( STARTX,	     STARTY +91,  300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_MODEL_1, "��"),
		DLG_TEXT  ( STARTX +300, STARTY +91,  700,  60,  0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MODEL_1, ""),
				
		DLG_TEXT  ( STARTX,	     STARTY +151, 300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_INST_YMD_1, "��ġ����"),
		DLG_TEXT  ( STARTX +300, STARTY +151, 700,  60,  0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INST_YMD_1, ""),

		DLG_TEXT  ( STARTX,	     STARTY +211, 300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DJ_CHK_FIRM_1, "�������˻�"),
		DLG_TEXT  ( STARTX +300, STARTY +211, 700,  60,  0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DJ_CHK_FIRM_1, ""),
		
		DLG_TEXT  ( STARTX,	     STARTY +271, 300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DJ_CHK_YMD_1, "����������"),
		DLG_TEXT  ( STARTX +300, STARTY +271, 700,  60,  0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DJ_CHK_YMD_1, ""),
		
		DLG_TEXT  ( STARTX,	     STARTY +331, 420,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DJ_REG_DATE_1, "�������˵������"),
		DLG_TEXT  ( STARTX +420, STARTY +331, 580,  60,  0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DJ_REG_DATE_1, ""),
		
		DLG_LINE  ( STARTX,      STARTY +395, 1000, STARTY+395, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT  ( STARTX,	     STARTY +400, 1000, 60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DIV_2, "�������� �Է�"),
		
		DLG_BUTTON(STARTX	   , STARTY +460,1000, 60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATE, "�������� ����"),

		DLG_TEXT  ( STARTX,	     STARTY +520, 300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DJ_CHK_FIRM_2, "�������˻�"),
		DLG_COMBO ( STARTX +300, STARTY +520, 700,  200, 180, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DJ_CHK_FIRM, 10),
		
		DLG_TEXT  ( STARTX,	     STARTY +580, 300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DJ_CHK_YMD1_2, "����������"),
		DLG_EDIT  ( STARTX +300, STARTY +580, 200,  60,  0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DJ_CHK_YMD_YEAR_2, 4,  ""),
		DLG_TEXT  ( STARTX +500, STARTY +580, 18,   40,  0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, ST_DJ_CHK_YMD2_2, ""),
		DLG_TEXT  ( STARTX +500, STARTY +580, 18,   60,  0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, ST_DJ_CHK_YMD3_2, "."),
		DLG_EDIT  ( STARTX +518, STARTY +580, 145,  60,  0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DJ_CHK_YMD_MONTH_2, 2,  ""), 
		DLG_TEXT  ( STARTX +663, STARTY +580, 17,   40,  0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, ST_DJ_CHK_YMD4_2, ""),
		DLG_TEXT  ( STARTX +663, STARTY +580, 17,   60,  0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, ST_DJ_CHK_YMD5_2, "."),
		DLG_EDIT  ( STARTX +680, STARTY +580, 140,  60,  0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DJ_CHK_YMD_DATE_2, 2,  ""),
		DLG_BUTTON( STARTX +820, STARTY +580, 180,  60,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "��"),

		DLG_TEXT  ( STARTX,	     STARTY +760, 300,  60,  0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_DETA_LOC_2, "����ġ"),
		DLG_BUTTON( STARTX +300, STARTY +760, 700,  60,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DETA_LOC_2,  ""),	
		DLG_EDIT  ( STARTX +300, STARTY +760, 700,  60,  0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DETA_LOC_2, 30,  ""),
		
		DLG_LINE  ( STARTX,      STARTY +824, 1000, STARTY+824, DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_BUTTON( STARTX,      STARTY +829, 1000, 70,  0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG,  "����"),
	};
	
	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	CARD_ENTRY_MAP()
	
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
		m_bFirst = bFirst;
	
		switch (bFirst)
		{	
			case INIT_MAIN:

				CREATE_DIALOG_OBJECT (DlgRes_PRESSCHG, SIZEOF(DlgRes_PRESSCHG));
				SetBtnImg();
				SetStyle();
				REDRAW();
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		long d,k;
		char szDate[20];
		char szToday[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szMsg[150];
		long cnt;
		char szSql[300];
		char sztmp[100];
		
		switch(ID)
		{
			/********************************/
			/* ���б�,���������            */
			/********************************/		
			case BID_CHG:

				if( Save_PRESSCHG() )
				{
					move_save();
				}
				break;
				
			case BID_CLOSE:
				move_back();
				break;
				
			case BID_SCHDL:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));
				k = Str_AtoI(szDate);

				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();

				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
					Str_ItoA(Time_GetDate(), szToday, 10);
					Str_ItoA(d, szDate, 10);
					
					if( Str_Cmp(szDate, szToday) > 0 )
					{
						MessageBoxEx (CONFIRM_OK, "���� �������� ���ú��� Ů�ϴ�.");
						break;
					}
					else
					{
						Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
						Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
						Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
						Mem_Cpy((byte*)szYear, (byte *)szDate, 4);
						Mem_Cpy((byte*)szMonth, (byte *)szDate+4, 2);
						Mem_Cpy((byte*)szDay, (byte *)szDate+6, 2);
						
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), szYear );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), szMonth );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), szDay );
					}
				}
				
				break;
			
			case BID_DETA_LOC_2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DETA_LOC_2), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DETA_LOC_2)) );
				break;

			case BID_DATE:

				Str_Cpy(stGovinfo2.DISJOINT_CHK_FIRM_NM, stGovinfo2.DISJOINT_CHK_FIRM_NM);

				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM)   , stGovinfo2.DISJOINT_CHK_FIRM_NM);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.DISJOINT_CHK_YMD, 4);
				
				

				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), sztmp );
		
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.DISJOINT_CHK_YMD+4, 2);

				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), sztmp );
				
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.DISJOINT_CHK_YMD+6, 2);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), sztmp );
				

				

				break;
		}
	}		
	
	/*=======================================================================================
	�Լ��� : OnChar
	��  �� : �����Է� üũ
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];

		if( (Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2) == m_lEditCtrlIndex || Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2) == m_lEditCtrlIndex || Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2) == m_lEditCtrlIndex )
		 && (nChar < 48 ||  nChar > 57) )
		{
			MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
			ON_KEY( 5 );
			return;
		}
		
		if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2) == m_lEditCtrlIndex )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)) == 4 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2) == m_lEditCtrlIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)), 1);
			if( Str_AtoI(szTmp) > 1 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
			{
				ON_KEY( 5 );
				return;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)) == 2 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2) == m_lEditCtrlIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)), 1);
			if( Str_AtoI(szTmp) > 3 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
			{
				ON_KEY( 5 );
				return;
			}
		}

		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));
		
		if( Str_Len(szTmp) == 8 )
		{
			Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
			nDate = Str_AtoI(szTmp);
			nRet = Time_ValidateDate(nDate);
			
			if( nRet == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ȿ�� ��¥�� �ƴմϴ�.\n��¥�� Ȯ�����ּ���.");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), "");
				
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}

		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : OnPointing
	��  �� : Ű�е�
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing( long nAction, long X, long Y )
	{
		long lActiveIndex = -1;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{
			m_lEditCtrlIndex = lActiveIndex;

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+500) && Y > DMS_Y(STARTY+210) && Y < DMS_Y(STARTY+280) )
				{
					if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+518) && X < DMS_X(STARTX+663) && Y > DMS_Y(STARTY+210) && Y < DMS_Y(STARTY+280) )
				{
					if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+680) && X < DMS_X(STARTX+820) && Y > DMS_Y(STARTY+210) && Y < DMS_Y(STARTY+280) )
				{
					if( Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
			}
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : Style
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DIV_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_MAKER_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKER_1), EDITALIGN_MIDDLE|EDITALIGN_LEFT);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_MODEL_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MODEL_1), EDITALIGN_MIDDLE|EDITALIGN_LEFT);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_CHK_FIRM_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DJ_CHK_FIRM_1), EDITALIGN_MIDDLE|EDITALIGN_LEFT);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_CHK_YMD_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DJ_CHK_YMD_1), EDITALIGN_MIDDLE|EDITALIGN_LEFT);
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_INST_YMD_1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INST_YMD_1), EDITALIGN_MIDDLE|EDITALIGN_LEFT);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DIV_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER); 

		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_CHK_FIRM_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM), EDITALIGN_MIDDLE|EDITALIGN_LEFT);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DJ_CHK_YMD1_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DETA_LOC_2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		
		
	}
	
	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : ������/���б� ���÷���
	Param  : 
	Return : 
	========================================================================================*/	
	void REDRAW(void)
	{
		char szSql[200];
		char sztmp[100];
		char sztmp2[100];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szDate[15];
		long lToDate , lDisDate;
		long setDate;
		
		Mem_Set((byte*)m_szGOV_REGTR_FLAG, 0x00, sizeof(m_szGOV_REGTR_FLAG));
		Str_Cpy(m_szGOV_REGTR_FLAG, stGovinfo2.GOV_REGTR_FLAG);
		
		if( Str_Cmp( stGovinfo2.SET_YMD, "Y") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DJ_CHK_YMD_1), RED);
		}
		// TXT_DJ_CHK_YMD_1

		// ������Ʈ SetVisible
		// 10 = ���б�, 20 = ������
		if( Str_Cmp(m_szGOV_REGTR_FLAG, "10") == 0 )
		{	
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Mem_Cpy((byte*)szYear, (byte*)stGovinfo2.NEW_DISJOINT_CHK_YMD, 4);
			Mem_Cpy((byte*)szMonth, (byte*)stGovinfo2.NEW_DISJOINT_CHK_YMD+4, 2);
			Mem_Cpy((byte*)szDay, (byte*)stGovinfo2.NEW_DISJOINT_CHK_YMD+6, 2);
			
			// ������������
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), szYear );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), szMonth );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), szDay );
			
			Str_Cpy(m_szGOV_REGTR_FLAG, "20");
		}
		else if( Str_Cmp(m_szGOV_REGTR_FLAG, "20") == 0 )
		{
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(ST_DJ_CHK_FIRM_1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DJ_CHK_FIRM_1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(ST_DJ_CHK_YMD_1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DJ_CHK_YMD_1), FALSE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(ST_DJ_CHK_FIRM_2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(ST_DJ_CHK_YMD1_2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(ST_DJ_CHK_YMD2_2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(ST_DJ_CHK_YMD3_2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(ST_DJ_CHK_YMD4_2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(ST_DJ_CHK_YMD5_2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DJ_CHK_FIRM), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DJ_CHK_FIRM+1), FALSE);
			
			Str_Cpy(m_szGOV_REGTR_FLAG, "30");
		}
		
		/**** ���� ���� ****/
		// ���ۻ�
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		
		SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '%s' AND MAKER_NUM = '%s' ", m_szGOV_REGTR_FLAG, stGovinfo2.MAKER_NUM, 0   );
		g_Sql_RetStr( szSql, 30, sztmp );

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_MAKER_1), sztmp);
		
		// ��
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		
		if( Str_Cmp(m_szGOV_REGTR_FLAG, "20") == 0 )
		{
			SPRINT(szSql, "SELECT GOV_MODEL_NM FROM GOV_MODEL WHERE MAKER_NUM = '%s' AND GOV_MODEL_CD = '%s' " , stGovinfo2.MAKER_NUM, stGovinfo2.MODEL_CD, 0 );
		}
		else
		{
			SPRINT(szSql, "SELECT REGTR_MODEL_NM FROM REGTR_MODEL WHERE MAKER_NUM = '%s' AND REGTR_MODEL_CD = '%s' ", stGovinfo2.MAKER_NUM, stGovinfo2.MODEL_CD, 0   );
		}
		
		g_Sql_RetStr( szSql, 30, sztmp );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_MODEL_1), sztmp);
		
		// ����������
		Mem_Set((byte*)sztmp2, 0x00, sizeof(sztmp2));
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.DISJOINT_CHK_YMD, 4);
		Str_Cpy(sztmp2, sztmp);
		
		Str_Cat(sztmp2, ".");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.DISJOINT_CHK_YMD+4, 2);
		Str_Cat(sztmp2, sztmp);
		
		Str_Cat(sztmp2, ".");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.DISJOINT_CHK_YMD+6, 2);
		Str_Cat(sztmp2, sztmp);

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DJ_CHK_YMD_1), sztmp2);
		
		// ��ġ����
		Mem_Set((byte*)sztmp2, 0x00, sizeof(sztmp2));
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.INST_YMD, 4);
		Str_Cpy(sztmp2, sztmp);
		
		Str_Cat(sztmp2, ".");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.INST_YMD+4, 2);
		Str_Cat(sztmp2, sztmp);
		
		Str_Cat(sztmp2, ".");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.INST_YMD+6, 2);
		Str_Cat(sztmp2, sztmp);
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_INST_YMD_1), sztmp2);
		
		//�������˻� 
		Mem_Set((byte*)sztmp2, 0x00, sizeof(sztmp2));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.DISJOINT_CHK_FIRM_NM, 30);
		Str_Cat(sztmp2, sztmp);

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DJ_CHK_FIRM_1), sztmp2);

		// �������˵������
		Mem_Set((byte*)sztmp2, 0x00, sizeof(sztmp2));
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.CRT_DTM, 4);
		Str_Cpy(sztmp2, sztmp);
		
		Str_Cat(sztmp2, ".");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.CRT_DTM+4, 2);
		Str_Cat(sztmp2, sztmp);
		
		Str_Cat(sztmp2, ".");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Cpy((byte*)sztmp, (byte*)stGovinfo2.CRT_DTM+6, 2);
		Str_Cat(sztmp2, sztmp);

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DJ_REG_DATE_1), sztmp2);
		
		/**** �������� �Է� ****/
		// �������˻�
		ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM+2 ) );
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID ='C30066' AND CODE_ITEM NOT IN ('100','320','330','360','370','380','400','430','999') ORDER BY CAST( SORT_ORDER AS INTEGER), ITEM_KNAME ASC", CMB_DJ_CHK_FIRM+2);
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM), stGovinfo2.NEW_DISJOINT_CHK_FIRM_NM);
		
		// ����ġ
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DETA_LOC_2), stGovinfo2.DETA_LOC);
		
		// ��Ʈ���Ŀ� ������ ����
		SetStruct();

		return;
	}
	
	/*=======================================================================================
	�Լ��� : SetStruct
	��  �� : m_stBsPress Setting
	Param  : 
	Return : 
	========================================================================================*/	
	void SetStruct(void)
	{
		Mem_Set((byte*)&m_stBsPress, 0x00, sizeof(m_stBsPress));
	
		// �������˻�
		Str_Cpy(m_stBsPress.NEW_DISJOINT_CHK_FIRM_NM, stGovinfo2.NEW_DISJOINT_CHK_FIRM_NM);
		
		// ����������
		Str_Cpy(m_stBsPress.NEW_DISJOINT_CHK_YMD, stGovinfo2.NEW_DISJOINT_CHK_YMD);
		
		// ����ġ
		Str_Cpy(m_stBsPress.DETA_LOC, stGovinfo2.DETA_LOC);
	}
	
	/*=======================================================================================
	�Լ��� : Save_PRESSCHG
	��  �� : ������,���б� ������Ʈ
	Param  : 
	Return : 
	========================================================================================*/	
	bool Save_PRESSCHG(void) 
	{
		char szSql[400];
		char szTmp[30];
		char szToday[30];
		long idx;
		long nLen;
		bool ret = TRUE;		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		// Validation
		if( !isValid() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		// ������ �����Ͱ� ������ Update ����
		if( Compare_Data() )
		{
			ret = FALSE;
			goto Finally;
		}

		// ����������
		Mem_Set( (byte*)stGovinfo2.NEW_DISJOINT_CHK_YMD, 0x00, sizeof(stGovinfo2.NEW_DISJOINT_CHK_YMD) );
		Str_Cpy(stGovinfo2.NEW_DISJOINT_CHK_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
		Str_Cat(stGovinfo2.NEW_DISJOINT_CHK_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
		Str_Cat(stGovinfo2.NEW_DISJOINT_CHK_YMD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));

		// �������˻�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(stGovinfo2.NEW_DISJOINT_CHK_FIRM_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM)) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID ='C30066' AND ITEM_KNAME = '%s' ",stGovinfo2.NEW_DISJOINT_CHK_FIRM_NM, 0, 0   );
		g_Sql_RetStr( szSql, 3, stGovinfo2.NEW_DISJOINT_CHK_FIRM_CD );
	

		// ����ġ
		Mem_Set( (byte*)stGovinfo2.DETA_LOC, 0x00, sizeof(stGovinfo2.DETA_LOC) );
		Str_Cpy(stGovinfo2.DETA_LOC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DETA_LOC_2)));

		// SEND_YN
		Str_Cpy(stGovinfo2.SEND_YN, "S");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_GOV_REG \
					      SET NEW_DISJOINT_CHK_FIRM_NM = ?, NEW_DISJOINT_CHK_FIRM_CD = ?, NEW_DISJOINT_CHK_YMD = ?, INST_YMD = ?, DETA_LOC = ? \
					        , UPD_EMPID = ?, PDA_IP = ?, SEND_YN = 'S' \
				   	    WHERE CHK_EXEC_NUM = ? AND GOV_REGTR_FLAG = ? AND GOV_REGTR_NUM = ? "
					, 0, 0, 0);
					
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
	
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.NEW_DISJOINT_CHK_FIRM_NM, 30 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.NEW_DISJOINT_CHK_FIRM_CD, 10 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.NEW_DISJOINT_CHK_YMD	  , 8  +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.INST_YMD		      	  , 8  +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.DETA_LOC		      	  , 30 +1, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	          , 9  +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip		          , 15 +1, DECRYPT);

		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM		              , 12 +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.GOV_REGTR_FLAG	      , 2  +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGovinfo2.GOV_REGTR_NUM	          , 9  +1, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
	Finally:
		g_lGovFlag = 1;
		DelSqLite(sql);

		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : isValid
	��  �� : Validation
	Param  : 
	Return : 
	========================================================================================*/	
	bool isValid(void)
	{
		bool ret = TRUE;
		long nLen;
		long pLen ,qlen;
		char szTmp[10];
		char szToday[20];

		char strMsg[100];
		char strLen[100];
		char strNlen[100];
		
		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 )
		{
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM)), "") == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "�������˻縦 ������ �ּ���.");
				ret = FALSE;
				goto Finally;
			}
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));
		
			if( Str_Len(szTmp) < 8 )
			{
				MessageBoxEx(CONFIRM_OK, "������������ �Է��� �ּ���.");
				ret = FALSE;
				goto Finally;
			}
			
			Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
			Str_ItoA(Time_GetDate(), szToday, 10);
			
			if( Str_Cmp(szTmp, szToday) > 0 )
			{
				MessageBoxEx (CONFIRM_OK, "���� �������� ���ú��� Ů�ϴ�.");
				ret = FALSE;
				goto Finally;
			}
		}

		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DETA_LOC_2)));
		
		if(nLen > 30)
			{
				pLen = (nLen - 30) / 3;
				qlen = (nLen - 30);
				// PRINT("OOOO == %d" ,pLen,0,0);
				
				Mem_Set((byte *)strMsg      , 0x00, sizeof(strMsg));
				Mem_Set((byte *)strLen      , 0x00, sizeof(strLen));
				Mem_Set((byte *)strNlen      , 0x00, sizeof(strNlen));
				Str_ItoA(pLen,strLen,10);
				Str_ItoA(qlen,strNlen,10);

				
				Str_Cat(strMsg, "����ġ �Է°��� �ʹ� Ů�ϴ�.\n\n ");
				Str_Cat(strMsg, "�ѱ��� �ִ� 10���� ");
				Str_Cat(strMsg, "\n �� �ܴ� ");
				Str_Cat(strMsg, "30 ���ڷ� \n �Է����ּ���");
				
				
				MessageBoxEx(ERROR_OK, strMsg);

				ret = FALSE;
				return ret;
				
			}		

		
	Finally:
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Compare_Data
	��  �� : ���� �ڷ�� ��, �������� ������ TRUE
	Param  : 
	Return : 
	========================================================================================*/	
	bool Compare_Data(void)
	{
		bool ret = TRUE;
		long lChk = 0;
		char szTmp[20];
		
		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 )
		{
			// �������˻�
			if( Str_Cmp(m_stBsPress.NEW_DISJOINT_CHK_FIRM_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DJ_CHK_FIRM))) != 0 )
			{
				lChk++;
			}
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_YEAR_2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_MONTH_2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DJ_CHK_YMD_DATE_2)));
			
			// ����������
			if( Str_Cmp(m_stBsPress.NEW_DISJOINT_CHK_YMD, szTmp) != 0 )
			{
				lChk++;
			}
		}

		PRINT("DDDDDDDDDDDDDDDDDDDDD",0,0,0);
		PRINT("lChk : %d",lChk,0,0);
		
		// ����ġ
		if( Str_Cmp(m_stBsPress.DETA_LOC, szTmp) != 0 )
		{
			lChk++;
		}
		
		if( lChk > 0 )
		{
			ret = FALSE;
		}
		else
		{
			ret = TRUE;
		}
	
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : move_back
	��  �� : �ڷΰ���
	Param  : 
	Return : 
	========================================================================================*/	
	void move_back(void)
	{
		if( g_lGovInflowPath == 1 )
		{
			g_nWorkChkFlag = 40;
			g_lSCMoveFlag = 1;
			Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
			Str_Cpy(stBsNogood.CHK_SEC_CD, "21");
			Str_Cpy(stBsNogood.MTR_NUM, "");
			Str_Cpy(stBsNogood.BURNER_NUM, "");
			Str_Cpy(stBsNogood.CHK_SEC_NM, "���б�");
			Card_Move("CHK_BSDTL");
		}
		else
		{
			Card_Move("BS_CONFIRM");
		}
	}
	
	/*=======================================================================================
	�Լ��� : move_save
	��  �� : ���� �� �̵�
	Param  : 
	Return : 
	========================================================================================*/	
	void move_save(void)
	{
		if( g_lGovInflowPath == 1 )
		{
			g_nWorkChkFlag = 40;
			g_lSCMoveFlag = 1;
			Str_Cpy(stBsNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
			Str_Cpy(stBsNogood.CHK_SEC_CD, "21");
			Str_Cpy(stBsNogood.MTR_NUM, "");
			Str_Cpy(stBsNogood.BURNER_NUM, "");
			Str_Cpy(stBsNogood.CHK_SEC_NM, "���б�");
			Card_Move("CHK_BSDTL");
		}
		else
		{
			Card_Move("BS_START");
		}
	}
}
