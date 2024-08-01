/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_RFRMRSK
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
	#define USE_ON_UART
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_REFORM )	//�����Ϸ�
		DEF_BUTTON_ID ( BID_OK1 )		//Ȯ��
		DEF_BUTTON_ID ( BID_PREVLST )
		DEF_BUTTON_ID ( BID_NEXTLST )
		DEF_BUTTON_ID ( BID_REFSCHDL ) //������������
//���������Է�
		DEF_BUTTON_ID ( BID_PHOTO )
		DEF_BUTTON_ID ( BID_OK2 )
		DEF_BUTTON_ID ( BID_CLOSE )
		DEF_BUTTON_ID ( BID_REFSCHDL2 ) //������������
		
		
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
		DEF_OBJECT_ID ( TXT_BSUNIT )		//���˴���
		DEF_OBJECT_ID ( TXT_CMBSTRNUM )		//���ұ��ȣ
		DEF_OBJECT_ID ( TXT_OBJNUM )		//�⹰��ȣ
		DEF_OBJECT_ID ( TXT_VISITDT )		//�湮�Ͻ�
		DEF_OBJECT_ID ( TXT_REFSCHDL2 )		//������������
		DEF_OBJECT_ID ( TXT_NUMBER )		//����
		DEF_OBJECT_ID ( TXT_REFPSSBL )		//��������
		DEF_OBJECT_ID ( TXT_REFORMDT )		//��������
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA11 )
		DEF_OBJECT_ID ( TXT_DATA12 )
		DEF_OBJECT_ID ( TXT_DATA13 )
		DEF_OBJECT_ID ( TXT_DATA14 )
//���������Է�
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA10 )
		DEF_OBJECT_ID ( TXT_DATA15 )
		DEF_OBJECT_ID ( TXT_DATA16 )
		DEF_OBJECT_ID ( TXT_DATA17 )
		DEF_OBJECT_ID ( TXT_DATA18 )

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
//���������Է�
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		
		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( ICON_TITLE )

		DEF_OBJECT_ID ( CMB_DATA1  )
	END_OBJECT_ID()
	
	#define INIT_MAIN	  1
	#define INIT_REFORMDT 2 
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    4					// table�� �ళ��
	#define		COL 	    11					// table�� ������
	#define		GRID_H		(CHT+10)			// table �� ����
	#define		GRID_H_P	(CHT+25)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		201 				    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+65	  	    // table ����y��ǥ
	#define		GRID_Y_P	STARTY-40			// table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�������׸�", CWD*19+23, EDITALIGN_MIDDLE,      TABLE_TEXT, 0},
		{"����������", CWD*12, EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"����",       CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"���˴���",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�⹰��ȣ",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���ұ��ȣ", 0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�湮�Ͻ�",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",       0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"��������",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�׸��ڵ�",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�����ڵ�",   0 , EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
	};
	
	char m_szCnt_page[10];
	char m_szMtr_Num[20];
	char m_szBurner_Num[7];
	char m_szCHK_SEC_CD[3];
	char m_szNOT_PASS_ITEM_CD[3];
	char m_szChk_Cd[5];
	char m_szNotPass_Cd[5];
	char m_szEndDate[20];
	char m_szPlanDate[20];
	char m_szDegree[10];
	long m_lpage = 0;
	long m_lTotpage;
	long m_lActive = -1;
	long m_bFirst;
	long m_lEditCtrlIndex = -1;
	char m_szfilenm[128];

	long Chk_Photo(void);
	
	void SetStyle(void);
	void REDRAW(void);
	void ReformDraw(void);
	bool Save_BetterEnd(void);
	void Save_BetterYn(void);
	void SetBtnImg(void);
	void Shoto_Photo(void);
	bool Validate(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�����ǰ� �����ջ�"),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT( STARTX,     STARTY+315, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500,STARTY+315, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750,STARTY+315, 250, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		
		DLG_TEXT( STARTX,     STARTY+390, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSUNIT, "���˴���"),
		DLG_TEXT( STARTX+350, STARTY+390, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT( STARTX,     STARTY+450, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_TEXT( STARTX+350, STARTY+450, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT( STARTX,     STARTY+510, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "���ұ��ȣ"),
		DLG_TEXT( STARTX+350, STARTY+510, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT( STARTX,     STARTY+570, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "�湮�Ͻ�"),
		DLG_TEXT( STARTX+350, STARTY+570, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_TEXT( STARTX,       STARTY+630, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFSCHDL2, "������������"),
		DLG_EDIT(STARTX+350,    STARTY+630, 170, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+520,    STARTY+630,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+520,    STARTY+660,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, "."),
		DLG_EDIT(STARTX+540,    STARTY+630, 140, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+680,    STARTY+630,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX+680,    STARTY+660,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, "."),
		DLG_EDIT(STARTX+700,    STARTY+630, 140, 60, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+840,  STARTY+630, 160, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL, "��"),
		//DLG_TEXT( STARTX+350, STARTY+620, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		//DLG_BUTTON(STARTX+650,STARTY+620,  75, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL, "��"),
		
		DLG_TEXT(STARTX,     STARTY+690, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFPSSBL, "��������"),
		DLG_TEXT(STARTX+350, STARTY+690, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+700, STARTY+690, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NUMBER, "����"),
		DLG_TEXT(STARTX+850, STARTY+690, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+750, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "��������"),
		DLG_TEXT(STARTX+350, STARTY+750, 325, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_BUTTON(STARTX+675,STARTY+750, 325, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "�����Ϸ�"),
		
		DLG_BUTTON(STARTX+200, STARTY+829, 600, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1, "Ȯ ��"),

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
		//ȭ��ĸ��
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�����ǰ� �����ջ�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),		
		
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-10, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_TEXT( STARTX,     STARTY+275, 350, 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page),
		DLG_BUTTON(STARTX+500,STARTY+275, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750,STARTY+275, 250, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),
		
		DLG_TEXT( STARTX,     STARTY+340, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSUNIT, "���˴���"),
		DLG_TEXT( STARTX+350, STARTY+340, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT( STARTX,     STARTY+400, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_TEXT( STARTX+350, STARTY+400, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT( STARTX,     STARTY+460, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMBSTRNUM, "���ұ��ȣ"),
		DLG_TEXT( STARTX+350, STARTY+460, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT( STARTX,     STARTY+520, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_VISITDT, "�湮�Ͻ�"),
		DLG_TEXT( STARTX+350, STARTY+520, 650, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_TEXT( STARTX,		STARTY+580, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFSCHDL2, "������������"),
		DLG_EDIT(STARTX+350,    STARTY+580, 170, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+520,    STARTY+580,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+520,    STARTY+610,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, "."),
		DLG_EDIT(STARTX+540,    STARTY+580, 140, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+680,    STARTY+580,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX+680,    STARTY+610,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, "."),
		DLG_EDIT(STARTX+700,    STARTY+580, 140, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+840,  STARTY+580, 160, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL, "��"),
		//DLG_TEXT( STARTX+350, STARTY+570, 300, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		//DLG_BUTTON(STARTX+650,STARTY+570,  75, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL, "��"),
		
		DLG_TEXT(STARTX,     STARTY+640, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFPSSBL, "��������"),
		DLG_TEXT(STARTX+350, STARTY+640, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+700, STARTY+640, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NUMBER, "����"),
		DLG_TEXT(STARTX+850, STARTY+640, 150, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+700, 350, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORMDT, "��������"),
		DLG_TEXT(STARTX+350, STARTY+700, 325, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_BUTTON(STARTX+675,STARTY+700, 325, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "�����Ϸ�"),
		
		DLG_BUTTON(STARTX+200, STARTY+780, 600, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1, "Ȯ ��"),
	};
	
	//  ���̾�α�:���������Է�
	//---------------------------------------------------------------
	DlgObject	DlgRes_REFORMDT[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������� �Է�"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX    ,   STARTY+100, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO , "�����Կ�"),
		DLG_BUTTON(STARTX+600,	 STARTY+100, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "Ȯ��"),

		DLG_TEXT ( STARTX,		STARTY-29, 300, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "��������"),
		DLG_EDIT(STARTX+300,    STARTY-29, 185, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+485,    STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+485,    STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA16, "."),
		DLG_EDIT(STARTX+505,    STARTY-29, 150, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 2,  ""),
		DLG_TEXT(STARTX+655,    STARTY-29,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+655,    STARTY+11,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA18, "."),
		DLG_EDIT(STARTX+675,    STARTY-29, 150, 70, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 2,  ""),
		DLG_BUTTON(STARTX+825,	 STARTY-29, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL2, "��"),
		//DLG_TEXT ( STARTX+300,	 STARTY-10, 450, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		//DLG_BUTTON(STARTX+750,	 STARTY-10, 225, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL2,  "��"),
	};
	
	//  ���̾�α�:���������Է�
	//---------------------------------------------------------------
	DlgObject	DlgRes_REFORMDT_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������� �Է�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+600,	 STARTY+100, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "Ȯ��"),

		DLG_TEXT ( STARTX,		STARTY-40, 300, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "��������"),
		DLG_EDIT(STARTX+300,    STARTY-40, 185, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+485,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+485,       STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA16, "."),
		DLG_EDIT(STARTX+505,    STARTY-40, 150, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 2,  ""),
		DLG_TEXT(STARTX+655,    STARTY-40,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+655,       STARTY,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA18, "."),
		DLG_EDIT(STARTX+675,    STARTY-40, 150, 80, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 2,  ""),
		DLG_BUTTON(STARTX+825,	STARTY-40, 175, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL2, "��"),
		//DLG_TEXT ( STARTX+300,	 STARTY-10, 450, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		//DLG_BUTTON(STARTX+750,	 STARTY-10, 225, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFSCHDL2,  "��"),
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
				REDRAW();
				break;

			case INIT_REFORMDT:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_REFORMDT_P, SIZEOF(DlgRes_REFORMDT_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_REFORMDT, SIZEOF(DlgRes_REFORMDT));
						break;		
				}

				SetBtnImg();
				ReformDraw();
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
	void	SetStyle(void)
	{
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSUNIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMBSTRNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISITDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFSCHDL2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NUMBER), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFPSSBL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFORMDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
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

	//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long d, k;
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szTmp[30];
		char szMsg[150];
	
		switch(ID)
		{
			case BID_PREVLST:
				m_lpage -= ROW;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					//MessageBoxEx (CONFIRM_OK, "ù��° ������ �Դϴ�.");
					REDRAW();
					break;
				}
				m_lActive = 0;
				REDRAW();
				break;
			case BID_NEXTLST:
				m_lpage += ROW;
				if( m_lpage >= m_lTotpage )
				{
					m_lpage -= ROW;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					//MessageBoxEx (CONFIRM_OK, "������ ������ �Դϴ�.");
					REDRAW();
					break;
				}
				m_lActive = 0;
				REDRAW();
				break;	
			case BID_REFORM:
				if( Validate() )
				{
					ON_EXIT();
					OnInit(INIT_REFORMDT);

					if( Chk_Photo() > 0 )
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						// SPRINT(szMsg, "1111111111111", 0, 0, 0);
						MessageBoxEx(CONFIRM_OK, szMsg);
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED); 
					}

					return;
				}
/*
				if( MessageBoxEx (CONFIRM_YESNO, "�׸��� �����Ϸ� �ϰڽ��ϱ�?") == MB_OK )
				{
					Load_Calendar_Card();
					d = CalendarDialog(&k);
					Unload_Calendar_Card();
					if(d == 0)
					{
						break;
					}
					else
					{
						Mem_Set((byte*)m_szEndDate, 0x00, sizeof(m_szEndDate));
						Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
						Str_ItoA ( d, m_szEndDate, 10);
						g_Str_DateType(szDate, m_szEndDate);
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), szDate );
					}

					Save_BetterEnd();
					REDRAW();
				}
*/
				break;
			case BID_REFSCHDL:
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
					Mem_Set((byte*)m_szPlanDate, 0x00, sizeof(m_szPlanDate));
					Str_ItoA ( d, m_szPlanDate, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)m_szPlanDate, 4);
					Mem_Cpy((byte *)szMonth, (byte *)m_szPlanDate+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)m_szPlanDate+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );
					//g_Str_DateType(szDate, m_szPlanDate);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), szDate );
				}
				break;
			case BID_OK1:
				PRINT("55555555555555 : %d",g_lGovBetterFlag,0,0);
				if( g_lGovBetterFlag == 1 )
				{
					Card_Move("BS_SPCLBDCHK");
				}
				else if (g_lGovBetterFlag == 2)
				{
					Card_Move("BS_BNCHK");
				}
				else if (g_lGovBetterFlag == 3)
				{
					Card_Move("BS_MTRCHK");
				}
				else{
					Card_Move("BS_RFRMPRGRS");
				}
				
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "Ư������ �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
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
				Card_Move("BS_RFRMPRGRS");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
				
//�����ǰ� �Ϸ�
			case BID_PHOTO:
				
				// if(Chk_Photo() > 0)
				// {
				// 	// ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED); 
				// 	ON_EXIT();
				// 	OnInit(INIT_REFORMDT);
				// }
				// else
				// {	
				// 	Shoto_Photo();
				// }
				Shoto_Photo();

				break;

			case BID_OK2:

					if(Chk_Photo() > 0)
					{	
						Save_BetterEnd();					
						ON_EXIT();
						OnInit(INIT_MAIN);
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "�����Ϸ� �����Կ��� ���ּ���.");
						Shoto_Photo();
						ON_EXIT();
						OnInit(INIT_REFORMDT);
					}
				// }
				break;
			case BID_CLOSE:
				if( Chk_Photo() > 0 )
					{
						MessageBoxEx (CONFIRM_OK, "�������� �Է� �� Ȯ�ι�ư�� �����ּ���.");
					}
					else
					{
						ON_EXIT();
						OnInit(INIT_MAIN);
					}
				
				break;
			case BID_REFSCHDL2:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
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
					Mem_Set((byte*)m_szEndDate, 0x00, sizeof(m_szEndDate));
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_ItoA ( d, m_szEndDate, 10);
					Str_ItoA (Time_GetDate(), szTmp, 10 );

					if( Str_AtoI(szTmp) >= Str_AtoI(m_szEndDate) )
					{
						Str_Chg( m_szEndDate, STRCHG_DEL_NONDIGIT);
					
						Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
						Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
						Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
						Mem_Cpy((byte *)szYear, (byte *)m_szEndDate, 4);
						Mem_Cpy((byte *)szMonth, (byte *)m_szEndDate+4, 2);
						Mem_Cpy((byte *)szDay, (byte *)m_szEndDate+6, 2);
						
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szYear );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szMonth );
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szDay );

						//g_Str_DateType( szTmp, m_szEndDate);
						//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), szTmp );
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "�����Ϸ����� �߸� �����Ǿ����ϴ�.\n �ٽ� �������ּ���.");
						break;
					}
				}
				break;
		}
	}


//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];
		char szDate[10];

		if( m_bFirst == INIT_MAIN )
		{
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
		}
		else if( m_bFirst == INIT_REFORMDT )
		{
			//���ڸ� �Է� ����
			if( (Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex 
			|| Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex
			|| Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex )
			&& (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				ON_KEY( 5 );
				return;
			}
			
			//�����ǰ�����
			if( Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA5)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA6));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
	
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				//PRINT(">>>>>>>>>>>>>>>>>>>>> nRet : %d , nDate : %d , szTmp : %s",nRet,nDate,szTmp);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "��ȿ�� ��¥�� �ƴմϴ�.\n��¥�� Ȯ�����ּ���.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4));
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
				else
				{
					Str_ItoA (Time_GetDate(), szDate, 10 );
					if( Str_AtoI(szDate) <= Str_AtoI(szTmp) )
					{
						Str_Cpy(m_szEndDate, szTmp);
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "�����Ϸ����� �߸� �����Ǿ����ϴ�.\n �ٽ� �������ּ���.");
						
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
						
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4));
						m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					}
					
				}
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
		
		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+520) && Y > DMS_Y(STARTY+630-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+690-(g_Dlgflag*400)) ||
						X > DMS_X(STARTX+540) && X < DMS_X(STARTX+680) && Y > DMS_Y(STARTY+630-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+690-(g_Dlgflag*400)) ||
						X > DMS_X(STARTX+700) && X < DMS_X(STARTX+840) && Y > DMS_Y(STARTY+630-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+690-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);

							ShowSip(FALSE);
							g_Sipflag = 0;
							
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
		}
		else if( m_bFirst == INIT_REFORMDT )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+485) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+505) && X < DMS_X(STARTX+655) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) ||
						X > DMS_X(STARTX+675) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY-29) && Y < DMS_Y(STARTY+41) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex || 
							Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex )	
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
				
				ON_DRAW();
			}
		}
		
		return;
	}


//-------------------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long index = -1;
		long lPage = 0;
		char szTmp[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];

		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		
		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_lActive = index-1;
				//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 3));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 6));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 7));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 2));
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 8));

				//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 1));
				Str_Cpy(szTmp, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 1));
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				
				Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
				Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
				Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
				Mem_Cpy((byte *)szYear, (byte *)szTmp, 4);
				Mem_Cpy((byte *)szMonth, (byte *)szTmp+4, 2);
				Mem_Cpy((byte *)szDay, (byte *)szTmp+6, 2);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
				EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );	

				//Mem_Set( (byte*)m_szMtr_Num, 0x00, sizeof(m_szMtr_Num) );
				//Mem_Set( (byte*)m_szBurner_Num, 0x00, sizeof(m_szBurner_Num) );
				Str_Cpy(m_szMtr_Num, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
				PRINT("ONSELECT MTR :: %d",m_szMtr_Num,0,0);
				Str_Cpy(m_szBurner_Num, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
				Str_Cpy( m_szCHK_SEC_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 9));
				Str_Cpy( m_szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 10));

				lPage = m_lpage + index;
				SPRINT(m_szCnt_page, "%d/%d", lPage, m_lTotpage, 0);
				ON_DRAW();
			}
		}
	}
	
	//------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		long i, idx;
		long k = ROW + 1;
		char sztmp[401];
		char szDate[25];
		char szTime[9];
		char szCat[9];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		long ret = -1;	
		long lstartidx ;
		long lpage;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL  WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( sztmp, &m_lTotpage );

		if( m_lActive == -1 )
		{
			m_lActive = 0;
		}

		lpage = m_lpage + m_lActive;
		SPRINT(m_szCnt_page, "%d/%d", lpage+1, m_lTotpage, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, " SELECT NOT_PASS_ITEM_NM, BETTER_PLAN_YMD, BETTER_YN, CHK_SEC_NM, MTR_NUM, BURNER_NUM, VISIT_DTM, BETTER_DEGREE, BETTER_END_YMD, CHK_SEC_CD, NOT_PASS_ITEM_CD FROM SPECIAL_NOGOOD_DETAL WHERE  CHK_EXEC_NUM = '%s' ORDER BY CHK_SEC_CD, NOT_PASS_ITEM_CD LIMIT ?, ? ",g_szCHK_EXEC_NUM, 0, 0   );
		hstmt = sql->CreateStatement(sql, sztmp);
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
				//������ �׸�
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 33, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				//����������
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 9, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, szDate );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 2, DECRYPT);
				if(sztmp[0] == 'Y')
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 2,  "�̰���");	
				//���˴���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 33, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );			
				//�⹰��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );			
				//���ұ��ȣ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 7, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );	
				
				//�湮�Ͻ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				Mem_Set( (byte*)szTime, 0x00, sizeof(szTime) );
				Mem_Set( (byte*)szCat, 0x00, sizeof(szCat) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 15, DECRYPT);
				Mem_Cpy((byte *)szDate, (byte *)sztmp, 8);
				Mem_Cpy((byte *)szCat, (byte *)sztmp+8, 6);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, szDate );	

				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 3, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, sztmp );	

				//��������
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 9, DECRYPT);
				g_Str_DateType(szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 8, szDate );	

				//���˴����ڵ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 3, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 9, sztmp );	

				//�׸��ڵ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 3, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 10, sztmp );

			}
		}		

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lActive+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActive+1, TABLEACTIVE_COLOR);
	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 3));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 6));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 7));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 2));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 8));
			
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), DlgTbl_GetStr( ID_TBLLIST, m_lActive, 1));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 1));
			Str_Chg(sztmp, STRCHG_DEL_NONDIGIT);
			
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Mem_Cpy((byte *)szYear, (byte *)sztmp, 4);
			Mem_Cpy((byte *)szMonth, (byte *)sztmp+4, 2);
			Mem_Cpy((byte *)szDay, (byte *)sztmp+6, 2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );	

			Mem_Set( (byte*)m_szMtr_Num, 0x00, sizeof(m_szMtr_Num) );
			Mem_Set( (byte*)m_szBurner_Num, 0x00, sizeof(m_szBurner_Num) );
			Mem_Set( (byte*)m_szCHK_SEC_CD, 0x00, sizeof(m_szCHK_SEC_CD) );
			Mem_Set( (byte*)m_szNOT_PASS_ITEM_CD, 0x00, sizeof(m_szNOT_PASS_ITEM_CD) );
			
			Str_Cpy(m_szMtr_Num, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));			
			Str_Cpy(m_szBurner_Num, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));			
			Str_Cpy( m_szCHK_SEC_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 9));			
			Str_Cpy( m_szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 10));
		}
		
		ON_DRAW();
		return;
	}
	
//----------------------------------------------------------------------------------
	bool Save_BetterEnd(void)
	{
		char sztmp[401];
		char szSql[401];
		char szdate[20];
		long idx;
		bool bRet = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)szdate, 0x00, sizeof(szdate) );

		// PRINT("if( FFS_Exist(szPhotopath) )")
		
		
		//���� ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)m_szDegree, 0x00, sizeof(m_szDegree) );
		SPRINT(szSql, "SELECT MAX(BETTER_ADVICE_DEGREE) FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 5, m_szDegree );
	
	
		//Str_Cpy( szDp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA18)));
		Str_Chg( m_szEndDate, STRCHG_DEL_NONDIGIT);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			bRet = FALSE;
			goto Finally;
		}	

		
//�跮���ȣ, ���ұ��ȣ�� where���ǿ� �߰��ؾ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_NOGOOD_DETAL SET BETTER_PLAN_YMD = ?, BETTER_END_YMD= ?, BETTER_DEGREE = ? \
		, BETTER_YN ='Y', UPD_EMPID = ?, PDA_IP = ?, SEND_YN = 'S' \
		  WHERE CHK_EXEC_NUM = ? AND MTR_NUM = ? AND BURNER_NUM = ? AND CHK_SEC_CD = ? AND NOT_PASS_ITEM_CD = ? "
		, 0, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)m_szEndDate              ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szEndDate              ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szDegree               ,3 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id  ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip		,20,DECRYPT);

		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM         ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szMtr_Num              ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szBurner_Num           ,7 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szCHK_SEC_CD		    ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szNOT_PASS_ITEM_CD     ,2 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}
		else
		{
			// if( MessageBoxEx (CONFIRM_OK, "���������� �Կ� ���ּ���") == MB_OK )
			// {
			// 	Shoto_Photo();
			// }	
		}	
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( bRet == TRUE)
		{
			Save_BetterYn();
		}
		
		return bRet;
	}
	
//----------------------------------------------------------------------------------
	void Save_BetterYn(void)
	{
		char szSql[300];
		char szBetter[3];
		char szEndYmd[10];
		long lCnt = 0;
		long idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL)",g_szCHK_EXEC_NUM, stBsMtr.MTR_NUM, 0   );
		g_Sql_RetInt( szSql, &lCnt );
		
		Mem_Set( (byte*)szBetter, 0x00, sizeof(szBetter) );
		Mem_Set( (byte*)szEndYmd, 0x00, sizeof(szEndYmd) );
		if( lCnt > 0 )
		{
			Str_Cpy(szBetter, "N");
			Str_Cpy(szEndYmd, "");
		}
		else
		{
			Str_Cpy(szBetter, "Y");
			Str_Cpy(szEndYmd, m_szEndDate);
		}

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, "UPDATE SPECIAL_NOGOOD_CHA SET BETTER_YN = ?, BETTER_END_YMD = ?, UPD_EMPID = ?, PDA_IP = ? \
		// , CHK_YEAR = ?, CHK_ORDER = ?, SEND_YN = 'S' \
		// WHERE CHK_EXEC_NUM = ? AND BETTER_ADVICE_DEGREE = ? "
		// ,g_szCHK_EXEC_NUM, m_szDegree, 0   );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_NOGOOD_CHA SET BETTER_YN = ?, BETTER_END_YMD = ?, UPD_EMPID = ?, PDA_IP = ? \
		,SEND_YN = 'S' \
		WHERE CHK_EXEC_NUM = ? AND BETTER_ADVICE_DEGREE = ? "
		,g_szCHK_EXEC_NUM, m_szDegree, 0   );
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)szBetter                 ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szEndYmd                 ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id  ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip		,20,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM    ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szDegree          ,3,DECRYPT);

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

void Shoto_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet;
				
		if( m_lActive < 0 )
		{
			MessageBoxEx (ERROR_OK, "�׸��� �����ϼ���.");
			return;
		}

/*
		//���ϸ�
		Mem_Set((byte*)szMTR_NUM, 0x00, sizeof(szMTR_NUM));
		Mem_Set((byte*)szBURNER_NUM, 0x00, sizeof(szBURNER_NUM));
		Mem_Set((byte*)szCHK_SEC_CD, 0x00, sizeof(szCHK_SEC_CD));
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );

		Str_Cpy( szMTR_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 4));
		Str_Cpy( szBURNER_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 5));
		Str_Cpy( szCHK_SEC_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 9));
		Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 10));
*/
		
		Str_Cpy(m_szfilenm , "2");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , g_szCHK_EXEC_NUM);
		Str_Cat(m_szfilenm , "_");
		if(Str_Len(m_szMtr_Num) > 0)
			Str_Cat(m_szfilenm , m_szMtr_Num);
		else
			Str_Cat(m_szfilenm , "000000000");
		Str_Cat(m_szfilenm , "_");
		if(Str_Len(m_szBurner_Num) > 0)
			Str_Cat(m_szfilenm , m_szBurner_Num);
		else
			Str_Cat(m_szfilenm , "000000");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , m_szCHK_SEC_CD);
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , m_szNOT_PASS_ITEM_CD);
		Str_Cat(m_szfilenm , ".jjp");
		
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			g_nPhotoFlag = 2;
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_BS,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//��������
			//Mem_Set((byte*)szScrPht, 0x00, sizeof(szScrPht));
			//SPRINT (g_szphoto, "%s/%s", PHOTO_BS, m_szfilenm,  0);
			//���Ŀ��� Ȯ�ν�...
			//Str_Cpy(szScrPht, szfilenm);
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
	
//----------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		long lrow = 0;
		char szNOT_PASS_ITEM_CD[10];
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
					SPRINT (g_szphoto, "%s/%s", PHOTO_BS,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{	
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);
					
					lrow = m_lActive/COL;
					lrow--;

					// Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
					// Str_Cpy( szNOT_PASS_ITEM_CD, DlgTbl_GetStr( ID_TBLLIST, lrow, 10) );

					Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
					SPRINT(szTmp, "UPDATE SPECIAL_NOGOOD_DETAL SET BETTER_PHOTO = 'Y' WHERE CHK_EXEC_NUM ='%s' and NOT_PASS_ITEM_CD = '%s' and MTR_NUM ='%s'", g_szCHK_EXEC_NUM,m_szNOT_PASS_ITEM_CD,m_szMtr_Num);
					g_Sql_DirectExecute( szTmp );

					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED); 
					
					ON_DRAW();
					MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
					
				}
			}
		}

		ON_DRAW();
		return;
	}
	
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


	long Chk_Photo(void)
	{
		long lPhotoCnt = 0;
		long lCount = 0;
		long lRet = 0;
		char szSql[400];

		SPRINT(szSql, "SELECT COUNT(1) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND BETTER_PHOTO = 'Y' AND NOT_PASS_ITEM_CD = '%s' AND MTR_NUM ='%s' ",g_szCHK_EXEC_NUM,m_szNOT_PASS_ITEM_CD,m_szMtr_Num);
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
	
	
	bool Validate(void)
	{
		char szTmp[20];
		char szSql[300];
		char szDegree[10];
		bool ret = TRUE;
	
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy( szTmp, DlgTbl_GetStr( ID_TBLLIST, m_lActive, 2));
		if( Str_Cmp( szTmp, "����" ) == 0  )
		{
			MessageBoxEx (CONFIRM_OK, "�̹� ���� �Ϸ� �� �׸��Դϴ�.");
			ret = FALSE;
			return ret;	
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szDegree, 0x00, sizeof(szDegree) );
		SPRINT(szSql, "SELECT MAX(BETTER_ADVICE_DEGREE) FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetStr( szSql, 5, szDegree );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szSql, "SELECT BETTER_ADVICE_YMD FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s' AND BETTER_ADVICE_DEGREE = '%s' ", g_szCHK_EXEC_NUM, szDegree, 0   );
		g_Sql_RetStr( szSql, 10, szTmp );
		
		if( Str_AtoI(szTmp) == Time_GetDate() )
		{
			MessageBoxEx (CONFIRM_OK, "�����ǰ� ���� ���Ĵ� �����Ҽ� �����ϴ�.");
			ret = FALSE;
			return ret;	
		}
		
		return ret;
	}
	
//-------------------------------------------------------------------------------------------------
	void ReformDraw(void)
	{
		char szTmp[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
			
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
		
		//�⺻ ���� ��¥ ����
		Mem_Set((byte*)szTmp ,0x00, sizeof(szTmp) );
		Mem_Set((byte*)szDay ,0x00, sizeof(szDay) );
		Mem_Set((byte*)m_szEndDate ,0x00, sizeof(m_szEndDate) );
		Str_ItoA(Time_GetDate(), m_szEndDate, 10);
		
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte *)szYear, (byte *)m_szEndDate, 4);
		Mem_Cpy((byte *)szMonth, (byte *)m_szEndDate+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)m_szEndDate+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), szDay );			
		//Str_Cpy(m_szEndDate, szTmp);
		//g_Str_DateType( szDay, szTmp );
		//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), szDay);
	}
}


