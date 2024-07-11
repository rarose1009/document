/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card GM_SMSSND
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
//	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
//�����޼�������
		DEF_BUTTON_ID ( BID_TAB1 )
		DEF_BUTTON_ID ( BID_TAB2 )
		DEF_BUTTON_ID ( BID_WRITE )
		DEF_BUTTON_ID ( BID_CHANGE )
		DEF_BUTTON_ID ( BID_CLOSE )
		DEF_BUTTON_ID ( BID_SAVE )
//��ȭ��ȣ����
		DEF_BUTTON_ID ( BID_CHGADDR )
		DEF_BUTTON_ID ( BID_CHGCLOSE )
		DEF_BUTTON_ID ( BID_CHGSAVE )
//��ݳ��� ��������
		DEF_BUTTON_ID ( BID_FEEWRITE )
		DEF_BUTTON_ID ( BID_FEEPREV )
		DEF_BUTTON_ID ( BID_FEENEXT )
		DEF_BUTTON_ID ( BID_FEECLOSE )
		DEF_BUTTON_ID ( BID_FEESAVE )
//�̰�ħ ��������
		DEF_BUTTON_ID ( BID_NOGM_SMSSND )
		DEF_BUTTON_ID ( BID_BOX1 )
		DEF_BUTTON_ID ( BID_BOX2 )
		DEF_BUTTON_ID ( BID_BOX3 )
		DEF_BUTTON_ID ( BID_BOX4 )
		DEF_BUTTON_ID ( BID_BOX5 )
		DEF_BUTTON_ID ( BID_BOX6 )
		DEF_BUTTON_ID ( BID_BOX7 )
		DEF_BUTTON_ID ( BID_BOX8 )
		DEF_BUTTON_ID ( BID_BOX9 )


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
		DEF_OBJECT_ID ( TXT_BORDER )
//�����޼�������
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
//��ȭ��ȣ����
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA26 )
		DEF_OBJECT_ID ( TXT_DATA27 )
		DEF_OBJECT_ID ( TXT_DATA28 )
		DEF_OBJECT_ID ( TXT_DATA29 )
		DEF_OBJECT_ID ( TXT_DATA30 )
		DEF_OBJECT_ID ( TXT_DATA31 )
//��ݳ��� ��������
		DEF_OBJECT_ID ( TXT_DATA10 )
//�̰�ħ ��������
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
		
//��ȭ��ȣ����
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )

		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
//��ȭ��ȣ����
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1 + 3 )
	END_OBJECT_ID()
	
	#define INIT_NOGMMSG 1		//�̰�ħ��������
	#define INIT_MAIN	 2
	#define INIT_CHANGE  3
	#define INIT_FEE     4
	
		
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

	typedef struct _USERINFO
	{
		char szCp_ddd[6];
		char szCp_exn[6];
		char szCp_num[6];
		char szCust_nm[50];
		char szSmsdesc[400];
	}	USERINFO;

	USERINFO m_stUserinfo;

	long m_bFirst;
	long m_lEditCtrlIndex = -1;
	long m_lAddrFlag = 1;		//��ȭ��ȣ����  = 1 ���ּ�, = 0 ���ּ�
	
	handle m_hGrid = NULL;
	long m_lTotpage;
	long m_lpage;
    long m_lSmsAgreeFlag = 0;  // = 0 ���ڰ�ħ ���� ���뿩�� ���� , = 1 ���ڰ�ħ ���� ���뿩�� ���� X �� ���ڴ�� ����üũ

//�̰�ħ ��������
	char m_send_flag[2];
	char m_sms_desc_flag[2];
	char m_send_tel_flag[2];
//��� ��������
	char m_szSms[2][1500];
	long m_lPage = 0;

	void SetBtnImg(void);
	void SetStyle(void);
	bool Save_Sms(void);

//��� ���� �� ���ڳ��� ����
	long Rcv_Info(void);
	long TR25001(void);
	void ReDraw(long nservicenum);
	//���ڰ�ħ ����
	long Rcv_Many(void);
	long TR25010(void);
	long Rcv_SmsSts(void);
	long TR25008(void);
	long GmSms_Sts(long nservicenum);
//���ڰ�ħ ��� ���
	long Snd_Sms_New(void);
	long TR25004(void);
//���ڰ�ħ ���� ����
	long Snd_Sms_Gm(void);
	long TR25003(void);

//��ȣ����
	void ChgDraw(void);
	long Snd_Change(void);
	long TR25002(void);
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	
//��ݳ��� ��������
	void FeeDraw(void);
	long Snd_Fee(void);
	long TR242453(void);
//�̰�ħ ��������
	long Analy_Phone(char*phone, char* num1, char* num2, char* num3 );
	long SND_SMS(void);
	long TR21365(void);	
	
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ڰ�ħ �����޼��� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,       STARTY-29, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "�̰�ħ ����"),
		DLG_BUTTON(STARTX+500,   STARTY-29, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "���ڰ�ħ ����"),

		DLG_BUTTON(STARTX+850,   STARTY+100, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "����"),
		DLG_BUTTON(STARTX,       STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "���"),
		DLG_BUTTON(STARTX+600,   STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "����"),

		DLG_TEXT(STARTX,      STARTY+40, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "����"),
		DLG_TEXT(STARTX+330,  STARTY+40, 670, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),

		DLG_TEXT(STARTX,      STARTY+100, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "������ȭ��ȣ"),
		DLG_TEXT(STARTX+330,  STARTY+100, 520, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_BUTTON(STARTX,	STARTY+160, 1000, 650, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE, ""),
		DLG_TEXT(STARTX,	STARTY+160, 1000, 650, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA5, ""),
	};	
	
	// ���̷� PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���ڰ�ħ �����޼��� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,       STARTY-40, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "�̰�ħ ����"),
		DLG_BUTTON(STARTX+500,   STARTY-40, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "���ڰ�ħ ����"),

		DLG_BUTTON(STARTX+850,   STARTY+100, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE, "����"),
		DLG_BUTTON(STARTX,       STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "���"),
		DLG_BUTTON(STARTX+600,   STARTY+829, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "����"),

		DLG_TEXT(STARTX,      STARTY+40, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "����"),
		DLG_TEXT(STARTX+330,  STARTY+40, 670, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),

		DLG_TEXT(STARTX,      STARTY+100, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "������ȭ��ȣ"),
		DLG_TEXT(STARTX+330,  STARTY+100, 520, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		
		DLG_EDIT(STARTX,	STARTY+160, 1000, 650, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_DATA5, 500,  ""),
	};	

	//  ���̾�α�:�̰�ħ ��������
	//---------------------------------------------------------------
	DlgObject	DlgRes_NOGMMSG[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�̰�ħ ��������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,       STARTY-29, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "�̰�ħ ����"),
		DLG_BUTTON(STARTX+500,   STARTY-29, 500, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "���ڰ�ħ ����"),

		DLG_BUTTON(STARTX,      STARTY+740, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�� ��"),
		DLG_BUTTON(STARTX+600,  STARTY+740, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOGM_SMSSND, "�� ��"),
	
		DLG_BUTTON(STARTX,      STARTY+110, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1,  CHKOFF),
		DLG_BUTTON(STARTX+500,  STARTY+110, 140, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2,  CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+260, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX3,  CHKOFF),
		DLG_BUTTON(STARTX+500,  STARTY+260, 140, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX4,  CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+330, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX5,  CHKOFF),
		DLG_BUTTON(STARTX+500,  STARTY+330, 140, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX6,  CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+480, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX7,  CHKOFF),
		DLG_BUTTON(STARTX+500,  STARTY+480, 140, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX8,  CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+550, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX9,  CHKOFF),
		
		DLG_TEXT ( STARTX,       STARTY+40, 1000, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "�ݹ������۹��"),
		DLG_TEXT ( STARTX+150,  STARTY+110, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, "�ǽð�����"),
		DLG_TEXT ( STARTX+640,  STARTY+110, 360, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, "�ϰ�(����)����"),
		
		DLG_TEXT ( STARTX,     STARTY+190, 1000, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "�ݾȳ�������"),
		DLG_TEXT ( STARTX+150, STARTY+260, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "���������ȳ�"),
		DLG_TEXT ( STARTX+640, STARTY+260, 360, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, "�ڰ���ħ�뺸"),
		DLG_TEXT ( STARTX+150, STARTY+330, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, "�ڰ���ħ����"),
		DLG_TEXT ( STARTX+640, STARTY+330, 360, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, "��湮�ȳ�"),
		
		DLG_TEXT ( STARTX ,    STARTY+410, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, "�ݹ߼۹�ȣ����"),
		DLG_TEXT ( STARTX+400, STARTY+410, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA20, ""),
		DLG_TEXT ( STARTX+150, STARTY+480, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, "PDA"),
		DLG_TEXT ( STARTX+640, STARTY+480, 360, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, "������"),
		DLG_TEXT ( STARTX+150, STARTY+550, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, "�ݼ���"),
		DLG_TEXT ( STARTX ,    STARTY+630, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "�ݰ���ȭ��ȣ"),
		DLG_TEXT ( STARTX+400, STARTY+630, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA25, ""),
	};
	
	//  ���̾�α�:�̰�ħ ��������
	//---------------------------------------------------------------
	DlgObject	DlgRes_NOGMMSG_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�̰�ħ ��������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX,       STARTY-40, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB1, "�̰�ħ ����"),
		DLG_BUTTON(STARTX+500,   STARTY-40, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TAB2, "���ڰ�ħ ����"),

		DLG_BUTTON(STARTX,      STARTY+740, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�� ��"),
		DLG_BUTTON(STARTX+600,  STARTY+740, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOGM_SMSSND, "�� ��"),
	
		DLG_BUTTON(STARTX,      STARTY+110, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1,  CHKOFF),
		DLG_BUTTON(STARTX+500,  STARTY+110, 140, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2,  CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+260, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX3,  CHKOFF),
		DLG_BUTTON(STARTX+500,  STARTY+260, 140, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX4,  CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+330, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX5,  CHKOFF),
		DLG_BUTTON(STARTX+500,  STARTY+330, 140, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX6,  CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+480, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX7,  CHKOFF),
		DLG_BUTTON(STARTX+500,  STARTY+480, 140, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX8,  CHKOFF),
		DLG_BUTTON(STARTX,      STARTY+550, 150, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX9,  CHKOFF),
		
		DLG_TEXT ( STARTX,       STARTY+40, 1000, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, "�ݹ������۹��"),
		DLG_TEXT ( STARTX+150,  STARTY+110, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, "�ǽð�����"),
		DLG_TEXT ( STARTX+640,  STARTY+110, 360, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, "�ϰ�(����)����"),
		
		DLG_TEXT ( STARTX,     STARTY+190, 1000, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "�ݾȳ�������"),
		DLG_TEXT ( STARTX+150, STARTY+260, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "���������ȳ�"),
		DLG_TEXT ( STARTX+640, STARTY+260, 360, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, "�ڰ���ħ�뺸"),
		DLG_TEXT ( STARTX+150, STARTY+330, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, "�ڰ���ħ����"),
		DLG_TEXT ( STARTX+640, STARTY+330, 360, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, "��湮�ȳ�"),
		
		DLG_TEXT ( STARTX ,    STARTY+410, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, "�ݹ߼۹�ȣ����"),
		DLG_TEXT ( STARTX+400, STARTY+410, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA20, ""),
		DLG_TEXT ( STARTX+150, STARTY+480, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, "PDA"),
		DLG_TEXT ( STARTX+640, STARTY+480, 360, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, "������"),
		DLG_TEXT ( STARTX+150, STARTY+550, 350, 70, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, "�ݼ���"),
		DLG_TEXT ( STARTX ,    STARTY+630, 400, 70, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "�ݰ���ȭ��ȣ"),
		DLG_TEXT ( STARTX+400, STARTY+630, 600, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DATA25, ""),
	};
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_Change[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ڼ��� ��ȭ��ȣ ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHGCLOSE, ""),
		
		DLG_BUTTON(STARTX,       STARTY+390, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGCLOSE, "�� ��"),
		DLG_BUTTON(STARTX+500,   STARTY+390, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGSAVE, "�� ��"),

		DLG_TEXT(STARTX,      STARTY-29, 330, 69, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "������ȣ"),
		DLG_TEXT(STARTX+330,  STARTY-29, 670, 69, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(STARTX,      STARTY+40, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "����"),
		DLG_TEXT(STARTX+330,  STARTY+40, 670, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		
		//DLG_TEXT(0,           STARTY+95, 330, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA28, "�ּ�"),
		DLG_BUTTON(STARTX,    STARTY+100, 330, 150, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGADDR, ""),
		DLG_TEXT(STARTX+330,  STARTY+100, 670, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""),

		DLG_TEXT(STARTX,      STARTY+250, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "������ȭ��ȣ"),
		DLG_TEXT(STARTX+580,  STARTY+250, 40, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, "-"),
		DLG_EDIT(STARTX+620,  STARTY+250, 170, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+790,  STARTY+250, 40, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, "-"),
		DLG_EDIT(STARTX+830,  STARTY+250, 170, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA2, 4,  ""),
		
		DLG_TEXT(STARTX,  STARTY+310, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "�� ��"),
		
		DLG_COMBO (STARTX+330,  STARTY+250, 250, 60, 100, 60, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DATA1, 5),			//������ȭ��ȣ
		DLG_COMBO (STARTX+330,  STARTY+310, 670, 60, 200, 60, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DATA2, 20),			//����
	};	
	
	// ��ȣ���� PDA
	//---------------------------------------------------------------
	DlgObject	DlgRes_Change_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���ڼ��� ��ȭ��ȣ ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CHGCLOSE, ""),

		DLG_BUTTON(STARTX,       STARTY+390, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGCLOSE, "�� ��"),
		DLG_BUTTON(STARTX+500,   STARTY+390, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGSAVE, "�� ��"),

		DLG_TEXT(STARTX,      STARTY-40, 330, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "������ȣ"),
		DLG_TEXT(STARTX+330,  STARTY-40, 670, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(STARTX,      STARTY+30, 330, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "����"),
		DLG_TEXT(STARTX+330,  STARTY+30, 670, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		
		//DLG_TEXT(0,           STARTY+95, 330, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA28, "�ּ�"),
		DLG_BUTTON(STARTX,    STARTY+100, 330, 150, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHGADDR, ""),
		DLG_TEXT(STARTX+330,  STARTY+100, 670, 150, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""),

		DLG_TEXT(STARTX,      STARTY+250, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "������ȭ��ȣ"),
		DLG_TEXT(STARTX+580,  STARTY+250, 40, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, "-"),
		DLG_EDIT(STARTX+620,  STARTY+250, 170, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+790,  STARTY+250, 40, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, "-"),
		DLG_EDIT(STARTX+830,  STARTY+250, 170, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_DATA2, 4,  ""),
		
		DLG_TEXT(STARTX,  STARTY+310, 330, 60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, "�� ��"),
		
		DLG_COMBO (STARTX+330,  STARTY+250, 250, 60, 100, 60, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DATA1, 5),			//������ȭ��ȣ
		DLG_COMBO (STARTX+330,  STARTY+310, 670, 60, 200, 60, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC, "", CMB_DATA2, 20),			//����
	};	

	// ���� ���̾�α�(��ݳ���)
	//---------------------------------------------------------------
	DlgObject	DlgRes_Fee[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ݳ��� ��������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEECLOSE, ""),

		DLG_BUTTON(STARTX,       STARTY+770, 500, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEEPREV, "����"),
		DLG_BUTTON(STARTX+500,   STARTY+770, 500, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEENEXT, "����"),
		DLG_BUTTON(STARTX,       STARTY+835, 500, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEECLOSE, "���"),
		DLG_BUTTON(STARTX+500,   STARTY+835, 500, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEESAVE, "��������"),

//		DLG_BUTTON(0,	STARTY-25, 998, 810, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEEWRITE, ""),
		DLG_TEXT(STARTX,	    STARTY-29, 1000, 770, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA10, ""),
	};	
	
	// ���̷� PDA(��ݳ���)
	//---------------------------------------------------------------
	DlgObject	DlgRes_Fee_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ݳ��� ��������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEECLOSE, ""),

		DLG_BUTTON(STARTX,       STARTY+770, 500, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEEPREV, "����"),
		DLG_BUTTON(STARTX+500,   STARTY+770, 500, 65, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEENEXT, "����"),
		DLG_BUTTON(STARTX,       STARTY+835, 500, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEECLOSE, "���"),
		DLG_BUTTON(STARTX+500,   STARTY+835, 500, 64, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEESAVE, "��������"),

//		DLG_BUTTON(0,	STARTY-25, 998, 810, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_FEEWRITE, ""),
		DLG_TEXT(STARTX,	    STARTY-29, 1000, 770, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA10, ""),
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
		long i;
		char szPhoneNum[32];
		char szPhoneNum1[5];
		char szPhoneNum2[5];
		char szPhoneNum3[5];
		char szTmp[50];
		
		if( g_nSmsFlag == 2 || g_nSmsFlag == 5 )
		{
			bFirst = INIT_CHANGE;
		}
		else if( g_nSmsFlag == 3 || g_nSmsFlag == 4 )
		{
			bFirst = INIT_FEE;
		}
		
		m_bFirst = bFirst;
	
		switch (bFirst)
		{
			case INIT_NOGMMSG:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_NOGMMSG_P, SIZEOF(DlgRes_NOGMMSG_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_NOGMMSG, SIZEOF(DlgRes_NOGMMSG));
						break;		
				}
				
				SetBtnImg();

				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
				Str_Cpy(m_send_flag, "1");//�ǽð�����
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKON);
				Str_Cpy(m_sms_desc_flag, "1");//��������
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKON);
				Str_Cpy(m_send_tel_flag, "1");//PDA ��ȣ
				
				Mem_Set( (byte*)szPhoneNum, 0x00, sizeof(szPhoneNum) );
				Mem_Set( (byte*)szPhoneNum1, 0x00, sizeof(szPhoneNum1) );
				Mem_Set( (byte*)szPhoneNum2, 0x00, sizeof(szPhoneNum2) );
				Mem_Set( (byte*)szPhoneNum3, 0x00, sizeof(szPhoneNum3) );
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				
				Tapi_GetPhoneNum( (byte*)szTmp, 0);
				
				if( Str_Cmp(szTmp, "01099991111") == 0 )
				{
					Str_Cpy(szPhoneNum, "00000000000");
				}
				else
				{
					Str_Cpy(szPhoneNum, szTmp);
				}
				
				Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
				Str_Cpy(szPhoneNum , szPhoneNum1 );
				Str_Cat(szPhoneNum , "-" );
				Str_Cat(szPhoneNum , szPhoneNum2 );
				Str_Cat(szPhoneNum , "-" );
				Str_Cat(szPhoneNum , szPhoneNum3 );			
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), szPhoneNum );
				
				Mem_Set((byte*)szPhoneNum , 0x00, sizeof(szPhoneNum) );
				Str_Cpy(szPhoneNum , stGm.CP_DDD );
				Str_Cat(szPhoneNum , "-" );
				Str_Cat(szPhoneNum , stGm.CP_EXN );
				Str_Cat(szPhoneNum , "-" );
				Str_Cat(szPhoneNum , stGm.CP_NUM );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA25), szPhoneNum );
				
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), TRUE );

				if( (Str_Cmp(stGm.SEND_YN, "S") != 0 && Str_Cmp(stGm.SEND_YN, "I") != 0) )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), TRUE );
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), FALSE );
				}
				break;
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				Rcv_Info();

				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TAB2), FALSE );
				break;
			case INIT_CHANGE:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Change_P, SIZEOF(DlgRes_Change_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Change, SIZEOF(DlgRes_Change));
						break;		
				}

				for ( i = 0 ;  GM_TELCHG_WHY[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), GM_TELCHG_WHY[i].Str, 0, ICON_NONE);
				}

				SetBtnImg();	
				SetStyle();
				ChgDraw();
				break;
			case INIT_FEE:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Fee_P, SIZEOF(DlgRes_Fee_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Fee, SIZEOF(DlgRes_Fee));
						break;		
				}
				SetBtnImg();	
				SetStyle();
				FeeDraw();
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		long nRet = 0;
		long nchkcnt = 0;
		char szPhoneNum[32];
		char szPhoneNum1[5];
		char szPhoneNum2[5];
		char szPhoneNum3[5];
		char szTmp[50];
		
		switch(ID)
		{
			case BID_TAB1:
				if( m_bFirst != INIT_NOGMMSG )
				{
					ON_EXIT();
					OnInit(INIT_NOGMMSG);
				}
				break;
			case BID_TAB2:
				if( m_bFirst != INIT_MAIN )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_CHANGE:
				ON_EXIT();
				OnInit(INIT_CHANGE);
				break;
			case BID_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_DATA5), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA5)) );
				break;
			case BID_CLOSE:
				Card_Move("GM_ENTRY");
				break;
			case BID_SAVE:
				Mem_Set( (byte*)szPhoneNum, 0x00, sizeof(szPhoneNum) );
				Mem_Set( (byte*)szPhoneNum1, 0x00, sizeof(szPhoneNum1) );
				Mem_Set( (byte*)szPhoneNum2, 0x00, sizeof(szPhoneNum2) );
				Mem_Set( (byte*)szPhoneNum3, 0x00, sizeof(szPhoneNum3) );
				Str_Cpy(szPhoneNum, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA4)));
				Str_Chg(szPhoneNum, STRCHG_DEL_NONDIGIT);
				nRet = 0;
				nRet = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
				if( nRet > 0 )
				{
				/*
					//SMS_GMTR_MAN_YN = Y ���ڴ�� , != Y ���ڴ��X
					if( Str_Cmp(stGm.SMS_GMTR_MAN_YN, "Y") == 0 )
					{
						if( Str_Cmp(stGm.GMTR_SEND_STS, "10") != 0 && Str_Cmp(stGm.GMTR_SEND_STS, "50") != 0 )
						{
							MessageBoxEx (CONFIRM_OK, "����� ���¸� Ȯ�����ּ���.");
							break;
						}
						else
						{
							//���ڹ߼�
							Snd_Sms_Gm();
						}
					}
					else
					{
						//���ڴ�� ��� �� ���ڹ߼�
						Snd_Sms_New();
					}
				*/
					//m_lSmsAgreeFlag = 0;
					//Rcv_SmsSts();
					Rcv_Many();
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "���� ��ȭ��ȣ�� Ȯ�����ּ���.");
				}
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "��ħ �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("GM_MENU");
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
				if( g_nWorkFlag == 100 || g_nWorkFlag == 101 || g_nWorkFlag == 102 )
				{
					Card_Move("GM_LST");
				}
				else if( g_nWorkFlag == 103 )
				{
					Card_Move("GM_NOGMLST");
				}
				else if( g_nWorkFlag == 104 )
				{
					Card_Move("GM_ABSNCLST");
				}
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
				
//��ȭ��ȣ ����
			case BID_CHGADDR:
				if( m_lAddrFlag == 1 )
				{
					m_lAddrFlag = 0;
				}
				else
				{
					m_lAddrFlag = 1;
				}
				ChgDraw();
				break;
			case BID_CHGCLOSE:
				if( g_nSmsFlag == 2 || g_nSmsFlag == 5 )
				{
					Card_Move("GM_SMSGM");
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_CHGSAVE:
				Mem_Set( (byte*)szPhoneNum, 0x00, sizeof(szPhoneNum) );
				Mem_Set( (byte*)szPhoneNum1, 0x00, sizeof(szPhoneNum1) );
				Mem_Set( (byte*)szPhoneNum2, 0x00, sizeof(szPhoneNum2) );
				Mem_Set( (byte*)szPhoneNum3, 0x00, sizeof(szPhoneNum3) );
				
				Str_Cpy(szPhoneNum , EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) );
				Str_Cat(szPhoneNum , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				Str_Cat(szPhoneNum , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) );
				
				nRet = 0;
				nRet = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
				if( nRet > 0 )
				{
					Snd_Change();
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "���� ��ȭ��ȣ�� Ȯ�����ּ���.");
				}
				break;
//��ݳ��� ��������
			case BID_FEEWRITE:
				//g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_DATA10), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA10)) );
				break;
			case BID_FEEPREV:
				m_lPage = 0;
				if( m_lPage == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), m_szSms[0] );
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), m_szSms[1] );
				}
				break;
			case BID_FEENEXT:
				m_lPage = 1;
				if( m_lPage == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), m_szSms[0] );
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), m_szSms[1] );
				}
				break;
			case BID_FEESAVE:
				Snd_Fee();
				break;
			case BID_FEECLOSE:
				Card_Move("GM_FEEVIEW");
				break;
//�̰�ħ��������
			case BID_NOGM_SMSSND:
				if( Str_Cmp(g_szIndi_MtrCode, "2:����") == 0 )
				{
					if( SND_SMS() < 0 )
					{
					 	break;
					}
				}
				else
				{
					MessageBoxEx(CONFIRM_OK, "�������۱����\n�����϶� ����� �� �ֽ��ϴ�.");
				}
				break;
			case BID_BOX1:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				Str_Cpy(m_send_flag, "1");//�ǽð�����
				break;
			case BID_BOX2:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKON);
				Str_Cpy(m_send_flag, "2");//��������
				break;
			case BID_BOX3:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKOFF);
				Str_Cpy(m_sms_desc_flag, "1");//��������
				break;
			case BID_BOX4:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKOFF);
				Str_Cpy(m_sms_desc_flag, "2");//�ڰ���ħ�뺸
				break;
			case BID_BOX5:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKOFF);
				Str_Cpy(m_sms_desc_flag, "3");//�ڰ���ħ����
				break;
			case BID_BOX6:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX5), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX6), CHKON);
				Str_Cpy(m_sms_desc_flag, "4");//��湮�ȳ�
				break;
			case BID_BOX7:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX8), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX9), CHKOFF);
				Str_Cpy(m_send_tel_flag, "1");//PDA ��ȣ
				Mem_Set( (byte*)szPhoneNum, 0x00, sizeof(szPhoneNum) );
				Mem_Set( (byte*)szPhoneNum1, 0x00, sizeof(szPhoneNum1) );
				Mem_Set( (byte*)szPhoneNum2, 0x00, sizeof(szPhoneNum2) );
				Mem_Set( (byte*)szPhoneNum3, 0x00, sizeof(szPhoneNum3) );
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				
				Tapi_GetPhoneNum( (byte*)szTmp, 0);
				
				if( Str_Cmp(szTmp, "01099991111") == 0 )
				{
					Str_Cpy(szPhoneNum, "00000000000");
				}
				else
				{
					Str_Cpy(szPhoneNum, szTmp);
				}

				nchkcnt = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
				if( nchkcnt > 0 )
				{
					Str_Cpy(szPhoneNum , szPhoneNum1 );
					Str_Cat(szPhoneNum , "-" );
					Str_Cat(szPhoneNum , szPhoneNum2 );
					Str_Cat(szPhoneNum , "-" );
					Str_Cat(szPhoneNum , szPhoneNum3 );			
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), szPhoneNum );
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), "" );
				}
				break;
			case BID_BOX8:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX8), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX9), CHKOFF);
				Mem_Set( (byte*)szPhoneNum, 0x00, sizeof(szPhoneNum) );
				Mem_Set( (byte*)szPhoneNum1, 0x00, sizeof(szPhoneNum1) );
				Mem_Set( (byte*)szPhoneNum2, 0x00, sizeof(szPhoneNum2) );
				Mem_Set( (byte*)szPhoneNum3, 0x00, sizeof(szPhoneNum3) );
				Str_Cpy(m_send_tel_flag, "3");//������
				
				nchkcnt = Analy_Phone(stUserinfo.sztel, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
				PRINT("55555555555555555555%d :",nchkcnt,0,0);
				if( nchkcnt > 0 )
				{
					Str_Cpy(szPhoneNum , szPhoneNum1 );
					Str_Cat(szPhoneNum , "-" );
					Str_Cat(szPhoneNum , szPhoneNum2 );
					Str_Cat(szPhoneNum , "-" );
					Str_Cat(szPhoneNum , szPhoneNum3 );			
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), szPhoneNum );
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), "" );
				}
				
				break;
			case BID_BOX9:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX7), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX8), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX9), CHKON);
				Str_Cpy(m_send_tel_flag, "4");//�ݼ���
				Str_Cpy(szPhoneNum , "1588" );
				Str_Cat(szPhoneNum , "-" );
				Str_Cat(szPhoneNum , "5788" );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), szPhoneNum );
				break;
		}
	}		
	
//-------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		if( m_bFirst == INIT_CHANGE )
		{
			//���ڸ� �Է� ����
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
					return;
				}
			}

			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lEditCtrlIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) == 4 )
			{
				m_lEditCtrlIndex = Get_iDlgCtrlByID(EDT_DATA2);
				Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
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
		
		if( m_bFirst == INIT_CHANGE )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+615) && X < DMS_X(STARTX+785) && Y > DMS_Y(STARTY+250) && Y < DMS_Y(STARTY+310) ||
					    X > DMS_X(STARTX+825) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+250) && Y < DMS_Y(STARTY+310) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex )	
						{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);

							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
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
				
				ON_DRAW();
			}
		}
	}

	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
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
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_TOP);
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA5), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_CHANGE )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA29), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_FEE )
		{
			//
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_TOP);
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA10), TRUE, 2, EDITSEP_NONE );
		}
	}	
	
//------------------------------------------------------------------
	void ReDraw(long nservicenum)
	{
	char szJsonpath[500];
	char szMsg[500];
	char szCol[128];
	char szTmp[100];
	long *nCol;
	long nCnt = 0;
	long fd, i;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szitem;
	char *szCpddd;
	char *szCpexn;
	char *szCpnum;
	char *szCustnm;
	char *szSmsdesc;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
		
		//MessageBox(MESSAGE, "�ڷ� Ȯ���� �Դϴ�.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, nservicenum, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, nservicenum, 0 );
		}
		
		fsize = FFS_GetSize(szJsonpath);
		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		pStr = Mem_Alloc(fsize);
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read(fd, (byte*)pStr, fsize);
		for(i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			if(chkmsg > 0 &&  chkcode > 0)
				break;
		}

		FFS_Close(fd);
		
		Mem_Free((byte*)pStr);
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}

		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
			  char* pMsg = NULL;
			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				//SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				ON_DRAW();
				ret = -1;
			}
			else
			{
				Mem_Set((byte*)&m_stUserinfo, 0x00, sizeof( m_stUserinfo) );
	
				//����
				Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
				szcode = (char*)JSON_GetValue ( g_pjcomm, "cust_nm", szType);
				SQL_ConvMbStr(m_stUserinfo.szCust_nm, szcode);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2),  m_stUserinfo.szCust_nm);

				//�� ��ȭ��ȣ
				Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
				szCpddd = (char*)JSON_GetValue ( g_pjcomm, "cp_ddd", szType);
				Str_Cpy(m_stUserinfo.szCp_ddd, szCpddd);
				Str_Chg(m_stUserinfo.szCp_ddd, STRCHG_DEL_NONDIGIT);

				Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
				szCpexn = (char*)JSON_GetValue ( g_pjcomm, "cp_exn", szType);
				Str_Cpy(m_stUserinfo.szCp_exn, szCpexn);
				Str_Chg(m_stUserinfo.szCp_exn, STRCHG_DEL_NONDIGIT);

				Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
				szCpnum = (char*)JSON_GetValue ( g_pjcomm, "cp_num", szType);
				Str_Cpy(m_stUserinfo.szCp_num, szCpnum);
				Str_Chg(m_stUserinfo.szCp_num, STRCHG_DEL_NONDIGIT);

				Mem_Set((byte*) szTmp, 0x00, sizeof( szTmp) );
				Str_Cpy(szTmp, m_stUserinfo.szCp_ddd);
				Str_Cat(szTmp, "-");
				Str_Cat(szTmp, m_stUserinfo.szCp_exn);
				Str_Cat(szTmp, "-");
				Str_Cat(szTmp, m_stUserinfo.szCp_num);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4),  szTmp);

				//���ڳ���
				Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
				szSmsdesc = (char*)JSON_GetValue ( g_pjcomm, "sms_template_desc", szType);
				SQL_ConvMbStr(m_stUserinfo.szSmsdesc, szSmsdesc);
				if( Str_Cmp(m_stUserinfo.szSmsdesc, "-1") == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5),  "");
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5),  m_stUserinfo.szSmsdesc);
				}
			}
		}
		else
		{
			ret = 0;
		}
		
Finally:		
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_Close_SubDlg();
		EvtDraw();
		
		return;
	}
	
//------------------------------------------------------------------
	void ChgDraw(void)
	{
		long i = 0;
		long lAddr = 0;
		char szTmp[512];
		char szBuf[512];
	
		g_Sql_SetCombo("select item_kname from commoncode WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_DATA1+2);

		Mem_Set((byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set((byte*) szBuf, 0x00, sizeof( szBuf) );
		if( g_nSmsFlag == 2 || g_nSmsFlag == 5 )
		{	
			//���ڰ�ħ ������ȭ��ȣ
			Analy_Phone(g_szCpNum, m_stUserinfo.szCp_ddd, m_stUserinfo.szCp_exn, m_stUserinfo.szCp_num);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_stUserinfo.szCp_ddd );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), m_stUserinfo.szCp_exn );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), m_stUserinfo.szCp_num );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA27), g_szTown );		//����

			Mem_Cpy( (byte*)szTmp, (byte*)g_szUSE_CONT_NUM, 5);
			Mem_Cpy( (byte*)szBuf, (byte*)g_szUSE_CONT_NUM+5, 5);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, szBuf);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA31), szTmp );	//����ȣ

			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			
			if( g_nSmsFlag == 2 )
			{
				if( m_lAddrFlag == 1 )
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHGADDR), "���θ� �ּ�");
					//���ּ�
					SPRINT( szTmp, "SELECT CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END FROM GUMDATA WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0 );
				}
				else
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHGADDR), "���� �ּ�");
					//���ּ�
					SPRINT( szTmp, "SELECT CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END FROM GUMDATA WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0 );
				}
				g_Sql_RetStr(szTmp, 510, szBuf);
			}
			else if( g_nSmsFlag == 5 )
			{
				if( m_lAddrFlag == 1 )
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHGADDR), "���θ� �ּ�");
					//���ּ�
					SPRINT( szTmp, "SELECT CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE ifnull(NEW_ADDR_M,'') ||'-'|| ifnull(NEW_ADDR_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END FROM GUM_SMS_TARGET WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0 );
				}
				else
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHGADDR), "���� �ּ�");
					//���ּ�
					SPRINT( szTmp, "SELECT CASE WHEN Length(Trim(CO_LIVE_NM))+Length(Trim(BLD_NM)) > 0 THEN ifnull(CO_LIVE_NM,'') ||' '|| ifnull(BLD_NM,'') ||'-'|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') ELSE ifnull(ADDR1_M,'') ||'-'|| ifnull(ADDR1_S,'') ||' '|| ifnull(HOSU,'') ||' '|| ifnull(DETA_FLOOR,'') END FROM GUM_SMS_TARGET WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0 );
				}
				g_Sql_RetStr(szTmp, 510, szBuf);
			}
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA29), szBuf );	//�ּ�
		}
		else
		{
			//��ħ��� ������ȭ��ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_stUserinfo.szCp_ddd );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), m_stUserinfo.szCp_exn );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), m_stUserinfo.szCp_num );

			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA27), m_stUserinfo.szCust_nm );		//����
			
			Mem_Cpy( (byte*)szTmp, (byte*)stGm.USE_CONT_NUM, 5);
			Mem_Cpy( (byte*)szBuf, (byte*)stGm.USE_CONT_NUM+5, 5);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, szBuf);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA31), szTmp);	//����ȣ

		//	EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA29), g_szCntSql );		//�ּ�

			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			if( m_lAddrFlag == 1)
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHGADDR), "���θ��ּ�");
			
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				if(Str_Len(stGm.NEW_ROAD_NM) > 0)
				{
					Str_Cpy(szTmp,  stGm.NEW_ROAD_NM );
				}
				else
				{
					Str_Cpy(szTmp,  "" );
				}
				if(Str_Len(stGm.NEW_ADDR_M) > 0)
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.NEW_ADDR_M);
				}
				if(Str_Len(stGm.NEW_ADDR_S) > 0)
				{
					Str_Cat(szTmp,  "-" );
					Str_Cat(szTmp,  stGm.NEW_ADDR_S);
				}
	
				if( Str_Len(stGm.CO_LIVE_NM) > 0 )
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.CO_LIVE_NM );
				}
				else
				{
					Str_Cat(szTmp,  "" );
				}
				if( Str_Len(stGm.BLD_NM) > 0 )
				{
					Str_Cat(szTmp,  " " );	
					Str_Cat(szTmp,  stGm.BLD_NM );
				}
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szTmp,  "-" );	
					Str_Cat(szTmp,  stGm.HOSU );
				}
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.DETA_FLOOR );		//������
				}
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA29), szTmp);
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHGADDR), "���� �ּ�");
			
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				if(Str_Len(stGm.TOWN) > 0)
				{
					Str_Cpy(szTmp,  stGm.TOWN );
				}
				else
				{
					Str_Cpy(szTmp,  "" );
				}
				if(Str_Len(stGm.VILLAGE) > 0)
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.VILLAGE );
				}
				if(Str_Len(stGm.ADDR1_M) > 0)
				{
					Str_Cat(szTmp,  " " );
					Str_Cat(szTmp,  stGm.ADDR1_M);
				}			
				if(Str_Len(stGm.ADDR1_S) > 0)
				{
					Str_Cat(szTmp,  "-" );
					Str_Cat(szTmp,  stGm.ADDR1_S);
				}
				
				lAddr = Str_Len(stGm.CO_LIVE_NM) + Str_Len(stGm.BLD_NM);
	
				if( lAddr > 0 )
				{
					if( Str_Len(stGm.CO_LIVE_NM) > 0 )
					{
						Str_Cat(szTmp,  " " );
						Str_Cat(szTmp,  stGm.CO_LIVE_NM );
					}
					else
					{
						Str_Cat(szTmp,  "" );
					}
						
					if( Str_Len(stGm.BLD_NM) > 0 )
					{
						Str_Cat(szTmp,  " " );	
						Str_Cat(szTmp,  stGm.BLD_NM );
					}
					
					if( Str_Len(stGm.HOSU) > 0 )
					{
						Str_Cat(szTmp,  "-" );	
						Str_Cat(szTmp,  stGm.HOSU );
					}
					
					if( Str_Len(stGm.DETA_FLOOR) > 0 )
					{
						Str_Cat(szTmp,  " " );	
						Str_Cat(szTmp,  stGm.DETA_FLOOR );		//������
					}
				}
				else
				{
					if( Str_Len(stGm.HOSU) > 0 )
					{
						Str_Cat(szTmp,  " " );
						Str_Cat(szTmp,  stGm.HOSU );
					}
					else
					{
						Str_Cat(szTmp,  "" );
					}
					
					if( Str_Len(stGm.DETA_FLOOR) > 0 )
					{
						Str_Cat(szTmp,  " " );	
						Str_Cat(szTmp,  stGm.DETA_FLOOR );		//������
					}
				}
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA29), szTmp);
			}
		}
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) <= 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), GM_TELCHG_WHY[0].Str);
		}
		
		ON_DRAW();
		return;
	}
	
//------------------------------------------------------------------------------------------
	long Rcv_Info(void)
	{
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25001, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        	stGm.USE_CONT_NUM );
		//20170920 ����� Ȳ���� ����� ��û, �ű�ȣ ����
		JSON_SetValue( g_pjcomm, 'C', "req_ym",        	        stGm.REQ_YM );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",        	stGm.DEADLINE_FLAG );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25001; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR25001_IN",  "FR25001" , sndbuf, sztmp );
		return 0 ;
	}
	
	
//------------------------------------------------------------------------------------------
	long TR25001(void)	
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(25001) >= 0)
		{
			ReDraw(25001);
			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}

//------------------------------------------------------------------
	long Snd_Change(void)
	{
		char szTmp[500];
		char szUrl[200];
		char szbuf[128];
		char szReqym[10];
		char szDeadlineFlag[10];
		char szSmsChgWhy[10];
		char* sndbuf;
		long i = 0;
		long ret = 0;
		long nLen = 0;

		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set( (byte*) szReqym, 0x00, sizeof( szReqym) );
		SPRINT( szTmp, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetStr(szTmp, 10, szReqym);
		
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set((byte*)szDeadlineFlag, 0x00, sizeof(szDeadlineFlag));	
		SPRINT( szTmp, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetStr(szTmp, 10, szDeadlineFlag);
		
		//������� -> �ڵ尪 ������ �ִ°ɷ�?? ���� Ȯ��
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set((byte*)szSmsChgWhy, 0x00, sizeof(szSmsChgWhy));	
        i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), GM_TELCHG_WHY );
        if (i == -1)
        {
            Str_Cpy(szSmsChgWhy, GM_TELCHG_WHY[0].Code);
        }
        else
        {
            Str_Cpy(szSmsChgWhy, GM_TELCHG_WHY[i].Code);
        }
		
		Mem_Set( (byte*) m_stUserinfo.szCp_ddd, 0x00, sizeof( m_stUserinfo.szCp_ddd) );
		Str_Cpy(m_stUserinfo.szCp_ddd, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)));
		Mem_Set( (byte*) m_stUserinfo.szCp_exn, 0x00, sizeof( m_stUserinfo.szCp_exn) );
		Str_Cpy(m_stUserinfo.szCp_exn, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		Mem_Set( (byte*) m_stUserinfo.szCp_num, 0x00, sizeof( m_stUserinfo.szCp_num) );
		Str_Cpy(m_stUserinfo.szCp_num, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25002, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "req_ym",              szReqym               );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",       szDeadlineFlag        );
		
		if( g_nSmsFlag == 2 || g_nSmsFlag == 5 )
		{
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        g_szUSE_CONT_NUM     );
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        stGm.USE_CONT_NUM     );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",              m_stUserinfo.szCp_ddd );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",              m_stUserinfo.szCp_exn );
		JSON_SetValue( g_pjcomm, 'C', "cp_num",              m_stUserinfo.szCp_num );
		JSON_SetValue( g_pjcomm, 'C', "sms_agree_chg_why",   szSmsChgWhy           );
				
		sndbuf = JSON_toString(g_pjcomm);
		
		//���۵����� Ȯ��
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR25002; //��ſϷ� �Ŀ� ȣ�� �Լ�
		HTTP_DownloadData( szUrl, "FR25002_IN",  "FR25002" , sndbuf, szbuf );

		return 1;
	}
	
//------------------------------------------------------------------
	long TR25002(void)
	{
		char szSql[250];
		char szTmp[100];

		if(g_Chk_Json(25002) >= 0)
		{
			//��ħ ��ȭ��ȣ ���� ��!!!!!!!!!!!
			//���� �۽� �Ϸ� ��, ���� DB �� ��Ʈ���� �� �����ų��.

			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			SPRINT(szSql, "UPDATE GUMDATA SET SMS_CP_DDD = '%s', SMS_CP_EXN = '%s', SMS_CP_NUM = '%s' ", m_stUserinfo.szCp_ddd, m_stUserinfo.szCp_exn, m_stUserinfo.szCp_num);
			if( g_nSmsFlag == 2 || g_nSmsFlag == 5 )
			{
				SPRINT(szTmp, " WHERE USE_CONT_NUM = '%s'", g_szUSE_CONT_NUM, 0, 0);
				Str_Cat(szSql, szTmp);
				g_Sql_DirectExecute(szSql);
				
				Card_Move("GM_SMSGM");
			}
			else
			{
				SPRINT(szTmp, " WHERE USE_CONT_NUM = '%s'", stGm.USE_CONT_NUM, 0, 0);

				Mem_Set((byte*)stGm.SMS_CP_DDD, 0x00, sizeof(stGm.SMS_CP_DDD));	
				Mem_Set((byte*)stGm.SMS_CP_EXN, 0x00, sizeof(stGm.SMS_CP_EXN));	
				Mem_Set((byte*)stGm.SMS_CP_NUM, 0x00, sizeof(stGm.SMS_CP_NUM));	
				Str_Cpy(stGm.SMS_CP_DDD, m_stUserinfo.szCp_ddd);
				Str_Cpy(stGm.SMS_CP_EXN, m_stUserinfo.szCp_exn);
				Str_Cpy(stGm.SMS_CP_NUM, m_stUserinfo.szCp_num);
				Str_Cat(szSql, szTmp);
				g_Sql_DirectExecute(szSql);
	
				ON_EXIT();
				OnInit(INIT_MAIN);
			}
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

//------------------------------------------------------------------
//g_nSmsFlag = 3 ��ݳ���
//g_nSmsFlag = 4 ��ݰ��
/*
//��ݳ��� - �׽�Ʈ �Է� �ڷ�
Mem_Set((byte*)&stFee_History, 0x00, sizeof(stFee_History));	
Str_Cpy(stFee_History.REQ_YM            , "201704");
Str_Cpy(stFee_History.USE_TOT_AMT       , "102010");
Str_Cpy(stFee_History.USE_PERIOD_STR    , "11.26");
Str_Cpy(stFee_History.USE_PERIOD_END    , "12.25");
Str_Cpy(stFee_History.CUST_NM           , "�迵��");
Str_Cpy(stFee_History.ADDR              , "������ ��ġ���14�� 33-16,����2(ȭ�)");
Str_Cpy(stFee_History.INDI_COMPENS_VC   , "2837");
Str_Cpy(stFee_History.BF_INDI_COMPENS_VC, "2710");
Str_Cpy(stFee_History.USE_QTY           , "127");
Str_Cpy(stFee_History.SET_QTY           , "126.8984");
Str_Cpy(stFee_History.SUPPLY_UNIT_ENER  , "42.812");
Str_Cpy(stFee_History.ENER_QTY          , "5419.4129");
Str_Cpy(stFee_History.USE_CHARG         , "91176");
Str_Cpy(stFee_History.USE_CHARG_DISC_AMT, "-100");
Str_Cpy(stFee_History.BASE_CHARG        , "1000");
Str_Cpy(stFee_History.CNL_CHARG_SUPPY   , "10");
Str_Cpy(stFee_History.ADJ_SET_CHARG     , "10");
Str_Cpy(stFee_History.VAT               , "9217");
Str_Cpy(stFee_History.OVERDUE_AMT       , "0");
Str_Cpy(stFee_History.ADJ_ALT_AMT       , "-200");
Str_Cpy(stFee_History.REPL_COST         , "10");
Str_Cpy(stFee_History.SUBTR_REQ_AMT     , "102010");
Str_Cpy(stFee_History.UNCOL_AMT_REMA    , "0");
Str_Cpy(stFee_History.WOORI_ACCNO       , "1111111111");
Str_Cpy(stFee_History.KOOKMIN_ACCNO     , "2222222222");
Str_Cpy(stFee_History.SHINHAN_ACCNO     , "3333333333");
Str_Cpy(stFee_History.HANA_ACCNO        , "4444444444");
Str_Cpy(stFee_History.FB_ACCNO          , "5555555555");
Str_Cpy(stFee_History.NH_ACCNO          , "6666666666");
Str_Cpy(stFee_History.CITY_ACCNO        , "7777777777");
Str_Cpy(stFee_History.IBK_ACCNO         , "8888888888");
Str_Cpy(stFee_History.CENTER_NM         , "���� 1������");
Str_Cpy(stFee_History.TEL1_DDD          , "02");
Str_Cpy(stFee_History.TEL1_EXN          , "712");
Str_Cpy(stFee_History.TEL1_NUM          , "3834");
*/
	void FeeDraw(void)
	{
		char szMsg[500];
		char szTmp[200];
		char szBuf[100];
		char szComma[100];
		long i = 0 , j = 0 , k = 0;
		long lLen = 0;
		handle hHeader_Grid = NULL;

		Mem_Set((byte*)m_szSms, 0x00, sizeof(m_szSms));	

		if( g_nSmsFlag == 3 )
		{
			Str_Cpy(m_szSms[0], "�� ���û������ ���ڹ߼�\n");
			Str_Cat(m_szSms[0], "--------------------\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
			Mem_Cpy( (byte*)szTmp, (byte*)stFee_History.REQ_YM, 4);
			Mem_Cpy( (byte*)szBuf, (byte*)stFee_History.REQ_YM+4, Str_Len(stFee_History.REQ_YM)-4);
			SPRINT(szMsg,  "�� %s��%s�� ������� û������\n", szTmp,szBuf,0);

			Str_Cat(m_szSms[0], szMsg);
			
			Str_Cat(m_szSms[0], "--------------------\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			i = 0;
			i = Str_AtoI(stFee_History.SUBTR_REQ_AMT) + Str_AtoI(stFee_History.UNCOL_AMT_REMA);
			Str_ItoA(i, szComma, 10);
			Str_Chg(szComma, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "�ް������ݾ� (��+��) : %s��\n", szComma,0,0);
			Str_Cat(m_szSms[0], szMsg);
	
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			g_Str_DateType( szBuf, stFee_History.USE_PERIOD_STR);
			g_Str_DateType( szComma, stFee_History.USE_PERIOD_END);
			SPRINT(szMsg,  "�޻��Ⱓ: %s~%s\n", szBuf,szComma,0);
			Str_Cat(m_szSms[0], szMsg);

			Str_Cat(m_szSms[0], "--------------------\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "�ް���: %s��\n", stFee_History.CUST_NM,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "���ּ� : %s\n", stFee_History.ADDR,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Str_Cat(m_szSms[0], "--------------------\n");
			Str_Cat(m_szSms[0], "�� ���ð��� �������\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			Str_Cpy(szComma, stFee_History.INDI_COMPENS_VC);
			Str_Chg(szComma, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "������ħ %s��\n", szComma,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			Str_Cpy(szComma, stFee_History.BF_INDI_COMPENS_VC);
			Str_Chg(szComma, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "��������ħ %s��\n", szComma,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "�޻�뷮 %s��\n", stFee_History.USE_QTY,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			lLen = Str_Len(stFee_History.SET_QTY);
			for( i=0 ; i < lLen ; i++ )
			{
				if( stFee_History.SET_QTY[i] == '.' )
				{
					break;
				}
				else if( stFee_History.SET_QTY[i] == '' )
				{
					i = 0;
					break;
				}
			}
			if( i > 0 )
			{
				Mem_Cpy( (byte*)szTmp, (byte*)stFee_History.SET_QTY,  i);
				Mem_Cpy( (byte*)szBuf, (byte*)stFee_History.SET_QTY+i,  (lLen-i));
			}
			else
			{
				Str_Cpy(szTmp, "0");
			}
			Str_Chg(szTmp,  STRCHG_INS_COMMA);
			Str_Cat(szTmp, szBuf);
			SPRINT(szMsg,  "�������� %s��\n", szTmp,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			lLen = Str_Len(stFee_History.SUPPLY_UNIT_ENER);
			for( i=0 ; i < lLen ; i++ )
			{
				if( stFee_History.SUPPLY_UNIT_ENER[i] == '.' )
				{
					break;
				}
				else if( stFee_History.SUPPLY_UNIT_ENER[i] == '' )
				{
					i = 0;
					break;
				}
			}
			if( i > 0 )
			{
				Mem_Cpy( (byte*)szTmp, (byte*)stFee_History.SUPPLY_UNIT_ENER,  i);
				Mem_Cpy( (byte*)szBuf, (byte*)stFee_History.SUPPLY_UNIT_ENER+i,  (lLen-i));
			}
			else
			{
				Str_Cpy(szTmp, "0");
			}
			Str_Chg(szTmp,  STRCHG_INS_COMMA);
			Str_Cat(szTmp, szBuf);
			SPRINT(szMsg,  "�޴������� %sMJ/��\n", szTmp,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			lLen = Str_Len(stFee_History.ENER_QTY);
			for( i=0 ; i < lLen ; i++ )
			{
				if( stFee_History.ENER_QTY[i] == '.' )
				{
					break;
				}
				else if( stFee_History.ENER_QTY[i] == '' )
				{
					i = 0;
					break;
				}
			}
			if( i > 0 )
			{
				Mem_Cpy( (byte*)szTmp, (byte*)stFee_History.ENER_QTY,  i);
				Mem_Cpy( (byte*)szBuf, (byte*)stFee_History.ENER_QTY+i,  (lLen-i));
			}
			else
			{
				Str_Cpy(szTmp, "0");
			}
			Str_Chg(szTmp,  STRCHG_INS_COMMA);
			Str_Cat(szTmp, szBuf);
			SPRINT(szMsg,  "�޻�뿭�� %sMJ/��\n", szTmp,0,0);
			Str_Cat(m_szSms[0], szMsg);

			if( Str_Len(stFee_History.USE_CHARG) > 0 && Str_Cmp(stFee_History.USE_CHARG, "0") != 0  && Str_Cmp(stFee_History.USE_CHARG, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_History.USE_CHARG);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�޻���� %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_History.USE_CHARG_DISC_AMT) > 0 && Str_Cmp(stFee_History.USE_CHARG_DISC_AMT, "0") != 0  && Str_Cmp(stFee_History.USE_CHARG_DISC_AMT, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_History.USE_CHARG_DISC_AMT);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�ް����� %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_History.BASE_CHARG) > 0 && Str_Cmp(stFee_History.BASE_CHARG, "0") != 0  && Str_Cmp(stFee_History.BASE_CHARG, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_History.BASE_CHARG);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�ޱ⺻��� %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_History.CNL_CHARG_SUPPY) > 0 && Str_Cmp(stFee_History.CNL_CHARG_SUPPY, "0") != 0  && Str_Cmp(stFee_History.CNL_CHARG_SUPPY, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_History.CNL_CHARG_SUPPY);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "������������ %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_History.ADJ_SET_CHARG) > 0 && Str_Cmp(stFee_History.ADJ_SET_CHARG, "0") != 0  && Str_Cmp(stFee_History.ADJ_SET_CHARG, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_History.ADJ_SET_CHARG);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "������������ %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_History.VAT) > 0 && Str_Cmp(stFee_History.VAT, "0") != 0  && Str_Cmp(stFee_History.VAT, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_History.VAT);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�޺ΰ��� %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_History.OVERDUE_AMT) > 0 && Str_Cmp(stFee_History.OVERDUE_AMT, "0") != 0  && Str_Cmp(stFee_History.OVERDUE_AMT, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_History.OVERDUE_AMT);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�޿�ü�� %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_History.ADJ_ALT_AMT) > 0 && Str_Cmp(stFee_History.ADJ_ALT_AMT, "0") != 0  && Str_Cmp(stFee_History.ADJ_ALT_AMT, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				i = 0;
				k = 0;
				i = Str_AtoI(stFee_History.ADJ_ALT_AMT);
				k = i * (-1);
				if( k > 0 || k == 0 )
				{
					Str_Cpy(szTmp, stFee_History.ADJ_ALT_AMT);
					Str_Chg(szTmp, STRCHG_INS_COMMA);
				}
				else
				{
					Str_Cpy(szComma, stFee_History.ADJ_ALT_AMT);
					Str_Chg(szComma, STRCHG_INS_COMMA);
					Str_Cpy(szTmp, "-");
					Str_Cat(szTmp, szComma);
				}
				SPRINT(szMsg,  "������ݾ� %s��\n", szTmp,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_History.REPL_COST) > 0 && Str_Cmp(stFee_History.REPL_COST, "0") != 0  && Str_Cmp(stFee_History.REPL_COST, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_History.REPL_COST);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�ޱ�ü�� %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			Str_Cpy(szComma, stFee_History.SUBTR_REQ_AMT);
			Str_Chg(szComma, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "��Ұ� %s��\n", szComma,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Str_Cat(m_szSms[0], "--------------------\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			Str_Cpy(szComma, stFee_History.UNCOL_AMT_REMA);
			Str_Chg(szComma, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "��̳��� %s��\n", szComma,0,0);
			Str_Cat(m_szSms[0], szMsg);
			
			Str_Cat(m_szSms[1], "--------------------\n");
			Str_Cat(m_szSms[1], "�� �Ա�������¾ȳ�\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  �츮���� : %s\n", stFee_History.WOORI_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  �������� : %s\n", stFee_History.KOOKMIN_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  �������� : %s\n", stFee_History.SHINHAN_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  �ϳ����� : %s\n", stFee_History.HANA_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  SC���� : %s\n", stFee_History.FB_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  ���� : %s\n", stFee_History.NH_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  ��Ƽ���� : %s\n", stFee_History.CITY_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  ������� : %s\n", stFee_History.IBK_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Str_Cat(m_szSms[1], "�� ����\n");
			Str_Cat(m_szSms[1], "�ϼ��ﵵ�ð��� �ݼ���: 1588-5788\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "��%s : %s-%s-", stFee_History.CENTER_NM,stFee_History.TEL1_DDD,stFee_History.TEL1_EXN);
			Str_Cat(szMsg, stFee_History.TEL1_NUM);
			
			Str_Cat(m_szSms[1], szMsg);
		}
		else if( g_nSmsFlag == 4 )
		{
			//��ݰ��
			Str_Cpy(m_szSms[0], "�� ��ݰ�� ��������\n");
			Str_Cat(m_szSms[0], "--------------------\n");
			Str_Cat(m_szSms[0], "�� ���ð��� ��ݳ���\n");

			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			i = 0;
			if( Str_AtoI(stFee_Calcul.SUSPN_REMA) > Str_AtoI(stFee_Calcul.SUBTR_REQ_AMT) )
			{
				Str_Cpy(szTmp, "0");
				i = Str_AtoI(szTmp) + Str_AtoI(stFee_Calcul.BF_UNPAY_AMT);
				Str_ItoA(i, szComma, 10);
			}
			else
			{
				i = Str_AtoI(stFee_Calcul.TOT_REQ_AMT) - Str_AtoI(stFee_Calcul.SUSPN_REMA) + Str_AtoI(stFee_Calcul.BF_UNPAY_AMT);
				Str_ItoA(i, szComma, 10);
				//stFee_Calcul.UNPAY_AMT
			}
			Str_Chg(szComma, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "�ް������ݾ� (��+��) : %s��\n", szComma,0,0);
			Str_Cat(m_szSms[0], szMsg);
			
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));	
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			g_Str_DateType( szBuf, stFee_Calcul.USE_PERIOD_STR);
			g_Str_DateType( szComma, stFee_Calcul.USE_PERIOD_END);
			SPRINT(szMsg,  "�޻��Ⱓ: %s~%s\n", szBuf,szComma,0);
			Str_Cat(m_szSms[0], szMsg);

			Str_Cat(m_szSms[0], "--------------------\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "�ް���: %s��\n", stFee_Calcul.CUST_NM,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "���ּ�   : %s\n", stFee_Calcul.ADDR,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Str_Cat(m_szSms[0], "--------------------\n");
			Str_Cat(m_szSms[0], "�� ���ð��� �������\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			Str_Cpy(szComma, stFee_Calcul.INDI_COMPENS_THIS_MM_VC);
			Str_Chg(szComma, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "������ħ       : %s��\n", szComma,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
			Str_Cpy(szComma, stFee_Calcul.INDI_COMPENS_VC);
			Str_Chg(szComma, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "��������ħ    : %s��\n", szComma,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "�޻�뷮       : %s��\n", stFee_Calcul.USE_QTY,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			lLen = Str_Len(stFee_Calcul.SET_QTY);
			for( i=0 ; i < lLen ; i++ )
			{
				if( stFee_Calcul.SET_QTY[i] == '.' )
				{
					break;
				}
				else if( stFee_Calcul.SET_QTY[i] == '' )
				{
					i = 0;
					break;
				}
			}
			if( i > 0 )
			{
				Mem_Cpy( (byte*)szTmp, (byte*)stFee_Calcul.SET_QTY,  i);
				Mem_Cpy( (byte*)szBuf, (byte*)stFee_Calcul.SET_QTY+i,  (lLen-i));
			}
			else
			{
				Str_Cpy(szTmp, "0");
			}
			Str_Chg(szTmp,  STRCHG_INS_COMMA);
			Str_Cat(szTmp, szBuf);
			SPRINT(szMsg,  "��������       : %s��\n", szTmp,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			lLen = Str_Len(stFee_Calcul.SUPPLY_UNIT_ENER);
			for( i=0 ; i < lLen ; i++ )
			{
				if( stFee_Calcul.SUPPLY_UNIT_ENER[i] == '.' )
				{
					break;
				}
				else if( stFee_Calcul.SUPPLY_UNIT_ENER[i] == '' )
				{
					i = 0;
					break;
				}
			}
			if( i > 0 )
			{
				Mem_Cpy( (byte*)szTmp, (byte*)stFee_Calcul.SUPPLY_UNIT_ENER,  i);
				Mem_Cpy( (byte*)szBuf, (byte*)stFee_Calcul.SUPPLY_UNIT_ENER+i,  (lLen-i));
			}
			else
			{
				Str_Cpy(szTmp, "0");
			}
			Str_Chg(szTmp,  STRCHG_INS_COMMA);
			Str_Cat(szTmp, szBuf);
			SPRINT(szMsg,  "�޴�������    : %sMJ/��\n", szTmp,0,0);
			Str_Cat(m_szSms[0], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
			lLen = Str_Len(stFee_Calcul.ENER_QTY);
			for( i=0 ; i < lLen ; i++ )
			{
				if( stFee_Calcul.ENER_QTY[i] == '.' )
				{
					break;
				}
				else if( stFee_Calcul.ENER_QTY[i] == '' )
				{
					i = 0;
					break;
				}
			}
			if( i > 0 )
			{
				Mem_Cpy( (byte*)szTmp, (byte*)stFee_Calcul.ENER_QTY,  i);
				Mem_Cpy( (byte*)szBuf, (byte*)stFee_Calcul.ENER_QTY+i,  (lLen-i));
			}
			else
			{
				Str_Cpy(szTmp, "0");
			}
			Str_Chg(szTmp,  STRCHG_INS_COMMA);
			Str_Cat(szTmp, szBuf);
			SPRINT(szMsg,  "�޻�뿭��    : %sMJ/��\n", szTmp,0,0);
			Str_Cat(m_szSms[0], szMsg);

			if( Str_Len(stFee_Calcul.USE_CHARG) > 0 && Str_Cmp(stFee_Calcul.USE_CHARG, "0") != 0  && Str_Cmp(stFee_Calcul.USE_CHARG, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_Calcul.USE_CHARG);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�޻����    : %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_Calcul.USE_CHARG_DISC_AMT) > 0 && Str_Cmp(stFee_Calcul.USE_CHARG_DISC_AMT, "0") != 0  && Str_Cmp(stFee_Calcul.USE_CHARG_DISC_AMT, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_Calcul.USE_CHARG_DISC_AMT);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�ް�����    : %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_Calcul.BASE_CHARG) > 0 && Str_Cmp(stFee_Calcul.BASE_CHARG, "0") != 0  && Str_Cmp(stFee_Calcul.BASE_CHARG, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_Calcul.BASE_CHARG);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�ޱ⺻���    : %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_Calcul.CNL_CHARG_SUPPY) > 0 && Str_Cmp(stFee_Calcul.CNL_CHARG_SUPPY, "0") != 0  && Str_Cmp(stFee_Calcul.CNL_CHARG_SUPPY, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_Calcul.CNL_CHARG_SUPPY);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "������������ : %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_Calcul.ADJ_SET_CHARG) > 0 && Str_Cmp(stFee_Calcul.ADJ_SET_CHARG, "0") != 0  && Str_Cmp(stFee_Calcul.ADJ_SET_CHARG, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_Calcul.ADJ_SET_CHARG);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "������������ : %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_Calcul.VAT) > 0 && Str_Cmp(stFee_Calcul.VAT, "0") != 0  && Str_Cmp(stFee_Calcul.VAT, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_Calcul.VAT);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�޺ΰ���        : %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_Calcul.OVERDUE_AMT) > 0 && Str_Cmp(stFee_Calcul.OVERDUE_AMT, "0") != 0  && Str_Cmp(stFee_Calcul.OVERDUE_AMT, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_Calcul.OVERDUE_AMT);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�޿�ü��        : %s��\n", stFee_Calcul.OVERDUE_AMT,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

			if( Str_Len(stFee_Calcul.SUSPN_REMA) > 0 && Str_Cmp(stFee_Calcul.SUSPN_REMA, "0") != 0  && Str_Cmp(stFee_Calcul.SUSPN_REMA, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_Calcul.SUSPN_REMA);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�޿������ܾ� : %s��\n", szComma,0,0);
				Str_Cat(m_szSms[0], szMsg);
			}

//2page
			if( Str_Len(stFee_Calcul.REPL_COST) > 0 && Str_Cmp(stFee_Calcul.REPL_COST, "0") != 0  && Str_Cmp(stFee_Calcul.REPL_COST, "") != 0)
			{
				Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
				Mem_Set((byte*)szComma, 0x00, sizeof(szComma));	
				Str_Cpy(szComma, stFee_Calcul.REPL_COST);
				Str_Chg(szComma, STRCHG_INS_COMMA);
				SPRINT(szMsg,  "�ޱ�ü��     : %s��\n", stFee_Calcul.REPL_COST,0,0);
				Str_Cat(m_szSms[1], szMsg);
			}

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			i = 0;
			if( Str_AtoI(stFee_Calcul.SUSPN_REMA) > Str_AtoI(stFee_Calcul.SUBTR_REQ_AMT) )
			{
				Str_Cpy(stFee_Calcul.REQ_AMT, "0");		//û����
				
				if( Str_AtoI(stFee_Calcul.SUBTR_REQ_AMT) < Str_AtoI(stFee_Calcul.SUSPN_REMA) )
				{
					i = Str_AtoI(stFee_Calcul.SUSPN_REMA) - Str_AtoI(stFee_Calcul.SUBTR_REQ_AMT);
					Str_ItoA(i, stFee_Calcul.SUSPN_REQ_AMT, 10);		//�����ݴ�ü�� �ܾ�
				}
			}
			else
			{
				i = Str_AtoI(stFee_Calcul.SUBTR_REQ_AMT) - Str_AtoI(stFee_Calcul.SUSPN_REMA);
				Str_ItoA(i, stFee_Calcul.REQ_AMT, 10);		//û����
				
				Str_Cpy(stFee_Calcul.SUSPN_REQ_AMT, "0");
			}
			
			Str_Chg(stFee_Calcul.REQ_AMT, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "��Ұ�         : %s��\n", stFee_Calcul.REQ_AMT,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Str_Cat(m_szSms[1], "--------------------\n");
			

			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			if( Str_AtoI(stFee_Calcul.UNCOL_AMT_REMA) < Str_AtoI(stFee_Calcul.SUSPN_REQ_AMT) )
			{
				Str_Cpy(szTmp, "0");
			}
			else
			{
				i = 0;
				i = Str_AtoI(stFee_Calcul.UNCOL_AMT_REMA) - Str_AtoI(stFee_Calcul.SUSPN_REQ_AMT);
				Str_ItoA(i, szTmp, 10);
			}
			i = 0;
			i = Str_AtoI(szTmp) + Str_AtoI(stFee_Calcul.BF_UNPAY_AMT) + Str_AtoI(stFee_Calcul.SUMAMT2) + Str_AtoI(stFee_Calcul.DEBT_UNPAY_AMT);
			Str_ItoA(i, stFee_Calcul.UNPAY_AMT, 10);
					
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Str_Chg(stFee_Calcul.UNPAY_AMT, STRCHG_INS_COMMA);
			SPRINT(szMsg,  "��̳���     : %s��\n", stFee_Calcul.UNPAY_AMT,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Str_Cat(m_szSms[1], "--------------------\n");
			Str_Cat(m_szSms[1], "�� �Ա�������¾ȳ�\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  �츮���� : %s\n", stFee_Calcul.WOORI_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  �������� : %s\n", stFee_Calcul.KOOKMIN_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  �������� : %s\n", stFee_Calcul.SHINHAN_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  �ϳ����� : %s\n", stFee_Calcul.HANA_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  SC   ���� : %s\n", stFee_Calcul.FB_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  ����        : %s\n", stFee_Calcul.NH_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  ��Ƽ���� : %s\n", stFee_Calcul.CITY_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "  ������� : %s\n", stFee_Calcul.IBK_ACCNO,0,0);
			Str_Cat(m_szSms[1], szMsg);


			Str_Cat(m_szSms[1], "�� ����\n");
			Str_Cat(m_szSms[1], "�ϼ��ﵵ�ð��� �ݼ���: 1588-5788\n");

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			SPRINT(szMsg,  "��%s : %s-%s-", stFee_Calcul.CENTER_NM,stFee_Calcul.TEL1_DDD,stFee_Calcul.TEL1_EXN);
			Str_Cat(szMsg, stFee_Calcul.TEL1_NUM);

			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));	
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			g_Str_DateType( szTmp, stFee_Calcul.ADJ_JOB_DTM);
			SPRINT(szMsg,  "����ð� : %s\n", szTmp,0,0);
			Str_Cat(m_szSms[1], "");

			Str_Cat(m_szSms[1], szMsg);
		}
	
		if( m_lPage == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), m_szSms[0] );
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA10), m_szSms[1] );
		}
//PRINT("m_szSms : %s , Length : %d",m_szSms,Str_Len(m_szSms),0);
		
		ON_DRAW();
		return;
	}


	//------------------------------------------------------------------
	long Analy_Phone(char* phone, char* num1, char* num2, char* num3 )
	{
	long len;
	
		Str_Chg(phone, STRCHG_DEL_NONDIGIT );
		len = Str_Len(phone);
		
		if( len == 9 )
		{
			Mem_Cpy( (byte*)num1, (byte*)phone,  2);
			Mem_Cpy( (byte*)num2, (byte*)phone+2,  3);
			Mem_Cpy( (byte*)num3, (byte*)phone+5,  4);
		}
		else if( len == 10 )
		{
			if( Mem_Cmp((byte*)phone, (byte*)"01", 2) == 0  )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else if(  Mem_Cmp((byte*)phone, (byte*)"02", 2) == 0 )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  2);
				Mem_Cpy( (byte*)num2, (byte*)phone+2,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
		}
		else if( len == 11 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,  3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+7,  4);
		}
		else if( len == 12 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,  4);
				Mem_Cpy( (byte*)num2, (byte*)phone+4,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+8,  4);
		}
		else
		{
			return -1;
		}
		
		if( !g_CheckPhoneNumber("1", num1, num2, num3) )
		{
			return -1;
		}

		return 1;
	}

	//---------------------------------------------------------------------------------------
	long SND_SMS(void)
	{
	char sztmp[128];
	char szUrl[128];
	char szPhoneNum[32];
	char szPhoneNum1[5];
	char szPhoneNum2[5];
	char szPhoneNum3[5];
	char szCUST_NM[62];
	char* sndbuf;
	long ret = 0;

		Mem_Set( (byte*)szPhoneNum, 0x00, sizeof(szPhoneNum) );
		Str_Cpy(szPhoneNum , stGm.CP_DDD);
		Str_Cat(szPhoneNum , stGm.CP_EXN);
		Str_Cat(szPhoneNum , stGm.CP_NUM);
		ret = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
		if( ret < 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
			ON_DRAW();
			return ret;
		}
		
		Mem_Set( (byte*)szPhoneNum, 0x00, sizeof(szPhoneNum) );
		Mem_Set( (byte*)szPhoneNum1, 0x00, sizeof(szPhoneNum1) );
		Mem_Set( (byte*)szPhoneNum2, 0x00, sizeof(szPhoneNum2) );
		Mem_Set( (byte*)szPhoneNum3, 0x00, sizeof(szPhoneNum3) );
			
		if(m_send_tel_flag[0] == '1' )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			
			Tapi_GetPhoneNum( (byte*)sztmp, 0);
			
			if( Str_Cmp(sztmp, "01099991111") == 0 )
			{
				Str_Cpy(szPhoneNum, "00000000000");
				MessageBoxEx (CONFIRM_OK, "�ܸ��� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
				return ret;
			}
			else
			{
				Str_Cpy(szPhoneNum, sztmp);
			}
			
			ret = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
		}
		else if(m_send_tel_flag[0] == '2' )
		{
			ret = Analy_Phone(stUserinfo.szcellphone, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
			if(ret < 0)
				MessageBoxEx (CONFIRM_OK, "����� ��ȭ��ȣ�� Ȯ���ϼ���.");
		}
		else if(m_send_tel_flag[0] == '3' )
		{
			ret = Analy_Phone(stUserinfo.sztel, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
			if(ret < 0)
				MessageBoxEx (CONFIRM_OK, "��ȭ��ȣ�� Ȯ���ϼ���.");
		}
		else if(m_send_tel_flag[0] == '4' )
		{
			Str_Cpy(szPhoneNum2, "1588" );
			Str_Cpy(szPhoneNum3, "5788" );
			ret = 1;
		}
		
		if( ret < 0 )
		{
			ON_DRAW();
			return ret;
		}
		
		if( MessageBoxEx (CONFIRM_YESNO, "���� ���õ� ���Բ�\n�޽����� �߼��ϰڽ��ϱ�?") == MB_OK )
		{
			if( g_pjcomm != NULL)
			{
				JSON_Finalize( g_pjcomm );
				g_pjcomm = NULL;
			}
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 21365, FALSE);

			JSON_SetValue( g_pjcomm, 'C', "mtr_num",           stGm.MTR_NUM );
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",      stGm.USE_CONT_NUM );
			JSON_SetValue( g_pjcomm, 'C', "cust_num",          stGm.CUST_NUM );
			JSON_SetValue( g_pjcomm, 'C', "send_tel_flag",     m_send_tel_flag );
			JSON_SetValue( g_pjcomm, 'C', "sms_desc_flag",     m_sms_desc_flag );
			JSON_SetValue( g_pjcomm, 'C', "send_flag",         m_send_flag );
	
			JSON_SetValue( g_pjcomm, 'C', "send_tel_ddd",      szPhoneNum1 );
			JSON_SetValue( g_pjcomm, 'C', "send_tel_exn",      szPhoneNum2 );
			JSON_SetValue( g_pjcomm, 'C', "send_tel_num",      szPhoneNum3 );
			
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_ddd",  stGm.CP_DDD );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_exn",  stGm.CP_EXN );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_num",  stGm.CP_NUM );

			Mem_Set( (byte*) szCUST_NM, 0x00, sizeof( szCUST_NM) );
			SQL_ConvUcStr( szCUST_NM, stGm.CUST_NM );
			JSON_SetValue( g_pjcomm, 'C', "receiver_nm",       szCUST_NM );
			JSON_SetValue( g_pjcomm, 'C', "center_cd",         stUserinfo.szcenter_cd );

			sndbuf = JSON_toString(g_pjcomm);
			g_SeverConnection();
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
			GET_FILENM(sztmp, SQLITE_DB);
			
			callBackfunc = TR21365; //��ſϷ� �Ŀ� ȣ�� �Լ�
			ret = HTTP_DownloadData(szUrl, "FR21365_IN",  "FR21365" , sndbuf, sztmp );
		}
		
		return ret;
	}
	
	//---------------------------------------------------------------------------------------
	long TR21365(void)
	{
		g_Sock_Close();
		if(g_Chk_Json(21365) >= 0)
		{
			if(m_send_flag[0] == '1')
				MessageBoxEx (CONFIRM_OK, "SMS������ �Ϸ� �Ǿ����ϴ�.");
			else
				MessageBoxEx (CONFIRM_OK, "SMS������ ���� �Ǿ����ϴ�.");

			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			return -1;
		}
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


	//-----------------------------------------------------------------------
	//���ڰ�ħ ��� ���
	long Snd_Sms_New(void)
	{
		char szSql[256];
		char sztmp[32];
		char szUrl[256];
		char szReqym[10];
		char szDeadlineFlag[10];
		char* sndbuf;
		long ret;

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25004, FALSE);

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szReqym, 0x00, sizeof( szReqym) );
		SPRINT( szSql, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, szReqym);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set((byte*)szDeadlineFlag, 0x00, sizeof(szDeadlineFlag));	
		SPRINT( szSql, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, szDeadlineFlag);

		//GMTR_SEND_STS = 90 -> ���(����) ��� , ����� �����ϸ� update , �������� ������ insert
		if( Str_Cmp(stGm.GMTR_SEND_STS, "90") == 0 || Str_Len(stGm.GMTR_SEND_STS) > 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "gubun",        		"U" );
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "gubun",        		"I" );
		}

		JSON_SetValue( g_pjcomm, 'C', "req_ym",        		szReqym );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",      szDeadlineFlag );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",       stGm.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_ddd",   m_stUserinfo.szCp_ddd );
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_exn",   m_stUserinfo.szCp_exn );
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_num",   m_stUserinfo.szCp_num );
		JSON_SetValue( g_pjcomm, 'C', "cust_num",        	stGm.CUST_NUM );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        	stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "send_type",        	"10" );  //10 : ���� , 20 : �׷�
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_sec",  stGm.NONPAY_MANAGE_SEC );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25004; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR25004_IN",  "FR25004" , sndbuf, sztmp );
		return 0 ;
	}

	//-----------------------------------------------------------------------
	long TR25004(void)
	{
		long ntotcnt = 0;
		char szIndi_VM[10];		//��� VM ��ħ 
		char szIndi_VA[10];		//��� VA��ħ 
		char szIndi_VC[10];		//��� VC��ħ
		char szIndi_Qty[10];
		char szDate[20];
		char szTmp[256];
	
		if( g_Chk_Json(25004) >= 0)
		{
			Snd_Sms_Gm();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}

	//-----------------------------------------------------------------------
	//���ڰ�ħ ���� ����
	long Snd_Sms_Gm(void)
	{
		char szSql[256];
		char sztmp[32];
		char szUrl[256];
		char szReqym[10];
		char szDeadlineFlag[10];
		char szCustnm[50];
		char szSmsdesc[500];
		char* sndbuf;
		long ret;

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25003, FALSE);

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szReqym, 0x00, sizeof( szReqym) );
		SPRINT( szSql, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, szReqym);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set((byte*)szDeadlineFlag, 0x00, sizeof(szDeadlineFlag));	
		SPRINT( szSql, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, szDeadlineFlag);

		JSON_SetValue( g_pjcomm, 'C', "req_ym",        		szReqym );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",      szDeadlineFlag );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",       stGm.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",        		m_stUserinfo.szCp_ddd );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",        		m_stUserinfo.szCp_exn );
		JSON_SetValue( g_pjcomm, 'C', "cp_num",        	    m_stUserinfo.szCp_num );
		JSON_SetValue( g_pjcomm, 'C', "send_flag",        	"1" );		//( 1 :  ��ù߼� , 2: ����߼� )
		JSON_SetValue( g_pjcomm, 'C', "gmtr_send_sts",      "40" );		//(  20 : �߼���, 30 : ����,  90 : ���, 40 : �߼ۿϷ�)
		JSON_SetValue( g_pjcomm, 'C', "reserve_dtm",        "" );	//������ ��쿡�� �Է�
		
		Mem_Set( (byte*) szCustnm, 0x00, sizeof( szCustnm) );
		SQL_ConvUcStr( szCustnm, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA2)) );
		JSON_SetValue( g_pjcomm, 'C', "receiver_nm",        szCustnm );
		
		Mem_Set( (byte*) szSmsdesc, 0x00, sizeof( szSmsdesc) );
		SQL_ConvUcStr( szSmsdesc, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA5)) );
		JSON_SetValue( g_pjcomm, 'C', "sms_desc",        	szSmsdesc );

		JSON_SetValue( g_pjcomm, 'C', "cust_num",        	stGm.CUST_NUM );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        	stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_sec",  stGm.NONPAY_MANAGE_SEC );
		JSON_SetValue( g_pjcomm, 'C', "send_type",        	"10" );  //10 : ���� , 20 : �׷�
		JSON_SetValue( g_pjcomm, 'C', "sms_num",        	stGm.SMS_NUM );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25003; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR25003_IN",  "FR25003" , sndbuf, sztmp );
		return 0 ;
	}

	//-----------------------------------------------------------------------
	long TR25003(void)
	{
		long ntotcnt = 0;
		char szIndi_VM[10];		//��� VM ��ħ 
		char szIndi_VA[10];		//��� VA��ħ 
		char szIndi_VC[10];		//��� VC��ħ
		char szIndi_Qty[10];
		char szDate[20];
		char szTmp[256];
	
		if( g_Chk_Json(25003) >= 0)
		{
			//���� ������ ���� -> ȭ���̵� �� ����
			g_nSmsSndFlag = 1;
			Card_Move("GM_ENTRY");
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}


	//-----------------------------------------------------------------------
	//��� ���� ����
	long Snd_Fee(void)
	{
		char szSms[3000];
		char sztmp[1500];
		char szUrl[256];
		char szPhoneNum[20];
		char szSnd_ddd[6];
		char szSnd_exn[6];
		char szSnd_num[6];
		char* sndbuf;
		long ret;

		Mem_Set((byte*)szSms, 0x00, sizeof(szSms));	
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		SQL_ConvUcStr( szSms, m_szSms[0] );
		SQL_ConvUcStr( sztmp, m_szSms[1] );
		Str_Cat(szSms, sztmp);
		
		Mem_Set((byte*)szPhoneNum, 0x00, sizeof(szPhoneNum));	
		Mem_Set((byte*)szSnd_ddd, 0x00, sizeof(szSnd_ddd));	
		Mem_Set((byte*)szSnd_exn, 0x00, sizeof(szSnd_exn));	
		Mem_Set((byte*)szSnd_num, 0x00, sizeof(szSnd_num));	
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );

		Tapi_GetPhoneNum( (byte*)sztmp, 0);
		
		if( Str_Cmp(sztmp, "01099991111") == 0 )
		{
			Str_Cpy(szPhoneNum, "00000000000");
			MessageBoxEx(CONFIRM_OK, "�߼� ����");
			return 0 ;
		}
		else
		{
			Str_Cpy(szPhoneNum, sztmp);
		}
		
		Analy_Phone(szPhoneNum, szSnd_ddd, szSnd_exn, szSnd_num);

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 242453, FALSE);

		//(C294 : ��ݰ��ȳ�, C295: ��ݳ����ȳ�)
		//g_nSmsFlag = 3 ��ݳ���
		//g_nSmsFlag = 4 ��ݰ��
		if( g_nSmsFlag == 3 )
		{
			JSON_SetValue( g_pjcomm, 'C', "corres_flag",        "C295" );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_ddd",   stFee_History.CP_DDD );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_exn",   stFee_History.CP_EXN );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_num",   stFee_History.CP_NUM );
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
			SQL_ConvUcStr( sztmp, stFee_History.CUST_NM );
			JSON_SetValue( g_pjcomm, 'C', "receiver_nm",        sztmp );  
			
			JSON_SetValue( g_pjcomm, 'C', "sms_desc",        	szSms );  
			JSON_SetValue( g_pjcomm, 'C', "cust_num",        	g_szCUST_NUM );  
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",       g_szUSE_CONT_NUM );  
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "corres_flag",        "C294" );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_ddd",   stFee_Calcul.CP_DDD );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_exn",   stFee_Calcul.CP_EXN );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_num",   stFee_Calcul.CP_NUM );
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
			SQL_ConvUcStr( sztmp, stFee_Calcul.CUST_NM );
			JSON_SetValue( g_pjcomm, 'C', "receiver_nm",        sztmp );  
			
			//JSON_SetValue( g_pjcomm, 'C', "sms_desc",        	m_szSms );  
			JSON_SetValue( g_pjcomm, 'C', "sms_desc",        	szSms );  
			JSON_SetValue( g_pjcomm, 'C', "cust_num",        	g_szCUST_NUM );  
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num",       g_szUSE_CONT_NUM );  
		}
		
		JSON_SetValue( g_pjcomm, 'C', "send_tel_ddd",       szSnd_ddd );
		JSON_SetValue( g_pjcomm, 'C', "send_tel_exn",       szSnd_exn );
		JSON_SetValue( g_pjcomm, 'C', "send_tel_num",       szSnd_num );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        	stUserinfo.szcenter_cd );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR242453; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR242453_IN",  "FR242453" , sndbuf, sztmp );
		return 0 ;
	}

	//-----------------------------------------------------------------------
	long TR242453(void)
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(242453) >= 0)
		{
			//MessageBoxEx(CONFIRM_OK, "��� ���� �۽� �Ϸ�");
			Card_Move("GM_FEEVIEW");
			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return -1;
		}
	}

	//------------------------------------------------------------------------------------------
	long Rcv_Many(void)
	{
		char sztmp[256];
		char szUrl[256];
		char szReqym[10];
		char szDeadlineFlag[10];
		char* sndbuf;
		long ret;

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25010, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        stGm.USE_CONT_NUM     );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25010; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR25010_IN",  "FR25010" , sndbuf, sztmp );
		return 1 ;
	}

	//------------------------------------------------------------------------------------------
	long TR25010(void)
	{
		long lRet = -1;
		
		if( g_Chk_Json(25010) >= 0)
		{
			lRet = GmSms_Sts(25010);

			Rcv_SmsSts();
			
			ON_DRAW();
			return lRet;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return lRet;
		}
	}
	//------------------------------------------------------------------------------------------
	long Rcv_SmsSts(void)
	{
		char sztmp[256];
		char szUrl[256];
		char szReqym[10];
		char szDeadlineFlag[10];
		char* sndbuf;
		long ret;
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szReqym, 0x00, sizeof( szReqym) );
		SPRINT( sztmp, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetStr(sztmp, 10, szReqym);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set((byte*)szDeadlineFlag, 0x00, sizeof(szDeadlineFlag));	
		SPRINT( sztmp, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '1' ", 0, 0, 0 );
		g_Sql_RetStr(sztmp, 10, szDeadlineFlag);

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25008, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "req_ym",              szReqym               );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",       szDeadlineFlag        );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        stGm.USE_CONT_NUM     );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25008; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR25008_IN",  "FR25008" , sndbuf, sztmp );
		return 1 ;
	}

	//------------------------------------------------------------------------------------------
	long TR25008(void)
	{
		long lRet = -1;
		
		if( g_Chk_Json(25008) >= 0)
		{
			lRet = GmSms_Sts(25008);
			ON_DRAW();
			return lRet;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return lRet;
		}
	}

	//------------------------------------------------------------------------------------------
	long GmSms_Sts(long nservicenum)
	{
	char szJsonpath[500];
	char szMsg[500];
	char szCol[128];
	char szTmp[100];
	long *nCol;
	long nCnt = 0;
	long fd, i;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	long lServerDtm = 0 , lReceiveDtm = 0 , lRet = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szitem;
	char *szSmsSts;
	char *szSmsdesc;
	char *szAgreeYn;
	char *szContCd;
	long *nSmsnum;
	char *szSendType;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
		
		//MessageBox(MESSAGE, "�ڷ� Ȯ���� �Դϴ�.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, nservicenum, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, nservicenum, 0 );
		}
		
		fsize = FFS_GetSize(szJsonpath);
		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		pStr = Mem_Alloc(fsize);
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read(fd, (byte*)pStr, fsize);
		for(i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			if(chkmsg > 0 &&  chkcode > 0)
				break;
		}

		FFS_Close(fd);
		
		Mem_Free((byte*)pStr);
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}

		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
			
				MessageBoxEx (WARNING_OK, szJsonpath);
				ON_DRAW();
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "item", szType);
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
							
							if( ret > 0 )
							{
								if( nservicenum == 25008 )
								{
									//���ڰ�ħ�߼��������
									Mem_Set((byte*) stGm.GMTR_SEND_STS, 0x00, sizeof( stGm.GMTR_SEND_STS) );
									szSmsSts = (char*)JSON_GetArrayItem ( hitem, 0, "gmtr_send_sts", szType);
									Str_Cpy(stGm.GMTR_SEND_STS, szSmsSts);
									Str_Chg(stGm.GMTR_SEND_STS, STRCHG_DEL_NONDIGIT);
									
									//stGm.SEND_TYPE
									Mem_Set((byte*) stGm.SEND_TYPE, 0x00, sizeof( stGm.SEND_TYPE) );
									szSendType = (char*)JSON_GetArrayItem ( hitem, 0, "send_type", szType);
									Str_Cpy(stGm.SEND_TYPE, szSendType);
								}
								else if( nservicenum == 25010 )
								{
									//�������� ����
									Mem_Set((byte*) stGm.MULTI_USE_CONT_YN, 0x00, sizeof( stGm.MULTI_USE_CONT_YN) );
									szSmsSts = (char*)JSON_GetArrayItem ( hitem, 0, "multi_use_cont_yn", szType);
									Str_Cpy(stGm.MULTI_USE_CONT_YN, szSmsSts);

									//���ڰ�ħ ���� ����
									Mem_Set((byte*) stGm.SMS_SEND_AGREE_YN, 0x00, sizeof( stGm.SMS_SEND_AGREE_YN) );
									szAgreeYn = (char*)JSON_GetArrayItem ( hitem, 0, "sms_send_agree_yn", szType);
									Str_Cpy(stGm.SMS_SEND_AGREE_YN, szAgreeYn);
									
									//��������
									Mem_Set((byte*) stGm.CONT_STS_CD, 0x00, sizeof( stGm.CONT_STS_CD) );
									szContCd = (char*)JSON_GetArrayItem ( hitem, 0, "cont_sts_cd", szType);
									Str_Cpy(stGm.CONT_STS_CD, szContCd);
								}
							}
							
							JSON_Finalize(hitem);
							hitem = NULL;
							
							if( nservicenum == 25010 )
							{
								goto Finally2;
							}
						}
					}
				}
			}
		}
		else
		{
			ret = 1;
		}
		
Finally:		
		
		// = 0 ���ڰ�ħ ��� ���� ǥ�� , = 1 ���ڴ�� -> ���� ����(�������) ��� �� ���� , 
		// = 2 ��ħ���(����) �� ����, = 3 ���ڴ�� ��Ͻ� ����
/*
		if( nservicenum == 25008 && Str_Cmp(stGm.SMS_SEND_AGREE_YN, "Y") == 0 && m_lSmsAgreeFlag == 0 )
		{
			if( Str_Cmp(stGm.CONT_STS_CD, "Y") == 0 )
			{
				m_lSmsAgreeFlag = 1;
				Rcv_Many();
				ret = 1;
			}
			else
			{
				m_lSmsAgreeFlag = 0;
				MessageBoxEx (CONFIRM_OK, "�������°� ������ �ƴմϴ�.");
				ret = 0;
			}
			goto Finally2;
		}
		else
*/
		if( nservicenum == 25008 )
		{
//PRINT("stGm.MULTI_USE_CONT_YN : %s , stGm.SMS_SEND_AGREE_YN : %s , stGm.CONT_STS_CD : %s",stGm.MULTI_USE_CONT_YN,stGm.SMS_SEND_AGREE_YN,stGm.CONT_STS_CD);
			if( Str_Cmp(stGm.GMTR_SEND_STS, "10") == 0 || Str_Cmp(stGm.GMTR_SEND_STS, "50") == 0 )
			{
				if( Str_Cmp(stGm.MULTI_USE_CONT_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "��� ���� �� �ܵ���� ���뿴���� �� �������� ������� ���밡 �Ǿ����ϴ�. \n������� ����� ���ڰ�ħ�� �� �� �����ϴ�.");
				}
				else if( Str_Cmp(stGm.SMS_SEND_AGREE_YN, "N") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "���ڰ�ħ ���� ���밡 �ƴմϴ�.");
				}
				else if( Str_Cmp(stGm.CONT_STS_CD, "N") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�������°� ������ �ƴմϴ�.");
				}
				else
				{
					//���ڹ߼�
					Snd_Sms_Gm();
				}
			}
			else if( Str_Cmp(stGm.GMTR_SEND_STS, "90") == 0 || Str_Cmp(stGm.GMTR_SEND_STS, "") == 0 || 
			         Str_Cmp(stGm.GMTR_SEND_STS, "null") == 0 || Str_Cmp(stGm.GMTR_SEND_STS, "NULL") == 0 )
			{
				if( Str_Cmp(stGm.MULTI_USE_CONT_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�ش� ����� ������� ���� �Դϴ�. \n������� ����� ���ڰ�ħ�� �� �� �����ϴ�.");
				}
				else if( Str_Cmp(stGm.SMS_SEND_AGREE_YN, "N") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "���ڰ�ħ ���� ���밡 �ƴմϴ�.");
				}
				else if( Str_Cmp(stGm.CONT_STS_CD, "N") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�������°� ������ �ƴմϴ�.");
				}
				else
				{
					//���ڴ�� ��� �� ���ڹ߼�
					Snd_Sms_New();
				}
			}
			else
			{
				if( Str_Cmp(stGm.SEND_TYPE, "30") == 0 )
				{
					Snd_Sms_New();
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "����� ���¸� Ȯ�����ּ���.");
					ret = 0;
					goto Finally2;
				}
			}
		}
		
Finally2:

		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}

		g_Close_SubDlg();
		EvtDraw();
		
		return ret;
	}

}



