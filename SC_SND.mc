/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_SND
	Card Desc : �������� �۽�
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_SND
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_SEND )		//�ڷ�۽�
		DEF_BUTTON_ID ( BID_DEL  )		//�ڷ����
		//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_LIST )			//���
		DEF_OBJECT_ID ( TXT_OBJECT )		//���
		DEF_OBJECT_ID ( TXT_SEND )			//�۽�
		DEF_OBJECT_ID ( TXT_NSEND )			//�̼۽�
		DEF_OBJECT_ID ( TXT_SCRSLT )		//���˰��
		DEF_OBJECT_ID ( TXT_CLINFO )		//������
		DEF_OBJECT_ID ( TXT_GRINFO )		//�跮������
		DEF_OBJECT_ID ( TXT_COMBUSTOR )		//���ұ�����
		DEF_OBJECT_ID ( TXT_ABSENCE )		//��������
		DEF_OBJECT_ID ( TXT_NFIT )			//����������
		DEF_OBJECT_ID ( TXT_NFITITEM )		//�������׸�
		DEF_OBJECT_ID ( TXT_ADDRINFO )		//�ּ�����
		DEF_OBJECT_ID ( TXT_STRPIPEINFO)	//�Ի������
		DEF_OBJECT_ID ( TXT_DATA1 )			//���˰�� ���
		DEF_OBJECT_ID ( TXT_DATA2 )			//���˰�� �۽�
		DEF_OBJECT_ID ( TXT_DATA3 )			//���˰��
		DEF_OBJECT_ID ( TXT_DATA4 )			//������ ���
		DEF_OBJECT_ID ( TXT_DATA5 )			//������ �۽�
		DEF_OBJECT_ID ( TXT_DATA6 )			//������ �̼۽�
		DEF_OBJECT_ID ( TXT_DATA7 )			//�跮������ ���
		DEF_OBJECT_ID ( TXT_DATA8 )			//�跮������ �۽�
		DEF_OBJECT_ID ( TXT_DATA9 )			//�跮������ �̼۽�
		DEF_OBJECT_ID ( TXT_DATA10 )		//���ұ����� ���
		DEF_OBJECT_ID ( TXT_DATA11 )		//���ұ����� �۽�
		DEF_OBJECT_ID ( TXT_DATA12 )		//���ұ����� �̼۽�
		DEF_OBJECT_ID ( TXT_DATA13 )        //�������� ���
		DEF_OBJECT_ID ( TXT_DATA14 )		//�������� �۽�
		DEF_OBJECT_ID ( TXT_DATA15 )		//�������� �̼۽�
		DEF_OBJECT_ID ( TXT_DATA16 )		//���������� ���
		DEF_OBJECT_ID ( TXT_DATA17 )		//���������� �۽�
		DEF_OBJECT_ID ( TXT_DATA18 )		//���������� �̼۽�
		DEF_OBJECT_ID ( TXT_DATA19 )		//�������׸� ���
		DEF_OBJECT_ID ( TXT_DATA20 )		//�������׸� �۽�
		DEF_OBJECT_ID ( TXT_DATA21 )		//�������׸� �̼۽�
		DEF_OBJECT_ID ( TXT_DATA22 )		//�ּ����� ���
		DEF_OBJECT_ID ( TXT_DATA23 )		//�ּ����� �۽�
		DEF_OBJECT_ID ( TXT_DATA24 )		//�ּ����� �̼۽�
		DEF_OBJECT_ID ( TXT_DATA25 )		//�Ի������ ���
		DEF_OBJECT_ID ( TXT_DATA26 )		//�Ի������ �۽�
		DEF_OBJECT_ID ( TXT_DATA27 )		//�Ի������ �̼۽�
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN	1
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	char m_szSession[128];
	char m_szScrPht[258];

	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void SetStyle(void);
	void REDRAW(void);
	void SetBtnImg(void);
	void SC_DATADEL(void);
	void SC_DATASAND(void);
	long Snd_Manager(void);
	
	long Snd312301(void);
	long Snd312302(void);
	long Snd312303(void);
	long Snd312304(void);
	long Snd312305(void);
	long Snd312306(void);
	long Snd312307(void);
	long Snd312308(void);
	long Snd312309(void);
	long Snd312318(void);
	long Snd312321(void);
	long Snd312317(void);
	long Snd312323(void);
	long Snd312322(void);
	long Snd312324(void);
	long Snd312325(void);
	long Snd312326(void);
	long Snd312327(void);
	long Snd312328(void);
	
	void fsgetitem(char* szSource, char* szTarget, int id, int len );
	
	//---------------------------------------------------------------
	//	�����ư
	//---------------------------------------------------------------
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
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������� �ڷ�۽�"),
		
		DLG_TEXT(STARTX, 	  STARTY+65, 300, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LIST, "���"),
		DLG_TEXT(STARTX+300,  STARTY+65, 250, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "���"),
		DLG_TEXT(STARTX+550,  STARTY+65, 225, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SEND, "�۽�"),
		DLG_TEXT(STARTX+775,  STARTY+65, 225, 55, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NSEND, "�̼۽�"),
		DLG_TEXT(STARTX, 	 STARTY+120, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCRSLT, "���˰��"),
		DLG_TEXT(STARTX+300, STARTY+120, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550, STARTY+120, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+775, STARTY+120, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX, 	 STARTY+190, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLINFO, "������"),
		DLG_TEXT(STARTX+300, STARTY+190, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+550, STARTY+190, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+775, STARTY+190, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX, 	 STARTY+260, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GRINFO, "�跮������"),
		DLG_TEXT(STARTX+300, STARTY+260, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+550, STARTY+260, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+775, STARTY+260, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX, 	 STARTY+330, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMBUSTOR, "���ұ�����"),
		DLG_TEXT(STARTX+300, STARTY+330, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+550, STARTY+330, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+775, STARTY+330, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX, 	 STARTY+400, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ABSENCE, "��������"),
		DLG_TEXT(STARTX+300, STARTY+400, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX+550, STARTY+400, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+775, STARTY+400, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX, 	 STARTY+470, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFIT, "����������"),
		DLG_TEXT(STARTX+300, STARTY+470, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX+550, STARTY+470, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+775, STARTY+470, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX, 	 STARTY+540, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFITITEM, "�������׸�"),
		DLG_TEXT(STARTX+300, STARTY+540, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+550, STARTY+540, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX+775, STARTY+540, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX, 	 STARTY+610, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ADDRINFO, "�ּ�����"),
		DLG_TEXT(STARTX+300, STARTY+610, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+550, STARTY+610, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+775, STARTY+610, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, ""),
		DLG_TEXT(STARTX, 	 STARTY+680, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_STRPIPEINFO, "�Ի������"),
		DLG_TEXT(STARTX+300, STARTY+680, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX+550, STARTY+680, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA26, ""),
		DLG_TEXT(STARTX+775, STARTY+680, 225, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		
		DLG_BUTTON(STARTX,		STARTY+799, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL, "�ڷ����"),
		DLG_BUTTON(STARTX+600,	STARTY+799, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "�ڷ�۽�"),
	};	
	
	//---------------------------------------------------------------
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�������� �ڷ�۽�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,		STARTY+750, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL, "�ڷ����"),
		DLG_BUTTON(STARTX+600,	STARTY+750, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEND, "�ڷ�۽�"),
		
		DLG_TEXT(STARTX,	  STARTY-40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_LIST, "���"),
		DLG_TEXT(STARTX+300,  STARTY-40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJECT, "���"),
		DLG_TEXT(STARTX+550,  STARTY-40, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SEND, "�۽�"),
		DLG_TEXT(STARTX+750,  STARTY-40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NSEND, "�̼۽�"),
		DLG_TEXT(STARTX,	  STARTY+40, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_SCRSLT, "���˰��"),
		DLG_TEXT(STARTX+300,  STARTY+40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX+550,  STARTY+40, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+750,  STARTY+40, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		DLG_TEXT(STARTX,	 STARTY+120, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLINFO, "������"),
		DLG_TEXT(STARTX+300, STARTY+120, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX+550, STARTY+120, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX+750, STARTY+120, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,	 STARTY+200, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GRINFO, "�跮������"),
		DLG_TEXT(STARTX+300, STARTY+200, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX+550, STARTY+200, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+750, STARTY+200, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX,	 STARTY+280, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMBUSTOR, "���ұ�����"),
		DLG_TEXT(STARTX+300, STARTY+280, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(STARTX+550, STARTY+280, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+750, STARTY+280, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(STARTX,	 STARTY+360, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ABSENCE, "��������"),
		DLG_TEXT(STARTX+300, STARTY+360, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX+550, STARTY+360, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(STARTX+750, STARTY+360, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX,	 STARTY+440, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFIT, "����������"),
		DLG_TEXT(STARTX+300, STARTY+440, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(STARTX+550, STARTY+440, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX+750, STARTY+440, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(STARTX,	 STARTY+520, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NFITITEM, "�������׸�"),
		DLG_TEXT(STARTX+300, STARTY+520, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+550, STARTY+520, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(STARTX+750, STARTY+520, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX,	 STARTY+600, 300, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_ADDRINFO, "�ּ�����"),
		DLG_TEXT(STARTX+300, STARTY+600, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(STARTX+550, STARTY+600, 200, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+750, STARTY+600, 250, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, ""),
	};		
	
	//---------------------------------------------------------------
	// main
	//---------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		return TRUE;
	}
	
	//---------------------------------------------------------------
	// OnInit Function
	//---------------------------------------------------------------
	void OnInit(char bFirst)
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
				
				REDRAW();
				break;
		}
	}

	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		handle h;
	
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

	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_LIST), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJECT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SEND), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NSEND), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SCRSLT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CLINFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GRINFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_COMBUSTOR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ABSENCE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NFIT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NFITITEM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDRINFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STRPIPEINFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		switch(ID)
		{
			/*********************************/
			/* ����                          */
			/*********************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
				
			case GID_MENU:
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
				Card_Move("SC_DMMENU");
				break;
					
			case GID_VMEXIT:
				g_Exit();
				break;
			
			/*********************************/
			/* �Ϲ�                          */
			/*********************************/			
			case BID_DEL:
				SC_DATADEL();
				break;
				
			case BID_SEND:
				SC_DATASAND();
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : ȭ���� �ٽ� �׸���.
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		char szToday[10];
		char sztmp[30]; 
		char szSql[200];
		
		// 1. ���˰�� ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_DATA ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp );
		
		// 2. ������ ���
		// ** ������ ����� ���˴��� �����ϴ�.
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4), sztmp );
		
		// 3. ���˰�� �۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_DATA WHERE SEND_YN = 'Y' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2), sztmp );
		
		// 4. ���˰�� �̼۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_DATA WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3), sztmp );
		
		// 5. ������ �۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_INFO WHERE SEND_YN = 'Y' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), sztmp );

		// 6. ������ �̼۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_INFO WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6), sztmp );

		// 7. �跮������ ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_MTR ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA7), sztmp );
		
		// 8. �跮������ �۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_MTR WHERE SEND_YN = 'Y' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8), sztmp );
		
		// 9. �跮������ �̼۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_MTR WHERE SEND_YN = 'S' AND LENGTH(UPD_EMPID) > 0 ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), sztmp );

		// 10. ���ұ����� ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_BUR ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), sztmp );
		
		// 11. ���ұ����� �۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_BUR WHERE SEND_YN = 'Y' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11), sztmp );
		
		// 12 . ���ұ����� �̼۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_BUR WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA12), sztmp );

		// 13. �������� ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_VISIT ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13), sztmp );
		
		// 14. �������� �۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_VISIT  WHERE SEND_YN = 'Y' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA14), sztmp );

		// 15. �������� �̼۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_VISIT  WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), sztmp );
		
		// 16. ���������� ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_CHA ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), sztmp );
		
		// 17. ���������� �۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_CHA  WHERE SEND_YN = 'Y' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17), sztmp );

		// 18. ���������� �̼۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_CHA  WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), sztmp );

		// 19. �������׸� ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19), sztmp );

		// 20. �������׸� �۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE SEND_YN = 'Y' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), sztmp );
		
		// 21. �������׸� �̼۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), sztmp );

		// 22. �ּ����� ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_ADDR ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22), sztmp );
		
		// 23. �ּ����� �۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_ADDR WHERE SEND_YN = 'Y' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA23), sztmp );
		
		// 24. �ּ����� �̼۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_ADDR WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA24), sztmp );
		
		// 25. �Ի������ ���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_STANDPIPE_CHK_RSLT ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA25), sztmp );
		
		// 26. �Ի������ �۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_STANDPIPE_CHK_RSLT WHERE SEND_YN = 'Y' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA26), sztmp );
		
		// 27. �Ի������ �̼۽�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_STANDPIPE_CHK_RSLT WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA27), sztmp );
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : SC_DATADEL
	��  �� : �����͸� �����մϴ�.
	Param  : 
	Return : 
	========================================================================================*/
	void SC_DATADEL(void)
	{
		char szSql[600];
		char sztmp[10]; 
		long nchk = 0;

		if( MessageBoxEx (CONFIRM_YESNO, "�ڷḦ ���� �Ͻðڽ��ϱ�?") != MB_OK )
		{
			return;
		}
		
		// 1. ���˰�� 
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_DATA WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0)
		{
			nchk++;
		}
		
		// 2. ������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_INFO WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 3. �跮������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_MTR WHERE SEND_YN = 'S' AND LENGTH(UPD_EMPID) > 0 ", 0 ,0 ,0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 4. ���ұ�����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_BUR WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 5. ��������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_VISIT WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 6. ����������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_CHA WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 7. �������׸�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 8. �ּ�����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_ADDR WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 9. ������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM CUST_PATT_COLL_INFO WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 10. �Ի������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_STANDPIPE_CHK_RSLT WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		if( nchk > 0 )
		{
			if( MessageBoxEx (CONFIRM_YESNO, "�̼۽� �ڷᰡ �ֽ��ϴ�.\n�����Ͻðڽ��ϱ�?") != MB_OK)
				return;
		}
		
		MessageBox(MESSAGE, "�ڷḦ ���� ���Դϴ�.", 0, 0, 0, 0);
		
		g_Sql_DirectExecute("DELETE FROM NORMAL_ADDR");
		g_Sql_DirectExecute("DELETE FROM NORMAL_BUR");
		g_Sql_DirectExecute("DELETE FROM NORMAL_DATA");
		g_Sql_DirectExecute("DELETE FROM NORMAL_GROUP");
		g_Sql_DirectExecute("DELETE FROM NORMAL_INFO");
		
		SetMessageBoxText("20 % ���� ��...");
		
		g_Sql_DirectExecute("DELETE FROM NORMAL_MTR");
		g_Sql_DirectExecute("DELETE FROM NORMAL_NOGOOD");
		g_Sql_DirectExecute("DELETE FROM NORMAL_NOGOOD_CHA");
		g_Sql_DirectExecute("DELETE FROM NORMAL_NOGOOD_DETAL");
		g_Sql_DirectExecute("DELETE FROM NORMAL_PIPE_CHK_DATA");
		
		SetMessageBoxText("40 % ���� ��...");
		
		g_Sql_DirectExecute("DELETE FROM NORMAL_PREV_NO");
		g_Sql_DirectExecute("DELETE FROM NORMAL_VISIT");
		g_Sql_DirectExecute("DELETE FROM CUST_PATT_COLL_INFO");
		g_Sql_DirectExecute("DELETE FROM NORMAL_STANDPIPE_CHK_RSLT");
		
		SetMessageBoxText("60 % ���� ��...");
		
		//�۽� �Ϸ� �� �����ջ��� �� ���ڵ� ���� ����
		g_DirFS_Clear(PHOTO_SC, "*");
		g_DirFS_Clear(PHOTO_SCMTR, "*");
		g_DirFS_Clear(PHOTO_SCBUR, "*");
		g_DirFS_Clear(PHOTO_SCBOIL, "*");
		g_DirFS_Clear(PHOTO_SCBAR, "*");
		g_DirFS_Clear(PHOTO_SCREFUSE, "*");
		g_DirFS_Clear(PHOTO_SCABSENCE, "*");
		
		SetMessageBoxText("100 % �����Ϸ�");
		
		REDRAW();
		
		MessageBoxEx (CONFIRM_OK, "�ڷ� ������ �Ϸ�Ǿ����ϴ�.");
	}
	
	/*=======================================================================================
	�Լ��� : SC_DATASAND
	��  �� : �����͸� �۽��մϴ�.
	Param  : 
	Return : 
	========================================================================================*/
	void SC_DATASAND(void)
	{
		char szSql[200];
		char sztmp[10]; 
		char szyymm[10];
		long ret = 0; 
		long nchk = 0;	
		
		/******************************/
		/* ���� ������ Ȯ��           */
		/*****************************/
		// 1. ���˰��
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_DATA WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0)
		{
			nchk++;
		}
		
		// 2. ������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_INFO WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 3. �跮������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_MTR WHERE SEND_YN = 'S' AND LENGTH(UPD_EMPID) > 0 ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 4. ���ұ�����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_BUR WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 5. ��������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_VISIT WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 6. �����մ��
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 7. ����������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_CHA WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 8. �������׸�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 9. �ּ�����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_ADDR WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 10. ������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM CUST_PATT_COLL_INFO WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		// 11. �Ի������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_STANDPIPE_CHK_RSLT WHERE SEND_YN = 'S' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 4, sztmp );
		if(Str_AtoI(sztmp) > 0) 
		{
			nchk++;
		}
		
		if( nchk == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�۽��� ����� �����ϴ�.");
			return;
		}
		
		/******************************/
		/* ���� �۽� ���� ����        */
		/******************************/
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szyymm, 0x00, sizeof( szyymm) );
		SPRINT( szSql, " SELECT PARAM7 FROM RCV_LOG WHERE GUBUN = '2' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 8, sztmp);
		Str_ItoA( Time_GetDate(), szyymm, 10);

		if( Str_NCmp( sztmp, szyymm, 6) != 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�̿��� �̼۽Ű��� ������ �� �����ϴ�.");
			return;
		}

		/******************************/
		/* ���� �۽� ����             */
		/******************************/
		g_TRNUM = 0;
		
		Snd_Manager();
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Manager
	��  �� : �۽� Mnanager
	Param  : 
	Return : 
	========================================================================================*/
	long Snd_Manager(void)
	{
		long ret = 1;
		long nchk = 0;
		char szSql[600];
		char sztmp[10]; 
		char szDirPath[128];
		
		/*************************************/
		/*  ������ ���� ����                 */
		/*************************************/
		if( g_TRNUM > 0 )
		{
			if(g_Chk_Json( g_TRNUM ) >= 0)
			{
				if(g_TRNUM == 312323 )
				{					
					FFS_Delete(m_szScrPht);
				}
				else if (g_TRNUM == 312324 )
				{
					FFS_Delete(m_szScrPht);
				}
				else if (g_TRNUM == 312325 )
				{
					FFS_Delete(m_szScrPht);
				}
				else if (g_TRNUM == 312326 )
				{
					FFS_Delete(m_szScrPht);
				}
				else if (g_TRNUM == 312327 )
				{
					FFS_Delete(m_szScrPht);
				}
				else if (g_TRNUM == 312328 )
				{
					FFS_Delete(m_szScrPht);
				}
				else if(g_TRNUM == 312317 )
				{					
					FFS_Delete(m_szScrPht);
					g_TRNUM = 312329;
				}
				
				g_TRNUM++;
			}
			else
			{
				g_Sock_Close();
				return ret;
			}
		}
		
		/*************************************/
		/* ������ �۽�                       */
		/*************************************/
		// 1. ���� Connection
		if(  g_TRNUM <= 312301 )
		{
			g_SeverConnection();
			Mem_Set( (byte*)m_szSession, 0x00, sizeof(m_szSession) );
			if( g_StartSession( m_szSession ) < 0)
			{
				//���� ȸ�� ���нÿ� �۽������Ѵ�.
				return ret; 
			}
		}
		
		// 2. ���˰��
		if(  g_TRNUM <= 312301)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
	    	SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_DATA WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312301();
				return ret;
			}
		}
		
		// 3. ��������
		if(  g_TRNUM <= 312302)
		{				
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_VISIT WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312302();
				return ret;
			}
		}	
		
		// 4. �跮������
		if(  g_TRNUM <= 312303)
		{		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_MTR WHERE SEND_YN = 'S' AND LENGTH(UPD_EMPID) > 0 ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312303();
				return ret;
			}
		}
		
		// 5. ������
		if(  g_TRNUM <= 312304)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_INFO WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312304();
				return ret;
			}
		}
		
		// 6. ���ұ�����
		if(  g_TRNUM <= 312305)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_BUR WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312305();
				return ret;
			}
		}
		
		// 7. �����մ��
		if(  g_TRNUM <= 312306)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312306();
				return ret;
			}
		}
		
		// 8. ����������
		if(  g_TRNUM <= 312307)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_CHA WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312307();
				return ret;
			}
		}
		
		// 9. �������׸�
		if(  g_TRNUM <= 312308)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312308();
				return ret;
			}
		}
		
		// 10. �������
		if(  g_TRNUM <= 312309)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_PIPE_CHK_DATA ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312309();
				return ret;
			}
		}
		
		// 11. �ּ�����
		if(  g_TRNUM <= 312318)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_ADDR WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312318();
				return ret;
			}
		}
		
		// 12. ������
		if(  g_TRNUM <= 312319)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM CUST_PATT_COLL_INFO WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312321();
				return ret;
			}
		}
		
		// 13. �Ի������
		if(  g_TRNUM <= 312322)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ," SELECT COUNT(1) FROM NORMAL_STANDPIPE_CHK_RSLT WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_RetStr(szSql, 4, sztmp );
			if(Str_AtoI(sztmp) > 0) 
			{
				Snd312322();
				return ret;
			}
		}
		
		// 14. ���� Close
		if(  g_TRNUM <= 312323 )
		{
			if( g_EndSession( m_szSession, "1") < 0)
			{
				g_Sock_Close();
				return ret;
			}		
		}
		
		/*************************************/
		/* ���� �۽�                         */
		/*************************************/
		// 1. �跮������ ����
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCMTR );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			Snd312323();
			return ret;
		}
		
		// 2. ���ұ� ����
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCBUR );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			Snd312324();
			return ret;
		}
		
		// 3. ���Ϸ� ����
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCBOIL );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			Snd312325();
			return ret;
		}
		
		// 4. ���ڵ� �Ұ����� ����
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCBAR );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			Snd312326();
			return ret;
		}
		
		// 5. ���� �ź� ĸ�� ����
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCREFUSE );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			Snd312327();
			return ret;
		}

		// ���� ���� ĸ�� ����
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCABSENCE );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			Snd312328();
			return ret;
		}
		
		// 6. ������ ����
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SC );
		ret = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		if(ret > 0)
		{
			Snd312317();
			return ret;
		}
		else
		{
			/*************************************/
			/* �۽� �Ϸ�                         */
			/*************************************/ 
			g_Sock_Close();
			ret = 1;
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_DATA SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_DATA SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_VISIT SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_MTR SET SEND_YN = 'Y' WHERE SEND_YN = 'S' AND LENGTH(UPD_EMPID) > 0 ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_INFO SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_BUR SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_NOGOOD SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_NOGOOD_CHA SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_NOGOOD_DETAL SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " DELETE FROM NORMAL_PIPE_CHK_DATA ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE CUST_PATT_COLL_INFO SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_ADDR SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " UPDATE NORMAL_STANDPIPE_CHK_RSLT SET SEND_YN = 'Y' WHERE SEND_YN = 'S' ", 0, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			REDRAW();
			
			MessageBoxEx (CONFIRM_OK, "��� �۽ſϷ��Ͽ����ϴ�.");
		}
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312301
	��  �� : �������� ��� �۽� / FR312301
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312301(void)
	{
		char szUrl[200];
		char szSql[1000];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312301, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );

		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR \
							  , CHK_ORDER, OBJ_YM, PLAN_YM, CHK_EMPID, CHKER_NM \
							  , CHK_YMD, CHK_TIME_FROM, CHK_TIME_TO, CHK_RSLT, CHK_EXCEP_WHY \
							  , ADV_DIST_YN, SELF_CHK_YN, LK_BREAKER, CO_SENSOR, PIPE_COLOR_STS \
							  , SIGN_RELAT, SIGN, CURR_BAR AS BAR, BAR_WHY, MEMO \
							  , MEMO_WHY, COMP_CHK_OBJ_YN, UPD_EMPID AS USER_ID, PDA_IP AS CLIENT_ID \
							  , CO_ALARM_INST_YN, KIT_AUTO_EXTINGU_INST_YN \
						   FROM NORMAL_DATA WHERE SEND_YN = 'S' "
		             , 0, 0, 0 );
		
		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312301;
		
		ret = HTTP_UploadData  ( szUrl, "FR312301_IN",  "FR312301" , sndbuf, szDbpath, szSql);
		
		return 1;	
	}
	
	/*=======================================================================================
	�Լ��� : Snd312302
	��  �� : �������� ���� �۽� / FR312302
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312302(void)
	{
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312302, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, VISIT_FLAG, VISIT_DEGREE, BLD_NUM, INST_PLACE_NUM \
					 		  , CHK_TYPE, CHK_YEAR, CHK_ORDER, OBJ_YM, PLAN_YM \
                              , VISIT_YMD, NO_CHK_WHY, VISITOR_NM, SUPPLY_STOP_YMD, NOT_PERMIT_WHY \
                              , UPD_EMPID AS USER_ID, PDA_IP AS CLIENT_ID, VISIT_TIME \
                           FROM NORMAL_VISIT WHERE SEND_YN = 'S' "
		             , 0, 0, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312302;
					
		HTTP_UploadData  ( szUrl, "FR312302_IN",  "FR312302" , sndbuf, szDbpath, szSql);
		
		return 1;	
	}

	/*=======================================================================================
	�Լ��� : Snd312303
	��  �� : �������� ���� �۽� / FR312303
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312303(void)
	{
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312303, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, MTR_NUM, BLD_NUM, INST_PLACE_NUM, CHK_TYPE \
                              , CHK_YEAR, CHK_ORDER, OBJ_YM, PLAN_YM, VISIT_DTM \
                              , MTR_INDI_CUR AS MTR_INDI, INDI_VA_CUR AS INDI_VA, INDI_VC_CUR AS INDI_VC, COMPENS_YN, PROD_CD \
                              , MTR_LOC_FLAG, SEALED_STS, FUSE_COCK_INST_YN, TIMER_COCK_INST_YN, RCV_PROD_CD \
                              , UPD_EMPID AS USER_ID, PDA_IP AS CLIENT_ID \
                           FROM NORMAL_MTR WHERE SEND_YN = 'S' AND LENGTH(UPD_EMPID) > 0  "
		             , 0, 0, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312303;
		
		HTTP_UploadData  ( szUrl, "FR312303_IN",  "FR312303" , sndbuf, szDbpath, szSql);
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312304
	��  �� : �������� ������ �۽� / FR312304
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312304(void)
	{	
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312304, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, CUST_NUM, CUST_NM, CUST_TYPE_CD, CUST_TRND_CD, SOC_NUM \
						 	  , OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, CP_DDD, CP_EXN, CP_NUM \
                              , FAMILY_CNT, SQUARE_METER, FIRM_NM, BUILT_IN_YN, EMAIL, FIRM_TEL_DDD \
							  , FIRM_TEL_EXN, FIRM_TEL_NUM, FAX_DDD, FAX_EXN, FAX_NUM \
							  , BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR, CHK_ORDER \
							  , OBJ_YM, PLAN_YM, SCG_RELAT_CD, UPD_EMPID AS USER_ID, PDA_IP AS CLIENT_ID \
							  , INDUCTION_INST_YN, FACI_STS_CD, CHK_YMD \
					       FROM NORMAL_INFO WHERE SEND_YN = 'S' "
 		             , 0, 0, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312304;
				
		HTTP_UploadData  ( szUrl, "FR312304_IN",  "FR312304" , sndbuf, szDbpath, szSql);
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312305
	��  �� : �������� ���ұ����� �۽� / FR312305
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312305(void)
	{
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312305, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, MTR_NUM, BURNER_NUM, BLD_NUM, INST_PLACE_NUM \
							  , CHK_TYPE, CHK_YEAR, CHK_ORDER, OBJ_YM, PLAN_YM \
							  , CHG_FLAG, BURNER_CLASS_CD, BURNER_KIND_NUM, BURNER_MODEL_CD, BURNER_MODEL_NM \
							  , BURNER_CAPA, BURNER_CAPA_UNIT, BURNER_INST_YMD, BURNER_REMOV_YMD, MAKER_NUM \
							  , MAKER_NM, BOILER_FORM, MAKE_NUM, MAKE_YMD, INST_FLAG \
							  , INST_LOC, BOILER_INST_FIRM_CD, UPD_EMPID AS USER_ID, PDA_IP AS CLIENT_ID \
						   FROM NORMAL_BUR WHERE SEND_YN = 'S' "
		             , 0, 0, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312305;
					
		HTTP_UploadData  ( szUrl, "FR312305_IN",  "FR312305" , sndbuf, szDbpath, szSql);
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312306
	��  �� : �������� ������ ��� �۽� / FR312306
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312306(void)
	{
		char szUrl[200];
		char szSql[1000];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312306, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, ZIP_NO1, ZIP_NO2, CITY, COUNTY, TOWN \
		                      , VILLAGE, ADDR1_M, ADDR1_S, LOT_NUM_SECOND_ADDR, CO_LIVE_NM \
                              , HOUSE_CNT, BLD_NM, DETA_FLOOR, NEW_ADDR_HOSU, NEW_ADDR_UNGRNOUD_YN \
                              , NEW_ADDR_UNION, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR \
                              , CHK_ORDER, OBJ_YM, PLAN_YM, CUST_NUM, CUST_NM \
                              , CUST_TYPE_CD, CUST_TRND_CD, USE_CONT_NUM, FIRM_NM, BIZ_REGI_NUM \
                              , SOC_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN, OWNHOUSE_TEL_NUM, CP_DDD \
                              , CP_EXN, CP_NUM, CENTER_CD, ZONE_MANAGE_NUM, UPD_EMPID AS USER_ID \
                              , PDA_IP AS CLIENT_ID \
                           FROM NORMAL_NOGOOD WHERE SEND_YN = 'S' "
		            , 0, 0, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312306;
					
		HTTP_UploadData  ( szUrl, "FR312306_IN",  "FR312306" , sndbuf, szDbpath, szSql);
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312307
	��  �� : �������� ������ ���� �۽� / FR312307
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312307(void)
	{
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312307, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, BETTER_ADVICE_DEGREE, BLD_NUM, INST_PLACE_NUM, CHK_TYPE \
                              , CHK_YEAR, CHK_ORDER, OBJ_YM, PLAN_YM, BETTER_ADVICE_YMD \
                              , BETTER_ADVICE_EXPIRE, BETTER_YN, BETTER_END_YMD, SUPPLY_STOP_YMD, NOT_PERMIT_WHY \
                              , UPD_EMPID AS USER_ID, PDA_IP AS CLIENT_ID \
                           FROM NORMAL_NOGOOD_CHA WHERE SEND_YN = 'S' "
		             , 0, 0, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312307;
			
		HTTP_UploadData  ( szUrl, "FR312307_IN",  "FR312307" , sndbuf, szDbpath, szSql);
		
		return 1;
	}

	/*=======================================================================================
	�Լ��� : Snd312308
	��  �� : �������� ������ �׸� �۽� / FR312308
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312308(void)
	{
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312308, FALSE);
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, BETTER_DEGREE, CHK_SEC_CD, MTR_NUM, BURNER_NUM \
                              , NOT_PASS_ITEM_CD, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR \
                              , CHK_ORDER, OBJ_YM, PLAN_YM, CHK_SEC_NM, NOT_PASS_ITEM_NM \
                              , MTR_ID_NUM, VISIT_DTM, BETTER_PLAN_YMD, BETTER_YN, BETTER_END_YMD \
                              , BETTER_CONF_EMPID, BETTER_CONF_NM, UPD_EMPID AS USER_ID, PDA_IP AS CLIENT_ID \
                           FROM NORMAL_NOGOOD_DETAL WHERE SEND_YN = 'S' "
		             , 0, 0, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312308;
			
		HTTP_UploadData  ( szUrl, "FR312308_IN",  "FR312308" , sndbuf, szDbpath, szSql);
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312309
	��  �� : �������� ����Ÿ���� ���� �׸� �۽� / FR312309
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312309(void)
	{
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312309, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_EXEC_NUM, CHK_TYPE, MTR_NUM, PIPE_FLAG AS PIPE_BURY_HIDE_FLAG, GAS_DAMP_YN \
                              , MULTI_GAS_MTR_YN, PIPE_INSPEC_HOLE_YN, CUTOFF_INSPEC_HOLE_YN, PIPE_LOC_MARK_YN, UPD_EMPID AS USER_ID \
                              , PDA_IP AS CLIENT_ID \
                           FROM NORMAL_PIPE_CHK_DATA "
		             , 0, 0, 0 );
		
		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312309;
				
		HTTP_UploadData  ( szUrl, "FR312309_IN",  "FR312309" , sndbuf, szDbpath, szSql);
		
		return 1;

	}
	
	/*=======================================================================================
	�Լ��� : Snd312318
	��  �� : �������� �ּ� ���� �۽� / FR312318
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312318(void)
	{
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312318, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT BLD_NUM, ZIP_SEQ, HILL, ADDR1_M, ADDR1_S \
							  , NEW_ADDR_BLD_SEQ, NEW_ADDR_M AS NEW_ADDR1_M, NEW_ADDR_S AS NEW_ADDR1_S, CURR_ADDR_RSLT AS CURR_INSP_FLAG, NEW_ADDR_RSLT AS NEW_INSP_FLAG \
							  , BEFO_ADDR1_M, BEFO_ADDR1_S, BEFO_NEW_ADDR_M AS BEFO_NEW_ADDR1_M, BEFO_NEW_ADDR_S AS BEFO_NEW_ADDR1_S, '%s' AS USER_ID \
							  , '%s' AS CLIENT_ID \
						   FROM NORMAL_ADDR WHERE SEND_YN = 'S' "
		             , stUserinfo.szemployee_id, stUserinfo.szpda_ip, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312318;
					
		HTTP_UploadData  ( szUrl, "FR312318_IN",  "FR312318" , sndbuf, szDbpath, szSql);
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312321
	��  �� : �������� ������ �۽� / FR312321
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312321(void)
	{
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312321, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_YEAR, CHK_ORDER, CHK_TYPE, BLD_NUM, INST_PLACE_NUM \
							  , UPD_EMPID, UPD_IP, CUST_NUM, USE_CONT_NUM, CHK_VISIT_GBN \
							  , CHK_WISH_WEEK, CHK_WISH_TIME, EMR_DDD, EMR_EXN, EMR_NUM \
							  , OUT_PLAN_YN, OUT_PLAN_YMD, COLL_YMD, COLL_EMPID \
						   FROM CUST_PATT_COLL_INFO WHERE SEND_YN = 'S' "
		             , stUserinfo.szemployee_id, stUserinfo.szpda_ip, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312321;	
		
		HTTP_UploadData  ( szUrl, "FR312321_IN",  "FR312321" , sndbuf, szDbpath, szSql);
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312322
	��  �� : �������� �Ի������ �۽� / FR312322
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312322(void)
	{
		char szUrl[200];
		char szSql[800];
		char szDbpath[128];
		char* sndbuf;
		long ret = 0;		
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312322, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "session_key",   m_szSession );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));	
		GET_FILENM(szDbpath, SQLITE_DB);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT CHK_YEAR, CHK_ORDER, CHK_TYPE, BLD_NUM, CHK_EMPID \
							  , CHKER_NM, CHK_YMD, CHK_TIME, GAS_LK, PIPE_RUST \
		                      , STAND_PIPE_PROTE_INST, PIPE_CNT, '%s' AS USER_ID, '%s' AS CLIENT_ID \
						   FROM NORMAL_STANDPIPE_CHK_RSLT WHERE SEND_YN = 'S' "
                     , stUserinfo.szemployee_id, stUserinfo.szpda_ip, 0 );

		callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		g_TRNUM = 312322;
				
		HTTP_UploadData  ( szUrl, "FR312322_IN",  "FR312322" , sndbuf, szDbpath, szSql);
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312317
	��  �� : ������ ���� �۽� / FR312317
	         * ����������ġ 
			   - ��������_�����ջ��� : 10.1.9.13/exdat03/C30/C32/��/��
			 * ��������
			   - ��������_�����ջ��� : C31(��������) | E(���˽����ȣ) | M(�跮���ȣ) | B(���ұ� ��ȣ) | N(������), B(����) | ���˺κ��ڵ� | �������׸��ڵ� | D(������¥(SYSDATE : YYYYMMDDHHMMSS))
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312317(void)
	{
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char* sndbuf;
		char* szfile;
		char* filedata;
		long ret=0, nRet, filesize, fd;
		handle file;		
		
		/********************************/
		/* ���� ���� ����               */
		/********************************/
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		
		Str_Cpy(szDirPath, PHOTO_SC );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);

		if(nRet > 0)
		{
			/********************************/
			/* �۽ŵ����� ����              */
			/********************************/
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312317, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			// 1. gubun
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "gubun",       szdata );
			
			// 2. chk_exec_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_exec_num", szdata );
			
			// 3. mtr_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num",      szdata );
			
			// 4. guburner_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 4, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "burner_num",   szdata );
			
			// 5. chk_sec_cd
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 5, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_sec_cd",   szdata );
			
			// 6. not_pass_item_cd
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+9, szdata, 6, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "not_pass_item_cd",  szdata );
				
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			// 7. photo
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			
			sndbuf = JSON_toString(g_pjcomm);
			
			callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
			
			g_TRNUM = 312317;
			
			HTTP_DownloadData  ( szUrl, "FR312317_IN",  "FR312317" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			REDRAW();
			
			MessageBoxEx (CONFIRM_OK, "�������� ��� �۽ſϷ��Ͽ����ϴ�.");
		}
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312323
	��  �� : ���ΰ跮����� �۽� / FR312323
	         * ����������ġ 
			   - ��������_���ΰ跮����� : 10.1.9.13/exdat03/C30/C37/��/��/��
			 * ��������
			   - ��������_���ΰ跮����� : C37(��������) | E(���˽����ȣ) | M(�跮���ȣ) | I(��ġ��ҹ�ȣ) | D(������¥(SYSDATE : YYYYMMDDHHMMSS))
	Param  : 
	Return : 
	========================================================================================*/		
	long Snd312323(void)
	{
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char* sndbuf;
		char* szfile;
		char* filedata;
		long ret=0, nRet, filesize, fd;
		handle file;		
		
		/********************************/
		/* ���� ���� ����               */
		/********************************/
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		
		Str_Cpy(szDirPath, PHOTO_SCMTR );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);

		if(nRet > 0)
		{
			/********************************/
			/* �۽ŵ����� ����              */
			/********************************/
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312323, FALSE);
					
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			// 1. chk_exec_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_exec_num", szdata );
			
			// 2. mtr_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num",      szdata );
			
			// 3. inst_place_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num",   szdata );
				
			// 4. photo
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			
			sndbuf = JSON_toString(g_pjcomm);
			
			callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
			
			g_TRNUM = 312323;
			
			HTTP_DownloadData  ( szUrl, "FR312323_IN",  "FR312323" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			ON_DRAW();
		}
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312324
	��  �� : ���ұ���� �۽� / FR312324
	         * ����������ġ 
			   - ��������_���ұ���� : 10.1.9.13/exdat03/C30/C39/��/��/��
			 * ��������
			   - ��������_���ұ���� : C39(��������) | E(���˽����ȣ) | M(�跮���ȣ) | I(��ġ��ҹ�ȣ) | D(������¥(SYSDATE : YYYYMMDDHHMMSS))
	Param  : 
	Return : 
	========================================================================================*/
	long Snd312324(void)
	{
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char* sndbuf;
		char* szfile;
		char* filedata;
		char szChk_exec_num[20];
		char szSql[300];
		char sztmp[100];
		long ret=0, nRet, filesize, fd;
		handle file;		
		
		/********************************/
		/* ���� ���� ����               */
		/********************************/
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		
		Str_Cpy(szDirPath, PHOTO_SCBUR );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);

		if(nRet > 0)
		{
			/********************************/
			/* �۽ŵ����� ����              */
			/********************************/
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312324, FALSE);
				
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			// 1. chk_exec_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_exec_num", szdata );
			
			// 1-1. szChk_exec_num
			Mem_Set((byte*)szChk_exec_num, 0x00, sizeof(szChk_exec_num));
			Str_Cpy(szChk_exec_num, szdata);
			
			// 2. mtr_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num",      szdata );
			
			// 3. inst_place_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num",   szdata );
			
			// 4. inflow_flag
			JSON_SetValue( g_pjcomm, 'C', "inflow_flag", "10" );
			
			// 5. flag_item
			JSON_SetValue( g_pjcomm, 'C', "flag_item"  , "10"   );
			
			// 6. chk_year
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_YEAR FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_year"   , sztmp );
			
			// 7. chk_order
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_ORDER FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_order"   , sztmp );
			
			// 8. chk_type
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_TYPE FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_type"   , sztmp );
			
			// 9. bld_num
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT BLD_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "bld_num"    , sztmp );
			
			// 10. burner_num
			JSON_SetValue( g_pjcomm, 'C', "burner_num"    , "000000" );
			
			// 11. photo
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			
			sndbuf = JSON_toString(g_pjcomm);
			
			callBackfunc = Snd_Manager; //��ſϷ� �Ŀ� ȣ�� �Լ�
			
			g_TRNUM = 312324;
			
			HTTP_DownloadData  ( szUrl, "FR312324_IN",  "FR312324" , sndbuf, szDbpath);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			ON_DRAW();
		}
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312325
	��  �� : ���Ϸ� ���� �۽� / FR312325
	         * ����������ġ 
			   - ��������_���Ϸ�����	 : 10.1.9.13/exdat03/C30/C40/��/��/��
	 		   - ��������_���Ϸ�������� : 10.1.9.13/exdat03/C30/C41/��/��/��
			 * ��������
			   - ��������_���Ϸ�����	 : C40(��������) | E(���˽����ȣ) | M(�跮���ȣ) | I(��ġ��ҹ�ȣ) | B(���ұ��ȣ) | D(������¥(SYSDATE : YYYYMMDDHHMMSS))										
               - ��������_���Ϸ�������� : C41(��������) | E(���˽����ȣ) | M(�跮���ȣ) | I(��ġ��ҹ�ȣ) | B(���ұ��ȣ) | D(������¥(SYSDATE : YYYYMMDDHHMMSS))
	Param  : 
	Return : 
	========================================================================================*/											
	long Snd312325(void)
	{
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char* sndbuf;
		char* szfile;
		char* filedata;
		char szChk_exec_num[20];
		char szSql[300];
		char sztmp[100];
		char szFlag[10];
		long ret=0, nRet, filesize, fd;
		handle file;		
		
		/********************************/
		/* ���� ���� ����               */
		/********************************/
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCBOIL );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		
		if(nRet > 0)
		{
			/********************************/
			/* �۽ŵ����� ����              */
			/********************************/
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312325, FALSE);
			
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			Mem_Set((byte*)szFlag, 0x00, sizeof(szFlag));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			// 1. flag
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 1, Str_Len(m_szScrPht) );
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			SQL_ConvUcStr( sztmp, szdata );
			JSON_SetValue( g_pjcomm, 'C', "flag", sztmp );
			Str_Cpy( szFlag, szdata );
			
			// 2. chk_exec_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_exec_num", szdata );
			
			Mem_Set((byte*)szChk_exec_num, 0x00, sizeof(szChk_exec_num));
			Str_Cpy(szChk_exec_num, szdata);
			
			// 3. mtr_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num",      szdata );
			
			// 4. inst_place_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 4, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num",   szdata );
			
			// 5. inflow_flag
			JSON_SetValue( g_pjcomm, 'C', "inflow_flag", "20" );
			
			// 6. flag_item
			if( Str_Cmp(szFlag, "C40") == 0 )
			{
				JSON_SetValue( g_pjcomm, 'C', "flag_item"  , "10"   );
			}
			else
			{
				JSON_SetValue( g_pjcomm, 'C', "flag_item"  , "20"   );
			}
			
			// 7. chk_year
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_YEAR FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_year"   , sztmp );
			
			// 8. chk_order
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_ORDER FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_order"   , sztmp );
			
			// 9. chk_type
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_TYPE FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_type"   , sztmp );
			
			// 10. bld_num
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT BLD_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "bld_num"    , sztmp );
			
			// 11. burner_num
			JSON_SetValue( g_pjcomm, 'C', "burner_num"    , "" );
			
			// 12. photo
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			
			sndbuf = JSON_toString(g_pjcomm);
			
			//��ſϷ� �Ŀ� ȣ�� �Լ�
			callBackfunc = Snd_Manager;
			
			g_TRNUM = 312325;
				
			HTTP_DownloadData( szUrl, "FR312325_IN", "FR312325", sndbuf, szDbpath );
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			ON_DRAW();
		}
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312326
	��  �� : ���ڵ� �Ұ����� ���� �۽� / FR312326
	         * ����������ġ 
			   - 10.1.9.13/exdat03/C30/C42/��/��/��
			 * ��������
			   - C42(��������) | E(���˽����ȣ) | I(��ġ��ҹ�ȣ) | D(������¥(SYSDATE : YYYYMMDDHHMMSS))										
	Param  : 
	Return : 
	========================================================================================*/											
	long Snd312326(void)
	{
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char* sndbuf;
		char* szfile;
		char* filedata;
		char szChk_exec_num[20];
		char szSql[300];
		char sztmp[100];
		char szFlag[10];
		long ret=0, nRet, filesize, fd;
		handle file;		
		
		/********************************/
		/* ���� ���� ����               */
		/********************************/
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCBAR );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		
		if(nRet > 0)
		{
			/********************************/
			/* �۽ŵ����� ����              */
			/********************************/
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312326, FALSE);
			
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			Mem_Set((byte*)szFlag, 0x00, sizeof(szFlag));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			// 1. chk_exec_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_exec_num", szdata );
			
			Mem_Set((byte*)szChk_exec_num, 0x00, sizeof(szChk_exec_num));
			Str_Cpy(szChk_exec_num, szdata);
			
			// 2. inst_place_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+14, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num",   szdata );
			
			// 3. inflow_flag
			JSON_SetValue( g_pjcomm, 'C', "inflow_flag", "30" );
			
			// 4. flag_item
			JSON_SetValue( g_pjcomm, 'C', "flag_item"  , "10"   );
			
			// 5. chk_year
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_YEAR FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_year"   , sztmp );
			
			// 6. chk_order
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_ORDER FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_order"   , sztmp );
			
			// 7. chk_type
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_TYPE FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_type"   , sztmp );
			
			// 8. bld_num
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT BLD_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "bld_num"    , sztmp );
			
			// 9. burner_num
			JSON_SetValue( g_pjcomm, 'C', "burner_num"    , "" );
			
			// 10. photo
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			
			sndbuf = JSON_toString(g_pjcomm);
			
			//��ſϷ� �Ŀ� ȣ�� �Լ�
			callBackfunc = Snd_Manager;
			
			g_TRNUM = 312326;
				
			HTTP_DownloadData( szUrl, "FR312326_IN", "FR312326", sndbuf, szDbpath );
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			ON_DRAW();
		}
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Snd312327
	��  �� : ���� �ź� ĸ�� ���� / FR312327
	         * ����������ġ 
			   - 10.1.9.13/exdat03/C30/C50/��/��/��
			 * ��������
			   - C50(�ڵ�) | U(������ȣ) | D(������¥(SYSDATE : YYYYMMDDHHMMSS))
	Param  : 
	Return : 
	========================================================================================*/											
	long Snd312327(void)
	{
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char* sndbuf;
		char* szfile;
		char* filedata;
		char szChk_exec_num[20];
		char szSql[300];
		char sztmp[100];
		char szFlag[10];
		long ret=0, nRet, filesize, fd;
		handle file;		
		
		/********************************/
		/* ���� ���� ����               */
		/********************************/
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCREFUSE );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		
		if(nRet > 0)
		{
			/********************************/
			/* �۽ŵ����� ����              */
			/********************************/
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312327, FALSE);
			
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			Mem_Set((byte*)szFlag, 0x00, sizeof(szFlag));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			// 1. chk_exec_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+16, szdata, 1, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "chk_exec_num", szdata );
			
			Mem_Set((byte*)szChk_exec_num, 0x00, sizeof(szChk_exec_num));
			Str_Cpy(szChk_exec_num, szdata);
			
			// 2. mtr_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+16, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num", szdata );
			
			// 3. inst_place_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+16, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num", szdata );
			
			// 4. bld_num
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT BLD_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "bld_num", sztmp );
			
			// 5. chk_year
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_YEAR FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_year", sztmp );
			
			// 6. chk_order
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_ORDER FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_order", sztmp );
			
			// 7. center_cd
			JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
			
			// 8. photo
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			
			sndbuf = JSON_toString(g_pjcomm);
			
			//��ſϷ� �Ŀ� ȣ�� �Լ�
			callBackfunc = Snd_Manager;
			
			g_TRNUM = 312327;
				
			HTTP_DownloadData( szUrl, "FR312327_IN", "FR312327", sndbuf, szDbpath );
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			ON_DRAW();
		}
		return 1;
	}

	/*=======================================================================================
	�Լ��� : Snd312328
	��  �� : ���� ���� ĸ�� ���� / FR312328
	         * ����������ġ 
			   - 10.1.9.13/exdat03/C30/C51/��/��/��
			 * ��������
			   - C51(�ڵ�) | U(������ȣ) | D(������¥(SYSDATE : YYYYMMDDHHMMSS))
	Param  : 
	Return : 
	========================================================================================*/											
	long Snd312328(void)
	{
		char szUrl[200];
		char szDbpath[128];
		char szDirPath[128];
		char szfilenm[128];
		char szdata[20];
		char* sndbuf;
		char* szfile;
		char* filedata;
		char szChk_exec_num[20];
		char szSql[300];
		char sztmp[100];
		char szFlag[10];
		char szMsg[150];
		long ret=0, nRet, filesize, fd;
		handle file;		
		
		/********************************/
		/* ���� ���� ����               */
		/********************************/
		Mem_Set((byte*)m_szScrPht, 0x00, sizeof(m_szScrPht));
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Str_Cpy(szDirPath, PHOTO_SCABSENCE );
		
		nRet = g_FindFiles( szDirPath, "*.jjp" , m_szScrPht);
		
		if(nRet > 0)
		{
			/********************************/
			/* �۽ŵ����� ����              */
			/********************************/
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312328, FALSE);
			
			Mem_Set((byte*)szDbpath, 0x00, sizeof(szDbpath));
			Mem_Set((byte*)szFlag, 0x00, sizeof(szFlag));
			GET_FILENM(szDbpath, SQLITE_DB);
			
			// 1. chk_exec_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+17, szdata, 1, Str_Len(m_szScrPht) );

			JSON_SetValue( g_pjcomm, 'C', "chk_exec_num", szdata );
			
			Mem_Set((byte*)szChk_exec_num, 0x00, sizeof(szChk_exec_num));
			Str_Cpy(szChk_exec_num, szdata);
			
			// 2. mtr_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+17, szdata, 2, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "mtr_num", szdata );
			
			// 3. inst_place_num
			Mem_Set((byte*)szdata, 0x00, sizeof(szdata));
			fsgetitem(m_szScrPht+17, szdata, 3, Str_Len(m_szScrPht) );
			JSON_SetValue( g_pjcomm, 'C', "inst_place_num", szdata );
			
			// 4. bld_num
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT BLD_NUM FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "bld_num", sztmp );
			
			// 5. chk_year
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_YEAR FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_year", sztmp );
			
			// 6. chk_order
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT CHK_ORDER FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'", szChk_exec_num, 0, 0 );
			g_Sql_RetStr(szSql, 10, sztmp );
			JSON_SetValue( g_pjcomm, 'C', "chk_order", sztmp );
			
			// 7. center_cd
			JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
			
			// 8. photo
			filesize = FFS_GetSize( m_szScrPht );
			filedata = Mem_Alloc(filesize);
			
			fd = FFS_Open(m_szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)filedata, filesize );
			FFS_Close(fd);

			file = BASE64_Create();
			BASE64_Encode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			JSON_SetValue( g_pjcomm, 'C', "photo",  szfile );
			
			free((byte*)filedata);
			
			sndbuf = JSON_toString(g_pjcomm);
			
			//��ſϷ� �Ŀ� ȣ�� �Լ�
			callBackfunc = Snd_Manager;
			
			g_TRNUM = 312328;
				
			HTTP_DownloadData( szUrl, "FR312328_IN", "FR312328", sndbuf, szDbpath );
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		else
		{
			ON_DRAW();
		}
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : fsgetitem
	��  �� : - / . ���а����� ������.
	Param  : 
	Return : 
	========================================================================================*/
	void fsgetitem(char* szSource, char* szTarget, int id, int len )
	{
		int i;
		int idx;
		int ids;
	
		idx =0;
		ids =1;
		
		for( i=0; i<len; i++ )
		{
			if(szSource[i] == '_' || szSource[i] == '.')
			{
				if(ids == id )
				{
					szTarget[idx] = 0x00;
					break;
				}
				idx = 0;
				ids++;
				continue;
			}
			if(ids == id )
			{
				szTarget[idx] = szSource[i];
				idx++;
			}
		}
	}
}



