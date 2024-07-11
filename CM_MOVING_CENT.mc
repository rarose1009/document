/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : CM_MOVING_CENT
	Card Desc : �̵� ������
	Card Hist :
----------------------------------------------------------------------------------*/
card CM_MOVING_CENT
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
//  #define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/* �̵�������_����            */
		/********************************/
		DEF_BUTTON_ID ( BID_INQUIRY )				// BID_��ȸ
		DEF_BUTTON_ID ( BID_REAL_HP_TEL )				// BID_HP/TEL
		DEF_BUTTON_ID ( BID_HP_CHG )				// BID_����
		DEF_BUTTON_ID ( BID_HP_SMS )				// BID_SMS
		
		DEF_BUTTON_ID ( BID_PAY_METHOD_DTL )	   	// BID_���ι��_��
		DEF_BUTTON_ID ( BID_BILL_SEND_METHOD_DTL ) 	// BID_�߼۹��_��
		DEF_BUTTON_ID ( BID_UNPAY_MONTH )		   	// BID_�̳�����_��
		
		DEF_BUTTON_ID ( BID_VISIT )					// BID_�湮����(�湮����)
		DEF_BUTTON_ID ( BID_RSLT )					// BID_���(�޸�)
		
		DEF_BUTTON_ID ( BID_CMB_BILL_SEND_METHOD )	// BID_CMB_�߼۹��
		DEF_BUTTON_ID ( BID_CLOSE )					// BID_���
		DEF_BUTTON_ID ( BID_MEMO )					// BID_�޸�
		DEF_BUTTON_ID ( BID_OK )					// BID_���
		
		/********************************/
		/* �̵�������_��ȸ            */
		/********************************/
		DEF_BUTTON_ID ( BID_SEARCH_CLEAR )			// BID_�ʱ�ȭ
		DEF_BUTTON_ID ( BID_SEARCH )				// BID_�˻�
		DEF_BUTTON_ID ( BID_SEARCH_ADDR_CHG )		// BID_�ּ� ����
		DEF_BUTTON_ID ( BID_SEARCH_PAGE )			// BID_PAGE, ����
		DEF_BUTTON_ID ( BID_SEARCH_UP )				// BID_��ȸ_��
		DEF_BUTTON_ID ( BID_SEARCH_DOWN )			// BID_��ȸ_��
		DEF_BUTTON_ID ( BID_SEARCH_WRITE_ADDR ) 	// BID_�˻�
		DEF_BUTTON_ID ( BID_SEARCH_WRITE_NAME ) 	// BID_����
		DEF_BUTTON_ID ( BID_SEARCH_CLOSE )     	    // BID_��ȸ_�ݱ�
		
		/********************************/
		/* �̵�������_�ǻ����        */
		/********************************/
		DEF_BUTTON_ID ( BID_REAL_SAVE )				// BID_����
		DEF_BUTTON_ID ( BID_REAL_SMS )				// BID_SMS
		
		/********************************/
		/* �̵�������_��ݳ���        */
		/********************************/
		DEF_BUTTON_ID ( BID_CHARGE_UP )				// BID_���_��
		DEF_BUTTON_ID ( BID_CHARGE_DOWN )			// BID_���_��
		
		/********************************/
		/* �̵�������_�湮����        */
		/********************************/
		DEF_BUTTON_ID ( BID_VISIT_UP )				// BID_�湮_��
		DEF_BUTTON_ID ( BID_VISIT_DOWN )			// BID_�湮_��
		
		/********************************/
		/* �̵�������_�޸�            */
		/********************************/
		DEF_BUTTON_ID ( BID_MEMO_DEL )				// BID_�޸����
		DEF_BUTTON_ID ( BID_MEMO_SAVE )				// BID_�޸�����
		DEF_BUTTON_ID ( BID_MEMO_WRITE )			// BID_�޸�EDIT
		
		/********************************/
		/* �̵�������_�߼۵��        */
		/********************************/
		DEF_BUTTON_ID ( BID_BILL_SEND_SAVE )		 // BID_���
		DEF_BUTTON_ID ( BID_BILL_SEND_REQ_NM_WRITE ) // BID_��û�ڸ�
		DEF_BUTTON_ID ( BID_BILL_SEND_EMAIL_WRITE )	 // BID_�̸���
		DEF_BUTTON_ID ( BID_BILL_SEND_EMAIL_WRITE2 ) // BID_�̸���2
		
		/********************************/
		/* ����                         */
		/********************************/
		DEF_BUTTON_ID ( BID_POPUP_CLOSE )			// BID_�˾�_���
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* �̵�������_Ÿ��Ʋ          */
		/********************************/
		DEF_OBJECT_ID ( TXT_TITLE )				
		DEF_OBJECT_ID ( ICON_TITLE )
		
		/********************************/
		/* �̵�������_����            */
		/********************************/
		DEF_OBJECT_ID ( ST_USE_CONT_NUM )		// ST_������ȣ
		DEF_OBJECT_ID ( TXT_USE_CONT_NUM )		// TXT_������ȣ
		DEF_OBJECT_ID ( TXT_USE_CONT_DOC )		// TXT_������û��_����
		DEF_OBJECT_ID ( TXT_PHONE_NUM )			// TXT_HP/TEL��ȣ
		
		DEF_OBJECT_ID ( ST_DEADLINE )			// ST_������
		DEF_OBJECT_ID ( TXT_DEADLINE )			// TXT_������
		DEF_OBJECT_ID ( ST_GMTR_METHOD )		// ST_��ħ���
		DEF_OBJECT_ID ( TXT_GMTR_METHOD )		// TXT_��ħ���
		DEF_OBJECT_ID ( ST_PAY_METHOD )			// ST_���ι��
		DEF_OBJECT_ID ( TXT_PAY_METHOD )		// TXT_���ι��
		DEF_OBJECT_ID ( ST_BILL_SEND_METHOD )	// ST_�߼۹��
		DEF_OBJECT_ID ( TXT_BILL_SEND_METHOD )	// TXT_�߼۹��
		DEF_OBJECT_ID ( ST_UNPAY_MONTH )		// ST_�̳�����
		DEF_OBJECT_ID ( TXT_UNPAY_MONTH )		// TXT_�̳�����
		DEF_OBJECT_ID ( ST_UNPAY_AMT )			// ST_�̳��ݾ�
		DEF_OBJECT_ID ( TXT_UNPAY_AMT )			// TXT_�̳��ݾ�
		
		DEF_OBJECT_ID ( ST_VISIT_TYPE )			// ST_�湮����
		DEF_OBJECT_ID ( TXT_VISIT_YMD )			// TXT_�湮����
		DEF_OBJECT_ID ( TXT_VISIT_TYPE )		// TXT_�湮����
		DEF_OBJECT_ID ( TXT_VISIT_RESULT )		// TXT_�湮���
		
		DEF_OBJECT_ID ( ST_CMB_REFUSE )			// ST_CMB_�ź�
		DEF_OBJECT_ID ( ST_CMB_PAY_METHOD )		// ST_CMB_���ι��
		DEF_OBJECT_ID ( ST_CMB_SELF_GMTR )		// ST_CMB_�ڰ���ħ
		DEF_OBJECT_ID ( ST_CMB_USE_CONT )		// ST_CMB_�����
		
		DEF_OBJECT_ID ( LINE_DATA1 )			// ����1
		DEF_OBJECT_ID ( LINE_DATA2 )			// ����2
		DEF_OBJECT_ID ( LINE_DATA3 )			// ����3
		DEF_OBJECT_ID ( LINE_DATA4 )			// ����4
		
		/********************************/
		/* �̵�������_��ȸ            */
		/********************************/
		DEF_OBJECT_ID ( ST_SEARCH_TYPE )		// ST_����
		DEF_OBJECT_ID ( ST_SEARCH_ADDR_TYPE )	// ST_�ּ�
		DEF_OBJECT_ID ( ST_SEARCH_CITY )		// ST_��/��
		DEF_OBJECT_ID ( ST_SEARCH_CITY2 )		// ST_��/��2
		DEF_OBJECT_ID ( ST_SEARCH_ADDR )		// ST_�˻�
		DEF_OBJECT_ID ( ST_SEARCH_USE_CONT )	// ST_�����
		DEF_OBJECT_ID ( ST_SEARCH_NAME )		// ST_����
		DEF_OBJECT_ID ( ST_SEARCH_PHONE )		// ST_��ȭ��ȣ
		DEF_OBJECT_ID ( ST_SEARCH_PHONE_EXN )	// ST_��ȭ��ȣ_EXN
		DEF_OBJECT_ID ( ST_SEARCH_PHONE_NUM )	// ST_��ȭ��ȣ_NUM
		DEF_OBJECT_ID ( TXT_SEARCH_ADDR_EX )	// TXT_�˻�����
		DEF_BUTTON_ID ( TXT_SEARCH_PAGE )		// TXT_������
		DEF_OBJECT_ID ( LINE_DATA5 )			// ����5
		DEF_OBJECT_ID ( LINE_DATA6 )			// ����6
		
		/********************************/
		/* �̵�������_�ǻ����        */
		/********************************/
		DEF_OBJECT_ID ( ST_REAL_HP )			// ST_�ǻ����_HP
		DEF_OBJECT_ID ( TXT_REAL_HP )			// TXT_�ǻ����_HP
		DEF_OBJECT_ID ( ST_REAL_USER )			// ST_�ǻ����
		DEF_OBJECT_ID ( ST_REAL_EXN )			// ST_�ǻ����_-
		DEF_OBJECT_ID ( ST_REAL_NUM )			// ST_�ǻ����_-
		DEF_OBJECT_ID ( LINE_DATA7 )			// ����7
		
		/********************************/
		/* �̵�������_��ݳ���        */
		/********************************/
		DEF_OBJECT_ID ( TXT_CHARGE_PAGE )		// TXT_���_PAGE
		DEF_OBJECT_ID ( LINE_DATA8 )			// ����8
		
		/********************************/
		/* �̵�������_�湮����        */
		/********************************/
		DEF_OBJECT_ID ( TXT_VISIT_PAGE )		// TXT_�湮_PAGE
		DEF_OBJECT_ID ( LINE_DATA9 )			// ����9
		
		/********************************/
		/* �̵�������_�޸�            */
		/********************************/
		DEF_OBJECT_ID ( EDT_MEMO ) 				// EDIT_MEMO
		DEF_OBJECT_ID ( LINE_DATA10 )			// ����10
		
		/********************************/
		/* �̵�������_�߼۵��        */
		/********************************/
		DEF_OBJECT_ID ( ST_BILL_SEND_REQ_NM )	// ST_��û��
		DEF_OBJECT_ID ( ST_BILL_SEND_PHONE )	// ST_�ڵ���
		DEF_OBJECT_ID ( ST_BILL_SEND_EXN )		// ST_EXN_-
		DEF_OBJECT_ID ( ST_BILL_SEND_NUM )		// ST_NUM_-+
		DEF_OBJECT_ID ( ST_BILL_SEND_EMAIL1 )	// ST_�̸���
		DEF_OBJECT_ID ( ST_BILL_SEND_EMAIL2 )	// ST_@
		DEF_OBJECT_ID ( LINE_DATA11 )			// ����11
		
		/********************************/
		/* ����                         */
		/********************************/
		// ������ ����
		DEF_OBJECT_ID ( TXT_KEY_ONE )			// 1
		DEF_OBJECT_ID ( TXT_KEY_TWO )			// 2
		DEF_OBJECT_ID ( TXT_KEY_THREE )			// 3 
		DEF_OBJECT_ID ( TXT_KEY_FOUR )			// 4
		DEF_OBJECT_ID ( TXT_KEY_FIVE )			// 5
		DEF_OBJECT_ID ( TXT_KEY_SIX )			// 6
		DEF_OBJECT_ID ( TXT_KEY_SEVEN )			// 7
		DEF_OBJECT_ID ( TXT_KEY_EIGHT )			// 8
		DEF_OBJECT_ID ( TXT_KEY_NINE )			// 9
		DEF_OBJECT_ID ( TXT_KEY_ZERO )			// 0
		DEF_OBJECT_ID ( TXT_KEY_DEL )			// <-
		DEF_OBJECT_ID ( TXT_KEY_EMPTY )			// ��ĭ
		
		/********************************/
		/* ���̺�                       */
		/********************************/
		DEF_OBJECT_ID ( ID_SEARCH_TBLLIST )		// ��ȸ ���̺�
		DEF_OBJECT_ID ( ID_CHARGE_TBLLIST )		// ��� ���̺�
		DEF_OBJECT_ID ( ID_VISIT_TBLLIST )		// �湮 ���̺�
		
		/********************************/
		/* EDIT                         */
		/********************************/
		// ��ȸ
		DEF_OBJECT_ID ( EDT_SEARCH_ADDR )			// EDT_�ּ� �˻�
		DEF_OBJECT_ID ( EDT_SEARCH_USE_CONT_NUM )	// EDT_������ȣ �˻�
		DEF_OBJECT_ID ( EDT_SEARCH_NAME )			// EDT_����
		DEF_OBJECT_ID ( EDT_SEARCH_PHONE_EXN )		// EDT_��ȭ��ȣ_EXN
		DEF_OBJECT_ID ( EDT_SEARCH_PHONE_NUM )		// EDT_��ȭ��ȣ_NUM
		
		// �ǻ����
		DEF_OBJECT_ID ( EDT_REAL_PHONE_EXN )		// EDT_EXN
		DEF_OBJECT_ID ( EDT_REAL_PHONE_NUM )		// EDT_NUM
		
		// �߼۵��
		DEF_OBJECT_ID ( EDT_BILL_SEND_REQ_NM )		// EDT_��û��
		DEF_OBJECT_ID ( EDT_BILL_SEND_PHONE_EXN )	// EDT_EXN
		DEF_OBJECT_ID ( EDT_BILL_SEND_PHONE_NUM )	// EDT_NUM
		DEF_OBJECT_ID ( EDT_BILL_SEND_EMAIL )		// EDT_EMAIL
		DEF_OBJECT_ID ( EDT_BILL_SEND_EMAIL2 )		// DET_EMIAL
		
		/********************************/
		/* COMBO                        */
		/********************************/
		// ����
		DEF_OBJECT_ID ( CMB_BILL_SEND_METHOD )					// CMB_�߼۹��
		DEF_OBJECT_ID ( CMB_REFUSE = CMB_BILL_SEND_METHOD + 3 )	// CMB_�ź�
		DEF_OBJECT_ID ( CMB_PAY_METHOD = CMB_REFUSE + 3 )		// CMB_���ι��
		DEF_OBJECT_ID ( CMB_SELF_GMTR = CMB_PAY_METHOD + 3 )	// CMB_�ڰ���ħ
		DEF_OBJECT_ID ( CMB_USE_CONT = CMB_SELF_GMTR + 3 )		// CMB_�����
		
		// ��ȸ
		DEF_OBJECT_ID ( CMB_SEARCH_TYPE = CMB_USE_CONT + 3 )			// CMB_�����
		DEF_OBJECT_ID ( CMB_SEARCH_ADDR_TYPE = CMB_SEARCH_TYPE + 3 )	// CMB_�ּ�
		DEF_OBJECT_ID ( CMB_SEARCH_CITY = CMB_SEARCH_ADDR_TYPE + 3 )	// CMB_��/��
		DEF_OBJECT_ID ( CMB_SEARCH_CITY2 = CMB_SEARCH_CITY + 3 )		// CMB_��/��2
		DEF_OBJECT_ID ( CMB_SEARCH_PHONE_DDD = CMB_SEARCH_CITY2 + 3 )	// CMB_��ȭ��ȣ
		
		// �ǻ����
		DEF_OBJECT_ID ( CMB_REAL_PHONE_DDD = CMB_SEARCH_PHONE_DDD + 3 )		// CMB_�ǻ����_DDD
		
		// �߼۵��
		DEF_OBJECT_ID ( CMB_BILL_SEND_PHONE_DDD = CMB_REAL_PHONE_DDD + 3 )	// CMB_�߼۵��_DDD
		DEF_OBJECT_ID ( CMB_BILL_SEND_EMAIL = CMB_BILL_SEND_PHONE_DDD + 3 )	// CMB_�߼۵��_�̸���
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	��ȸ Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    3						// table�� �ళ��
	#define		COL 	    4						// table�� ������
	#define		GRID_H_H	(CHT+15)				// table ��� �� ����
	#define		GRID_H		(CHT+107)				// table �� ����
	#define		GRID_CLR	TRANSPARENT   			// table Ŭ���� color
	#define		GRID_X		STARTX 			    	// table ����x��ǥ
	#define		GRID_Y		STARTY+340  	    	// table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table������ row�� Y��
	#define		MAXCHAR		1000     	    		// table�� ���� �ִ� �ִ�  char ����
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; 	// �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�����",	CWD*10, EDITALIGN_CENTER, TABLE_TEXT, 0},
		{"�ּ�",		CWD*22, EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����",		CWD*8 , EDITALIGN_CENTER, TABLE_TEXT, 0},
		{"��ġ��ҹ�ȣ",	0 , EDITALIGN_CENTER, TABLE_TEXT, 0}
	};
	
	//-------------------------------------------------------------------------------------------------	
	//	��� Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW2 	    9							// table�� �ళ��
	#define		COL2 	    7							// table�� ������
	#define		GRID_H2		(CHT+45)					// table �ٵ� �� ����
	#define		GRID_CLR2	TRANSPARENT   				// table Ŭ���� color
	#define		GRID_X2		STARTX 			    		// table ����x��ǥ
	#define		GRID_Y2		STARTY-29  	    			// table ����y��ǥ
	#define		GRID_ENDY2	(GRID_Y2+(ROW2+1)*GRID_H2) 	// table������ row�� Y��
	#define		MAXCHAR2	51 			    			// table�� ���� �ִ� �ִ�  char ����
	
	char	m_szTableBuf2 [COL2*(ROW2+1)*MAXCHAR2]; 	// �� CELL�� �� �ؽ�Ʈ ������ ���� ����
	
	Column m_stGridTitle2[] = {
		{"û��\n���",	CWD*7,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��ħ",		CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��뷮",		CWD*8 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"û���ݾ�",	CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����",		CWD*5 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ι��",	0 	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"��������",	0 	  , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	//-------------------------------------------------------------------------------------------------	
	//	�湮 Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW3 	    4							// table�� �ళ��
	#define		COL3 	    4							// table�� ������
	#define		GRID_H_H3	(CHT+21)					// table ��� �� ����
	#define		GRID_H3		(CHT+155)					// table �ٵ� �� ����
	#define		GRID_CLR3	TRANSPARENT   				// table Ŭ���� color
	#define		GRID_X3		STARTX 			    		// table ����x��ǥ
	#define		GRID_Y3		STARTY-29  	    			// table ����y��ǥ
	#define		GRID_ENDY3	(GRID_Y3+(ROW3+1)*GRID_H3) 	// table������ row�� Y��
	#define		MAXCHAR3	500 	       			    // table�� ���� �ִ� �ִ�  char ����
	
	char	m_szTableBuf3 [COL3*(ROW3+1)*MAXCHAR3]; 	// �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle3[] = {
		{"�湮����",	CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����",		CWD*7 , EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���",		CWD*23, EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ETC" ,		0     , EDITALIGN_LEFT  |EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN 1				// ����
	#define INIT_SEARCH 2			// ��ȸ
	#define INIT_REALUSER 3			// �ǻ����
	#define INIT_CHARGEHIST 4		// ��ݳ���
	#define INIT_VISITHIST 5		// �湮����
	#define INIT_MEMO 6				// �޸�
	#define INIT_BILL_SEND_METHOD 7	// �߼۵��
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	long m_bFirst;					// ȭ�� Index
	long m_lActiveIndex;			// ���� ��ġ�� Index	
	long m_lAIarmIndex = -1; 		// ���̺� ���� ��ġ �� �ľ��� ���� ���� Index ����	
	long m_lReal_hp_tel = 0; 		// REAL/HP/TEL Change Pamram, HP = 0, tel = 1, real = 2
	long m_lInitRedraw = 0; 		// Init Screen Param, ���� = 0, ��ȸ���� = 1 
	long m_lSearch_Addr_Chg = 0;    // ��ȸ �ּ� ���� flag : 0 = ����, 1 = ���θ�
	long m_lSearch_Move_flag = 0;	// ��ȸ Ŭ�� �� Snd_FR90001���� ���, 0 = ����, 1 = ��ȸ
	long m_lBldOk_flag = 0;			// ��� ��ư flag : 0 = ���, 1 = �߼۵��
	
	long m_lVisit_Totpage; 		  	// Visit hist Total page
	long m_lVisit_page;	 		  	// Visit hist current page
	char m_szCnt_Visit_page[20];  	// Visit hist show page
	
	long m_lCharge_Totpage; 	  	// Charge hist Total page
	long m_lCharge_page;	 	  	// Charge hist current page
	char m_szCnt_Charge_page[20]; 	// Charge hist show page
	
	long m_lSearch_Totpage; 	  	// Search Total page
	long m_lSearch_page;	 	  	// Search current page
	char m_szCnt_Search_page[20]; 	// Search show page
	
	char m_szInst_Place_Num[10];
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void SetCombo(void);
	
	void TableDraw_ChargeHist(void);
	void TableDraw_VisitHist(void);
    void TableDraw_Search(long flag);
	
	void SetCombo_Filter(void);
	
	void Set_Bill_Alarm(void);
	void Set_Pay_Alarm(void);
	
	void Save_Main_Combo(void);
	void Save_BillSend_Method(void);
	void Save_Real(void);
	void Save_Search(void);
	void Save_Memo(char* szMemo);
	
	void Clear_Data(void);
	void Clear_RsltData(void);
	
	bool Validation(void);
	
	void Snd_FR90001(char* szInst_Place_Num);
	long Rcv_FR90001(void);
	long Chk_Json_90001(void);
	
	void Snd_FR90002(void);
	long Rcv_FR90002(void);

	void Snd_FR90003(void);
	long Rcv_FR90003(void);

	void Snd_FR90004(void);
	long Rcv_FR90004(void);
	
	void Snd_FR90005(void);
	long Rcv_FR90005(void);
	
	void Snd_FR90006(void);
	long Rcv_FR90006(void);
	
	void Snd_FR90007(void);
	long Rcv_FR90007(void);
	
	void Quick_View_Search(void);
	void OnList(quad lParam);
	
	void Back_Move_Card(void);
	
	void Set_View_Main_PhoneNum(void);
	
	//---------------------------------------------------------------
	//	main 
	//---------------------------------------------------------------
	bool main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		if( MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST )
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�̵� ������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY- 29,  220,  60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_USE_CONT_NUM , "�����"),
		DLG_TEXT ( STARTX+220, STARTY- 29,  400,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_USE_CONT_NUM, ""),
		DLG_TEXT ( STARTX+620, STARTY- 29,  180,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_USE_CONT_DOC, ""),
		DLG_BUTTON(STARTX+800, STARTY- 29,  200,  59, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_INQUIRY, "��ȸ"),
		
		DLG_BUTTON(STARTX,	   STARTY+ 31,  219,  59, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_REAL_HP_TEL, "HP"),
		DLG_TEXT ( STARTX+220, STARTY+ 31,  400,  60, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_PHONE_NUM, ""),
		DLG_BUTTON(STARTX+620, STARTY+ 31,  180,  59, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_HP_CHG, "����"),
		DLG_BUTTON(STARTX+800, STARTY+ 31,  200,  59, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_HP_SMS, "SMS"),
		
		DLG_LINE ( STARTX,     STARTY+94, 1000, STARTY+94, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT ( STARTX,     STARTY+ 99,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_DEADLINE, "������"),
		DLG_TEXT ( STARTX+220, STARTY+ 99,  180,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_DEADLINE, ""),
		DLG_TEXT ( STARTX+400, STARTY+ 99,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_GMTR_METHOD, "��ħ���"),
		DLG_TEXT ( STARTX+620, STARTY+ 99,  380,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_GMTR_METHOD, ""),
		
		DLG_TEXT ( STARTX,     STARTY+149,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_BILL_SEND_METHOD, "�߼۹��"),
		DLG_TEXT ( STARTX+220, STARTY+149,  580,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_BILL_SEND_METHOD, ""),
		DLG_BUTTON(STARTX+800, STARTY+149,  200,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_BILL_SEND_METHOD_DTL, "��"),
		
		DLG_TEXT ( STARTX,     STARTY+199,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_PAY_METHOD, "���ι��"),
		DLG_TEXT ( STARTX+220, STARTY+199,  580,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_PAY_METHOD, ""),
		DLG_BUTTON(STARTX+800, STARTY+199,  200,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_PAY_METHOD_DTL, "��"),
		
		DLG_TEXT ( STARTX,     STARTY+249,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_UNPAY_MONTH, "�̳�����"),
		DLG_TEXT ( STARTX+220, STARTY+249,  580,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_UNPAY_MONTH, ""),
		DLG_BUTTON(STARTX+800, STARTY+249,  200,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_UNPAY_MONTH, "��"),
		
		DLG_TEXT ( STARTX,     STARTY+299,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_UNPAY_AMT, "�̳��ݾ�"),
		DLG_TEXT ( STARTX+220, STARTY+299,  780,  50, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_UNPAY_AMT, ""),
		
		DLG_LINE ( STARTX,     STARTY+352, 1000, STARTY+352, DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_BUTTON(STARTX,	   STARTY+357,  299,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_VISIT, "�湮����"),
		DLG_TEXT ( STARTX+300, STARTY+357,  150,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_VISIT_TYPE, "����"),
		DLG_BUTTON(STARTX+450, STARTY+357,  550,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_RSLT, "���"),
		
		DLG_TEXT ( STARTX,     STARTY+407,  300, 155, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_VISIT_YMD, ""),
		DLG_TEXT ( STARTX+300, STARTY+407,  150, 155, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_VISIT_TYPE, ""),
		DLG_TEXT ( STARTX+450, STARTY+407,  550, 155, 0, 0, 0, EDITSTY_BORDER             , TXTFRCOLOR    , TXTINCTRLBK   , TXT_VISIT_RESULT, ""),
		
		DLG_LINE ( STARTX,     STARTY+566, 1000, STARTY+566, DARKSLATEBLUE, 10, LINE_DATA3),
		
		DLG_BUTTON(STARTX,	   STARTY+570,  219,  49, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CMB_BILL_SEND_METHOD, "�߼۹��"),
		DLG_COMBO( STARTX+220, STARTY+570,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_BILL_SEND_METHOD, 5), // �߼۹��
		
		DLG_TEXT ( STARTX,     STARTY+620,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CMB_REFUSE, "�ź�"),
		DLG_COMBO( STARTX+220, STARTY+620,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_REFUSE, 5), // �ź�
		
		DLG_TEXT ( STARTX,     STARTY+670,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CMB_PAY_METHOD, "���ι��"),
		DLG_COMBO( STARTX+220, STARTY+670,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_PAY_METHOD, 5), // ���ι��
		
		DLG_TEXT ( STARTX,     STARTY+720,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CMB_SELF_GMTR, "�ڰ���ħ"),
		DLG_COMBO( STARTX+220, STARTY+720,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SELF_GMTR, 5), // �ڰ���ħ
		
		DLG_TEXT ( STARTX,     STARTY+770,  220,  50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR , TXTCTRLBK     , ST_CMB_USE_CONT, "�����"),
		DLG_COMBO( STARTX+220, STARTY+770,  780,  50, 200, 50, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_USE_CONT, 5), // �����
		
		DLG_LINE ( STARTX,     STARTY+823, 1000, STARTY+823, DARKSLATEBLUE, 10, LINE_DATA4),
		
		DLG_BUTTON(STARTX,	   STARTY+827,  330,  72, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CLOSE, "���"),
		DLG_BUTTON(STARTX+330, STARTY+827,  330,  72, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_MEMO, "�޸�"),
		DLG_BUTTON(STARTX+660, STARTY+827,  340,  72, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_OK, "���"),		
	};
	
	//---------------------------------------------------------------
	// ��ȸ ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes_Search[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ȸ"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SEARCH_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY- 29,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_TYPE , "����"),
		DLG_COMBO( STARTX+220, STARTY- 29,  780, 60, 200, 59, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SEARCH_TYPE, 5), // ����
		
		DLG_TEXT ( STARTX,     STARTY+ 31,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_ADDR_TYPE , "�ּ�Ÿ��"),
		DLG_COMBO( STARTX+220, STARTY+ 31,  780, 60, 200, 59, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SEARCH_ADDR_TYPE, 5), // �ּ�
		
		DLG_TEXT ( STARTX,     STARTY+ 31,  220, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_USE_CONT , "���\n����ȣ"),
		DLG_EDIT ( STARTX+220, STARTY+ 31,  780, 69, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR    , PDAEDTCTRLBK  , EDT_SEARCH_USE_CONT_NUM, 11,  ""),
		
		DLG_TEXT ( STARTX,     STARTY+ 31,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_CITY2 , "��/��"),
		DLG_COMBO( STARTX+220, STARTY+ 31,  780, 60, 200, 59, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SEARCH_CITY2, 5), // ��/��
		
		DLG_TEXT ( STARTX,     STARTY+ 91,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_CITY , "��/��"),
		DLG_COMBO( STARTX+220, STARTY+ 91,  780, 60, 200, 59, TXTFRCOLOR				  , TXTINCTRLBK   , CALL_FUNC, "", CMB_SEARCH_CITY, 5), // ��/��
		
		DLG_TEXT ( STARTX,     STARTY+ 91,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR, TXTCTRLBK, ST_SEARCH_PHONE, "��ȭ��ȣ"),
		DLG_COMBO (STARTX+220, STARTY+ 91,  290, 60, 115, 60, TXTFRCOLOR, PDAEDTCTRLBK    , CALL_FUNC, "", CMB_SEARCH_PHONE_DDD, 5), // DDD
		DLG_TEXT ( STARTX+510, STARTY+ 91,   55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTFRCOLOR, TXTINCTRLBK, ST_SEARCH_PHONE_EXN, "-"),
		DLG_EDIT ( STARTX+565, STARTY+ 91,  190, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_SEARCH_PHONE_EXN, 4,  ""),
		DLG_TEXT ( STARTX+755, STARTY+ 91,   55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTFRCOLOR, TXTINCTRLBK, ST_SEARCH_PHONE_NUM, "-"),
		DLG_EDIT ( STARTX+810, STARTY+ 91,  190, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_SEARCH_PHONE_NUM, 4,  ""),
		
		DLG_TEXT ( STARTX,     STARTY +91,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_NAME , "����"),
		DLG_BUTTON(STARTX+220, STARTY +91,  780, 60, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER  , BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SEARCH_WRITE_NAME,  ""),
		DLG_EDIT ( STARTX+220, STARTY +91,  780, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR    , PDAEDTCTRLBK  , EDT_SEARCH_NAME, 11,  ""),
		
		DLG_TEXT ( STARTX,     STARTY+151,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR , TXTCTRLBK     , ST_SEARCH_ADDR , "�˻�"),
		
		DLG_BUTTON(STARTX+220, STARTY+151,  580, 59, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER  , BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SEARCH_WRITE_ADDR,  ""),
		DLG_EDIT ( STARTX+220, STARTY+151,  580, 59, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_SEARCH_ADDR, 50,  ""),
		
		DLG_BUTTON(STARTX+800, STARTY+151,  200, 60, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH_CLEAR, "�ʱ�ȭ"),
		
		DLG_TEXT ( STARTX,     STARTY+211, 1000, 60, 0, 0, 0, EDITSTY_BORDER              , TXTFRCOLOR    , TXTINCTRLBK   , TXT_SEARCH_ADDR_EX , "��: �����ͳ� 111-105 �븲"),
		
		DLG_BUTTON(STARTX,     STARTY+271, 1000, 60, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH, "�� ��"),
		
		DLG_LINE ( STARTX,     STARTY+335, 1000, STARTY+335, DARKSLATEBLUE, 10, LINE_DATA5),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_SEARCH_TBLLIST, m_szTableBuf),
		
		DLG_BUTTON(STARTX+250, STARTY+339,  550, 55, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, TABCOLOR4, CALL_FUNC, "", BID_SEARCH_ADDR_CHG, "�ּ�"),
		
		DLG_LINE ( STARTX,     STARTY+836, 1000, STARTY+836, DARKSLATEBLUE, 10, LINE_DATA6),
		
		DLG_BUTTON(STARTX,     STARTY+840,  330, 59, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH_PAGE, m_szCnt_Search_page),
		DLG_BUTTON(STARTX+330, STARTY+840,  330, 59, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH_UP, "��"),
		DLG_BUTTON(STARTX+660, STARTY+840,  340, 59, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SEARCH_DOWN, "��"),
		
		//���� ����
		DLG_TEXT(0,   STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333, STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666, STARTY+540, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+630, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+720, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(0,   STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR    , TXTINCTRLBK   , TXT_KEY_EMPTY  , ""),
		DLG_TEXT(333, STARTY+810, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "��"),	
	};
	
	//---------------------------------------------------------------
	// �ǻ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes_RealUser[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�ǻ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY- 29,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR, TXTCTRLBK, ST_REAL_HP, "HP"),
		DLG_TEXT ( STARTX+220, STARTY- 29,  780, 60, 0, 0, 0, EDITSTY_BORDER              , TXTFRCOLOR    , TXTINCTRLBK   , TXT_REAL_HP, ""),
		 
		DLG_TEXT ( STARTX,     STARTY+ 31,  220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTTTLFRCOLOR, TXTCTRLBK, ST_REAL_USER, "�ǻ����"),
		DLG_COMBO (STARTX+220, STARTY+ 31,  290, 60, 115, 60, TXTFRCOLOR, PDAEDTCTRLBK    , CALL_FUNC, "", CMB_REAL_PHONE_DDD, 5), // DDD
		DLG_TEXT ( STARTX+510, STARTY+ 31,   55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTFRCOLOR, TXTINCTRLBK, ST_REAL_EXN, "-"),
		DLG_EDIT ( STARTX+565, STARTY+ 31,  190, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_REAL_PHONE_EXN, 4,  ""),
		DLG_TEXT ( STARTX+755, STARTY+ 31,   55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD , TXTFRCOLOR, TXTINCTRLBK, ST_REAL_NUM, "-"),
		DLG_EDIT ( STARTX+810, STARTY+ 31,  190, 60, 0, 0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, EDT_REAL_PHONE_NUM, 4,  ""),
		
		DLG_LINE ( STARTX,     STARTY+ 94, 1000, STARTY+94, DARKSLATEBLUE, 10, LINE_DATA7),
		
		DLG_BUTTON(STARTX,     STARTY+ 97,  330, 80, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_POPUP_CLOSE, "���"),
		DLG_BUTTON(STARTX+330, STARTY+ 97,  330, 80, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_REAL_SAVE, "����"),
		DLG_BUTTON(STARTX+660, STARTY+ 97,  340, 80, 0, 0, 0, BUTSTY_BORDER               , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_REAL_SMS, "SMS"),
		
		//���� ����
		DLG_TEXT(0,   STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333, STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666, STARTY+540, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+630, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+720, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(0,   STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR    , TXTINCTRLBK   , TXT_KEY_EMPTY  , ""),
		DLG_TEXT(333, STARTY+810, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "��"),
	};
	
	//---------------------------------------------------------------
	// ��ݳ��� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes_ChargeHist[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ݳ���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_TABLE (GRID_X2, GRID_Y2, ROW2, COL2, 0, GRID_H2, 1, GRID_H2, SEL_ROW, MAXCHAR2, m_stGridTitle2, ID_CHARGE_TBLLIST, m_szTableBuf2),
		
		DLG_LINE ( STARTX,     STARTY+ 815, 1000, STARTY+815, DARKSLATEBLUE, 10, LINE_DATA8),
		
		DLG_TEXT ( STARTX,     STARTY+ 820,  330, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_CHARGE_PAGE, m_szCnt_Charge_page),
		
		DLG_BUTTON(STARTX+330, STARTY+ 820,  330, 79, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHARGE_UP, "��"),
		DLG_BUTTON(STARTX+660, STARTY+ 820,  340, 79, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CHARGE_DOWN, "��"),
	};
	
	//---------------------------------------------------------------
	// �湮���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes_VisitHist[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�湮 ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_TABLE (GRID_X3, GRID_Y3, ROW3, COL3, 0, GRID_H3, 1, GRID_H_H3, SEL_ROW, MAXCHAR3, m_stGridTitle3, ID_VISIT_TBLLIST, m_szTableBuf3),
		
		DLG_LINE ( STARTX,     STARTY+ 815, 1000, STARTY+815, DARKSLATEBLUE, 10, LINE_DATA9),
		
		DLG_TEXT ( STARTX,     STARTY+ 819,  330, 80, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, TXT_VISIT_PAGE, m_szCnt_Visit_page ),
		
		DLG_BUTTON(STARTX+330, STARTY+ 819,  330, 80, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_VISIT_UP, "��"),
		DLG_BUTTON(STARTX+660, STARTY+ 819,  340, 80, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_VISIT_DOWN, "��"),
	};
	
	//---------------------------------------------------------------
	// �޸� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes_Memo[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�̵� ������ �޸�"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_BUTTON( STARTX,		STARTY- 29, 1000, 820, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MEMO_WRITE,  ""),	
		DLG_TEXT  ( STARTX,		STARTY- 29, 1000, 820, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_MEMO,  ""),
		
		DLG_LINE ( STARTX,     STARTY+ 796, 1000, STARTY+796, DARKSLATEBLUE, 10, LINE_DATA10),
		
		DLG_BUTTON( STARTX,		STARTY+800,  333, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE,  "���"),
		DLG_BUTTON( STARTX+333, STARTY+800,  333, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO_DEL,   "����"),	
		DLG_BUTTON( STARTX+666, STARTY+800,  334, 99, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO_SAVE,  "����"),	
	};
	
	//---------------------------------------------------------------
	// �߼۵�� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes_BillSendMethod[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�߼۵��"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_POPUP_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY- 29,   220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_BILL_SEND_REQ_NM, "��û��"),
		
		DLG_BUTTON(STARTX+220, STARTY- 29,   780, 59, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BILL_SEND_REQ_NM_WRITE,  ""),
		DLG_EDIT ( STARTX+220, STARTY- 29,   780, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_REQ_NM, 50,  ""),
		
		DLG_TEXT ( STARTX,     STARTY+ 31,   220, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_BILL_SEND_PHONE, "�ڵ���"),
		
		DLG_COMBO (STARTX+220, STARTY+ 31,   290, 59, 115, 59, TXTFRCOLOR, PDAEDTCTRLBK   , CALL_FUNC, "", CMB_BILL_SEND_PHONE_DDD, 5), // DDD
		DLG_TEXT ( STARTX+510, STARTY+ 31,    55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_BILL_SEND_EXN, "-"),
		DLG_EDIT ( STARTX+565, STARTY+ 31,   190, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_PHONE_EXN, 4,  ""),
		DLG_TEXT ( STARTX+755, STARTY+ 31,    55, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_BILL_SEND_NUM, "-"),
		DLG_EDIT ( STARTX+810, STARTY+ 31,   190, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_PHONE_NUM, 4,  ""),
		
		DLG_TEXT ( STARTX,     STARTY+ 91,   220, 120, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, ST_BILL_SEND_EMAIL1, "�̸���"),
		
		DLG_BUTTON(STARTX+220, STARTY+ 91,   662, 59, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BILL_SEND_EMAIL_WRITE,  ""),
		DLG_EDIT ( STARTX+220, STARTY+ 91,   662, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_EMAIL, 50,  ""),
		DLG_TEXT ( STARTX+882, STARTY+ 91,   118, 60, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, TXTINCTRLBK, ST_BILL_SEND_EMAIL2, "@"),
		
		DLG_BUTTON(STARTX+220, STARTY+ 151,  662, 59, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER , BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BILL_SEND_EMAIL_WRITE2,  ""),
		DLG_EDIT ( STARTX+220, STARTY+ 151,  662, 59, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER  , TXTFRCOLOR, PDAEDTCTRLBK, EDT_BILL_SEND_EMAIL2, 50,  ""),
		DLG_COMBO (STARTX+882, STARTY+ 151,  118, 60, 118, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BILL_SEND_EMAIL, 20), // �̸���
		
		DLG_LINE ( STARTX,     STARTY+ 215, 1000, STARTY+215, DARKSLATEBLUE, 10, LINE_DATA11),
		
		DLG_BUTTON(STARTX,     STARTY+ 220,  500, 80, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_POPUP_CLOSE, "���"),
		DLG_BUTTON(STARTX+500, STARTY+ 220,  500, 80, 0, 0, 0, BUTSTY_BORDER              , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_BILL_SEND_SAVE, "���"),
		
		//���� ����
		DLG_TEXT(0,   STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE  , "1"),
		DLG_TEXT(333, STARTY+540, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO  , "2"),
		DLG_TEXT(666, STARTY+540, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR , "4"),
		DLG_TEXT(333, STARTY+630, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE , "5"),
		DLG_TEXT(666, STARTY+630, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX  , "6"),
		DLG_TEXT(0,   STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+720, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+720, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE , "9"),
		DLG_TEXT(0,   STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR    , TXTINCTRLBK   , TXT_KEY_EMPTY  , ""),
		DLG_TEXT(333, STARTY+810, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO , "0"),
		DLG_TEXT(666, STARTY+810, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL  , "��"),
	};
	
	//---------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : OnInit
	��  �� : ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnInit(char bFirst)
	{
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			/********************************/
			/* �̵�������_����            */
			/********************************/
			case INIT_MAIN:
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				if( m_lInitRedraw == 0 )
				{
					if( m_lSearch_Move_flag == 0)
					{
						Snd_FR90001(g_szMC_InstPlaceNum);
					}
					else
					{
						Snd_FR90001(m_szInst_Place_Num);
					}
				}
				else
				{
					ReDraw();
				}
				
				break;
				
			/********************************/
			/* �̵�������_��ȸ            */
			/********************************/
			case INIT_SEARCH:
				CREATE_DIALOG_OBJECT (DlgRes_Search, SIZEOF(DlgRes_Search));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				ReDraw();
				TableDraw_Search(m_lSearch_Addr_Chg);
				break;
				
			/********************************/
			/* �̵�������_�ǻ����        */
			/********************************/
			case INIT_REALUSER:
				CREATE_DIALOG_OBJECT (DlgRes_RealUser, SIZEOF(DlgRes_RealUser));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				ReDraw();
				
				break;
				
			/********************************/
			/* �̵�������_��ݳ���        */
			/********************************/	
			case INIT_CHARGEHIST:
				CREATE_DIALOG_OBJECT (DlgRes_ChargeHist, SIZEOF(DlgRes_ChargeHist));
					
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				TableDraw_ChargeHist();
				
				break;
				
			/********************************/
			/* �̵�������_�湮����        */
			/********************************/
			case INIT_VISITHIST:
				CREATE_DIALOG_OBJECT (DlgRes_VisitHist, SIZEOF(DlgRes_VisitHist));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				TableDraw_VisitHist();
				
				break;
					
			/********************************/
			/* �̵�������_�޸�            */
			/********************************/
			case INIT_MEMO:
				CREATE_DIALOG_OBJECT (DlgRes_Memo, SIZEOF(DlgRes_Memo));
				
				SetBtnImg();
				SetStyle();
				ReDraw();
				break;
			
			/********************************/
			/* �̵�������_�߼۵��        */
			/********************************/	
			case INIT_BILL_SEND_METHOD:
				CREATE_DIALOG_OBJECT (DlgRes_BillSendMethod, SIZEOF(DlgRes_BillSendMethod));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				ReDraw();
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
		char szTmp[2000];
		
		switch(ID)
		{
			/****************************/
			/* �̵�������_����        */
			/****************************/
			// �ڷ� ����, ���
			case BID_CLOSE:
				if( m_lSearch_Move_flag == 0 )
				{
					Clear_Data();
					Back_Move_Card();
				}
				else
				{	
					Clear_RsltData();
					ON_EXIT();
					OnInit(INIT_SEARCH);
				}
				break;
			
			// ��ȸ
			case BID_INQUIRY:
				Save_Main_Combo();
				ON_EXIT();
				OnInit(INIT_SEARCH);
				break;
			
			// HP/TEL
			case BID_REAL_HP_TEL:
				// HP = 0, tel = 1, real = 2
				if( m_lReal_hp_tel == 0 )
				{
					m_lReal_hp_tel = 1;
				}
				else if( m_lReal_hp_tel == 1)
				{
					m_lReal_hp_tel = 2;
				}
				else
				{
					m_lReal_hp_tel = 0;
				}
				
				Save_Main_Combo();
				
				ReDraw();
				break;
			
			// ����
			case BID_HP_CHG:
				Save_Main_Combo();
				ON_EXIT();
				OnInit(INIT_REALUSER);
				break;
			
			// SMS
			case BID_HP_SMS:
				Snd_FR90007();
				break;
			
			// �̳����� ��
			case BID_UNPAY_MONTH:
				Save_Main_Combo();
				Snd_FR90002();
				break;
			
			// �߼۹�� ��	
			case BID_BILL_SEND_METHOD_DTL:
			    Set_Bill_Alarm();
			    break;
			
			// ���ι�� ��  
			case BID_PAY_METHOD_DTL:
				Set_Pay_Alarm();
				break;
			
			// �湮 ����
			case BID_VISIT:
				Save_Main_Combo();
				Snd_FR90003();
				break;
			
			// �޸�
			case BID_MEMO:
				Save_Main_Combo();
				ON_EXIT();
				OnInit(INIT_MEMO);
				break;
			
			// �޺� �߼۹��
			case BID_CMB_BILL_SEND_METHOD:
				Save_Main_Combo();
				ON_EXIT();
				OnInit(INIT_BILL_SEND_METHOD);
				break;
			
			// ���
			case BID_OK:
				if( m_lBldOk_flag == 0 )
				{
					Snd_FR90004();
				}
				else if( m_lBldOk_flag == 1 )
				{
					Save_Main_Combo();
					ON_EXIT();
					OnInit(INIT_BILL_SEND_METHOD);
				}
				
				break;
			
			// �����ư
			case BID_RSLT:
				MessageBoxEx (CONFIRM_OK, stMcMainInfo.VISIT_ETC);
				break;
			
			/********************************/
			/* �̵�������_��ȸ            */
			/********************************/
			// ��ȸ
			case BID_SEARCH:
				m_lSearch_page = 0;
				
				Snd_FR90006();
				
				break;
			
			// ��ȸ UP
			case BID_SEARCH_UP:
				m_lSearch_page--;
				
				if(m_lSearch_page < 0)
				{
					m_lSearch_page = 0;
				}
				
				TableDraw_Search(m_lSearch_Addr_Chg);
				
				break;
			
			// ��ȸ DOWN
			case BID_SEARCH_DOWN:
				m_lSearch_page++;
				if( m_lSearch_page > m_lSearch_Totpage-1 )
				{
					m_lSearch_page = m_lSearch_Totpage-1;
				}	
				
				TableDraw_Search(m_lSearch_Addr_Chg);
				
				break;
			
			// �ּ� CHG
			case BID_SEARCH_ADDR_CHG:
				
				if( m_lSearch_Addr_Chg == 0 )
				{
					m_lSearch_Addr_Chg = 1;
				}
				else
				{
					m_lSearch_Addr_Chg = 0;
				}
				
				TableDraw_Search(m_lSearch_Addr_Chg);
				break;
				
			// ��ȸ �ʱ�ȭ
			case BID_SEARCH_CLEAR:
				if( MessageBoxEx (CONFIRM_YESNO, "�˻� ������ �ʱ�ȭ �Ͻðڽ��ϱ�?") == MB_OK)
				{
					Mem_Set((byte*)stMcSearch.SEARCH_KEYWORD, 0x00, sizeof(stMcSearch.SEARCH_KEYWORD));
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_ADDR), "");
				}
				
				break;
				
			// ��ȸ �˻� �Է�
			case BID_SEARCH_WRITE_ADDR:
			
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_SEARCH_ADDR), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_ADDR)) );
				break;
			
			// ��ȸ ���� �Է�
			case BID_SEARCH_WRITE_NAME:
			
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_SEARCH_NAME), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_NAME)) );
				break;
			
			// ��ȸ ������
			case BID_SEARCH_PAGE:
				Quick_View_Search();
				break;
			
			// ��ȸ �ݱ�
			case BID_SEARCH_CLOSE:
				if( m_lSearch_Move_flag == 0)
				{
					m_lInitRedraw = 1;
					ON_EXIT();
					OnInit(INIT_MAIN);				
				}
				else
				{
					m_lSearch_Move_flag = 0;
					Clear_Data();
					Snd_FR90001(g_szMC_InstPlaceNum);
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				
				break;
			
			/********************************/
			/* �̵�������_�ǻ����        */
			/********************************/
			// �ǻ���� ����
			case BID_REAL_SAVE:
				Snd_FR90005();
				break;
			
			// �ǻ���� SMS
			case BID_REAL_SMS:
				Snd_FR90007();
				break;
			
			/********************************/
			/* �̵�������_��ݳ���        */
			/********************************/
			// ��� UP
			case BID_CHARGE_UP:
				m_lCharge_page--;
				
				if(m_lCharge_page < 0)
				{
					m_lCharge_page = 0;
				}
				
				TableDraw_ChargeHist();
				break;
			
			// ��� DOWN
			case BID_CHARGE_DOWN:
				m_lCharge_page++;
				if( m_lCharge_page > m_lCharge_Totpage-1 )
				{
					m_lCharge_page = m_lCharge_Totpage-1;
				}	
				
				TableDraw_ChargeHist();
				break;
			
			/********************************/
			/* �̵�������_�湮����        */
			/********************************/
			// �湮 UP	
			case BID_VISIT_UP:
				m_lVisit_page--;
				
				if(m_lVisit_page < 0)
				{
					m_lVisit_page = 0;
				}
				
				TableDraw_VisitHist();
				break;
				
			// �湮 DOWN
			case BID_VISIT_DOWN:
				m_lVisit_page++;
				
				if( m_lVisit_page > m_lVisit_Totpage-1 )
				{
					m_lVisit_page = m_lVisit_Totpage-1;
				}	
				
				TableDraw_VisitHist();
				break;

			/********************************/
			/* �̵�������_�޸�            */
			/********************************/
			// �޸� �Է�
			case BID_MEMO_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_MEMO), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_MEMO)) );
				break;
			
			// �޸� ����
			case BID_MEMO_SAVE:
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_MEMO)) );
				Save_Memo(szTmp);
				ReDraw();
				
				MessageBoxEx(CONFIRM_OK, "����Ǿ����ϴ�.");
				
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			// �޸� ����	
			case BID_MEMO_DEL:
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_MEMO), "");
				Save_Memo(szTmp);
				ReDraw();
				
				MessageBoxEx(CONFIRM_OK, "�����Ǿ����ϴ�.");
				break;
				
			/********************************/
			/* �̵�������_�߼۵��        */
			/********************************/
			// �߼۵�� ����
			case BID_BILL_SEND_SAVE:
				
				if( Validation() )
				{	
					Save_BillSend_Method();
					
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				
				break;
				
			// �߼۵�� ��û�ڸ�
			case BID_BILL_SEND_REQ_NM_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM)) );
				break;
			
			// �߼۵�� ����
			case BID_BILL_SEND_EMAIL_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL)) );
				break;
				
			// �߼۵�� ����2
			case BID_BILL_SEND_EMAIL_WRITE2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2)) );
				break;
			
			/****************************/
			/* ����                     */
			/****************************/
			// �ݱ�, �ڷΰ���
			case BID_POPUP_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;	
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect(long Index)
	{
		long index = -1;
		char szMsg[100];
		char szTmp[100];
		char szTmp2[100];
		char szTmp3[100];
		char szTmp4[100];
		long i;
		
		m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);			 
		
		/********************************/
		/* �̵�������_����            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD+1) )
			{
				SetCombo_Filter();
				ReDraw();
			}
		}
		/********************************/
		/* �̵�������_��ȸ            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_SEARCH_TYPE+1) )
			{
				SetCombo_Filter();
			}
			else if(DlgTbl_IsSelect(ID_SEARCH_TBLLIST))
			{
				if( g_Dlgflag == 0 )
				{
					return;
				}
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_SEARCH_TBLLIST);
				
				if( m_lAIarmIndex == index - 1 )
				{
					Mem_Set((byte*)m_szInst_Place_Num, 0x00, sizeof(m_szInst_Place_Num));
					Str_Cpy(m_szInst_Place_Num, DlgTbl_GetStr( ID_SEARCH_TBLLIST, m_lAIarmIndex, 3 ) );
					
					Clear_RsltData();
					
					m_lInitRedraw = 0;
					m_lSearch_Move_flag = 1;
					
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				else
				{	
					m_lAIarmIndex = index - 1;
				}
			}
		}
		/********************************/
		/* �̵�������_��ݳ���        */
		/********************************/
		else if( m_bFirst == INIT_CHARGEHIST )
		{
			if (DlgTbl_IsSelect(ID_CHARGE_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_CHARGE_TBLLIST);
				
				if( m_lAIarmIndex == index - 1 )
				{
					if( Str_Cmp( DlgTbl_GetStr( ID_CHARGE_TBLLIST, m_lAIarmIndex, 4 ), "�̳�") != 0 )
					{
						Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
						Str_Cpy( szMsg, "�������� : " );
						
						Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
						Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
						Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3));
						Mem_Set((byte*)szTmp4, 0x00, sizeof(szTmp4));
						
						Str_Cpy( szTmp, DlgTbl_GetStr( ID_CHARGE_TBLLIST, m_lAIarmIndex, 6 ) );
						
						Mem_Cpy( (byte*)szTmp2, (byte*)szTmp, 4 );
						Mem_Cpy( (byte*)szTmp3, (byte*)szTmp+4 , 2 );
						Mem_Cpy( (byte*)szTmp4, (byte*)szTmp+6 , 2 );
						
						Str_Cat( szMsg, szTmp2 );
						Str_Cat( szMsg, "�� " );
						Str_Cat( szMsg, szTmp3 );
						Str_Cat( szMsg, "�� " );
						Str_Cat( szMsg, szTmp4 );
						Str_Cat( szMsg, "��" );
						
						Str_Cat( szMsg, "\n���ι�� : " );
						Str_Cat( szMsg, DlgTbl_GetStr( ID_CHARGE_TBLLIST, m_lAIarmIndex, 5 ) );
					
						MessageBoxEx (CONFIRM_OK, szMsg);
					}
				}
				else
				{	
					m_lAIarmIndex = index - 1;
				}
			}
		}
		/********************************/
		/* �̵�������_�湮����        */
		/********************************/
		else if( m_bFirst == INIT_VISITHIST )
		{
			if (DlgTbl_IsSelect(ID_VISIT_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_VISIT_TBLLIST);
				
				if( m_lAIarmIndex == index - 1 )
				{
					if( Str_Cmp( DlgTbl_GetStr( ID_VISIT_TBLLIST, m_lAIarmIndex, 3 ), "") != 0 )
					{
						Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
						Str_Cat( szMsg, DlgTbl_GetStr( ID_VISIT_TBLLIST, m_lAIarmIndex, 3 ) );
					
						MessageBoxEx (CONFIRM_OK, szMsg);
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "�޸� ����");
					}
				}
				else
				{	
					m_lAIarmIndex = index - 1;
				}
			}
		}
		/********************************/
		/* �̵�������_�߼۵��        */
		/********************************/
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL+1) )
			{
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				
				Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_BILL_SEND_EMAIL) ) );
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2),  szTmp);
			}
		}
		
		ON_DRAW();
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
			
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( POINTING_UP == nAction )
		{	
			/********************************/
			/* �̵�������_��ȸ            */
			/********************************/
			if( m_bFirst == INIT_SEARCH )
			{
				if( X > DMS_X(STARTX+220) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+100) 
				 || X > DMS_X(STARTX+565) && X < DMS_X(STARTX+755) && Y > DMS_Y(STARTY+91) && Y < DMS_Y(STARTY+151)
				 || X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+91) && Y < DMS_Y(STARTY+151) )
				{	
					if( Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM) == lActiveIndex 
					 || Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN) == lActiveIndex
					 || Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM) == lActiveIndex )
					{
						g_Dlgflag = 0;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_PAGE), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_PAGE), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_UP), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_UP), TRUE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_DOWN), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_DOWN), TRUE );
					}
				}
				else
				{	
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_KEY( 5 );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else
					{	
						g_Dlgflag = 1;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_PAGE), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_PAGE), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_UP), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_UP), FALSE );
						
						DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_DOWN), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SEARCH_DOWN), FALSE );
					}
				}
			}
			/********************************/
			/* �̵�������_�ǻ����        */
			/********************************/
			else if( m_bFirst == INIT_REALUSER )
			{
				if( X > DMS_X(STARTX+565) && X < DMS_X(STARTX+755) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+91) 
				 || X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+91) )
				{	
					if( Get_iDlgCtrlByID(EDT_REAL_PHONE_EXN) == lActiveIndex
					 || Get_iDlgCtrlByID(EDT_REAL_PHONE_NUM) == lActiveIndex )
					{
						g_Dlgflag = 0;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), TRUE );
					}
				}
				else
				{	
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_KEY( 5 );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else
					{	
						g_Dlgflag = 1;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
					}
				}
			}
			/********************************/
			/* �̵�������_�߼۵��        */
			/********************************/
			else if( m_bFirst == INIT_BILL_SEND_METHOD )
			{
				if( X > DMS_X(STARTX+565) && X < DMS_X(STARTX+755) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+91) 
				 || X > DMS_X(STARTX+810) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+31) && Y < DMS_Y(STARTY+91) )
				{	
					if( Get_iDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN) == lActiveIndex
					 || Get_iDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM) == lActiveIndex )
					{
						g_Dlgflag = 0;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), TRUE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), TRUE );
					}
				}
				else
				{	
					if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '1' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '2' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+540) && Y < DMS_Y(STARTY+630) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '3' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '4' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '5' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+630) && Y < DMS_Y(STARTY+720) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '6' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '7' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '8' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+720) && Y < DMS_Y(STARTY+810) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '9' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_CHAR( '0' );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+810) && Y < DMS_Y(STARTY+890) )
					{
						if ( g_Dlgflag == 0 )
						{
							ON_KEY( 5 );
							VM_PlaySound(CLICKSOUND);
						}
					}
					else
					{	
						g_Dlgflag = 1;
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL), FALSE );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
					}
				}
			}	
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : OnChar
	��  �� : ��ȭ��ȣ ĭ �ڵ����� �Ѿ�� ��
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar(long nChar)
	{
		long lActiveIndex = -1;
		char szTmp[100];
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		/********************************/
		/* �̵�������_��ȸ            */
		/********************************/
		if( m_bFirst == INIT_SEARCH )
		{
			if( Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM) == lActiveIndex )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM)));
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				
				if( Str_Len(szTmp) == 5 )
				{
					Str_Cat(szTmp, "-");
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), szTmp);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_EXN))) == 4 )
			{
				lActiveIndex = Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM);
				Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
			}
		}
		/********************************/
		/* �̵�������_�ǻ����        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			if( Get_iDlgCtrlByID(EDT_REAL_PHONE_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN))) == 4 )
			{
				lActiveIndex = Get_iDlgCtrlByID(EDT_REAL_PHONE_NUM);
				Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
			}	
		}
		/********************************/
		/* �̵�������_�߼۵��        */
		/********************************/	
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			if( Get_iDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN) == lActiveIndex && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN))) == 4 )
			{
				lActiveIndex = Get_iDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM);
				Dialog_SetActiveCtrl(this->m_hDlg, lActiveIndex);
			}
		}
	}
	
	//---------------------------------------------------------------
	// �Ϲ� FUCTION
	//---------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : BUTTON IMAGE
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage( Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE );
	}
	
	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{	
		/********************************/
		/* �̵�������_����            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_USE_CONT_NUM)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USE_CONT_NUM)    	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USE_CONT_DOC)    	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PHONE_NUM)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_DEADLINE)   		 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DEADLINE)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_GMTR_METHOD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GMTR_METHOD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_PAY_METHOD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_METHOD) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_UNPAY_MONTH)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_UNPAY_AMT)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_VISIT_TYPE)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_YMD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_TYPE)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_RESULT)    	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CMB_REFUSE)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CMB_PAY_METHOD)	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CMB_SELF_GMTR)    	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_CMB_USE_CONT)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_REFUSE)   		 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_PAY_METHOD)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SELF_GMTR)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_USE_CONT)   	 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_RESULT)    	, EDITALIGN_MIDDLE|EDITALIGN_LEFT );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_VISIT_RESULT) 	, TRUE, 2, EDITSEP_NONE );
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
		}
		/********************************/
		/* �̵�������_��ȸ            */
		/********************************/
		else if ( m_bFirst == INIT_SEARCH )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_TYPE)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_ADDR_TYPE)	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_CITY)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_CITY2)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_ADDR)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_USE_CONT) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_NAME) 		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_PHONE) 		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_PHONE_EXN) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_SEARCH_PHONE_NUM) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SEARCH_ADDR_EX) 	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_TYPE)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE)   , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_CITY)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_CITY2)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD)	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(ST_SEARCH_USE_CONT), TRUE, 2, EDITSEP_NONE );
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), FALSE);
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), FALSE);
			
			// ������
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EMPTY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
		}
		/********************************/
		/* �̵�������_�ǻ����        */
		/********************************/
		else if ( m_bFirst == INIT_REALUSER )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_REAL_HP)   			, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REAL_HP)   			, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_REAL_USER)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_REAL_EXN)   			, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_REAL_NUM)   			, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			
			// ������
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EMPTY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
		}
		/********************************/
		/* �̵�������_��ݳ���        */
		/********************************/
		else if ( m_bFirst == INIT_CHARGEHIST )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHARGE_PAGE)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		}
		/********************************/
		/* �̵�������_�湮����        */
		/********************************/
		else if ( m_bFirst == INIT_VISITHIST )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VISIT_PAGE)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		}
		/********************************/
		/* �̵�������_�޸�            */
		/********************************/
		else if ( m_bFirst == INIT_MEMO )
		{
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(EDT_MEMO), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetEditableMode( Get_hDlgCtrlByID(EDT_MEMO), EDITMODE_HANGUL );
			EditCtrl_SetMaxChar(Get_hDlgCtrlByID(EDT_MEMO), 1000);
		}
		/********************************/
		/* �̵�������_�߼۵��        */
		/********************************/
		else if ( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_REQ_NM)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_PHONE)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD)   	, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_EXN)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_NUM)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_EMAIL1)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_BILL_SEND_EMAIL2)   		, EDITALIGN_MIDDLE|EDITALIGN_CENTER );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BILL_SEND_EMAIL)   		, EDITALIGN_MIDDLE );
			
			// ������
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ONE)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_TWO)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_THREE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FOUR) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_FIVE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SIX)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_SEVEN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EIGHT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_NINE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_ZERO) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_DEL)  , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KEY_EMPTY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ONE)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_TWO)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_THREE), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FOUR) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_FIVE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SIX)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_SEVEN), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EIGHT), FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_NINE) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_ZERO) , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_DEL)  , FALSE );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_KEY_EMPTY), FALSE );
			
			if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20" ) == 0 )
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_BILL_SEND_EMAIL1), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_BILL_SEND_EMAIL2), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_BILL_SEND_EMAIL), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL+1), FALSE);	
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_BILL_SEND_EMAIL_WRITE), FALSE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_BILL_SEND_EMAIL2), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_BILL_SEND_EMAIL_WRITE2), FALSE);
			}
			else if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 )
			{
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_BILL_SEND_EMAIL1), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_BILL_SEND_EMAIL2), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_BILL_SEND_EMAIL), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL), TRUE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_EMAIL+1), TRUE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_BILL_SEND_EMAIL_WRITE), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_BILL_SEND_EMAIL2), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_BILL_SEND_EMAIL_WRITE2), TRUE);
			}	
		}
	}
		
	/*=======================================================================================
	�Լ��� : SetCombo
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i;
		
		/********************************/
		/* �̵�������_����            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// �߼۹��
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD+2 ) );
			
			for ( i = 0 ;  MC_BILL_SEND_METHOD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD+2), MC_BILL_SEND_METHOD[i].Str, 0, ICON_NONE);
			}

			// �ź�
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_REFUSE+2 ) );
			
			for ( i = 0 ;  MC_REFUSE[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_REFUSE+2), MC_REFUSE[i].Str, 0, ICON_NONE);
			}
			
			// ���ι��
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_PAY_METHOD+2 ) );
			
			for ( i = 0 ;  MC_PAY_METHOD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_PAY_METHOD+2), MC_PAY_METHOD[i].Str, 0, ICON_NONE);
			}
			
			// �ڰ���ħ
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SELF_GMTR+2 ) );
			
			for ( i = 0 ;  MC_SELF_GMTR[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SELF_GMTR+2), MC_SELF_GMTR[i].Str, 0, ICON_NONE);
			}
			
			// �����
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_USE_CONT+2 ) );
			
			for ( i = 0 ;  MC_USE_CONT[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_USE_CONT+2), MC_USE_CONT[i].Str, 0, ICON_NONE);
			}
		}
		/********************************/
		/* �̵�������_��ȸ            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			// ����
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2), "�ּ�", 0, ICON_NONE);
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2), "������ȣ", 0, ICON_NONE);
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2), "��ȭ��ȣ", 0, ICON_NONE);
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_TYPE+2), "����", 0, ICON_NONE);
			
			// �ּ� ����
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+2 ) );
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+2), "����", 0, ICON_NONE);
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+2), "���θ�", 0, ICON_NONE);
			
			// ��/��
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_CITY2+2 ) );
			for ( i = 0 ;  MC_NEW_ADDR[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SEARCH_CITY2+2), MC_NEW_ADDR[i].Str, 0, ICON_NONE);
			}
			
			// ��ȭ��ȣ
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD+2 ) );
			for ( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
		}
		/********************************/
		/* �̵�������_�ǻ����        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			//�ڵ���
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD+2 ) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_REAL_PHONE_DDD+2);
		}
		/********************************/
		/* �̵�������_�߼۵��        */
		/********************************/
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			//�ڵ���
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD+2 ) );
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_BILL_SEND_PHONE_DDD+2);
			
			//�����ּ�
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_BILL_SEND_EMAIL+2 ) );
			for ( i = 0 ;  MC_EMAIL_ADDR[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BILL_SEND_EMAIL+2), MC_EMAIL_ADDR[i].Str, 0, ICON_NONE);
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : ReDraw
	��  �� : ȭ���� �ٽ� �׸���.
	Param  : 
	Return : 
	========================================================================================*/
	void ReDraw(void)
	{	
	 	char szTmp[100];
	 	char szTmp2[100];
	 	char szTmp3[100];
	 	long i;
	 	
		/********************************/
		/* �̵�������_����            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			/********* ������ȣ *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
			Mem_Cpy( (byte*)szTmp, (byte*)stMcMainInfo.USE_CONT_NUM , 5 );
			Mem_Cpy( (byte*)szTmp2, (byte*)stMcMainInfo.USE_CONT_NUM+5 , 5 );
			
			Str_Cpy(szTmp, szTmp);
			Str_Cat(szTmp, "-");
			Str_Cat(szTmp, szTmp2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_USE_CONT_NUM), szTmp );
			
			/********* ����༭ �ۼ� ���� *********/
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_USE_CONT_DOC), stMcMainInfo.USE_CONT_DOC_YN );
			
			/********* HP OR TEL / SMS��ư *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			
			// HP
			if( m_lReal_hp_tel == 0 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_REAL_HP_TEL), "HP");
				
				Str_Cpy( szTmp, stMcMainInfo.CP_DDD);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.CP_EXN);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.CP_NUM);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), FALSE );
			}
			// TEL
			else if( m_lReal_hp_tel == 1 )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_REAL_HP_TEL), "TEL");
				
				Str_Cpy( szTmp, stMcMainInfo.OWNHOUSE_TEL_DDD);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.OWNHOUSE_TEL_EXN);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.OWNHOUSE_TEL_NUM);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), TRUE );	
			}
			// REAL
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_REAL_HP_TEL), "�ǻ��");
				
				Str_Cpy( szTmp, stMcMainInfo.REAL_CP_DDD);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.REAL_CP_EXN);
				Str_Cat( szTmp, "-" );
				Str_Cat( szTmp, stMcMainInfo.REAL_CP_NUM);
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_HP_SMS), FALSE );
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_PHONE_NUM), szTmp);
			
			/********* ������ *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			
			Str_Cpy( szTmp, stMcMainInfo.DEADLINE_FLAG);
			Str_Cat( szTmp, "����" );
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DEADLINE), szTmp);
			
			/********* ��ħ��� *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_GMTR_METHOD), stMcMainInfo.GMTR_METHOD_NM);
			
			/********* �߼۹�� *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_BILL_SEND_METHOD), stMcMainInfo.BILL_SEND_METHOD_NM);
			
			/********* �߼۹�� �� *********/
			if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "10") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL_SEND_METHOD_DTL), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL_SEND_METHOD_DTL), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL_SEND_METHOD_DTL), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BILL_SEND_METHOD_DTL), FALSE );
			}
			
			/********* ���ι�� �� *********/
			if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "10") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY_METHOD_DTL), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY_METHOD_DTL), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY_METHOD_DTL), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PAY_METHOD_DTL), FALSE );
			}
			
			/********* ���ι�� *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_PAY_METHOD), stMcMainInfo.PAY_METHOD_NM);
			
			/********* �̳����� *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			
			Str_Cpy( szTmp, stMcMainInfo.UNPAY_MONTH);
			Str_Cat( szTmp, "����" );
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_UNPAY_MONTH), szTmp);
			
			/********* �̳��ݾ� *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
			
			Str_Cpy( szTmp, stMcMainInfo.UNPAY_AMT);
			Str_Chg( szTmp, STRCHG_INS_COMMA );
			Str_Cat( szTmp, "��" );
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_UNPAY_AMT), szTmp);
			
			/********* �湮��ư *********/
			if( Str_Cmp( stMcMainInfo.VISIT_YMD, "" ) == 0 )
			{
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIT), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIT), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIT), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_VISIT), FALSE );
			}
			
			/********* �湮���� *********/
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Mem_Cpy((byte*)szTmp, (byte*)stMcMainInfo.VISIT_YMD, 4);
			Str_Cat(szTmp, "-");
			
			Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
			Mem_Cpy((byte*)szTmp2, (byte*)stMcMainInfo.VISIT_YMD+4, 2);
			Str_Cat(szTmp, szTmp2);
			Str_Cat(szTmp, "-");
			
			Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3));
			Mem_Cpy((byte*)szTmp3, (byte*)stMcMainInfo.VISIT_YMD+6, 2);
			Str_Cat(szTmp, szTmp3);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_VISIT_YMD), szTmp);
			
			/********* ���� *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_VISIT_TYPE), stMcMainInfo.VISIT_TYPE_NM);
			
			/********* �����ư *********/
			if( Str_Cmp( stMcMainInfo.VISIT_ETC, "") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_RSLT), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_RSLT), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_RSLT), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_RSLT), FALSE );
			}
			
			/********* ��� *********/
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_VISIT_RESULT), stMcMainInfo.VISIT_RESULT);
				
			/********* �߼۹�� ��ư ���� *********/
			if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20") == 0 ) // LMS
			{
				if( Str_Cmp(stMcMainRslt.REQ_NM, "") != 0 
				 && Str_Cmp(stMcMainRslt.REQ_LMS_DDD, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_LMS_EXN, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_LMS_NUM, "") != 0 )
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), RED);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);	
					
					m_lBldOk_flag = 0;
				}
				else
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), GREEN);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);
					
					m_lBldOk_flag = 1;
				}	
			}
			else if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30") == 0 ) // EMAIL
			{
				if( Str_Cmp(stMcMainRslt.REQ_NM, "") != 0 
				 && Str_Cmp(stMcMainRslt.REQ_LMS_DDD, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_LMS_EXN, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_LMS_NUM, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_EMAIL, "") != 0
				 && Str_Cmp(stMcMainRslt.REQ_EMAIL_ADDR, "") != 0 )
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), RED);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);	
					
					m_lBldOk_flag = 0;
				}
				else
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), GREEN);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);
					
					m_lBldOk_flag = 1;
				}
			}
			else
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), BTNMENUFRCOLOR);
				
				m_lBldOk_flag = 1;
			}
			
			/********* �޸� ��ư ���� *********/
			if( Str_Cmp(stMcMainRslt.ETC, "") != 0 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MEMO), RED);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNMENUFRCOLOR);	
			}
			else
			{	
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNMENUFRCOLOR);
			}
			
			/********* �߼۹�� �޺��ڽ� *********/	
			if( Str_Cmp(stMcMainRslt.CMB_BILL_SEND_METHOD, "") == 0 )
			{
				if( Str_Cmp(stMcMainInfo.BILL_SEND_METHOD_CD, "10") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "�۴�");
				}
				else if( Str_Cmp(stMcMainInfo.BILL_SEND_METHOD_CD, "40") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "����");
				}
				else if( Str_Cmp(stMcMainInfo.BILL_SEND_METHOD_CD, "70") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "LMS");
				}
				else if( Str_Cmp(stMcMainInfo.BILL_SEND_METHOD_CD, "80") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "������");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), stMcMainInfo.BILL_SEND_METHOD_NM);
				}
			}
			else
			{
				i = g_SearchCD( stMcMainRslt.CMB_BILL_SEND_METHOD, MC_BILL_SEND_METHOD );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), MC_BILL_SEND_METHOD[i].Str);
				}
				
				i = g_SearchCD( stMcMainRslt.CMB_REFUSE, MC_REFUSE );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REFUSE), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REFUSE), MC_REFUSE[i].Str);
				}
				
				i = g_SearchCD( stMcMainRslt.CMB_PAY_METHOD, MC_PAY_METHOD );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD), MC_PAY_METHOD[i].Str);
				}
				
				i = g_SearchCD( stMcMainRslt.CMB_SELF_GMTR, MC_SELF_GMTR );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELF_GMTR), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELF_GMTR), MC_SELF_GMTR[i].Str);
				}
				
				i = g_SearchCD( stMcMainRslt.CMB_USE_CONT, MC_USE_CONT );
				
				if( i == -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_USE_CONT), "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_USE_CONT), MC_USE_CONT[i].Str);
				}
			}
			
			SetCombo_Filter();
			
			/********* ��� ��ư *********/
			// SetCombo_Filter()�ȿ� m_lBldOk_flag ������ �����Ƿ� SetCombo_Filter() ���� ��� ��ư ������ �־����
			if( m_lBldOk_flag == 0 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_OK), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_OK), BTNMENUFRCOLOR);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_OK), "���");
			}
			else if( m_lBldOk_flag == 1 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_OK), GREEN);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_OK), BTNMENUFRCOLOR);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_OK), "�߼۵��");
			}
		}
		/********************************/
		/* �̵�������_��ȸ            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			if( Str_Cmp(stMcSearch.SEARCH_TYPE, "�ּ�" ) == 0 )
			{	
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), stMcSearch.SEARCH_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), stMcSearch.SEARCH_ADDR_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY), stMcSearch.SEARCH_CITY);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_ADDR), stMcSearch.SEARCH_KEYWORD);
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "������ȣ" ) == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), stMcSearch.SEARCH_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), stMcSearch.SEARCH_USE_CONT_NUM);
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "��ȭ��ȣ" ) == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), stMcSearch.SEARCH_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY2), stMcSearch.SEARCH_CITY2);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD), stMcSearch.SEARCH_PHONE_DDD);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_EXN), stMcSearch.SEARCH_PHONE_EXN);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_NUM), stMcSearch.SEARCH_PHONE_NUM);
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "����" ) == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), stMcSearch.SEARCH_TYPE);
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY2), stMcSearch.SEARCH_CITY2);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_SEARCH_NAME), stMcSearch.SEARCH_NAME);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE), "������ȣ");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), "���θ�");
			}
			
			SetCombo_Filter();
		}
		/********************************/
		/* �̵�������_�ǻ����        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy( szTmp, stMcMainInfo.CP_DDD);
			Str_Cat( szTmp, "-" );
			Str_Cat( szTmp, stMcMainInfo.CP_EXN);
			Str_Cat( szTmp, "-" );
			Str_Cat( szTmp, stMcMainInfo.CP_NUM);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_REAL_HP), szTmp);
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD), stMcMainInfo.REAL_CP_DDD);
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN), stMcMainInfo.REAL_CP_EXN);
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_NUM), stMcMainInfo.REAL_CP_NUM);
		}
		/********************************/
		/* �̵�������_�޸�            */
		/********************************/
		else if( m_bFirst == INIT_MEMO )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_MEMO), stMcMainRslt.ETC );
		}
		/********************************/
		/* �̵�������_�߼۵��        */
		/********************************/
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{	
			// ��û�� ��
			if( Str_Cmp( stMcMainRslt.REQ_NM, "" ) != 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM), stMcMainRslt.REQ_NM);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM), stMcMainInfo.CUST_NM);
			}
			
			// �ڵ��� DDD
			if( Str_Cmp( stMcMainRslt.REQ_LMS_DDD, "" ) != 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD), stMcMainRslt.REQ_LMS_DDD);
			}
			else
			{
				if( Str_Cmp( stMcMainInfo.REAL_CP_DDD, "") != 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD), stMcMainInfo.REAL_CP_DDD);
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD), stMcMainInfo.CP_DDD);
				}
			}
			
			// �ڵ��� EXN
			if( Str_Cmp( stMcMainRslt.REQ_LMS_EXN, "" ) != 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN), stMcMainRslt.REQ_LMS_EXN);
			}
			else
			{
				if( Str_Cmp( stMcMainInfo.REAL_CP_EXN, "") != 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN), stMcMainInfo.REAL_CP_EXN);
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN), stMcMainInfo.CP_EXN);
				}
			}
			
			// �ڵ��� NUM
			if( Str_Cmp( stMcMainRslt.REQ_LMS_NUM, "" ) != 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM), stMcMainRslt.REQ_LMS_NUM);
			}
			else
			{
				if( Str_Cmp( stMcMainInfo.REAL_CP_NUM, "") != 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM), stMcMainInfo.REAL_CP_NUM);
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM), stMcMainInfo.CP_NUM);
				}
			}
			
			// EMAIL
			if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL), stMcMainRslt.REQ_EMAIL);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2), stMcMainRslt.REQ_EMAIL_ADDR);
			}
		}
		
		ON_DRAW();
	}
		
	/*=======================================================================================
	�Լ��� : TableDraw_VisitHist
	��  �� : �湮�̷� ȭ�� ���̺� Draw
	Param  : 
	Return : 
	========================================================================================*/	
	void TableDraw_VisitHist(void)
	{
		long i, idx;
		long k = 4;
		char szTmp[500];
		char szTmp2[50];
		char szTmp3[50];
		char szTmp4[50];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		
		/************************************/
		/* ���� �ʱ�ȭ                      */
		/************************************/
		m_lAIarmIndex = -1;
		
		/************************************/
		/* Page Setting                     */
		/************************************/
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lVisit_Totpage );
		
		if( m_lVisit_Totpage % ROW3 > 0 )
		{
			m_lVisit_Totpage = (m_lVisit_Totpage / ROW3) + 1;
		}
		else
		{
			m_lVisit_Totpage = m_lVisit_Totpage / ROW3;
		}

		Mem_Set( (byte*)m_szCnt_Visit_page, 0x00, sizeof(m_szCnt_Visit_page) );
		SPRINT(m_szCnt_Visit_page, "%d/%d", m_lVisit_page+1, m_lVisit_Totpage, 0);

		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		// PARAM1 : visit_ymd, PARAM2 : seq, PARAM3 : visit_type, PARAM4 : visit_result, PARAM5 : visit_etc
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM3, PARAM4, PARAM5 FROM RCV_TMP ORDER BY PARAM1 DESC, PARAM2 DESC LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		
		lstartidx = m_lVisit_page * ROW3;
		
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		
		i = m_lVisit_page * ROW3 + ROW3;
		
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for(i = 0 ; i < ROW3 ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 3, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 3, "" );
					continue;
				}
				
				idx = 0;
				
				// �湮����
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
				Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3));
				Mem_Set((byte*)szTmp4, 0x00, sizeof(szTmp4));
				
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 10, DECRYPT);
				
				Mem_Cpy( (byte*)szTmp2, (byte*)szTmp, 4 );
				Mem_Cpy( (byte*)szTmp3, (byte*)szTmp+4 , 2 );
				Mem_Cpy( (byte*)szTmp4, (byte*)szTmp+6 , 2 );
				
				Str_Cpy(szTmp, szTmp2);
				Str_Cat(szTmp, "��\n");
				Str_Cat(szTmp, szTmp3);
				Str_Cat(szTmp, "�� ");
				Str_Cat(szTmp, szTmp4);
				Str_Cat(szTmp, "��");
				
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 0, szTmp );

				// ����
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 1, szTmp );
				
				// ���
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 2, szTmp );
				
				// �޸�
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 500, DECRYPT);
				DlgTbl_SetStr ( ID_VISIT_TBLLIST, i, 3, szTmp );
			}
		}
				
Finally:
		DelSqLite(sql);
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : TableDraw_ChargeHist
	��  �� : ��ݳ��� ȭ�� ���̺� Draw
	Param  : 
	Return : 
	========================================================================================*/	
	void TableDraw_ChargeHist(void)
	{
		long i, idx;
		long k = 9;
		char szTmp[200];
		char szTmp2[50];
		char szTmp3[50];
		char szTmp4[50];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		
		/************************************/
		/* ���� �ʱ�ȭ                      */
		/************************************/
		m_lAIarmIndex = -1;
		
		/************************************/
		/* Page Setting                     */
		/************************************/
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lCharge_Totpage );
		
		if( m_lCharge_Totpage % ROW2 > 0 )
		{
			m_lCharge_Totpage = (m_lCharge_Totpage / ROW2) + 1;
		}
		else
		{
			m_lCharge_Totpage = m_lCharge_Totpage / ROW2;
		}
		
		Mem_Set( (byte*)m_szCnt_Charge_page, 0x00, sizeof(m_szCnt_Charge_page) );
		SPRINT(m_szCnt_Charge_page, "%d/%d", m_lCharge_page+1, m_lCharge_Totpage, 0);
		
		/************************************/
		/* ���̺� ONDRAW                    */
		/************************************/
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		// param1 : requestYm, param2 : indicatorQty, param3 : usageQty
		// param4 : chargeAmt, param5 : paymentFlag, param6 : paymentType, param7 : payDate
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, PARAM6, PARAM7 FROM RCV_TMP ORDER BY PARAM1 DESC LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		
		lstartidx = m_lCharge_page * ROW2;
		
		sql->Bind(sql, idx++, 'X', &lstartidx, 9, DECRYPT);
		
		i = m_lCharge_page * ROW2 + ROW2;
		
		sql->Bind(sql, idx++, 'X', &i, 9, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for(i = 0 ; i < ROW2 ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 5, "" );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 6, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 3, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 4, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 5, "" );
					DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 6, "" );
					continue;
				}
				
				idx = 0;
				
				// û�����
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
				Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3));
				
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 10, DECRYPT);
				
				Mem_Cpy( (byte*)szTmp2, (byte*)szTmp, 4 );
				Mem_Cpy( (byte*)szTmp3, (byte*)szTmp+4 , 2 );
				Str_Cpy(szTmp, szTmp2);
				Str_Cat(szTmp, "\n - ");
				Str_Cat(szTmp, szTmp3);
				
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 0, szTmp );

				// ��ħ
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 10, DECRYPT);
				Str_Chg( szTmp, STRCHG_INS_COMMA );
				
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 1, szTmp );
				
				// ��뷮
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				Str_Chg( szTmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 2, szTmp );
				
				// û���ݾ�
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				Str_Chg( szTmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 3, szTmp );
				
				// ����
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 4, szTmp );
				
				// ���ι��
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 5, szTmp );
				
				// ��������
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_CHARGE_TBLLIST, i, 6, szTmp );
				
			}
		}
				
Finally:
		DelSqLite(sql);
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : TableDraw_Search
	��  �� : ��ȸ ȭ�� ���̺� Draw
	Param  : flag : 0 = ����, 1= ���θ�
	Return : 
	========================================================================================*/	
	void TableDraw_Search(long flag)
	{
		long i, idx;
		long k = 4;
		char szTmp[1000];
		char szTmp2[100];
		char szTmp3[100];
		long ret = -1;	
		long lstartidx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		
		/************************************/
		/* ���� �ʱ�ȭ                      */
		/************************************/
		m_lAIarmIndex = -1;
		
		/************************************/
		/* Page Setting                     */
		/************************************/
		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_RELEASE", &m_lSearch_Totpage );
		
		if( m_lSearch_Totpage % ROW > 0 )
		{
			m_lSearch_Totpage = ( m_lSearch_Totpage / ROW ) + 1;
		}
		else
		{
			m_lSearch_Totpage = m_lSearch_Totpage / ROW;
		}
		
		Mem_Set( (byte*)m_szCnt_Search_page, 0x00, sizeof(m_szCnt_Search_page) );
		SPRINT(m_szCnt_Search_page, "%d/%d", m_lSearch_page+1, m_lSearch_Totpage, 0);
		
		/************************************/
		/* ���̺� ONDRAW                    */
		/************************************/
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		// param1 : inst_place_num, param2 : use_cont_num, param3 : cust_nm, param4 : curr_addr_union, param5 : new_addr_union
		if( flag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SEARCH_ADDR_CHG), "�����ּ�");
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM4, PARAM3, PARAM1 FROM RCV_RELEASE ORDER BY PARAM4 LIMIT  ?, ? " );
		}
		else if( flag == 1 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SEARCH_ADDR_CHG), "���θ��ּ�");
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM5, PARAM3, PARAM1 FROM RCV_RELEASE ORDER BY PARAM5 LIMIT  ?, ? " );
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SEARCH_ADDR_CHG), "�ּ�");
			hstmt = sql->CreateStatement(sql, "SELECT PARAM2, PARAM4, PARAM3, PARAM1 FROM RCV_RELEASE LIMIT ?, ? " );
		}
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		idx = 0;
		
		lstartidx = m_lSearch_page * ROW;
		
		sql->Bind(sql, idx++, 'X', &lstartidx, 3, DECRYPT);
		
		i = m_lSearch_page * ROW + ROW;
		
		sql->Bind(sql, idx++, 'X', &i, 3, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for(i = 0 ; i < ROW ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 3, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 2, "" );
					DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 3, "" );
					continue;
				}
				
				idx = 0;
				
				// �����
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Mem_Set( (byte*)szTmp2, 0x00, sizeof(szTmp2) );
				Mem_Set( (byte*)szTmp3, 0x00, sizeof(szTmp3) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				
				Mem_Cpy( (byte*)szTmp2, (byte*)szTmp , 5 );
				Mem_Cpy( (byte*)szTmp3, (byte*)szTmp+5 , 5 );
				
				Str_Cpy(szTmp, szTmp2);
				Str_Cat(szTmp, "\n-");
				Str_Cat(szTmp, szTmp3);
				
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 0, szTmp );
				
				// �ּ�
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 1000, DECRYPT);
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 1, szTmp );

				// ����
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 2, szTmp );

				// ��ġ��ҹ�ȣ
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				sql->GetValue(sql, idx++, 'U', (long*)szTmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_SEARCH_TBLLIST, i, 3, szTmp );
			}
		}
				
Finally:
		DelSqLite(sql);
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90001
	��  �� : �̵� ������ ������ ��ȸ / FR90001
	Param  : szInst_Place_Num / ��ġ��ҹ�ȣ
	Return : 
	========================================================================================*/
	void Snd_FR90001(char* szInst_Place_Num)
	{
		char sztmp[32];
		char szUtmp[100];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90001, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",  szInst_Place_Num );
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = Rcv_FR90001; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR90001_IN",  "FR90001" , sndbuf, sztmp );	
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_FR90001
	��  �� : FR90001 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long Rcv_FR90001(void)
	{
		long ret = 0;
		
		ret = Chk_Json_90001();
		
		g_Sock_Close();
		CloseMessageBox();
		
		if( ret >= 0)
		{
			m_lInitRedraw = 1;
			Set_View_Main_PhoneNum();
			ReDraw();
				
			return 1;
		}
		else
		{
			if( m_lSearch_Move_flag == 0 )
			{
				Back_Move_Card();
			}
			else
			{
				ON_DRAW();
			}
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_FR90001
	��  �� : FR90001 ���� ��� ������ �����Ѵ�.
	Param  : 
	Return : 1:�������� ��ſϷ�, 0: ��������or�������Ŀ���, -1: �˼����� ����
	========================================================================================*/
	long Chk_Json_90001(void)
	{
		char szJsonpath[500];
		char szMsg[500];
		long fd, i;
		long chkmsg = 0;
		long chkcode = 0;
		long fsize = 0;
		char *pStr = NULL;
		char *szCode = NULL;
		char *szMessage = NULL;
		long *nCol = NULL;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 11;
		
		char szTmp[100];
		handle hitem = NULL;
		handle hcnt = NULL;
		
		/* FR90001���� �޾ƿ��� ���� ���� */
		char *szInst_place_num = NULL;
		char *szUse_cont_num = NULL;
		char *szUse_cont_doc_yn = NULL;
		char *szCp_ddd = NULL;
		char *szCp_exn = NULL;
		char *szCp_num = NULL;
		char *szOwnhouse_tel_ddd = NULL;
		char *szOwnhouse_tel_exn = NULL;
		char *szOwnhouse_tel_num = NULL;
		char *szReal_cp_ddd = NULL;
		char *szReal_cp_exn = NULL;
		char *szReal_cp_num = NULL;
		char *szDeadline_flag = NULL;
		char *szGmtr_method_nm = NULL;
		char *szBill_send_method_cd = NULL;
		char *szBill_send_method_nm = NULL;
		char *szPay_method_cd = NULL;
		char *szPay_method_nm = NULL;
		
		char *szReq_cp_ddd = NULL;
		char *szReq_cp_exn = NULL;
		char *szReq_cp_num = NULL;
		char *szReq_email = NULL;
		
		char *szAddr = NULL;
		char *szCust_nm = NULL;
		
		char *szVisit_ymd = NULL;
		char *szVisit_type_nm = NULL;
		char *szVisit_result = NULL;
		char *szVisit_etc = NULL;
		
		char *szUnpay_amt = NULL;
		char *szUnpay_month = NULL;
		
		char *szBnk_nm = NULL;
		char *szDefray_account_num = NULL;
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 90001, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 90001, 0 );
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
		
		for(i = 0; i < fsize - 9; i++ )
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
			{
				break;
			}
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
		
		/********************************/
		/* ���� Callback                */
		/********************************/
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
		szCode = JSON_GetValue (g_pjcomm, "code", szType);
			szMessage = JSON_GetValue (g_pjcomm, "message", szType);
			
			/* FR90001 ������ */
			szInst_place_num		= JSON_GetValue (g_pjcomm, "inst_place_num", szType);
			szUse_cont_num 			= JSON_GetValue (g_pjcomm, "use_cont_num", szType);
			szUse_cont_doc_yn 		= JSON_GetValue (g_pjcomm, "use_cont_doc_yn", szType);
			szCp_ddd 				= JSON_GetValue (g_pjcomm, "cp_ddd", szType);
			szCp_exn 				= JSON_GetValue (g_pjcomm, "cp_exn", szType);
			szCp_num 				= JSON_GetValue (g_pjcomm, "cp_num", szType);
			szOwnhouse_tel_ddd 		= JSON_GetValue (g_pjcomm, "ownhouse_tel_ddd", szType);
			szOwnhouse_tel_exn 		= JSON_GetValue (g_pjcomm, "ownhouse_tel_exn", szType);
			szOwnhouse_tel_num		= JSON_GetValue (g_pjcomm, "ownhouse_tel_num", szType);
			szReal_cp_ddd 			= JSON_GetValue (g_pjcomm, "real_cp_ddd", szType);
			szReal_cp_exn 			= JSON_GetValue (g_pjcomm, "real_cp_exn", szType);
			szReal_cp_num 			= JSON_GetValue (g_pjcomm, "real_cp_num", szType);
			szDeadline_flag 		= JSON_GetValue (g_pjcomm, "deadline_flag", szType);
			szGmtr_method_nm 		= JSON_GetValue (g_pjcomm, "gmtr_method_nm", szType);
			szBill_send_method_cd 	= JSON_GetValue (g_pjcomm, "bill_send_method_cd", szType);
			szBill_send_method_nm 	= JSON_GetValue (g_pjcomm, "bill_send_method_nm", szType);
			szPay_method_cd 		= JSON_GetValue (g_pjcomm, "pay_method_cd", szType);
			szPay_method_nm 		= JSON_GetValue (g_pjcomm, "pay_method_nm", szType);
			szReq_cp_ddd			= JSON_GetValue (g_pjcomm, "req_cp_ddd", szType);
			szReq_cp_exn			= JSON_GetValue (g_pjcomm, "req_cp_exn", szType);
			szReq_cp_num			= JSON_GetValue (g_pjcomm, "req_cp_num", szType);
			szReq_email				= JSON_GetValue (g_pjcomm, "req_email", szType);
			szAddr            		= JSON_GetValue (g_pjcomm, "addr", szType);
			szCust_nm			    = JSON_GetValue (g_pjcomm, "cust_nm", szType);
			
			szVisit_ymd 			= JSON_GetValue (g_pjcomm, "visit_ymd", szType);
			szVisit_type_nm 		= JSON_GetValue (g_pjcomm, "visit_type_nm", szType);
			szVisit_result 			= JSON_GetValue (g_pjcomm, "visit_result", szType);
			szVisit_etc 			= JSON_GetValue (g_pjcomm, "visit_etc", szType);
			
			szUnpay_amt			 	= JSON_GetValue (g_pjcomm, "unpay_amt", szType);
			szUnpay_month 			= JSON_GetValue (g_pjcomm, "unpay_month", szType);
			
			szBnk_nm  				= JSON_GetValue (g_pjcomm, "bnk_nm", szType);
			szDefray_account_num  	= JSON_GetValue (g_pjcomm, "defray_account_num", szType);
			/********************************/
			/* ������ Callback              */
			/********************************/
			if( Str_Cmp(szCode, "0000") != 0)
			{
			  	char* pMsg = NULL;
			  
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szMessage) < 500 )
				{
					SQL_ConvMbStr( szMsg, szMessage);
				}
				
				//SPRINT(szJsonpath, "[%s] %s", szCode, szMsg, 0 );
				pMsg = g_Chk_Code(szJsonpath, szCode, szMsg);
			
				MessageBoxEx (WARNING_OK, pMsg);
				
				EvtDraw();
				
				ret = -1;
			}
			/********************************/
			/* ���� Callback                */
			/********************************/
			else
			{
				Mem_Set((byte*)&stMcMainInfo, 0x00, sizeof(stMcMainInfo));
				
				Str_Cpy(stMcMainInfo.INST_PLACE_NUM, szInst_place_num);
				Str_Cpy(stMcMainInfo.USE_CONT_NUM, szUse_cont_num);
				Str_Cpy(stMcMainInfo.USE_CONT_DOC_YN, szUse_cont_doc_yn);
				Str_Cpy(stMcMainInfo.CP_DDD, szCp_ddd);
				Str_Cpy(stMcMainInfo.CP_EXN, szCp_exn);
				Str_Cpy(stMcMainInfo.CP_NUM, szCp_num);
				Str_Cpy(stMcMainInfo.OWNHOUSE_TEL_DDD, szOwnhouse_tel_ddd);
				Str_Cpy(stMcMainInfo.OWNHOUSE_TEL_EXN, szOwnhouse_tel_exn);
				Str_Cpy(stMcMainInfo.OWNHOUSE_TEL_NUM, szOwnhouse_tel_num);
				Str_Cpy(stMcMainInfo.REAL_CP_DDD, szReal_cp_ddd);
				Str_Cpy(stMcMainInfo.REAL_CP_EXN, szReal_cp_exn);
				Str_Cpy(stMcMainInfo.REAL_CP_NUM, szReal_cp_num);
				Str_Cpy(stMcMainInfo.DEADLINE_FLAG, szDeadline_flag);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szGmtr_method_nm);
				Str_Cpy(stMcMainInfo.GMTR_METHOD_NM, szTmp);
				
				Str_Cpy(stMcMainInfo.BILL_SEND_METHOD_CD, szBill_send_method_cd);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szBill_send_method_nm);
				Str_Cpy(stMcMainInfo.BILL_SEND_METHOD_NM, szTmp);
				
				Str_Cpy(stMcMainInfo.PAY_METHOD_CD, szPay_method_cd);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szPay_method_nm);
				Str_Cpy(stMcMainInfo.PAY_METHOD_NM, szTmp);
				
				Str_Cpy(stMcMainInfo.REQ_CP_DDD, szReq_cp_ddd);
				Str_Cpy(stMcMainInfo.REQ_CP_EXN, szReq_cp_exn);
				Str_Cpy(stMcMainInfo.REQ_CP_NUM, szReq_cp_num);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szReq_email);
				Str_Cpy(stMcMainInfo.REQ_EMAIL, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szAddr);
				Str_Cpy(stMcMainInfo.ADDR, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szCust_nm);
				Str_Cpy(stMcMainInfo.CUST_NM, szTmp);
				
				Str_Cpy(stMcMainInfo.VISIT_YMD, szVisit_ymd);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szVisit_type_nm);
				Str_Cpy(stMcMainInfo.VISIT_TYPE_NM, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szVisit_result);
				Str_Cpy(stMcMainInfo.VISIT_RESULT, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szVisit_etc);
				Str_Cpy(stMcMainInfo.VISIT_ETC, szTmp);
				
				Str_Cpy(stMcMainInfo.UNPAY_AMT, szUnpay_amt);
				Str_Cpy(stMcMainInfo.UNPAY_MONTH, szUnpay_month);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szBnk_nm);
				Str_Cpy(stMcMainInfo.BNK_NM, szTmp);
				
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szDefray_account_num);
				Str_Cpy(stMcMainInfo.DEFRAY_ACCOUNT_NUM, szTmp);
			}
		}
		/********************************/
		/* ������ Callback              */
		/********************************/
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
		ON_DRAW();
		
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90002
	��  �� : ��ݳ��� ��ȸ / FR90002 / RCV_TMP
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90002(void)
	{
		char szUrl[200];
		char szbuf[128];
		char sztmp[128];
		char* sndbuf;
		long ret = 0;
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		// TABLE CLEAR
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		
		// PARAM SETTING
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90002, FALSE);
		
		// USE_CONT_NUM
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stMcMainInfo.USE_CONT_NUM );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90002; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR90002_IN",  "FR90002" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_FR90002
	��  �� : FR90002 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90002(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90002) >= 0)
		{
			ON_EXIT();
			OnInit(INIT_CHARGEHIST);
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_FR90003
	��  �� : �湮�̷� ��ȸ / FR90003 / RCV_TMP
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90003(void)
	{
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		// TABLE CLEAR
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		
		// PARAM SETTING
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90003, FALSE);
		
		// USE_CONT_NUM
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stMcMainInfo.USE_CONT_NUM );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90003;
		ret = HTTP_DownloadData(szUrl, "FR90003_IN",  "FR90003" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_FR90003
	��  �� : FR90003 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90003(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90003) >= 0)
		{
			ON_EXIT();
			OnInit(INIT_VISITHIST);
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90004
	��  �� : ���� ��� / FR90004
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90004(void)
	{
		char szUrl[200];
		char szbuf[200];
		char szTmp[500];
		char szTmp2[200];
		char* sndbuf;
		long ret = 0;
		
		/************************************************************/
		/* ������ ����                                              */
		/************************************************************/
		Save_Main_Combo();
		
		/************************************************************/
		/* Validation                                               */
		/************************************************************/
		if( !Validation() )
		{
			return;
		}
		
		Mem_Set((byte*)stMcMainRslt.REQ_FLAG, 0x00, sizeof(stMcMainRslt.REQ_FLAG));
		
		/*****************************************************************************************/
		/* REQ_FLAG SETTING                                                                      */
		/* 1. �̸��� �ű�, 2. LMS �ű�, 3. �̸��� ����, 4. LMS ����, 5. ���߰��� ����            */
		/*****************************************************************************************/
		// �۴� -> EMAIL = �űԽ�û
		if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "10" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 ) 
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "1" ); 
		}
		// �۴� -> LMS = �űԽ�û
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "10" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "2" ); 
		}
		// EMAIL -> �۴� = ����
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "60" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "3" ); 
		}
		// EMAIL -> LMS = �űԽ�û
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "2" ); 
		}
		// LMS -> �۴� = ����
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "60" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "4" ); 
		}
		// LMS -> EMAIL = �űԽ�û
		else if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) == 0 && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "1" ); 
		}
		// ���߰��� -> �۴� = ����
		else if( ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "14" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "17" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "18" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "47" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "48" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "78" ) == 0 ) && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "60" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "5" ); 
		}
		// ���߰��� -> EMAIL = �űԽ�û
		else if( ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "14" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "17" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "18" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "47" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "48" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "78" ) == 0 ) && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "1" ); 
		}
		// ���߰��� -> LMS = �űԽ�û
		else if( ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "14" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "17" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "18" ) == 0 
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "47" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "48" ) == 0
		        || Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "78" ) == 0 ) && Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "20" ) == 0 )
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "2" ); 
		}
		else
		{
			Str_Cpy( stMcMainRslt.REQ_FLAG , "0" ); 
		}
		
		/************************************************************/
		/* PARAM SETTING                                            */
		/************************************************************/
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90004, FALSE);
		
		// REQ_FLAG
		JSON_SetValue( g_pjcomm, 'C', "req_flag",  stMcMainRslt.REQ_FLAG ); 
		
		// REQ_NM
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stMcMainRslt.REQ_NM  );
		JSON_SetValue( g_pjcomm, 'C', "req_nm", szTmp );
		
		// REQ_LMS_DDD, REQ_LMS_EXN, REQ_LMS_NUM
		JSON_SetValue( g_pjcomm, 'C', "req_lms_ddd", stMcMainRslt.REQ_LMS_DDD );
		JSON_SetValue( g_pjcomm, 'C', "req_lms_exn", stMcMainRslt.REQ_LMS_EXN );
		JSON_SetValue( g_pjcomm, 'C', "req_lms_num", stMcMainRslt.REQ_LMS_NUM);
		
		// �̸���
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2));
		Str_Cpy( szTmp, stMcMainRslt.REQ_EMAIL );
		Str_Cat( szTmp, "@");
		Str_Cat( szTmp, stMcMainRslt.REQ_EMAIL_ADDR );
		
		SQL_ConvUcStr( szTmp2, szTmp );
		JSON_SetValue( g_pjcomm, 'C', "req_email", szTmp2 );
		
		// USE_CONT_NUM
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMcMainInfo.USE_CONT_NUM );
		
		// �ּ�
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stMcMainInfo.ADDR );
		JSON_SetValue( g_pjcomm, 'C', "addr", szTmp );
		
		// ���ι��(�Ѻ���)
		JSON_SetValue( g_pjcomm, 'C', "payMethodCd",  stMcMainInfo.PAY_METHOD_CD );
		
		// �߼۹��(�Ѻ���)
		JSON_SetValue( g_pjcomm, 'C', "billSendMethodCd",  stMcMainRslt.CMB_BILL_SEND_METHOD );
		
		// ��ġ��ҹ�ȣ
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",  stMcMainInfo.INST_PLACE_NUM );
		
		// �߼۹��
		JSON_SetValue( g_pjcomm, 'C', "send_ret_cd",  stMcMainRslt.CMB_BILL_SEND_METHOD );
		
		// �ź�
		JSON_SetValue( g_pjcomm, 'C', "reject_cd",    stMcMainRslt.CMB_REFUSE );
		
		// �ڰ���ħ
		JSON_SetValue( g_pjcomm, 'C', "self_ret_cd",  stMcMainRslt.CMB_SELF_GMTR );
		
		// �����
		JSON_SetValue( g_pjcomm, 'C', "udoc_ret_cd",  stMcMainRslt.CMB_USE_CONT );
		
		// ���ι��
		JSON_SetValue( g_pjcomm, 'C', "pay_ret_cd",   stMcMainRslt.CMB_PAY_METHOD );
		
		// �޸�
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stMcMainRslt.ETC  );
		JSON_SetValue( g_pjcomm, 'C', "etc",  szTmp );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90004;
		ret = HTTP_DownloadData(szUrl, "FR90004_IN",  "FR90004" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90004
	��  �� : FR90001 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90004(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90004) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "��� �Ϸ��Ͽ����ϴ�.");
			Clear_RsltData();
			Snd_FR90001(stMcMainInfo.INST_PLACE_NUM);
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90005
	��  �� : �ǻ�� ��ȣ UPDATE / FR90005
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90005(void)
	{
		char szUrl[200];
		char szbuf[200];
		char szTmp[200];
		char* sndbuf;
		long ret = 0;
		
		// 	Validation	
		if( !Validation() )
		{
			return;
		}
		
		// �ǻ���� ��ȣ ���� 
		Save_Real();
		
		// PARAM SETTING
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90005, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num", stMcMainInfo.INST_PLACE_NUM);
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMcMainInfo.USE_CONT_NUM);
		JSON_SetValue( g_pjcomm, 'C', "real_cp_ddd", stMcMainInfo.REAL_CP_DDD);
		JSON_SetValue( g_pjcomm, 'C', "real_cp_exn", stMcMainInfo.REAL_CP_EXN);
		JSON_SetValue( g_pjcomm, 'C', "real_cp_num", stMcMainInfo.REAL_CP_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90005;
		ret = HTTP_DownloadData(szUrl, "FR90005_IN",  "FR90005" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90005
	��  �� : FR90005 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90005(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90005) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "���� �Ϸ��Ͽ����ϴ�.");
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90006
	��  �� : ��ȸ / FR90006 / RCV_RELEASE
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90006(void)
	{
		char szUrl[200];
		char szbuf[200];
		char szTmp[200];
		char szAddr_city[200];
		char* sndbuf;
		long ret = 0;
		long i;
		handle js = NULL;
		
		// ��ȸ ������ ����
		Save_Search();
		
		// Validation
		if( !Validation() )
		{	
			return;
		}
		
		// TABLE CLEAR
		g_Sql_DirectExecute(" DELETE FROM RCV_RELEASE ");
		
		// PARAM SETTING
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90006, FALSE);
		
		/********************************************************************************/
		/* search_type : 1 = ������ȣ, 2 = ����, 3 = ���θ�, 4 = ��ȭ��ȣ, 5 = ���� */
		/********************************************************************************/
		// �ּ�
		if( Str_Cmp(stMcSearch.SEARCH_TYPE, "�ּ�" ) == 0 )
		{
			Mem_Set( (byte*)szAddr_city, 0x00, sizeof(szAddr_city) );
			
			// ����
			if( Str_Cmp(stMcSearch.SEARCH_ADDR_TYPE, "����" ) == 0 )
			{
				JSON_SetValue( g_pjcomm, 'C', "search_type", "2" );
				
				i = g_SearchStr( stMcSearch.SEARCH_CITY, MC_CURR_ADDR );
				
				if (i == -1)
				{
					Str_Cpy(szAddr_city, "");
				}
				else
				{
					Str_Cpy(szAddr_city, MC_CURR_ADDR[i].Code);
				}	
			}
			//���θ�
			else
			{
				JSON_SetValue( g_pjcomm, 'C', "search_type", "3" );
				
				i = g_SearchStr( stMcSearch.SEARCH_CITY, MC_NEW_ADDR );
			
				if (i == -1)
				{
					Str_Cpy(szAddr_city, "");
				}
				else
				{
					Str_Cpy(szAddr_city, MC_NEW_ADDR[i].Code);
				}
			}
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, szAddr_city );
			JSON_SetValue( g_pjcomm, 'C', "addr_city", szTmp );
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, stMcSearch.SEARCH_KEYWORD );
			JSON_SetValue( g_pjcomm, 'C', "addr_keyword",  szTmp );
			
			// JSON_SetValue( g_pjcomm, 'C', "use_cont_num", "");
		}
		// ������ȣ
		else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "������ȣ" ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "search_type", "1" );
			// JSON_SetValue( g_pjcomm, 'C', "addr_city", "" );
			// JSON_SetValue( g_pjcomm, 'C', "addr_keyword", "" );
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_Cpy( szTmp, stMcSearch.SEARCH_USE_CONT_NUM );
			Str_Chg( szTmp, STRCHG_DEL_NONDIGIT);
			
			JSON_SetValue( g_pjcomm, 'C', "use_cont_num", szTmp );
		}
		// ��ȭ��ȣ
		else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "��ȭ��ȣ" ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "search_type", "4" );
			
			Mem_Set( (byte*)szAddr_city, 0x00, sizeof(szAddr_city) );
				
			i = g_SearchStr( stMcSearch.SEARCH_CITY2, MC_NEW_ADDR );
		
			if (i == -1)
			{
				Str_Cpy(szAddr_city, "");
			}
			else
			{
				Str_Cpy(szAddr_city, MC_NEW_ADDR[i].Code);
			}
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, szAddr_city );
			JSON_SetValue( g_pjcomm, 'C', "addr_city", szTmp );
			JSON_SetValue( g_pjcomm, 'C', "phone_ddd", stMcSearch.SEARCH_PHONE_DDD );
			JSON_SetValue( g_pjcomm, 'C', "phone_exn", stMcSearch.SEARCH_PHONE_EXN );
			JSON_SetValue( g_pjcomm, 'C', "phone_num", stMcSearch.SEARCH_PHONE_NUM );
		}
		// ����
		else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "����" ) == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "search_type", "5" );
			
			Mem_Set( (byte*)szAddr_city, 0x00, sizeof(szAddr_city) );
				
			i = g_SearchStr( stMcSearch.SEARCH_CITY2, MC_NEW_ADDR );
		
			if (i == -1)
			{
				Str_Cpy(szAddr_city, "");
			}
			else
			{
				Str_Cpy(szAddr_city, MC_NEW_ADDR[i].Code);
			}

			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, szAddr_city );
			JSON_SetValue( g_pjcomm, 'C', "addr_city", szTmp );
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SQL_ConvUcStr( szTmp, stMcSearch.SEARCH_NAME );
			JSON_SetValue( g_pjcomm, 'C', "cust_nm", szTmp );
		}
		
		// FR90006_IN�� �ִ� List<FR90006_IN_Item> items������ �� JSON�����͸� �Ѱܾ���, ���� X
		js = JSON_Create(JSON_Array);
		
		JSON_Attach(g_pjcomm, "items", js);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90006;
		ret = HTTP_DownloadData(szUrl, "FR90006_IN",  "FR90006" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90006
	��  �� : FR90006 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90006(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90006) >= 0)
		{
			if( Str_Cmp(stMcSearch.SEARCH_ADDR_TYPE, "����" ) == 0 )
			{
				m_lSearch_Addr_Chg = 0;
			}
			else
			{
				m_lSearch_Addr_Chg = 1;
			}
			
			TableDraw_Search(m_lSearch_Addr_Chg);
			MessageBoxEx (CONFIRM_OK, "��ȸ�� �Ϸ��Ͽ����ϴ�.");
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90007
	��  �� : SMS�߼� / FR90007
	Param  : 
	Return : 
	========================================================================================*/	
	void Snd_FR90007(void)
	{
		char szUrl[200];
		char szbuf[200];
		char szTmp[200];
		char szMsg[200];
		char* sndbuf;
		long ret = 0;
		
		/********************************/
		/* �̵�������_����            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// HP
			if( m_lReal_hp_tel == 0 )
			{
				if( Str_Len(stMcMainInfo.CP_DDD) < 3
				 || Str_Len(stMcMainInfo.CP_EXN) < 4
				 || Str_Len(stMcMainInfo.CP_NUM) < 4 )
				{
					MessageBoxEx (CONFIRM_OK, "��ȭ��ȣ ������ �����ʽ��ϴ�.");
					return;
				
				}
				else
				{
					Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					
					Str_Cpy( szTmp, stMcMainInfo.CP_DDD );
					Str_Cat( szTmp, "-" );
					Str_Cat( szTmp, stMcMainInfo.CP_EXN );
					Str_Cat( szTmp, "-" );
					Str_Cat( szTmp, stMcMainInfo.CP_NUM );
					
					SPRINT(szMsg, "���Բ� SMS�߼��� �Ͻðڽ��ϱ�?\n( HP : %s )", szTmp, 0, 0);	
	
					if( MessageBoxEx(CONFIRM_YESNO, szMsg) != MB_OK)
					{
						return;
					}
				}
			}
			// REAL
			else if( m_lReal_hp_tel == 2 )
			{
				if( Str_Len(stMcMainInfo.REAL_CP_DDD) < 3
				 || Str_Len(stMcMainInfo.REAL_CP_EXN) < 4
				 || Str_Len(stMcMainInfo.REAL_CP_NUM) < 4 )
				{
					MessageBoxEx (CONFIRM_OK, "��ȭ��ȣ ������ �����ʽ��ϴ�.");
					return;
				}
				else
				{
					Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					
					Str_Cpy( szTmp, stMcMainInfo.REAL_CP_DDD );
					Str_Cat( szTmp, "-" );
					Str_Cat( szTmp, stMcMainInfo.REAL_CP_EXN );
					Str_Cat( szTmp, "-" );
					Str_Cat( szTmp, stMcMainInfo.REAL_CP_NUM );
					
					SPRINT(szMsg, "���Բ� SMS�߼��� �Ͻðڽ��ϱ�?\n( HP : %s )", szTmp, 0, 0);	
	
					if( MessageBoxEx(CONFIRM_YESNO, szMsg) != MB_OK)
					{
						return;
					}
				}
			}	
		}
		/********************************/
		/* �̵�������_�ǻ����        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			if( Str_Cmp( stMcMainInfo.REAL_CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD)) ) != 0 
			 || Str_Cmp( stMcMainInfo.REAL_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN)) ) != 0 
			 || Str_Cmp( stMcMainInfo.REAL_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_NUM)) ) != 0 )
			{
				MessageBoxEx (CONFIRM_OK, "������ ���� �ϼ���.");
				return;
			}
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			
			Str_Cpy( szTmp, stMcMainInfo.REAL_CP_DDD );
			Str_Cat( szTmp, "-" );
			Str_Cat( szTmp, stMcMainInfo.REAL_CP_EXN );
			Str_Cat( szTmp, "-" );
			Str_Cat( szTmp, stMcMainInfo.REAL_CP_NUM );
			
			if( Str_Len(stMcMainInfo.REAL_CP_DDD) < 3
			 || Str_Len(stMcMainInfo.REAL_CP_EXN) < 4
			 || Str_Len(stMcMainInfo.REAL_CP_NUM) < 4 )
			{
				
				MessageBoxEx (CONFIRM_OK, "��ȭ��ȣ ������ �����ʽ��ϴ�.");
				return;
			
			}
			else
			{
				SPRINT(szMsg, "���Բ� SMS�߼��� �Ͻðڽ��ϱ�?\n( HP : %s )", szTmp, 0, 0);	

				if( MessageBoxEx(CONFIRM_YESNO, szMsg) != MB_OK)
				{
					return;
				}
			}
		}
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 90007, FALSE);
		
		/********************************/
		/* �̵�������_����            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{	
			if( m_lReal_hp_tel == 0 )
			{
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber1", stMcMainInfo.CP_DDD);
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber2", stMcMainInfo.CP_EXN);
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber3", stMcMainInfo.CP_NUM);
			}
			else if( m_lReal_hp_tel == 2 )
			{
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber1", stMcMainInfo.REAL_CP_DDD);
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber2", stMcMainInfo.REAL_CP_EXN);
				JSON_SetValue( g_pjcomm, 'C', "receiverNumber3", stMcMainInfo.REAL_CP_NUM);
			}
		}
		/********************************/
		/* �̵�������_�ǻ����        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			JSON_SetValue( g_pjcomm, 'C', "receiverNumber1", stMcMainInfo.REAL_CP_DDD);
			JSON_SetValue( g_pjcomm, 'C', "receiverNumber2", stMcMainInfo.REAL_CP_EXN);
			JSON_SetValue( g_pjcomm, 'C', "receiverNumber3", stMcMainInfo.REAL_CP_NUM);
		}
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMcMainInfo.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "center_cd", stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "recommender_id", stUserinfo.szRecommender_id );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, stUserinfo.sztel );
		JSON_SetValue( g_pjcomm, 'C', "center_tel", szTmp );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR90007;
		ret = HTTP_DownloadData(szUrl, "FR90007_IN",  "FR90007" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR90007
	��  �� : FR90007 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR90007(void)
	{
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(90007) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "SMS�߼��� �Ϸ��Ͽ����ϴ�.");
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Set_Bill_Alarm
	��  �� : �߼۹�� �� ��ư �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/	
	void Set_Bill_Alarm(void)
	{
		char szMsg[200];
		
		Mem_Set((byte *)szMsg, 0x00, sizeof(szMsg));
		
		/*********************/
		/* LMS               */
		/*********************/
		if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) == 0 )
		{
			Str_Cpy( szMsg, "[ LMS ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		/*********************/
		/* EMAIL             */
		/*********************/
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) == 0 )
		{
			Str_Cpy( szMsg, "[ E-MAIL ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_EMAIL );
		}
		/*********************/
		/* MOBILE            */
		/*********************/
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "80" ) == 0 )
		{
			Str_Cpy( szMsg, "[ ����� ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "14" ) == 0 )
		{
			Str_Cpy( szMsg, "[ E-MAIL ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_EMAIL );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "17" ) == 0 )
		{
			Str_Cpy( szMsg, "[ LMS ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "18" ) == 0 )
		{
			Str_Cpy( szMsg, "[ ����� ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "47" ) == 0 )
		{
			Str_Cpy( szMsg, "[ E-MAIL ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_EMAIL );
			Str_Cat( szMsg, "\n [ LMS ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "48" ) == 0 )
		{
			Str_Cpy( szMsg, "[ ����� \n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
			Str_Cat( szMsg, "\n [ E-MAIL ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_EMAIL );
		}
		else if ( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "78" ) == 0 )
		{
			Str_Cpy( szMsg, "[ ����� ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
			Str_Cat( szMsg, "\n[ LMS ]\n" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_DDD );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_EXN );
			Str_Cat( szMsg, "-" );
			Str_Cat( szMsg, stMcMainInfo.REQ_CP_NUM );
		}
		
		MessageBoxEx (CONFIRM_OK, szMsg);
	}
	
	/*=======================================================================================
	�Լ��� : Set_Pay_Alarm
	��  �� : ���ι�� �� ��ư �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/	
	void Set_Pay_Alarm(void)
	{
		char szMsg[200];
		char szTmp[10];
		char szTmp2[10];
		
		Mem_Set((byte *)szMsg, 0x00, sizeof(szMsg));
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte *)szTmp2, 0x00, sizeof(szTmp2));
		
		/*********************/
		/* ������ü          */
		/*********************/
		if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) == 0 )
		{
			Str_Cpy( szMsg, "[ ������ü ]\n" );
			Str_Cat( szMsg, stMcMainInfo.BNK_NM );
			Str_Cat( szMsg, "\n" );
			Str_Cat( szMsg, stMcMainInfo.DEFRAY_ACCOUNT_NUM );
		}
		/*********************/
		/* ī����ü          */
		/*********************/
		else if ( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) == 0 )
		{
			Str_Cpy( szMsg, "[ ī����ü ]\n" );
			Str_Cat( szMsg, stMcMainInfo.BNK_NM );
			Str_Cat( szMsg, "\n" );
			Str_Cat( szMsg, stMcMainInfo.DEFRAY_ACCOUNT_NUM );
		}
		
		MessageBoxEx (CONFIRM_OK, szMsg);
	}
	
	/*=======================================================================================
	�Լ��� : SetCombo_Filter
	��  �� : �޺��ڽ� Filter
	Param  : 
	Return : 
	========================================================================================*/	
	void SetCombo_Filter(void)
	{
		long i;
		char szSql[500];
		
		/********************************/
		/* �̵�������_����            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// 1. û�����߼۹�� �޺��ڽ�
			// 1-1. ������ : �ź� �޺��ڽ� ��Ȱ��ȭ
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "������") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_REFUSE), "" );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), TRUE );
				
				m_lBldOk_flag = 0;
			}
			// 1-2. LMS : �߼۹�� ��ư Ȱ��ȭ
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "LMS") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_REFUSE), "" );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), TRUE );
			}
			// 1-3. ���� : �߼۹�� ��ư Ȱ��ȭ
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "����") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_REFUSE), "" );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), TRUE );
			}
			// 1-4. �۴� : �߼۹�� ��ư ��Ȱ��ȭ
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "�۴�") == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_REFUSE), FALSE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_REFUSE+1), FALSE );
				
				m_lBldOk_flag = 0;
			}
			else
			{
				m_lBldOk_flag = 0;
			}
			
			// 2. ���ι�� �޺��ڽ�
			// 2-1. ���� ���ι���� ����, ī�� : ���ι�� �޺��ڽ� ��Ȱ��ȭ
			if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) == 0 || Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_PAY_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_PAY_METHOD), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD+1), TRUE );
			}
			// 2-2. ���� ���ι���� ����, ī�尡 �ƴ� ��� : ���ι�� �޺��ڽ� Ȱ��ȭ
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_PAY_METHOD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(ST_CMB_PAY_METHOD), FALSE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_PAY_METHOD+1), FALSE );
			}
			
			// 3. ���� û�����߼۹���� ����, LMS��, �޺��ڽ��� ������ ���� ����, LMS�� ��� �߼۹�� ��Ȱ��ȭ
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "����") == 0 && Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				
				m_lBldOk_flag = 0;
			}
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "LMS") == 0 && Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CMB_BILL_SEND_METHOD), TRUE );
				
				m_lBldOk_flag = 0;
			}
			
			// 4. ���� û�����߼۹���� �������� ��� �߼۹���޺��ڽ� �� Ȱ��ȭ
			if(  Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "80" ) == 0 )
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD), TRUE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BILL_SEND_METHOD+1), TRUE );
				
				m_lBldOk_flag = 0;
			}
			
			Save_Main_Combo();
		}
		/********************************/
		/* �̵�������_��ȸ            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)), "������ȣ") == 0 )
			{
				// �ּ�Ÿ��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+1), FALSE);
				
				// ��/��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY+1), FALSE);
				
				// ��/��2
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY2), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2+1), FALSE);
				
				// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_NAME), FALSE);
				
				// ��ȭ��ȣ
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_NUM), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD+1), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM), FALSE);
				
				// �˻�
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SEARCH_ADDR_EX), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_CLEAR), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_ADDR), FALSE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_ADDR), FALSE);	
				
				// ������ȣ
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), TRUE);
			}
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)), "�ּ�") == 0 )
			{
				// �ּ�Ÿ��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR_TYPE), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+1), TRUE);
				
				// ��/��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY+1), TRUE);
				
				// ��/��2
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY2), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2+1), FALSE);
				
				// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_NAME), FALSE);
				
				// ��ȭ��ȣ
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_NUM), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD+1), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM), FALSE);
				
				// �˻�
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SEARCH_ADDR_EX), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_CLEAR), TRUE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_ADDR), TRUE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_ADDR), TRUE);	
				
				// ������ȣ
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), FALSE);
			}
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)), "��ȭ��ȣ") == 0 )
			{
				// �ּ�Ÿ��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+1), FALSE);
				
				// ��/��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY+1), FALSE);
				
				// ��/��2
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY2), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2+1), TRUE);
				
				// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_NAME), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_NAME), FALSE);
				
				// ��ȭ��ȣ
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_EXN), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_NUM), TRUE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD+1), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM), TRUE);
				
				// �˻�
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SEARCH_ADDR_EX), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_CLEAR), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_ADDR), FALSE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_ADDR), FALSE);	
				
				// ������ȣ
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), FALSE);
			}
			else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)), "����") == 0 )
			{
				// �ּ�Ÿ��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_ADDR_TYPE+1), FALSE);
				
				// ��/��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY+1), FALSE);
				
				// ��/��2
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_CITY2), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_SEARCH_CITY2+1), TRUE);
				
				// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_NAME), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_NAME), TRUE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_NAME), TRUE);
				
				// ��ȭ��ȣ
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_PHONE_NUM), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(CMB_SEARCH_PHONE_DDD+1), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_EXN), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_PHONE_NUM), FALSE);
				
				// �˻�
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_ADDR), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_SEARCH_ADDR_EX), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_CLEAR), FALSE);
				
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_ADDR), FALSE);	
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_SEARCH_WRITE_ADDR), FALSE);	
				
				// ������ȣ
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(ST_SEARCH_USE_CONT), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM), FALSE);
			}
			
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE)), "����") == 0 )
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_CITY+2 ) );
				for ( i = 0 ;  MC_CURR_ADDR[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SEARCH_CITY+2), MC_CURR_ADDR[i].Str, 0, ICON_NONE);
				}
			}
			else
			{
				ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_SEARCH_CITY+2 ) );
				for ( i = 0 ;  MC_NEW_ADDR[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_SEARCH_CITY+2), MC_NEW_ADDR[i].Str, 0, ICON_NONE);
				}
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : Validation
	��  �� : 
	Param  : 
	Return : 
	========================================================================================*/
	bool Validation(void)
	{
		long lActiveIndex = -1;
	
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		/********************************/
		/* �̵�������_����            */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			// ������
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "������" )  == 0 )
			{
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD)), "")  == 0 )
				{
					if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) != 0 && Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) != 0 )
					{
						MessageBoxEx(CONFIRM_OK, "���ι���� �����ϼ���.");
						return FALSE;
					}
				}
			}
			// LMS
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "LMS" )  == 0 )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD)), "" ) == 0 )
				{
					if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) != 0 && Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) != 0 )
					{
						MessageBoxEx(CONFIRM_OK, "���ι���� �����ϼ���.");
						return FALSE;
					}
				}
				
				if( Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "70" ) != 0 && Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "LMS" )  == 0 )
				{
					if( Str_Cmp(stMcMainRslt.REQ_NM, "") == 0 
					 || Str_Cmp(stMcMainRslt.REQ_LMS_DDD, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_LMS_EXN, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_LMS_NUM, "") == 0 )
					{
						MessageBoxEx(CONFIRM_OK, "LMS �߼۵�� ������ Ȯ���ϼ���.");
						return FALSE;
					}
				}
			}
			// �̸���
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "����" )  == 0 )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD)), "" ) == 0 )
				{
					if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) != 0 && Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) != 0 )
					{
						MessageBoxEx(CONFIRM_OK, "���ι���� �����ϼ���.");
						return FALSE;
					}
				}
				
				if (  Str_Cmp( stMcMainInfo.BILL_SEND_METHOD_CD, "40" ) != 0 && Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "����" )  == 0 )
				{
					if( Str_Cmp(stMcMainRslt.REQ_NM, "") == 0 
					 || Str_Cmp(stMcMainRslt.REQ_LMS_DDD, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_LMS_EXN, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_LMS_NUM, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_EMAIL, "") == 0
					 || Str_Cmp(stMcMainRslt.REQ_EMAIL_ADDR, "") == 0 )
					{
						MessageBoxEx(CONFIRM_OK, "EMAIL �߼۵�� ������ Ȯ���ϼ���.");
						return FALSE;
					}
				}
			}
			// �۴�
			else if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD)), "�۴�" )  == 0 )
			{
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_REFUSE)), "")  == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "�źθ� �����ϼ���.");
					return FALSE;
				}
				
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD)), "" ) == 0 )
				{
					if( Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "20" ) != 0 && Str_Cmp( stMcMainInfo.PAY_METHOD_CD, "30" ) != 0 )
					{
						MessageBoxEx(CONFIRM_OK, "���ι���� �����ϼ���.");
						return FALSE;
					}
				}
			}
		}
		/********************************/
		/* �̵�������_��ȸ            */
		/********************************/
		else if( m_bFirst == INIT_SEARCH )
		{
			if( Str_Cmp(stMcSearch.SEARCH_TYPE, "�ּ�" ) == 0 )
			{
				if( Str_Cmp(stMcSearch.SEARCH_ADDR_TYPE, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "�ּ�Ÿ���� �����ϼ���.");
					return FALSE;
				}
				else if( Str_Cmp(stMcSearch.SEARCH_CITY, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "��/���� �����ϼ���.");
					return FALSE;
				}
				else if( Str_Cmp(stMcSearch.SEARCH_KEYWORD, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "�˻� ������ �Է��ϼ���.\n[��: �����ͳ� 111-105 �븲]");
					return FALSE;
				}
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "������ȣ" ) == 0 )
			{
				if( Str_Len(stMcSearch.SEARCH_USE_CONT_NUM) != 11 )
				{
					MessageBoxEx(CONFIRM_OK, "������ȣ�� �Է��ϼ���.");
					return FALSE;
				}
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "��ȭ��ȣ" ) == 0 )
			{
				if( Str_Cmp(stMcSearch.SEARCH_CITY2, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "��/���� �����ϼ���.");
					return FALSE;
				}
				else if( Str_Len( stMcSearch.SEARCH_PHONE_DDD ) < 3 
					  || Str_Len( stMcSearch.SEARCH_PHONE_EXN ) < 4 
					  || Str_Len( stMcSearch.SEARCH_PHONE_NUM ) < 4 )
				{
					MessageBoxEx(CONFIRM_OK, "��ȭ��ȣ ������ ���� �ʽ��ϴ�.");
					return FALSE;	
				}
			}
			else if( Str_Cmp(stMcSearch.SEARCH_TYPE, "����" ) == 0 )
			{
				if( Str_Cmp(stMcSearch.SEARCH_CITY2, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "��/���� �����ϼ���.");
					return FALSE;
				}
				else if( Str_Cmp(stMcSearch.SEARCH_NAME, "") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "������ �Է��ϼ���");
					return FALSE;
				}
			}
		}
		/********************************/
		/* �̵�������_�ǻ����        */
		/********************************/
		else if( m_bFirst == INIT_REALUSER )
		{
			if( Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD)) ) < 3 
			 || Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN)) ) < 4 
			 || Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_NUM)) ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "��ȭ��ȣ ������ ���� �ʽ��ϴ�.");
				return FALSE;	
			}
		}
		
		/********************************/
		/* �̵�������_�߼۵��        */
		/********************************/
		else if( m_bFirst == INIT_BILL_SEND_METHOD )
		{
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM)), "" ) == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "��û���� �Է��ϼ���.");
				return FALSE;
			}
			
			if( Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD)) ) < 3 
			 || Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN)) ) < 4 
			 || Str_Len( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM)) ) < 4 )
			{
				MessageBoxEx(CONFIRM_OK, "��ȭ��ȣ ������ ���� �ʽ��ϴ�.");
				return FALSE;	
			}
			
			if( Str_Cmp( stMcMainRslt.CMB_BILL_SEND_METHOD, "30" )  == 0 )
			{
				if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL)), "" ) == 0
				 || Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2)), "" ) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "EMAIL������ �Է��ϼ���.");
					return FALSE;
				}
			}
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	�Լ��� : Save_Main_Combo
	��  �� : ���� ���
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Main_Combo(void)
	{
		long i;
		char szTmp[300];
		
		Mem_Set((byte*)stMcMainRslt.REQ_FLAG, 0x00, sizeof(stMcMainRslt.REQ_FLAG));
		
		// 1. �߼۹��
		Mem_Set((byte*)stMcMainRslt.CMB_BILL_SEND_METHOD, 0x00, sizeof(stMcMainRslt.CMB_BILL_SEND_METHOD));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD) ) );
		
		i = g_SearchStr( szTmp, MC_BILL_SEND_METHOD );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_BILL_SEND_METHOD, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_BILL_SEND_METHOD, MC_BILL_SEND_METHOD[i].Code);
		}
		
		// 2. �ź�
		Mem_Set((byte*)stMcMainRslt.CMB_REFUSE, 0x00, sizeof(stMcMainRslt.CMB_REFUSE));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_REFUSE) ) );
		
		i = g_SearchStr( szTmp, MC_REFUSE );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_REFUSE, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_REFUSE, MC_REFUSE[i].Code);
		}
		
		// 3. ���ι��
		Mem_Set((byte*)stMcMainRslt.CMB_PAY_METHOD, 0x00, sizeof(stMcMainRslt.CMB_PAY_METHOD));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_PAY_METHOD) ) );
		
		i = g_SearchStr( szTmp, MC_PAY_METHOD );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_PAY_METHOD, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_PAY_METHOD, MC_PAY_METHOD[i].Code);
		}
		
		// 4. �ڰ���ħ
		Mem_Set((byte*)stMcMainRslt.CMB_SELF_GMTR, 0x00, sizeof(stMcMainRslt.CMB_SELF_GMTR));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_SELF_GMTR) ) );
		
		i = g_SearchStr( szTmp, MC_SELF_GMTR );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_SELF_GMTR, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_SELF_GMTR, MC_SELF_GMTR[i].Code);
		}
		
		// 5. �����
		Mem_Set((byte*)stMcMainRslt.CMB_USE_CONT, 0x00, sizeof(stMcMainRslt.CMB_USE_CONT));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		
		Str_Cpy( szTmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_USE_CONT) ) );
		
		i = g_SearchStr( szTmp, MC_USE_CONT );
		
		if (i == -1)
		{
			Str_Cpy(stMcMainRslt.CMB_USE_CONT, "");
		}
		else
		{
			Str_Cpy(stMcMainRslt.CMB_USE_CONT, MC_USE_CONT[i].Code);
		}
	}
	
	/*=======================================================================================
	�Լ��� : Save_BillSend_Method
	��  �� : �߼۹�� ����
	Param  : 
	Return : 
	========================================================================================*/
	void Save_BillSend_Method(void)
	{
		Mem_Set((byte*)stMcMainRslt.REQ_NM, 0x00, sizeof(stMcMainRslt.REQ_NM));
		Str_Cpy(stMcMainRslt.REQ_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_REQ_NM)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_LMS_DDD, 0x00, sizeof(stMcMainRslt.REQ_LMS_DDD));
		Str_Cpy(stMcMainRslt.REQ_LMS_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_PHONE_DDD)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_LMS_EXN, 0x00, sizeof(stMcMainRslt.REQ_LMS_EXN));
		Str_Cpy(stMcMainRslt.REQ_LMS_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_EXN)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_LMS_NUM, 0x00, sizeof(stMcMainRslt.REQ_LMS_NUM));
		Str_Cpy(stMcMainRslt.REQ_LMS_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_PHONE_NUM)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_EMAIL, 0x00, sizeof(stMcMainRslt.REQ_EMAIL));
		Str_Cpy(stMcMainRslt.REQ_EMAIL, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL)));
		
		Mem_Set((byte*)stMcMainRslt.REQ_EMAIL_ADDR, 0x00, sizeof(stMcMainRslt.REQ_EMAIL_ADDR));
		Str_Cpy(stMcMainRslt.REQ_EMAIL_ADDR, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_BILL_SEND_EMAIL2)));
	}
	
	/*=======================================================================================
	�Լ��� : Save_Real
	��  �� : �ǻ���ȣ ����
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Real(void)
	{
		Mem_Set((byte*)stMcMainInfo.REAL_CP_DDD, 0x00, sizeof(stMcMainInfo.REAL_CP_DDD));
		Str_Cpy(stMcMainInfo.REAL_CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_REAL_PHONE_DDD)));
		
		Mem_Set((byte*)stMcMainInfo.REAL_CP_EXN, 0x00, sizeof(stMcMainInfo.REAL_CP_EXN));
		Str_Cpy(stMcMainInfo.REAL_CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_EXN)));
		
		Mem_Set((byte*)stMcMainInfo.REAL_CP_NUM, 0x00, sizeof(stMcMainInfo.REAL_CP_NUM));
		Str_Cpy(stMcMainInfo.REAL_CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_REAL_PHONE_NUM)));
	}
	
	/*=======================================================================================
	�Լ��� : Save_Search
	��  �� : ��ȸ ����
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Search(void)
	{
		Mem_Set((byte*)&stMcSearch, 0x00, sizeof(stMcSearch));

		Str_Cpy(stMcSearch.SEARCH_TYPE, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_TYPE)));

		Str_Cpy(stMcSearch.SEARCH_ADDR_TYPE, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_ADDR_TYPE)));

		Str_Cpy(stMcSearch.SEARCH_CITY, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY)));
		
		Str_Cpy(stMcSearch.SEARCH_CITY2, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_CITY2)));
		
		Str_Cpy(stMcSearch.SEARCH_KEYWORD, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_ADDR)));
		
		Str_Cpy(stMcSearch.SEARCH_USE_CONT_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_USE_CONT_NUM)));
		
		Str_Cpy(stMcSearch.SEARCH_NAME, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_NAME)));
		
		Str_Cpy(stMcSearch.SEARCH_PHONE_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEARCH_PHONE_DDD)));
		
		Str_Cpy(stMcSearch.SEARCH_PHONE_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_EXN)));
		
		Str_Cpy(stMcSearch.SEARCH_PHONE_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_SEARCH_PHONE_NUM)));
	}
	
	/*=======================================================================================
	�Լ��� : Save_Memo
	��  �� : �޸� ����
	Param  : 
	Return : 
	========================================================================================*/
	void Save_Memo(char* szMemo)
	{
		Mem_Set((byte*)stMcMainRslt.ETC, 0x00, sizeof(stMcMainRslt.ETC));
		Str_Cpy(stMcMainRslt.ETC, szMemo);
	}
	
	/*=======================================================================================
	�Լ��� : Quick_View_Search
	��  �� : ��ȸ ���� ȣ��
	Param  : 
	Return : 
	========================================================================================*/
	void Quick_View_Search(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		char szTmp[400];
		
		char col_name[5][32] = {"���\n����ȣ", "�ּ�", "����", "", ""};
		
		//�ʵ� ���� ����
		char col_weight[5][10] = {"2","4","2","0","0"};
		char col_align[5][10]  = {"center", "left", "center", "center", ""};
		
		
		h = JSON_Create( JSON_Object );
		
		if (h)
		{
			hData = JSON_Create( JSON_Object );
			
			if(hData == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hData	, 'C', "list_type"	, "GridListView");
			
			//�� ȣ��������, ���� ��ġ�� ����ϰ� �������� �� ȣ��� ����
			//true�� �� �־�� �Ѵ�.
			//���� ������ �ٸ� �並 ȣ���� ���, ������ �ǹǷ� �ݵ�� �Ź� ȣ���
			//���� �Ǵ��Ͽ� ��� �ؾ� �Ѵ�.
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");	// true/false
			
			col_count = 4;
			
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			//�ּҰ� ǥ�õǴ� �ʵ尡 �����ؼ� ���α��̰� �ڵ������� �ȵȴٸ� 
			//�Ϲ� ���丮��Ʈ�� ���� ���� ������ �ʿ��ҰŰ����ϴ�.
			col_height = 300;
			
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = 0;
			
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			
			if( m_lSearch_Addr_Chg == 0 )
			{
				Str_Cpy( szTmp, "SELECT SUBSTR(PARAM2,1,5) || '\n-' || SUBSTR(PARAM2,6) AS PARAM2, PARAM4, PARAM3, PARAM1 FROM RCV_RELEASE ORDER BY PARAM4" );
			}
			else if( m_lSearch_Addr_Chg == 1 )
			{
				Str_Cpy( szTmp, "SELECT SUBSTR(PARAM2,1,5) || '\n-' || SUBSTR(PARAM2,6) AS PARAM2, PARAM5, PARAM3, PARAM1 FROM RCV_RELEASE ORDER BY PARAM5" );
			}
			else
			{
				Str_Cpy( szTmp, "SELECT SUBSTR(PARAM2,1,5) || '\n-' || SUBSTR(PARAM2,6) AS PARAM2, PARAM4, PARAM3, PARAM1 FROM RCV_RELEASE" );
			}
			
			JSON_SetValue	(hData	, 'C', "query", szTmp);

			hHead = JSON_Create( JSON_Array );
			
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for( i=0; i < col_count; i++ )
			{
				JSON_AddArrayItem(hHead);
				JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name[i]);
				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "��ȸ");
			JSON_SetValue	(h		, 'C', "method"			, "ListViewActivity");
			JSON_Attach 	(h		, "data"				, hData);
		
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hData)
		{
			JSON_Finalize(hData);
		}
			
		if (hHead)
		{
			JSON_Finalize(hHead);
		}	
	}
	
	/*=======================================================================================
	�Լ��� : OnList
	��  �� : ��ȸ ���� ���
	Param  : 
	Return : 
	========================================================================================*/
	void OnList(quad lParam)
	{
		long i;
		char szTmp[200];
		long lActIndex;
		long lindex;
		
		i = lParam;
		
		if( i > -1 )
		{
			if( m_lSearch_Addr_Chg == 0 )
			{
				g_Sql_SaveSeq( "SELECT ROWID FROM RCV_RELEASE ORDER BY PARAM4", SREACH_FILE);
			}
			else if( m_lSearch_Addr_Chg == 1 )
			{
				g_Sql_SaveSeq( "SELECT ROWID FROM RCV_RELEASE ORDER BY PARAM5", SREACH_FILE);
			}
			else
			{
				g_Sql_SaveSeq( "SELECT ROWID FROM RCV_RELEASE", SREACH_FILE);
			}
		
			lActIndex = lParam;
			lindex = g_SREACHFILE_GetSeq(SREACH_FILE, lActIndex);
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)m_szInst_Place_Num, 0x00, sizeof(m_szInst_Place_Num));
			
			SPRINT(szTmp, "SELECT PARAM1 FROM RCV_RELEASE A WHERE ROWID = '%d'", lindex, 0, 0);

			g_Sql_RetStr(szTmp, 10, m_szInst_Place_Num);
			
			Clear_RsltData();
			
			m_lInitRedraw = 0;
			m_lSearch_Move_flag = 1;
			
			ON_EXIT();
			OnInit(INIT_MAIN);
		}
	}
	
	/*=======================================================================================
	�Լ��� : Clear_Data
	��  �� : ������ Clear
	Param  : 
	Return : 
	========================================================================================*/
	void Clear_Data(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REFUSE), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELF_GMTR), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_USE_CONT), "");
		}
		
		Mem_Set((byte*)&stMcMainInfo, 0x00, sizeof(stMcMainInfo));
		Mem_Set((byte*)&stMcMainRslt, 0x00, sizeof(stMcMainRslt));
		Mem_Set((byte*)&stMcSearch, 0x00, sizeof(stMcSearch));
		
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		g_Sql_DirectExecute(" DELETE FROM RCV_RELEASE ");
	}
	
	/*=======================================================================================
	�Լ��� : Clear_RsltData
	��  �� : ���� ������ Clear
	Param  : 
	Return : 
	========================================================================================*/
	void Clear_RsltData(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BILL_SEND_METHOD), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_REFUSE), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_PAY_METHOD), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_SELF_GMTR), "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_USE_CONT), "");
		}
		
		Mem_Set((byte*)&stMcMainRslt, 0x00, sizeof(stMcMainRslt));
		
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
	}
	
	/*=======================================================================================
	�Լ��� : Set_Move_Card
	��  �� : �̵������� ȭ�鿡�� �ڷ� ���ư��� ��������� �̵����� �����ϴ� �Լ�
	Param  : 
	Return : 
	========================================================================================*/
	void Back_Move_Card(void)
	{	
		// g_lMC_MoveCard_Flag : 0 = ��������, 1 = ��ħ, 2 = ������ �ܵ�, 3 = ������ ����, 4 = �������� ���
		if( g_lMC_MoveCard_Flag == 0 )
		{
			Card_Move("SC_START");
		}
		else if( g_lMC_MoveCard_Flag == 1 )
		{
			Card_Move("GM_ENTRY");
		}
		else if( g_lMC_MoveCard_Flag == 2 )
		{
			Card_Move("BF_BEFOCONFIRM");
		}
		else if( g_lMC_MoveCard_Flag == 3 )
		{
			Card_Move("BF_TGTCONFIRM");
		}
		else if( g_lMC_MoveCard_Flag == 4 )
		{
			Card_Move("SC_CONFIRM");
		}
		else
		{
			Card_Move("MENU");
		}
	}
	
	/*=======================================================================================
	�Լ��� : Set_View_Main_PhoneNum
	��  �� : ���� ��ȭ��ȣ ȭ�� view
	Param  : 
	Return : 
	========================================================================================*/
	void Set_View_Main_PhoneNum(void)
	{
		// m_lReal_hp_tel : HP = 0, tel = 1, real = 2
		if( Str_Cmp(stMcMainInfo.REAL_CP_DDD, "") != 0 || Str_Cmp(stMcMainInfo.REAL_CP_EXN, "") != 0 || Str_Cmp(stMcMainInfo.REAL_CP_NUM, "") != 0 )
		{
			m_lReal_hp_tel = 2;
		}
		else if( Str_Cmp(stMcMainInfo.CP_DDD, "") != 0 || Str_Cmp(stMcMainInfo.CP_EXN, "") != 0 || Str_Cmp(stMcMainInfo.CP_NUM, "") != 0 )
		{
			m_lReal_hp_tel = 0;	
		}
		else
		{
			m_lReal_hp_tel = 1;
		}
	}
}
