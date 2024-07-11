/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_BEFOCONFIRM_list
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
	
	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )
		DEF_BUTTON_ID ( BID_DELCANCEL )
		DEF_BUTTON_ID ( BID_DELETE )
		DEF_BUTTON_ID ( BID_CHANGE )
		DEF_BUTTON_ID ( BID_BF )
		DEF_BUTTON_ID ( BID_SIGN )
		DEF_BUTTON_ID ( BID_OK )
		DEF_BUTTON_ID ( BID_NEXTPG )
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTLST )
		DEF_BUTTON_ID ( BID_PREVLST )
//���Ϸ� ����
		DEF_BUTTON_ID ( BID_SCHDL)
		DEF_BUTTON_ID ( BID_SAVE)
		DEF_BUTTON_ID ( BID_CANCEL)
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
		DEF_OBJECT_ID ( TXT_PAGE )
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
		DEF_OBJECT_ID ( TXT_DATA14 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )
		DEF_OBJECT_ID ( TXT_DATA19 )
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA21 )
		DEF_OBJECT_ID ( TXT_DATA22 )
		DEF_OBJECT_ID ( TXT_DATA23 )
		DEF_OBJECT_ID ( TXT_DATA24 )
		DEF_OBJECT_ID ( TXT_DATA25 )
		DEF_OBJECT_ID ( TXT_DATA26 )
		DEF_OBJECT_ID ( TXT_DATA27 )
		DEF_OBJECT_ID ( TXT_DATA28 )
		DEF_OBJECT_ID ( TXT_PAGELST )
//���Ϸ�����
		DEF_OBJECT_ID ( TXT_DATA30 )
		DEF_OBJECT_ID ( TXT_DATA31 )
		DEF_OBJECT_ID ( TXT_DATA32 )
		DEF_OBJECT_ID ( TXT_DATA33 )
		DEF_OBJECT_ID ( TXT_DATA34 )
		DEF_OBJECT_ID ( TXT_DATA35 )
		DEF_OBJECT_ID ( TXT_DATA36 )
		DEF_OBJECT_ID ( TXT_DATA37 )
		DEF_OBJECT_ID ( TXT_DATA38 )
		DEF_OBJECT_ID ( TXT_DATA39 )
		DEF_OBJECT_ID ( TXT_DATA40 )
		DEF_OBJECT_ID ( TXT_DATA41 )
		DEF_OBJECT_ID ( TXT_DATA42 )
		DEF_OBJECT_ID ( TXT_DATA43 )
		DEF_OBJECT_ID ( TXT_DATA44 )
		DEF_OBJECT_ID ( TXT_DATA45 )
		DEF_OBJECT_ID ( TXT_DATA46 )
		DEF_OBJECT_ID ( TXT_DATA47 )
		DEF_OBJECT_ID ( TXT_DATA48 )
		DEF_OBJECT_ID ( TXT_DATA49 )
		DEF_OBJECT_ID ( TXT_DATA50 )
		DEF_OBJECT_ID ( TXT_DATA51 )

		DEF_OBJECT_ID ( EDT_VC)
		DEF_OBJECT_ID ( EDT_VA)
		DEF_OBJECT_ID ( EDT_VM)

//���Ϸ� ����
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		
		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )
//����
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 )
//���Ϸ� ����
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 )
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 )
		DEF_OBJECT_ID ( CMB_DATA5 = CMB_DATA4+3 )
		DEF_OBJECT_ID ( CMB_DATA6 = CMB_DATA5+3 )
		DEF_OBJECT_ID ( CMB_DATA7 = CMB_DATA6+3 )
		DEF_OBJECT_ID ( CMB_DATA8 = CMB_DATA7+3 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	  1
	#define INIT_BOILCHG  2
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    3					// table�� �ళ��
	#define		COL 	    7					// table�� ������
	#define		GRID_H		(CHT+10)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		MAXCHAR		51 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		GRID_Y		STARTY+580  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY+510  	    // table ����y��ǥ
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����

	Column m_stGridTitle[] = 
	{
		{"������",     CWD*10, EDITALIGN_LEFT|EDITALIGN_MIDDLE,    TABLE_TEXT, 0},
		{"�𵨸�",     CWD*13, EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"����",       CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���",       CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���Ϸ���ȣ", CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"��ġ����",   CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"�뷮",       CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0}
	};	
	
	char m_szCnt_index[10];
	char m_szCnt_page[10];
	char m_szBunner_Num[7];
	long m_lIdxFlag;
	long m_lpage;
	long m_lTotpage;
	long m_lTotCnt;			//����Ʈ ����
	long m_lLstCnt;			//����Ʈ
	long m_lSelIndex = -1;
	long m_bFirst;
	long m_lPrev = 0;
	long m_lEditCtrlIndex = -1;
	long m_lSqlOpenFlag = 0;
	
	GOVINFO stGovinfo;
	
	#define MAX_DISP_NUM 50
	handle m_hdb = NULL;
	SQLITE m_sql = NULL;	
	long m_nRowIndex = 0;
	long m_nRowOffset = MAX_DISP_NUM;
	BFINFO	m_stBfInfo[MAX_DISP_NUM];
	long m_nCursor = 0;
	
	void SetBtnImg(void);
	void Set_Index(void);	//���õ� �ε����� �����Ѵ�.
	void SetComboIdx(void);
	void SetCombo(void);
	void SetStyle(void);
	void SetData(void);
	void SetBoilData(void);
	void SetNogoodData(void);
	void SetClickData(void);
	void REDRAW(void);
	void CHG_DRAW(void);
	void INST_DRAW(void);
	bool Save_BoilChg(void);
	bool Save_Result(void);
	void SaveInput(void);
	bool New_Nogood(void);
	void Del_Boil(void);
	bool Validate(void);
	bool Check(void);
	void Prev_Pg(void);
	void Next_Pg(void);
	void Clear_Flag(void);
	long FS_GetSrchTotCnt(void);
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	
	void ReadData(void);

	long OpenDB(void);
	long CloseDB(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ���"),
		
		DLG_BUTTON(STARTX,      STARTY+70, 150, 50, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, " ��"),
		DLG_BUTTON(STARTX+160,  STARTY+70, 150, 50, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, " ��"),				
		DLG_BUTTON(STARTX,     STARTY+180, 200, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_BUTTON(STARTX+210, STARTY+530, 260, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELCANCEL, "�������"),
		DLG_BUTTON(STARTX+480, STARTY+530, 240, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE, "����"),
		DLG_BUTTON(STARTX+730, STARTY+530, 240, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "����"),
		DLG_BUTTON(STARTX,     STARTY+840, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+220, STARTY+840, 200, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+450, STARTY+840, 250, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BF, "����"),
		DLG_BUTTON(STARTX+720, STARTY+840, 250, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "����"),

		DLG_TEXT(STARTX+670,   STARTY+70, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index), 
		DLG_TEXT(STARTX,      STARTY+130, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "��"),
		DLG_TEXT(STARTX+200,  STARTY+130, 410, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+610,  STARTY+130, 360, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX+200,  STARTY+180, 770, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), //�ּ�
		DLG_TEXT(STARTX+200,  STARTY+230, 770, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), //�ּ�
		DLG_TEXT(STARTX,      STARTY+280, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA6, "TEL/HP"),
		DLG_TEXT(STARTX+200,  STARTY+280, 410, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+610,  STARTY+280, 360, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,      STARTY+330, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA9, "�跮��"),
		DLG_TEXT(STARTX+200,  STARTY+330, 410, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+610,  STARTY+330, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA11, "������"),
		DLG_TEXT(STARTX+840,  STARTY+330, 130, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,      STARTY+380, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA13, "��"),
		DLG_TEXT(STARTX+200,  STARTY+380, 410, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+610,  STARTY+380, 150, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA15, "���"),
		DLG_TEXT(STARTX+760,  STARTY+380, 210, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,      STARTY+430, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA17, "����"),
		DLG_TEXT(STARTX+550,  STARTY+430, 150, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA18, "����"),
		
		DLG_TEXT(STARTX,      STARTY+480, 130, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA23, "VC"),
		DLG_EDIT(STARTX+130,  STARTY+480, 180, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_VC, 10,  ""),
		DLG_TEXT(STARTX+330,  STARTY+480, 130, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA19, "VM"),
		DLG_EDIT(STARTX+460,  STARTY+480, 200, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_VM, 10,  ""),
		DLG_TEXT(STARTX+660,  STARTY+480, 130, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA21, "VA"),
		DLG_EDIT(STARTX+790,  STARTY+480, 200, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_VA, 10,  ""),

		DLG_TEXT(STARTX,      STARTY+530, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGELST, m_szCnt_page),
		DLG_TEXT(STARTX,      STARTY+780, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA25, "��ġ����"),
		DLG_TEXT(STARTX+230,  STARTY+780, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA26, ""),
		DLG_TEXT(STARTX+530,  STARTY+780, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA27, "�뷮"),
		DLG_TEXT(STARTX+730,  STARTY+780, 240, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA28, ""),

		DLG_COMBO (STARTX+200, STARTY+430, 350, 250, 100, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),	//
		DLG_COMBO (STARTX+700, STARTY+430, 270, 250, 100, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),	//
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//ȭ��ĸ��
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���� ���"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX,             70, 200, 50, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, " ��"),
		DLG_BUTTON(STARTX+230,         70, 200, 50, 0, 0, BUTSTY_BORDER|BUTSTY_BOLD, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, " ��"),				
		DLG_BUTTON(STARTX,      STARTY+80, 220, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_BUTTON(STARTX+210, STARTY+450, 260, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELCANCEL, "�������"),
		DLG_BUTTON(STARTX+480, STARTY+450, 240, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE, "����"),
		DLG_BUTTON(STARTX+730, STARTY+450, 240, 50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "����"),
		DLG_BUTTON(STARTX,     STARTY+800, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+220, STARTY+800, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+450, STARTY+800, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BF, "����"),
		DLG_BUTTON(STARTX+720, STARTY+800, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN, "����"),

		DLG_TEXT(STARTX+670,          70, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index), 
		DLG_TEXT(STARTX,       STARTY+30, 220, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "��"),
		DLG_TEXT(STARTX+220,   STARTY+30, 390, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+610,   STARTY+30, 360, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX+220,   STARTY+80, 750, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), //�ּ�
		DLG_TEXT(STARTX+220,  STARTY+130, 750, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), //�ּ�
		DLG_TEXT(STARTX,      STARTY+180, 220, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA6, "TEL/HP"),
		DLG_TEXT(STARTX+220,  STARTY+180, 390, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+610,  STARTY+180, 360, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,      STARTY+230, 220, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA9, "�跮��"),
		DLG_TEXT(STARTX+220,  STARTY+230, 390, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+610,  STARTY+230, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA11, "������"),
		DLG_TEXT(STARTX+840,  STARTY+230, 130, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,      STARTY+280, 220, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA13, "��"),
		DLG_TEXT(STARTX+220,  STARTY+280, 390, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+610,  STARTY+280, 150, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA15, "���"),
		DLG_TEXT(STARTX+760,  STARTY+280, 210, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,      STARTY+330, 220, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA17, "����"),
		DLG_TEXT(STARTX+550,  STARTY+330, 150, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA18, "����"),

		DLG_TEXT(STARTX,      STARTY+380, 130, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA23, "VC"),
		DLG_EDIT(STARTX+130,  STARTY+380, 180, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_VC, 10,  ""),
		DLG_TEXT(STARTX+330,  STARTY+380, 130, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA19, "VM"),
		DLG_EDIT(STARTX+460,  STARTY+380, 200, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_VM, 10,  ""),
		DLG_TEXT(STARTX+660,  STARTY+380, 130, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA21, "VA"),
		DLG_EDIT(STARTX+790,  STARTY+380, 200, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_VA, 10,  ""),		

		DLG_TEXT(STARTX,      STARTY+445, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGELST, m_szCnt_page),
		DLG_TEXT(STARTX,      STARTY+720, 230, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA25, "��ġ����"),
		DLG_TEXT(STARTX+230,  STARTY+720, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA26, ""),
		DLG_TEXT(STARTX+530,  STARTY+720, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA27, "�뷮"),
		DLG_TEXT(STARTX+730,  STARTY+720, 240, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA28, ""),

		DLG_COMBO (STARTX+220, STARTY+330, 330, 250, 100, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),	//
		DLG_COMBO (STARTX+700, STARTY+330, 270, 250, 100, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),	//
		
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	};
	
	//���Ϸ� ����
	//---------------------------------------------------------------
	DlgObject	DlgRes_BOILCHG[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���Ϸ� ����"),

		DLG_BUTTON(STARTX+630, STARTY+790, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "����"),
		DLG_BUTTON(STARTX,     STARTY+790, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL, "���"),
		
		DLG_TEXT(STARTX, 	     STARTY, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA30, "���ұ��ȣ"),
		DLG_TEXT(STARTX+300,     STARTY, 675, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, LIGHTGRAY,	TXT_DATA31, ""),	//���ұ�� �ڵ� ����+1�Ǽ� �߰�
		DLG_TEXT(STARTX, 	 STARTY+60, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA32, "����"),
		DLG_TEXT(STARTX, 	 STARTY+120, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA33, "�𵨸�"),
		DLG_TEXT(STARTX, 	 STARTY+180, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA34, "�뷮"),
		DLG_TEXT(STARTX, 	 STARTY+240, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA35, "�������"),
		
		DLG_TEXT(STARTX, 	 STARTY+300, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA36, "��ġ����"),
		DLG_TEXT(STARTX+300, STARTY+300, 525, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA37, ""),	//��ġ����
		DLG_BUTTON(STARTX+825,STARTY+300, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "��"),
		
		DLG_TEXT(STARTX, 	 STARTY+360, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA38, "��ġ��ġ"),
		DLG_TEXT(STARTX, 	 STARTY+420, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA39, "����"),
		DLG_TEXT(STARTX, 	 STARTY+480, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA40, "������ȣ"),
		DLG_TEXT(STARTX, 	 STARTY+540, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA41, "��ġ��ü"),
		DLG_TEXT(STARTX, 	 STARTY+600, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA42, "��ǥ�ڸ�"),
		DLG_TEXT(STARTX+300, STARTY+600, 675, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, ""),
		DLG_TEXT(STARTX,	 STARTY+660, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA44, "�����ȣ"),
		DLG_TEXT(STARTX+300, STARTY+660, 675, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA45, ""),
		DLG_TEXT(STARTX, 	 STARTY+720, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA46, "��ȭ��ȣ"),
		DLG_TEXT(STARTX+250, STARTY+720, 205, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA47, ""),
		DLG_TEXT(STARTX+455, STARTY+720, 50 , 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA48, "-"),
		DLG_TEXT(STARTX+505, STARTY+720, 210, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA49, ""),
		DLG_TEXT(STARTX+715, STARTY+720, 50 , 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, 	TXT_DATA50, "-"),
		DLG_TEXT(STARTX+765, STARTY+720, 210, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA51, ""),
		
		DLG_EDIT( STARTX+300,STARTY+120 , 675, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 30,  ""),
		DLG_EDIT( STARTX+300,STARTY+180 , 300, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 30,  ""),
		DLG_EDIT( STARTX+300,STARTY+480 , 675, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 30,  ""),
		
		DLG_COMBO (STARTX+300, STARTY+60, 675, 290, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 30),		
		DLG_COMBO (STARTX+600, STARTY+180, 375, 290, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 30),		
		DLG_COMBO (STARTX+300, STARTY+240, 675, 290, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 30),
		DLG_COMBO (STARTX+300, STARTY+360, 675, 290, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 30),
		DLG_COMBO (STARTX+300, STARTY+420, 675, 290, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA7, 30),
		DLG_COMBO (STARTX+300, STARTY+540, 675, 290, 120, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA8, 30),
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

		if( m_lSqlOpenFlag == 0 )
		{
			long nRet = OpenDB();
			if (nRet < 0)
			{
				//�޽��� �ڽ� ǥ��
				MessageBoxEx (CONFIRM_OK, "DB���¿� �����Ͽ����ϴ�.");
			}
			m_lSqlOpenFlag = 1;
			if( g_nActIndex >= MAX_DISP_NUM )
			{
				m_lpage = (g_nActIndex/MAX_DISP_NUM);
				m_nCursor = (g_nActIndex%MAX_DISP_NUM);
				
				m_nRowIndex = m_lpage*MAX_DISP_NUM;
			}
			else
			{
				m_nCursor = g_nActIndex;
			}
		}

		switch (bFirst)
		{
			case INIT_MAIN:
			
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						
						g_nAddrFlag = 0;

						SetBtnImg();
						SetStyle();
						SetCombo();
						//SetData();
						ReadData();
						SetBoilData();
						SetNogoodData();
						REDRAW();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						
						g_nAddrFlag = 0;
						SetBtnImg();
						SetStyle();
						SetCombo();
						//SetData();
						ReadData();
						//SetBoilData();
						//SetNogoodData();
						REDRAW();
						break;		
				}
				break;
			
			case INIT_BOILCHG:
				CREATE_DIALOG_OBJECT (DlgRes_BOILCHG, SIZEOF(DlgRes_BOILCHG));
				SetBtnImg();
				SetStyle();
				SetCombo();
				CHG_DRAW();
				break;
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
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGELST), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_VM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_VA), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_VC), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_BOILCHG )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA32), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA44), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA45), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA46), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA47), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA48), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA49), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA50), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA51), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA8), EDITALIGN_MIDDLE);
		}
	}
	
//------------------------------------------------------------------
	void SetCombo(void)
	{	
		char szSql[300];
		long i;

		if( m_bFirst == INIT_MAIN )
		{
			//����
			for ( i = 0 ;  INS_JOIN[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), INS_JOIN[i].Str, 0, ICON_NONE);
			}

			//����
			for ( i = 0 ;  INS_EXPLA[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), INS_EXPLA[i].Str, 0, ICON_NONE);
			}
		}
		else if( m_bFirst == INIT_BOILCHG )
		{
			//����
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM IN (201, 301)",0, 0, 0   );		
			g_Sql_SetCombo(szSql, CMB_DATA3+2);
					
			//�뷮����
			for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA4+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
			}
			
			//�������
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY TEL_NUM  ",0, 0, 0   );
			g_Sql_SetCombo(szSql, CMB_DATA5+2);
			
			//��ġ , BOIL_LOC
			for ( i = 0 ;  BOIL_LOC[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA6+2), BOIL_LOC[i].Str, 0, ICON_NONE);
			}
			
			//����
			for ( i = 0 ;  SCBOIL_FORM[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA7+2), SCBOIL_FORM[i].Str, 0, ICON_NONE);
			}
			
			//��ġ��ü
			g_Sql_SetCombo("SELECT WORK_FIRM FROM BO_INST LIMIT 0, 200", CMB_DATA8+2);
		}

	}
	
	//------------------------------------------------------------------	
	void OnExit(void)
	{
		CloseDB();	
	}
	
	//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d,k;
		char szDate[20];
		char sztmp[20];
	
		switch(ID)
		{
			case BID_ADDR:
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�\n�ּ�");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����\n�ּ�");
				}
				REDRAW();
				break;
			case BID_CHANGE:
				if( g_nWorkFlag == 500 )
				{
					Set_Index();
				}
				else
				{
					SetComboIdx();
				}
				
				if( m_lTotCnt == 0 )
				{
					break;
				}
				else
				{
					SaveInput();
					m_lIdxFlag = 1;
					ON_EXIT();
					OnInit(INIT_BOILCHG);
				}
				break;
			case BID_DELCANCEL:
				if( g_nWorkFlag == 500 )
				{
					Set_Index();
				}
				else
				{
					SetComboIdx();
				}
				SaveInput();
				g_lSCMoveFlag = 1;
				Card_Move("BF_NODEL");
				break;
			case BID_DELETE:
				if( m_lTotCnt == 0 )
				{
					break;
				}
				else if( Str_Cmp(stBfBoil.CHK_RSLT, "E") != 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�ű� �� ��ü ���Ϸ��� �����Ұ� �մϴ�.");
					break;
				}
				
				if(  MessageBoxEx (CONFIRM_YESNO, "�����Ͻðڽ��ϱ�?")  == MB_OK )
				{
					Del_Boil();
					SetBoilData();
				}
				break;
			case BID_PREVLST:
				m_lLstCnt -= ROW;
				if(m_lLstCnt < 0)
				{
					m_lLstCnt = 0;
					MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					SetBoilData();
					return;
				}
				m_lSelIndex = 0;
				SetBoilData();
				break;
			case BID_NEXTLST:
				m_lLstCnt += ROW;
				if( m_lLstCnt >= m_lTotCnt )
				{
					m_lLstCnt -= ROW;
					if(m_lLstCnt < 0)
					{
						m_lLstCnt = 0;
					}
					MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					SetBoilData();
					break;
				}
				m_lSelIndex = 0;
				SetBoilData();
				break;

			case BID_PREVPG:
				Clear_Flag();
				Prev_Pg();
				REDRAW();
				Set_Index();
				/*
				Prev_Pg();
				SetStyle();
				SetData();
				SetBoilData();
				SetNogoodData();
				REDRAW();
				Set_Index();
				*/
				break;			
			case BID_NEXTPG:
				Clear_Flag();
				Next_Pg();
				REDRAW();
				Set_Index();
				/*
				Next_Pg();
				SetStyle();
				SetData();
				SetBoilData();
				SetNogoodData();
				REDRAW();
				Set_Index();
				*/
				break;
			case BID_BF:
				if( g_nWorkFlag == 500 )
				{
					Set_Index();
				}
				else
				{
					SetComboIdx();
				}
				SaveInput();
				if( Str_Cmp( stBf.SEND_FLAG, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
				}
				else if( m_lTotCnt == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "������ ���Ϸ��� �����ϴ�.");
				}
				else if( Str_Cmp( stBfBoil.CHK_RSLT, "E") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "������ ���Ϸ��� �ƴմϴ�.");
				}
				else
				{
					g_lSCMoveFlag = 1;
					Card_Move("BF_BEFOBOILCHK");
				}
				break;
			case BID_SIGN:
				if( Save_Result() )
				{
					ON_BUTTON(BID_NEXTPG);
				}
				break;
			case GID_HOME:
				if( g_nWorkFlag == 500 )
				{
					Set_Index();
				}
				else
				{
					SetComboIdx();
				}
				Card_Move("MENU");
				break;
			case GID_MENU:
				if( g_nWorkFlag == 500 )
				{
					Set_Index();
				}
				else
				{
					SetComboIdx();
				}
				Card_Move("BF_BEFOMENU");
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
				Set_Index();
				Card_Move("BF_BEFOSLLST");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
//���Ϸ� ����
			case BID_SCHDL:
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_ItoA( d, sztmp, 10);
					g_Str_DateType(szDate, sztmp);
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA37), szDate );
				}
				break;
			case BID_SAVE:
				if( Save_BoilChg() )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_CANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
		}
	}		
	
//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long i;
		long index = -1;
		long lPage;
		char szDate[10];

		if( m_bFirst == INIT_MAIN )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);

				m_lSelIndex = index -1;
				g_nActRow = m_lpage*ROW + m_lSelIndex;
				
				lPage = m_lLstCnt + index;
				SPRINT(m_szCnt_page, "%d/%d", lPage, m_lTotCnt, 0);
				
				Str_Cpy(m_szBunner_Num , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
				
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				g_Str_DateType(szDate, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA26),  szDate);
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA28), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 6) );
				SetClickData();
			}
			
			//����
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), INS_JOIN );
			if (i == -1)
			{
				Str_Cpy(stBf.INS_JOIN_YN, "");
			}
			else
			{
				Str_Cpy(stBf.INS_JOIN_YN, INS_JOIN[i].Code);
			}
			Mem_Set( (byte*)g_szINS_JOIN, 0x00, sizeof(g_szINS_JOIN) );
			Str_Cpy(g_szINS_JOIN, stBf.INS_JOIN_YN);
			//����
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), INS_EXPLA );
			if (i == -1)
			{
				Str_Cpy(stBf.INS_EXPLA_YN, "");
			}
			else
			{
				Str_Cpy(stBf.INS_EXPLA_YN, INS_EXPLA[i].Code);
			}
			Mem_Set( (byte*)g_szINS_EXPLA, 0x00, sizeof(g_szINS_EXPLA) );
			Str_Cpy(g_szINS_EXPLA, stBf.INS_EXPLA_YN);
		}
		else if( m_bFirst == INIT_BOILCHG )
		{
			INST_DRAW();
		}
	}

//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nIndiVc = 0;
		long nBefo_IndiVc = 0;
		long nRet = 0;
		char szRet[5];
		
		if( m_bFirst == INIT_BOILCHG )
		{
			Mem_Set((byte *)szRet, 0x00, sizeof(szRet));
			//���ڸ� �Է� ����
			if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex && (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "�뷮�Է��� ���ڸ� �Է��� �ּ���.");
				Str_Chg(EditCtrl_GetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex)), STRCHG_DEL_NONDIGIT);
				//EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}
		}
	}
	
	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		
		if( m_bFirst == INIT_BOILCHG )
		{
			//EDITCTRL�� ACTIVE�ÿ� CTRLINDEX�� ����
			//Ű���� BUTTONCTRL�� ACTIVE�ÿ��� EDITCTRL�� Ŀ���� �α����ؼ� INDEX�� ����
			lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
	
			if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex )
			{
				m_lEditCtrlIndex = lActiveIndex;
			}
			else
			{
				m_lEditCtrlIndex = -1;
			}
		}
	}
	
	

//------------------------------------------------------------------		
	long OpenDB(void)
	{
		m_sql = NewSqLite();
		if (m_sql == NULL)
		{
			return -1;
		}
		
		m_hdb = m_sql->Open(m_sql);
		if( m_hdb == NULL )
		{
			return -2;
		}
		
		return 0;
	}
	
//------------------------------------------------------------------	
	long CloseDB(void)
	{
		DelSqLite(m_sql);
		m_sql = NULL;
		
		return 0;
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
	�Լ��� : Prev_Pg
	��  �� : ���� ��ư�� ��������� ã�´�.
	Param  : 
	Return : 
	========================================================================================*/
	void Prev_Pg(void)
	{
		long lPage;
	/*
		if( g_nActIndex > 0 )
		{
			g_nActIndex--;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		}
		else
		{
			g_nActIndex = -1;
		}
		
		if( g_nActIndex < 2 )
		{	//�˻� ��, ù��° �� �޼��� �ڽ� ����
			m_lPrev--;
		}

		if( g_lindex <= 0 || g_nActIndex < 0 )
		{
			g_nActIndex = 0;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			if( m_lPrev < 0 )
			{
				m_lPrev = 0;
				MessageBoxEx (CONFIRM_OK, "ù��° ���Դϴ�.");
			}
			return;
		}
		*/
		m_nCursor--;
		lPage = MAX_DISP_NUM*m_lpage + m_nCursor;
		if( lPage < 0 )
		{
			m_nCursor = 0;
			MessageBoxEx (CONFIRM_OK, "ù��° ���Դϴ�.");
		}
		else if( lPage < m_nRowIndex )
		{
			//m_nCursor++;
			//m_nCursor = m_nRowCount-m_nCursor;
			//m_nRowCount = m_nRowCount-MAX_DISP_NUM;
			m_nCursor = m_nRowIndex-1;
			m_nRowIndex -= MAX_DISP_NUM;			
			m_lpage--;
			ReadData();
			//REDRAW();
		}
		
		//g_nActIndex = m_nCursor;
		Mem_Set( (byte*)g_szINS_JOIN, 0x00, sizeof(g_szINS_JOIN) );
		Mem_Set( (byte*)g_szINS_EXPLA, 0x00, sizeof(g_szINS_EXPLA) );
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Next_Pg
	��  �� : �ٿ� ��ư�� ��������� ã�´�.
	Param  : 
	Return : 
	========================================================================================*/
	void Next_Pg(void)
	{
		long lPage;
		
		m_lPrev = 0;
/*
		g_nActIndex++;
		g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		if( g_nActIndex > m_lTotpage || g_lindex < 0 )
		{
			if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
			{
				g_nActIndex = g_nActIndex-1;
			}
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			MessageBoxEx (CONFIRM_OK, "������ ���Դϴ�.");
			return;
		}
*/
		
		m_nCursor++;
		lPage = MAX_DISP_NUM*m_lpage + m_nCursor;
		if( lPage >= m_lTotpage )
		{
			m_nCursor--;
			MessageBoxEx (CONFIRM_OK, "������ ���Դϴ�.");
		}
		else if( m_nCursor >= (m_nRowOffset + MAX_DISP_NUM*m_lpage) )
		{
			m_nCursor = 0;
			m_nRowIndex += MAX_DISP_NUM;
			m_lpage++;
			ReadData();
		}

		
		g_nActIndex = m_nCursor;
		Mem_Set( (byte*)g_szINS_JOIN, 0x00, sizeof(g_szINS_JOIN) );
		Mem_Set( (byte*)g_szINS_EXPLA, 0x00, sizeof(g_szINS_EXPLA) );
		return;
	}

	
/*=======================================================================================
========================================================================================*/	
/*
	void SetData(void)
	{
		long i;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stBf, 0x00, sizeof(stBf));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}


		hstmt = sql->CreateStatement(sql,
"SELECT ROWID, CREATE_YMD, MTR_NUM, BEFO_OBJ_YN, BLD_NUM, INST_PLACE_NUM, SINGLE_COLIVE_FLAG \
, CENTER_CD, ZONE_MANAGE_NUM, PDA_NUM, ZIP_NO1, ZIP_NO2, COUNTY, TOWN, VILLAGE, ADDR1_M \
, ADDR1_S, LOT_NUM_SECOND_ADDR, CO_LIVE_NM, HOUSE_CNT, BLD_NM, DETA_FLOOR, COMPX_FLAG_NM \
, CUST_NUM, CUST_TYPE_CD, CUST_NM, FIRM_NM, BIZ_REGI_NUM, SOC_NUM, REPRE_NM, CP_DDD \
, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, USE_CONT_NUM \
, PROD_NM, CONT_YMD, CNL_YMD, MTR_ID_NUM, MTR_MODEL_CD, MTR_GRD, CONT_STS_CD, INS_JOIN_YN \
, INS_EXPLA_YN, COMPENS_OBJ_YN, CHK_YMD, CHK_TIME_FROM, CHK_TIME_TO, CHK_EMPID, CHK_RSLT \
, SIGN, INDI_DTM, MTR_INDI, INDI_VA, INDI_VC, SEND_FLAG, CRT_EMPID, CRT_IP, LAW_TOWN \
, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S \
FROM BEFO_DATA WHERE ROWID = ?  "
		);
		

		
		hstmt = sql->CreateStatement(sql,
"SELECT ROWID, CREATE_YMD, MTR_NUM, BEFO_OBJ_YN, BLD_NUM, INST_PLACE_NUM, SINGLE_COLIVE_FLAG \
, CENTER_CD, ZONE_MANAGE_NUM, PDA_NUM, ZIP_NO1, ZIP_NO2, COUNTY, TOWN, VILLAGE, ADDR1_M \
, ADDR1_S, LOT_NUM_SECOND_ADDR, CO_LIVE_NM, HOUSE_CNT, BLD_NM, DETA_FLOOR, COMPX_FLAG_NM \
, CUST_NUM, CUST_TYPE_CD, CUST_NM, FIRM_NM, BIZ_REGI_NUM, SOC_NUM, REPRE_NM, CP_DDD \
, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, USE_CONT_NUM \
, PROD_NM, CONT_YMD, CNL_YMD, MTR_ID_NUM, MTR_MODEL_CD, MTR_GRD, CONT_STS_CD, INS_JOIN_YN \
, INS_EXPLA_YN, COMPENS_OBJ_YN, CHK_YMD, CHK_TIME_FROM, CHK_TIME_TO, CHK_EMPID, CHK_RSLT \
, SIGN, INDI_DTM, MTR_INDI, INDI_VA, INDI_VC, SEND_FLAG, CRT_EMPID, CRT_IP, LAW_TOWN \
, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S \
FROM BEFO_DATA LIMIT ?, ? "
		);
		
		//LIMIT 0, 50
		//LIMIT 50,50
		//LIMIT 100,50

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'X', &g_lindex , 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ROWID              ,3 + 1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CREATE_YMD         ,8  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_NUM            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].BEFO_OBJ_YN        ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].BLD_NUM            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INST_PLACE_NUM     ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].SINGLE_COLIVE_FLAG ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CENTER_CD          ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ZONE_MANAGE_NUM    ,5  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].PDA_NUM            ,5  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ZIP_NO1            ,3  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ZIP_NO2            ,3  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].COUNTY             ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].TOWN               ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].VILLAGE            ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ADDR1_M            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ADDR1_S            ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].LOT_NUM_SECOND_ADDR,100+1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CO_LIVE_NM         ,60 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].HOUSE_CNT          ,6  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].BLD_NM             ,100+1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].DETA_FLOOR         ,6  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].COMPX_FLAG_NM      ,60 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CUST_NUM           ,10 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CUST_TYPE_CD       ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CUST_NM            ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].FIRM_NM            ,50 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].BIZ_REGI_NUM       ,10 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].SOC_NUM            ,13 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].REPRE_NM           ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CP_DDD             ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CP_EXN             ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CP_NUM             ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].OWNHOUSE_TEL_DDD   ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].OWNHOUSE_TEL_EXN   ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].OWNHOUSE_TEL_NUM   ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].USE_CONT_NUM       ,10 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].PROD_NM            ,50 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CONT_YMD           ,8  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CNL_YMD            ,8  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_ID_NUM         ,20 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_MODEL_CD       ,20 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_GRD            ,62 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CONT_STS_CD        ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INS_JOIN_YN        ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INS_EXPLA_YN       ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].COMPENS_OBJ_YN     ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_YMD            ,8  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_TIME_FROM      ,6  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_TIME_TO        ,6  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_EMPID          ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_RSLT           ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].SIGN               ,300+1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INDI_DTM           ,14 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_INDI           ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INDI_VA            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INDI_VC            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].SEND_FLAG          ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CRT_EMPID          ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CRT_IP             ,32 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].LAW_TOWN           ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].NEW_ROAD_NM        ,100+1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].NEW_ADDR_M         ,10 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].NEW_ADDR_S         ,10 +1 , DECRYPT );
		}
		
Finally:

		Str_Cpy(g_szCREATE_YMD, stBf.CREATE_YMD);
		Str_Cpy(g_szMTR_NUM, stBf.MTR_NUM);
		
		//���˽��۽ð�
		g_Str_TimeType( stBf.CHK_TIME_FROM , Time_GetTime());
		
		return;
	}
*/

	void SetData(void)
	{
		return;
	}

//-----------------------------------------------------------------------------------------------
	void ReadData(void)
	{
		long i, j;
		SQLITE s = m_sql;
		handle hStmt = NULL;

		//Mem_Set((byte*)&stBf, 0x00, sizeof(stBf));

		hStmt = s->CreateStatement(s,
"SELECT ROWID, CREATE_YMD, MTR_NUM, BEFO_OBJ_YN, BLD_NUM, INST_PLACE_NUM, SINGLE_COLIVE_FLAG \
, CENTER_CD, ZONE_MANAGE_NUM, PDA_NUM, ZIP_NO1, ZIP_NO2, COUNTY, TOWN, VILLAGE, ADDR1_M \
, ADDR1_S, LOT_NUM_SECOND_ADDR, CO_LIVE_NM, HOUSE_CNT, BLD_NM, DETA_FLOOR, COMPX_FLAG_NM \
, CUST_NUM, CUST_TYPE_CD, CUST_NM, FIRM_NM, BIZ_REGI_NUM, SOC_NUM, REPRE_NM, CP_DDD \
, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, USE_CONT_NUM \
, PROD_NM, CONT_YMD, CNL_YMD, MTR_ID_NUM, MTR_MODEL_CD, MTR_GRD, CONT_STS_CD, INS_JOIN_YN \
, INS_EXPLA_YN, COMPENS_OBJ_YN, CHK_YMD, CHK_TIME_FROM, CHK_TIME_TO, CHK_EMPID, CHK_RSLT \
, SIGN, INDI_DTM, MTR_INDI, INDI_VA, INDI_VC, SEND_FLAG, CRT_EMPID, CRT_IP, LAW_TOWN \
, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S \
FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S LIMIT ?, ? "
		);
		

		//LIMIT 0, 50
		//LIMIT 50,50
		//LIMIT 100,50

		if( hStmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", s->GetLastError(s), 0, 0);
			goto Finally;
		}

		i = 0;
		s->Bind(s, i++, 'X', &m_nRowIndex , 4, DECRYPT);
		s->Bind(s, i++, 'X', &m_nRowOffset , 4, DECRYPT);

		if(s->Execute(s) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", s->GetLastError(s), 0, 0);
			goto Finally;
		}

		j = 0;
		while ( s->Next(s) == TRUE )
		{	
			i = 0;
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ROWID              ,3 + 1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CREATE_YMD         ,8  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_NUM            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].BEFO_OBJ_YN        ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].BLD_NUM            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INST_PLACE_NUM     ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].SINGLE_COLIVE_FLAG ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CENTER_CD          ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ZONE_MANAGE_NUM    ,5  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].PDA_NUM            ,5  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ZIP_NO1            ,3  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ZIP_NO2            ,3  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].COUNTY             ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].TOWN               ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].VILLAGE            ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ADDR1_M            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].ADDR1_S            ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].LOT_NUM_SECOND_ADDR,100+1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CO_LIVE_NM         ,60 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].HOUSE_CNT          ,6  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].BLD_NM             ,100+1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].DETA_FLOOR         ,6  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].COMPX_FLAG_NM      ,60 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CUST_NUM           ,10 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CUST_TYPE_CD       ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CUST_NM            ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].FIRM_NM            ,50 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].BIZ_REGI_NUM       ,10 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].SOC_NUM            ,13 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].REPRE_NM           ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CP_DDD             ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CP_EXN             ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CP_NUM             ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].OWNHOUSE_TEL_DDD   ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].OWNHOUSE_TEL_EXN   ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].OWNHOUSE_TEL_NUM   ,4  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].USE_CONT_NUM       ,10 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].PROD_NM            ,50 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CONT_YMD           ,8  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CNL_YMD            ,8  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_ID_NUM         ,20 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_MODEL_CD       ,20 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_GRD            ,62 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CONT_STS_CD        ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INS_JOIN_YN        ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INS_EXPLA_YN       ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].COMPENS_OBJ_YN     ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_YMD            ,8  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_TIME_FROM      ,6  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_TIME_TO        ,6  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_EMPID          ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CHK_RSLT           ,2  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].SIGN               ,300+1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INDI_DTM           ,14 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].MTR_INDI           ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INDI_VA            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].INDI_VC            ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].SEND_FLAG          ,1  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CRT_EMPID          ,9  +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].CRT_IP             ,32 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].LAW_TOWN           ,30 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].NEW_ROAD_NM        ,100+1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].NEW_ADDR_M         ,10 +1 , DECRYPT );
			s->GetValue( s, i++, 'U', (long*) m_stBfInfo[j].NEW_ADDR_S         ,10 +1 , DECRYPT );
			
			j++;
			
			if (j >= MAX_DISP_NUM)
				break;
		}

Finally:
		//s->Commit(s);
		//DelSqLite(sql);

		//Str_Cpy(g_szCREATE_YMD, stBf.CREATE_YMD);
		//Str_Cpy(g_szMTR_NUM, stBf.MTR_NUM);
		
		//���˽��۽ð�
		//g_Str_TimeType( stBf.CHK_TIME_FROM , Time_GetTime());
		
		return;
	}
	
//---------------------------------------------------------------------------------------------------------
	void SetBoilData(void)
	{
		long i, idx, j, n;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		long lPage;
		char sztmp[300];
		char szSql[800];
		char szDate[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//������
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM BEFO_BO_DATA  WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' AND (CHG_FLAG <> '30' OR CHG_FLAG IS NULL) ",g_szCREATE_YMD, g_szMTR_NUM, 0   );
		g_Sql_RetInt( sztmp, &m_lTotCnt );

		if(m_lIdxFlag == 1 || g_lSCMoveFlag == 1)
		{
			m_lLstCnt = g_nActRow / ROW;
			m_lSelIndex = (g_nActRow % ROW);
			
			m_lIdxFlag = 0;
			g_lSCMoveFlag = 0;
		}

		if( m_lSelIndex == -1 )
		{
			m_lSelIndex = 0;
		}

		if( m_lTotCnt > 0 )
		{
			lPage = m_lLstCnt+m_lSelIndex;
		}
		else
		{
			lPage = -1;
		}

		SPRINT(m_szCnt_page, "%d/%d", lPage+1, m_lTotCnt, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MAKER_NM, BURNER_MODEL_NM, INST_FLAG, CHK_RSLT, BURNER_NUM, BURNER_INST_YMD, BURNER_CAPA \
					FROM BEFO_BO_DATA WHERE CREATE_YMD = ? AND MTR_NUM = ? AND (CHG_FLAG <> '30' OR CHG_FLAG IS NULL) LIMIT ?, ? "
					, 0, 0, 0);
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;
		lstartidx = m_lpage;
		j = m_lpage+ROW;
		sql->Bind(sql, i++, 'U', (long*)&g_szCREATE_YMD , 8, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&g_szMTR_NUM ,    9, DECRYPT);
		sql->Bind(sql, i++, 'X', &lstartidx, 4, DECRYPT);
		sql->Bind(sql, i++, 'X', &j, 4, DECRYPT);
		
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
					continue;
				}
				//������
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue( sql, idx++, 'U', (long*) sztmp   , 60 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//�𵨸�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue( sql, idx++, 'U', (long*) sztmp   , 50  + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//���� , Decode(INST_FLAG,'10','�ű�','20','��ü','����')
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue( sql, idx++, 'U', (long*) sztmp   , 2  + 1, DECRYPT );
				n = SearchCD( sztmp, BFBOIL_INST );
				if( n == -1 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, BFBOIL_INST[2].Str );
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, BFBOIL_INST[n].Str );
				}
				//��� , Decode(CHK_RSLT,'Y','����','N','������','E',' ','��Ȯ��')
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue( sql, idx++, 'U', (long*) sztmp    , 2  + 1, DECRYPT );
				if( Str_Cmp(sztmp, "N") == 0 )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle ( ID_TBLLIST, i, 3 ), RED);
				}
				else
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle ( ID_TBLLIST, i, 3 ), BLACK);
				}
				n = SearchCD( sztmp, BFBOIL_RSLT );
				if( n == -1 )
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, BFBOIL_RSLT[3].Str );
				}
				else
				{
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, BFBOIL_RSLT[n].Str );
				}
				//���Ϸ���ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue( sql, idx++, 'U', (long*) sztmp     , 6 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//��ġ����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue( sql, idx++, 'U', (long*) sztmp     , 8 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				//�뷮
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue( sql, idx++, 'U', (long*) sztmp     ,10 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
			}
		}	

Finally:
		sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotCnt > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)m_szBunner_Num, 0x00, sizeof(m_szBunner_Num) );
			Str_Cpy(m_szBunner_Num , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
			
			Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
			g_Str_DateType(szDate, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA26),  szDate);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA28), DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 6) );
			
			SetClickData();
		}
		
		ON_DRAW();
		return;
	}
	
//---------------------------------------------------------------------------------------------------------	
	void SetClickData(void)
	{
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stBfBoil, 0x00, sizeof(stBfBoil));
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
		"SELECT CREATE_YMD, MTR_NUM, BURNER_NUM, CHK_OBJ_BOILER_YN, NEW_REPL_FLAG, BURNER_MODEL_CD \
		, BURNER_CLASS_CD, BURNER_KIND_NUM, BURNER_CAPA, BURNER_CAPA_UNIT, BURNER_INST_YMD \
		, BURNER_REMOV_YMD, BURNER_MODEL_NM, MAKER_FLAG, MAKER_NUM, MAKER_NM, BOILER_FORM \
		, MAKE_NUM, WORK_DOCU_RECEIVE_YMD, INST_FLAG, INST_LOC, BOILER_INST_FIRM_CD, BO1_RSLT \
		, BO2_RSLT, BO3_RSLT, BO4_RSLT, CHK_RSLT, SEND_FLAG, CRT_EMPID, CRT_IP, CHG_FLAG \
		, BURNER_CAPA_UNIT_NM, BURNER_CLASS_NM, BURNER_KIND_NM, BOILER_FORM_NM \
		FROM BEFO_BO_DATA WHERE CREATE_YMD = ? AND MTR_NUM = ? AND BURNER_NUM = ? AND (CHG_FLAG <> '30' OR CHG_FLAG IS NULL) "
		);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szCREATE_YMD , 8, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&g_szMTR_NUM ,    9, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&m_szBunner_Num , 6, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			idx = 0;
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.CREATE_YMD			      , 8 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.MTR_NUM				  , 9 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_NUM			      , 6 + 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.CHK_OBJ_BOILER_YN		  , 1 + 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.NEW_REPL_FLAG			  , 2 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_MODEL_CD		  , 6 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_CLASS_CD		  , 2 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_KIND_NUM		  , 3 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_CAPA			  , 10+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_CAPA_UNIT		  , 2 + 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_INST_YMD		  , 8 + 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_REMOV_YMD		  , 8 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_MODEL_NM		  , 2 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.MAKER_FLAG			      , 5 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.MAKER_NUM				  , 2 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.MAKER_NM				  , 30+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BOILER_FORM			  , 8 + 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.MAKE_NUM				  , 20+ 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.WORK_DOCU_RECEIVE_YMD	  , 8 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.INST_FLAG				  , 2 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.INST_LOC				  , 2 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BOILER_INST_FIRM_CD	  , 6 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BO1_RSLT				  , 2 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BO2_RSLT				  , 2 + 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BO3_RSLT				  , 2 + 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BO4_RSLT				  , 2 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.CHK_RSLT				  , 2 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.SEND_FLAG				  , 1 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.CRT_EMPID				  , 9 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.CRT_IP				      , 32+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.CHG_FLAG				  , 2 + 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_CAPA_UNIT_NM	  , 30+ 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_CLASS_NM		  , 30+ 1, DECRYPT );	
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BURNER_KIND_NM		      , 30+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfBoil.BOILER_FORM_NM		      , 30+ 1, DECRYPT );
		}
		
Finally:
		sql->Commit(sql);
		DelSqLite(sql);
		
		Str_Cpy(g_szBURNER_NUM, stBfBoil.BURNER_NUM);
		
		return;
	}
		
//---------------------------------------------------------------------------------------------------------
	void SetNogoodData(void)
	{
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stBfNogood, 0x00, sizeof(stBfNogood));
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT CREATE_YMD, MTR_NUM, BLD_NUM, INST_PLACE_NUM, SINGLE_COLIVE_FLAG, CENTER_CD \
, ZONE_MANAGE_NUM, ZIP_NO1, ZIP_NO2, CITY, AREA, TOWN, VILLAGE, ADDR1_M, ADDR1_S \
, LOT_NUM_SECOND_ADDR, CO_LIVE_NM, HOUSE_CNT, BLD_NM, DETA_FLOOR, COMPX_FLAG_NM \
, CUST_NUM, CUST_TYPE_CD, CUST_NM, FIRM_NM, BIZ_REGI_NUM, SOC_NUM, REPRE_NM, CP_DDD \
, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, END_YN, SEND_YN \
, CRT_EMPID, CRT_IP, LAW_TOWN, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S \
FROM BEFO_NOGOOD_MAIN WHERE CREATE_YMD = ? AND MTR_NUM = ? "
		);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szCREATE_YMD , 8, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&g_szMTR_NUM ,    9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			idx = 0;
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CREATE_YMD         , 8  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.MTR_NUM            , 9  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.BLD_NUM            , 9  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.INST_PLACE_NUM     , 9  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.SINGLE_COLIVE_FLAG , 2  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CENTER_CD          , 2  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ZONE_MANAGE_NUM    , 5  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ZIP_NO1            , 3  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ZIP_NO2            , 3  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CITY               , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.AREA               , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.TOWN               , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.VILLAGE            , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ADDR1_M            , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.ADDR1_S            , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.LOT_NUM_SECOND_ADDR, 100+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CO_LIVE_NM         , 60 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.HOUSE_CNT          , 6  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.BLD_NM             , 150+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.DETA_FLOOR         , 6  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.COMPX_FLAG_NM      , 60 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CUST_NUM           , 10 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CUST_TYPE_CD       , 2  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CUST_NM            , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.FIRM_NM            , 50 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.BIZ_REGI_NUM       , 10 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.SOC_NUM            , 13 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.REPRE_NM           , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CP_DDD             , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CP_EXN             , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CP_NUM             , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.OWNHOUSE_TEL_DDD   , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.OWNHOUSE_TEL_EXN   , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.OWNHOUSE_TEL_NUM   , 4  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.END_YN             , 1  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.SEND_YN            , 1  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CRT_EMPID          , 9  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.CRT_IP             , 32 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.LAW_TOWN           , 30 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.NEW_ROAD_NM        , 100+ 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.NEW_ADDR_M         , 10 + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) stBfNogood.NEW_ADDR_S         , 10 + 1, DECRYPT );
		}
		
Finally:
		sql->Commit(sql);
		DelSqLite(sql);
		
		return;
	}


//---------------------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		char szSql[300];
		char szAddr[300];
		char szTel[50];
		long lPage;
		long i;
	
		//������
		//m_lTotpage = FS_GetSrchTotCnt();
		//SPRINT(m_szCnt_index, "%d/%d", g_nActIndex+1, m_lTotpage, 0);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ", 0, 0, 0);
		g_Sql_RetInt(szSql, &m_lTotpage);
		
		lPage = MAX_DISP_NUM*m_lpage + m_nCursor;
		SPRINT(m_szCnt_index, "%d/%d", lPage+1, m_lTotpage, 0);

		
	
		//�ܵ�,���� ���� üũ?
		if( g_lDataflag == 0 )
		{
			if( Str_Cmp( m_stBfInfo[m_nCursor].COMPENS_OBJ_YN, "Y") == 0 )
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA19), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA21), TRUE);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VC), m_stBfInfo[m_nCursor].INDI_VC);
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VM), m_stBfInfo[m_nCursor].MTR_INDI);
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VA), m_stBfInfo[m_nCursor].INDI_VA);
			}
			else
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA19), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA21), FALSE);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VC), m_stBfInfo[m_nCursor].INDI_VC);
			}
		}
		else
		{
			if( Str_Cmp( m_stBfInfo[m_nCursor].COMPENS_OBJ_YN, "Y") == 0 )
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA19), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA21), TRUE);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VC), g_szIndi_Vc);
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VM), g_szIndi_Vm);
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VA), g_szIndi_Va);
			}
			else
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA19), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA21), FALSE);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VC), g_szIndi_Vc);
			}
			
			g_lDataflag = 0;
		}
	
		//��
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), m_stBfInfo[m_nCursor].CUST_NUM);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), m_stBfInfo[m_nCursor].CUST_NM);
		
		//�ּ�
		if( g_nAddrFlag == 0)
		{
			Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
			
			if(Str_Len(m_stBfInfo[m_nCursor].COUNTY) != 0)
			{
				Str_Cpy(szAddr,  m_stBfInfo[m_nCursor].COUNTY );
			}
			if(Str_Len(m_stBfInfo[m_nCursor].TOWN) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  m_stBfInfo[m_nCursor].TOWN );
			}
			if(Str_Len(m_stBfInfo[m_nCursor].VILLAGE) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  m_stBfInfo[m_nCursor].VILLAGE);
			}			
			if(Str_Len(m_stBfInfo[m_nCursor].ADDR1_M) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  m_stBfInfo[m_nCursor].ADDR1_M);
			}
			if(Str_Len(m_stBfInfo[m_nCursor].ADDR1_S) != 0)
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  m_stBfInfo[m_nCursor].ADDR1_S);
			}
			//�⺻�ּ�
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), szAddr);
			
			//���ּ�
			Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
			if( Str_Cmp( m_stBfInfo[m_nCursor].SINGLE_COLIVE_FLAG, "10") == 0 )
			{
				if(Str_Len(m_stBfInfo[m_nCursor].LOT_NUM_SECOND_ADDR) != 0)
				{
					Str_Cpy(szAddr,  m_stBfInfo[m_nCursor].LOT_NUM_SECOND_ADDR);
				}
				if(Str_Len(m_stBfInfo[m_nCursor].BLD_NM) != 0)
				{
					Str_Cat(szAddr,  " ");
					Str_Cat(szAddr,  m_stBfInfo[m_nCursor].BLD_NM);
				}
				if(Str_Len(m_stBfInfo[m_nCursor].HOUSE_CNT) != 0)
				{
					Str_Cat(szAddr,  " ");
					Str_Cat(szAddr,  m_stBfInfo[m_nCursor].HOUSE_CNT);
				}
			}
			else
			{
				if(Str_Len(m_stBfInfo[m_nCursor].CO_LIVE_NM) != 0)
				{
					Str_Cpy(szAddr,  m_stBfInfo[m_nCursor].CO_LIVE_NM);
				}
				if(Str_Len(m_stBfInfo[m_nCursor].BLD_NM) != 0)
				{
					Str_Cat(szAddr,  " ");
					Str_Cat(szAddr,  m_stBfInfo[m_nCursor].BLD_NM);
				}
				if(Str_Len(m_stBfInfo[m_nCursor].HOUSE_CNT) != 0)
				{
					Str_Cat(szAddr,  "-");
					Str_Cat(szAddr,  m_stBfInfo[m_nCursor].HOUSE_CNT);
				}
			}
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), szAddr);
		}
		else
		{
			Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
			
			if(Str_Len(m_stBfInfo[m_nCursor].COUNTY) != 0)
			{
				Str_Cpy(szAddr,  m_stBfInfo[m_nCursor].COUNTY );
			}
			if(Str_Len(m_stBfInfo[m_nCursor].NEW_ROAD_NM) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  m_stBfInfo[m_nCursor].NEW_ROAD_NM );
			}
			if(Str_Len(m_stBfInfo[m_nCursor].NEW_ADDR_M) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  m_stBfInfo[m_nCursor].NEW_ADDR_M);
			}
			if(Str_Len(m_stBfInfo[m_nCursor].NEW_ADDR_S) != 0)
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  m_stBfInfo[m_nCursor].NEW_ADDR_S);
			}
			
			//�⺻�ּ�
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), szAddr);
			
			//���ּ�
			Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
			if( Str_Cmp( m_stBfInfo[m_nCursor].SINGLE_COLIVE_FLAG, "10") == 0 )
			{
				if(Str_Len(m_stBfInfo[m_nCursor].LOT_NUM_SECOND_ADDR) != 0)
				{
					Str_Cpy(szAddr,  m_stBfInfo[m_nCursor].LOT_NUM_SECOND_ADDR);
				}
				if(Str_Len(m_stBfInfo[m_nCursor].BLD_NM) != 0)
				{
					Str_Cat(szAddr,  " ");
					Str_Cat(szAddr,  m_stBfInfo[m_nCursor].BLD_NM);
				}
				if(Str_Len(m_stBfInfo[m_nCursor].HOUSE_CNT) != 0)
				{
					Str_Cat(szAddr,  " ");
					Str_Cat(szAddr,  m_stBfInfo[m_nCursor].HOUSE_CNT);
				}
			}
			else
			{
				if(Str_Len(m_stBfInfo[m_nCursor].CO_LIVE_NM) != 0)
				{
					Str_Cpy(szAddr,  m_stBfInfo[m_nCursor].CO_LIVE_NM);
				}
				if(Str_Len(m_stBfInfo[m_nCursor].BLD_NM) != 0)
				{
					Str_Cat(szAddr,  " ");
					Str_Cat(szAddr,  m_stBfInfo[m_nCursor].BLD_NM);
				}
				if(Str_Len(m_stBfInfo[m_nCursor].HOUSE_CNT) != 0)
				{
					Str_Cat(szAddr,  "-");
					Str_Cat(szAddr,  m_stBfInfo[m_nCursor].HOUSE_CNT);
				}
			}
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), szAddr);
		}
		
		//TEL
		Mem_Set((byte *)szTel, 0x00, sizeof(szTel));
		
		if(Str_Len(m_stBfInfo[m_nCursor].CP_DDD) != 0)
		{
			Str_Cat(szTel,  m_stBfInfo[m_nCursor].CP_DDD);
		}
		
		Str_Cat(szTel,  "-" );
		
		if(Str_Len(m_stBfInfo[m_nCursor].CP_EXN) != 0)
		{
			Str_Cat(szTel,  m_stBfInfo[m_nCursor].CP_EXN);
		}
		
		Str_Cat(szTel,  "-" );
		
		if(Str_Len(m_stBfInfo[m_nCursor].CP_NUM) != 0)
		{
			Str_Cat(szTel,  m_stBfInfo[m_nCursor].CP_NUM);

		}
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), szTel);

		//HP
		Mem_Set((byte *)szTel, 0x00, sizeof(szTel));
		
		if(Str_Len(m_stBfInfo[m_nCursor].OWNHOUSE_TEL_DDD) != 0)
		{
			Str_Cpy(szTel,  m_stBfInfo[m_nCursor].OWNHOUSE_TEL_DDD);
		}
		
		Str_Cat(szTel,  "-" );
		
		if(Str_Len(m_stBfInfo[m_nCursor].OWNHOUSE_TEL_EXN) != 0)
		{
			Str_Cat(szTel,  m_stBfInfo[m_nCursor].OWNHOUSE_TEL_EXN);
		}
		
		Str_Cat(szTel,  "-" );
		
		if(Str_Len(m_stBfInfo[m_nCursor].OWNHOUSE_TEL_NUM) != 0)
		{
			Str_Cat(szTel,  m_stBfInfo[m_nCursor].OWNHOUSE_TEL_NUM);
		}
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), szTel);

		//�跮��
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), m_stBfInfo[m_nCursor].MTR_ID_NUM);
		
		//������ , Decode(CONT_STS_CD,'10','����','20','����','30','����','�ü�')
		if( Str_Cmp( m_stBfInfo[m_nCursor].CONT_STS_CD, "10") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "����");
		}
		else if( Str_Cmp( m_stBfInfo[m_nCursor].CONT_STS_CD, "20") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "����");
		}
		else if( Str_Cmp( m_stBfInfo[m_nCursor].CONT_STS_CD, "30") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "����");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "�ü�");
		}
		
		//��
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), m_stBfInfo[m_nCursor].MTR_MODEL_CD);
		
		//���
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), m_stBfInfo[m_nCursor].MTR_GRD);
		
		//����
		if( Str_Len(g_szINS_JOIN) > 0 )
		{
			Str_Cpy(m_stBfInfo[m_nCursor].INS_JOIN_YN, g_szINS_JOIN);
		}
		i = SearchCD( m_stBfInfo[m_nCursor].INS_JOIN_YN, INS_JOIN );
		if (i == -1)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), INS_JOIN[0].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), INS_JOIN[i].Str);
		}

		//����
		if( Str_Len(g_szINS_EXPLA) > 0 )
		{
			Str_Cpy(m_stBfInfo[m_nCursor].INS_EXPLA_YN, g_szINS_EXPLA);
		}
		i = SearchCD( m_stBfInfo[m_nCursor].INS_EXPLA_YN, INS_EXPLA );
		if (i == -1)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), INS_EXPLA[0].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), INS_EXPLA[i].Str);
		}

		if( m_stBfInfo[m_nCursor].SEND_FLAG[0] == 'N' || m_stBfInfo[m_nCursor].SEND_FLAG[0] == '' )
		{
	    	ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SIGN), BTNCTRLBKCOLOR);
	    	ButCtrl_SetText(Get_hDlgCtrlByID(BID_SIGN), "����");
		}
		else
		{
	    	ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SIGN), SANDYBROWN);
	    	ButCtrl_SetText(Get_hDlgCtrlByID(BID_SIGN), "�Ϸ�");
		}
		
		ON_DRAW();
		return;
	}
	
//---------------------------------------------------------------------------------------------------------
	void CHG_DRAW(void)
	{
		char szSql[300];
		char sztmp[50];
		char szTel[20];
		long i;
	
		//���ұ��ȣ
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA31), stBfBoil.BURNER_NUM);
		//����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM = '%s'  ",stBfBoil.BURNER_KIND_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA3)   , sztmp);
		//�𵨸�
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), stBfBoil.BURNER_MODEL_NM);
		//�뷮
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), stBfBoil.BURNER_CAPA);
		//����
		i = SearchCD( stBfBoil.BURNER_CAPA_UNIT, SCBOIL_CAPA );
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), SCBOIL_CAPA[i].Str);
		//�������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NUM = '%s' ORDER BY MAKER_NM   ",stBfBoil.MAKER_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA5)   , sztmp);
		//��ġ����
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Str_DateType( sztmp, stBfBoil.BURNER_INST_YMD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA37), sztmp);
		//��ġ��ġ
		i = SearchCD( stBfBoil.INST_LOC, BOIL_LOC );
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6), BOIL_LOC[i].Str);
		//����
		i = SearchCD( stBfBoil.BOILER_FORM, SCBOIL_FORM );
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), SCBOIL_FORM[i].Str);
		//������ȣ
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), stBfBoil.MAKE_NUM);
		
		//��ġ��ü , 
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT WORK_FIRM FROM BO_INST WHERE BOILER_INST_FIRM_CD = '%s' ", stBfBoil.BOILER_INST_FIRM_CD, 0, 0 );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA8)   , sztmp);
		//��ǥ�ڸ�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT REPRE_NM FROM BO_INST WHERE BOILER_INST_FIRM_CD = '%s' ", stBfBoil.BOILER_INST_FIRM_CD, 0, 0 );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA43)   , sztmp);
		//����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT REG_NUM1 FROM BO_INST WHERE BOILER_INST_FIRM_CD = '%s' ", stBfBoil.BOILER_INST_FIRM_CD, 0, 0 );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA45)   , sztmp);
		//��ȭ��ȣ1
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT WORK_FIRM_TEL_DDD FROM BO_INST WHERE BOILER_INST_FIRM_CD = '%s' ", stBfBoil.BOILER_INST_FIRM_CD, 0, 0 );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA47)   , sztmp);
		//��ȭ��ȣ2
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT WORK_FIRM_TEL_EXN FROM BO_INST WHERE BOILER_INST_FIRM_CD = '%s' ", stBfBoil.BOILER_INST_FIRM_CD, 0, 0 );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA49)   , sztmp);
		EditCtrl_ModifyStyle( Get_hDlgCtrlByID(TXT_DATA49), 0, EDITSTY_HIDDEN);
		//��ȭ��ȣ3
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT WORK_FIRM_TEL_NUM FROM BO_INST WHERE BOILER_INST_FIRM_CD = '%s' ", stBfBoil.BOILER_INST_FIRM_CD, 0, 0 );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA51)   , sztmp);

		return;
	}
	
//------------------------------------------------------------------
	void INST_DRAW(void)
	{
		long i, idx;
		char szWork_Firm[300];
		char sztmp[300];
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szWork_Firm, 0x00, sizeof(szWork_Firm));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));

		Str_Cpy(szWork_Firm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)));
		
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		//BURNER_KIND_NUM = 201 || 301 �̸� ���Ϸ�, �������� ���ұ�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT REPRE_NM, REG_NUM1, WORK_FIRM_TEL_DDD, WORK_FIRM_TEL_EXN, WORK_FIRM_TEL_NUM \
		FROM BO_INST WHERE WORK_FIRM = ? ORDER BY BOILER_INST_FIRM_CD "
		, 0, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&szWork_Firm, 20, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{
			idx = 0;
			//��ǥ�ڸ�
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 30+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA43)   , sztmp);
			//�����ȣ
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 15+ 1, DECRYPT );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA45)   , sztmp);
			//��ȭ_1
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 4+ 1, DECRYPT );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA47)   , sztmp);
			//��ȭ_2
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 4+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA49)   , sztmp);
			//��ȭ_1
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 4 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA51)   , sztmp);
		}
	
Finally:
		sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
//------------------------------------------------------------------	
	bool Save_Result(void)
	{
		char szSql[500];
		char szToday[20];
		char szTime[7];
		char* pRst;
		long idx, i;
		long lCount;
		long lsign;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( !Check() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		//����
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��" );
		if( lsign <= 0 )
		{
			ret = FALSE;
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
			lsign = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
			//fd= FFS_Open ( "BASE64_Encode.txt", FS_WRITE_MODE , FS_CREATE_FLAG );
			//FFS_Write(fd, (byte*)pRst, Str_Len(pRst) );
			//FFS_Close(fd);
		}

		if( Str_Cmp( stBf.SINGLE_COLIVE_FLAG, "20") == 0 )
		{
			ret = FALSE;
			goto Finally;
		}

		//����
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), INS_JOIN );
		if (i == -1)
		{
			Str_Cpy(stBf.INS_JOIN_YN, "");
		}
		else
		{
			Str_Cpy(stBf.INS_JOIN_YN, INS_JOIN[i].Code);
		}
		
		//����
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), INS_EXPLA );
		if (i == -1)
		{
			Str_Cpy(stBf.INS_EXPLA_YN, "");
		}
		else
		{
			Str_Cpy(stBf.INS_EXPLA_YN, INS_EXPLA[i].Code);
		}
		
		//��ħ
		if( Str_Cmp( stBf.COMPENS_OBJ_YN, "Y") == 0 )
		{
			Str_Cpy(stBf.INDI_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
			Str_Cpy(stBf.INDI_VA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VA)));
			Str_Cpy(stBf.MTR_INDI, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VM)));
		}
		else
		{
			Str_Cpy(stBf.INDI_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
			Mem_Set( (byte*)stBf.INDI_VA, 0x00, sizeof(stBf.INDI_VA) );
			Mem_Set( (byte*)stBf.MTR_INDI, 0x00, sizeof(stBf.MTR_INDI) );
		}


		//������
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		Str_ItoA(Time_GetDate(), szToday, 10);
		Str_Cpy(stBf.CHK_YMD, szToday);
		
		//��������ð�
		g_Str_TimeType( stBf.CHK_TIME_TO , Time_GetTime());
		
		//INDI_DTM 
		Str_Cat(szToday, stBf.CHK_TIME_TO);
		Str_Cpy(stBf.INDI_DTM, szToday);

		//���
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_BO_DATA WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' AND CHK_RSLT = 'N' "
						, g_szCREATE_YMD, g_szMTR_NUM, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			Str_Cpy(stBf.CHK_RSLT, "21");
		}
		else
		{
			Str_Cpy(stBf.CHK_RSLT, "20");
		}

		//�������� ������ ��� �����մ�� ����
		if( Str_Cmp(stBf.CHK_RSLT, "21") == 0 )
		{
			if( !New_Nogood() )
			{
				ret = FALSE;
				goto Finally;
			}
		}


		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE BEFO_DATA SET \
						INS_JOIN_YN = ?, INS_EXPLA_YN = ?, CHK_YMD = ?, CHK_TIME_FROM = ?, CHK_TIME_TO = ? \
						, CHK_EMPID = ?, CRT_EMPID = ?, CRT_IP = ?, CHK_RSLT = ?, SIGN = ?, INDI_DTM = ? \
						, MTR_INDI = ?, INDI_VA = ?, INDI_VC = ?, SEND_FLAG = 'S' \
						WHERE CREATE_YMD = ? AND MTR_NUM = ? "
					, 0, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBf.INS_JOIN_YN		    ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBf.INS_EXPLA_YN	    ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBf.CHK_YMD			    ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBf.CHK_TIME_FROM	    ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBf.CHK_TIME_TO		    ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      ,32 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBf.CHK_RSLT		    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)pRst			 ,Str_Len(pRst) ,DECRYPT);	//����
		sql->Bind(sql, idx++, 'U', (long *)stBf.INDI_DTM		    ,14 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBf.MTR_INDI		    ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBf.INDI_VA		        ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBf.INDI_VC		        ,9  ,DECRYPT);

		sql->Bind(sql, idx++, 'U', (long *)g_szCREATE_YMD		    ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szMTR_NUM		        ,9  ,DECRYPT);


		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		//else
		//{
		//	MessageBoxEx (CONFIRM_OK, "������ �Ϸ�Ǿ����ϴ�.");
		//}
		
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

//------------------------------------------------------------------
	bool Check(void)
	{
		bool ret = TRUE;
		char szSql[300];
		long lCnt = 0;
	
		if( Str_Cmp( stBf.SEND_FLAG, "Y") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�̹� �۽ſϷ��� �ڷ� �Դϴ�.");
			ret = FALSE;
			return ret;
		}
		
		if( Str_Cmp( stBf.COMPENS_OBJ_YN, "Y") == 0 )
		{
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VM))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ħ�� Ȯ���� �ּ���.");
				ret = FALSE;
				return ret;
			}
			else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VA))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ħ�� Ȯ���� �ּ���.");
				ret = FALSE;
				return ret;
			}
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "��ħ�� Ȯ���� �ּ���.");
			ret = FALSE;
			return ret;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM BEFO_BO_DATA WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' AND (CHK_RSLT IS NULL OR CHK_RSLT = '') "
		,g_szCREATE_YMD, g_szMTR_NUM, 0   );
		g_Sql_RetInt( szSql, &lCnt );
		if( lCnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���Ϸ� ������ �Ϸ� ���� �ʾҽ��ϴ�.");
			ret = FALSE;
			return ret;
		}
	
		return ret;
	}

//------------------------------------------------------------------
	bool Save_BoilChg(void)
	{
		char sztmp[300];
		char szSql[300];
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}	
		
		//����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)stBfBoil.BURNER_KIND_NM, 0x00, sizeof(stBfBoil.BURNER_KIND_NM) );
		Str_Cpy(stBfBoil.BURNER_KIND_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)));
		//������ȣ
		SPRINT(szSql, "SELECT BURNER_KIND_NUM FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stBfBoil.BURNER_KIND_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBfBoil.BURNER_KIND_NUM );

		SPRINT(szSql, "SELECT BURNER_CLASS_CD FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stBfBoil.BURNER_KIND_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBfBoil.BURNER_CLASS_CD );

		//�𵨸�
		Str_Cpy(stBfBoil.BURNER_MODEL_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		
		//�뷮
		Str_Cpy(stBfBoil.BURNER_CAPA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) );
		//����
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)), SCBOIL_CAPA );
		if (i == -1)
		{
			Str_Cpy(stBfBoil.BURNER_CAPA_UNIT, "");
			Str_Cpy(stBfBoil.BURNER_CAPA_UNIT_NM, "");
		}
		else
		{
			Str_Cpy(stBfBoil.BURNER_CAPA_UNIT, SCBOIL_CAPA[i].Code);
			Str_Cpy(stBfBoil.BURNER_CAPA_UNIT_NM, SCBOIL_CAPA[i].Str);
		}
		
		//������� 
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(stBfBoil.MAKER_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5)));
		SPRINT(szSql, "SELECT MAKER_NUM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NM = '%s' ", stBfBoil.MAKER_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBfBoil.MAKER_NUM );
		
		//��ġ����
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA37)) );
		Str_Chg( sztmp, STRCHG_DEL_NONDIGIT);
		Str_Cpy(stBfBoil.BURNER_INST_YMD, sztmp );
		
		//���Ϸ� ��ġ��ġ
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)stBfBoil.INST_LOC, 0x00, sizeof(stBfBoil.INST_LOC) );
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6)), BOIL_LOC );
		if (i == -1)
		{
			Str_Cpy(stBfBoil.INST_LOC, "");
		}
		else
		{
			Str_Cpy(stBfBoil.INST_LOC, BOIL_LOC[i].Code);
		}
		
		//����
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7)), SCBOIL_FORM );
		if (i == -1)
		{
			Str_Cpy(stBfBoil.BOILER_FORM, "");
			Str_Cpy(stBfBoil.BOILER_FORM_NM, "");
		}
		else
		{
			Str_Cpy(stBfBoil.BOILER_FORM, SCBOIL_FORM[i].Code);
			Str_Cpy(stBfBoil.BOILER_FORM_NM, SCBOIL_FORM[i].Str);
		}
		
		//������ȣ
		Str_Cpy(stBfBoil.MAKE_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
		
		//��ġ��ü
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)stBfBoil.BOILER_INST_FIRM_CD, 0x00, sizeof(stBfBoil.BOILER_INST_FIRM_CD) );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)));
		SPRINT(szSql, "SELECT BOILER_INST_FIRM_CD FROM BO_INST  where WORK_FIRM = '%s' ", sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 20, stBfBoil.BOILER_INST_FIRM_CD );
	
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
				"UPDATE BEFO_BO_DATA SET \
				BURNER_MODEL_NM = ?, BURNER_CAPA = ?, BURNER_CAPA_UNIT = ?,  BURNER_INST_YMD = ?,  MAKER_NUM = ? \
				, MAKER_NM = ?, BOILER_FORM = ?, BOILER_INST_FIRM_CD = ?, INST_LOC = ?, BURNER_CLASS_CD = ? \
				, BURNER_CLASS_NM = ?, BURNER_KIND_NM = ?, BURNER_KIND_NUM = ?, BOILER_FORM_NM = ?, BURNER_CAPA_UNIT_NM = ? \
				, CRT_EMPID = ?, CRT_IP = ?, CHG_FLAG = '20', SEND_FLAG = 'S' \
				WHERE CREATE_YMD = ? AND MTR_NUM = ? AND BURNER_NUM = ? " 

		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_MODEL_NM      	,50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_CAPA         	,10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_CAPA_UNIT        ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_INST_YMD      	,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.MAKER_NUM 		        ,5 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.MAKER_NM 		        ,60,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BOILER_FORM 		    ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BOILER_INST_FIRM_CD 	,6,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.INST_LOC 		        ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_CLASS_CD     	,2,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_CLASS_NM		    ,30 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_KIND_NM          ,30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_KIND_NUM			,3 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BOILER_FORM_NM		    ,30 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_CAPA_UNIT_NM		,30 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id			,9,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip			    ,32 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCREATE_YMD			        ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szMTR_NUM			            ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szBURNER_NUM			        ,6 ,DECRYPT);		
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "�����Ǿ����ϴ�!");
		}
		
Finally:
		sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//------------------------------------------------------------------------------------------
	bool Validate(void)
	{
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ұ� ������ ������ �ּ���.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ұ� �����縦 ������ �ּ���.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ұ� ������ ������ �ּ���.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�뷮�� �Է��� �ּ���.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "��ġ��ġ�� �Է��� �ּ���.");
			return FALSE;
		}
		return TRUE;
	}
	
//------------------------------------------------------------------------------------------
	void Del_Boil(void)
	{
		char szSql[300];
		long idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Str_ItoA(Time_GetDate(), stBfBoil.BURNER_REMOV_YMD, 10);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE BEFO_BO_DATA SET \
					BURNER_REMOV_YMD = ?, CHG_FLAG = '30', SEND_FLAG = 'S', CRT_EMPID = ?, CRT_IP = ? \
					WHERE CREATE_YMD = ? AND MTR_NUM = ? AND BURNER_NUM = ? "
					, 0, 0, 0);

		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBfBoil.BURNER_REMOV_YMD	,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id      ,9,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip     		,32,DECRYPT);

		sql->Bind(sql, idx++, 'U', (long *)g_szCREATE_YMD			    ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szMTR_NUM			        ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szBURNER_NUM			    ,6 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���� �Ǿ����ϴ�.");
		}
		
Finally:
		sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
	
//-----------------------------------------------------------------		
//������ ���� ����� NORMAL_NOGOOD ���̺� ������ �߰�.
	bool New_Nogood(void)
	{
		char sztmp[300];
		char szSql[300];
		long idx, i;
		long lCount;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM BEFO_NOGOOD_MAIN WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' "
						, g_szCREATE_YMD, g_szMTR_NUM, 0);
		g_Sql_RetInt(szSql, &lCount);
		//���� ������ ����� �����ϰ��ִٸ�, ����� �ٽ� �Է�
		if( lCount > 0 )
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM BEFO_NOGOOD_MAIN WHERE CREATE_YMD = '%s' AND MTR_NUM = '%s' "
			, g_szCREATE_YMD, g_szMTR_NUM, 0);
			g_Sql_DirectExecute( szSql );
		}

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
/*
		if( lCount > 0 )
		{
			hstmt = sql->CreateStatement(sql,
			" UPDATE BEFO_NOGOOD_MAIN SET \
			  CREATE_YMD = ?, MTR_NUM = ?, BLD_NUM = ?, INST_PLACE_NUM = ?, SINGLE_COLIVE_FLAG = ?, CENTER_CD = ? \
			, ZONE_MANAGE_NUM = ?, ZIP_NO1 = ?, ZIP_NO2 = ?, CITY = ?, AREA = ?, TOWN = ?, VILLAGE = ?, ADDR1_ = ? \
			, ADDR1_S = ?, LOT_NUM_SECOND_ADDR = ?, CO_LIVE_NM = ?, HOUSE_CNT = ?, BLD_NM = ?, DETA_FLOOR = ? \
			, COMPX_FLAG_NM = ?, CUST_NUM = ?, CUST_TYPE_CD = ?, CUST_NM = ?, FIRM_NM = ?, BIZ_REGI_NUM = ? \
			, SOC_NUM = ?, REPRE_NM = ?, CP_DDD = ?, CP_EXN = ?, CP_NUM = ?, OWNHOUSE_TEL_DDD = ? \
			, OWNHOUSE_TEL_EXN = ?, OWNHOUSE_TEL_NUM = ?, END_YN = ?, CRT_EMPID = ?, CRT_IP = ?, SEND_YN = ? \
			, LAW_TOWN = ?, NEW_ROAD_NM = ?, NEW_ADDR_M = ?, NEW_ADDR_S = ? \
			  WHERE CREATE_NUM = ? AND MTR_NUM = ? "
				);
		}
		else
		{
*/
		hstmt = sql->CreateStatement(sql,
		"INSERT INTO BEFO_NOGOOD_MAIN \
		( CREATE_YMD , MTR_NUM , BLD_NUM , INST_PLACE_NUM , SINGLE_COLIVE_FLAG \
		, CENTER_CD , ZONE_MANAGE_NUM , ZIP_NO1 , ZIP_NO2 , CITY , AREA , TOWN , VILLAGE \
		, ADDR1_M , ADDR1_S , LOT_NUM_SECOND_ADDR , CO_LIVE_NM , HOUSE_CNT , BLD_NM \
		, DETA_FLOOR , COMPX_FLAG_NM , CUST_NUM , CUST_TYPE_CD , CUST_NM , FIRM_NM \
		, BIZ_REGI_NUM , SOC_NUM , REPRE_NM , CP_DDD , CP_EXN , CP_NUM , OWNHOUSE_TEL_DDD \
		, OWNHOUSE_TEL_EXN , OWNHOUSE_TEL_NUM , END_YN , CRT_EMPID , CRT_IP , SEND_YN \
		, LAW_TOWN , NEW_ROAD_NM , NEW_ADDR_M , NEW_ADDR_S ) \
		VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, '' \
			   , '', ?, ?, ?, ?, ?, ?, ?, ?, ? \
			   , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
			   , ?, ?, ?, ?, 'N', ?, ?, 'S', ?, ? \
			   , ?, ? ) "
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stBf.CREATE_YMD         ,  8,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.MTR_NUM            ,  9,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.BLD_NUM            ,  9,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.INST_PLACE_NUM     ,  9,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.SINGLE_COLIVE_FLAG ,  2,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.CENTER_CD          ,  2,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.ZONE_MANAGE_NUM    ,  5,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.ZIP_NO1            ,  3,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.ZIP_NO2            ,  3,DECRYPT);
//		sql->Bind(sql, idx++, 'U', (long*)stBf.CITY               , 30,DECRYPT);
//		sql->Bind(sql, idx++, 'U', (long*)stBf.AREA               , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.TOWN               , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.VILLAGE            , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.ADDR1_M            , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.ADDR1_S            , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.LOT_NUM_SECOND_ADDR,100,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.CO_LIVE_NM         , 60,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.HOUSE_CNT          ,  6,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.BLD_NM             ,150,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.DETA_FLOOR         ,  6,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.COMPX_FLAG_NM      , 60,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.CUST_NUM           , 10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.CUST_TYPE_CD       ,  2,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.CUST_NM            , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.FIRM_NM            , 50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.BIZ_REGI_NUM       , 10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.SOC_NUM            , 13,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.REPRE_NM           , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.CP_DDD             ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.CP_EXN             ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.CP_NUM             ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.OWNHOUSE_TEL_DDD   ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.OWNHOUSE_TEL_EXN   ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.OWNHOUSE_TEL_NUM   ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id,  9,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip     , 32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.LAW_TOWN           , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.NEW_ROAD_NM        ,100,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.NEW_ADDR_M         , 10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBf.NEW_ADDR_S         , 10,DECRYPT);
	
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	
//======================================================================================================
//�ٸ� ���� ȭ��, �˾�â�� ���ǵ� ���� ȭ������ ���ƿ��� �Էµ��ִ� ���� �ٽ� ���ü��ֵ��� �ϱ�����.
	void SaveInput(void)
	{
		Mem_Set((byte *)g_szIndi_Vm, 0x00, sizeof(g_szIndi_Vm));
		Mem_Set((byte *)g_szIndi_Va, 0x00, sizeof(g_szIndi_Va));
		Mem_Set((byte *)g_szIndi_Vc, 0x00, sizeof(g_szIndi_Vc));

		g_lDataflag = 1;
		
		if( Str_Cmp( stBf.COMPENS_OBJ_YN, "Y") == 0 )
		{
			Str_Cpy(g_szIndi_Vc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
			Str_Cpy(g_szIndi_Vm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VM)));
			Str_Cpy(g_szIndi_Va, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VA)));
		}
		else
		{
			Str_Cpy(g_szIndi_Vc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
		}
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
		char sztmp[101];

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '6' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(sztmp);
	}
	
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetComboIdx(void)
	{
		long i, idx;
		long lRow;
		long lActIndex;
		char sztmp[201];
		char szSql[301];	

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM BEFO_DATA WHERE SINGLE_COLIVE_FLAG = '10' ORDER BY COUNTY,TOWN,ADDR1_M,ADDR1_S ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, SREACH_FILE);
		
		Str_Cpy(g_szROWID, stBf.ROWID);
		lRow = Str_AtoI(g_szROWID);
		lActIndex = g_Get_FsIndex(lRow, SREACH_FILE);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '6' ", lActIndex, 0, 0);		
		g_Sql_DirectExecute(szSql);

		return;
	}
	
//------------------------------------------------------------------	
//�ش� ���� ���� flag �ʱ�ȭ
	void Clear_Flag(void)
	{
		m_lLstCnt = 0;
		m_lSelIndex = 0;
		m_lIdxFlag = 0;
	}
}


