/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_MENU
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
		DEF_BUTTON_ID ( BID_OLD )		//���ı�ü
		DEF_BUTTON_ID ( BID_MINWON )	//�ο���ü
		DEF_BUTTON_ID ( BID_REMARK )	//����ǥ��ü
		DEF_BUTTON_ID ( BID_UNCHG )		//��ü�Ұ�
		DEF_BUTTON_ID ( BID_SLCTCHG )	//���ñ�ü
		DEF_BUTTON_ID ( BID_RESULT )	//��޹׽�����ȸ
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
		//DEF_OBJECT_ID ( TXT_BACK )
		DEF_OBJECT_ID ( TXT_BORDER )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
		DEF_OBJECT_ID ( LINE_DATA3 )
		DEF_OBJECT_ID ( LINE_DATA4 )
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
	bool RcvDate_Chk(long BtnId);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		
		//DLG_TEXT(0, 0, 1000, 1000, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, 0, WHITE, DEEPBLUE, TXT_BACK, ""),

		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�跮�ⱳü �޴�"),

		DLG_BUTTON(STARTX,     STARTY+65, BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OLD, ""), // ���ı�ü
		DLG_BUTTON(STARTX+495, STARTY+65, BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MINWON, ""), // �ο���ü

		// DLG_BUTTON(STARTX,     STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REMARK, ""), // ��ü�Ұ�
		DLG_BUTTON(STARTX,     STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_REMARK, ""), // ��ü�Ұ�
		DLG_BUTTON(STARTX+495, STARTY+65+(1*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_UNCHG, ""), // ���ñ�ü
		DLG_BUTTON(STARTX,     STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCTCHG, ""), // ��� �� ������ȸ
		DLG_BUTTON(STARTX+495, STARTY+65+(2*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RESULT, ""),// �ڷ����
		DLG_BUTTON(STARTX,     STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, ""), // ��ĭ
		//DLG_BUTTON(STARTX+495, STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEEVIEW, ""), // �� �� �� ȸ
		DLG_BUTTON(STARTX+495, STARTY+65+(3*BTNHT), BTNWH, BTNHT, 25, 12, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA, ""),// ��ĭ
		
		DLG_LINE(500, STARTY+65,        500, STARTY+899, LINECTRLCOLOR, 2, LINE_DATA1),
		DLG_LINE(0,  STARTY+65+(1*BTNHT), STARTX+995, STARTY+65+(1*BTNHT), LINECTRLCOLOR, 2, LINE_DATA2),
		DLG_LINE(0,  STARTY+65+(2*BTNHT), STARTY+995, STARTY+65+(2*BTNHT), LINECTRLCOLOR, 2, LINE_DATA3),
		DLG_LINE(0,  STARTY+65+(3*BTNHT), STARTX+995, STARTY+65+(3*BTNHT), LINECTRLCOLOR, 2, LINE_DATA4)
	};	
// 	DlgObject	DlgRes[] = 
// 	{
// 		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
// 		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
// 		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
// 		//Ÿ��Ʋ
// 		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�跮�ⱳü �޴�"),
// /*
// 		DLG_BUTTON(STARTX,     STARTY+240, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OLD    , "�� �� �� ü"),
// 		DLG_BUTTON(STARTX+500, STARTY+240, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MINWON , "�� �� �� ü"),
// 		DLG_BUTTON(STARTX,     STARTY+390, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_UNCHG  , "�� ü �� ��"),
// 		DLG_BUTTON(STARTX+500, STARTY+390, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCTCHG, "�� �� �� ü"),
// 		DLG_BUTTON(STARTX,     STARTY+540, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RESULT , "��� �� ������ȸ"),
// 		DLG_BUTTON(STARTX+500, STARTY+540, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA   , "�� �� �� ��"),
// */

// //2�� �þ�
// //#define BTNMNWD		490
// //#define BTNMNHT		140
// //DLG_TEXT(STARTX+450, STARTY+700, 535, 70, 0, 0, 0, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_DATA2, ""),
// 		DLG_BUTTON(0,		     STARTY+65, 498, 280, 75, 60, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OLD    , ""),
// 		DLG_BUTTON(STARTX+495,	 STARTY+65, 498, 280, 75, 60, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MINWON , ""),
// 		DLG_BUTTON(0,		    STARTY+345, 498, 280, 75, 60, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_UNCHG  , ""),
// 		DLG_BUTTON(STARTX+495,	STARTY+345, 498, 280, 75, 60, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SLCTCHG, ""),
// 		DLG_BUTTON(0,		    STARTY+625, 498, 273, 75, 60, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RESULT , ""),
// 		DLG_BUTTON(STARTX+495,	STARTY+625, 498, 273, 75, 60, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DATA   , ""),

// 		DLG_LINE(500, STARTY+65, 500, STARTY+900, LINECTRLCOLOR, 2, LINE_DATA1),
// 		DLG_LINE(0, STARTY+345, STARTX+995, STARTY+345, LINECTRLCOLOR, 2, LINE_DATA2),
// 		DLG_LINE(0, STARTY+625, STARTY+995, STARTY+625, LINECTRLCOLOR, 2, LINE_DATA3)
// 	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�跮�ⱳü �޴�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,     STARTY+200, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OLD    , "�� �� �� ü"),     
		DLG_BUTTON(STARTX+500, STARTY+200, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MINWON , "�� �� �� ü"),     
		DLG_BUTTON(STARTX,     STARTY+350, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UNCHG  , "�� ü �� ��"),     
		DLG_BUTTON(STARTX+500, STARTY+350, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SLCTCHG, "�� �� �� ü"),     
		DLG_BUTTON(STARTX,     STARTY+500, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RESULT , "��� �� ������ȸ"),
		DLG_BUTTON(STARTX+500, STARTY+500, BTNMNWD, BTNMNHT, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DATA   , "�� �� �� ��"),     
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
				ON_DRAW();
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
			case BID_OLD:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND NOBILL_YN ='N'",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					if( !RcvDate_Chk(ID) )
					{
						return;
					}
				
					g_nWorkFlag = 700;
					Card_Move("C6301_LST");
					break;
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "�ڷᰡ �����ϴ�.");
				}
				break;	
			case BID_MINWON:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND NOBILL_YN ='N'",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					g_nWorkFlag = 710;
					Card_Move("C6301_LST");
					break;
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "�ڷᰡ �����ϴ�.");
				}
				break;

			case BID_REMARK :
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y'",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );
				if( lCnt > 0 )
				{
					g_nWorkFlag = 740;
					Card_Move("C6301_LST");
					break;
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "�ڷᰡ �����ϴ�.");
				}
				break;

				break;
			case BID_UNCHG:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30'",0, 0, 0   );
				g_Sql_RetInt( szSql, &lCnt );

				if( lCnt > 0 )
				{
					if( !RcvDate_Chk(ID) )
					{
						return;
					}
				
					g_nWorkFlag = 720;
					Card_Move("C6301_LST");
					break;
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "�ڷᰡ �����ϴ�.");
				}
				break;
			case BID_SLCTCHG:
				if( !RcvDate_Chk(ID) )
				{
					return;
				}
				
				g_nWorkFlag = 730;
				Card_Move("C6301_SELECTCHG");
				break;
			case BID_RESULT:
				Card_Move("C6301_RESULT");
				break;	
			case BID_DATA:
				Card_Move("C6301_DMMENU");
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
/*			
			//�޴���ư
			h = Get_hDlgCtrlByID(BID_OLD);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_MINWON);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_UNCHG);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_SLCTCHG);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_RESULT);
			ButCtrl_SetImage( h,  g_pImgMnTop);
			
			h = Get_hDlgCtrlByID(BID_DATA);
			ButCtrl_SetImage( h,  g_pImgMnTop);
*/

			//2�� �þ�
			//�޴���ư
			h = Get_hDlgCtrlByID(BID_OLD);
			ButCtrl_SetImage( h,  g_pImgGc_Old);
					
			h = Get_hDlgCtrlByID(BID_MINWON);
			ButCtrl_SetImage( h,  g_pImgGc_Mw);

			h = Get_hDlgCtrlByID(BID_REMARK);
			if( FFS_Exist( "img/FHD/Gc_Remark.pngi" ) )
			{
				ButCtrl_SetImage( h,  g_pImgGc_Remark);
			}
			else
			{	
				ButCtrl_SetBkColorEx(h, SKYBLUE);
		    	ButCtrl_SetText(h, "����ǥ��ü");
			}
			
			
			
			h = Get_hDlgCtrlByID(BID_UNCHG);
			ButCtrl_SetImage( h,  g_pImgGc_Imp);
			
			h = Get_hDlgCtrlByID(BID_SLCTCHG);
			ButCtrl_SetImage( h,  g_pImgGc_Sel);
			
			h = Get_hDlgCtrlByID(BID_RESULT);
			ButCtrl_SetImage( h,  g_pImgGc_Ret);
			
			h = Get_hDlgCtrlByID(BID_DATA);
			ButCtrl_SetImage( h,  g_pImgGc_Data);
		}
		
		return;
	}
	
//------------------------------------------------------------------
	bool RcvDate_Chk(long BtnId)
	{
		char szSql[300];
		char szTmp[30];
		long lCnt = 0;
	
		if( BtnId == BID_OLD )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(OBJ_CRT_YMD) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND OBJ_CRT_YMD != '%s'", stUserinfo.szloginday, 0, 0);
			g_Sql_RetInt( szSql, &lCnt );
		}
		else
		{
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			g_Sql_RetStr( "SELECT PARAM4 FROM RCV_LOG WHERE GUBUN = '8'", 30, szTmp );
			if( Str_Cmp(szTmp, "20") == 0 )
			{
				return TRUE;
			}
			else
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(OBJ_CRT_YMD) FROM C6301_CHANGEDATA WHERE OBJ_CRT_YMD != '%s'", stUserinfo.szloginday, 0, 0);
				g_Sql_RetInt( szSql, &lCnt );
			}
		}
		
		if( lCnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�ڷᰡ ���� �����Ͱ� �ƴմϴ�. �ڷḦ ������ϼ���.");
			return FALSE;
		}
		
		return TRUE;
	}
}


