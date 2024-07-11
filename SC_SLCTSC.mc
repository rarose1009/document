/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card SC_SLCTSC
{
	#include <include.h>
	#include "globalcard.h"
	#include "Calendar.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
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
//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
//�˻�
		DEF_BUTTON_ID ( BID_BAR )
		DEF_BUTTON_ID ( BID_SEARCH1 )		//���밡��ȣ ��ȸ
		DEF_BUTTON_ID ( BID_SEARCH2 )		//�⹰��ȣ ��ȸ
		DEF_BUTTON_ID ( BID_SEARCH3 )		//���ڵ� ��ȸ
		DEF_BUTTON_ID ( BID_SEARCH4 )
		DEF_BUTTON_ID ( BID_SEARCH5 )
		DEF_BUTTON_ID ( BID_SEARCH6 )		//��ȸ
		DEF_BUTTON_ID ( BID_SEARCH7 )
		DEF_BUTTON_ID ( BID_ADDR )
		DEF_BUTTON_ID ( BID_NADDR )
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
//�˻�
		DEF_OBJECT_ID ( TXT_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_CSMNUM )		//���밡��ȣ
		DEF_OBJECT_ID ( TXT_OBJNUM )		//�⹰��ȣ
		DEF_OBJECT_ID ( TXT_BARNUM )		//���ڵ�
		DEF_OBJECT_ID ( TXT_CPTEL  )		//�޴���
		DEF_OBJECT_ID ( TXT_OWNTEL )		//����ȭ
		DEF_OBJECT_ID ( TXT_ADDR)			//�ּ�
		DEF_OBJECT_ID ( TXT_GOO )			//��
		DEF_OBJECT_ID ( TXT_DONG )			//��
		DEF_OBJECT_ID ( TXT_BUNJI )			//����
		DEF_OBJECT_ID ( TXT_HOSOO )			//ȣ��
		DEF_OBJECT_ID ( TXT_NWADDR )		//���ּ�
		DEF_OBJECT_ID ( TXT_NWGOO )			//��
		DEF_OBJECT_ID ( TXT_STREET )		//���θ�
		DEF_OBJECT_ID ( TXT_BONBUN )		//����
		DEF_OBJECT_ID ( TXT_BOOBUN )		//�ι�

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

//�˻�
		DEF_OBJECT_ID ( EDT_CSMNUM )		//���밡��ȣ �Է�
		DEF_OBJECT_ID ( EDT_OBJNUM )		//�⹰��ȣ �Է�
		DEF_OBJECT_ID ( EDT_BARNUM )		//���ڵ� �Է�
		DEF_OBJECT_ID ( EDT_CPTEL  )		//�޴���
		DEF_OBJECT_ID ( EDT_OWNTEL )		//����ȭ
		DEF_OBJECT_ID ( EDT_BUNJI )			//���� �Է�
		DEF_OBJECT_ID ( EDT_HOSOO )			//ȣ�� �Է�
		DEF_OBJECT_ID ( EDT_BONBUN )		//���� �Է�
		DEF_OBJECT_ID ( EDT_BOOBUN )		//�ι� �Է�
				
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
//�˻�
		DEF_OBJECT_ID ( CMB_GOO ) 				//��
		DEF_OBJECT_ID ( CMB_DONG = CMB_GOO+3 ) 			//��
		DEF_OBJECT_ID ( CMB_NWGOO = CMB_DONG+3 ) 		//��
		DEF_OBJECT_ID ( CMB_STREET = CMB_NWGOO+3 ) 		//���θ�
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	#define INIT_NEW	2
	
	long m_lBtnId = -1;
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_lActIndex = -1;		//��Ƽ��� index
	char m_szCnt_page[10];		// ������ ǥ�� ����
	char m_szSql[2][1200];
	char m_szCobSel[20];		//
	char m_bFirst;
	char m_szSingle_Flag[10];
	char m_szInstNum[11];
	char m_szMtrNum[11];
	char m_szBarNum[22];
	char m_szCpNum[15];
	char m_szHouseNum[15];
	char m_szBarcode_Value[20];	//���ڵ� ��ĵ ���
	
	bool Search_Addr(long nbuttonid);
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void REDRAW(void);
	void SetCombo(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void SetSearch(void);
	void SaveInput(void);
	void SetBtnImg(void);
	void Barcode(void);
	void OnBarcodeRead(void);
	void PDA_OnBarcodeRead(void);
	long SearchCD(char *CD, CodeTable *CT);		//�ڵ� ���� ã�´�.
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	
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
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ����"),

		DLG_BUTTON(STARTX+800,  STARTY+65, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+135, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+205, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+275, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+345, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "�� ȸ"),
		DLG_BUTTON(STARTX+600, STARTY+830, 400, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH6, "�� ȸ"),

		//üũ�ڽ� �ؽ�Ʈ		
		DLG_TEXT(STARTX,	 STARTY+65, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "���밡��ȣ"),
		DLG_TEXT(STARTX,	STARTY+135, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_BUTTON(STARTX,	STARTY+205, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR, "���ڵ�"),
		DLG_TEXT(STARTX,	STARTY+275, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CPTEL , "�ڵ�����ȣ"),
		DLG_TEXT(STARTX,	STARTY+345, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "����ȭ��ȣ"),
		
		DLG_TEXT(STARTX,       STARTY+440, 300, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, "���ּҰ˻�"),
		DLG_BUTTON(STARTX+300, STARTY+440, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+650, STARTY+440, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		
		DLG_EDIT(STARTX+300,  STARTY+65, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+135, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300, STARTY+205, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+275, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+345, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OWNTEL, 15,  ""),

		DLG_TEXT(STARTX,	 STARTY+520, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOO, "��"),
		DLG_TEXT(STARTX,	 STARTY+590, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DONG, "��"),
		DLG_TEXT(STARTX,	 STARTY+660, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BUNJI, "����"),
		DLG_EDIT(STARTX+200, STARTY+660, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BUNJI , 10,  ""),
		DLG_TEXT(STARTX,	 STARTY+730, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HOSOO, "ȣ��"),
		DLG_EDIT(STARTX+200, STARTY+730, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_HOSOO , 10,  ""),
		
		DLG_COMBO (STARTX+200, STARTY+520, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOO, 10),		//��(�� �ּ�)
		DLG_COMBO (STARTX+200, STARTY+590, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DONG, 10),		//��

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
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
			
		DLG_BUTTON(STARTX+800,  STARTY-40, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "�� ȸ"),
		DLG_BUTTON(STARTX+800,  STARTY+30, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+100, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+170, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+240, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "�� ȸ"),
		DLG_BUTTON(STARTX+600, STARTY+780, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH6, "�� ȸ"),
//		DLG_BUTTON(STARTX+800, STARTY+440, 175, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH7, "�� ȸ"),

		//üũ�ڽ� �ؽ�Ʈ		
		DLG_TEXT(STARTX,    STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "���밡��ȣ"),
		DLG_TEXT(STARTX,    STARTY+30, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_BUTTON(STARTX, STARTY+100, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR, "���ڵ�"),
		DLG_TEXT(STARTX,   STARTY+170, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CPTEL , "�ڵ�����ȣ"),
		DLG_TEXT(STARTX,   STARTY+240, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "����ȭ��ȣ"),

		DLG_EDIT(STARTX+300,  STARTY-40, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300,  STARTY+30, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300, STARTY+100, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+170, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+240, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OWNTEL, 15,  ""),
		
		DLG_TEXT(STARTX,       STARTY+350, 300, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, "���ּҰ˻�"),
		DLG_BUTTON(STARTX+300, STARTY+350, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+650, STARTY+350, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		
		DLG_TEXT(STARTX, STARTY+450, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GOO, "��"),
		DLG_TEXT(STARTX, STARTY+520, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DONG, "��"),
		DLG_TEXT(STARTX, STARTY+590, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BUNJI, "����"),
		DLG_TEXT(STARTX, STARTY+660, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_HOSOO, "ȣ��"),
		
		DLG_EDIT(STARTX+200, STARTY+590, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BUNJI , 10,  ""),
		DLG_EDIT(STARTX+200, STARTY+660, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_HOSOO , 10,  ""),
		
//		DLG_EDIT(STARTX+200, STARTY+750, 775, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BONBUN, 20,  ""),
//		DLG_EDIT(STARTX+200, STARTY+800, 775, 50, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BOOBUN, 20,  ""),
		DLG_COMBO (STARTX+200, STARTY+450, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GOO, 10),		//��(�� �ּ�)
		DLG_COMBO (STARTX+200, STARTY+520, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DONG, 10),		//��
		//DLG_COMBO (STARTX+200, STARTY+650, 775, 200, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//��(�� �ּ�)
		//DLG_COMBO (STARTX+200, STARTY+700, 775, 200, 150, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//���θ�
	};

	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_NEW[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ����"),

		DLG_BUTTON(STARTX+800,  STARTY+65, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+135, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+205, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+275, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+345, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "�� ȸ"),
//		DLG_BUTTON(STARTX+675, STARTY+750, 300, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH6, "�� ȸ"),
		DLG_BUTTON(STARTX+600, STARTY+830, 400, 69, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH7, "�� ȸ"),

		//üũ�ڽ� �ؽ�Ʈ		
		DLG_TEXT(STARTX,	 STARTY+65, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "���밡��ȣ"),
		DLG_TEXT(STARTX,	STARTY+135, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_BUTTON(STARTX,	STARTY+205, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR, "���ڵ�"),
		DLG_TEXT(STARTX,	STARTY+275, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CPTEL , "�ڵ�����ȣ"),
		DLG_TEXT(STARTX,	STARTY+345, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "����ȭ��ȣ"),

		DLG_EDIT(STARTX+300,  STARTY+65, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+135, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300, STARTY+205, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+275, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+345, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OWNTEL, 15,  ""),
		
		DLG_TEXT(STARTX,       STARTY+440, 300, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, "���ּҰ˻�"),
		DLG_BUTTON(STARTX+300, STARTY+440, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+650, STARTY+440, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		
		DLG_TEXT(STARTX,	 STARTY+520, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NWGOO, "��"),
		DLG_TEXT(STARTX,	 STARTY+590, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_STREET, "���θ�"),
		DLG_TEXT(STARTX,	 STARTY+660, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BONBUN, "����"),
		DLG_EDIT(STARTX+200, STARTY+660, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BONBUN, 20,  ""),
		DLG_TEXT(STARTX,	 STARTY+730, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BOOBUN, "�ι�"),
		DLG_EDIT(STARTX+200, STARTY+730, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BOOBUN, 20,  ""),
		
		DLG_COMBO (STARTX+200, STARTY+520, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//��(�� �ּ�)
		DLG_COMBO (STARTX+200, STARTY+590, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//���θ�

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
	DlgObject	DlgRes_NEW_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���� ����"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),
			
		DLG_BUTTON(STARTX+800,  STARTY-40, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH1, "�� ȸ"),
		DLG_BUTTON(STARTX+800,  STARTY+30, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH2, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+100, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH3, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+170, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH4, "�� ȸ"),
		DLG_BUTTON(STARTX+800, STARTY+240, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH5, "�� ȸ"),
		DLG_BUTTON(STARTX+600, STARTY+780, 400, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEARCH7, "�� ȸ"),

		//üũ�ڽ� �ؽ�Ʈ		
		DLG_TEXT(STARTX,    STARTY-40, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CSMNUM, "���밡��ȣ"),
		DLG_TEXT(STARTX,    STARTY+30, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OBJNUM, "�⹰��ȣ"),
		DLG_BUTTON(STARTX, STARTY+100, 300, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR, "���ڵ�"),
		DLG_TEXT(STARTX,   STARTY+170, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CPTEL , "�ڵ�����ȣ"),
		DLG_TEXT(STARTX,   STARTY+240, 300, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_OWNTEL, "����ȭ��ȣ"),
		
		DLG_EDIT(STARTX+300,  STARTY-40, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CSMNUM, 10,  ""),
		DLG_EDIT(STARTX+300,  STARTY+30, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OBJNUM, 20,  ""),
		DLG_EDIT(STARTX+300, STARTY+100, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BARNUM, 10,  ""),
		DLG_EDIT(STARTX+300, STARTY+170, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_CPTEL , 15,  ""),
		DLG_EDIT(STARTX+300, STARTY+240, 500, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_OWNTEL, 15,  ""),
		
		DLG_TEXT(STARTX,       STARTY+350, 300, 70, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_ADDR, "���ּҰ˻�"),
		DLG_BUTTON(STARTX+300, STARTY+350, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+650, STARTY+350, 350, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),

		DLG_TEXT(STARTX, STARTY+450, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_NWGOO, "��"),
		DLG_TEXT(STARTX, STARTY+520, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_STREET, "���θ�"),
		DLG_TEXT(STARTX, STARTY+590, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BONBUN, "����"),
		DLG_TEXT(STARTX, STARTY+660, 200, 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BOOBUN, "�ι�"),

		DLG_EDIT(STARTX+200, STARTY+590, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BONBUN, 20,  ""),
		DLG_EDIT(STARTX+200, STARTY+660, 800, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_BOOBUN, 20,  ""),
		
		DLG_COMBO (STARTX+200, STARTY+450, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_NWGOO, 10),	//��(�� �ּ�)
		DLG_COMBO (STARTX+200, STARTY+520, 800, 200, 200, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_STREET, 10),	//���θ�
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
				SetCombo();
				SetStyle();
				REDRAW();
				break;
			case INIT_NEW:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_NEW_P, SIZEOF(DlgRes_NEW_P));
						break;
					default:
						CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
						CREATE_DIALOG_OBJECT (DlgRes_NEW, SIZEOF(DlgRes_NEW));
						break;
				}

				SetBtnImg();
				SetCombo();
				SetStyle();
				REDRAW();
				break;
		}
	}
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		
		if( theDevInfo.m_nType > FAMILY_PDA )
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
	
//-------------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		long lret;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( POINTING_UP == nAction )
		{
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				m_lActiveIndex = lActiveIndex;
				
				if( m_bFirst == INIT_MAIN )
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+65) && Y < DMS_Y(STARTY+135) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+135) && Y < DMS_Y(STARTY+205) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+205) && Y < DMS_Y(STARTY+275) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+275) && Y < DMS_Y(STARTY+345) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+345) && Y < DMS_Y(STARTY+415) )
					{
						if( Get_iDlgCtrlByID(EDT_CSMNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_OBJNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BARNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_CPTEL)  == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_OWNTEL) == lActiveIndex )	
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
					else if( X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+660-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+730-(g_Dlgflag*400)) ||
					         X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+730-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+800-(g_Dlgflag*400))
					       )
					{
						if( Get_iDlgCtrlByID(EDT_BUNJI) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_HOSOO) == lActiveIndex )	
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
						if( Get_iDlgCtrlByID(EDT_BUNJI) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_HOSOO) == lActiveIndex )
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
						else
						{
							g_Dlgflag = 1;
							g_MOVE_DLG(1);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
						}
					}
				}
				else
				{
					if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+65) && Y < DMS_Y(STARTY+135) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+135) && Y < DMS_Y(STARTY+205) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+205) && Y < DMS_Y(STARTY+275) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+275) && Y < DMS_Y(STARTY+345) ||
					    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+800) && Y > DMS_Y(STARTY+345) && Y < DMS_Y(STARTY+415) 
					  )
					{
						if( Get_iDlgCtrlByID(EDT_CSMNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_OBJNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BARNUM) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_CPTEL) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_OWNTEL) == lActiveIndex )	
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
					else if( X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+660-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+730-(g_Dlgflag*400)) ||
					         X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+730-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+800-(g_Dlgflag*400))
					       )
					{
						if( Get_iDlgCtrlByID(EDT_BONBUN) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BOOBUN) == lActiveIndex )	
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
						if( Get_iDlgCtrlByID(EDT_BONBUN) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_BOOBUN) == lActiveIndex )	
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
	}
	
//��������������������������������������������������������������������������������������������
	void	OnSelect(long Index)
	{
		long index = -1;
		char szStscd[5];
		char szcmb[20];
/*
		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// ���� �ε����� ���� �ε����� ���� �� ���
				if ( index-1 == m_lActIndex )
				{
					//���õ� ������ ��ġ INDEX�� �۷ι������� ����
					g_nActIndex = m_lpage*ROW + index - 1;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

					g_lMoveFlag = 1;
					Set_Index();
					if(g_nWorkFlag == 205)//���ð�ħ���� �̵��ϸ� 
						g_nWorkFlag = 200;

					Card_Move("SC_CONFIRM");
					return;
				}
				else
				{
					//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR2), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 5));
					if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, index-1, 0), "10") == 0 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 9));
					}
					else if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, index-1, 0), "20") == 0 )
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ADDR3), DlgTbl_GetStr( ID_TBLLIST, index-1, 6));
					}
					
					
					Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
					Mem_Set((byte*)szStscd, 0x00, sizeof(szStscd));
					Str_Cpy(szcmb, DlgTbl_GetStr( ID_TBLLIST, index-1, 8) );
					Str_Cpy(szStscd, DlgTbl_GetStr( ID_TBLLIST, index-1, 11) );
					
					if( szcmb[0] == 'Y' )
					{
						if( Str_Cmp(szStscd, "30") == 0 )
						{
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), RED);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
						}
						else
						{
							ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), BLACK);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						}
					}
					else
					{
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS), BLACK);
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS), PDAEDTCTRLBK);
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
					}
										
					ON_DRAW();
					
					m_lActIndex = index - 1;//���õ� INDEX ����
					//g_nActIndex = m_lpage*ROW + index - 1;
					Str_Cpy( g_szCHK_EXEC_NUM, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 7));
					Str_Cpy( stScAddr.SEND_YN, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 10));
				}
			}
			
			Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
			Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELECT) ) );
			//�޺��ڽ� �������� ����Ʈ ��� ���͸�.(��ħ,�̰�ħ,��ü���)
			if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
			{
				Str_Cpy(m_szCobSel, szcmb);
				if( Str_Cmp(m_szCobSel, "��ü" ) == 0 )
					g_nWorkFlag = 200;
				else if( Str_Cmp(m_szCobSel, "����" ) == 0 )
					g_nWorkFlag = 206;
				else if( Str_Cmp(m_szCobSel, "������" ) == 0 )
					g_nWorkFlag = 207;
				else if( Str_Cmp(m_szCobSel, "�켱����" ) == 0 )
					g_nWorkFlag = 208;
					
				m_lpage = 0;
				m_lActIndex = 0;
				Cmb_Filter();
				REDRAW();
			}
			else
			{
				REDRAW();
			}
		}
*/
	}
	
//-----------------------------------------------------------------------------------------------
	void SetCombo(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			g_Sql_SetCombo("SELECT COUNTY FROM NORMAL_DATA WHERE COUNTY IS NOT NULL GROUP BY COUNTY", CMB_GOO+2);
			g_Sql_SetCombo("SELECT TOWN FROM NORMAL_DATA WHERE TOWN IS NOT NULL GROUP BY TOWN", CMB_DONG+2);
		}
		else
		{
			g_Sql_SetCombo("SELECT COUNTY FROM NORMAL_DATA WHERE COUNTY IS NOT NULL GROUP BY COUNTY", CMB_NWGOO+2);
			g_Sql_SetCombo("SELECT NEW_ROAD_NM FROM NORMAL_DATA WHERE NEW_ROAD_NM IS NOT NULL GROUP BY NEW_ROAD_NM", CMB_STREET+2);
		}
	}
	
//---------------------------------------------------------------------------------------
	void	OnButton(long ID)
	{
	long d, k;
	char szToday[11];
	char szDate[11];
	
		switch(ID)
		{
			case BID_ADDR:
				if( m_bFirst == INIT_NEW )
				{
					SaveInput();
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
			case BID_NADDR:
				if( m_bFirst == INIT_MAIN )
				{
					SaveInput();
					ON_EXIT();
					OnInit(INIT_NEW);
				}
				break;
			//�˻�ȭ��  ,, Barcode();
			case BID_SEARCH1:
			case BID_SEARCH2:
			case BID_SEARCH3:
			case BID_SEARCH4:
			case BID_SEARCH5:
			case BID_SEARCH6:
			case BID_SEARCH7:
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( Search_Addr(ID) == FALSE)
					break;

				if(FS_GetSrchTotCnt() == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�Է��� �ڷᰡ �����ϴ�.Ȯ���� �ּ���.");
					break;
				}

				g_nWorkFlag = 205;
				m_lpage = 0;
				SetSearch();
				Set_Index();
				Card_Move("SC_CONFIRM");
				break;
			case BID_BAR:
				Barcode();
				break;
			case GID_HOME:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
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
				if( g_Dlgflag > 0 )
				{
					return;
				}
				
				Card_Move("SC_MENU");
				break;	
			case GID_VMEXIT:
				ShowSip(FALSE);
				g_Sipflag = 0;

				g_Exit();
				break;
		}
	}

//-----------------------------------------------------------------------------------------------
	void	SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CSMNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CPTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OWNTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DONG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BUNJI), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_HOSOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CSMNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OBJNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BARNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CPTEL), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OWNTEL), EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BUNJI), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_HOSOO), EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DONG), EDITALIGN_MIDDLE);
			
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
		}
		else
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CSMNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OBJNUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CPTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_OWNTEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADDR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NWGOO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STREET), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BONBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BOOBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CSMNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OBJNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BARNUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_CPTEL), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_OWNTEL), EDITALIGN_MIDDLE);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BONBUN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_BOOBUN), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_NWGOO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_STREET), EDITALIGN_MIDDLE);
			
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );
		}
		
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
			{
				return i;
			}
		}
		return -1;
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
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '2' ", g_nActIndex, 0, 0);
		g_Sql_DirectExecute(szSql);
	}

	
//-------------------------------------------------------------------------------
	bool Search_Addr(long nbuttonid)
	{
		char szWhere[400];
		char szObj[400];
		char szSql[2][600];
		long chki= 0;
	
	  	Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
		Mem_Set( (byte*)szObj, 0x00, sizeof(szObj) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		
		if( nbuttonid == BID_SEARCH2 )
		{
			m_lBtnId = 1;
		
			Str_Cpy( szSql[1], "SELECT A.ROWID FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[0], "SELECT A.CHK_EXEC_NUM, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[1], "SELECT A.CHK_EXEC_NUM, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A INNER JOIN NORMAL_MTR B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
		}
		else
		{
			m_lBtnId = 2;
		
			Str_Cpy( szSql[0], "SELECT ROWID FROM NORMAL_DATA WHERE ");
			Str_Cpy( m_szSql[0], "SELECT A.CHK_EXEC_NUM, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY  CHK_EXEC_NUM ) B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
			Str_Cpy( m_szSql[1], "SELECT A.CHK_EXEC_NUM, (SELECT C.SEND_YN FROM NORMAL_ADDR C WHERE C.BLD_NUM = A.BLD_NUM) FROM NORMAL_DATA A LEFT OUTER JOIN ( SELECT CHK_EXEC_NUM, COUNT(*) AS CNT FROM NORMAL_VISIT GROUP BY  CHK_EXEC_NUM ) B ON A.CHK_EXEC_NUM = B.CHK_EXEC_NUM WHERE ");
		}

		
		if( nbuttonid == BID_SEARCH1 )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_CSMNUM)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ġ��� ��ȣ�� �Է��� �ּ���.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_CSMNUM) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "INST_PLACE_NUM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CSMNUM) ) );
				Str_Cat( szWhere, "' " );
				
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}
		else if( nbuttonid == BID_SEARCH2 )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OBJNUM)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "�⹰ ��ȣ�� �Է��� �ּ���.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OBJNUM)) > 0   ) 
			{
				Mem_Set( (byte*)szObj, 0x00, sizeof(szObj) );
				Str_Cat( szObj, "B.MTR_ID_NUM = '" );
				Str_Cat( szObj, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_OBJNUM) ) );
				Str_Cat( szObj, "' " );
				
				Str_Cat( szSql[1], szObj );
				Str_Cat( m_szSql[0], szObj );
				Str_Cat( m_szSql[1], szObj );
			}			
		}
		else if( nbuttonid == BID_SEARCH3)
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BARNUM)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "���ڵ带 �Է��� �ּ���.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BARNUM) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "BAR = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BARNUM) ) );
				Str_Cat( szWhere, "' " );
				
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}	
		}
		else if( nbuttonid == BID_SEARCH4)
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_CPTEL)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ȭ��ȣ�� �Է��� �ּ���.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_CPTEL) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "CP_DDD ||''|| CP_EXN ||''|| CP_NUM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_CPTEL) ) );
				Str_Cat( szWhere, "' " );
				
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}	
		}
		else if( nbuttonid == BID_SEARCH5)
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OWNTEL)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ȭ��ȣ�� �Է��� �ּ���.");
				return FALSE;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_OWNTEL) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "OWNHOUSE_TEL_DDD ||''|| OWNHOUSE_TEL_EXN ||''|| OWNHOUSE_TEL_NUM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_OWNTEL) ) );
				Str_Cat( szWhere, "' " );
				
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}	
		}
		else if( nbuttonid == BID_SEARCH6 )
		{	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BUNJI)) == 0   
        	)
			{
				MessageBoxEx (CONFIRM_OK, "������ �Է��� �ּ���.");
				return FALSE;
			}
			/*
			else if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_HOSOO)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "ȣ���� �Է��� �ּ���.");
				return FALSE;
			}
			*/
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_GOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "COUNTY = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_GOO) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}

			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DONG) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "TOWN = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DONG) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BUNJI) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "ADDR1_M = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BUNJI) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_HOSOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "ADDR1_S = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_HOSOO) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}
		else if( nbuttonid == BID_SEARCH7 )
		{	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BONBUN)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "������ �Է��� �ּ���.");
				return FALSE;
			}
			/*
			else if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BOOBUN)) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "�ι��� �Է��� �ּ���.");
				return FALSE;
			}
			*/
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_NWGOO) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				Str_Cat( szWhere, "COUNTY = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_NWGOO) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_STREET) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ROAD_NM = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_STREET) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
	
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BONBUN) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ADDR_M = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BONBUN) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
				chki++;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_BOOBUN) ) > 0   ) 
			{
				Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
				if(chki > 0)
					Str_Cat( szWhere, " AND " );
				Str_Cat( szWhere, "NEW_ADDR_S = '" );
				Str_Cat( szWhere, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BOOBUN) ) );
				Str_Cat( szWhere, "' " );
				Str_Cat( szSql[0], szWhere );
				Str_Cat( m_szSql[0], szWhere );
				Str_Cat( m_szSql[1], szWhere );
			}
		}

		if( nbuttonid == BID_SEARCH2 )
		{
			Str_Cat( szSql[1], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			Str_Cat( m_szSql[0], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			Str_Cat( m_szSql[1], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			g_Sql_SaveSeq( szSql[1], SREACH_FILE);
		}
		else
		{
			Str_Cat( szSql[0], "ORDER BY HOUSE_NUM_ORD, DONG_ORD");
			Str_Cat( m_szSql[0], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			Str_Cat( m_szSql[1], "ORDER BY A.HOUSE_NUM_ORD, A.DONG_ORD");
			g_Sql_SaveSeq( szSql[0], SREACH_FILE);
		}

		//�������� �ʱ�ȭ��Ų��.
		m_lpage = 0;
		
		return TRUE;
	}
		
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	void SetSearch(void)
	{
		long i, idx;
		long lRow;
		char sztmp[201];	
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		if( g_nAddrFlag == 0)
			hstmt = sql->CreateStatement(sql, m_szSql[0]);
		else
			hstmt = sql->CreateStatement(sql, m_szSql[1]);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{	
			//2016-05-24 Sanghyun Lee , �󼼸���Ʈ���� ȭ�� �и� �� Value ������ �κ� ����
			if( m_lBtnId == 1 )
			{	//�⹰��ȣ �˻�
				Mem_Set( (byte*)stSc.CHK_EXEC_NUM, 0x00, sizeof(stSc.CHK_EXEC_NUM) );
				sql->GetValue(sql, 0, 'U', (long*)stSc.CHK_EXEC_NUM, 12 + 1, DECRYPT);
				Str_Cpy(g_szCHK_EXEC_NUM, stSc.CHK_EXEC_NUM);
				
				Mem_Set( (byte*)stScAddr.SEND_YN, 0x00, sizeof(stScAddr.SEND_YN) );
				sql->GetValue(sql, 1, 'U', (long*)stScAddr.SEND_YN, 1 + 1, DECRYPT);
			}
			else
			{	//�⹰��ȣ�� ������ ������ �˻�
				Mem_Set( (byte*)stSc.CHK_EXEC_NUM, 0x00, sizeof(stSc.CHK_EXEC_NUM) );
				sql->GetValue(sql, 0, 'U', (long*)stSc.CHK_EXEC_NUM, 12 + 1, DECRYPT);
				Str_Cpy(g_szCHK_EXEC_NUM, stSc.CHK_EXEC_NUM);

				Mem_Set( (byte*)stScAddr.SEND_YN, 0x00, sizeof(stScAddr.SEND_YN) );
				sql->GetValue(sql, 1, 'U', (long*)stScAddr.SEND_YN, 1 + 1, DECRYPT);
			}

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ORDER BY HOUSE_NUM_ORD, DONG_ORD ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_RetInt( szSql, &lRow );

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
			g_Sql_SaveSeq( szSql, SREACH_FILE);

			g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		}
		
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		return;
	}
	
//-----------------------------------------------------------------------------------------------
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

//-----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char* ptr;
		long nRet = 0;
		
		if(nEvent == TASK_SYS_CALL && nData == TASK_BARCODE )
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

//-----------------------------------------------------------------------------------------------
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
		char szSql[300];
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

		if( Str_Len(m_szBarcode_Value) > 5 )
		{
			//���ڵ� ����
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			Mem_Cpy((byte *)szBar, (byte *)m_szBarcode_Value, 9);
			Str_Cpy(g_szCurrBar, m_szBarcode_Value);
			//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR1), m_szBarcode_Value ) ;

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_DATA WHERE BAR = '%s' ", m_szBarcode_Value, 0, 0);
			g_Sql_RetInt( szSql, &lCnt );

			if( lCnt > 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE BAR = '%s' ", m_szBarcode_Value, 0, 0);
				g_Sql_RetInt( szSql, &lRow );
				
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
				g_Sql_SaveSeq( szSql, SREACH_FILE);
	
				g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				Set_Index();
				
				RetFlag = 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "�Է��� �ڷᰡ �����ϴ�.Ȯ���� �ּ���.");
				Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				goto Finally;
			}

		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� ���̰� ���� �ʽ��ϴ�.");
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			goto Finally;
		}

Finally:
		
		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}
		
		if( RetFlag > 0 )
		{
			Card_Move("SC_CONFIRM");
		}

		ON_DRAW();
		return;
	}
	
	
//=======================================================================================
	void PDA_OnBarcodeRead(void)
	{
	char szSql[300];
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

		if( Str_Len(m_szBarcode_Value) > 5 )
		{
			//���ڵ� ����
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			Mem_Cpy((byte *)szBar, (byte *)m_szBarcode_Value, 9);
			Str_Cpy(g_szCurrBar, m_szBarcode_Value);
			//EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_ADDR1), m_szBarcode_Value ) ;

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_DATA WHERE BAR = '%s' ", m_szBarcode_Value, 0, 0);
			g_Sql_RetInt( szSql, &lCnt );

			if( lCnt > 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA WHERE BAR = '%s' ", m_szBarcode_Value, 0, 0);
				g_Sql_RetInt( szSql, &lRow );
				
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT ROWID FROM NORMAL_DATA ORDER BY HOUSE_NUM_ORD, DONG_ORD ", 0, 0, 0);
				g_Sql_SaveSeq( szSql, SREACH_FILE);
	
				g_nActIndex = g_Get_FsIndex(lRow, SREACH_FILE);
				g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
				Set_Index();
				
				RetFlag = 1;
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "�Է��� �ڷᰡ �����ϴ�.Ȯ���� �ּ���.");
				Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				goto Finally;
			}

		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� ���̰� ���� �ʽ��ϴ�.");
			Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			goto Finally;
		}

Finally:
		
		ON_DRAW();
		
		if( RetFlag > 0 )
		{
			Card_Move("SC_CONFIRM");
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
	
	
//-------------------------------------------------------------------------------------------
	void SaveInput(void)
	{
/*
	if( Get_iDlgCtrlByID(EDT_CSMNUM) == lActiveIndex ||
	    Get_iDlgCtrlByID(EDT_OBJNUM) == lActiveIndex ||
	    Get_iDlgCtrlByID(EDT_BARNUM) == lActiveIndex ||
	    Get_iDlgCtrlByID(EDT_CPTEL)  == lActiveIndex ||
	    Get_iDlgCtrlByID(EDT_OWNTEL) == lActiveIndex )	

	char m_szInstNum[11];
	char m_szMtrNum[11];
	char m_szBarNum[22];
	char m_szCpNum[15];
	char m_szHouseNum[15];
*/

		Mem_Set( (byte*)m_szInstNum, 0x00, sizeof(m_szInstNum) );
		Mem_Set( (byte*)m_szMtrNum, 0x00, sizeof(m_szMtrNum) );
		Mem_Set( (byte*)m_szBarNum, 0x00, sizeof(m_szBarNum) );
		Mem_Set( (byte*)m_szCpNum, 0x00, sizeof(m_szCpNum) );
		Mem_Set( (byte*)m_szHouseNum, 0x00, sizeof(m_szHouseNum) );
		
		Str_Cpy(m_szInstNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_CSMNUM)) );
		Str_Cpy(m_szMtrNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_OBJNUM)) );
		Str_Cpy(m_szBarNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_BARNUM)) );
		Str_Cpy(m_szCpNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_CPTEL)) );
		Str_Cpy(m_szHouseNum, EditCtrl_GetStr( Get_hDlgCtrlByID(EDT_OWNTEL)) );
	}
	
//-------------------------------------------------------------------------------------------
	void REDRAW(void)
	{
		if( Str_Len(m_szInstNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CSMNUM), m_szInstNum);
		}
		
		if( Str_Len(m_szMtrNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_OBJNUM), m_szMtrNum);
		}
		
		if( Str_Len(m_szBarNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_BARNUM), m_szBarNum);
		}
		
		if( Str_Len(m_szCpNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_CPTEL), m_szCpNum);
		}
		
		if( Str_Len(m_szHouseNum) > 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_OWNTEL), m_szHouseNum);
		}
	}
}



