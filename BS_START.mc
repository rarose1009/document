/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card BS_START
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Calendar.h"
	
	#define USE_ON_EXIT
	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#define USE_ON_UART
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_ADDR )		//�����ּ�
		DEF_BUTTON_ID ( BID_BSBD )		//Ư���ü� ����
		DEF_BUTTON_ID ( BID_GR )		//�跮�� ����
		DEF_BUTTON_ID ( BID_BSINFO )	//Ư������ Ȯ��
		DEF_BUTTON_ID ( BID_REFORM )	//�����ǰ� ����
		DEF_BUTTON_ID ( BID_SCHDL )		//����˻���
		DEF_BUTTON_ID ( BID_IMPOSSIBLE )		//����˻���
		
		DEF_BUTTON_ID ( BID_BARCODE )	//���ڵ�
		DEF_BUTTON_ID ( BID_PHOTO )		//����
		DEF_BUTTON_ID ( BID_SAVE )		//����
		
//����������
		DEF_BUTTON_ID ( BID_CAMERA1 )
		DEF_BUTTON_ID ( BID_CHECK5 )
//��ȸ�ڰ���
		DEF_BUTTON_ID ( BID_SIGN )
		DEF_BUTTON_ID ( BID_CANCEL )
//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
		
//�޸�
		DEF_BUTTON_ID ( BID_MEMO )		//�޸�
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_MANAGER )		//������
		DEF_OBJECT_ID ( TXT_CLIENT )		//��ǥ��(��)
		DEF_OBJECT_ID ( TXT_BSBD )			//Ư���ü�
		DEF_OBJECT_ID ( TXT_GR )			//�跮������
		DEF_OBJECT_ID ( TXT_BSINFO )		//Ư������
		DEF_OBJECT_ID ( TXT_REFORM )		//�����ǰ�
		DEF_OBJECT_ID ( TXT_TERMBSDT )		//����˻���
		DEF_OBJECT_ID ( TXT_BEFOSDT )		//����˻���
		DEF_OBJECT_ID ( TXT_BARCODE )		//���ڵ����
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		DEF_OBJECT_ID ( TXT_DATA7 )
		DEF_OBJECT_ID ( TXT_DATA8 )
		DEF_OBJECT_ID ( TXT_DATA9 )
		DEF_OBJECT_ID ( TXT_DATA74 )
		DEF_OBJECT_ID ( TXT_DATA75 )
		DEF_OBJECT_ID ( TXT_DATA76 )
		DEF_OBJECT_ID ( TXT_DATA77 )
		DEF_OBJECT_ID ( TXT_DATA78 )
		DEF_OBJECT_ID ( TXT_DATA79 )
//����������
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
		DEF_OBJECT_ID ( TXT_DATA32 )
		DEF_OBJECT_ID ( TXT_DATA33 )
		DEF_OBJECT_ID ( TXT_DATA34 )
		DEF_OBJECT_ID ( TXT_DATA35 )
		DEF_OBJECT_ID ( TXT_DATA36 )
		DEF_OBJECT_ID ( TXT_DATA37 )
//�������
		DEF_OBJECT_ID ( TXT_DATA38 )
		DEF_OBJECT_ID ( TXT_DATA39 )
//���б�/������ ��������
		DEF_OBJECT_ID ( TXT_DATA40 )
		DEF_OBJECT_ID ( TXT_DATA41 )
		DEF_OBJECT_ID ( TXT_DATA42 )
		DEF_OBJECT_ID ( TXT_DATA43 )
//�Ÿ��������
		DEF_OBJECT_ID ( TXT_DATA44 )
		DEF_OBJECT_ID ( TXT_DATA45 )
		DEF_OBJECT_ID ( TXT_DATA46 )
		DEF_OBJECT_ID ( TXT_DATA47 )
		DEF_OBJECT_ID ( TXT_DATA48 )
		DEF_OBJECT_ID ( TXT_DATA49 )
		DEF_OBJECT_ID ( TXT_DATA50 )
		DEF_OBJECT_ID ( TXT_DATA51 )
		DEF_OBJECT_ID ( TXT_DATA52 )
		DEF_OBJECT_ID ( TXT_DATA53 )
		DEF_OBJECT_ID ( TXT_DATA54 )
		DEF_OBJECT_ID ( TXT_DATA55 )
//����������
		DEF_OBJECT_ID ( TXT_DATA56 )
		DEF_OBJECT_ID ( TXT_DATA57 )
		DEF_OBJECT_ID ( TXT_DATA58 )
		DEF_OBJECT_ID ( TXT_DATA59 )
		DEF_OBJECT_ID ( TXT_DATA60 )
		DEF_OBJECT_ID ( TXT_DATA61 )
		DEF_OBJECT_ID ( TXT_DATA62 )
		DEF_OBJECT_ID ( TXT_DATA63 )
		DEF_OBJECT_ID ( TXT_DATA64 )
		DEF_OBJECT_ID ( TXT_DATA65 )
		DEF_OBJECT_ID ( TXT_DATA66 )
		DEF_OBJECT_ID ( TXT_DATA67 )
		DEF_OBJECT_ID ( TXT_DATA68 )
		DEF_OBJECT_ID ( TXT_DATA69 )
		DEF_OBJECT_ID ( TXT_DATA70 )
		DEF_OBJECT_ID ( TXT_DATA71 )
		DEF_OBJECT_ID ( TXT_DATA72 )
		DEF_OBJECT_ID ( TXT_DATA73 )
		
		DEF_OBJECT_ID ( TTL_TIME_FROM )
		DEF_OBJECT_ID ( TXT_TIME_FROM )
		DEF_OBJECT_ID ( TTL_TIME_TO )
		DEF_OBJECT_ID ( TXT_TIME_TO )
		DEF_OBJECT_ID ( TTL_TIME_LEFT )
		DEF_OBJECT_ID ( TXT_TIME_LEFT )
		
		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
				
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( LINE_DATA1 )		//����1
		DEF_OBJECT_ID ( LINE_DATA2 )		//����2
		
		DEF_OBJECT_ID ( CMB_BARCODE ) 		//���ڵ���� �޺��ڽ�
//��ȸ�ڰ���
		DEF_OBJECT_ID ( CMB_DATA1 = CMB_BARCODE+3)

	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	#define INIT_RLTCHK 2
	#define SET_TIME 300
	
	long m_bFirst;
	long m_lTimeFlag = 0;
	long m_lEditCtrlIndex = -1;
	long m_nCheck = 0;
	long m_bImpossible = 0;
	char m_szfilenm[256];
	char m_szBarSql[300];
	char m_szBarcode_Value[20];	//���ڵ� ��ĵ ���

	void SetStyle(void);
	void SetBtnImg(void);
	void REDRAW(void);
	void BDCHK_DRAW(void);
	void Barcode(void);
	void OnBarcodeRead(void);
	void PDA_OnBarcodeRead(void);
	bool Save_Result(void);
	bool Validate(void);
	bool Check(void);
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);	//�ڵ� ���� ã�´�.
	bool New_Nogood(void);
	bool Save_Issue(void);
	void Shoto_Photo(void);
	long m_lActiveIndex = -1;
	void Set_Index(void);
	void SetComboIdx(void);
		
	//Ÿ�̸�
	void SetStatus(char* pText);
	void Start_Timer(void);
	void Stop_Timer(void);
	long m_nTimerCnt = 1000;
	long m_nTimerId = -1;
	char m_szBuf[32];
	
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
		NORM_DLG("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(  0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(  TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ����"),
		
		DLG_TEXT(  STARTX,      STARTY  +65, 200,  60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MANAGER, "������"),
		DLG_TEXT(  STARTX +200, STARTY  +65, 500,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		
		DLG_TEXT(  STARTX +500, STARTY +65, 700,  60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLIENT, "��ǥ��"),
		DLG_TEXT(  STARTX +700, STARTY +65, 1000,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		
		DLG_BUTTON(STARTX,      STARTY +125, 300, 120, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_TEXT(  STARTX +300, STARTY +125, 700, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		
		DLG_LINE ( STARTX,      STARTY +244, 1000, STARTY+244, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT(  STARTX,      STARTY +249, 300,  60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSBD, "Ư���ü�"),
		DLG_TEXT(  STARTX +300, STARTY +249, 475,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_BUTTON(STARTX +775, STARTY +249, 225,  60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BSBD, "����"),
		
		DLG_TEXT(  STARTX,      STARTY +309, 300,  60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GR, "�跮������"),
		DLG_TEXT(  STARTX +300, STARTY +309, 475,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_BUTTON(STARTX +775, STARTY +309, 225,  60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GR, "����"),
		
		DLG_TEXT(  STARTX,      STARTY +369, 300,  60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSINFO, "Ư������"),
		DLG_TEXT(  STARTX +300, STARTY +369, 475,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_BUTTON(STARTX +775, STARTY +369, 225,  60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BSINFO, "Ȯ��"),
		
		DLG_TEXT(  STARTX,      STARTY +429, 300,  60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORM, "�����ǰ�"),
		DLG_TEXT(  STARTX +300, STARTY +429, 475,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_BUTTON(STARTX +775, STARTY +429, 225,  60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "����"),

		DLG_TEXT(  STARTX,      STARTY +489, 300,  60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TERMBSDT, "����˻���"),
		DLG_EDIT(  STARTX +300, STARTY +489, 165,  60, 0, 0,    EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(  STARTX +465, STARTY +489,  20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA75, ""),
		DLG_TEXT(  STARTX +465, STARTY +519,  20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA76, "."),
		DLG_EDIT(  STARTX +485, STARTY +489, 135,  60, 0, 0,    EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(  STARTX +620, STARTY +489,  20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA77, ""),
		DLG_TEXT(  STARTX +620, STARTY +519,  20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA78, "."),
		DLG_EDIT(  STARTX +640, STARTY +489, 135,  60, 0, 0,    EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX +775, STARTY +489, 225,  60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "��"),
		
		DLG_TEXT(  STARTX,      STARTY +549, 300,  65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BEFOSDT, "�����˻���"),
		DLG_TEXT(  STARTX +300, STARTY +549, 475,  65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA79, ""),
		DLG_BUTTON(STARTX +775, STARTY +549, 225,  65, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_IMPOSSIBLE, "����˻�Ȯ�κҰ�"),
		// DLG_BUTTON(STARTX +775, STARTY +429, 225,  60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "����"),

		
		
		DLG_BUTTON(STARTX,      STARTY +614, 300,  60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "���ڵ�"),
		DLG_TEXT(  STARTX +300, STARTY +614, 475,  60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA74, ""),
		DLG_BUTTON(STARTX +775, STARTY +614, 225,  60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "����"),
		
		DLG_TEXT(  STARTX,      STARTY +674, 300,  60, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BARCODE, "���ڵ����"),
		DLG_COMBO( STARTX +300, STARTY +674, 700, 150, 225, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BARCODE, 10),
		
		DLG_LINE ( STARTX,      STARTY +733, 1000, STARTY+738, DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_BUTTON(STARTX + 20, STARTY +748, 730, 135, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "�� ��"),
		DLG_BUTTON(STARTX +775, STARTY +748, 205, 135, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "�޸�"),	
	};
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,     STARTY+100, 200, 120, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_BUTTON(STARTX+825, STARTY+220, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BSBD, "����"),	
		DLG_BUTTON(STARTX+825, STARTY+290, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GR, "����"),
		DLG_BUTTON(STARTX+825, STARTY+360, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BSINFO, "Ȯ��"),
		DLG_BUTTON(STARTX+825, STARTY+430, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REFORM, "����"),
		DLG_BUTTON(STARTX,     STARTY+570, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "���ڵ�"),	
		DLG_BUTTON(STARTX+200, STARTY+760, 600, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "�� ��"),
		
		DLG_TEXT(STARTX,      STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_MANAGER, "������"),
		DLG_TEXT(STARTX+300,  STARTY-40, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		DLG_TEXT(STARTX,      STARTY+30, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLIENT, "��ǥ��"),
		DLG_TEXT(STARTX+300,  STARTY+30, 700, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX+200, STARTY+100, 800, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""),
		//DLG_TEXT(STARTX+200, STARTY+180, 775, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,     STARTY+220, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSBD, "Ư���ü�"),
		DLG_TEXT(STARTX+300, STARTY+220, 525, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,     STARTY+290, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GR, "�跮������"),
		DLG_TEXT(STARTX+300, STARTY+290, 525, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,     STARTY+360, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BSINFO, "Ư������"),
		DLG_TEXT(STARTX+300, STARTY+360, 525, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_TEXT(STARTX,     STARTY+430, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORM, "�����ǰ�"),
		DLG_TEXT(STARTX+300, STARTY+430, 525, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),

		DLG_TEXT(STARTX,       STARTY+500, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TERMBSDT, "����˻���"),
		DLG_EDIT(STARTX+300,   STARTY+500, 185, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_TEXT(STARTX+485,   STARTY+500,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA75, ""),
		DLG_TEXT(STARTX+485,   STARTY+540,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA76, "."),
		DLG_EDIT(STARTX+505,   STARTY+500, 150, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 2,  ""),
		DLG_TEXT(STARTX+655,   STARTY+500,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA77, ""),
		DLG_TEXT(STARTX+655,   STARTY+540,  20, 30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA78, "."),
		DLG_EDIT(STARTX+675,   STARTY+500, 150, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_BUTTON(STARTX+825, STARTY+500, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_SCHDL, "��"),
		//DLG_TEXT(STARTX+300, STARTY+480, 525, 60, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""), 
		//DLG_BUTTON(STARTX+825, STARTY+480, 150, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SCHDL, "��"),	
		
		DLG_TEXT(STARTX+300,	STARTY+570, 525, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA74, ""),    //���ڵ�
		DLG_BUTTON(STARTX+825,	STARTY+570, 175, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "����"),
		DLG_TEXT(STARTX,		STARTY+640, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BARCODE, "���ڵ����"),
		
		DLG_COMBO (STARTX+300, STARTY+640, 700, 270, 175, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BARCODE, 10),
	};		
	
	// ��ȸ�ڰ���
	//---------------------------------------------------------------
	DlgObject	DlgRes_RLTCHK[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ȸ�� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),
		
		DLG_TEXT(STARTX,	  STARTY+51, 450, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TTL_TIME_FROM, "���˽��۽ð�"),
		DLG_TEXT(STARTX+450,  STARTY+51, 550, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TIME_FROM, ""),
		DLG_TEXT(STARTX,	 STARTY+131, 450, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TTL_TIME_TO, "����ð�"),
		DLG_TEXT(STARTX+450, STARTY+131, 550, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TIME_TO, ""),	
		DLG_TEXT(STARTX,	 STARTY+211, 450, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TTL_TIME_LEFT, "�����ð�"),
		DLG_TEXT(STARTX+450, STARTY+211, 550, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TIME_LEFT, ""),
		
		DLG_BUTTON( STARTX,		STARTY+350, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "�� ��"),			
		DLG_BUTTON( STARTX+600, STARTY+350, 400, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN,  "�� ��"),	
		
		DLG_COMBO (STARTX,		STARTY-29, 1000, 200, 200, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),
	};

	// ��ȸ�ڰ���
	//---------------------------------------------------------------
	DlgObject	DlgRes_RLTCHK_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ȸ�� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),
		
		DLG_BUTTON( STARTX,		STARTY+100, 400, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "�� ��"),			
		DLG_BUTTON( STARTX+600, STARTY+100, 400, 85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN,  "�� ��"),	
		
		DLG_COMBO (STARTX,   STARTY-40, 1000, 200, 200, 100, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),
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
		char szSql[300];
		char sztmp[20];

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
				
				g_nAddrFlag = 0;
				SetBtnImg();
				if(g_lSCMoveFlag == 1)
				{
					g_lSCMoveFlag = 0;
					ON_DRAW();
					Card_Move("BS_SPCLBDCHK");
					return;
				}
				
				SetStyle();
				REDRAW();
				break;
				
			case INIT_RLTCHK:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:	
						CREATE_DIALOG_OBJECT (DlgRes_RLTCHK_P, SIZEOF(DlgRes_RLTCHK_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_RLTCHK, SIZEOF(DlgRes_RLTCHK));
						
						SetStyle();
						
						// ���� ���۽ð�
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						g_Str_TimeForm( sztmp, stBs.CHK_TIME_FROM );
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TIME_FROM), sztmp );
						
						// ����ð� ����
						Mem_Set( (byte*)stBs.CHK_TIME_TO, 0x00, sizeof(stBs.CHK_TIME_TO) );
						g_Str_TimeType( stBs.CHK_TIME_TO, Time_GetTime() );
						
						// ���� �ð�
						g_Str_TimeForm( sztmp, stBs.CHK_TIME_TO );
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TIME_TO), sztmp );
						
						Start_Timer();
						break;		
				}
								
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
		long i, n;
		char sztmp[200];
		
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MANAGER), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CLIENT), EDITALIGN_LEFT|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSBD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BSINFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFORM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TERMBSDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BARCODE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BEFOSDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA74), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA3), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BARCODE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			//���ڵ�Ұ�����
			for ( i = 0 ;  CHKBAR_WHY[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BARCODE+2), CHKBAR_WHY[i].Str, 0, ICON_NONE);
			}
		}
		else if( m_bFirst == INIT_RLTCHK )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TIME_FROM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TIME_FROM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TIME_TO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TIME_TO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TIME_LEFT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TIME_LEFT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			//�������
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DATA1+2 ) );
			for ( i = 0 ;  SIGN_RLT[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), SIGN_RLT[i].Str, 0, ICON_NONE);
			}
			
			n = SearchCD( stBs.SIGN_RELAT, SIGN_RLT );
			if(n == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), SIGN_RLT[0].Str);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), SIGN_RLT[n].Str);
			}
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[300];
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		long i, d,k;
		long lCount;
		long nfromtime = 0;
		long ntotime = 0;
		char sztmp[200];
		
		switch(ID)
		{					
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
			case BID_BSBD:
				g_lRfrmFlag = 0;
				Card_Move("BS_SPCLBDCHK");
				break;
			case BID_GR:
				g_lRfrmFlag = 0;
				g_nObjIndex = 0;
				if( Str_Cmp(stUserinfo.szcenter_cd,"91") == 0 
				|| Str_Cmp(stUserinfo.szcenter_cd,"92") == 0 
				|| Str_Cmp(stUserinfo.szcenter_cd,"93") == 0 
				|| Str_Cmp(stUserinfo.szcenter_cd,"94") == 0 
				|| Str_Cmp(stUserinfo.szcenter_cd,"95") == 0 )
				{
					Card_Move("BS_MTRLST_2");
				}
				else
				{
					Card_Move("BS_MTRLST");
				}
				
				break;
			case BID_BSINFO:
				g_lConfrimFlag = 1;
				Card_Move("BS_INFO");
				break;
			case BID_REFORM:
				if( Check() )
				{
					g_lRfrmFlag = 1;
					Card_Move("BS_RFRMISSU");
				}
				break;
			case BID_SCHDL:
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
					Str_ItoA(d, stBs.PERIOD_CHK_YMD, 10);
					
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)stBs.PERIOD_CHK_YMD, 4);
					Mem_Cpy((byte *)szMonth, (byte *)stBs.PERIOD_CHK_YMD+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)stBs.PERIOD_CHK_YMD+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );

					Str_Cpy(stBs.IMPOSSIBLE_YN,"N");
					
					//Str_Cpy(stBs.PERIOD_CHK_YMD, szDate);
					//g_Str_DateType(szDate, szDate);
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), szDate );
				}
				break;
			case BID_BARCODE:
				Barcode();
				break;
			case BID_PHOTO:
				Shoto_Photo();
				break;
			case BID_SAVE:
				if( !Validate() )
					break;
				
				//���ڵ� �νĺҰ�����
				i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE)), CHKBAR_WHY );
				if (i == -1)
				{
					Str_Cpy(stBs.BAR_WHY, "");
				}
				else
				{
					Str_Cpy(stBs.BAR_WHY, CHKBAR_WHY[i].Code);
				}
				
				ON_EXIT();
				OnInit(INIT_RLTCHK);
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
				if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
				{
					g_Del_BsData();
				}
				g_lConfrimFlag = 0;
				g_lRfrmFlag = 0;
				Card_Move("BS_CONFIRM");
				break;	
			case GID_VMEXIT:
				if( Str_Cmp(stBs.SEND_YN, "N") == 0 || Str_Cmp(stBs.SEND_YN, "") == 0)
				{
					g_Exit_DelBsData();
					return;
				}
				g_Exit();
				return;
//��ȸ�� ����
			case BID_SIGN:	
			
				// ���� ���� �� ���� �ð� �ٽ� ������
				g_Str_TimeType( stBs.CHK_TIME_TO , Time_GetTime());
				
				/*********************************************************/
				/* ���� �ð� üũ ����                                   */
				/*********************************************************/
				if( Str_Cmp(stBs.SEND_YN, "S") != 0 && Str_Cmp(stBs.SEND_YN, "Y") != 0 && Str_Cmp(stBs.CHK_TYPE, "30") != 0)
				{
					/* 20181101 �ð� �߰�, 3�� */
					// ���� �ð� ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Cpy((byte*)sztmp, (byte*)stBs.CHK_TIME_FROM, 2);
					nfromtime = 60*60*Str_AtoI(sztmp);
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Cpy((byte*)sztmp, (byte*)stBs.CHK_TIME_FROM+2, 2);
					nfromtime += 60*Str_AtoI(sztmp);
					Mem_Cpy((byte*)sztmp, (byte*)stBs.CHK_TIME_FROM+4, 2);
					nfromtime += Str_AtoI(sztmp);
					
					// ���� �ð� ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Cpy((byte*)sztmp, (byte*)stBs.CHK_TIME_TO, 2);
					ntotime = 60*60*Str_AtoI(sztmp);
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Mem_Cpy((byte*)sztmp, (byte*)stBs.CHK_TIME_TO+2, 2);
					ntotime += 60*Str_AtoI(sztmp);
					Mem_Cpy((byte*)sztmp, (byte*)stBs.CHK_TIME_TO+4, 2);
					ntotime += Str_AtoI(sztmp);
					
					if( ntotime - nfromtime < SET_TIME )
					{
						Timer_Kill( m_nTimerId );
						m_nTimerId = -1;
						SetStatus("");
						
						MessageBoxEx (CONFIRM_OK, "���˱��ؽð� �������� \n���� �Ϸ� ó���� ���� �ʽ��ϴ�.\n( ���˱��ؽð� : 5�� )");
						
						Mem_Set( (byte*)stBs.CHK_TIME_TO, 0x00, sizeof(stBs.CHK_TIME_TO) );
						g_Str_TimeType( stBs.CHK_TIME_TO, Time_GetTime()  );
						Start_Timer();
						
						break;
					}
				}
				
				/*********************************************************/
				/* ������ ����                                           */
				/*********************************************************/
				lCount = 0;
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL)"
								, g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetInt(szSql, &lCount);				
				if( lCount > 0)
				{
					if( !New_Nogood() )
						break;
					//�����ǰ� ��������
					if( !Save_Issue() )
						break;
				}
				// else
				// {
				// 	PRINT("222222222",0,0,0);
				// 	PRINT("222222222 : %s",g_szCHK_EXEC_NUM,0,0);
				// 	Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				// 	SPRINT(sztmp, "DELETE FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
				// 	g_Sql_DirectExecute(sztmp);

				// 	PRINT("sztmp : %s",sztmp,0,0);

				// }
				// PRINT("3333333333",0,0,0);
				
				//���ڵ带 �Է� ���߰ų�, �������׸��� �����ϸ� ���� �ʼ�!
				if( Str_Len(stBs.BAR_WHY) > 0 || lCount > 0 )
				{
					m_nCheck = 0;
				}
				else
				{
					m_nCheck = 1;
				}
				
				if( Save_Result() )
				{
					g_nBackFlag++;
					
					if( g_nBackFlag > 4)
					{
						g_Db_Backup();
						g_nBackFlag = 0;
					}
					
					g_lConfrimFlag = 0;
					 
					lCount = 0;
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, " SELECT COUNT(1) FROM SPECIAL_NOGOOD WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
					g_Sql_RetInt(szSql, &lCount);
					/*
					if( Str_Cmp(stBs.PREUSE_CHK_WHY, "10" ) == 0 && lCount > 0)
					{
						Card_Move("BS_RFRMPRGRS");
					}
					else
					{
						Card_Move("BS_BDLST");
					}
					*/
					Card_Move("BS_BDLST");
				}
				
				break;
			case BID_CANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			case BID_MEMO:
				if( g_nWorkFlag == 301 || g_nWorkFlag == 302 || g_nWorkFlag == 303 || g_nWorkFlag == 306  )
				{
					SetComboIdx();
				}
				else
				{
					Set_Index();
				}
				g_nMemoFlag = 4;
				Card_Move("CM_MEMO");
				break;

			case BID_IMPOSSIBLE:

				if( m_bImpossible == 0 )
				{
					Str_Cpy(stBs.PERIOD_CHK_YMD, "1111");
					Str_Cpy(stBs.PERIOD_CHK_YMD+4, "11");
					Str_Cpy(stBs.PERIOD_CHK_YMD+6, "11");

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE );

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
					

					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), "1111" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), "11" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), "11" );

					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_IMPOSSIBLE), RED);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_IMPOSSIBLE), BTNMENUFRCOLOR);

					Str_Cpy(stBs.IMPOSSIBLE_YN,"Y");

					m_bImpossible = 1;
				}
				else if(m_bImpossible == 1)
				{
					Str_Cpy(stBs.PERIOD_CHK_YMD, "");

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), FALSE );

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );

					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), "" );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), "" );
					
					// EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_IMPOSSIBLE), GREEN);

					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_IMPOSSIBLE), GREEN);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_IMPOSSIBLE), BTNMENUFRCOLOR);

					m_bImpossible = 0;
				}
			    

				
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
			else
			{
				Str_Cpy(stBs.PERIOD_CHK_YMD, szTmp);
			}
		}

		ON_DRAW();
		return;
	}

	//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long m_lActiveIndex = -1;

		//EDITCTRL�� ACTIVE�ÿ� CTRLINDEX�� ����
		//Ű���� BUTTONCTRL�� ACTIVE�ÿ��� EDITCTRL�� Ŀ���� �α����ؼ� INDEX�� ����
		m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( INIT_MAIN == m_bFirst )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = m_lActiveIndex;

				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+465) && Y > DMS_Y(STARTY+600-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+660-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
	
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+485) && X < DMS_X(STARTX+620) && Y > DMS_Y(STARTY+600-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+660-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
	
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+640) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+600-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+660-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
	
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
	
					ON_DRAW();
				}
			}
		}

		return;
	}



//-----------------------------------------------------------------------------------------
	void	OnSelect(long Index)
	{
		long i;
		char sztmp[20];
		char szSql[100];
	
		if( INIT_MAIN == m_bFirst )
		{	
			//���ڵ� �νĺҰ�����CMB_BARCODE
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE)), CHKBAR_WHY );
			if (i == -1)
			{
				Str_Cpy(stBs.BAR_WHY, "");
			}
			else
			{
				Str_Cpy(stBs.BAR_WHY, CHKBAR_WHY[i].Code);
			}
		}
		else if( INIT_RLTCHK == m_bFirst )
		{
			//���� �����ڵ�
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), SIGN_RLT );
			if (i == -1)
			{
				Str_Cpy(stBs.SIGN_RELAT, "");
			}
			else
			{
				Str_Cpy(stBs.SIGN_RELAT, SIGN_RLT[i].Code);
			}
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
	void REDRAW(void)
	{
		char szDate[15];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szImpYear[5];
		char szImpMonth[3];
		char szImpDay[3];
		char szName[20];
		char szAddr[256];
		char szfilenm[256];
		char szBefoYmd[256];
		long i;
		
		
		Mem_Set((byte*)szName, 0x00, sizeof(szName));
		
		//������
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), stBs.SAFE_MANAGER_NM);
		//��ǥ��
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), stBs.REPRE_NM);
		
		Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
		if( g_nAddrFlag == 0)
		{
			if(Str_Len(stBs.COUNTY) == 0)		//�ñ���
			{
				Str_Cpy(szAddr,  "" );
			}
			else
			{
				Str_Cpy(szAddr,  stBs.COUNTY );
			}
			if(Str_Len(stBs.TOWN) == 0)			//���鵿
			{
				Str_Cat(szAddr,  " " );
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stBs.TOWN );
			}
			if(Str_Len(stBs.ADDR1_M) == 0)		//����
			{
				Str_Cat(szAddr,  "" );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stBs.ADDR1_M);
			}			
			if(Str_Len(stBs.ADDR1_S) == 0)		//�ι�
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stBs.ADDR1_S);
			}
			
			//�����ּ�
			Str_Cat(szAddr,  " " );
			Str_Cat(szAddr,  stBs.SECOND_ADDR);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), szAddr);
		}
		else
		{
			if(Str_Len(stBs.COUNTY) == 0)		//�ñ���
			{
				Str_Cpy(szAddr,  "" );
			}
			else
			{
				Str_Cpy(szAddr,  stBs.COUNTY );
			}
			if(Str_Len(stBs.NEW_ROAD_NM) == 0)
			{
				Str_Cat(szAddr,  "" );
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stBs.NEW_ROAD_NM );
			}
			if(Str_Len(stBs.NEW_ADDR_M) == 0)
			{
				Str_Cat(szAddr,  "" );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stBs.NEW_ADDR_M);
			}
			if(Str_Len(stBs.NEW_ADDR_S) == 0)
			{
				Str_Cat(szAddr,  "" );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stBs.NEW_ADDR_S);
			}
			
			//�����ּ�
			Str_Cat(szAddr,  " " );
			Str_Cat(szAddr,  stBs.SECOND_ADDR);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), szAddr);
		}
		//�����ּ�
		//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), stBs.SECOND_ADDR);
		
		//Ư���ü�����
		if( Str_Cmp( stBs.SPECIAL_RSLT, "Y") == 0 )
		{
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), "����");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA5), TXTFRCOLOR);
		}
		else if( Str_Cmp( stBs.SPECIAL_RSLT, "N") == 0 )
		{
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), "������");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA5), RED);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), "������");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA5), TXTFRCOLOR);
		}
		
		//�跮��
		if( Str_Cmp( stBs.MRT_RSLT, "Y") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "����");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA6), TXTFRCOLOR);
		}
		else if( Str_Cmp( stBs.MRT_RSLT, "N") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "������");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA6), RED);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "������");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA6), TXTFRCOLOR);
		}
		//Ư������
		if( Str_Cmp(stBs.INFO_YN, "Y") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), "Ȯ��");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), "��Ȯ��");
		}
			
		//�����ǰ�
		if( Str_Cmp(stBs.SEND_YN, "S") == 0 || Str_Cmp(stBs.SEND_YN, "Y") == 0 )
		{
			Str_Cpy( stBs.NOGOOD_RSLT, "N" );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "�����ǰ����");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8), RED);
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), FALSE );
			
			g_lRfrmFlag = 1;
		}
		else if( (Str_Cmp(stBs.SPECIAL_RSLT, "N") == 0 || Str_Cmp(stBs.MRT_RSLT, "N") == 0) && g_lRfrmFlag == 0 )
		{
			Str_Cpy( stBs.NOGOOD_RSLT, "N" );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "�����ǰ����ٶ�");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8), RED);
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), FALSE );
		}
		else if( (Str_Cmp(stBs.SPECIAL_RSLT, "N") == 0 || Str_Cmp(stBs.MRT_RSLT, "N") == 0) && g_lRfrmFlag == 1 )
		{
			Str_Cpy( stBs.NOGOOD_RSLT, "N" );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "�����ǰ����");
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA8), RED);
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), FALSE );
		}
		else
		{
			Str_Cpy( stBs.NOGOOD_RSLT, "Y" );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "");
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), TRUE );
			g_lRfrmFlag = 1;
		}
		
		//����˻���
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		
		
		Mem_Cpy((byte *)szYear, (byte *)stBs.PERIOD_CHK_YMD, 4);
		Mem_Cpy((byte *)szMonth, (byte *)stBs.PERIOD_CHK_YMD+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)stBs.PERIOD_CHK_YMD+6, 2);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA1), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szDay );	
		//Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		//g_Str_DateType(szDate, stBs.PERIOD_CHK_YMD);
		//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), szDate);

		if(Str_Cmp(stBs.IMPOSSIBLE_YN, "Y") == 0)
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_IMPOSSIBLE), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_IMPOSSIBLE), BTNMENUFRCOLOR);

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SCHDL), TRUE );

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE );

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE );

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE );

			m_bImpossible = 1 ;
		}
		
		//���ڵ� �Ұ�����
		i = SearchCD( stBs.BAR_WHY, CHKBAR_WHY );
		if( i == -1 )
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), CHKBAR_WHY[1].Str);
		else
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), CHKBAR_WHY[i].Str);
			
		//���ڵ�
		//2017-09-19 Sanghyun Lee
		//���ڵ� ��ĵ �� �ٷ� ����DB�� ������Ʈ �ǵ��� ����

		if( Str_Len(stBs.CURR_BAR) > 15 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA74), stBs.CURR_BAR ) ;
			//EditCtrl_ModifyStyle( Get_hDlgCtrlByID(TXT_DATA74), 0, EDITSTY_HIDDEN);
			
			Str_Cpy(stBs.BAR_WHY, "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), "");
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), TRUE );
		}
		
		//����
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		Str_Cpy(szfilenm, g_szCHK_EXEC_NUM);
		Str_Cat(szfilenm, "_");
		Str_Cat(szfilenm, stBs.SPECIAL_NUM);
		Str_Cat(szfilenm, ".jjp");

		Mem_Set((byte*)szAddr, 0x00, sizeof(szAddr));
		SPRINT (szAddr, "%s/%s",PHOTO_BSBAR, szfilenm, 0);

		if(FFS_Exist(szAddr) > 0 || Str_Cmp( stBs.TEMP_INST_BAR_PHOTO_YN, "Y" ) == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
		}
		else
		{
			if(Str_Cmp(stBs.INST_BAR_PHOTO_YN, "Y") == 0)
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
			}
			else
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), YELLOW);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), TXTFRCOLOR);
			}
		}
		
		//�޸� ��ư
		if( Str_Len(stBs.BEFO_HALF_MEMO) > 0 )
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), RED);
		}
		else
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNMENUFRCOLOR);
		}

		if( Str_Len(stBs.BEFO_PERIOD_YMD) > 0)
		{
			Mem_Cpy((byte *)szImpYear, (byte *)stBs.BEFO_PERIOD_YMD, 4);
			Mem_Cpy((byte *)szImpMonth, (byte *)stBs.BEFO_PERIOD_YMD+4, 2);
			Mem_Cpy((byte *)szImpDay, (byte *)stBs.BEFO_PERIOD_YMD+6, 2);

			Str_Cat(szBefoYmd, szImpYear);
			Str_Cat(szBefoYmd, ".");
			Str_Cat(szBefoYmd, szImpMonth);
			Str_Cat(szBefoYmd, ".");
			Str_Cat(szBefoYmd, szImpDay);
		}
		
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA79), szBefoYmd ) ;
	}

//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		char* ptr;
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
					PRINT(">>> TASK_SYS_CALL:: UART_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
					
					//�������� +19
					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_BSBAR,  m_szfilenm, 0);
	
					if( FFS_Exist(szPhotopath) )
					{
						FFS_Copy(szPhotopath, g_szphoto);
						FFS_Delete(szPhotopath);
					}
					
					Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
					SPRINT(szTmp, "UPDATE SPECIAL_DATA SET TEMP_INST_BAR_PHOTO_YN = 'Y' WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
					g_Sql_DirectExecute(szTmp);
				}

				//ȭ�� REFRESH
				REDRAW();
			}
			else if( nData == TASK_BARCODE )
			{
				//ī�޶� ���ڵ� ��ĵ ��
				Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
				ptr = (char*)System_GetResult((char*)&nRet);
				Str_Cpy(m_szBarcode_Value, ptr);

				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					OnBarcodeRead();
				}
			}
		}

		ON_DRAW();
		return;
	}

//------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		if (nEvent == UART_BARCODE)
		{
			if( theDevInfo.m_nType == FAMILY_PDA )
			{
				PDA_OnBarcodeRead();
			}
			else
			{
				OnBarcodeRead();
			}
		}
	}

//------------------------------------------------------------------------------
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
		char szMsg[300];
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

		if( Str_Len(m_szBarcode_Value) > 15 )
		{
			//Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			//Str_Cpy(g_szCurrBar, m_szBarcode_Value);
			Mem_Cpy((byte *)szBar, (byte *)m_szBarcode_Value, 7);
			
			if( Str_Cmp(stBs.SPECIAL_NUM, szBar) == 0 )	
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA74), m_szBarcode_Value ) ;
				//EditCtrl_ModifyStyle( Get_hDlgCtrlByID(TXT_DATA74), 0, EDITSTY_HIDDEN);
				Str_Cpy(stBs.CURR_BAR, m_szBarcode_Value);
				Str_Cpy(stBs.BAR_WHY, "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), "");

				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), TRUE );

				Mem_Set( (byte*)m_szBarSql, 0x00, sizeof(m_szBarSql) );
				SPRINT(m_szBarSql, "UPDATE SPECIAL_DATA SET CURR_BAR = '%s', BAR_RCV_YN = 'Y' WHERE CHK_EXEC_NUM = '%s' ", stBs.CURR_BAR, g_szCHK_EXEC_NUM, 0);
				g_Sql_DirectExecute(m_szBarSql);				

				MessageBoxEx (CONFIRM_OK, "���ڵ带 ���������� �ν��߽��ϴ�.");
			}
			else
			{
				//Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA74), "" ) ;
				Str_Cpy(stBs.CURR_BAR, "");
				
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), FALSE );

				MessageBoxEx (CONFIRM_OK, "���ڵ� ������ ��ġ���� �ʽ��ϴ�. �ٽ� Ȯ���� �ֽʽÿ�.");
			}
		}
		else
		{
			//Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA74), "");
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "���ڵ� ������ �߸��Ǿ����ϴ�.\n[%s]",m_szBarcode_Value,0,0);
			MessageBoxEx (CONFIRM_OK, szMsg);
		}

Finally:	
	
		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}

		ON_DRAW();
		return;
	}

//=======================================================================================
	void PDA_OnBarcodeRead(void)
	{
	char szMsg[300];
	char szBar[10];
	long lCnt, lRow;
	long RetFlag = -1;
	long ret = 0;

		Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
		ret = Barcode_Read( m_szBarcode_Value );	
		if( ret < 0)
		{
			MessageBoxEx (ERROR_OK, "���ڵ� �б� ����");
			goto Finally;
		}

		if( Str_Len(m_szBarcode_Value) > 15 )
		{
			//Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			//Str_Cpy(g_szCurrBar, m_szBarcode_Value);
			Mem_Cpy((byte *)szBar, (byte *)m_szBarcode_Value, 7);
			
			
			if( Str_Cmp(stBs.SPECIAL_NUM, szBar) == 0 )	
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA74), m_szBarcode_Value ) ;
				//EditCtrl_ModifyStyle( Get_hDlgCtrlByID(TXT_DATA74), 0, EDITSTY_HIDDEN);
				Str_Cpy(stBs.CURR_BAR, m_szBarcode_Value);
				Str_Cpy(stBs.BAR_WHY, "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARCODE), "");

				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), TRUE );

				Mem_Set( (byte*)m_szBarSql, 0x00, sizeof(m_szBarSql) );
				SPRINT(m_szBarSql, "UPDATE SPECIAL_DATA SET CURR_BAR = '%s', BAR_RCV_YN = 'Y' WHERE CHK_EXEC_NUM = '%s' ", stBs.CURR_BAR, g_szCHK_EXEC_NUM, 0);
				g_Sql_DirectExecute(m_szBarSql);				

				MessageBoxEx (CONFIRM_OK, "���ڵ带 ���������� �ν��߽��ϴ�.");
			}
			else
			{
				//Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA74), "" ) ;
				Str_Cpy(stBs.CURR_BAR, "");
				
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARCODE+1), FALSE );

				MessageBoxEx (CONFIRM_OK, "���ڵ� ������ ��ġ���� �ʽ��ϴ�. �ٽ� Ȯ���� �ֽʽÿ�.");
			}
		}
		else
		{
			//Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA74), "");
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "���ڵ� ������ �߸��Ǿ����ϴ�.\n[%s]",m_szBarcode_Value,0,0);
			MessageBoxEx (CONFIRM_OK, szMsg);
		}

Finally:

		ON_DRAW();
		return;
	}

//------------------------------------------------------------------------------
	bool Save_Result(void)
	{
		char szSql[500];
		char szToday[15];
		char* pRst;
		long idx, i;
		long lCount;
		long lsign, lSign_Len;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

/*		
-->>���� Ư�� �������
		//����
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		//lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��" );
		lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��", SIGN_OPT_NONE );
		if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
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
			lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
			//fd= FFS_Open ( "BASE64_Encode.txt", FS_WRITE_MODE , FS_CREATE_FLAG );
			//FFS_Write(fd, (byte*)pRst, Str_Len(pRst) );
			//FFS_Close(fd);
		}
*/
		//����
		//lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��" );
		//2017-07-21 Sanghyun Lee , ���ǿ� ���� ���� ���� �߰�
		//SIGN_OPT_NONE : �ʼ��� �Է��ؾ��ϴ� ���� , SIGN_OPT_CHECK : �Է����� �ʾƵ� �Ѿ���ִ� ����

		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		if( m_nCheck == 0 )
		{
			lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��", SIGN_OPT_NONE );
		}
		else
		{
			lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��", SIGN_OPT_CHECK );
		}

		if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
		{
			ret = FALSE;
			goto Finally;
		}
		else if( lsign == SIGN_RET_SUCCESS )
		{
			g_png_getbmp(SIGN_WIDTH, SIGN_HEIGHT, g_SignBuf );
			if(g_pjcomm != NULL )
			{
				BASE64_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}
			g_pjcomm = BASE64_Create();
			lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
		}

		//���� �����ڵ�
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), SIGN_RLT );
		if (i == -1)
		{
			Str_Cpy(stBs.SIGN_RELAT, "");
		}
		else
		{
			Str_Cpy(stBs.SIGN_RELAT, CHKBAR_WHY[i].Code);
		}

		//������
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		Str_ItoA(Time_GetDate(), szToday, 10);
		Str_Cpy(stBs.CHK_YMD, szToday);

		//���ڵ�����
		//2017-09-19 Sanghyun Lee
		//���ڵ� ��ĵ �� �ٷ� ����DB�� ������Ʈ �ǵ��� ����
		//if( Str_Len(g_szCurrBar) > 15 )
		//{
		//	Str_Cpy(stBs.CURR_BAR, g_szCurrBar);
		//}

		//��������ð�
		g_Str_TimeType( stBs.CHK_TIME_TO , Time_GetTime());

		//���
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND BETTER_YN = 'N' ", g_szCHK_EXEC_NUM, 0, 0);
						
		g_Sql_RetInt(szSql, &lCount);
		
		if( lCount > 0 )
		{
			Str_Cpy(stBs.CHK_RSLT, "21");
		}
		else
		{
			Str_Cpy(stBs.CHK_RSLT, "20");
		}
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		if( Str_Cmp(stBs.SEND_YN, "S") == 0 || Str_Cmp(stBs.SEND_YN, "Y") == 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE SPECIAL_DATA  \
			                  SET MRT_RSLT = ?, CHK_RSLT = ?, CHK_EMPID = ?, CHKER_NM = ?, SIGN_RELAT = ? \
			                    , SIGN = ?, CURR_BAR = ?, BAR_WHY = ?, UPD_EMPID = ?, PDA_IP = ? \
			                    , PERIOD_CHK_YMD = ?, HEAT_PUMP_YN = ?, PIPE_BURY_YN = ?, PIPE_HIDE_YN = ? \
							WHERE CHK_EXEC_NUM = '%s' "
						, g_szCHK_EXEC_NUM, 0, 0);
		}
		else
		{
			Str_Cpy(stBs.SEND_YN, "S");
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE SPECIAL_DATA  \
			                  SET MRT_RSLT = ?, CHK_RSLT = ?, CHK_EMPID = ?, CHKER_NM = ?, SIGN_RELAT = ? \
			                    , SIGN = ?, CURR_BAR = ?, BAR_WHY = ?, UPD_EMPID = ?, PDA_IP = ? \
			                    , PERIOD_CHK_YMD = ?, HEAT_PUMP_YN = ?, PIPE_BURY_YN = ?, PIPE_HIDE_YN = ?, CHK_YMD = ? \
			                    , CHK_TIME_FROM = ?, CHK_TIME_TO = ?, SEND_YN = ? \
							WHERE CHK_EXEC_NUM = '%s' "
						, g_szCHK_EXEC_NUM, 0, 0);
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stBs.MRT_RSLT		    ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_RSLT		    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor	    ,12 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SIGN_RELAT	        ,20 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)pRst						,Str_Len(pRst) ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CURR_BAR		    ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.BAR_WHY			    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      ,15 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stBs.PERIOD_CHK_YMD	    ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.HEAT_PUMP_YN	    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.PIPE_BURY_YN	    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.PIPE_HIDE_YN	    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_YMD			    ,8  ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_TIME_FROM	    ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.CHK_TIME_TO		    ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stBs.SEND_YN		        ,1  ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "������ �Ϸ�Ǿ����ϴ�");
		}
		
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
//--------------------------------------------------------------------------------------------
	bool Validate(void)
	{
		char szTmp[256];
		char szfilenm[256];
		char szDate[256];
		char szYear[256];
		char szChkDate[256];
		char szSql[300];
		long lCount;
		bool ret = TRUE;
		
		Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szChkDate, 0x00, sizeof(szChkDate));
		
		Str_ItoA(Time_GetDate(), szDate, 10);
		Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
		Mem_Cpy((byte *)szChkDate, (byte *)stGovinfo2.NEW_DISJOINT_CHK_YMD, 4);

		if( Str_Cmp(stGovinfo2.GOV_REGTR_FLAG, "10") == 0 && Str_Cmp(stBs.PRESS_FLAG, "M") == 0)
		{
			if( Str_Len(stGovinfo2.NEW_DISJOINT_CHK_YMD) == 0 )
			{	
				MessageBoxEx (CONFIRM_OK, "���б� ������������ Ȯ���ϼ���.\n(�ʼ�)");
				ret = FALSE;
				return ret;
			}
		}
		
		if( Str_Cmp(stBs.SPECIAL_RSLT, "") == 0 || Str_Cmp(stBs.MRT_RSLT, "") == 0)
		{
			MessageBoxEx (CONFIRM_OK, "�������׸��� Ȯ���ϼ���.");
			ret = FALSE;
			return ret;
		}
	
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA7)), "��Ȯ��") == 0  )
		{
			MessageBoxEx (CONFIRM_OK, "Ư�������� Ȯ���ϼ���.");
			ret = FALSE;
			return ret;
		}

		if( g_lRfrmFlag == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�����ǰ� ������ �ּ���!");
			ret = FALSE;
			return ret;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);		

		if( lCount == 0)
		{
			// MessageBoxEx (CONFIRM_OK, "������ �׸��� ���µ� , \n�����ǰ� ������ �����մϴ�.\n �����ǰ� ������ �����Ͻðڽ��ϱ�?");

		 	Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		 	SPRINT(szSql, " DELETE FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM ='%s' AND SEND_YN ='S' ", stBsNogood.CHK_EXEC_NUM,0,0);
			g_Sql_DirectExecute( szSql );

		}
		
		if( !( Str_Cmp(stUserinfo.szcenter_cd,"91") == 0 
			|| Str_Cmp(stUserinfo.szcenter_cd,"92") == 0 
			|| Str_Cmp(stUserinfo.szcenter_cd,"93") == 0 
			|| Str_Cmp(stUserinfo.szcenter_cd,"94") == 0 
			|| Str_Cmp(stUserinfo.szcenter_cd,"95") == 0 ) )
		{
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA74))) == 0 &&
			    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARCODE))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "���ڵ带 ��ĵ�ϰų� �Ұ������� �����ϼ���.");
				ret = FALSE;
				return ret;
			}
			
			if(Str_Cmp(stBs.INST_BAR_PHOTO_YN, "Y") != 0)
			{
				//����
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Str_Cpy(szfilenm, g_szCHK_EXEC_NUM);
				Str_Cat(szfilenm, "_");
				Str_Cat(szfilenm, stBs.SPECIAL_NUM);
				Str_Cat(szfilenm, ".jjp");
		
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SPRINT (szTmp, "%s/%s",PHOTO_BSBAR, szfilenm, 0);
	
				if( FFS_Exist(szTmp) <= 0 && Str_Cmp( stBs.TEMP_INST_BAR_PHOTO_YN, "Y" ) != 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�����Կ��� ���ּ���.");
					ret = FALSE;
					return ret;
				}
			}
		}
		if( Str_Cmp(stBs.CHK_TYPE, "21") == 0 )
		{
			if( Str_Cmp(stBs.PERIOD_CHK_YMD, "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "����˻����� �Է��ϰų� Ȯ�κҰ��� �������ּ���.");
				ret = FALSE;
				return ret;
			}
		}
		
		
		
		return ret;
	}
	
//-----------------------------------------------------------------	
	bool Save_Issue(void)
	{
		char szZero[10];
		char szSql[500];
		long idx;
		long i;
		long lDegree = 0;
		long lCount;
		long lDate;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD_CHA \
						 WHERE CHK_EXEC_NUM ='%s' AND BETTER_ADVICE_DEGREE = '1' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL) ", g_szCHK_EXEC_NUM, 0, 0);
		
		g_Sql_RetInt(szSql, &lCount);		
		
		//�����ǰ�����
		Mem_Set( (byte*)stBsNogoodCha.BETTER_ADVICE_YMD, 0x00, sizeof(stBsNogoodCha.BETTER_ADVICE_YMD) );
		lDate = Time_GetDate();
		Str_ItoA(lDate, stBsNogoodCha.BETTER_ADVICE_YMD, 10);
		
		//�����ǰ����
		Mem_Set( (byte*)stBsNogoodCha.BETTER_ADVICE_EXPIRE, 0x00, sizeof(stBsNogoodCha.BETTER_ADVICE_EXPIRE) );
		lDate = Time_DateUpDown(lDate, 30);
		Str_ItoA(lDate, stBsNogoodCha.BETTER_ADVICE_EXPIRE, 10);
			
		//���˽����ȣ
		Mem_Set( (byte*)stBsNogoodCha.CHK_EXEC_NUM, 0x00, sizeof(stBsNogoodCha.CHK_EXEC_NUM) );
		Str_Cpy(stBsNogoodCha.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
		
		//��������
		Mem_Set( (byte*)stBsNogoodCha.BETTER_YN, 0x00, sizeof(stBsNogoodCha.BETTER_YN) );
		Str_Cpy(stBsNogoodCha.BETTER_YN, "N");
		
		// ��������
		Mem_Set( (byte*)stBsNogoodCha.BETTER_END_YMD, 0x00, sizeof(stBsNogoodCha.BETTER_END_YMD) );
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( lCount > 0 )
		{
			hstmt = sql->CreateStatement(sql," UPDATE SPECIAL_NOGOOD_CHA \
									              SET BETTER_ADVICE_YMD = ?, BETTER_ADVICE_EXPIRE = ?, SEND_YN = 'S', UPD_EMPID = ?, PDA_IP = ? \
												WHERE CHK_EXEC_NUM = '%s' AND BETTER_ADVICE_DEGREE = '1' ");
		}
		else
		{
			hstmt = sql->CreateStatement(sql," INSERT INTO SPECIAL_NOGOOD_CHA \
											   ( CHK_EXEC_NUM, BETTER_ADVICE_DEGREE, OBJ_YM, SPECIAL_NUM, CHK_TYPE \
											   , BETTER_ADVICE_YMD, BETTER_ADVICE_EXPIRE, BETTER_YN, BETTER_END_YMD, SEND_YN \
									           , UPD_EMPID, PDA_IP, CHK_YEAR, CHK_ORDER ) \
									           VALUES \
									           ( ?, '1', ?, ?, ? \
									           , ?, ?, 'N', ?, 'S' \
										   	   , ?, ?, ?, ? )" );
		}
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		
		if( lCount > 0 )
		{
			sql->Bind(sql, idx++, 'U', (long*) stBsNogoodCha.BETTER_ADVICE_YMD   ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stBsNogoodCha.BETTER_ADVICE_EXPIRE,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szemployee_id          ,20 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szpda_ip               ,15 ,DECRYPT);
		}
		else
		{
			sql->Bind(sql, idx++, 'U', (long*) stBs.CHK_EXEC_NUM                 ,12,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stBs.OBJ_YM                       ,6 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stBs.SPECIAL_NUM                  ,7 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stBs.CHK_TYPE                     ,2 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long*) stBsNogoodCha.BETTER_ADVICE_YMD   ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stBsNogoodCha.BETTER_ADVICE_EXPIRE,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stBsNogoodCha.BETTER_END_YMD      ,8 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szemployee_id          ,20 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stUserinfo.szpda_ip               ,15 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stBs.CHK_YEAR                     ,4 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*) stBs.CHK_ORDER                    ,2 ,DECRYPT);
		}
		
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
		SPRINT(szSql, " SELECT COUNT(*) FROM SPECIAL_NOGOOD WHERE CHK_EXEC_NUM ='%s' "
						, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);		

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( lCount > 0 )
		{
			hstmt = sql->CreateStatement(sql,
			"UPDATE SPECIAL_NOGOOD SET \
			CHK_EXEC_NUM = ?, OBJ_YM = ?, SPECIAL_NUM = ?, CHK_TYPE = ?, SPECIAL_NM = ?, CHK_YEAR = ?, CHK_ORDER = ?, CENTER_CD = ? \
			, ZONE_MANAGE_NUM = ?, PDA_NUM = ?, CITY = ?, COUNTY = ?, TOWN = ?, VILLAGE = ?, ADDR1_M = ?, ADDR1_S = ?, SECOND_ADDR = ? \
			, BLD_DONG = ?, HOSU = ?, ZIP_NO1 = ?, ZIP_NO2 = ?, NEW_HOSU = ?, NEW_ADDR_UNGRNOUD_YN = ?, NEW_ADDR_UNION = ? \
			, LAW_TOWN = ?, NEW_ROAD_NM = ?, NEW_ADDR_M = ?, NEW_ADDR_S = ?, SAFE_MANAGER_NM = ?, MANAGE_TEL_DDD = ? \
			, MANAGE_TEL_EXN = ?, MANAGE_TEL_NUM = ?, MANAGE_CP_DDD = ?, MANAGE_CP_EXN = ?, MANAGE_CP_NUM = ? \
			, PRESS_FLAG = ?, SPECIAL_YN = ?, COMPL_INSPECT_YMD = ?, MM_USE_PLAN_QTY = ?, INS_JOIN_YN = ?, INS_JOIN_YMD = ? \
			, UPD_EMPID = ?, PDA_IP = ? \
			WHERE CHK_EXEC_NUM = '%s' "
				);
		}
		else
		{
			hstmt = sql->CreateStatement(sql,
			"INSERT INTO SPECIAL_NOGOOD \
			( CHK_EXEC_NUM, OBJ_YM, SPECIAL_NUM, CHK_TYPE, SPECIAL_NM, CHK_YEAR, CHK_ORDER \
			, CENTER_CD, ZONE_MANAGE_NUM, PDA_NUM, CITY, COUNTY, TOWN, VILLAGE, ADDR1_M \
			, ADDR1_S, SECOND_ADDR, BLD_DONG, HOSU, ZIP_NO1, ZIP_NO2 \
			, NEW_HOSU, NEW_ADDR_UNGRNOUD_YN, NEW_ADDR_UNION, LAW_TOWN, NEW_ROAD_NM \
			, NEW_ADDR_M, NEW_ADDR_S, SAFE_MANAGER_NM, MANAGE_TEL_DDD, MANAGE_TEL_EXN \
			, MANAGE_TEL_NUM, MANAGE_CP_DDD, MANAGE_CP_EXN, MANAGE_CP_NUM, PRESS_FLAG \
			, SPECIAL_YN, COMPL_INSPECT_YMD, MM_USE_PLAN_QTY, INS_JOIN_YN, INS_JOIN_YMD \
			, END_YN, SEND_YN, UPD_EMPID, PDA_IP )  \
			VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
				   , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
				   , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
				   , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
				   , ?, 'N', 'S', ?, ? ) "
				);
		}
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_EXEC_NUM         , 12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.OBJ_YM               , 6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.SPECIAL_NUM          , 7 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_TYPE             , 2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.SPECIAL_NM           , 50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_YEAR             , 4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.CHK_ORDER            , 2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.CENTER_CD            , 6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.ZONE_MANAGE_NUM      , 5 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.PDA_NUM              , 5 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.CITY                 , 20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.COUNTY               , 20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.TOWN                 , 20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.VILLAGE              , 20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.ADDR1_M              ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.ADDR1_S              ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.SECOND_ADDR          ,100,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.BLD_DONG             ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.HOSU                 ,  4,DECRYPT);
		//sql->Bind(sql, idx++, 'U', (long *)stBs.CURR_ADDR_UNION      ,  6,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.ZIP_NO1              ,  3,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.ZIP_NO2              ,  3,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.NEW_HOSU             ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.NEW_ADDR_UNGRNOUD_YN ,  1,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.NEW_ADDR_UNION       ,300,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.LAW_TOWN             , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.NEW_ROAD_NM          ,100,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.NEW_ADDR_M           , 10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.NEW_ADDR_S           , 10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.SAFE_MANAGER_NM      , 32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.MANAGE_TEL_DDD       ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.MANAGE_TEL_EXN       ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.MANAGE_TEL_NUM       ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.MANAGE_CP_DDD        ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.MANAGE_CP_EXN        ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.MANAGE_CP_NUM        ,  4,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.PRESS_FLAG           ,  1,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.SPECIAL_YN           ,  1,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.COMPL_INSPECT_YMD    ,  8,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.MM_USE_PLAN_QTY      , 10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.INS_JOIN_YN          ,  1,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stBs.INS_JOIN_YMD         ,  8,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id  , 20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip       , 15,DECRYPT);
	
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
	
//-----------------------------------------------------------------------------------------------
	bool Check(void)
	{
		bool ret = TRUE;
		
		if( stBs.SPECIAL_RSLT[0] == '' )
		{
			MessageBoxEx (CONFIRM_OK, "�������׸��� Ȯ���ϼ���.");
			ret = FALSE;
			return ret;
		}
		
		if( stBs.MRT_RSLT[0] == '' )
		{
			MessageBoxEx (CONFIRM_OK, "�������׸��� Ȯ���ϼ���.");
			ret = FALSE;
			return ret;
		}
		
		if( Str_Cmp(stBs.INFO_YN, "Y") != 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Ư�������� Ȯ���ϼ���.");
			ret = FALSE;
			return ret;
		}
		
		return ret;
	}
	
//----------------------------------------------------------------------------------------------
/*
Ư������ ���ڵ� ��ġ ����	C38(��������) | E(���˽����ȣ | S(Ư����ȣ) | D( ������¥(SYSDATE : YYYYMMDDHHMMSS )				
���� ���� ���� : C38E133176S2027601D201706130956
*/
	void Shoto_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet;

		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Str_Cpy(m_szfilenm, g_szCHK_EXEC_NUM);
		Str_Cat(m_szfilenm, "_");
		Str_Cat(m_szfilenm, stBs.SPECIAL_NUM);
		Str_Cat(m_szfilenm, ".jjp");

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_BSBAR,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//��������
		//	Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
		//	SPRINT (g_szphoto, "%s/%s", PHOTO_BSBAR,  m_szfilenm, 0);
		//	//���Ŀ��� Ȯ�ν�...
			//Str_Cpy(szScrPht, szfilenm);
		//	ShootPhoto ( 1, 0, m_szfilenm );
		
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
		
		return;
	}
	
	void SetStatus(char* pText)
	{	
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_TIME_LEFT), pText);
		ON_DRAW();
	}
	
	void Start_Timer(void)
	{
		char temp[2];
		long fromTime = 0; // ���۽ð� ��
		long toTime = 0;   // ����ð� ��
		long time_Result = 0;
		char szSql[100];
		
		if( Str_Cmp(stBs.SEND_YN, "S") == 0 || Str_Cmp(stBs.SEND_YN, "Y") == 0 || Str_Cmp(stBs.CHK_TYPE, "30") == 0)
		{
			SetStatus("0��");
			return;
		}
		
		/************************************************************/
		/* �ð� ��� Start                                          */
		/************************************************************/
		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stBs.CHK_TIME_FROM, 2);
		
		fromTime = 60 * 60 * Str_AtoI(temp);
		
		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stBs.CHK_TIME_FROM + 2, 2);
		
		fromTime += 60 * Str_AtoI(temp);
		
		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stBs.CHK_TIME_FROM + 4, 2);
		
		fromTime += Str_AtoI(temp);
		
		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stBs.CHK_TIME_TO, 2);
		
		toTime = 60 * 60 * Str_AtoI(temp);

		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stBs.CHK_TIME_TO + 2, 2);
		
		toTime += 60 * Str_AtoI(temp);
		
		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stBs.CHK_TIME_TO + 4, 2); 
		
		toTime += Str_AtoI(temp);
		
		time_Result = toTime - fromTime;
		/************************************************************/
		/* �ð� ��� End                                            */
		/************************************************************/
		
		if( time_Result < SET_TIME )
		{
			if(m_nTimerId == -1)
			{
				m_nTimerCnt = SET_TIME - time_Result;
				m_nTimerId = Timer_Set(1000,0);
			}
		}
		else
		{
			SetStatus("0��");
		}
		
		return;
	}
	
	void Stop_Timer(void)
	{
		if(m_nTimerCnt == 0)
		{
			SetStatus("0��");
			Timer_Kill( m_nTimerId );
			m_nTimerId = -1;
			//ON_DRAW();
			return;
		}
		else
		{
			Mem_Set( (byte*)m_szBuf, 0x00, sizeof(m_szBuf) );
			Str_Printf(m_szBuf, "%d��", m_nTimerCnt,0,0);
			SetStatus( m_szBuf );
			m_nTimerCnt--;
			//ON_DRAW();
			return;
		}
	}
	
	void OnTimer(long nTimerID)
	{	
		if(m_nTimerId == nTimerID)
		{
			Stop_Timer();
		}
		else
		{
			Mem_Set( (byte*)stBs.CHK_TIME_TO, 0x00, sizeof(stBs.CHK_TIME_TO) );
			g_Str_TimeType( stBs.CHK_TIME_TO, Time_GetTime() );
			Start_Timer();
		}
	}
	
	void OnExit(void)
	{
		if(m_nTimerId != -1)
		{
			Timer_Kill( m_nTimerId);
			m_nTimerId = -1;
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
		char szSql[201];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		
		if( g_nWorkFlag == 305 || g_nWorkFlag == 306 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '5' ", g_nActIndex, 0, 0);
		}
		else
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '5' ", g_nActIndex, 0, 0);
		}
		
		g_Sql_DirectExecute(szSql);
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
		SPRINT(szSql, "SELECT ROWID FROM SPECIAL_DATA ORDER BY ZIP_NO1, ZIP_NO2, ADDR1_M ", 0, 0, 0);
		g_Sql_SaveSeq( szSql, CMBFILTER_FILE);
		
		//g_szCHK_EXEC_NUM
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ROWID FROM SPECIAL_DATA WHERE CHK_EXEC_NUM = '%s' ORDER BY ZIP_NO1, ZIP_NO2, ADDR1_M ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt( szSql, &lRow );

		lActIndex = g_Get_FsIndex(lRow, CMBFILTER_FILE);
			
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		if( g_nWorkFlag == 305 || g_nWorkFlag == 306 )
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '5' ", lActIndex, 0, 0);		
		}
		else
		{
			SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '5' ", lActIndex, 0, 0);		
		}

		g_Sql_DirectExecute(szSql);

		return;
	}
}


