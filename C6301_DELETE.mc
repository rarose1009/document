/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_DELETE
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
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_DELETE )	
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
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		DEF_OBJECT_ID ( TXT_DATA19 )
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA21 )
				
		DEF_OBJECT_ID ( ICON_TITLE )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	char m_szgmtr_job_ymd[9];
	char m_sztmp[200]; 
	char m_szSql[400];

	
	#define SNDCNT 100
	
	void SetStyle(void);
	void ReDraw(void);
	void SetBtnImg(void);
	bool Data_Delete(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�� �� �� ��"),
					
		DLG_BUTTON(STARTX+600,	STARTY+530, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE, "�� �� �� ��"),
		
		DLG_TEXT(STARTX,		STARTY+65, 600, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�� ��"),		
		DLG_TEXT(STARTX+600,	STARTY+65, 400, 75, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�� ��"),		
		DLG_TEXT(STARTX,		STARTY+140, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�� ��"),
		DLG_TEXT(STARTX+600,	STARTY+140, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,		STARTY+210, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "�Ϸ�"),
		DLG_TEXT(STARTX+600,	STARTY+210, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,		STARTY+280, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "�̿Ϸ�"),
		DLG_TEXT(STARTX+600,	STARTY+280, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,		STARTY+350, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "�� ��"),
		DLG_TEXT(STARTX+600,	STARTY+350, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX,		STARTY+420, 600, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "�̼۽�"),
		DLG_TEXT(STARTX+600,	STARTY+420, 400, 70, 0, 0, 0, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_DATA12, ""),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),	
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�ڷ� �۽�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+600,	STARTY+500, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE, "�� �� �� ��"),
		
		DLG_TEXT(STARTX,		 STARTY-40, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�� ��"),		
		DLG_TEXT(STARTX+600,	 STARTY-40, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�� ��"),		
		DLG_TEXT(STARTX,		 STARTY+40, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�� ��"),
		DLG_TEXT(STARTX+600,	 STARTY+40, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,		STARTY+120, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "�Ϸ�"),
		DLG_TEXT(STARTX+600,	STARTY+120, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,		STARTY+200, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "�̿Ϸ�"),
		DLG_TEXT(STARTX+600,	STARTY+200, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,		STARTY+280, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "�� ��"),
		DLG_TEXT(STARTX+600,	STARTY+280, 400, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX,		STARTY+360, 600, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "�̼۽�"),
		DLG_TEXT(STARTX+600,	STARTY+360, 400, 80, 0, 0, 0, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_DATA12, ""),
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
		char szSql[150];
	
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
				SetStyle();
				ReDraw();
				break;
		}
	}

//------------------------------------------------------------------
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

//-----------------------------------------------------------------
void	SetStyle(void)
{	
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d, k;
		char szDate[11];
		char szToday[10];
		
		switch(ID)
		{
			case BID_DELETE:
				if( Data_Delete() )
				{
					MessageBoxEx (CONFIRM_OK, "�ڷ� ������ �Ϸ�Ǿ����ϴ�.");
					ReDraw();
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "�跮�ⱳü �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("C6301_MENU");
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
				Card_Move("C6301_DMMENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
//------------------------------------------------------------------------------------------
	void ReDraw(void)
	{
		char szDate[20];
		
		//���
		Mem_Set( (byte*)m_sztmp, 0x00, sizeof(m_sztmp) );
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA ", 5, m_sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), m_sztmp );

		//�Ϸ�
		Mem_Set( (byte*)m_sztmp, 0x00, sizeof(m_sztmp) );
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN = 'Y' OR SEND_YN = 'S')", 5, m_sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), m_sztmp );

		//�̿Ϸ�
		Mem_Set( (byte*)m_sztmp, 0x00, sizeof(m_sztmp) );
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN = 'N' OR SEND_YN = '' OR SEND_YN IS NULL)", 5, m_sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), m_sztmp );
		
		//�۽�
		Mem_Set( (byte*)m_sztmp, 0x00, sizeof(m_sztmp) );
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'Y'", 5, m_sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), m_sztmp );

		//�̼۽�
		Mem_Set( (byte*)m_sztmp, 0x00, sizeof(m_sztmp) );
		g_Sql_RetStr("SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE SEND_YN = 'S'", 5, m_sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), m_sztmp );
		
		ON_DRAW();
		return;
	}
	
	
//------------------------------------------------------------------------------------------
	bool Data_Delete(void)
	{
		long lCnt = 0;
		bool lRet = TRUE;
	
		Mem_Set( (byte*)m_sztmp, 0x00, sizeof(m_sztmp) );
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		
		g_Sql_RetInt( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN == 'S' OR SEND_YN == 'N' OR SEND_YN == '' OR SEND_YN IS NULL)", &lCnt );
		if( lCnt > 0 )
		{
			if( MessageBoxEx (CONFIRM_YESNO, "�̼۽� �ڷᰡ �ֽ��ϴ�.\n�ڷḦ �����Ͻðڽ��ϱ�?")  == MB_OK )
			{
				//�۽� �Ϸ� �� �����ջ��� �� ���ڵ� ���� ����
				g_DirFS_Clear(PHOTO_GC, "*");

				g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA");
			}
			else
			{
				lRet = FALSE;
			}
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "�ڷḦ �����Ͻðڽ��ϱ�?")  == MB_OK )
			{
				//�۽� �Ϸ� �� �����ջ��� �� ���ڵ� ���� ����
				g_DirFS_Clear(PHOTO_GC, "*");

				g_Sql_DirectExecute("DELETE FROM C6301_CHANGEDATA");
			}
			else
			{
				lRet = FALSE;
			}
		}
		
		return lRet;
	}
}



