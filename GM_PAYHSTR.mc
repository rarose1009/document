/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_PAYHSTR
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
		DEF_BUTTON_ID ( BID_UP )			//����
		DEF_BUTTON_ID ( BID_DOWN )			//��
		DEF_BUTTON_ID ( BID_ADDR )			//����
		DEF_BUTTON_ID ( BID_ADDR2 )			//��
		DEF_BUTTON_ID ( BID_UNPAYMONEY )	//�̳��ݾ�
	//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )	//Ȩ
		DEF_BUTTON_ID ( BID_MENU )	//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )	//����
		DEF_BUTTON_ID ( BID_EXIT )	//����
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_CNTRCTNUM ) //����ȣ
		DEF_OBJECT_ID ( TXT_NAME ) 		//����/��ȣ
		DEF_OBJECT_ID ( TXT_PAGE )		//��������
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )

		DEF_OBJECT_ID ( ID_TBLLIST ) // ���̺� ����Ʈ
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	#define INIT_MAIN	1	
	
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+12)			// table �� ����
	#define		GRID_H_P	(CHT+17)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 				// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+330  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+290  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"û�����", CWD*11  , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"C", 		 CWD*3   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ħ��",   CWD*7   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��뷮",   CWD*9   , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ݾ�", 	 CWD*9+23, EDITALIGN_RIGHT|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	long 	m_lpage = 0;			// ���� ������
	long 	m_lTotpage = 0;			// �� ������ 
	long    m_lGmTot = 0;
	long    m_lChkRow = 0;
	char 	m_szCnt_page[10];
	
	void SetStyle(void);
	void REDRAW(void);		//��ħ ���
	void SetBtnImg(void);
	void Rcv_paymant(void);
	long TR24231(void);
	void Rcv24232(void);
	long TR24232(void);
	long FS_GetSrchTotCnt(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��� ����"),

		DLG_BUTTON(STARTX,  	STARTY+120, 250, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		//DLG_BUTTON(STARTX+150, STARTY+120, 100, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "��"),
		DLG_BUTTON(STARTX, 		STARTY+270, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UNPAYMONEY, "�̳��ݾ�"),		
		DLG_BUTTON(STARTX+600,  STARTY+270, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+800,  STARTY+270, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),		
		
		DLG_TEXT(STARTX, 	 STARTY+65, 250, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CNTRCTNUM, "����ȣ"), //����ȣ
		DLG_TEXT(STARTX+250, STARTY+65, 425, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+675, STARTY+65, 325, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_TEXT(STARTX+250, STARTY+120, 750, 90, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""), 	
		DLG_TEXT(STARTX, 	 STARTY+210, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NAME, "����/��ȣ"), 		//����/��ȣ
		DLG_TEXT(STARTX+250, STARTY+210, 750, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 	
		DLG_TEXT(STARTX+250, STARTY+270, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_NONE, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "��� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY+30, 250, 120, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		//DLG_BUTTON(STARTX+150, STARTY+60, 100, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "��"),
		DLG_BUTTON(STARTX,     STARTY+220, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UNPAYMONEY, "�̳��ݾ�"),		
		DLG_BUTTON(STARTX+500, STARTY+220, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+750, STARTY+220, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),		
		
		DLG_TEXT(STARTX,      STARTY-40, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CNTRCTNUM, "����ȣ"), //����ȣ
		DLG_TEXT(STARTX+250,  STARTY-40, 475, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+725,  STARTY-40, 275, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		
		DLG_TEXT(STARTX+250,  STARTY+30, 750, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,     STARTY+150, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NAME, "����/��ȣ"), 		//����/��ȣ
		DLG_TEXT(STARTX+250, STARTY+150, 750, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX+250, STARTY+220, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		// ����Ʈ
		DLG_TABLE(GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_NONE, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
			{
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
				
				if( g_lPAYFlag == 0)
				{
					Rcv_paymant();
					g_lPAYFlag = 1;
				}
				else
				{
					REDRAW();
				}
			}	
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
		}
	}
	
	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CNTRCTNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NAME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA2), TRUE, 2, EDITSEP_NONE );
	}

	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{				
			case BID_ADDR:
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����");
				}
				REDRAW();
				break;				
			case BID_ADDR2:
				break;
			case BID_UP:
				m_lpage =m_lpage - ROW ;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				REDRAW();
				break;			
			case BID_DOWN:
				m_lpage =m_lpage + ROW ;
				if( m_lpage > m_lTotpage )
				{
					m_lpage = m_lpage-ROW;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					//REDRAW();
					break;
				}
				REDRAW();
				break;	
			case BID_UNPAYMONEY:
				Card_Load("GM_NOPAY");
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( g_nWorkFlag < 200 )
					{
						g_lMoveFlag = 0;
						g_lDataflag = 0;
						Card_Move("MENU");	
					}
					else
					{
						g_Del_ScData();
						g_lSCMoveFlag = 0;
						g_lDataflag = 0;
						g_lMoveFlag = 0;
						Card_Move("MENU");
					}
				}
				break;
			case GID_MENU:
				if( g_nWorkFlag < 200 )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "��ħ �޴��� �����ðڽ��ϱ�?")  == MB_OK)
					{
						g_lMoveFlag = 0;
						g_lDataflag = 0;
						Card_Move("GM_MENU");
					}
				}
				else
				{
					if( MessageBoxEx (CONFIRM_YESNO, "�������� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
					{
						g_Del_ScData();
						g_lSCMoveFlag = 0;
						g_lDataflag = 0;
						g_lMoveFlag = 0;
						Card_Move("SC_MENU");
					}
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
				if( g_nPhotoFlag == 1 )
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
				else if( g_nPhotoFlag == 2 )
				{
					Card_Move("SC_MTRCHK");
				}
				else if( g_nPhotoFlag == 3 )
				{
					Card_Move("BS_MTRINFO");
				}
				break;	
			case GID_VMEXIT:
				if( g_nWorkFlag < 200 )
					g_Exit();
				else
				{
					g_Exit_DelScData();
				}
				return;
		}
	}
	
//--------------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		char szAddr[200];
		char szName[50];
		char sztmp[200];
		char szDP[20];
		long lAddr = 0;
		long lNopay;		//�̳��ݾ�
		long lTotal = 0;		//�̳��Ѿ�
		long i, idx;
		long j = 0;
		long ret = -1;
		long k = ROW+1;
		long lstartidx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		char szBld[50];
		char szColive[50];
		long nLength = 0;
		
		Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
		Mem_Set((byte*)szName, 0x00, sizeof(szName));
	
		if( g_nPhotoFlag == 1 )
		{
			Str_Cpy(g_szMTR_NUM, stGm.MTR_NUM);	//�跮���ȣ
			Str_Cpy(g_szCUST_NUM, stGm.CUST_NUM);	//����ȣ
			Str_Cpy(g_szUSE_CONT_NUM, stGm.USE_CONT_NUM);	//������ȣ
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Cpy((byte*)sztmp, (byte*)g_szUSE_CONT_NUM, 5);
			sztmp[5] = '-';
			Mem_Cpy((byte*)sztmp+6, (byte*)g_szUSE_CONT_NUM+5, 5);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), sztmp);
		
			if( g_nAddrFlag == 0)
			{
				//�⺻�ּ�
				Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
				if(Str_Len(stGm.TOWN) > 0)
				{
					Str_Cpy(szAddr,  stGm.TOWN );
				}
				else
				{
					Str_Cpy(szAddr,  "" );
				}
				if(Str_Len(stGm.VILLAGE) > 0)
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.VILLAGE );
				}
				if(Str_Len(stGm.ADDR1_M) > 0)
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.ADDR1_M);
				}			
				if(Str_Len(stGm.ADDR1_S) > 0)
				{
					Str_Cat(szAddr,  "-" );
					Str_Cat(szAddr,  stGm.ADDR1_S);
				}
				Str_Cat(szAddr, "\n");
				//���ּ�
				lAddr = Str_Len(stGm.CO_LIVE_NM) + Str_Len(stGm.BLD_NM);
	
				if( lAddr > 0 )
				{
					if( Str_Len(stGm.CO_LIVE_NM) > 0 )
					{
						Str_Cat(szAddr,  stGm.CO_LIVE_NM );
					}
					else
					{
						Str_Cat(szAddr,  "" );
					}
						
					if( Str_Len(stGm.BLD_NM) > 0 )
					{
						Str_Cat(szAddr,  " " );	
						Str_Cat(szAddr,  stGm.BLD_NM );
					}
					
					if( Str_Len(stGm.HOSU) > 0 )
					{
						Str_Cat(szAddr,  "-" );	
						Str_Cat(szAddr,  stGm.HOSU );
					}
					
					if( Str_Len(stGm.DETA_FLOOR) > 0 )
					{
						Str_Cat(szAddr,  " " );	
						Str_Cat(szAddr,  stGm.DETA_FLOOR );		//������
					}
				}
				else
				{
					if( Str_Len(stGm.HOSU) > 0 )
					{
						Str_Cat(szAddr,  stGm.HOSU );
					}
					else
					{
						Str_Cat(szAddr,  "" );
					}
					
					if( Str_Len(stGm.DETA_FLOOR) > 0 )
					{
						Str_Cat(szAddr,  " " );	
						Str_Cat(szAddr,  stGm.DETA_FLOOR );		//������
					}
				}
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), szAddr);
			}
			else
			{
				//�⺻�ּ�
				Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
				if(Str_Len(stGm.NEW_ROAD_NM) > 0)
				{
					Str_Cpy(szAddr,  stGm.NEW_ROAD_NM );
				}
				else
				{
					Str_Cpy(szAddr,  "" );
				}
				if(Str_Len(stGm.NEW_ADDR_M) > 0)
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.NEW_ADDR_M);
				}
				if(Str_Len(stGm.NEW_ADDR_S) > 0)
				{
					Str_Cat(szAddr,  "-" );
					Str_Cat(szAddr,  stGm.NEW_ADDR_S);
				}
				Str_Cat(szAddr, "\n");
				
				//���ּ�
				Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
				if( Str_Len(stGm.CO_LIVE_NM) > 0 )
				{
					Str_Cpy(szAddr,  stGm.CO_LIVE_NM );
				}
				else
				{
					Str_Cpy(szAddr,  "" );
				}
				if( Str_Len(stGm.BLD_NM) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.BLD_NM );
				}
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szAddr,  "-" );	
					Str_Cat(szAddr,  stGm.HOSU );
				}
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.DETA_FLOOR );		//������
				}
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), szAddr);
			}
						/*
			//����
			Str_Cpy(szName,  stGm.CUST_NM );
			if(Str_Len(stGm.FIRM_NM ) > 0)
			{
				Str_Cat(szName,  "/" );
				Str_Cat(szName,  stGm.FIRM_NM );
			}
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), szName);
	
			if( g_nAddrFlag == 0)
			{
				if(Str_Len(stGm.TOWN) > 0)			//���鵿
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.TOWN );
				}
				if(Str_Len(stGm.TOWN) > 0)			//���鵿
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.TOWN );
				}

				if(Str_Len(stGm.ADDR1_M) == 0)		//����
				{
					Str_Cat(szAddr,  " " );	
				}
				else
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.ADDR1_M);
				}			
				if(Str_Len(stGm.ADDR1_S) == 0)		//�ι�
				{
					Str_Cat(szAddr,  " " );	
				}
				else
				{
					Str_Cat(szAddr,  "-" );
					Str_Cat(szAddr,  stGm.ADDR1_S);
				}
				
				//��ȸȭ�鿡���� �ּ�
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.CO_LIVE_NM );	//�������ø�
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.BLD_NM );		//�ǹ���
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.DONG_NUM );	//����ȣ
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.HOSU );		//ȣ��
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.DETA_FLOOR );		//������
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), szAddr);
			}
			else
			{
				Str_Cpy(szAddr,  stGm.AREA );		//�ñ���
				
				if(Str_Len(stGm.NEW_ROAD_NM) != 0)
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.NEW_ROAD_NM );
				}
				if(Str_Len(stGm.NEW_ADDR_M) == 0)
				{
					Str_Cat(szAddr,  " " );	
				}
				else
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.NEW_ADDR_M);
				}
				if(Str_Len(stGm.NEW_ADDR_S) == 0)
				{
					Str_Cat(szAddr,  " " );	
				}
				else
				{
					Str_Cat(szAddr,  "-" );
					Str_Cat(szAddr,  stGm.NEW_ADDR_S);
				}
				
				//��ȸȭ�鿡���� �ּ�
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.CO_LIVE_NM );
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.BLD_NM );
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.DONG_NUM );
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.HOSU );
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.DETA_FLOOR );		//������
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), szAddr);
			}
			*/
		}
		else if( g_nPhotoFlag == 2 )
		{
			Str_Cpy(g_szMTR_NUM, stScMtr.MTR_NUM);	//�跮���ȣ
			Str_Cpy(g_szCUST_NUM, stScMtr.CUST_NM);	//����ȣ
			Str_Cpy(g_szUSE_CONT_NUM, stSc.USE_CONT_NUM);	//������ȣ

			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_CNTRCTNUM), "����ȣ");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), stScMtr.CUST_NUM);
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			
			//����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), stScMtr.CUST_NM);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), FALSE);
	
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_CNTRCTNUM), STARTX,     STARTY+65,  STARTX+250, STARTY+165);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_NAME),      STARTX,     STARTY+165, STARTX+250, STARTY+265);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_PAGE),      STARTX+725, STARTY+65,  STARTX+1000, STARTY+165);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA1),     STARTX+250, STARTY+65,  STARTX+725, STARTY+165);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA3),     STARTX+250, STARTY+165, STARTX+1000, STARTY+265);
			}
			else
			{
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_CNTRCTNUM), STARTX,     STARTY-40, STARTX+250, STARTY+90);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA1),     STARTX+250, STARTY-40, STARTX+725, STARTY+90);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_PAGE),      STARTX+725, STARTY-40, STARTX+1000, STARTY+90);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_NAME),      STARTX,     STARTY+90, STARTX+250, STARTY+220);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA3),     STARTX+250, STARTY+90, STARTX+1000, STARTY+220);
			}
			
		}
		else if( g_nPhotoFlag == 3 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_CNTRCTNUM), "����ȣ");
			
			Str_Cpy(g_szMTR_NUM, stBsMtr.MTR_NUM);	//�跮���ȣ
			Str_Cpy(g_szCUST_NUM, stBsMtr.CUST_NUM);	//����ȣ
			Str_Cpy(g_szUSE_CONT_NUM, stBsMtr.USE_CONT_NUM);	//������ȣ
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), stBsMtr.CUST_NUM);
			
			//����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), stBsMtr.FIRM_NM);
			
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA2), FALSE);
	
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_CNTRCTNUM), STARTX,     STARTY+65,  STARTX+250, STARTY+165);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_NAME),      STARTX,     STARTY+165, STARTX+250, STARTY+265);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA1),     STARTX+250, STARTY+65,  STARTX+725, STARTY+165);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_PAGE),      STARTX+725, STARTY+65,  STARTX+1000, STARTY+165);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA3),     STARTX+250, STARTY+165, STARTX+1000, STARTY+265);
			}
			else
			{
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_CNTRCTNUM), STARTX,     STARTY-40, STARTX+250, STARTY+90);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA1),     STARTX+250, STARTY-40, STARTX+725, STARTY+90);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_PAGE),      STARTX+725, STARTY-40, STARTX+1000, STARTY+90);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_NAME),      STARTX,     STARTY+90, STARTX+250, STARTY+220);
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA3),     STARTX+250, STARTY+90, STARTX+1000, STARTY+220);
			}
		}

		//��ݳ���
		if( g_nPhotoFlag == 1 )
		{
/*
			m_lTotpage = FS_GetSrchTotCnt();
			SPRINT(m_szCnt_page, "%d/%d ", g_nActIndex+1, m_lTotpage, 0);
*/
			g_Sql_RetInt("SELECT COUNT(*) FROM PAY_AMT ", &m_lTotpage);
			
			m_lGmTot = FS_GetSrchTotCnt();
			SPRINT(m_szCnt_page, "%d/%d ", g_nActIndex+1, m_lGmTot, 0);
		}
		else
		{
			g_Sql_RetInt("SELECT COUNT(*) FROM PAY_AMT ", &m_lTotpage);
			if(m_lTotpage > 0)
			{
				SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
			}
			else
			{
				SPRINT(m_szCnt_page, "0", 0, 0, 0);
			}
		}
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT REQ_YM, GMTR_JOB_CD, INDI_COMPENS_THIS_MM_VC, SET_QTY, THIS_MM_OCCU_AMT FROM PAY_AMT ORDER BY REQ_YM DESC  LIMIT ?, ?");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lpage;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		//Ÿ��Ʋ �� ����
		EditCtrl_SetBkColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, -1, 3 ), CORAL);
		EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, -1, 3 ), WHITE);
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0; i < ROW; i++)
		{
				if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
					continue;
				}

				//û�����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				idx = 0;
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 9, DECRYPT);
				g_Str_DateType(szDP, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, szDP );
				//��ħ�ڵ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 4, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//��ħ��ħ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//��뷮
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//�ݾ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'C', (long*)sztmp, 9, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				
			}
		}

		if( m_lChkRow > 0 )		
		{
			g_Sql_RetInt("SELECT SUM(UNPAY_AMT) FROM PAY_NOAMT ", &lTotal);
			Str_ItoA(lTotal, sztmp, 10);
			Str_Chg(sztmp, STRCHG_INS_COMMA);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), sztmp);
		}
		else
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), sztmp);
			lTotal = 0;
		}
		
		
		if( lTotal > 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_UNPAYMONEY), TRUE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_UNPAYMONEY), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_UNPAYMONEY), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_UNPAYMONEY), TRUE );
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
	void Rcv_paymant(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
	char szSql[300];
	
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		Str_Cpy	( szSql,"DELETE FROM PAY_AMT " );
		g_Sql_DirectExecute( szSql );

		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
		Str_Cpy	( szSql,"DELETE FROM PAY_NOAMT " );
		g_Sql_DirectExecute( szSql );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 24231, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "mtr_num",      g_szMTR_NUM);
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", g_szUSE_CONT_NUM);

		sndbuf = JSON_toString(g_pjcomm);
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR24231; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR24231_IN",  "FR24231" , sndbuf, sztmp );
	}
	
	long TR24231(void)
	{
		m_lChkRow = g_Chk_Json(24231);
		
		if( m_lChkRow >= 0)
		{
			Rcv24232();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			g_Sock_Close();
			return -1;
		}
	}
	
	void Rcv24232(void)
	{
	char sztmp[32];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 24232, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",      g_szMTR_NUM);
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", g_szUSE_CONT_NUM);

		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR24232; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR24232_IN",  "FR24232" , sndbuf, sztmp );
	}
	
	long TR24232(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(24232) >= 0)
		{
			//MessageBoxEx (CONFIRM_OK, "�����ȸ�� �Ϸ��Ͽ����ϴ�.");
			REDRAW();
			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	
	/*=======================================================================================
	�Լ��� : FS_GetSrchTotCnt
	��  �� : �˻��ε��������� ���ڵ� ���� �����Ѵ�.
	Param  : nPos:�˻� �ε��� ������ ����
 	Return : ���ڵ��
	========================================================================================*/
	long FS_GetSrchTotCnt(void)
	{
		long size = 0;
		
		size = FFS_GetSize( SREACH_FILE );
		size = size/SRCH_FS_SIZE;
		return size;
	}

}
