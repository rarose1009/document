/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_MENU
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
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_NP )		//ü��Ȱ��
		DEF_BUTTON_ID ( BID_PART )		//����Ȱ��
		DEF_BUTTON_ID ( BID_CLEAR )		//����Ȱ��
		DEF_BUTTON_ID ( BID_STOP )		//����Ȱ��
		DEF_BUTTON_ID ( BID_AUCTION )	//���Ȱ��
		DEF_BUTTON_ID ( BID_PAYCONFIRM )//����Ȯ�༭Ȱ��
		DEF_BUTTON_ID ( BID_RECEIPT )	//��������
		DEF_BUTTON_ID ( BID_DATA )		//�ڷ����
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
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		
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
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "ü�� �޴�"),

		DLG_TEXT(STARTX,       STARTY+85, 400, 75, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "��������"),
		DLG_TEXT(STARTX+400,   STARTY+85, 300, 75, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "���"),
		DLG_TEXT(STARTX+700,   STARTY+85, 300, 75, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�Ϸ�"),
		DLG_BUTTON(STARTX,    STARTY+160, 400, 90, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NP, "ü��Ȱ��"),
		DLG_TEXT(STARTX+400,  STARTY+160, 300, 90, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+700,  STARTY+160, 300, 90, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_BUTTON(STARTX, 	  STARTY+250, 1000, 90, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PART, "����Ȱ��"),
		DLG_BUTTON(STARTX,    STARTY+340, 400, 90, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLEAR, "����Ȱ��"),
		DLG_TEXT(STARTX+400,  STARTY+340, 300, 90, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+700,  STARTY+340, 300, 90, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_BUTTON(STARTX, 	  STARTY+430, 400, 90, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP, "����Ȱ��"),
		DLG_TEXT(STARTX+400,  STARTY+430, 300, 90, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+700,  STARTY+430, 300, 90, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_BUTTON(STARTX,    STARTY+520, 400, 90, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AUCTION, "�������"),
		DLG_TEXT(STARTX+400,  STARTY+520, 600, 90, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_BUTTON(STARTX,	  STARTY+610, 400, 90, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PAYCONFIRM, "����Ȯ�༭\nȰ��"),
		DLG_TEXT(STARTX+400,  STARTY+610, 300, 90, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+700,  STARTY+610, 300, 90, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_BUTTON(STARTX,	  STARTY+700, 1000, 90, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECEIPT, "��������"),
		DLG_BUTTON(STARTX,	  STARTY+790, 1000, 90, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATA, "�ڷ����"),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "ü�� �޴�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_TEXT(STARTX,       STARTY+30, 400, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "��������"),
		DLG_TEXT(STARTX+400,   STARTY+30, 300, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "���"),
		DLG_TEXT(STARTX+700,   STARTY+30, 300, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�Ϸ�"),
		DLG_BUTTON(STARTX,    STARTY+130, 400, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NP, "ü��Ȱ��"),
		DLG_TEXT(STARTX+400,  STARTY+130, 300, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+700,  STARTY+130, 300, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_BUTTON(STARTX, 	  STARTY+230, 1000, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PART, "����Ȱ��"),
		DLG_BUTTON(STARTX,    STARTY+330, 400, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLEAR, "����Ȱ��"),
		DLG_TEXT(STARTX+400,  STARTY+330, 300, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX+700,  STARTY+330, 300, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_BUTTON(STARTX, 	  STARTY+430, 400, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP, "����Ȱ��"),
		DLG_TEXT(STARTX+400,  STARTY+430, 300, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+700,  STARTY+430, 300, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_BUTTON(STARTX,    STARTY+530, 400, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AUCTION, "�������"),
		DLG_TEXT(STARTX+400,  STARTY+530, 600, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_BUTTON(STARTX,	  STARTY+630, 1000, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECEIPT, "��������"),
		DLG_BUTTON(STARTX,	  STARTY+730, 1000, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATA, "�ڷ����"),
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}
				g_FlagClear();
				SetBtnImg();	
				SetStyle();
				ReDraw();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[150];
		long lCnt;
		
		if( g_ChkDay() )
		{
			return;
		}
			
		switch(ID)
		{				
			case BID_NP:
				Card_Move("C6202_GRPLST");
				break;	
			case BID_PART:
				g_nWorkFlag = 810;
				Card_Move("C6202_PART");
				break;	
			case BID_CLEAR:
				g_nWorkFlag = 820;
				Card_Move("C6202_CLEARLST");
				break;	
			case BID_STOP:
				g_nWorkFlag = 830;
				Card_Move("C6202_STOPLST");
				break;		
			case BID_AUCTION:
				g_nWorkFlag = 840;
				g_nScrollIndex = 0;
				Card_Move("C6202_AUCTIONLST");
				break;
			case BID_PAYCONFIRM:
				//MessageBoxEx (CONFIRM_OK, "�ű� ���� ���� �������Դϴ�.");
				
				//OZ���� �Ϸ� �� Ǯ�����.
				g_nWorkFlag = 850;
				Card_Move("C6202_PAYCONFIRM");
				
				break;
			case BID_RECEIPT:
				Card_Move("C6202_RECEIPT");
				break;	
			case BID_DATA:
				Card_Move("C6202_RCV");
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
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
				Card_Move("MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}		
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
					
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
			
/*			//�޴���ư
			h = Get_hDlgCtrlByID();
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID();
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID();
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID();
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID();
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID();
			ButCtrl_SetImage( h,  g_pImgMnTop);
*/
		}
	}
	
//------------------------------------------------------------------
	void SetStyle(void)
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
		
		if( theDevInfo.m_nType > FAMILY_PDA )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		
		return;
	}
	
//------------------------------------------------------------------
	void ReDraw(void)
	{
		char szSql[400];
		char szCnt[10];
	
		//ü��Ȱ�� ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
		SPRINT(szSql, "SELECT COUNT(*) FROM C6202_NOPAY_OBJ",0, 0, 0   );
		g_Sql_RetStr( szSql, 10, szCnt );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), szCnt );

		//ü��Ȱ�� �Ϸ�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
		SPRINT(szSql, "SELECT COUNT(*) FROM C6202_NOPAY_OBJ WHERE (VISIT_FLAG != 'N' AND VISIT_FLAG IS NOT NULL) ",0, 0, 0   );
		g_Sql_RetStr( szSql, 10, szCnt );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), szCnt );
		
		//����Ȱ�� ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
		SPRINT(szSql, "SELECT COUNT(*) FROM C6202_RELEASE",0, 0, 0   );
		g_Sql_RetStr( szSql, 10, szCnt );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), szCnt );
		
		//����Ȱ�� �Ϸ�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
		SPRINT(szSql, "SELECT COUNT(*) FROM C6202_RELEASE WHERE (PROC != 'N' AND PROC IS NOT NULL)",0, 0, 0   );
		g_Sql_RetStr( szSql, 10, szCnt );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), szCnt );
		
		//����Ȱ�� ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
		SPRINT(szSql, "SELECT COUNT(*) FROM C6202_STOP_OBJ",0, 0, 0   );
		g_Sql_RetStr( szSql, 10, szCnt );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), szCnt );
		
		//����Ȱ�� �Ϸ�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
		SPRINT(szSql, "SELECT COUNT(*) FROM C6202_STOP_OBJ WHERE (VISIT_FLAG != 'N' AND VISIT_FLAG IS NOT NULL)",0, 0, 0   );
		g_Sql_RetStr( szSql, 10, szCnt );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), szCnt );
		
		//�������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
		SPRINT(szSql, "SELECT COUNT(*) FROM C6202_AUCTION",0, 0, 0   );
		g_Sql_RetStr( szSql, 10, szCnt );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), szCnt );

		if( theDevInfo.m_nType > FAMILY_PDA )
		{
			//����Ȯ�༭ ���
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
			SPRINT(szSql, "SELECT COUNT(*) FROM C6202_PAYCONFIRM",0, 0, 0   );
			g_Sql_RetStr( szSql, 10, szCnt );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11), szCnt );
			
			//����Ȯ�༭ �Ϸ�
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
			SPRINT(szSql, "SELECT COUNT(*) FROM C6202_PAYCONFIRM WHERE VISIT_FLAG = 'Y'",0, 0, 0   );
			g_Sql_RetStr( szSql, 10, szCnt );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), szCnt );
		}
	}
}


