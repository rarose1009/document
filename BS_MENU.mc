/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_MENU
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
		DEF_BUTTON_ID ( BID_BS )		//����Ư������
		DEF_BUTTON_ID ( BID_REFORM )	//�����ǰ�
		DEF_BUTTON_ID ( BID_DATA )		//�ڷ����
		DEF_BUTTON_ID ( BID_FIRSTBS )   //�켱Ư������
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
		DEF_OBJECT_ID ( ICON_TITLE )	//Ÿ��Ʋ
		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
		DEF_OBJECT_ID ( LINE_DATA3 )
		DEF_OBJECT_ID ( LINE_DATA4 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	void SetBtnImg(void);
	bool Chk_Month(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "Ư������ �޴�"),
		
		//DLG_BUTTON(STARTX+240, STARTY+250, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BS, "����Ư������"),
		//DLG_BUTTON(STARTX+240, STARTY+400, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REFORM, "�����ǰ����"),
		//DLG_BUTTON(STARTX+240, STARTY+550, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, "�ڷ� ����"),
		
		DLG_BUTTON(STARTX    , STARTY+65          , BTNMNWD, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BS, ""), // ����Ư������
		DLG_BUTTON(STARTX+495, STARTY+65          , BTNMNWD, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FIRSTBS, ""), // �켱Ư������
		DLG_BUTTON(STARTX    , STARTY+65+(1*BTNHT), BTNMNWD, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REFORM, ""), // �����ǰ����
		DLG_BUTTON(STARTX+495, STARTY+65+(1*BTNHT), BTNMNWD, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, ""), // �ڷ� ����
		
		DLG_LINE(500, STARTY+65,                 500, STARTY+65+(2*BTNHT), LINECTRLCOLOR, 2, LINE_DATA1),
		DLG_LINE(0,  STARTY+65+(1*BTNHT), STARTX+995, STARTY+65+(1*BTNHT), LINECTRLCOLOR, 2, LINE_DATA2),
		DLG_LINE(0,  STARTY+65+(2*BTNHT), STARTY+995, STARTY+65+(2*BTNHT), LINECTRLCOLOR, 2, LINE_DATA3)
	
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "Ư������ �޴�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
/*
		DLG_BUTTON(STARTX+150, STARTY+180, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BS, "����Ư������"),
		DLG_BUTTON(STARTX+150, STARTY+330, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REFORM, "�����ǰ����"),
		DLG_BUTTON(STARTX+150, STARTY+480, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, "�ڷ� ����"),
*/
		DLG_BUTTON(STARTX+240, STARTY+200, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BS, "����Ư������"),
		DLG_BUTTON(STARTX+240, STARTY+350, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "�����ǰ����"),
		DLG_BUTTON(STARTX+240, STARTY+500, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATA, "�ڷ� ����"),
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
			
			//�޴���ư
			h = Get_hDlgCtrlByID(BID_BS);
			ButCtrl_SetImage( h,  g_pImgBs_Normal);
			
			h = Get_hDlgCtrlByID(BID_REFORM);
			ButCtrl_SetImage( h,  g_pImgBs_Rfrm);
			
			h = Get_hDlgCtrlByID(BID_DATA);
			ButCtrl_SetImage( h,  g_pImgBs_Data);
			
			h = Get_hDlgCtrlByID(BID_FIRSTBS);
			ButCtrl_SetImage( h,  g_pImgBs_First);
		}
	}

//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		if( g_ChkDay() )
			return;

		switch(ID)
		{					
			case BID_BS:
				
				if( Chk_Month() )
				{
					g_nWorkFlag = 300;
					g_nAddrFlag = 0;
					Card_Move("BS_BDLST");					
				}
				
				break;				
			case BID_REFORM:
				if( Chk_Month() )
				{
					g_nWorkFlag = 304;
					g_nAddrFlag = 0;
					Card_Move("BS_RFRMLST");
				}
				break;
			case BID_DATA:
				Card_Move("BS_DMMENU");
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
			case BID_FIRSTBS:
				if( Chk_Month() )
				{
					Card_Move("BS_FRSTLST");
				}
				break;
		}
	}	
	
	bool Chk_Month(void)
	{
		char szYYYYMM[10];
		char szToYYYYMM[10];
		char szTmp[100];
		char szSql[300];
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		
		SPRINT( szSql, " SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '5' ", 0, 0, 0 );
		g_Sql_RetStr( szSql, 50, szTmp );
		
		// �����ΰ��( Ư������ ) ����
		if( Str_Cmp(szTmp, "30") == 0)
		{
			return TRUE;
		}
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szYYYYMM, 0x00, sizeof( szYYYYMM) );
		
		SPRINT( szSql, " SELECT PARAM7 FROM RCV_LOG WHERE GUBUN = '5' ", 0, 0, 0 );
		g_Sql_RetStr( szSql, 50, szYYYYMM );
		
		Str_ItoA( Time_GetDate(), szToYYYYMM, 10);
		
		if( Str_NCmp( szYYYYMM, szToYYYYMM, 6 ) != 0 && Str_Cmp( szYYYYMM, "" ) != 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�̿��� �����ʹ�\n������ ���� �� �� �����ϴ�.\n�����ڷḦ �� ���� ���ּ���.");
			return FALSE;
		}	
		
		return TRUE;
	}	
}


