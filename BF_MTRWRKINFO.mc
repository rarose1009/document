/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BF_MTRWRKINFO
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
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
		DEF_BUTTON_ID ( BID_TAB1 )	//�ü�������
		DEF_BUTTON_ID ( BID_TAB2 )	//�ð�����
		DEF_BUTTON_ID ( BID_OK )	//Ȯ��
		DEF_BUTTON_ID ( BID_PREVPG )
		DEF_BUTTON_ID ( BID_NEXTPG )
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
		DEF_OBJECT_ID ( TXT_DATA29 )
		DEF_OBJECT_ID ( TXT_DATA30 )
		DEF_OBJECT_ID ( TXT_DATA31 )
//TAB2
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
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	
	#define INIT_MAIN	1
	#define INIT_TABTWO 2
	
	handle m_hDlg;
	long m_nOptionSet = 0;		//m_nOptionSet == 0 ��1, m_nOptionSet == 1 ��2
	char m_szgr[10];
	char m_szbj[10];
	char m_sztp[10];	
	long m_lDrawFlag = 0;
	long m_lEditCtrlIndex = -1;
	long m_bFirst;
	
	void SetStyle(void);
//	void SetCombo(void);
//	void REDRAW(void);			//���� ��Ʈ���� ���÷���
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
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
	
	// ���� ���̾�α� , ��1
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�ü��� ��������"),

		DLG_BUTTON(STARTX,      STARTY+70, 280, 59, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "�ü�������"),
		DLG_BUTTON(STARTX+290,  STARTY+70, 280, 59, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "�ð�����"),	
		DLG_BUTTON(STARTX,     STARTY+820, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+310, STARTY+820, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+675, STARTY+820, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,     STARTY+130, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "�����ȣ"),
		DLG_TEXT(STARTX+280, STARTY+130, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""), 
		DLG_TEXT(STARTX,     STARTY+180, 280,100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "�����"), 
		DLG_TEXT(STARTX+280, STARTY+180, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), 
		DLG_TEXT(STARTX+280, STARTY+230, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 
		DLG_TEXT(STARTX,     STARTY+280, 280,100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA6, "�ּ�"),
		DLG_TEXT(STARTX+280, STARTY+280, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+280, STARTY+330, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,     STARTY+380, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA9, "��ȭ��ȣ"),
		DLG_TEXT(STARTX+280, STARTY+380, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX,     STARTY+430, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA11, "�ڵ�����ȣ"),
		DLG_TEXT(STARTX+280, STARTY+430, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,     STARTY+480, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA13, "��û����"),
		DLG_TEXT(STARTX+280, STARTY+480, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+580, STARTY+480, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA15, "��û��"),
		DLG_TEXT(STARTX+780, STARTY+480, 195, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,     STARTY+530, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA17, "�ǹ��Ը�"),
		DLG_TEXT(STARTX+280, STARTY+530, 120, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA18, "����"),
		DLG_TEXT(STARTX+400, STARTY+530, 150, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+550, STARTY+530,  60, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, "��"),
		DLG_TEXT(STARTX+610, STARTY+530, 120, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA21, "����"),
		DLG_TEXT(STARTX+730, STARTY+530, 185, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+915, STARTY+530,  60, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, "��"),
		DLG_TEXT(STARTX,     STARTY+580, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA24, "����������"),
		DLG_TEXT(STARTX+280, STARTY+580, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX,     STARTY+630, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA26, "���޿�����"),
		DLG_TEXT(STARTX+280, STARTY+630, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		DLG_TEXT(STARTX,     STARTY+680, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA28, "���๰�뵵"),
		DLG_TEXT(STARTX+280, STARTY+680, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""),
		DLG_TEXT(STARTX,     STARTY+730, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA30, "���籸��"),
		DLG_TEXT(STARTX+280, STARTY+730, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY+70, 280, 59, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "�ü�������"),
		DLG_BUTTON(STARTX+290,  STARTY+70, 280, 59, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "�ð�����"),	
		DLG_BUTTON(STARTX,     STARTY+820, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+310, STARTY+820, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+675, STARTY+820, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,     STARTY+130, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1, "�����ȣ"),
		DLG_TEXT(STARTX+280, STARTY+130, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""), 
		DLG_TEXT(STARTX,     STARTY+180, 280,100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA3, "�����"), 
		DLG_TEXT(STARTX+280, STARTY+180, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""), 
		DLG_TEXT(STARTX+280, STARTY+230, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 
		DLG_TEXT(STARTX,     STARTY+280, 280,100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA6, "�ּ�"),
		DLG_TEXT(STARTX+280, STARTY+280, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+280, STARTY+330, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX,     STARTY+380, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA9, "��ȭ��ȣ"),
		DLG_TEXT(STARTX+280, STARTY+380, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX,     STARTY+430, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA11, "�ڵ�����ȣ"),
		DLG_TEXT(STARTX+280, STARTY+430, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,     STARTY+480, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA13, "��û����"),
		DLG_TEXT(STARTX+280, STARTY+480, 300, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+580, STARTY+480, 200, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA15, "��û��"),
		DLG_TEXT(STARTX+780, STARTY+480, 195, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX,     STARTY+530, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA17, "�ǹ��Ը�"),
		DLG_TEXT(STARTX+280, STARTY+530, 120, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA18, "����"),
		DLG_TEXT(STARTX+400, STARTY+530, 150, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+550, STARTY+530,  60, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, "��"),
		DLG_TEXT(STARTX+610, STARTY+530, 120, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA21, "����"),
		DLG_TEXT(STARTX+730, STARTY+530, 185, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+915, STARTY+530,  60, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, "��"),
		DLG_TEXT(STARTX,     STARTY+580, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA24, "����������"),
		DLG_TEXT(STARTX+280, STARTY+580, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX,     STARTY+630, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA26, "���޿�����"),
		DLG_TEXT(STARTX+280, STARTY+630, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		DLG_TEXT(STARTX,     STARTY+680, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA28, "���๰�뵵"),
		DLG_TEXT(STARTX+280, STARTY+680, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""),
		DLG_TEXT(STARTX,     STARTY+730, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA30, "���籸��"),
		DLG_TEXT(STARTX+280, STARTY+730, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
	};		
	
	// ���� ���̾�α� , ��2
	//---------------------------------------------------------------
	DlgObject	DlgRes_TABTWO[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�ð�����"),

		DLG_BUTTON(STARTX,      STARTY+70, 280, 59, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "�ü�������"),
		DLG_BUTTON(STARTX+290,  STARTY+70, 280, 59, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "�ð�����"),	
		DLG_BUTTON(STARTX,     STARTY+820, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "��"),
		DLG_BUTTON(STARTX+310, STARTY+820, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "��"),
		DLG_BUTTON(STARTX+675, STARTY+820, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,     STARTY+130, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA32, "�ð���ü"),
		DLG_TEXT(STARTX+280, STARTY+130, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""), 
		DLG_TEXT(STARTX,     STARTY+180, 280,50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA34, "��ü��"), 
		DLG_TEXT(STARTX+280, STARTY+180, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA35, ""), 
		DLG_TEXT(STARTX,     STARTY+230, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA36, "�ð�������"), 
		DLG_TEXT(STARTX+280, STARTY+230, 695,50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(STARTX,     STARTY+280, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA38, "�ڵ���"),
		DLG_TEXT(STARTX+280, STARTY+280, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX,     STARTY+330, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA40, "ȸ����ȭ"),
		DLG_TEXT(STARTX+280, STARTY+330, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(STARTX,     STARTY+380, 280, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA42, "FAX"),
		DLG_TEXT(STARTX+280, STARTY+380, 695, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, ""),
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
					
						SetBtnImg();
						SetStyle();
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						
						SetBtnImg();
						SetStyle();
						break;		
				}
				break;
				
			case INIT_TABTWO:
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes_TABTWO, SIZEOF(DlgRes_TABTWO));
				
				SetBtnImg();
				SetStyle();
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

	//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
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
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_TABTWO )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA32), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}

//-------------------------------------------------------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long i, length;
	
		switch(ID)
		{					
			case BID_TAB1:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_TAB2:
				ON_EXIT();
				OnInit(INIT_TABTWO);
				break;
			case BID_OK:
				break;
			case BID_PREVPG:
				break;
			case BID_NEXTPG:
				break;
			case GID_HOME:
				Card_Move("MENU");
				break;
			case GID_MENU:
				Card_Move("BF_MENU");
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
				Card_Move("BF_MTRLST");
				break;	
			case GID_VMEXIT:
				g_Del_ScData();
				g_Exit();
				break;
		}
	}
	
//-------------------------------------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{	
		char sztmp[50];
		long i;
	}
	
	//------------------------------------------------------------------------
	void	OnKey(long nKey)
	{
		;
	}
	
//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
	/*
		if( 0 == m_nOptionSet )
		{
			//�Է� �� �ڵ�����
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex )
			{
				Str_Cpy(m_stClInfo.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex )
			{
				Str_Cpy(m_stClInfo.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
			{
				Str_Cpy(m_stClInfo.OWNHOUSE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex )
			{
				Str_Cpy(m_stClInfo.OWNHOUSE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
			}

			
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}
		}
		else if( 1 == m_nOptionSet )
		{
			if( Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex )
			{
			//���ڸ� �Է� ����
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}
				Str_Cpy(m_stClInfo2.FIRM_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA6) == m_lEditCtrlIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}

				Str_Cpy(m_stClInfo2.FIRM_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA7) == m_lEditCtrlIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}

				Str_Cpy(m_stClInfo2.FAX_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA8) == m_lEditCtrlIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}

				Str_Cpy(m_stClInfo2.FAX_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA9) == m_lEditCtrlIndex )
			{
				Str_Cpy(m_stClInfo2.EMAIL, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA10) == m_lEditCtrlIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}

				Str_Cpy(m_stClInfo2.FAMILY_CNT, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
			}
		}
	*/
	}
	
//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		//EDITCTRL�� ACTIVE�ÿ� CTRLINDEX�� ����
		//Ű���� BUTTONCTRL�� ACTIVE�ÿ��� EDITCTRL�� Ŀ���� �α����ؼ� INDEX�� ����
		m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
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
}


