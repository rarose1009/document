/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6202_VISIT
	Card Desc : ü�� �湮Ȱ��
	Card Hist :
----------------------------------------------------------------------------------*/
card C6202_VISIT
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
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )		//Ȩ
		DEF_BUTTON_ID ( BID_MENU )		//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	//�������
		DEF_BUTTON_ID ( BID_PREV )		//����
		DEF_BUTTON_ID ( BID_EXIT )		//����
		
		//ȭ�� ��ü
		DEF_BUTTON_ID ( BID_RCV )
		DEF_BUTTON_ID ( BID_SAVE )
		DEF_BUTTON_ID ( BID_PREVLST )
		DEF_BUTTON_ID ( BID_NEXTLST )
		DEF_BUTTON_ID ( BID_WRITE )
		DEF_BUTTON_ID ( BID_REFSCHDL )
		DEF_BUTTON_ID ( BID_STOPREQ )
		DEF_BUTTON_ID ( BID_TXTVIEW )
		DEF_BUTTON_ID ( BID_VIEW_CLOSE ) //�̷� ����
		DEF_BUTTON_ID ( BID_PHOTO )      //����
		DEF_BUTTON_ID ( BID_SMS )        //����
		DEF_BUTTON_ID ( BID_EXCEP_YN )   //HP üũ�ڽ�
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( ICON_TITLE )	//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_TITLE )
		
		DEF_OBJECT_ID ( TXT_BORDER )
		DEF_OBJECT_ID ( TXT_PAGE )
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

		DEF_OBJECT_ID ( EDT_DATA1 )
		DEF_OBJECT_ID ( EDT_DATA2 )
		DEF_OBJECT_ID ( EDT_DATA3 )
		DEF_OBJECT_ID ( EDT_DATA4 )
		
		DEF_OBJECT_ID ( ID_TBLLIST ) // ���̺� ����Ʈ
		
		DEF_OBJECT_ID ( CMB_DATA1 )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 ) // ������
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 ) // �湮
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 ) // ����1
		DEF_OBJECT_ID ( CMB_DATA5 = CMB_DATA4+3 ) // ����2
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    3						// table�� �ళ��
	#define		COL 	    8						// table�� ������
	#define		GRID_H		(CHT+15)				// table �� ����
	#define		GRID_H_P	(CHT+15)				// table �� ����
	#define		GRID_CLR	TRANSPARENT   			// table Ŭ���� color
	#define		GRID_X		STARTX 					// table ����x��ǥ
	#define		MAXCHAR		1200 			    	// table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+620  	    	// table ����y��ǥ
	#define		GRID_Y_P	STARTY+620  	        // table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR];     // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"����", 		  CWD*15,   EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����", 		  CWD*7,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����", 		  CWD*8+13, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ó����", 		  CWD*9+10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�̷³���", 	  CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����", 		  CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"VISIT_WHY_CD",  CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"VISIT_WHY_CD2", CWD*0,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	//---------------------------------------------------------------
	// ��� ��ư
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
	// struck �湮���
	//---------------------------------------------------------------
	typedef struct _VISITREG
	{
		char JOB_DTM[30];
		char NONPAY_ACTIVE_YMD[20];
		char NONPAY_ACTIVE_FLAG[50];
		char NONPAY_CENTER_CD[50];
		char TAKER_NM[50];
		char PDA_PUBSH_YN_1[10];
		char PDA_PUBSH_YN_2[10];
		char PDA_PUBSH_YN_3[10];
		char CUST_RELAT_CD[50];
		char ACTIVE_SUCCESS_YN[50];
		char VISIT_WHY_CD[50];
		char ACTIVE_RSLT_DESC[300];
	}	VISITREG;
	VISITREG m_stVisitReg;
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN 1
	#define INIT_VIEW 2
	// ��ư �ð� ����
	#define	BTN_START_TIME "090000"
	#define	BTN_END_TIME   "190000"
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	long m_bFirst;
	long m_lEditCtrlIndex = -1;
	long m_lActIndex = -1;
	long m_lTotCnt = 0;
	long m_lTotpage = 0;
	long m_lPage = 0;
	long m_lViewFlag = 0;		// m_lViewFlag = 0 default, = 1 �湮�̷� ȭ�� ��ȸ
	long m_lRcvFlag = 0;		// m_lRcvFlag = 0 default, = 1 �湮�̷� ����
	long m_lExcepFlag = 0;      // m_lExcepFlag = 0 CHKOFF, = 1 CHKON 
	long m_lStopReqFlag = 0;	// �����Ƿ� flag : 0 = ����, 1 = ����
	
	char m_szCnt_page[10];
	char m_szView[1200];
	char m_szVisitYn[10];
	char m_szPlanymd[30];
	char m_szfilenm[256];
	
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void SetCombo(void);
	void ReDraw(void);
	void VisitDraw(void);
	void SaveInput(void);
	void Shoto_Photo(void);
	long Rcv_Visit(void);
	long TR82226(void);
	long Snd_Visit(void);
	long TR82228(void);
	long Snd_Stop(void);
	long TR83201(void);
	long Snd_ExcepTel(char* flag);
	long TR84102(void);
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		// Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�湮���"),
		
		DLG_TEXT(  STARTX,     STARTY+65,   220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "HP"),
		DLG_TEXT(  STARTX+220, STARTY+65,   670,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_BUTTON(STARTX+890, STARTY+65,   110,  50, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TXTCTRLFRCOLOR, TXTINCTRLBK, CALL_FUNC , "", BID_EXCEP_YN, CHKOFF),
		
		DLG_TEXT(  STARTX,     STARTY+115,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "������"),
		DLG_COMBO( STARTX+220, STARTY+115,  350, 290, 110, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20), // ������
		
		DLG_TEXT(  STARTX+570, STARTY+115,  120,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�湮"),
		DLG_COMBO( STARTX+690, STARTY+115,  310, 290, 110, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 20), // �湮
		
		DLG_TEXT(  STARTX,     STARTY+165,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "����"),
		DLG_COMBO( STARTX+220, STARTY+165,  780, 290, 110, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 20), // ����1
		
		DLG_TEXT(  STARTX,     STARTY+215,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "�湮����"),
		DLG_TEXT(  STARTX+220, STARTY+215,  780,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		
		DLG_TEXT(  STARTX,     STARTY+265,  220,  85, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "�湮����"),
		DLG_BUTTON(STARTX+220, STARTY+265,  780,  85, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
		DLG_TEXT(  STARTX+220, STARTY+265,  780,  85, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, ""),
		
		// �����Ƿ� ��¥
		DLG_TEXT(  STARTX,     STARTY+350,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "�����Ƿ�"),
		
		DLG_EDIT(  STARTX+220, STARTY+350,  145,  50, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		DLG_TEXT(  STARTX+365, STARTY+350,   20,  20, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA11, ""),
		
		DLG_EDIT(  STARTX+385, STARTY+350,  100,  50, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_TEXT(  STARTX+485, STARTY+350,   20,  20, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, ""),
		
		DLG_EDIT(  STARTX+505, STARTY+350,  100,  50, 0, 0, EDITSTY_BOLD, 0, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 2,  ""),
		
		DLG_BUTTON(STARTX+605, STARTY+350,  150,  50, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL, "��"), // �����Ƿ� ��¥
		DLG_BUTTON(STARTX+755, STARTY+350,  245,  50, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOPREQ, "�����Ƿ�"),
		
		DLG_TEXT(  STARTX+365, STARTY+370,   20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, "."),
		DLG_TEXT(  STARTX+485, STARTY+370,   20,  30, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, "."),
		
		DLG_BUTTON(STARTX,     STARTY+405,  245,  60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "�̷¼���"),
		DLG_BUTTON(STARTX+255, STARTY+405,  240,  60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS, "����"),
		DLG_BUTTON(STARTX+505, STARTY+405,  240,  60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "����"),
		DLG_BUTTON(STARTX+755, STARTY+405,  245,  60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "�湮���"),

		DLG_BUTTON(STARTX,     STARTY+470, 1000, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TXTVIEW, ""), // �̷³���
		DLG_TEXT(  STARTX,     STARTY+470, 1000, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		
		DLG_TEXT(  STARTX,     STARTY+570,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "����"),
		DLG_COMBO( STARTX+220, STARTY+570,  780, 290, 110, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 20), // ����2
		
		//����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_TEXT(  STARTX,     STARTY+840,  500,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, m_szCnt_page), // ����Ʈ ī����
		DLG_BUTTON(STARTX+500, STARTY+840,  250,  59, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750, STARTY+840,  250,  59, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),	
	};	
	
	//---------------------------------------------------------------
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�湮���"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY+370, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "�̷¼���"),
		DLG_BUTTON(STARTX+600,  STARTY+370, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "�湮���"),
		DLG_BUTTON(STARTX+500,  STARTY+835, 250, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST, "��"),
		DLG_BUTTON(STARTX+750,  STARTY+835, 250, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST, "��"),

		DLG_TEXT(STARTX,        STARTY-40, 220, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "������"),
		DLG_TEXT(STARTX+570,    STARTY-40, 120, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�湮"),
		DLG_TEXT(STARTX,        STARTY+30, 220, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "����"),
		DLG_TEXT(STARTX,       STARTY+100, 220, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, "�湮����"),
		DLG_TEXT(STARTX+220,   STARTY+100, 780, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(STARTX,       STARTY+170, 220, 120, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, "�湮����"),
		DLG_EDIT(STARTX+220,   STARTY+170, 780, 120, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 300,  ""),
//		DLG_BUTTON( STARTX+220,   STARTY+220, 765, 100, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
//		DLG_TEXT(STARTX+220,   STARTY+220, 765, 100, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, ""),
		
		DLG_TEXT(STARTX,        STARTY+290, 220, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "�����Ƿ�"),
		DLG_EDIT(STARTX+220,    STARTY+290, 130, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		DLG_TEXT(STARTX+350,    STARTY+290,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+350,    STARTY+330,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA12, "."),
		DLG_EDIT(STARTX+370,    STARTY+290,  90, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 2,  ""),
		DLG_TEXT(STARTX+460,    STARTY+290,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX+460,    STARTY+330,  20, 40, 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA14, "."),
		DLG_EDIT(STARTX+480,    STARTY+290,  90, 80, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 2,  ""),
		DLG_BUTTON(STARTX+570,	STARTY+290, 150, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_REFSCHDL, "��"),
		DLG_BUTTON(STARTX+720,	STARTY+290, 280, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOPREQ, "�����Ƿ�"),

		DLG_BUTTON(STARTX,     STARTY+440, 1000, 120, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TXTVIEW, ""),
		DLG_TEXT(STARTX,       STARTY+440, 1000, 120, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(STARTX,       STARTY+560, 220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "����"),
		DLG_TEXT(STARTX,       STARTY+835, 400, 64, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, m_szCnt_page),
		
		//����Ʈ
		DLG_TABLE (GRID_X, GRID_Y_P, ROW, COL, 0, GRID_H_P, 1, GRID_H_P-10, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_COMBO(STARTX+220,  STARTY-40, 350, 290, 110, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),
		DLG_COMBO(STARTX+690,  STARTY-40, 310, 290, 110, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 20),
		DLG_COMBO(STARTX+220,  STARTY+30, 780, 290, 110, 70, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 20),
		DLG_COMBO(STARTX+220, STARTY+560, 780, 290, 110, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 20),
	};		
	
	//---------------------------------------------------------------
	// �̷»󼼳���
	//---------------------------------------------------------------
	DlgObject	DlgRes_View[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�̷³���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_VIEW_CLOSE, ""),

		DLG_BUTTON(STARTX+600,   STARTY+580, 829, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEW_CLOSE, "�ݱ�"),

		DLG_TEXT(STARTX,     STARTY-29, 1000, 800, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
	};	
	
	//---------------------------------------------------------------
	// PDA �̷»󼼳���
	//---------------------------------------------------------------
	DlgObject	DlgRes_View_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�̷³���"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_VIEW_CLOSE, ""),

		DLG_BUTTON(STARTX+600,   STARTY+580, 829, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIEW_CLOSE, "�ݱ�"),

		DLG_TEXT(STARTX,     STARTY-29, 1000, 800, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
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
		long lCnt;
		
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
				ReDraw();
				
				if( m_lViewFlag == 1 )
				{
					m_lViewFlag = 0;
					VisitDraw();
				}
				
				break;
				
			case INIT_VIEW:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_View_P, SIZEOF(DlgRes_View_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_View, SIZEOF(DlgRes_View));
						break;		
				}

				SetBtnImg();	
				m_lViewFlag = 1;
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_TOP);
				EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA15), TRUE, 2, EDITSEP_NONE );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), m_szView );
				
				break;
		}
	}

	/*=======================================================================================
	�Լ��� : OnButton
	��  �� : ��ư �̺�Ʈ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		long d, k;
		char sztmp[15];
		char szToday[15];
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		
		if( g_ChkDay() )
		{
			return;
		}
			
		switch(ID)
		{
			case BID_REFSCHDL:
				Mem_Set((byte*)szDate, 0x00, sizeof(szDate));		
				Str_Cpy(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
				Str_Cat(szDate, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
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
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
					Str_ItoA ( d, sztmp, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)sztmp, 4);
					Mem_Cpy((byte *)szMonth, (byte *)sztmp+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)sztmp+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szDay );					
				}
				
				break;
				
			case BID_STOPREQ:
				if( g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
				{
					Snd_Stop();
				}
				
				break;
				
			case BID_WRITE:
				if( g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
				{
					g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				}
				
				break;
				
			case BID_RCV:
				Rcv_Visit();
				
				break;
				
			case BID_SAVE:
			
				if( g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
				{
					Snd_Visit();
				}
				
				break;
				
			case BID_PREVLST:
				m_lPage--;
				if(m_lPage < 0)
				{
					m_lPage = 0;
					
					break;
				}
				
				m_lActIndex = 0;
				VisitDraw();
				
				break;
							
			case BID_NEXTLST:
				m_lPage++ ;
				if( m_lPage > m_lTotpage-1 )
				{
					m_lPage = m_lTotpage-1;
					if(m_lPage < 0)
					{
						m_lPage = 0;
					}
					
					break;
				}
				
				m_lActIndex = 0;
				VisitDraw();
				
				break;
				
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "ü�� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("C6202_MENU");
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
				Card_Move("C6202_NPACTIVE");
				
				break;
				
			case GID_VMEXIT:
				g_Exit();
				
				break;
				
			case BID_TXTVIEW:
				if( m_lRcvFlag == 1 )
				{
					SaveInput();
					ON_EXIT();
					OnInit(INIT_VIEW);
				}
				
				break;
				
			case BID_VIEW_CLOSE:
				ON_EXIT();
				
				OnInit(INIT_MAIN);
				
				break;
				
			case BID_PHOTO:
				Shoto_Photo();
				
				break;
				
			case BID_SMS:
				if( g_Chk_Time( BTN_START_TIME, BTN_END_TIME ) )
				{
					Card_Move("C6202_SMS");
				}
			    
			    break;
			    
			case BID_EXCEP_YN:
				// ���� -> ���
				if( m_lExcepFlag == 0 )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "����Ͻðڽ��ϱ�?")  == MB_OK)
					{
						Snd_ExcepTel("0");	
					}
				}
				// ��� -> ����
				else
				{
					if( MessageBoxEx (CONFIRM_YESNO, "�����Ͻðڽ��ϱ�?")  == MB_OK)
					{
						Snd_ExcepTel("1");	
					}	
				}
				
				break;
		}
	}		

	/*=======================================================================================
	�Լ��� : OnChar
	��  �� : ���ڸ� �Է� && ��¥ ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar(long nChar)
	{
		long nRet = 0;
		long nDate = 0;
		char szTmp[10];
		char szDate[10];

		/********************************************/
		/* ���ڸ� �Է� ����                         */
		/********************************************/
		if( (Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex 
	 	  || Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex
		  || Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex )
		  && (nChar < 48 ||  nChar > 57) )
		{
			MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
			ON_KEY( 5 );
			return;
		}
		
		/********************************************/
		/* �����Ƿ����� ���� üũ                   */
		/********************************************/
		// 1. �⵵
		if( Get_iDlgCtrlByID(EDT_DATA2) == m_lEditCtrlIndex )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) == 4 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		// 2. ��
		else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lEditCtrlIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 1);
			if( Str_AtoI(szTmp) > 1 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
			{
				ON_KEY( 5 );
				return;
			}
			
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA3)) == 2 )
			{
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		// 3. ��
		else if( Get_iDlgCtrlByID(EDT_DATA4) == m_lEditCtrlIndex )
		{
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)), 1);
			if( Str_AtoI(szTmp) > 3 )
			{
				ON_KEY( 5 );
				return;
			}
			
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)), 2);
			if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
			{
				ON_KEY( 5 );
				return;
			}
		}
		
		/********************************************/
		/* �����Ƿ����� ���� ����                   */
		/********************************************/
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		
		if( Str_Len(szTmp) == 8 )
		{
			Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
			nDate = Str_AtoI(szTmp);
			nRet = Time_ValidateDate(nDate);
			
			if( nRet == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ȿ�� ��¥�� �ƴմϴ�.\n��¥�� Ȯ�����ּ���.");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
				
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2));
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}

		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : OnPointing
	��  �� : ȭ�� ������ �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		// EDITCTRL�� ACTIVE�ÿ� CTRLINDEX�� ����
		// Ű���� BUTTONCTRL�� ACTIVE�ÿ��� EDITCTRL�� Ŀ���� �α����ؼ� INDEX�� ����
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( POINTING_UP == nAction )
		{
			m_lEditCtrlIndex = lActiveIndex;
			
			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+485) && Y > DMS_Y(STARTY+320) && Y < DMS_Y(STARTY+370) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+505) && X < DMS_X(STARTX+655) && Y > DMS_Y(STARTY+320) && Y < DMS_Y(STARTY+370) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex )	
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
						
						ShowSip(TRUE);
						g_Sipflag = 1;
					}
				}
				else if( X > DMS_X(STARTX+675) && X < DMS_X(STARTX+825) && Y > DMS_Y(STARTY+320) && Y < DMS_Y(STARTY+370) )
				{
					if( Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex )	
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
	
	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : �޺��ڽ�. �׸��� Ŭ�� �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long index;
		char szSql[500];
		char szTmp[50];
		
		/*******************************************************************/
		/* �湮���� �޺��ڽ�, ��/�ƴϿ��� ���� ���� �޺��ڽ� �Ӽ��� �޶��� */
		/*******************************************************************/
		if( Str_Cmp(m_szVisitYn, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) != 0 )
		{
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "��") == 0 )
			{
				Mem_Set( (byte*)m_szVisitYn, 0x00, sizeof(m_szVisitYn) );
				Str_Cpy(m_szVisitYn, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)));
				
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DATA3+2 ) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20371' ", CMB_DATA3+2);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA3), "" );
			}
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), "�ƴϿ�") == 0 )
			{
				Mem_Set( (byte*)m_szVisitYn, 0x00, sizeof(m_szVisitYn) );
				Str_Cpy(m_szVisitYn, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)));
				
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DATA3+2 ) );
				g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20372' ", CMB_DATA3+2);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA3), "" );
			}
		}
		
		/****************************************/
		/* �湮�̷� �׸���                      */
		/****************************************/
		if (DlgTbl_IsSelect(ID_TBLLIST))
		{
			// ���� ���õ� �ε���
			index = DlgTbl_GetActiveRow(ID_TBLLIST);
			m_lActIndex = index - 1;
			
			// �湮 �� �̷�
			Mem_Set( (byte*)m_szView, 0x00, sizeof(m_szView) );
			Str_Cpy(m_szView, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), m_szView );
			
			// ����2
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 1), "Y") == 0 )
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20371' AND CODE_ITEM = '%s'", DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5), 0, 0 );
			}
			else
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20372' AND CODE_ITEM = '%s'", DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5), 0, 0 );
			}
			g_Sql_RetStr(szSql, 50, szTmp);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA4), szTmp);
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
		void* h;

		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
						
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
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(EDT_DATA1), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA9), TRUE, 2, EDITSEP_NONE );
		
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), TRUE );
	}
	
	/*=======================================================================================
	�Լ��� : SetCombo
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/	
	void SetCombo(void)
	{
		char szSql[500];

		//������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C10004' ", CMB_DATA1+2);

		//�湮
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10200'", CMB_DATA2+2);

		return;
	}
	
	/*=======================================================================================
	�Լ��� : ReDraw
	��  �� : ȭ���� �ٽ� �׸���.
	Param  : 
	Return : 
	========================================================================================*/
	void ReDraw(void)
	{
		char szSql[200];
		char szTmp[50];
		char szDate[30];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szDirPath[100];
		char szScrPht[128];
		char szToday[10];
		long nRet;
		
		/********************************************/
		/* HP                                       */
		/********************************************/ 
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stNoPayObj.CP_DDD);
		Str_Cat(szTmp, "-");
		Str_Cat(szTmp, stNoPayObj.CP_EXN);
		Str_Cat(szTmp, "-");
		Str_Cat(szTmp, stNoPayObj.CP_NUM);
		
		// HP��ȣ�� �ִٸ� ǥ������
		if(Str_Len(szTmp) > 2)
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17), szTmp );
		}
		// HP��ȣ�� ���ٸ� ǥ������ ����
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17), "" );
		}
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, stNoPayObj.CP_DDD);
		Str_Cat(szTmp, stNoPayObj.CP_EXN);
		Str_Cat(szTmp, stNoPayObj.CP_NUM);
		
		// HP��ȣ�� 10�ڸ� �̻��ΰ�� �޺��ڽ� ENABLE
		if(Str_Len(szTmp) > 9)
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_EXCEP_YN), TRUE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_EXCEP_YN), FALSE );
		}
		// HP��ȣ�� 10�ڸ� ������ ��� �޺��ڽ� DISABLE
		else
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_EXCEP_YN), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_EXCEP_YN), TRUE );
		}
		
		/********************************************/
		/* Excep_TEL &&  BID_SMS                    */
		/********************************************/
		if( Str_Cmp(stNoPayObj.EXCEP_TEL_YN, "Y") == 0 )
		{
			m_lExcepFlag = 1;
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_EXCEP_YN), CHKON);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_EXCEP_YN), RED);
				
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );
		}
		else
		{
			m_lExcepFlag = 0;
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_EXCEP_YN), CHKOFF);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_EXCEP_YN), BLACK);
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
		}
		
		/********************************************/
		/* �湮����                                 */
		/********************************************/
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_ItoA(Time_GetDate(), szTmp, 10);
		
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		g_Str_DateType( szDate, szTmp);
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA5), szDate );
		
		/*********************************************************/
		/* �����Ƿ� ����, �̷� ��ȸ �� ����� ��¥�� �ִٸ� ǥ�� */
		/*********************************************************/
		if( Str_Len(m_szPlanymd) > 7)
		{
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, m_szPlanymd);
		}
		
		Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
		Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
		Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
		Mem_Cpy((byte *)szYear, (byte *)szTmp, 4);
		Mem_Cpy((byte *)szMonth, (byte *)szTmp+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)szTmp+6, 2);

		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA2), szYear );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szMonth );
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szDay );
		
		/********************************************/
		/* ���� ������ Ȯ��                         */
		/********************************************/
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szScrPht, 0x00, sizeof(szScrPht));
		Mem_Set((byte *)szToday, 0x00, sizeof(szToday));
		Str_ItoA(Time_GetDate(), szToday, 10);
		
		Str_Cpy( szDirPath, PHOTO_NP );
		Str_Cpy( szTmp, stNoPayObj.USE_CONT_NUM );
		Str_Cat( szTmp, "_" );
		Str_Cat( szTmp, szToday );
		Str_Cat( szTmp, "*" );
		Str_Cat( szTmp, "_V.jpg" );
		
		nRet = g_FindFiles( szDirPath, szTmp , szScrPht);
		
		if(nRet > 0)
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
		}
		
		/********************************************/
		/* �̷� ��ȸ �� ȭ�� ���� ǥ��              */
		/********************************************/
		if( m_lViewFlag == 1 )
		{
			// ������ �ڵ�
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C10004' AND CODE_ITEM = '%s'", m_stVisitReg.CUST_RELAT_CD, 0, 0 );
			g_Sql_RetStr(szSql, 10, szTmp);
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA1), szTmp);
	
			// �湮����
			Mem_Set( (byte*) szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10200' AND CODE_ITEM = '%s'", m_stVisitReg.ACTIVE_SUCCESS_YN, 0, 0 );
			g_Sql_RetStr(szSql, 10, szTmp);
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), szTmp);
	
			// ����
			Mem_Set( (byte*) szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			if( Str_Cmp(m_stVisitReg.ACTIVE_SUCCESS_YN, "Y") == 0 )
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20371' AND CODE_ITEM = '%s' ", m_stVisitReg.VISIT_WHY_CD, 0, 0 );
			}
			else
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20372' AND CODE_ITEM = '%s' ", m_stVisitReg.VISIT_WHY_CD, 0, 0 );
			}
			g_Sql_RetStr(szSql, 10, szTmp);
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), szTmp);
	
			// �湮����
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), m_stVisitReg.ACTIVE_RSLT_DESC);
		}
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : VisitDraw
	��  �� : �湮�̷� Draw
	Param  : 
	Return : 
	========================================================================================*/
	void VisitDraw(void)
	{
		long i, idx;
		long k = ROW + 1;
		long ret = -1;	
		long lstartidx;
		
		char sztmp[1200];
		char szDate[50];
		char szSql[300];
		char szWhy[50];
		char szVisitWhyCd[5];
		char szVisitWhyCd2[5];
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		// ������
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lTotpage );

		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT(m_szCnt_page, "%d/%d", m_lPage+1, m_lTotpage, 0);
		
		// �׸��� setting
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, " SELECT PARAM1, PARAM2, PARAM3, PARAM4, PARAM102, PARAM5 FROM RCV_TMP LIMIT ?, ? ");
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lPage*ROW;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lPage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW ; i++)
		{
			// �ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
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
					continue;
				}
				
				idx = 0;
				
				// ����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				g_Str_DateType( szDate, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, szDate );
				
				// ����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				
				// ����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				// ó����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				// �̷³���
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 490, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				
				// ����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
			
				// VISIT_WHY_CD
				Mem_Set( (byte*)szVisitWhyCd, 0x00, sizeof(szVisitWhyCd) );
				sql->GetValue(sql, idx++, 'U', (long*)szVisitWhyCd, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, szVisitWhyCd );
				
				// VISIT_WHY_CD2
				Mem_Set( (byte*)szVisitWhyCd2, 0x00, sizeof(szVisitWhyCd2) );
				sql->GetValue(sql, idx++, 'U', (long*)szVisitWhyCd2, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 7, szVisitWhyCd2 );
				
				if( Str_Cmp(szVisitWhyCd, "82") == 0 || Str_Cmp(szVisitWhyCd, "60") == 0 ||
				    Str_Cmp(szVisitWhyCd2, "82") == 0 || Str_Cmp(szVisitWhyCd2, "60") == 0 )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 0 ), RED );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 1 ), RED );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 2 ), RED );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 3 ), RED );
				}
				else
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 0 ), TXTCTRLFRCOLOR );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 1 ), TXTCTRLFRCOLOR );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 2 ), TXTCTRLFRCOLOR );
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 3 ), TXTCTRLFRCOLOR );
				}
			}
		}		

Finally:
		
		if(m_lTotpage > 0)
		{
			if( m_lActIndex == -1 )
			{
				m_lActIndex = 0;
			}

			DlgTbl_SetActive(ID_TBLLIST , m_lActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActIndex+1, TABLEACTIVE_COLOR);
			
			Mem_Set( (byte*)m_szView, 0x00, sizeof(m_szView) );
			Str_Cpy(m_szView, DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 4));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9), m_szView );
		
			Mem_Set( (byte*)szWhy, 0x00, sizeof(szWhy) );
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			if( Str_Cmp(DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 1), "Y") == 0 )
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20371' AND CODE_ITEM = '%s'", DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5), 0, 0 );
			}
			else
			{
				SPRINT( szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C20372' AND CODE_ITEM = '%s'", DlgTbl_GetStr( ID_TBLLIST, m_lActIndex, 5), 0, 0 );
			}
			g_Sql_RetStr(szSql, 50, szWhy);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA4), szWhy);
		}
		
		DelSqLite(sql);
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_Visit
	��  �� : FR82226, �湮�̷� ����
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_Visit(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82226, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stNoPayObj.USE_CONT_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82226;
		ret = HTTP_DownloadData(szUrl, "FR82226_IN",  "FR82226" , sndbuf, sztmp );
		
		return 0 ;
	}
	
	/*=======================================================================================
	�Լ��� : TR82226
	��  �� : FR82226 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR82226(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82226) >= 0)
		{
			m_lRcvFlag = 1;
			VisitDraw();
			ON_DRAW();
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Visit
	��  �� : FR82228, �湮�̷� ���
	Param  : 
	Return : 
	========================================================================================*/
	long Snd_Visit(void)
	{
		char szSql[500];
		char szUrl[200];
		char szbuf[128];
		char szActive_rslt_desc[350];
		char szTime[50];
		char szTmp[100];
		char* sndbuf;	
		char szDirPath[100];
		char szScrPht[128];
		char szToday[10];
		
		long nRet = 0;
		long ret = 0;
		long nLen = 0;
		
		/********************************************/
		/* �⺻ Validation                          */
		/********************************************/
		if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA1)) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "���踦 �����ϼ���.");
			return -1;
		}
		
		if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA2)) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "�湮 �������θ� �����ϼ���.");
			return -1;
		}
		
		if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_DATA3)) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "������ �����ϼ���.");
			return -1;
		}
		
		/********************************************/
		/* ���� Validation                          */
		/********************************************/
		if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1) ), "��Ÿ" ) == 0 
	 	 && Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2) ), "�ƴϿ�" ) == 0 
		 && Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3) ), "����" ) == 0 )
		{	
			Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szScrPht, 0x00, sizeof(szScrPht));
			Mem_Set((byte *)szToday, 0x00, sizeof(szToday));
			Str_ItoA(Time_GetDate(), szToday, 10);
			
			Str_Cpy( szDirPath, PHOTO_NP );
			Str_Cpy( szTmp, stNoPayObj.USE_CONT_NUM );
			Str_Cat( szTmp, "_" );
			Str_Cat( szTmp, szToday );
			Str_Cat( szTmp, "*" );
			Str_Cat( szTmp, "_V.jpg" );
			
			nRet = g_FindFiles( szDirPath, szTmp , szScrPht);
			
			if(nRet <= 0)
			{
				MessageBoxEx(CONFIRM_OK, "������ ���� �Կ��ϼ���.");
				return -1;
			}
		}
		
		/********************************************/
		/* �����Ƿ� Validation                      */
		/********************************************/
		if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1) ), "��Ÿ" ) == 0 
	 	 && Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2) ), "�ƴϿ�" ) == 0 
		 && Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3) ), "����" ) == 0 )
		{	
			if( m_lStopReqFlag != 1)
			{
				MessageBoxEx (CONFIRM_OK, "[�ʼ�����]\n�����Ƿ� ����");
				return -1;
			}
		}
		
		/********************************************/
		/* �湮���� ���� Validation                 */
		/********************************************/
		Mem_Set((byte*)&m_stVisitReg, 0x00, sizeof(m_stVisitReg));
		Mem_Set( (byte*)szActive_rslt_desc, 0x00, sizeof(szActive_rslt_desc) );
		Mem_Set( (byte*)szTime, 0x00, sizeof(szTime) );
		
		Str_Cpy( szActive_rslt_desc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		nLen = g_GetUtf8Size(szActive_rslt_desc);
		if( nLen > 300 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "�������!\n(�湮������ �ѱ� 100��,\n����.���� 300�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szSql);
			return -1;
		}
		
		if( MessageBoxEx (CONFIRM_YESNO, "�湮���� ��� �Ͻðڽ��ϱ�?")  != MB_OK)
		{
			return -1;
		}

		SQL_ConvUcStr( m_stVisitReg.ACTIVE_RSLT_DESC, szActive_rslt_desc );
		
		Str_ItoA(Time_GetDate(), m_stVisitReg.JOB_DTM, 10);
		g_Str_TimeType( szTime , Time_GetTime());
		Str_Chg(szTime, STRCHG_DEL_NONDIGIT);
		Str_Cat(m_stVisitReg.JOB_DTM, szTime);
		Str_Chg(m_stVisitReg.JOB_DTM, STRCHG_DEL_NONDIGIT);
		
		Str_ItoA(Time_GetDate(), m_stVisitReg.NONPAY_ACTIVE_YMD, 10);
		Str_Chg(m_stVisitReg.NONPAY_ACTIVE_YMD, STRCHG_DEL_NONDIGIT);
		Str_Cpy(m_stVisitReg.NONPAY_ACTIVE_FLAG, "240");
		Str_Cpy(m_stVisitReg.NONPAY_CENTER_CD, stUserinfo.szcenter_cd);
		SQL_ConvUcStr( m_stVisitReg.TAKER_NM, stUserinfo.sznm_kor );
		Str_Cpy(m_stVisitReg.PDA_PUBSH_YN_1, "N");
		Str_Cpy(m_stVisitReg.PDA_PUBSH_YN_2, "N");
		Str_Cpy(m_stVisitReg.PDA_PUBSH_YN_3, "N");
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), 0, 0 );
		g_Sql_RetStr(szSql, 10, m_stVisitReg.CUST_RELAT_CD);
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'A10200' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), 0, 0 );
		g_Sql_RetStr(szSql, 10, m_stVisitReg.ACTIVE_SUCCESS_YN);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		if( Str_Cmp(m_stVisitReg.ACTIVE_SUCCESS_YN, "Y") == 0 )
		{
			SPRINT( szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C20371' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), 0, 0 );
		}
		else
		{
			SPRINT( szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C20372' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), 0, 0 );
		}
		g_Sql_RetStr(szSql, 10, m_stVisitReg.VISIT_WHY_CD);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82228, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "job_dtm",                  m_stVisitReg.JOB_DTM                );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",             stNoPayObj.USE_CONT_NUM             );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_ymd",        m_stVisitReg.NONPAY_ACTIVE_YMD      );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_flag",       m_stVisitReg.NONPAY_ACTIVE_FLAG     );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_active_dept",       stNoPayObj.NONPAY_ACTIVE_DEPT       );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone",       stNoPayObj.NONPAY_MANAGE_ZONE       );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_center_cd",         m_stVisitReg.NONPAY_CENTER_CD       );
		JSON_SetValue( g_pjcomm, 'C', "taker_nm",                 m_stVisitReg.TAKER_NM               );
		JSON_SetValue( g_pjcomm, 'C', "pda_pubsh_yn_1",           m_stVisitReg.PDA_PUBSH_YN_1         );
		JSON_SetValue( g_pjcomm, 'C', "pda_pubsh_yn_2",           m_stVisitReg.PDA_PUBSH_YN_2         );
		JSON_SetValue( g_pjcomm, 'C', "pda_pubsh_yn_3",           m_stVisitReg.PDA_PUBSH_YN_3         );
		JSON_SetValue( g_pjcomm, 'C', "cust_relat_cd",            m_stVisitReg.CUST_RELAT_CD          );
		JSON_SetValue( g_pjcomm, 'C', "active_success_yn",        m_stVisitReg.ACTIVE_SUCCESS_YN      );
		JSON_SetValue( g_pjcomm, 'C', "visit_why_cd",             m_stVisitReg.VISIT_WHY_CD           );
		JSON_SetValue( g_pjcomm, 'C', "active_rslt_desc",         m_stVisitReg.ACTIVE_RSLT_DESC       );
				
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR82228;
		
		HTTP_DownloadData( szUrl, "FR82228_IN",  "FR82228" , sndbuf, szbuf );
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : TR82228
	��  �� : FR82228 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR82228(void)
	{
		char szSql[350];
	
		if(g_Chk_Json(82228) >= 0)
		{
			// g_nWorkFlag = 830 > ����Ȱ��
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));	
			if( g_nWorkFlag == 830 )
			{
				SPRINT(szSql, "UPDATE C6202_STOP_OBJ SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			else if( g_nWorkFlag == 810 )
			{
				// ����Ȱ�� ���
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ_PART SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}
			else
			{
				SPRINT(szSql, "UPDATE C6202_NOPAY_OBJ SET VISIT_FLAG = 'Y' WHERE USE_CONT_NUM = '%s'", stNoPayObj.USE_CONT_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
			}

			Str_Cpy(stNoPayObj.VISIT_FLAG, "Y");
			MessageBoxEx (CONFIRM_OK, "�湮���� ��� �Ǿ����ϴ�.");
			Card_Move("C6202_NPACTIVE");
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
	
	/*=======================================================================================
	�Լ��� : Snd_Stop
	��  �� : FR83201, �����Ƿ�
	Param  : 
	Return : 
	========================================================================================*/
	long Snd_Stop(void)
	{
		char szMsg[500];
		char szUrl[200];
		char szbuf[128];
		char szPlanymd[30];
		char szCustnm[50];
		char szReqnm[50];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		
		/********************************************/
		/* �����Ƿ� ��¥ Validation                 */
		/********************************************/
		if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA2)) == 0 ||
		    EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA3)) == 0 ||
		    EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4)) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "�����Ƿ� ��¥�� �Է����ּ���.");
			return -1;
		}
		
		/********************************************/
		/* �����Ƿ� Ȯ��                            */
		/********************************************/
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		SPRINT(szMsg, "[%s��%s��%s��]��\n�����Ƿ� �Ͻðڽ��ϱ�?", EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		if( MessageBoxEx (CONFIRM_YESNO, szMsg)  != MB_OK)
		{
			return -1;
		}
		
		/********************************************/
		/* �����Ƿ� ���� Param Setting              */
		/********************************************/
		Mem_Set( (byte*)szPlanymd, 0x00, sizeof(szPlanymd) );
		Str_Cpy(szPlanymd, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(szPlanymd, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cat(szPlanymd, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Chg(szPlanymd, STRCHG_DEL_NONDIGIT);

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 83201, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stNoPayObj.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "plan_ymd", szPlanymd                   );

		Mem_Set( (byte*)szCustnm, 0x00, sizeof(szCustnm) );
		SQL_ConvUcStr( szCustnm, stNoPayObj.CUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm", szCustnm                     );

		JSON_SetValue( g_pjcomm, 'C', "tel_ddd", stNoPayObj.OWNHOUSE_TEL_DDD  );
		JSON_SetValue( g_pjcomm, 'C', "tel_exn", stNoPayObj.OWNHOUSE_TEL_EXN  );
		JSON_SetValue( g_pjcomm, 'C', "tel_num", stNoPayObj.OWNHOUSE_TEL_NUM  );
		
		Mem_Set( (byte*)szReqnm, 0x00, sizeof(szReqnm) );
		SQL_ConvUcStr( szReqnm, stUserinfo.sznm_kor );
		JSON_SetValue( g_pjcomm, 'C', "req_nm", szReqnm                       );
		
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd", stNoPayObj.CP_DDD             );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn", stNoPayObj.CP_EXN             );
		JSON_SetValue( g_pjcomm, 'C', "cp_num", stNoPayObj.CP_NUM             );
		JSON_SetValue( g_pjcomm, 'C', "branch_cd", stUserinfo.szbranch_cd     );
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd     );
				
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR83201; //��ſϷ� �Ŀ� ȣ�� �Լ�
		HTTP_DownloadData( szUrl, "FR83201_IN",  "FR83201" , sndbuf, szbuf );
		return 1;
	}

	/*=======================================================================================
	�Լ��� : TR83201
	��  �� : FR83201 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR83201(void)
	{
		char szSql[350];
	
		if(g_Chk_Json(83201) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "�����Ƿ� ���� ����");
			
			m_lStopReqFlag = 1;
			
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_STOPREQ), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_STOPREQ), BTNMENUFRCOLOR);
			
			ON_DRAW();
			return 1;
		}
		else
		{
			m_lStopReqFlag = 0;
			
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

	/*=======================================================================================
	�Լ��� : SaveInput
	��  �� : �ӽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void SaveInput(void)
	{
		char szSql[500];

		Mem_Set((byte*)&m_stVisitReg, 0x00, sizeof(m_stVisitReg));
	
		// ������ �ڵ�
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), 0, 0 );
		g_Sql_RetStr(szSql, 10, m_stVisitReg.CUST_RELAT_CD);
		
		// �湮����
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'A10200' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)), 0, 0 );
		g_Sql_RetStr(szSql, 10, m_stVisitReg.ACTIVE_SUCCESS_YN);
		
		// ����
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		if( Str_Cmp(m_stVisitReg.ACTIVE_SUCCESS_YN, "Y") == 0 )
		{
			SPRINT( szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C20371' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), 0, 0 );
		}
		else
		{
			SPRINT( szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C20372' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), 0, 0 );
		}
		g_Sql_RetStr(szSql, 10, m_stVisitReg.VISIT_WHY_CD);
		
		// �湮����
		Str_Cpy( m_stVisitReg.ACTIVE_RSLT_DESC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		
		// �����Ƿ� ��¥
		Mem_Set( (byte*)m_szPlanymd, 0x00, sizeof(m_szPlanymd) );
		Str_Cpy(m_szPlanymd, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		Str_Cat(m_szPlanymd, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cat(m_szPlanymd, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Chg(m_szPlanymd, STRCHG_DEL_NONDIGIT);
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : OnTask
	��  �� : �����Կ�, ��� X
	Param  : 
	Return : 
	========================================================================================*/
	void OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;

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

					Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
					SPRINT (g_szphoto, "%s/%s", PHOTO_NP,  m_szfilenm, 0);
				}

				if( FFS_Exist(szPhotopath) )
				{
					FFS_Copy(szPhotopath, g_szphoto);
					FFS_Delete(szPhotopath);
					
					MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
					return;
				}
			}
		}

		ON_DRAW();
		
		return;
	}

	/*=======================================================================================
	�Լ��� : OnUart
	��  �� : ���� �Կ�, ��� O
	Param  : 
	Return : 
	========================================================================================*/
	void OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		int size = 0;
		
		if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				
				if( FFS_Exist(szfilenm) )
				{
					FFS_Copy(szfilenm, g_szphoto);

					MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
					
					FFS_Delete( szfilenm );
					
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
					
					ON_DRAW();
				}
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : Shoto_Photo
	��  �� : �����Կ�
	Param  : 
	Return : 
	========================================================================================*/
	void Shoto_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet = 0;
		char szToday[10];
		char szTime[10];
		
 		// ������ȣ | _ | ������¥(SYSDATE : YYYYMMDDHHMMSS ) | _ | S(����)/V(�湮) 
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Mem_Set((byte*)szToday, 0x00, sizeof(szToday));
		Mem_Set((byte*)szTime, 0x00, sizeof(szTime));
		
		Str_Cpy(m_szfilenm, stNoPayObj.USE_CONT_NUM);				
		Str_Cat(m_szfilenm, "_");		

		Str_ItoA(Time_GetDate(), szToday, 10);
		Str_Cat(m_szfilenm, szToday);
		
		g_Str_TimeType( szTime , Time_GetTime());

		Str_Cat(m_szfilenm, szTime);
		Str_Cat(m_szfilenm, "_");		
		Str_Cat(m_szfilenm, "V");
		Str_Cat(m_szfilenm, ".jpg");

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_NP,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;	
		}
		else
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_NP,  m_szfilenm, 0);
			ShootPhoto ( 1, 0, m_szfilenm );
		}

		return;
	}
	
	/*=======================================================================================
	�Լ��� : Snd_ExcepTel
	��  �� : �ڵ�����ȣ ���� Service
	Param  : flag = 0 : insert, 1 : ����
	Return : 
	========================================================================================*/
	long Snd_ExcepTel(char* flag)
	{	
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;	
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 84102, FALSE);
		
		if(flag == 0)
		{
			JSON_SetValue( g_pjcomm, 'C', "flag", flag );
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "flag", flag );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "tel_ddd", stNoPayObj.CP_DDD );
		JSON_SetValue( g_pjcomm, 'C', "tel_exn", stNoPayObj.CP_EXN );
		JSON_SetValue( g_pjcomm, 'C', "tel_num", stNoPayObj.CP_NUM );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR84102;
		
		HTTP_DownloadData( szUrl, "FR84102_IN",  "FR84102" , sndbuf, szbuf );
		
		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : TR84102
	��  �� : FR84102 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR84102(void)
	{
		char szTmp[300];
		
		g_Sock_Close();
		CloseMessageBox();
			
		if(g_Chk_Json(84102) >= 0)
		{
			// ���� -> ���
			if( m_lExcepFlag == 0 )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				
				if( g_nWorkFlag == 810 )
				{
					SPRINT(szTmp, "UPDATE C6202_NOPAY_OBJ_PART SET EXCEP_TEL_YN = 'Y' WHERE USE_CONT_NUM = '%s' ", stNoPayObj.USE_CONT_NUM, 0, 0);
				}
				else if( g_nWorkFlag == 830 )
				{
					SPRINT(szTmp, "UPDATE C6202_STOP_OBJ SET EXCEP_TEL_YN = 'Y' WHERE USE_CONT_NUM = '%s' ", stNoPayObj.USE_CONT_NUM, 0, 0);
				}
				else
				{
					SPRINT(szTmp, "UPDATE C6202_NOPAY_OBJ SET EXCEP_TEL_YN = 'Y' WHERE USE_CONT_NUM = '%s' ", stNoPayObj.USE_CONT_NUM, 0, 0);
				}
				
				g_Sql_DirectExecute(szTmp);
				
				Mem_Set((byte*)stNoPayObj.EXCEP_TEL_YN, 0x00, sizeof(stNoPayObj.EXCEP_TEL_YN));
				Str_Cpy(stNoPayObj.EXCEP_TEL_YN, "Y");
				
				m_lExcepFlag = 1;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_EXCEP_YN), CHKON);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_EXCEP_YN), RED);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE );	
			}
			// ��� -> ���� 
			else
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				
				if( g_nWorkFlag == 810 )
				{
					SPRINT(szTmp, "UPDATE C6202_NOPAY_OBJ_PART SET EXCEP_TEL_YN = 'N' WHERE USE_CONT_NUM = '%s' ", stNoPayObj.USE_CONT_NUM, 0, 0);
				}
				else if( g_nWorkFlag == 830 )
				{
					SPRINT(szTmp, "UPDATE C6202_STOP_OBJ SET EXCEP_TEL_YN = 'N' WHERE USE_CONT_NUM = '%s' ", stNoPayObj.USE_CONT_NUM, 0, 0);
				}
				else
				{
					SPRINT(szTmp, "UPDATE C6202_NOPAY_OBJ SET EXCEP_TEL_YN = 'N' WHERE USE_CONT_NUM = '%s' ", stNoPayObj.USE_CONT_NUM, 0, 0);
				}
				
				g_Sql_DirectExecute(szTmp);
				
				Mem_Set((byte*)stNoPayObj.EXCEP_TEL_YN, 0x00, sizeof(stNoPayObj.EXCEP_TEL_YN));
				Str_Cpy(stNoPayObj.EXCEP_TEL_YN, "N");
				
				m_lExcepFlag = 0;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_EXCEP_YN), CHKOFF);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_EXCEP_YN), BLACK);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), TRUE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMS), FALSE );
			}
			
			return 1;
		}
		else
		{
			
			ON_DRAW();
			return -1;
		}
	}
}


