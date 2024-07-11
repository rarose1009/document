/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_JOJUNGCHK
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQl.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_JUNSOO )	//����
		DEF_BUTTON_ID ( BID_ADDR )		//�����ּ�
		DEF_BUTTON_ID ( BID_MODELNM )	//�𵨸�
		DEF_BUTTON_ID ( BID_PREVPG )	//��
		DEF_BUTTON_ID ( BID_NEXTPG )	//��
		DEF_BUTTON_ID ( BID_SCOUT )		//���� ����	
		DEF_BUTTON_ID ( BID_SC )		//���˽���
		DEF_BUTTON_ID ( BID_MEMO )		//�޸�
//�跮�⸮��Ʈ(����)
		DEF_BUTTON_ID ( BID_OK )		//Ȯ��
		DEF_BUTTON_ID ( BID_ADD )		//�߰�
		DEF_BUTTON_ID ( BID_DEL )		//����
		DEF_BUTTON_ID ( BID_PREVLST )
		DEF_BUTTON_ID ( BID_NEXTLST )
//��������
		DEF_BUTTON_ID ( BID_CANCEL )
		DEF_BUTTON_ID ( BID_OK2 )
//��������������
		DEF_BUTTON_ID ( BID_SAVE )
		DEF_BUTTON_ID ( BID_CLOSE )
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
		DEF_OBJECT_ID ( TXT_WORKTYPE )		//�۾�����
		DEF_OBJECT_ID ( TXT_FORM )			//����
		DEF_OBJECT_ID ( TXT_COMPANY )		//���ۻ�
		DEF_OBJECT_ID ( TXT_FIRSTPRESS )	//1���з�
		DEF_OBJECT_ID ( TXT_TYPE)			//Ÿ��
		DEF_OBJECT_ID ( TXT_INSPLACE )		//��ġ/��ġ
		DEF_OBJECT_ID ( TXT_JJGSN )			//������S/N
		DEF_OBJECT_ID ( TXT_FILTERDT )		//���ͱ�ü��
		DEF_OBJECT_ID ( TXT_JUNBAN )		//���ݱ�
		DEF_OBJECT_ID ( TXT_HABAN )			//�Ϲݱ�
		DEF_OBJECT_ID ( TXT_PAGE )
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
//�跮�⸮��Ʈ
		DEF_OBJECT_ID ( TXT_PAGELST )
		DEF_OBJECT_ID ( TXT_DATA23 )
		DEF_OBJECT_ID ( TXT_DATA24 )
		DEF_OBJECT_ID ( EDT_DATA2 )
//��������
		DEF_OBJECT_ID ( TXT_DATA25 )
//��������������
		DEF_OBJECT_ID ( TXT_DATA26 )
		DEF_OBJECT_ID ( TXT_DATA27 )
		DEF_OBJECT_ID ( TXT_DATA28 )
		DEF_OBJECT_ID ( TXT_DATA29 )
		DEF_OBJECT_ID ( TXT_DATA30 )
		DEF_OBJECT_ID ( EDT_DATA1 )
		
		DEF_OBJECT_ID ( ID_TBLLIST )		//����(�跮�⸮��Ʈ)
		DEF_OBJECT_ID ( ID_TBLLIST_E )		//��������
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
//��������
		DEF_OBJECT_ID ( CMB_DATA1 )
//��������������
		DEF_OBJECT_ID ( CMB_DATA2=CMB_DATA1+3 )
		DEF_OBJECT_ID ( CMB_DATA3=CMB_DATA2+3 )
		DEF_OBJECT_ID ( CMB_DATA4=CMB_DATA3+3 )
		DEF_OBJECT_ID ( CMB_DATA5=CMB_DATA4+3 )
	END_OBJECT_ID()

	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� ����� , ����(�跮�⸮��Ʈ)
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    10				// table�� �ళ��
	#define		COL 	    3				// table�� ������
	#define		GRID_H		(CHT+25)			// table �� ����
	#define		GRID_H_P	(CHT+28)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   	// table Ŭ���� color
	#define		GRID_X		STARTX 			// table ����x��ǥ
	#define		MAXCHAR		51 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+111  	// table ����y��ǥ
	#define		GRID_Y_P	STARTY+110      // table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�⹰��ȣ",	CWD*21, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"��ġ��ġ",	CWD*12, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",		CWD*6+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};
	
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� ����� , ��������
	//-------------------------------------------------------------------------------------------------
	#define		ROW_E	    7					// table�� �ళ��
	#define		COL_E	    1					// table�� ������
	#define		GRID_H_E	(CHT+40)			// table �� ����
	#define		GRID_H_E_P	(CHT+50)			// table �� ���� PDA
	//#define		GRID_CLR	TRANSPARENT   	// table Ŭ���� color , ����ǥ�� ���� ��
	#define		GRID_X_E	STARTX 				// table ����x��ǥ
	//#define		MAXCHAR		51 			    // table�� ���� �ִ� �ִ�  char ���� , ����ǥ�� ���� ��
	#define		GRID_Y_E	STARTY-29	  	    // table ����y��ǥ
	#define		GRID_Y_E_P	STARTY-40           // table ����y��ǥ PDA
	#define		GRID_ENDY_E (GRID_Y_E+(ROW_E+1)*GRID_H_E) //table������ row�� Y��
	
	char	m_szTableBuf_E [COL_E*(ROW_E+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle_E[] = {
		{"�������� �����Է�",	CWD*39+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};
	
	
	#define INIT_MAIN	 1
	#define INIT_MTRLST  2
	#define INIT_SCOUT   3
	#define INIT_INFOCHG 4
	
	char m_szCnt_index[11];     //�ε��� ���ڿ�(���� ������)
	char m_szPopCnt_index[11];  //�ε��� ���ڿ�(���� ������)
	long m_bFirst = 0;
	long m_ltotcnt;
	long m_Popltotcnt;
	long m_lPrev = 0;
	long m_lPopPrev = 0;
	long m_lpage = 0;
	long m_lSelIndex = -1;
	long m_lActiveIndex = -1;
	char m_CmdStr[51];
	char m_szScOut[20];
	
	void SetStyle(void);
	void SetData(void);
	void SetData_Nogood(void);
	void SetData_MTR(void);
	void REDRAW(void);			//ȭ�鿡 �ڷ� ���÷����Ѵ�.
	void SCOUT_DRAW(void);  	//�������� ���÷���
	void INFOCHG_DRAW(void);	//��������
	bool Save_ScOut(void);
	bool Save_InfoChg(void);	//������ ���� ����
	void Add_Mtr(void);			//�跮���߰�
	void Del_Mtr(void);			//�跮�����
	void PrevPG(void);			//����������� �ε��� ã��
	void NextPG(void);			//����������� �ε��� ã��
	long FS_GetSrchTotCnt(void);
	long SearchCD(char *CD, CodeTable *CT);		//�ڵ� ���� ã�´�.
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	void SetBtnImg(void);
	void Set_Index(void);
	bool Validate(void);
	long SetGlobal(long lindex);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ ��������"),

		DLG_BUTTON(STARTX+625, STARTY+125, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_JUNSOO, "����"),
		DLG_BUTTON(STARTX,     STARTY+185, 300,100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_BUTTON(STARTX,     STARTY+345, 300, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MODELNM, "�𵨸�"),
		DLG_BUTTON(STARTX,     STARTY+825, 150, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+150, STARTY+825, 150, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+300, STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCOUT, "����\n����"),
		DLG_BUTTON(STARTX+550, STARTY+825, 250, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SC, "����\n����"),
		DLG_BUTTON(STARTX+800, STARTY+825, 200, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "�޸�"),
		
		DLG_TEXT(STARTX+625,   STARTY+65, 375, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index), 
		DLG_TEXT(STARTX,      STARTY+125, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGNUM, "�������ȣ"), 
		DLG_TEXT(STARTX+300,  STARTY+125, 325, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+825,  STARTY+125, 175, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 
		DLG_TEXT(STARTX+300,  STARTY+185, 700, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), 
		DLG_TEXT(STARTX,      STARTY+285, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKTYPE, "�۾�����"),
		DLG_TEXT(STARTX+300,  STARTY+285, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""), 
		DLG_TEXT(STARTX+550,  STARTY+285, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "����"),
		DLG_TEXT(STARTX+750,  STARTY+285, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""), 
		DLG_TEXT(STARTX+300,  STARTY+345, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""), 
		DLG_TEXT(STARTX,      STARTY+405, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMPANY, "���ۻ�"),
		DLG_TEXT(STARTX+300,  STARTY+405, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""), 
		DLG_TEXT(STARTX,      STARTY+465, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FIRSTPRESS, "1���з�"),
		DLG_TEXT(STARTX+300,  STARTY+465, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""), 
		DLG_TEXT(STARTX+550,  STARTY+465, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TYPE, "Ÿ��"),
		DLG_TEXT(STARTX+750,  STARTY+465, 250, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""), 
		DLG_TEXT(STARTX,      STARTY+525, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_INSPLACE, "��ġ/��ġ"),
		DLG_TEXT(STARTX+300,  STARTY+525, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+650,  STARTY+525, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX,      STARTY+585, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGSN, "������S/N"),
		DLG_TEXT(STARTX+300,  STARTY+585, 700, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""), 
		DLG_TEXT(STARTX,      STARTY+645, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FILTERDT, "���ͱ�ü��"),
		DLG_TEXT(STARTX+300,  STARTY+645, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""), 
		DLG_TEXT(STARTX+650,  STARTY+645, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""), 
		DLG_TEXT(STARTX,      STARTY+705, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, LIGHTORANGE, TXT_JUNBAN, "���ݱ�"), 
		DLG_TEXT(STARTX+300,  STARTY+705, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""), 
		DLG_TEXT(STARTX+500,  STARTY+705, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""), 
		DLG_TEXT(STARTX+800,  STARTY+705, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""), 
		DLG_TEXT(STARTX,      STARTY+765, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, LIGHTORANGE, TXT_HABAN, "�Ϲݱ�"),
		DLG_TEXT(STARTX+300,  STARTY+765, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""), 
		DLG_TEXT(STARTX+500,  STARTY+765, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""), 
		DLG_TEXT(STARTX+800,  STARTY+765, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""), 
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "������ ��������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+625,  STARTY+25, 200, 65, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_JUNSOO, "����"),
		DLG_BUTTON(STARTX,      STARTY+90, 300, 120, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_BUTTON(STARTX,     STARTY+275, 300, 65, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MODELNM, "�𵨸�"),
		DLG_BUTTON(STARTX,     STARTY+800, 150, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+150, STARTY+800, 150, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+300, STARTY+800, 250, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCOUT, "����\n����"),
		DLG_BUTTON(STARTX+550, STARTY+800, 250, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SC, "����\n����"),
		DLG_BUTTON(STARTX+800, STARTY+800, 200, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "�޸�"),
		
		DLG_TEXT(STARTX+600,   STARTY-40, 400, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index), 
		DLG_TEXT(STARTX,       STARTY+25, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGNUM, "�������ȣ"), 
		DLG_TEXT(STARTX+300,   STARTY+25, 325, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+825,   STARTY+25, 175, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 
		DLG_TEXT(STARTX+300,   STARTY+90, 700, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), 
		DLG_TEXT(STARTX,      STARTY+210, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_WORKTYPE, "�۾�����"),
		DLG_TEXT(STARTX+300,  STARTY+210, 250, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""), 
		DLG_TEXT(STARTX+550,  STARTY+210, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "����"),
		DLG_TEXT(STARTX+750,  STARTY+210, 250, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""), 
		DLG_TEXT(STARTX+300,  STARTY+275, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""), 
		DLG_TEXT(STARTX,      STARTY+340, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMPANY, "���ۻ�"),
		DLG_TEXT(STARTX+300,  STARTY+340, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""), 
		DLG_TEXT(STARTX,      STARTY+405, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FIRSTPRESS, "1���з�"),
		DLG_TEXT(STARTX+300,  STARTY+405, 250, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""), 
		DLG_TEXT(STARTX+550,  STARTY+405, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TYPE, "Ÿ��"),
		DLG_TEXT(STARTX+750,  STARTY+405, 250, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""), 
		DLG_TEXT(STARTX,      STARTY+470, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_INSPLACE, "��ġ/��ġ"),
		DLG_TEXT(STARTX+300,  STARTY+470, 340, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+640,  STARTY+470, 360, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX,      STARTY+535, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_JJGSN, "������S/N"),
		DLG_TEXT(STARTX+300,  STARTY+535, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""), 
		DLG_TEXT(STARTX,      STARTY+600, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FILTERDT, "���ͱ�ü��"),
		DLG_TEXT(STARTX+300,  STARTY+600, 340, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""), 
		DLG_TEXT(STARTX+640,  STARTY+600, 360, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""), 
		DLG_TEXT(STARTX,      STARTY+665, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, LIGHTORANGE, TXT_JUNBAN, "���ݱ�"), 
		DLG_TEXT(STARTX+300,  STARTY+665, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""), 
		DLG_TEXT(STARTX+500,  STARTY+665, 275, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""), 
		DLG_TEXT(STARTX+775,  STARTY+665, 225, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""), 
		DLG_TEXT(STARTX,      STARTY+730, 300, 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, LIGHTORANGE, TXT_HABAN, "�Ϲݱ�"),
		DLG_TEXT(STARTX+300,  STARTY+730, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""), 
		DLG_TEXT(STARTX+500,  STARTY+730, 275, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""), 
		DLG_TEXT(STARTX+775,  STARTY+730, 225, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
	};
	
	//  ���̾�α�:�跮�⸮��Ʈ
	//---------------------------------------------------------------
	DlgObject	DlgRes_MTRLST[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�跮�� ����Ʈ"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),
		
		DLG_BUTTON(STARTX,	     STARTY+41, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST,  "��"),
		DLG_BUTTON(STARTX+250,	 STARTY+41, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST,  "��"),
		DLG_BUTTON(STARTX,		STARTY+830, 333, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADD,  "�߰�"),
		DLG_BUTTON(STARTX+333,	STARTY+830, 333, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL,  "����"),
		DLG_BUTTON(STARTX+666,	STARTY+830, 334, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK,  "Ȯ��"),

		DLG_TEXT ( STARTX,		STARTY-29, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA23, "�⹰��ȣ"),
		DLG_EDIT( STARTX+300,   STARTY-29, 700, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		DLG_TEXT ( STARTX+500,	STARTY+41, 500, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGELST, m_szPopCnt_index),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};
	
	//  ���̾�α�:�跮�⸮��Ʈ
	//---------------------------------------------------------------
	DlgObject	DlgRes_MTRLST_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�跮�� ����Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),
		
		DLG_BUTTON(STARTX,	     STARTY+40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST,  "��"),
		DLG_BUTTON(STARTX+250,	 STARTY+40, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST,  "��"),
		DLG_BUTTON(STARTX,		STARTY+829, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADD,  "�߰�"),
		DLG_BUTTON(STARTX+333,	STARTY+829, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL,  "����"),
		DLG_BUTTON(STARTX+666,	STARTY+829, 334, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK,  "Ȯ��"),

		DLG_TEXT ( STARTX+700,	STARTY+40, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGELST, m_szPopCnt_index),
		DLG_TEXT ( STARTX,		STARTY-40, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA23, "�⹰��ȣ"),
		DLG_EDIT( STARTX+300,   STARTY-40, 700, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 20,  ""),
		
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-20, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};
	
	//  ���̾�α�:��������-�����Է�
	//---------------------------------------------------------------
	DlgObject	DlgRes_SCOUT[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������� �����Է�"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),
/*
		DLG_BUTTON(STARTX,      STARTY+300, 300, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "���"),
		DLG_BUTTON(STARTX+670,  STARTY+300, 300, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2, "Ȯ��"),
		
		DLG_TEXT ( STARTX,	        80, 970, 100, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA25, "���������� ����"),
		DLG_COMBO (STARTX,  STARTY+110, 970, 200, 150, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 4),
*/
		DLG_BUTTON(STARTX,      STARTY+650, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "���"),
		DLG_BUTTON(STARTX+600,  STARTY+650, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2, "Ȯ��"),
		
		//DLG_TEXT ( STARTX,	   STARTY, 970, 70, 0,0, EDITSTY_BORDER, 0, BLACK, TXTINCTRLBK, TXT_DATA55, "���������� ����"),
		//DLG_COMBO (STARTX,  STARTY+80, 970, 200, 200, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SCOUT, 4),
		DLG_TABLE (GRID_X_E, GRID_Y_E, ROW_E, COL_E, 0, GRID_H_E, 1, GRID_H_E, SEL_ROW, MAXCHAR, m_stGridTitle_E, ID_TBLLIST_E, m_szTableBuf_E),
	};
	
	//  ���̾�α�:��������-�����Է�
	//---------------------------------------------------------------
	DlgObject	DlgRes_SCOUT_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������� �����Է�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),

		DLG_BUTTON(STARTX,      STARTY+700, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "���"),
		DLG_BUTTON(STARTX+600,  STARTY+700, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2, "Ȯ��"),
		
		DLG_TABLE (GRID_X_E, GRID_Y_E_P, ROW_E, COL_E, 0, GRID_H_E_P, 1, GRID_H_E_P, SEL_ROW, MAXCHAR, m_stGridTitle_E, ID_TBLLIST_E, m_szTableBuf_E),

	};
	
	//  ���̾�α�:������ ��������
	//---------------------------------------------------------------
	DlgObject	DlgRes_INFOCHG[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ ��������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,      STARTY+400, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "�ݱ�"),
		DLG_BUTTON(STARTX+600,  STARTY+400, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE,  "����"),
		
		DLG_TEXT ( STARTX,	  STARTY-29, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "���ۻ�"),
		DLG_TEXT ( STARTX,	  STARTY+41, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA27, "��"),
		DLG_TEXT ( STARTX,	 STARTY+111, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "Ÿ��"),
		DLG_TEXT ( STARTX,	 STARTY+181, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA29, "������ S/N"),
		DLG_EDIT( STARTX+350,STARTY+181, 650, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 30,  ""),
		DLG_TEXT ( STARTX,	 STARTY+251, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "�ܵ�/����"),
		
		DLG_COMBO (STARTX+350,   STARTY-29, 650, 70, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 20),
		DLG_COMBO (STARTX+350,   STARTY+41, 650, 70, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 20),
		DLG_COMBO (STARTX+350,  STARTY+111, 650, 70, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 20),
		DLG_COMBO (STARTX+350,  STARTY+251, 650, 70, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 20),
	};
	
	//  ���̾�α�:������ ��������
	//---------------------------------------------------------------
	DlgObject	DlgRes_INFOCHG_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ ��������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,      STARTY+400, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "�ݱ�"),
		DLG_BUTTON(STARTX+600,  STARTY+400, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE,  "����"),
		
		DLG_TEXT ( STARTX,	 STARTY-40, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "���ۻ�"),
		DLG_TEXT ( STARTX,	 STARTY+40, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA27, "��"),
		DLG_TEXT ( STARTX,	STARTY+120, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "Ÿ��"),
		DLG_TEXT ( STARTX,	STARTY+200, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA29, "������ S/N"),
		DLG_EDIT( STARTX+350,STARTY+200, 650, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 15,  ""),
		DLG_TEXT ( STARTX,	STARTY+280, 350, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "�ܵ�/����"),		
		
		DLG_COMBO (STARTX+350,   STARTY-40, 650, 80, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 20),
		DLG_COMBO (STARTX+350,   STARTY+40, 650, 80, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 20),
		DLG_COMBO (STARTX+350,  STARTY+120, 650, 80, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 20),
		DLG_COMBO (STARTX+350,  STARTY+280, 650, 80, 150, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 20),
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
				SetStyle();
				SetData();
				SetData_Nogood();
				REDRAW();
				break;
			case INIT_MTRLST:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_MTRLST_P, SIZEOF(DlgRes_MTRLST_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_MTRLST, SIZEOF(DlgRes_MTRLST));
						break;		
				}

				SetBtnImg();
				SetStyle();
				SetData_MTR();
				break;
			case INIT_SCOUT:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_SCOUT_P, SIZEOF(DlgRes_SCOUT_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_SCOUT, SIZEOF(DlgRes_SCOUT));
						break;		
				}

				SetBtnImg();
				SetStyle();
				SCOUT_DRAW();
				break;
			case INIT_INFOCHG:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_INFOCHG_P, SIZEOF(DlgRes_INFOCHG_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_INFOCHG, SIZEOF(DlgRes_INFOCHG));
						break;		
				}

				SetBtnImg();
				SetStyle();
				INFOCHG_DRAW();
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
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}
	
//-----------------------------------------------------------------
	void SetStyle(void)
	{
	long i;
	char szSql[300];
	
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JJGNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_WORKTYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FORM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_COMPANY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FIRSTPRESS), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INSPLACE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JJGSN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FILTERDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_JUNBAN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HABAN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA4), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_MTRLST )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGELST), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_SCOUT )
		{
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_INFOCHG )
		{
			//���ۻ�
			g_Sql_SetCombo("SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '30' ", CMB_DATA2+2);
			//�𵨸�
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT REGTR_MODEL_NM FROM REGTR_MODEL WHERE MAKER_FLAG ='30' AND MAKER_NUM='%s' ",stScJjChk.MAKER_NUM, 0, 0   );
			g_Sql_SetCombo(szSql, CMB_DATA3+2);
			//Ÿ��
			for ( i = 0 ;  SCJJTYPE[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA4+2), SCJJTYPE[i].Str, 0, ICON_NONE);
			}
			
			for ( i = 0 ;  SINGLECOLIVECD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA5+2), SINGLECOLIVECD[i].Str, 0, ICON_NONE);
			}
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5+1), TRUE );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		}
	}
	
//-----------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{					
			case BID_JUNSOO:
				if( Str_Cmp(stScJjChk.CHK_END_YN, "Y") == 0  )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
					break;
				}
				m_lSelIndex = 0;
				ON_EXIT();
				OnInit(INIT_MTRLST);
				break;
			case BID_ADDR:
				//g_nAddrFlag = 0 -> ���ּ�    g_nAddrFlag = 1 -> ���ּ�
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
			case BID_MODELNM:
				if( Str_Cmp(stScJjChk.CHK_END_YN, "Y") == 0  )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
				}
				else
				{
					ON_EXIT()
					OnInit(INIT_INFOCHG);
				}
				break;
			case BID_PREVPG:
				PrevPG();
				break;
			case BID_NEXTPG:
				NextPG();
				break;
			case BID_SCOUT:
				if( Str_Cmp(stScJjChk.CHK_END_YN, "Y") == 0  )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
					break;
				}
				
				if( Str_Cmp(stScJjChk.CHK_END_YN, "S") == 0  )
				{
					MessageBoxEx (CONFIRM_OK, "���˿Ϸ��� ����� �������� �Ҽ� �����ϴ�.");
					break;
				}
				m_lSelIndex = 0;
				ON_EXIT();
				OnInit(INIT_SCOUT);
				break;
			case BID_SC:
				if( Str_Cmp(stScJjChk.CHK_END_YN, "Y") == 0  )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
					break;
				}
				else if( Str_Len(stScJjChk.CHK_EXCEP_WHY) > 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�������� �� ����Դϴ�.");
					break;
				}
				
				Str_ItoA(  Time_GetDate(), stScJjChk.CHK_STR_DTM, 10 );
				g_Str_TimeType( stScJjChk.CHK_STR_DTM+8 , Time_GetTime() );
				
				if( Str_Cmp(stScJjChk.SINGLE_COLIVE_FLAG, "10") == 0 )
				{
					Card_Move("SC_JOJUNGCHKSL");
				}
				else
				{
					if( Str_Cmp(stScJjChk.CHK_END_YN, "S") != 0 )
					{
						Str_Cpy(stScJjChk.REG1_RSLT, "");
						Str_Cpy(stScJjChk.REG2_RSLT, "");
						Str_Cpy(stScJjChk.REG3_RSLT, "");
					}
					Card_Move("SC_JOJUNGCHKTGT");
				}
				break;
			case BID_MEMO:
				g_nMemoFlag = 3;
				Card_Move("CM_MEMO");
				break;	
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_lDataflag = 0;
					g_lMoveFlag = 0;
					Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
					if( g_nWorkFlag == 101 )
						g_nWorkFlag = 100;
					Card_Move("MENU");	
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "���������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					g_lDataflag = 0;
					g_lMoveFlag = 0;
					Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
					if( g_nWorkFlag == 101 )
						g_nWorkFlag = 100;
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
				if( g_nWorkFlag != 203 )
					Card_Move("SC_CONFIRM");
				else
					Card_Move("SC_JOJUNGLST");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
//�跮�⸮��Ʈ(����)
			case BID_OK:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_ADD:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				m_lSelIndex = 0;
				Add_Mtr();
				SetData_MTR();
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
				break;
			case BID_DEL:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				if(m_lSelIndex == -1)
				{
					MessageBoxEx (CONFIRM_OK, "����� �������ּ���.");
					break;
				}
				else
				{
					Del_Mtr();
					SetData_MTR();
					//m_lSelIndex = 0;
				}
				break;
			case BID_PREVLST:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					SetData_MTR();
					return;
				}
				m_lSelIndex = 0;
				SetData_MTR();
				break;
			case BID_NEXTLST:
				m_lpage++ ;
				if( m_lpage > m_Popltotcnt-1 )
				{
					m_lpage = m_Popltotcnt-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					SetData_MTR();
					break;
				}
				m_lSelIndex = 0;
				SetData_MTR();
				break;
//��������
			case BID_OK2:
				if( Save_ScOut() )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_CANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
//������ ��������
			case BID_SAVE:
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( Save_InfoChg() )
				{
					ON_EXIT()
					OnInit(INIT_MAIN);
				}
				break;
			case BID_CLOSE:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				ON_EXIT()
				OnInit(INIT_MAIN);
				break;
		}
	}
	
	//------------------------------------------------------------------------
	void	OnKey(long nKey)
	{

		if( m_bFirst == INIT_MTRLST)
		{
			return;
		}
	}
	
	//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		char szVc[10];
	
		if( m_bFirst == INIT_MTRLST )
		{
			if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex)
			{
				//���ڸ� �Է� ����
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					ON_KEY( 5 );
					return;
				}
			}
		}
	}
	
	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		//EDITCTRL�� ACTIVE�ÿ� CTRLINDEX�� ����
		//Ű���� BUTTONCTRL�� ACTIVE�ÿ��� EDITCTRL�� Ŀ���� �α����ؼ� INDEX�� ����
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);			

		if( m_bFirst == INIT_MTRLST )
		{
			if( POINTING_UP == nAction )
			{
				m_lActiveIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex )			
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
				}
			}
		}
		else if( m_bFirst == INIT_INFOCHG )
		{			
			if( POINTING_UP == nAction )
			{
				m_lActiveIndex = lActiveIndex;
				
				if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+181) && Y < DMS_Y(STARTY+251) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )			
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
			}						
		}
		
		ON_DRAW();
		return;
	}

	//=======================================================================================	
	void	OnSelect(long Index)
	{
		char sztmp[51];
		char szSql[300];
		long index;
		
		if( INIT_MTRLST == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				m_lSelIndex = index - 1;
				// ���� ���õ� �ε���
				Str_Cpy(stScJjMtr.MTR_ID_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));			//�⹰��ȣ
				Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 2)); //����

				if( Str_Cmp(stScJjMtr.REGTR_RESOU_CHG_STS, "����") == 0 )
					Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, "20");
				else if ( Str_Cmp(stScJjMtr.REGTR_RESOU_CHG_STS, "�߰�") == 0 )
					Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, "30");
				else
					Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, "");			
			}
		}
		else if( INIT_INFOCHG == m_bFirst )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2 ))   );	
			if( Str_Cmp(m_CmdStr,  sztmp ) != 0 )
			{
				Str_Cpy(m_CmdStr,  sztmp);
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT MAKER_NUM FROM USE_MAKER WHERE MAKER_FLAG = '30' AND  MAKER_NM = '%s' ",m_CmdStr, 0, 0   );
				g_Sql_RetStr( szSql, 5, stScJjChk.MAKER_NUM );
				
				//�𵨸�
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DATA3+2 ) );
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT REGTR_MODEL_NM FROM REGTR_MODEL WHERE MAKER_FLAG ='30' AND MAKER_NUM='%s' ",stScJjChk.MAKER_NUM, 0, 0   );
				g_Sql_SetCombo(szSql, CMB_DATA3+2);
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3 ), "");
				ON_DRAW();
			}
		}
		else if( INIT_SCOUT == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST_E))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST_E);
				m_lSelIndex = index - 1;

				Mem_Set( (byte*)m_szScOut, 0x00, sizeof(m_szScOut) );
				Str_Cpy(m_szScOut , DlgTbl_GetStr( ID_TBLLIST_E, m_lSelIndex, 0));
				
				return;
			}
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

	/*=======================================================================================
	�Լ��� : Prev_SC
	��  �� : ���� ��ư�� ��������� ã�´�.
	Param  : 
	Return : ���� �ƹ��͵� �ڵ����� ����.(��ħ �ڵ� �״��)
	========================================================================================*/
	void PrevPG(void)
	{
		if( g_nWorkFlag == 203 )
		{
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
					//MessageBoxEx (CONFIRM_OK, "ù��° ���Դϴ�.");
				}
				return;
			}
		}
		else
		{
			//MessageBoxEx (CONFIRM_OK, "ù��° ���Դϴ�.");
		}
		
		SetData();
		SetData_Nogood();
		REDRAW();
		Set_Index();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Next_SC
	��  �� : �ٿ� ��ư�� ��������� ã�´�.
	Param  : 
	Return : ���� �ƹ��͵� �ڵ����� ����.(��ħ �ڵ� �״��)
	========================================================================================*/
	void NextPG(void)
	{
		m_lPrev = 0;

		if( g_nWorkFlag == 203 )
		{
			g_nActIndex++;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
	
			if( g_nActIndex > m_ltotcnt || g_lindex < 0 )
			{
				if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
				{
					g_nActIndex = g_nActIndex-1;
				}
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				//MessageBoxEx (CONFIRM_OK, "������ ���Դϴ�.");
				return;
			}
		}
		else
		{
			//MessageBoxEx (CONFIRM_OK, "������ ���Դϴ�.");
		}
		
		SetData();
		SetData_Nogood();
		REDRAW();
		Set_Index();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : SetGlobal
	��  �� : setData()�Լ� �ȿ��� global ������(g_szREGTR_NUM, g_szCHK_PLAN_YM, g_szSAFE_CHK_TYPE) ������ �Ѵ�
	Param  : long lindex : ROWID
	Return : 
	========================================================================================*/
	long SetGlobal(long lindex)
	{
		long i;
		long nRet = 1;
		char szSql[200];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			nRet = -1;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT REGTR_NUM, CHK_PLAN_YM, SAFE_CHK_TYPE \
										     FROM REGTR_DATA WHERE ROWID = ?" 
								    );
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			nRet = -1;
			goto Finally;
		} 
		 
		i = 0;
		sql->Bind(sql, i++, 'X', (long*)&lindex , 9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			nRet = -1;
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) g_szREGTR_NUM				    , 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) g_szCHK_PLAN_YM				, 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) g_szSAFE_CHK_TYPE				, 1  + 1, DECRYPT );	
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			nRet = -1;
			goto Finally;
		}
		//PRINT("::g_szREGTR_NUM[%s]", g_szREGTR_NUM, 0, 0);
		//PRINT("::g_szCHK_PLAN_YM[%s]", g_szCHK_PLAN_YM, 0, 0);
		//PRINT("::g_szSAFE_CHK_TYPE[%s]", g_szSAFE_CHK_TYPE, 0, 0);
Finally:
		DelSqLite(sql);
		
		return nRet;
	}
	
	//-----------------------------------------------------------------
	void SetData(void)
	{
		long i;
		long lindex = 0;
		char szSql[200];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//g_nWorkFlag = 203 > ������ ����
		if( g_nWorkFlag != 203 )
		{
			//ī�� �̵����� �Ѱ��ִ°ɷ� ����
			SPRINT(m_szCnt_index, "1/1", 0, 0, 0);
		}
		else
		{
			lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			// SPRINT(szSql, "SELECT REGTR_NUM FROM REGTR_DATA WHERE ROWID = '%d'",lindex, 0, 0   );
			// g_Sql_RetStr( szSql, 9, g_szREGTR_NUM );
			
			// global
			if(SetGlobal(lindex) == -1){
				goto Finally;
			}
			
			// ������������ ǥ��
			m_ltotcnt = FS_GetSrchTotCnt();

			SPRINT(m_szCnt_index, "%d/%d", g_nActIndex+1, m_ltotcnt, 0);
		}
		
		Mem_Set((byte*)&stScJjChk, 0x00, sizeof(stScJjChk));
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		//CHK_SIGN_IMAGE -> SECOND_PRESS ������ ������. �߰�����
		hstmt = sql->CreateStatement(sql,
"SELECT REGTR_NUM, CHK_PLAN_YM, SAFE_CHK_TYPE, BRANCH_CD, CENTER_CD, SINGLE_COLIVE_FLAG \
, GENER_REGTR_CHK_FLAG, REGTR_FILTER_FLAG, REGTR_ID_NUM, REGTR_MODEL_CD \
, REGTR_MODEL_NM, REGTR_INST_YMD, MTRCNT, REGTR_LOC_FLAG, REGTR_TYPE, REGTR_LR_TYPE_NM \
, FIRST_PRESS, BLD_NUM, BLD_NM, MAKER_NUM, Trim(MAKER_NM), ZIP_NO1, ZIP_NO2, ZIP_NO3, CITY \
, COUNTY, TOWN, VILLAGE, ADDR1_M, ADDR1_S, LOT_NUM_SECOND_ADDR, FILTER_REPL_YMD \
, FHALF_CHK_RSLT, FHALF_CHK_YMD, FHALF_CHKER_NM, TRIM(FHALF_MEMO), FHALF_MEMO_FLAG, BAR \
, ZONE_MANAGE_NUM, FILTER_REPL_FLAG, NEW_FILTER_REPL_YMD, CURR_BAR, BAR_NOT_PERMIT_WHY \
, CHK_EMPID, CHK_YMD, CHK_RSLT, CHK_EXCEP_WHY, SECOND_PRESS, CHK_STR_DTM \
, CHK_END_DTM, INFO_FLAG, REG1_RSLT, REG2_RSLT, REG3_RSLT, CHK_END_YN, UPD_EMPID \
, UPD_EMPNM, CO_LIVE_NM, LAW_TOWN, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S, SPECIAL_ETC \
FROM REGTR_DATA WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? AND SAFE_CHK_TYPE = ?"
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szREGTR_NUM , 9, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&g_szCHK_PLAN_YM , 6, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&g_szSAFE_CHK_TYPE , 2, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REGTR_NUM           , 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CHK_PLAN_YM         , 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.SAFE_CHK_TYPE       , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.BRANCH_CD           , 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CENTER_CD           , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.SINGLE_COLIVE_FLAG  , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.GENER_REGTR_CHK_FLAG, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REGTR_FILTER_FLAG   , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REGTR_ID_NUM        , 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REGTR_MODEL_CD      , 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REGTR_MODEL_NM      , 50 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REGTR_INST_YMD      , 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.MTRCNT              , 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REGTR_LOC_FLAG      , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REGTR_TYPE          , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REGTR_LR_TYPE_NM    , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.FIRST_PRESS         , 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.BLD_NUM             , 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.BLD_NM              , 150+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.MAKER_NUM           , 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.MAKER_NM            , 60 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.ZIP_NO1             , 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.ZIP_NO2             , 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.ZIP_NO3             , 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CITY                , 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.COUNTY              , 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.TOWN                , 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.VILLAGE             , 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.ADDR1_M             , 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.ADDR1_S             , 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.LOT_NUM_SECOND_ADDR , 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.FILTER_REPL_YMD     , 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.FHALF_CHK_RSLT      , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.FHALF_CHK_YMD       , 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.FHALF_CHKER_NM      , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.FHALF_MEMO          , 100+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.FHALF_MEMO_FLAG     , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.BAR                 , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.ZONE_MANAGE_NUM     , 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.FILTER_REPL_FLAG    , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.NEW_FILTER_REPL_YMD , 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CURR_BAR            , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.BAR_NOT_PERMIT_WHY  , 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CHK_EMPID           , 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CHK_YMD             , 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CHK_RSLT            , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CHK_EXCEP_WHY       , 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.SECOND_PRESS        , 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CHK_STR_DTM         , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CHK_END_DTM         , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.INFO_FLAG           , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REG1_RSLT           , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REG2_RSLT           , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.REG3_RSLT           , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CHK_END_YN          , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.UPD_EMPID           , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.UPD_EMPNM           , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.CO_LIVE_NM          , 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.LAW_TOWN            , 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.NEW_ROAD_NM         , 100+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.NEW_ADDR_M          , 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.NEW_ADDR_S          , 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScJjChk.SPECIAL_ETC         , 2  + 1, DECRYPT );
		}
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( Str_Cmp(stScJjChk.CHK_END_YN,"S") != 0)
		{
			Str_Cpy(stScJjChk.REG1_RSLT, "");
			Str_Cpy(stScJjChk.REG2_RSLT, "");
			Str_Cpy(stScJjChk.REG3_RSLT, "");
		}
		return;
	}

//-----------------------------------------------------------------	
	void SetData_Nogood(void)
	{
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)&stScVisit, 0x00, sizeof(stScVisit));
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		//NOT_PASS_PHOTO_IMAGE  => REGTR_NOT_PASS_ITEM ���� �߰��ϸ��. �̹��� ���
		hstmt = sql->CreateStatement(sql,
"SELECT REGTR_NUM, CHK_PLAN_YM, SAFE_CHK_TYPE, REGTR_NOT_PASS_FLAG, REGTR_NOT_PASS_ITEM \
, NOT_PASS_BETTER_YMD, CORRECTION_FLAG, SEND_YN, EMP_ID, UPD_EMPID \
FROM REGTR_NOGOOD WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? AND SAFE_CHK_TYPE = ? AND REGTR_NOT_PASS_FLAG = '10' "
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szREGTR_NUM ,     9, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&g_szCHK_PLAN_YM ,   6, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&g_szSAFE_CHK_TYPE , 2, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.REGTR_NUM            , 8 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.CHK_PLAN_YM          , 6 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.SAFE_CHK_TYPE        , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.REGTR_NOT_PASS_FLAG  , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.REGTR_NOT_PASS_ITEM  , 2 + 1, DECRYPT );
//			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.NOT_PASS_PHOTO_IMAGE , 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.NOT_PASS_BETTER_YMD  , 8 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.CORRECTION_FLAG      , 1 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.SEND_YN              , 1 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.EMP_ID               , 9 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stScJjNogood.UPD_EMPID            , 20+ 1, DECRYPT );
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
/*=======================================================================================
�Լ��� : SetData_MTR
��  �� : �跮�� ����Ʈ �ڷ�(����)
Param  : 
Return : 
========================================================================================*/	
	void SetData_MTR(void)
	{
		long i, idx, j;
		long k = ROW+1;
		long lstartidx;
		char sztmp[200];
		char szSql[800];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//������
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM REGTR_MRT WHERE REGTR_NUM = '%s' ",g_szREGTR_NUM, 0, 0   );
		g_Sql_RetInt( sztmp, &m_Popltotcnt );
		
		if( m_Popltotcnt % ROW > 0 )		
		{
			m_Popltotcnt = (m_Popltotcnt / ROW) + 1;
		}
		else
		{
			m_Popltotcnt = m_Popltotcnt / ROW;
		}

		if( m_lSelIndex == -1 )
		{
			m_lSelIndex = 0;
		}

		SPRINT(m_szPopCnt_index, "%d/%d", m_lpage+1, m_Popltotcnt, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MTR_ID_NUM, MTR_LOC_FLAG, REGTR_RESOU_CHG_STS, CHK_PLAN_YM, SAFE_CHK_TYPE \
		FROM REGTR_MRT WHERE REGTR_NUM = '%s' LIMIT ?, ? "
		, g_szREGTR_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;
		lstartidx = m_lpage*ROW;
		sql->Bind(sql, i++, 'X', &lstartidx, 4, DECRYPT);
		j = m_lpage*ROW+ROW;
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
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
					continue;
				}
				//�⹰��ȣ
				idx = 0;
				Mem_Set( (byte*)stScJjMtr.MTR_ID_NUM, 0x00, sizeof(stScJjMtr.MTR_ID_NUM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScJjMtr.MTR_ID_NUM          , 20 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, stScJjMtr.MTR_ID_NUM );
				//��ġ��ġ
				Mem_Set( (byte*)stScJjMtr.MTR_LOC_FLAG, 0x00, sizeof(stScJjMtr.MTR_LOC_FLAG) );
				sql->GetValue( sql, idx++, 'U', (long*) stScJjMtr.MTR_LOC_FLAG        , 30 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1,  stScJjMtr.MTR_LOC_FLAG);
				//����
				Mem_Set( (byte*)stScJjMtr.REGTR_RESOU_CHG_STS, 0x00, sizeof(stScJjMtr.REGTR_RESOU_CHG_STS) );
				sql->GetValue( sql, idx++, 'U', (long*) stScJjMtr.REGTR_RESOU_CHG_STS , 2  + 1, DECRYPT );
				if( Str_Cmp(stScJjMtr.REGTR_RESOU_CHG_STS, "20") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
				else if ( Str_Cmp(stScJjMtr.REGTR_RESOU_CHG_STS, "30") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "�߰�");
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "");
				//CHK_PLAN_YM
				Mem_Set( (byte*)stScJjMtr.CHK_PLAN_YM, 0x00, sizeof(stScJjMtr.CHK_PLAN_YM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScJjMtr.CHK_PLAN_YM        , 6 + 1, DECRYPT );
				//SAFE_CHK_TYPE
				Mem_Set( (byte*)stScJjMtr.SAFE_CHK_TYPE, 0x00, sizeof(stScJjMtr.SAFE_CHK_TYPE) );
				sql->GetValue( sql, idx++, 'U', (long*) stScJjMtr.SAFE_CHK_TYPE        , 2 + 1, DECRYPT );
			}
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_Popltotcnt > 0 )
		{
			// ���� ���õ� �ε���
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);
			
			Str_Cpy(stScJjMtr.MTR_ID_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));			//�⹰��ȣ
			Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 2)); //����
			if( Str_Cmp(stScJjMtr.REGTR_RESOU_CHG_STS, "����") == 0 )
				Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, "20");
			else if ( Str_Cmp(stScJjMtr.REGTR_RESOU_CHG_STS, "�߰�") == 0 )
				Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, "30");
			else
				Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, "");	
		}
		
		ON_DRAW();
		return;
	}
	
	
/*=======================================================================================
�Լ��� : REDRAW
��  �� : ��ħ �ڷḦ �о�ͼ� ȭ�鿡 �����Ѵ�.
Param  : 
Return : 
========================================================================================*/
	void REDRAW(void)
	{
		char szSql[300];
		char szAddr[300];
		char sztmp[50];
		long i;
	
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2 ), stScJjChk.REGTR_NUM);	//������
		
		//SPRINT(szSql, "SELECT COUNT(*) FROM REGTR_MRT WHERE REGTR_NUM = '%s'",g_szREGTR_NUM, 0, 0   );
		//g_Sql_RetStr( szSql, 10, sztmp );
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3 ), stScJjChk.MTRCNT);  //����(�跮�� ����)
		
		if( g_nAddrFlag == 0)
		{

			Str_Cpy(szAddr,  stScJjChk.CITY );
			if(Str_Len(stScJjChk.COUNTY) != 0)			//�ñ���
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stScJjChk.COUNTY );
			}			
			if(Str_Len(stScJjChk.TOWN) != 0)			//���鵿
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stScJjChk.TOWN );
			}
			if(Str_Len(stScJjChk.VILLAGE) != 0)			//��
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stScJjChk.VILLAGE );
			}
			if(Str_Len(stScJjChk.ADDR1_M) == 0)			//����
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stScJjChk.ADDR1_M);
			}			
			if(Str_Len(stScJjChk.ADDR1_S) == 0)		//�ι�
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stScJjChk.ADDR1_S);
			}
			
			//��ȸȭ�鿡���� �ּ�
			Str_Cat(szAddr,  stScJjChk.CO_LIVE_NM );	//�������ø�
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), szAddr);
		}
		else
		{

			Str_Cpy(szAddr,  stScJjChk.CITY );
			
			if(Str_Len(stScJjChk.COUNTY) != 0)		//�ñ���
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stScJjChk.COUNTY );
			}		
			if(Str_Len(stScJjChk.NEW_ROAD_NM) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stScJjChk.NEW_ROAD_NM );
			}
			if(Str_Len(stScJjChk.NEW_ADDR_M) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stScJjChk.NEW_ADDR_M);
			}
			if(Str_Len(stScJjChk.NEW_ADDR_S) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stScJjChk.NEW_ADDR_S);
			}

			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), szAddr);
		}
		
		//�޸� ����
		if( Str_Len(stScJjChk.FHALF_MEMO) > 0 )
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), RED);
		else
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), WHITE);
		
		//�۾�����
		i = SearchCD( stScJjChk.GENER_REGTR_CHK_FLAG, SCWORK );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), SCWORK[i].Str);
		
		//����(����)
		if( Str_Cmp( stScJjChk.SINGLE_COLIVE_FLAG, "10") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7 ), "�ܵ�");
		}
		else if( Str_Cmp( stScJjChk.SINGLE_COLIVE_FLAG, "20") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7 ), "����");
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8 ), stScJjChk.REGTR_MODEL_NM);  //�𵨸�
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9 ), stScJjChk.MAKER_NM);		  //���ۻ�
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), stScJjChk.FIRST_PRESS);	  //1���з�
		
		//Ÿ��
		i = SearchCD( stScJjChk.REGTR_TYPE, SCJJTYPE );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), SCJJTYPE[i].Str);
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Str_DateType( sztmp, stScJjChk.REGTR_INST_YMD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), sztmp);   //��ġ
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), stScJjChk.REGTR_LOC_FLAG);   //��ġ
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), stScJjChk.REGTR_ID_NUM);	   //������S/N

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Str_DateType( sztmp, stScJjChk.FILTER_REPL_YMD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), sztmp);  //���ͱ�ü����
		
		//������ ���� �÷���
		i = SearchCD( stScJjChk.REGTR_FILTER_FLAG, SCFLTCHGFLAG );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), SCFLTCHGFLAG[i].Str);
		
		//���ݱ�
		i = SearchCD( stScJjChk.FHALF_CHK_RSLT, SCCHK_RSLT );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), SCCHK_RSLT[i].Str);

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Str_DateType( sztmp, stScJjChk.FHALF_CHK_YMD);			
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), sztmp);	   //���ݱ�
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), stScJjChk.FHALF_CHKER_NM);   //���ݱ�
		//�Ϲݱ�
		i = SearchCD( stScJjChk.CHK_RSLT, SCCHK_RSLT );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), SCCHK_RSLT[i].Str);

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Str_DateType( sztmp, stScJjChk.CHK_YMD);				
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), sztmp);		   //�Ϲݱ�
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), stScJjChk.UPD_EMPNM);		   //�Ϲݱ�
		
		//���˽���
		if( Str_Cmp(stScJjChk.CHK_RSLT, "20") == 0 || Str_Cmp(stScJjChk.CHK_RSLT, "21") == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SC), "���˿Ϸ�");
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SC), RED);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SC), "���˽���");
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SC), WHITE);
		}
		
		//��������
		if( Str_Cmp(stScJjChk.CHK_RSLT, "40") == 0 )
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SCOUT), RED);
		else
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SCOUT), WHITE);
	
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : SCOUT_DRAW
	��  �� : �������� ���÷���
	Param  : 
	Return :
	========================================================================================*/		
	void SCOUT_DRAW(void)
	{
		long ret = -1;
		long i = 0;
		long cnt  = 0;
		char sztmp[100];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
/*	
		//�޺��ڽ��� �ڵ尪 ����
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30015' AND CODE_ITEM > '13' ", CMB_DATA1+2);
		
		if( Str_Len(stScJjChk.CHK_EXCEP_WHY) > 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30015' AND CODE_ITEM = '%s' ", stScJjChk.CHK_EXCEP_WHY, 0, 0   );
			g_Sql_RetStr( szSql, 10, stScJjChk.CHK_EXCEP_WHY );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), stScJjChk.CHK_EXCEP_WHY);
		}
*/
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30015' AND CODE_ITEM > '13' AND ITEM_KNAME IS NOT NULL ORDER BY CODE_ITEM");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		sql->Begin(sql);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}		

		i = 0;
		cnt = 0;
		while(sql->Next(sql) == TRUE)
		{
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i, 'U', (long*)sztmp, sizeof(sztmp), DECRYPT );
			DlgTbl_SetStr ( ID_TBLLIST_E, cnt, i, sztmp );

			cnt++;
			if(cnt == 20)
				break;
		}
		
		if( m_lSelIndex == -1 )
		{
			m_lSelIndex = 0;
		}
		
		DlgTbl_SetActive(ID_TBLLIST_E , m_lSelIndex+1 );
		DlgTbl_SetRowColor(ID_TBLLIST_E, m_lSelIndex+1, TABLEACTIVE_COLOR);
		
		Mem_Set( (byte*)m_szScOut, 0x00, sizeof(m_szScOut) );
		Str_Cpy(m_szScOut , DlgTbl_GetStr( ID_TBLLIST_E, m_lSelIndex, 0));

Finally:

		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	�Լ��� : INFOCHG_DRAW
	��  �� : �������� �˾� ���÷���
	Param  : 
	Return :
	========================================================================================*/	
	void INFOCHG_DRAW(void)
	{
		long i;
	
		//���ۻ�
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), stScJjChk.MAKER_NM);
		Str_Cpy(m_CmdStr, stScJjChk.MAKER_NM);
		
		if( Str_Len(stScJjChk.MAKER_NM) > 0 )
		{
			//�𵨸�
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), stScJjChk.REGTR_MODEL_NM);
		}
		
		//Ÿ��
		i = SearchCD( stScJjChk.REGTR_TYPE, SCJJTYPE );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), SCJJTYPE[i].Str);
		//������S/N
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), stScJjChk.REGTR_ID_NUM);
		
		i = SearchCD( stScJjChk.SINGLE_COLIVE_FLAG, SINGLECOLIVECD );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA5), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA5), SINGLECOLIVECD[i].Str);
		
	}
	
	/*=======================================================================================
	�Լ��� : Save_ScOut
	��  �� : �������ܻ��� ����
	Param  : 
	Return :
	========================================================================================*/		
	bool Save_ScOut(void)
	{
		char szSql[300];
		char szMemo[300];
		long idx;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//������
		Str_ItoA(Time_GetDate(), stScJjChk.CHK_YMD, 10);
		//������
		Str_Cpy(stScJjChk.UPD_EMPNM, stUserinfo.sznm_kor);
		//�������� �Է½�, CHK_RSLT 40 �Է�
		Str_Cpy(stScJjChk.CHK_RSLT,"40");

		Str_ItoA(  Time_GetDate(), stScJjChk.CHK_END_DTM, 10 );
		Str_Cpy( stScJjChk.CHK_YMD,stScJjChk.CHK_END_DTM );
		g_Str_TimeType( stScJjChk.CHK_END_DTM+8 , Time_GetTime() );
		Str_Cpy( stScJjChk.CHK_STR_DTM, stScJjChk.CHK_END_DTM );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30015' AND ITEM_KNAME = '%s' ",m_szScOut, 0, 0   );
		g_Sql_RetStr( szSql, 10, stScJjChk.CHK_EXCEP_WHY );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
	    hstmt = sql->CreateStatement(sql, " UPDATE REGTR_DATA SET CHK_END_YN='S', CHK_EXCEP_WHY =?, \
	    CHK_YMD =?,  CHK_STR_DTM = ?, CHK_END_DTM = ?,UPD_EMPNM =?, CHK_RSLT =?, CHK_EMPID = ?, UPD_EMPID = ? \
	    WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? AND SAFE_CHK_TYPE = ? ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_EXCEP_WHY	,6	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_YMD		,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_STR_DTM    ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_END_DTM    ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.UPD_EMPNM		,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_RSLT		,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM	     	,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_PLAN_YM	     	,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szSAFE_CHK_TYPE	    ,2  ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Save_InfoChg
	��  �� : 
	Param  : 
	Return :
	========================================================================================*/	
	bool Save_InfoChg(void)
	{
		char szSql[300];
		char szTmp[50];
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

		//���ۻ�
		Str_Cpy(stScJjChk.MAKER_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)) );
		
		//�𵨸�
		Str_Cpy(stScJjChk.REGTR_MODEL_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT REGTR_MODEL_CD FROM REGTR_MODEL WHERE MAKER_FLAG = '30' AND  REGTR_MODEL_NM = '%s' ",stScJjChk.REGTR_MODEL_NM, 0, 0   );
		g_Sql_RetStr( szSql, 5, stScJjChk.REGTR_MODEL_CD );		
		
		//Ÿ�Ը�
		Str_Cpy(stScJjChk.REGTR_LR_TYPE_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)) );
		//�ڵ�
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)), SCJJTYPE );
		if (i == -1)
			Str_Cpy(stScJjChk.REGTR_TYPE, "");
		else
			Str_Cpy(stScJjChk.REGTR_TYPE, SCJJTYPE[i].Code);
		//������S/N
		Str_Cpy(stScJjChk.REGTR_ID_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		
		
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5)), SINGLECOLIVECD );
		if (i == -1)
			Str_Cpy(stScJjChk.SINGLE_COLIVE_FLAG, "");
		else
			Str_Cpy(stScJjChk.SINGLE_COLIVE_FLAG, SINGLECOLIVECD[i].Code);
			
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
	    hstmt = sql->CreateStatement(sql, " UPDATE REGTR_DATA SET MAKER_NM = ?,MAKER_NUM = ?, REGTR_MODEL_NM = ?,REGTR_MODEL_CD = ?,\
 REGTR_LR_TYPE_NM = ?, REGTR_TYPE = ?, SINGLE_COLIVE_FLAG = ?, REGTR_ID_NUM = ?, INFO_FLAG='S' WHERE REGTR_NUM = ? AND CHK_PLAN_YM = ? AND SAFE_CHK_TYPE = ? " );
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.MAKER_NM	        ,60  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.MAKER_NUM	        ,5   ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REGTR_MODEL_NM	    ,50  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REGTR_MODEL_CD	    ,5   ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REGTR_LR_TYPE_NM   ,20  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REGTR_TYPE	        ,2	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SINGLE_COLIVE_FLAG ,2	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.REGTR_ID_NUM	    ,10  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM         	    ,8   ,DECRYPT);
  		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_PLAN_YM	     	    ,6   ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szSAFE_CHK_TYPE	        ,2   ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���� ����");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Add_Mtr
	��  �� : 
	Param  : 
	Return :
	========================================================================================*/	
	void Add_Mtr(void)
	{
		char sztmp[300];
		char szSql[300];
		char szMtr_Num[20];
		long idx;
		long i;
		long lVal;
		long lCnt;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�߰��� �⹰��ȣ�� �����ϴ�.");
			goto Finally;
		}
		
		Mem_Set( (byte*)szMtr_Num, 0x00, sizeof(szMtr_Num) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(szMtr_Num, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		SPRINT(szSql, "SELECT COUNT(*) FROM REGTR_MRT WHERE REGTR_NUM = '%s' AND MTR_ID_NUM = '%s' ",g_szREGTR_NUM, szMtr_Num, 0   );
		g_Sql_RetInt( szSql, &lCnt );
		if( lCnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�ߺ��� �⹰��ȣ�Դϴ�.");
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
			goto Finally;
		}
		
		
		//�⹰��ȣ
		Str_Cpy(stScJjMtr.MTR_ID_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) );
		//�跮�����?
		Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, "30");
		//�۽ſ���
		Str_Cpy(stScJjMtr.SEND_YN, "S");
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
				"INSERT INTO REGTR_MRT \
				( REGTR_NUM, CHK_PLAN_YM, SAFE_CHK_TYPE, MTR_ID_NUM, REGTR_RESOU_CHG_STS, EMP_ID, UPD_EMPID, SEND_YN ) \
				  VALUES(?, ?, ?, ?, ?, ?, ?, ?)"
		);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)g_szREGTR_NUM		      	 ,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.CHK_PLAN_YM         ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjChk.SAFE_CHK_TYPE       ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjMtr.MTR_ID_NUM      	 ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjMtr.REGTR_RESOU_CHG_STS ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id      ,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id      ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjMtr.SEND_YN     		 ,2 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Del_Mtr
	��  �� : 
	Param  : 
	Return :
	========================================================================================*/	
	void Del_Mtr(void)
	{
		char szSql[300];
		long idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( Str_Cmp(stScJjMtr.REGTR_RESOU_CHG_STS, "30") != 0 )
		{
			Str_Cpy(stScJjMtr.REGTR_RESOU_CHG_STS, "20" );
			Str_Cpy(stScJjMtr.SEND_YN, "S");
		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE REGTR_MRT SET \
						REGTR_RESOU_CHG_STS = ?, EMP_ID = ?, UPD_EMPID = ?, SEND_YN = ? WHERE REGTR_NUM = '%s'  AND MTR_ID_NUM = '%s' "
						, g_szREGTR_NUM, stScJjMtr.MTR_ID_NUM, 0);
		}
		else
		{
			//���Ϸ�
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM REGTR_MRT WHERE REGTR_NUM ='%s' AND MTR_ID_NUM = '%s' "
							, g_szREGTR_NUM, stScJjMtr.MTR_ID_NUM, 0);
			g_Sql_DirectExecute( szSql );
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScJjMtr.REGTR_RESOU_CHG_STS ,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id      ,9,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id      ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScJjMtr.SEND_YN			 ,1	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
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
		char szSql[201];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '3' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}

//=======================================================================================
	bool Validate(void)
	{
		bool ret = TRUE;
	
		//���ۻ�
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ۻ縦 ������ �ּ���.");
			ret = FALSE;
			return ret;
		}
		//��
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���� ������ �ּ���.");
			ret = FALSE;
			return ret;
		}
		//Ÿ��
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Ÿ���� ������ �ּ���.");
			ret = FALSE;
			return ret;
		}
		
		return ret;
	}
}



