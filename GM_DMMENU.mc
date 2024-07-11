/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : GM_DMMENU
	Card Desc : ��ħ �ڷ����
	Card Hist :
----------------------------------------------------------------------------------*/
card GM_DMMENU
{
	#include <include.h>
	#include "globalcard.h"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
	
		// ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		// Ȩ
		DEF_BUTTON_ID ( BID_MENU )		// �޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	// Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	// ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	// �������
		DEF_BUTTON_ID ( BID_PREV )		// ����
		DEF_BUTTON_ID ( BID_EXIT )		// ����
		
		// �Ϲ� ��ư
		DEF_BUTTON_ID ( BID_DEL )		// �ڷ� ����
		DEF_BUTTON_ID ( BID_RECV )		// �ڷ� ����
		DEF_BUTTON_ID ( BID_SNDDEL )	// �ڷ� �۽� �� ����
		
		DEF_BUTTON_ID ( BID_REDEL )		// ��� �ڷ� ����
		DEF_BUTTON_ID ( BID_RESNDDEL )	// ��� �ڷ� �۽� �� ����
			
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		
		// Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_TITLE )
		DEF_OBJECT_ID ( ICON_TITLE )
		
		// SUB Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_SUBTITLE1 )	
		DEF_OBJECT_ID ( TXT_SUBTITLE2 )
		DEF_OBJECT_ID ( TXT_SUBTITLE3 )
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define INIT_MAIN	1
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	void SetBtnImg(void);
	void Del_Gmdata(void);
	void Del_ReGmdata(void);
	
	//---------------------------------------------------------------------------------------
	// Common Button
	//---------------------------------------------------------------------------------------
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
	
	//---------------------------------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		// Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�� ħ �� �� �� ��"),
		
		DLG_TEXT  (STARTX,     STARTY+65, 			 1000,    70,      0,  0,  0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, DARKSLATEBLUE, TXT_SUBTITLE1, "�ڷ� ����" ),
		DLG_BUTTON(STARTX+240, STARTY+135, 			 BTNMNWD, BTNHT,   25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RECV, ""),
		
		DLG_TEXT  (STARTX,     STARTY+135+(1*BTNHT), 1000,    70,      0,  0,  0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, DARKSLATEBLUE, TXT_SUBTITLE2, "�����ħ �۽�, ����" ),
		DLG_BUTTON(STARTX,     STARTY+210+(1*BTNHT), BTNMNWD, BTNHT,   25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SNDDEL, ""),
		DLG_BUTTON(STARTX+495, STARTY+210+(1*BTNHT), BTNMNWD, BTNHT,   25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DEL, ""),
		
		DLG_TEXT  (STARTX,     STARTY+210+(2*BTNHT), 1000,    70,      0,  0,  0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, DARKSLATEBLUE, TXT_SUBTITLE3, "���, �������� �۽�, ����" ),
		DLG_BUTTON(STARTX,     STARTY+280+(2*BTNHT), BTNMNWD, BTNHT-5, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RESNDDEL, ""),
		DLG_BUTTON(STARTX+495, STARTY+280+(2*BTNHT), BTNMNWD, BTNHT-5, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REDEL, ""),
		
	};	

	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
		return TRUE;
	}

	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : OnInit
	��  �� : ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit( char bFirst )
	{
		switch ( bFirst )
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
					
				SetBtnImg();
				
				break;
		}
	}

	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton( long ID )
	{	
		char szSql[300];
		long lCnt = 0;
	
		switch(ID)
		{
			/*********************************/
			/* ����                          */
			/*********************************/
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
				Card_Move("GM_MENU");
				break;
				
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/*********************************/
			/* �Ϲ�                          */
			/*********************************/
			case BID_RECV:
				/* ���� ����
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA",0, 0, 0   );
					g_Sql_RetInt( szSql, &lCnt );
					
					if( lCnt > 0 )
					{
						MessageBoxEx(CONFIRM_OK, "��ħ�ڷᰡ �ֽ��ϴ�. �ڷ������ �����ϼ���.");
					}
					else
					{
						Card_Move("GM_RCV");
					}
				*/
				Card_Move("GM_RCV");
				
				break;
				
			case BID_SNDDEL:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );
				
				if( lCnt == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "��ħ ����� �����ϼ���.");
				}
				else
				{
					Card_Move("GM_SND");
				}
				
				break;
				
			case BID_DEL:
				Del_Gmdata();
				break;
			
			case BID_RESNDDEL:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT( szSql, "SELECT COUNT(*) FROM REGUMDATA", 0, 0, 0 );
				g_Sql_RetInt( szSql, &lCnt );
				
				if( lCnt == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "��ħ ����� �����ϼ���.");
				}
				else
				{
					Card_Move("GM_RESND");
				}
				
				break;
				
			case BID_REDEL:
				Del_ReGmdata();
				break;	
		}
	}		

	//---------------------------------------------------------------------------------------
	// �Ϲ� FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/	
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUBTITLE1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUBTITLE2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUBTITLE3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		//��ܰ���޴�
		h = GetSysButHandle(GID_HOME);
		ButCtrl_SetImage( h, g_pImgHomeI);
		ButCtrl_SetActiveImage( h, g_pImgHomeA);
		
		h = GetSysButHandle(GID_KEYBOARD);
		ButCtrl_SetImage( h, g_pImgKeybrdI);
		ButCtrl_SetActiveImage( h, g_pImgKeybrdA);
		
		h = GetSysButHandle(GID_SCREEN);
		ButCtrl_SetImage( h, g_pImgScreenI);
		ButCtrl_SetActiveImage( h, g_pImgScreenA);
		
		h = GetSysButHandle(GID_CMMNWK);
		ButCtrl_SetImage( h, g_pImgCmmnwrkI);
		ButCtrl_SetActiveImage( h, g_pImgCmmnwrkA);
		
		h = GetSysButHandle(GID_VMEXIT);
		ButCtrl_SetImage( h, g_pImgExitI);
		ButCtrl_SetActiveImage( h, g_pImgExitA);
		
		//�޴���ư
		h = Get_hDlgCtrlByID(BID_RECV);
		ButCtrl_SetImage( h, g_pImgGm_DataRcv);
		
		h = Get_hDlgCtrlByID(BID_SNDDEL);
		ButCtrl_SetImage( h, g_pImgGm_DataSnd);

		h = Get_hDlgCtrlByID(BID_DEL);
		ButCtrl_SetImage( h, g_pImgGm_DataDel);
		
		
		h = Get_hDlgCtrlByID(BID_RESNDDEL);
		ButCtrl_SetImage( h, g_pImgGm_DataSnd);

		h = Get_hDlgCtrlByID(BID_REDEL);
		ButCtrl_SetImage( h, g_pImgGm_DataDel);
		
	}
	
	/*=======================================================================================
	�Լ��� : Del_Gmdata
	��  �� : ���� ��ħ ����
	Param  : 
	Return : 
	========================================================================================*/
	void Del_Gmdata(void)
	{
		long totcnt;
	
		g_Sql_RetInt(" select count(*) from GUMDATA WHERE SEND_YN = 'S' AND MTR_WORK_CODE <> 'L'", &totcnt);
		
		if( totcnt > 0 )
		{
			if( MessageBoxEx (CONFIRM_YESNO, "�����ħ [�̼۽�] �ڷᰡ �ֽ��ϴ�.\n�����Ͻðڽ��ϱ�?") != MB_OK )
				return;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "[�����ħ �ڷ�]��\n�����Ͻðڽ��ϱ�?")  != MB_OK )
				return;
		}
		
		g_Sql_DirectExecute("DELETE FROM GUMGROUP");
		g_Sql_DirectExecute("DELETE FROM GUMDATA");
		g_Sql_DirectExecute("DELETE FROM GUM_COMPENS_REMOVE_REQ");
		// g_Sql_DirectExecute("DELETE FROM RCV_LOG WHERE GUBUN = '1'");
		g_Sql_DirectExecute("UPDATE RCV_LOG SET PARAM6 ='' WHERE GUBUN ='1'");
		
		g_DirFS_Clear(PHOTO_GM, "*");
		
		MessageBoxEx(CONFIRM_OK, "�ڷ������ �Ϸ� �߽��ϴ�.");
	}
	
	/*=======================================================================================
	�Լ��� : Del_ReGmdata
	��  �� : ��� ��ħ ����
	Param  : 
	Return : 
	========================================================================================*/
	void Del_ReGmdata(void)
	{
		long totcnt;
	
		g_Sql_RetInt(" select count(*) from REGUMDATA WHERE SEND_YN = 'S' AND MTR_WORK_CODE <> 'L'", &totcnt);
		
		if( totcnt > 0 )
		{
			if( MessageBoxEx (CONFIRM_YESNO, "���, �������� [�̼۽�] �ڷᰡ\n�ֽ��ϴ�. �����Ͻðڽ��ϱ�?") != MB_OK )
				return;
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "[���, ��������]�ڷḦ\n�����Ͻðڽ��ϱ�?")  != MB_OK )
				return;
		}

		g_Sql_DirectExecute("DELETE FROM REGUMDATA");
		
		MessageBoxEx(CONFIRM_OK, "�ڷ������ �Ϸ� �߽��ϴ�.");
	}
}


