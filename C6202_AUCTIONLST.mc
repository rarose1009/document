/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_AUCTIONLST
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )			//���� �ּ�
		DEF_BUTTON_ID ( BID_NADDR )			//���θ� �ּ�
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//�ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_UP )			//����������
		DEF_BUTTON_ID ( BID_DOWN )			//����������
		DEF_BUTTON_ID ( BID_GRID )
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
//���� ����Ʈ
		DEF_OBJECT_ID ( TXT_PAGE )			//������
		DEF_OBJECT_ID ( TXT_DATA1 )			//�ּ�
		
//�׸���
		DEF_OBJECT_ID ( TXT_DATA10 )

//���� ����Ʈ
		DEF_OBJECT_ID ( ID_TBLLIST )		// ���̺� ����Ʈ
		
//�׸���
		DEF_OBJECT_ID ( ID_GRIDLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
//���� ����Ʈ
		DEF_OBJECT_ID ( CMB_DATA1 )

//�׸���
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1 + 3 )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    100					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+30)			// table �� ����
	#define		GRID_H_P	(CHT+48)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX	 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+255  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+200  	    //table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�����ּ�",   	 CWD*20+10, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   GCTYPE_EDITCTRL, 0},
		{"����",       	 CWD*5,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_EDITCTRL, 0},
		{"ü���ݾ�",     CWD*14,    EDITALIGN_RIGHT|EDITALIGN_MIDDLE, GCTYPE_EDITCTRL, 0},
		{"���ּ�",   	 CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_EDITCTRL, 0},
		{"USE_CONT_NUM", CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_EDITCTRL, 0}
	};	

	//dkjung's test
	//GRID ���� ���� define
	#define GRID_DEBUG

//�׸��� Ÿ��Ʋ

#ifdef GRID_DEBUG

	//�׸��� �׽�Ʈ
	Column m_stGridCtrl_Title[] = {
		{ "�����ּ�",     480, EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "����",         120, EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "ü���ݾ�",     270, EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "���ּ�",     0  , EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "USE_CONT_NUM", 0  , EDITALIGN_CENTER|EDITALIGN_MIDDLE, GCTYPE_TEXTCTRL	, 32},
		{ "",             130, 								   0, GCTYPE_TEXTCTRL	, 1}
	};

//#else

//	Column m_stGridCtrl_Title[] = {
//		{ "�ּ�",    200, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "D",       100, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "C",     	 100, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "��ħ",    100, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "��뷮",  100, 0, GCTYPE_TEXTCTRL	, 32},
//		{ "",        80 , 0, GCTYPE_TEXTCTRL	, 32}
//	};
	
#endif
	
	#define INIT_MAIN	1
	#define INIT_GRID   2
	
	handle m_hGrid = NULL;
	handle m_hHeader0 = NULL;
	handle m_hHeader1 = NULL;
	handle m_hHeader2 = NULL;
	handle m_hHeader3 = NULL;
	handle m_hHeader4 = NULL;
	handle m_hHeader5 = NULL;
	handle m_hGridStyle0 = NULL;
	handle m_hGridStyle1 = NULL;
	handle m_hGridStyle2 = NULL;
	handle m_hGridStyle3 = NULL;
	handle m_hGridStyle4 = NULL;
	handle m_hGridStyle5 = NULL;
	long m_lGridIndex = -1;
	long m_lGridRow = -1;
	long m_nPosX = 0;
	long m_nPosY = 0;
	long m_nMoveFlag = 0;
	long m_nScrollY = 0;
	
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_nActIndex = -1;		//���õ� row index
	long m_bFirst;				
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szCobSel[20];
	char m_szQuickSql[1000];

	bool REDRAW(void);
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
	void SetBtnImg(void);
	
	void Grid_Draw(void);		//Grid ���̺�
	void OnList(quad lParam);	//Quick view
	void Grid_QuickList(void);	//Quick view
		
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
	
	// ���� ���̾�α�(����Ʈ)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���Ȱ�� ����Ʈ"),
	
		DLG_BUTTON(STARTX,	 	STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+250,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+500,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
		
		DLG_TEXT(STARTX,	   STARTY+135, 1000, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),			//�⺻�ּ�

		DLG_TEXT(STARTX+750,   STARTY+65, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/�������� , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		// ����Ʈ
		
#ifdef GRID_DEBUG

//Ÿ��Ʋ ����, ������Ŭ ��
//#define DLG_GRID(x, y, width, height, Rem, Add, Id, rownum, colnum, head_height, body_height, scroll_delta, scroll_thick, selected_color, grid_title)\
		{0, Id, 0, OBJ_GRD, 0, 0, 0,\
		{{x, y, width, height, rownum, colnum}, Rem, Add, head_height, body_height, scroll_delta, {scroll_thick, grid_title, 0}}}
			
		//[����] m_stGridCtrl_Title�� ����� �÷������� �÷� ���� ���� Ʋ���� ȭ�� ���� (ī��Ʈ �ٸ��� �˼� ����) => ��� �ڵ�������� ó��
		DLG_GRID(GRID_X, GRID_Y, 1000, 645, 0, FRMSTY_BORDER|FRMSTY_ALWAYSSHOWSB|GRDSTY_STRIPE, ID_GRIDLIST, ROW, 50, 100, 800, 90, TABLEACTIVE_COLOR, m_stGridCtrl_Title),
		//DLG_COMBO_LIST (STARTX, 	   STARTY+260, 480, 290, 125, 69, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),

#else

		DLG_BUTTON(STARTX+565, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+785, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		DLG_COMBO_LIST (STARTX, 	   STARTY+260, 510, 290, 125, 69, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
#endif		
		
	};	
	

	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���Ȱ�� ����Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,	 	STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+220,  STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+565, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+785, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		DLG_TEXT(STARTX,	   STARTY+150, 985, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),			//�⺻�ּ�

		DLG_TEXT(STARTX+585,   STARTY+70, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/�������� , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_COMBO_LIST (STARTX, 	   STARTY+260, 510, 290, 125, 69, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
	};
	

	// ���� ���̾�α�(����Ʈ)
	//---------------------------------------------------------------
	DlgObject	DlgRes_Grid[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���Ȱ�� ����Ʈ"),
/*	
		DLG_BUTTON(STARTX,	 	STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+220,  STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+565, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+785, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
*/		
		DLG_TEXT(STARTX,	   STARTY+150, 985, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),			//�⺻�ּ�

		DLG_TEXT(STARTX+585,   STARTY+70, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/�������� , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		//DLG_GRID(DMS_X(0), DMS_X(360), DMS_X(1000), DMS_Y(1000), 0, FRMSTY_BORDER|FRMSTY_ALWAYSSHOWSB, ID_GRIDLIST, 100, 6, 70, 120, DMS_Y(800), DMS_X(100), m_stGridCtrl_Title),
		//DLG_GRID(0, 360, 1000, 1000, 0, FRMSTY_BORDER|FRMSTY_ALWAYSSHOWSB, ID_GRIDLIST, 100, 6, 70, 120, 800, 80, 	m_stGridCtrl_Title),
	};	
/*
#define DLG_GRID(x, y, width, height, Rem, Add, Id, rownum, colnum, head_height, body_height, scroll_delta, scroll_thick, grid_title)\
		{0, Id, 0, OBJ_GRD, 0, 0, 0,\
		{{x, y, width, height, rownum, colnum}, Rem, Add, head_height, body_height, scroll_delta, {scroll_thick, grid_title, 0}}}
*/
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_Grid_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���Ȱ�� ����Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,	 	STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+220,  STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+565, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+785, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		
		DLG_TEXT(STARTX,	   STARTY+150, 985, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),			//�⺻�ּ�

		DLG_TEXT(STARTX+585,   STARTY+70, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/�������� , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		//DLG_GRID(DMS_X(0), DMS_X(360), DMS_X(1000), DMS_Y(1000), 0, FRMSTY_BORDER|FRMSTY_ALWAYSSHOWSB, ID_GRIDLIST, 100, 6, 70, 120, DMS_Y(800), DMS_X(100), m_stGridCtrl_Title),
		//DLG_GRID(0, 360, 1000, 1000, 0, FRMSTY_BORDER|FRMSTY_ALWAYSSHOWSB, ID_GRIDLIST, 100, 6, 70, 120, 800, 100, 	""),
	};


	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);

		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
	}

//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
		long i, lCnt = 0;
		char szTmp[200];
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM C6202_AUCTION ORDER BY AREA, TOWN, ADDR1_M", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM) );
			SPRINT(szTmp, "SELECT USE_CONT_NUM FROM C6202_AUCTION WHERE ROWID = '%d'", g_lindex, 0, 0);
			g_Sql_RetStr(szTmp, 15, g_szUSE_CONT_NUM);
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp));
			SPRINT(szTmp, "SELECT COUNT(*) FROM C6202_NOPAY_OBJ WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0);
			g_Sql_RetInt(szTmp, &lCnt);
			if( lCnt > 0 )
			{
				g_lDataflag = 0;
				
				g_Sql_SaveSeq( "SELECT ROWID FROM C6202_AUCTION WHERE USE_CONT_NUM IN ( SELECT USE_CONT_NUM FROM C6202_NOPAY_OBJ) ORDER BY AREA, TOWN, ADDR1_M", SREACH_FILE);
				
				Card_Move("C6202_NPACTIVE");
				return;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "���Ź��� ü������� �����ϴ�.");
			}
		}
		
		return;
	}
	
//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void	OnInit(char bFirst)
	{
		//bFirst = INIT_GRID;
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
						//Grid_Draw();

						//m_hGrid = Get_hDlgCtrlByID(ID_GRIDLIST);
						
						break;
				}
				
				//M(2222->3333);
			
				//ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "�����ּ�", 0, ICON_NONE);
				//ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "��ȣ", 0, ICON_NONE);
				//ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "����", 0, ICON_NONE);
				//Mem_Set( (byte*)m_szCobSel, 0x00, sizeof(m_szCobSel));
				//Str_Cpy(m_szCobSel, "�����ּ�");
				//EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_szCobSel);

#ifdef GRID_DEBUG

				m_hGrid = Get_hDlgCtrlByID(ID_GRIDLIST);
				GridCtrl_SetPageInfo(m_hGrid, ROW, m_lpage, m_lTotpage, REDRAW);

#endif				
				
//				{
//					handle h = GridCtrl_GetCellHandle(m_hGrid, 0, 1);
//					BaseCtrl_SetFont(h, FONT_32);
//				}

				g_nAddrFlag = 0;
				SetBtnImg();
				SetStyle();
				REDRAW();
				break;
				
			case INIT_GRID:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Grid_P, SIZEOF(DlgRes_Grid_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_Grid, SIZEOF(DlgRes_Grid));
						//Grid_Draw();
						break;
				}
				
				//ID_GRIDLIST
				//M(1111->2222);

				g_nAddrFlag = 0;
				SetBtnImg();
				//SetStyle();
				
				
				//grid ���� ȣ��
				Grid_Draw();
				break;
		}
	}
	
	//----------------------------------------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);			
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		
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

	//----------------------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long index = -1;
		long lCnt = 0;
		long lCol = 0;
		char sztmp[300];
		char szcmb[30];
		char szMsg[256];
		char* ptr = NULL;
	
		if( INIT_MAIN == m_bFirst )
		{
		
#ifdef GRID_DEBUG

			if (Index > 0)
			{
				if (Index == m_nActIndex)
				{
					if( Str_Len(g_szUSE_CONT_NUM) > 5 )
					{
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
						SPRINT(sztmp, "SELECT COUNT(*) FROM C6202_NOPAY_OBJ WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0);
						g_Sql_RetInt(sztmp, &lCnt);
						if( lCnt > 0 )
						{
							g_Sql_SaveSeq( "SELECT ROWID FROM C6202_AUCTION WHERE USE_CONT_NUM IN ( SELECT USE_CONT_NUM FROM C6202_NOPAY_OBJ) ORDER BY AREA, TOWN, ADDR1_M", SREACH_FILE);
							//���õ� ������ ��ġ INDEX�� �۷ι������� ����
							g_nActIndex = m_lpage*ROW + m_nActIndex-1;
							g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
							g_nScrollIndex = GridCtrl_GetScrollY(m_hGrid);

							//Set_Index();
							g_lDataflag = 0;
							Card_Move("C6202_NPACTIVE");
							return;
						}
						else
						{
							MessageBoxEx (CONFIRM_OK, "���Ź��� ü������� �����ϴ�.");
						}
					}
				}
				
				m_nActIndex = Index;

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, GridCtrl_GetCellStr(m_hGrid, 3, m_nActIndex));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
				
				//PRINT("addr : [%d] = %s",m_nActIndex,GridCtrl_GetCellStr(m_hGrid, 3, m_nActIndex),0);
				
				Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM) );
				Str_Cpy(g_szUSE_CONT_NUM, GridCtrl_GetCellStr(m_hGrid, 4, m_nActIndex));
				//PRINT("m_szUse_cont_num : %s",m_szUse_cont_num,0,0);
				//PRINT("use_cont_num : [%d] = %s",m_nActIndex,GridCtrl_GetCellStr(m_hGrid, 4, m_nActIndex),0);
			}			

#else
		
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				// ���� �ε����� ���� �ε����� ���� �� ���
				if ( index-1 == m_nActIndex )
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
					SPRINT(sztmp, "SELECT COUNT(*) FROM C6202_NOPAY_OBJ WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0);
					g_Sql_RetInt(sztmp, &lCnt);
					if( lCnt > 0 )
					{
						g_Sql_SaveSeq( "SELECT ROWID FROM C6202_AUCTION WHERE USE_CONT_NUM IN ( SELECT USE_CONT_NUM FROM C6202_NOPAY_OBJ) ORDER BY AREA, TOWN, ADDR1_M", SREACH_FILE);
						FS_GetSrchTotCnt();

						//���õ� ������ ��ġ INDEX�� �۷ι������� ����
						g_nActIndex = m_lpage*ROW + m_nActIndex;
						g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
						//Set_Index();
						g_lDataflag = 0;
						Card_Move("C6202_NPACTIVE");
						return;
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "���Ź��� ü������� �����ϴ�.");
					}
				}
				else
				{
					m_nActIndex = index - 1;//���õ� INDEX ����
				
					//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
					Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));
					Str_Cpy( g_szUSE_CONT_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
				}
			}
			else
			{
				
				Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
				Str_Cpy( szcmb , EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1) ) );
				//�޺��ڽ� �������� ����Ʈ ��� ���͸�
				if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
				{
					Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
					SPRINT(szMsg, "�׸��� %s�� �����Ͻðڽ��ϱ�?", szcmb, 0, 0);
					if( MessageBoxEx (CONFIRM_YESNO, szMsg)  == MB_OK)
					{
						Str_Cpy(m_szCobSel, szcmb);
						
						REDRAW();
					}
					else
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_szCobSel);
					}
				}
				else
				{
					REDRAW();
				}
			}
#endif

		}
	}

	//----------------------------------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		
		if( m_bFirst == INIT_GRID )
		{
			GridCtrl_PointingProcess(m_hGrid, nAction, X, Y);
			/*
			if(m_hGrid)
			{
				//if( theDevInfo.m_nType != FAMILY_PDA && POINTING_DOWN == nAction && Y > DMS_Y(360)  )
				if( theDevInfo.m_nType != FAMILY_PDA && Y > DMS_Y(360)  )
				{
					GridCtrl_PointingProcess(m_hGrid, nAction, X, Y);
				}
				else if( theDevInfo.m_nType == FAMILY_PDA && Y > DMS_Y(360) )
				{
					GridCtrl_PointingProcess(m_hGrid, nAction, X, Y);
				}
			}
			*/
			if( theDevInfo.m_nType != FAMILY_PDA )
			{
				if( X > 0 && X < 998 && Y > 0 && Y < 170 && POINTING_DOWN == nAction )
				{
					//ON_EXIT();
					//OnInit(INIT_MAIN);
					//Card_Prev();
					Card_Move("C6202_MENU");
					return;
				}
			}
/*
			PRINT ("OnPointing(0x%x, 0x%x)", X,Y,0);
			
			if (nAction == POINTING_DOWN)
			{
				m_nPosX = X;
				m_nPosY = Y;
				m_nMoveFlag = 0;
			}
			else if (nAction == POINTING_UP)
			{
				if (m_nMoveFlag)
				{
					long y = Y - m_nPosY;
					
					if (y < 0)
					{
						// ȭ�� �� ����
						m_nScrollY += 200;
						PRINT("ȭ�� �� �������� ����(m_nScrollY = %d)",m_nScrollY,0,0);
						//Y = m_nScrollY;
					}
					else
					{
						// ȭ�� �Ʒ� ����
						m_nScrollY -= 200;
						PRINT("ȭ�� �Ʒ� �������� ����(m_nScrollY = %d)",m_nScrollY,0,0);
						//Y = m_nScrollY;
					}
					
					GridCtrl_SetScroll(m_hGrid, 0, m_nScrollY);
					
					PRINT("Y = %d, m_nPosY = %d",Y,m_nPosY,0);
					//GridCtrl_PointingProcess(m_hGrid, nAction, X, Y);
					//GridCtrl_ScrollProcess(m_hGrid, Y, m_nPosY);
				}
				
				//OnDraw();
			}
			else if (nAction == POINTING_MOVE)
			{			
				PRINT("POINTING_MOVE -> %d",Y,0,0);
				m_nMoveFlag = 1;
			}
*/
			
			
			OnDraw();
		}
		return;
	}

	//----------------------------------------------------------------------------------------------------
	void	OnDraw(void)
	{
	}
	
	
	//----------------------------------------------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA1), TRUE, 2, EDITSEP_NONE );
	}


	//----------------------------------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
	
//PRINT("OnButton>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> %d",ID,0,0);
		switch(ID)
		{
			case BID_QUICK_ADDR:
				Grid_QuickList();
				break;
			case BID_GRID:
				ON_EXIT();
				OnInit(INIT_GRID);
				break;
			case BID_ADDR:
				g_nAddrFlag = 0;
				REDRAW();
				break;
			case BID_NADDR:
				g_nAddrFlag = 1;
				REDRAW();
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0)
						{
							m_nActIndex = 0;
						}
					
					//------dkjung's test start
					#ifndef GRID_DEBUG
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					//------dkjung's test end
					#endif
					}
					break;
				}
				m_nActIndex = 0;
				REDRAW();
				break;			
			case BID_DOWN:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0 )
						{
							m_nActIndex = 0;
						}
					
					#ifndef GRID_DEBUG
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					#endif
					}
					break;
				}
				m_nActIndex = 0;
				REDRAW();
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
			//	ON_EXIT();
			//	OnInit(INIT_GRID);
				break;				
			case GID_PREV:
				Card_Move("C6202_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}	

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------

//#ifndef GRID_DEBUG
#ifdef GRID_DEBUG

	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		char sztmp[256];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		handle h = NULL;
		char* ptr =  NULL;
		SQLITE sql = NewSqLite();
		
		g_Sql_SaveSeq( "SELECT ROWID FROM C6202_AUCTION ORDER BY AREA, TOWN, ADDR1_M", SREACH_FILE);
		lTotPage = FS_GetSrchTotCnt();
		m_lTotpage = lTotPage;
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0)
		{
			//���α׷� ���� �� �ҷ����� �ε���
			Get_Index();
		}

		SPRINT(m_szCnt_page, "%d/%d , %d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "����\n��ũ��");

			hstmt = sql->CreateStatement(sql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, IFNULL(AREA, '') ||' '|| IFNULL(TOWN, '') ||' '|| IFNULL(VILLAGE, '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, USE_CONT_NUM, FIRM_NM, CUST_NM FROM C6202_AUCTION ORDER BY AREA, TOWN, ADDR1_M LIMIT ?, ? ");
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "���θ�\n��ũ��");

			hstmt = sql->CreateStatement(sql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, IFNULL(NEW_ROAD_NM, '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, USE_CONT_NUM, FIRM_NM, CUST_NM FROM C6202_AUCTION ORDER BY AREA, TOWN, ADDR1_M LIMIT ?, ? ");
		}

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		//��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		//i�� 1���� �����ϱ� ������ ��ü������ +1 �� ���ش�.
		for (i=1 ; i<lTotPage+1 ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				GridCtrl_SetCellStr ( m_hGrid, 0, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 1, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 2, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 3, i, "" );
				GridCtrl_SetCellStr ( m_hGrid, 4, i, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					GridCtrl_SetCellStr ( m_hGrid, 0, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 1, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 2, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 3, i, "" );
					GridCtrl_SetCellStr ( m_hGrid, 4, i, "" );
					continue;
				}
				
				//�ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
				GridCtrl_SetCellStr ( m_hGrid, 0, i, sztmp );
				h = GridCtrl_GetCellHandle(m_hGrid, 0, i);
				EditCtrl_SetAlign(h, EDITALIGN_LEFT|EDITALIGN_MIDDLE);
				EditCtrl_SetMultiLine(h, TRUE, 2, EDITSEP_NONE );
				
				//ptr = EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1));
				//if (ptr != NULL)
				//{
				//	if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "�����ּ�") == 0 )
				//	{
				//		sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
				//	}
				//	else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "��ȣ") == 0 )
				//	{
				//		sql->GetValue(sql, 5, 'U', (long*)sztmp, 200, DECRYPT);
				//	}
				//	else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "����") == 0 )
				//	{
				//		sql->GetValue(sql, 6, 'U', (long*)sztmp, 200, DECRYPT);
				//	}
				//	GridCtrl_SetCellStr ( m_hGrid, 0, i, sztmp );
				//}

				//��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 5, DECRYPT);
				GridCtrl_SetCellStr ( m_hGrid, 1, i, sztmp );

				//ü���ݾ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				GridCtrl_SetCellStr ( m_hGrid, 2, i, sztmp );

				//���ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 200, DECRYPT);
				GridCtrl_SetCellStr ( m_hGrid, 3, i, sztmp );

				//USE_CONT_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 20, DECRYPT);
				GridCtrl_SetCellStr ( m_hGrid, 4, i, sztmp );
			}
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		if(m_lTotpage > 0)
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}


			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, GridCtrl_GetCellStr(m_hGrid, 3, m_nActIndex));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
			
			//PRINT("addr : [%d] = %s",m_nActIndex,GridCtrl_GetCellStr(m_hGrid, 3, m_nActIndex),0);
			
			Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM) );
			Str_Cpy(g_szUSE_CONT_NUM, GridCtrl_GetCellStr(m_hGrid, 4, m_nActIndex));
		
			//DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			//DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
			//Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			//Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
			
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
			
			//Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));
			//Str_Cpy( g_szUSE_CONT_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			m_lIdxFlag = 1;
		}

		ON_DRAW();		
		return TRUE;
	}

#else

	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		char sztmp[256];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		g_Sql_SaveSeq( "SELECT ROWID FROM C6202_AUCTION ORDER BY AREA, TOWN, ADDR1_M", SREACH_FILE);
		lTotPage = FS_GetSrchTotCnt();
		m_lTotpage = lTotPage;
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0)
		{
			//���α׷� ���� �� �ҷ����� �ε���
			//Get_Index();
		}

		SPRINT(m_szCnt_page, "%d/%d , %d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );

			hstmt = sql->CreateStatement(sql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, IFNULL(AREA, '') ||' '|| IFNULL(TOWN, '') ||' '|| IFNULL(VILLAGE, '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, USE_CONT_NUM, FIRM_NM, CUST_NM FROM C6202_AUCTION ORDER BY AREA, TOWN, ADDR1_M LIMIT ?, ? ");
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );

			hstmt = sql->CreateStatement(sql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , NONPAY_MM_CNT, ALL_UNPAY, IFNULL(NEW_ROAD_NM, '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(CO_LIVE_NM, '') ||' '|| CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END, USE_CONT_NUM, FIRM_NM, CUST_NM FROM C6202_AUCTION ORDER BY AREA, TOWN, ADDR1_M LIMIT ?, ? ");
		}

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
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
				
				//�ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );				
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "�����ּ�") == 0 )
				{
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "��ȣ") == 0 )
				{
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 200, DECRYPT);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "����") == 0 )
				{
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 200, DECRYPT);
				}
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				//��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//ü���ݾ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//���ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 200, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//USE_CONT_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		if(m_lTotpage > 0)
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
			Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));
			Str_Cpy( g_szUSE_CONT_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			m_lIdxFlag = 1;
		}

		ON_DRAW();		
		return TRUE;
	}

#endif
	
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
	
	/*=======================================================================================
	�Լ��� : Set_Index
	��  �� : ���� �ε��� �����Ѵ�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '9' ", g_lindex, 0, 0);		
		g_Sql_DirectExecute(szSql);
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
		long lParam9;
		
		//g_Sql_RetInt("SELECT PARAM9 FROM RCV_LOG WHERE GUBUN = '9'", &lParam9);
		
		//g_nActIndex = lParam9;		
		//m_lpage = g_nActIndex / ROW;
		//m_nActIndex = (g_nActIndex % ROW);
		
		m_lpage = g_nActIndex / ROW;
		m_nActIndex = g_nActIndex+1;
		GridCtrl_SetScroll(m_hGrid, 0, g_nScrollIndex );
		GridCtrl_SetSelectedColor(m_hGrid, m_nActIndex, TABLEACTIVE_COLOR);
		//PRINT("Get_Index >>>>>>>> g_nScrollIndex : %d , m_lpage : %d , g_nActIndex : %d",g_nScrollIndex,m_lpage,g_nActIndex);
	}

	
//-----------------------------------------------------------------------------------------------------

#ifdef GRID_DEBUG

	void Grid_Draw(void)
	{		
		long i, idx, j;
		long lRow = 0;
		long k = ROW+1;
		long lTotPage;
		char sztmp[256];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		handle hBody = NULL;
		handle hScrl = NULL;
		
		M(Grid_Draw >>>>> 1111);

/*
		//C6202_AUCTION
		//g_Sql_RetInt("SELECT COUNT(*) FROM GUMDATA", &lRow);
		lRow = 100;
	
		m_hGrid = GridCtrl_CreateObject(DMS_X(0), DMS_Y(360), DMS_X(1000), DMS_Y(1000), lRow, 6);
PRINT("Grid_Draw>>>>>>>>>>>>>>>>>>>> 1111111111 ,  m_hGrid : %x",m_hGrid,0,0);
		
		//FRMSTY_ALWAYSSHOWSB : ��ũ�ѹٸ� �׻� ���̰���. �ڵ� �� ������ �߰��������.
		FrmCtrl_ModifyStyle(m_hGrid, 0, FRMSTY_BORDER | FRMSTY_THICKBORDER | FRMSTY_ROUNDBORDER | FRMSTY_ALWAYSSHOWSB);	
		FrmCtrl_SetRoundRadius(m_hGrid, DMS_X(0));	
		FrmCtrl_SetRoundThickness(m_hGrid, DMS_X(2));
		FrmCtrl_SetRoundBoarderColor(m_hGrid, 0x52aa, 0x52aa);
		
		GridCtrl_SetHeaderHeight(m_hGrid, DMS_Y(70));
		GridCtrl_SetBodyHeight(m_hGrid, DMS_Y(120));

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			FrmCtrl_SetFont(m_hGrid, theDevInfo.m_nFontType);
		}

		GridCtrl_SetScrollDelta(m_hGrid, DMS_Y(800));
		FrmCtrl_SetVarScrollThickness(m_hGrid, DMS_X(100));
		
		GridCtrl_SetColumn(m_hGrid, 0, "�ּ�", 		DMS_X(300), 0, GCTYPE_TEXTCTRL	, 32);
		GridCtrl_SetColumn(m_hGrid, 1, "D", 		DMS_X(100), 0, GCTYPE_TEXTCTRL	, 32);
		GridCtrl_SetColumn(m_hGrid, 2, "C", 		DMS_X(100), 0, GCTYPE_TEXTCTRL	, 32);
		GridCtrl_SetColumn(m_hGrid, 3, "��ħ", 		DMS_X(200), 0, GCTYPE_TEXTCTRL	, 32);
		GridCtrl_SetColumn(m_hGrid, 4, "��뷮",    DMS_X(200), 0, GCTYPE_TEXTCTRL	, 32);
		GridCtrl_SetColumn(m_hGrid, 5, "",          DMS_X(99), 0, GCTYPE_TEXTCTRL	, 32);

		

		
		GridCtrl_CreateTable(m_hGrid);

//syscall handle	GridCtrl_GetCellHandle		(handle pGC, long x, long y);
//syscall void	GridCtrl_SetCellStr			(handle pGC, long x, long y, char* pstr);
//		hBody = GridCtrl_GetCellHandle(m_hGrid, 2, 2);
//		EditCtrl_SetStr( hBody, "1234");
//		GridCtrl_SetCellStr			(m_hGrid, 1, 1, "12111");

		m_hHeader0 = GridCtrl_GetCellHandle(m_hGrid, 0, 0);
		m_hHeader1 = GridCtrl_GetCellHandle(m_hGrid, 1, 0);
		m_hHeader2 = GridCtrl_GetCellHandle(m_hGrid, 2, 0);
		m_hHeader3 = GridCtrl_GetCellHandle(m_hGrid, 3, 0);
		m_hHeader4 = GridCtrl_GetCellHandle(m_hGrid, 4, 0);

		EditCtrl_SetBkColorEx(m_hHeader0, GRIDTTLBK);
		EditCtrl_SetBkColorEx(m_hHeader1, GRIDTTLBK);
		EditCtrl_SetBkColorEx(m_hHeader2, GRIDTTLBK);
		EditCtrl_SetBkColorEx(m_hHeader3, GRIDTTLBK);
		EditCtrl_SetBkColorEx(m_hHeader4, GRIDTTLBK);
*/
		//m_hGrid = Get_hDlgCtrlByID(ID_GRIDLIST);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,''),BASE_YMD, MTR_WORK_CODE, INDI_SET_VC, INDI_QTY FROM GUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE LIMIT 0, 100");

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=1 ; i<lRow+1 ; i++)
		{
			if(sql->Next(sql) == FALSE)
			{
				k = i + 1;
				DlgTbl_SetStr ( ID_GRIDLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_GRIDLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_GRIDLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_GRIDLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_GRIDLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_GRIDLIST, i, 5, "" );
				continue;
			}

			j = 0;
			//�ּ�
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
			//DlgTbl_SetStr ( ID_GRIDLIST, i, 0, sztmp );				
			GridCtrl_SetCellStr(m_hGrid, j, i, sztmp);
			j++;
			//D
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 1, 'U', (long*)sztmp, 5, DECRYPT);
			//DlgTbl_SetStr ( ID_GRIDLIST, i, 1, sztmp );
			GridCtrl_SetCellStr(m_hGrid, j, i, sztmp);
			j++;
			//C
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
			//Str_Chg(sztmp, STRCHG_INS_COMMA);
			//DlgTbl_SetStr ( ID_GRIDLIST, i, 2, sztmp );
			GridCtrl_SetCellStr(m_hGrid, j, i, sztmp);
			j++;
			//��ħ
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 3, 'U', (long*)sztmp, 200, DECRYPT);
			//DlgTbl_SetStr ( ID_GRIDLIST, i, 3, sztmp );
			GridCtrl_SetCellStr(m_hGrid, j, i, sztmp);
			j++;
			//��뷮
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 4, 'U', (long*)sztmp, 20, DECRYPT);
			//DlgTbl_SetStr ( ID_GRIDLIST, i, 4, sztmp );
			GridCtrl_SetCellStr(m_hGrid, j, i, sztmp);
		}

Finally:

		DelSqLite(sql);

/*
		if(m_lTotpage > 0)
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
			Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));
			Str_Cpy( g_szUSE_CONT_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			m_lIdxFlag = 1;
		}
*/


		
		//GridCtrl_Draw(m_hGrid, TRUE);
		//ON_DRAW();
		GrDev_Refresh();
		OnDraw();		
		return;
	}
	
#else

	void Grid_Draw(void)
	{		
		M(Grid_Draw >>>>>);
	}
	
#endif	

	//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name[5][32] = {"�����ּ�", "����", "ü���ݾ�", "", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","1","2","0","0"};
		char col_align[5][10]  = {"left", "center", "center","", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		if( g_nAddrFlag == 0 )
		{
			Str_Cpy(m_szQuickSql, "SELECT \
CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 \
THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END \
, NONPAY_MM_CNT, ALL_UNPAY \
FROM C6202_AUCTION ORDER BY AREA, TOWN, ADDR1_M");
		}
		else
		{
			Str_Cpy(m_szQuickSql, "SELECT \
CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 \
THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END \
, NONPAY_MM_CNT, ALL_UNPAY \
FROM C6202_AUCTION ORDER BY AREA, TOWN, ADDR1_M");
		}

		h = JSON_Create( JSON_Object );
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridListView");
			//�� ȣ��������, ���� ��ġ�� ����ϰ� �������� �� ȣ��� ����
			//true�� �� �־�� �Ѵ�.
			//���� ������ �ٸ� �並 ȣ���� ���, ������ �ǹǷ� �ݵ�� �Ź� ȣ���
			//���� �Ǵ��Ͽ� ��� �ؾ� �Ѵ�.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_nActIndex-1;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query", m_szQuickSql);
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "���Ȱ�� ����Ʈ");
			JSON_SetValue	(h		, 'C', "method"			, "ListViewActivity");
			JSON_Attach 	(h		, "data"				, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	
	}
}



