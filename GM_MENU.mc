/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_MENU
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
		DEF_BUTTON_ID ( BID_GM )		//�����ħ 
		DEF_BUTTON_ID ( BID_NOGM )		//�����̰�ħ 
		DEF_BUTTON_ID ( BID_ABSNC )		//���� 
		DEF_BUTTON_ID ( BID_SLCT )		//������ħ 
		DEF_BUTTON_ID ( BID_GMGO )		//��ħ�ٷΰ���
		DEF_BUTTON_ID ( BID_DATA )		//�ڷ����
		DEF_BUTTON_ID ( BID_SMSGM )		//���ڰ�ħ
		//DEF_BUTTON_ID ( BID_FEEVIEW )	//�����ȸ
		DEF_BUTTON_ID ( BID_REGM )		//���
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
		DEF_OBJECT_ID ( TXT_BACK )
		DEF_OBJECT_ID ( TXT_BORDER )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ

		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
		DEF_OBJECT_ID ( LINE_DATA3 )
		DEF_OBJECT_ID ( LINE_DATA4 )
		DEF_OBJECT_ID ( LINE_DATA5 )		
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
	
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
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		
		//DLG_TEXT(0, 0, 1000, 1000, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, WHITE, DEEPBLUE, TXT_BACK, ""),

		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ħ �޴�"),
/*
		DLG_BUTTON(STARTX+120, STARTY+170, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GM, " �� �� �� ħ"),
		DLG_BUTTON(STARTX+120, STARTY+170, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOGM, " �� �� �� �� ħ"),
		DLG_BUTTON(STARTX+120, STARTY+170, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_ABSNC, " �� �� �� ħ"),
		DLG_BUTTON(STARTX+120, STARTY+170, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCT, " �� �� �� ħ"),
		DLG_BUTTON(STARTX+120, STARTY+320, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMGO, " ��ħ�ٷΰ���"),
		DLG_BUTTON(STARTX+120, STARTY+470, BTNMNWD, BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, " �ڷ� ����"),
*/
		//DLG_BUTTON(STARTX,     STARTY+180, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GM, "�� �� �� ħ"),
		//DLG_BUTTON(STARTX+500, STARTY+180, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOGM, "�� �� �� �� ħ"),
		//DLG_BUTTON(STARTX,     STARTY+330, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_ABSNC, "�� �� �� ħ"),
		//DLG_BUTTON(STARTX+500, STARTY+330, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCT, "�� �� �� ħ"),
		//DLG_BUTTON(STARTX,     STARTY+480, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMGO, "��ħ�ٷΰ���"),
		//DLG_BUTTON(STARTX+500, STARTY+480, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, "�� �� �� ��"),
		//DLG_BUTTON(STARTX,     STARTY+630, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SMSGM, "�� �� �� ħ"),
		//DLG_BUTTON(STARTX+500, STARTY+630, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEEVIEW, "�� �� �� ȸ"),
		
		DLG_BUTTON(STARTX,     STARTY+65, BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GM, ""), // �� �� �� ħ
		DLG_BUTTON(STARTX+495, STARTY+65, BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOGM, ""), // �� �� �� �� ħ
		DLG_BUTTON(STARTX,     STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_ABSNC, ""), // �� �� �� ħ
		DLG_BUTTON(STARTX+495, STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCT, ""), // �� �� �� ħ
		DLG_BUTTON(STARTX,     STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMGO, ""), // ��ħ�ٷΰ���
		//DLG_BUTTON(STARTX+495, STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, ""), // �� �� �� ��
		DLG_BUTTON(STARTX+495, STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REGM, ""),// ���
		DLG_BUTTON(STARTX,     STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SMSGM, ""), // �� �� �� ħ
		//DLG_BUTTON(STARTX+495, STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEEVIEW, ""), // �� �� �� ȸ
		DLG_BUTTON(STARTX+495, STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, ""),// �ڷ����
		
		DLG_LINE(500, STARTY+65,        500, STARTY+899, LINECTRLCOLOR, 2, LINE_DATA1),
		DLG_LINE(0,  STARTY+65+(1*BTNHT), STARTX+995, STARTY+65+(1*BTNHT), LINECTRLCOLOR, 2, LINE_DATA2),
		DLG_LINE(0,  STARTY+65+(2*BTNHT), STARTY+995, STARTY+65+(2*BTNHT), LINECTRLCOLOR, 2, LINE_DATA3),
		DLG_LINE(0,  STARTY+65+(3*BTNHT), STARTX+995, STARTY+65+(3*BTNHT), LINECTRLCOLOR, 2, LINE_DATA4)
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "��ħ �޴�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
/*	
		DLG_BUTTON(STARTX+150,     STARTY, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GM, "���� ��ħ"),
		DLG_BUTTON(STARTX+150, STARTY+150, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_NOGM, " �� �� �� �� ħ"),
		DLG_BUTTON(STARTX+150, STARTY+300, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_ABSNC, " �� �� �� ħ"),
		DLG_BUTTON(STARTX+150, STARTY+450, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCT, " �� �� �� ħ"),
		DLG_BUTTON(STARTX+150, STARTY+600, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_GMGO, "��ħ �ٷΰ���"),
		DLG_BUTTON(STARTX+150, STARTY+750, P_BTNMNWD, P_BTNMNHT, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, "�ڷ� ����"),
*/
		DLG_BUTTON(STARTX,     STARTY+140, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GM, "�� �� �� ħ"),
		DLG_BUTTON(STARTX+500, STARTY+140, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOGM, "�� �� �� �� ħ"),
		DLG_BUTTON(STARTX,     STARTY+290, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ABSNC, "�� �� �� ħ"),
		DLG_BUTTON(STARTX+500, STARTY+290, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SLCT, "�� �� �� ħ"),
		DLG_BUTTON(STARTX,     STARTY+440, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMGO, "��ħ�ٷΰ���"),
		DLG_BUTTON(STARTX+500, STARTY+440, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATA, "�� �� �� ��"),
		DLG_BUTTON(STARTX,     STARTY+590, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMSGM, "�� �� �� ħ"),
		//DLG_BUTTON(STARTX+500, STARTY+590, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEEVIEW, "�� �� �� ȸ"),
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
				g_FlagClear();
				SetBtnImg();

				//�����̰�ħ FLAG ������Ʈ
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE GUMDATA SET SEND_YN = 'S' WHERE SEND_YN = 'I'", 0, 0, 0);		
				g_Sql_DirectExecute(szSql);

				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[300];
		long lCnt;
		
		if( g_ChkDay() )
			return;
	
		switch(ID)
		{					
			case BID_GM:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 100;
					Card_Move("GM_GRPLST");
				}
				else
					MessageBoxEx(CONFIRM_OK, "����� �����ϼ���.");
				break;	
			case BID_NOGM:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 103;
					Card_Move("GM_NOGMLST");
				}
				else
					MessageBoxEx(CONFIRM_OK, "����� �����ϼ���.");
				break;
			case BID_ABSNC:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 104;
					Card_Move("GM_ABSNCLST");
				}
				else
					MessageBoxEx(CONFIRM_OK, "����� �����ϼ���.");
				break;
			case BID_SLCT:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 101;
					Card_Move("GM_SLCTGM");
				}
				else
					MessageBoxEx(CONFIRM_OK, "����� �����ϼ���.");
				break;
			case BID_GMGO:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM GUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );
				
				if( lCnt > 0 )
				{	//���Ͽ� ������ ��
					g_nWorkFlag = 100;
					g_lMoveFlag = 1;
					
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Str_Cpy(szSql, "SELECT ROWID FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE");
					g_Sql_SaveSeq( szSql, SREACH_FILE);
					Get_Index();				

					Card_Move("GM_ENTRY");
				}
				else
					MessageBoxEx(CONFIRM_OK, "����� �����ϼ���.");
				break;	
			case BID_DATA:
				Card_Move("GM_DMMENU");
				break;
			case BID_SMSGM:
				//�ش� ȭ�� �ּ� �ʱ� ���� -> ���θ�
				g_nAddrFlag = 1;
				g_nSmsFlag = 0;
				Card_Move("GM_SMSGM");
				break;
			case BID_REGM:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM REGUMDATA ",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 100;
					Card_Move("GM_RELST");
				}
				else
					MessageBoxEx(CONFIRM_OK, "����� �����ϼ���.");
				break;
				/*
			case BID_FEEVIEW:
				//�ش� ���� ���� ���� ���̺� Ŭ����
				g_Sql_DirectExecute("DELETE FROM GUM_FEE_INFO");
				g_Sql_DirectExecute("DELETE FROM RCV_TMP");
				g_Sql_DirectExecute("DELETE FROM RCV_RELEASE");
				g_Sql_DirectExecute("DELETE FROM RCV_CALCUL");

				Mem_Set((byte*)&stFee_History, 0x00, sizeof(stFee_History));
				Mem_Set((byte*)&stFee_Calcul, 0x00, sizeof(stFee_Calcul));
				Mem_Set((byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));
				Mem_Set((byte*)g_szUSE_CONT_NUM_Fee, 0x00, sizeof(g_szUSE_CONT_NUM_Fee));
				Mem_Set((byte*)g_szIndi_Cur, 0x00, sizeof(g_szIndi_Cur));
				g_lPAYFlag = 0;
				
				Card_Move("GM_FEEVIEW");
				break;
				*/
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
			
			//�޴���ư
			h = Get_hDlgCtrlByID(BID_GM);
			ButCtrl_SetImage( h,  g_pImgGm_Normal);
			
			h = Get_hDlgCtrlByID(BID_NOGM);
			ButCtrl_SetImage( h,  g_pImgGm_Nogm);
			
			h = Get_hDlgCtrlByID(BID_ABSNC);
			ButCtrl_SetImage( h,  g_pImgGm_Absnc);
			
			h = Get_hDlgCtrlByID(BID_SLCT);
			ButCtrl_SetImage( h,  g_pImgGm_Sel);
			
			h = Get_hDlgCtrlByID(BID_GMGO);
			ButCtrl_SetImage( h,  g_pImgGm_Go);
			
			h = Get_hDlgCtrlByID(BID_DATA);
			ButCtrl_SetImage( h,  g_pImgGm_Data);
		
			h = Get_hDlgCtrlByID(BID_SMSGM);
			ButCtrl_SetImage( h,  g_pImgGm_Sms);
			
			//h = Get_hDlgCtrlByID(BID_FEEVIEW);
			//ButCtrl_SetImage( h,  g_pImgGm_Feeview);
			
			h = Get_hDlgCtrlByID(BID_REGM);
			ButCtrl_SetImage( h,  g_pImgGm_Regm);

/*
			h = Get_hDlgCtrlByID(BID_GM);
			ButCtrl_SetImage( h,  g_pImgGmBtn);
			
			h = Get_hDlgCtrlByID(BID_NOGM);
			ButCtrl_SetImage( h,  g_pImgNoGmBtn);
			
			h = Get_hDlgCtrlByID(BID_ABSNC);
			ButCtrl_SetImage( h,  g_pImgAbsncBtn);
			
			h = Get_hDlgCtrlByID(BID_SLCT);
			ButCtrl_SetImage( h,  g_pImgGmSlctBtn);
			
			h = Get_hDlgCtrlByID(BID_GMGO);
			ButCtrl_SetImage( h,  g_pImgGmgoBtn);

			h = Get_hDlgCtrlByID(BID_DATA);
			ButCtrl_SetImage( h,  g_pImgGmDataBtn);
*/
		}
	}
	
	/*=======================================================================================
	�Լ��� : Get_Index
	��  �� : ���� �ε��� �о�´�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Get_Index(void)
	{
		char szsql[101];
		char szbuf[10];
		long lret;
		
		Mem_Set((byte*)szsql, 0x00, sizeof(szsql));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		Str_Cpy(szsql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '1'  ");	
		g_Sql_RetStr(szsql, 4, szbuf);
		
		lret = Str_AtoI(szbuf);
		
		if( lret == 0 )
		{
			g_nActIndex = lret;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		}
		else
		{
			g_lindex = lret;
			g_nActIndex = g_Get_FsIndex(g_lindex, SREACH_FILE);
		}
	}
}


