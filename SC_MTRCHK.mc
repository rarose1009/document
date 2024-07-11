/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_MTRCHK
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#define USE_ON_UART
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_PREVLST )	//����Ʈ ��������
		DEF_BUTTON_ID ( BID_NEXTLST )	//����Ʈ ����������
		DEF_BUTTON_ID ( BID_FEE )		//���
		DEF_BUTTON_ID ( BID_PREVPG )	//��
		DEF_BUTTON_ID ( BID_ETC )		//*
		DEF_BUTTON_ID ( BID_NEXTPG )	//��
		DEF_BUTTON_ID ( BID_SAVE )		//����
		DEF_BUTTON_ID ( BID_MTRSC )		//����
		DEF_BUTTON_ID ( BID_COMPLETE )	//�Ϸ�
		DEF_BUTTON_ID ( BID_PHOTO )	    //����
		
//�跮������
		DEF_BUTTON_ID ( BID_CHECK1 )
		DEF_BUTTON_ID ( BID_CHECK2 )
		DEF_BUTTON_ID ( BID_CLOSE )
		DEF_BUTTON_ID ( BID_OK1 )
//�跮�⸮��Ʈ
		DEF_BUTTON_ID ( BID_ADD )
		DEF_BUTTON_ID ( BID_DEL )
		DEF_BUTTON_ID ( BID_OK2 )
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
		DEF_OBJECT_ID ( TXT_PAGE )			//������
		DEF_OBJECT_ID ( TXT_ADDR )			//�ּ�
		DEF_OBJECT_ID ( TXT_MTRNAME )		//�跮���Ī
		DEF_OBJECT_ID ( TXT_RATE )			//���
		DEF_OBJECT_ID ( TXT_MODEL )			//��
		DEF_OBJECT_ID ( TXT_FORM )			//����
		DEF_OBJECT_ID ( TXT_OBJECT )		//��ǰ
		DEF_OBJECT_ID ( TXT_VALIDDT )		//��ȿ�Ⱓ
		DEF_OBJECT_ID ( TXT_PLACETYPE )		//��ġ����
		DEF_OBJECT_ID ( TXT_SUPSTATE )		//���޻���
		DEF_OBJECT_ID ( TXT_SEAL )			//���ο���
		DEF_OBJECT_ID ( TXT_LTVC )			//����Vc
		DEF_OBJECT_ID ( TXT_GUIDEVC )		//��ħVc
		DEF_OBJECT_ID ( TXT_LTVA )			//����Va
		DEF_OBJECT_ID ( TXT_GUIDEVA )		//��ħVa
		DEF_OBJECT_ID ( TXT_LTVM )			//����Vm
		DEF_OBJECT_ID ( TXT_GUIDEVM )		//��ħVm
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
		DEF_OBJECT_ID ( TXT_DATA20 )
		DEF_OBJECT_ID ( TXT_DATA22 )
//�跮������
		DEF_OBJECT_ID ( TXT_DATA24 )
		DEF_OBJECT_ID ( TXT_DATA25 )
		DEF_OBJECT_ID ( TXT_DATA26 )
		DEF_OBJECT_ID ( TXT_DATA27 )
		DEF_OBJECT_ID ( TXT_DATA28 )
		DEF_OBJECT_ID ( TXT_DATA29 )
//�跮�⸮��Ʈ
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
//�跮������_�Է�
		DEF_OBJECT_ID ( TXT_DATA47 )
		DEF_OBJECT_ID ( TXT_DATA48 )
		DEF_OBJECT_ID ( TXT_DATA49 )
		DEF_OBJECT_ID ( TXT_DATA50 )
		DEF_OBJECT_ID ( TXT_DATA51 )
		DEF_OBJECT_ID ( TXT_DATA52 )
		DEF_OBJECT_ID ( TXT_DATA53 )
		DEF_OBJECT_ID ( TXT_DATA54 )
		DEF_OBJECT_ID ( TXT_DATA55 )
		DEF_OBJECT_ID ( TXT_DATA56 )
		DEF_OBJECT_ID ( TXT_DATA57 )
		DEF_OBJECT_ID ( TXT_DATA58 )
		
//������ ����
		DEF_OBJECT_ID ( TXT_KEY_ONE )
		DEF_OBJECT_ID ( TXT_KEY_TWO )
		DEF_OBJECT_ID ( TXT_KEY_THREE )
		DEF_OBJECT_ID ( TXT_KEY_FOUR )
		DEF_OBJECT_ID ( TXT_KEY_FIVE )
		DEF_OBJECT_ID ( TXT_KEY_SIX )
		DEF_OBJECT_ID ( TXT_KEY_SEVEN )
		DEF_OBJECT_ID ( TXT_KEY_EIGHT )
		DEF_OBJECT_ID ( TXT_KEY_NINE )
		DEF_OBJECT_ID ( TXT_KEY_ZERO )
		DEF_OBJECT_ID ( TXT_KEY_DEL )
		
//����
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		
		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
				
		DEF_OBJECT_ID ( CMB_INSPLACE )
		DEF_OBJECT_ID ( CMB_SEAL = CMB_INSPLACE+3 )
		DEF_OBJECT_ID ( CMB_DATA1 = CMB_SEAL+3 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    1					// table�� �ళ��
	#define		COL 	    4					// table�� ������
	#define		GRID_H		(CHT+10)			// table �� ����
	#define		GRID_H_P	(CHT+20)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		51 				    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+65	  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY-40           // table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	#define		GRID_ENDY_P	(GRID_Y_P+(ROW+1)*GRID_H) //table������ row�� Y�� PDA
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�⹰��ȣ",	CWD*21, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"��ġ��ġ",	CWD*9, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",		CWD*9+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����������",	0	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};
	
	#define INIT_MAIN		1
	#define INIT_MTRCHK 	2

	long m_lindex;	
	long m_lActiveIndex = -1;
	long m_bFirst;
	long m_lPrev = 0;
	long m_lpage = 0;
	long m_lTotCnt = 0;
	long m_lActIndex;
	long m_lTotpage = 0;
	long m_lSelIndex = -1;		//�ε���
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lMoveFlag = 0;
	char m_szCnt_page[10];
	char m_szCHK_EXEC_NUM[13];
	char m_szUSE_CONT_NUM[11];
	char m_szfilenm[256];
	
	long FS_GetSrchTotCnt(void);
	void PrevPG(void);
	void NextPG(void);
	void SetStyle(void);
	void SetData(void);
	void SetClickData(void);
	void SetCombo(void);
	void Clear_DRAW(void);		//ȭ�� Ŭ����
	void Clear_Flag(void);		//flag �ʱ�ȭ
	void REDRAW(void);			//�跮�����˵�� ����
	void MTRCHK_DRAW(void);		//�跮������ �˾�
	void HOSE_DRAW(void);		//�跮������ �˾�
	bool Update_Result(void);	//stSc.MTR_RSLT ������Ʈ
	void Save_Main(void);		//��ħ ����
	bool Save_Mtr(void);		//���� ���� ����
	void SaveInput(void);		//ȭ�� �̵� �� ȭ�� �Է� �� ����
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	void SetBtnImg(void);
	bool Validate(void);
	void Shoto_Photo(void);
	long Chk_Photo(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�跮�� ���� ���"),
		
//		DLG_BUTTON(STARTX+555, STARTY+325, 200, 45, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
//		DLG_BUTTON(STARTX+775, STARTY+325, 200, 45, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),	
		DLG_BUTTON(STARTX,	   STARTY+765, 280, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "����"),
		DLG_BUTTON(STARTX,	   STARTY+825, 140, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEE, "���"),
		DLG_BUTTON(STARTX+140, STARTY+825, 140, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+280, STARTY+825, 140, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ETC, "*"),
		DLG_BUTTON(STARTX+420, STARTY+825, 140, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+560, STARTY+825, 145, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "����"),
		DLG_BUTTON(STARTX+705, STARTY+825, 145, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTRSC, "����"),
		DLG_BUTTON(STARTX+850, STARTY+825, 150, 74, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPLETE, "�Ϸ�"),

//		DLG_TEXT(STARTX,     STARTY+325, 150, 45, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),	//������

		DLG_TEXT(STARTX,     STARTY+165,1000, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),	//�ּ�
		DLG_TEXT(STARTX,     STARTY+245, 300, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MTRNAME, "�跮���Ī"),
		DLG_TEXT(STARTX+300, STARTY+245, 700, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX,     STARTY+310, 150, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_RATE, "���"),
		DLG_TEXT(STARTX+150, STARTY+310, 150, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+300, STARTY+310, 150, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODEL, "��"),
		DLG_TEXT(STARTX+450, STARTY+310, 550, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX,     STARTY+375, 150, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "����"),
		DLG_TEXT(STARTX+150, STARTY+375, 150, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+300, STARTY+375, 150, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "��ǰ"),
		DLG_TEXT(STARTX+450, STARTY+375, 550, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX,     STARTY+440, 220, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VALIDDT, "��ȿ�Ⱓ"),
		DLG_TEXT(STARTX+220, STARTY+440, 230, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX+450, STARTY+440, 250, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_PLACETYPE, "��ġ����"),
		DLG_TEXT(STARTX,     STARTY+505, 250, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SUPSTATE, "���޻���"),
		DLG_TEXT(STARTX+250, STARTY+505, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+450, STARTY+505, 250, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SEAL, "���ο���"),
		DLG_TEXT(STARTX,     STARTY+570, 250, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LTVC, "����Vc"),
		DLG_TEXT(STARTX+250, STARTY+570, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX+450, STARTY+570, 250, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GUIDEVC, "��ħVc"),
		DLG_TEXT(STARTX,     STARTY+635, 250, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LTVA, "����Va"),
		DLG_TEXT(STARTX+250, STARTY+635, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX+450, STARTY+635, 250, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GUIDEVA, "��ħVa"),
		DLG_TEXT(STARTX,     STARTY+700, 250, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LTVM, "����Vm"),
		DLG_TEXT(STARTX+250, STARTY+700, 200, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+450, STARTY+700, 250, 65, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GUIDEVM, "��ħVm"),
		
		DLG_EDIT( STARTX+700,STARTY+570 , 300, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA1, 12,  ""),
		DLG_EDIT( STARTX+700,STARTY+635 , 300, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA2, 12,  ""),
		DLG_EDIT( STARTX+700,STARTY+700 , 300, 65, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, BLACK, EDTCTRLBK, EDT_DATA3, 12,  ""),
		
		DLG_COMBO (STARTX+700, STARTY+440, 300, 200, 120, 65, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_INSPLACE, 10),	//��ġ����
		DLG_COMBO (STARTX+700, STARTY+505, 300, 200, 120, 65, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SEAL, 10),		//���޻���
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),

		//���� ����
		DLG_TEXT(0,    STARTY+940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE, "1"),
		DLG_TEXT(333,  STARTY+940, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO, "2"),
		DLG_TEXT(666,  STARTY+940, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR, "4"),
		DLG_TEXT(333, STARTY+1030, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE, "5"),
		DLG_TEXT(666, STARTY+1030, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX, "6"),
		DLG_TEXT(0,   STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+1120, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+1120, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE, "9"),
		DLG_TEXT(333, STARTY+1210, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO, "0"),
		DLG_TEXT(666, STARTY+1210, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL, "��"),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�跮�� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

//		DLG_BUTTON(STARTX+525, STARTY+100, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
//		DLG_BUTTON(STARTX+775, STARTY+100, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),	

		DLG_BUTTON(STARTX,	   STARTY+720, 280, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "����"),
		DLG_BUTTON(STARTX, 	   STARTY+810, 140, 89, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEE, "���"),
		DLG_BUTTON(STARTX+140, STARTY+810, 140, 89, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+280, STARTY+810, 140, 89, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ETC, "*"),
		DLG_BUTTON(STARTX+420, STARTY+810, 140, 89, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+560, STARTY+810, 145, 89, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "����"),
		DLG_BUTTON(STARTX+705, STARTY+810, 145, 89, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTRSC, "����"),
		DLG_BUTTON(STARTX+850, STARTY+810, 150, 89, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPLETE, "�Ϸ�"),

		//DLG_TEXT(STARTX,     STARTY+100, 200, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),	//������
		
		DLG_TEXT(STARTX,      STARTY+80, 1000, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, ""),	//�ּ�
		DLG_TEXT(STARTX, 	 STARTY+150, 300, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MTRNAME, "�跮���Ī"),
		DLG_TEXT(STARTX+300, STARTY+150, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX, 	 STARTY+220, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_RATE, "���"),
		DLG_TEXT(STARTX+250, STARTY+220, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX+450, STARTY+220, 120, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MODEL, "��"),
		DLG_TEXT(STARTX+570, STARTY+220, 430, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX, 	 STARTY+290, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_FORM, "����"),
		DLG_TEXT(STARTX+250, STARTY+290, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+450, STARTY+290, 120, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "��ǰ"),
		DLG_TEXT(STARTX+570, STARTY+290, 430, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX, 	 STARTY+360, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VALIDDT, "��ȿ�Ⱓ"),
		DLG_TEXT(STARTX+250, STARTY+360, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX+450, STARTY+360, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_PLACETYPE, "��ġ����"),
		DLG_TEXT(STARTX, 	 STARTY+430, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SUPSTATE, "���޻���"),
		DLG_TEXT(STARTX+250, STARTY+430, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+450, STARTY+430, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SEAL, "���ο���"),
		DLG_TEXT(STARTX, 	 STARTY+500, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LTVC, "����Vc"),
		DLG_TEXT(STARTX+250, STARTY+500, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX+450, STARTY+500, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GUIDEVC, "��ħVc"),
		DLG_TEXT(STARTX, 	 STARTY+570, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LTVA, "����Va"),
		DLG_TEXT(STARTX+250, STARTY+570, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX+450, STARTY+570, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GUIDEVA, "��ħVa"),
		DLG_TEXT(STARTX, 	 STARTY+640, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LTVM, "����Vm"),
		DLG_TEXT(STARTX+250, STARTY+640, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+450, STARTY+640, 250, 70, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GUIDEVM, "��ħVm"),
		
		DLG_EDIT( STARTX+700,STARTY+500 , 300, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1, 9,  ""),
		DLG_EDIT( STARTX+700,STARTY+570 , 300, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA2, 9,  ""),
		DLG_EDIT( STARTX+700,STARTY+640 , 300, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA3, 9,  ""),
				
		DLG_COMBO (STARTX+700, STARTY+360, 300, 200, 100, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_INSPLACE, 10),
		DLG_COMBO (STARTX+700, STARTY+430, 300, 200, 100, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SEAL, 10),
		
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
	};		
	
	//  ���̾�α�:�跮������
	//---------------------------------------------------------------
	DlgObject	DlgRes_MTRCHK[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�跮�� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

/*
		//2�� ����, ǻ����, Ÿ�̸���, ȣ������ ���ұ�� �̵�.

		DLG_BUTTON(STARTX+700,	    STARTY, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "����"),
		DLG_BUTTON(STARTX+700,	 STARTY+70, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2,  "����"),
		DLG_BUTTON(STARTX+650,	STARTY+300, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1,  "����"),
		DLG_BUTTON(STARTX+50,	STARTY+300, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "�ݱ�"),
		
		DLG_TEXT ( STARTX+50 ,	    STARTY, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA24, "�跮��"),
		DLG_TEXT ( STARTX+300,	    STARTY, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),

		DLG_TEXT ( STARTX+50 ,	 STARTY+70, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA26, "ȣ��"),
		DLG_TEXT ( STARTX+300,	 STARTY+70, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		DLG_TEXT ( STARTX+50 ,	STARTY+140, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA28, "ǻ����"),
		DLG_TEXT ( STARTX+50 ,	STARTY+210, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA29, "Ÿ�̸���"),
		
		DLG_COMBO (STARTX+300,  STARTY+140, 650, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 4),		//ǻ����
		DLG_COMBO (STARTX+300,  STARTY+210, 650, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 4),	//Ÿ�̸���
*/
		DLG_BUTTON(STARTX+700,	 STARTY-29, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "����"),
		DLG_BUTTON(STARTX,	    STARTY+150, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "�ݱ�"),
		DLG_BUTTON(STARTX+600,	STARTY+150, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1,  "����"),
		
		DLG_TEXT ( STARTX ,	     STARTY-29, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "�跮��"),
		DLG_TEXT ( STARTX+300,	 STARTY-29, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
	};

	//  ���̾�α�:�跮������
	//---------------------------------------------------------------
	DlgObject	DlgRes_MTRCHK_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�跮�� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

/*
		//2�� ����, ǻ����, Ÿ�̸���, ȣ������ ���ұ�� �̵�.
		
		DLG_BUTTON(STARTX+700,	    STARTY, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "����"),
		DLG_BUTTON(STARTX+700,	 STARTY+70, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK2,  "����"),
		DLG_BUTTON(STARTX+650,	STARTY+300, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1,  "����"),
		DLG_BUTTON(STARTX+50,	STARTY+300, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "�ݱ�"),
		
		DLG_TEXT ( STARTX+50 ,	    STARTY, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA24, "�跮��"),
		DLG_TEXT ( STARTX+300,	    STARTY, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT ( STARTX+50 ,	 STARTY+70, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA26, "ȣ��"),
		DLG_TEXT ( STARTX+300,	 STARTY+70, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		DLG_TEXT ( STARTX+50 ,	STARTY+140, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA28, "ǻ����"),
		DLG_TEXT ( STARTX+50 ,	STARTY+210, 250, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA29, "Ÿ�̸���"),
		
		DLG_COMBO (STARTX+300,  STARTY+140, 650, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 4),		//ǻ����
		DLG_COMBO (STARTX+300,  STARTY+210, 650, 200, 150, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 4),	//Ÿ�̸���
*/

		DLG_BUTTON(STARTX+700,	 STARTY-40, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHECK1,  "����"),
		DLG_BUTTON(STARTX,		STARTY+150, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE,  "�ݱ�"),
		DLG_BUTTON(STARTX+600,	STARTY+150, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1,  "����"),
		
		DLG_TEXT ( STARTX,		 STARTY-40, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "�跮��"),
		DLG_TEXT ( STARTX+300,	 STARTY-40, 400, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
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
				SetCombo();
				
				if( g_lSCMoveFlag == 0 && g_lPAYFlag == 0)
				{
					m_lActIndex = g_nActIndex;
					m_lindex = g_lindex;
				}
				else if( g_lSCMoveFlag == 1 && g_lPAYFlag == 0 )
				{
					ON_DRAW();
					g_lSCMoveFlag = 0;
					m_lIdxFlag = 1;
					ON_EXIT();
					OnInit(INIT_MTRCHK);
					break;
				}
				else if( g_lSCMoveFlag == 0 && g_lPAYFlag == 1)
				{
					g_lSCMoveFlag = 0;
					m_lIdxFlag = 1;
					//g_lPAYFlag = 0;
				}

				SetData();
				REDRAW();
				break;
			case INIT_MTRCHK:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_MTRCHK_P, SIZEOF(DlgRes_MTRCHK_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_MTRCHK, SIZEOF(DlgRes_MTRCHK));
						break;
				}
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				MTRCHK_DRAW();
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
	void	SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTRNAME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_RATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MODEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FORM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VALIDDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PLACETYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUPSTATE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SEAL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_LTVC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GUIDEVC), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_INSPLACE), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEAL), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_ADDR), TRUE, 2, EDITSEP_NONE );
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				//������
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			}
		}
		else if( m_bFirst == INIT_MTRCHK )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE);
		}
		
		return;
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long lCnt = 0;
		char szSql[200];
	
		switch(ID)
		{
			case BID_PREVLST:
				SaveInput();
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					//SetData();
					//REDRAW();
					return;
				}
				m_lIdxFlag = 0;
				m_lSelIndex = 0;
				SetData();
				REDRAW();
				break;
			case BID_NEXTLST:
				SaveInput();
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					//SetData();
					//REDRAW();
					break;
				}
				m_lIdxFlag = 0;
				m_lSelIndex = 0;
				SetData();
				REDRAW();
				break;
			case BID_PHOTO:
				Shoto_Photo();
				break;
			case BID_FEE:
				if(  MessageBoxEx (CONFIRM_YESNO, "��ݳ����� Ȯ���Ͻðڽ��ϱ�?")  == MB_OK )
				{
					SaveInput();

					g_lPAYFlag = 0;
					g_nPhotoFlag = 2;
					
					Mem_Set((byte*)g_szSubCHK_EXEC_NUM, 0x00, sizeof(g_szSubCHK_EXEC_NUM));	
					Str_Cpy(g_szSubCHK_EXEC_NUM, m_szCHK_EXEC_NUM);
					Str_Cpy(g_szMTR_NUM, stScMtr.MTR_NUM);	//�跮���ȣ
					Str_Cpy(g_szUSE_CONT_NUM, m_szUSE_CONT_NUM);	// ����ȣ
					Card_Move("GM_PAYHSTR");
				}
				
				break;
			case BID_PREVPG:
				Clear_Flag();
				PrevPG();
				//Clear_DRAW();
				SetStyle();
				SetData();
				REDRAW();
				break;
			case BID_ETC:
				Clear_Flag();
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_NEXTPG:
				Clear_Flag();
				NextPG();
				//Clear_DRAW();
				SetStyle();
				SetData();
				REDRAW();
				break;
			case BID_SAVE:
				Save_Main();
				//SetData();
				//REDRAW();
				break;
			case BID_MTRSC:
				ShowSip(FALSE);
				g_Sipflag = 0;

				SaveInput();
				
				if( Validate() )
				{
					ON_EXIT();
					OnInit(INIT_MTRCHK);
				}
				break;
			case BID_COMPLETE:
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				//2016-05-23 Sanghyun Lee , ����� �跮�� ���� �ľ�
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_MTR WHERE CHK_EXEC_NUM ='%s' ",m_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetInt( szSql, &lCnt );
				if( lCnt > 0)
				{
					lCnt = 0;
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_MTR WHERE CHK_EXEC_NUM ='%s' AND (CHK_RSLT IS NULL OR CHK_RSLT = '') ", g_szCHK_EXEC_NUM, 0, 0);
					g_Sql_RetInt(szSql, &lCnt);
					if( lCnt > 0 )
					{
						MessageBoxEx (CONFIRM_OK, "�跮�⸦ �����ϼ���");
						break;
					}
				
					if( Str_Cmp(stScMtr.SEND_YN, "N") == 0 || Str_Cmp(stScMtr.SEND_YN, "") == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "��ħ�� �����ϼ���!");
						break;
					}
					
					SaveInput();
					if( Update_Result() )
					{
						g_lSCMoveFlag = 0;
						Card_Move("SC_START");
					}
				}
				else
				{
					SaveInput();
					if( Update_Result() )
					{
						g_lSCMoveFlag = 0;
						Card_Move("SC_START");
					}
				}
				break;
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
					{
						g_Del_ScData();
					}
					Card_Move("MENU");	
				}
				break;
			case GID_MENU:
				if( g_Dlgflag > 0 )
				{
					return;
				}
			
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( MessageBoxEx (CONFIRM_YESNO, "�������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
					{
						g_Del_ScData();
					}
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
				if( MessageBoxEx (CONFIRM_YESNO, "SOS ���ȣ���� �Ͻðڽ��ϱ�?") == MB_OK )
				{
					g_Send_SOS(1);
				}
				break;				
			case GID_PREV:
				if( g_Dlgflag > 0 )
				{
					return;
				}
			
				ShowSip(FALSE);
				g_Sipflag = 0;

				Mem_Set((byte*)g_szSubCHK_EXEC_NUM, 0x00, sizeof(g_szSubCHK_EXEC_NUM));	
				Mem_Set((byte *)g_szIndi_Vm, 0x00, sizeof(g_szIndi_Vm));
				Mem_Set((byte *)g_szIndi_Va, 0x00, sizeof(g_szIndi_Va));
				Mem_Set((byte *)g_szIndi_Vc, 0x00, sizeof(g_szIndi_Vc));
				Mem_Set((byte *)g_szMtr_Loc_Flag, 0x00, sizeof(g_szMtr_Loc_Flag));
				Mem_Set((byte *)g_szSealed_Sts, 0x00, sizeof(g_szSealed_Sts));		
				g_lSCMoveFlag = 0;
				g_lDataflag = 0;
				Card_Move("SC_START");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
				{
					g_Exit_DelScData();
					return;
				}
				g_Exit();
				return;
//�跮������
			case BID_CHECK1:
				g_nWorkChkFlag = 11;
				g_lSCMoveFlag = 1;
				Str_Cpy(stScNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stScNogood.CHK_SEC_CD, "50");
				Str_Cpy(stScNogood.MTR_NUM, stScMtr.MTR_NUM);
				Str_Cpy(stScNogood.BURNER_NUM, "");
				Str_Cpy(stScNogood.CHK_SEC_NM, "�跮��");
				Card_Move("CHK_DTL");
				break;
			case BID_CHECK2:
				g_nWorkChkFlag = 11;
				g_lSCMoveFlag = 1;
				Str_Cpy(stScNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stScNogood.CHK_SEC_CD, "60");
				Str_Cpy(stScNogood.MTR_NUM, stScMtr.MTR_NUM);
				Str_Cpy(stScNogood.BURNER_NUM, "");
				Str_Cpy(stScNogood.CHK_SEC_NM, "ȣ��");
				Card_Move("CHK_DTL");
				break;
			case BID_OK1:
				if( Save_Mtr() )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			
		}
	}

	//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		char szVc[10];
		long nLen;
		
		if( m_bFirst == INIT_MAIN )
		{
			//�Է� �� ��뷮 �ڵ� ���
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
			{
				if( Str_Cmp(stScMtr.MTR_GRD, "2.5") == 0 )
				{
					Mem_Set( (byte*)szVc, 0x00, sizeof(szVc));
					Str_Cpy( szVc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));

					if( Str_AtoI(szVc) > Str_AtoI(stScMtr.INDI_VC)+255 )
					{
						MessageBoxEx (CONFIRM_OK, "�ִ��Է°��� �ʰ��Ͽ����ϴ�.\nȮ���� �ּ���");
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
					}
				}
				else if( Str_Cmp(stScMtr.MTR_GRD, "3") == 0 || Str_Cmp(stScMtr.MTR_GRD, "4") == 0 )
				{
					
					Mem_Set( (byte*)szVc, 0x00, sizeof(szVc));
					Str_Cpy( szVc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));

					if( Str_AtoI(szVc) > Str_AtoI(stScMtr.INDI_VC)+360 )
					{
						MessageBoxEx (CONFIRM_OK, "�ִ��Է°��� �ʰ��Ͽ����ϴ�.\nȮ���� �ּ���");
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
					}
				}
				else if( Str_Cmp(stScMtr.MTR_GRD, "6") == 0 )
				{
					
					Mem_Set( (byte*)szVc, 0x00, sizeof(szVc));
					Str_Cpy( szVc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));

					if( Str_AtoI(szVc) > Str_AtoI(stScMtr.INDI_VC)+540 )
					{
						MessageBoxEx (CONFIRM_OK, "�ִ��Է°��� �ʰ��Ͽ����ϴ�.\nȮ���� �ּ���");
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1));
					}
				}
				
				nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				if( nLen > 9 )
				{
					MessageBoxEx(ERROR_OK, "�Է� �ڸ����� �ʰ��Ͽ����ϴ�.");
					ON_KEY( 5 );
				}
			}
			
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) && nChar != 5 )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
				return;
			}
		}
	}
	
	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( m_bFirst == INIT_MAIN )
		{
			if( Str_Cmp(stScMtr.COMPENS_YN, "Y") == 0 )
			{
				if( POINTING_UP == nAction )
				{
					if( theDevInfo.m_nType > FAMILY_PDA )
					{
						m_lActiveIndex = lActiveIndex;
					
						if( X > DMS_X(STARTX+700) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+570-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+635-(g_Dlgflag*400)) ||
						    X > DMS_X(STARTX+700) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+635-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+700-(g_Dlgflag*400)) ||
						    X > DMS_X(STARTX+700) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+700-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+765-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
							{
								g_Dlgflag = 0;
								g_MOVE_DLG(400);
							
							//	ShowSip(FALSE);
							//	g_Sipflag = 0;
								
								//SetKeyMode(KEYMODE_NUMBER);
				
							//	ShowSip(TRUE);
							//	g_Sipflag = 1;
							}
						}
						else
						{
							if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400))  )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '1' );
									VM_PlaySound("1");
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '2' );
									VM_PlaySound("2");
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '3' );
									VM_PlaySound("3");
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '4' );
									VM_PlaySound("4");
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '5' );
									VM_PlaySound("5");
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '6' );
									VM_PlaySound("6");
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '7' );
									VM_PlaySound("7");
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '8' );
									VM_PlaySound("8");
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '9' );
									VM_PlaySound("9");
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1210-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '0' );
									VM_PlaySound("0");
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1210-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_KEY( 5 );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else
							{
									g_Dlgflag = 1;
									g_MOVE_DLG(1);
								
									ShowSip(FALSE);
									g_Sipflag = 0;
							}
						}
					}
				}
			}
			else
			{
				if( POINTING_UP == nAction )
				{
					if( theDevInfo.m_nType > FAMILY_PDA )
					{
						m_lActiveIndex = lActiveIndex;
					
						if( X > DMS_X(STARTX+700) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+570-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+635-(g_Dlgflag*400)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )	
							{
								g_Dlgflag = 0;
								g_MOVE_DLG(400);
							
							//	ShowSip(FALSE);
							//	g_Sipflag = 0;
								
								//SetKeyMode(KEYMODE_NUMBER);
				
							//	ShowSip(TRUE);
							//	g_Sipflag = 1;
							}
						}
						else
						{
							if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400))  )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '1' );
									VM_PlaySound("1");
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '2' );
									VM_PlaySound("2");
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '3' );
									VM_PlaySound("3");
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '4' );
									VM_PlaySound("4");
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '5' );
									VM_PlaySound("5");
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '6' );
									VM_PlaySound("6");
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '7' );
									VM_PlaySound("7");
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '8' );
									VM_PlaySound("8");
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '9' );
									VM_PlaySound("9");
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1210-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '0' );
									VM_PlaySound("0");
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1210-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_KEY( 5 );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else
							{
									g_Dlgflag = 1;
									g_MOVE_DLG(1);
								
									ShowSip(FALSE);
									g_Sipflag = 0;
							}
						}
					}
				}
			}

			ON_DRAW();
		}
		
Finally:
		return;
	}

//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		char sztmp[200];
		char szSql[300];
		long i, index;
	
		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_lSelIndex = index - 1;
				g_nActRow = m_lpage*ROW + m_lSelIndex;

				Str_Cpy(stScMtr.MTR_ID_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));
				SetClickData();
				REDRAW();
				
				return;
			}

			if( Str_Cmp(stScMtr.REMOTE_MTR_YN, "Y") == 0)
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE);	
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), GREEN);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
			}
			else
			{
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_INSPLACE)), "����") == 0 )
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), GREEN);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
				}
				else
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE);
				}
			}
			// 2022-12-08 ������
			// AMI �跮���� ��� ���� �Կ�
			// if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_INSPLACE)), "����") == 0 )
			// {
			// 	DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE);
			// }
			// else
			// {
			// 	DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE);
			// }

			//���ο���
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEAL)), CHKMTR_SEAL );
			if (i == -1)
			{
				Str_Cpy(stScMtr.SEALED_STS, "");
			}
			else
			{
				Str_Cpy(stScMtr.SEALED_STS, CHKMTR_SEAL[i].Code);
			}
		}
		else if( INIT_MTRCHK == m_bFirst )
		{
/*
			//2�� ����, ǻ����, Ÿ�̸���, ȣ������ ���ұ�� �̵�.
			//������
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), SC_MTRFUSE );
			if (i == -1)
			{
				Str_Cpy(stScMtr.FUSE_COCK_INST_YN, "");
			}
			else
			{
				Str_Cpy(stScMtr.FUSE_COCK_INST_YN, SC_MTRFUSE[i].Code);
			}
			//Ÿ�̸���
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), SCTIMER_COCK );
			if (i == -1)
			{
				Str_Cpy(stScMtr.TIMER_COCK_INST_YN, "");
			}
			else
			{
				Str_Cpy(stScMtr.TIMER_COCK_INST_YN, SCTIMER_COCK[i].Code);
			}
*/
		}
	}

//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;
		
		//PRINT("nEvent : %d , nData : %d",nEvent,nData,0);
		CloseMessageBox();
		
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_CAMERA )
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
					SPRINT (g_szphoto, "%s/%s", PHOTO_SCMTR,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);
					
					MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
					REDRAW();
					return;
				}
			}
		}

		ON_DRAW();
		return;
	}

//----------------------------------------------------------------------------------------------
//2018-01-30 Sanghyun Lee
//PM80 ī�޶� �̺�Ʈ �޴°�.
	void	OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		char szTmp[256];
		
		int size = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			if (nEvent == UART_CAMERA)
			{
				if(nData == 1 )
				{
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
					SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
					
					if( FFS_Exist(szfilenm) )
					{
						//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h�� ���ǵǾ�����
						//2018-02-07 Sanghyun Lee PM80ī�޶� ���� �뷮 �����ڵ�
						//ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);
	
						//2018-02-07 Sanghyun Lee PM80ī�޶� ���� �뷮 �������� �ʰ� ���� ���� ���������� ����
						// 1MB �ʰ��� ���� ���� �ȵǰ���
						size = FFS_GetSize( szfilenm );

						if( size > 1048576 )
						{
							MessageBoxEx (CONFIRM_OK, "���� �뷮�� �ʰ��Ͽ����ϴ�.\nī�޶� ���� Ȥ�� ���Կ����ּ���.");
						}
						else
						{
							MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
							
							FFS_Copy(szfilenm, g_szphoto);
							VmSleep(100);
							
							Mem_Set((byte*)stScMtr.INSIDE_MTR_PHOTO_ID, 0x00, sizeof(stScMtr.INSIDE_MTR_PHOTO_ID));
							Str_Cpy(stScMtr.INSIDE_MTR_PHOTO_ID, "Y");
							
							Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
							SPRINT(szTmp, "UPDATE NORMAL_MTR SET INSIDE_MTR_PHOTO_ID = 'Y' WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
							g_Sql_DirectExecute(szTmp);
							
							VmSleep(100);
						}
						
						VmSleep(100);
						FFS_Delete( szfilenm );
						VmSleep(100);
						
						REDRAW();
					}
				}
			}
		}
		
		return;
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
				return i;
		}
		
		return -1;
	}

//------------------------------------------------------------------
	void SetCombo(void)
	{
		long i;
	
		if( INIT_MAIN == m_bFirst )
		{	//��ġ����, ���ο���
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30002' AND ITEM_KNAME IS NOT NULL GROUP BY ITEM_KNAME", CMB_INSPLACE+2);

			for ( i = 0 ;  CHKMTR_SEAL[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SEAL+2), CHKMTR_SEAL[i].Str, 0, ICON_NONE);
			}
		}
/*
		//2�� ����, ǻ����, Ÿ�̸���, ȣ������ ���ұ�� �̵�.

		else if( INIT_MTRCHK == m_bFirst )
		{	//������, Ÿ�̸��� , stScMtr.FUSE_COCK_INST_YN, SC_MTRFUSE );
			//g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30023' AND ITEM_KNAME IS NOT NULL GROUP BY ITEM_KNAME", CMB_DATA1+2);
			for ( i = 0 ;  SC_MTRFUSE[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), SC_MTRFUSE[i].Str, 0, ICON_NONE);
			}
			for ( i = 0 ;  SCTIMER_COCK[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), SCTIMER_COCK[i].Str, 0, ICON_NONE);
			}
		}
*/
	}

//------------------------------------------------------------------
	void SetData(void)
	{
		long i, idx, j, n;
		long lRowid;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		char sztmp[200];
		char szSql[800];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		if( g_lSCMoveFlag == 0 )
		{
			Mem_Set((byte*)&stScMtr, 0x00, sizeof(stScMtr));
		}
		
		//����&���� ��ư�� ��� ������ CHK_EXEC_NUM �� ������� �κ�.
		Mem_Set((byte*)m_szCHK_EXEC_NUM, 0x00, sizeof(m_szCHK_EXEC_NUM));
		if( m_lMoveFlag == 1 )
		{
			lindex = g_SREACHFILE_GetSeq(SREACH_FILE, m_lActIndex);
			SPRINT(szSql, "SELECT CHK_EXEC_NUM FROM NORMAL_DATA WHERE ROWID = '%d'",lindex, 0, 0   );
			g_Sql_RetStr( szSql, 12, m_szCHK_EXEC_NUM );
		
			Mem_Set((byte*)g_szSubCHK_EXEC_NUM, 0x00, sizeof(g_szSubCHK_EXEC_NUM));	
			Str_Cpy(g_szSubCHK_EXEC_NUM, m_szCHK_EXEC_NUM);
		}
		else
		{
			if( g_lPAYFlag == 0 )
			{
				Str_Cpy(m_szCHK_EXEC_NUM, g_szCHK_EXEC_NUM);
			}
			else
			{
				Str_Cpy(m_szCHK_EXEC_NUM, g_szSubCHK_EXEC_NUM);

				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(sztmp, "SELECT ROWID FROM NORMAL_DATA  WHERE CHK_EXEC_NUM = '%s' ORDER BY HOUSE_NUM_ORD, DONG_ORD ",m_szCHK_EXEC_NUM, 0, 0   );
				g_Sql_RetInt( sztmp, &lRowid );
			
				m_lActIndex = g_Get_FsIndex(lRowid, SREACH_FILE);
				
				g_lPAYFlag = 0;
			}
		}
		
		//������
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM NORMAL_MTR  WHERE CHK_EXEC_NUM = '%s' ",m_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( sztmp, &m_lTotpage );

		/*
			if( m_lTotpage % ROW > 0 )
			{
				m_lTotpage = (m_lTotpage / ROW) + 1;
			}
			else
			{
				m_lTotpage = m_lTotpage / ROW;
			}

			2016-05-11 Sanghyun Lee
			�跮�Ⱑ 1�� �̻��� ��� �� ���� �� ������ ����
			if(m_lIdxFlag == 1)
			{
				m_lpage = g_nActRow / ROW;
				m_lSelIndex = (g_nActRow % ROW);
			}
		*/

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT MTR_ID_NUM, MTR_LOC_FLAG, CHK_RSLT, COMPENS_YN, CHK_EXEC_NUM \
		                      , ADDR1_M, ADDR1_S, CO_LIVE_NM, HOUSE_CNT, BLD_NM, ETC_ADDR , REMOTE_MTR_YN \
		                   FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ORDER BY MTR_NUM LIMIT ?, ? "
		      , m_szCHK_EXEC_NUM, 0, 0 );
		
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
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
					continue;
				}
				//�⹰��ȣ
				idx = 0;
				Mem_Set( (byte*)stScMtr.MTR_ID_NUM, 0x00, sizeof(stScMtr.MTR_ID_NUM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_ID_NUM          , 20 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, stScMtr.MTR_ID_NUM );
				//��ġ��ġ
				Mem_Set( (byte*)stScMtr.MTR_LOC_FLAG, 0x00, sizeof(stScMtr.MTR_LOC_FLAG) );
				sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_LOC_FLAG        , 2  + 1, DECRYPT );
				if( Str_Cmp(stScMtr.MTR_LOC_FLAG, "10") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "����" );
				else if ( Str_Cmp(stScMtr.MTR_LOC_FLAG, "20") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 1,  "�ܺ�");
				//����, Decode(CHK_RSLT,'Y','����','N','������','��Ȯ��')
				Mem_Set( (byte*)stScMtr.CHK_RSLT, 0x00, sizeof(stScMtr.CHK_RSLT) );
				sql->GetValue( sql, idx++, 'U', (long*) stScMtr.CHK_RSLT            , 1  + 1, DECRYPT );

				if( Str_Cmp(stScMtr.CHK_RSLT, "Y") == 0 )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
				}
				else if( Str_Cmp(stScMtr.CHK_RSLT, "N") == 0 )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), RED);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "������" );
				}
				else
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle 	( ID_TBLLIST, i, 2 ), TXTFRCOLOR);
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "��Ȯ��" );
				}

				//�����⿩��
				Mem_Set( (byte*)stScMtr.COMPENS_YN, 0x00, sizeof(stScMtr.COMPENS_YN) );
				sql->GetValue( sql, idx++, 'U', (long*) stScMtr.COMPENS_YN          , 1  + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, stScMtr.COMPENS_YN );
				
				if( i == 0 )
				{
					sql->GetValue( sql, idx++, 'U', (long*) stScMtr.CHK_EXEC_NUM        , 12 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'U', (long*) stScMtr.ADDR1_M             , 30 + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'U', (long*) stScMtr.ADDR1_S             , 30 + 1, DECRYPT );	
					sql->GetValue( sql, idx++, 'U', (long*) stScMtr.CO_LIVE_NM          , 60 + 1, DECRYPT );	
					sql->GetValue( sql, idx++, 'U', (long*) stScMtr.HOUSE_CNT           , 6  + 1, DECRYPT );
					sql->GetValue( sql, idx++, 'U', (long*) stScMtr.BLD_NM              , 150+ 1, DECRYPT );
					sql->GetValue( sql, idx++, 'U', (long*) stScMtr.ETC_ADDR            , 100+ 1, DECRYPT );	
					sql->GetValue( sql, idx++, 'U', (long*) stScMtr.REMOTE_MTR_YN       , 1+ 1, DECRYPT );	
				}
			}
		}	

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if(m_lTotpage > 0  )
		{
			if( m_lSelIndex == -1 )
			{
				m_lSelIndex = 0;
			}
			
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);
				
			Str_Cpy(stScMtr.MTR_ID_NUM , DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));
			
			SetClickData();
		}
		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : SetClickData
	��  �� : �跮�⸦ ���������� ������ ���� ����
	Param  : 
	Return : 
	========================================================================================*/	
	void SetClickData(void)
	{
		long i, idx, j, n;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		char szSql[800];
		char sztmp[11];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT MTR_DETA_LOC, MTR_GRD, MTR_MODEL_NM, MTR_FORM_NM \
		                      , PROD_NM, MTR_VALID_YM, MTR_LOC_FLAG, MTR_SUPPLY_STS, SEALED_STS, INDI_VC, INDI_VC_CUR, INDI_VA, INDI_VA_CUR, MTR_INDI \
		                      , MTR_INDI_CUR, COMPENS_YN, MTR_NUM, FUSE_COCK_INST_YN, TIMER_COCK_INST_YN, SEND_YN, INST_PLACE_NUM, INSIDE_MTR_PHOTO_ID \
		                   FROM NORMAL_MTR WHERE CHK_EXEC_NUM = ? AND MTR_ID_NUM = '%s' "
		      , stScMtr.MTR_ID_NUM, 0, 0 );
		
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&m_szCHK_EXEC_NUM, 12, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{
			idx = 0;
			//�跮���Ī(����ġ)
			Mem_Set( (byte*)stScMtr.MTR_DETA_LOC, 0x00, sizeof(stScMtr.MTR_DETA_LOC) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_DETA_LOC        , 30 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11)   , stScMtr.MTR_DETA_LOC);
			//���
			Mem_Set( (byte*)stScMtr.MTR_GRD, 0x00, sizeof(stScMtr.MTR_GRD) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_GRD             , 8  + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12)   , stScMtr.MTR_GRD);
			//��
			Mem_Set( (byte*)stScMtr.MTR_MODEL_NM, 0x00, sizeof(stScMtr.MTR_MODEL_NM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_MODEL_NM        , 50 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13)   , stScMtr.MTR_MODEL_NM);
			//����
			Mem_Set( (byte*)stScMtr.MTR_FORM_NM, 0x00, sizeof(stScMtr.MTR_FORM_NM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_FORM_NM         , 30 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA14)   , stScMtr.MTR_FORM_NM);
			//��ǰ
			Mem_Set( (byte*)stScMtr.PROD_NM, 0x00, sizeof(stScMtr.PROD_NM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.PROD_NM             , 50 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15)   , stScMtr.PROD_NM);
			//��ȿ�Ⱓ
			Mem_Set( (byte*)stScMtr.MTR_VALID_YM, 0x00, sizeof(stScMtr.MTR_VALID_YM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_VALID_YM        , 6  + 1, DECRYPT );
			g_Str_DateType( sztmp, stScMtr.MTR_VALID_YM);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), sztmp);
			//��ġ����
			Mem_Set( (byte*)stScMtr.MTR_LOC_FLAG, 0x00, sizeof(stScMtr.MTR_LOC_FLAG) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_LOC_FLAG        , 2  + 1, DECRYPT );	
			if( g_lDataflag == 0 )
			{
				if( Str_Cmp(stScMtr.REMOTE_MTR_YN, "Y") == 0)
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), GREEN);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
				}
				else
				{
					if( Str_Cmp(stScMtr.MTR_LOC_FLAG, "10") == 0 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_INSPLACE)   , "����");
						
						DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE);
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), GREEN);
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
					}
					else if( Str_Cmp(stScMtr.MTR_LOC_FLAG, "20") == 0 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_INSPLACE)   , "�ܺ�");			

						DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE);
					// DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE);
					}
				}
				
			}
			else
			{
				if( Str_Cmp(stScMtr.REMOTE_MTR_YN, "Y") == 0)
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), GREEN);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
				}
				else
				{
					if( Str_Cmp(g_szMtr_Loc_Flag, "10") == 0 )
					{
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_INSPLACE)   , "����");

					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), GREEN);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
					}
					else if( Str_Cmp(g_szMtr_Loc_Flag, "20") == 0 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_INSPLACE)   , "�ܺ�");

						DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE);
					// DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE);
					// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), GREEN);
					// ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
					}

				}
				
			}
			//���޻���
			Mem_Set( (byte*)stScMtr.MTR_SUPPLY_STS, 0x00, sizeof(stScMtr.MTR_SUPPLY_STS) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_SUPPLY_STS      , 2  + 1, DECRYPT );
			if( Str_Cmp(stScMtr.MTR_SUPPLY_STS, "10") == 0 )
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)   , "����");
			else if ( Str_Cmp(stScMtr.MTR_SUPPLY_STS, "20") == 0 )
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)   , "����");
			else if ( Str_Cmp(stScMtr.MTR_SUPPLY_STS, "30") == 0 )
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)   , "����");
			else if ( Str_Cmp(stScMtr.MTR_SUPPLY_STS, "40") == 0 )
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)   , "����");
			else if ( Str_Cmp(stScMtr.MTR_SUPPLY_STS, "50") == 0 )
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)   , "����");
			else if ( Str_Cmp(stScMtr.MTR_SUPPLY_STS, "60") == 0 )
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)   , "�簳��/�����");
			//���ο���
			Mem_Set( (byte*)stScMtr.SEALED_STS, 0x00, sizeof(stScMtr.SEALED_STS) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.SEALED_STS          , 2  + 1, DECRYPT );
			if( g_lDataflag == 0 )
			{
				n = SearchCD( stScMtr.SEALED_STS, CHKMTR_SEAL );
				if( n >= 0 )
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SEAL)   , CHKMTR_SEAL[n].Str);
				else
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SEAL)   , "");
			}
			else
			{
				n = SearchCD( g_szSealed_Sts, CHKMTR_SEAL );
				if( n >= 0 )
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SEAL)   , CHKMTR_SEAL[n].Str);
				else
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SEAL)   , "");
			}
			//����vc
			Mem_Set( (byte*)stScMtr.INDI_VC, 0x00, sizeof(stScMtr.INDI_VC) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.INDI_VC             , 9  + 1, DECRYPT );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18)   , stScMtr.INDI_VC);

			//��ħvc
			Mem_Set( (byte*)stScMtr.INDI_VC_CUR, 0x00, sizeof(stScMtr.INDI_VC_CUR) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.INDI_VC_CUR         , 9  + 1, DECRYPT );
			if( g_lDataflag == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1)   , stScMtr.INDI_VC_CUR);
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1)   , g_szIndi_Vc);
			}

			//����va
			Mem_Set( (byte*)stScMtr.INDI_VA, 0x00, sizeof(stScMtr.INDI_VA) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.INDI_VA             , 9  + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20)   , stScMtr.INDI_VA);
			//��ħva
			Mem_Set( (byte*)stScMtr.INDI_VA_CUR, 0x00, sizeof(stScMtr.INDI_VA_CUR) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.INDI_VA_CUR         , 9  + 1, DECRYPT );
			if( g_lDataflag == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2)   , stScMtr.INDI_VA_CUR);
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2)   , g_szIndi_Va);
			}
			//����vm
			Mem_Set( (byte*)stScMtr.MTR_INDI, 0x00, sizeof(stScMtr.MTR_INDI) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_INDI            , 9  + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22)   , stScMtr.MTR_INDI);
			//��ħvm
			Mem_Set( (byte*)stScMtr.MTR_INDI_CUR, 0x00, sizeof(stScMtr.MTR_INDI_CUR) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_INDI_CUR        , 9  + 1, DECRYPT );
			if( g_lDataflag == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3)   , stScMtr.MTR_INDI_CUR);
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3)   , g_szIndi_Vm);
			}
			//�����⿩��
			Mem_Set( (byte*)stScMtr.COMPENS_YN, 0x00, sizeof(stScMtr.COMPENS_YN) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.COMPENS_YN          , 1  + 1, DECRYPT );
			//�跮���ȣ
			Mem_Set( (byte*)stScMtr.MTR_NUM, 0x00, sizeof(stScMtr.MTR_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.MTR_NUM             , 9  + 1, DECRYPT );
			//������
			Mem_Set( (byte*)stScMtr.FUSE_COCK_INST_YN, 0x00, sizeof(stScMtr.FUSE_COCK_INST_YN) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.FUSE_COCK_INST_YN   , 1  + 1, DECRYPT );
			//Ÿ�̸���
			Mem_Set( (byte*)stScMtr.TIMER_COCK_INST_YN, 0x00, sizeof(stScMtr.TIMER_COCK_INST_YN) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.TIMER_COCK_INST_YN  , 1  + 1, DECRYPT );
			//SEND_YN ���忩��.
			Mem_Set( (byte*)stScMtr.SEND_YN, 0x00, sizeof(stScMtr.SEND_YN) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.SEND_YN  , 1  + 1, DECRYPT );
			//INST_PLACE_NUM ���忩��.
			Mem_Set( (byte*)stScMtr.INST_PLACE_NUM, 0x00, sizeof(stScMtr.INST_PLACE_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.INST_PLACE_NUM  , 10 + 1, DECRYPT );
			
			//INSIDE_MTR_PHOTO_ID ���忩��
			Mem_Set( (byte*)stScMtr.INSIDE_MTR_PHOTO_ID, 0x00, sizeof(stScMtr.INSIDE_MTR_PHOTO_ID) );
			sql->GetValue( sql, idx++, 'U', (long*) stScMtr.INSIDE_MTR_PHOTO_ID  , 30 + 1, DECRYPT );
			
			Mem_Set((byte*)m_szUSE_CONT_NUM, 0x00, sizeof(m_szUSE_CONT_NUM));
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT USE_CONT_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'",m_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr( szSql, 11, m_szUSE_CONT_NUM );
			
			Mem_Set((byte*)stScMtr.CUST_NM, 0x00, sizeof(stScMtr.CUST_NM));
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT CUST_NM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'",m_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr( szSql, 30, stScMtr.CUST_NM );
			
			Mem_Set((byte*)stScMtr.CUST_NUM, 0x00, sizeof(stScMtr.CUST_NUM));
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT CUST_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'",m_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr( szSql, 10, stScMtr.CUST_NUM );

		}
	
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Prev_SC
	��  �� : ���� ��ư�� ��������� ã�´�.
	Param  : 
	Return : ���� �ƹ��͵� �ڵ����� ����.(��ħ �ڵ� �״��)
	========================================================================================*/
	void PrevPG(void)
	{
		if( m_lActIndex > 0 )
		{
			m_lActIndex--;
			m_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, m_lActIndex);
		}
		else
		{
			m_lActIndex = -1;
		}
		
		if( m_lActIndex < 2 )
		{	//�˻� ��, ù��° �� �޼��� �ڽ� ����
			m_lPrev--;
		}

		if( m_lindex <= 0 || m_lActIndex < 0 )
		{
			m_lActIndex = 0;
			m_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, m_lActIndex);

			if( m_lPrev < 0 )
			{
				m_lPrev = 0;
				//MessageBoxEx (CONFIRM_OK, "ù��°���� �Դϴ�!");
			}
		}
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

		m_lActIndex++;
		m_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, m_lActIndex);

//�˻� & ���͸� ���� ������ ������ üũ.
		if( m_lActIndex > m_lTotCnt || m_lindex < 0 )
		{
			if( g_SREACHFILE_GetSeq(SREACH_FILE, m_lActIndex) < m_lActIndex )
			{
				m_lActIndex = m_lActIndex-1;
			}
			m_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, m_lActIndex);
			
			//MessageBoxEx (CONFIRM_OK, "���������� �Դϴ�!");
		}
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
	
//------------------------------------------------------------------	
	void Clear_DRAW(void)
	{
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA14)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_INSPLACE), "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SEAL)    , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1)   , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2)   , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22)  , "");
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3)   , "");
	}
	
//------------------------------------------------------------------	
//��,�� ȭ�� �̵��� �ش� ���� ���� flag �ʱ�ȭ
	void Clear_Flag(void)
	{
		m_lMoveFlag = 1;
		m_lpage = 0;
		m_lSelIndex = 0;
		m_lIdxFlag = 0;

		g_lDataflag = 0;		
		Mem_Set((byte *)g_szIndi_Vm, 0x00, sizeof(g_szIndi_Vm));
		Mem_Set((byte *)g_szIndi_Va, 0x00, sizeof(g_szIndi_Va));
		Mem_Set((byte *)g_szIndi_Vc, 0x00, sizeof(g_szIndi_Vc));
	}
	
//------------------------------------------------------------------
	void REDRAW(void)
	{
		char szBld[50];
		char szColive[50];
		char sztmp[400];
		long nLength = 0;
		
		m_lTotCnt = FS_GetSrchTotCnt();

		//COMPENS_YN -> Y�� �� �����ְ�, N�̸� VA,VM �ؽ�Ʈ ���� 
		if( Str_Cmp(stScMtr.COMPENS_YN, "Y") == 0 )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_LTVA), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GUIDEVA), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_LTVM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GUIDEVM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_LTVA), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA20), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_GUIDEVA), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_LTVM), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_GUIDEVM), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE);
		}
		else
		{
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_LTVA), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA20), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_GUIDEVA), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_LTVM), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_GUIDEVM), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE);
		}

		//CHK_EXEC_NUM -> ����ȭ�鿡�� ���� ���� �跮�� �����Ϳ� ������ ����,�Ϸ��ư �����ְ�, �ƴϸ� �Ⱥ�����	
		if( Str_Cmp(g_szCHK_EXEC_NUM, stScMtr.CHK_EXEC_NUM) == 0 || Str_Cmp(stScMtr.CHK_EXEC_NUM, "") == 0 )
		{
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_MTRSC), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_COMPLETE), TRUE);
		}
		else
		{
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_MTRSC), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_COMPLETE), FALSE);
		}

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		g_Str_trimcpy(szColive, stScMtr.CO_LIVE_NM, Str_Len(stScMtr.CO_LIVE_NM));
		g_Str_trimcpy(szBld, stScMtr.BLD_NM, Str_Len(stScMtr.BLD_NM));
		nLength = Str_Len(szColive) + Str_Len(szBld);
		if( nLength > 0   )
		{
			Str_Cpy(sztmp, stScMtr.ADDR1_M);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stScMtr.ADDR1_S);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, szColive);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, szBld);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stScMtr.HOUSE_CNT);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR), sztmp);
		}
		else
		{
			Str_Cpy(sztmp, stScMtr.ADDR1_M);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stScMtr.ADDR1_S);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stScMtr.HOUSE_CNT);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stScMtr.ETC_ADDR);
			Str_Cat(sztmp, " ");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR), sztmp);
		}
		
		if( Str_Cmp(stScMtr.SEND_YN, "S") == 0 || Str_Cmp(stScMtr.SEND_YN, "Y") == 0 )
		{
			//ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SAVE), RED);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SAVE), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNMENUFRCOLOR);
		}
		else
		{
			//ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNMENUFRCOLOR);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNCTRLBKCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNMENUFRCOLOR);
		}
		
		//BID_PHOTO
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(m_szfilenm, "E");				
		Str_Cat(m_szfilenm, m_szCHK_EXEC_NUM);
		Str_Cat(m_szfilenm, "_");
		//Str_Cat(m_szfilenm, "M");				
		Str_Cat(m_szfilenm, stScMtr.MTR_NUM);
		Str_Cat(m_szfilenm, "_");
		//Str_Cat(m_szfilenm, "I");				
		Str_Cat(m_szfilenm, stScMtr.INST_PLACE_NUM);
		Str_Cat(m_szfilenm, ".jjp");
		SPRINT (sztmp, "%s/%s", PHOTO_SCMTR,  m_szfilenm, 0);
		
		/*
		if( FFS_Exist(sztmp) )
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
		}
		else
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
		}
		*/
		// 2017.11.08 �ű�ȣ ���λ��� ���� �߰�
		if( FFS_Exist(sztmp) || Str_Len(stScMtr.INSIDE_MTR_PHOTO_ID) > 0)
		{
			//ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
		}
		else
		{
			//ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
			// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNCTRLBKCOLOR);
			// ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
		}
		
		ON_DRAW();
		return;
	}
	
//------------------------------------------------------------------
	void MTRCHK_DRAW(void)
	{
		long lCount = 0;
		long i;
		char szSql[300];
		char sztmp[100];
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE|EDITALIGN_CENTER);

		//�跮����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND CHK_SEC_CD ='50' ", g_szCHK_EXEC_NUM, stScMtr.MTR_NUM, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA25), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA25), "������");	
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA25), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA25), "����");	
		}
		
		/*
		//2�� ����, ǻ����, Ÿ�̸���, ȣ������ ���ұ�� �̵�.
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);


		//ȣ�����
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND CHK_SEC_CD ='60' ", g_szCHK_EXEC_NUM, stScMtr.MTR_NUM, 0);
		g_Sql_RetInt(szSql, &lCount);
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA27), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA27), "������");	
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA27), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA27), "����");	
		}

		//������
		i = SearchCD( stScMtr.FUSE_COCK_INST_YN, SC_MTRFUSE );
		if(i == -1)
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), SC_MTRFUSE[0].Str);
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), SC_MTRFUSE[i].Str);
		//Ÿ�̸���
		i = SearchCD( stScMtr.TIMER_COCK_INST_YN, SCTIMER_COCK );
		if(i == -1)
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), SCTIMER_COCK[i].Str);
		
		*/
	}
	
//------------------------------------------------------------------------------------------------	
	bool Update_Result(void)
	{
		long lRet;
		long lMtrCnt = 0;
		long lPipeCnt = 0;
		char szSql[300];
		char szDay[14];
		char szTime[14];

		//�跮����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='50' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lMtrCnt);
		
		//��������� - ���ұ��������� �̵�
		//Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		//SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='60' ", g_szCHK_EXEC_NUM, 0, 0);
		//g_Sql_RetInt(szSql, &lPipeCnt);
		
		if( lMtrCnt > 0 || lPipeCnt > 0 )
		{
			Str_Cpy( stSc.MTR_RSLT, "N" );
			Str_Cpy( stSc.NOGOOD_RSLT, "N" );
		}
		else
		{
			Str_Cpy( stSc.MTR_RSLT, "Y" );
		}
		
		//2016-05-23 Sanghyun Lee , �Ϸ��ư Ŭ�� �� SEND_YN = 'S' �ٲ�� ����.
		/*
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE NORMAL_MTR SET SEND_YN = 'S' WHERE CHK_EXEC_NUM = ? AND MTR_ID_NUM = ? "
						, g_szCHK_EXEC_NUM, stScMtr.MTR_ID_NUM, 0);
		g_Sql_DirectExecute( szSql );
		*/

		return TRUE;
	}
	
//------------------------------------------------------------------------------------------------
	bool Save_Mtr(void)
	{
		char szSql[300];
		char sztmp[300];
		long lMtrCnt = 0;
		long lPipeCnt = 0;
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

/*
		//2�� ����, ǻ����, Ÿ�̸���, ȣ������ ���ұ�� �̵�.

		if(Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "ǻ������ �������ּ���.");
			ret = FALSE;
			return ret;
		}
		if(Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) == 0)
		{
			MessageBoxEx (CONFIRM_OK, "Ÿ�̸����� �������ּ���.");
			ret = FALSE;
			return ret;
		}

		//������
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), SC_MTRFUSE );
		if (i == -1)
		{
			Str_Cpy(stScMtr.FUSE_COCK_INST_YN, "");
		}
		else
		{
			Str_Cpy(stScMtr.FUSE_COCK_INST_YN, SC_MTRFUSE[i].Code);
		}
		//Ÿ�̸���
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), SCTIMER_COCK );
		if (i == -1)
		{
			Str_Cpy(stScMtr.TIMER_COCK_INST_YN, "");
		}
		else
		{
			Str_Cpy(stScMtr.TIMER_COCK_INST_YN, SCTIMER_COCK[i].Code);
		}
		//ȣ��
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA27)), "����") == 0 )
		{
			Str_Cpy( stScMtr.PIPE_RSLT, "Y" );
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA27)), "������") == 0 )
		{
			Str_Cpy( stScMtr.PIPE_RSLT, "N" );
		}
*/
		//�跮��
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA25)), "����") == 0 )
		{
			Str_Cpy( stScMtr.MTR_RSLT, "Y" );
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA25)), "������") == 0 )
		{
			Str_Cpy( stScMtr.MTR_RSLT, "N" );
		}
		//�跮����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='50' AND MTR_NUM = '%s' ", g_szCHK_EXEC_NUM, stScMtr.MTR_NUM, 0);
		g_Sql_RetInt(szSql, &lMtrCnt);

		//��������� - ���ұ��������� �̵�
		//Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		//SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='60' AND MTR_NUM = '%s' ", g_szCHK_EXEC_NUM, stScMtr.MTR_NUM, 0);
		//g_Sql_RetInt(szSql, &lPipeCnt);
		
		if( lMtrCnt > 0 || lPipeCnt > 0 )
			Str_Cpy(stScMtr.CHK_RSLT, "N" );
		else
			Str_Cpy(stScMtr.CHK_RSLT, "Y" );

		//�۽ſ���
		Str_Cpy(stScMtr.SEND_YN, "S" );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
/*
		SPRINT(szSql, "UPDATE NORMAL_MTR SET \
			MTR_RSLT = ?, PIPE_RSLT = ?, FUSE_COCK_INST_YN = ?, TIMER_COCK_INST_YN = ?, CHK_RSLT = ?, PDA_IP = ?, UPD_EMPID = ?, SEND_YN = ? \
			WHERE CHK_EXEC_NUM = '%s' AND MTR_ID_NUM = '%s' "
			, g_szCHK_EXEC_NUM, stScMtr.MTR_ID_NUM, 0);
*/
		//2�� ����, ǻ����, Ÿ�̸���, ȣ������ ���ұ�� �̵�.
		SPRINT(szSql, "UPDATE NORMAL_MTR SET \
			MTR_RSLT = ?, PIPE_RSLT = ?, CHK_RSLT = ?, PDA_IP = ?, UPD_EMPID = ?, SEND_YN = ? \
			WHERE CHK_EXEC_NUM = '%s' AND MTR_ID_NUM = '%s' "
			, g_szCHK_EXEC_NUM, stScMtr.MTR_ID_NUM, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScMtr.MTR_RSLT			  ,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScMtr.PIPE_RSLT		  ,1 ,DECRYPT);
		//sql->Bind(sql, idx++, 'U', (long *)stScMtr.FUSE_COCK_INST_YN  ,1 ,DECRYPT);
		//sql->Bind(sql, idx++, 'U', (long *)stScMtr.TIMER_COCK_INST_YN ,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScMtr.CHK_RSLT			  ,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip		  ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id    ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScMtr.SEND_YN			  ,1 ,DECRYPT);
/*
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM       		  ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM		  ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE      		  ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR      		  ,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER     		  ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM        		  ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM       		  ,6 ,DECRYPT);
*/

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//------------------------------------------------------------------------------------------------
	void Save_Main(void)
	{
		char szSql[300];
		char sztmp[50];
		char szDay[10];
		char szTime[10];
		long idx, ret, i;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		//��ġ��ġ
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_INSPLACE)) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30002' AND ITEM_KNAME = '%s' ",sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 10, stScMtr.MTR_LOC_FLAG );

		//���ο���
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEAL)), CHKMTR_SEAL );
		if (i == -1)
		{
			Str_Cpy(stScMtr.SEALED_STS, "");
		}
		else
		{
			Str_Cpy(stScMtr.SEALED_STS, CHKMTR_SEAL[i].Code);
		}

		if( Str_Cmp(stScMtr.COMPENS_YN, "Y") == 0)
		{
			//VM
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) > 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), "") != 0 )
			{
				Str_Cpy( stScMtr.MTR_INDI_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��ħVM�� �Է��ϼ���!");
				goto Finally2;
			}
			//VA
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) > 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), "") != 0 )
			{
				Str_Cpy( stScMtr.INDI_VA_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��ħVA�� �Է��ϼ���!");
				goto Finally2;
			}
			//VC
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) > 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)), "") != 0 )
			{
				Str_Cpy( stScMtr.INDI_VC_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��ħVC�� �Է��ϼ���!");
				goto Finally2;
			}
		}
		else
		{
			//VC
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) > 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)), "") != 0 )
			{
				Str_Cpy( stScMtr.INDI_VC_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��ħVC�� �Է��ϼ���!");
				goto Finally2;
			}
		}
		
		Mem_Set( (byte*)szDay, 0x00, sizeof(szDay) );
		Mem_Set( (byte*)szTime, 0x00, sizeof(szTime) );
		Str_ItoA(Time_GetDate(), szDay, 10);
		g_Str_TimeType( szTime, Time_GetTime() );
		Str_Cpy(stScMtr.VISIT_DTM, szDay);
		Str_Cat(stScMtr.VISIT_DTM, szTime);
		
		Str_Cpy(stScMtr.SEND_YN, "S" );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		if( Str_Cmp(stScMtr.COMPENS_YN, "Y") == 0)
		{
			SPRINT(szSql, "UPDATE NORMAL_MTR SET \
MTR_LOC_FLAG = ?, SEALED_STS = ?, INDI_VC_CUR = ?, INDI_VA_CUR = ?, MTR_INDI_CUR = ?, VISIT_DTM = ?, SEND_YN = ?, PDA_IP = ?, UPD_EMPID = ? \
WHERE CHK_EXEC_NUM = ? AND MTR_ID_NUM = ? "
			, 0, 0, 0);
		}
		else
		{
			SPRINT(szSql, "UPDATE NORMAL_MTR SET \
MTR_LOC_FLAG = ?, SEALED_STS = ?, INDI_VC_CUR = ?,INDI_VA_CUR = '0', MTR_INDI_CUR = '0', VISIT_DTM = ?, SEND_YN = ?, PDA_IP = ?, UPD_EMPID = ? \
WHERE CHK_EXEC_NUM = ? AND MTR_ID_NUM = ? "
			, m_szCHK_EXEC_NUM, stScMtr.MTR_ID_NUM, 0);
		}

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		if( Str_Cmp(stScMtr.COMPENS_YN, "Y") == 0)
		{
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.MTR_LOC_FLAG		,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.SEALED_STS		,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.INDI_VC_CUR		,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.INDI_VA_CUR		,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.MTR_INDI_CUR		,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.VISIT_DTM		,14,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.SEND_YN   		,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip		,32,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id  ,20,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)m_szCHK_EXEC_NUM		,12	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.MTR_ID_NUM	,20	,DECRYPT);
		}
		else
		{
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.MTR_LOC_FLAG	,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.SEALED_STS	,2	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.INDI_VC_CUR	,9	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.VISIT_DTM	,14	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.SEND_YN   		,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip		,32,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id  ,20,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)m_szCHK_EXEC_NUM		,12	,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScMtr.MTR_ID_NUM	,20	,DECRYPT);
		}

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			if( Str_Cmp(stScMtr.SEND_YN, "S") == 0 || Str_Cmp(stScMtr.SEND_YN, "Y") == 0 )
			{
				//ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SAVE), RED);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SAVE), RED);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNMENUFRCOLOR);
			}
			else
			{
				//ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNMENUFRCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SAVE), BTNMENUFRCOLOR);
			}

			MessageBoxEx (CONFIRM_OK, "����Ǿ����ϴ�.");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

Finally2:
		
		return;
	}
	
	
//======================================================================================================
//�ٸ� ���� ȭ��, �˾�â�� ���ǵ� ���� ��ħ��� ȭ������ ���ƿ��� �Էµ��ִ� ���� �ٽ� ���ü��ֵ��� �ϱ�����.
	void SaveInput(void)
	{
		char szSql[200];
		char szTmp[20];
		long i;
	
		Mem_Set((byte *)g_szIndi_Vm, 0x00, sizeof(g_szIndi_Vm));
		Mem_Set((byte *)g_szIndi_Va, 0x00, sizeof(g_szIndi_Va));
		Mem_Set((byte *)g_szIndi_Vc, 0x00, sizeof(g_szIndi_Vc));
		
		g_lDataflag = 1;

		if( Str_Cmp(stScMtr.COMPENS_YN, "Y") == 0 )
		{
			Str_Cpy(g_szIndi_Vm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Cpy(g_szIndi_Va, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			Str_Cpy(g_szIndi_Vc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		}
		else
		{
			Str_Cpy(g_szIndi_Vc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		}
		
		Mem_Set((byte *)g_szMtr_Loc_Flag, 0x00, sizeof(g_szMtr_Loc_Flag));
		Mem_Set((byte *)g_szSealed_Sts, 0x00, sizeof(g_szSealed_Sts));		
		//��ġ��ġ
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_INSPLACE)) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30002' AND ITEM_KNAME = '%s' ",szTmp, 0, 0   );
		g_Sql_RetStr( szSql, 10, g_szMtr_Loc_Flag );

		//���ο���
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEAL)), CHKMTR_SEAL );
		if (i == -1)
		{
			Str_Cpy(g_szSealed_Sts, "");
		}
		else
		{
			Str_Cpy(g_szSealed_Sts, CHKMTR_SEAL[i].Code);
		}
		
		return;
	}

//======================================================================================================
	bool Validate(void)
	{
		bool bRet = TRUE;
		char sztmp[400];
	
		if( Str_Cmp(stScMtr.COMPENS_YN, "Y") == 0)
		{
			//VM
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3))) > 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), "") != 0 )
			{
				Str_Cpy( stScMtr.MTR_INDI_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��ħVM�� �Է��ϼ���!");
				bRet = FALSE;
				return bRet;
			}
			//VA
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) > 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), "") != 0 )
			{
				Str_Cpy( stScMtr.INDI_VA_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��ħVA�� �Է��ϼ���!");
				bRet = FALSE;
				return bRet;
			}
			//VC
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) > 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), "") != 0 )
			{
				Str_Cpy( stScMtr.INDI_VC_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��ħVC�� �Է��ϼ���!");
				bRet = FALSE;
				return bRet;
			}
		}
		else
		{
			//VC
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) > 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)), "") != 0 )
			{
				Str_Cpy( stScMtr.INDI_VC_CUR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��ħVC�� �Է��ϼ���!!!");
				bRet = FALSE;
				return bRet;
			}
		}
		
		if( Str_Cmp(stScMtr.SEND_YN, "N") == 0 || Str_Cmp(stScMtr.SEND_YN, "") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "��ħ�� �����ϼ���!");
			bRet = FALSE;
			return bRet;
		}

		//BID_PHOTO
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(m_szfilenm, "E");				
		Str_Cat(m_szfilenm, m_szCHK_EXEC_NUM);
		Str_Cat(m_szfilenm, "_");
		//Str_Cat(m_szfilenm, "M");				
		Str_Cat(m_szfilenm, stScMtr.MTR_NUM);
		Str_Cat(m_szfilenm, "_");
		//Str_Cat(m_szfilenm, "I");				
		Str_Cat(m_szfilenm, stScMtr.INST_PLACE_NUM);
		Str_Cat(m_szfilenm, ".jjp");
		SPRINT (sztmp, "%s/%s", PHOTO_SCMTR,  m_szfilenm, 0);

		if (Str_Cmp(stScMtr.REMOTE_MTR_YN, "Y") == 0 )
		{
			if( FFS_Exist(sztmp) || Str_Len(stScMtr.INSIDE_MTR_PHOTO_ID) > 0 ){}
			else
			{
				MessageBoxEx (CONFIRM_OK, "AMI �跮�� ������ �Կ��ϼ���!");
				Shoto_Photo();
				bRet = FALSE;
				return bRet;
			}
			
		}

		// if( Str_Cmp(stScMtr.REMOTE_MTR_YN, "Y") == 0)
		// {
		// 	if (Chk_Photo() > 0)
		// 	{

		// 	}
		// 	else
		// 	{
		// 		MessageBoxEx (CONFIRM_OK, "AMI �跮�� ������ �Կ��ϼ���!");
		// 		Shoto_Photo();
		// 		bRet = FALSE;
		// 		return bRet;
		// 	}
			
		// }

		
		return bRet;
	}
	
//======================================================================================================
	void Shoto_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet;

//     C37(��������) | E(���˽����ȣ) | M(�跮���ȣ) | I(��ġ��ҹ�ȣ) | D( ������¥(SYSDATE : YYYYMMDDHHMMSS )
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Str_Cpy(m_szfilenm, "E");				
		Str_Cat(m_szfilenm, m_szCHK_EXEC_NUM);
		Str_Cat(m_szfilenm, "_");
		//Str_Cat(m_szfilenm, "M");				
		Str_Cat(m_szfilenm, stScMtr.MTR_NUM);
		Str_Cat(m_szfilenm, "_");
		//Str_Cat(m_szfilenm, "I");				
		Str_Cat(m_szfilenm, stScMtr.INST_PLACE_NUM);
		Str_Cat(m_szfilenm, ".jjp");

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_SCMTR,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
				else
		{
			//2018-01-30 Sanghyun Lee
			//PM80 ī�޶� ȣ��
			//��������
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_SCMTR,  m_szfilenm, 0);
			//���Ŀ��� Ȯ�ν�...
			ShootPhoto ( 1, 0, m_szfilenm );
/*
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
*/
		}

		return;
	}
	

	long Chk_Photo(void)
	{
		long lPhotoCnt = 0;
		long lCount = 0;
		long lRet = 0;
		char szSql[400];

		SPRINT(szSql, "SELECT COUNT(1) FROM NORMAL_MTR WHERE CHK_EXEC_NUM ='%s' AND INSIDE_MTR_PHOTO_ID = 'Y'",g_szCHK_EXEC_NUM,0,0);
		g_Sql_RetInt( szSql, &lPhotoCnt );

		if (lPhotoCnt > 0)
		{
			lRet = 1;
		}
		else
		{
			lRet = 0;
		}

		

		return lRet;

	}

	

}


