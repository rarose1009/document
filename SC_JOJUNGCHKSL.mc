/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_JOJUNGCHKSL
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
	#define USE_ON_UART
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CHECK )		//����
		DEF_BUTTON_ID ( BID_BARCODE )	//���ڵ�
		DEF_BUTTON_ID ( BID_PHOTO )	    //�Կ�
		DEF_BUTTON_ID ( BID_SIGN )		//����
		DEF_BUTTON_ID ( BID_COMPLETE )	//�Ϸ�
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
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_JJGNUM )		//�������ȣ
		DEF_OBJECT_ID ( TXT_JUNSOO )		//����
		DEF_OBJECT_ID ( TXT_WORKTYPE )		//�۾�����
		DEF_OBJECT_ID ( TXT_FORM )			//����
		DEF_OBJECT_ID ( TXT_MODELNM )		//�𵨸�
		DEF_OBJECT_ID ( TXT_JJGSN )			//������S/N
		DEF_OBJECT_ID ( TXT_NO )			//NO

		DEF_OBJECT_ID ( TXT_FILTERCHNG )	//���ͱ�ü����
		DEF_OBJECT_ID ( TXT_ETC )			//Ư�̻���
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )			
		DEF_OBJECT_ID ( TXT_DATA8 )

		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ

		DEF_OBJECT_ID ( CMB_FILTERCHNG ) 	
		DEF_OBJECT_ID ( CMB_ETC = CMB_FILTERCHNG+3 ) 			
		DEF_OBJECT_ID ( CMB_BARCODE = CMB_ETC+3 )
	END_OBJECT_ID()
	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+30)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		100 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+330  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY+285  	    // table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�����׸�"    , CWD*25+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"��"          , CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"��ġ"        , CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"�����׸��ڵ�", 0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{""            , 0     , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1
	#define INIT_JJCHK	2
	
	//üũ�ڽ� �� 
	#define CHKYES 1
	#define CHKNO  0

	long m_bFirst;
	CodeTable *m_CT;
	long m_nSec_cd;
	long m_lpage = 0;
	long m_lTotpage= 0;
	char m_szCnt_page[10];
	long m_lIdxFlag = 0;	// index ���� flag
	long m_lActive = -1;
	char m_Title[30];
	char m_szfilenm[128];
	char m_szBarcode_Value[20];	//���ڵ� ��ĵ ���
	
	void SetStyle(void);
	void SetCombo(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void Tbl_Draw(void);
	void Save_Sign(void);
	bool Save_Result(void);
	void Del_Sc(void);
	bool Validate(void);
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	void Barcode(void);
	void OnBarcodeRead(void);
	void Save_Row(long row, long col);
	bool Save_NotPassItem(char* szREGTR_NOT_PASS_ITEM, char* szCHKGOODYN );
	void Shoto_Photo(void);

	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ ����(�ܵ�)"),
		
		DLG_TEXT(STARTX,       STARTY+65, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGNUM, "�������ȣ"), 
		DLG_TEXT(STARTX+300,   STARTY+65, 325, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+625,   STARTY+65, 200, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JUNSOO, "����"),
		DLG_TEXT(STARTX+825,   STARTY+65, 175, 55, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,      STARTY+120, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKTYPE, "�۾�����"), 
		DLG_TEXT(STARTX+300,  STARTY+120, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,      STARTY+170, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "����"), 
		DLG_TEXT(STARTX+300,  STARTY+170, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,      STARTY+220, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODELNM, "�𵨸�"), 
		DLG_TEXT(STARTX+300,  STARTY+220, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,      STARTY+270, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGSN, "������S/N"),
		DLG_TEXT(STARTX+300,  STARTY+270, 700, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT(STARTX,      STARTY+690, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FILTERCHNG, "���ͱ�ü����"),
		DLG_COMBO (STARTX+350,STARTY+690, 650, 290, 150, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_FILTERCHNG, 10),
		DLG_TEXT(STARTX,      STARTY+750, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ETC, "Ư�̻���"),
		DLG_COMBO (STARTX+350,STARTY+750, 650, 290, 150, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ETC, 10),
		
//		DLG_BUTTON(STARTX,    STARTY+570, 300, 140, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "���ڵ�"),
//		DLG_TEXT(STARTX+300,  STARTY+570, 675,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
//		DLG_COMBO(STARTX+300, STARTY+640, 675, 290, 100, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BARCODE, 10),
		
		DLG_BUTTON(STARTX    , STARTY+819, 333, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "�����Կ�"),
		DLG_BUTTON(STARTX+333, STARTY+819, 333, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "����"),
		DLG_BUTTON(STARTX+666, STARTY+819, 334, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPLETE, "�Ϸ�"),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "������ ����(�ܵ�)"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_TEXT(STARTX,  	   STARTY-40, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGNUM, "�������ȣ"), 
		DLG_TEXT(STARTX+300,   STARTY-40, 325, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+625,   STARTY-40, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JUNSOO, "����"),
		DLG_TEXT(STARTX+825,   STARTY-40, 175, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,  	   STARTY+25, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKTYPE, "�۾�����"), 
		DLG_TEXT(STARTX+300,   STARTY+25, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,       STARTY+90, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "����"), 
		DLG_TEXT(STARTX+300,   STARTY+90, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,  	  STARTY+155, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODELNM, "�𵨸�"), 
		DLG_TEXT(STARTX+300,  STARTY+155, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,  	  STARTY+220, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGSN, "������S/N"),
		DLG_TEXT(STARTX+300,  STARTY+220, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		//DLG_BUTTON(STARTX,     STARTY+310, 350, 80, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK, "����"),
		//DLG_TEXT(STARTX+350,   STARTY+310, 625, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT(STARTX,  	   STARTY+640, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FILTERCHNG, "���ͱ�ü����"),
		DLG_COMBO (STARTX+350, STARTY+640, 650, 290, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_FILTERCHNG, 10),
		DLG_TEXT(STARTX,  	   STARTY+720, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ETC, "Ư�̻���"),
		DLG_COMBO (STARTX+350, STARTY+720, 650, 280, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_ETC, 10),
		
//		DLG_BUTTON(STARTX,	   STARTY+560, 300, 160, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "���ڵ�"),
//		DLG_TEXT(STARTX+300,   STARTY+560, 675, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
//		DLG_COMBO (STARTX+300, STARTY+640, 675, 160, 80, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BARCODE, 10),
		
		DLG_BUTTON(STARTX    , STARTY+810, 333, 89, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "�����Կ�"),
		DLG_BUTTON(STARTX+333, STARTY+810, 333, 89, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "����"),
		DLG_BUTTON(STARTX+666, STARTY+810, 334, 89, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPLETE, "�Ϸ�"),
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
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;
				}
				SetBtnImg();
				SetCombo();
				SetStyle();
				REDRAW();
				Tbl_Draw();
				break;
		}
	}
	
/*=======================================================================================
========================================================================================*/	
	void	OnSelect(long Index)
	{
		long i = 0;
		long index = -1;
		long lpage;
		char sztmp[20];
		long lrow, lcol;

		
		if( m_bFirst == INIT_MAIN )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				m_lActive = index;
				
				lrow = m_lActive/COL;
				lcol = m_lActive%COL;
				lrow--;

				if( lcol == 1 )
				{
				
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, lcol ) );
					if( Str_Cmp( sztmp, CHKGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKNOGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), RED);
					}
					else if( Str_Cmp( sztmp, CHKNOGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), BLUE );
					}

					ON_DRAW();
					Save_Row( lrow, lcol );
				}
				else if( lcol == 2 )
				{
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, lcol ) );
					if( Str_Cmp( sztmp, CHKGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKNOGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), BLUE);
		
					}
					else if( Str_Cmp( sztmp, CHKNOGOOD) == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKGOOD );
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, lrow, lcol ), RED );
					}
					
					ON_DRAW();
					Save_Row( lrow, lcol );
				}
				
				m_lActive = index;
		
				lpage = (index/COL);
				g_nChkIndex = index;
				SPRINT(m_szCnt_page, "%d/%d", lpage, m_lTotpage, 0);
				
				ON_DRAW();
			}

			//���ͱ�ü����
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG)), SCFLTCHG );
			if (i == -1)
				Str_Cpy(stScJjChk.FILTER_REPL_FLAG, "");
			else
				Str_Cpy(stScJjChk.FILTER_REPL_FLAG, SCFLTCHG[i].Code);
				PRINT("stScJjChk.FILTER_REPL_FLAG : %s",stScJjChk.FILTER_REPL_FLAG,0,0 );
			//Ư�̻���
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ETC)), SCRMK );
			if (i == -1)
				Str_Cpy(stScJjChk.SPECIAL_ETC, "");
			else
				Str_Cpy(stScJjChk.SPECIAL_ETC, SCRMK[i].Code);
				
/*
			//���ڵ�Ұ�����
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE)), SCBARWHY );
			if (i == -1)
				Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "");
			else
				Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, SCBARWHY[i].Code);
*/
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		if( m_bFirst == INIT_MAIN )
		{
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
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
		}
	}
	
	//-----------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JJGNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JUNSOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_WORKTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FORM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MODELNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JJGSN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FILTERCHNG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ETC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_FILTERCHNG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_ETC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BARCODE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			Str_Cpy( stScJjNogood.REGTR_NOT_PASS_FLAG, "10");
			m_nSec_cd = 10;
			m_lTotpage = sizeof(SCJJCHKSL)/sizeof( CodeTable )-1;
			m_CT = SCJJCHKSL;
			//Str_Cpy(m_Title, "�ܵ� ����");
		}
	}
	
	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long i, lsign;
	
		switch(ID)
		{
			case BID_CHECK:
				g_lConfrimFlag = 1;
				g_nWorkChkFlag = 20;
				Str_Cpy( stScJjNogood.REGTR_NOT_PASS_FLAG, "10");
				Card_Move("CHK_JOJUNGDTL");
				break;
				
			//case BID_BARCODE:
			//	Barcode();
			//	break;
			case BID_PHOTO:
				Shoto_Photo();
				break;
			case BID_SIGN:
				Save_Sign();
				break;
			case BID_COMPLETE:
				if( Str_Cmp(stScJjChk.CHK_END_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
					break;
				}
				if( Save_Result() )
				{
					g_nBackFlag++;
					
					if( g_nBackFlag > 9)
					{
						g_Db_Backup();
						g_nBackFlag = 0;
					}
				
					if( g_nWorkFlag != 203 )
						Card_Move("SC_CONFIRM");
					else
						Card_Move("SC_JOJUNGLST");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stScJjChk.CHK_RSLT, "20") == 0 || Str_Cmp(stScJjChk.CHK_RSLT, "21") == 0 )
					{
						Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
						if( g_nWorkFlag == 101 )
							g_nWorkFlag = 100;
						Card_Move("MENU");
					}
					else
					{
						Del_Sc();
						Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
						if( g_nWorkFlag == 101 )
							g_nWorkFlag = 100;
						Card_Move("MENU");
					}
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "���������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stScJjChk.CHK_RSLT, "20") == 0 || Str_Cmp(stScJjChk.CHK_RSLT, "21") == 0 )
					{
						Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
						if( g_nWorkFlag == 101 )
							g_nWorkFlag = 100;
						Card_Move("SC_MENU");
					}
					else
					{
						Del_Sc();
						Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
						if( g_nWorkFlag == 101 )
							g_nWorkFlag = 100;
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
				Card_Move("SC_JOJUNGCHK");
				break;				
			case GID_PREV:
				g_lConfrimFlag = 0;
				
				if( Str_Cmp(stScJjChk.CHK_RSLT, "20") == 0 || Str_Cmp(stScJjChk.CHK_RSLT, "21") == 0 )
				{
					Card_Move("SC_JOJUNGLST");
				}
				else
				{
					Del_Sc();
					Card_Move("SC_JOJUNGLST");
				}
				break;	
			case GID_VMEXIT:
				Del_Sc();
				g_Exit();
				break;
		}
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

		for ( i = 0 ; GM_CODE[i].Code[0] != 0 ; i++)
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
			{
				return i;
			}
		}
		return -1;
	}

//-----------------------------------------------------------------	
	void SetCombo(void)
	{
		long i;

		//���ͱ�ü����
		for ( i = 0 ;  SCFLTCHG[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_FILTERCHNG+2), SCFLTCHG[i].Str, 0, ICON_NONE);
		}
		
		//Ư�̻���
		for ( i = 0 ;  SCRMK[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_ETC+2), SCRMK[i].Str, 0, ICON_NONE);
		}
/*
		//���ڵ�
		for ( i = 0 ;  SCBARWHY[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BARCODE+2), SCBARWHY[i].Str, 0, ICON_NONE);
		}
*/
	}

//-----------------------------------------------------------------	
	void REDRAW(void)
	{
		char szSql[300];
		char sztmp[50];
		long i;
	
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1 ), g_szREGTR_NUM);	//������ ��ȣ

		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2 ), stScJjChk.MTRCNT);  //����(�跮�� ����)
		
		//�۾�����
		i = SearchCD( stScJjChk.GENER_REGTR_CHK_FLAG, SCWORK );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), SCWORK[i].Str);
		
		//����
		if( Str_Cmp( stScJjChk.SINGLE_COLIVE_FLAG, "10") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4 ), "�ܵ�");
		}
		else if( Str_Cmp( stScJjChk.SINGLE_COLIVE_FLAG, "20") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4 ), "����");
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5 ), stScJjChk.REGTR_MODEL_NM);  //�𵨸�
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6 ), stScJjChk.REGTR_ID_NUM);	  //������S/N

/*
		//�����հ��
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT COUNT(*) FROM REGTR_NOGOOD WHERE REGTR_NUM = '%s' AND REGTR_NOT_PASS_FLAG = '10' AND (CORRECTION_FLAG = 'N' OR CORRECTION_FLAG IS NULL)",g_szREGTR_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 10, sztmp );
		if( Str_AtoI(sztmp) > 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7 ), "������");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA7 ), RED);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7 ), "��ȣ");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA7 ), TXTFRCOLOR);
		}
*/

		//���ͱ�ü����
		i = SearchCD( stScJjChk.FILTER_REPL_FLAG, SCFLTCHG );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG), SCFLTCHG[1].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG), SCFLTCHG[i].Str);
		}
		
		//Ư�̻���
		/*
		i = SearchCD( stScJjChk.SPECIAL_ETC, SCRMK );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ETC), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ETC), SCRMK[i].Str);
		*/
/*
		//���ڵ�
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), stScJjChk.CURR_BAR);
		
		//���ڵ� ������ ����
		if(Str_Len(stScJjChk.BAR_NOT_PERMIT_WHY) == 0)
		{
			Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "10");
		}
		i = SearchCD( stScJjChk.BAR_NOT_PERMIT_WHY, SCBARWHY );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), SCBARWHY[i].Str);

*/
		//ON_DRAW();
	}

//-----------------------------------------------------------------
	void Tbl_Draw(void)
	{
		long i, idx;
		long k = ROW;
		long lpage = 1;
		long lrow, lcol;
		char szSql[512];
		char szWhere[128];
		char szNOT_PASS_ITEM_CD[3];
		char szCORRECTION_FLAG[3];
		long ret = -1;	
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );

/*
		if( m_lIdxFlag == 1 )
		{
			lpage = g_nChkIndex / COL;
			m_lActive = g_nChkIndex;
			
			lrow = (m_lActive/COL) - 1;
			lcol = m_lActive%COL;

			DlgTbl_SetActive(ID_TBLLIST , m_lActive );
			DlgTbl_SetCellColor(TBL_BKCOLOR, ID_TBLLIST, lrow, lcol, TABLEACTIVE_COLOR);
			
			ON_DRAW();

			m_lIdxFlag = 0;
		}
*/

		SPRINT(m_szCnt_page, "%d/%d", lpage, m_lTotpage, 0);
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i = 0 ; i < ROW ; i++)
		{
			if( m_lpage+i+1 > m_lTotpage )//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
			}
			else
			{
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, m_CT[m_lpage+i].Str );
				
				//2017-10-16 Sanghyun Lee
				//������ Ű�� �߰�
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				SPRINT(szSql, " SELECT REGTR_NOT_PASS_ITEM FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' and SAFE_CHK_TYPE = '%s' ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				SPRINT(szWhere, "AND REGTR_NOT_PASS_FLAG ='%s' AND REGTR_NOT_PASS_ITEM = '%s' ", stScJjNogood.REGTR_NOT_PASS_FLAG, m_CT[m_lpage+i].Code,0);
				Str_Cat(szSql, szWhere);
				g_Sql_RetStr( szSql, 3, szNOT_PASS_ITEM_CD );
				if( Str_Len(szNOT_PASS_ITEM_CD) == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), RED);
				}
				
				//2017-10-16 Sanghyun Lee
				//������ Ű�� �߰�
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				Mem_Set((byte*)szCORRECTION_FLAG ,0x00, sizeof(szCORRECTION_FLAG) );
				SPRINT(szSql, " SELECT CORRECTION_FLAG FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' and SAFE_CHK_TYPE = '%s' ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				SPRINT(szWhere, " AND REGTR_NOT_PASS_FLAG ='%s' and REGTR_NOT_PASS_ITEM = '%s'", stScJjNogood.REGTR_NOT_PASS_FLAG, m_CT[m_lpage+i].Code, 0);
				Str_Cat(szSql, szWhere);
				g_Sql_RetStr( szSql, 3, szCORRECTION_FLAG );
				if( Str_Len(szCORRECTION_FLAG) == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				else if( Str_Cmp(szCORRECTION_FLAG, "N" ) == 0  )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
				}
				else 
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, CHKNOGOOD );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
				}
				
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, m_CT[m_lpage+i].Code );
			}			
		}
		
		ON_DRAW();
		return;
	}


//-----------------------------------------------------------------
	bool Validate(void)
	{
		if( Str_Cmp( stScJjChk.CHK_END_YN, "Y") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
			return FALSE;
		}
	
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ͱ�ü������ �������ּ���.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ETC))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Ư�̻����� �������ּ���.");
			return FALSE;
		}
		/*
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA8))) == 0
		&&  Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ带 ��ĵ�� �ּ���.");
			return FALSE;
		}
		*/
		return TRUE;
	}

//-----------------------------------------------------------------
	void Save_Sign(void)
	{
		char szSql[500];
		char szToday[20];
		char szTime[7];
		long idx, i;
		long lCount;
		long lsign, lSign_Len;
		char* pRst;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( Str_Cmp( stScJjChk.CHK_END_YN, "Y") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
			goto Finally;
		}
		
		//����
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		//lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��" );
		lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��", SIGN_OPT_NONE );
		if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
		{
			goto Finally;
		}
		else
		{
			g_png_getbmp(SIGN_WIDTH, SIGN_HEIGHT, g_SignBuf );
			if(g_pjcomm != NULL )
			{
				BASE64_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}
			g_pjcomm = BASE64_Create();
			lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
		}		

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		//2017-10-16 Sanghyun Lee
		//������ Ű�� �߰�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE REGTR_DATA SET \
						CHK_SIGN_IMAGE = ? WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? and SAFE_CHK_TYPE = ? "
					, 0, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)pRst			            ,Str_Len(pRst) ,DECRYPT);	//����
		
		sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM		    ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_PLAN_YM		    ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szSAFE_CHK_TYPE	    ,2  ,DECRYPT);


		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}

//-----------------------------------------------------------------
	bool Save_Result(void)
	{
		char szSql[500];
		char szSign[10];
		long lCount;
		long idx;
		long i, lsign;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}

		//2017-10-16 Sanghyun Lee
		//������ Ű�� �߰�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT LENGTH(CHK_SIGN_IMAGE) FROM REGTR_DATA WHERE REGTR_NUM = '%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s' "
					, g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
		g_Sql_RetInt(szSql, &lsign);

		Str_ItoA(  Time_GetDate(), stScJjChk.CHK_END_DTM, 10 );
		Str_Cpy( stScJjChk.CHK_YMD,stScJjChk.CHK_END_DTM );
		g_Str_TimeType( stScJjChk.CHK_END_DTM+8 , Time_GetTime() );
		
		//���ͱ�ü����
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_FILTERCHNG)), SCFLTCHG );
		if (i == -1)
			Str_Cpy(stScJjChk.FILTER_REPL_FLAG, "");
		else
			Str_Cpy(stScJjChk.FILTER_REPL_FLAG, SCFLTCHG[i].Code);
		
		//Ư�̻���
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_ETC)), SCRMK );
		if (i == -1)
			Str_Cpy(stScJjChk.SPECIAL_ETC, "");
		else
			Str_Cpy(stScJjChk.SPECIAL_ETC, SCRMK[i].Code);

		//���ͱ�ü���� (��ü�϶��� �۾����ڵ�����)
		if( Str_Cmp( stScJjChk.FILTER_REPL_FLAG, "30") == 0)
			{
				// PRINT("���ͱ�ü����",0,0,0);
				Str_ItoA(  Time_GetDate(), stScJjChk.NEW_FILTER_REPL_YMD, 10 );
				// PRINT("stScJjChk.NEW_FILTER_REPL_YMD : %s",stScJjChk.NEW_FILTER_REPL_YMD,0,0);
				// new_filter_repl_ymd
				//NEW_FILTER_REPL_YMD
			}
/*
		//���ڵ� 
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE)), SCBARWHY );
		if (i == -1)
			Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "");
		else
			Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, SCBARWHY[i].Code);
		//���ڵ�
		Str_Cpy( stScJjChk.CURR_BAR, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA8)) );
*/

		//2017-10-16 Sanghyun Lee
		//������ Ű�� �߰�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s'", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
		g_Sql_RetInt(szSql, &lCount);
		
		Str_Cpy(stScJjChk.CHK_END_YN, "S");
		
		if( lCount > 0 )
			Str_Cpy(stScJjChk.CHK_RSLT, "21");
		else
			Str_Cpy(stScJjChk.CHK_RSLT, "20");
				
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( lsign > 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			// PRINT("222222222222222222",0,0,0);
/*			
			SPRINT(szSql, "UPDATE REGTR_DATA SET \
			CHK_END_YN = ?, CHK_STR_DTM = ?, CHK_END_DTM = ?, CHK_EMPID = ?, CURR_BAR = ? \
			, BAR_NOT_PERMIT_WHY = ?, CHK_YMD = ?, FILTER_REPL_FLAG = ?, SECOND_PRESS = ?, SPECIAL_ETC = ? \
			, UPD_EMPID = ?, UPD_EMPNM = ?, CHK_RSLT = ?, CHK_EXCEP_WHY = ''  \
			, REG1_RSLT = '', REG2_RSLT = '', REG3_RSLT = '' WHERE REGTR_NUM = ? "
						, 0, 0, 0);
*/

			//2017-10-16 Sanghyun Lee
			//������ Ű�� �߰�
			SPRINT(szSql, "UPDATE REGTR_DATA SET \
			CHK_END_YN = ?, CHK_STR_DTM = ?, CHK_END_DTM = ?, CHK_EMPID = ? \
			, CHK_YMD = ?, FILTER_REPL_FLAG = ?, SECOND_PRESS = ?, SPECIAL_ETC = ? \
			, UPD_EMPID = ?, UPD_EMPNM = ?, CHK_RSLT = ?, CHK_EXCEP_WHY = ''  \
			, REG1_RSLT = '', REG2_RSLT = '', REG3_RSLT = '',NEW_FILTER_REPL_YMD = ?  WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? AND SAFE_CHK_TYPE = ? "
						, 0, 0, 0);
			hstmt = sql->CreateStatement(sql, szSql);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}
	
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_YN        ,1	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_STR_DTM       ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_DTM       ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,9	,DECRYPT);
			//sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CURR_BAR          ,20	,DECRYPT);
			//sql->Bind(sql, idx++, 'U', (long *)stScJjChk.BAR_NOT_PERMIT_WHY,6	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_YMD           ,8	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.FILTER_REPL_FLAG  ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SECOND_PRESS      ,5	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SPECIAL_ETC       ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor         ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_RSLT          ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.NEW_FILTER_REPL_YMD          ,2	,DECRYPT);

			//2017-10-16 Sanghyun Lee
			//������ Ű�� �߰�
			sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM               ,8	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_PLAN_YM		       ,6  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szSAFE_CHK_TYPE	       ,2  ,DECRYPT);
		}
		else
		{
			// PRINT("33333333333333333333",0,0,0);
			//���� �� null�Է�
			//Mem_Set( (byte*)szSign, 0x00, sizeof(szSign) );
		
			//2017-10-16 Sanghyun Lee
			//������ Ű�� �߰�
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE REGTR_DATA SET \
			CHK_END_YN = ?, CHK_STR_DTM = ?, CHK_END_DTM = ?, CHK_EMPID = ?  \
			, CHK_YMD = ?, FILTER_REPL_FLAG = ?, SECOND_PRESS = ?, SPECIAL_ETC = ? \
			, UPD_EMPID = ?, UPD_EMPNM = ?, CHK_RSLT = ?, CHK_SIGN_IMAGE = '', CHK_EXCEP_WHY = ''  \
			, REG1_RSLT = '', REG2_RSLT = '', REG3_RSLT = '' ,NEW_FILTER_REPL_YMD = ? WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? AND SAFE_CHK_TYPE = ? "
						, 0, 0, 0);
			hstmt = sql->CreateStatement(sql, szSql);
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}
	
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_YN        ,1	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_STR_DTM       ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_DTM       ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,9	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CURR_BAR          ,20	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.BAR_NOT_PERMIT_WHY,6	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_YMD           ,8	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.FILTER_REPL_FLAG  ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SECOND_PRESS      ,5	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SPECIAL_ETC       ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id    ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor         ,20	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_RSLT          ,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.NEW_FILTER_REPL_YMD          ,2	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)szSign			           ,Str_Len(szSign) ,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REG1_RSLT         ,1	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REG2_RSLT         ,1	,DECRYPT);
//			sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REG3_RSLT         ,1	,DECRYPT);

			//2017-10-16 Sanghyun Lee
			//������ Ű�� �߰�
			sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM               ,8	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_PLAN_YM		       ,6  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szSAFE_CHK_TYPE	       ,2  ,DECRYPT);
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "������ �Ϸ�Ǿ����ϴ�.");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

//-----------------------------------------------------------------	
	void Barcode(void)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;

		//2017-08-22 Sanghyun Lee
		//ī�޶� ���ڵ�(����Ʈ�� ����) & �� ���ڵ� ���� ��� �߰�(������ ����޴����� ����)
		if( Str_Cmp(g_szBarcodeSet, PHOTO_BARCODE) == 0 && theDevInfo.m_nType > FAMILY_PDA )
		{
			h = JSON_Create( JSON_Object );
			if (h)
			{
				hdata = JSON_Create( JSON_Object );
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				JSON_SetValue	(hdata	, 'C', "desc"				, "ī�޶���ڵ�");
				JSON_SetValue	(hdata	, 'C', "imgSaveEnabled"		, "false");						//{true, false}
				JSON_SetValue	(hdata	, 'C', "imgOutPath"			, "Barcode/barcode.jpg");		//Smart ���� ��θ� ����
				
				JSON_SetValue	(h		, 'C', "method"				, "BarcodeActivity");
				
				JSON_Attach 	(h		, "data"					, hdata);
			
				System_Call		("Native_System_Call" , JSON_toString(h));
			}
			
		Finally:
		
			if (h)
			{
				JSON_Finalize(h);
			}	
		
			if (hdata)
			{
				JSON_Finalize(hdata);
			}	
		}
		else
		{
			//����Ʈ�� -> Barcode_Init, Barcode_Exit �ʿ� ,, PDA -> Barcode_Init, Barcode_Exit ���ʿ� 
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				Barcode_Init();
			}

			ret = Barcode_SendCommand( "start" );
		}

		return;
	}
	
//-----------------------------------------------------------------	
	void OnBarcodeRead(void)
	{
	long ret = 0;

		if( Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
			ret = Barcode_Read( m_szBarcode_Value );	
			if( ret < 0)
			{
				MessageBoxEx (CONFIRM_OK, "���ڵ� �б� ����");
			}
		}

		//���ڵ� ����
		Str_Cpy(stScJjChk.CURR_BAR, m_szBarcode_Value);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), m_szBarcode_Value ) ;
		
		//���ڵ� �Ұ�����
		Str_Cpy(stScJjChk.BAR_NOT_PERMIT_WHY, "");	
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), "");
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), TRUE );

		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}

		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Del_Sc
	��  �� : �������
	Param  : 
	Return :
	========================================================================================*/
	void Del_Sc(void)
	{
		char szSql[300];

		//�����ջ���
		//2017-10-16 Sanghyun Lee
		//������ Ű�� �߰�
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s' AND REGTR_NOT_PASS_FLAG ='10' ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
		g_Sql_DirectExecute( szSql );

		return;
	}
	
//----------------------------------------------------------------------------------------------
	void Save_Row(long row, long col)
	{
		char szSql[400];
		char sztmp[200];
		char szWhere[200];
		char szday[10];
		char szREGTR_NOT_PASS_ITEM[3];
	
		Mem_Set((byte*)szREGTR_NOT_PASS_ITEM ,0x00, sizeof(szREGTR_NOT_PASS_ITEM) );
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Mem_Set((byte*)szday ,0x00, sizeof(szday) );
	
		Str_Cpy( szREGTR_NOT_PASS_ITEM, DlgTbl_GetStr( ID_TBLLIST, row, 3) );
		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, row, col) );
		if( col == 1 )
		{
			//������ ��� �׸� ����
			if(Str_Cmp( sztmp, CHKGOOD) == 0)
			{
				//2017-10-16 Sanghyun Lee
				//������ Ű�� �߰�
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				SPRINT(szSql, " DELETE FROM REGTR_NOGOOD WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' and SAFE_CHK_TYPE = '%s'  ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				SPRINT(szWhere, " AND REGTR_NOT_PASS_FLAG ='%s' and REGTR_NOT_PASS_ITEM = '%s'", stScJjNogood.REGTR_NOT_PASS_FLAG, szREGTR_NOT_PASS_ITEM, 0);
				Str_Cat(szSql, szWhere);
				g_Sql_DirectExecute( szSql );
			}
			else // �������� ��� �׸� �߰�
			{	
				Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, row, 2) );
				Save_NotPassItem( szREGTR_NOT_PASS_ITEM, sztmp );
			}
		}
		else if( col == 2 )
		{
			if(Str_Cmp( sztmp, CHKGOOD) == 0)
			{
				//2017-10-16 Sanghyun Lee
				//������ Ű�� �߰�
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				SPRINT(szSql, " UPDATE REGTR_NOGOOD SET CORRECTION_FLAG ='N',NOT_PASS_BETTER_YMD='', SEND_YN='S'  WHERE REGTR_NUM ='%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s' ", g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				SPRINT(szWhere, " AND REGTR_NOT_PASS_FLAG ='%s' AND REGTR_NOT_PASS_ITEM = '%s'", stScJjNogood.REGTR_NOT_PASS_FLAG, szREGTR_NOT_PASS_ITEM, 0);
				Str_Cat(szSql, szWhere);
				g_Sql_DirectExecute( szSql );
			}
			else
			{
				Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
				Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
				Mem_Set((byte*)szWhere ,0x00, sizeof(szWhere) );
				
				//2017-10-16 Sanghyun Lee
				//������ Ű�� �߰�
				Str_ItoA( Time_GetDate(),szday,10 );
				SPRINT(szSql, " UPDATE REGTR_NOGOOD SET CORRECTION_FLAG ='Y',NOT_PASS_BETTER_YMD='%s', SEND_YN='S' WHERE REGTR_NUM ='%s' AND REGTR_NOT_PASS_FLAG ='%s' ",szday, g_szREGTR_NUM, stScJjNogood.REGTR_NOT_PASS_FLAG);
				SPRINT(szWhere, " AND REGTR_NOT_PASS_ITEM = '%s' AND CHK_PLAN_YM ='%s' AND SAFE_CHK_TYPE = '%s'", szREGTR_NOT_PASS_ITEM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE);
				Str_Cat(szSql, szWhere);
				g_Sql_DirectExecute( szSql );
				
			}
		}
	}
	
//----------------------------------------------------------------------------------------------
	bool Save_NotPassItem(char* szREGTR_NOT_PASS_ITEM, char* szCHKGOODYN )
	{
	long idx, ret;
	SQLITE sql = NewSqLite();
	long nDate;
	char sztmp[20];	
		
		sql->Open(sql);
		if( sql->m_hdb == NULL )
		{
			goto Finally;
		}
		
		//2017-10-16 Sanghyun Lee
		//������ Ű�� �߰�
		sql->CreateStatement(sql,
"INSERT INTO REGTR_NOGOOD \
(REGTR_NUM          ,CHK_PLAN_YM ,SAFE_CHK_TYPE,REGTR_NOT_PASS_FLAG ,REGTR_NOT_PASS_ITEM,\
NOT_PASS_BETTER_YMD ,CORRECTION_FLAG  ,SEND_YN ,EMP_ID, UPD_EMPID ) \
VALUES(?, ?, ?, ?, ?,  ?, ?, 'S', ?, ? ) " 
		);
		if( sql->m_hdb == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM                    ,8,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_PLAN_YM            ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SAFE_CHK_TYPE          ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjNogood.REGTR_NOT_PASS_FLAG ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szREGTR_NOT_PASS_ITEM            ,2 ,DECRYPT);
		if(Str_Cmp(szCHKGOODYN, CHKNOGOOD) == 0 )//�����ս�
		{
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			Str_ItoA( Time_GetDate(), sztmp, 10);
			sql->Bind(sql, idx++, 'U', (long *)sztmp       ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)"Y"         ,2 ,DECRYPT);
		}
		else
		{
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			sql->Bind(sql, idx++, 'U', (long *)sztmp      ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)"N"        ,2 ,DECRYPT);
		}	
		
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id  ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id  ,9 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

Finally:		
		DelSqLite(sql);

		return TRUE;
	}
	
//----------------------------------------------------------------------------------------------
	void Shoto_Photo(void)
	{
		char sztmp[256];
		char szScrPht[256];
		char szTgrPht[256];
		char szDirPath[256];
		char szREGTR_NOT_PASS_ITEM[3];
		char *pCamera;
		long nRet, lrow, lcol;
		handle h = NULL;
		handle hdata = NULL;
		
		lrow = m_lActive/COL;
		lcol = m_lActive%COL;
		lrow--;
		
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		if( m_lActive <= 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�׸��� �����ϼ���.");
			return;
		}
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, 1) );
		if( Str_Cmp( sztmp, CHKGOOD) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "������ ���� �������� �ƴմϴ�.");
			return;
		}
		
		//���ϸ�
		Mem_Set((byte*)szREGTR_NOT_PASS_ITEM ,0x00, sizeof(szREGTR_NOT_PASS_ITEM) );
		Str_Cpy( szREGTR_NOT_PASS_ITEM, DlgTbl_GetStr( ID_TBLLIST, lrow, 3) );
		
		
		Str_Cpy(m_szfilenm, g_szREGTR_NUM);
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, stScJjChk.CHK_PLAN_YM);
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, stScJjChk.SAFE_CHK_TYPE);
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, stScJjNogood.REGTR_NOT_PASS_FLAG);
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, szREGTR_NOT_PASS_ITEM);
		Str_Cat(m_szfilenm, ".jjp");
		
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			g_nPhotoFlag = 3;
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_JO,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//��������
			//Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			//SPRINT (g_szphoto, "%s/%s", PHOTO_JO,  m_szfilenm, 0);
			//���Ŀ��� Ȯ�ν�...
			//ShootPhoto ( 1, 0, m_szfilenm );

			h = JSON_Create( JSON_Object );
			if (h)
			{
				hdata = JSON_Create( JSON_Object );
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				//2017-08-18 Sanghyun Lee
				//ī�޶� ȭ�� ����(photo_quality)	
				//"MEDIA_QUALITY_AUTO" ->> ���� �߻�, �ʿ�X
				//"MEDIA_QUALITY_LOWEST"
				//"MEDIA_QUALITY_LOW" ->> ���õǴ� ȭ���� ���� , �ʿ�X
				//"MEDIA_QUALITY_MEDIUM" ->> ���� ������ι���
				//"MEDIA_QUALITY_HIGH"
				//"MEDIA_QUALITY_HIGHEST"
				JSON_SetValue	(hdata	, 'C', "photo_quality"		, "MEDIA_QUALITY_MEDIUM");

				//JSON_SetValue	(hdata	, 'C', "desc"				, "photo");
				JSON_SetValue	(hdata	, 'C', "position_info"		, " ");
				JSON_SetValue	(h		, 'C', "method"				, "CameraActivity");
				
				JSON_Attach 	(h		, "data"					, hdata);
			
				System_Call		("Native_System_Call" , JSON_toString(h));
			}
			
			Finally:
		
			if (h)
			{
				JSON_Finalize(h);
			}	
		
			if (hdata)
			{
				JSON_Finalize(hdata);
			}	
		}
	}

//-----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		
		if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				if( FFS_Exist(szfilenm)  )
				{
					//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h�� ���ǵǾ�����
					ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);

					VmSleep(100);
					FFS_Delete( szfilenm );
				}
			}
		}
	}

//-----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;
		char* ptr;
		
		if(nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_BARCODE )
			{
				//ī�޶� ���ڵ� ��ĵ ��
				Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
				ptr = (char*)System_GetResult((char*)&nRet);
				Str_Cpy(m_szBarcode_Value, ptr);

				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					OnBarcodeRead();
				}
			}
			else if( nData == TASK_CAMERA )
			{
				Mem_Set((byte*)szPhotopath, 0x00, sizeof(szPhotopath));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				szPath = (char*)System_GetResult((char*)&nRet);
				nLen = Str_Len(szPath);
				if( nLen > 19 )
				{
					Mem_Cpy((byte *)szTmp, (byte *)szPath+19, nLen-19);
					Str_Cpy(szPhotopath, "..");
					Str_Cat(szPhotopath, szTmp);
					//PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
					
					//�������� +19
					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_JO,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);
					
					ON_DRAW();
					MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
				}
			}
		}
	}
}

