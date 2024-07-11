/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_SMS_VIEW
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
//��ȭ��ȣ����
		DEF_BUTTON_ID ( BID_ADDR )
		DEF_BUTTON_ID ( BID_GM )
		DEF_BUTTON_ID ( BID_CLOSE )
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
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA11 )

		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
	END_OBJECT_ID()
	
	#define INIT_MAIN 1		
		
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

	long m_bFirst;
	long m_lEditCtrlIndex = -1;
	long m_lAddrFlag = 1;		//��ȭ��ȣ����  = 1 ���ּ�, = 0 ���ּ�

	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long Analy_Phone(char*phone, char* num1, char* num2, char* num3 );
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "ȸ�� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),
		
		DLG_BUTTON(STARTX,   	 STARTY+785, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GM, "��ħ���\nȭ����ȯ"),
		DLG_BUTTON(STARTX+600,   STARTY+785, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),

		DLG_TEXT(STARTX,      STARTY-29, 330, 64, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "������ȣ"),
		DLG_TEXT(STARTX+325,  STARTY-29, 675, 64, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),

		DLG_TEXT(STARTX,      STARTY+35, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�⹰��ȣ"),
		DLG_TEXT(STARTX+325,  STARTY+35, 675, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),

		DLG_TEXT(STARTX,      STARTY+95, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "����"),
		DLG_TEXT(STARTX+325,  STARTY+95, 675, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_BUTTON(STARTX,    STARTY+155, 330, 150, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, ""),
		DLG_TEXT(STARTX+325,  STARTY+155, 675, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),

		DLG_TEXT(STARTX,      STARTY+305, 330, 400, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "���Ź��ڳ���"),
		DLG_TEXT(STARTX+325,  STARTY+305, 675, 400, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		
		DLG_TEXT(STARTX,      STARTY+705, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "ȸ�Ű����ڵ�"),
		DLG_TEXT(STARTX+325,  STARTY+705, 675, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
	};	
	
	// ��ȣ���� PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "ȸ�� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,   	 STARTY+790, 400, 109, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GM, "��ħ���\nȭ����ȯ"),
		DLG_BUTTON(STARTX+600,   STARTY+790, 400, 109, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),

		DLG_TEXT(STARTX,      STARTY-40, 330, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "������ȣ"),
		DLG_TEXT(STARTX+325,  STARTY-40, 675, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,      STARTY+30, 330, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�⹰��ȣ"),
		DLG_TEXT(STARTX+325,  STARTY+30, 675, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,      STARTY+100, 330, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "����"),
		DLG_TEXT(STARTX+325,  STARTY+100, 675, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_BUTTON(STARTX,    STARTY+170, 330, 150, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, ""),
		DLG_TEXT(STARTX+325,  STARTY+170, 675, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX,      STARTY+320, 330, 400, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "���Ź��ڳ���"),
		DLG_TEXT(STARTX+325,  STARTY+320, 675, 400, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX,      STARTY+720, 330, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "ȸ�Ű����ڵ�"),
		DLG_TEXT(STARTX+325,  STARTY+720, 675, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
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
		long i;
		char szPhoneNum[32];
		char szPhoneNum1[5];
		char szPhoneNum2[5];
		char szPhoneNum3[5];

		m_bFirst = bFirst;
	
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
				ReDraw();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long nRet = 0;
		long nchkcnt = 0;
		long nCnt = 0;
		char szSql[256];

		switch(ID)
		{
			case BID_GM:
				if( g_nSmsFlag == 5 )
				{
					g_Sql_SaveSeq( "SELECT ROWID FROM GUMDATA ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE", SREACH_FILE);

					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "SELECT count(*) FROM GUMDATA WHERE USE_CONT_NUM = '%s' ",g_szUSE_CONT_NUM,0,0);
					g_Sql_RetInt( szSql, &nCnt );
	
					//2017-08-17 Sanghyun Lee
					//��� ���翩�� Ȯ��
					if( nCnt > 0 )
					{
						Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
						SPRINT(szSql, "SELECT ROWID FROM GUMDATA WHERE USE_CONT_NUM = '%s' ",g_szUSE_CONT_NUM,0,0);
						g_Sql_RetInt( szSql, &g_lindex );
		
						g_nActIndex = g_Get_FsIndex(g_lindex, SREACH_FILE);
						Mem_Set( (byte*)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
		
						g_lDataflag = 0;
						g_nSmsFlag = 0;
						g_nAddrFlag = 0;
						Card_Move("GM_ENTRY");
					}
					else
					{
						MessageBoxEx (WARNING_OK, "����� �����ϴ�.");
					}
				}
				else
				{
					g_nSmsFlag = 0;
					g_nAddrFlag = 1;
					
					Card_Move("GM_SMSGM");
				}
				break;
			case BID_ADDR:
				if( m_lAddrFlag == 1 )
				{
					m_lAddrFlag = 0;
				}
				else
				{
					m_lAddrFlag = 1;
				}
				ReDraw();
				break;
			case BID_OK:
				if( g_nSmsFlag == 5 )
				{
					Card_Move("GM_SMSGM");
				}
				else
				{
					if( g_nGmType == 1 )
					{
						Card_Move("GM_REENTRY");
					}
					else
					{
						Card_Move("GM_ENTRY");
					}
				}
				break;
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

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_TOP);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_TOP);

			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA7), TRUE, 2, EDITSEP_NONE );			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA9), TRUE, 2, EDITSEP_NONE );
		}
	}	
	
//------------------------------------------------------------------
	void ReDraw(void)
	{
		long i = 0;
		long lAddr = 0;
		char szTmp[512];
		char szBuf[512];
	
		Mem_Set((byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set((byte*) szBuf, 0x00, sizeof( szBuf) );
		if( g_nSmsFlag == 5 )
		{	
			//������ȣ
			Mem_Cpy( (byte*)szTmp, (byte*)g_szUSE_CONT_NUM, 5);
			Mem_Cpy( (byte*)szBuf, (byte*)g_szUSE_CONT_NUM+5, 5);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, szBuf);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), szTmp );	
			
			//�⹰��ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), g_szMTR_ID_NUM );

			//����
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), g_szTown );

			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			if( g_nSmsFlag == 5 )
			{
				if( m_lAddrFlag == 1 )
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ� �ּ�");
					//���ּ�
					SPRINT( szTmp, "SELECT CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END FROM GUM_SMS_TARGET WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0 );
				}
				else
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���� �ּ�");
					//���ּ�
					SPRINT( szTmp, "SELECT CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END FROM GUM_SMS_TARGET WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0 );
				}
				g_Sql_RetStr(szTmp, 510, szBuf);
			}
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), szBuf );	//�ּ�
			
			//ȭ���̵� ��ư��
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_GM), "��ħ���\nȭ����ȯ");
		}
		else
		{
			//����ȣ
			Mem_Cpy( (byte*)szTmp, (byte*)stGm.USE_CONT_NUM, 5);
			Mem_Cpy( (byte*)szBuf, (byte*)stGm.USE_CONT_NUM+5, 5);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, szBuf);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), szTmp);	
			
			//�⹰��ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), stGm.MTR_ID_NUM);
			
			//����
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), stGm.CUST_NM);

			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			if( m_lAddrFlag == 1)
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ��ּ�");
			
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				if(Str_Len(stGm.NEW_ROAD_NM) > 0)
				{
					Str_Cpy(szTmp,  stGm.NEW_ROAD_NM );
				}
				else
				{
					Str_Cpy(szTmp,  "" );
				}
				if(Str_Len(stGm.NEW_ADDR_M) > 0)
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.NEW_ADDR_M);
				}
				if(Str_Len(stGm.NEW_ADDR_S) > 0)
				{
					Str_Cat(szTmp,  "-" );
					Str_Cat(szTmp,  stGm.NEW_ADDR_S);
				}
	
				if( Str_Len(stGm.CO_LIVE_NM) > 0 )
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.CO_LIVE_NM );
				}
				else
				{
					Str_Cat(szTmp,  "" );
				}
				if( Str_Len(stGm.BLD_NM) > 0 )
				{
					Str_Cat(szTmp,  " " );	
					Str_Cat(szTmp,  stGm.BLD_NM );
				}
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szTmp,  "-" );	
					Str_Cat(szTmp,  stGm.HOSU );
				}
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.DETA_FLOOR );		//������
				}
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), szTmp);
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���� �ּ�");
			
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				if(Str_Len(stGm.TOWN) > 0)
				{
					Str_Cpy(szTmp,  stGm.TOWN );
				}
				else
				{
					Str_Cpy(szTmp,  "" );
				}
				if(Str_Len(stGm.VILLAGE) > 0)
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.VILLAGE );
				}
				if(Str_Len(stGm.ADDR1_M) > 0)
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.ADDR1_M);
				}			
				if(Str_Len(stGm.ADDR1_S) > 0)
				{
					Str_Cat(szTmp,  "-" );
					Str_Cat(szTmp,  stGm.ADDR1_S);
				}
				
				lAddr = Str_Len(stGm.CO_LIVE_NM) + Str_Len(stGm.BLD_NM);
	
				if( lAddr > 0 )
				{
					if( Str_Len(stGm.CO_LIVE_NM) > 0 )
					{
						Str_Cat(szTmp,  " " );
						Str_Cat(szTmp,  stGm.CO_LIVE_NM );
					}
					else
					{
						Str_Cat(szTmp,  "" );
					}
						
					if( Str_Len(stGm.BLD_NM) > 0 )
					{
						Str_Cat(szTmp,  " " );	
						Str_Cat(szTmp,  stGm.BLD_NM );
					}
					
					if( Str_Len(stGm.HOSU) > 0 )
					{
						Str_Cat(szTmp,  "-" );	
						Str_Cat(szTmp,  stGm.HOSU );
					}
					
					if( Str_Len(stGm.DETA_FLOOR) > 0 )
					{
						Str_Cat(szTmp,  " " );	
						Str_Cat(szTmp,  stGm.DETA_FLOOR );		//������
					}
				}
				else
				{
					if( Str_Len(stGm.HOSU) > 0 )
					{
						Str_Cat(szTmp,  " " );
						Str_Cat(szTmp,  stGm.HOSU );
					}
					else
					{
						Str_Cat(szTmp,  "" );
					}
					
					if( Str_Len(stGm.DETA_FLOOR) > 0 )
					{
						Str_Cat(szTmp,  " " );	
						Str_Cat(szTmp,  stGm.DETA_FLOOR );		//������
					}
				}
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), szTmp);
			}
		
			//ȭ���̵� ��ư��
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_GM), "���ڰ�ħ\nȭ����ȯ");
		}
		
		//���Ź��ڳ���
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), stGm.RCV_SMS_DESC);
		
		//ȸ�Ű����ڵ�
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		SPRINT( szBuf, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C21125' AND CODE_ITEM = '%s'", stGm.RCV_STS_VERIFY_CD, 0, 0 );
		g_Sql_RetStr(szBuf, 50, szTmp);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), szTmp);
		
		ON_DRAW();
		return;
	}

	//------------------------------------------------------------------
	long Analy_Phone(char* phone, char* num1, char* num2, char* num3 )
	{
	long len;
	
		Str_Chg(phone, STRCHG_DEL_NONDIGIT );
		len = Str_Len(phone);
		
		if( len == 9 )
		{
			Mem_Cpy( (byte*)num1, (byte*)phone,  2);
			Mem_Cpy( (byte*)num2, (byte*)phone+2,  3);
			Mem_Cpy( (byte*)num3, (byte*)phone+5,  4);
		}
		else if( len == 10 )
		{
			if( Mem_Cmp((byte*)phone, (byte*)"01", 2) == 0  )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else if(  Mem_Cmp((byte*)phone, (byte*)"02", 2) == 0 )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  2);
				Mem_Cpy( (byte*)num2, (byte*)phone+2,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
		}
		else if( len == 11 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+7,  4);
		}
		else if( len == 12 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,  4);
				Mem_Cpy( (byte*)num2, (byte*)phone+4,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+8,  4);
		}
		else
		{
			return -1;
		}
		
		return 1;
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

		for ( i = 0 ; CT[i].Code[0] != 0 ; i++)
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
}



