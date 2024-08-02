/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6301_LST
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
	//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
//����Ʈ
		DEF_BUTTON_ID ( BID_TBL_BARCODE )
		DEF_BUTTON_ID ( BID_ADDR )		//�ּ�
		DEF_BUTTON_ID ( BID_NADDR )
		DEF_BUTTON_ID ( BID_UP )		//����������
		DEF_BUTTON_ID ( BID_DOWN )		//����������
		DEF_BUTTON_ID ( BID_MEMO )
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//�����ּ� ��ũ�� ȣ��
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//����Ʈ
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE )			//��������
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
		
		DEF_OBJECT_ID ( LINE_DATA1 )
		DEF_OBJECT_ID ( LINE_DATA2 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
//����Ʈ
		DEF_OBJECT_ID ( CMB_SELECT )
//����Ʈ
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
		DEF_OBJECT_ID ( ID_TBLLIST2 )	// ���̺� ����Ʈ

		DEF_OBJECT_ID ( CMB_GMTYPE )
		
	END_OBJECT_ID()

	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    5					// table�� �ళ��
	#define		COL 	    12					// table�� ������
	#define		GRID_TITLEH CHT+18				// table�� Ÿ��Ʋ �� ����
	#define		GRID_H		(CHT+76)			// table �� ����
	#define		GRID_H_P	(CHT+86)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		0 			    // table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+260  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY+200  	    // table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf   [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"��ü���", 			CWD*27+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"����",     			CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���",     			CWD*6 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"MTR_GRD",  		    CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"PDA_REPL_JOB_ITEM",   CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"MTR_NUM",     		CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"OBJ_CRT_YMD",	     	CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"Ÿ��",		     	CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"��ġ",		     	CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���ּ�",	     	CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"MEMO",		     	CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"NOBILL_YN",		    CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1	

/*
g_nWorkFlag = 700		�跮�ⱳü ���ĸ���Ʈ
g_nWorkFlag = 701		�跮�ⱳü ���ĸ���Ʈ(�̽ǽ�)
g_nWorkFlag = 702		�跮�ⱳü ���ĸ���Ʈ(��ü)

g_nWorkFlag = 710		�跮�ⱳü �ο�����Ʈ
g_nWorkFlag = 711		�跮�ⱳü �ο�����Ʈ(�̽ǽ�)
g_nWorkFlag = 712		�跮�ⱳü �ο�����Ʈ(��ü)

g_nWorkFlag = 720		�跮�ⱳü ��ü�Ұ�����Ʈ
g_nWorkFlag = 721		�跮�ⱳü ��ü�Ұ�����Ʈ(�̽ǽ�)
g_nWorkFlag = 722		�跮�ⱳü ��ü�Ұ�����Ʈ(��ü)

g_nWorkFlag = 730		�跮�ⱳü ���ø���Ʈ
g_nWorkFlag = 731		�跮�ⱳü ���ø���Ʈ(�̽ǽ�)
g_nWorkFlag = 732		�跮�ⱳü ���ø���Ʈ(��ü)

g_nWorkFlag = 740       �跮�ⱳü ����ǥ����Ʈ
g_nWorkFlag = 741       �跮�ⱳü ����ǥ����Ʈ(�̽ǽ�)
g_nWorkFlag = 742       �跮�ⱳü ����ǥ����Ʈ(��ü)
*/
	
	long m_lIdxFlag = 0;
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_nActIndex = -1;
	char m_bFirst;				//INIT_MAIN �� INIT_SRCH �� ���� ���� ���� flag
	char m_szTitle[100];
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szCobSel[20];
	char m_szSendYn[10];
	char m_szMtrGrd[10];
	char m_szPdaRepl[10];
	char m_szMtrType[10];
	char m_szMtrLoc[10];
	char m_szNoBillYn[2];
	char m_szSql[2][2600];
	char m_szBarcode_Value[20];	//���ڵ� ��ĵ ���
	handle m_hData = NULL;		//grid quick ������ �ڵ�

	bool m_bChgGmFlag = FALSE;
	// long g_nGmKind = 0;		//�۷ι��� ������ �ٲ㼭 �����ϵ��� �Ѵ�.
	
	long FS_GetSrchTotCnt(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void Cmb_Filter(void);
	void Cmb_Result(void);
	void SetWorkFlag(void);
	void Grid_QuickList(void);
	void Grid_SetQuery(void);
	void OnList(quad lParam);

	void Search_BarcodeData(char* szBarnum);
	void Barcode(void);
	void OnBarcodeRead(void);
	void PDA_OnBarcodeRead(void);

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
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle),
		
		DLG_BUTTON(STARTX+230, STARTY+65, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+430,  STARTY+65, 135, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+565,  STARTY+65, 135, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),
		DLG_BUTTON(STARTX+810, STARTY+185, 190, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "�޸�"),	
		DLG_BUTTON(STARTX,  STARTY+65, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, m_szCnt_page),
		
		DLG_TEXT(STARTX,      STARTY+125, 120, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA1, "��ü"),
		DLG_TEXT(STARTX+135-20,  STARTY+125, 120, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),

		DLG_COMBO (STARTX+135-20+120, STARTY+125, 260, 250, 100, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GMTYPE, 11),

		DLG_TEXT(STARTX+315+55+40+20+60,  STARTY+125, 120, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA3, "��ü"),
		DLG_TEXT(STARTX+455+55+40+60,  STARTY+125, 110, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+635+55+30,  STARTY+125, 170, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA5, "�̱�ü"),
		DLG_TEXT(STARTX+805+55+30,  STARTY+125, 110, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_TEXT(STARTX,  	  STARTY+185, 140, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA7, "���"),
		DLG_TEXT(STARTX+135,  STARTY+185, 180, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+315,  STARTY+185, 140, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA9, "Ÿ��"),
		DLG_TEXT(STARTX+455,  STARTY+185, 100, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+555,  STARTY+185, 115, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA11, "��ġ"),
		DLG_TEXT(STARTX+670,  STARTY+185, 140, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
	
		DLG_COMBO (STARTX+700, STARTY+65, 300, 250, 100, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 11),	//
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_TITLEH, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		DLG_BUTTON(STARTX, STARTY+260, CWD*27+23, 58, 0, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TBL_BARCODE, "��ü���"),
	};

	//---------------------------------------------------------------
	DlgObject DlgResBase[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_szTitle),
		
		DLG_BUTTON(STARTX+230, STARTY+65, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+430,  STARTY+65, 135, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+565,  STARTY+65, 135, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),
		DLG_BUTTON(STARTX+810, STARTY+185, 190, 55, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "�޸�"),
		DLG_BUTTON(STARTX,  STARTY+65, 230, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, m_szCnt_page),
		
		DLG_TEXT(STARTX,      STARTY+125, 140, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA1, "��ü"),
		DLG_TEXT(STARTX+135,  STARTY+125, 180, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+315,  STARTY+125, 140, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA3, "��ü"),
		DLG_TEXT(STARTX+455,  STARTY+125, 180, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+635,  STARTY+125, 170, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA5, "�̱�ü"),
		DLG_TEXT(STARTX+805,  STARTY+125, 195, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_TEXT(STARTX,  	  STARTY+185, 140, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA7, "���"),
		DLG_TEXT(STARTX+135,  STARTY+185, 180, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+315,  STARTY+185, 140, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA9, "Ÿ��"),
		DLG_TEXT(STARTX+455,  STARTY+185, 100, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+555,  STARTY+185, 115, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA11, "��ġ"),
		DLG_TEXT(STARTX+670,  STARTY+185, 140, 55, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),

		DLG_COMBO (STARTX+700, STARTY+65, 300, 250, 100, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 11),	//
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_TITLEH, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
	};	

	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, m_szTitle),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX+230,	STARTY-40, 200, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����"),
		DLG_BUTTON(STARTX+430,  STARTY-40, 135, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+565,  STARTY-40, 135, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),
		DLG_BUTTON(STARTX+815, STARTY+120, 185, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "�޸�"),
		
		DLG_TEXT(STARTX,       STARTY-40, 230, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		
		DLG_TEXT(STARTX,      STARTY+40, 140, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA1, "��ü"),
		DLG_TEXT(STARTX+140,  STARTY+40, 180, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+320,  STARTY+40, 140, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA3, "��ü"),
		DLG_TEXT(STARTX+460,  STARTY+40, 180, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+640,  STARTY+40, 170, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA5, "�̱�ü"),
		DLG_TEXT(STARTX+810,  STARTY+40, 190, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		
		DLG_TEXT(STARTX,  	  STARTY+120, 140, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA7, "���"),
		DLG_TEXT(STARTX+140,  STARTY+120, 180, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+320,  STARTY+120, 140, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA9, "Ÿ��"),
		DLG_TEXT(STARTX+460,  STARTY+120, 100, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+560,  STARTY+120, 115, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLRSLTBK, TXT_DATA11, "��ġ"),
		DLG_TEXT(STARTX+675,  STARTY+120, 140, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_COMBO (STARTX+700, STARTY-40, 300, 250, 100, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SELECT, 11),	//
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_TITLEH, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),		
		DLG_BUTTON(STARTX, STARTY+200, CWD*27+23, GRID_TITLEH, 0, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TBL_BARCODE, "��ü���"),
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
		long i = 0, j = 0;
		char szindex[10];
		char szSql[1500];
		char szWhere[512];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		i = lParam;

		if( i > -1 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
			Str_Cpy(szSql, "SELECT ROWID FROM C6301_CHANGEDATA ");
			if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
			{
				//����
				Str_Cpy(szWhere, "WHERE REPL_OCCU_FLAG = '10' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ");
			}
			else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
			{
				//�ο�
				Str_Cpy(szWhere, "WHERE REPL_OCCU_FLAG = '20' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ");
			}
			else if( g_nWorkFlag > 739 )
			{
				//����ǥ
				Str_Cpy(szWhere, "WHERE NOBILL_YN ='Y' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ");
			}
			else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
			{
				//�Ұ�
				Str_Cpy(szWhere, "WHERE LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30' ");
			}
			else if( g_nWorkFlag > 729 && g_nWorkFlag < 739 )
			{
				//����
				Str_Cpy(szWhere, "WHERE ");
				Str_Cat(szWhere, g_szSqlWhere);
			}

			Str_Cat(szSql, szWhere);
			Str_Cat(szSql, "ORDER BY ROWID");

			g_Sql_SaveSeq( szSql, SREACH_FILE);
			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				DelSqLite(sql);
				goto Finally;
			}
	
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Str_Cpy(szSql, "SELECT SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, OBJ_CRT_YMD, NOBILL_YN FROM C6301_CHANGEDATA ");
			Str_Cat(szSql, szWhere);
			Str_Cat(szSql, " AND ROWID = ?");
			hstmt = sql->CreateStatement(sql, szSql);
			
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				DelSqLite(sql);
				goto Finally;
			}
	
			j = 0;
			Mem_Set((byte*)szindex, 0x00, sizeof(szindex));
			Str_ItoA(g_lindex,szindex,10);
			sql->Bind(sql, j++, 'U', (long*)&szindex , 10, DECRYPT);

			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				DelSqLite(sql);
				goto Finally;
			}
	
			if(sql->Next(sql) == TRUE )
			{	
				Mem_Set( (byte*)m_szSendYn, 0x00, sizeof(m_szSendYn) );
				Mem_Set( (byte*)m_szMtrGrd, 0x00, sizeof(m_szMtrGrd) );
				Mem_Set( (byte*)m_szPdaRepl, 0x00, sizeof(m_szPdaRepl) );
				Mem_Set( (byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM) );
				Mem_Set( (byte*)g_szOBJ_CRT_YMD, 0x00, sizeof(g_szOBJ_CRT_YMD) );
				Mem_Set( (byte*)m_szNoBillYn, 0x00, sizeof(m_szNoBillYn) );
	                                                                                                                                                               
				j = 0;
				sql->GetValue( sql, j++, 'U', (long*) m_szSendYn				, 2  + 1, DECRYPT );
				sql->GetValue( sql, j++, 'U', (long*) m_szMtrGrd				, 7  + 1, DECRYPT );
				sql->GetValue( sql, j++, 'U', (long*) m_szPdaRepl				, 2  + 1, DECRYPT );
				sql->GetValue( sql, j++, 'U', (long*) g_szMTR_NUM				, 10 + 1, DECRYPT );
				sql->GetValue( sql, j++, 'U', (long*) g_szOBJ_CRT_YMD			, 8  + 1, DECRYPT );
				sql->GetValue( sql, j++, 'U', (long*) m_szNoBillYn				, 2  + 1, DECRYPT );
				
				DelSqLite(sql);
			}
			else
			{
				PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
				DelSqLite(sql);
				goto Finally;
			}
	
			if( MATCH(m_szSendYn, "Y") )
			{
				MessageBoxEx (CONFIRM_OK, "�̹� �۽��� �ڷ� �Դϴ�.");
				return;
			}
		
			g_lDataflag = 0;
			g_lMoveFlag = 0;
			Set_Index();
			//g_nBojungFlag;    //�跮�� ������� ���� Flag , Flag = 0 ���������, Flag = 1 ����������, Flag = 2 ���Ϻ�����
			if( MATCH(m_szPdaRepl, "10") || MATCH(m_szPdaRepl, "30") )
			{
				if( Str_AtoI(m_szMtrGrd) >= 10 )
				{
					if( MATCH(m_szPdaRepl, "10") )
					{
						g_nBojungFlag = 0;
					}
					else
					{
						g_nBojungFlag = 1;
					}

					//��뷮
					Card_Move("C6301_BIGCHG");
				}
				else if( Str_AtoI(m_szMtrGrd) < 10 )
				{
					if( MATCH(m_szPdaRepl, "10") )
					{
						g_nBojungFlag = 0;
					}
					else
					{
						g_nBojungFlag = 1;
					}

					//�ҿ뷮
					Card_Move("C6301_MTRCHG");
				}
			}
			else if( MATCH(m_szPdaRepl, "20") )
			{
				g_nBojungFlag = 2;

				//������
				Card_Move("C6301_BOJUNGCHG");
			}
			else if (MATCH(m_szNoBillYn, "Y") )
			{
				//�ҿ뷮
				Card_Move("C6301_MTRCHG");
			}
		}
		
Finally:

		return;
	}
	
//------------------------------------------------------------------
	void OnInit(char bFirst)
	{
		m_bFirst = bFirst;
	
		switch (bFirst)
		{
			case INIT_MAIN:
				
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);

						// #ifndef VER_RELEASE
						// 	#error ">>>>>>>> [FIXME] PLS, Remove the below code for product build!!! <<<<<<<"
						// 	//[FIXME] �׽�Ʈ �ڵ� �̹Ƿ�, ���� �׽�Ʈ�� ������ �����Ͻÿ�.
						// 	g_nWorkFlag = 700;
						// #endif

						PRINT(">>>>>> g_nGmKind => %d", g_nGmKind, 0, 0);

						if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
						{
							M("DlgRes....");
							//���ı�ü�� ����� ȭ��
							CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));

							ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMTYPE+2), "��ü"	, 0, ICON_NONE);
							ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMTYPE+2), "�Ϲ���"	, 1, ICON_NONE);
							ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GMTYPE+2), "Ư����"	, 2, ICON_NONE);

							//���ǰ� �ڵ忡 ���� �ʱ�ȭ �� ��� ��.
							{
								handle h = Get_hDlgCtrlByID(CMB_GMTYPE+2);
								ListCtrl_SelectItem(h, g_nGmKind);
								EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_GMTYPE), ListCtrl_GetSelStr(h));
							}

							//�Ʒ��� ���� ������ �ʿ� �� �� �� �ִ�.
							// Str_Cpy(m_szCobSel, "��ü");

							m_bChgGmFlag = TRUE;
						}
						else
						{
							M("DlgResBase....");
							CREATE_DIALOG_OBJECT (DlgResBase, SIZEOF(DlgResBase));
						}
						break;
				}

				PRINT("g_nWorkFlag => %d, m_bChgGmFlag => %d", g_nWorkFlag, m_bChgGmFlag, 0);

				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "��ü"	, 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "�̽ǽ�"	, 1, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELECT+2), "��ü"	, 2, ICON_NONE);
				g_nAddrFlag = 0;
				
				SetBtnImg();
				SetStyle();
				
				Mem_Set( (byte*)m_szTitle, 0x00, sizeof(m_szTitle) );
				if( g_nWorkFlag == 700 )
				{
					Str_Cpy(m_szTitle, "���ı�ü �۾�����Ʈ");
				}
				else if( g_nWorkFlag == 710 )
				{
					Str_Cpy(m_szTitle, "�ο���ü �۾�����Ʈ");
				}
				else if( g_nWorkFlag == 720)
				{
					Str_Cpy(m_szTitle, "��ü�Ұ� �۾�����Ʈ");
				}
				else if( g_nWorkFlag == 730)
				{
					Str_Cpy(m_szTitle, "���ñ�ü �۾�����Ʈ");
				}
				else if( g_nWorkFlag == 740)
				{
					Str_Cpy(m_szTitle, "����ǥ��ü �۾�����Ʈ");
				}
				
				if( g_nWorkFlag == 700 || g_nWorkFlag == 710 || g_nWorkFlag == 720 || g_nWorkFlag == 730 || g_nWorkFlag == 740)
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "��ü");
					Str_Cpy(m_szCobSel, "��ü");							
				}
				else if( g_nWorkFlag == 701 || g_nWorkFlag == 711 || g_nWorkFlag == 721 || g_nWorkFlag == 731 || g_nWorkFlag == 744)
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "�̽ǽ�");
					Str_Cpy(m_szCobSel, "�̽ǽ�");
				}
				else if( g_nWorkFlag == 702 || g_nWorkFlag == 712 || g_nWorkFlag == 722 || g_nWorkFlag == 732 || g_nWorkFlag == 742)
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELECT), "��ü");
					Str_Cpy(m_szCobSel, "��ü");
				}

				Cmb_Filter();
				REDRAW();
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
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_TBL_BARCODE:
				Barcode();
				break;
			case BID_ADDR:
				//g_nAddrFlag = 0 -> ���ּ�    g_nAddrFlag = 1 -> ���ּ�
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
			case BID_QUICK_ADDR:
				Grid_QuickList();
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					return;
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
					break;
				}
				m_nActIndex = 0;
				REDRAW();
				break;
			case BID_MEMO:
				g_nMemoFlag = 6;
				g_nActIndex = m_lpage*ROW + m_nActIndex;
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				Set_Index();
				Card_Move("CM_MEMO");
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
				Card_Move("C6301_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}
	
//��������������������������������������������������������������������������������������������
	void OnSelect(long Index)
	{
		long index = -1;
		char szcmb[20];
		char szSql[301];
		char sztmp[301];

		long kind = 0;
		BOOL gmTypeFlag = FALSE;

		if( INIT_MAIN == m_bFirst )
		{
			//PRINT("m_szNoBillYn : %s",m_szNoBillYn,0,0);
			//PRINT("m_szPdaRepl : %s",m_szPdaRepl,0,0);

			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// ���� �ε����� ���� �ε����� ���� �� ���
				if ( index-1 == m_nActIndex )
				{
					if( MATCH(m_szSendYn, "Y") )
					{
						MessageBoxEx (CONFIRM_OK, "�̹� �۽��� �ڷ� �Դϴ�.");
						return;
					}
				
					g_nActIndex = m_lpage*ROW + m_nActIndex;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					g_lDataflag = 0;
					g_lMoveFlag = 0;
					Set_Index();
					//g_nBojungFlag;    //�跮�� ������� ���� Flag , Flag = 0 ���������, Flag = 1 ����������, Flag = 2 ���Ϻ�����
					if( MATCH(m_szPdaRepl, "10") || MATCH(m_szPdaRepl, "30") )
					{
						if( Str_AtoI(m_szMtrGrd) >= 10 )
						{
							if( MATCH(m_szPdaRepl, "10") )
							{
								g_nBojungFlag = 0;
							}
							else
							{
								g_nBojungFlag = 1;
							}
							Card_Move("C6301_BIGCHG");
						}
						else if( Str_AtoI(m_szMtrGrd) < 10 )
						{
							if( MATCH(m_szPdaRepl, "10") )
							{
								g_nBojungFlag = 0;
							}
							else
							{
								g_nBojungFlag = 1;
							}

							Card_Move("C6301_MTRCHG");
						}
					}
					else if( MATCH(m_szPdaRepl, "20") )
					{
						g_nBojungFlag = 2;
						Card_Move("C6301_BOJUNGCHG");
					}
					else if ( MATCH(m_szNoBillYn, "Y") )
					{
						Card_Move("C6301_MTRCHG");
					}
					return;
				}
				else
				{
					m_nActIndex = index - 1;//���õ� INDEX ����
				
					Mem_Set( (byte*)m_szSendYn, 0x00, sizeof(m_szSendYn) );
					Mem_Set( (byte*)m_szMtrGrd, 0x00, sizeof(m_szMtrGrd) );
					Mem_Set( (byte*)m_szPdaRepl, 0x00, sizeof(m_szPdaRepl) );
					Mem_Set( (byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM) );
					Mem_Set( (byte*)g_szOBJ_CRT_YMD, 0x00, sizeof(g_szOBJ_CRT_YMD) );
					Mem_Set( (byte*)m_szMtrType, 0x00, sizeof(m_szMtrType) );
					Mem_Set( (byte*)m_szMtrLoc, 0x00, sizeof(m_szMtrLoc) );
					if( MATCH(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2), "��") )
					{
						Str_Cpy( m_szSendYn, "N");
					}
					else if( MATCH(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2), "��ü") )
					{
						Str_Cpy( m_szSendYn, "S");
					}
					else if( MATCH(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2), "�Ϸ�") )
					{
						Str_Cpy( m_szSendYn, "Y");
					}
					else
					{
						Str_Cpy( m_szSendYn, "N");
					}

					Str_Cpy( m_szMtrGrd, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), m_szMtrGrd);		

					Str_Cpy( m_szPdaRepl, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
					Str_Cpy( g_szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
					Str_Cpy( g_szOBJ_CRT_YMD, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));

					//Ÿ��
					Str_Cpy( m_szMtrType, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					SPRINT(szSql, "SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'B30003' AND CODE_ITEM = '%s'",m_szMtrType, 0, 0 );
					g_Sql_RetStr( szSql, 20, sztmp );
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), sztmp);
					
					//��ġ
					Str_Cpy( m_szMtrLoc, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
					if( MATCH(m_szMtrLoc, "10") )
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "����");
					}
					else if( MATCH(m_szMtrLoc, "20") )
					{
						EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "�ܺ�");
					}
			
					//���ּ�
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9));
					
					//�޸�
					if( MATCH(m_szPdaRepl, "20") )
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_MEMO), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MEMO), TRUE );
					}
					else
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_MEMO), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MEMO), FALSE );

						Mem_Set( (byte*)stMtrChg.MEMO, 0x00, sizeof(stMtrChg.MEMO) );
						Str_Cpy(stMtrChg.MEMO, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10));
						if( Str_Len(stMtrChg.MEMO) > 0 )
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MEMO), RED);
						}
						else
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNCTRLBKCOLOR);
						}
					}
				}
			}

			PRINT("m_nGmKind = %d vs kind = %d", g_nGmKind, kind, 0);

			if (m_bChgGmFlag)
			{
				handle h = Get_hDlgCtrlByID(CMB_GMTYPE+2);
				long i = ListCtrl_GetSelIndex(h);
				kind = ListCtrl_GetData(h, i);

				// PRINT("33333333333333333333 => %d, %s, %d", i, ListCtrl_GetStr(hCmb, i), m_nGmType);
				if (kind != g_nGmKind)
				{
					g_nGmKind = kind;
					gmTypeFlag = TRUE;

					M("GM type changed....");
				}
			}

			Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
			Str_Cpy( szcmb, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELECT) ) );
			//�޺��ڽ� �������� ����Ʈ ��� ���͸�.(��ü,�̽ǽ�,��ü)
			// if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
			if( !MATCH(m_szCobSel, szcmb) || gmTypeFlag)
			{
				Str_Cpy(m_szCobSel, szcmb);

				//���� �� g_nWorkFlag ����
				SetWorkFlag();

				//�������� �ʱ�ȭ��Ų��.
				m_lpage = 0;
				m_nActIndex = 0;

				Cmb_Filter();

				REDRAW();
			}
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
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//------------------------------------------------------------------------------------------
	void SetWorkFlag(void)
	{
		if( MATCH(m_szCobSel, "�̽ǽ�" ) )
		{
			if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
			{
				g_nWorkFlag = 701;
			}
			else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
			{
				g_nWorkFlag = 711;
			}
			else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
			{
				g_nWorkFlag = 721;
			}
			else if( g_nWorkFlag > 729 && g_nWorkFlag < 740 )
			{
				g_nWorkFlag = 731;
			}
			else if( g_nWorkFlag > 739)
			{
				g_nWorkFlag = 741;
			}
		}
		else if( MATCH(m_szCobSel, "��ü" ) )
		{
			if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
			{
				g_nWorkFlag = 702;
			}
			else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
			{
				g_nWorkFlag = 712;
			}
			else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
			{
				g_nWorkFlag = 722;
			}
			else if( g_nWorkFlag > 729 && g_nWorkFlag < 740 )
			{
				g_nWorkFlag = 732;
			}
			else if( g_nWorkFlag > 739 )
			{
				g_nWorkFlag = 742;
			}
		}
		else if( MATCH(m_szCobSel, "��ü" ) )
		{
			if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
			{
				g_nWorkFlag = 700;
			}
			else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
			{
				g_nWorkFlag = 710;
			}
			else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
			{
				g_nWorkFlag = 720;
			}
			else if( g_nWorkFlag > 729 && g_nWorkFlag < 740 )
			{
				g_nWorkFlag = 730;
			}
			else if (g_nWorkFlag > 739 )
			{
				g_nWorkFlag = 740;
			}
		}
	}

//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		char szSql[301];
		char sztmp[301];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		m_lTotpage = FS_GetSrchTotCnt();
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0 && (g_nWorkFlag > 699 && g_nWorkFlag < 730) )
		{
			//���α׷� ���� �� �ҷ����� �ε���
			Get_Index();
			
			m_lIdxFlag = 1;
		}
		else if( g_lMoveFlag == 1 && (g_nWorkFlag > 729 && g_nWorkFlag < 739) )
		{
			//���α׷� ���� �� �ҷ����� �ε���
			//Get_Index();
			m_lpage = g_nActIndex / ROW;
			m_nActIndex = (g_nActIndex % ROW);
			
			g_lMoveFlag = 0;
		}
		else if( m_lIdxFlag == 0 && g_nWorkFlag > 739) 
		{
			//���α׷� ���� �� �ҷ����� �ε���
			Get_Index();
			
			m_lIdxFlag = 1;
		}

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
/*
		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );
			hstmt = sql->CreateStatement(sql, m_szSql[1]);
		}
*/

		if( g_nAddrFlag == 0)
		{
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		}
		else
		{
			hstmt = sql->CreateStatement(sql, m_szSql[1]);
		}
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 11, "" );
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
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 11, "" );
					continue;
				}

				idx = 0;
				//��ü���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 200 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  20 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );		
				//�۽ſ���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2 +1, DECRYPT);
				if( MATCH(sztmp, "N") )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "��" );
				}
				else if( MATCH(sztmp, "S") )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "��ü" );
				}
				else if( MATCH(sztmp, "Y") )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "�Ϸ�" );
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				}
				//�跮����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  10 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );	
				//PDA_REPL_JOB_ITEM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  3 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );	
				//�跮���ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  10 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );	
				//OBJ_CRT_YMD
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  9 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );	
				//Ÿ��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  9 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );	
				//��ġ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  9 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );	
				//���ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  9 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
				//���ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  9 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp,  9 +1, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 11, sztmp );
			}
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		if( m_nActIndex < 0 )
		{
			m_nActIndex =0;
		}

//PRINT("m_lTotpage : %d",m_lTotpage,0,0);
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)m_szSendYn, 0x00, sizeof(m_szSendYn) );
			Mem_Set( (byte*)m_szMtrGrd, 0x00, sizeof(m_szMtrGrd) );
			Mem_Set( (byte*)m_szPdaRepl, 0x00, sizeof(m_szPdaRepl) );
			Mem_Set( (byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM) );
			Mem_Set( (byte*)g_szOBJ_CRT_YMD, 0x00, sizeof(g_szOBJ_CRT_YMD) );
			Mem_Set( (byte*)m_szMtrType, 0x00, sizeof(m_szMtrType) );
			Mem_Set( (byte*)m_szMtrLoc, 0x00, sizeof(m_szMtrLoc) );

			if( MATCH(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2), "��") )
			{
				Str_Cpy( m_szSendYn, "N");
			}
			else if( MATCH(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2), "��ü") )
			{
				Str_Cpy( m_szSendYn, "S");
			}
			else if( MATCH(DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2), "�Ϸ�") )
			{
				Str_Cpy( m_szSendYn, "Y");
			}
			else
			{
				Str_Cpy( m_szSendYn, "N");
			}

			Str_Cpy( m_szMtrGrd, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), m_szMtrGrd);		
			
			Str_Cpy( m_szPdaRepl, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			Str_Cpy( g_szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			Str_Cpy( g_szOBJ_CRT_YMD, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			Str_Cpy( m_szNoBillYn, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 11));
			
			//Ÿ��
			Str_Cpy( m_szMtrType, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 7));
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, "SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'B30003' AND CODE_ITEM = '%s'",m_szMtrType, 0, 0 );
			g_Sql_RetStr( szSql, 20, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), sztmp);
			
			//��ġ
			Str_Cpy( m_szMtrLoc, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 8));
			if( MATCH(m_szMtrLoc, "10") )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "����");
			}
			else if( MATCH(m_szMtrLoc, "20") )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "�ܺ�");
			}
	
			//���ּ�
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13), DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 9));

			//�޸�
			if( MATCH(m_szPdaRepl, "20") )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_MEMO), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MEMO), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_MEMO), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_MEMO), FALSE );

				Mem_Set( (byte*)stMtrChg.MEMO, 0x00, sizeof(stMtrChg.MEMO) );
				Str_Cpy(stMtrChg.MEMO, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 10));
				if( Str_Len(stMtrChg.MEMO) > 0 )
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MEMO), RED);
				}
				else
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNCTRLBKCOLOR);
				}
			}
		}
		else
		{
			Mem_Set( (byte*)m_szSendYn, 0x00, sizeof(m_szSendYn) );
			Mem_Set( (byte*)m_szMtrGrd, 0x00, sizeof(m_szMtrGrd) );
			Mem_Set( (byte*)m_szPdaRepl, 0x00, sizeof(m_szPdaRepl) );
			Mem_Set( (byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM) );
			Mem_Set( (byte*)g_szOBJ_CRT_YMD, 0x00, sizeof(g_szOBJ_CRT_YMD) );
			Mem_Set( (byte*)m_szMtrType, 0x00, sizeof(m_szMtrType) );
			Mem_Set( (byte*)m_szMtrLoc, 0x00, sizeof(m_szMtrLoc) );
			Mem_Set( (byte*)m_szNoBillYn, 0x00, sizeof(m_szNoBillYn) );

			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), "");
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "");
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNCTRLBKCOLOR);
		}

		ON_DRAW();
		return;
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
	
	//-----------------------------------------------------------------------------------------------
	//�޺��ڽ��� �̿��� ��ü,����,������ ��� ����m_szCobSel
	//-----------------------------------------------------------------------------------------------
	char szTypeWhere[200];
	void Cmb_Filter(void)
	{
		char szRow[800];

		Mem_Set( (byte*)szRow, 0x00, sizeof(szRow) );
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );

		if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
		{
			memset(szTypeWhere, 0, sizeof(szTypeWhere));

			//m_nGmType => 0: ��ü, 1: �Ϲ���, 2: Ư����
			switch(g_nGmKind)
			{
				default:
				case 0:	//��ü
						M("All");
						break;

				case 1:	//�Ϲ���
						M("Normal");
						//���͸� ���������� �߰��Ǿ�� ��.
						strcpy(szTypeWhere, " AND MTR_KIND IN (10,30,40,41,42,70,80)");
						break;

				case 2: //Ư����
						M("Special");
						//�̼�ġ �ƴҶ���, 30�� ���ԵǾ�� �Ѵ�.
						strcpy(szTypeWhere, " AND case when MTR_REMOTE_FLAG <> 10 then MTR_KIND IN (20,21,30,50,60,61,65,66) else MTR_KIND IN (20,21,50,60,61,65,66) end");
						break;
			}

			//���ı�ü
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				g_nWorkFlag = 701;
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				g_nWorkFlag = 702;
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				SPRINT(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", m_szCobSel, 0, 0 );
				g_nWorkFlag = 700;
			}

			strcat(szRow, szTypeWhere);
			strcat(szRow, " ORDER BY ROWID");

			PRINT("sql => %s", szRow, 0, 0);

			g_Sql_SaveSeq( szRow, SREACH_FILE);

			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��'  ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO , NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat ( m_szSql[0], szTypeWhere);
				strcat ( m_szSql[0], " ORDER BY ROWID LIMIT ? , ?");

				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat ( m_szSql[1], szTypeWhere);
				strcat ( m_szSql[1], " ORDER BY ROWID LIMIT ? , ?");
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE TRIM(HOUSE_CNT) ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO , NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat ( m_szSql[0], szTypeWhere);
				strcat ( m_szSql[0], " ORDER BY ROWID LIMIT ? , ?");

				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat ( m_szSql[1], szTypeWhere);
				strcat ( m_szSql[1], " ORDER BY ROWID LIMIT ? , ?");
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat ( m_szSql[0], szTypeWhere);
				strcat ( m_szSql[0], " ORDER BY ROWID LIMIT ? , ?");

				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat ( m_szSql[1], szTypeWhere);
				strcat ( m_szSql[1], " ORDER BY ROWID LIMIT ? , ?");
			}
		}
		else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
		{
			//�ο���ü
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N' ORDER BY ROWID");
				g_nWorkFlag = 711;
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N' ORDER BY ROWID");
				g_nWorkFlag = 712;
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				SPRINT(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N' ORDER BY ROWID", m_szCobSel, 0, 0 );
				g_nWorkFlag = 710;
			}
	
			g_Sql_SaveSeq( szRow, SREACH_FILE);
	
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��'  ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO , NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE TRIM(HOUSE_CNT) ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
			}
		}
		else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
		{
			//��ü�Ұ�
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND NOBILL_YN ='N' ORDER BY ROWID");
				g_nWorkFlag = 721;
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND NOBILL_YN ='N' ORDER BY ROWID");
				g_nWorkFlag = 722;
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				SPRINT(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND NOBILL_YN ='N' ORDER BY ROWID", m_szCobSel, 0, 0 );
				g_nWorkFlag = 720;
			}
	
			g_Sql_SaveSeq( szRow, SREACH_FILE);
	
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��'  ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE TRIM(HOUSE_CNT) ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND NOBILL_YN ='N' ORDER BY ROWID LIMIT ? , ?");
			}
		}
		else if( g_nWorkFlag > 729 && g_nWorkFlag < 739 )
		{
			//���ñ�ü
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE (SEND_YN == 'N' OR SEND_YN IS NULL) AND ");
				g_nWorkFlag = 731;
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE (SEND_YN == 'S' OR SEND_YN == 'Y') AND ");
				g_nWorkFlag = 732;
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				SPRINT(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE ", 0, 0, 0 );
				g_nWorkFlag = 730;
			}

			Str_Cat(szRow, g_szSqlWhere);
			Str_Cat(szRow, "ORDER BY ROWID");

			g_Sql_SaveSeq( szRow, SREACH_FILE);
	
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��'  ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (SEND_YN == 'N' OR SEND_YN IS NULL) AND ");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (SEND_YN == 'N' OR SEND_YN IS NULL) AND ");
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE TRIM(HOUSE_CNT) ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (SEND_YN == 'S' OR SEND_YN == 'Y') AND ");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE (SEND_YN == 'S' OR SEND_YN == 'Y') AND ");
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE ");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE ");
			}
			
			Str_Cat(m_szSql[0], g_szSqlWhere);
			Str_Cat(m_szSql[1], g_szSqlWhere);
			
			Str_Cat(m_szSql[0], "ORDER BY ROWID LIMIT ? , ?");
			Str_Cat(m_szSql[1], "ORDER BY ROWID LIMIT ? , ?");
		}
		else if( g_nWorkFlag > 739 )
		{
			//����ǥ��ü
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID");
				g_nWorkFlag = 741;
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID");
				g_nWorkFlag = 742;
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				SPRINT(szRow, "SELECT ROWID FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID", m_szCobSel, 0, 0 );
				g_nWorkFlag = 740;
			}
	
			g_Sql_SaveSeq( szRow, SREACH_FILE);
	
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��'  ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID LIMIT ? , ?");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID LIMIT ? , ?");
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE TRIM(HOUSE_CNT) ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID LIMIT ? , ?");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID LIMIT ? , ?");
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Str_Cpy( m_szSql[0], "SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID LIMIT ? , ?");
				Str_Cpy( m_szSql[1], "SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD, MTR_TYPE, MTR_LOC_FLAG, IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END, MEMO, NOBILL_YN FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID LIMIT ? , ?");
			}
		}
		
		//PRINT("m_szSql[0] : %d ,, m_szSql[0] : %s",Str_Len(m_szSql[0]),m_szSql[0],0);
		//PRINT("m_szSql[1] : %d ,,, m_szSql[1] : %d",Str_Len(m_szSql[1]),Str_Len(m_szSql[1]),0);
		
		Cmb_Result();
		return;
	}
	
	//-----------------------------------------------------------------------------------------------
	//�޺��ڽ��� �̿��� ��ü,����,������ ��� ����, ��� ��� Ȯ�κκ�
	//-----------------------------------------------------------------------------------------------
	void Cmb_Result(void)
	{
		char sztmp[20];
		char szSql[700];
		
		//PRINT("g_nWorkFlag : %d ,,  m_szCobSel : %s",g_nWorkFlag,m_szCobSel,0);
		
		if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
		{
			//���ı�ü => ���ı�ü�� �۾��ؾ� �Ѵ�.
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				//��ü ī��Ʈ ǥ��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				memset(szSql, 0x00, sizeof(szSql));
				strcpy(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat(szSql, szTypeWhere);

				PRINT("total : szSql => %s", szSql,0,0);

				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				//��ü ī��Ʈ ǥ��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				memset(szSql, 0x00, sizeof(szSql));
				strcpy(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat(szSql, szTypeWhere);

				PRINT("replaced : szSql => %s", szSql,0,0);

				// g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				//�̱�ü ī��Ʈ ǥ��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				memset(szSql, 0x00, sizeof(szSql));
				strcpy(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat(szSql, szTypeWhere);

				PRINT("not replaced : szSql => %s", szSql,0,0);

				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				memset(szSql, 0x00, sizeof(szSql));
				strcpy(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat(szSql, szTypeWhere);

				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				memset(szSql, 0x00, sizeof(szSql));
				strcpy(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat(szSql, szTypeWhere);

				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				memset(szSql, 0x00, sizeof(szSql));
				strcpy(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat(szSql, szTypeWhere);

				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				memset(szSql, 0x00, sizeof(szSql));
				strcpy(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat(szSql, szTypeWhere);

				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				memset(szSql, 0x00, sizeof(szSql));
				strcpy(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat(szSql, szTypeWhere);

				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				memset(szSql, 0x00, sizeof(szSql));
				strcpy(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'");
				strcat(szSql, szTypeWhere);

				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
		}
		else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
		{
			//�ο���ü
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
		}
		else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
		{
			//��ü�Ұ�
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND NOBILL_YN ='N'", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
		}
		else if( g_nWorkFlag > 729 && g_nWorkFlag < 740 )
		{
			//���ñ�ü
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN == 'N' OR SEND_YN IS NULL) AND %s", g_szSqlWhere, 0, 0 );
				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN == 'N' OR SEND_YN IS NULL) AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND %s", g_szSqlWhere, 0, 0 );
				g_Sql_RetStr( szSql, 4, sztmp );
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN == 'N' OR SEND_YN IS NULL) AND %s", g_szSqlWhere, 0, 0 );
				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN == 'S' OR SEND_YN == 'Y') AND %s", g_szSqlWhere, 0, 0 );
				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN == 'S' OR SEND_YN == 'Y') AND %s", g_szSqlWhere, 0, 0 );
				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN == 'S' OR SEND_YN == 'Y') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND %s", g_szSqlWhere, 0, 0 );
				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE %s", g_szSqlWhere, 0, 0 );
				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN == 'S' OR SEND_YN == 'Y') AND %s", g_szSqlWhere, 0, 0 );
				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE (SEND_YN == 'N' OR SEND_YN IS NULL) AND %s", g_szSqlWhere, 0, 0 );
				g_Sql_RetStr( szSql, 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
		}
		else if( g_nWorkFlag > 739)
		{
			//����ǥ��ü
			if( MATCH(m_szCobSel, "�̽ǽ�") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30')", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30')", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30')", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30')", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30')", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30')", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
			else //if( MATCH(m_szCobSel, "��ü") )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30')", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'S' OR SEND_YN == 'Y') AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30')", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), sztmp); 
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Sql_RetStr( "SELECT COUNT(*) FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (SEND_YN == 'N' OR SEND_YN IS NULL) AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30')", 4, sztmp );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), sztmp); 
			}
		}
		
		return;
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
		long lRow;
		char szSql[301];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		
		if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '8' ", g_nActIndex, 0, 0);
			g_Sql_DirectExecute(szSql);
		}
		else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '8' ", g_nActIndex, 0, 0);
			g_Sql_DirectExecute(szSql);
		}
		else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM10 =%d WHERE GUBUN = '8' ", g_nActIndex, 0, 0);
			g_Sql_DirectExecute(szSql);
		}		
		else if ( g_nWorkFlag > 739 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM11 =%d WHERE GUBUN = '8' ", g_nActIndex, 0, 0);
			g_Sql_DirectExecute(szSql);
		}
		else if( g_nWorkFlag > 729 && g_nWorkFlag < 739 )
		{
			g_lMoveFlag = 1;
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
		char szSql[201];
		char szbuf[10];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		
		if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
		{
			SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '8' ", 0, 0, 0);
		}
		else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
		{
			SPRINT(szSql, "SELECT PARAM9 FROM RCV_LOG  WHERE GUBUN = '8' ", 0, 0, 0);
		}
		else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
		{
			SPRINT(szSql, "SELECT PARAM10 FROM RCV_LOG  WHERE GUBUN = '8' ", 0, 0, 0);
		}
		else if( g_nWorkFlag > 739 )
		{
			SPRINT(szSql, "SELECT PARAM11 FROM RCV_LOG  WHERE GUBUN = '8' ", 0, 0, 0);
		}

		g_Sql_RetStr(szSql, 4, szbuf);

		g_nActIndex = Str_AtoI(szbuf);		
		m_lpage = g_nActIndex / ROW;
		m_nActIndex = (g_nActIndex % ROW);
		
		return;
	}
	
//-----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
//PRINT("nEvent : %d ,,,, UART_BARCODE : %d",nEvent,UART_BARCODE,0);
		if (nEvent == UART_BARCODE)
		{
			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				PDA_OnBarcodeRead();
			}
			else
			{
				OnBarcodeRead();
			}
		}
	}

//-----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char* ptr;
		long nRet = 0;
		
		if(nEvent == TASK_SYS_CALL && nData == TASK_BARCODE )
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
	}

//-----------------------------------------------------------------------------------------------
	void Barcode(void)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;

		//2017-08-22 Sanghyun Lee
		//ī�޶� ���ڵ�(����Ʈ�� ����) & �� ���ڵ� ���� ��� �߰�(������ ����޴����� ����)
		if( MATCH(g_szBarcodeSet, PHOTO_BARCODE) && theDevInfo.m_nType > FAMILY_PDA )
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

//=======================================================================================
	void OnBarcodeRead(void)
	{
	char szSql[300];
	char szBar[10];
	long lCnt, lRow;
	long RetFlag = -1;
	long ret = 0;

		if( MATCH(g_szBarcodeSet, BEAM_BARCODE) )
		{
			Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
			ret = Barcode_Read( m_szBarcode_Value );	
		}

		//PRINT("m_szBarcode_Value : %s",m_szBarcode_Value,0,0);
		if( ret < 0)
		{
			MessageBoxEx (ERROR_OK, "���ڵ� �б� ����");
			goto Finally;
		}

		if( Str_Len(m_szBarcode_Value) > 8 )
		{
			Search_BarcodeData(m_szBarcode_Value);
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� ���̰� ���� �ʽ��ϴ�.");
			goto Finally;
		}

Finally:
		
		if( theDevInfo.m_nType > FAMILY_PDA && MATCH(g_szBarcodeSet, BEAM_BARCODE) )
		{
			Barcode_Exit();
		}

		ON_DRAW();
		return;
	}


	//=======================================================================================
	void PDA_OnBarcodeRead(void)
	{
	char szSql[300];
	char szBar[10];
	long lCnt, lRow;
	long RetFlag = -1;
	long ret = 0;

		Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
		ret = Barcode_Read( m_szBarcode_Value );	
		if( ret < 0)
		{
			MessageBoxEx (ERROR_OK, "���ڵ� �б� ����");
			goto Finally;
		}
//PRINT("PDA>>>>>>>>>>>>>>>>>Str_Len(m_szBarcode_Value) : %d ",Str_Len(m_szBarcode_Value),0,0);
		if( Str_Len(m_szBarcode_Value) > 8 )
		{
			Search_BarcodeData(m_szBarcode_Value);
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� ���̰� ���� �ʽ��ϴ�.");
			goto Finally;
		}

Finally:
		
		ON_DRAW();
		return;
	}
	
	//=======================================================================================
	void Search_BarcodeData(char* szBarnum)
	{
		long i;
		long lRet = -1;
		char szRowid[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
		{
			//���ı�ü
			hstmt = sql->CreateStatement(sql,"SELECT ROWID, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND MTR_ID_NUM = ?");
		}
		else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
		{
			//�ο���ü
			hstmt = sql->CreateStatement(sql,"SELECT ROWID, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND MTR_ID_NUM = ?");
		}
		else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
		{
			//��ü�Ұ�
			hstmt = sql->CreateStatement(sql,"SELECT ROWID, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') AND MTR_ID_NUM = ?");
		}
		else if( g_nWorkFlag > 739 )
		{
			//����ǥ��ü
			hstmt = sql->CreateStatement(sql,"SELECT ROWID, SEND_YN, MTR_GRD, PDA_REPL_JOB_ITEM, MTR_NUM, OBJ_CRT_YMD FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') AND MTR_ID_NUM = ?");
		}
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)szBarnum , 20, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			Mem_Set( (byte*)szRowid, 0x00, sizeof(szRowid) );
			Mem_Set( (byte*)m_szSendYn, 0x00, sizeof(m_szSendYn) );
			Mem_Set( (byte*)m_szMtrGrd, 0x00, sizeof(m_szMtrGrd) );
			Mem_Set( (byte*)m_szPdaRepl, 0x00, sizeof(m_szPdaRepl) );
			Mem_Set( (byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM) );
			Mem_Set( (byte*)g_szOBJ_CRT_YMD, 0x00, sizeof(g_szOBJ_CRT_YMD) );

			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) szRowid						, 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szSendYn					, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szMtrGrd					, 7  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szPdaRepl					, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) g_szMTR_NUM					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) g_szOBJ_CRT_YMD				, 8  + 1, DECRYPT );
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ�� ��ġ�ϴ� ����� �����ϴ�.");
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}
		
		lRet = 1;

Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		if( lRet > 0 )
		{
			if( MATCH(m_szSendYn, "Y") )
			{
				MessageBoxEx (CONFIRM_OK, "�̹� �۽��� �ڷ� �Դϴ�.");
				return;
			}
	
			g_nActIndex = g_Get_FsIndex(Str_AtoI(szRowid), SREACH_FILE);
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			g_lDataflag = 0;
			g_lMoveFlag = 0;
			Set_Index();
	
			//g_nBojungFlag;    //�跮�� ������� ���� Flag , Flag = 0 ���������, Flag = 1 ����������, Flag = 2 ���Ϻ�����
			if( MATCH(m_szPdaRepl, "10") || MATCH(m_szPdaRepl, "30") )
			{
				if( Str_AtoI(m_szMtrGrd) >= 10 )
				{
					if( MATCH(m_szPdaRepl, "10") )
					{
						g_nBojungFlag = 0;
					}
					else
					{
						g_nBojungFlag = 1;
					}
					Card_Move("C6301_BIGCHG");
				}
				else if( Str_AtoI(m_szMtrGrd) < 10 )
				{
					if( MATCH(m_szPdaRepl, "10") )
					{
						g_nBojungFlag = 0;
					}
					else
					{
						g_nBojungFlag = 1;
					}
	
					Card_Move("C6301_MTRCHG");
				}
			}
			else if( MATCH(m_szPdaRepl, "20") )
			{
				g_nBojungFlag = 2;
				Card_Move("C6301_BOJUNGCHG");
			}
		}
		
		return;
	}
	
	//=======================================================================================
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
		
		char col_name[5][32] = {"��ü���", "����", "���", "", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","1","1","0","0"};
		char col_align[5][10]  = {"left", "center", "center","", ""};
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			m_hData = JSON_Create( JSON_Object );
			if(m_hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(m_hData	, 'C', "list_type"	, "GridListView");
			//�� ȣ��������, ���� ��ġ�� ����ϰ� �������� �� ȣ��� ����
			//true�� �� �־�� �Ѵ�.
			//���� ������ �ٸ� �並 ȣ���� ���, ������ �ǹǷ� �ݵ�� �Ź� ȣ���
			//���� �Ǵ��Ͽ� ��� �ؾ� �Ѵ�.
			JSON_SetValue	(m_hData	, 'C', "list_position_save"	, "true");		//true/false
			
			start_position = m_lpage*ROW + m_nActIndex;
			JSON_SetValue	(m_hData	, 'X', "start_position"		, &start_position);

			col_count = 3;
			JSON_SetValue	(m_hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(m_hData	, 'X', "col_height"			, &col_height);
			
			JSON_SetValue	(m_hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(m_hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			//���� ����
			Grid_SetQuery();

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
			
			JSON_Attach 	(m_hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, m_szTitle);
			JSON_SetValue	(h		, 'C', "method"			, "ListViewActivity");
			JSON_Attach 	(h		, "data"				, m_hData);

			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (m_hData)
		{
			JSON_Finalize(m_hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	
	}

	//=======================================================================================
	void Grid_SetQuery(void)
	{
		char szSql[2500];
	
		if( g_nWorkFlag > 699 && g_nWorkFlag < 710 )
		{
			//���� ��ü
			if( g_nAddrFlag == 0 )
			{
				JSON_SetValue	(m_hData	, 'C', "query",
	"SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| \
	IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 \
	THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END \
	||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' \
	THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' \
	ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID"
								);
			}
			else
			{
				JSON_SetValue	(m_hData	, 'C', "query",
	"SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| \
	CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN \
	IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| \
	CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN \
	PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN \
	COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, '') \
	, CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '10' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID"
								);
			}
		}
		else if( g_nWorkFlag > 709 && g_nWorkFlag < 720 )
		{
			//�ο� ��ü
			if( g_nAddrFlag == 0 )
			{
				JSON_SetValue	(m_hData	, 'C', "query",
	"SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| \
	IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 \
	THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END \
	||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' \
	THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' \
	ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID"
								);
			}
			else
			{
				JSON_SetValue	(m_hData	, 'C', "query",
	"SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| \
	CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN \
	IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| \
	CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN \
	PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN \
	COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, '') \
	, CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE REPL_OCCU_FLAG = '20' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID"
								);
			}
		}
		else if( g_nWorkFlag > 719 && g_nWorkFlag < 730 )
		{
			//��ü�Ұ�
			if( g_nAddrFlag == 0 )
			{
				JSON_SetValue	(m_hData	, 'C', "query",
	"SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| \
	IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 \
	THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END \
	||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' \
	THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' \
	ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') ORDER BY ROWID"
								);
			}
			else
			{
				JSON_SetValue	(m_hData	, 'C', "query",
	"SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| \
	CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN \
	IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| \
	CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN \
	PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN \
	COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, '') \
	, CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE (LENGTH(REPL_NOT_PERMIT_WHY) > 0 OR REPL_STS = '30') ORDER BY ROWID"
								);
			}
		}
		else if( g_nWorkFlag > 729 && g_nWorkFlag < 740 )
		{
			//���ñ�ü
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			if( g_nAddrFlag == 0 )
			{
				Str_Cpy(szSql, 
	"SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| \
	IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 \
	THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END \
	||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' \
	THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' \
	ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE " );
	
				Str_Cat(szSql, g_szSqlWhere);
				Str_Cat(szSql,  "ORDER BY ROWID");
				JSON_SetValue	(m_hData	, 'C', "query", szSql);
			}
			else
			{
				Str_Cpy(szSql, 
	"SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| \
	CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN \
	IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| \
	CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN \
	PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN \
	COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, '') \
	, CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE " );
	
				Str_Cat(szSql, g_szSqlWhere);
				Str_Cat(szSql,  "ORDER BY ROWID");
				JSON_SetValue	(m_hData	, 'C', "query", szSql);
			}
		}
		else if( g_nWorkFlag > 739 )
		{
			//����ǥ ��ü
			if( g_nAddrFlag == 0 )
			{
				JSON_SetValue	(m_hData	, 'C', "query",
	"SELECT IFNULL(TRIM(TOWN), '') ||' '|| IFNULL(TRIM(VILLAGE), '') ||' '|| IFNULL(ADDR1_M, '') ||'-'|| \
	IFNULL(ADDR1_S, '') ||' '|| CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 \
	THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END \
	||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' \
	THEN '����' WHEN PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN COMPENS_FLAG = '30' THEN '(��)' \
	ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, ''), CASE WHEN REPL_STS = '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID"
								);
			}
			else
			{
				JSON_SetValue	(m_hData	, 'C', "query",
	"SELECT IFNULL(TRIM(NEW_ROAD_NM), '') ||' '|| IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| \
	CASE WHEN LENGTH(IFNULL(TRIM(CO_LIVE_NM), '') ||''|| IFNULL(TRIM(BLD_NM), '')) > 0 THEN \
	IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(TRIM(BLD_NM), '') ||' '|| IFNULL(TRIM(HOUSE_CNT), '') ELSE \
	IFNULL(TRIM(HOUSE_CNT), '') ||' '|| IFNULL(TRIM(LOT_NUM_SECOND_ADDR), '') END ||'('|| IFNULL(MTR_ID_NUM, '') ||')'|| \
	CASE WHEN PDA_REPL_JOB_ITEM = '10' THEN '�跮' WHEN PDA_REPL_JOB_ITEM = '20' THEN '����' WHEN \
	PDA_REPL_JOB_ITEM = '30' THEN '��+��' ELSE '' END ||'-'|| IFNULL(MTR_GRD, '') ||' '|| \
	CASE WHEN COMPENS_FLAG = '10' THEN '(��)' WHEN COMPENS_FLAG = '20' THEN '(�߰�)' WHEN \
	COMPENS_FLAG = '30' THEN '(��)' ELSE '' END ||' '|| IFNULL(COMPENS_MAKER_NM, '') \
	, CASE WHEN REPL_STS == '30' THEN '��' ELSE '' END \
	, CASE WHEN SEND_YN == 'N' THEN '��' WHEN SEND_YN = 'S' THEN '��ü' WHEN SEND_YN = 'Y' THEN '�Ϸ�' ELSE '' END \
	FROM C6301_CHANGEDATA WHERE NOBILL_YN ='Y' AND (LENGTH(REPL_NOT_PERMIT_WHY) == 0 OR REPL_STS != '30') ORDER BY ROWID"
								);
			}
		}
		
		return;
	}
}
