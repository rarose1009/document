/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_RFRMISSU
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_PREVLST )
		DEF_BUTTON_ID ( BID_NEXTLST )
		DEF_BUTTON_ID ( BID_REFORMSCHDL2 )
		DEF_BUTTON_ID ( BID_COMPLETE )
		DEF_BUTTON_ID ( BID_OK )		//Ȯ��
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
		DEF_OBJECT_ID ( TXT_NOFIT )			//�������׸�
		DEF_OBJECT_ID ( TXT_REFORMSCHDL )	//����������
		DEF_OBJECT_ID ( TXT_POSSIBLE )		//����
		DEF_OBJECT_ID ( TXT_SCUNIT )		//���˴���
		DEF_OBJECT_ID ( TXT_ITEMNM )		//�׸��
		DEF_OBJECT_ID ( TXT_OBJNUM )		//�⹰��ȣ
		DEF_OBJECT_ID ( TXT_CMBSTRNUM )		//���ұ��ȣ
		DEF_OBJECT_ID ( TXT_VISITDT )		//�湮�Ͻ�
		DEF_OBJECT_ID ( TXT_REFORMSCHDL2 )	//������������
		DEF_OBJECT_ID ( TXT_REFORMDT )		//��������
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

		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )

		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+10)			// table �� ����
	#define		GRID_H_P	(CHT+25)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		51 				    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+65			// table ����y��ǥ
	#define		GRID_Y_P	STARTY-40			// table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�������׸�",	  CWD*20+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����������",	  CWD*12, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",		  CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���˺ι��ڵ�",  CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�������׸��ڵ�",CWD*0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};
	
	#define INIT_MAIN	1
	
	long m_bFirst;
	long m_lpage = 0;
	long m_lTotCnt = 0;
	long m_lTotpage = 0;
	long m_lSelIndex = -1;
	long m_lSelRow = -1;
	long m_lEditCtrlIndex = -1;
	char m_szCnt_page[10];
	
	void SetStyle(void);
	void SetData(void);
	void SetClickData(void);
	void REDRAW(void);
	bool Save_REFORMSCHDL(void);
	bool Update_Better(void);
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);	    //�ڵ� ���� ã�´�.
	void SetBtnImg(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�����ǰ� ����"),

		DLG_BUTTON(STARTX+500, STARTY+315, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750, STARTY+315, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX+200, STARTY+810, 600, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,     STARTY+315, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),	//������
		DLG_TEXT(STARTX,     STARTY+390, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCUNIT, "���˴���"),
		DLG_TEXT(STARTX+350, STARTY+390, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,     STARTY+450, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ITEMNM, "�׸��"),
		DLG_TEXT(STARTX+350, STARTY+450, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX,     STARTY+510, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_TEXT(STARTX+350, STARTY+510, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX,     STARTY+570, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "���ұ��ȣ"),
		DLG_TEXT(STARTX+350, STARTY+570, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX,     STARTY+630, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "�湮�Ͻ�"),
		DLG_TEXT(STARTX+350, STARTY+630, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		
		DLG_TEXT(STARTX, 	   STARTY+690, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMSCHDL2, "������������"),
		DLG_EDIT(STARTX+350,   STARTY+690, 165, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+515,   STARTY+690,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+515,   STARTY+720,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA24, "."),
		DLG_EDIT(STARTX+535,   STARTY+690, 135, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+670,   STARTY+690,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX+670,   STARTY+720,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA26, "."),
		DLG_EDIT(STARTX+690,   STARTY+690, 135, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+825, STARTY+690, 175, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFORMSCHDL2, "��"),
		//DLG_TEXT(STARTX+350, STARTY+680, 475, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		//DLG_BUTTON(STARTX+825, STARTY+680, 150,   60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORMSCHDL2, "��"),

//		DLG_TEXT(STARTX,     STARTY+740, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "��������"),
//		DLG_TEXT(STARTX+350, STARTY+740, 625, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
	
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�����ǰ� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX+500, STARTY+275, 250, 75, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750, STARTY+275, 250, 75, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		DLG_BUTTON(STARTX+200, STARTY+830, 600, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,     STARTY+275, 350, 75, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),	//������
		DLG_TEXT(STARTX, 	 STARTY+350, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCUNIT, "���˴���"),
		DLG_TEXT(STARTX+350, STARTY+350, 650, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX, 	 STARTY+430, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ITEMNM, "�׸��"),
		DLG_TEXT(STARTX+350, STARTY+430, 650, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX, 	 STARTY+510, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_TEXT(STARTX+350, STARTY+510, 650, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX, 	 STARTY+590, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "���ұ��ȣ"),
		DLG_TEXT(STARTX+350, STARTY+590, 650, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX, 	 STARTY+670, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "�湮�Ͻ�"),
		DLG_TEXT(STARTX+350, STARTY+670, 650, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		
		DLG_TEXT(STARTX,	   STARTY+750, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMSCHDL2, "������������"),
		DLG_EDIT(STARTX+350,   STARTY+750, 165, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+515,   STARTY+750,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+515,   STARTY+790,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA24, "."),
		DLG_EDIT(STARTX+535,   STARTY+750, 135, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+670,   STARTY+750,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX+670,   STARTY+790,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA26, "."),
		DLG_EDIT(STARTX+690,   STARTY+750, 135, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+825, STARTY+750, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFORMSCHDL2, "��"),
		//DLG_TEXT(STARTX+350, STARTY+620, 475, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		//DLG_BUTTON(STARTX+825, STARTY+620, 150,   60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORMSCHDL2, "��"),
//		DLG_TEXT(STARTX, 	 STARTY+740, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "��������"),
//		DLG_TEXT(STARTX+350, STARTY+740, 625, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
	
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-10, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
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
				break;
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
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

	//--------------------------------------------------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SCUNIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ITEMNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMBSTRNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISITDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFORMSCHDL2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		
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
		
		return;
	}

//--------------------------------------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d,k;
		long nRet;
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
	
		switch(ID)
		{
			case BID_PREVLST:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					SetData();
					return;
				}
				SetData();
				break;
			case BID_NEXTLST:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					SetData();
					break;
				}
				SetData();
				break;
			case BID_REFORMSCHDL2:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
//PRINT(">>>>>>>>>>>>>>>>>>>>>>>>>>>>szDate : %s",szDate,0,0);
				k = Str_AtoI(szDate);
			
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
					Str_ItoA ( d, szDate, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
					Mem_Cpy((byte *)szMonth, (byte *)szDate+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)szDate+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );
					//g_Str_DateType( szToday, sztmp);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22), szToday );
				
					//2016-11-17 Sanghyun Lee
					//�޷��Է¼������� OK��ư���� �̵�
					//Save_REFORMSCHDL();
				}
				break;
			case BID_OK:
			/*
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL  WHERE CHK_EXEC_NUM = '%s' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL)",g_szCHK_EXEC_NUM, 0, 0   );
				g_Sql_RetInt( szSql, &nRet );
				if( nRet == 0 )
				{
					Str_Cpy( stSc.LOC_RSLT, "Y");
					Str_Cpy( stSc.MTR_RSLT, "Y");
					Str_Cpy( stSc.BO_RSLT, "Y");
					Str_Cpy( stSc.NOGOOD_RSLT, "Y");
				}
			*/
			
				Save_REFORMSCHDL();
				Card_Move("BS_START");
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
					}
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "Ư������ �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
					{
						g_Del_BsData();
					}
					Card_Move("BS_MENU");
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
				Card_Move("BS_START");
				break;	
			case GID_VMEXIT:
				//g_Exit();
				MessageBoxEx(CONFIRM_OK, "���� ���� �� ��� �� �� �����ϴ�.");
				break;
		}
	}		


//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];

		//���ڸ� �Է� ����
		if( (Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex 
		|| Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex
		|| Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
		&& (nChar < 48 ||  nChar > 57) )
		{
			MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
			ON_KEY( 5 );
			return;
		}
		
		//�����ǰ�����
		if( Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA1)) == 4 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex )
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
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
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
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}

		ON_DRAW();
		return;
	}

	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		//EDITCTRL�� ACTIVE�ÿ� CTRLINDEX�� ����
		//Ű���� BUTTONCTRL�� ACTIVE�ÿ��� EDITCTRL�� Ŀ���� �α����ؼ� INDEX�� ����
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( POINTING_UP == nAction )
		{
			m_lEditCtrlIndex = lActiveIndex;
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+515) && Y > DMS_Y(STARTY+680-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+740-(g_Dlgflag*400)) ||
					X > DMS_X(STARTX+535) && X < DMS_X(STARTX+670) && Y > DMS_Y(STARTY+680-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+740-(g_Dlgflag*400)) ||
					X > DMS_X(STARTX+690) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY+680-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+740-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
					{
						g_Dlgflag = 0;
						g_MOVE_DLG(400);

						ShowSip(FALSE);
						g_Sipflag = 0;
					}
				}
				else
				{
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400))  )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+940-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1030-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1030-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1120-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1120-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1210-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1210-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+1300-(g_Dlgflag*400)) )
					{
						if( g_Dlgflag == 1 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
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
			
			ON_DRAW();
		}
		return;
	}


//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long lActIndex = -1;
	
		//���� TBL�� ���õǾ������� Ȯ��
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// ���� ���õ� �ε���
			lActIndex = DlgTbl_GetActiveRow(ID_TBLLIST);
			
			Str_Cpy(stBsNogood.NOT_PASS_ITEM_NM	, DlgTbl_GetStr( ID_TBLLIST, lActIndex-1, 0));
			Str_Cpy(stBsNogood.CHK_SEC_CD		, DlgTbl_GetStr( ID_TBLLIST, lActIndex-1, 3));
			Str_Cpy(stBsNogood.NOT_PASS_ITEM_CD	, DlgTbl_GetStr( ID_TBLLIST, lActIndex-1, 4));
			
			m_lSelIndex = lActIndex - 1;
			
			SetClickData();
		}
	}
	
//--------------------------------------------------------------------------------------------------------	
	void SetData(void)
	{
		long i, idx, j;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		char sztmp[200];
		char szSql[800];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//������
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( sztmp, &m_lTotpage );
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT NOT_PASS_ITEM_NM, BETTER_PLAN_YMD, BETTER_YN, CHK_SEC_CD, NOT_PASS_ITEM_CD \
		FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' LIMIT ?, ? "
		, g_szCHK_EXEC_NUM, 0, 0);
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
				//�������׸�
				idx = 0;
				Mem_Set( (byte*)stBsNogood.NOT_PASS_ITEM_NM, 0x00, sizeof(stBsNogood.NOT_PASS_ITEM_NM) );
				sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.NOT_PASS_ITEM_NM , 2 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, stBsNogood.NOT_PASS_ITEM_NM );
				//����������
				Mem_Set( (byte*)stBsNogood.BETTER_PLAN_YMD, 0x00, sizeof(stBsNogood.BETTER_PLAN_YMD) );
				sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.BETTER_PLAN_YMD  , 8 + 1, DECRYPT );
				g_Str_DateType( sztmp, stBsNogood.BETTER_PLAN_YMD);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//����
				Mem_Set( (byte*)stBsNogood.BETTER_YN, 0x00, sizeof(stBsNogood.BETTER_YN) );
				sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.BETTER_YN        , 1+ 1, DECRYPT );
				if(stBsNogood.BETTER_YN[0] == 'Y')
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "�̰���");
				//���˺ι��ڵ�
				Mem_Set( (byte*)stBsNogood.CHK_SEC_CD, 0x00, sizeof(stBsNogood.CHK_SEC_CD) );
				sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.CHK_SEC_CD       , 2+ 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, stBsNogood.CHK_SEC_CD );
				//���˺ι��ڵ�
				Mem_Set( (byte*)stBsNogood.NOT_PASS_ITEM_CD, 0x00, sizeof(stBsNogood.NOT_PASS_ITEM_CD) );
				sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.NOT_PASS_ITEM_CD , 2+ 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, stBsNogood.NOT_PASS_ITEM_CD );
			}
		}	
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , 1 );
			DlgTbl_SetRowColor(ID_TBLLIST, 1, TABLEACTIVE_COLOR);
				
			Str_Cpy(stBsNogood.NOT_PASS_ITEM_NM	, DlgTbl_GetStr( ID_TBLLIST, 0, 0));
			Str_Cpy(stBsNogood.CHK_SEC_CD		, DlgTbl_GetStr( ID_TBLLIST, 0, 3));
			Str_Cpy(stBsNogood.NOT_PASS_ITEM_CD	, DlgTbl_GetStr( ID_TBLLIST, 0, 4));
	
			m_lSelIndex = 0;
	
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
		long i, idx, j;
		long n;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		char szSql[300];
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)   , stBsNogood.NOT_PASS_ITEM_NM);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		//BURNER_KIND_NUM = 201 || 301 �̸� ���Ϸ�, �������� ���ұ�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT CHK_SEC_NM, MTR_ID_NUM, BURNER_NUM, VISIT_DTM, BETTER_PLAN_YMD \
		FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = ? AND CHK_SEC_CD = ? AND NOT_PASS_ITEM_CD = ? "
		, 0, 0, 0);
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM, 12, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stBsNogood.CHK_SEC_CD, 2, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stBsNogood.NOT_PASS_ITEM_CD, 2, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{
			idx = 0;
			//���˴���
			Mem_Set( (byte*)stBsNogood.CHK_SEC_NM, 0x00, sizeof(stBsNogood.CHK_SEC_NM) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.CHK_SEC_NM      , 32 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16)   , stBsNogood.CHK_SEC_NM);
			//�⹰��ȣ
			Mem_Set( (byte*)stBsNogood.MTR_ID_NUM, 0x00, sizeof(stBsNogood.MTR_ID_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.MTR_ID_NUM         , 20 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18)   , stBsNogood.MTR_ID_NUM);
			//���ұ��ȣ
			Mem_Set( (byte*)stBsNogood.BURNER_NUM, 0x00, sizeof(stBsNogood.BURNER_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.BURNER_NUM      , 6+ 1, DECRYPT );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19)   , stBsNogood.BURNER_NUM);
			
			//�湮�Ͻ�
			Mem_Set( (byte*)stBsNogood.VISIT_DTM, 0x00, sizeof(stBsNogood.VISIT_DTM) );
			Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.VISIT_DTM       , 14+ 1, DECRYPT );
			g_Str_DateType( szDate, stBsNogood.VISIT_DTM);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), szDate);
			
			//������������
			Mem_Set( (byte*)stBsNogood.BETTER_PLAN_YMD, 0x00, sizeof(stBsNogood.BETTER_PLAN_YMD) );
			Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
			sql->GetValue( sql, idx++, 'U', (long*) stBsNogood.BETTER_PLAN_YMD , 8 + 1, DECRYPT );
			
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Mem_Cpy((byte *)szYear, (byte *)stBsNogood.BETTER_PLAN_YMD, 4);
			Mem_Cpy((byte *)szMonth, (byte *)stBsNogood.BETTER_PLAN_YMD+4, 2);
			Mem_Cpy((byte *)szDay, (byte *)stBsNogood.BETTER_PLAN_YMD+6, 2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );	
			//g_Str_DateType( szDate, stBsNogood.BETTER_PLAN_YMD);
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22)   , szDate);
		}
	
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
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
	
	/*=======================================================================================
	�Լ��� : Update_Better
	��  �� : BETTER_END_YMD ������Ʈ
	Param  : 
	Return :
	========================================================================================*/
/*
	bool Update_Better(void)
	{
		char szSql[300];
		char sztmp[300];
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
				
		Str_Cpy(stBsNogood.BETTER_END_YMD, 	 EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA21)));	//�����Ϸ�����
		Str_Cpy(stBsNogood.BETTER_YN, "Y" );
		Str_Cpy(stBsNogood.SEND_YN, "S" );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_NOGOOD_DETAL SET \
					BETTER_END_YMD = ?, BETTER_YN = ?, SEND_YN = ? \
					WHERE CHK_EXEC_NUM = '%s' AND CHK_SEC_CD = '%s' AND NOT_PASS_ITEM_CD = '%s' " 
					, g_szCHK_EXEC_NUM, stBsNogood.CHK_SEC_CD, stBsNogood.NOT_PASS_ITEM_CD);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.BETTER_END_YMD	,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.BETTER_YN			,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.SEND_YN			,1	,DECRYPT);

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
*/

//===============================================================================
	bool Save_REFORMSCHDL(void)
	{
		char szSql[300];
		char sztmp[300];
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
				
		//Str_Cpy(sztmp, 	 EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA22)));	//������������
		//Str_Chg(sztmp, STRCHG_DEL_NONDIGIT );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Chg(sztmp, STRCHG_DEL_NONDIGIT);


		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, " UPDATE SPECIAL_NOGOOD_DETAL SET BETTER_PLAN_YMD = ? \
WHERE CHK_EXEC_NUM = ? AND CHK_SEC_CD = ? AND NOT_PASS_ITEM_CD = ? ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)sztmp	                    ,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM			    ,12	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.CHK_SEC_CD		,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBsNogood.NOT_PASS_ITEM_CD	,2	,DECRYPT);

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

}


