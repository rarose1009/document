/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_STOPCANCEL
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
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )
		DEF_BUTTON_ID ( BID_PREVLST )
		DEF_BUTTON_ID ( BID_NEXTLST )
		DEF_BUTTON_ID ( BID_STOPCANCEL )
		DEF_BUTTON_ID ( BID_WRITE )
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
		DEF_OBJECT_ID ( TXT_PAGE )
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )

		DEF_OBJECT_ID ( EDT_DATA1 )
		
		DEF_OBJECT_ID ( LINE_DATA1 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( ID_TBLLIST ) 	// ���̺� ����Ʈ
	END_OBJECT_ID()
	
	#define INIT_MAIN	1

	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4					// table�� �ళ��
	#define		COL 	    8					// table�� ������
	#define		GRID_H		(CHT+20)			// table �� ����
	#define		GRID_H_P	(CHT+30)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+175  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�⹰��ȣ", 	CWD*15,   EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ü����", 		CWD*15,   EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����", 		CWD*9+23,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�����ġ", 	CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���", 		CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ǰ��", 		CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"MTR_NUM", 	CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CONT_STS_CD", CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};

		
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
	
	typedef struct _STOPCANCEL
	{
		char NONPAY_ACTIVE_FLAG[10];
		char ACTIVE_RSLT_DESC[300];
		char NONPAY_CENTER_CD[10];
		char TAKER_NM[50];
		char CUT_JOB_FLAG[10];
		char MTR_NUM[20];
	}	STOPCANCEL;
	
	STOPCANCEL	m_stStopCancel;

	long m_lActIndex = -1;
	long m_lTotCnt = 0;
	long m_lTotpage = 0;
	long m_lPage = 0;
	char m_szCnt_page[10];
	char m_szContStsCd[10];

	void SetBtnImg(void);
	void SetStyle(void);
	void AddrDraw(void);
	void ReDraw(void);
	long Rcv_Mtr(void);
	long TR81205(void);
	long Snd_StopCancel(void);
	long TR82217(void);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�ߴܴ�����"),

		DLG_BUTTON(STARTX,       STARTY+65, 250, 110, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_BUTTON(STARTX+500,  STARTY+472, 250, 63, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750,  STARTY+472, 250, 63, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX+600,  STARTY+829, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOPCANCEL, "�ߴܴ�����"),

		DLG_TEXT(STARTX+250,    STARTY+65, 750,110, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,       STARTY+472, 300, 63, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_TEXT(STARTX,       STARTY+535, 250, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�����ġ"),
		DLG_TEXT(STARTX+250,   STARTY+535, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX+550,   STARTY+535, 150, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "���"),
		DLG_TEXT(STARTX+700,   STARTY+535, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,       STARTY+595, 250, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "��ǰ��"),
		DLG_TEXT(STARTX+250,   STARTY+595, 750, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX,       STARTY+675, 250, 150, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, "��һ���"),
		DLG_BUTTON( STARTX+250,   STARTY+675, 750, 150, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
		DLG_TEXT(STARTX+250,   STARTY+675, 750, 150, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, ""),

		DLG_LINE(0, STARTY+665, 1000, STARTY+665, BLUE, 2, LINE_DATA1),
		
		//����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�ߴܴ�����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,       STARTY+70, 250, 100, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_BUTTON(STARTX+450,  STARTY+475, 250, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+735,  STARTY+475, 250, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX+635,  STARTY+800, 350, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOPCANCEL, "�ߴܴ�����"),

		DLG_TEXT(STARTX+250,    STARTY+70, 735,100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,       STARTY+475, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_TEXT(STARTX,       STARTY+535, 250, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2, "�����ġ"),
		DLG_TEXT(STARTX+250,   STARTY+535, 300, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX+550,   STARTY+535, 150, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4, "���"),
		DLG_TEXT(STARTX+700,   STARTY+535, 285, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,       STARTY+595, 250, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA6, "��ǰ��"),
		DLG_TEXT(STARTX+250,   STARTY+595, 735, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX,       STARTY+675, 250, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA8, "��һ���"),
		DLG_BUTTON( STARTX+250,   STARTY+675, 735, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
		DLG_TEXT(STARTX+250,   STARTY+675, 735, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, ""),

		DLG_LINE(0, STARTY+665, 1000, STARTY+665, BLUE, 2, LINE_DATA1),
		
		//����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
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

				SetBtnImg();	
				SetStyle();
				AddrDraw();
				Rcv_Mtr();
				ON_DRAW();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_ADDR:
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				AddrDraw();
				ON_DRAW();
				break;
			case BID_PREVLST:
				m_lPage--;
				if(m_lPage < 0)
				{
					m_lPage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//ReDraw();
					break;
				}
				ReDraw();
				break;			
			case BID_NEXTLST:
				m_lPage++ ;
				if( m_lPage > m_lTotpage-1 )
				{
					m_lPage = m_lTotpage-1;
					if(m_lPage < 0)
					{
						m_lPage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					//ReDraw();
					break;
				}
				ReDraw();
				break;
			case BID_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				break;
			case BID_STOPCANCEL:
				Snd_StopCancel();
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
				Card_Move("C6202_NPACTIVE");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}		

//------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long index;

		//���� TBL�� ���õǾ������� Ȯ��
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// ���� ���õ� �ε���
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			m_lActIndex = index - 1;
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 3) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5) );
			Mem_Set( (byte*)m_szContStsCd, 0x00, sizeof(m_szContStsCd) );
			Str_Cpy(m_szContStsCd, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 7));
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
	
//------------------------------------------------------------------
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA1), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(EDT_DATA1), TRUE, 2, EDITSEP_NONE );
	}
	
//------------------------------------------------------------------	
	void AddrDraw(void)
	{
		char szTmp[400];
	
		//�ּ�
		if( g_nAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����\n�ּ�");
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, stNoPayObj.AREA);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.TOWN);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.VILLAGE);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.ADDR1_M);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stNoPayObj.ADDR1_S);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�\n�ּ�");
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, stNoPayObj.NEW_ROAD_NM);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.NEW_ADDR_M);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stNoPayObj.NEW_ADDR_S);
		}
		
		if( ( Str_Len(stNoPayObj.CO_LIVE_NM) + Str_Len(stNoPayObj.BLD_NM) ) > 0 )
		{
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.CO_LIVE_NM);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.BLD_NM);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stNoPayObj.HOSU);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.DETAIL_FLOOR);
		}
		else
		{
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.HOSU);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.DETAIL_FLOOR);
		}
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1),  szTmp);

		return;
	}
	
//------------------------------------------------------------------
	void ReDraw(void)
	{
		long i, idx;
		long k = ROW + 1;
		char sztmp[201];
		char szDate[50];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lTotpage );
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		//������
		SPRINT(m_szCnt_page, "%d/%d", m_lPage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT PARAM5, PARAM3, PARAM1, PARAM6, PARAM12, PARAM10, PARAM4, PARAM2 FROM RCV_TMP LIMIT ?, ?" );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lPage*ROW;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lPage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
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
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, "" );
					continue;
				}

				idx = 0;
				//�⹰��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//ü����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//�����ġ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//��ǰ��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 100, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				//�跮���ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
				//CONT_STS_CD
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
			}
		}		

Finally:

		if(m_lTotpage > 0)
		{
			if( m_lActIndex == -1 )
			{
				m_lActIndex = 0;
			}

			DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 3) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4) );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5) );
			Mem_Set( (byte*)m_szContStsCd, 0x00, sizeof(m_szContStsCd) );
			Str_Cpy(m_szContStsCd, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 7));
		}

		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		return;
	}
	
	
//------------------------------------------------------------------
	long Rcv_Mtr(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 81205, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR81205; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR81205_IN",  "FR81205" , sndbuf, sztmp );
		
		return 0 ;
	}
	
	
//------------------------------------------------------------------
	long TR81205(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(81205) >= 0)
		{
			ReDraw();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
//------------------------------------------------------------------
	long Snd_StopCancel(void)
	{
		char szMsg[500];
		char szUrl[200];
		char szbuf[128];
		char szActive_rslt_desc[350];
		char szTime[20];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;

		if( Str_Cmp(m_szContStsCd, "30") == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "�������°� ������ ��� ����� �� �����ϴ�.");
			return -1;
		}
		if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "�����Ƿ� ��һ����� �Է��ϼ���.");
			return -1;
		}
		
		Mem_Set( (byte*)szActive_rslt_desc, 0x00, sizeof(szActive_rslt_desc) );
		Str_Cpy( szActive_rslt_desc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		nLen = g_GetUtf8Size(szActive_rslt_desc);
		if( nLen > 300 )
		{
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "�������!\n(�޸�� �ѱ� 100��,\n����.���� 300�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szMsg);
			return -1;
		}
		
		if( MessageBoxEx (CONFIRM_YESNO, "�ߴܴ�� ��Ҹ� ��� �Ͻðڽ��ϱ�?")  != MB_OK)
		{
			return -1;
		}
		
		Mem_Set((byte*)&m_stStopCancel, 0x00, sizeof(m_stStopCancel));
		
		SQL_ConvUcStr( m_stStopCancel.ACTIVE_RSLT_DESC, szActive_rslt_desc );
		Str_Cpy(m_stStopCancel.NONPAY_ACTIVE_FLAG, "320");
		Str_Cpy(m_stStopCancel.NONPAY_CENTER_CD, stUserinfo.szcenter_cd);
		SQL_ConvUcStr( m_stStopCancel.TAKER_NM, stUserinfo.sznm_kor );
		Str_Cpy(m_stStopCancel.CUT_JOB_FLAG, "10");
		Str_Cpy(m_stStopCancel.MTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 6));
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82217, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",             stNoPayObj.USE_CONT_NUM             );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_flag",       m_stStopCancel.NONPAY_ACTIVE_FLAG   );
		JSON_SetValue( g_pjcomm, 'C', "active_rslt_desc",         m_stStopCancel.ACTIVE_RSLT_DESC     );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_dept",       stNoPayObj.NONPAY_ACTIVE_DEPT       );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone",       stNoPayObj.NONPAY_MANAGE_ZONE       );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_center_cd",         m_stStopCancel.NONPAY_CENTER_CD     );
		JSON_SetValue( g_pjcomm, 'C', "taker_nm",                 m_stStopCancel.TAKER_NM             );
		JSON_SetValue( g_pjcomm, 'C', "cut_job_flag",             m_stStopCancel.CUT_JOB_FLAG         );
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",                  m_stStopCancel.MTR_NUM              );
				
		sndbuf = JSON_toString(g_pjcomm);
		
		//���۵����� Ȯ��
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR82217; //��ſϷ� �Ŀ� ȣ�� �Լ�
		HTTP_DownloadData( szUrl, "FR82217_IN",  "FR82217" , sndbuf, szbuf );

		return 1;
	}
	
//------------------------------------------------------------------
	long TR82217(void)
	{
		char szSql[350];
	
		if(g_Chk_Json(82217) >= 0)
		{
			//g_nWorkFlag = 830 > ����Ȱ��
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			if( g_nWorkFlag == 830 )
			{
				SPRINT(szSql, "UPDATE C6202_STOP_OBJ SET STOP_FLAG = 'N' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			else if( g_nWorkFlag == 810 )
			{
				//����Ȱ�� ���
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ_PART SET STOP_FLAG = 'N' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			else
			{
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET STOP_FLAG = 'N' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			
			Str_Cpy(stNoPayObj.STOP_FLAG, "N");
			MessageBoxEx (CONFIRM_OK, "����Ǿ����ϴ�.");
			Card_Move("C6202_NPACTIVE");
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

}


