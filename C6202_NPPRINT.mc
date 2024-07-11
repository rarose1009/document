/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_NPPRINT
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	#include "ArrayList.c"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_SCHDL )
		DEF_BUTTON_ID ( BID_CHECK1 )
		DEF_BUTTON_ID ( BID_CHECK2 )
		DEF_BUTTON_ID ( BID_CHECK3 )
		DEF_BUTTON_ID ( BID_CHECK4 )
		DEF_BUTTON_ID ( BID_PRINT )
		DEF_BUTTON_ID ( BID_PRINT2 )
		DEF_BUTTON_ID ( BID_OK )
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
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_BORDER )
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
				
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )

		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
		
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
	
	long m_lChkFlag = 0;  // 1 : �̳�������, 2 : ���ఢ��, 3 : ������, 4 : �ְ���
	long m_lEditCtrlIndex = -1;
	
	CARRAYLIST m_pList = NULL;
	bool m_bPrintAgain = FALSE;
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	long Snd_Print(void);
	long TR82208(void);
	long TR82208_PostProcess(void);
	void BillPrint(void);
	void* BillPrint_GetData(void);
	long Print_Result(void* p);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "ü������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,   STARTY+70, 1000, 70, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK1, "�� �̳� ������"),
		DLG_BUTTON(STARTX,  STARTY+150, 1000, 70, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK2, "�� ���ఢ��"),
		DLG_BUTTON(STARTX,  STARTY+230, 1000, 70, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK3, "�� ������"),
		DLG_BUTTON(STARTX,  STARTY+310, 1000, 70, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK4, "�� �ְ���"),
		
		DLG_BUTTON(STARTX+600,  STARTY+400, 400, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINT, "�� ��"),
		
		DLG_TEXT(STARTX,        STARTY-29, 400, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�������� ������"),
		DLG_EDIT(STARTX+400,    STARTY-29, 150, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+550,    STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+550,    STARTY+11,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA3, "."),
		DLG_EDIT(STARTX+570,    STARTY-29, 130, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+700,    STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+700,    STARTY+11,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA5, "."),
		DLG_EDIT(STARTX+720,    STARTY-29, 130, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+850,	STARTY-29, 150, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "��"),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "ü������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,   STARTY+70, 1000, 70, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK1, "�� �̳� ������"),
		DLG_BUTTON(STARTX,  STARTY+150, 1000, 70, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK2, "�� ���ఢ��"),
		DLG_BUTTON(STARTX,  STARTY+230, 1000, 70, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK3, "�� ������"),
		DLG_BUTTON(STARTX,  STARTY+310, 1000, 70, 0, 0, 0, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHECK4, "�� �ְ���"),
		
		DLG_BUTTON(STARTX+600,  STARTY+400, 400, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINT, "�� ��"),
		
		DLG_TEXT(STARTX,        STARTY-40, 400, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�������� ������"),
		DLG_EDIT(STARTX+400,    STARTY-40, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+550,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+550,       STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA3, "."),
		DLG_EDIT(STARTX+570,    STARTY-40, 130, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+700,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+700,       STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA5, "."),
		DLG_EDIT(STARTX+720,    STARTY-40, 130, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+850,	STARTY-40, 150, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "��"),
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
		long lCnt;
		
		switch (bFirst)
		{
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

				SetBtnImg();	
				SetStyle();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d, k;
		char sztmp[15];
		char szToday[15];
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		handle h;

		switch(ID)
		{
			case BID_SCHDL:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
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
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
					Str_ItoA ( d, sztmp, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)sztmp, 4);
					Mem_Cpy((byte *)szMonth, (byte *)sztmp+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)sztmp+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );					
				}
				break;
			case BID_CHECK1:
				m_lChkFlag = 1;
				
				ReDraw();
				break;
			case BID_CHECK2:
				m_lChkFlag = 2;
				
				ReDraw();
				break;
			case BID_CHECK3:
				m_lChkFlag = 3;

				ReDraw();
				break;
			case BID_CHECK4:
				m_lChkFlag = 4;
				
				ReDraw();
				break;

/*
			case BID_CHECK1:
				m_lChkFlag = 1;
				h = Get_hDlgCtrlByID(BID_CHECK1);
				ButCtrl_SetImage( h,  g_pImgChkOn);

				h = Get_hDlgCtrlByID(BID_CHECK2);
				ButCtrl_SetImage( h,  g_pImgChkOff);

				h = Get_hDlgCtrlByID(BID_CHECK3);
				ButCtrl_SetImage( h,  g_pImgChkOff);

				h = Get_hDlgCtrlByID(BID_CHECK4);
				ButCtrl_SetImage( h,  g_pImgChkOff);
				
				ReDraw();
				break;
			case BID_CHECK2:
				m_lChkFlag = 2;
				
				h = Get_hDlgCtrlByID(BID_CHECK1);
				ButCtrl_SetImage( h,  g_pImgChkOff);

				h = Get_hDlgCtrlByID(BID_CHECK2);
				ButCtrl_SetImage( h,  g_pImgChkOn);

				h = Get_hDlgCtrlByID(BID_CHECK3);
				ButCtrl_SetImage( h,  g_pImgChkOff);

				h = Get_hDlgCtrlByID(BID_CHECK4);
				ButCtrl_SetImage( h,  g_pImgChkOff);
				
				ReDraw();
				break;
			case BID_CHECK3:
				m_lChkFlag = 3;
				
				h = Get_hDlgCtrlByID(BID_CHECK1);
				ButCtrl_SetImage( h,  g_pImgChkOff);

				h = Get_hDlgCtrlByID(BID_CHECK2);
				ButCtrl_SetImage( h,  g_pImgChkOff);

				h = Get_hDlgCtrlByID(BID_CHECK3);
				ButCtrl_SetImage( h,  g_pImgChkOn);

				h = Get_hDlgCtrlByID(BID_CHECK4);
				ButCtrl_SetImage( h,  g_pImgChkOff);
				
				ReDraw();
				break;
			case BID_CHECK4:
				m_lChkFlag = 4;
				
				h = Get_hDlgCtrlByID(BID_CHECK1);
				ButCtrl_SetImage( h,  g_pImgChkOff);

				h = Get_hDlgCtrlByID(BID_CHECK2);
				ButCtrl_SetImage( h,  g_pImgChkOff);

				h = Get_hDlgCtrlByID(BID_CHECK3);
				ButCtrl_SetImage( h,  g_pImgChkOff);

				h = Get_hDlgCtrlByID(BID_CHECK4);
				ButCtrl_SetImage( h,  g_pImgChkOn);
				
				ReDraw();
				break;
*/
			case BID_PRINT:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �Ͻðڽ��ϱ�?")  == MB_OK)
				{
					Snd_Print();
				}
				break;
			case BID_OK:
				Card_Move("C6202_NPMANAGE");
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "ü�� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("C6202_MENU");
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
				Card_Move("C6202_NPMANAGE");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}		

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];
		char szDate[10];

		//���ڸ� �Է� ����
		if( (Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex 
		|| Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex
		|| Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
		&& (nChar < 48 ||  nChar > 57) )
		{
			MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
			ON_KEY( 5 );
			return;
		}

		//�����Ƿ�����
		if( Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 4 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 1);
			if( Str_AtoI(szTmp) > 1 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
			{
				ON_KEY( 5 );
				return;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) == 2 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 1);
			if( Str_AtoI(szTmp) > 3 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
			{
				ON_KEY( 5 );
				return;
			}
		}

		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		if( Str_Len(szTmp) == 8 )
		{
			Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
			nDate = Str_AtoI(szTmp);
			nRet = Time_ValidateDate(nDate);
			//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
			
			if( nRet == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ȿ�� ��¥�� �ƴմϴ�.\n��¥�� Ȯ�����ּ���.");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
				
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}

		ON_DRAW();
		return;
	}


	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		//EDITCTRL�� ACTIVE�ÿ� CTRLINDEX�� ����
		//Ű���� BUTTONCTRL�� ACTIVE�ÿ��� EDITCTRL�� Ŀ���� �α����ؼ� INDEX�� ����
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( POINTING_UP == nAction )
		{
			m_lEditCtrlIndex = lActiveIndex;
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+550) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+51) ||
					X > DMS_X(STARTX+570) && X < DMS_X(STARTX+700) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+51) ||
					X > DMS_X(STARTX+720) && X < DMS_X(STARTX+850) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+51) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
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
				
				ON_DRAW();
			}
		}
		
		return;
	}


//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
/*		
		h = Get_hDlgCtrlByID(BID_PRINT);
		ButCtrl_SetImage( h,  g_pImgCash);

		h = Get_hDlgCtrlByID(BID_PRINT2);
		ButCtrl_SetImage( h,  g_pImgCashDark);
		
		h = Get_hDlgCtrlByID(BID_CHECK1);
		ButCtrl_SetImage( h,  g_pImgChkOff);

		h = Get_hDlgCtrlByID(BID_CHECK2);
		ButCtrl_SetImage( h,  g_pImgChkOff);
		
		h = Get_hDlgCtrlByID(BID_CHECK3);
		ButCtrl_SetImage( h,  g_pImgChkOff);
		
		h = Get_hDlgCtrlByID(BID_CHECK4);
		ButCtrl_SetImage( h,  g_pImgChkOff);
*/
	}
	
//------------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
	}
	
//------------------------------------------------------------------	
	void ReDraw(void)
	{
		if( m_lChkFlag == 1 )
		{
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA1), FALSE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), FALSE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA3), FALSE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), FALSE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA5), FALSE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), FALSE );
			
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK1), "�� �̳� ������");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK2), "�� ���ఢ��");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK3), "�� ������");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK4), "�� �ְ���");
		}
		else if( m_lChkFlag == 2 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), "��������");
		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA1), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA3), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA5), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE );

			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK1), "�� �̳� ������");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK2), "�� ���ఢ��");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK3), "�� ������");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK4), "�� �ְ���");
		}
		else if( m_lChkFlag == 3 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), "�������� ������");
		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA1), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA3), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA5), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE );

			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK1), "�� �̳� ������");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK2), "�� ���ఢ��");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK3), "�� ������");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK4), "�� �ְ���");
		}
		else if( m_lChkFlag == 4 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), "���� ������");
		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA1), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA3), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA5), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE );

			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK1), "�� �̳� ������");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK2), "�� ���ఢ��");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK3), "�� ������");
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHECK4), "�� �ְ���");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), "�������� ������");
		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA1), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA3), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA5), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE );
		}
	}
	
	
//------------------------------------------------------------------	
	long Snd_Print(void)
	{
		char szTmp[256];
		char szUrl[200];
		char szbuf[128];
		char szPlanDate[30];
		char szDate[30];
		char szToday[30];
		char szTime[30];
		char szYear[10];
		char szMonth[10];
		char szDay[10];
		char szHour[10];
		char szMin[10];
		char szActiveFlag[10];
		char szPubshYn_1[5];
		char szPubshYn_2[5];
		char szPubshYn_3[5];
		char szActiveRsltDesc[200];
		char szTakerNm[30];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;

		Mem_Set((byte*)szPlanDate, 0x00, sizeof(szPlanDate));
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Str_Cpy(szYear, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cpy(szMonth, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cpy(szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		
		Str_Cpy(szPlanDate, szYear);
		Str_Cat(szPlanDate, szMonth);
		Str_Cat(szPlanDate, szDay);
		if( (Str_Cmp(szPlanDate, "") == 0 || Str_Len(szPlanDate) == 0) && m_lChkFlag > 1 )
		{
			MessageBoxEx(CONFIRM_OK, "���ڸ� ������ �ּ���.");
			return -1;
		}
		if( m_lChkFlag == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "���౸���� ���� ���ּ���.");
			return -1;
		}
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		if( m_lChkFlag == 1 )
		{
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Mem_Set((byte*)szHour, 0x00, sizeof(szHour));
			Mem_Set((byte*)szMin, 0x00, sizeof(szMin));
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Mem_Set((byte*)szTime, 0x00, sizeof(szTime));
			Str_ItoA(Time_GetDate(), szDate, 10);
			//Str_ItoA(Time_GetTime(), szTime, 10);
			g_Str_TimeType( szTime , Time_GetTime());
			Str_Chg(szTime, STRCHG_DEL_NONDIGIT);
			
			Mem_Cpy( (byte*)szYear, (byte*)szDate, 4);
			Mem_Cpy( (byte*)szMonth, (byte*)szDate+4, 2);
			Mem_Cpy( (byte*)szDay, (byte*)szDate+6, 2);
			Mem_Cpy( (byte*)szHour, (byte*)szTime, 2);
			Mem_Cpy( (byte*)szMin, (byte*)szTime+2, 2);
			
			SPRINT(szTmp, "%s��%s��%s�� ",szYear,szMonth,szDay);
			Str_Cat(szTmp, szHour);
			Str_Cat(szTmp, ":");
			Str_Cat(szTmp, szMin);
			Str_Cat(szTmp, " ���Կ��� �̳��ȳ�.");
			
			Mem_Set((byte*)szActiveFlag, 0x00, sizeof(szActiveFlag));
			Mem_Set((byte*)szPubshYn_1, 0x00, sizeof(szPubshYn_1));
			Mem_Set((byte*)szPubshYn_2, 0x00, sizeof(szPubshYn_2));
			Mem_Set((byte*)szPubshYn_3, 0x00, sizeof(szPubshYn_3));
			Str_Cpy(szActiveFlag, "360");
			Str_Cpy(szPubshYn_1, "N");
			Str_Cpy(szPubshYn_2, "N");
			Str_Cpy(szPubshYn_3, "N");
		}
		else if( m_lChkFlag == 2 )
		{
			SPRINT(szTmp, "%s��%s��%s�� ",szYear,szMonth,szDay);
			Str_Cat(szTmp, "���� ���ο��� (Ȯ�༭ ¡��).");

			Mem_Set((byte*)szActiveFlag, 0x00, sizeof(szActiveFlag));
			Mem_Set((byte*)szPubshYn_1, 0x00, sizeof(szPubshYn_1));
			Mem_Set((byte*)szPubshYn_2, 0x00, sizeof(szPubshYn_2));
			Mem_Set((byte*)szPubshYn_3, 0x00, sizeof(szPubshYn_3));
			Str_Cpy(szActiveFlag, "340");
			Str_Cpy(szPubshYn_1, "N");
			Str_Cpy(szPubshYn_2, "Y");
			Str_Cpy(szPubshYn_3, "N");
		}
		else if( m_lChkFlag == 3 )
		{
			SPRINT(szTmp, "%s��%s��%s�� ",szYear,szMonth,szDay);
			Str_Cat(szTmp, "���� ��������.");

			Mem_Set((byte*)szActiveFlag, 0x00, sizeof(szActiveFlag));
			Mem_Set((byte*)szPubshYn_1, 0x00, sizeof(szPubshYn_1));
			Mem_Set((byte*)szPubshYn_2, 0x00, sizeof(szPubshYn_2));
			Mem_Set((byte*)szPubshYn_3, 0x00, sizeof(szPubshYn_3));
			Str_Cpy(szActiveFlag, "310");
			Str_Cpy(szPubshYn_1, "Y");
			Str_Cpy(szPubshYn_2, "N");
			Str_Cpy(szPubshYn_3, "N");
		}
		else if( m_lChkFlag == 4 )
		{
			SPRINT(szTmp, "%s��%s��%s�� ",szYear,szMonth,szDay);
			Str_Cat(szTmp, "���� ���� �ְ��� ����.");

			Mem_Set((byte*)szActiveFlag, 0x00, sizeof(szActiveFlag));
			Mem_Set((byte*)szPubshYn_1, 0x00, sizeof(szPubshYn_1));
			Mem_Set((byte*)szPubshYn_2, 0x00, sizeof(szPubshYn_2));
			Mem_Set((byte*)szPubshYn_3, 0x00, sizeof(szPubshYn_3));
			Str_Cpy(szActiveFlag, "350");
			Str_Cpy(szPubshYn_1, "N");
			Str_Cpy(szPubshYn_2, "N");
			Str_Cpy(szPubshYn_3, "Y");
		}
		
		//JOB_DTM
		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Mem_Set((byte*)szHour, 0x00, sizeof(szHour));
		Mem_Set((byte*)szTime, 0x00, sizeof(szTime));
		Str_ItoA(Time_GetDate(), szDate, 10);
		//Str_ItoA(Time_GetTime(), szHour, 10);
		g_Str_TimeType( szTime , Time_GetTime());
		Str_Chg(szTime, STRCHG_DEL_NONDIGIT);
		Str_Cat(szDate, szTime);

		//nonpay_active_ymd
		Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
		Str_ItoA(Time_GetDate(), szToday, 10);
		//active_rslt_desc
		Mem_Set((byte*)szActiveRsltDesc, 0x00, sizeof(szActiveRsltDesc));
		SQL_ConvUcStr(szActiveRsltDesc, szTmp);
		//taker_nm
		Mem_Set((byte*)szTakerNm, 0x00, sizeof(szTakerNm));
		SQL_ConvUcStr(szTakerNm, stUserinfo.sznm_kor);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82208, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "job_dtm",                  szDate                              );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",             stNoPayObj.USE_CONT_NUM             );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_ymd",        szToday                             );
		JSON_SetValue( g_pjcomm, 'C', "active_success_yn",        "Y"                                 );
		JSON_SetValue( g_pjcomm, 'C', "pay_plan_ymd",             szPlanDate                          );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_flag",       szActiveFlag                        );
		JSON_SetValue( g_pjcomm, 'C', "pda_pubsh_yn_1",           szPubshYn_1                         );
		JSON_SetValue( g_pjcomm, 'C', "pda_pubsh_yn_2",           szPubshYn_2                         );
		JSON_SetValue( g_pjcomm, 'C', "pda_pubsh_yn_3",           szPubshYn_3                         );
		JSON_SetValue( g_pjcomm, 'C', "active_rslt_desc",         szActiveRsltDesc                    );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_dept",       stNoPayObj.NONPAY_ACTIVE_DEPT       );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone",       stNoPayObj.NONPAY_MANAGE_ZONE       );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_center_cd",         stUserinfo.szcenter_cd              );
		JSON_SetValue( g_pjcomm, 'C', "taker_nm",                 szTakerNm                           );

		sndbuf = JSON_toString(g_pjcomm);
		
		//���۵����� Ȯ��
		//g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR82208; //��ſϷ� �Ŀ� ȣ�� �Լ�
		HTTP_DownloadData( szUrl, "FR82208_IN",  "FR82208" , sndbuf, szbuf );

		return 1;
	}
	
	//------------------------------------------------------------------
	long TR82208(void)
	{
		if(g_Chk_Json(82208) >= 0)
		{
			BillPrint();
				
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

	//------------------------------------------------------------------
	long TR82208_PostProcess(void)
	{
		char szSql[350];

		//g_nWorkFlag = 830 > ����Ȱ��
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		if( g_nWorkFlag == 830 )
		{
			SPRINT(szSql, "UPDATE C6202_STOP_OBJ SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
			g_Sql_DirectExecute(szSql);
		}
		else if( g_nWorkFlag == 810 )
		{
			//����Ȱ�� ���
			SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ_PART SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
			g_Sql_DirectExecute(szSql);
		}
		else
		{
			SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
			g_Sql_DirectExecute(szSql);
		}
		
		Str_Cpy(stNoPayObj.VISIT_FLAG, "Y");

		Card_Move("C6202_NPMANAGE");
		
		return 0;
	}

	//------------------------------------------------------------------
	long Print_Result(void* p)
	{
		long* pRet = (long*)p;
		long nRet = *pRet;
	
		PRINT("%s", g_Printer_GetLastError(nRet),0,0);
	
		if( MessageBoxEx (CONFIRM_YESNO, "������ ������ �ߵǾ����ϱ�?") == MB_OK )
		{
			;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "����� �Ͻðڽ��ϱ�?") == MB_OK )
			{
				m_bPrintAgain = TRUE;
			
				BillPrint();
				return 0;
			}
		}	

		m_bPrintAgain = FALSE;
		
		if (m_pList)
		{
			DelArrayList(m_pList);
			m_pList = NULL;
			g_printerCallBack = NULL;
		}

		TR82208_PostProcess();

		return 0;
	}	

	//------------------------------------------------------------------
	void BillPrint(void)
	{
		if (m_bPrintAgain == FALSE)
		{
		  callBackfunc = NULL;
			m_pList = BillPrint_GetData();
		}
		
		g_Printer_Start(m_pList, (void*)Print_Result);
	}
	
	//------------------------------------------------------------------
	void* BillPrint_GetData(void)
	{
		bool bRet = FALSE;
		long i, j, ret, lCnt;
		long lUnpayAmt = 0;
		long lLoopCnt = 0;
		long lAddrFlag = 0; //lAddrFlag = 0 ���ּ� ���� ����, lAddrFlag = 1 ���ּ� ���� ����.
		char LineSpace[]={0x1b,0x20,0x00};
		char sztmp[1000];
		char szBuf[150];
		char szMsg[150];
		char szMoney[30];
		char szFirstNm[20];
		char szLastNm[20];
		char szPlanDate[30];
		char szYear[10];
		char szMonth[10];
		char szDay[10];
		CARRAYLIST list = NULL;

		list = NewArrayList();
		if (list == NULL)
		{
			return NULL;
		}

		if( m_lChkFlag == 1 )
		{
			list->append(list, "--------------------------------");
			list->append(list, "       �̳����� ���ξȳ�        ");
			list->append(list, "--------------------------------");
			list->append(list, " �� ��(����)���� ����Ͻð� �ִ�");
			list->append(list, "���ð������ᰡ �̳��Ǿ� ����  ");
			list->append(list, "�ȳ��Ͽ��� �ش� �Ա�������·�  ");
			list->append(list, "���� �Ǵ� �Ʒ� ����ó�� �Աݹ���");
			list->append(list, "�Ͻñ� �ٶ��ϴ�.                ");
			list->append(list, "--------------------------------");
			
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)szFirstNm, 0x00, sizeof(szFirstNm));
			Mem_Set((byte*)szLastNm, 0x00, sizeof(szLastNm));
			if( Str_Len(stNoPayObj.CUST_NM) < 6 )
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				
				Str_Cpy(szBuf, "�� �� �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "***");
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			else if( Str_Len(stNoPayObj.CUST_NM) > 4 && Str_Len(stNoPayObj.CUST_NM) < 8)
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+4, 2);
				
				Str_Cpy(szBuf, "�� �� �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "***");
				Str_Cat(szBuf, szLastNm);
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			else if( Str_Len(stNoPayObj.CUST_NM) > 6 && Str_Len(stNoPayObj.CUST_NM) < 10 )
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+6, 2);
	
				Str_Cpy(szBuf, "�� �� �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "******");
				Str_Cat(szBuf, szLastNm);
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			else if( Str_Len(stNoPayObj.CUST_NM) > 8 && Str_Len(stNoPayObj.CUST_NM) < 12 )
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+8, 2);
	
				Str_Cpy(szBuf, "�� �� �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "******");
				Str_Cat(szBuf, szLastNm);
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "�� ȣ �� : ");
			Str_Cat(sztmp, stNoPayObj.FIRM_NM);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
			Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.CUST_NUM, 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.CUST_NUM+5, 5);
			Str_Cpy(sztmp, "����ȣ : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
			Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.USE_CONT_NUM, 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.USE_CONT_NUM+5, 5);
			Str_Cpy(sztmp, "����ȣ : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
				
			if( Str_Len(stNoPayObj.CO_LIVE_NM) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "�����ּ� : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.TOWN);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.ADDR1_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.ADDR1_S);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.CO_LIVE_NM);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.BLD_NM);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.HOSU);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "���θ��ּ� : ");
					Str_Cat(sztmp, stNoPayObj.CITY);
					Str_Cat(sztmp, " ");
					Str_Cat(sztmp, stNoPayObj.AREA);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "�����ּ� : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.TOWN);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.ADDR1_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.ADDR1_S);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "���θ��ּ� : ");
					Str_Cat(sztmp, stNoPayObj.CITY);
					Str_Cat(sztmp, " ");
					Str_Cat(sztmp, stNoPayObj.AREA);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			
			list->append(list, "--------------------------------");
			list->append(list, "�Ա��������\n");
			
			g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_ACCOUNT", &lCnt );
			for( i = 0 ; i < lCnt ; i++ )
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
				SPRINT(szMsg, "%d.����� : ", (i+1),0,0);
			
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM2 FROM RCV_NONPAY_ACCOUNT LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 30, szBuf);
				
				Str_Cat(szMsg, szBuf);
				g_Line_Print(list, szMsg,"","",LEFT,0);
				
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM1 FROM RCV_NONPAY_ACCOUNT LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 30, szBuf);
				
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
				SPRINT(szMsg, "  ���¹�ȣ : ", 0,0,0);
				Str_Cat(szMsg, szBuf);
				g_Line_Print(list, szMsg,"","",LEFT,0);
			}
			
//			list->append(list, "KT ��ȭ��ü : 060-7088-114       ");
//			list->append(list, "   [������ �߻� �� ���κδ�]    ");
			list->append(list, "--------------------------------");
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_ItoA(Time_GetDate(), szBuf, 10);
			Mem_Cpy((byte *)szMsg, (byte *)szBuf, 4);
			Str_Cpy(sztmp, "�̳�����(");
			Str_Cat(sztmp, szMsg);
			
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+4, 2);
			Str_Cat(sztmp, ".");
			Str_Cat(sztmp, szMsg);			

			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+6, 2);
			Str_Cat(sztmp, ".");
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "����)");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "--------------------------------");
			g_Line_Print(list, "����","��뷮","�̳��ݾ�",CENTER,17);
			
			g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &lCnt );
			for( i = 0 ; i < lCnt ; i++ )
			{
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM1 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 20, szBuf);
				
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
				SPRINT( sztmp, "SELECT PARAM10 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 20, szMsg);

				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
				SPRINT( sztmp, "SELECT PARAM4 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 20, szMoney);
				lUnpayAmt = Str_AtoI(szMoney) + lUnpayAmt;
				Str_Chg(szMoney, STRCHG_INS_COMMA);
				Str_Cat(szMoney, "��");
				
				g_Line_Print(list, szBuf,szMsg,szMoney,CENTER,17);
			}
		
			list->append(list, "--------------------------------");
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
			Str_ItoA(lUnpayAmt, szMoney, 10);
			Str_Chg(szMoney, STRCHG_INS_COMMA);
			SPRINT(sztmp, "�̳��ݾ� �� :  %s��",szMoney,0,0);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "--------------------------------");
			list->append(list, "�Ѽ��ﵵ�ð��� �ݼ���           ");
			list->append(list, "  �� 02)810-8000                ");
			list->append(list, "  �� 1588-5788                  ");
			list->append(list, "                                ");
			list->append(list, "                                ");
		}
		else if( m_lChkFlag == 2 )
		{
			Mem_Set((byte*)szPlanDate, 0x00, sizeof(szPlanDate));
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Str_Cpy(szYear, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cpy(szMonth, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			
			Str_Cpy(szPlanDate, szYear);
			Str_Cat(szPlanDate, szMonth);
			Str_Cat(szPlanDate, szDay);
			
			if( g_lNpChkFlag == 1 )
			{
				Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
				g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM", 20, szMoney);
				Str_Chg(szMoney, STRCHG_INS_COMMA);
			}
			else
			{
				Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
				g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_REQYM", 20, szMoney);
				Str_Chg(szMoney, STRCHG_INS_COMMA);
			}

			list->append(list, "--------------------------------");
			list->append(list, "          �������ఢ��          ");
			list->append(list, "--------------------------------");
			list->append(list, "1. ������ �ͻ�κ��� ���ð����� \n");

			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cpy(sztmp, "���޹޾� ����� ");

			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_ItoA(Time_GetDate(), szBuf, 10);
			Mem_Cpy((byte *)szMsg, (byte *)szBuf, 4);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "��");
			
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+4, 2);
			Str_Cat(sztmp, szMsg);			
			Str_Cat(sztmp, "��");
			
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+6, 2);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "�� ");
			g_Line_Print(list, sztmp,"","",LEFT,0);

			list->append(list, "���� �̳���(��ü)�� ���ð���\n");
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			SPRINT(sztmp, "��� %s���� �Ʒ��� ��ȯ��",szMoney,0,0);
			g_Line_Print(list, sztmp,"","",LEFT,0);


//			list->append(list, "--------------------------------");
			list->append(list, "ȹ�� ���� ��������ϸ�,���� ��");
			list->append(list, "�ð��� ������ ��ݿ� ���Ͽ���\n");
			list->append(list, "�� ���⳻�� ������ ���� �� ����\n");
			list->append(list, "Ȯ���ϸ� ���� ������ �� ���ఢ��");
			list->append(list, "�� ������ ������ �� �ÿ��� ����\n");
			list->append(list, "�ߴ�, ä�������� ��� �� ��翡\n");
			list->append(list, "�� ��� ������ġ�� ���Ͽ���,\n");
			list->append(list, "������� ���Ǹ� �������� ���� ��\n");
			list->append(list, "�� Ȯ���ϸ�, �� ���ఢ���� �ۼ�\n");
			list->append(list, "�����մϴ�.\n");

			list->append(list, "                                ");
			list->append(list, "2. Ȯ��� ������ + 7�ϱ��� ����\n");
			list->append(list, "���� ���� ��� ä�������� ���\n");
			list->append(list, "���� ��������. \n");

			list->append(list, "--------------------------------");
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cpy(sztmp,"��ȯ��ȹ(");
			Str_Cat(sztmp, szYear);
			Str_Cat(sztmp, ".");
			Str_Cat(sztmp, szMonth);
			Str_Cat(sztmp, ".");
			Str_Cat(sztmp, szDay);
			Str_Cat(sztmp, " ����) �̳���");
			g_Line_Print(list, sztmp,"","",LEFT,0);

			g_Line_Print(list, "����","�̳��ݾ�","��������",CENTER,18);
			
			if( g_lNpChkFlag == 1 )
			{
				g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &lCnt );
				for( i = 0 ; i < lCnt ; i++ )
				{
					Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					SPRINT( sztmp, "SELECT PARAM1 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
					g_Sql_RetStr(sztmp, 20, szBuf);
					
					Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
					Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
					SPRINT( sztmp, "SELECT PARAM4 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
					g_Sql_RetStr(sztmp, 20, szMoney);
					Str_Chg(szMoney, STRCHG_INS_COMMA);
					Str_Cat(szMoney, "��");
					
					Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
					g_Str_DateType(szMsg, szPlanDate);
					g_Line_Print(list, szBuf,szMoney,szMsg,CENTER,18);
				}
			}
			else
			{
				g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_REQYM", &lCnt );
				for( i = 0 ; i < lCnt ; i++ )
				{
					Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					SPRINT( sztmp, "SELECT PARAM1 FROM RCV_NONPAY_REQYM LIMIT %d, 1", i, 0, 0 );
					g_Sql_RetStr(sztmp, 20, szBuf);
					
					Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
					Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
					SPRINT( sztmp, "SELECT PARAM4 FROM RCV_NONPAY_REQYM LIMIT %d, 1", i, 0, 0 );
					g_Sql_RetStr(sztmp, 20, szMoney);
					Str_Chg(szMoney, STRCHG_INS_COMMA);
					Str_Cat(szMoney, "��");
					
					Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
					g_Str_DateType(szMsg, szPlanDate);
					g_Line_Print(list, szBuf,szMoney,szMsg,CENTER,18);
				}
			}

			list->append(list, "--------------------------------");

			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
			Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.CUST_NUM, 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.CUST_NUM+5, 5);
			Str_Cpy(sztmp, "����ȣ : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
			Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.USE_CONT_NUM, 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.USE_CONT_NUM+5, 5);
			Str_Cpy(sztmp, "����ȣ : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			if( Str_Len(stNoPayObj.CO_LIVE_NM) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "�����ּ� : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.TOWN);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.ADDR1_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.ADDR1_S);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.CO_LIVE_NM);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.BLD_NM);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.HOSU);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "���θ��ּ� : ");
					Str_Cat(sztmp, stNoPayObj.CITY);
					Str_Cat(sztmp, " ");
					Str_Cat(sztmp, stNoPayObj.AREA);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "�����ּ� : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.TOWN);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.ADDR1_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.ADDR1_S);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "���θ��ּ� : ");
					Str_Cat(sztmp, stNoPayObj.CITY);
					Str_Cat(sztmp, " ");
					Str_Cat(sztmp, stNoPayObj.AREA);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "�� ȣ �� : ");
			Str_Cat(sztmp, stNoPayObj.FIRM_NM);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "�� �� ó : ");
			Str_Cat(sztmp, stNoPayObj.OWNHOUSE_TEL_DDD);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.OWNHOUSE_TEL_EXN);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.OWNHOUSE_TEL_NUM);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)szFirstNm, 0x00, sizeof(szFirstNm));
			Mem_Set((byte*)szLastNm, 0x00, sizeof(szLastNm));
			if( Str_Len(stNoPayObj.CUST_NM) < 6 )
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				
				Str_Cpy(szBuf, "��    �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "***");
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			else if( Str_Len(stNoPayObj.CUST_NM) > 4 && Str_Len(stNoPayObj.CUST_NM) < 8)
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+4, 2);
				
				Str_Cpy(szBuf, "��    �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "***");
				Str_Cat(szBuf, szLastNm);
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			else if( Str_Len(stNoPayObj.CUST_NM) > 6 && Str_Len(stNoPayObj.CUST_NM) < 10 )
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+6, 2);
	
				Str_Cpy(szBuf, "��    �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "******");
				Str_Cat(szBuf, szLastNm);
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			else if( Str_Len(stNoPayObj.CUST_NM) > 8 && Str_Len(stNoPayObj.CUST_NM) < 12 )
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+8, 2);
	
				Str_Cpy(szBuf, "��    �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "******");
				Str_Cat(szBuf, szLastNm);
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			
			list->append(list, "                          ����  ");
			list->append(list, "--------------------------------");
			list->append(list, "�Ա��������\n");
			
			g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_ACCOUNT", &lCnt );
			for( i = 0 ; i < lCnt ; i++ )
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
				SPRINT(szMsg, "%d.����� : ", (i+1),0,0);
			
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM2 FROM RCV_NONPAY_ACCOUNT LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 30, szBuf);
				
				Str_Cat(szMsg, szBuf);
				g_Line_Print(list, szMsg,"","",LEFT,0);
				
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM1 FROM RCV_NONPAY_ACCOUNT LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 30, szBuf);
				
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
				SPRINT(szMsg, "  ���¹�ȣ : ", 0,0,0);
				Str_Cat(szMsg, szBuf);
				g_Line_Print(list, szMsg,"","",LEFT,0);
			}

			list->append(list, "                                ");
			list->append(list, "                                ");
		}
		else if( m_lChkFlag == 3 )
		{
			list->append(list, "--------------------------------");
			list->append(list, "   ���ð��� �������� ������     ");
			list->append(list, "--------------------------------");
			
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
			Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.CUST_NUM, 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.CUST_NUM+5, 5);
			Str_Cpy(sztmp, "����ȣ : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			if( Str_Len(stNoPayObj.CO_LIVE_NM) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "�����ּ� : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.TOWN);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.ADDR1_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.ADDR1_S);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.CO_LIVE_NM);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.BLD_NM);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.HOSU);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "���θ��ּ� : ");
					Str_Cat(sztmp, stNoPayObj.CITY);
					Str_Cat(sztmp, " ");
					Str_Cat(sztmp, stNoPayObj.AREA);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "�����ּ� : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.TOWN);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.ADDR1_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.ADDR1_S);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "���θ��ּ� : ");
					Str_Cat(sztmp, stNoPayObj.CITY);
					Str_Cat(sztmp, " ");
					Str_Cat(sztmp, stNoPayObj.AREA);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			
			list->append(list, "�� ��(����)���� ����Ͻð� �ִ�\n");
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_ItoA(Time_GetDate(), szBuf, 10);
			Mem_Cpy((byte *)szMsg, (byte *)szBuf, 4);
			Str_Cpy(sztmp, "���ð��� ����� ");
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "��");
			
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+4, 2);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "��");

			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+6, 2);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "��");
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
			g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM", 20, szMoney);
			Str_Chg(szMoney, STRCHG_INS_COMMA);
			Str_Cpy(sztmp, "����� ");
			Str_Cat(sztmp, szMoney);
			Str_Cat(sztmp, "���� ü���Ǿ�");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "���� �����Ͽ��� ������ �����Ͽ�\n");
			list->append(list, "�ֽñ� �ٶ��ϴ�. �������� ������");
			list->append(list, "������ �����Ͻ��� ���� ��� Ư��");
			list->append(list, "�� ������ ���� �� ���ޱ����� ��");
			list->append(list, "�� �ε��� ���ð��� ������ �ߴܵ�");
			list->append(list, "���� ���� �����Ͽ� �ֽñ� �ٶ���");
			list->append(list, "��. ����, �������� ������ġ ����");
			list->append(list, "�� ��� �ÿ��� ���ޱ����� �ǰ�\n");
			list->append(list, "�����ݿ�ġ �Ǵ� �������迡 ����\n");
			list->append(list, "�ϼž߸� ���������� �����ϸ� ü\n");
			list->append(list, "������ ���Ͽ� ���νſ�� ������\n");
			list->append(list, "�� ���Ҽ� ������ �˷��帳�ϴ�.\n");

			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set((byte*)szPlanDate, 0x00, sizeof(szPlanDate));
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Str_Cpy(szYear, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cpy(szMonth, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Cpy(szPlanDate, szYear);
			Str_Cat(szPlanDate, szMonth);
			Str_Cat(szPlanDate, szDay);

			Str_Cpy(sztmp, "�������������� : ");
			Str_Cat(sztmp, szYear);
			Str_Cat(sztmp, "��");
			Str_Cat(sztmp, szMonth);
			Str_Cat(sztmp, "��");
			Str_Cat(sztmp, szDay);
			Str_Cat(sztmp, "��");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "\n");
			list->append(list, "--------------------------------");
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_ItoA(Time_GetDate(), szBuf, 10);
			Mem_Cpy((byte *)szMsg, (byte *)szBuf, 4);
			Str_Cpy(sztmp, "�̳�����(");
			Str_Cat(sztmp, szMsg);
			
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+4, 2);
			Str_Cat(sztmp, ".");
			Str_Cat(sztmp, szMsg);			

			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+6, 2);
			Str_Cat(sztmp, ".");
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "����)");
			g_Line_Print(list, sztmp,"","",LEFT,0);

			list->append(list, "--------------------------------");
			g_Line_Print(list, "����","��뷮","�̳��ݾ�",CENTER,17);
			
			g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &lCnt );
			for( i = 0 ; i < lCnt ; i++ )
			{
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM1 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 20, szBuf);
				
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
				SPRINT( sztmp, "SELECT PARAM10 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 20, szMsg);

				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
				SPRINT( sztmp, "SELECT PARAM4 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 20, szMoney);
				lUnpayAmt = Str_AtoI(szMoney) + lUnpayAmt;
				Str_Chg(szMoney, STRCHG_INS_COMMA);
				Str_Cat(szMoney, "��");
				
				g_Line_Print(list, szBuf,szMsg,szMoney,CENTER,17);
			}

			list->append(list, "--------------------------------");

			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
			g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM", 20, szMoney);
			Str_Chg(szMoney, STRCHG_INS_COMMA);
			Str_Cpy(sztmp, "�̳��ݾ� �� :  ");
			Str_Cat(sztmp, szMoney);
			Str_Cat(sztmp, "��");
			g_Line_Print(list, sztmp,"","",LEFT,0);

			list->append(list, "--------------------------------");
			list->append(list, "�Ա��������\n");

			g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_ACCOUNT", &lCnt );
			for( i = 0 ; i < lCnt ; i++ )
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
				SPRINT(szMsg, "%d.����� : ", (i+1),0,0);
			
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM2 FROM RCV_NONPAY_ACCOUNT LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 30, szBuf);
				
				Str_Cat(szMsg, szBuf);
				g_Line_Print(list, szMsg,"","",LEFT,0);
				
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM1 FROM RCV_NONPAY_ACCOUNT LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 30, szBuf);
				
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
				SPRINT(szMsg, "  ���¹�ȣ : ", 0,0,0);
				Str_Cat(szMsg, szBuf);
				g_Line_Print(list, szMsg,"","",LEFT,0);
			}

//			list->append(list, "KT ��ȭ��ü : 060-7088-114       ");
//			list->append(list, "   [������ �߻� �� ���κδ�]    ");
			list->append(list, "--------------------------------");
			list->append(list, "�Ѽ��ﵵ�ð��� �ݼ���           ");
			list->append(list, "  �� 02)810-8000                ");
			list->append(list, "  �� 1588-5788                  ");

			list->append(list, "                                ");
			list->append(list, "                                ");
		}
		else if( m_lChkFlag == 4 )
		{
			list->append(list, "--------------------------------");
			list->append(list, "    �� �� ��(���ð������)      ");
			list->append(list, "--------------------------------");

			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
			Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.CUST_NUM, 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.CUST_NUM+5, 5);
			Str_Cpy(sztmp, "����ȣ : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
			Mem_Cpy( (byte*)szBuf, (byte*)stNoPayObj.USE_CONT_NUM, 5);
			Mem_Cpy( (byte*)szMsg, (byte*)stNoPayObj.USE_CONT_NUM+5, 5);
			Str_Cpy(sztmp, "����ȣ : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, szMsg);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			if( Str_Len(stNoPayObj.CO_LIVE_NM) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "�����ּ� : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.TOWN);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.ADDR1_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.ADDR1_S);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.CO_LIVE_NM);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.BLD_NM);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.HOSU);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "���θ��ּ� : ");
					Str_Cat(sztmp, stNoPayObj.CITY);
					Str_Cat(sztmp, " ");
					Str_Cat(sztmp, stNoPayObj.AREA);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "�����ּ� : ");
				Str_Cat(sztmp, stNoPayObj.CITY);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.AREA);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.TOWN);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.ADDR1_M);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stNoPayObj.ADDR1_S);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stNoPayObj.DETAIL_FLOOR);
				g_Line_Print(list, sztmp,"","",LEFT,0);
	
				if( Str_Len(stNoPayObj.NEW_ROAD_NM) > 0 )
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "���θ��ּ� : ");
					Str_Cat(sztmp, stNoPayObj.CITY);
					Str_Cat(sztmp, " ");
					Str_Cat(sztmp, stNoPayObj.AREA);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ROAD_NM);
					g_Line_Print(list, sztmp,"","",LEFT,0);
	
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, "             ");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_M);
					Str_Cat(sztmp, "-");
					Str_Cat(sztmp, stNoPayObj.NEW_ADDR_S);
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "�� ȣ �� : ");
			Str_Cat(sztmp, stNoPayObj.FIRM_NM);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "�� �� ó : ");
			Str_Cat(sztmp, stNoPayObj.OWNHOUSE_TEL_DDD);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.OWNHOUSE_TEL_EXN);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stNoPayObj.OWNHOUSE_TEL_NUM);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			Mem_Set((byte*)szFirstNm, 0x00, sizeof(szFirstNm));
			Mem_Set((byte*)szLastNm, 0x00, sizeof(szLastNm));
			if( Str_Len(stNoPayObj.CUST_NM) < 6 )
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				
				Str_Cpy(szBuf, "��    �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "***");
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			else if( Str_Len(stNoPayObj.CUST_NM) > 4 && Str_Len(stNoPayObj.CUST_NM) < 8)
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+4, 2);
				
				Str_Cpy(szBuf, "��    �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "***");
				Str_Cat(szBuf, szLastNm);
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			else if( Str_Len(stNoPayObj.CUST_NM) > 6 && Str_Len(stNoPayObj.CUST_NM) < 10 )
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+6, 2);
	
				Str_Cpy(szBuf, "��    �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "******");
				Str_Cat(szBuf, szLastNm);
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			else if( Str_Len(stNoPayObj.CUST_NM) > 8 && Str_Len(stNoPayObj.CUST_NM) < 12 )
			{
				Mem_Cpy( (byte*)szFirstNm, (byte*)stNoPayObj.CUST_NM, 2);
				Mem_Cpy( (byte*)szLastNm, (byte*)stNoPayObj.CUST_NM+8, 2);
	
				Str_Cpy(szBuf, "��    �� : ");
				Str_Cat(szBuf, szFirstNm);
				Str_Cat(szBuf, "******");
				Str_Cat(szBuf, szLastNm);
	
				g_Line_Print(list, szBuf,"","",LEFT,0);
			}
			
			list->append(list, "1. �� ��(����)���� ����ϰ��ִ�\n");

			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_ItoA(Time_GetDate(), szBuf, 10);
			Mem_Cpy((byte *)szMsg, (byte *)szBuf, 4);
			Str_Cpy(sztmp, "���ð�������� ");
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "��");
			
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+4, 2);
			Str_Cat(sztmp, szMsg);			
			Str_Cat(sztmp, "��");
			
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+6, 2);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "�� ");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
			g_Sql_RetStr("SELECT SUM(PARAM4) FROM RCV_NONPAY_MTRREQYM", 20, szMoney);
			Str_Chg(szMoney, STRCHG_INS_COMMA); 
			Str_Cpy(sztmp, "����� ");
			Str_Cat(sztmp, szMoney);
			Str_Cat(sztmp, "�� �� �Ʒ��� ����");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			g_Line_Print(list, "ü���Ǿ� �ֽ��ϴ�.","","",LEFT,0);

			list->append(list, "                                ");
			list->append(list, "2. �׵��� ��ݰ��� �Ա��� ��Ź��");
			list->append(list, "�������� �ұ��ϰ� ���ݱ��� ����\n");
			list->append(list, "�� �����ʾ� �� �ְ����� �뺸�ϰ�");
			list->append(list, "���� ���� ���������� �����ϸ�,\n");

			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set((byte*)szPlanDate, 0x00, sizeof(szPlanDate));
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Str_Cpy(szYear, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cpy(szMonth, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Cpy(szPlanDate, szYear);
			Str_Cat(szPlanDate, szMonth);
			Str_Cat(szPlanDate, szDay);

			Str_Cpy(sztmp, szYear);
			Str_Cat(sztmp, "��");
			Str_Cat(sztmp, szMonth);
			Str_Cat(sztmp, "��");
			
			Str_Cat(sztmp, szDay);
			Str_Cat(sztmp, "�ϱ��� ���� ��������");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cpy(sztmp, "���Ͽ� �����Ͽ� �ֽǰ��� ��ε�");
			g_Line_Print(list, sztmp,"","",LEFT,0);

			list->append(list, "������ ���ѳ� ������� ������\n");
			list->append(list, "���� ���ѳ� �����Ͽ� �ֽñ�\n");
			list->append(list, "�ٶ��ϴ�.\n");
			list->append(list, "                                ");
			
//			list->append(list, "--------------------------------");
			list->append(list, "3. ����, ���������� �뺸�Ͽ� ��\n");
			list->append(list, "�� �����ϱ��� ���ΰ� �ȵ� ���\n");
			list->append(list, "�����ޱ��� ��28�� �� 1�׿� �ǰ�\n");
			list->append(list, "���ð��� ������������ ���� ����\n");
			list->append(list, "���� �� 10�� ��3�׿� �ǰ� �ؾ�\n");
			list->append(list, "�� ������ġ�� ���� ���� �뺸��\n");
			list->append(list, "���� ������� �̳����� ���� ��\n");
			list->append(list, "�� �������� ���Ͻ��� �ʵ���\n");
			list->append(list, "��ε帳�ϴ�.\n");
			list->append(list, "                                ");
			list->append(list, "4. �ƿ﷯ ������ ������ + 7�� ��\n");
			list->append(list, "�Ŀ��� ���ε��� ���� ��� ä����\n");
			list->append(list, "������ ���� �˷��帳�ϴ�.\n");
			list->append(list, "                                ");
			
			list->append(list, "5. �������ῡ ���� ���κ�����\n");
			list->append(list, "�迡 �����Ͽ� �����Ͽ� �ֽñ�\n");
			list->append(list, "�ٶ��ϴ�.\n");
			list->append(list, "                                ");
			
			list->append(list, "--------------------------------");

			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_ItoA(Time_GetDate(), szBuf, 10);
			Mem_Cpy((byte *)szMsg, (byte *)szBuf, 4);
			Str_Cpy(sztmp, "�̳�����(");
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, ".");
			
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+4, 2);
			Str_Cat(sztmp, szMsg);			
			Str_Cat(sztmp, ".");
			
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Mem_Cpy((byte *)szMsg, (byte *)szBuf+6, 2);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "����)");
			g_Line_Print(list, sztmp,"","",LEFT,0);

			list->append(list, "--------------------------------");

			g_Line_Print(list, "����","��뷮","�̳��ݾ�",CENTER,17);
			
			g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_MTRREQYM", &lCnt );
			for( i = 0 ; i < lCnt ; i++ )
			{
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM1 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 20, szBuf);
				
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
				SPRINT( sztmp, "SELECT PARAM10 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 20, szMsg);

				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szMoney, 0x00, sizeof( szMoney) );
				SPRINT( sztmp, "SELECT PARAM4 FROM RCV_NONPAY_MTRREQYM LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 20, szMoney);
				lUnpayAmt = Str_AtoI(szMoney) + lUnpayAmt;
				Str_Chg(szMoney, STRCHG_INS_COMMA);
				Str_Cat(szMoney, "��");
				
				g_Line_Print(list, szBuf,szMsg,szMoney,CENTER,17);
			}

			list->append(list, "--------------------------------");
			list->append(list, "�Ա��������\n");
			
			g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_NONPAY_ACCOUNT", &lCnt );
			for( i = 0 ; i < lCnt ; i++ )
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
				SPRINT(szMsg, "%d.����� : ", (i+1),0,0);
			
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM2 FROM RCV_NONPAY_ACCOUNT LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 30, szBuf);
				
				Str_Cat(szMsg, szBuf);
				g_Line_Print(list, szMsg,"","",LEFT,0);
				
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				SPRINT( sztmp, "SELECT PARAM1 FROM RCV_NONPAY_ACCOUNT LIMIT %d, 1", i, 0, 0 );
				g_Sql_RetStr(sztmp, 30, szBuf);
				
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
				SPRINT(szMsg, "  ���¹�ȣ : ", 0,0,0);
				Str_Cat(szMsg, szBuf);
				g_Line_Print(list, szMsg,"","",LEFT,0);
			}
			
			g_Line_Print(list, "���ﵵ�ð���(��)","","",CENTER,0);
			list->append(list, "                                ");
			list->append(list, "                                ");
		}

		return list;
	}	
}



