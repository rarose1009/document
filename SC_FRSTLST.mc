/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_FRSTLST
{
	#include <include.h>
	#include "globalcard.h"
	#include "Calendar.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#define USE_ON_UART

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
//�������� ����Ʈ
		DEF_BUTTON_ID ( BID_BARCODE )	//���ڵ�
		DEF_BUTTON_ID ( BID_LIST_SEARCH )		//�� ��
		DEF_BUTTON_ID ( BID_ADDR )		//
		DEF_BUTTON_ID ( BID_NADDR )		//
		DEF_BUTTON_ID ( BID_SMS )		//SMS �߼�
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTPG )
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//�����ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_QUICK_NADDR )	//���θ��ּ� ��ũ�� ȣ��

		DEF_BUTTON_ID ( BID_SCHDL )
		DEF_BUTTON_ID ( BID_CANCEL )
		DEF_BUTTON_ID ( BID_SEND )

	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//�������� ����Ʈ
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE )		//������
		DEF_OBJECT_ID ( TXT_ADDR1 )
		DEF_OBJECT_ID ( TXT_ADDR2 )
		DEF_OBJECT_ID ( TXT_ADDR3 )

//SMS �۽�
		DEF_OBJECT_ID ( TXT_DATA1 )		
		DEF_OBJECT_ID ( TXT_DATA2 )		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA3 )		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA4 )		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA5 )		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA6 )		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA7 )		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA8 )		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA9 )		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA10)		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA11)		//SMS �۽�		
		DEF_OBJECT_ID ( TXT_DATA12)
		DEF_OBJECT_ID ( TXT_DATA13)
		DEF_OBJECT_ID ( TXT_DATA14)
		DEF_OBJECT_ID ( TXT_DATA15)
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
//�������� ����Ʈ
		DEF_OBJECT_ID ( ID_TBLLIST )	// ���̺� ����Ʈ
		
//SMS �۽�
		DEF_OBJECT_ID ( CMB_TIME1 )
		DEF_OBJECT_ID ( CMB_TIME2 = CMB_TIME1+3 )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    6					// table�� �ళ��
	#define		COL 	    12					// table�� ������
	#define		GRID_H		(CHT+36)			// table �� ����
	#define		GRID_H_P	(CHT+49)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+305  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+220  	    //table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�ܵ���������", CWD*0, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ּ�",	     CWD*16+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����",         CWD*6,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���",         CWD*7,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ȭ��ȣ",     CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ּ�",	     CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ּ�",     CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���˽����ȣ", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"SMS�߼ۿ���",  CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ּ�2",    CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�ּ�����Ȯ��", CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"CONT_STS_CD",  CWD*0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};		
	
	#define INIT_MAIN	1
	#define INIT_SMS	2
	
	long m_lBtnId = -1;
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_lActIndex = -1;		//��Ƽ��� index
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szSql[2][1200];
	char m_szQuickSql[3000];
	char m_szCobSel[20];		//
	char m_bFirst;				//INIT_MAIN �� INIT_SRCH �� ���� ���� ���� flag
	char m_szSingle_Flag[10];
	char m_szChk_Exec_Num[13];
	char m_szBarcode_Value[20];	//���ڵ� ��ĵ ���
	
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void SetComboIdx(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
	void REDRAW(void);
	void SMSSEND_DRAW(void);
	bool Save_SmsSend(void);
	void Snd_Sms(void);
	long TR312316(void);
	
	void SetBtnImg(void);
	void Barcode(void);
	void OnBarcodeRead(void);
	long SearchCD(char *CD, CodeTable *CT);		//�ڵ� ���� ã�´�.
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	void OnList(quad lParam);
	void QuickList(long nBtnID);
	void Grid_QuickList(long nBtnID);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�켱���� ����Ʈ"),

		DLG_BUTTON(STARTX,     STARTY+65, 350, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "���ڵ�"),
		DLG_BUTTON(STARTX+500, STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),
		DLG_BUTTON(STARTX+750, STARTY+65, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_NADDR, "���θ�\n��ũ��"),
		
		DLG_BUTTON(STARTX+500, STARTY+836, 250, 63, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+750, STARTY+836, 250, 63, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		
		//DLG_BUTTON(STARTX,     STARTY+275, 300, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_LIST_SEARCH, "���� ����"),
		DLG_BUTTON(STARTX,     STARTY+245, 333, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+333, STARTY+245, 333, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+666, STARTY+245, 334, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS�߼�"),
		
//		DLG_TEXT(STARTX, STARTY+70, 400, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),
		DLG_TEXT(STARTX, STARTY+125, 1000, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
		//DLG_TEXT(STARTX, STARTY+170, 975, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),
		DLG_TEXT(STARTX, STARTY+836, 350, 63, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),

		// ����Ʈ		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�켱���� ����Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY-40, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "���ڵ�"),
		
		DLG_BUTTON(STARTX,     STARTY+150, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+333, STARTY+150, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+666, STARTY+150, 334, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "SMS�߼�"),
				
		//DLG_TEXT(STARTX, 70, 400, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR1, ""),
		DLG_TEXT(STARTX,	    STARTY+30, 1000, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR2, ""),
		//DLG_TEXT(STARTX, STARTY+90, 975, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR3, ""),
		
		DLG_TEXT(STARTX,		STARTY+829, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500,	STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+750,	STARTY+829, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		
		// ����Ʈ		
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-20, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};
		
	//  SMS�߼�
	//---------------------------------------------------------------
	DlgObject	DlgRes_SMSSEND[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "SMS ���ڹ߼�"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,		 STARTY+390, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "�ݱ�"),
		DLG_BUTTON(STARTX+600,   STARTY+390, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "����"),
		
		DLG_TEXT ( STARTX,	   STARTY-29, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�湮����"),
		DLG_EDIT( STARTX+250,  STARTY-29, 200, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+450,   STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+450,   STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, "."),
		DLG_EDIT( STARTX+470,  STARTY-29, 170, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+640,   STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+640,   STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, "."),
		DLG_EDIT( STARTX+660,  STARTY-29, 165, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+825, STARTY-29, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "��"),
		//DLG_TEXT ( STARTX+250,	    STARTY, 575, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		//DLG_BUTTON(STARTX+825,      STARTY, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "��"),

		DLG_TEXT ( STARTX,	     STARTY+41, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "�湮�ð�"),
		DLG_COMBO (STARTX+250,   STARTY+41, 250, 200, 120, 70, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_TIME1, 10),
		DLG_TEXT ( STARTX+500,	 STARTY+41, 125, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "�� ~"),
		DLG_COMBO (STARTX+625,   STARTY+41, 250, 200, 120, 70, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_TIME2, 10),
		DLG_TEXT ( STARTX+875,	 STARTY+41, 125, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "��"),
			
		DLG_TEXT ( STARTX,	    STARTY+111, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�Ҽ�"),
		DLG_TEXT ( STARTX+250,	STARTY+111, 750, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,	    STARTY+181, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "���˿�"),
		DLG_TEXT ( STARTX+250,	STARTY+181, 750, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	    STARTY+251, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "��H.P"),
		DLG_TEXT ( STARTX+250,	STARTY+251, 750, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
	};
	
	//  SMS�߼�
	//---------------------------------------------------------------
	DlgObject	DlgRes_SMSSEND_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "SMS ���ڹ߼�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,		STARTY+400, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "�ݱ�"),
		DLG_BUTTON(STARTX+600,	STARTY+400, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "����"),
		
		DLG_TEXT ( STARTX,	      STARTY-40, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�湮����"),
		DLG_EDIT( STARTX+250,     STARTY-40, 200, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+450,      STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+450,	     STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, "."),
		DLG_EDIT( STARTX+470,     STARTY-40, 170, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+640,      STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+640,	     STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, "."),
		DLG_EDIT( STARTX+660,     STARTY-40, 165, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+825,    STARTY-40, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "��"),
		//DLG_TEXT ( STARTX+250,	    STARTY, 575, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		//DLG_BUTTON(STARTX+825,      STARTY, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "��"),

		DLG_TEXT ( STARTX,	     STARTY+40, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "�湮�ð�"),
		DLG_COMBO (STARTX+250,   STARTY+40, 250, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_TIME1, 10),
		DLG_TEXT ( STARTX+500,	 STARTY+40, 125, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "�� ~"),
		DLG_COMBO (STARTX+625,   STARTY+40, 250, 200, 120, 80, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_TIME2, 10),
		DLG_TEXT ( STARTX+875,	 STARTY+40, 125, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "��"),
			
		DLG_TEXT ( STARTX,	    STARTY+120, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "�Ҽ�"),
		DLG_TEXT ( STARTX+250,	STARTY+120, 750, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT ( STARTX,	    STARTY+200, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "���˿�"),
		DLG_TEXT ( STARTX+250,	STARTY+200, 750, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT ( STARTX,	    STARTY+280, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "��H.P"),
		DLG_TEXT ( STARTX+250,	STARTY+280, 750, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
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
		long i;
		char szTmp[200];
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM NORMAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY HOUSE_NUM_ORD, DONG_ORD", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			g_lMoveFlag = 1;
			Set_Index();			
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SPRINT(szTmp, "SELECT (SELECT B.SEND_YN FROM NORMAL_ADDR B WHERE B.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A WHERE ROWID = '%d'", g_lindex, 0, 0);
			g_Sql_RetStr(szTmp, 5, stScAddr.SEND_YN);
			
			Card_Move("SC_CONFIRM");
		}
		
		return;
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

				Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				SetBtnImg();
				SetStyle();

				REDRAW();
				break;
			case INIT_SMS:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_SMSSEND_P, SIZEOF(DlgRes_SMSSEND_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_SMSSEND, SIZEOF(DlgRes_SMSSEND));
						break;
				}
				
				SetBtnImg();
				SMSSEND_DRAW();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		}
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
		}
		
		
		if( theDevInfo.m_nType != FAMILY_PDA && m_bFirst == INIT_MAIN )
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

	//-------------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];
		char szDate[10];
		
		if( m_bFirst == INIT_SMS )
		{
			//���ڸ� �Է� ����
			if( (Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex 
			|| Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex
			|| Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			&& (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				ON_KEY( 5 );
				return;
			}
	
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
			
	
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "��ȿ�� ��¥�� �ƴմϴ�.\n��¥�� Ȯ�����ּ���.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
				else
				{
					Mem_Set((byte *)szDate, 0x00, sizeof(szDate));
					Str_ItoA(Time_GetDate(), szDate, 10);
					if( Str_AtoI(szDate) > Str_AtoI(szTmp) )
					{
						MessageBoxEx (CONFIRM_OK, "��¥�� Ȯ���ϼ���..");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
						
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
						m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					}
				}
			}
			
			ON_DRAW();
			return;
		}
	}


	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		
		//EDITCTRL�� ACTIVE�ÿ� CTRLINDEX�� ����
		//Ű���� BUTTONCTRL�� ACTIVE�ÿ��� EDITCTRL�� Ŀ���� �α����ؼ� INDEX�� ����
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		m_lActiveIndex = lActiveIndex;
		
		if( m_bFirst == INIT_SMS )
		{
			if( POINTING_UP == nAction )
			{
				m_lActiveIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+250) && X < DMS_X(STARTX+450) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+470) && X < DMS_X(STARTX+640) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+660) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
	
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
					
					ON_DRAW();
				}
			}
		}
	}


//��������������������������������������������������������������������������������������������
	void	OnSelect(long Index)
	{
		long index = -1;
		char szStscd[5];
		char szcmb[20];
		char szAddr[200];
		
		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// ���� �ε����� ���� �ε����� ���� �� ���
				if ( index-1 == m_lActIndex )
				{
					//���õ� ������ ��ġ INDEX�� �۷ι������� ����
					g_nActIndex = m_lpage*ROW + index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					Str_Cpy( g_szCHK_EXEC_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 7));
					
					g_lMoveFlag = 1;
					Set_Index();

					Card_Move("SC_CONFIRM");
					return;
				}
				else
				{
					m_lActIndex = index - 1;//���õ� INDEX ����
				
					//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
					Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
					Str_Cpy(szAddr, DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					Str_Cat(szAddr, "  ");
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, index-1, 0), "10") == 0 )
					{
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 9));
						Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, index-1, 9));
					}
					else if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, index-1, 0), "20") == 0 )
					{
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 6));
						Str_Cat(szAddr, DlgTbl_GetStr( ID_TBLLIST, index-1, 6));
					}
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), szAddr);
					
					Mem_Set((byte*)szStscd, 0x00, sizeof(szStscd));
					Str_Cpy(szStscd, DlgTbl_GetStr( ID_TBLLIST, index-1, 11) );
					
					Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
					Str_Cpy(szcmb, DlgTbl_GetStr( ID_TBLLIST, index-1, 8) );
					
					if( szcmb[0] == 'Y' )
					{
						if( Str_Cmp(szStscd, "30") == 0 )
						{
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), RED);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
						}
						else
						{
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						}
					}
					else
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
					}
										
					ON_DRAW();
					//g_nActIndex = m_lpage*ROW + index - 1;
					
					Mem_Set((byte*)m_szChk_Exec_Num, 0x00, sizeof(m_szChk_Exec_Num));
					Str_Cpy( m_szChk_Exec_Num, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 7));
					Str_Cpy( stScAddr.SEND_YN, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 10));
				}
			}
		}
	}
	
//---------------------------------------------------------------------------------------
	void	OnButton(long ID)
	{
		long d, k;
		char szToday[11];
		char szDate[11];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char sztmp[20];	
	
		switch(ID)
		{
			case BID_QUICK_ADDR:
			case BID_QUICK_NADDR:
				//QuickList(ID);
				Grid_QuickList(ID);
				break;
			case BID_BARCODE:
				Barcode();
				break;
			case BID_ADDR:
				g_nAddrFlag = 0;

				REDRAW();
				break;
			case BID_NADDR:
				g_nAddrFlag = 1;
				
				REDRAW();
				break;
			case BID_SMS:
				ON_EXIT();
				OnInit(INIT_SMS);
				break;
			case BID_SCHDL:
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));		
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>sztmp : %s",sztmp,0,0);
				k = Str_AtoI(sztmp);
			
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Str_ItoA ( d, szDate, 10);
					Str_ItoA ( Time_GetDate(), szToday, 10);
					if( Str_AtoI(szToday) <= Str_AtoI(szDate) )
					{
						Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
						Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
						Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
						Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
						Mem_Cpy((byte *)szMonth, (byte *)szDate+4, 2);
						Mem_Cpy((byte *)szDay, (byte *)szDate+6, 2);
						
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );

						//g_Str_DateType(szToday, szDate);
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), szToday );
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "��¥�� Ȯ���ϼ���..");
					}
					
				}
				break;
			case BID_SEND:
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));

				if( Str_Len(sztmp) < 8 )
				{
					MessageBoxEx (CONFIRM_OK, "�湮���ڸ� �������ּ���.");
				}
				else
				{
					if( Save_SmsSend() )
					{
						ON_EXIT();
						OnInit(INIT_MAIN);
					}
					//Snd_Sms();
				}
				break;
				
			case BID_CANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;	

			case BID_PREVPG:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
					DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
					break;
				}
				m_lActIndex = 0;
				REDRAW();
				break;
			case BID_NEXTPG:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					
					DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
					DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
					break;
				}
				m_lActIndex = 0;

				REDRAW();
				break;
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "�������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("SC_MENU");
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
				if( INIT_SMS == m_bFirst)
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
					
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				else
				{
					g_lMoveFlag = 0;
					Card_Move("SC_MENU");
				}
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;

				g_Exit();
				break;
		}
	}

//-----------------------------------------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR2), EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR3), EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR2), TRUE, 2, EDITSEP_NONE );
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
			{
				return i;
			}
		}
		return -1;
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
		char szSql[201];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '2' ", g_lindex, 0, 0);
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
		char szSql[201];
		char szbuf[10];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));
		SPRINT(szSql, "SELECT PARAM8 FROM RCV_LOG  WHERE GUBUN = '2' ", 0, 0, 0);		
		g_Sql_RetStr(szSql, 4, szbuf);

		g_nActIndex = Str_AtoI(szbuf);		
		m_lpage = g_nActIndex / ROW;
		m_lActIndex = (g_nActIndex % ROW);
	}


//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx, n;
		long k = ROW+1;	//i�� ��ġ�� �ʴ� ���ڷ� �ʱ�ȭ
		long lTotpage;
		char sztmp[201];
		char szPreuse[15];
		char szChkNum[15];
		char szCnt[15];
		char szStscd[5];
		char szOldBoilYn[1];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		g_Sql_SaveSeq( "SELECT ROWID FROM NORMAL_DATA WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY HOUSE_NUM_ORD, DONG_ORD", SREACH_FILE);

		lTotpage = FS_GetSrchTotCnt();
		m_lTotpage = lTotpage;
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		//ȭ�� �̵� �� �ε���
		if( g_lMoveFlag == 1)
		{
			//���α׷� ���� �� �ҷ����� �ε���
			//Get_Index();
			m_lpage = g_nActIndex / ROW;
			m_lActIndex = (g_nActIndex % ROW);
			
			g_lMoveFlag = 0;
		}
		
		SPRINT(m_szCnt_page, "%d/%d, %d", m_lpage+1, m_lTotpage, lTotpage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
			
			hstmt = sql->CreateStatement(sql, "SELECT A.SINGLE_COLIVE_FLAG \
			                                        , ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
			                                        , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                                        , A.CHK_RSLT \
			                                        , Length(A.OWNHOUSE_TEL_EXN) \
			                                        , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
			                                        , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') \
			                                        , ifnull(A.COUNTY,'') ||' '|| ifnull(A.TOWN,'') ||' '|| ifnull(A.VILLAGE,'') ||' '|| ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') \
			                                        , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                                        , A.CHK_EXEC_NUM \
			                                        , A.PREUSE_CHK_WHY \
			                                        , B.CHK_EXEC_NUM AS ABSENT \
			                                        , B.CNT \
			                                        , A.SMS_SEND_AGREE_YN \
			                                        , A.LOT_NUM_SECOND_ADDR \
			                                        , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
			                                        , A.CONT_STS_CD \
			                                        , A.OLD_BOILER_YN \
			                                     FROM NORMAL_DATA A \
			                                     LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
			                                                  ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
			                                    WHERE LENGTH(PREUSE_CHK_WHY) > 0 \
			                                    ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ?, ?");
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );
			
			hstmt = sql->CreateStatement(sql, "SELECT A.SINGLE_COLIVE_FLAG \
			                                        , ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
			                                        , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                                        , A.CHK_RSLT \
			                                        , Length(A.OWNHOUSE_TEL_EXN) \
			                                        , ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
			                                        , ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') \
			                                        , ifnull(A.COUNTY,'') ||' '|| ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') \
			                                        , ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') \
			                                        , A.CHK_EXEC_NUM \
			                                        , A.PREUSE_CHK_WHY \
			                                        , B.CHK_EXEC_NUM AS ABSENT \
			                                        , B.CNT \
			                                        , A.SMS_SEND_AGREE_YN \
			                                        , A.LOT_NUM_SECOND_ADDR \
			                                        , (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) \
			                                        , A.CONT_STS_CD \
			                                        , A.OLD_BOILER_YN \
			                                     FROM NORMAL_DATA A \
			                                     LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
			                                                  ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
			                                    WHERE LENGTH(PREUSE_CHK_WHY) > 0 \
			                                    ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD LIMIT ? , ?");
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
					continue;
				}
				//SINGLE_COLIVE_FLAG , m_szSingle_Flag
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				//idx = 0;
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				if( Str_Cmp(sztmp, "10") == 0 )
				{
					//�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					idx = 0;
					sql->GetValue(sql, 1, 'U', (long*)sztmp, 50 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					
					//����
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szPreuse, 0x00, sizeof(szPreuse) );
					Mem_Set( (byte*)szChkNum, 0x00, sizeof(szChkNum) );
					Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
					Mem_Set( (byte*)szOldBoilYn, 0x00, sizeof(szOldBoilYn) );
					
					sql->GetValue(sql, 10, 'U', (long*)szPreuse, 2  + 1, DECRYPT);
					sql->GetValue(sql, 11, 'U', (long*)szChkNum, 12 + 1, DECRYPT);
					sql->GetValue(sql, 12, 'U', (long*)szCnt,     5 + 1, DECRYPT);
					sql->GetValue(sql, 17, 'U', (long*)szOldBoilYn,     2 + 1, DECRYPT);
					
					if( Str_Len(szPreuse) > 0 )
					{
						Str_Cpy(sztmp, "F");
					}
					else
					{
						Str_Cpy(sztmp, "");
					}
					
					if( Str_Len(szChkNum) > 0 )
					{
						Str_Cat(sztmp, "B");
						Str_Cat(sztmp, szCnt);
					}
					else
					{
						Str_Cat(sztmp, "");
					}
					
					if( Str_Len(szOldBoilYn) > 0 )
					{
						Str_Cat(sztmp, "\n��");
					}
					else
					{
						Str_Cat(sztmp, "");
					}
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					
					//���
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					//'������' ���� �� ����
					if( Str_Cmp(sztmp, "21") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), RED);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					
					n = SearchCD( sztmp, SCCHK_RSLT );
					if( n == -1 || n == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "�̰�" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, SCCHK_RSLT[n].Str );
					}
					//��ȭ��ȣ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 5 + 1, DECRYPT);
					if( Str_Len(sztmp) > 0 )
					{
						//��ȭ��ȣ
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 5, 'U', (long*)sztmp, 15 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					}
					else
					{
						//��ȭ��ȣ
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 6, 'U', (long*)sztmp, 15 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					}
					//�⺻�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					//���ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					//���˽����ȣ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 12 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					//SMS�߼ۿ���
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 13, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), BLUE);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), TXTFRCOLOR);
					}
					
					if( Str_Cmp(szOldBoilYn, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 2 ), RED);
					}
					
					//���ּ�2
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 14, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					//�ּ�����Ȯ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 15, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
					//CONT_STS_CD, SMS�۽Ź�ư ����
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 16, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 11, sztmp );
				}
				else
				{
					//�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					idx = 0;
					sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
					
					//����
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Set( (byte*)szPreuse, 0x00, sizeof(szPreuse) );
					Mem_Set( (byte*)szChkNum, 0x00, sizeof(szChkNum) );
					Mem_Set( (byte*)szCnt, 0x00, sizeof(szCnt) );
					Mem_Set( (byte*)szOldBoilYn, 0x00, sizeof(szOldBoilYn) );
					
					sql->GetValue(sql, 10, 'U', (long*)szPreuse, 2  + 1, DECRYPT);
					sql->GetValue(sql, 11, 'U', (long*)szChkNum, 12 + 1, DECRYPT);
					sql->GetValue(sql, 12,'U', (long*)szCnt,     5 + 1, DECRYPT);
					sql->GetValue(sql, 17, 'U', (long*)szOldBoilYn,     2 + 1, DECRYPT);
					
					if( Str_Len(szPreuse) > 0 )
					{
						Str_Cpy(sztmp, "F");
					}
					else
					{
						Str_Cpy(sztmp, "");
					}
					
					if( Str_Len(szChkNum) > 0 )
					{
						Str_Cat(sztmp, "B");
						Str_Cat(sztmp, szCnt);
					}
					else
					{
						Str_Cpy(sztmp, "");
					}
					
					if( Str_Len(szOldBoilYn) > 0 )
					{
						Str_Cat(sztmp, "\n��");
					}
					else
					{
						Str_Cat(sztmp, "");
					}
					
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
					
					//���
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 3, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					//'������' ���� �� ����
					if( Str_Cmp(sztmp, "21") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), RED);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					}
					n = SearchCD( sztmp, SCCHK_RSLT );
					if( n == -1 ||n == 0 )
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, "�̰�" );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, i, 3, SCCHK_RSLT[n].Str );
					}
					//��ȭ��ȣ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 4, 'U', (long*)sztmp, 5 + 1, DECRYPT);
					if( Str_Len(sztmp) > 0 )
					{
						//��ȭ��ȣ
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 5, 'U', (long*)sztmp, 15 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					}
					else
					{
						//��ȭ��ȣ
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						sql->GetValue(sql, 6, 'U', (long*)sztmp, 15 + 1, DECRYPT);
						DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					}
					//��ȭ��ȣ
					//Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					//sql->GetValue(sql, 4, 'U', (long*)sztmp, 12 + 1, DECRYPT);
					//DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
					//�⺻�ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 7, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
					//���ּ�
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 8, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
					//���˽����ȣ
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 9, 'U', (long*)sztmp, 12 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );
					
					//SMS�߼ۿ���
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 13, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 8, sztmp );
					if( Str_Cmp(sztmp, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), BLUE);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), BLUE);
					}
					else
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 1 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 4 ), TXTFRCOLOR);
					}
					
					if( Str_Cmp(szOldBoilYn, "Y") == 0 )
					{
						EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 2 ), RED);
					}
					
					//���ּ�2
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 14, 'U', (long*)sztmp, 100 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );
					//�ּ�����Ȯ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 15, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );
					//CONT_STS_CD, SMS�۽Ź�ư ����
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					sql->GetValue(sql, 16, 'U', (long*)sztmp, 2 + 1, DECRYPT);
					DlgTbl_SetStr ( ID_TBLLIST, i, 11, sztmp );
				}
			}
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if(m_lTotpage > 0 )
		{
			if( m_lActIndex < 0 )
			{
				m_lActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
			
			//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5));
			Str_Cat(sztmp, "  ");
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
			if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 0), "10") == 0 )
			{
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 9));
				Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 9));
			}
			else if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 0), "20") == 0 )
			{
				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 6));
				Str_Cat(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 6));
			}
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), sztmp);

			Mem_Set((byte*)szCnt, 0x00, sizeof(szCnt));
			Mem_Set((byte*)szStscd, 0x00, sizeof(szStscd));
			Str_Cpy(szCnt, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 8) );
			Str_Cpy(szStscd, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 11) );
			
			if( szCnt[0] == 'Y' )
			{
				if( Str_Cmp(szStscd, "30") == 0 )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), RED);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
				}
				else
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
				}
			}
			else
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
			}
			
			Str_Cpy( m_szChk_Exec_Num, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 7));
			Str_Cpy( stScAddr.SEND_YN, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 10));

			m_lIdxFlag = 1;
		}
		else
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), TXTFRCOLOR);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
		}
		
		ON_DRAW();
		return;
	}

	
//-----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		if (nEvent == UART_BARCODE)
		{
			OnBarcodeRead();
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

//=======================================================================================
	void OnBarcodeRead(void)
	{
	char szSql[300];
	char szBar[10];
	long lCnt, lRow;
	long RetFlag = -1;
	long ret = 0;

		if( Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
			ret = Barcode_Read( m_szBarcode_Value );	
			if( ret < 0)
			{
				MessageBoxEx (ERROR_OK, "���ڵ� �б� ����");
				goto Finally;
			}
		}

		if( Str_Len(m_szBarcode_Value) > 8 )
		{
			//���ڵ� ����
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			Mem_Cpy((byte *)szBar, (byte *)m_szBarcode_Value, 9);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_DATA WHERE INST_PLACE_NUM = '%s' AND LENGTH(PREUSE_CHK_WHY) > 0 ", szBar, 0, 0);
			g_Sql_RetInt( szSql, &lCnt );

			if( lCnt > 0 )
			{
				Str_Cpy(g_szCurrBar, m_szBarcode_Value);
			
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE INST_PLACE_NUM = '%s' AND LENGTH(PREUSE_CHK_WHY) > 0", szBar, 0, 0);
				g_Sql_RetInt( szSql, &lRow );
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
				g_Sql_SaveSeq( szSql, SREACH_FILE);
	
				g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				Set_Index();
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE NORMAL_DATA SET CURR_BAR = '%s' WHERE INST_PLACE_NUM = '%s' ", g_szCurrBar, szBar, 0);
				g_Sql_DirectExecute(szSql);
				
				RetFlag = 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "���ڵ�� ��ġ�ϴ� ����� �����ϴ�.");
				Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				goto Finally;
			}

		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� ���̰� ���� �ʽ��ϴ�.");
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			goto Finally;
		}

Finally:
		
		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}
		
		if( RetFlag > 0 )
		{
			Card_Move("SC_CONFIRM");
		}

		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : SMSSEND_DRAW
	��  �� : 
	Param  : 
	Return :
	========================================================================================*/		
	void SMSSEND_DRAW(void)
	{
	char szPhone[30];
	char szToday[11];
	char szDate[11];
	char szSql[100];
	char szYear[5];
	char szMonth[3];
	char szDay[3];
	char szZero[3];
	char szHour[3];
	char szHour2[3];
	long lHour = 24;
	long lTime;
	long i;
		
		Mem_Set( (byte*)szPhone, 0x00, sizeof(szPhone) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_TIME1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_TIME2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		//�� ����
		for(i=0 ; i<lHour ; i++)
		{
			Mem_Set( (byte*)szHour, 0x00, sizeof(szHour) );
			if( i < 10 )
			{
				Str_ItoA(i, szHour, 10);
				Str_Cpy(szZero, "0");
				Str_Cat(szZero, szHour);
				Str_Cpy(szHour, szZero);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME1+2), szHour, 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME2+2), szHour, 0, ICON_NONE);
			}
			else
			{
				Str_ItoA(i, szHour, 10);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME1+2), szHour, 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_TIME2+2), szHour, 0, ICON_NONE);
			}
		}

		Mem_Set( (byte*)szHour, 0x00, sizeof(szHour) );
		Mem_Set( (byte*)szZero, 0x00, sizeof(szZero) );
		lTime = Time_GetHour();
		if( lTime < 10 )
		{
			Str_ItoA(lTime, szHour, 10);
			Str_Cpy(szZero, "0");
			Str_Cat(szZero, szHour);
			Str_Cpy(szHour, szZero);
		}
		else
		{
			Str_ItoA(lTime, szHour, 10);
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_TIME1), szHour);
		
		Mem_Set( (byte*)szHour, 0x00, sizeof(szHour) );
		Mem_Set( (byte*)szHour2, 0x00, sizeof(szHour2) );
		Mem_Set( (byte*)szZero, 0x00, sizeof(szZero) );
		lTime += 1;
		if( lTime < 10 )
		{
			Str_ItoA(lTime, szHour, 10);
			Str_Cpy(szZero, "0");
			Str_Cat(szZero, szHour);
			Str_Cpy(szHour, szZero);
		}
		else
		{
			Str_ItoA(lTime, szHour, 10);
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_TIME2), szHour);
		
		
		//��¥
		Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
		Str_ItoA ( Time_GetDate(), szToday, 10);
		
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte *)szYear, (byte *)szToday, 4);
		Mem_Cpy((byte *)szMonth, (byte *)szToday+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)szToday+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );

		//g_Str_DateType(szDate, szToday);
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), szDate );

		//�Ҽ�
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stUserinfo.szcenter_nm);
		
		//���˿�
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), stUserinfo.sznm_kor);
		//��H.P
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szPhone, 0x00, sizeof(szPhone) );
		SPRINT(szSql, "SELECT CP_DDD ||'-'|| CP_EXN||'-'||CP_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ", m_szChk_Exec_Num, 0, 0   );
		g_Sql_RetStr( szSql, 20, szPhone );
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), szPhone);
	}
	
	/*=======================================================================================
	�Լ��� : Save_SmsSend
	��  �� : 
	Param  : 
	Return :
	========================================================================================*/		
//���� ����1 : ���ð��� �������� ������ XX�� XX�� (����� �湮����)    �������˿� : ���˿��� (  ����̽� ��ȭ��ȣ  )   �湮 
//���۹��� 2:  ���ﵵ�ð��� + stUserinfo.szcenter_nm + ������ + stUserinfo.sztel
	bool Save_SmsSend(void)
	{
		char szSql[1000];
		char szCustTel[50];
		char szUserTel[50];
		char szUserTel2[50];
		char szMsg[2000];
		char szMsg2[1000];
		char szARG_DATE[15];
		char szTime[4];
		char szTime2[4];
		char szDay[30];
		char szTmp[500];
		long idx;
		bool ret = TRUE;
		long lTime = 100;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/*************************************/
		/* ���۹��� 1                        */
		/*************************************/
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );
		Mem_Set( (byte*)szTime, 0x00, sizeof(szTime) );
		Mem_Set( (byte*)szTime2, 0x00, sizeof(szTime2) );
		Mem_Set( (byte*)szCustTel, 0x00, sizeof(szCustTel) );
		Mem_Set( (byte*)szUserTel, 0x00, sizeof(szUserTel) );
		
		Tapi_GetPhoneNum( (byte*)szUserTel, 0);
		Str_Chg( szUserTel, STRCHG_DEL_NONDIGIT);

		Str_Cpy(szCustTel, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA8)));
		Str_Chg( szCustTel, STRCHG_DEL_NONDIGIT);
		
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		g_Str_DateType( szDay, szTmp);
		
		Str_Cpy( szTime, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_TIME1)));
		Str_Cpy( szTime2, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_TIME2)));

		Str_Cpy(szMsg, "�ȳ��Ͻʴϱ� ���ﵵ�ð����Դϴ�.");
		Str_Cat(szMsg, "\n���ð��� ������������(��������ڴ� ȸ��(������)�� �����ϴ� ���ü��� �������˿� ���� �����Ͽ��� �Ѵ�)�� ���Ͽ�,");
		Str_Cat(szMsg, "\n�Ʒ��� ���� ���������� ���� �湮 �����Դϴ�.");
		
		SPRINT( szSql, "\n���ð��� �������� ������ : %s\n�湮�����ð� : %s�� ~ %s��", szDay, szTime, szTime2 );

		Str_Cat( szMsg, szSql );
		/*************************************/
		/* ���۹��� 2                        */
		/*************************************/
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szUserTel2, 0x00, sizeof(szUserTel2) );

		Str_Cat(szMsg, "\n<<���������� ���� ����� ����� ��Ű�� ù���� �Դϴ�>>");			

		g_FormatPhoneNumber(szUserTel, szUserTel2);	
		
		SPRINT(szTmp, "\n���ﵵ�ð��� %s ������", stUserinfo.szcenter_nm, 0, 0);	
		Str_Cat(szMsg, szTmp);
		// SPRINT(szTmp, "\n�������˿� : %s(%s)\n*�����ð��� ��ȭ�����մϴ�.\n(09��~18��)", stUserinfo.sznm_kor, szUserTel2, 0);
		SPRINT(szTmp, "\n�������˿� : %s(%s)\n*������ȭ�� �����ð�(09��~18��)�� ���ֽø� �����ϰڽ��ϴ�.", stUserinfo.sznm_kor, szUserTel2, 0);
		Str_Cat(szMsg, szTmp);
		SPRINT(szTmp, "\n������� ������ ���� �ݷ������� ������ҿ� �и��� ������ �ӹ����� ��Ź�帳�ϴ�.",0,0,0);
		Str_Cat(szMsg, szTmp);
		
		ret = Tapi_SendSmsEx(szCustTel, szUserTel, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
					return FALSE;
				case -2:
					MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
					return FALSE;
				case -3:
					MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
					return FALSE;
				case -4:
					MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
					return FALSE;
				default:
					MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
					return FALSE;
			}
		}

		VmSleep(lTime);
		
		/*************************************/
		/* ���۹��� 2                        */
		/*************************************/
		/*
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );
		
		SPRINT(szMsg, "���ﵵ�ð��� %s ������\n", stUserinfo.szcenter_nm, 0, 0);
		SPRINT(szMsg2, "�������˿� : %s(%s) �湮", stUserinfo.sznm_kor, szUserTel, 0);
		
		Str_Cat(szMsg, szMsg2);
		
		ret = Tapi_SendSmsEx(szCustTel, szUserTel, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
					return FALSE;
				case -2:
					MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
					return FALSE;
				case -3:
					MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
					return FALSE;
				case -4:
					MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
					return FALSE;
				default:
					MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
					return FALSE;
			}
		}
		*/
		
		MessageBoxEx (CONFIRM_OK, "SMS ������ �Ϸ�Ǿ����ϴ�.");
		
		ret = TRUE;
		
		return ret;
	}
	
//------------------------------------------------------------------------------------------------------
	void Snd_Sms(void)
	{
	char szUrl[200];
	char szbuf[128];
	char szMemo[301];
	char szDay[15];
	char* sndbuf;
	long ret = 0;
	

		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		Mem_Set((byte*)szMemo, 0x00, sizeof(szMemo));	

		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));		
		Str_Cpy(szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cat(szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		//Str_Cpy( szDay, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA2)));

		Str_Chg( szDay, STRCHG_DEL_NONDIGIT);				
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		SPRINT(szUrl, "SELECT BEFO_HALF_MEMO FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ", m_szChk_Exec_Num, 0, 0   );
		g_Sql_RetStr( szUrl, 100, stSc.BEFO_HALF_MEMO );
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312316, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_exec_num",   g_szCHK_EXEC_NUM );
		JSON_SetValue( g_pjcomm, 'C', "gubun",          "1" );
		SQL_ConvUcStr( szMemo, stSc.BEFO_HALF_MEMO );
		JSON_SetValue( g_pjcomm, 'C', "befo_half_memo", szMemo );
		JSON_SetValue( g_pjcomm, 'C', "reserved_date",  szDay );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR312316; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR312316_IN",  "FR312316" , sndbuf, szbuf );
		
		return;
	}

	long TR312316(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(312316) >= 0)
		{
			if( Save_SmsSend() )
			{
				ON_EXIT();
				OnInit(INIT_MAIN);
			}
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

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetComboIdx(void)
	{
		long i, idx;
		long k = ROW+1;
		long lRow;
		long lActIndex;
		char sztmp[201];
		char szSql[301];	

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		//g_szCHK_EXEC_NUM
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ORDER BY HOUSE_NUM_ORD, DONG_ORD ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt( szSql, &lRow );

		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '2' ", lActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);


		return;
	}
	
	
//---------------------------------------------------------------------------------------------------------------
	void QuickList(long nBtnID)
	{
		handle js = NULL;
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		//nAddrType = 0 ���� ,, nAddrType = 1 ���θ�
		if( nBtnID == BID_QUICK_ADDR )
		{
			JSON_SetValue ( js, 'C', "title", "�������� �켱���˸���Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(COUNTY,'') ||' '|| ifnull(TOWN,'') ||' '|| ifnull(VILLAGE,'') ||' '|| ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOUSE_CNT,''), ifnull(CUST_NM, '') ||' /����:'|| Case When Length(ifnull(PREUSE_CHK_WHY, '')) > 0 Then 'F' Else '' End ||''|| Case When (SELECT Length(ifnull(B.CHK_EXEC_NUM, '')) FROM NORMAL_VISIT B WHERE B.CHK_EXEC_NUM = A.CHK_EXEC_NUM) > 0 Then 'B' ||''|| B.CNT Else '' End ||' /���:'|| Case When CHK_RSLT = '10' Then '������' When CHK_RSLT = '20' Then '����' When CHK_RSLT = '21' Then '������' When CHK_RSLT = '40' Then '����' When CHK_RSLT = '50' Then '�̽ǽ�' Else '�̰�' end ||' \n��ȭ��ȣ:'|| Case When Length(ifnull(OWNHOUSE_TEL_EXN, '')) > 1 Then ifnull(OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(OWNHOUSE_TEL_NUM,'') Else ifnull(CP_DDD,'') ||'-'|| ifnull(CP_EXN,'') ||'-'|| ifnull(CP_NUM,'') END  FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}
		else
		{
			JSON_SetValue ( js, 'C', "title", "�������� �켱���˸���Ʈ");
			JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
			JSON_SetValue ( js, 'C', "query", "select ifnull(COUNTY,'') ||' '|| ifnull(NEW_ROAD_NM,'') ||' '|| ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOUSE_CNT,''), ifnull(CUST_NM, '') ||' /����:'|| Case When Length(ifnull(PREUSE_CHK_WHY, '')) > 0 Then 'F' Else '' End ||''|| Case When (SELECT Length(ifnull(B.CHK_EXEC_NUM, '')) FROM NORMAL_VISIT B WHERE B.CHK_EXEC_NUM = A.CHK_EXEC_NUM) > 0 Then 'B' ||''|| B.CNT Else '' End ||' /���:'|| Case When CHK_RSLT = '10' Then '������' When CHK_RSLT = '20' Then '����' When CHK_RSLT = '21' Then '������' When CHK_RSLT = '40' Then '����' When CHK_RSLT = '50' Then '�̽ǽ�' Else '�̰�' end ||' \n��ȭ��ȣ:'|| Case When Length(ifnull(OWNHOUSE_TEL_EXN, '')) > 1 Then ifnull(OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(OWNHOUSE_TEL_NUM,'') Else ifnull(CP_DDD,'') ||'-'|| ifnull(CP_EXN,'') ||'-'|| ifnull(CP_NUM,'') END  FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE LENGTH(PREUSE_CHK_WHY) > 0 ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}

		sztmp = JSON_toString(js);
		
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:

		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
	}
	
	//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(long nBtnID)
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
		
		char col_name[5][32] = {"�ּ�", "����", "���", "��ȭ��ȣ", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","2","2","2","0"};
		char col_align[5][10]  = {"left", "center", "center","center", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		if( nBtnID == BID_QUICK_ADDR )
		{
			Str_Cpy(m_szQuickSql, "SELECT CASE WHEN A.SINGLE_COLIVE_FLAG = '10' \
											   THEN ifnull(A.ADDR1_M,'') ||'-'|| ifnull(A.ADDR1_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
										   	   ELSE ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') END \
										, CASE WHEN LENGTH(A.PREUSE_CHK_WHY) > 0 THEN 'F' ELSE '' END ||''|| CASE WHEN LENGTH(B.CHK_EXEC_NUM) > 0 THEN 'B' ||''|| B.CNT ELSE '' END ||''|| CASE WHEN LENGTH(A.OLD_BOILER_YN) > 0 THEN CHAR(10) || '��' ELSE '' END \
										, CASE WHEN A.CHK_RSLT = '10' THEN '������' \
										       WHEN A.CHK_RSLT = '20' THEN '����' \
										       WHEN A.CHK_RSLT = '21' THEN '������' \
											   WHEN A.CHK_RSLT = '40' THEN '����' \
											   WHEN A.CHK_RSLT = '50' THEN '�̽ǽ�' \
											   ELSE '�̰�' END \
										, CASE WHEN LENGTH(A.OWNHOUSE_TEL_EXN) > 0 THEN ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
											   ELSE ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') END \
									 FROM NORMAL_DATA A \
									 LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
											      ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
									WHERE LENGTH(PREUSE_CHK_WHY) > 0 \
									ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
		}
		else
		{
			Str_Cpy(m_szQuickSql, "SELECT CASE WHEN A.SINGLE_COLIVE_FLAG = '10' \
										       THEN ifnull(A.NEW_ROAD_NM,'') ||' '|| ifnull(A.NEW_ADDR_M,'') ||'-'|| ifnull(A.NEW_ADDR_S,'') ||' '|| ifnull(A.HOUSE_CNT,'') ||' '|| ifnull(A.LOT_NUM_SECOND_ADDR,'') \
										       ELSE ifnull(A.CO_LIVE_NM,'') ||' '|| ifnull(A.BLD_NM,'') ||'-'|| ifnull(A.HOUSE_CNT,'') END \
										, CASE WHEN LENGTH(A.PREUSE_CHK_WHY) > 0 THEN 'F' ELSE '' END ||''|| CASE WHEN LENGTH(B.CHK_EXEC_NUM) > 0 THEN 'B' ||''|| B.CNT ELSE '' END ||''|| CASE WHEN LENGTH(A.OLD_BOILER_YN) > 0 THEN CHAR(10) || '��' ELSE '' END \
										, CASE WHEN A.CHK_RSLT = '10' THEN '������' \
										       WHEN A.CHK_RSLT = '20' THEN '����' \
										       WHEN A.CHK_RSLT = '21' THEN '������' \
										       WHEN A.CHK_RSLT = '40' THEN '����' \
										       WHEN A.CHK_RSLT = '50' THEN '�̽ǽ�' \
										       ELSE '�̰�' END \
										, CASE WHEN LENGTH(A.OWNHOUSE_TEL_EXN) > 0 THEN ifnull(A.OWNHOUSE_TEL_DDD,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_EXN,'') ||'-'|| ifnull(A.OWNHOUSE_TEL_NUM,'') \
										       ELSE ifnull(A.CP_DDD,'') ||'-'|| ifnull(A.CP_EXN,'') ||'-'|| ifnull(A.CP_NUM,'') END \
									 FROM NORMAL_DATA A \
									 LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY CHK_EXEC_NUM ) B \
										          ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM \
									WHERE LENGTH(PREUSE_CHK_WHY) > 0 \
									ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
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
			
			col_count = 4;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_lActIndex;
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
			
			JSON_SetValue	(h		, 'C', "title"			, "�켱���� ����Ʈ");
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



