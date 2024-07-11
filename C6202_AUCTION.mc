/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_AUCTION
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
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_INFO1 )
		DEF_BUTTON_ID ( BID_INFO2 )
		DEF_BUTTON_ID ( BID_ADDR )
		DEF_BUTTON_ID ( BID_ETC )
		DEF_BUTTON_ID ( BID_OK )
//������
		DEF_BUTTON_ID ( BID_CLOSE )
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
//�������2
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
		DEF_OBJECT_ID ( TXT_DATA47 )
		DEF_OBJECT_ID ( TXT_DATA48 )
		DEF_OBJECT_ID ( TXT_DATA49 )
		
//������
		DEF_OBJECT_ID ( TXT_DATA50 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	#define INIT_SUB	2
	#define INIT_ETC    3
		
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

	typedef struct _AUCINFO
	{
		char LAWCOURT_EVENT_NUM[20];
		char CUST_NUM[20];
		char AUCTION_FLAG[20];
		char USAGE[30];
		char CITY[30];
		char AREA[30];
		char TOWN[30];
		char VILLAGE[30];
		char ADDR1_M[10];
		char ADDR1_S[10];
		char CO_LIVE_NM[30];
		char DONG_NUM[30];
		char HOSU[30];
		char ADDR[200];
		char LAW_TOWN[30];
		char NEW_ROAD_NM[30];
		char NEW_ADDR_M[10];
		char NEW_ADDR_S[10];
		char NEW_ADDR[200];
		char FINL_RSLT[10];
		char FINL_RSLT_YMD[30];
		char HOLD_BID_CNT[10];
		char JUDGE_YMD[30];
		char OWNER_REG_YMD[30];
		char DISTRIB_YMD[30];
		char STR_DECISION_YMD[30];
		char OK_BID_YMD[30];
		char DISTRIB_REQ_YMD[30];
		char BIDDING_YMD[30];
		char TRANS_IN_YMD[30];
		char CONF_YMD[30];
		char REQ_AMT[20];
		char RENT_WARR_AMT[20];
		char MM_RENT[20];
		char RENT_FLAG[10];
		char RENTER_NM[30];
		char ETC_RENT_DETA[950];
		char LAWCOURT_NM[30];
		char PROC_CNT[20];
	}	AUCINFO;
	
	AUCINFO	m_stAucInfo;

	
	long m_bFirst;
	long m_RcvFlag = 0;		//0 : ���� , 1 : ���Ź������� , ȭ��ó���� �ѹ��� ���Ź޵���.
	long m_lInitFlag = 0;	//0 : MAIN , 1 : SUB, ������ Ȯ�� �� ���ƿö� ���.
	
	void SetBtnImg(void);
	void SetStyle(void);
	void AddrDraw(void);
	void ReDraw(void);
	long SetStruct(long nservicenum);
	long Rcv_AucInfo(void);
	long TR82236(void);
	
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY-29, 300, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO1, "�������1"),
		DLG_BUTTON(STARTX+300,  STARTY-29, 300, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO2, "�������2"),
		DLG_BUTTON(STARTX,     STARTY+270, 230,120, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_BUTTON(STARTX+600, STARTY+835, 400, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),

		DLG_TEXT(STARTX,        STARTY+30, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "��Ź�ȣ"),
		DLG_TEXT(STARTX+230,    STARTY+30, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,        STARTY+90, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "��ű���"),
		DLG_TEXT(STARTX+230,    STARTY+90, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,       STARTY+150, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "����ȣ"),
		DLG_TEXT(STARTX+230,   STARTY+150, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,       STARTY+210, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "�뵵"),
		DLG_TEXT(STARTX+230,   STARTY+210, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+230,   STARTY+270, 770,120, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		
		DLG_TEXT(STARTX,       STARTY+390, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "�������"),
		DLG_TEXT(STARTX+230,   STARTY+390, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+510,   STARTY+390, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "�����"),
		DLG_TEXT(STARTX+710,   STARTY+390, 295, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX,       STARTY+450, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "����ȸ��"),
		DLG_TEXT(STARTX+230,   STARTY+450, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+510,   STARTY+450, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "������"),
		DLG_TEXT(STARTX+710,   STARTY+450, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX,       STARTY+510, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, "������"),
		DLG_TEXT(STARTX+230,   STARTY+510, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+510,   STARTY+510, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA20, "�����"),
		DLG_TEXT(STARTX+710,   STARTY+510, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX,       STARTY+570, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA22, "���ÿ���"),
		DLG_TEXT(STARTX+230,   STARTY+570, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+510,   STARTY+570, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "������"),
		DLG_TEXT(STARTX+710,   STARTY+570, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX,       STARTY+630, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "���䱸"),
		DLG_TEXT(STARTX+230,   STARTY+630, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		DLG_TEXT(STARTX+510,   STARTY+630, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "������"),
		DLG_TEXT(STARTX+710,   STARTY+630, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,      STARTY-40, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO1, "�������1"),
		DLG_BUTTON(STARTX+400,  STARTY-40, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO2, "�������2"),
		DLG_BUTTON(STARTX,     STARTY+270, 230,120, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "����\n�ּ�"),
		DLG_BUTTON(STARTX+600, STARTY+835, 400, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),

		DLG_TEXT(STARTX,        STARTY+30, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "��Ź�ȣ"),
		DLG_TEXT(STARTX+230,    STARTY+30, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		DLG_TEXT(STARTX,        STARTY+90, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA3, "��ű���"),
		DLG_TEXT(STARTX+230,    STARTY+90, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(STARTX,       STARTY+150, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, "����ȣ"),
		DLG_TEXT(STARTX+230,   STARTY+150, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(STARTX,       STARTY+210, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA7, "�뵵"),
		DLG_TEXT(STARTX+230,   STARTY+210, 770, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(STARTX+230,   STARTY+270, 770,120, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		
		DLG_TEXT(STARTX,       STARTY+390, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, "�������"),
		DLG_TEXT(STARTX+230,   STARTY+390, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(STARTX+510,   STARTY+390, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, "�����"),
		DLG_TEXT(STARTX+710,   STARTY+390, 295, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(STARTX,       STARTY+450, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, "����ȸ��"),
		DLG_TEXT(STARTX+230,   STARTY+450, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(STARTX+510,   STARTY+450, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, "������"),
		DLG_TEXT(STARTX+710,   STARTY+450, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(STARTX,       STARTY+510, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, "������"),
		DLG_TEXT(STARTX+230,   STARTY+510, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(STARTX+510,   STARTY+510, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA20, "�����"),
		DLG_TEXT(STARTX+710,   STARTY+510, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),
		DLG_TEXT(STARTX,       STARTY+570, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA22, "���ÿ���"),
		DLG_TEXT(STARTX+230,   STARTY+570, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(STARTX+510,   STARTY+570, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA24, "������"),
		DLG_TEXT(STARTX+710,   STARTY+570, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(STARTX,       STARTY+630, 230, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "���䱸"),
		DLG_TEXT(STARTX+230,   STARTY+630, 280, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA27, ""),
		DLG_TEXT(STARTX+510,   STARTY+630, 200, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "������"),
		DLG_TEXT(STARTX+710,   STARTY+630, 290, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA29, ""),
	};		
	

	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_Sub[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,      STARTY-29, 300, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO1, "�������1"),
		DLG_BUTTON(STARTX+300,  STARTY-29, 300, 60, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO2, "�������2"),
		DLG_BUTTON(STARTX+600, STARTY+835, 400, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),

		DLG_TEXT(STARTX,       STARTY+30, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "��������"),
		DLG_TEXT(STARTX+270,   STARTY+30, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(STARTX,       STARTY+90, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA32, "Ȯ������"),
		DLG_TEXT(STARTX+270,   STARTY+90, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""),
		DLG_TEXT(STARTX,      STARTY+150, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA34, "û���ݾ�"),
		DLG_TEXT(STARTX+270,  STARTY+150, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(STARTX,      STARTY+210, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA36, "����������"),
		DLG_TEXT(STARTX+270,  STARTY+210, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(STARTX,      STARTY+270, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA38, "������"),
		DLG_TEXT(STARTX+270,  STARTY+270, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX,      STARTY+330, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA40, "��������"),
		DLG_TEXT(STARTX+270,  STARTY+330, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(STARTX,      STARTY+390, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA42, "�����θ�"),
		DLG_TEXT(STARTX+270,  STARTY+390, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, ""),
		//DLG_TEXT(0,           STARTY+450, 260, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA44, "������"),
		DLG_BUTTON(STARTX,    STARTY+450, 270, 260, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ETC, "������"),
		DLG_TEXT(STARTX+270,  STARTY+450, 730, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA45, ""),
		DLG_TEXT(STARTX,      STARTY+710, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA46, "����"),
		DLG_TEXT(STARTX+270,  STARTY+710, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA47, ""),
		DLG_TEXT(STARTX,      STARTY+770, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA48, "����ȸ��"),
		DLG_TEXT(STARTX+270,  STARTY+770, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA49, ""),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_Sub_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "�������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,      STARTY-40, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO1, "�������1"),
		DLG_BUTTON(STARTX+400,  STARTY-40, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_INFO2, "�������2"),
		DLG_BUTTON(STARTX+600, STARTY+835, 400, 64, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ ��"),

		DLG_TEXT(STARTX,       STARTY+30, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, "��������"),
		DLG_TEXT(STARTX+270,   STARTY+30, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(STARTX,       STARTY+90, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA32, "Ȯ������"),
		DLG_TEXT(STARTX+270,   STARTY+90, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA33, ""),
		DLG_TEXT(STARTX,      STARTY+150, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA34, "û���ݾ�"),
		DLG_TEXT(STARTX+270,  STARTY+150, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(STARTX,      STARTY+210, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA36, "����������"),
		DLG_TEXT(STARTX+270,  STARTY+210, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(STARTX,      STARTY+270, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA38, "������"),
		DLG_TEXT(STARTX+270,  STARTY+270, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(STARTX,      STARTY+330, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA40, "��������"),
		DLG_TEXT(STARTX+270,  STARTY+330, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(STARTX,      STARTY+390, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA42, "�����θ�"),
		DLG_TEXT(STARTX+270,  STARTY+390, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, ""),
		//DLG_TEXT(0,           STARTY+450, 260, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_DATA44, "������"),
		DLG_BUTTON(STARTX,    STARTY+450, 270, 260, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ETC, "������"),
		DLG_TEXT(STARTX+270,  STARTY+450, 730, 260, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA45, ""),
		DLG_TEXT(STARTX,      STARTY+710, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA46, "����"),
		DLG_TEXT(STARTX+270,  STARTY+710, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA47, ""),
		DLG_TEXT(STARTX,      STARTY+770, 270, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA48, "����ȸ��"),
		DLG_TEXT(STARTX+270,  STARTY+770, 730, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA49, ""),
	};		

	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_Etc[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+600,   STARTY+829, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�ݱ�"),

		DLG_TEXT(STARTX,     STARTY-29, 1000, 825, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA50, ""),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_Etc_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "������"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(STARTX+600,   STARTY+829, 400, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE, "�ݱ�"),

		DLG_TEXT(STARTX,     STARTY-40, 1000, 850, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA50, ""),
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
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				
				if( m_RcvFlag == 0 )
				{
					m_RcvFlag = 1;
					Rcv_AucInfo();
				}
				else
				{
					ReDraw();
				}
				break;
			case INIT_SUB:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Sub_P, SIZEOF(DlgRes_Sub_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Sub, SIZEOF(DlgRes_Sub));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				ReDraw();
				break;
			case INIT_ETC:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_Etc_P, SIZEOF(DlgRes_Etc_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes_Etc, SIZEOF(DlgRes_Etc));
						break;		
				}

				SetBtnImg();	
				SetStyle();
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA50),  m_stAucInfo.ETC_RENT_DETA );
				break;
		}
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{				
		switch(ID)
		{
			case BID_INFO1:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_INFO2:
				ON_EXIT();
				OnInit(INIT_SUB);
				break;
			case BID_ADDR:
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				AddrDraw();
				ON_DRAW();
				break;
			case BID_ETC:
				if( m_bFirst == INIT_MAIN )
				{
					m_lInitFlag = 0;
				}
				else
				{
					m_lInitFlag = 1;
				}
				
				ON_EXIT();
				OnInit(INIT_ETC);
				break;
			case BID_OK:
				Card_Move("C6202_NPACTIVE");
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
//������
			case BID_CLOSE:
				if( m_lInitFlag == 0 )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				else if( m_lInitFlag == 1 )
				{
					ON_EXIT();
					OnInit(INIT_SUB);
				}
				break;
			
		}
	}		
	
//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
//------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA9), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_SUB )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA32), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA44), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA45), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA46), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA47), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA48), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA49), EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA45), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_ETC )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA50), EDITALIGN_TOP);
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA50), TRUE, 2, EDITSEP_NONE );
		}
	}
	
//------------------------------------------------------------------
	long Rcv_AucInfo(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82236, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "cust_num",  stNoPayObj.CUST_NUM );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		//�Ѱ��ִ� item������ Ȯ��
		//g_Save_JsonFile(sndbuf);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82236; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR82236_IN",  "FR82236" , sndbuf, sztmp );
		return 0 ;
	}
	
//------------------------------------------------------------------
	long TR82236(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82236) >= 0)
		{
			SetStruct(82236);
			ReDraw();
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

//------------------------------------------------------------------
	long SetStruct(long nservicenum)
	{
	char szJsonpath[500];
	char szMsg[500];
	char szCol[950];
	char szDate[50];
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
								Mem_Set((byte*)&m_stAucInfo, 0x00, sizeof(m_stAucInfo));

								//������ǹ�ȣ
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "lawcourt_event_num", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.LAWCOURT_EVENT_NUM , szCol);

								//��ű���
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "auction_flag", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.AUCTION_FLAG , szCol);

								//����ȣ
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "cust_num", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.CUST_NUM , szCol);

								//�뵵
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "usage", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.USAGE , szCol);

								//�õ�
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "city", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.CITY , szCol);

								//�ñ���
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "area", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.AREA , szCol);

								//���鵿
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "town", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.TOWN , szCol);

								//��
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "village", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.VILLAGE , szCol);

								//����_����
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "addr1_m", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.ADDR1_M , szCol);

								//����_�ι�
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "addr1_s", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.ADDR1_S , szCol);

								//�������ø�
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "co_live_nm", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.CO_LIVE_NM , szCol);

								//����ȣ
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "dong_num", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.DONG_NUM , szCol);

								//ȣ��
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "hosu", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.HOSU , szCol);

								//�����ּ�
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "addr", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.ADDR , szCol);

								//������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "law_town", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.LAW_TOWN , szCol);

								//���θ�
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "new_road_nm", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.NEW_ROAD_NM , szCol);

								//���ּҺ���
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "new_addr_m", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.NEW_ADDR_M , szCol);

								//���ּҺι�
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "new_addr_s", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.NEW_ADDR_S , szCol);

								//���ּ�����
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "new_addr", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.NEW_ADDR , szCol);

								//�������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "finl_rslt", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.FINL_RSLT , szCol);

								//�����������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "finl_rslt_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.FINL_RSLT_YMD , szDate);

								//����ȸ��
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "hold_bid_cnt", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Cpy(m_stAucInfo.HOLD_BID_CNT , szCol);

								//��������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "judge_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.JUDGE_YMD , szDate);

								//�����ڵ����
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "owner_reg_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.OWNER_REG_YMD , szDate);

								//�������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "distrib_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.DISTRIB_YMD , szDate);

								//���ð�����
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "str_decision_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.STR_DECISION_YMD , szDate);

								//��������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "ok_bid_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.OK_BID_YMD , szDate);

								//���䱸����
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "distrib_req_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.DISTRIB_REQ_YMD , szDate);

								//��������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "bidding_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.BIDDING_YMD , szDate);

								//��������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "trans_in_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.TRANS_IN_YMD , szDate);

								//Ȯ������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								Mem_Set((byte*) szDate, 0x00, sizeof( szDate) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "conf_ymd", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								g_Str_DateType( szDate, szCol);
								Str_Cpy(m_stAucInfo.CONF_YMD , szDate);

								//û���ݾ�
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "req_amt", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								Str_Chg(szCol, STRCHG_INS_COMMA);
								Str_Cpy(m_stAucInfo.REQ_AMT , szCol);

								//����������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "rent_warr_amt", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								Str_Chg(szCol, STRCHG_INS_COMMA);
								Str_Cpy(m_stAucInfo.RENT_WARR_AMT , szCol);

								//�����ݾ�
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "mm_rent", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Chg(szCol, STRCHG_DEL_NONDIGIT);
								Str_Chg(szCol, STRCHG_INS_COMMA);
								Str_Cpy(m_stAucInfo.MM_RENT , szCol);

								//��������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "rent_flag", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.RENT_FLAG , szCol);

								//�����ڸ�
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "renter_nm", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.RENTER_NM , szCol);

								//��Ÿ������
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "etc_rent_deta", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.ETC_RENT_DETA , szCol);
//PRINT("m_stAucInfo.ETC_RENT_DETA : %s",m_stAucInfo.ETC_RENT_DETA,0,0);

								//�������Ī
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								szcode = (char*)JSON_GetArrayItem ( hitem, 0, "lawcourt_nm", szType);
								SQL_ConvMbStr(szCol, szcode);
								Str_Cpy(m_stAucInfo.LAWCOURT_NM , szCol);

								//����Ƚ��
								Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
								nCol = (long*)JSON_GetArrayItem ( hitem, 0, "proc_cnt", szType);
								nCnt = *nCol;
								Str_ItoA(nCnt, szCol, 10);
								Str_Cpy(m_stAucInfo.PROC_CNT , szCol);
							}

							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
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
		
		return ret;
	}

//------------------------------------------------------------------
	void ReDraw(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_INFO1), FALSE );		
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_INFO2), TRUE );

			//��Ź�ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA2),  m_stAucInfo.LAWCOURT_EVENT_NUM );
			
			//��ű���
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA4),  m_stAucInfo.AUCTION_FLAG );
			
			//����ȣ
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA6),  m_stAucInfo.CUST_NUM );
			
			//�뵵
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA8),  m_stAucInfo.USAGE );

			//�ּ�
			AddrDraw();
			
			//�������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA11),  m_stAucInfo.FINL_RSLT );
			
			//�����
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13),  m_stAucInfo.FINL_RSLT_YMD );
			
			//����ȸ��
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15),  m_stAucInfo.HOLD_BID_CNT );
			
			//������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17),  m_stAucInfo.JUDGE_YMD );
			
			//������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19),  m_stAucInfo.OWNER_REG_YMD );
			
			//�����
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21),  m_stAucInfo.DISTRIB_YMD );
			
			//���ÿ���
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA23),  m_stAucInfo.STR_DECISION_YMD );
			
			//������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA25),  m_stAucInfo.OK_BID_YMD );
			
			//���䱸
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA27),  m_stAucInfo.DISTRIB_REQ_YMD );
			
			//������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA29),  m_stAucInfo.BIDDING_YMD );
		}
		else if( m_bFirst == INIT_SUB )
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_INFO1), TRUE );		
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_INFO2), FALSE );

			//��������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA31),  m_stAucInfo.TRANS_IN_YMD );
			
			//Ȯ������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA33),  m_stAucInfo.CONF_YMD );
			
			//û���ݾ�
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA35),  m_stAucInfo.REQ_AMT );
			
			//����������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA37),  m_stAucInfo.RENT_WARR_AMT );
			
			//������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA39),  m_stAucInfo.MM_RENT );
			
			//��������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA41),  m_stAucInfo.RENT_FLAG );
			
			//�����θ�
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA43),  m_stAucInfo.RENTER_NM );
			
			//������
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA45),  m_stAucInfo.ETC_RENT_DETA );
			
			//����
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA47),  m_stAucInfo.LAWCOURT_NM );
			
			//����ȸ��
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA49),  m_stAucInfo.PROC_CNT );
		}
		
		ON_DRAW();
		return;
	}

//------------------------------------------------------------------
	void AddrDraw(void)
	{
		char szTmp[400];
	
		//�ּ�
		if( g_nAddrFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����\n�ּ�");
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, stNoPayObj.AREA);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.TOWN);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.VILLAGE);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.ADDR1_M);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stNoPayObj.ADDR1_S);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�\n�ּ�");
		
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy(szTmp, stNoPayObj.NEW_ROAD_NM);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.NEW_ADDR_M);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stNoPayObj.NEW_ADDR_S);
		}
		
		if( ( Str_Len(stNoPayObj.CO_LIVE_NM) + Str_Len(stNoPayObj.BLD_NM) ) > 0 )
		{
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.CO_LIVE_NM);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.BLD_NM);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, stNoPayObj.HOSU);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.DETAIL_FLOOR);
		}
		else
		{
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.HOSU);
			Str_Cat(szTmp, " ");
			Str_Cat(szTmp, stNoPayObj.DETAIL_FLOOR);
		}
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA9),  szTmp);

		return;
	}
}



