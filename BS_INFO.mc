/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_INFO
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CHANGE )	//����
		DEF_BUTTON_ID ( BID_OK )		//Ȯ��
		DEF_BUTTON_ID ( BID_WRITE1 )	//
		DEF_BUTTON_ID ( BID_WRITE2 )	//
		DEF_BUTTON_ID ( BID_WRITE3 )	//
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
		DEF_OBJECT_ID ( TXT_BSNM )			//Ư����
		DEF_OBJECT_ID ( TXT_CMPLTBSDT )		//�ϼ��˻���
		DEF_OBJECT_ID ( TXT_MONTHUSE )		//����뿹����
		DEF_OBJECT_ID ( TXT_CLIENT )		//��ǥ��
		DEF_OBJECT_ID ( TXT_OFFICENUM )		//�繫�ǹ�ȣ
		DEF_OBJECT_ID ( TXT_HPNUM )			//�ڵ�����ȭ
		DEF_OBJECT_ID ( TXT_MANAGER )		//����������
		DEF_OBJECT_ID ( TXT_OFFICENUM2 )	//�繫�ǹ�ȣ
		DEF_OBJECT_ID ( TXT_HPNUM2 )		//�ڵ�����ȣ
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
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		DEF_OBJECT_ID ( EDT_DATA7 )
		DEF_OBJECT_ID ( EDT_DATA8 )
		DEF_OBJECT_ID ( EDT_DATA9 )
		DEF_OBJECT_ID ( EDT_DATA10 )
		DEF_OBJECT_ID ( EDT_DATA11 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( CMB_OFFICENUM )
		DEF_OBJECT_ID ( CMB_HPNUM = CMB_OFFICENUM+3 )
		DEF_OBJECT_ID ( CMB_OFFICENUM2 = CMB_HPNUM+3 )
		DEF_OBJECT_ID ( CMB_HPNUM2 = CMB_OFFICENUM2+3 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	long m_lEditCtrlIndex = -1;
	
	void SetStyle(void);
	void SetBtnImg(void);
	void SetCombo(void);
	void REDRAW(void);
	bool Save_Info(void);
	
	//�Ϻ� ������ ���� �� ������ư�� ������ �ʰ� ��������, ������ ������ stBs ��Ʈ���Ŀ� ����
	//���˵��ȭ������ �����ԵǸ� ����� �����ʹ� �����
	void Save_Struct(void);
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "Ư�� ����"),
				
		// DLG_BUTTON(STARTX,     STARTY+780, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "�� ��"),
		DLG_BUTTON(STARTX+600, STARTY+780, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "����/Ȯ��"),
		
		DLG_TEXT(STARTX,      STARTY+65, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSNM, "Ư����"),
		DLG_BUTTON(STARTX+350,STARTY+65, 650, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE3,  ""),
		DLG_TEXT(STARTX+350,  STARTY+65, 650, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11,  ""),
		//DLG_TEXT(STARTX+350,  STARTY+80, 640, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,     STARTY+135, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMPLTBSDT, "�ϼ��˻���"),
		DLG_TEXT(STARTX+350, STARTY+135, 650, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,     STARTY+205, 350, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MONTHUSE, "����뿹����"),
		DLG_TEXT(STARTX+350, STARTY+205, 650, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),

		DLG_TEXT(STARTX,     STARTY+320, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLIENT, "��ǥ��"),
		DLG_BUTTON(STARTX+300, STARTY+320, 700, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE1,  ""),
		DLG_TEXT(STARTX+300, STARTY+320, 700, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1,  ""),
		DLG_TEXT(STARTX,     STARTY+390, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OFFICENUM, "�繫�ǹ�ȣ"),
		DLG_TEXT(STARTX+590, STARTY+390, 50,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, "-"),
		DLG_EDIT(STARTX+640, STARTY+390, 150, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		DLG_TEXT(STARTX+790, STARTY+390, 50,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, "-"),
		DLG_EDIT(STARTX+840, STARTY+390, 160, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 4,  ""),
		DLG_TEXT(STARTX,     STARTY+460, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HPNUM, "�ڵ�����ȣ"),
		DLG_TEXT(STARTX+590, STARTY+460, 50,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "-"),
		DLG_EDIT(STARTX+640, STARTY+460, 150, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+790, STARTY+460, 50,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, "-"),
		DLG_EDIT(STARTX+840, STARTY+460, 160, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_TEXT(STARTX,     STARTY+530, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MANAGER, "����������"),
		DLG_BUTTON(STARTX+300, STARTY+530, 700, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE2,  ""),
		DLG_TEXT(STARTX+300, STARTY+530, 700, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6,   ""),
		DLG_TEXT(STARTX,     STARTY+600, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OFFICENUM2, "�繫�ǹ�ȣ"),
		DLG_TEXT(STARTX+590, STARTY+600, 50,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, "-"),
		DLG_EDIT(STARTX+640, STARTY+600, 150, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 4,  ""),
		DLG_TEXT(STARTX+790, STARTY+600, 50,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, "-"),
		DLG_EDIT(STARTX+840, STARTY+600, 160, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 4,  ""),
		DLG_TEXT(STARTX,     STARTY+670, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HPNUM2, "�ڵ�����ȣ"),
		DLG_TEXT(STARTX+590, STARTY+670, 50,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, "-"),
		DLG_EDIT(STARTX+640, STARTY+670, 150, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, 4,  ""),
		DLG_TEXT(STARTX+790, STARTY+670, 50,  70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, "-"),
		DLG_EDIT(STARTX+840, STARTY+670, 160, 70, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10, 4,  ""),
		
		DLG_COMBO (STARTX+300, STARTY+390, 290, 200, 100, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_OFFICENUM, 10),
		DLG_COMBO (STARTX+300, STARTY+460, 290, 200, 100, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_HPNUM, 10),
		DLG_COMBO (STARTX+300, STARTY+600, 290, 200, 100, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_OFFICENUM2, 10),
		DLG_COMBO (STARTX+300, STARTY+670, 290, 200, 100, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_HPNUM2, 10),
		
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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "Ư�� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
		
		DLG_BUTTON(STARTX,     STARTY+780, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "�� ��"),
		DLG_BUTTON(STARTX+600, STARTY+780, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),
		
		DLG_TEXT(STARTX,      STARTY-40, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSNM, "Ư����"),
		DLG_EDIT(STARTX+350,  STARTY-40, 650, 80, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11, 100,  ""),
		DLG_TEXT(STARTX,      STARTY+40, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CMPLTBSDT, "�ϼ��˻���"),
		DLG_TEXT(STARTX+350,  STARTY+40, 650, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,     STARTY+120, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MONTHUSE, "����뿹����"),
		DLG_TEXT(STARTX+350, STARTY+120, 650, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),

		DLG_TEXT(STARTX,     STARTY+250, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLIENT, "��ǥ��"),
		DLG_EDIT(STARTX+300, STARTY+250, 700, 80, 0,0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 30,  ""),		
		DLG_TEXT(STARTX,     STARTY+330, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OFFICENUM, "�繫�ǹ�ȣ"),
		DLG_TEXT(STARTX+590, STARTY+330, 50,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, "-"),
		DLG_EDIT(STARTX+640, STARTY+330, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		DLG_TEXT(STARTX+790, STARTY+330, 50,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, "-"),
		DLG_EDIT(STARTX+840, STARTY+330, 160, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 4,  ""),
		DLG_TEXT(STARTX,     STARTY+410, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HPNUM, "�ڵ�����ȣ"),
		DLG_TEXT(STARTX+590, STARTY+410, 50,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, "-"),
		DLG_EDIT(STARTX+640, STARTY+410, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_TEXT(STARTX+790, STARTY+410, 50,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, "-"),
		DLG_EDIT(STARTX+840, STARTY+410, 160, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_TEXT(STARTX,     STARTY+490, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MANAGER, "����������"),
		DLG_EDIT(STARTX+300, STARTY+490, 700, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 32,  ""),
		DLG_TEXT(STARTX,     STARTY+570, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OFFICENUM2, "�繫�ǹ�ȣ"),
		DLG_TEXT(STARTX+590, STARTY+570, 50,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, "-"),
		DLG_EDIT(STARTX+640, STARTY+570, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 4,  ""),
		DLG_TEXT(STARTX+790, STARTY+570, 50,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, "-"),
		DLG_EDIT(STARTX+840, STARTY+570, 160, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 4,  ""),
		DLG_TEXT(STARTX,     STARTY+650, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HPNUM2, "�ڵ�����ȣ"),
		DLG_TEXT(STARTX+590, STARTY+650, 50,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, "-"),
		DLG_EDIT(STARTX+640, STARTY+650, 150, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, 4,  ""),
		DLG_TEXT(STARTX+790, STARTY+650, 50,  80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, "-"),
		DLG_EDIT(STARTX+840, STARTY+650, 160, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10, 4,  ""),
		
		DLG_COMBO (STARTX+300, STARTY+330, 290, 200, 100, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_OFFICENUM, 10),
		DLG_COMBO (STARTX+300, STARTY+410, 290, 200, 100, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_HPNUM, 10),
		DLG_COMBO (STARTX+300, STARTY+570, 290, 200, 100, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_OFFICENUM2, 10),
		DLG_COMBO (STARTX+300, STARTY+650, 290, 200, 100, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_HPNUM2, 10),
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
				SetCombo();
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CMPLTBSDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MONTHUSE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CLIENT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OFFICENUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HPNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MANAGER), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OFFICENUM2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HPNUM2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA8), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA9), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA10), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA11), EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_OFFICENUM), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_HPNUM), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_OFFICENUM2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_HPNUM2), EDITALIGN_MIDDLE);
		
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
		switch(ID)
		{					
			case BID_WRITE1:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				break;	
				
			case BID_WRITE2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA6), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)) );
				break;	

			case BID_WRITE3:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA11), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)) );
				break;	

			case BID_CHANGE:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( Save_Info() )
				{
					Card_Move("BS_START");
				}
				break;
			case BID_OK:
				// ShowSip(FALSE);
				// g_Sipflag = 0;
				
				// Save_Struct();
				// Card_Move("BS_START");
				// break;
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( Save_Info() )
				{
					Card_Move("BS_START");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
					
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
					ShowSip(FALSE);
					g_Sipflag = 0;
					
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
				ShowSip(FALSE);
				g_Sipflag = 0;
			
				Card_Move("BS_START");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
				{
					g_Exit_DelBsData();
					return;
				}
				g_Exit();
				return;
		}
	}

	//------------------------------------------------------------------------
	void	OnKey(long nKey)
	{
		if( nKey == 5 )
		{
			//�Է� �� �ڵ�����
			if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex )
			{
				Str_Cpy(stBs.REPRE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
			{
				Str_Cpy(stBs.REPRE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex )
			{
				Str_Cpy(stBs.REPRE_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex )
			{
				Str_Cpy(stBs.REPRE_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA7) == m_lEditCtrlIndex )
			{
				Str_Cpy(stBs.MANAGE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA8) == m_lEditCtrlIndex )
			{
				Str_Cpy(stBs.MANAGE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA9) == m_lEditCtrlIndex )
			{
				Str_Cpy(stBs.MANAGE_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA10) == m_lEditCtrlIndex )
			{
				Str_Cpy(stBs.MANAGE_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
			}
		}
	}


//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		//�Է� �� �ڵ�����
		if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex )
		{
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}

			Str_Cpy(stBs.REPRE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		}
		else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
		{
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}
			
			Str_Cpy(stBs.REPRE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		}
		else if( Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex )
		{
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}
			
			Str_Cpy(stBs.REPRE_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		}
		else if( Get_iDlgCtrlByID(EDT_DATA5) == m_lEditCtrlIndex )
		{
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}
			
			Str_Cpy(stBs.REPRE_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		}
		else if( Get_iDlgCtrlByID(EDT_DATA7) == m_lEditCtrlIndex )
		{
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}
			
			Str_Cpy(stBs.MANAGE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
		}
		else if( Get_iDlgCtrlByID(EDT_DATA8) == m_lEditCtrlIndex )
		{
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}
			
			Str_Cpy(stBs.MANAGE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
		}
		else if( Get_iDlgCtrlByID(EDT_DATA9) == m_lEditCtrlIndex )
		{
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}
			
			Str_Cpy(stBs.MANAGE_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
		}
		else if( Get_iDlgCtrlByID(EDT_DATA10) == m_lEditCtrlIndex )
		{
			//���ڸ� �Է� ����
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				return;
			}
			
			Str_Cpy(stBs.MANAGE_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
		}
	}


//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( POINTING_UP == nAction )
		{
			m_lEditCtrlIndex = lActiveIndex;

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+640) && X < DMS_X(STARTX+790) && Y > DMS_Y(STARTY+390-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+460-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+840) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+390-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+460-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+640) && X < DMS_X(STARTX+790) && Y > DMS_Y(STARTY+460-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+530-(g_Dlgflag*400)) ||
				    X > DMS_X(STARTX+840) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+460-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+530-(g_Dlgflag*400)) ||
					X > DMS_X(STARTX+640) && X < DMS_X(STARTX+790) && Y > DMS_Y(STARTY+600-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+670-(g_Dlgflag*400)) ||
					X > DMS_X(STARTX+840) && X < DMS_X(STARTX+990) && Y > DMS_Y(STARTY+600-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+670-(g_Dlgflag*400)) ||
					X > DMS_X(STARTX+640) && X < DMS_X(STARTX+790) && Y > DMS_Y(STARTY+670-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+740-(g_Dlgflag*400)) ||
					X > DMS_X(STARTX+840) && X < DMS_X(STARTX+990) && Y > DMS_Y(STARTY+670-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+740-(g_Dlgflag*400)) ) 
				{
					
					if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA7) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA8) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA9) == lActiveIndex ||
						Get_iDlgCtrlByID(EDT_DATA10) == lActiveIndex )
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						//SetKeyMode(KEYMODE_NUMBER);

						ShowSip(TRUE);
						g_Sipflag = 1;
						
						g_Dlgflag = 0;
						g_MOVE_DLG(400);
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
			else if( theDevInfo.m_nType == FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+980) && Y > DMS_Y(STARTY+240) && Y < DMS_Y(STARTY+310) ||
				    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+980) && Y > DMS_Y(STARTY+450) && Y < DMS_Y(STARTY+520) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
					    Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex )	
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

			ON_DRAW();
		}
		
		return;
	}


//---------------------------------------------------------------------------------
	void SetCombo(void)
	{
		long i;
	
		//�繫�ǹ�ȣ
		for ( i = 0 ;  OFFICE_TEL[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_OFFICENUM+2), OFFICE_TEL[i].Str, 0, ICON_NONE);
		}
		//�ڵ�����ȣ
		for ( i = 0 ;  HP_NUM[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_HPNUM+2), HP_NUM[i].Str, 0, ICON_NONE);
		}
		
		//�繫�ǹ�ȣ
		for ( i = 0 ;  OFFICE_TEL[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_OFFICENUM2+2), OFFICE_TEL[i].Str, 0, ICON_NONE);
		}
		//�ڵ�����ȣ
		for ( i = 0 ;  HP_NUM[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_HPNUM2+2), HP_NUM[i].Str, 0, ICON_NONE);
		}
	}
	
//---------------------------------------------------------------------------------
	void REDRAW(void)
	{
		char szDate[20];
	
		//Ư����
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA11), stBs.SPECIAL_NM);
		
		//�ϼ��˻���
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		g_Str_DateType(szDate, stBs.COMPL_INSPECT_YMD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), szDate);
		
		//����뿹����
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), stBs.MM_USE_PLAN_QTY);

		//��ǥ��
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), stBs.REPRE_NM);
		//�繫�ǹ�ȣ_1
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_OFFICENUM), stBs.REPRE_TEL_DDD);
		//�繫�ǹ�ȣ_1
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), stBs.REPRE_TEL_EXN);
		//�繫�ǹ�ȣ_1
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), stBs.REPRE_TEL_NUM);
		//�ڵ�����ȣ_1
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_HPNUM), stBs.REPRE_CP_DDD);
		//�ڵ�����ȣ_1
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), stBs.REPRE_CP_EXN);
		//�ڵ�����ȣ_1
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), stBs.REPRE_CP_NUM);

		//����������
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), stBs.SAFE_MANAGER_NM);
		//�繫�ǹ�ȣ_2
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_OFFICENUM2), stBs.MANAGE_TEL_DDD);
		//�繫�ǹ�ȣ_2
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA7), stBs.MANAGE_TEL_EXN);
		//�繫�ǹ�ȣ_2
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA8), stBs.MANAGE_TEL_NUM);
		//�ڵ�����ȣ_2
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_HPNUM2), stBs.MANAGE_CP_DDD);
		//�ڵ�����ȣ_2
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA9), stBs.MANAGE_CP_EXN);
		//�ڵ�����ȣ_2
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA10), stBs.MANAGE_CP_NUM);		
	}
	
//---------------------------------------------------------------------------------
	bool Save_Info(void)
	{
		char szTmp[100];
		char szSql[300];
		long idx;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		// if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11))) > 32 )
		// {
		// 	Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		// 	SPRINT(szTmp, "�������! (Ư������ �ѱ� 10��, ����.���� 32�� ������ �Է°����մϴ�.) : [%d]", Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11))), 0, 0);
		// 	MessageBoxEx (CONFIRM_OK, szTmp);
		// 	ret = FALSE;
		// 	goto Finally;
		// }
		// if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) > 30 )
		// {
		// 	Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		// 	SPRINT(szTmp, "�������! (��ǥ�ڴ� �ѱ� 10��, ����.���� 30�� ������ �Է°����մϴ�.) : [%d]", Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))), 0, 0);
		// 	MessageBoxEx (CONFIRM_OK, szTmp);
		// 	ret = FALSE;
		// 	goto Finally;
		// }
		// if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6))) > 32 )
		// {
		// 	Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		// 	SPRINT(szTmp, "�������! (���������ڴ� �ѱ� 10��, ����.���� 32�� ������ �Է°����մϴ�.) : [%d]", Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6))), 0, 0);
		// 	MessageBoxEx (CONFIRM_OK, szTmp);
		// 	ret = FALSE;
		// 	goto Finally;
		// }
		
		// // 20180531 ��ȭ��ȣ ���� ����, �ڵ������� ������ȣ�� �� ��찡 �־ ��� 2�� ����
		// if( !g_CheckPhoneNumber("2", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_OFFICENUM)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) ))
		// {
		// 	MessageBoxEx(CONFIRM_OK, "��ǥ�� �繫�ǹ�ȣ��\nȮ�����ּ���.");
		// 	ret = FALSE;
		// 	goto Finally;
		// }
		
		// if( !g_CheckPhoneNumber("2", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_HPNUM)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)) ))
		// {
		// 	MessageBoxEx(CONFIRM_OK, "��ǥ�� �ڵ�����ȣ��\nȮ�����ּ���.");
		// 	ret = FALSE;
		// 	goto Finally;
		// }
		
		// if( !g_CheckPhoneNumber("2", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_OFFICENUM2)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)) ))
		// {
		// 	MessageBoxEx(CONFIRM_OK, "���������� �繫�ǹ�ȣ��\nȮ�����ּ���.");
		// 	ret = FALSE;
		// 	goto Finally;
		// }
		
		// if( !g_CheckPhoneNumber("2", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_HPNUM2)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)) ))
		// {
		// 	MessageBoxEx(CONFIRM_OK, "���������� �ڵ�����ȣ��\nȮ�����ּ���.");
		// 	ret = FALSE;
		// 	goto Finally;
		// }
		
		Save_Struct();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE SPECIAL_DATA SET \
					SPECIAL_NM = ?, REPRE_NM = ?, REPRE_TEL_DDD = ?, REPRE_TEL_EXN = ?, REPRE_TEL_NUM = ?, REPRE_CP_DDD = ? \
					, REPRE_CP_EXN = ?, REPRE_CP_NUM = ?, SAFE_MANAGER_NM = ?, MANAGE_TEL_DDD = ? \
					, MANAGE_TEL_EXN = ?, MANAGE_TEL_NUM = ?, MANAGE_CP_DDD = ?, MANAGE_CP_EXN = ? \
					, MANAGE_CP_NUM = ?, INFO_FLAG = 'S', UPD_EMPID = ?, PDA_IP = ? ,INFO_YN ='Y'\
					WHERE CHK_EXEC_NUM = ? "
					, 0, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.SPECIAL_NM           ,50 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.REPRE_NM             ,30 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.REPRE_TEL_DDD        ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.REPRE_TEL_EXN        ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.REPRE_TEL_NUM        ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.REPRE_CP_DDD         ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.REPRE_CP_EXN         ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.REPRE_CP_NUM         ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SAFE_MANAGER_NM      ,32 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.MANAGE_TEL_DDD       ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.MANAGE_TEL_EXN       ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.MANAGE_TEL_NUM       ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.MANAGE_CP_DDD        ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.MANAGE_CP_EXN        ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.MANAGE_CP_NUM        ,4	 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id  ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip       ,15 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM          ,12 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "������ �����Ǿ����ϴ�.");
		}
		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//---------------------------------------------------------------------------------
	void Save_Struct(void)
	{

		Str_Cpy(stBs.SPECIAL_NM     , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)));
		Str_Cpy(stBs.REPRE_NM       , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Str_Cpy(stBs.REPRE_TEL_DDD  , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_OFFICENUM)));
		Str_Cpy(stBs.REPRE_TEL_EXN  , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cpy(stBs.REPRE_TEL_NUM  , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cpy(stBs.REPRE_CP_DDD   , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_HPNUM)));
		Str_Cpy(stBs.REPRE_CP_EXN   , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Cpy(stBs.REPRE_CP_NUM   , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Cpy(stBs.SAFE_MANAGER_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
		Str_Cpy(stBs.MANAGE_TEL_DDD , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_OFFICENUM2)));
		Str_Cpy(stBs.MANAGE_TEL_EXN , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
		Str_Cpy(stBs.MANAGE_TEL_NUM , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
		Str_Cpy(stBs.MANAGE_CP_DDD  , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_HPNUM2)));
		Str_Cpy(stBs.MANAGE_CP_EXN  , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
		Str_Cpy(stBs.MANAGE_CP_NUM  , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
		Str_Cpy(stBs.INFO_YN  , "Y");
	}
}


