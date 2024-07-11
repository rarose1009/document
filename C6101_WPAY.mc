/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_WPAY
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
	#define USE_ON_SELECT
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	#include "ArrayList.c"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_WCUST )			//
		DEF_BUTTON_ID ( BID_WMTR )			//
		DEF_BUTTON_ID ( BID_WBUR )			//
		DEF_BUTTON_ID ( BID_WCHK )			//
		DEF_BUTTON_ID ( BID_WONE )			//
		DEF_BUTTON_ID ( BID_WSTOP )			//
		DEF_BUTTON_ID ( BID_WRELE )			//
		DEF_BUTTON_ID ( BID_WPAY )			//
		DEF_BUTTON_ID ( BID_CLOSE )			//
		
		DEF_BUTTON_ID ( BID_UP )	//
		DEF_BUTTON_ID ( BID_DOWN )	//
		DEF_BUTTON_ID ( BID_UP2 )	//
		DEF_BUTTON_ID ( BID_DOWN2 )	//

		DEF_BUTTON_ID ( BID_CASH )			// ���ݿ�����
		DEF_BUTTON_ID ( BID_SNDCASH )		// ���ݿ�����
		DEF_BUTTON_ID ( BID_VIRTACT )		// �������
		DEF_BUTTON_ID ( BID_AUTO  )			// ȯ�Ұ���
		DEF_BUTTON_ID ( BID_SNDAUTO  )		// ȯ�Ұ���
		DEF_BUTTON_ID ( BID_WRITEMEMO )		//�޸𾲱�
		DEF_BUTTON_ID ( BID_MEMOCLOSE )		//�޸�ȭ��ݱ�
		DEF_BUTTON_ID ( BID_MEMO  )			// �޸�
		DEF_BUTTON_ID ( BID_COMP  )			// �Ϸ�
		DEF_BUTTON_ID ( BID_DFRRD )			// �ĺ�
		DEF_BUTTON_ID ( BID_CARD )			// ī��
		DEF_BUTTON_ID ( BID_CHKADJ )        
		DEF_BUTTON_ID ( BID_PLANPAY )       //����Ȯ�༭
		DEF_BUTTON_ID ( BID_RAD_GUBUN_Y )
		DEF_BUTTON_ID ( BID_RAD_GUBUN_N )
		DEF_BUTTON_ID ( BID_REALPAY )		 //�ǽð�������ȸ
		DEF_BUTTON_ID ( BID_SOC_BIZ_GUBUN_Y )//
		DEF_BUTTON_ID ( BID_SOC_BIZ_GUBUN_N )//
		DEF_BUTTON_ID ( BID_DEPOSITOR_NM )	 //
		DEF_BUTTON_ID ( BID_PRINTPAY )		 //
		DEF_BUTTON_ID ( BID_PAYCLOSE )		 //
		
		DEF_BUTTON_ID ( BID_OZ )
		DEF_BUTTON_ID ( BID_NOT_OZ )
		DEF_BUTTON_ID ( BID_OZ_MEMO )
		DEF_BUTTON_ID ( BID_OZ_MEMO_SAVE )
		
		DEF_BUTTON_ID ( BID_SUBCLOSE )		
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
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		//DEF_OBJECT_ID ( TAB_COVER )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TAB_LINE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( TXT_PAGE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE2 )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( TTL_DEBT_AMT            )
		DEF_OBJECT_ID ( TXT_DEBT_AMT            )
		DEF_OBJECT_ID ( TTL_LAW_ETC_AMT         )
		DEF_OBJECT_ID ( TXT_LAW_ETC_AMT         )
		DEF_OBJECT_ID ( TTL_SUM                 )
		DEF_OBJECT_ID ( TXT_NOPAY               )
		DEF_OBJECT_ID ( TXT_CHK_ACCOUNT         )
		DEF_OBJECT_ID ( TXT_CHK_AMT             )
		DEF_OBJECT_ID ( TXT_CHK_CARD            )
		DEF_OBJECT_ID ( TTL_TOTAMT              )
		DEF_OBJECT_ID ( TXT_TOTAMT              )
		DEF_OBJECT_ID ( TTL_ALT                 )
		DEF_OBJECT_ID ( TXT_ALT                 )
		DEF_OBJECT_ID ( TTL_ACCOUNT             )
		DEF_OBJECT_ID ( TXT_ACCOUNT             )
		DEF_OBJECT_ID ( TTL_ONCE                )
		DEF_OBJECT_ID ( TXT_ONCE                )
		DEF_OBJECT_ID ( TTL_PAY                 )
		DEF_OBJECT_ID ( TXT_PAY                 )
		DEF_OBJECT_ID ( TTL_DEPOSITOR_NM        )
		DEF_OBJECT_ID ( TXT_DEPOSITOR_NM        )
		DEF_OBJECT_ID ( TTL_DDEPOSITOR_RELAT_CD )
		DEF_OBJECT_ID ( TTL_TEL                 )
		//DEF_OBJECT_ID ( TXT_TEL_DDD             )
		DEF_OBJECT_ID ( TXT_TEL_EXN             )
		DEF_OBJECT_ID ( TXT_TEL_NUM             )
		DEF_OBJECT_ID ( TTL_SOC_BIZ_NUM         )
		DEF_OBJECT_ID ( TXT_SOC_BIZ_NUM         )
		DEF_OBJECT_ID ( TTL_BNK_NM              )
		DEF_OBJECT_ID ( TTL_ACCOUNT_NUM         )
		DEF_OBJECT_ID ( TXT_ACCOUNT_NUM         )
		DEF_OBJECT_ID ( TTL_RAD_GUBUN           )
		DEF_OBJECT_ID ( TXT_RAD_GUBUN           )
		DEF_OBJECT_ID ( TTL_CUSTINFO            )
		DEF_OBJECT_ID ( TXT_CUSTINFO            )
		DEF_OBJECT_ID ( TTL_GUBUN               )
		DEF_OBJECT_ID ( TTL_AMT                 )
		DEF_OBJECT_ID ( TXT_AMT                 )
		
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )

		DEF_OBJECT_ID ( CMB_TEL_DDD_CD  )
		DEF_OBJECT_ID ( CMB_DEPOSITOR_RELAT_CD = CMB_TEL_DDD_CD+3)
		DEF_OBJECT_ID ( CMB_BNK_NM = CMB_DEPOSITOR_RELAT_CD+3)
		DEF_OBJECT_ID ( CMB_GUBUN  = CMB_BNK_NM+3 )

		DEF_OBJECT_ID ( TXT_MEMO = CMB_GUBUN+3 )

		DEF_OBJECT_ID ( ID_TBLLIST )
		DEF_OBJECT_ID ( ID_TBLLIST2 )
		DEF_OBJECT_ID ( ID_VIRTTBLLIST )
		
	END_OBJECT_ID()
	
	#define INIT_MAIN	  1
	#define INIT_CASH	  2
	#define INIT_AUTO	  3
	#define INIT_MEMO	  4
	#define INIT_BANK	  5
	#define INIT_BIZ	  6
	#define INIT_PAYED	  7
	#define INIT_PLANPAY  8

	//Ȯ�༭�� �Ѱ��ִ� �⺻ ������ struct1
	//Ȯ�༭�� �Ѱ��ִ� �⺻ ������ struct1
	typedef struct _PAYINFO
	{
		char USE_CONT_NUM        [20];
		char PROMISE_ASSIGN_SEQ  [10];
		char SEQ                 [10];
		char USE_CUST_NM         [50];
		char USE_FIRM_NM         [50];
		char USE_BIZ_REGI_NUM    [30];
		char USE_CP_DDD          [5];
		char USE_CP_EXN          [5];
		char USE_CP_NUM          [5];
		char USE_OWNHOUSE_TEL_DDD[5];
		char USE_OWNHOUSE_TEL_EXN[5];
		char USE_OWNHOUSE_TEL_NUM[5];
		char USE_CURR_ADDR_UNION [300];
		char USE_NEW_ADDR_UNION  [300];
		char ADJ_BASE_YMD        [20];
		char CUST_NM             [50];
		char SOC_NUM             [20];
		char CP_DDD              [5];
		char CP_EXN              [5];
		char CP_NUM              [5];
		char OWNHOUSE_TEL_DDD    [5];
		char OWNHOUSE_TEL_EXN    [5];
		char OWNHOUSE_TEL_NUM    [5];
		char RELATION            [20];
		char CAUSE_CD            [10];
		char PAY_PLAN_YMD        [20];
		char RMK                 [300];
		char NEW_ADDR_UNION      [300];
		char PROMISE_USE_CONT_NUM[20];
		char FIRM_NM             [50];
		char BIZ_REGI_NUM        [30];
		char ADDR_GB             [10];
		char ADDR_TYPE           [10];
		char ADDR                [300];
		char SECOND_ADDR         [200];
		char ADDR_UNION          [500];
		char ZIP_SEQ             [20];
		char NEW_ADDR_BLD_SEQ    [20];
		char HILL                [50];
		char ADDR1_M             [50];
		char ADDR1_S             [50];
		char DONG                [50];
		char HOSU                [50];
		char LOT_NUM_UNION       [300];
		char NEW_HOSU            [50];
		char UNGRNOUND_YN        [10];
		char PROMISE_TYPE_GB     [100];
		char PROMISE_EMPID       [20];
		char PROMISE_YMD         [20];
		char PROMISE_TOT_AMT     [20];
		char ID_REC_YN           [2];
	}	PAYINFO;
	
	//Ȯ�༭�� �Ѱ��ִ� �⺻ ������ struct2
	typedef struct _PAYPLAN
	{
		char USE_CONT_NUM    [20];
		char SEQ             [10];
		char PROMISE_PLAN_SEQ[10];
		char PROMISE_PLAN_REQ[50];
		char PROMISE_PLAN_AMT[50];
		char PROMISE_PLAN_YMD[20];
	}	PAYPLAN;

	PAYINFO m_stPayInfo;
	PAYPLAN m_stPayPlan[20];
	
	//Ȯ�༭���� �Ѿ���� ���� struct
	typedef struct _OZDATA
	{
		char PROMISE_TYPE_GB     [10];
		char USE_CONT_NUM        [20];
		char PROMISE_ASSIGN_SEQ  [20];
		char SEQ                 [10];
		char ADDR_GB             [10];
		char ADDR_TYPE           [10];
		char ZIP_SEQ             [20];
		char ADDR_UNION          [300];
		char NEW_ADDR_BLD_SEQ    [20];
		char NEW_ADDR_UNION      [300];
		char LOT_NUM_UNION       [300];
		char SECOND_ADDR         [200];
		char FIRM_NM             [100];
		char BIZ_REGI_NUM        [30];
		char SOC_NUM             [20];
		char CP_DDD              [10];
		char CP_EXN              [10];
		char CP_NUM              [10];
		char CUST_NM             [50];
		char INFO_USE_AGREE_YN   [5];
		char INFO_USE_AGREE_YN2  [5];
		char INFO_USE_AGREE_YN3  [5];
		char INFO_USE_AGREE_YN4  [5];
		char INFO_USE_AGREE_YN5  [5];
		char PROMISE_TOT_AMT     [20];
		char PDFPATH			 [256];
	}	OZDATA;

	OZDATA m_stOzData;
	
	long m_lPlanCnt = 0;
	
	//ozview body �ڵ�
	handle m_hBody = NULL;

	#define		W_MAIN		CWD*39+10
	#define		H_MAIN		CHT*21
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    2					// table�� �ళ��
	#define		COL 	    7					// table�� ������
	#define		GRID_H		(CHT+20)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 				// table ����x��ǥ
	#define		MAXCHAR		31 			    	// table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+CHT 	//table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	#define		ROW2 	    4					// table�� �ళ��
	#define		COL2 	    8					// table�� ������
	#define		GRID_H2		(CHT+10)			// table �� ����
	#define		GRID_X2		STARTX	 			// table ����x��ǥ
	#define		MAXCHAR2	31 			    	// table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y2		GRID_ENDY+(CHT+20)*2 	//table ����y��ǥ
	#define		GRID_ENDY2	(GRID_Y2+(ROW2+1)*GRID_H2) //table������ row�� Y��
	
	#define		ROW3 	    13					// table�� �ళ��
	#define		COL3 	    3					// table�� ������
	#define		GRID_H3		(CHT+10)			// table �� ����
	#define		GRID_X3		STARTX 				// table ����x��ǥ
	#define		MAXCHAR3	100			    	// table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y3		STARTY-29 	//table ����y��ǥ
	#define		GRID_ENDY3	(GRID_Y3+(ROW3+1)*GRID_H3) //table������ row�� Y��

	#define 	SYH			(CHT+10)
	#define 	Line(x)	    (GRID_ENDY2+5+SYH*(x-1))
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
	char	m_szTableBuf2 [COL2*(ROW2+1)*MAXCHAR2]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
	char	m_szTableBuf3 [COL3*(ROW3+1)*MAXCHAR3]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
	char	m_szTableBuf4 [COL3*(ROW3+1)*MAXCHAR3]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�⹰��ȣ", CWD*10, EDITALIGN_LEFT|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�̳���"  , CWD*9+23,  EDITALIGN_RIGHT|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�����"  , CWD*10,  EDITALIGN_RIGHT|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����"    , CWD*5,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ī��"    , CWD*5,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ADJ_ALT_AMT",  0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�跮���ȣ",   0,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	Column m_stGridTitle2[] = {
		{"û�����", CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�̳��ݾ�", CWD*12, EDITALIGN_RIGHT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"C"       , CWD*7+23,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����"    , CWD*5,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"ī��"    , CWD*5,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"USE_PERIOD_STR", 0,EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"USE_PERIOD_END", 0,EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�跮���ȣ",     0,EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};

	Column m_stGridTitle3[] = {
		{"�ڵ�", 		 CWD*5, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�����", 		CWD*12, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���¹�ȣ", 	CWD*22+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};

	Column m_stGridTitle4[] = {
		{"�Ա�����", 	CWD*13, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�Ա�����", 	CWD*10, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�Աݱݾ�", 	CWD*16+23, EDITALIGN_RIGHT|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};

	#define	BUTSETRANGE(h, x1, y1, x2, y2)		ButCtrl_SetRange(h,  DMS_X(x1), DMS_Y(y1), DMS_X(x2), DMS_Y(y2) )
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1), DMS_Y(y1), DMS_X(x2), DMS_Y(y2) )
	
	handle m_hdb;
	SQLITE m_sql;
	handle m_hstmt;
	
	long m_bFirst;
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;
	long m_lpage2 = 0;			// ���� ������
	long m_lTotpage2 = 0;
	long m_lpage3 = 0;			// ���� ������
	long m_lTotpage3 = 0;

	char m_szCnt_index[11];     //�ε��� ���ڿ�(���� ������)
	long m_lradgbn_flag;
	long m_lDfrrd_flag = -1;
	long m_nAdj_amt;
	long m_lSoc_flag;
	long m_lActiveIndex;
	long m_lvirt = 0;
	long m_lAdjAmtFlag = 0;	//ȭ�� ù ȣ�� �� ������ ���ο� ���� �����ݹ�ư ���� ���� �÷���
	CARRAYLIST m_pList = NULL;
	bool m_bPrintAgain = FALSE;
	char m_szTrans_info_rslt[300];

enum
{

	PRINT_PAY_PLAN = 1,
	PRINT_PAY_BACK,
	PRINT_PAY_OK

} PRINT_PAY_STAT;	
	
long m_nPayFlag = PRINT_PAY_PLAN;
	
#define CHK_Y1	   "�࿹"
#define CHK_Y2	   "�ÿ�"
#define CHK_N1	   "��ƴϿ�"
#define CHK_N2	   "�þƴϿ�"

#define SOC_Y1	   "��������"
#define SOC_Y2	   "�û������"
#define SOC_N1	   "������"
#define SOC_N2	   "�û����"


#define ALT_Y1	   "��"
#define ALT_Y2	   "��"
#define CARD_Y1	   "��ī��"
#define CARD_Y2	   "��ī��"

	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void Draw_Nopay(void);
	void Draw_MtrAmt(void);
	long Sql_SetCombo(char* szSql, long CTRLID );
	void SetCombo(void);
	bool Validate(void);
	
	long Rcv_VirtAccount(void);
	long TR82211(void);
	long TR64703(void);
	void Virt_Draw(void);
	
	void Snd_Auto(void);
	long Rcv_Auto(void);
	void Snd_Payed(void);
	long Rcv_Payed(void);
	void Payed_Draw(void);
	void Snd_Cash(void);
	long Rcv_Cash(void);
	long Chk_Json_66802(void);
	void fsgetitem(char* szSource, char* szTarget, int id, int len );
	
	long SearchCD( char *CD, CodeTable *CT);
	long SearchStr( char *Str, CodeTable *CT);
	long GetUtf8Size(char* str, long chklen);
	
	long Rcv_Info(long promiseFlag);
	long TR66402(void);
	long TR664021(void);
	void SetInfo(void);
	void OzView(void);
	void SetJsonBody(SQLITE sql);
	void Rcv_OzData(char* OzData);
	long Snd_OzView(void);
	long TR822558(void);
	long Snd_Promiseplan(void);	
	long TR66804(void);

	long Rcv_BackVirtAccount(void);
	long TR82211_1(void);
	
	void Load_CardData(void);
	void Load_OneCardData(void);
	void Clear_PromiseCard(void);
	void Clear_PromiseOneCard(void);
		
	long Print_Result(void* p);
	
	void Print_PlanPay(void);
	void Print_BackPay(void);
	bool Print_Payed(void);
	
	void* Print_PlanPay_GetData(void);
	void* Print_BackPay_GetData(void);
	void* Print_Payed_GetData(void);
	
	void Snd_Cash_Mcpay(void);
	void Snd_Cash_Hist(long flag);
	long TR66806_0(void);
	long TR66806_1(void);
	long TR66806_2(void);
	void Run_Mcpay(long flag);
	void Rcv_CashData(char* szCashData);
	void Save_ApproCash(void);
	void Set_CashData(void);
	void Rcv_CashData_test(void);
	void Redraw_once(void);
	
	bool Chk_prod_cardpay( void );
	
	void Chk_Prod(void);
	long Chk_Json_64703(void);
	long Rcv_ProdChk(void);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCUST, "��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "���ұ�"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WONE, "��ȸ��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WPAY, "���"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WSTOP, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WRELE, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCHK, "����"),
		//DLG_TEXT ( 10, STARTY+35, W_MAIN, H_MAIN, 0, 0, 0, EDITSTY_THICKBORDER|EDITSTY_BORDER, TTLCTRLBK, TTLCTRLBK, TAB_LINE, ""),	
		//DLG_TEXT ( 0, 0, 0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, TAB_COVER, ""),
		
		// DLG_TEXT( STARTX,     STARTY+50,  195, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DEBT_AMT, "��ձ�"),
		// DLG_TEXT( STARTX+195, STARTY+50,  250, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DEBT_AMT, ""),
		// DLG_TEXT( STARTX+445, STARTY+50,  315, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_LAW_ETC_AMT, "�����ױ�Ÿ"),
		// DLG_TEXT( STARTX+750, STARTY+50,  250, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_LAW_ETC_AMT, ""),
			
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		DLG_TEXT( STARTX,        	GRID_ENDY,  CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TTL_SUM, "�հ�"),
		DLG_TEXT( STARTX+CWD*10, 	GRID_ENDY,  CWD*9+23, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NOPAY, ""),
		DLG_TEXT( STARTX+CWD*19+23, GRID_ENDY,  CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CHK_ACCOUNT, ""),
		DLG_TEXT( STARTX+CWD*29+23, GRID_ENDY,  CWD*5, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CHK_AMT, ""),
		DLG_TEXT( STARTX+CWD*34+23, GRID_ENDY,  CWD*5, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CHK_CARD, ""),

		DLG_BUTTON( STARTX,  	GRID_ENDY+SYH+2, 140, SYH+18, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+140,  GRID_ENDY+SYH+2, 140, SYH+18, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		DLG_TEXT( STARTX+280, 	GRID_ENDY+SYH+2, 220, SYH+18, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, ""),
		DLG_TEXT( STARTX+500, 	GRID_ENDY+SYH+2, 220, SYH+18, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE2, ""),
		DLG_BUTTON(STARTX+720,  GRID_ENDY+SYH+2, 140, SYH+18, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP2, " ��"),
		DLG_BUTTON(STARTX+860,  GRID_ENDY+SYH+2, 140, SYH+18, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN2, " ��"),

		// ����Ʈ
		DLG_TABLE (GRID_X2, GRID_Y2, ROW2, COL2, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR2, m_stGridTitle2, ID_TBLLIST2, m_szTableBuf2),	
		
		DLG_TEXT( STARTX,  	   Line(1)+44,  325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TOTAMT, "�� �� ��"),
		DLG_TEXT( STARTX+325,  Line(1)+44,  375, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOTAMT, ""),
		DLG_BUTTON(STARTX+700, Line(1)+44,  300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CASH,   "���ݿ�����"),		
		
		DLG_BUTTON(STARTX, 	   Line(2)+44,  125, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHKADJ,   ALT_Y1),		
		DLG_TEXT( STARTX+125,  Line(2)+44,  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_ALT, "������"),
		DLG_TEXT( STARTX+325,  Line(2)+44,  375, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ALT, ""),
		DLG_BUTTON(STARTX+700, Line(2)+44,  300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AUTO,   "ȯ�Ұ���"),		
		
		DLG_TEXT( STARTX,      Line(3)+44,  325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_ACCOUNT, "��������"),
		DLG_TEXT( STARTX+325,  Line(3)+44,  375, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ACCOUNT, ""),
		DLG_BUTTON(STARTX+700, Line(3)+44,  300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIRTACT,   "�������"),		
		
		DLG_BUTTON(STARTX,     Line(4)+44,  145, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DFRRD,   "�ĺ�"),		
		DLG_TEXT( STARTX+145,  Line(4)+44,  180, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_ONCE, "��ȸ��"),
		DLG_TEXT( STARTX+325,  Line(4)+44,  375, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ONCE, ""),
		DLG_BUTTON(STARTX+525, Line(4)+44,  175, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARD,   CARD_Y1),		
		DLG_BUTTON(STARTX+700, Line(4)+44,  300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PLANPAY,   "����Ȯ�༭"),	
		DLG_BUTTON(STARTX+700, Line(4)+44,  300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO,   "�޸�"),		
		
		DLG_TEXT( STARTX,  	   Line(5)+44,  325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_PAY , "�����ݾ�"),
		DLG_TEXT( STARTX+325,  Line(5)+44,  375, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAY , ""),
		DLG_BUTTON(STARTX+700, Line(5)+44,  300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMP,   "������"),		
	};
		
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCUST, "��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "���ұ�"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WONE, "��ȸ��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC , "", BID_WPAY, "���"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WSTOP, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WRELE, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCHK, "����"),
		DLG_TEXT ( 10, STARTY+35, W_MAIN, H_MAIN, 0, 0, 0, EDITSTY_THICKBORDER|EDITSTY_BORDER, TTLCTRLBK, TTLCTRLBK, TAB_LINE, ""),	
		//DLG_TEXT ( 0, 0, 0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, TAB_COVER, ""),
		
		DLG_TEXT( STARTX+25,  STARTY+50,  170, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_DEBT_AMT, "��ձ�"),
		DLG_TEXT( STARTX+195, STARTY+50,  250, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DEBT_AMT, ""),
		DLG_TEXT( STARTX+445, STARTY+50,  315, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_LAW_ETC_AMT, "�����ױ�Ÿ"),
		DLG_TEXT( STARTX+750, STARTY+50,  220, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_LAW_ETC_AMT, ""),
			
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		DLG_TEXT( STARTX+20,        GRID_ENDY,  CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TTL_SUM, "�հ�"),
		DLG_TEXT( STARTX+20+CWD*10, GRID_ENDY,  CWD*9, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_NOPAY, ""),
		DLG_TEXT( STARTX+20+CWD*19, GRID_ENDY,  CWD*9, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CHK_ACCOUNT, ""),
		DLG_TEXT( STARTX+20+CWD*28, GRID_ENDY,  CWD*5, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CHK_AMT, ""),
		DLG_TEXT( STARTX+20+CWD*33, GRID_ENDY,  CWD*5, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CHK_CARD, ""),

		// ����Ʈ
		DLG_TABLE (GRID_X2, GRID_Y2, ROW2, COL2, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR2, m_stGridTitle2, ID_TBLLIST2, m_szTableBuf2),	
		
		DLG_TEXT( STARTX+25,  Line(1),  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_TOTAMT, "�� �� ��"),
		DLG_TEXT( STARTX+325, Line(1),  375, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TOTAMT, ""),
		DLG_BUTTON(STARTX+700, Line(1),  270, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CASH,   "���ݿ�����"),		
		
		DLG_BUTTON(STARTX+25, Line(2),  100, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHKADJ,   ALT_Y1),		
		DLG_TEXT( STARTX+125,  Line(2), 200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_ALT, "������"),
		DLG_TEXT( STARTX+325, Line(2),  375, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ALT, ""),
		DLG_BUTTON(STARTX+700, Line(2),  270, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AUTO,   "ȯ�Ұ���"),		
		
		DLG_TEXT( STARTX+25,  Line(3),  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_ACCOUNT, "��������"),
		DLG_TEXT( STARTX+325, Line(3),  375, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ACCOUNT, ""),
		DLG_BUTTON(STARTX+700, Line(3),  270, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_VIRTACT,   "�������"),		
		
		DLG_BUTTON(STARTX+25, Line(4),  120, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DFRRD,   "�ĺ�"),		
		DLG_TEXT( STARTX+145, Line(4),  180, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_ONCE, "��ȸ��"),
		DLG_TEXT( STARTX+325, Line(4),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ONCE, ""),
		DLG_BUTTON(STARTX+525, Line(4),  175, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARD,   CARD_Y1),		
		DLG_BUTTON(STARTX+700, Line(4),  270, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PLANPAY,   "����Ȯ�༭"),	
		DLG_BUTTON(STARTX+700, Line(4),  270, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO,   "�޸�"),		
		
		DLG_TEXT( STARTX+25,  Line(5),  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_PAY , "�����ݾ�"),
		DLG_TEXT( STARTX+325, Line(5),  375, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAY , ""),
		DLG_BUTTON(STARTX+700, Line(5),  270, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMP,   "������"),
	};	
	
	// ȯ�Ұ���
	//---------------------------------------------------------------
	DlgObject	DlgRes_AUTO[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "ȯ�Ұ���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX,     STARTY-29,        325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DEPOSITOR_NM, "�����ָ�"),
		DLG_BUTTON(STARTX+325,STARTY-29,  675, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_DEPOSITOR_NM,  ""),
		DLG_TEXT( STARTX+325, STARTY-29,        675, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_DEPOSITOR_NM,  ""),
		DLG_TEXT( STARTX,     STARTY+SYH-29,    325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DDEPOSITOR_RELAT_CD, "�����ְ���"),
		DLG_COMBO(STARTX+325, STARTY+SYH-29,    675, SYH*6, SYH*3, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DEPOSITOR_RELAT_CD, 10),
		DLG_TEXT( STARTX,     STARTY+SYH*2-29,  325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TEL, "��ȭ��ȣ"),
		//DLG_TEXT( STARTX+325, STARTY+SYH*2,  645, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, 0, ""),
		//DLG_EDIT( STARTX+325, STARTY+SYH*2-29,  225, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_TEL_DDD, 3, ""),
		DLG_COMBO(STARTX+325, STARTY+SYH*2-29,  265, SYH*6, 110, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_TEL_DDD_CD, 10),
		DLG_EDIT( STARTX+590, STARTY+SYH*2-29,  205, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_TEL_EXN, 4, ""),
		DLG_EDIT( STARTX+795, STARTY+SYH*2-29,  205, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_TEL_NUM, 4, ""),
		
		DLG_TEXT( STARTX,     STARTY+SYH*3-29,  325, SYH*2, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SOC_BIZ_NUM, "�������/\n����ڹ�ȣ"),
		//DLG_TEXT( STARTX+325, STARTY+SYH*3,  645, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, 0,  ""),
		DLG_BUTTON(STARTX+325,STARTY+SYH*3-29,  337, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SOC_BIZ_GUBUN_Y,  SOC_Y1),
		DLG_BUTTON(STARTX+662,STARTY+SYH*3-29,  337, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SOC_BIZ_GUBUN_N,  SOC_N1),		
		DLG_EDIT( STARTX+325, STARTY+SYH*4-29,  675, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_SOC_BIZ_NUM, 10, ""),
		
		DLG_TEXT( STARTX,     STARTY+SYH*5-29,  325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BNK_NM, "�� �� ��"),
		DLG_COMBO(STARTX+325, STARTY+SYH*5-29,  675, SYH*6, SYH*3, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BNK_NM, 10),
		
		DLG_TEXT( STARTX,     STARTY+SYH*6-29,  325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_ACCOUNT_NUM, "���¹�ȣ"),
		DLG_EDIT( STARTX+325, STARTY+SYH*6-29,  675, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_ACCOUNT_NUM,30, ""),

		DLG_BUTTON( STARTX+700, STARTY+SYH*7, 300, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SNDAUTO, "�� ��"),
	};
	
	// ���ݿ�����
	//---------------------------------------------------------------
	DlgObject	DlgRes_CASH[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ݿ�����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX,       STARTY-29,        400, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_RAD_GUBUN, "�����߱޿���"),
		//DLG_TEXT( STARTX+400,   STARTY-29,        545, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_RAD_GUBUN,  ""),
		DLG_BUTTON(STARTX+400,  STARTY-29,  300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RAD_GUBUN_Y,  CHK_Y1),
		DLG_BUTTON(STARTX+700,  STARTY-29,  300, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_RAD_GUBUN_N,  CHK_N1),
		DLG_TEXT( STARTX,       STARTY+SYH-29,    400, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CUSTINFO, "�źе�Ϲ�ȣ"),
		DLG_EDIT( STARTX+400,   STARTY+SYH-29,    600, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_CUSTINFO, 20, ""),
		
		DLG_TEXT( STARTX,     STARTY+SYH*2-29,  400, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_GUBUN, "�ŷ��ڱ���"),
		DLG_COMBO(STARTX+400, STARTY+SYH*2-29,  600, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_GUBUN, 10),
		
		DLG_TEXT( STARTX,     STARTY+SYH*3-29,  400, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_AMT, "�ŷ��ݾ�"),
		DLG_TEXT( STARTX+400, STARTY+SYH*3-29,  600, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AMT, ""),

		DLG_BUTTON( STARTX+700, STARTY+SYH*5-29, 300, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SNDCASH, "Ȯ ��"),
	};
	
	// �޸�
	//---------------------------------------------------------------
	DlgObject	DlgRes_MEMO[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�޸��ϼ���"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_BUTTON(STARTX,  STARTY-29,  1000, SYH*5, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITEMEMO,  ""),
		DLG_EDIT(  STARTX,  STARTY-29,  1000, SYH*5, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_MEMO, 500, ""),

		DLG_BUTTON( STARTX+700, STARTY+SYH*6-29, 300, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMOCLOSE, "Ȯ ��"),
	};	
	
	// ���������ȸ
	//---------------------------------------------------------------
	DlgObject	DlgRes_BANK[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������� ��ȸ"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TABLE (GRID_X3, GRID_Y3, ROW3, COL3, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR3, m_stGridTitle3, ID_VIRTTBLLIST, m_szTableBuf3),	

		DLG_BUTTON( STARTX,     GRID_ENDY3+160, 400, SYH+18, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REALPAY, "�����ǽð���ȸ"),
		DLG_BUTTON( STARTX+600, GRID_ENDY3+160, 400, SYH+18, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, "Ȯ ��"),
	};	
	
	//---------------------------------------------------------------
	DlgObject	DlgRes_Payed[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�ǽð�����������ȸ"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TABLE (GRID_X3, GRID_Y3, ROW3, COL3, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR3, m_stGridTitle4, ID_VIRTTBLLIST, m_szTableBuf4),	

		DLG_BUTTON( STARTX,  	GRID_ENDY3+160, 500, SYH+18, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PRINTPAY, "�ǽð� ���γ��� ���"),
		DLG_BUTTON( STARTX+600, GRID_ENDY3+160, 400, SYH+18, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PAYCLOSE, "Ȯ ��"),
	};	
	
	//---------------------------------------------------------------
	DlgObject	DlgRes_PLANPAY[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����Ȯ�༭ ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX,        STARTY-29,  1000, 200, 0, 0, 0, EDITSTY_BORDER, RED, TXTINCTRLBK, TXT_DATA1, "�ϳ��� �ƴ� ��� ����Ȯ�༭��\n�� ���� ó���Ͻø� �ȵ˴ϴ�.\n \n��ȣ���� ����Ȯ�༭ �̹������\n��ݳ������� ����ó �� ������\n�޸���� ���� �ٶ��ϴ�."),

		DLG_BUTTON( STARTX,  	STARTY+210, 500, 100, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NOT_OZ, "�ϳ��� �̹���"),
		DLG_BUTTON( STARTX+500, STARTY+210, 500, 100, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OZ, "����"),

		DLG_TEXT(STARTX,    STARTY+340, 1000, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA2, "�޸�"),
		DLG_BUTTON( STARTX, STARTY+440, 1000, 430, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OZ_MEMO,  ""),
		DLG_TEXT(STARTX,    STARTY+440, 1000, 430, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA3, ""),

		//DLG_BUTTON( STARTX+700,  	STARTY+830, 300, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OZ_MEMO_SAVE, "�޸� ����"),
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
						Draw_MtrAmt();
						Draw_Nopay();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						Draw_MtrAmt();
						Draw_Nopay();
						break;		
				}
				break;
			case INIT_MEMO:	
				CREATE_DIALOG_OBJECT (DlgRes_MEMO, SIZEOF(DlgRes_MEMO));
				break;
			case INIT_CASH:	
				CREATE_DIALOG_OBJECT (DlgRes_CASH, SIZEOF(DlgRes_CASH));
				
				Set_CashData();
				break;
			case INIT_AUTO:	
				CREATE_DIALOG_OBJECT (DlgRes_AUTO, SIZEOF(DlgRes_AUTO));
				break;
			case INIT_BANK:	
				CREATE_DIALOG_OBJECT (DlgRes_BANK, SIZEOF(DlgRes_BANK));
				break;
			case INIT_PAYED:	
				CREATE_DIALOG_OBJECT (DlgRes_Payed, SIZEOF(DlgRes_Payed));
				break;
			case INIT_PLANPAY:
				CREATE_DIALOG_OBJECT (DlgRes_PLANPAY, SIZEOF(DlgRes_PLANPAY));
				break;
		}
		
		SetBtnImg();
		SetStyle();
		ReDraw();
		
		return;
	}
	
	//------------------------------------------------------------------
	void	OnButton(long ID)
	{
	char sztmp[300];
	long ret;
	char szSql[300];
	long gasnonpay = 0, gasacconut = 0;

		switch(ID)
		{
			case BID_PLANPAY:
				if( g_lNpChkFlag == 1)
				{
					MessageBoxEx (ERROR_OK, "����Ȯ�༭ ������ ��ȸ�� �����մϴ�.");
					ON_DRAW();
					return;
				}

				if( g_lPAYFlag == 0)
				{
					MessageBoxEx (ERROR_OK, "�߰������� �ϼ���.");
					Card_Move("C6101_WMTR");
					return;
				}
				
				//�ο��ڷ� �Է��ڷ� ������Ʈ
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN='0' ", g_szCHK_EXEC_NUM, 0, 0   );
				g_Sql_RetInt( szSql, &gasnonpay );
				
				gasacconut = 0;
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '0' ", g_szCHK_EXEC_NUM, 0, 0   );
				g_Sql_RetInt( szSql, &gasacconut );
				
				//������ �̳������ �߻� ����Ȯ�༭ �߻� �ʼ�
				if( (gasnonpay +gasacconut) == 0 )
				{
					MessageBoxEx (ERROR_OK, "������ �̳��ݾ��� �����ϴ�.");//
					return;
				}

				ON_EXIT();
				OnInit(INIT_PLANPAY);
				break;
			case BID_SOC_BIZ_GUBUN_Y:
				m_lSoc_flag = 0;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SOC_BIZ_GUBUN_Y), SOC_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SOC_BIZ_GUBUN_N), SOC_N1);
				EditCtrl_SetMaxChar (Get_hDlgCtrlByID(TXT_SOC_BIZ_NUM), 6);
				break;
			case BID_SOC_BIZ_GUBUN_N:
				m_lSoc_flag = 1;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SOC_BIZ_GUBUN_Y), SOC_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SOC_BIZ_GUBUN_N), SOC_N2);				
				EditCtrl_SetMaxChar (Get_hDlgCtrlByID(TXT_SOC_BIZ_NUM), 10);			
				break;
				
			case BID_DEPOSITOR_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_DEPOSITOR_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DEPOSITOR_NM)) );
				break;
				
			case BID_RAD_GUBUN_Y:
				m_lradgbn_flag = 1;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_N), CHK_N1);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CUSTINFO ), "0100001234"); 
				break;
			case BID_RAD_GUBUN_N:
				m_lradgbn_flag = 2;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_N), CHK_N2);
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, stMw.szReq_cp_ddd);
				Str_Cat( sztmp, stMw.szReq_cp_exn);
				Str_Cat( sztmp, stMw.szReq_cp_num);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CUSTINFO ), sztmp);
				break;
				
			case BID_CHKADJ: //������ ó��
				if( m_lDfrrd_flag == 1 )
				{
					m_lDfrrd_flag = 0;
//					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHKADJ), ALT_Y1);
				}
				else
				{
					m_lDfrrd_flag = 1;
//					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHKADJ), ALT_Y2);
				}
				
				ReDraw();
				break;
				
			case BID_SNDCASH:
				
				/* 20181029 ��� ������ Mcpay ������ ����
				if( Str_Cmp(stUserinfo.szcenter_cd, "11") == 0 || Str_Cmp(stUserinfo.szcenter_cd, "15") == 0 || Str_Cmp(stUserinfo.szcenter_cd, "41") == 0 || Str_Cmp(stUserinfo.szcenter_cd, "45") == 0 )
				{
					Snd_Cash_Mcpay();
				}
				else
				{
					Snd_Cash();
				}
				*/
				
				Snd_Cash_Mcpay();
				
				break;
				
			case BID_DFRRD:
				if( stMw.szAuto_yn[0] == 'Y')
				{
					if( MessageBoxEx (CONFIRM_YESNO, "�ĺ�ó���� ��� �ϰڽ��ϱ�?")  == MB_OK)
					{
						stMw.szAuto_yn[0] = 'N';
					}
				}
				else
				{
					if( stMw.szCard_onepay[0] == '2' )
					{
						MessageBoxEx (CONFIRM_OK, "��ȸ�� ī�� ������ ���õǾ� �ֽ��ϴ�.");
						ON_DRAW();
						break;
					}
					else
					{
						if( MessageBoxEx (CONFIRM_YESNO, "�ĺ�ó�� �ϰڽ��ϱ�?")  == MB_OK)
						{
							stMw.szAuto_yn[0] = 'Y';
							
							Print_BackPay();
						}
					}	
				}
				ReDraw();
				break;
			
			case BID_CASH:
				if( stMw.szAuto_yn[0] == 'Y' || Str_AtoI(stMw.szOnce_account) == 0 )
				{
					if( Str_Len( stMw.szAppro_num ) <= 0  )
					{
						break;
					}
				}
				
				if(stMw.szCard_onepay[0] == '2')
				{
					MessageBoxEx (CONFIRM_OK, "ī�� ������ ���õǾ� �ֽ��ϴ�.");
					ON_DRAW();
					break;
				}
				
				ON_EXIT();
				OnInit(INIT_CASH);
				break;
				
			case BID_CARD:
				if(	Str_Len( stMw.szAppro_num ) == 0  )
				{
					if( stMw.szCard_onepay[0] == '2' )
					{
						stMw.szCard_onepay[0] = '1';
						g_lOneCardPageFlag = 1;
						ButCtrl_SetText(Get_hDlgCtrlByID(BID_CARD), CARD_Y1);
					}
					else
					{
						stMw.szCard_onepay[0] = '2';
						g_lOneCardPageFlag = 0;
						ButCtrl_SetText(Get_hDlgCtrlByID(BID_CARD), CARD_Y2);
					}
					ReDraw();
				}
				else
				{
					MessageBoxEx (CONFIRM_YESNO, "���ݿ����� ������ �ֽ��ϴ�.");
					ON_DRAW();
				}
				break;
			case BID_REALPAY:
				if( MessageBoxEx (CONFIRM_YESNO, "�����ǽð���ȸ�� �Ͻðڽ��ϱ�?") != MB_OK)
					break;
				ON_EXIT();
				OnInit(INIT_PAYED);
				break;
				
			case BID_PRINTPAY:	
				Print_Payed();
				break;
				
			case BID_AUTO:
				if(g_nBackFlag == 1)
					break;					
				ON_EXIT();
				OnInit(INIT_AUTO);
				break;
				
			case BID_SNDAUTO:
				Snd_Auto();
				break;
				
			case BID_VIRTACT:
				if( MessageBoxEx (CONFIRM_YESNO, "������� ��ȸ�� �Ͻðڽ��ϱ�?") != MB_OK)
					break;
				ON_EXIT();
				OnInit(INIT_BANK);
				break;
				
			case BID_MEMO:
				
				ON_EXIT();
				OnInit(INIT_MEMO);
				break;
				
			case BID_WRITEMEMO:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_MEMO), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MEMO)) );
				break;
				
			case BID_MEMOCLOSE:
				Mem_Set( (byte*)stMw.szMemo, 0x00, sizeof(stMw.szMemo) );
				Str_Cpy(stMw.szMemo, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_MEMO )) );
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			case BID_PAYCLOSE:
				ON_EXIT();
				OnInit(INIT_BANK);
				break;

			case BID_SUBCLOSE:
				if( m_bFirst == INIT_PLANPAY )
				{
					Mem_Set( (byte*)stMw.szMemo, 0x00, sizeof(stMw.szMemo) );
					Str_Cpy(stMw.szMemo, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA3 )) );
				}
			
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					break;
				}
				Draw_MtrAmt();

				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					break;
				}
				Draw_MtrAmt();
				break;


			case BID_UP2:
				m_lpage2--;
				if(m_lpage2 < 0)
				{
					m_lpage2 = 0;
					break;
				}
				Draw_Nopay();
				break;			
			case BID_DOWN2:
				m_lpage2++;
				if( m_lpage2 > m_lTotpage2-1 )
				{
					m_lpage2 = m_lTotpage2-1;
					break;
				}
				Draw_Nopay();
				break;
				
			case BID_COMP:
				// if( Validate() )
				// 	Card_Move("C6101_WSIGN");
				if(Validate()){
					if( g_nWorkFlag == 660 )
					{
						if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0)
						{
							if (Str_Cmp( stMw.szProd_chg, "Y" ) == 0)
							{
								Chk_Prod();
							}
							else{
								Card_Move("C6101_WSIGN");
							}
						}
						else
						{
							Card_Move("C6101_WSIGN");
						}
					}
					else if(g_nWorkFlag == 650 )
					{
						if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) != 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0 )
						{
							if (Str_Cmp( stMw.szProd_chg, "Y" ) == 0)
							{
								Chk_Prod();
							}
							else
							{
								Card_Move("C6101_WSIGN");
							}
						}
						else
						{
							Card_Move("C6101_WSIGN");
						}

					}
					else
					{
						Card_Move("C6101_WSIGN");
					}
				}
					


				break;
			case BID_WCUST:
				Card_Move("C6101_WCUST");
				break;
			case BID_WMTR:
				Card_Move("C6101_WMTR");
				break;
			case BID_WBUR:
				Card_Move("C6101_WBUR");
				break;
			case BID_WCHK:
				Card_Move("C6101_WCHK");
				break;
			case BID_WONE:
				Card_Move("C6101_WONE");
				break;
			case BID_WSTOP:
				Card_Move("C6101_WSTOP");
				break;
			case BID_WRELE:
				Card_Move("C6101_WRELE");
				break;
			case BID_WPAY:
				//Card_Move("C6101_WPAY");
				break;			
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("C6101_MENU");
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
				Card_Move("C6101_LST");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
				
			case BID_CLOSE:
				if( MessageBoxEx (CONFIRM_YESNO, "�۾�����Ʈ ȭ������ �����ðڽ��ϱ�?")  == MB_OK)
				{
					Card_Move("C6101_LST");
				}
				break;
			
			case BID_NOT_OZ:
				Mem_Set( (byte*)stMw.szMemo, 0x00, sizeof(stMw.szMemo) );
				Str_Cpy(stMw.szMemo, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA3 )) );

				Rcv_Info(0); // �ϳ��� �̹���
				break;
			case BID_OZ:
				Mem_Set( (byte*)stMw.szMemo, 0x00, sizeof(stMw.szMemo) );
				Str_Cpy(stMw.szMemo, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA3 )) );

				Rcv_Info(1); // ����Ȯ�༭ ����
				break;
			case BID_OZ_MEMO:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_DATA3), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA3)) );
				break;
			case BID_OZ_MEMO_SAVE:
				Mem_Set( (byte*)stMw.szMemo, 0x00, sizeof(stMw.szMemo) );
				Str_Cpy(stMw.szMemo, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DATA3 )) );
				
				MessageBoxEx (CONFIRM_YESNO, "�޸� ����Ǿ����ϴ�.");
				break;
		}
	}
	
	//------------------------------------------------------------------
	void	OnSelect(long Index)
	{
	long index = -1;
	long lrow, lcol;
	char szdateS[12];
	char szdateE[12];
	char szdate[10];
	char sztmp[300];
	char szchk[4];
	handle* sql = NULL;
	char * sqlstr = "";
					
		if( INIT_MAIN == m_bFirst )
		{		
			//���� TBL�� ���õǾ������� Ȯ��
			if ( DlgTbl_IsSelect(ID_TBLLIST) == 1 && ( g_nWorkFlag == 620 || g_nWorkFlag == 630 ) )
			{
				if( g_lNpChkFlag == 1)
				{
					return;
				}
				
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				lrow = index/COL;
				lcol = index%COL;
				lrow--;
				
				if( lcol == 3 )
				{
					Str_Cpy( szchk, DlgTbl_GetStr( ID_TBLLIST, lrow, lcol) );
					if( Str_Cmp(szchk, CHKGOOD ) == 0)
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKNOGOOD );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST, lrow, 3, CHKGOOD );
						DlgTbl_SetStr ( ID_TBLLIST, lrow, 4, CHKGOOD );
					}	
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, 5) );	
					
					sql = STRING_Create(sqlstr);
					STRING_Empty(sql);
					STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
					if( Str_Cmp(szchk, CHKGOOD ) == 0)
						STRING_Append(sql," CHK_YN ='1'  ");
					else
						STRING_Append(sql," CHK_YN ='0', CARD_YN ='0', CARD_LIST_YN ='0' ");
					STRING_Append(sql," WHERE PROMISE_ASSIGN_SEQ = '");
					STRING_Append(sql,  g_szCHK_EXEC_NUM );
					STRING_Append(sql,"' AND MTR_NUM = '");
					STRING_Append(sql,  sztmp);
					STRING_Append(sql,"' ");
					sqlstr = STRING_toString(sql);	
						
					g_Sql_DirectExecute(sqlstr);
					STRING_Finalize(sql);
				}
				else if( lcol == 4 )
				{
					Str_Cpy( szchk, DlgTbl_GetStr( ID_TBLLIST, lrow, 3) );
					if( Str_Cmp(szchk, CHKNOGOOD ) == 0)
					{
						Str_Cpy( szchk, DlgTbl_GetStr( ID_TBLLIST, lrow, 4) );
						if( Str_Cmp(szchk, CHKGOOD ) == 0)
						{
							if( Chk_prod_cardpay() )
							{
								DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKNOGOOD );
							}
							else
							{
								return;
							}
						}
						else
						{
							DlgTbl_SetStr ( ID_TBLLIST, lrow, lcol, CHKGOOD );
						}
						
						Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST, lrow, 5) );
						
						sql = STRING_Create(sqlstr);
						STRING_Empty(sql);
						STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
						if( Str_Cmp(szchk, CHKGOOD ) == 0)
							STRING_Append(sql," CARD_YN ='1', CARD_LIST_YN='1' ");
						else
							STRING_Append(sql," CARD_YN ='0', CARD_LIST_YN='0' ");
						STRING_Append(sql," WHERE PROMISE_ASSIGN_SEQ = '");
						STRING_Append(sql,  g_szCHK_EXEC_NUM );
						STRING_Append(sql,"' AND MTR_NUM = '");
						STRING_Append(sql,  sztmp );
						STRING_Append(sql,"' ");
						sqlstr = STRING_toString(sql);
						g_Sql_DirectExecute(sqlstr);
						STRING_Finalize(sql);
					}
					
				}
				ReDraw();
				return;
			}

			if ( DlgTbl_IsSelect(ID_TBLLIST2) == 1  && g_nWorkFlag != 610  )
			{
				index = DlgTbl_GetActiveRow(ID_TBLLIST2);
				lrow = index/COL2;
				lcol = index%COL2;
				lrow--;
				
				if( lcol == 0 )
				{
					Mem_Set( (byte*)szdate, 0x00, sizeof(szdate) );
					Mem_Set( (byte*)szdateS, 0x00, sizeof(szdateS) );
					Mem_Set( (byte*)szdateE, 0x00, sizeof(szdateE) );
					Str_Cpy( szdate, DlgTbl_GetStr( ID_TBLLIST2, lrow, 5) );
					g_Str_DateType(szdateS, szdate);
					Str_Cpy( szdate, DlgTbl_GetStr( ID_TBLLIST2, lrow, 6) );
					g_Str_DateType(szdateE, szdate);
					
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					SPRINT(sztmp, "���Ⱓ : %s~%s ", szdateS, szdateE, 0);
					MessageBoxEx (CONFIRM_OK, sztmp);
				}
				else if( lcol == 3 )
				{
					if( g_lNpChkFlag == 1)
					{
						return;
					}
					
					Str_Cpy( szchk, DlgTbl_GetStr( ID_TBLLIST2, lrow, lcol) );
					
					if( Str_Cmp(szchk, CHKGOOD ) == 0)
					{
						DlgTbl_SetStr ( ID_TBLLIST2, lrow, 3, CHKNOGOOD );
					}
					else
					{
						DlgTbl_SetStr ( ID_TBLLIST2, lrow, 3, CHKGOOD );
						DlgTbl_SetStr ( ID_TBLLIST2, lrow, 4, CHKGOOD );
					}
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST2, lrow, 7) );
					
					sql = STRING_Create(sqlstr);
					STRING_Empty(sql);
					STRING_Append(sql," UPDATE C6101_NONPAY SET ");
					if( Str_Cmp(szchk, CHKGOOD ) == 0)
						STRING_Append(sql," CHK ='1'  ");
					else
						STRING_Append(sql," CHK ='0', CARD_YN ='0', CARD_LIST_YN='0' ");
					STRING_Append(sql," WHERE PROMISE_ASSIGN_SEQ = '");
					STRING_Append(sql,  g_szCHK_EXEC_NUM );
					STRING_Append(sql,"' AND MTR_NUM = '");
					STRING_Append(sql,  sztmp );
					STRING_Append(sql,"' AND REQ_YM = '");
					Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST2, lrow, 0) );
					
					// Str_Chg(sztmp, STRCHG_DEL_NONDIGIT );
					if(Str_Cmp(sztmp,"�������") == 0)
					{
						Str_Cpy(sztmp,"20");
					}
					else
					{
						Str_Chg(sztmp, STRCHG_DEL_NONDIGIT );
					}
					
					STRING_Append(sql, sztmp );
					STRING_Append(sql,"' ");
					sqlstr = STRING_toString(sql);		
					g_Sql_DirectExecute(sqlstr);
					STRING_Finalize(sql);
					
				}
				else if( lcol == 4 )
				{
					if( g_lNpChkFlag == 1)
					{
						return;
					}
					
					Str_Cpy( szchk, DlgTbl_GetStr( ID_TBLLIST2, lrow, 3) );
					
					if( Str_Cmp(szchk, CHKNOGOOD ) == 0)
					{
						Str_Cpy( szchk, DlgTbl_GetStr( ID_TBLLIST2, lrow, 4) );
						
						if( Str_Cmp(szchk, CHKGOOD ) == 0)
						{
							if( Chk_prod_cardpay() )
							{
								DlgTbl_SetStr ( ID_TBLLIST2, lrow, lcol, CHKNOGOOD );
							}
							else
							{
								return;
							}
						}
						else
						{
							DlgTbl_SetStr ( ID_TBLLIST2, lrow, lcol, CHKGOOD );
						}
						
						Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST2, lrow, 7) );
						
						sql = STRING_Create(sqlstr);
						STRING_Empty(sql);
						STRING_Append(sql," UPDATE C6101_NONPAY SET ");
						if( Str_Cmp(szchk, CHKGOOD ) == 0)
							STRING_Append(sql," CARD_YN ='1', CARD_LIST_YN='1'");
						else
							STRING_Append(sql," CARD_YN ='0', CARD_LIST_YN='0'");
						STRING_Append(sql," WHERE PROMISE_ASSIGN_SEQ = '");
						STRING_Append(sql,  g_szCHK_EXEC_NUM );
						STRING_Append(sql,"' AND MTR_NUM = '");
						STRING_Append(sql,  sztmp );
						STRING_Append(sql,"' AND REQ_YM = '");
						Str_Cpy( sztmp, DlgTbl_GetStr( ID_TBLLIST2, lrow, 0) );

						// Str_Chg(sztmp, STRCHG_DEL_NONDIGIT );
						if(Str_Cmp(sztmp,"�������") == 0)
						{
							Str_Cpy(sztmp,"20");
						}
						else
						{
							Str_Chg(sztmp, STRCHG_DEL_NONDIGIT );
						}
						// Str_Chg(sztmp, STRCHG_DEL_NONDIGIT );
						
						STRING_Append(sql, sztmp );
						STRING_Append(sql,"' ");
						sqlstr = STRING_toString(sql);		
						g_Sql_DirectExecute(sqlstr);
						STRING_Finalize(sql);
					}
				}
			}
			ReDraw();
		}
	}
	
	//------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		if( INIT_CASH == m_bFirst )
		{
			if( Get_iDlgCtrlByID(TXT_CUSTINFO) == m_lActiveIndex )
			{
				//���ڸ� �Է� ����
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					ON_KEY( 5 );
					return;
				}

			}
		}
		else if( INIT_AUTO == m_bFirst )
		{
			if( Get_iDlgCtrlByID(TXT_TEL_EXN) == m_lActiveIndex
			||  Get_iDlgCtrlByID(TXT_TEL_NUM) == m_lActiveIndex
			||  Get_iDlgCtrlByID(TXT_SOC_BIZ_NUM) == m_lActiveIndex
			||  Get_iDlgCtrlByID(TXT_ACCOUNT_NUM) == m_lActiveIndex  )
			{
				//���ڸ� �Է� ����
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					ON_KEY( 5 );
					return;
				}
			}
		}
	}
	
	//------------------------------------------------------------------
	void	OnPointing(long nAction, long X, long Y)
	{
		m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
		
		if( INIT_AUTO == m_bFirst )
		{	
			if( POINTING_UP == nAction )
			{
				if( X > DMS_X(STARTX+550) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+SYH*2-29) && Y < DMS_Y(STARTY+SYH*3-29)  
				||  X > DMS_X(STARTX+775) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+SYH*2-29) && Y < DMS_Y(STARTY+SYH*3-29)  
				||  X > DMS_X(STARTX+325) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+SYH*4-29) && Y < DMS_Y(STARTY+SYH*5-29)  
				||  X > DMS_X(STARTX+325) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+SYH*6-29) && Y < DMS_Y(STARTY+SYH*7-29)  
				)
				{
					if( Get_iDlgCtrlByID(TXT_TEL_EXN) == m_lActiveIndex 
					||  Get_iDlgCtrlByID(TXT_TEL_NUM) == m_lActiveIndex 
					||  Get_iDlgCtrlByID(TXT_SOC_BIZ_NUM) == m_lActiveIndex 
					||  Get_iDlgCtrlByID(TXT_ACCOUNT_NUM) == m_lActiveIndex 
					)	
					{
						g_Dlgflag = 0;
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
		else if( INIT_CASH == m_bFirst )
		{
			if( POINTING_UP == nAction )
			{
				if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+SYH-29) && Y < DMS_Y(STARTY+SYH*2-29) )
				{
					if( Get_iDlgCtrlByID(TXT_CUSTINFO) == m_lActiveIndex )	
					{
						g_Dlgflag = 0;
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
	
	//------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char* szOzData;
		char* szCashData;
		long nRet = 0;
		
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_IC_CARD )
			{
				//�ý�����
				szCashData = (char*)System_GetResult((char*)&nRet);
				
				//�Ʒ� �ּ��� Ǯ�� ��� �����͸� json ���Ϸ� ���� �� �� ����(������ġ : smart/SND.json)
				//g_Save_JsonFile(szCardData);
		
				//��� ����
				Rcv_CashData(szCashData);
			}
			else
			{
				//�ý�����
				szOzData = (char*)System_GetResult((char*)&nRet);
				
				//g_Save_JsonFile(szOzData);
				
				Rcv_OzData(szOzData);
			}
		}
	}
	
	//------------------------------------------------------------------
	void SetBtnImg(void)
	{
	long sX[8], eX[8];
	long lenX;
	long i;
	long TABCNT;
	long starty, highty;
	
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
			Mem_Set((byte*)&sX , 0x00, sizeof(sX));
			Mem_Set((byte*)&eX , 0x00, sizeof(eX));
			//610:����[��, ���ұ�, ��ǰ, ��ȸ��, ��� ]
			//620:����[��, ���ұ�, ����,  ��ȸ��, ��� ]
			//630:����[��, ����, ����, ��ȸ��, ��� ]
			//640:����[��, ����, ��ȸ��, ��� ]
			//650:��ü[��, ���ұ�, ��ȸ��, ��� ]
			//660:����[��, ���ұ�, ����(�跮�ⱳü), ��ȸ��, ��� ]
			
			if(   g_nWorkFlag == 640 )
			{
				TABCNT = 4;
				//lenX = CWD*9+20;
				lenX = CWD*10;
				
				sX[0] = 0;
			}
			else if(g_nWorkFlag == 660)
			{
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0 ){
					TABCNT = 6;
					lenX = 166;
				}
				else{
					TABCNT = 5;
					lenX = 200;
				}
				
				sX[0] = 0;
			}
			else if(g_nWorkFlag == 650)
			{	//���ұ� ���� �� ���/�跮�� �Ǵ� �����ξֵ��� ��ǰ�� ����
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) == 0 || Str_Cmp (stMw.szCont_sts_cd, "30") == 0 || Str_Cmp (stMw.szCont_sts_cd, "20") == 0) 
				{
					TABCNT = 4;
					lenX = CWD*10;
				}
				else {
					TABCNT = 5;
					lenX = CWD*8;
				}
				
				sX[0] = 0;
			}
			else
			{
				TABCNT = 5;
				//lenX = CWD*7+19;
				lenX = CWD*8;
				
				sX[0] = 0;
			}
			
			//sX[0] = 20;
			for(i = 0 ; i < TABCNT ; i++)
			{
				//eX[i] = sX[i] + lenX+5;
				eX[i] = sX[i] + lenX;
				sX[i+1] = eX[i];
			}
			starty = STARTY-29;
			highty = STARTY+40;
			
			i = 0;
			//���������� ����[��, �跮��, ���ұ�]
			if( Str_Cmp( stMw.szCivil_serv_class_cd, "070204" ) == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TITLE ),  "��������" );
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TITLE ),  stMw.szPda_duty );
			}
			
			//�� ������ ���� ���� ����.
			if( g_nWorkFlag == 610 )
			{
				//610:����[��, ���ұ�, ��ǰ, ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // ����
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "��ǰ" );
				//���õ� ���� Ȱ��ȭ�Ȱ�ó�� ���̰� ��.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[4]+4, highty-5, eX[4]-4, highty+5 );
				
			}
			else if( g_nWorkFlag == 620 )
			{
				//620:����[��, ���ұ�, ����,  ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // ����
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST),sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "����" );
				//���õ� ���� Ȱ��ȭ�Ȱ�ó�� ���̰� ��.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[4]+4, highty-5, eX[4]-4, highty+5 );
			}
			else if( g_nWorkFlag == 630 )
			{
				//630:����[��, ����, ����, ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);// ���ұ�
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // ����
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WSTOP), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
			
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "����" );
				//���õ� ���� Ȱ��ȭ�Ȱ�ó�� ���̰� ��.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[4]+4, highty-5, eX[4]-4, highty+5 );
			}
			else if( g_nWorkFlag == 640 )
			{
				//640:����[��, ����, ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);// ���ұ�
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// �跮��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // ����
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WRELE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
				//���õ� ���� Ȱ��ȭ�Ȱ�ó�� ���̰� ��.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[3]+4, highty-5, eX[3]-4, highty+5 );
				
			}
			else if( g_nWorkFlag == 650 )
			{
				//650:��ü[��, ���ұ�, ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // ����
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE); // ����
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) != 0)
				{
					if(Str_Cmp (stMw.szCont_sts_cd, "10") == 0 ){
						BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
						i++;
					}
				}
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );

				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "��ǰ" );
				//���õ� ���� Ȱ��ȭ�Ȱ�ó�� ���̰� ��.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[3]+4, highty-5, eX[3]-4, highty+5 );
			}
			else if( g_nWorkFlag == 660 )
			{
				//660:����[��, ���ұ�, ����(�跮�ⱳü), ��ȸ��, ��� ]
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// �跮��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0){
					BUTSETRANGE(Get_hDlgCtrlByID(BID_WMTR), sX[i], starty, eX[i], highty );
					i++;
				}
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCHK), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );

				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "��ǰ" );
				//���õ� ���� Ȱ��ȭ�Ȱ�ó�� ���̰� ��.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[4]+4, highty-5, eX[4]-4, highty+5 );
			}
		}
		else if( m_bFirst == INIT_MEMO )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_AUTO )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_BANK )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		}
		else if( m_bFirst == INIT_CASH )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
		}
		else if( m_bFirst == INIT_PAYED )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
		}
		else if( m_bFirst == INIT_PLANPAY )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
		}
	}

	//------------------------------------------------------------------
	void SetStyle(void)
	{
	long i;
	
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DEBT_AMT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DEBT_AMT), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_LAW_ETC_AMT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_LAW_ETC_AMT), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_SUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NOPAY), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHK_ACCOUNT), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHK_AMT), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CHK_CARD), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TOTAMT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TOTAMT), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_ACCOUNT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ACCOUNT), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_ALT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ALT), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_ONCE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ONCE), EDITALIGN_MIDDLE|EDITALIGN_LEFT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_PAY), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAY), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		}
		else if( m_bFirst == INIT_MEMO )
		{
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_MEMO), TRUE, 2, EDITSEP_NONE );
		}
		else if( m_bFirst == INIT_CASH )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_RAD_GUBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_RAD_GUBUN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CUSTINFO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CUSTINFO), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GUBUN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_GUBUN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_AMT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AMT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			for ( i = 0 ;  CASH_GBN[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_GUBUN+2), CASH_GBN[i].Str, 0, ICON_NONE);
			}
			
			if(	Str_Len( stMw.szAppro_num ) == 0  )
			{
				
			}
			else
			{
			
			}
		}
		else if( m_bFirst == INIT_AUTO )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DEPOSITOR_NM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DEPOSITOR_NM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DDEPOSITOR_RELAT_CD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DEPOSITOR_RELAT_CD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			//EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TEL_DDD), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_TEL_DDD_CD), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TEL_EXN), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TEL_NUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_SOC_BIZ_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SOC_BIZ_NUM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BNK_NM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BNK_NM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_ACCOUNT_NUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ACCOUNT_NUM), EDITALIGN_MIDDLE);
		}
		else if( m_bFirst == INIT_PLANPAY )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_TOP);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA1), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA3), TRUE, 2, EDITSEP_NONE );
		}
	}

	//------------------------------------------------------------------
	void ReDraw(void)
	{
	char sztmp[128];
	char szSql[200];
	char szWhere[300];
	long nonpay = 0;
	long n = 0;
	long once = 0;
	long account = 0;
	long pay = 0;
	
		if( m_bFirst == INIT_MAIN )
		{
			//20181011 ��ȸ����� redraw
			if( Str_AtoI( stMw.szOnce_account ) == 0 )
			{
				Redraw_once();	
			}
			
			if( g_nWorkFlag == 610 )
 			{
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_VIRTACT), FALSE);
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_AUTO), FALSE);
 				//�̳����� ���úҰ�
			}
			else
			{
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_VIRTACT), TRUE);
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_AUTO), TRUE);
			}
			
			if( g_nWorkFlag == 620 )//�ĺ�
			{
 				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_DFRRD), FALSE);
 				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_DFRRD), TRUE );
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_PLANPAY), TRUE);
 				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_MEMO), FALSE);

 				//��� ����Ȯ��
 				if(g_lNpChkFlag == 1)
 					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PLANPAY), RED);
 				else
 					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PLANPAY), BTNMENUFRCOLOR);
			}
			else
			{
				DlgCtrl_SetEnable( hCurDlg, Get_iDlgCtrlByID(BID_DFRRD), TRUE);
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_DFRRD), FALSE );
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_PLANPAY), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_MEMO), TRUE);
				
				if( Str_AtoI( stMw.szOnce_account ) == 0)
				{
					DlgCtrl_SetEnable( hCurDlg, Get_iDlgCtrlByID(BID_DFRRD), FALSE);
					DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_DFRRD), TRUE );					
				}
				
				//��ȸ�� �ĺ�
				if( stMw.szAuto_yn[0] == 'Y')
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_DFRRD), RED);
				else
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_DFRRD), BTNMENUFRCOLOR);
			}
			
			if( Str_AtoI( stMw.szOnce_account ) == 0 )
			{
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CARD), TRUE );
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CARD), FALSE);
				
				if( Str_Len( stMw.szAppro_num ) > 0 )
				{
					DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CASH), FALSE );
					DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CASH), TRUE);
				}
				else
				{
					DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CASH), TRUE );
					DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CASH), FALSE);
				}
			}
			else
			{
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CARD), FALSE );
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CARD), TRUE);
				
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CASH), FALSE );
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CASH), TRUE);
			}
			
			/*
			if( Str_AtoI( stMw.szOnce_account ) == 0 )
			{
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CARD), TRUE );
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CARD), FALSE);
				
				if( Str_Len( stMw.szAppro_num ) > 0 )
				{
					DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CASH), FALSE );
					DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CASH), TRUE);
				}
				else
				{
					DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CASH), TRUE );
					DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CASH), FALSE);
				}
			}
			else
			{
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CARD), FALSE );
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CARD), TRUE);
				
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CASH), TRUE );
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CASH), FALSE);
			}
			*/
				
			if(	Str_Len( stMw.szAppro_num ) > 0  )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CASH), RED);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CASH), BTNMENUFRCOLOR);	
			}
			else
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CASH), BTNCTRLBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_CASH), BTNMENUFRCOLOR);
			}
			
			if(g_nBackFlag == 1)
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_AUTO), RED);
			}
			else
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_AUTO), BTNMENUFRCOLOR);
			}	
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, stMw.szDebt_amt );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DEBT_AMT ),    sztmp );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, stMw.szLaw_etc_amt );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_LAW_ETC_AMT ), sztmp );
			
			if( m_lDfrrd_flag == -1)
			{
				if( Str_AtoI(stMw.szAdj_alt_amt) > 0 )
					m_lDfrrd_flag =1;
				else
					m_lDfrrd_flag =0;
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			m_nAdj_amt = 0 ;
			SPRINT(szSql, "SELECT ADJ_ALT_AMT FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( szSql, &m_nAdj_amt );
			if(n < 0)
				m_nAdj_amt = 0;
			
			if( m_nAdj_amt == 0)
			{
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CHKADJ), TRUE );
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CHKADJ), FALSE);

				m_lDfrrd_flag = 0;
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHKADJ), ALT_Y1);
			}
			else
			{
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CHKADJ), FALSE );
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CHKADJ), TRUE);
				
				if( m_lAdjAmtFlag == 0 )
				{
					//2017-09-21 Sanghyun Lee
					//m_lAdjAmtFlag = 0 ȭ�� ù ȣ�� , m_lAdjAmtFlag = 1 ������ ���
					//ȭ�� ù ȣ�� �� ������ ���ο� ���� �����ݹ�ư ���� ���� �÷���
					m_lAdjAmtFlag = 1;
					
					m_lDfrrd_flag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHKADJ), ALT_Y2);
				}
				else
				{
					if( m_lDfrrd_flag == 1 )
					{
						ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHKADJ), ALT_Y2);
					}
					else
					{
						ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHKADJ), ALT_Y1);
					}
				}
//				m_lDfrrd_flag = 1;
//				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CHKADJ), ALT_Y2);
			}
			
			Str_ItoA( m_nAdj_amt, sztmp, 10);
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ALT),  sztmp );//������
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, stMw.szOnce_account );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ONCE ), sztmp );//��ȸ��
			
			once = Str_AtoI( stMw.szOnce_account );
			
			if( stMw.szCard_onepay[0] == '2' &&  once > 0)
			{
				ButCtrl_SetText( Get_hDlgCtrlByID(BID_CARD), CARD_Y2 );
				g_lOneCardPageFlag = 0;
			}
			else if( stMw.szCard_onepay[0] != '2' && once > 0 )
			{
				stMw.szCard_onepay[0] = '1';
				ButCtrl_SetText( Get_hDlgCtrlByID(BID_CARD), CARD_Y1 );
				g_lOneCardPageFlag = 1;
			}
			else
			{
				Mem_Set( (byte*)stMw.szCard_onepay, 0x00, sizeof(stMw.szCard_onepay) );
				g_lOneCardPageFlag = 1;
			}
			
			// 20180622 ��ȸ����� ī����� �����Ҷ��� TRUE
			if( Str_Cmp(stUserinfo.szOneCard_yn,"Y") == 0 )
			{
				if( Str_AtoI( stMw.szOnce_account ) == 0 )
				{
					DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CARD), FALSE);
					DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CARD), TRUE );
				}
				else
				{
					DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CARD), TRUE);
					DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CARD), FALSE );
				}
			}
			else
			{
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CARD), FALSE);
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(BID_CARD), TRUE );
			}
			
			if( stMw.szAuto_yn[0] == 'Y' || once == 0 )//�ĺ��̰ų� ī������� ���
				DlgCtrl_SetEnable(hCurDlg, Get_iDlgCtrlByID(BID_CARD), FALSE);
				
			if( stMw.szAuto_yn[0] == 'Y' )//�ĺ��̰ų� ī������� ���
			{
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(TXT_ONCE), TRUE );
			}
			else
			{
				DlgCtrl_SetGray( hCurDlg, Get_iDlgCtrlByID(TXT_ONCE), FALSE );
			}
			
			//��� �߻��ݾ�
			account = 0;
			nonpay = 0;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( szSql, &account );

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA(account, sztmp, 10 );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CHK_ACCOUNT),  sztmp );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( szSql, &nonpay );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA(nonpay, sztmp, 10 );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_NOPAY),  sztmp );
			
			n = nonpay+account+once;
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA(n, sztmp, 10 );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TOTAMT),  sztmp );//�ѱݾ�

			//��� �����ݾ�
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN= '1' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( szSql, &account );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '1' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( szSql, &nonpay );
			
			if( m_lDfrrd_flag == 0 )
			{
				n = nonpay+account;
				m_nAdj_amt = 0;
			}
			else
			{
				n = nonpay+account - m_nAdj_amt;
				if( n < 0 )
				{
					if( nonpay+account == 0)
						m_nAdj_amt = 0;
					else
						m_nAdj_amt = nonpay+account;
					n = 0;
				}
			}	
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA(m_nAdj_amt, sztmp, 10 );
			Str_Cpy( stMw.szAdj_alt_amt, sztmp);//��� �����ݾ�
			
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA(n, sztmp, 10 );
			Str_Cpy( stMw.szAccount, sztmp);//��� �����ݾ�
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ACCOUNT ), sztmp );//��� �����ݾ�
			
			if( stMw.szAuto_yn[0] == 'Y')
			{
			
				if( m_lDfrrd_flag == 0 )
					n = nonpay+account;
				else
					n = nonpay+account-Str_AtoI(stMw.szAdj_alt_amt);
			}
			else
			{
				if( m_lDfrrd_flag == 0 )
					n = nonpay+account+once;
				else
					n = nonpay+account+once - Str_AtoI(stMw.szAdj_alt_amt);
			}	
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA(n, sztmp, 10 );
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_PAY), sztmp );//�����ݾ�
			
			Load_CardData();
			Load_OneCardData();
			
			ON_DRAW();
			
		}
		else if( m_bFirst == INIT_MEMO )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MEMO ),  stMw.szMemo );
		}
		else if( m_bFirst == INIT_BANK )
		{
			if(m_lvirt == 0)
			{
				Rcv_VirtAccount();
			}
		}
		else if( m_bFirst == INIT_AUTO ) // ȯ�Ұ���
		{
//PRINT("Redraw INIT_AUTO 0000", 0, 0, 0);
			SetCombo();
//PRINT("Redraw INIT_AUTO 0010", 0, 0, 0);
			m_lSoc_flag = 0;
//PRINT("Redraw INIT_AUTO 0020", 0, 0, 0);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DEPOSITOR_RELAT_CD ),  ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_DEPOSITOR_RELAT_CD+2 ), 0)  );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_TEL_DDD_CD ),  ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_TEL_DDD_CD+2 ), 0)  );
			
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SOC_BIZ_GUBUN_Y), SOC_Y2);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SOC_BIZ_GUBUN_N), SOC_N1);
//PRINT("Redraw INIT_AUTO 0030", 0, 0, 0);
			EditCtrl_SetMaxChar (Get_hDlgCtrlByID(TXT_SOC_BIZ_NUM), 6);
//PRINT("Redraw INIT_AUTO 0040", 0, 0, 0);
			//Str_Cpy( sztmp, stMw.szOnce_account );
			//Str_Chg( sztmp, STRCHG_INS_COMMA );
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_ONCE ), sztmp);
//PRINT("Redraw INIT_AUTO 0050", 0, 0, 0);
			
		}
		else if( m_bFirst == INIT_PAYED )
		{
			Snd_Payed();
		}
		else if( m_bFirst == INIT_CASH )
		{
			// ���ݿ����� ����
			if(	Str_Len( stMw.szAppro_num ) == 0  )
			{
				// 0 = �ҵ����, 1 = ������������
				if( Str_Len(stCashinfo.szStatus_flag) == 0 )
				{
					Str_Cpy(stCashinfo.szStatus_flag, "0");
				}
				
				// �ŷ��ݾ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, stMw.szOnce_account );
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AMT ), sztmp);
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SNDCASH), "���ο�û");
			}
			// ���ݿ����� ���
			else
			{
				// �ŷ��ݾ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy( sztmp, stCashinfo.szAmt );
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AMT ), sztmp);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_CUSTINFO ), stCashinfo.szCust_info );
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SNDCASH), "�������");
			}
			
			// �ŷ��� ����
			n = SearchCD( stCashinfo.szStatus_flag, CASH_GBN );
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_GUBUN), CASH_GBN[n].Str);	
			
			// �����߱ݿ���
			if(m_lradgbn_flag == 0 || m_lradgbn_flag == 2 )
			{
				m_lradgbn_flag = 2;
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_N), CHK_N2);
				
				if(	Str_Len( stMw.szAppro_num ) == 0  )
				{
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					Str_Cpy( sztmp, stMw.szReq_cp_ddd);
					Str_Cat( sztmp, stMw.szReq_cp_exn);
					Str_Cat( sztmp, stMw.szReq_cp_num);
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CUSTINFO ), sztmp);
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CUSTINFO ), stMw.szAppro_tel);
				}
			}
			else
			{
				m_lradgbn_flag = 1;

				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_RAD_GUBUN_N), CHK_N1);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_CUSTINFO ), "0100001234"); 					
			}
		}
		else if( m_bFirst == INIT_PLANPAY )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA3),  stMw.szMemo );
		}
		ON_DRAW();
	}
	
	//----------------------------------------------------------------------
	void Load_CardData(void)
	{
	long i;
	char sztmp[10];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stCardinfo, 0x00, sizeof(stCardinfo));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PROMISE_ASSIGN_SEQ,USE_CONT_NUM,ITEM_FLAG,REQ_YMD,RECEV_SEQ \
,DATA_FLAG,RSLT_CD,TERMINAL_GBN,TERMINAL_NUM,CARD_NUM \
,VALID_YM,CARD_COM,CARD_TYPE_NM,BUYING_COMP,BUYING_COMP_NM \
,APPROVAL_AMT,APPROVAL_NUM,ALLOTMENT_MM,APPROVAL_TIME \
,CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ \
FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = ? AND ITEM_FLAG = '10' ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szPromise_assign_seq    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szUse_cont_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szItem_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szReq_ymd               ,8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRecev_seq             ,3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szData_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szRslt_cd               ,1  +1, DECRYPT );
			Mem_Set((byte*)sztmp, 0x00,sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp                              ,2    , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szTerminal_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_num              ,128+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szValid_ym              ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_com              ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCard_type_nm          ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szBuying_comp           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szBuying_comp_nm        ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_amt          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_num          ,12 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szAllotment_mm          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szApproval_time         ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szCivil_serv_receive_num,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stCardinfo.szTreat_seq             ,10 +1, DECRYPT );
		}
Finally:

		DelSqLite(sql);
		return;
	}
	
	//----------------------------------------------------------------------
	void Load_OneCardData(void)
	{
	long i;
	char sztmp[10];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stOneCardinfo, 0x00, sizeof(stOneCardinfo));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PROMISE_ASSIGN_SEQ,USE_CONT_NUM,ITEM_FLAG,REQ_YMD,RECEV_SEQ \
										,DATA_FLAG,RSLT_CD,TERMINAL_GBN,TERMINAL_NUM,CARD_NUM \
										,VALID_YM,CARD_COM,CARD_TYPE_NM,BUYING_COMP,BUYING_COMP_NM \
										,APPROVAL_AMT,APPROVAL_NUM,ALLOTMENT_MM,APPROVAL_TIME \
										,CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ \
										FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = ? AND ITEM_FLAG = '20' ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szPromise_assign_seq    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szUse_cont_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szItem_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szReq_ymd               ,8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szRecev_seq             ,3  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szData_flag             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szRslt_cd               ,1  +1, DECRYPT );
			Mem_Set((byte*)sztmp, 0x00,sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp                              ,2    , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szTerminal_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szCard_num              ,128+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szValid_ym              ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szCard_com              ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szCard_type_nm          ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szBuying_comp           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szBuying_comp_nm        ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szApproval_amt          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szApproval_num          ,12 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szAllotment_mm          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szApproval_time         ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szCivil_serv_receive_num,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stOneCardinfo.szTreat_seq             ,10 +1, DECRYPT );
		}
Finally:

		DelSqLite(sql);
		return;
	}

	//------------------------------------------------------------------
	void Draw_MtrAmt(void)
	{
	long i, idx;
	long k = ROW+1;
	long lTotPage;
	long lstartidx;
	char sztmp[100];
	char szSql[100];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &m_lTotpage);
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		SPRINT(sztmp, "%d/%d", m_lpage+1, m_lTotpage,0);
		EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_PAGE ), sztmp );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		hstmt = sql->CreateStatement(sql, " SELECT A.MTR_ID_NUM \
,(SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ=A.PROMISE_ASSIGN_SEQ AND MTR_NUM=A.MTR_NUM) AS NONPAY \
,A.ACCOUNT, A.CHK_YN, A.CARD_YN, A.MTR_NUM  \
FROM C6101_PROMISE_MTR A  WHERE A.PROMISE_ASSIGN_SEQ = ? ORDER BY A.MTR_ID_NUM LIMIT ?, ? " );
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);
		lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage*ROW+ROW;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
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
				k = i + 1;
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
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 26, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 15, DECRYPT);
				if(Str_Len(sztmp) == 0)
					Str_Cpy(sztmp,"0");
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 15, DECRYPT);
				if(Str_Len(sztmp) == 0)
					Str_Cpy(sztmp,"0");
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 2, DECRYPT);
				if( sztmp[0] == '1' )
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, CHKNOGOOD );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 3,  CHKGOOD);
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 2, DECRYPT);
				if( sztmp[0] == '1' )
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, CHKNOGOOD);
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 4, CHKGOOD );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 5, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
	}
	
	//------------------------------------------------------------------
	void Draw_Nopay(void)
	{
	long i, idx;
	long k = ROW2+1;
	long lTotPage;
	long lstartidx;
	char sztmp[51];
	char szbuf[51];
	char szSql[200];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &m_lTotpage2);

		//SPRINT(m_szCnt_index, "%d/%d", m_lpage2+1, m_lTotpage2,0);
		if( m_lTotpage2 % ROW2 > 0 )
		{
			m_lTotpage2 = (m_lTotpage2 / ROW2) + 1;
		}
		else
		{
			m_lTotpage2 = m_lTotpage2 / ROW2;
		}
		SPRINT(sztmp, "%d/%d", m_lpage2+1, m_lTotpage2,0);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_PAGE2 ), sztmp );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		hstmt = sql->CreateStatement(sql, "SELECT REQ_YM, UNPAY_AMT, REQ_MANAGE_STS, CHK, CARD_YN,USE_PERIOD_STR, USE_PERIOD_END, MTR_NUM FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = ? ORDER BY REQ_YM DESC LIMIT ?, ? " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);
		lstartidx = m_lpage2*ROW2;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage2*ROW2+ROW2;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW2 ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST2, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 5, "" );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 6, "" );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 7, "" );
				k = i + 1;
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST2, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST2, i, 1, "" );
					DlgTbl_SetStr ( ID_TBLLIST2, i, 2, "" );
					DlgTbl_SetStr ( ID_TBLLIST2, i, 3, "" );
					DlgTbl_SetStr ( ID_TBLLIST2, i, 4, "" );
					DlgTbl_SetStr ( ID_TBLLIST2, i, 5, "" );
					DlgTbl_SetStr ( ID_TBLLIST2, i, 6, "" );
					DlgTbl_SetStr ( ID_TBLLIST2, i, 7, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 8, DECRYPT);
				// PRINT("11sztmpsztmpsztmpsztmpsztmp:%s",sztmp,0,0);
				if(Str_Cmp(sztmp,"20") != 0)
				{
					g_Str_DateType(szbuf, sztmp);
				}
				else
				{
					Str_Cpy(szbuf,"�������");
				}
				DlgTbl_SetStr ( ID_TBLLIST2, i, 0, szbuf );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 10, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_TBLLIST2, i, 1, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 14, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST2, i, 2, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 2, DECRYPT);
				if( sztmp[0] == '1' )
					DlgTbl_SetStr ( ID_TBLLIST2, i, 3, CHKNOGOOD );
				else
					DlgTbl_SetStr ( ID_TBLLIST2, i, 3, CHKGOOD );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 2, DECRYPT);
				if( sztmp[0] == '1' )
					DlgTbl_SetStr ( ID_TBLLIST2, i, 4, CHKNOGOOD );
				else
					DlgTbl_SetStr ( ID_TBLLIST2, i, 4, CHKGOOD );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 5, 'U', (long*)sztmp, 14, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST2, i, 5, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 6, 'U', (long*)sztmp, 14, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST2, i, 6, sztmp );	
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 7, 'U', (long*)sztmp, 14, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST2, i, 7, sztmp );	
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
	}
	
	//------------------------------------------------------------------
	long Rcv_VirtAccount(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char sznm_kor[64];
		char* sndbuf;
		long ret;
		long ntotcnt;
		
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82211, FALSE);
		
		//JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  "6003658048" );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stMw.szUse_cont_num );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82211; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR82211_IN",  "FR82211" , sndbuf, sztmp );
		return 0 ;
	}
	
	//------------------------------------------------------------------
	long TR82211(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82211) >= 0)
		{
			//MessageBoxEx (CONFIRM_OK, "��ȸ����");
			m_lvirt = 1;
			Virt_Draw();
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
	void Virt_Draw(void)
	{
	long i, idx;
	long k = 10;
	char sztmp[201];
	long ret = -1;	
	long lstartidx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_TMP", &m_lTotpage3 );
		
		if( m_lTotpage3 % ROW3 > 0 )
		{
			m_lTotpage3 = (m_lTotpage3 / ROW3) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage3 / ROW3;
		}
		//������
		SPRINT(m_szCnt_index, "%d/%d", m_lpage3+1, m_lTotpage3, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT  PARAM3, PARAM2, PARAM1, '1' as srt \
FROM RCV_TMP \
where PARAM3 = '003'  \
union \
SELECT PARAM3, PARAM2, PARAM1 , '2' as srt \
FROM RCV_TMP \
where PARAM3 = '027' \
union \
SELECT  PARAM3, PARAM2, PARAM1, '3' as srt \
FROM RCV_TMP \
where PARAM3 <> '027' and PARAM3 <> '003' \
order by srt, PARAM3 LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lpage3*ROW3;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage3*ROW3+ROW3;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW3 ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 2, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 2, "" );
					continue;
				}
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 0, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 1, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 2, sztmp );
			}
		}		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		ON_DRAW();
		return;
	}
	
	//------------------------------------------------------------------
	void SetCombo(void)
	{	
		char szSql[300];
		char sztmp[100];
		long i;

		m_sql = NewSqLite();
		if (m_sql == NULL)
		{
			goto Finally;
		}

		m_hdb = m_sql->Open(m_sql);
		if( m_hdb == NULL )
		{
			goto Finally;
		}
			
		//�������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		if( m_bFirst == INIT_AUTO )
		{
			SPRINT(szSql, " SELECT BNK_BRANCH_NM FROM C6101_BNK  ", 0, 0, 0);			
			Sql_SetCombo(szSql, CMB_BNK_NM+2);
			
			SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE  WHERE CODE_ID = 'C10004' ORDER BY CODE_ITEM ", 0, 0, 0);			
			Sql_SetCombo(szSql, CMB_DEPOSITOR_RELAT_CD+2);
			
			SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE  WHERE CODE_ID = 'A10110' ORDER BY SORT_ORDER ", 0, 0, 0);			
			Sql_SetCombo(szSql, CMB_TEL_DDD_CD+2);

		}
	
Finally:
		if(m_sql != NULL)
			m_sql->Commit(m_sql);
		
		DelSqLite(m_sql);
		return;
	}
	
	//------------------------------------------------------------------
	long Sql_SetCombo(char* szSql, long CTRLID )
	{
		long ret = -1;
		char szBuf[101];
		long cnt  = 0;
		SQLITE sql = m_sql;

		m_hstmt = sql->CreateStatement(sql, szSql);
		if( m_hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		sql->Begin(sql);

		ret = sql->Execute(sql);

		cnt = 0;
		while(sql->Next(sql) == TRUE)
		{
			Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue( sql, 0, 'U', (long*)szBuf, sizeof(szBuf), DECRYPT );
			ListCtrl_AddItem (Get_hDlgCtrlByID(CTRLID), szBuf, 0, ICON_NONE);
			cnt++;
			if(cnt == 100)
				break;
		}
		
Finally:
		return ret;
	}
	
	//------------------------------------------------------------------
	void Snd_Auto(void)
	{
	char sztmp[128];
	char szUrl[200];
	char szSql[300];
	char szbuf[128];
	char szbnk_cd[128];
	char szdepositor_nm[51];
	char szUdepositor_nm[101];
	char szsoc_biz_num[14];
	char sztel_ddd[5];
	char sztel_exn[5];
	char sztel_num[5];
	char szaccount_num[30];
	char szdepositor_relat_cd[3];
	char* sndbuf;
	long ret = 0;
		
		if(EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_DEPOSITOR_NM)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "�����ָ��� �Է��ϼ���.");
			return;
		}
		if(m_lSoc_flag == 0 && EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_SOC_BIZ_NUM)) != 6 )
		{
			MessageBoxEx (ERROR_OK, "���������  6�ڸ��� �Է��ϼž� �մϴ�.");
			return;
		}
		
		if(m_lSoc_flag == 1 && EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_SOC_BIZ_NUM)) != 10 )
		{
			MessageBoxEx (ERROR_OK, "����ڹ�ȣ�� 10�ڸ��� �Է��ϼž� �մϴ�.");
			return;
		}


		//if(EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_TEL_DDD)) < 2 )
		if(EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_TEL_DDD_CD)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "��ȭ��ȣ�� Ȯ���ϼ���.");
			return;
		}
		if(EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_TEL_EXN)) < 3  )
		{
			MessageBoxEx (ERROR_OK, "��ȭ��ȣ�� Ȯ���ϼ���.");
			return;
		}
		if(EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_TEL_NUM)) != 4 )
		{
			MessageBoxEx (ERROR_OK, "��ȭ��ȣ�� Ȯ���ϼ���.");
			return;
		}
		if(EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_DEPOSITOR_RELAT_CD)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "������ ���踦 Ȯ���ϼ���.");
			return;
		}
		if(EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_BNK_NM)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "������ Ȯ���ϼ���.");
			return;
		}
		
		
		if( MessageBoxEx (CONFIRM_YESNO, "ȯ�Ұ��¸� ����Ͻðڽ��ϱ�?") != MB_OK)
		{
			return;
		}
		
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szbnk_cd, 0x00, sizeof(szbnk_cd) );
		Mem_Set( (byte*)szdepositor_nm, 0x00, sizeof(szdepositor_nm) );
		Mem_Set( (byte*)szUdepositor_nm, 0x00, sizeof(szUdepositor_nm) );
		Mem_Set( (byte*)szsoc_biz_num, 0x00, sizeof(szsoc_biz_num) );
		Mem_Set( (byte*)sztel_ddd, 0x00, sizeof(sztel_ddd) );
		Mem_Set( (byte*)sztel_exn, 0x00, sizeof(sztel_exn) );
		Mem_Set( (byte*)sztel_num, 0x00, sizeof(sztel_num) );
		Mem_Set( (byte*)szdepositor_relat_cd, 0x00, sizeof(szdepositor_relat_cd) );
		Mem_Set( (byte*)szaccount_num, 0x00, sizeof(szaccount_num) );
		
		Str_Cpy( szdepositor_nm,  EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_DEPOSITOR_NM))  );
		Str_Cpy( szsoc_biz_num,   EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_SOC_BIZ_NUM))  );
		//Str_Cpy( sztel_ddd,       EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_TEL_DDD))  );
		Str_Cpy( sztel_exn,       EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_TEL_EXN))  );
		Str_Cpy( sztel_num,       EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_TEL_NUM))  );
		Str_Cpy( szaccount_num,   EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_ACCOUNT_NUM))  );
		
		if(m_lSoc_flag == 0 && Str_Len(szsoc_biz_num) == 6 )
		{
			Str_Cat(szsoc_biz_num, "0000000");
		}

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy( sztmp,       EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_BNK_NM))  );
		SPRINT(szSql, "SELECT  CUST_SUPT_USE_CD FROM C6101_BNK WHERE BNK_BRANCH_NM= '%s' ", sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 3, szbnk_cd );
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy( sztmp,       EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DEPOSITOR_RELAT_CD))  );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s' ", sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 2, szdepositor_relat_cd );
			
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Str_Cpy( sztmp,       EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_TEL_DDD_CD))  );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'A10110' AND ITEM_KNAME = '%s' ", sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 4, sztel_ddd );
			
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66302, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMw.szUse_cont_num );
		JSON_SetValue( g_pjcomm, 'C', "bnk_cd", szbnk_cd );
		JSON_SetValue( g_pjcomm, 'C', "account_num", szaccount_num );
		SQL_ConvUcStr( szUdepositor_nm, szdepositor_nm );
		JSON_SetValue( g_pjcomm, 'C', "depositor_nm", szUdepositor_nm );
		JSON_SetValue( g_pjcomm, 'C', "soc_biz_num", szsoc_biz_num );
		JSON_SetValue( g_pjcomm, 'C', "tel_ddd", sztel_ddd );
		JSON_SetValue( g_pjcomm, 'C', "tel_exn", sztel_exn );
		JSON_SetValue( g_pjcomm, 'C', "tel_num", sztel_num );
		JSON_SetValue( g_pjcomm, 'C', "depositor_relat_cd", szdepositor_relat_cd );
		
		
		sndbuf = JSON_toString(g_pjcomm);
		//g_Save_JsonFile(sndbuf);
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_Auto; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR66302_IN",  "FR66302" , sndbuf, szbuf );
	}
	
	//------------------------------------------------------------------
	long Rcv_Auto(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(66302) >= 0)
		{
			MessageBoxEx (CONFIRM_OK, "ó���� �Ϸ� �Ǿ����ϴ�.");
			g_nBackFlag =1;
			ON_EXIT();
			OnInit(INIT_MAIN);
			ON_DRAW();
			return 1;
		}
		else
		{
			MessageBoxEx (ERROR_OK, "���� �������.");
			ON_DRAW();
			return -1;
		}
	}
	
	//------------------------------------------------------------------
	void Snd_Payed(void)
	{
	char sztmp[128];
	char szUrl[200];
	char szbuf[128];
	char szDate[10];
	char* sndbuf;
	long ret = 0;
		
		g_Sql_DirectExecute("DELETE FROM RCV_RELEASE");
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		ret = Time_DateUpDown( Time_GetDate(), -150);
		Str_ItoA( ret, szDate, 10);

		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66602, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMw.szUse_cont_num );
		JSON_SetValue( g_pjcomm, 'C', "receipt_ymd", szDate );
		
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_Payed; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR66602_IN",  "FR66602" , sndbuf, szbuf );
	}
	
	//------------------------------------------------------------------
	long Rcv_Payed(void)
	{
	long ret;
	
		g_Sock_Close();
		ret = g_Chk_Json(66602);
		if( ret > 0)
		{
			MessageBoxEx (CONFIRM_OK, "ó���� �Ϸ� �Ǿ����ϴ�.");
			Payed_Draw();
			return 1;
		}
		else if (ret == 0)
		{
			MessageBoxEx (CONFIRM_OK, "���γ����� �����ϴ�.");
			//Payed_Draw();
			ON_EXIT();
			OnInit(INIT_BANK);
			return 1;
		}
		else
		{
			m_lTotpage3 = -1;
			MessageBoxEx (ERROR_OK, "���� �������.");
			ON_DRAW();
			return -1;
		}
	}
	
	//------------------------------------------------------------------
	void Payed_Draw(void)
	{
	long i, idx;
	long k = 10;
	char sztmp[201];
	char szbuf[32];
	long ret = -1;	
	long lstartidx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_RELEASE", &m_lTotpage3 );
		
		if( m_lTotpage3 % ROW3 > 0 )
		{
			m_lTotpage3 = (m_lTotpage3 / ROW3) + 1;
		}
		else
		{
			m_lTotpage3 = m_lTotpage3 / ROW3;
		}
		//������
		SPRINT(m_szCnt_index, "%d/%d", m_lpage3+1, m_lTotpage3, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT  PARAM2, PARAM1, PARAM3 FROM RCV_RELEASE ORDER BY PARAM2 DESC LIMIT ?, ? " );
				
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		lstartidx = m_lpage3*ROW3;
		sql->Bind(sql, idx++, 'X', &lstartidx, 4, DECRYPT);
		i = m_lpage3*ROW3+ROW3;
		sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		// ��ϵ� �ڵ� ����Ʈ�� �������� �°� �����ش�.
		for (i=0 ; i<ROW3 ; i++)
		{
			//�ڷᰡ ������ ȭ���� Ŭ���� ��Ų��.
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 2, "" );
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 1, "" );
					DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 2, "" );
					continue;
				}
				idx = 0;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				g_Str_DateType(szbuf, sztmp);
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 0, szbuf );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 1, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, idx++, 'U', (long*)sztmp, 5, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_VIRTTBLLIST, i, 2, sztmp );
			}
		}		
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);

		ON_DRAW();
		return;
	}
		
	//------------------------------------------------------------------
	void Snd_Cash(void)
	{
	char sztmp[128];
	char szUrl[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;
	long amt = 0;
	long vat = 0;
	long i;
	
		if(	Str_Len( stMw.szAppro_num ) == 0  )
		{
			if(Str_Len(stMw.szOnce_account) == 0 || Str_AtoI(stMw.szOnce_account) == 0)
			{
				MessageBoxEx (ERROR_OK, "�ݾ��� Ȯ���ϼ���.");
				return;
			}
			
			if(EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_GUBUN )) == 0 )
			{
				MessageBoxEx (ERROR_OK, "�źе�Ϲ�ȣ�� �ŷ��� ������ Ȯ���ϼ���.");
				return;
			}
			
			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_CUSTINFO)) == 0 )
			{
				MessageBoxEx (ERROR_OK, "�ź� ��Ϲ�ȣ�� �Է����ּ���.");
				return;
			}
			
			if(MessageBoxEx (CONFIRM_YESNO, "���ݿ������� ��� �Ͻðڽ��ϱ�?") != MB_OK)
				return;
		
			Mem_Set( (byte*) stCashinfo.szAmt, 0x00, sizeof(stCashinfo.szAmt)  );
			Str_Cpy( stCashinfo.szAmt, stMw.szOnce_account );
			amt = Str_AtoI( stMw.szOnce_account );
			vat = amt*10/110;
			Str_ItoA(vat , stCashinfo.szVat, 10);
			
			Str_Cpy(stCashinfo.szPromise_assign_seq, stMw.szPromise_assign_seq );
			Str_Cpy(stCashinfo.szUse_cont_num,       stMw.szUse_cont_num );
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof(sztmp)  );
			Str_Cpy(sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GUBUN )) );
			i = SearchStr(sztmp, CASH_GBN );
			if (i > -1)
			{
				Str_Cpy(stCashinfo.szStatus_flag, CASH_GBN[i].Code);
			}
			Str_Cpy( stCashinfo.szCust_info, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_CUSTINFO )) );
			
			
			Str_Cpy( stCashinfo.szWork_gubun, "7100");
			Str_Cpy( stCashinfo.szAppro_sts, "1");
			
			Str_ItoA( Time_GetDate(), sztmp, 10 );
			Str_Cpy(stCashinfo.szApproymd, sztmp+2);
			
			fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda1, 1, Str_Len(stUserinfo.szpda_ip) );
			fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda2, 2, Str_Len(stUserinfo.szpda_ip) );
			fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda3, 3, Str_Len(stUserinfo.szpda_ip) );
		}
		else
		{
			if(MessageBoxEx (CONFIRM_YESNO, "���ݿ������� ��� �Ͻðڽ��ϱ�?") != MB_OK)
				return;

			Str_Cpy( stCashinfo.szAppronum, stMw.szAppro_num );		
			Str_Cpy( stCashinfo.szWork_gubun, "7602");
			Str_Cpy( stCashinfo.szAppro_sts, "2");			
		}
				
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66802, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd"         , stUserinfo.szcenter_cd          );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq", stCashinfo.szPromise_assign_seq );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num"      , stCashinfo.szUse_cont_num       );
		JSON_SetValue( g_pjcomm, 'C', "work_gubun"        , stCashinfo.szWork_gubun );
		JSON_SetValue( g_pjcomm, 'C', "appro_sts"         , stCashinfo.szAppro_sts  );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda1"        , stCashinfo.szTreat_pda1 );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda2"        , stCashinfo.szTreat_pda2 );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda3"        , stCashinfo.szTreat_pda3 );
		JSON_SetValue( g_pjcomm, 'C', "status_flag"       , stCashinfo.szStatus_flag);
		JSON_SetValue( g_pjcomm, 'C', "cust_info"         , stCashinfo.szCust_info  );
		JSON_SetValue( g_pjcomm, 'C', "amt"               , stCashinfo.szAmt        );
		JSON_SetValue( g_pjcomm, 'C', "vat"               , stCashinfo.szVat        );
	
		//�׽�Ʈ�� �ܸ����ȣ
		//JSON_SetValue( g_pjcomm, 'C', "cert_cd"           , "1002189855"    );
		JSON_SetValue( g_pjcomm, 'C', "cert_cd"           , stUserinfo.szcert_cd    );
		
		JSON_SetValue( g_pjcomm, 'C', "approymd"          , stCashinfo.szApproymd   );
		JSON_SetValue( g_pjcomm, 'C', "appronum"          , stCashinfo.szAppronum   );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_Cash; //��ſϷ� �Ŀ� ȣ�� �Լ�
		
		ret = HTTP_DownloadData(szUrl, "FR66802_IN",  "FR66802" , sndbuf, szbuf );
	}
	
	//------------------------------------------------------------------
	long Rcv_Cash(void)
	{
		char szTmp[100];
		
		g_Sock_Close();
		
		if( Chk_Json_66802() >= 0)
		{
			if( Str_Len( stMw.szAppro_num) > 0 )
			{
				Mem_Set( (byte*)stMw.szAppro_num, 0x00, sizeof(stMw.szAppro_num) );
				Mem_Set( (byte*)stMw.szAppro_tel, 0x00, sizeof(stMw.szAppro_tel) );
				Mem_Set( (byte*)stMw.szAppro_gubun, 0x00, sizeof(stMw.szAppro_gubun) );
				Mem_Set( (byte*)stMw.szAppro_status_flag, 0x00, sizeof(stMw.szAppro_status_flag) );
			}
			else
			{
				Mem_Set( (byte*)stMw.szAppro_num, 0x00, sizeof(stMw.szAppro_num) );
				Mem_Set( (byte*)stMw.szAppro_tel, 0x00, sizeof(stMw.szAppro_tel) );
				Mem_Set( (byte*)stMw.szAppro_gubun, 0x00, sizeof(stMw.szAppro_gubun) );
				Mem_Set( (byte*)stMw.szAppro_status_flag, 0x00, sizeof(stMw.szAppro_status_flag) );
				
				Str_Cpy( stMw.szAppro_num, stCashinfo.szAppronum);
				Str_Cpy( stMw.szAppro_tel, stCashinfo.szCust_info );
				
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_ItoA( m_lradgbn_flag, szTmp, 10 );
				Str_Cpy( stMw.szAppro_gubun, szTmp );
				
				Str_Cpy( stMw.szAppro_status_flag, stCashinfo.szStatus_flag );
				
			}
			
			MessageBoxEx (CONFIRM_OK, "ó���� �Ϸ� �Ǿ����ϴ�.");
			
			ON_EXIT();
			OnInit(INIT_MAIN);
			return 1;
		}
		else
		{
			MessageBoxEx (ERROR_OK, "���� �������.");
			ON_DRAW();
			return -1;
		}
	}
	
	//----------------------------------------------------------------------------------
	// ��  �� : ���� ��� ������ �����Ѵ�.
	// ��  �� : 
	// ���ϰ� : 1:�������� ��ſϷ�, 0: ��������or�������Ŀ���, -1: �˼����� ����
	//----------------------------------------------------------------------------------
	long Chk_Json_66802(void)
	{
	char szJsonpath[500];
	char szMsg[500];
	long fd, i;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szappronum;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
		
		MessageBox(MESSAGE, "�ڷ� Ȯ���� �Դϴ�.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 66802, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 66802, 0 );
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
				EvtDraw();
				ret = -1;
			}
			else
			{
				szappronum = JSON_GetValue (g_pjcomm, "appro_num", szType);
				Str_Cpy(stCashinfo.szAppronum, szappronum);
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
		
		CloseMessageBox();
		ON_DRAW();
		return ret;
	}
	
	//------------------------------------------------------------------
	void fsgetitem(char* szSource, char* szTarget, int id, int len )
	{
	int i;
	int idx;
	int ids;
	
		idx =0;
		ids =1;
		for(i=0; i<len; i++)
		{
			if(szSource[i] == '-')
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
	bool Validate(void)
	{
	long i, idx;
	char sztmp[100];
	char sztmp2[100];
	char szbuf[100];
	char szSql[300];
	long ret = -100;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	long gasnonpay = 0;
	long gasacconut = 0;
	long nCardAmt = 0;
	long nCashAmt = 0;
	long nAdjAmt = 0;
	long nAmt = 0;
	char szCardAmt[20];
	char szCashAmt[20];
	char szCardChk[20];
	char * sqlstr1 = "";
	char * sqlstr2 = "";
	bool bret = FALSE;
	long cardtot = 0;
	long cardApproved = 0;
	long lCnt = 0;
	long mtrCnt , nonPayCnt ;
	char chk_card = 0;
	char szReqYm[10];
	long szUnpayAmt , szNonpayAmt;
	char szAmt[300];
	handle* sql1 = NULL;
	handle* sql2 = NULL;
	
	
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			bret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		hstmt = sql->CreateStatement(sql, " SELECT INDI_VC, REVIS_FLAG, INDI_VA, INDI_VM, PROD_CD, PROD_CHG  FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = ?  " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			bret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			bret = FALSE;
			goto Finally;
		}		
		
		while(sql->Next(sql) == TRUE)
		{

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 5, 'U', (long*)sztmp, 2, DECRYPT);
			Str_Cpy( stMw.szProd_chg, sztmp);
			PRINT("first stMw.szProd_chg : %s",stMw.szProd_chg,0,0);

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 0, 'U', (long*)sztmp, 10, DECRYPT);
			if( Str_Len(sztmp) == 0)
			{
				ret = -1;
				goto Finally;
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 1, 'U', (long*)sztmp, 3, DECRYPT);
			
			if( Str_Cmp( sztmp, "10") != 0 )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 10, DECRYPT);
				if( Str_Len(sztmp) == 0)
				{
					ret = -2;
					goto Finally;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
				if( Str_Len(sztmp) == 0)
				{
					ret = -3;
					goto Finally;
				}
			}
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, 4, 'U', (long*)sztmp, 5, DECRYPT);
			if( Str_Len(sztmp) == 0)
			{
				ret = -4;
				goto Finally;
			}
		};
		ret = 0;
Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		//����Ȯ�����üũ
		
//PRINT("szcenter_cd=[%s], szTrans_conn_yn=[%s], szConn_yn=[%s] ",stUserinfo.szcenter_cd,stMw.szTrans_conn_yn,stMw.szConn_yn);	
		
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		if( g_nWorkFlag == 610 )
		{
			//610:����[��, ���ұ�, ��ǰ, ��ȸ��, ��� ]
			if( ret == -1 )
			{
				SPRINT(sztmp, "������ħ VC�� �Է��ϼ���!", 0, 0, 0);
			}
			else if( ret == -2 )
			{
				SPRINT(sztmp, "������ħ VA�� �Է��ϼ���!", 0, 0, 0);
			}
			else if( ret == -3 )
			{
				SPRINT(sztmp, "������ħ VM�� �Է��ϼ���!", 0, 0, 0);
			}
			else if( ret == -4 )
			{
				SPRINT(sztmp, "��ǰ �ڵ带 �����ϼ���!", 0, 0, 0);
			}
			
			if( ret < 0 )
			{
				MessageBoxEx (ERROR_OK, sztmp);
				Card_Move("C6101_WMTR");
				return FALSE;
			}
			
			//���Թ��ڵ�üũ
			if( stUserinfo.szcenter_cd[0] != '4')
			{
				if( Str_Cmp(stMw.szCivil_serv_class_cd, "060103") == 0)
				{
					if(Str_Len(stMw.szTrans_conn_yn) == 0 )
					{
						MessageBoxEx (ERROR_OK, "���Կ��Ῡ�θ� �Է��ϼ���.");
						Card_Move("C6101_WBUR");
						return FALSE;
					}
					else if(stMw.szTrans_conn_yn[0] == 'Y' && Str_Len(stMw.szChk_yn) == 0 )
					{
						MessageBoxEx (ERROR_OK, "���˿��θ� �Է��ϼ���.");
						Card_Move("C6101_WBUR");
						return FALSE;
					}
				}
				else
				{
					if( Str_Len(stMw.szTrans_conn_yn) == 0 )
					{
						MessageBoxEx (ERROR_OK, "���Կ��Ῡ�θ� �Է��ϼ���.");
						Card_Move("C6101_WBUR");
						return FALSE;
					}
					else if(stMw.szTrans_conn_yn[0] == 'Y' && Str_Len(stMw.szConn_yn) == 0 )
					{
						MessageBoxEx (ERROR_OK, "����ð����θ� �Է��ϼ���.");
						Card_Move("C6101_WBUR");
						return FALSE;
					}
					else if(stMw.szTrans_conn_yn[0] == 'Y' && Str_Len(stMw.szBar_why) == 0 && ( Str_Len(stMw.szBar_yn) == 0 || stMw.szBar_yn[0] =='N' ) )
					{
						MessageBoxEx (ERROR_OK, "���ڵ� �����ϼ���.");//����üũ
						Card_Move("C6101_WBUR");
						return FALSE;
					}
				}
			}
			else
			{
				if(Str_Len(stMw.szConn_yn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "����ο��� �Է��ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szConn_yn[0] == 'Y' && Str_Len(stMw.szConn_gbn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "����/��ü���θ� �����ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szConn_yn[0] == 'Y' && Str_Len(stMw.szBar_why) == 0 && ( Str_Len(stMw.szBar_yn) == 0 || stMw.szBar_yn[0] =='N' ) )
				{
					MessageBoxEx (ERROR_OK, "���ڵ� �����ϼ���.");//����üũ
					Card_Move("C6101_WBUR");
					return FALSE;
				}
			}
			
			//������ �ڵ��� üũ
			
			if( ( Str_Len(stMw.szCp_ddd) == 0 || Str_Len(stMw.szCp_exn) == 0 || Str_Len(stMw.szCp_num) == 0 ) &&
			    ( Str_Len(stMw.szOwnhouse_tel_ddd) == 0 || Str_Len(stMw.szOwnhouse_tel_exn) == 0 || Str_Len(stMw.szOwnhouse_tel_num) == 0 )  )
			{
				MessageBoxEx (ERROR_OK, "�ڵ��� �� ���������� �Է��ϼ���!");
				Card_Move("C6101_WCUST");
				return FALSE;
			}		
	
			
		}
		else if( g_nWorkFlag == 620 )
		{
			
			//620:����[��, ���ұ�, ����,  ��ȸ��, ��� ]
			//��ȸ�� �Է�üũ(�Է���ü�� ����. ����üũ)
			
			//���ڵ�����
			//if( Str_Len(stMw.szBar_why) == 0 && Str_Len(stMw.szBar_yn) == 0 )
			if( (Str_Len(stMw.szBar_why) == 0 && Str_Len(stMw.szBar_yn) == 0) ||
				(Str_Len(stMw.szBar_why) == 0 && Str_Cmp(stMw.szBar_yn, "N") == 0) )
			{
				MessageBoxEx (ERROR_OK, "���ڵ� �����ϼ���.");//����üũ
				Card_Move("C6101_WBUR");
				return FALSE;
			}
			
			if( ret == -1 )
			{
				SPRINT(sztmp, "������ħ VC�� �Է��ϼ���!", 0, 0, 0);
			}
			else if( ret == -2 )
			{
				SPRINT(sztmp, "������ħ VA�� �Է��ϼ���!", 0, 0, 0);
			}
			else if( ret == -3 )
			{
				SPRINT(sztmp, "������ħ VM�� �Է��ϼ���!", 0, 0, 0);
			}
			
			if( ret < 0 && ret != -4 )
			{
				MessageBoxEx (ERROR_OK, sztmp);
				Card_Move("C6101_WMTR");
				return FALSE;
			}
			
			if( g_lPAYFlag == 0)
			{
				MessageBoxEx (ERROR_OK, "�߰������� �ϼ���.");
				Card_Move("C6101_WMTR");
				return FALSE;
			}
			
			ret = 0;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(ONCE_QTY) FROM C6101_ONCE_INFO WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( szSql, &ret );
			
			if( ret == 0 )
			{
				MessageBoxEx (ERROR_OK, "��ȸ�� �׸��� �����ϼ���.");
				Card_Move("C6101_WONE");
				return FALSE;
				
			}
			else if( ret > 1  )
			{
				MessageBoxEx (ERROR_OK, "��ȸ�� �Ϲ��ڵ�� �����ڵ�� �ߺ� ���þȵ˴ϴ�. �ٽ� ����ϼ���.");
				Card_Move("C6101_WONE");
				return FALSE;
			}
		}
		else if( g_nWorkFlag == 630 )
		{
			//630:����[��, ����, ����, ��ȸ��, ��� ]
			if( ret == -1 )
			{
				SPRINT(sztmp, "������ħ VC�� �Է��ϼ���!", 0, 0, 0);
			}
			else if( ret == -2 )
			{
				SPRINT(sztmp, "������ħ VA�� �Է��ϼ���!", 0, 0, 0);
			}
			else if( ret == -3 )
			{
				SPRINT(sztmp, "������ħ VM�� �Է��ϼ���!", 0, 0, 0);
			}
			
			if( ret < 0 && ret != -4 )
			{
				MessageBoxEx (ERROR_OK, sztmp);
				Card_Move("C6101_WMTR");
				return FALSE;
			}
			
			//��ħ�Է�üũ
			if( g_lPAYFlag == 0)
			{
				MessageBoxEx (ERROR_OK, "�߰������� �ϼ���.");
				//Card_Move("C6101_WMTR");
				return FALSE;
			}
			
			if( g_nStopReleFlag == 0)
			{
				MessageBoxEx (ERROR_OK, "��������� �ϼ���.");
				//Card_Move("C6101_WSTOP");
				return FALSE;
			}
		}
		else if( g_nWorkFlag == 640 )
		{
			//640:����[��, ����, ��ȸ��, ��� ]
			if( g_nStopReleFlag == 0)
			{
				MessageBoxEx (ERROR_OK, "���� ����� ���ּ���.");
				//Card_Move("C6101_WRELE");
				return FALSE;
			}
		}
		else if( g_nWorkFlag == 650 )
		{	
			//650:��ü[��, ���ұ�, ��ȸ��, ��� ]
			if (Str_Cmp( stMw.szCivil_serv_class_cd, "070302" ) != 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0)
			{
				if (Str_Cmp( stMw.szProd_chg, "Y" ) == 0)
				{
					if( ret == -1 )
					{	
						SPRINT(sztmp, "��ħ VC�� �Է��ϼ���!", 0, 0, 0);
					}
					// else if( ret == -2 )
					// {
					// 	SPRINT(sztmp, "������ħ VA�� �Է��ϼ���!", 0, 0, 0);
					// }
					// else if( ret == -3 )
					// {
					// 	SPRINT(sztmp, "������ħ VM�� �Է��ϼ���!", 0, 0, 0);
					// }
				}else{
					ret = 0;
				}

				if( ret < 0 )
				{
					MessageBoxEx (ERROR_OK, sztmp);
					Card_Move("C6101_WMTR");
					return FALSE;
				}
				
			}

			
			if( stUserinfo.szcenter_cd[0] != '4')
			{
				if(Str_Len(stMw.szTrans_conn_yn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "���Կ��Ῡ�θ� �Է��ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szTrans_conn_yn[0] == 'Y' && Str_Len(stMw.szConn_yn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "����ð����θ� �Է��ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szTrans_conn_yn[0] == 'Y' && Str_Len(stMw.szBar_why) == 0 && ( Str_Len(stMw.szBar_yn) == 0 || stMw.szBar_yn[0] =='N' ) )
				{
					MessageBoxEx (ERROR_OK, "���ڵ� �����ϼ���.");//����üũ
					Card_Move("C6101_WBUR");
					return FALSE;
				}
			}
			else
			{
				if(Str_Len(stMw.szConn_yn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "����ο��� �Է��ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szConn_yn[0] == 'Y' && Str_Len(stMw.szConn_gbn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "����/��ü���θ� �����ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szConn_yn[0] == 'Y' && Str_Len(stMw.szBar_why) == 0 && ( Str_Len(stMw.szBar_yn) == 0 || stMw.szBar_yn[0] =='N' ) )
				{
					MessageBoxEx (ERROR_OK, "���ڵ� �����ϼ���.");//����üũ
					Card_Move("C6101_WBUR");
					return FALSE;
				}
			}
		}
		else if( g_nWorkFlag == 660 )
		{
			//660:����[��, ���ұ�, ����(�跮�ⱳü), ��ȸ��, ��� ]
			
			if (Str_Cmp( stMw.szCivil_serv_class_cd, "070202" ) == 0 && Str_Cmp (stMw.szCont_sts_cd, "10") == 0 ){
				if (Str_Cmp( stMw.szProd_chg, "Y" ) == 0)
				{
					if( ret == -1 )
					{	
						SPRINT(sztmp, "������ħ VC�� �Է��ϼ���!", 0, 0, 0);
					}
				}else{
					ret = 0;
				}

				if( ret < 0 )
				{
					MessageBoxEx (ERROR_OK, sztmp);
					Card_Move("C6101_WMTR");
					return FALSE;
				}

			}



			if( stUserinfo.szcenter_cd[0] != '4')
			{
				if(Str_Len(stMw.szTrans_conn_yn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "���Կ��Ῡ�θ� �Է��ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szTrans_conn_yn[0] == 'Y' && Str_Len(stMw.szConn_yn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "����ð����θ� �Է��ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szTrans_conn_yn[0] == 'Y' && Str_Len(stMw.szBar_why) == 0 && ( Str_Len(stMw.szBar_yn) == 0 || stMw.szBar_yn[0] =='N' ) )
				{
					MessageBoxEx (ERROR_OK, "���ڵ� �����ϼ���.");//����üũ
					Card_Move("C6101_WBUR");
					return FALSE;
				}
			}
			else
			{
				if(Str_Len(stMw.szConn_yn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "����ο��� �Է��ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szConn_yn[0] == 'Y' && Str_Len(stMw.szConn_gbn) == 0 )
				{
					MessageBoxEx (ERROR_OK, "����/��ü���θ� �����ϼ���.");
					Card_Move("C6101_WBUR");
					return FALSE;
				}
				else if(stMw.szConn_yn[0] == 'Y' && Str_Len(stMw.szBar_why) == 0 && ( Str_Len(stMw.szBar_yn) == 0 || stMw.szBar_yn[0] =='N' ) )
				{
					MessageBoxEx (ERROR_OK, "���ڵ� �����ϼ���.");//����üũ
					Card_Move("C6101_WBUR");
					return FALSE;
				}
			}
			
			// ���������� ��� �޺��ڽ� validation üũ �ʿ�
			if( Str_Cmp( stMw.szCivil_serv_class_cd, "070204" ) == 0  )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " SELECT COUNT(1) FROM C6101_PROMISE_CHK WHERE PROMISE_ASSIGN_SEQ = '%s' ", stMw.szPromise_assign_seq, 0, 0);
				g_Sql_RetInt(szSql, &lCnt);
				
				if( lCnt <= 0 )
				{
					MessageBoxEx (ERROR_OK, "���������� �����ϼ���.");
					Card_Move("C6101_WCHK");
					return FALSE;
				}
				
				// 1.1. �����ġ ��ĭ
				if( Str_Cmp(stChk.szAcc_take_act, "") == 0 )
				{
					MessageBoxEx (ERROR_OK, "�����ġ�� �����ϼ���.");
					Card_Move("C6101_WCHK");
					return FALSE;
				}
				// 1.2. �����ġ ��ĭ �ƴ�
				else
				{
					// 2.1. �����ġ �̻������ �ƴѰ�� �������� �����ؾ���
					if( Str_Cmp(stChk.szAcc_take_act, "50") != 0 )
					{
						// 3.1. �������� �� ���
						if( Str_Cmp( stChk.szAcc_cause, "") == 0 )
						{
							MessageBoxEx (ERROR_OK, "�������� �����ϼ���.");
							Card_Move("C6101_WCHK");
							return FALSE;
						}
						// 3.2. �������� ������ ���
						else
						{
							// 4.1. �������� ��Ÿ�� ���
							if( Str_Cmp( stChk.szAcc_cause, "70") == 0 )
							{
								if( Str_Cmp( stChk.szAcc_cause_rmk, "") == 0 )
								{
									MessageBoxEx (ERROR_OK, "���α�Ÿ�� �ۼ����ּ���.");
									Card_Move("C6101_WCHK");
									return FALSE;
								}
							}
							
							// 4.2. �����ġ1�� ��ĭ�� ���
							if( Str_Cmp( stChk.szAcc_loc1, "") == 0 )
							{
								MessageBoxEx (ERROR_OK, "�����ġ1�� �����ϼ���.");
								Card_Move("C6101_WCHK");
								return FALSE;
							}
							// 4.3. �����ġ1�� �ִ� ���
							else
							{
								//5.1. �����ġ1�� ��Ÿ�� ���
								if( Str_Cmp( stChk.szAcc_loc1, "90") == 0 )
								{
									if( Str_Cmp( stChk.szAcc_loc_rmk, "") == 0 )
									{
										MessageBoxEx (ERROR_OK, "��ġ��Ÿ�� �ۼ����ּ���.");
										Card_Move("C6101_WCHK");
										return FALSE;
									}
								}
								//5.2. �����ġ1�� ��Ÿ�� �ƴѰ��
								else
								{
									// 6.1. �����ġ1�� ���ұ��� ���
									if( Str_Cmp( stChk.szAcc_loc1, "30") == 0 || Str_Cmp( stChk.szAcc_loc1, "40") == 0)
									{
										// 7.1. �����ġ2�� ��Ÿ�� ���
										if( Str_Cmp( stChk.szAcc_loc2, "40") == 0 )
										{	
											if( Str_Cmp( stChk.szAcc_loc_rmk, "") == 0 )
											{
												MessageBoxEx (ERROR_OK, "��ġ��Ÿ�� �ۼ����ּ���.");
												Card_Move("C6101_WCHK");
												return FALSE;
											}
										}
										// 7.1. �����ġ2�� ��Ÿ�� �ƴ� ���
										else
										{
											if( Str_Cmp( stChk.szAcc_loc2, "") == 0 )
											{
												MessageBoxEx (ERROR_OK, "�����ġ2�� �����ϼ���.");
												Card_Move("C6101_WCHK");
												return FALSE;
											}
										}
										
									}
									// 6.2. �����ġ1�� ���Ϸ��� ���
									else if( Str_Cmp( stChk.szAcc_loc1, "50") == 0 )
									{
										// 7.2. �����ġ2�� ��Ÿ�� ���
										if( Str_Cmp( stChk.szAcc_loc2, "40") == 0 )
										{	
											if( Str_Cmp( stChk.szAcc_loc_rmk, "") == 0 )
											{
												MessageBoxEx (ERROR_OK, "��ġ��Ÿ�� �ۼ����ּ���.");
												Card_Move("C6101_WCHK");
												return FALSE;
											}	
										}
										// 7.1. �����ġ2�� ��Ÿ�� �ƴ� ���
										else
										{
											if( Str_Cmp( stChk.szAcc_loc2, "") == 0 )
											{
												MessageBoxEx (ERROR_OK, "�����ġ2�� �����ϼ���.");
												Card_Move("C6101_WCHK");
												return FALSE;
											}
										}
									}
									// 6.3. �����ġ1�� �跮���� ���
									else if( Str_Cmp( stChk.szAcc_loc1, "20") == 0 || Str_Cmp( stChk.szAcc_loc1, "70") == 0 )
									{
										// 7.3. �����ġ2�� ��Ÿ�� ���
										if( Str_Cmp( stChk.szAcc_loc2, "30") == 0 )
										{	
											if( Str_Cmp( stChk.szAcc_loc_rmk, "") == 0 )
											{
												MessageBoxEx (ERROR_OK, "��ġ��Ÿ�� �ۼ����ּ���.");
												Card_Move("C6101_WCHK");
												return FALSE;
											}	
										}
										// 7.1. �����ġ2�� ��Ÿ�� �ƴ� ���
										else
										{
											if( Str_Cmp( stChk.szAcc_loc2, "") == 0 )
											{
												MessageBoxEx (ERROR_OK, "�����ġ2�� �����ϼ���.");
												Card_Move("C6101_WCHK");
												return FALSE;
											}
										}
									}
								}
							}
						}
					}
					// 2.2. �����ġ �̻������ ���
					else
					{
					 	// 2.2.1. ������, ������ ��Ÿ, �����ġ1, �����ġ2, �����ġ��Ÿ�� ��ĭ�̿�����
						if( Str_Cmp(stChk.szAcc_cause, "") != 0 || Str_Cmp(stChk.szAcc_cause_rmk, "") != 0 || Str_Cmp(stChk.szAcc_loc1, "") != 0
						 || Str_Cmp(stChk.szAcc_loc2, "") != 0 || Str_Cmp(stChk.szAcc_loc_rmk, "") != 0 )
						{
							MessageBoxEx (ERROR_OK, "������ �ٽ����ּ���.");
							Card_Move("C6101_WCHK");
							return FALSE;
						}
					}
				}
			}
		}
		
		nCardAmt = 0;
		nCashAmt = 0;
		gasnonpay = 0;
		//�ο��ڷ� �Է��ڷ� ������Ʈ
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN='0' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &gasnonpay );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '0' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &gasacconut );
		
		//������ �̳������ �߻� ����Ȯ�༭ �߻� �ʼ�
		if( g_nWorkFlag == 620 && g_lNpChkFlag == 0)
		{
			if( (gasnonpay +gasacconut) > 0 )
			{
				MessageBoxEx (ERROR_OK, "�����ݾ��� ������ ���� ����Ȯ�༭�� ����ؾ� �մϴ�.");//
				return FALSE;
			}
		}

		//0705
		if(g_nWorkFlag == 620 || g_nWorkFlag == 630 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szCardChk, 0x00, sizeof(szCardChk) );
			SPRINT(szSql, "SELECT CASE WHEN CARD_YN != '1' THEN 'N' ELSE 'Y' END as CARD_CHK FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND REQ_MANAGE_STS ='���' AND CHK = '1' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr( szSql, 9 , szCardChk );			
			// Str_ItoA(chk_card,szCardChk,10);			
			// PRINT("szCardChk :%s",szCardChk,0,0);
			if( Str_Cmp(szCardChk, "N") == 0 )
			{
				
				MessageBoxEx (ERROR_OK, "����� ī�� ������ �����ϼž� �մϴ�.");//
				return FALSE;	
			}
		}

		if(g_nWorkFlag == 620 || g_nWorkFlag == 630)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szCardChk, 0x00, sizeof(szCardChk) );
			SPRINT(szSql, "SELECT CASE WHEN CARD_YN != '1' THEN 'N' ELSE 'Y' END as CARD_CHK FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND REQ_YM ='20' AND CHK = '1' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr( szSql, 9 , szCardChk );			
			// Str_ItoA(chk_card,szCardChk,10);			
			// PRINT("szCardChk :%s",szCardChk,0,0);
			if( Str_Cmp(szCardChk, "N") == 0 )
			{
				
				MessageBoxEx (ERROR_OK, "��������� ī�� ������ �����ϼž� �մϴ�.");//
				return FALSE;	
			}
		}
		// //ī�� ����� 
		// gasacconut = 0;
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN= '1' AND CARD_YN = '1' ", g_szCHK_EXEC_NUM, 0, 0   );
		// g_Sql_RetInt( szSql, &gasacconut );
		
		// // ī�� û����� �̳��ݾ�
		// gasnonpay = 0;
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '1' AND CARD_YN = '1' ", g_szCHK_EXEC_NUM, 0, 0   );
		// g_Sql_RetInt( szSql, &gasnonpay );
		// Str_ItoA( (gasacconut+ gasnonpay), stMw.szCard_gaspay, 10);//������� ī������ݾ�
		// nCardAmt = gasacconut+ gasnonpay;
		
		// gasacconut = 0;
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN= '1'  ", g_szCHK_EXEC_NUM, 0, 0   );
		// g_Sql_RetInt( szSql, &gasacconut );
		
		// gasnonpay = 0;
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '1'  ", g_szCHK_EXEC_NUM, 0, 0   );
		// g_Sql_RetInt( szSql, &gasnonpay );
		
		// if( Str_AtoI(stMw.szCard_gaspay) > 0 && Str_AtoI(stMw.szCard_gaspay) > (  gasacconut+ gasnonpay- Str_AtoI(stMw.szAdj_alt_amt) ) )
		// {
		// 	MessageBoxEx (ERROR_OK, "ī�� ���� ������ �߸��Ǿ����ϴ�.");//
		// 	return FALSE;
		// }

		//���� �����
		gasacconut = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN= '1' AND ( CARD_YN <> '1' OR CARD_YN IS NULL) ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &gasacconut );
		//���� û����� �̳��ݾ�
		gasnonpay = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '1' AND ( CARD_YN <> '1' OR CARD_YN IS NULL)  ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &gasnonpay );
		Str_ItoA( (gasacconut+gasnonpay-Str_AtoI(stMw.szAdj_alt_amt) ), stMw.szCash_gaspay , 10);//������� ���ݼ����ݾ�
		nCashAmt = gasacconut+gasnonpay-Str_AtoI(stMw.szAdj_alt_amt);

		if(nCashAmt < 0)
		{
			nCashAmt = 0;
			Str_ItoA( nCashAmt, stMw.szCash_gaspay , 10);//������� ���ݼ����ݾ�
		}

		if ((gasacconut + gasnonpay) < Str_AtoI(stMw.szAdj_alt_amt))
		{
			nAdjAmt = Str_AtoI(stMw.szAdj_alt_amt) - (gasacconut + gasnonpay);
		}
		else
		{
			nAdjAmt = 0 ;
		}

		//ī�� ����� 
		gasacconut = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN= '1' AND CARD_YN = '1' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &gasacconut );
		
		// ī�� û����� �̳��ݾ�
		gasnonpay = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '1' AND CARD_YN = '1' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &gasnonpay );
		// Str_ItoA( (gasacconut+gasnonpay-Str_AtoI(stMw.szAdj_alt_amt) ), stMw.szCash_gaspay , 10)
		
		//���ݿ��� �����ߴµ��� ������ �ݾ��� ������ nCardAmt���� �������� ����.
		//�����ϸ鼭 C6101_PROMISE_MTR�� ADJ_AMT_YN �� ���� Y�� �������ֱ�
		Str_ItoA( (gasacconut+ gasnonpay-nAdjAmt), stMw.szCard_gaspay, 10);//������� ī������ݾ�
		nCardAmt = gasacconut+ gasnonpay-nAdjAmt;

		//���� �ݾ׿��� �������� �����ص� 0���� �ɶ����� WHILE ��. C6101_NONPAY �� MTR �� Ư�� FLAG���� �־ ó���ȰŴ� �� �ȵ��� �ؾ���.
		if( m_lDfrrd_flag == 1 ){
			while( 1 )
			{
				nonPayCnt = 0;
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK ='1' AND CARD_LIST_YN = '1' AND UNPAY_AMT > 0 AND IFNULL(AMT_CHK_YN,'N') <> 'Y'",g_szCHK_EXEC_NUM, 0, 0 );
				g_Sql_RetInt(szSql, &nonPayCnt );

				mtrCnt = 0;
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN ='1' AND CARD_LIST_YN = '1' AND ACCOUNT > 0 AND IFNULL(AMT_CHK_YN,'N') <> 'Y'",g_szCHK_EXEC_NUM, 0, 0 );
				g_Sql_RetInt(szSql, &mtrCnt );

				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				SPRINT(szSql, "SELECT MIN(REQ_YM) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK = '1' AND CARD_LIST_YN = '1' AND UNPAY_AMT > 0 AND IFNULL(AMT_CHK_YN,'N') <> 'Y'", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetStr( szSql, 10, szReqYm );

				szUnpayAmt = 0 ;
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				SPRINT(szSql, "SELECT UNPAY_AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK = '1' AND CARD_LIST_YN = '1' AND UNPAY_AMT > 0 AND REQ_YM = '%s' AND IFNULL(AMT_CHK_YN,'N') <> 'Y'", g_szCHK_EXEC_NUM, szReqYm, 0);
				g_Sql_RetInt( szSql, &szUnpayAmt );

				szNonpayAmt = 0;
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT( szSql ,"SELECT ACCOUNT FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN ='1' AND CARD_LIST_YN = '1' AND IFNULL(AMT_CHK_YN,'N') <> 'Y'",g_szCHK_EXEC_NUM, 0, 0 );
				g_Sql_RetInt(szSql, &szNonpayAmt );

				// gasacconut = 0;
				// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				// SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '0' ", g_szCHK_EXEC_NUM, 0, 0   );
				// g_Sql_RetInt( szSql, &gasacconut );

				PRINT("szReqYmszReqYmszReqYm : %s",szReqYm,0,0); 
				PRINT("szUnpayAmtszUnpayAmtszUnpayAmt : %d",szUnpayAmt,0,0); 
				PRINT("nAdjAmtnAdjAmtnAdjAmtnAdjAmt : %d",nAdjAmt,0,0); 

				//C6101_NONPAY�� ī�� ���� ���� ������
				if(nonPayCnt > 0 )
				{
					PRINT("����",0,0,0);
					nAmt = szUnpayAmt - nAdjAmt ;		
					//		
					if(nAmt < 0)
					{
						nAdjAmt = nAdjAmt - szUnpayAmt ;
					}
					else
					{
						nAdjAmt = 0;
					}
				}
				//C6101_PROMISE_MTR�� ī�� ���� ������
				else if(mtrCnt > 0)
				{
					PRINT("����111",0,0,0);
					nAmt = szNonpayAmt - nAdjAmt ;
					if(nAmt < 0)
					{
						nAdjAmt = nAdjAmt - szUnpayAmt ;
					}
					else
					{
						nAdjAmt = 0;
					}
				}
				//�������� �����ݾ׿��� ���� �������� �� ���� ������ 
				if(nAmt < 0)
				{
					PRINT("����222",0,0,0);
					nAmt = 0 ;
				}

				PRINT("nAmtnAmtnAmtnAmt : %d",nAmt,0,0);
				Mem_Set( (byte*)szAmt, 0x00, sizeof(szAmt) );
				Str_ItoA( nAmt, szAmt, 10 );

				PRINT("szAmtszAmtszAmt : %s",szAmt,0,0);
				
				//C6101_NONPAY�� UPDATE ó��
				if(nonPayCnt > 0)
				{
					PRINT("111111111111111",0,0,0);
					
					sql1 = STRING_Create(sqlstr1);
					STRING_Empty(sql1);
					STRING_Append(sql1,"UPDATE C6101_NONPAY");
					STRING_Append(sql1,"   SET SUB_UNPAY_AMT = '");
					STRING_Append(sql1, szAmt );
					STRING_Append(sql1,"' ");
					STRING_Append(sql1,", AMT_CHK_YN = 'Y'");
					STRING_Append(sql1," WHERE PROMISE_ASSIGN_SEQ = '");
					STRING_Append(sql1, g_szCHK_EXEC_NUM );
					STRING_Append(sql1,"' ");
					STRING_Append(sql1,"AND REQ_YM = '");
					STRING_Append(sql1, szReqYm );
					STRING_Append(sql1,"' ");
					sqlstr1 = STRING_toString(sql1);
					g_Sql_DirectExecute(sqlstr1);
					STRING_Finalize(sql1);
				}
				else if(mtrCnt > 0)
				{
					PRINT("222222222222",0,0,0);
					sql1 = STRING_Create(sqlstr1);
					STRING_Empty(sql1);
					STRING_Append(sql1,"UPDATE C6101_PROMISE_MTR");
					STRING_Append(sql1,"   SET SUB_ACCOUNT = '");
					STRING_Append(sql1, szAmt );
					STRING_Append(sql1,"' ");
					STRING_Append(sql1,", AMT_CHK_YN = 'Y'");
					STRING_Append(sql1," WHERE PROMISE_ASSIGN_SEQ = '");
					STRING_Append(sql1, g_szCHK_EXEC_NUM );
					STRING_Append(sql1,"' ");
					STRING_Append(sql1,"AND CHK_YN = '1'");
					// STRING_Append(sql1,"'  AND CARD_LIST_YN = ");
					// STRING_Append(sql1,"1" );
					sqlstr1 = STRING_toString(sql1);
					g_Sql_DirectExecute(sqlstr1);
					STRING_Finalize(sql1);
				}
				else if (mtrCnt <= 0 && nonPayCnt <= 0)
				{
					break;
				}
			}
		}
		else if( m_lDfrrd_flag == 0 ){
			
			Str_ItoA( 0, szAmt, 10 );

			sql1 = STRING_Create(sqlstr1);
					STRING_Empty(sql1);
					STRING_Append(sql1,"UPDATE C6101_NONPAY");
					STRING_Append(sql1,"   SET SUB_UNPAY_AMT = '");
					STRING_Append(sql1, szAmt );
					STRING_Append(sql1,"' ");
					STRING_Append(sql1,", AMT_CHK_YN = 'N'");
					STRING_Append(sql1," WHERE PROMISE_ASSIGN_SEQ = '");
					STRING_Append(sql1, g_szCHK_EXEC_NUM );
					STRING_Append(sql1,"' ");
					sqlstr1 = STRING_toString(sql1);
					g_Sql_DirectExecute(sqlstr1);
					STRING_Finalize(sql1);

			sql2 = STRING_Create(sqlstr2);
					STRING_Empty(sql2);
					STRING_Append(sql2,"UPDATE C6101_PROMISE_MTR");
					STRING_Append(sql2,"   SET SUB_ACCOUNT = '");
					STRING_Append(sql2, szAmt );
					STRING_Append(sql2,"' ");
					STRING_Append(sql2,", AMT_CHK_YN = 'N'");
					STRING_Append(sql2," WHERE PROMISE_ASSIGN_SEQ = '");
					STRING_Append(sql2, g_szCHK_EXEC_NUM );
					STRING_Append(sql2,"' ");
					STRING_Append(sql2,"AND CHK_YN = '1'");
					// STRING_Append(sql1,"'  AND CARD_LIST_YN = ");
					// STRING_Append(sql1,"1" );
					sqlstr2 = STRING_toString(sql2);
					g_Sql_DirectExecute(sqlstr2);
					STRING_Finalize(sql2);

		}
		
		// if(nAdjAmt == 0)
		// {
		// 	Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		// 	SPRINT(szSql, "UPDATE C6101_PROMISE_MTR SET ADJ_AMT_YN  = 'Y' WHERE PROMISE_ASSIGN_SEQ = %s ", g_szCHK_EXEC_NUM, 0, 0);		
		// 	g_Sql_DirectExecute(szSql);
		// }
		// else
		// {
		// 	Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		// 	SPRINT(szSql, "UPDATE C6101_PROMISE_MTR SET ADJ_AMT_YN  = 'N' WHERE PROMISE_ASSIGN_SEQ = %s ", g_szCHK_EXEC_NUM, 0, 0);		
		// 	g_Sql_DirectExecute(szSql);
		// }
		
		// Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		// SPRINT(szSql, "UPDATE C6101_PROMISE_MTR SET ADJ_AMT_YN  = 'Y' WHERE PROMISE_ASSIGN_SEQ = %s ", g_szCHK_EXEC_NUM, 0, 0);		
		// g_Sql_DirectExecute(szSql);

		//20240130 ī�� ������ó�� ī�忡 �������� �پ������� ADJ_AMT_YN Y�� �־��ְ� GASCARD.mc ���� Y �ΰ� Ȯ���ϰ� ����ݾ��̶� �����ݾ� �ٲ㼭 �־������.
		//�׸��� Add_nonpay���� ������ ó���Ȱ� ����������ϴµ� , û����� ���� �����Ȱ� �������� ����
		// else
		// {
		// 	Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		// 	SPRINT(szSql, "UPDATE C6101_PROMISE_MTR SET ADJ_AMT_YN  = 'N' WHERE PROMISE_ASSIGN_SEQ = %s ", g_szCHK_EXEC_NUM, 0, 0);		
		// 	g_Sql_DirectExecute(szSql);

		// }

		
		
		
		if( stMw.szCard_onepay[0] == '2' && stMw.szAuto_yn[0] != 'Y' ) // ��ȸ�� ī�� ������
			nCardAmt += Str_AtoI(stMw.szOnce_account);
		else if( stMw.szAuto_yn[0] != 'Y' ) //��ȸ�� ���� ������
			nCashAmt += Str_AtoI(stMw.szOnce_account);
		else
			nCashAmt += 0;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szCardAmt, 0x00, sizeof(szCardAmt) );
		Mem_Set( (byte*)szCashAmt, 0x00, sizeof(szCashAmt) );
		Str_ItoA( nCardAmt,szCardAmt,10  );
		Str_ItoA( nCashAmt,szCashAmt,10 );
		Str_Chg( szCardAmt, STRCHG_INS_COMMA );
		Str_Chg( szCashAmt, STRCHG_INS_COMMA );

// PRINT("stMw.szAdj_alt_amt=%s, stMw.szOnce_account=%s, stMw.szAccount=%s",stMw.szAdj_alt_amt, stMw.szOnce_account, stMw.szAccount);
// PRINT("stMw.szCash_gaspay=%s, stMw.szCard_gaspay=%s,stMw.szCard_onepay=%s ",stMw.szCash_gaspay, stMw.szCard_gaspay, stMw.szCard_onepay);
// PRINT("stMw.szAuto_yn=%s szCardAmt=%d,szCashAmt=%d ",stMw.szAuto_yn, szCardAmt, szCashAmt);


		if( nCardAmt> 0 &&  nCashAmt > 0)
			SPRINT(szSql, "[ �����ݾ� Ȯ��111 ]\nī�� : %s��\n���� : %s��\n�����Ͻðڽ��ϱ�?", szCardAmt, szCashAmt, 0   );
		else if( nCardAmt > 0 )
			SPRINT(szSql, "[ �����ݾ� Ȯ��222 ]\nī�� : %s��\n�����Ͻðڽ��ϱ�?", szCardAmt, 0, 0   );
		else if( nCashAmt > 0 )
			SPRINT(szSql, "[ �����ݾ� Ȯ��333 ]\n���� : %s��\n�����Ͻðڽ��ϱ�?", szCashAmt, 0, 0   );
		else
			SPRINT(szSql, "[ �����ݾ� Ȯ��444 ]\n%s������ ó���Ͻðڽ��ϱ�?", szCashAmt, 0, 0   );

		if( MessageBoxEx (CONFIRM_YESNO, szSql) != MB_OK)
			return FALSE;
		
		bret = TRUE;
		
		if( g_nWorkFlag == 620 )
		{
			stMw.szPrice_yn[0] = '2';//���� ��ȸ�����
		}
		else
		{	
			gasacconut = 0;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(ONCE_QTY) FROM C6101_ONCE_INFO  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( szSql, &gasacconut );
			if( gasacconut > 0 )
				stMw.szPrice_yn[0] = '1';//����� ��ȸ�����
			else
			  stMw.szPrice_yn[0] = '0';//����� ��ȸ�����
		}
	
		if( Str_Len(stMw.szAppro_num) > 0 )
		{
			stMw.szOnce_yn[0] = '1';//2���� ����?
		}
		
		if( Str_Len(stCardinfo.szApproval_num) == 0 )
		{
			Mem_Set( (byte*)&stCardinfo, 0x00, sizeof(stCardinfo) );
		}
		
		//PRINT("stMw.szCard_gaspay:[%s], stMw.szCard_onepay:[%s], cardApproved:[%d]", stMw.szCard_gaspay, stMw.szCard_onepay, cardApproved);
		
		// ī����� �ݾ��� �߻��� ���	
		if(Str_AtoI(stMw.szCard_gaspay) > 0 || stMw.szCard_onepay[0] == '2')
		{			
			cardtot = Str_AtoI(stMw.szCard_gaspay);
			cardtot += Str_AtoI(stMw.szOnce_account);
			cardApproved = Str_AtoI(stCardinfo.szApproval_amt);
			cardApproved += Str_AtoI(stOneCardinfo.szApproval_amt);

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			Str_ItoA( cardtot, szbuf, 10 );
			Str_Cpy( sztmp, szbuf);
			Str_Chg( sztmp, STRCHG_INS_COMMA );
			

			Mem_Set( (byte*)sztmp2, 0x00, sizeof(sztmp2) );
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			Str_ItoA( cardApproved, szbuf, 10 );
			Str_Cpy( sztmp2, szbuf );
			Str_Chg( sztmp2, STRCHG_INS_COMMA );

			// ���� ī�� ���� �̷��� �ִ� ���
			if (cardApproved > 0)
			{
				// ī����� �̷°� ���� ���� �ݾ��� �ٸ����
				if (cardApproved != cardtot)
				{
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "�̹� ���ε� ī�� ���� �ݾװ�\n���� ���ε� ���� �ݾ��� �ٸ��ϴ�.\n�������αݾ� : %s��\n������αݾ� : %s��\n�ٽ� �����Ͻðڽ��ϱ�?", sztmp2, sztmp, 0 );
					if( MessageBoxEx (CONFIRM_YESNO, szSql) == MB_OK )
					{
						// ���� �������� Ŭ����~ (������� �ƴ�)
						Clear_PromiseCard();	
						Clear_PromiseOneCard();					
						
						//Card_Move("C6101_WCARD");
						
						g_lGasCardFlag = 0;
						g_lGasRecevieFlag = 0;
						g_lOneCardFlag = 0;
						g_lOneRecevieFlag = 0;
						Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
						Str_Cpy(g_szGas_ApproRslt,"");
						Mem_Set( (byte*)g_szOne_ApproRslt, 0x00, sizeof(g_szOne_ApproRslt) );
						Str_Cpy(g_szOne_ApproRslt,"");
						
						if( g_nWorkFlag == 620 )
						{
							g_lOneCardPageFlag = 1;
						}
						
						if(Str_AtoI(stMw.szCard_gaspay) > 0)
						{
							Card_Move("C6101_GASCARD");
						}
						else
						{
							Card_Move("C6101_ONECARD");
						}

						return FALSE;
					}
					else 
					{
						// ȭ���̵� ����
						return FALSE;
					}
				}
				// �̹� ���ε� ī������� �ݾ��� ������ ����ȭ������ �ٷ� �̵�.
				else 
				{
					// return TRUE;
					
					g_lGasCardFlag = 0;
					g_lGasRecevieFlag = 0;
					g_lOneCardFlag = 0;
					g_lOneRecevieFlag = 0;
					
					if( Str_AtoI(stCardinfo.szApproval_amt) > 0 && Str_AtoI(stMw.szCard_gaspay) > 0 )
					{
						g_lGasCardFlag = 1;
						Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
						Str_Cpy(g_szGas_ApproRslt,"���οϷ�");	
					}
					
					if(Str_AtoI(stOneCardinfo.szApproval_amt) > 0 && stMw.szCard_onepay[0] == '2')
					{
						g_lOneCardFlag = 1;
						Mem_Set( (byte*)g_szOne_ApproRslt, 0x00, sizeof(g_szOne_ApproRslt) );
						Str_Cpy(g_szOne_ApproRslt,"���οϷ�");	
					}
					
					if( g_nWorkFlag == 620 )
					{
						g_lOneCardPageFlag = 1;
					}
				}
			}
			// ó�� �����ϴ� ���
			else
			{
				//Card_Move("C6101_WCARD");
				
				g_lGasCardFlag = 0;
				g_lGasRecevieFlag = 0;
				g_lOneCardFlag = 0;
				g_lOneRecevieFlag = 0;
				
				Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
				Str_Cpy(g_szGas_ApproRslt,"");
				Mem_Set( (byte*)g_szOne_ApproRslt, 0x00, sizeof(g_szOne_ApproRslt) );
				Str_Cpy(g_szOne_ApproRslt,"");
				
				if( g_nWorkFlag == 620 )
				{
					g_lOneCardPageFlag = 1;
				}
				
				if(Str_AtoI(stMw.szCard_gaspay) > 0)
				{
					Card_Move("C6101_GASCARD");
				}
				else
				{
					Card_Move("C6101_ONECARD");
				}
				
				return FALSE;
			}
		}
		// ������ ������ �ִ� ���
		else
		{
			// ���ݰ��� ������ ��� ī�� ���� �ݾ��� ������ Ŭ����~
			Clear_PromiseCard();
			Clear_PromiseOneCard();
		}
		
		return bret;
	}
	
	void Clear_PromiseCard(void)
	{
		handle* sql = NULL;
		char * sqlstr = "";
		
		PRINT("Clear_PromiseCard start", 0, 0, 0);
		
		/*
		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," UPDATE C6101_PROMISE_CARD SET ");
		STRING_Append(sql," rslt_cd='O', approval_num ='', approval_time ='', card_com = '' ");
		STRING_Append(sql," ,card_type_nm = '',buying_comp = '', buying_comp_nm = '' ");
		STRING_Append(sql," ,UPD_EMPID = '");
		STRING_Append(sql,  stUserinfo.szemployee_id);
		STRING_Append(sql,"',UPD_IP = '");
		STRING_Append(sql,  stUserinfo.szpda_ip);
		STRING_Append(sql,"' WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  stCardinfo.szPromise_assign_seq );
		STRING_Append(sql,"' ");
		sqlstr = STRING_toString(sql);	
		*/
		
		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," DELETE FROM C6101_PROMISE_CARD ");
		STRING_Append(sql,"  WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  stCardinfo.szPromise_assign_seq );
		STRING_Append(sql,"' AND ITEM_FLAG = '10'");
		sqlstr = STRING_toString(sql);
		
		PRINT("Clear_PromiseCard sqlstr:[%s]", sqlstr, 0, 0);
		g_Sql_DirectExecute(sqlstr);
		
		Mem_Set((byte*)stCardinfo.szApproval_num, 0x00, sizeof(stCardinfo.szApproval_num));
		PRINT("Clear_PromiseCard end", 0, 0, 0);
	}
			
	void Clear_PromiseOneCard(void)
	{
		handle* sql = NULL;
		char * sqlstr = "";

		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," DELETE FROM C6101_PROMISE_CARD ");
		STRING_Append(sql,"  WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  stCardinfo.szPromise_assign_seq );
		STRING_Append(sql,"' AND ITEM_FLAG = '20'");
		sqlstr = STRING_toString(sql);

		g_Sql_DirectExecute(sqlstr);
		
		Mem_Set((byte*)stOneCardinfo.szApproval_num, 0x00, sizeof(stOneCardinfo.szApproval_num));
	}
				
	//edit �ѱ�üũ
	long GetUtf8Size(char* str, long chklen)
	{
		long nSize = 0;
		long nLen = 0;
		long i = 0;
		
		nSize = Str_Len(str);
		
		for(i=0 ; i < nSize ; )
		{
			if ( str[i] & 0x80 )	//�ѱ�
				i+=2;			//2����
			else
				i++;
				
			if( i >= chklen )
				break;
		}
		nLen = i;
		return nLen;
	}	
	
	//------------------------------------------------------------------
	long Rcv_Info(long promiseFlag)
	{
		char sztmp[300];
		char szUrl[256];
		char* sndbuf;
		long ret;
		char szSql[300];
		long gasnonpay = 0, gasacconut = 0;
		long except_amt = 0;
		char szExceptAmt[30];
		
		//PRINT("Rcv_Info step 1", 0, 0, 0);
		
		//�ο��ڷ� �Է��ڷ� ������Ʈ
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN='0' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &gasnonpay );
		
		gasacconut = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK= '0' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( szSql, &gasacconut );
		
		except_amt = gasnonpay +gasacconut;
		//������ �̳������ �߻� ����Ȯ�༭ �߻� �ʼ�
		if( (gasnonpay +gasacconut) == 0 )
		{
			MessageBoxEx (ERROR_OK, "������ �̳��ݾ��� �����ϴ�.");//
			return FALSE;
		}
		
		g_Sql_DirectExecute("DELETE FROM RCV_TMP");

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		if (promiseFlag == 0) // �ϳ��� �̹���
		{
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 664021, FALSE);
		}
		else // promiseFlag == 1 : OZ View
		{
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66402, FALSE);
		}

		//PRINT("Rcv_Info step 2", 0, 0, 0);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",              stUserinfo.szcenter_cd );		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",           stMw.szUse_cont_num );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq",     stMw.szPromise_assign_seq );
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stMw.szCust_nm );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm",               sztmp );
		JSON_SetValue( g_pjcomm, 'C', "soc_num",               stMw.szSoc_num );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",                stMw.szCp_ddd );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",                stMw.szCp_exn );
		JSON_SetValue( g_pjcomm, 'C', "cp_num",                stMw.szCp_num );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_ddd",      stMw.szOwnhouse_tel_ddd );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_exn",      stMw.szOwnhouse_tel_exn );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_num",      stMw.szOwnhouse_tel_num );
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stMw.szCurr_addr_union );
		JSON_SetValue( g_pjcomm, 'C', "addr_union",            sztmp );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq",             stMw.szTreat_seq );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num",stMw.szCivil_serv_receive_num );
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stMw.szNew_addr_union );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_union",        sztmp );
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SQL_ConvUcStr( sztmp, stMw.szFirm_nm );		
		JSON_SetValue( g_pjcomm, 'C', "firm_nm",               sztmp );
		JSON_SetValue( g_pjcomm, 'C', "biz_regi_num",          stMw.szBiz_regi_num );
		JSON_SetValue( g_pjcomm, 'C', "zip_seq",               stMw.szZip_seq );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_bld_seq",      stMw.szNew_addr_bld_seq );
		if(Str_Len(stMw.szNew_addr_union) > 5 )
			JSON_SetValue( g_pjcomm, 'C', "addr_type",             "R" );
		else
			JSON_SetValue( g_pjcomm, 'C', "addr_type",             "Z" );
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		//PRINT("Rcv_Info step 3", 0, 0, 0);
			
		//ü�� ����Ȯ�༭ ���Ű� �и���.
		//FR822552 ���ϸ� ������.
		if (promiseFlag == 0) // �ϳ��� �̹���
		{			
		
			//PRINT("Rcv_Info except_amt:[%d]", except_amt, 0, 0);
			
			Mem_Set((byte*)szExceptAmt, 0x00, sizeof(szExceptAmt));
			Str_ItoA(except_amt, szExceptAmt, 10);			
			//PRINT("Rcv_Info szExceptAmt:[%s]", szExceptAmt, 0, 0);
			
			Mem_Set((byte*)&m_stOzData, 0x00, sizeof(m_stOzData));
			Str_Cpy(m_stOzData.PROMISE_TOT_AMT, szExceptAmt);
			//PRINT("Rcv_Info m_stOzData.PROMISE_TOT_AMT:[%s]", m_stOzData.PROMISE_TOT_AMT, 0, 0);			
			
			Str_ItoA(Time_GetDate(), m_stPayPlan[0].PROMISE_PLAN_YMD, 10);
			//PRINT("Rcv_Info m_stPayPlan[0].PROMISE_PLAN_YMD:[%s]", m_stPayPlan[0].PROMISE_PLAN_YMD, 0, 0);			
			
			JSON_SetValue(g_pjcomm, 'C',  "except_amt", szExceptAmt );
			//JSON_SetArrayItem(g_pjcomm, 'C',  "except_amt", m_stOzData.PROMISE_TOT_AMT );
			
			//PRINT("Rcv_Info step 4", 0, 0, 0);
			sndbuf = JSON_toString(g_pjcomm);
			
			//PRINT("Rcv_Info step 5", 0, 0, 0);
			callBackfunc = TR664021; //��ſϷ� �Ŀ� ȣ�� �Լ�
			ret = HTTP_DownloadData(szUrl, "FR664021_IN",  "FR664021" , sndbuf, sztmp );
			//PRINT("Rcv_Info step 6", 0, 0, 0);
		}
		else // promiseFlag == 1 : OZ View
		{			
			sndbuf = JSON_toString(g_pjcomm);
			//PRINT("Rcv_Info step 4-1", 0, 0, 0);
			
			callBackfunc = TR66402; //��ſϷ� �Ŀ� ȣ�� �Լ�
			ret = HTTP_DownloadData(szUrl, "FR66402_IN",  "FR66402" , sndbuf, sztmp );
			//PRINT("Rcv_Info step 4-2", 0, 0, 0);
		}
		return 0 ;
	}
	
	//------------------------------------------------------------------
	long TR66402(void)	
	{
		g_Sock_Close();
		
		if( g_Chk_Json(66402) > 0)
		{	
			//������
			SetInfo();
			//�����ݾ� ����
			OzView();
			
			ON_DRAW();
			return 1;	
		}
		else
		{
			MessageBoxEx (ERROR_OK, "��ȸ�� �ڷᰡ �����ϴ�.");
			ON_DRAW();
			return -1;
		}
	}

	//------------------------------------------------------------------
	long TR664021(void)	
	{
			//PRINT("TR664021 step 1", 0, 0, 0);
		g_Sock_Close();
		
			//PRINT("TR664021 step 2", 0, 0, 0);
		if( g_Chk_Json(664021) >= 0)
		{	
			//������
			//SetInfo();
			//�����ݾ� ����
			//OzView();
			
			g_lNpChkFlag = 1;
			
			MessageBoxEx (CONFIRM_OK, "�ϳ��� �̹��� ���忡 �����Ͽ����ϴ�.");
			
			//PRINT("TR664021 step 3", 0, 0, 0);
			Rcv_BackVirtAccount();
			
			//PRINT("TR664021 step 4", 0, 0, 0);
			CloseMessageBox();
			//PRINT("TR664021 step 5", 0, 0, 0);
			ON_DRAW();
			//PRINT("TR664021 step 6", 0, 0, 0);
			return 1;	
		}
		else
		{
			MessageBoxEx (ERROR_OK, "�����߻�. ��� �� �ٽ� �õ� �ٶ��ϴ�.");
			//PRINT("TR664021 step 3-1", 0, 0, 0);
			ON_DRAW();
			return -1;
		}
	}

	//------------------------------------------------------------------
	//����Ȯ���� ����
	void SetInfo(void)
	{
		long i;
		char szindex[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&m_stPayInfo, 0x00, sizeof(m_stPayInfo));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT \
  PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, PARAM6, PARAM7, PARAM8 \
  , PARAM9, PARAM10, PARAM11, PARAM12, PARAM13, PARAM14, PARAM15 \
  , PARAM16, PARAM17, PARAM18, PARAM19, PARAM20, PARAM21 \
  , PARAM22, PARAM23, PARAM24, PARAM25, PARAM26, PARAM27 \
  , PARAM28, PARAM29, PARAM30, PARAM31, PARAM32, PARAM33, PARAM34, PARAM35, PARAM36, PARAM37, PARAM38, PARAM39, PARAM40, PARAM41 FROM RCV_TMP" );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;

		sql->Bind(sql, i++, 'U', (long*)&stMw.szUse_cont_num , 11, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while( sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CONT_NUM         , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_ASSIGN_SEQ   , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.SEQ                  , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CUST_NM          , 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_FIRM_NM          , 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_BIZ_REGI_NUM     , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CP_DDD           , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CP_EXN           , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CP_NUM           , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_OWNHOUSE_TEL_DDD , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_OWNHOUSE_TEL_EXN , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_OWNHOUSE_TEL_NUM , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_CURR_ADDR_UNION  , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.USE_NEW_ADDR_UNION   , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ADJ_BASE_YMD         , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CUST_NM              , 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.SOC_NUM              , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CP_DDD               , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CP_EXN               , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CP_NUM               , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.OWNHOUSE_TEL_DDD     , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.OWNHOUSE_TEL_EXN     , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.OWNHOUSE_TEL_NUM     , 5  , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.RELATION             , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.CAUSE_CD             , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PAY_PLAN_YMD         , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.RMK                  , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_USE_CONT_NUM , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.FIRM_NM              , 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.BIZ_REGI_NUM         , 30 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ADDR                 , 300, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.SECOND_ADDR          , 200, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ADDR_GB              , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ADDR_TYPE            , 10 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ZIP_SEQ              , 20,  DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.NEW_ADDR_BLD_SEQ     , 20,  DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_TYPE_GB      , 100, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_EMPID        , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_YMD          , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_TOT_AMT      , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ID_REC_YN            , 2  , DECRYPT );
		}
Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
	//------------------------------------------------------------------
	void OzView(void)
	{
		handle hHeader = NULL;
		handle h = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//PRINT("OzView start", 0, 0, 0);
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hHeader = JSON_Create( JSON_Object );
			if(hHeader == NULL)
			{
				goto Finally;
			}
			
			m_hBody = JSON_Create( JSON_Object );
			if(m_hBody == NULL)
			{
				goto Finally;
			}		

			//���� �� Body �� ����
			SetJsonBody(sql);
			
			//��������Ȯ�༭ �� ���볳��Ȯ�༭ ������Ǽ� ����
			JSON_SetValue( m_hBody, 'C', "detail1",     "�������� ���� �� �̿� ���� [�ʼ�]<br> <br><br> 1.���������� �������̿� ����<br> - ���ð��� ��ݾȳ�, �Ǹ�Ȯ�� �� ��������, ��ݰ��� �� �߽ɰ���, ������ġ<br> 2.�������̿��Ϸ��� ���������� �׸�<br> - ����, �ּ�, ��ȭ��ȣ, �޴���ȭ��ȣ<br> 3.���� �� �̿�Ⱓ<br> - �̿�����Ⱓ��" );
			JSON_SetValue( m_hBody, 'C', "detail2",     "�����ĺ����� ���� �� �̿� ���� [�ʼ�]<br><br> 1.�����ĺ������� �������̿� ����<br> - �Ǹ�Ȯ�� �� ��������, ä���߽�, ������ġ<br> 2.�������̿��Ϸ��� ���������� �׸�<br> - �ֹε�Ϲ�ȣ, �ܱ��ε�Ϲ�ȣ, ���������ȣ, ���ǹ�ȣ<br> 3.���� �� �̿�Ⱓ<br> - �̿�����Ⱓ��" );
			JSON_SetValue( m_hBody, 'C', "detail3",     "����(�ſ�)���� ��ȸ ���� [�ʼ�]<br><br> 1.�ſ���ȸȸ��<br> - NICE��������<br> 2.��ȸ ��� ����<br> - ��������, �ſ뵵�Ǵ�����(��ü, �ε�, ������������), ��������, �ſ���, ��Ű���<br> 3.��ȸ ����<br> - Ȯ�༭ ü�� �� �����Ǵܿ���, ��ü����, ���Žɻ�<br> 4.���� �� �̿�Ⱓ<br> - �̿�����Ⱓ��" );
			JSON_SetValue( m_hBody, 'C', "detail4",     "����(�ſ�)���� ��3�� ���� ���� [�ʼ�]<br><br> 1.���������� �����޴� ��<br> - NICE������(��)<br> 2.���������� �����޴� ���� �������� �̿� ����<br> - �ſ�������ȸ, ä����������, ä���߽�, ��������ȣ �߱�<br> 3.�����ϴ� �������� �׸�<br> - ����, �������, ����, �ּ�, ��ȭ��ȣ, �޴���ȭ��ȣ, �̳�����<br> 4.���� �� �̿�Ⱓ<br> - �̿�����Ⱓ��" );
			JSON_SetValue( m_hBody, 'C', "detail5",     "�����ĺ����� ��3�� ���� ���� [�ʼ�]<br><br> 1.�����ĺ������� �����޴� ��<br> - NICE������(��)<br> 2.�����ĺ������� �����޴� ���� �����ĺ����� �̿� ����<br> - �ſ�������ȸ, ä����������, ä���߽�<br> 3.�����ϴ� �����ĺ����� �׸�<br> - �ֹι�ȣ, �ܱ��ε�Ϲ�ȣ, ���������ȣ, ���ǹ�ȣ<br> 4.���� �� �̿�Ⱓ<br> - �̿�����Ⱓ��" );
			
			//�ּ� �Է� ȭ�� �⺻ ������
			JSON_SetValue( m_hBody, 'C', "url",          GET_URL(WAS_BASE_URL) );
			JSON_SetValue( m_hBody, 'C', "clientid",     stUserinfo.szpda_ip );
			JSON_SetValue( m_hBody, 'C', "userid",       stUserinfo.szemployee_id );
			JSON_SetValue( m_hBody, 'C', "workcd",       stUserinfo.szworkcd );
			JSON_SetValue( m_hBody, 'C', "vmversion",    stUserinfo.szver_num );
			JSON_SetValue( m_hBody, 'C', "appversion",   stUserinfo.szappversion );
				
			//��� �Է�
			// PROMISE_TYPE_GB Ȯ�༭ ���� ( �������� : 10, ���볳�� : 20 , ����༭�� �ƿ� �ٸ�)
			if( Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "10") == 0 )
			{
				JSON_SetValue	(hHeader	, 'C', "Formcode"			, "00003");
			}
			else if(Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "20") == 0 )
			{
				JSON_SetValue	(hHeader	, 'C', "Formcode"			, "00002");
			}
			JSON_SetValue	(hHeader	, 'C', "Ozserver"			, GET_URL(OZ_BASE_URL));
			JSON_Attach 	(hHeader		 , "Paramdata"			, m_hBody);
			
			//�ý����� ��û
			// { "method" : "�ý����� �Ž���", "data" : "json object ��Ʈ��" }
			JSON_SetValue	(h, 'C', "method", "OzViewActivity");
			JSON_Attach 	(h, "data", hHeader);
			System_Call		("Native_System_Call" , JSON_toString(h));
		}
		
	Finally:
	
		DelSqLite(sql);
		//PRINT("OzView DelSqLite", 0, 0, 0);
		if (h)
		{
			JSON_Finalize(h);
		}	
	
		if (hHeader)
		{
			JSON_Finalize(hHeader);
		}
			
		if (m_hBody)
		{
			JSON_Finalize(m_hBody);
		}
	}
	
	//------------------------------------------------------------------
	void SetJsonBody(SQLITE sql)
	{
		long i = 0, j = 0;
		long lAllAmt = 0;
		long lComboCnt = 0;
		char szUseHpNum[20];
		char szUseTelNum[20];
		char szTemlNum[20];
		char szNumber[5];
		char szAllAmt[30];
		char szpmChargedate[50];
		char szpmCost[50];
		char szpmPaybackdate[50];
		char szRet[256];
		char szTmp[256];
		char szComboData[700];
		long account = 0;
		long nonpay = 0;
		long nAmt = 0;
		char szPLAN_REQ1[20];
		char szPLAN_REQ2[20];
		char szSql[300];
		
		// PROMISE_TYPE_GB Ȯ�༭ ���� ( �������� : 10, ���볳�� : 20 , ����༭�� �ƿ� �ٸ�)
		if(Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "10") == 0 )
		{
			//��༭ �ۼ����� > 1(�������Ȯ�༭) > �ο� �� , 2(�������Ȯ�༭+�̻�����) > �ο�
			if(m_stPayInfo.ID_REC_YN[0] == 'Y' )
				JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "3");
			else
				JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "2");
			
			//�ٵ� - ��������
			JSON_SetValue	(m_hBody	, 'C', "pmUsecontnum"		, m_stPayInfo.USE_CONT_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmCorpname"			, m_stPayInfo.USE_FIRM_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmVatno"			, m_stPayInfo.USE_BIZ_REGI_NUM);

			if( Str_Len(m_stPayInfo.NEW_ADDR_UNION) > 5 )
			{
				//�⺻ ���θ��ּ� �Է�
				JSON_SetValue	(m_hBody	, 'C', "pmAddr"			    , m_stPayInfo.USE_NEW_ADDR_UNION);
			}
			else
			{
				//���θ��ּ� ���� �� �����ּ� �Է�
				JSON_SetValue	(m_hBody	, 'C', "pmAddr"			    , m_stPayInfo.USE_CURR_ADDR_UNION);
			}
			
			JSON_SetValue	(m_hBody	, 'C', "pmName"			    , m_stPayInfo.USE_CUST_NM);
			
			
			Mem_Set((byte*)szUseHpNum, 0x00, sizeof(szUseHpNum));	
			//SPRINT(szUseHpNum, "%s-%s-%s", m_stPayInfo.USE_CP_DDD, m_stPayInfo.USE_CP_EXN, m_stPayInfo.USE_CP_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone1"			, m_stPayInfo.USE_CP_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone2"			, m_stPayInfo.USE_CP_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone3"			, m_stPayInfo.USE_CP_NUM);
			
			Mem_Set((byte*)szUseTelNum, 0x00, sizeof(szUseTelNum));	
			//SPRINT(szUseTelNum, "%s-%s-%s", m_stPayInfo.USE_OWNHOUSE_TEL_DDD, m_stPayInfo.USE_OWNHOUSE_TEL_EXN, m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmTel1"			    , m_stPayInfo.USE_OWNHOUSE_TEL_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmTel2"			    , m_stPayInfo.USE_OWNHOUSE_TEL_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmTel3"			    , m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			
			
			//�ٵ� - ���ð��� �̳����� �� ��ȯ(��������) ��ȹ , m_lPlanCnt
			lAllAmt = 0;
			if( Str_AtoI( stMw.szLaw_etc_amt ) > 0 )
			{
				m_lPlanCnt = 2;
			}
			else
			{
				m_lPlanCnt = 1;
			}
			
			account = 0;
			nonpay = 0;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt2( sql, szSql, &account );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt2( sql, szSql, &nonpay );
			
			i = 0;
			nAmt = account+nonpay+Str_AtoI(stMw.szDebt_amt) ;   //�߰�����ݾ�+�����̳��ݾ�+��չ̳���
			Str_ItoA( nAmt, m_stPayPlan[i].PROMISE_PLAN_AMT,10   );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szPLAN_REQ2, 0x00, sizeof(szPLAN_REQ2) );
			SPRINT(szSql, "SELECT MIN(REQ_YM) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr2( sql, szSql, 7, szPLAN_REQ2 );
			if( Str_Len(szPLAN_REQ2) == 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szPLAN_REQ2, 0x00, sizeof(szPLAN_REQ2) );
				SPRINT(szSql, "SELECT MAX(REQ_YM) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
				g_Sql_RetStr2( sql, szSql, 7, szPLAN_REQ2 );
			}
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szPLAN_REQ1, 0x00, sizeof(szPLAN_REQ1) );
			SPRINT(szSql, "SELECT MIN(REQ_YM) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr2( sql, szSql, 7, szPLAN_REQ1 );
			
			if( Str_Len(szPLAN_REQ1) == 0 )
			{
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[2] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+3, (byte*)szPLAN_REQ2+4, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[5] = '~';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+6, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[8] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+9, (byte*)szPLAN_REQ2+4, 2 );
				
			}
			else
			{
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ, (byte*)szPLAN_REQ1+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[2] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+3, (byte*)szPLAN_REQ1+4, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[5] = '~';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+6, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[8] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+9, (byte*)szPLAN_REQ2+4, 2 );				
			}
			
			Str_Cpy(m_stPayPlan[i].USE_CONT_NUM    , stMw.szUse_cont_num );
			Str_Cpy(m_stPayPlan[i].SEQ             , m_stPayInfo.SEQ);
			Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_SEQ, "1");
			Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_YMD, "");
			JSON_SetValue	(m_hBody	, 'C', "pmChargedate1"	, m_stPayPlan[i].PROMISE_PLAN_REQ);
			JSON_SetValue	(m_hBody	, 'C', "pmCost1"		, m_stPayPlan[i].PROMISE_PLAN_AMT);
			JSON_SetValue	(m_hBody	, 'C', "pmPaybackdate1"	, m_stPayPlan[i].PROMISE_PLAN_YMD);
			lAllAmt = Str_AtoI( m_stPayPlan[i].PROMISE_PLAN_AMT );
			i++;
			if(m_lPlanCnt == 2)
			{
				Str_Cpy(m_stPayPlan[i].USE_CONT_NUM    , stMw.szUse_cont_num );
				Str_Cpy(m_stPayPlan[i].SEQ             , m_stPayInfo.SEQ);
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_SEQ, "2");
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_REQ, " " );
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_AMT, stMw.szLaw_etc_amt );//������Ÿ�ݾ�
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_YMD, "");
				JSON_SetValue	(m_hBody	, 'C', "pmChargedate2"	, m_stPayPlan[i].PROMISE_PLAN_REQ);
				JSON_SetValue	(m_hBody	, 'C', "pmCost2"		, m_stPayPlan[i].PROMISE_PLAN_AMT);
				JSON_SetValue	(m_hBody	, 'C', "pmPaybackdate2"	, m_stPayPlan[i].PROMISE_PLAN_YMD);
				lAllAmt += Str_AtoI( m_stPayPlan[i].PROMISE_PLAN_AMT );
			}
		
			Mem_Set((byte*)szAllAmt, 0x00, sizeof(szAllAmt));
			Str_ItoA(lAllAmt, szAllAmt, 10);
			JSON_SetValue	(m_hBody	, 'C', "pmTotal"			, szAllAmt);//�ѱݾ�
			Str_Cpy(m_stPayInfo.PROMISE_TOT_AMT, szAllAmt);
			//�ٵ� - ������ �ͻ�κ��� ���ð����� ���޹޾� ~ Ȯ�༭�� �ۼ� �����մϴ�.
			JSON_SetValue	(m_hBody	, 'C', "pmGascost"			, m_stPayInfo.PROMISE_TOT_AMT);

			//�ٵ� - ����Ȯ���
			//����Ȯ��� �ּ����� ȭ�� ���� �ʿ�.
        	Str_Cpy(m_stPayInfo.ADDR_UNION, m_stPayInfo.ADDR);
        	Str_Cat(m_stPayInfo.ADDR_UNION, " ");
        	Str_Cat(m_stPayInfo.ADDR_UNION, m_stPayInfo.SECOND_ADDR);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyaddr"		, m_stPayInfo.ADDR_UNION);
			
			JSON_SetValue	(m_hBody	, 'C', "pmSuretycorpname"	, m_stPayInfo.FIRM_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyvatno"		, m_stPayInfo.BIZ_REGI_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyjumin"		, m_stPayInfo.SOC_NUM);

			//��ȭ��ȣ �޺��ڽ�
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			SPRINT(szTmp," CODE_ID = 'A10110' ORDER BY SORT_ORDER ",0,0,0);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretytelcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));
			
			if( Str_Len(m_stPayInfo.CP_EXN) > 2)
			{
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel1"		, m_stPayInfo.CP_DDD);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel2"		, m_stPayInfo.CP_EXN);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel3"		, m_stPayInfo.CP_NUM);
			}
			else
			{
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel1"		, m_stPayInfo.OWNHOUSE_TEL_DDD);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel2"		, m_stPayInfo.OWNHOUSE_TEL_EXN);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel3"		, m_stPayInfo.OWNHOUSE_TEL_NUM);
			}
			JSON_SetValue	(m_hBody	, 'C', "pmUsename"		, m_stPayInfo.USE_CUST_NM);
			//JSON_SetValue	(m_hBody	, 'C', ""		, m_stPayInfo.ID_REC_YN);
			
			
		}
		else if( Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "20") == 0 )
		{
			//��༭ �ۼ����� > 1(���볳��Ȯ�༭), 2(���볳��Ȯ�༭+�̻�����)
			if(m_stPayInfo.ID_REC_YN[0] == 'Y' )
				JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "3");
			else
				JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "2");

			//�ٵ� - ��������
			JSON_SetValue	(m_hBody	, 'C', "pmUsecontnum"		, m_stPayInfo.USE_CONT_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmCorpname"			, m_stPayInfo.USE_FIRM_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmVatno"			, m_stPayInfo.USE_BIZ_REGI_NUM);

			if( Str_Len(m_stPayInfo.NEW_ADDR_UNION) > 5 )
			{
				//�⺻ ���θ��ּ� �Է�
				JSON_SetValue	(m_hBody	, 'C', "pmAddr"			, m_stPayInfo.USE_NEW_ADDR_UNION);
			}
			else
			{
				//���θ��ּ� ���� �� �����ּ� �Է�
				JSON_SetValue	(m_hBody	, 'C', "pmAddr"			, m_stPayInfo.USE_CURR_ADDR_UNION);
			}
			JSON_SetValue	(m_hBody	, 'C', "pmName"			    , m_stPayInfo.USE_CUST_NM);
			
			Mem_Set((byte*)szUseHpNum, 0x00, sizeof(szUseHpNum));	
			//SPRINT(szUseHpNum, "%s-%s-%s", m_stPayInfo.USE_CP_DDD, m_stPayInfo.USE_CP_EXN, m_stPayInfo.USE_CP_NUM);			
			JSON_SetValue	(m_hBody	, 'C', "pmPhone1"			, m_stPayInfo.USE_CP_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone2"			, m_stPayInfo.USE_CP_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone3"			, m_stPayInfo.USE_CP_NUM);
			
			Mem_Set((byte*)szUseTelNum, 0x00, sizeof(szUseTelNum));	
			//SPRINT(szUseTelNum, "%s-%s-%s", m_stPayInfo.USE_OWNHOUSE_TEL_DDD, m_stPayInfo.USE_OWNHOUSE_TEL_EXN, m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmTel1"			    , m_stPayInfo.USE_OWNHOUSE_TEL_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmTel2"			    , m_stPayInfo.USE_OWNHOUSE_TEL_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmTel3"			    , m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			//�ٵ� - ���ð��� �̳����� �� ��ȯ(��������) ��ȹ , m_lPlanCnt
			lAllAmt = 0;
			if( Str_AtoI( stMw.szLaw_etc_amt ) > 0 )
			{
				m_lPlanCnt = 2;
			}
			else
			{
				m_lPlanCnt = 1;
			}
			
			account = 0;
			nonpay = 0;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(ACCOUNT) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt2( sql, szSql, &account );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(UNPAY_AMT) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt2( sql, szSql, &nonpay );
			
			i = 0;
			nAmt = account+nonpay+Str_AtoI(stMw.szDebt_amt) ;   //�߰�����ݾ�+�����̳��ݾ�+��չ̳���
			Str_ItoA( nAmt, m_stPayPlan[i].PROMISE_PLAN_AMT,10   );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szPLAN_REQ2, 0x00, sizeof(szPLAN_REQ2) );
			SPRINT(szSql, "SELECT MIN(REQ_YM) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr2( sql, szSql, 7, szPLAN_REQ2 );
			if( Str_Len(szPLAN_REQ2) == 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szPLAN_REQ2, 0x00, sizeof(szPLAN_REQ2) );
				SPRINT(szSql, "SELECT MAX(REQ_YM) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
				g_Sql_RetStr2( sql, szSql, 7, szPLAN_REQ2 );
			}
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szPLAN_REQ1, 0x00, sizeof(szPLAN_REQ1) );
			SPRINT(szSql, "SELECT MIN(REQ_YM) FROM C6101_NONPAY  WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK = '0' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetStr2( sql, szSql, 7, szPLAN_REQ1 );
			
			if( Str_Len(szPLAN_REQ1) == 0 )
			{
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[2] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+3, (byte*)szPLAN_REQ2+4, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[5] = '~';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+6, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[8] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+9, (byte*)szPLAN_REQ2+4, 2 );
				
			}
			else
			{
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ, (byte*)szPLAN_REQ1+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[2] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+3, (byte*)szPLAN_REQ1+4, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[5] = '~';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+6, (byte*)szPLAN_REQ2+2, 2 );
				m_stPayPlan[i].PROMISE_PLAN_REQ[8] = '.';
				Mem_Cpy((byte*)m_stPayPlan[i].PROMISE_PLAN_REQ+9, (byte*)szPLAN_REQ2+4, 2 );				
			}
			
			Str_Cpy(m_stPayPlan[i].USE_CONT_NUM    , stMw.szUse_cont_num );
			Str_Cpy(m_stPayPlan[i].SEQ             , m_stPayInfo.SEQ);
			Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_SEQ, "1");
			Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_YMD, "");
			JSON_SetValue	(m_hBody	, 'C', "pmChargedate1"	, m_stPayPlan[i].PROMISE_PLAN_REQ);
			JSON_SetValue	(m_hBody	, 'C', "pmCost1"		, m_stPayPlan[i].PROMISE_PLAN_AMT);
			JSON_SetValue	(m_hBody	, 'C', "pmPaybackdate1"	, m_stPayPlan[i].PROMISE_PLAN_YMD);
			lAllAmt = Str_AtoI( m_stPayPlan[i].PROMISE_PLAN_AMT );
			i++;
			if(m_lPlanCnt == 2)
			{
				Str_Cpy(m_stPayPlan[i].USE_CONT_NUM    , stMw.szUse_cont_num );
				Str_Cpy(m_stPayPlan[i].SEQ             , m_stPayInfo.SEQ);
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_SEQ, "2");
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_REQ, " " );
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_AMT, stMw.szLaw_etc_amt );//������Ÿ�ݾ�
				Str_Cpy(m_stPayPlan[i].PROMISE_PLAN_YMD, "");
				JSON_SetValue	(m_hBody	, 'C', "pmChargedate2"	, m_stPayPlan[i].PROMISE_PLAN_REQ);
				JSON_SetValue	(m_hBody	, 'C', "pmCost2"		, m_stPayPlan[i].PROMISE_PLAN_AMT);
				JSON_SetValue	(m_hBody	, 'C', "pmPaybackdate2"	, m_stPayPlan[i].PROMISE_PLAN_YMD);
				lAllAmt += Str_AtoI( m_stPayPlan[i].PROMISE_PLAN_AMT );
			}
		
			Mem_Set((byte*)szAllAmt, 0x00, sizeof(szAllAmt));
			Str_ItoA(lAllAmt, szAllAmt, 10);
			JSON_SetValue	(m_hBody	, 'C', "pmTotal"			, szAllAmt);//�ѱݾ�
			Str_Cpy(m_stPayInfo.PROMISE_TOT_AMT, szAllAmt);
			//�ٵ� - ������ �ͻ�κ��� ���ð����� ���޹޾� ~ Ȯ�༭�� �ۼ� �����մϴ�.
			JSON_SetValue	(m_hBody	, 'C', "pmGascost"			, m_stPayInfo.PROMISE_TOT_AMT);
			//�ٵ� - ����Ȯ���
			//����Ȯ��� �ּ����� ȭ�� ���� �ʿ�.
        	Str_Cpy(m_stPayInfo.ADDR_UNION, m_stPayInfo.ADDR);
        	Str_Cat(m_stPayInfo.ADDR_UNION, " ");
        	Str_Cat(m_stPayInfo.ADDR_UNION, m_stPayInfo.SECOND_ADDR);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyaddr"		, m_stPayInfo.ADDR_UNION);
			
			JSON_SetValue	(m_hBody	, 'C', "pmSuretycorpname"	, m_stPayInfo.FIRM_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyvatno"		, m_stPayInfo.BIZ_REGI_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretyjumin"		, m_stPayInfo.SOC_NUM);

			//��ȭ��ȣ �޺��ڽ�
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			SPRINT(szTmp," CODE_ID = 'A10110' ORDER BY SORT_ORDER ",0,0,0);
			JSON_SetValue	(m_hBody	, 'C', "pmSuretytelcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));

			if( Str_Len(m_stPayInfo.CP_EXN) > 2)
			{
				//SPRINT(szTemlNum, "%s-%s-%s", m_stPayInfo.CP_DDD, m_stPayInfo.CP_EXN, m_stPayInfo.CP_NUM);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel1"		, m_stPayInfo.CP_DDD);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel2"		, m_stPayInfo.CP_EXN);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel3"		, m_stPayInfo.CP_NUM);
			}
			else
			{
				//SPRINT(szTemlNum, "%s-%s-%s", m_stPayInfo.OWNHOUSE_TEL_DDD, m_stPayInfo.OWNHOUSE_TEL_EXN, m_stPayInfo.OWNHOUSE_TEL_NUM);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel1"		, m_stPayInfo.OWNHOUSE_TEL_DDD);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel2"		, m_stPayInfo.OWNHOUSE_TEL_EXN);
				JSON_SetValue	(m_hBody	, 'C', "pmSuretytel3"		, m_stPayInfo.OWNHOUSE_TEL_NUM);
			}
			
			JSON_SetValue	(m_hBody	, 'C', "pmUsename"		, m_stPayInfo.USE_CUST_NM);
			//JSON_SetValue	(m_hBody	, 'C', ""		, m_stPayInfo.ID_REC_YN);
		}
	}

	//------------------------------------------------------------------
	//���� ������ ����
	void Rcv_OzData(char* szOzData)
	{
	char szTmp[500];
	char szBuf[256];
	char szFolderNm[128];
	char szFileNm[256];
	char szCopyNm[256];
	char szCopyPath[256];
	long fd, i = 0, j = 0, k = 0;
	long lFileLen = 0;
	long lAddrLen = 0;
	long lRet = 0;
	char *szitem;
	char *szPath;
	char *szData;
	char *szAddrMode;
	char *szAddrSeq;
	long *nCol;
	long nCnt = 0;
	char szType[2] = {0,0};
	long ret = 0;
	handle hItem = NULL;
	handle hPath = NULL;
	handle hData = NULL;
	handle hAddrMode = NULL;
	handle hAddrSeq = NULL;

		Mem_Set((byte*)&m_stOzData, 0x00, sizeof(m_stOzData));
		
		hItem = JSON_Create( JSON_Object );
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szOzData ) ;
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, JSON_GetValue (hItem, "ret_action",    szType));

			if( Str_Cmp(szTmp, "btnSave") == 0 )
			{
				//�ۼ����� ���� ��ư ���� , btnSave
			
				//�Է� ����
				szData = JSON_GetValue (hItem, "ret_data",    szType);

				hData = JSON_Create( JSON_Object );
				if( hData != NULL )
				{
					JSON_toJson( hData, szData ) ;
	
					Str_Cpy(m_stOzData.PROMISE_TYPE_GB   , m_stPayInfo.PROMISE_TYPE_GB);
					Str_Cpy(m_stOzData.USE_CONT_NUM      , JSON_GetValue (hData, "pmUsecontnum",    szType));
					Str_Chg(m_stOzData.USE_CONT_NUM, STRCHG_DEL_NONDIGIT );
					Str_Cpy(m_stOzData.PROMISE_ASSIGN_SEQ, m_stPayInfo.PROMISE_ASSIGN_SEQ);
					Str_Cpy(m_stOzData.SEQ               , m_stPayInfo.SEQ);

					//�Է� �ּ� ����(����,���θ�,����)
					//ADDR_GB = 'N ' ���� X | 'Y' ���� O
					//ADDR_TYPE = 'Z' ���� | 'R' ���θ�
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_Cpy(szTmp           , JSON_GetValue (hData, "pmSuretyaddr", szType));
					if( Str_Cmp(szTmp, m_stPayInfo.ADDR_UNION) == 0 )
					{
						if( Str_Cmp(m_stPayInfo.ADDR_GB, "N") == 0 )
						{
							Str_Cpy(m_stOzData.ADDR_GB, "N");

							if( Str_Cmp(m_stPayInfo.ADDR_TYPE, "Z") == 0 )
							{
								Str_Cpy(m_stOzData.ADDR_TYPE, m_stPayInfo.ADDR_TYPE);
								Str_Cpy(m_stOzData.ZIP_SEQ           , m_stPayInfo.ZIP_SEQ);
								Str_Cpy(m_stOzData.ADDR_UNION        , m_stPayInfo.ADDR);
								Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , "");
								Str_Cpy(m_stOzData.NEW_ADDR_UNION    , "");
								Str_Cpy(m_stOzData.LOT_NUM_UNION     , "");
								Str_Cpy(m_stOzData.SECOND_ADDR       , m_stPayInfo.SECOND_ADDR);
							}
							else
							{
								Str_Cpy(m_stOzData.ADDR_TYPE, m_stPayInfo.ADDR_TYPE);
								Str_Cpy(m_stOzData.ZIP_SEQ           , "");
								Str_Cpy(m_stOzData.ADDR_UNION        , "");
								Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , m_stPayInfo.NEW_ADDR_BLD_SEQ);
								Str_Cpy(m_stOzData.NEW_ADDR_UNION    , m_stPayInfo.ADDR);
								Str_Cpy(m_stOzData.LOT_NUM_UNION     , "");
								Str_Cpy(m_stOzData.SECOND_ADDR       , m_stPayInfo.SECOND_ADDR);
							}
						}
						else
						{
							Str_Cpy(m_stOzData.ADDR_GB, "Y");
							Str_Cpy(m_stOzData.ADDR_TYPE, "R");

							Str_Cpy(m_stOzData.ZIP_SEQ           , "");
							Str_Cpy(m_stOzData.ADDR_UNION        , "");
							Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , "");
							Str_Cpy(m_stOzData.NEW_ADDR_UNION    , "");
							Str_Cpy(m_stOzData.LOT_NUM_UNION     , m_stPayInfo.ADDR);
							Str_Cpy(m_stOzData.SECOND_ADDR       , m_stPayInfo.SECOND_ADDR);
						}

					}
					else
					{
						szAddrMode = JSON_GetValue (hItem, "ret_addr_mode",    szType);
						szAddrSeq = JSON_GetValue (hItem, "ret_zip_seq",    szType);				
						if( Str_Cmp(szAddrMode, "Z") == 0 )
						{
							Str_Cpy(m_stOzData.ADDR_GB, "N");
							Str_Cpy(m_stOzData.ADDR_TYPE, "Z");
							
							Str_Cpy(m_stOzData.ZIP_SEQ           , szAddrSeq);
							
							Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
							Str_Cpy(szTmp, JSON_GetValue (hItem, "ret_addr_1",    szType));
							if(Str_Len(szTmp) > 7)
							{
								Mem_Cpy((byte *)m_stOzData.ADDR_UNION, (byte *)szTmp+7, Str_Len(szTmp)-7);
							}
							else
							{
								Str_Cpy(m_stOzData.ADDR_UNION, szTmp);
							}
							
							Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , "");
							Str_Cpy(m_stOzData.NEW_ADDR_UNION    , "");
							Str_Cpy(m_stOzData.LOT_NUM_UNION     , "");
							Str_Cpy(m_stOzData.SECOND_ADDR       , JSON_GetValue (hItem, "ret_addr_2",    szType));

						}
						else if( Str_Cmp(szAddrMode, "R") == 0 )
						{

							Str_Cpy(m_stOzData.ADDR_GB, "N");
							Str_Cpy(m_stOzData.ADDR_TYPE, "R");
		
							Str_Cpy(m_stOzData.ZIP_SEQ           , "");
							Str_Cpy(m_stOzData.ADDR_UNION        , "");
							Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , szAddrSeq);
							
							Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
							Str_Cpy(szTmp, JSON_GetValue (hItem, "ret_addr_1",    szType));
							if(Str_Len(szTmp) > 6)
							{
								Mem_Cpy((byte *)m_stOzData.NEW_ADDR_UNION, (byte *)szTmp+6, Str_Len(szTmp)-6);
							}
							else
							{
								Str_Cpy(m_stOzData.ADDR_UNION, szTmp);
							}
							
							Str_Cpy(m_stOzData.LOT_NUM_UNION     , "");
							Str_Cpy(m_stOzData.SECOND_ADDR       , JSON_GetValue (hItem, "ret_addr_2",    szType));

						}
						else
						{
							Str_Cpy(m_stOzData.ADDR_GB, "Y");
							Str_Cpy(m_stOzData.ADDR_TYPE, "R");
		
							Str_Cpy(m_stOzData.ZIP_SEQ           , "");
							Str_Cpy(m_stOzData.ADDR_UNION        , "");
							Str_Cpy(m_stOzData.NEW_ADDR_BLD_SEQ  , "");
							Str_Cpy(m_stOzData.NEW_ADDR_UNION    , "");
							Str_Cpy(m_stOzData.LOT_NUM_UNION     , JSON_GetValue (hItem, "ret_addr_1",    szType));
							Str_Cpy(m_stOzData.SECOND_ADDR       , JSON_GetValue (hItem, "ret_addr_2",    szType));
							
						}
					}

					Str_Cpy(m_stOzData.FIRM_NM           , JSON_GetValue (hData, "pmSuretycorpname", szType));
					
					Str_Cpy(m_stOzData.BIZ_REGI_NUM      , JSON_GetValue (hData, "pmSuretyvatno",    szType));
					Str_Chg(m_stOzData.BIZ_REGI_NUM, STRCHG_DEL_NONDIGIT);

					Str_Cpy(m_stOzData.SOC_NUM           , JSON_GetValue (hData, "pmSuretyjumin",    szType));
					Str_Chg(m_stOzData.SOC_NUM, STRCHG_DEL_NONDIGIT);
					
					Str_Cpy(m_stOzData.CP_DDD            , JSON_GetValue (hData, "pmSuretytel1",     szType));
					Str_Cpy(m_stOzData.CP_EXN            , JSON_GetValue (hData, "pmSuretytel2",     szType));
					Str_Cpy(m_stOzData.CP_NUM            , JSON_GetValue (hData, "pmSuretytel3",     szType));
					Str_Cpy(m_stOzData.CUST_NM           , JSON_GetValue (hData, "pmSuretyname",     szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN , JSON_GetValue (hData, "pmAgreetitle1",   szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN2, JSON_GetValue (hData, "pmAgreetitle2",   szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN3, JSON_GetValue (hData, "pmAgreetitle3",   szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN4, JSON_GetValue (hData, "pmAgreetitle4",   szType));
					Str_Cpy(m_stOzData.INFO_USE_AGREE_YN5, JSON_GetValue (hData, "pmAgreetitle5",   szType));

					Str_Cpy(m_stOzData.PROMISE_TOT_AMT   , JSON_GetValue (hData, "pmTotal",   szType));
					Str_Chg(m_stOzData.PROMISE_TOT_AMT,  STRCHG_DEL_NONDIGIT );
					
					Str_Cpy(m_stPayPlan[0].PROMISE_PLAN_YMD, JSON_GetValue (hData, "pmPaybackdate1",   szType));
					Str_Chg(m_stPayPlan[0].PROMISE_PLAN_YMD,  STRCHG_DEL_NONDIGIT );

					if(m_lPlanCnt == 2)
					{
						Str_Cpy(m_stPayPlan[1].PROMISE_PLAN_YMD, JSON_GetValue (hData, "pmPaybackdate2",   szType));
						Str_Chg(m_stPayPlan[1].PROMISE_PLAN_YMD,  STRCHG_DEL_NONDIGIT );
					}
				}
				
				//PDF ���
				szPath = JSON_GetValue (hItem, "pdf_path",    szType);
				hPath = JSON_Create( JSON_Object );
				if( hPath != NULL )
				{
					//OZ ����(PDF) �� Smart���� ���� ������ ����
					JSON_toJson( hPath, szPath ) ;
		
					j = 0;
					k = 0;
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Mem_Set((byte*)szFolderNm, 0x00, sizeof(szFolderNm));
					Mem_Set((byte*)szCopyNm, 0x00, sizeof(szCopyNm));
					
					Str_Cpy(szTmp, JSON_GetValue (hPath, "Path",    szType));
					lFileLen = Str_Len(szTmp);
					if( lFileLen > 0 )
					{
						for( i=0 ; lFileLen ; i++)
						{
							if(szTmp[i] == '0')
							{
								j = i;
								break;
							}
							else
							{
								k++;
							}
						}
						
						//Mem_Cpy((byte *)m_stOzData.ZIP_SEQ, (byte *)szTmp, j);
						Mem_Cpy((byte *)szFolderNm, (byte *)szTmp+(j+9), 17);
						Mem_Cpy((byte *)szCopyNm, (byte *)szTmp+(j+9), 14);
					}

					Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
					Mem_Set((byte*)szFileNm, 0x00, sizeof(szFileNm));
					Str_Cpy(szBuf, "../LCTECH/");
					Str_Cat(szBuf, szFolderNm);
					if ( FFS_Exist(szBuf) )
					{
						lRet = g_FindFiles( szBuf, "*.Enc" , szFileNm);
						if( lRet > 0 )
						{
							SPRINT (m_stOzData.PDFPATH, "OZ_FILE/%s_%s_.pdf.Enc",  szCopyNm, m_stOzData.USE_CONT_NUM, 0);
							FFS_Copy(szFileNm, m_stOzData.PDFPATH);
							
							//������ �ű� �� LCTECH ���� Ŭ����(���� oz���� ����)
							FFS_Delete(szFileNm);
						}

						Mem_Set((byte*)szFileNm, 0x00, sizeof(szFileNm));
						lRet = g_FindFiles( szBuf, "*.pdf" , szFileNm);
						if( lRet > 0 )
						{
							//������ �ű� �� LCTECH ���� Ŭ����(���� oz���� ����)
							FFS_Delete(szFileNm);
						}
					}
				}
			}
			else
			{
				//�ۼ���� ��ư ����
				
				if(hItem != NULL)
				{
					JSON_Finalize(hItem);
					hItem = NULL;
				}
				
				if(hPath != NULL)
				{
					JSON_Finalize(hPath);
					hPath = NULL;
				}
				
				if(hData != NULL)
				{
					JSON_Finalize(hData);
					hData = NULL;
				}
		
				g_Close_SubDlg();
				
				return;
			}
		}


		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
		
		if(hPath != NULL)
		{
			JSON_Finalize(hPath);
			hPath = NULL;
		}
		
		if(hData != NULL)
		{
			JSON_Finalize(hData);
			hData = NULL;
		}

		g_Close_SubDlg();

		//���� ������ �۽�
		Snd_OzView();
		
		ON_DRAW();
		return;
	}

	//------------------------------------------------------------------
	long Snd_OzView(void)
	{
		char szTmp[500];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		char* szfile;
		char* filedata;
		long nRet, filesize, fd;
		handle file;		
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}

		g_SeverConnection();
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822558, FALSE);

        JSON_SetValue( g_pjcomm, 'C', "promise_type_gb",        m_stOzData.PROMISE_TYPE_GB   );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",           m_stOzData.USE_CONT_NUM      );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq",     m_stOzData.PROMISE_ASSIGN_SEQ);
		JSON_SetValue( g_pjcomm, 'C', "seq",                    m_stOzData.SEQ               );
		JSON_SetValue( g_pjcomm, 'C', "addr_gb",                m_stOzData.ADDR_GB           );
		JSON_SetValue( g_pjcomm, 'C', "addr_type",              m_stOzData.ADDR_TYPE         );
		JSON_SetValue( g_pjcomm, 'C', "zip_seq",                m_stOzData.ZIP_SEQ           );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.ADDR_UNION );
		JSON_SetValue( g_pjcomm, 'C', "addr_union",             szTmp                        );
		
		JSON_SetValue( g_pjcomm, 'C', "new_addr_bld_seq",       m_stOzData.NEW_ADDR_BLD_SEQ  );

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.NEW_ADDR_UNION );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_union",         szTmp                        );
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.LOT_NUM_UNION );
		JSON_SetValue( g_pjcomm, 'C', "lot_num_union",          szTmp                        );

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.SECOND_ADDR );
		JSON_SetValue( g_pjcomm, 'C', "second_addr",            szTmp                        );

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.FIRM_NM );
		JSON_SetValue( g_pjcomm, 'C', "firm_nm",                szTmp                        );

		JSON_SetValue( g_pjcomm, 'C', "biz_regi_num",           m_stOzData.BIZ_REGI_NUM      );
		JSON_SetValue( g_pjcomm, 'C', "soc_num",                m_stOzData.SOC_NUM           );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd",                 m_stOzData.CP_DDD            );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn",                 m_stOzData.CP_EXN            );
		JSON_SetValue( g_pjcomm, 'C', "cp_num",                 m_stOzData.CP_NUM            );
		
		//������Ʈ ���� ����
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_stOzData.CUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm",                szTmp                        );		
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn",      m_stOzData.INFO_USE_AGREE_YN );
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn2",     m_stOzData.INFO_USE_AGREE_YN2);
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn3",     m_stOzData.INFO_USE_AGREE_YN3);
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn4",     m_stOzData.INFO_USE_AGREE_YN4);
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn5",     m_stOzData.INFO_USE_AGREE_YN5);
		//ü���� �ٸ�.
		JSON_SetValue( g_pjcomm, 'C', "promise_tot_amt",        m_stOzData.PROMISE_TOT_AMT   );
		
		filesize = FFS_GetSize( m_stOzData.PDFPATH );
		filedata = Mem_Alloc(filesize);
		
		fd = FFS_Open(m_stOzData.PDFPATH, FS_READ_MODE, FS_NORMAL_FLAG );
		FFS_Read ( fd, (byte*)filedata, filesize );
		FFS_Close(fd);

		file = BASE64_Create();
		BASE64_Encode(file, filedata, filesize );
		szfile = BASE64_GetResult(file);	
		
		JSON_SetValue( g_pjcomm, 'C', "oz_file",  szfile );

		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR822558; //��ſϷ� �Ŀ� ȣ�� �Լ�
		HTTP_DownloadData( szUrl, "FR822558_IN",  "FR822558" , sndbuf, szbuf );
		return 1;
	}
	
	//------------------------------------------------------------------
	long TR822558(void)
	{
	long ret = -1;
	
		if(g_Chk_Json(822558) >= 0)
		{
			Snd_Promiseplan();
			ret = 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
		}
		return ret;
	}
	
	//------------------------------------------------------------------
	long Snd_Promiseplan(void)
	{
	char szUrl[200];
	char szbuf[128];
	char* sndbuf;
	handle js = NULL;
	long i;
	long ret;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66804, FALSE);
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		i = 0;
		JSON_AddArrayItem(js);
		JSON_SetArrayItem(js, 'C',  "use_cont_num",     m_stPayPlan[i].USE_CONT_NUM );
		JSON_SetArrayItem(js, 'C',  "seq",              m_stPayPlan[i].SEQ );
		JSON_SetArrayItem(js, 'C',  "promise_plan_seq", m_stPayPlan[i].PROMISE_PLAN_SEQ );
		JSON_SetArrayItem(js, 'C',  "promise_plan_req", m_stPayPlan[i].PROMISE_PLAN_REQ );
		JSON_SetArrayItem(js, 'C',  "promise_plan_amt", m_stPayPlan[i].PROMISE_PLAN_AMT );
		JSON_SetArrayItem(js, 'C',  "promise_plan_ymd", m_stPayPlan[i].PROMISE_PLAN_YMD );
		JSON_SetArrayItem(js, 'C',  "promise_plan_amt_type", "U" );
		
		if( m_lPlanCnt == 2 )
		{
			i++;
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C',  "use_cont_num",     m_stPayPlan[i].USE_CONT_NUM );
			JSON_SetArrayItem(js, 'C',  "seq",              m_stPayPlan[i].SEQ );
			JSON_SetArrayItem(js, 'C',  "promise_plan_seq", m_stPayPlan[i].PROMISE_PLAN_SEQ );
			JSON_SetArrayItem(js, 'C',  "promise_plan_req", m_stPayPlan[i].PROMISE_PLAN_REQ );
			JSON_SetArrayItem(js, 'C',  "promise_plan_amt", m_stPayPlan[i].PROMISE_PLAN_AMT );
			JSON_SetArrayItem(js, 'C',  "promise_plan_ymd", m_stPayPlan[i].PROMISE_PLAN_YMD );
			JSON_SetArrayItem(js, 'C',  "promise_plan_amt_type", "L" );
		}	
		
		JSON_Attach(g_pjcomm, "item", js);	
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		g_SeverConnection();
		
		callBackfunc = TR66804; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR66804_IN",  "FR66804" , sndbuf, szbuf );
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		return ret;
			
	}
	
	//------------------------------------------------------------------
	long TR66804(void)
	{
	long ret = -1;
		g_Sock_Close();
		
		if(g_Chk_Json(66804) >= 0)
		{
			//��ȣȭ pdf ����
			if( FFS_Exist(m_stOzData.PDFPATH) )
			{
				FFS_Delete(m_stOzData.PDFPATH);
			}
			
			g_lNpChkFlag = 1;
			
			MessageBoxEx (CONFIRM_OK, "����Ȯ�༭ ���忡 �����Ͽ����ϴ�.");
			
			Rcv_BackVirtAccount();
			
		}
		else
		{
		}
		
		CloseMessageBox();
		
		ON_DRAW();
		return ret;
	}
	
	//------------------------------------------------------------------
	// ������� ����
	long Rcv_BackVirtAccount(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82211, FALSE);
		
		//JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  "6003658048" );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",  stMw.szUse_cont_num );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82211_1; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR82211_IN",  "FR82211" , sndbuf, sztmp );		
		return 0 ;
	}
	
	//------------------------------------------------------------------
	long TR82211_1(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(82211) >= 0)
		{
			Print_PlanPay();
			
			CloseMessageBox();
			//ReDraw();
			
			//ON_DRAW();
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
	long Print_Result(void* p)
	{
		long* pRet = (long*)p;
		long nRet = *pRet;
	
		//PRINT("%s", g_Printer_GetLastError(nRet),0,0);
	
		if( MessageBoxEx (CONFIRM_YESNO, "������ ������ �ߵǾ����ϱ�?") == MB_OK )
		{
			switch(m_nPayFlag)
			{
				case PRINT_PAY_PLAN: 						
					ON_EXIT();
					OnInit(INIT_MAIN);
					break;
				case PRINT_PAY_BACK: 
					break;
				case PRINT_PAY_OK: 
					MessageBoxEx (CONFIRM_OK, "���γ��� ����� �Ϸ�Ǿ����ϴ�.");
					break;
			}	
		}
		else
		{
			if( MessageBoxEx (CONFIRM_YESNO, "����� �Ͻðڽ��ϱ�?") == MB_OK )
			{
				m_bPrintAgain = TRUE;
			
				switch(m_nPayFlag)
				{
					case PRINT_PAY_PLAN: 	Print_PlanPay(); 	break;
					case PRINT_PAY_BACK: 	Print_BackPay(); 	break;
					case PRINT_PAY_OK: 		Print_Payed(); 		break;
				}	
				
				return 0;
			}
		}	

		m_bPrintAgain = FALSE;
		
		if (m_pList)
		{
			DelArrayList(m_pList);
			m_pList = NULL;
			g_printerCallBack = NULL;
		}

		return 0;
	}	

	//------------------------------------------------------------------
	void Print_PlanPay(void)
	{
		if( g_IsCardReader() )
		{
			return;
		}
		
		if (m_bPrintAgain == FALSE)
		{
			callBackfunc = NULL;
			
			m_pList = Print_PlanPay_GetData();
		}
		
		g_Printer_Start(m_pList, (void*)Print_Result);
		
		m_nPayFlag = PRINT_PAY_PLAN;
	}

	//------------------------------------------------------------------
	void Print_BackPay(void)
	{
		if( g_IsCardReader() )
		{
			return;
		}
		
		if (m_bPrintAgain == FALSE)
		{
			callBackfunc = NULL;
			
			m_pList = Print_BackPay_GetData();
		}
		
		g_Printer_Start(m_pList, (void*)Print_Result);
		
		m_nPayFlag = PRINT_PAY_BACK;
	}

	//------------------------------------------------------------------
	bool Print_Payed(void)
	{
		bool bRet = FALSE;
		
		if( g_IsCardReader() )
		{
			MessageBoxEx (CONFIRM_OK, "������� ���ἳ���� Ȯ���ϼ���.");
			return FALSE;
		}
		
		if (m_bPrintAgain == FALSE)
		{
			if( m_lTotpage3 <= 0 )
			{
				MessageBoxEx (ERROR_OK, "���γ��� ��ȸ�ڷᰡ �����ϴ�.");
				return bRet;
			}
			
			if( MessageBoxEx (CONFIRM_YESNO, "���γ����� ����Ͻðڽ��ϱ�?") != MB_OK)
			{
				return bRet;
			}
			
			callBackfunc = NULL;
			
			m_pList = Print_Payed_GetData();
		}
		
		g_Printer_Start(m_pList, (void*)Print_Result);
		
		m_nPayFlag = PRINT_PAY_OK;
		
		return bRet;
	}
	
	//------------------------------------------------------------------
	void* Print_PlanPay_GetData(void)
	{
		char sztmp[300];
		long ret, idx, row;
		char LineSpace[]={0x1b,0x20,0x00};
		char szBuf[300];
		char szMsg[300];
		char szBillPreiod[300];
		char szFirstNm[32];
		char szLastNm[32];
		char szMtrNum[32];
		char szLeft[50];
		char szCenter[50];
		char szRight[50];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		long mtrcnt;
		long i, tot, len;
		long onceamt, payamt, nonpayamt;
		CARRAYLIST list = NULL;

		list = NewArrayList();
		if (list == NULL)
		{
			return NULL;
		}

		list->append(list, "--------------------------------");
		list->append(list, "        �̳����  Ȯ�༭        ");
		list->append(list, "--------------------------------");
		
		if( Str_Len(stMw.szNew_road_nm) > 0 )
		{
			list->append(list, "--------------------------------");
		}
		
		list->append(list, "�����ּ� : \n");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, stMw.szCity);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stMw.szCounty);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stMw.szTown);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stMw.szVillage_ri);
	
		if( Str_Len(stMw.szVillage) > 0 || Str_Len(stMw.szBuilding) > 0 )
		{
			Str_Cat(sztmp, stMw.szVillage);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szBuilding);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stMw.szHouse_cnt);
		}
		else
		{
			Str_Cat(sztmp, stMw.szAddr1_m);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stMw.szAddr1_s);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szHouse_cnt);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szEtc_addr);
		} //  end if( Str_Len(stMw.szVillage) > 0 || Str_Len(stMw.szBuilding) > 0 )
	
		Str_Cat(sztmp, "\n");
		list->append(list, sztmp);

		if( Str_Len(stMw.szNew_road_nm) > 0 )
		{
			list->append(list, "--------------------------------");
			list->append(list, "���θ��ּ� : \n");
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, stMw.szCity);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szCounty );
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szNew_road_nm);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szNew_addr_m );
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stMw.szNew_addr_s);
			Str_Cat(sztmp, "\n");
			list->append(list, sztmp);
			
			list->append(list, "--------------------------------");
		} // end if( Str_Len(stMw.szNew_road_nm) > 0 )


/*
		Str_Cpy(sztmp, "�����ּ� : ");
		Str_Cat(sztmp, stMw.szCity);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stMw.szCounty);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stMw.szTown);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stMw.szVillage_ri);
		
		if( Str_Len(sztmp) > 32)
		{
			ret = GetUtf8Size(sztmp,32);
			if( ret == 33)
			{
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
				g_Line_Print(list, szMsg,"","",LEFT,0);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Str_Cpy( szMsg,"           ");
				Str_Cat( szMsg, sztmp+31 );
				g_Line_Print(list, szMsg,"","",LEFT,0);
			}
			else
			{	
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
				g_Line_Print(list, szMsg,"","",LEFT,0);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Str_Cpy( szMsg,"           ");
				Str_Cat( szMsg, sztmp+32 );
				g_Line_Print(list, szMsg,"","",LEFT,0);
			}
		}
		else
		{
			g_Line_Print(list, sztmp,"","",LEFT,0);
		}
	
		if( Str_Len(stMw.szVillage) > 0 || Str_Len(stMw.szBuilding) > 0 )
		{
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "             ");
			Str_Cat(sztmp, stMw.szVillage);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szBuilding);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stMw.szHouse_cnt);
			if( Str_Len(sztmp) > 32 )
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{	
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg, "           ");
					Str_Cat( szMsg, sztmp+32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
		}
		else
		{
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "           ");
			Str_Cat(sztmp, stMw.szAddr1_m);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stMw.szAddr1_s);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szHouse_cnt);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szEtc_addr);
			if(Str_Len(sztmp) > 32)
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy(szMsg, "           ");
					Str_Cat( szMsg, sztmp+31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{	
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy(szMsg, "           ");
					Str_Cat( szMsg, sztmp+32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
		} //  end if( Str_Len(stMw.szVillage) > 0 || Str_Len(stMw.szBuilding) > 0 )
		
		if( Str_Len(stMw.szNew_road_nm) > 0 )
		{
			list->append(list, "--------------------------------");
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "���θ��ּ� : ");
			Str_Cat(sztmp, stMw.szCity);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szCounty );

			if(Str_Len(sztmp) > 32)
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy(szMsg, "           ");
					Str_Cat( szMsg, sztmp+31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{	
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy(szMsg, "           ");
					Str_Cat( szMsg, sztmp+32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}


			//g_Line_Print(list, sztmp,"","",LEFT,0);



			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "             ");
			Str_Cat(sztmp, stMw.szNew_road_nm);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "             ");
			Str_Cat(sztmp, stMw.szNew_addr_m );
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stMw.szNew_addr_s);
			
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
		} // end if( Str_Len(stMw.szNew_road_nm) > 0 )
*/
			
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Str_Cpy( sztmp, "��    ȣ : ");
		Str_Cat( sztmp, stMw.szFirm_nm );
		g_Line_Print(list, sztmp,"","",LEFT,0);
			
		//PRINT("szCust_nm:[%s], Str_Len(stMw.szCust_nm):[%d], szFirm_nm:[%s]", stMw.szCust_nm, Str_Len(stMw.szCust_nm), stMw.szFirm_nm);
		Mem_Set( (byte*)szFirstNm, 0x00, sizeof(szFirstNm) );
		Mem_Set( (byte*)szLastNm, 0x00, sizeof(szLastNm) );
		if( Str_Len(stMw.szCust_nm) < 6 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
			Str_Cpy(szBuf, "��    �� : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "***");
			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stMw.szCust_nm) > 4 && Str_Len(stMw.szCust_nm) < 8)
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+4, 2);
			Str_Cpy(szBuf, "��    �� : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "***");
			Str_Cat(szBuf, szLastNm);

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stMw.szCust_nm) > 6 && Str_Len(stMw.szCust_nm) < 10 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+6, 2);
			Str_Cpy(szBuf, "��    �� : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "******");
			Str_Cat(szBuf, szLastNm);
			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stMw.szCust_nm) > 8 && Str_Len(stMw.szCust_nm) < 12 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+8, 2);
			Str_Cpy(szBuf, "��    �� : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "******");
			Str_Cat(szBuf, szLastNm);
			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		
	//PRINT("szFirstNm:[%s], szLastNm:[%s], szBuf:[%s]", szFirstNm, szLastNm, szBuf);
	//PRINT("szCp_ddd:[%s], szCp_exn:[%s], szCp_num:[%s]", stMw.szCp_ddd, stMw.szCp_exn, stMw.szCp_num);
	//PRINT(" 11 szOwnhouse_tel_ddd:[%s], szOwnhouse_tel_exn:[%s], szOwnhouse_tel_num:[%s]", stMw.szOwnhouse_tel_ddd, stMw.szOwnhouse_tel_exn, stMw.szOwnhouse_tel_num);

// if (TRUE) return list; // test ��
	
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Str_Cpy(sztmp, "�� �� �� : ");
		if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) < 11  )
		{
			Str_Cpy( szBuf, stMw.szCp_ddd );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stMw.szCp_exn );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stMw.szCp_num );
			szBuf[5] = '*';
			szBuf[6] = '*';
			szBuf[9] = '*';
			szBuf[10] = '*';
			//123-4**-78**
		}
		else if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) > 10  )
		{
			Str_Cpy( szBuf, stMw.szCp_ddd );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stMw.szCp_exn );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stMw.szCp_num );
			szBuf[6] = '*';
			szBuf[7] = '*';
			szBuf[11] = '*';
			szBuf[12] = '*';
			//123-45**-89**
		}
		else if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) < 10  )
		{
			Str_Cpy( szBuf, "-" );
		}
		Str_Cat(sztmp, szBuf);
		g_Line_Print(list, sztmp,"","",LEFT,0);


// if (TRUE) return list; // test ��
	//PRINT("Print_PlanPay_GetData step 3", 0, 0, 0);
	
		//PRINT(" 22 szOwnhouse_tel_ddd:[%s], szOwnhouse_tel_exn:[%s], szOwnhouse_tel_num:[%s]", stMw.szOwnhouse_tel_ddd, stMw.szOwnhouse_tel_exn, stMw.szOwnhouse_tel_num);

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "������ȭ : ");
		if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) < 10  )
		{
			Str_Cpy( szBuf, stMw.szOwnhouse_tel_ddd );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stMw.szOwnhouse_tel_exn );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stMw.szOwnhouse_tel_num );
			szBuf[5] = '*';
			szBuf[6] = '*';
			szBuf[9] = '*';
			szBuf[10] = '*';
			//123-4**-78**
		}
		else if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) > 10  )
		{
			Str_Cpy( szBuf, stMw.szOwnhouse_tel_ddd );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stMw.szOwnhouse_tel_exn );
			Str_Cat( szBuf, "-" );
			Str_Cat( szBuf, stMw.szOwnhouse_tel_num );
			szBuf[6] = '*';
			szBuf[7] = '*';
			szBuf[11] = '*';
			szBuf[12] = '*';
			//123-45**-89**
		}
		else if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) < 10  )
		{
			Str_Cpy( szBuf, "-" );
		}
		Str_Cat(sztmp, szBuf);
		g_Line_Print(list, sztmp,"","",LEFT,0);	

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Cpy( (byte*)szBuf, (byte*)stMw.szCust_num , 5);
		Mem_Cpy( (byte*)szMsg, (byte*)stMw.szCust_num +5, 5);
		Str_Cpy(sztmp, "����ȣ : ");
		Str_Cat(sztmp, szBuf);
		Str_Cat(sztmp, "-");
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);


// if (TRUE) return list; // test ��
	//PRINT("Print_PlanPay_GetData step 4", 0, 0, 0);
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Cpy( (byte*)szBuf, (byte*)stMw.szUse_cont_num , 5);
		Mem_Cpy( (byte*)szMsg, (byte*)stMw.szUse_cont_num +5, 5);
		Str_Cpy(sztmp, "����ȣ : ");
		Str_Cat(sztmp, szBuf);
		Str_Cat(sztmp, "-");
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Str_Cpy(sztmp, "������������� : ");
		Str_ItoA(Time_GetDate(), szBuf, 10);
		g_Str_DateType( szMsg, szBuf);
		Str_Cat(sztmp, szMsg );
		g_Line_Print(list, sztmp,"","",LEFT,0);			

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "ö����ħ : ");
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		SPRINT(szBuf, "SELECT INDI_VC FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szBuf, 9 , szMsg );			
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);
			
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "��ħ��/���� : ");
		Str_Cat(sztmp, stMw.szGmtr_base_day);
		Str_Cat(sztmp, "��/");
		Str_Cat(sztmp, stMw.szDeadline_flag);
		Str_Cat(sztmp, "����");
		g_Line_Print(list, sztmp,"","",LEFT,0);	

// if (TRUE) return list; // test ��
	//PRINT("Print_PlanPay_GetData step 5", 0, 0, 0);
			
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Str_Cpy(sztmp, "1. ������ �ͻ�κ��� ���ð����� ���޹޾� ����� ");
		Str_ItoA(Time_GetDate(), szBuf, 10);
		Mem_Cpy( (byte*)szMsg, (byte*)szBuf, 4 );
		Str_Cat(szMsg, "�� " );
		Mem_Cpy( (byte*)szMsg+7, (byte*)szBuf+4, 2 );
		Str_Cat(szMsg, "�� " );
		Mem_Cpy( (byte*)szMsg+12, (byte*)szBuf+6, 2 );
		Str_Cat(szMsg, "�� ���� " );
		Str_Cat(sztmp, szMsg);
		Str_Cat(sztmp, "��� �ּ������� �����Կ� �־� �̳� ���ð��� ��� ");

		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Str_Cpy(szMsg, m_stOzData.PROMISE_TOT_AMT );
		Str_Chg(szMsg, STRCHG_INS_COMMA);
		Str_Cat(szMsg, "���� " );
		Str_Cat(sztmp, szMsg);
		list->append(list, sztmp);
		
//PRINT("Print_PlanPay_GetData step 5 sztmp:[%s]", sztmp, 0, 0);
// if (TRUE) return list // test ��;

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Cpy( (byte*)szMsg, (byte*)m_stPayPlan[0].PROMISE_PLAN_YMD, 4 );
		Str_Cat(szMsg, "�� " );
		Mem_Cpy( (byte*)szMsg+7, (byte*)m_stPayPlan[0].PROMISE_PLAN_YMD+4, 2 );
		Str_Cat(szMsg, "�� " );
		Mem_Cpy( (byte*)szMsg+12, (byte*)m_stPayPlan[0].PROMISE_PLAN_YMD+6, 2 );
		Str_Cat(szMsg, "�� ���� ���� �� ���� Ȯ���մϴ�.\n" );
		Str_Cat(sztmp, szMsg);

		list->append(list, sztmp);
//PRINT("Print_PlanPay_GetData step 5-1 sztmp:[%s]", sztmp, 0, 0);
// if (TRUE) return list;

		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cat(sztmp, "2. ���� �� ��������Ȯ���� ������ �� ��� �ſ���ȸ �� ä����������, ");
		Str_Cat(sztmp, "ä���߽ɱ���� ���� ä���߽ɿ� �����ϸ�, �ƿ﷯ ��� ������ġ�� ���Ͽ��� ");
		Str_Cat(sztmp, "��,����� ���Ǹ� �������� ���� ���� Ȯ���մϴ�. \n");
		
		list->append(list, sztmp);	
		
		
		//g_Line_Print(list, sztmp,"","",LEFT,0);
		
		

		list->append(list, "--------------------------------");
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Str_Cpy(sztmp, "���̳�����(");
		Str_ItoA(Time_GetDate(), szBuf, 10);
		g_Str_DateType( szMsg, szBuf);
		Str_Cat(sztmp, szMsg );
		Str_Cat(sztmp, " ����)" );
		g_Line_Print(list, sztmp,"","",LEFT,0);
		list->append(list, "--------------------------------");
		list->append(list, "��  ��    ���Ⱓ      �̳��ݾ�");
			
		//�跮�� �߰����� ������ ����� ���̳������
		mtrcnt = 0;
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt( sztmp, &mtrcnt );
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		nonpayamt = 0;
	
	//PRINT("Print_PlanPay_GetData step 6", 0, 0, 0);
// if (TRUE) return list; // test ��

		sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			MessageBoxEx(ERROR_OK, "�����ͺ��̽� ���� ����.. \n���α׷��� ���� �� �ٽ� ������ ���ñ� �ٶ��ϴ�.");
			goto Finally;
		}
		for( i = 0 ; i < mtrcnt ; i++)
		{		
			// C6101_PROMISE_MTR
			hstmt = sql->CreateStatement(sql, "select MTR_NUM, CHK_YN, REQ_YM, USE_PERIOD_STR, USE_PERIOD_END, ACCOUNT  \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ?  ORDER BY MTR_NUM  LIMIT ?,? ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
			row = 1;
			sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			while( sql->Next(sql) )
			{
				idx = 0;
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set( (byte*) szMtrNum, 0x00, sizeof( szMtrNum) );
				sql->GetValue(sql, idx++, 'U', (long*)szMtrNum ,10+1, DECRYPT);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				sql->GetValue(sql, idx++, 'U', (long*)sztmp ,1+1, DECRYPT);
				if(sztmp[0] == '0')
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 8 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					g_Str_DateType(szMsg, szBuf);
					Str_Cat(szBillPreiod, szMsg+5 );
					Str_Cat(szBillPreiod, "��" );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					g_Str_DateType(szMsg, szBuf);
					Str_Cat(szBillPreiod, szMsg+5 );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
					nonpayamt +=  Str_AtoI( szBuf );
					Str_Chg( szBuf, STRCHG_INS_COMMA);
					Str_Cat(szBuf, "��" );

					g_Line_Print(list, szBillPreiod, "", szBuf, RIGHT, 0);
				} // end if(sztmp[0] == '0')
				
				// 2017-07-23 sql->DeleteStatement(sql);
				
			}; // while( sql->Next(sql) )
			
	Finally:
			sql->DeleteStatement(sql); // 2017-07-23 
			// 2017-07-23 DelSqLite(sql);

	//PRINT("Print_PlanPay_GetData step 7", 0, 0, 0);
// if (TRUE) return list; // test ��
					
			// 2017-07-23 sql = NewSqLite();
	
			// 2017-07-23 hdb = sql->Open(sql);
			// 2017-07-23 if( hdb == NULL )
			// 2017-07-23 {
			// 2017-07-23 	goto Finally2;
			// 2017-07-23 }
		
			hstmt = sql->CreateStatement(sql, "select CHK, REQ_YM, USE_PERIOD_STR, USE_PERIOD_END, UNPAY_AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND MTR_NUM = ? ORDER BY REQ_YM ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally2;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)szMtrNum        , 10, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally2;
			}

			while( sql->Next(sql) == TRUE )
			{
				idx = 0;
				
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
				if(szBuf[0] == '0' )//�����̳� �������� ǥ��
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 8 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					g_Str_DateType(szMsg, szBuf);
					Str_Cat(szBillPreiod, szMsg+5 );
					Str_Cat(szBillPreiod, "��" );
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					g_Str_DateType(szMsg, szBuf);
					Str_Cat(szBillPreiod, szMsg+5);
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
					nonpayamt +=  Str_AtoI( szBuf );
					Str_Chg( szBuf, STRCHG_INS_COMMA);
					Str_Cat( szBuf, "��" );
					
					//g_Line_Print(list, szBillPreiod,"",szBuf,LEFT,0);
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			}; //  end while( sql->Next(sql) == TRUE )
			
	Finally2:

			// 2017-07-23 DelSqLite(sql);
			sql->DeleteStatement(sql); // 2017-07-23 
//PRINT("Print_PlanPay_GetData step 8", 0, 0, 0);

		} // end �̳����� for( i = 0 ; i < mtrcnt ; i++)
		
		DelSqLite(sql); // 2017-07-23
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		//Str_Cpy(sztmp, "         �̳��ݾ� �� : ");
		Str_Cpy(sztmp, "�̳��ݾ� �� : ");
		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
		Str_ItoA( nonpayamt,szBuf ,10);
		Str_Chg(szBuf, STRCHG_INS_COMMA);
		Str_Cat(szBuf,  "��");
		//g_Line_Print(list, sztmp,"",szBuf,LEFT,0);
		g_Line_Print(list, sztmp,"",szBuf,RIGHT,0);
		
		list->append(list, "--------------------------------");
		g_Line_Print(list, "����ħ �� ��뷮","","",LEFT,0);
		list->append(list, "--------------------------------");
		list->append(list, "��  ��      ��  ħ        ��뷮");
		
		for( i = 0 ; i < mtrcnt ; i++)
		{
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally3;
			}
		
			hstmt = sql->CreateStatement(sql, "select MTR_NUM, CHK_YN, REQ_YM, INDI_VC, TOT_USE_QTY  \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ?  ORDER BY MTR_NUM  LIMIT ?,? ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally3;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
			row = 1;
			sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally3;
			}
			
			while( sql->Next(sql) )
			{
				idx = 0;
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set( (byte*) szMtrNum, 0x00, sizeof( szMtrNum) );
				sql->GetValue(sql, idx++, 'U', (long*)szMtrNum ,10+1, DECRYPT);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				sql->GetValue(sql, idx++, 'U', (long*)sztmp ,1+1, DECRYPT);
				if(sztmp[0] == '0')
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 13 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Str_Cat(szBillPreiod, szBuf );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
			
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			};
			
	Finally3:

			DelSqLite(sql);

//PRINT("Print_PlanPay_GetData step 9", 0, 0, 0);	
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally4;
			}
		
			hstmt = sql->CreateStatement(sql, "select CHK, REQ_YM, INDI_COMPENS_VC, USE_QTY FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND MTR_NUM = ? ORDER BY REQ_YM ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)szMtrNum        , 10, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}

			while( sql->Next(sql) == TRUE )
			{
				idx = 0;
				
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
				if(szBuf[0] == '0' )
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 13 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Str_Cat(szBillPreiod, szBuf );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
			
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			};
			
	Finally4:
			DelSqLite(sql);				
		} // end for( i = 0 ; i < mtrcnt ; i++) ��ħ �� ��뷮
		
		list->append(list, "--------------------------------");
		g_Line_Print(list, "�������� �� ��������","","",LEFT,0);
		list->append(list, "--------------------------------");
		list->append(list, "��  ��     ������       ��������");
		
		for( i = 0 ; i < mtrcnt ; i++)
		{
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally5;
			}
		
			hstmt = sql->CreateStatement(sql, "select MTR_NUM, CHK_YN, REQ_YM, TOT_REVIS_QTY, SUPPLY_UNIT_ENER  \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ?  ORDER BY MTR_NUM  LIMIT ?,? ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally5;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'X', &i, 4, DECRYPT);
			row = 1;
			sql->Bind(sql, idx++, 'X', &row, 4, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally5;
			}
			
			while( sql->Next(sql) )
			{
				idx = 0;
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set( (byte*) szMtrNum, 0x00, sizeof( szMtrNum) );
				sql->GetValue(sql, idx++, 'U', (long*)szMtrNum ,10+1, DECRYPT);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				sql->GetValue(sql, idx++, 'U', (long*)sztmp ,1+1, DECRYPT);
				if(sztmp[0] == '0')
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 11 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
					Str_Cat(szBillPreiod, szBuf );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
			
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			};
			
	Finally5:
	
			DelSqLite(sql);

//PRINT("Print_PlanPay_GetData step 10", 0, 0, 0);					
			sql = NewSqLite();
	
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally6;
			}
		
			hstmt = sql->CreateStatement(sql, "select CHK, REQ_YM, INDI_COMPENS_VC, USE_QTY FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND MTR_NUM = ? ORDER BY REQ_YM ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally6;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long*)szMtrNum        , 10, DECRYPT);
					
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally6;
			}

			while( sql->Next(sql) == TRUE )
			{
				idx = 0;
				
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,2+1, DECRYPT);
				if(szBuf[0] == '0' )//�����̳� �������� ǥ��
				{
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					Mem_Set( (byte*) szBillPreiod, 0x00, sizeof( szBillPreiod) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,8+1, DECRYPT);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Set( (byte*)szMsg, 0x20, 11 );
					len = Str_Len(szBuf);
					Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
					Str_Cat(szBillPreiod, szMsg );
					
					Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
					Str_Cat(szBillPreiod, szBuf );
					
					Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
					sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);
			
					g_Line_Print(list, szBillPreiod,"",szBuf,RIGHT,0);
				}
			};
			
	Finally6:
	
			DelSqLite(sql);				

//PRINT("Print_PlanPay_GetData step 11", 0, 0, 0);	
		} // end ������ �� ��������
					
		list->append(list, "--------------------------------");
		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Str_Cat(szBuf, "[�Ա�������¾ȳ�]" );
		g_Line_Print(list, szBuf,"","",LEFT,0);

		sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally7;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT   PARAM2, PARAM1, PARAM3, '1' as srt \
FROM RCV_TMP \
where PARAM3 = '003'  \
union \
SELECT PARAM2, PARAM1, PARAM3, '2' as srt \
FROM RCV_TMP \
where PARAM3 = '027' \
union \
SELECT PARAM2, PARAM1, PARAM3, '3' as srt \
FROM RCV_TMP \
where PARAM3 <> '027' and PARAM3 <> '003' \
order by srt, PARAM3 " );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally7;
		}
		
		idx = 0;

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally7;
		}

		while( sql->Next(sql) )
		{
			idx = 0;
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue(sql, idx++, 'U', (long*)szBuf, 30, DECRYPT);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, ".�� �� �� : ");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue(sql, idx++, 'U', (long*)szBuf, 30, DECRYPT);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "  ���¹�ȣ : ");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);
		}
				
Finally7:
		DelSqLite(sql);
		// �Ա�������¾ȳ�
		
//		list->append(list, "KT ��ȭ��ü : 060-7088-114      ");
//		list->append(list, "   (������ �߻��� ���κδ�)     ");
		list->append(list, "�Ѽ��ﵵ�ð��� �ݼ���           ");
		list->append(list, "  �� 1588-5788                  ");
		list->append(list, "--------------------------------");
		list->append(list, "�ع̳���� �Ա� �� ���         ");
		list->append(list, "  �����ͷ� ���� �ּž� �մϴ�.");
		list->append(list, "�ع̳���� �Ա� �� �����ͷ�   ");
		list->append(list, "  �����ּž� ��������� ó����");
		list->append(list, "  �Ǹ�, ������ ���� ��� ����� ");
		list->append(list, "  (�⺻��) ��� �߻��� �� ������");
		list->append(list, "  ���� �� Ȯ���Ͻñ� �ٶ��ϴ�.  ");			
		list->append(list, "--------------------------------");
		g_Line_Print(list, "�ذ���������" ,"" ,"",LEFT,0);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "�� �� �� : ");
		Str_Cat(sztmp, stUserinfo.szcenter_nm);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "��ȭ��ȣ : ");
		Str_Cat(sztmp, stUserinfo.sztel);
		g_Line_Print(list, sztmp,"","",LEFT,0);
	
		list->append(list, "--------------------------------");
		list->append(list, "      ���ﵵ�ð���(��)          ");
		list->append(list, "                                ");

//PRINT("Print_PlanPay_GetData end", 0, 0, 0);	
		
		return list;
	}
	
	//------------------------------------------------------------------
	void* Print_BackPay_GetData(void)
	{
		long ret, idx, row;
		char LineSpace[]={0x1b,0x20,0x00};
		char szBuf[300];
		char szMsg[300];
		char sztmp[300];
		char szFirstNm[32];
		char szLastNm[32];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		long jdx = 0;
		long i, tot, len;
		long onceamt, payamt, nonpayamt;
		CARRAYLIST list = NULL;
					
		list = NewArrayList();
		if (list == NULL)
		{
			return NULL;
		}
		
		for( jdx = 0; jdx < 2 ; jdx++ )
		{
			if(g_nWorkFlag == 610)
			{
				list->append(list, "      ����ö�ź� ���� Ȯ�༭    ");
			}
			else
			{
				list->append(list, "      ���񽺺�� ���� Ȯ�༭    ");
			}
			
			if( jdx == 0)
			{
				list->append(list, "            (����)            ");
			}
			else
			{
				list->append(list, "         (������ ������)      ");
			}
			
			list->append(list, "--------------------------------");
			list->append(list, "        ���ﵵ�ð���(��)        ");
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "  ");
			Str_Cat(sztmp, stUserinfo.szcenter_nm );	
			Str_Cat(sztmp, " ����Ÿ");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "��  ȣ  ��  : ");
			Str_Cat(sztmp, stUserinfo.szcom_name );	
			//g_Line_Print(list, sztmp,"","",LEFT,0);				

			if( Str_Len(sztmp) > 32)
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"              ");
					Str_Cat( szMsg, sztmp+31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"               ");
					Str_Cat( szMsg, sztmp+32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "����ڹ�ȣ  : ");
			Mem_Cpy( (byte*)szMsg, (byte*)stUserinfo.szbiz_regi_num, 3 );
			Mem_Cpy( (byte*)szBuf, (byte*)stUserinfo.szbiz_regi_num+3, 2 );
			Str_Cat(sztmp, szMsg );
			Str_Cat(sztmp, "-" );
			Str_Cat(sztmp, szBuf );
			Str_Cat(sztmp, "-" );
			Mem_Cpy( (byte*)szBuf, (byte*)stUserinfo.szbiz_regi_num+5, 5 );
			Str_Cat(sztmp, szBuf );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "��  ǥ  ��  : ");
			Str_Cat(sztmp, stUserinfo.szrepre_nm );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "��  ��  ��  : ");
			Str_Cat(sztmp, stUserinfo.sznm_kor );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy(sztmp, "�� ȭ �� ȣ : ");
			Str_Cat(sztmp, stUserinfo.sztel );	
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");				

			Mem_Set( (byte*)szFirstNm, 0x00, sizeof(szFirstNm) );
			Mem_Set( (byte*)szLastNm, 0x00, sizeof(szLastNm) );
				
			if(g_nWorkFlag == 610)
			{
				if( Str_Len(stMw.szTrans_in_cust_nm) < 6 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 4 && Str_Len(stMw.szTrans_in_cust_nm) < 8)
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+4, 2);
					
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "***");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 6 && Str_Len(stMw.szTrans_in_cust_nm) < 10 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+6, 2);
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
		
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				else if( Str_Len(stMw.szTrans_in_cust_nm) > 8 && Str_Len(stMw.szTrans_in_cust_nm) < 12 )
				{
					Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szTrans_in_cust_nm, 2);
					Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szTrans_in_cust_nm+8, 2);
					Str_Cpy(szBuf, "�� �� �� : ");
					Str_Cat(szBuf, szFirstNm);
					Str_Cat(szBuf, "******");
					Str_Cat(szBuf, szLastNm);
					g_Line_Print(list, szBuf,"","",LEFT,0);
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Cpy( (byte*)szBuf, (byte*)stMw.szTrans_in_cust_num , 5);
				Mem_Cpy( (byte*)szMsg, (byte*)stMw.szTrans_in_cust_num +5, 5);
				Str_Cpy(sztmp, "����ȣ : ");
				Str_Cat(sztmp, szBuf);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, szMsg);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
				Str_Cpy(sztmp, "�� �� �� : ");
				if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) < 11  )
				{
					Str_Cpy( szBuf, stMw.szCp_ddd );
					Str_Cat( szBuf, "-" );
					Str_Cat( szBuf, stMw.szCp_exn );
					Str_Cat( szBuf, "-" );
					Str_Cat( szBuf, stMw.szCp_num );
					szBuf[5] = '*';
					szBuf[6] = '*';
					szBuf[9] = '*';
					szBuf[10] = '*';
					//123-4**-78**
				}
				else if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) > 10  )
				{
					Str_Cpy( szBuf, stMw.szCp_ddd );
					Str_Cat( szBuf, "-" );
					Str_Cat( szBuf, stMw.szCp_exn );
					Str_Cat( szBuf, "-" );
					Str_Cat( szBuf, stMw.szCp_num );
					szBuf[6] = '*';
					szBuf[7] = '*';
					szBuf[11] = '*';
					szBuf[12] = '*';
					//123-45**-89**
				}
				else if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) < 10  )
				{
					Str_Cpy( szBuf, "-" );
				}
				Str_Cat(sztmp, szBuf);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, "������ȭ : ");
				if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) < 10  )
				{
					Str_Cpy( szBuf, stMw.szOwnhouse_tel_ddd );
					Str_Cat( szBuf, "-" );
					Str_Cat( szBuf, stMw.szOwnhouse_tel_exn );
					Str_Cat( szBuf, "-" );
					Str_Cat( szBuf, stMw.szOwnhouse_tel_num );
					szBuf[5] = '*';
					szBuf[6] = '*';
					szBuf[9] = '*';
					szBuf[10] = '*';
					//123-4**-78**
				}
				else if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) > 10  )
				{
					Str_Cpy( szBuf, stMw.szOwnhouse_tel_ddd );
					Str_Cat( szBuf, "-" );
					Str_Cat( szBuf, stMw.szOwnhouse_tel_exn );
					Str_Cat( szBuf, "-" );
					Str_Cat( szBuf, stMw.szOwnhouse_tel_num );
					szBuf[6] = '*';
					szBuf[7] = '*';
					szBuf[11] = '*';
					szBuf[12] = '*';
					//123-45**-89**
				}
				else if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) < 10  )
				{
					Str_Cpy( szBuf, "-" );
				}
				Str_Cat(sztmp, szBuf);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				
				
			}
			else
			{
				if(jdx == 0)
				{
					if( Str_Cmp(stMw.szCont_sts_cd , "30") != 0)
					{
						if( Str_Len(stMw.szCust_nm) < 6 )
						{
							Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
							
							Str_Cpy(szBuf, "�� �� �� : ");
							Str_Cat(szBuf, szFirstNm);
							Str_Cat(szBuf, "***");
				
							g_Line_Print(list, szBuf,"","",LEFT,0);
						}
						else if( Str_Len(stMw.szCust_nm) > 4 && Str_Len(stMw.szCust_nm) < 8)
						{
							Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
							Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+4, 2);
							
							Str_Cpy(szBuf, "�� �� �� : ");
							Str_Cat(szBuf, szFirstNm);
							Str_Cat(szBuf, "***");
							Str_Cat(szBuf, szLastNm);
				
							g_Line_Print(list, szBuf,"","",LEFT,0);
						}
						else if( Str_Len(stMw.szCust_nm) > 6 && Str_Len(stMw.szCust_nm) < 10 )
						{
							Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
							Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+6, 2);
				
							Str_Cpy(szBuf, "�� �� �� : ");
							Str_Cat(szBuf, szFirstNm);
							Str_Cat(szBuf, "******");
							Str_Cat(szBuf, szLastNm);
				
							g_Line_Print(list, szBuf,"","",LEFT,0);
						}
						else if( Str_Len(stMw.szCust_nm) > 8 && Str_Len(stMw.szCust_nm) < 12 )
						{
							Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
							Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+8, 2);
				
							Str_Cpy(szBuf, "�� �� �� : ");
							Str_Cat(szBuf, szFirstNm);
							Str_Cat(szBuf, "******");
							Str_Cat(szBuf, szLastNm);
				
							g_Line_Print(list, szBuf,"","",LEFT,0);
						}
						
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szBuf, (byte*)stMw.szCust_num , 5);
						Mem_Cpy( (byte*)szMsg, (byte*)stMw.szCust_num +5, 5);
						Str_Cpy(sztmp, "����ȣ : ");
						Str_Cat(sztmp, szBuf);
						Str_Cat(sztmp, "-");
						Str_Cat(sztmp, szMsg);
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szBuf, (byte*)stMw.szUse_cont_num , 5);
						Mem_Cpy( (byte*)szMsg, (byte*)stMw.szUse_cont_num +5, 5);
						Str_Cpy(sztmp, "����ȣ : ");
						Str_Cat(sztmp, szBuf);
						Str_Cat(sztmp, "-");
						Str_Cat(sztmp, szMsg);
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Str_Cpy(sztmp, "�� �� �� : ");
						if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) < 11  )
						{
							Str_Cpy( szBuf, stMw.szCp_ddd );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szCp_exn );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szCp_num );
							szBuf[5] = '*';
							szBuf[6] = '*';
							szBuf[9] = '*';
							szBuf[10] = '*';
							//123-4**-78**
						}
						else if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) > 10  )
						{
							Str_Cpy( szBuf, stMw.szCp_ddd );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szCp_exn );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szCp_num );
							szBuf[6] = '*';
							szBuf[7] = '*';
							szBuf[11] = '*';
							szBuf[12] = '*';
							//123-45**-89**
						}
						else if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) < 10  )
						{
							Str_Cpy( szBuf, "-" );
						}
						Str_Cat(sztmp, szBuf);
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Str_Cpy(sztmp, "������ȭ : ");
						if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) < 10  )
						{
							Str_Cpy( szBuf, stMw.szOwnhouse_tel_ddd );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szOwnhouse_tel_exn );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szOwnhouse_tel_num );
							szBuf[5] = '*';
							szBuf[6] = '*';
							szBuf[9] = '*';
							szBuf[10] = '*';
							//123-4**-78**
						}
						else if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) > 10  )
						{
							Str_Cpy( szBuf, stMw.szOwnhouse_tel_ddd );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szOwnhouse_tel_exn );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szOwnhouse_tel_num );
							szBuf[6] = '*';
							szBuf[7] = '*';
							szBuf[11] = '*';
							szBuf[12] = '*';
							//123-45**-89**
						}
						else if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) < 10  )
						{
							Str_Cpy( szBuf, "-" );
						}
						Str_Cat(sztmp, szBuf);
						g_Line_Print(list, sztmp,"","",LEFT,0);
					}
				}
				else
				{
					if( Str_Cmp(stMw.szCont_sts_cd  , "30") != 0)
					{
						if( Str_Len(stMw.szCust_nm) < 6 )
						{
							Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
							
							Str_Cpy(szBuf, "�� �� �� : ");
							Str_Cat(szBuf, szFirstNm);
							Str_Cat(szBuf, "***");
				
							g_Line_Print(list, szBuf,"","",LEFT,0);
						}
						else if( Str_Len(stMw.szCust_nm) > 4 && Str_Len(stMw.szCust_nm) < 8)
						{
							Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
							Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+4, 2);
							
							Str_Cpy(szBuf, "�� �� �� : ");
							Str_Cat(szBuf, szFirstNm);
							Str_Cat(szBuf, "***");
							Str_Cat(szBuf, szLastNm);
				
							g_Line_Print(list, szBuf,"","",LEFT,0);
						}
						else if( Str_Len(stMw.szCust_nm) > 6 && Str_Len(stMw.szCust_nm) < 10 )
						{
							Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
							Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+6, 2);
				
							Str_Cpy(szBuf, "�� �� �� : ");
							Str_Cat(szBuf, szFirstNm);
							Str_Cat(szBuf, "******");
							Str_Cat(szBuf, szLastNm);
				
							g_Line_Print(list, szBuf,"","",LEFT,0);
						}
						else if( Str_Len(stMw.szCust_nm) > 8 && Str_Len(stMw.szCust_nm) < 12 )
						{
							Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
							Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+8, 2);
				
							Str_Cpy(szBuf, "�� �� �� : ");
							Str_Cat(szBuf, szFirstNm);
							Str_Cat(szBuf, "******");
							Str_Cat(szBuf, szLastNm);
				
							g_Line_Print(list, szBuf,"","",LEFT,0);
						}
						
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szBuf, (byte*)stMw.szCust_num , 5);
						Mem_Cpy( (byte*)szMsg, (byte*)stMw.szCust_num +5, 5);
						Str_Cpy(sztmp, "����ȣ : ");
						Str_Cat(sztmp, szBuf);
						Str_Cat(sztmp, "-");
						Str_Cat(sztmp, szMsg);
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szBuf, (byte*)stMw.szUse_cont_num , 5);
						Mem_Cpy( (byte*)szMsg, (byte*)stMw.szUse_cont_num +5, 5);
						Str_Cpy(sztmp, "����ȣ : ");
						Str_Cat(sztmp, szBuf);
						Str_Cat(sztmp, "-");
						Str_Cat(sztmp, szMsg);
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
						Str_Cpy(sztmp, "�� �� �� : ");
						if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) < 11  )
						{
							Str_Cpy( szBuf, stMw.szCp_ddd );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szCp_exn );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szCp_num );
							szBuf[5] = '*';
							szBuf[6] = '*';
							szBuf[9] = '*';
							szBuf[10] = '*';
							//123-4**-78**
						}
						else if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) > 10  )
						{
							Str_Cpy( szBuf, stMw.szCp_ddd );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szCp_exn );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szCp_num );
							szBuf[6] = '*';
							szBuf[7] = '*';
							szBuf[11] = '*';
							szBuf[12] = '*';
							//123-45**-89**
						}
						else if( Str_Len(stMw.szCp_ddd)+Str_Len(stMw.szCp_exn)+Str_Len(stMw.szCp_num) < 10  )
						{
							Str_Cpy( szBuf, "-" );
						}
						Str_Cat(sztmp, szBuf);
						g_Line_Print(list, sztmp,"","",LEFT,0);
						
						
						Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
						Str_Cpy(sztmp, "������ȭ : ");
						if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) < 10  )
						{
							Str_Cpy( szBuf, stMw.szOwnhouse_tel_ddd );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szOwnhouse_tel_exn );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szOwnhouse_tel_num );
							szBuf[5] = '*';
							szBuf[6] = '*';
							szBuf[9] = '*';
							szBuf[10] = '*';
							//123-4**-78**
						}
						else if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) > 10  )
						{
							Str_Cpy( szBuf, stMw.szOwnhouse_tel_ddd );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szOwnhouse_tel_exn );
							Str_Cat( szBuf, "-" );
							Str_Cat( szBuf, stMw.szOwnhouse_tel_num );
							szBuf[6] = '*';
							szBuf[7] = '*';
							szBuf[11] = '*';
							szBuf[12] = '*';
							//123-45**-89**
						}
						else if( Str_Len(stMw.szOwnhouse_tel_ddd)+Str_Len(stMw.szOwnhouse_tel_exn)+Str_Len(stMw.szOwnhouse_tel_num) < 10  )
						{
							Str_Cpy( szBuf, "-" );
						}
						Str_Cat(sztmp, szBuf);
						g_Line_Print(list, sztmp,"","",LEFT,0);
					}
				}
			}
			list->append(list, "--------------------------------");
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "�����ּ� : ");
			Str_Cat(sztmp, stMw.szCity);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szCounty);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szTown);
			if( Str_Len(stMw.szVillage_ri) > 0)
			{
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szVillage_ri);
			}
			
			if( Str_Len(sztmp) > 32)
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{	
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}					
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
			
			if( Str_Len(stMw.szVillage) > 0 || Str_Len(stMw.szBuilding) > 0 )
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "           ");
				Str_Cat(sztmp, stMw.szVillage);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szBuilding);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szHouse_cnt);
				if( Str_Len(sztmp) > 32 )
				{
					ret = GetUtf8Size(sztmp,32);
					if( ret == 33)
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy( szMsg,"           ");
						Str_Cat( szMsg, sztmp+31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
					else
					{	
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy( szMsg, "           ");
						Str_Cat( szMsg, sztmp+32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
				}
				else
				{
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			else
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "           ");
				Str_Cat(sztmp, stMw.szAddr1_m);
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szAddr1_s);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szHouse_cnt);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szEtc_addr);
				if(Str_Len(sztmp) > 32)
				{
					ret = GetUtf8Size(sztmp,32);
					if( ret == 33)
					{
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy(szMsg, "           ");
						Str_Cat( szMsg, sztmp+31 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
					else
					{	
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
						Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
						Str_Cpy(szMsg, "           ");
						Str_Cat( szMsg, sztmp+32 );
						g_Line_Print(list, szMsg,"","",LEFT,0);
					}
				}
				else
				{
					g_Line_Print(list, sztmp,"","",LEFT,0);
				}
			}
			
			if( Str_Len(stMw.szNew_road_nm) > 0 )
			{
				list->append(list, "--------------------------------");
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "���θ��ּ� : ");
				Str_Cat(sztmp, stMw.szCity);
				Str_Cat(sztmp, " ");
				Str_Cat(sztmp, stMw.szCounty );
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stMw.szNew_road_nm);
				g_Line_Print(list, sztmp,"","",LEFT,0);

				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Str_Cpy(sztmp, "             ");
				Str_Cat(sztmp, stMw.szNew_addr_m );
				Str_Cat(sztmp, "-");
				Str_Cat(sztmp, stMw.szNew_addr_s);
				g_Line_Print(list, sztmp,"","",LEFT,0);
				list->append(list, "--------------------------------");
			}
		
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Str_Cpy(sztmp, "��ħ��/���� : ");
			Str_Cat(sztmp, stMw.szGmtr_base_day);
			Str_Cat(sztmp, "��/");
			Str_Cat(sztmp, stMw.szDeadline_flag);
			Str_Cat(sztmp, "����");
			g_Line_Print(list, sztmp,"","",LEFT,0);			
			list->append(list, "--------------------------------");
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			if(g_nWorkFlag == 610)
			{
				Str_Cpy( sztmp, "1. ������ ����ּҿ� �����Կ� �־� �ͻ�κ��� �������� ���ұ� ����ð��� ���� ��� " );
			}
			else
			{
				Str_Cpy( sztmp, "1. ������ ����ּҿ� �ͻ�κ���  �������� ���񽺺�뿡 ���� �ݾ� " );
			}
			
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szLastNm, 0x00, sizeof(szLastNm) );
			
			Str_Cpy( szBuf, stMw.szOnce_account);
			Str_Chg( szBuf, STRCHG_INS_COMMA);
			Str_Cat( sztmp, szBuf );
			Str_Cat( sztmp, "���� " );
			
			Str_ItoA(Time_DateUpDown( Time_GetDate(), 3), szLastNm, 10);
			Mem_Cpy( (byte*)szMsg, (byte*)szLastNm, 4 );
			Str_Cat( szMsg , "��");
			Mem_Cpy( (byte*)szMsg+6, (byte*)szLastNm+4, 2 );
			Str_Cat( szMsg , "��");
			Mem_Cpy( (byte*)szMsg+10, (byte*)szLastNm+6, 2 );
			Str_Cat( szMsg , "��");
			Str_Cat( sztmp, szMsg );
			Str_Cat( sztmp, "���� ���� �� ���� Ȯ���մϴ�.\n" );
			list->append(list, sztmp);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_Cpy( sztmp, "2. �� ��������Ȯ���� ������ �� ��� �ſ���ȸ,ä�������� ��� �� " );
			Str_Cat( sztmp, "ä���߽ɱ���� ���� ä���߽��� �� ���� ������ �˷��帳�ϴ�.\n" );
			list->append(list, sztmp);
			
			list->append(list, "--------------------------------");
			list->append(list, "�ð�����                        ");
			list->append(list, "--------------------------------");
			
			sql = NewSqLite();
		
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally4;
			}
		
			hstmt = sql->CreateStatement(sql, "select B.ONCE_ITEM_NM, A.ONCE_AMT \
	FROM C6101_ONCE_INFO A , C6101_ONCE_ITEM B WHERE A.PROMISE_ASSIGN_SEQ = ? AND A.ONCE_ITEM_CD = B.ONCE_ITEM_CD AND A.ONCE_QTY > 0 ");
			
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}
			
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long*)g_szCHK_EXEC_NUM, 10, DECRYPT);
			
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally4;
			}
			onceamt = 0;
			while( sql->Next(sql) )
			{
				idx = 0;
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,50+1, DECRYPT);
				Str_Cpy(sztmp, "  ");						
				Mem_Set( (byte*)szMsg, 0x20, 18 );
				len = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg );
					
				Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
				sql->GetValue(sql, idx++, 'U', (long*)szBuf ,14+1, DECRYPT);							
				onceamt +=  Str_AtoI( szBuf );
				Str_Chg( szBuf, STRCHG_INS_COMMA);
				Str_Cat(szBuf, "��" );
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Set( (byte*)szMsg, 0x20, 9 );
				len = Str_Len(szBuf);
				Mem_Cpy((byte*)szMsg+9-len, (byte*)szBuf, len  );
				Str_Cat(sztmp, szMsg );
				g_Line_Print(list, sztmp,"","",LEFT,0);
			};
			
	Finally4:
			//sql->Commit(sql);
			DelSqLite(sql);	

			list->append(list, "--------------------------------");
			tot = Str_AtoI(stMw.szOnce_account);
			i = tot*10/110;
			tot = tot-i;
			
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "  �� ��   �� �� :  ");
			Str_ItoA( tot, szBuf ,10 );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 7 );
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			len = Str_Len(szBuf);
			Mem_Cpy((byte*)szMsg+7-len, (byte*)szBuf, len  );
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "��");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "  ��    ��   �� :  ");
			Str_ItoA( i, szBuf ,10 );
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 7 );
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			len = Str_Len(szBuf);
			Mem_Cpy((byte*)szMsg+7-len, (byte*)szBuf, len  );
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "��");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "  ���� ö�ź�� :  ");
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			Mem_Set( (byte*)szMsg, 0x20, 7 );
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Str_Cat( szBuf, stMw.szOnce_account);
			Str_Chg( szBuf, STRCHG_INS_COMMA );
			len = Str_Len(szBuf);
			Mem_Cpy((byte*)szMsg+7-len, (byte*)szBuf, len  );
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, "��");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_Cat(sztmp, "ó������ :  ");
			Str_ItoA(Time_GetDate(), szBuf, 10);
			g_Str_DateType( szMsg, szBuf);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, " ");
			g_Line_Print(list, sztmp,"","",LEFT,0);			
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
			Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
			Str_Cat(sztmp, "���α��� :  ");
			Str_ItoA(Time_DateUpDown( Time_GetDate(), 3), szBuf, 10);
			g_Str_DateType( szMsg, szBuf);
			Str_Cat(sztmp, szMsg);
			Str_Cat(sztmp, " ");
			g_Line_Print(list, sztmp,"","",LEFT,0);			
			
			list->append(list, "--------------------------------");
			list->append(list, "�Աݰ��¾ȳ�                    ");
			list->append(list, "--------------------------------");
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cat(sztmp, "�� �� �� : ");
			Str_Cat(sztmp, stUserinfo.szonce_bnk_nm);
			g_Line_Print(list, sztmp,"","",LEFT,0);			
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cat(sztmp, "���¹�ȣ : ");
			Str_Cat(sztmp, stUserinfo.szonce_account_num);
			g_Line_Print(list, sztmp,"","",LEFT,0);			
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cat(sztmp, "�� �� �� : ");
			Str_Cat(sztmp, stUserinfo.szonce_depositor_nm);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			list->append(list, "�Ա��� �����ͷ� ���� �ٶ��ϴ�.");
			list->append(list, "(������ �߻��� ���κδ�)        ");
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cat(sztmp, "���ﵵ�ð���");
			Str_Cat(sztmp, stUserinfo.szcenter_nm);
			Str_Cat(sztmp, " ����Ÿ");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cat(sztmp,  stUserinfo.sztel );
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			if(jdx == 0)
			{
				list->append(list, "                                ");
				list->append(list, "[���� ǰ�� �����Ⱓ]          ");
				list->append(list, "1. ���ұ� ���� �ð� �� 2�� �̳� ");
				list->append(list, "   ��ǰ�̻� �߻� �� (���� ���  ");
				list->append(list, "   ��ǰ�� �ش� ����) �������� ��");
				list->append(list, "   �ð��� �帳�ϴ�.             ");
				list->append(list, "2. �Һ��� �����ǿ� ���� ǰ�� �� ");
				list->append(list, "   �� �� ���� �߸��� ���� ����, ");
				list->append(list, "   ��ǰ �����Ⱓ(2��)�� �����  ");
				list->append(list, "   �ű���ǰ�� ������ å���� ����");
				list->append(list, "   ������, �� �ð��� ���� ���");
				list->append(list, "   �� �δ��ϼž� �մϴ�.        ");
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, "�Һ��ڻ��� : ");
				Str_Cat(sztmp, stUserinfo.sztel );	
				g_Line_Print(list, sztmp,"","",LEFT,0);
				list->append(list, "--------------------------------");	
				list->append(list, "                                ");
				list->append(list, "                                ");
			}
			else
			{
				list->append(list, "                                ");
				list->append(list, "                                ");
			}
		}
		
		return list;
	}

	//------------------------------------------------------------------
	void* Print_Payed_GetData(void)
	{
		long ret, idx;
		char LineSpace[]={0x1b,0x20,0x00};
		char szBuf[300];
		char szMsg[300];
		char sztmp[300];
		char szFirstNm[20];
		char szLastNm[20];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;
		CARRAYLIST list = NULL;

		list = NewArrayList();
		if (list == NULL)
		{
			return NULL;
		}
			
		list->append(list, "--------------------------------");
		list->append(list, "      �����ǽð�(����)������    ");
		list->append(list, "--------------------------------");
		list->append(list, "       ���ﵵ�ð���(��)         ");
		list->append(list, "����� ������ ��â�� 281\n");
		list->append(list, "����� ��ȣ: 109-81-31605\n");
		//list->append(list, ("��ǥ�̻� : ���¹� ��\n");
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp ,"��ǥ�̻� : " );
		Str_Cat(sztmp ,stUserinfo.szScg_repre_nm );
		g_Line_Print(list, sztmp,"","",LEFT,0);		
		list->append(list, "��ȭ��ȣ : 1588-5788            ");
		list->append(list, "--------------------------------");
		
		sql = NewSqLite();
		
		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));
		Mem_Set((byte*)szFirstNm, 0x00, sizeof(szFirstNm));
		Mem_Set((byte*)szLastNm, 0x00, sizeof(szLastNm));
		if( Str_Len(stMw.szCust_nm) < 6 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
			
			Str_Cpy(szBuf, "�� �� �� : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "***");

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stMw.szCust_nm) > 4 && Str_Len(stMw.szCust_nm) < 8)
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+4, 2);
			
			Str_Cpy(szBuf, "�� �� �� : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "***");
			Str_Cat(szBuf, szLastNm);

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stMw.szCust_nm) > 6 && Str_Len(stMw.szCust_nm) < 10 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+6, 2);

			Str_Cpy(szBuf, "�� �� �� : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "******");
			Str_Cat(szBuf, szLastNm);

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		else if( Str_Len(stMw.szCust_nm) > 8 && Str_Len(stMw.szCust_nm) < 12 )
		{
			Mem_Cpy( (byte*)szFirstNm, (byte*)stMw.szCust_nm, 2);
			Mem_Cpy( (byte*)szLastNm, (byte*)stMw.szCust_nm+8, 2);

			Str_Cpy(szBuf, "�� �� �� : ");
			Str_Cat(szBuf, szFirstNm);
			Str_Cat(szBuf, "******");
			Str_Cat(szBuf, szLastNm);

			g_Line_Print(list, szBuf,"","",LEFT,0);
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Cpy( (byte*)szBuf, (byte*)stMw.szUse_cont_num , 5);
		Mem_Cpy( (byte*)szMsg, (byte*)stMw.szUse_cont_num +5, 5);
		Str_Cpy(sztmp, "����ȣ : ");
		Str_Cat(sztmp, szBuf);
		Str_Cat(sztmp, "-");
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		list->append(list, "--------------------------------");
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, "�����ּ� : ");
		Str_Cat(sztmp, stMw.szCity);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stMw.szCounty);
		Str_Cat(sztmp, " ");
		Str_Cat(sztmp, stMw.szTown);
		if( Str_Len(stMw.szVillage_ri) > 0)
		{
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szVillage_ri);
		}
		
		if( Str_Len(sztmp) > 32)
		{
			ret = GetUtf8Size(sztmp,32);
			if( ret == 33)
			{
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
				g_Line_Print(list, szMsg,"","",LEFT,0);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Str_Cpy( szMsg,"           ");
				Str_Cat( szMsg, sztmp+31 );
				g_Line_Print(list, szMsg,"","",LEFT,0);
			}
			else
			{	
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
				g_Line_Print(list, szMsg,"","",LEFT,0);
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				Str_Cpy( szMsg,"           ");
				Str_Cat( szMsg, sztmp+32 );
				g_Line_Print(list, szMsg,"","",LEFT,0);
			}
		}
		else
		{
			g_Line_Print(list, sztmp,"","",LEFT,0);
		}
		
		if( Str_Len(stMw.szVillage) > 0 || Str_Len(stMw.szBuilding) > 0 )
		{
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "             ");
			Str_Cat(sztmp, stMw.szVillage);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szBuilding);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stMw.szHouse_cnt);
			if( Str_Len(sztmp) > 32 )
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg,"           ");
					Str_Cat( szMsg, sztmp+31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{	
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy( szMsg, "           ");
					Str_Cat( szMsg, sztmp+32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
		}
		else
		{
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "           ");
			Str_Cat(sztmp, stMw.szAddr1_m);
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stMw.szAddr1_s);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szHouse_cnt);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szEtc_addr);
			if(Str_Len(sztmp) > 32)
			{
				ret = GetUtf8Size(sztmp,32);
				if( ret == 33)
				{
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy(szMsg, "           ");
					Str_Cat( szMsg, sztmp+31 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
				else
				{	
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Mem_Cpy( (byte*)szMsg, (byte*)sztmp, 32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
					Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
					Str_Cpy(szMsg, "           ");
					Str_Cat( szMsg, sztmp+32 );
					g_Line_Print(list, szMsg,"","",LEFT,0);
				}
			}
			else
			{
				g_Line_Print(list, sztmp,"","",LEFT,0);
			}
		}
		
		if( Str_Len(stMw.szNew_road_nm) > 0 )
		{
			list->append(list, "--------------------------------");
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "���θ��ּ� : ");
			Str_Cat(sztmp, stMw.szCity);
			Str_Cat(sztmp, " ");
			Str_Cat(sztmp, stMw.szCounty );
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "             ");
			Str_Cat(sztmp, stMw.szNew_road_nm);
			g_Line_Print(list, sztmp,"","",LEFT,0);

			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, "             ");
			Str_Cat(sztmp, stMw.szNew_addr_m );
			Str_Cat(sztmp, "-");
			Str_Cat(sztmp, stMw.szNew_addr_s);
			g_Line_Print(list, sztmp,"","",LEFT,0);
		}
		
		list->append(list, "--------------------------------");
		list->append(list, "            ���γ���            ");
		list->append(list, "--------------------------------");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "SELECT  PARAM2, PARAM1, PARAM3 FROM RCV_RELEASE ORDER BY PARAM2 DESC " );
				
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

		while(sql->Next(sql) == TRUE)
		{
			idx = 0;
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)sztmp, 30, DECRYPT);
			g_Str_DateType(szBuf, sztmp);
			Str_Cpy(sztmp, "�Ա����� : ");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);			

			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)szBuf, 30, DECRYPT);
			Str_Cpy(sztmp, "�Ա����� : ");
			Str_Cat(sztmp, szBuf);
			g_Line_Print(list, sztmp,"","",LEFT,0);
			
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue(sql, idx++, 'U', (long*)szBuf, 5, DECRYPT);
			Str_Chg(szBuf, STRCHG_INS_COMMA);
			Str_Cpy(sztmp, "���αݾ� : ");
			Str_Cat(sztmp, szBuf);
			Str_Cat(sztmp, "��");
			g_Line_Print(list, sztmp,"","",LEFT,0);
			list->append(list, "--------------------------------");
		};
		
Finally:
		DelSqLite(sql);
		
		list->append(list, "��õ�ϴ��������������Ǵ¾�����ȭ");
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
		Str_Cat(sztmp, "�����Ͻ� : ");
		Str_ItoA(Time_GetDate(), szBuf, 10);
		g_Str_DateType( szMsg, szBuf);
		Str_Cat(sztmp, szMsg);
		Str_Cat(sztmp, " ");

		Mem_Set( (byte*) szBuf, 0x00, sizeof( szBuf) );
		Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
		//Str_ItoA(Time_GetTime(), szBuf, 10);
		g_Str_TimeType( szBuf , Time_GetTime());
		Str_Chg(szBuf, STRCHG_DEL_NONDIGIT);
		g_Str_TimeForm(szMsg, szBuf);
		Str_Cat(sztmp, szMsg);
		g_Line_Print(list, sztmp,"","",LEFT,0);
		list->append(list, "                                ");
		list->append(list, "                                ");
		return list;
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Cash_Mcpay
	��  �� : ���ݿ����� mcpay ����
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_Cash_Mcpay(void)
	{
		char sztmp[128];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long amt = 0;
		long vat = 0;
		long i;
		
		/************* ���ݿ����� ���� ***************/
		if(	Str_Len( stMw.szAppro_num ) == 0  )
		{
			// 1. ���� Validation
			if(Str_Len(stMw.szOnce_account) == 0 || Str_AtoI(stMw.szOnce_account) == 0)
			{
				MessageBoxEx (ERROR_OK, "�ݾ��� Ȯ���ϼ���.");
				return;
			}
			
			if(EditCtrl_GetStrLen( Get_hDlgCtrlByID(CMB_GUBUN )) == 0 )
			{
				MessageBoxEx (ERROR_OK, "�źе�Ϲ�ȣ�� �ŷ��� ������ Ȯ���ϼ���.");
				return;
			}
			
			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_CUSTINFO)) == 0 )
			{
				MessageBoxEx (ERROR_OK, "�ź� ��Ϲ�ȣ�� �Է����ּ���.");
				return;
			}
			
			// 2. ���� ���� Ȯ��
			if(MessageBoxEx (CONFIRM_YESNO, "���ݿ������� ��� �Ͻðڽ��ϱ�?") != MB_OK)
			{
				return;
			}
			
			// 3. ������ SET
			// 3-1. Amt
			Mem_Set( (byte*) stCashinfo.szAmt, 0x00, sizeof(stCashinfo.szAmt)  );
			Str_Cpy( stCashinfo.szAmt, stMw.szOnce_account );
			
			// 3-2. Vat
			Mem_Set( (byte*) stCashinfo.szVat, 0x00, sizeof(stCashinfo.szVat)  );
			amt = Str_AtoI( stMw.szOnce_account );
			vat = amt*10/110;
			Str_ItoA(vat , stCashinfo.szVat, 10);
			
			// 3-3. Promise_assign_seq
			Mem_Set( (byte*) stCashinfo.szPromise_assign_seq, 0x00, sizeof(stCashinfo.szPromise_assign_seq)  );
			Str_Cpy(stCashinfo.szPromise_assign_seq, stMw.szPromise_assign_seq );
			
			// 3-4. Use_cont_num
			Mem_Set( (byte*) stCashinfo.szUse_cont_num, 0x00, sizeof(stCashinfo.szUse_cont_num)  );
			Str_Cpy(stCashinfo.szUse_cont_num,       stMw.szUse_cont_num );
			
			// 3-5. Status_flag(�ŷ��ڱ���) : 0 = ����,1 = �����
			Mem_Set( (byte*) sztmp, 0x00, sizeof(sztmp)  );
			Mem_Set( (byte*) stCashinfo.szStatus_flag, 0x00, sizeof(stCashinfo.szStatus_flag)  );
			Str_Cpy(sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_GUBUN )) );
			i = SearchStr(sztmp, CASH_GBN );
			if (i > -1)
			{
				Str_Cpy(stCashinfo.szStatus_flag, CASH_GBN[i].Code);
			}
			
			// 3-6. Cust_info
			Mem_Set( (byte*) stCashinfo.szCust_info, 0x00, sizeof(stCashinfo.szCust_info)  );
			Str_Cpy( stCashinfo.szCust_info, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_CUSTINFO )) );
			
			// 3-7. Appro_sts
			Mem_Set( (byte*) stCashinfo.szAppro_sts, 0x00, sizeof(stCashinfo.szAppro_sts)  );
			Str_Cpy( stCashinfo.szAppro_sts, "1");
			
			// 3-8. Appro_ymd
			Mem_Set( (byte*) stCashinfo.szApproymd, 0x00, sizeof(stCashinfo.szApproymd)  );
			Mem_Set( (byte*) sztmp, 0x00, sizeof(sztmp)  );
			Str_ItoA( Time_GetDate(), sztmp, 10 );
			Str_Cpy(stCashinfo.szApproymd, sztmp+2);
			
			// 3-9. Treat_pda1, Treat_pda2, Treat_pda3
			Mem_Set( (byte*) stCashinfo.szTreat_pda1, 0x00, sizeof(stCashinfo.szTreat_pda1)  );
			Mem_Set( (byte*) stCashinfo.szTreat_pda2, 0x00, sizeof(stCashinfo.szTreat_pda2)  );
			Mem_Set( (byte*) stCashinfo.szTreat_pda3, 0x00, sizeof(stCashinfo.szTreat_pda3)  );
			
			fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda1, 1, Str_Len(stUserinfo.szpda_ip) );
			fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda2, 2, Str_Len(stUserinfo.szpda_ip) );
			fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda3, 3, Str_Len(stUserinfo.szpda_ip) );
			
			Snd_Cash_Hist(0);
		}
		/************* ���ݿ����� ��� ***************/
		else
		{
			if(MessageBoxEx (CONFIRM_YESNO, "���ݿ������� ��� �Ͻðڽ��ϱ�?") != MB_OK)
			{
				return;
			}

			Str_Cpy( stCashinfo.szAppronum, stMw.szAppro_num );	
			Str_Cpy( stCashinfo.szAppro_sts, "2");
			
			Mem_Set( (byte*) stCashinfo.szApproymd, 0x00, sizeof(stCashinfo.szApproymd)  );
			Mem_Set( (byte*) sztmp, 0x00, sizeof(sztmp)  );
			Str_ItoA( Time_GetDate(), sztmp, 10 );
			Str_Cpy(stCashinfo.szApproymd, sztmp+2);	
			
			Snd_Cash_Hist(2);
		}
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Cash_Hist
	��  �� : ���ݿ����� mcpay �̷�����
	Param  : flag  0 = ���νõ�, 1 = ���οϷ�, 2 = ��ҽõ�, 3 = ��ҿϷ�
	Return : 
	========================================================================================*/
	void Snd_Cash_Hist(long flag)
	{
		char sztmp[128];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long amt = 0;
		long vat = 0;
		long i;
				
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66806, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd"         , stUserinfo.szcenter_cd          );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq", stCashinfo.szPromise_assign_seq );
		
		if(flag == 0)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "1" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , ""   );
		}
		else if(flag == 1)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "2" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , stCashinfo.szAppronum );
			JSON_SetValue( g_pjcomm, 'C', "resp_cd"            , stCashinfo.szResp_cd );
		}
		else if(flag == 2)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "3" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , ""   );
		}
		else if(flag == 3)
		{
			JSON_SetValue( g_pjcomm, 'C', "item_flag"          , "4" );
			JSON_SetValue( g_pjcomm, 'C', "appro_num"          , stCashinfo.szAppronum );
			JSON_SetValue( g_pjcomm, 'C', "resp_cd"            , stCashinfo.szResp_cd );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stMw.szCivil_serv_receive_num );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num"        , stMw.szInst_place_num );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq"             , stMw.szTreat_seq );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda1"        	  , stCashinfo.szTreat_pda1 );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda2"        	  , stCashinfo.szTreat_pda2 );
		JSON_SetValue( g_pjcomm, 'C', "treat_pda3"        	  , stCashinfo.szTreat_pda3 );
		JSON_SetValue( g_pjcomm, 'C', "status_flag"       	  , stCashinfo.szStatus_flag);
		JSON_SetValue( g_pjcomm, 'C', "cust_info"         	  , stCashinfo.szCust_info  );
		JSON_SetValue( g_pjcomm, 'C', "amt"               	  , stCashinfo.szAmt        );
		JSON_SetValue( g_pjcomm, 'C', "appro_sts"         	  , stCashinfo.szAppro_sts  );
		JSON_SetValue( g_pjcomm, 'C', "cert_cd"           	  , stUserinfo.szcard_term_id2 );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		// ���� ��
		if(flag == 0 )
		{
			callBackfunc = TR66806_0;
		}
		// ��� ��
		else if(flag == 2)
		{
			callBackfunc = TR66806_1;
		}
		// ���
		else
		{
			callBackfunc = TR66806_2;
		}
		
		ret = HTTP_DownloadData(szUrl, "FR66806_IN",  "FR66806" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : TR66806_0
	��  �� : ���� �� �̷� ���� �� callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66806_0(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(66806) >= 0)
		{
			CloseMessageBox();
			Run_Mcpay(0);
			
			return 1;
		}
		else
		{
			CloseMessageBox();
			Run_Mcpay(0);
			
			return -1;
		}
	}
	/*=======================================================================================
	�Լ��� : TR66806_1
	��  �� : ��� �� �̷� ���� �� callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66806_1(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(66806) >= 0)
		{
			CloseMessageBox();
			Run_Mcpay(1);
			
			return 1;
		}
		else
		{
			CloseMessageBox();
			Run_Mcpay(1);
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : TR66806_2
	��  �� : ���� ��, ��� �� �̷� ���� �� callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR66806_2(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(66806) >= 0)
		{
			CloseMessageBox();
			
			MessageBoxEx (CONFIRM_OK, "ó���� �Ϸ� �Ǿ����ϴ�.");
				
			ON_EXIT();
			OnInit(INIT_MAIN);
			
			return 1;
		}
		else
		{
			CloseMessageBox();
			
			MessageBoxEx (CONFIRM_OK, "ó���� �Ϸ� �Ǿ����ϴ�.");
				
			ON_EXIT();
			OnInit(INIT_MAIN);
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Run_Mcpay
	��  �� : Mcpay Run
	Param  : flag : 0 = ����, 1 = ���
	Return : 
	========================================================================================*/
	void Run_Mcpay(long flag)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;
		char sztmp[50];
		char szDate[50];
		char receipt_YN[2];
		
		Mem_Set( (byte*)receipt_YN, 0x00, sizeof(receipt_YN) );
		// ������ �߱޹���
		if( MessageBoxEx (CONFIRM_YESNO, "���̿�������\n�����Ͻðڽ��ϱ�?")  == MB_OK)
		{						
			Str_Cpy(receipt_YN, "Y");		
		}
		else
		{
			Str_Cpy(receipt_YN, "N");		
		}
		
		PRINT("#### bussno #### : %s",stUserinfo.szbiz_regi_num,0,0);
		PRINT("#### totalprice #### : %s",stCashinfo.szAmt,0,0);
		PRINT("#### tax #### : %s",stCashinfo.szVat,0,0);
		PRINT("#### cashtradetype #### : %s",stCashinfo.szStatus_flag,0,0);
		PRINT("#### cashtradeinfo #### : %s",stCashinfo.szCust_info,0,0);
		PRINT("#### approvaldate #### : %s",stCashinfo.szApproymd,0,0);
		PRINT("#### approvalno #### : %s",stCashinfo.szAppronum,0,0);
		PRINT("#### vsno #### : %s",stUserinfo.szcard_term_id2,0,0);
		
		h = JSON_Create( JSON_Object );
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			if(flag == 0)
			{
				JSON_SetValue	(hdata	, 'C', "call"				, "cashAppr");
				JSON_SetValue	(hdata	, 'C', "desc"				, "���ݰ���");
				JSON_SetValue	(hdata	, 'C', "bussno"				, stUserinfo.szbiz_regi_num);
				JSON_SetValue	(hdata	, 'C', "type"				, "");
				JSON_SetValue	(hdata	, 'C', "receiptyn"			, receipt_YN);
				JSON_SetValue	(hdata	, 'C', "totalprice"			, stCashinfo.szAmt);
				JSON_SetValue	(hdata	, 'C', "tax"				, stCashinfo.szVat);
				JSON_SetValue	(hdata	, 'C', "svc"				, "0");
				JSON_SetValue	(hdata	, 'C', "inst"				, "0");
				JSON_SetValue	(hdata	, 'C', "printdata"			, "");
				JSON_SetValue	(hdata	, 'C', "approvaldate"		, "");
				JSON_SetValue	(hdata	, 'C', "approvalno"			, "");
				JSON_SetValue	(hdata	, 'C', "cashtradetype"		, stCashinfo.szStatus_flag);
				JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, stCashinfo.szCust_info);
				JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
				JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
				JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id2);
			}
			// ���ݿ����� ���
			else if(flag == 1)
			{
				JSON_SetValue	(hdata	, 'C', "call"				, "cashVoid");
				JSON_SetValue	(hdata	, 'C', "desc"				, "�������");
				JSON_SetValue	(hdata	, 'C', "bussno"				, stUserinfo.szbiz_regi_num);
				JSON_SetValue	(hdata	, 'C', "type"				, "");
				JSON_SetValue	(hdata	, 'C', "receiptyn"			, receipt_YN);
				JSON_SetValue	(hdata	, 'C', "totalprice"			, stCashinfo.szAmt);
				JSON_SetValue	(hdata	, 'C', "tax"				, stCashinfo.szVat);
				JSON_SetValue	(hdata	, 'C', "svc"				, "0");
				JSON_SetValue	(hdata	, 'C', "inst"				, "0");
				JSON_SetValue	(hdata	, 'C', "printdata"			, "");
				JSON_SetValue	(hdata	, 'C', "approvaldate"		, stCashinfo.szApproymd);	
				JSON_SetValue	(hdata	, 'C', "approvalno"			, stCashinfo.szAppronum);
				JSON_SetValue	(hdata	, 'C', "cashtradetype"		, stCashinfo.szStatus_flag);
				JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, stCashinfo.szCust_info);
				JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "1");
				JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
				JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id2);
			}

			JSON_SetValue	(h		, 'C', "method"				, "IC_CardPay");
			
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
		
		//Rcv_CashData_test();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_CashData
	��  �� : Rcv Mcpay Result Data 
	Param  : szCashData : OnTask �Լ��� ���� ���� ��� ������
	Return : 
	========================================================================================*/
	void Rcv_CashData(char* szCashData)
	{
		char szTmp[300];
		char szType[2] = {0,0};
		handle hItem = NULL;
		handle hData = NULL;
		
		hItem = JSON_Create( JSON_Object );
		
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szCashData );
			
			if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "null") == 0 )
			{
				Mem_Set( (byte*)stCashinfo.szResp_cd, 0x00, sizeof(stCashinfo.szResp_cd) );
				Str_Cpy( stCashinfo.szResp_cd, "0000" );
				
				// ����ΰ��
				if( Str_Len( stMw.szAppro_num) > 0 )
				{
				    Mem_Set( (byte*)stMw.szAppro_num, 0x00, sizeof(stMw.szAppro_num) );
				    Mem_Set( (byte*)stMw.szAppro_tel, 0x00, sizeof(stMw.szAppro_tel) );
				    Mem_Set( (byte*)stMw.szAppro_gubun, 0x00, sizeof(stMw.szAppro_gubun) );
				    Mem_Set( (byte*)stMw.szAppro_status_flag, 0x00, sizeof(stMw.szAppro_status_flag) );
				    
				    Mem_Set( (byte*)stCashinfo.szAppronum, 0x00, sizeof(stCashinfo.szAppronum) );
					Str_Cpy( stCashinfo.szAppronum, JSON_GetValue(hItem, "approvalno", szType) );
					
				    Save_ApproCash();
				    Snd_Cash_Hist(3);
				}
				else
				{	
					Mem_Set( (byte*)stMw.szAppro_num, 0x00, sizeof(stMw.szAppro_num) );
					Mem_Set( (byte*)stMw.szAppro_tel, 0x00, sizeof(stMw.szAppro_tel) );
				    Mem_Set( (byte*)stMw.szAppro_gubun, 0x00, sizeof(stMw.szAppro_gubun) );
				    Mem_Set( (byte*)stMw.szAppro_status_flag, 0x00, sizeof(stMw.szAppro_status_flag) );
					
					Str_Cpy( stMw.szAppro_num, JSON_GetValue(hItem, "approvalno", szType) );
					
				    Mem_Set( (byte*)stCashinfo.szAppronum, 0x00, sizeof(stCashinfo.szAppronum) );
					Str_Cpy( stCashinfo.szAppronum, JSON_GetValue(hItem, "approvalno", szType) );
					
					Str_Cpy( stMw.szAppro_tel, stCashinfo.szCust_info );
					
					Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
					Str_ItoA( m_lradgbn_flag, szTmp, 10 );
					Str_Cpy( stMw.szAppro_gubun, szTmp );
					
					Str_Cpy( stMw.szAppro_status_flag, stCashinfo.szStatus_flag );
					
					Save_ApproCash();
				    Snd_Cash_Hist(1);
				}		
			}
			else
			{	
				Mem_Set( (byte*)stCashinfo.szResp_cd, 0x00, sizeof(stCashinfo.szResp_cd) );
				Str_Cpy( stCashinfo.szResp_cd, JSON_GetValue (hItem, "resultcode",  		szType) );
				
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy( szTmp, "ERROR_CODE[");
				Str_Cat( szTmp, JSON_GetValue (hItem, "resultcode",  		szType));
				Str_Cat( szTmp, "]");
				Str_Cat( szTmp, "\n");
				Str_Cat( szTmp, JSON_GetValue (hItem, "resultmsg",  		szType));
				
				MessageBoxEx (ERROR_OK, szTmp);
				ON_DRAW();
			}
		}
		
		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
		
		g_Close_SubDlg();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Save_ApproCash
	��  �� : C6101_PROMISE_ASSIGN UPDATE / APPRO_NUM, APPRO_TEL [ ���ݿ����� ���� ]
	Param  : 
	Return : 
	========================================================================================*/
	void Save_ApproCash(void)
	{
		handle* sql;
		char * sqlstr = "";
		char szSql[300];

		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," UPDATE C6101_PROMISE_ASSIGN ");
		STRING_Append(sql," SET APPRO_NUM = '");
		STRING_Append(sql,  stMw.szAppro_num );
		STRING_Append(sql,"', APPRO_TEL = '");
		STRING_Append(sql,  stMw.szAppro_tel );
		STRING_Append(sql,"', APPRO_STATUS_FLAG = '");
		STRING_Append(sql,  stMw.szAppro_status_flag );
		STRING_Append(sql,"', APPRO_GUBUN = '");
		STRING_Append(sql,  stMw.szAppro_gubun );
		STRING_Append(sql,"' WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  g_szCHK_EXEC_NUM );
		STRING_Append(sql,"'");
		sqlstr = STRING_toString(sql);
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(sql);
	}
	
	
	void Rcv_CashData_test(void)
	{
		char szTmp[300];
		// ����ΰ��
		Mem_Set( (byte*)stCashinfo.szResp_cd, 0x00, sizeof(stCashinfo.szResp_cd) );
		Str_Cpy( stCashinfo.szResp_cd, "0000" );
		
		if( Str_Len( stMw.szAppro_num) > 0 )
		{
		    Mem_Set( (byte*)stMw.szAppro_num, 0x00, sizeof(stMw.szAppro_num) );
		    Mem_Set( (byte*)stMw.szAppro_tel, 0x00, sizeof(stMw.szAppro_tel) );
		    Mem_Set( (byte*)stMw.szAppro_gubun, 0x00, sizeof(stMw.szAppro_gubun) );
		    Mem_Set( (byte*)stMw.szAppro_status_flag, 0x00, sizeof(stMw.szAppro_status_flag) );
		    
		    Mem_Set( (byte*)stCashinfo.szAppronum, 0x00, sizeof(stCashinfo.szAppronum) );
			Str_Cpy( stCashinfo.szAppronum, "99999" );
			
		    Save_ApproCash();
		    Snd_Cash_Hist(3);
		}
		else
		{	
			Mem_Set( (byte*)stMw.szAppro_num, 0x00, sizeof(stMw.szAppro_num) );
			Mem_Set( (byte*)stMw.szAppro_tel, 0x00, sizeof(stMw.szAppro_tel) );
		    Mem_Set( (byte*)stMw.szAppro_gubun, 0x00, sizeof(stMw.szAppro_gubun) );
		    Mem_Set( (byte*)stMw.szAppro_status_flag, 0x00, sizeof(stMw.szAppro_status_flag) );
			
			Str_Cpy( stMw.szAppro_num, "99999" );
		    Str_Cpy( stMw.szAppro_tel, stCashinfo.szCust_info );
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Str_ItoA( m_lradgbn_flag, szTmp, 10 );
			Str_Cpy( stMw.szAppro_gubun, szTmp );
			
			Str_Cpy( stMw.szAppro_status_flag, stCashinfo.szStatus_flag );
			
			Str_Cpy( stMw.szAppro_tel, stCashinfo.szCust_info );
			
			Mem_Set( (byte*)stCashinfo.szAppronum, 0x00, sizeof(stCashinfo.szAppronum) );
			Str_Cpy( stCashinfo.szAppronum, "99999" );
			
			Save_ApproCash();
		    Snd_Cash_Hist(1);
		}
	}
	
	void Set_CashData(void)
	{
		char szSql[300];
		char szTmp[300];
		
		long amt, vat;
		long cnt = 0;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ," SELECT COUNT(1) FROM C6101_PROMISE_ASSIGN WHERE PROMISE_ASSIGN_SEQ = '%s' AND APPRO_NUM <> '' ", g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &cnt );

		if( cnt > 0)
		{
			// 3-1. Amt
			Mem_Set( (byte*) stCashinfo.szAmt, 0x00, sizeof(stCashinfo.szAmt)  );
			Str_Cpy( stCashinfo.szAmt, stMw.szOnce_account );
			
			// 3-2. Vat
			amt = Str_AtoI( stMw.szOnce_account );
			vat = amt*10/110;
			Str_ItoA(vat, stCashinfo.szVat, 10);
			
			// 3-3. Promise_assign_seq
			Str_Cpy(stCashinfo.szPromise_assign_seq, stMw.szPromise_assign_seq );
			
			// 3-4. Use_cont_num
			Str_Cpy(stCashinfo.szUse_cont_num, stMw.szUse_cont_num );
			
			// 3-5. Status_flag
			Str_Cpy( stCashinfo.szStatus_flag, stMw.szAppro_status_flag );
			
			// 3-6. Cust_info
			Str_Cpy( stCashinfo.szCust_info, stMw.szAppro_tel );
			
			// 3-7. Treat_pda1, Treat_pda2, Treat_pda3
			fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda1, 1, Str_Len(stUserinfo.szpda_ip) );
			fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda2, 2, Str_Len(stUserinfo.szpda_ip) );
			fsgetitem(stUserinfo.szpda_ip, stCashinfo.szTreat_pda3, 3, Str_Len(stUserinfo.szpda_ip) );
			
			// 3-8. GUBUN
			m_lradgbn_flag = Str_AtoI(stMw.szAppro_gubun);
		}
	}
	
	void Redraw_once(void)
	{
		char sztmp[128];
		char szSql[200];
		char szWhere[300];
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szWhere, 0x00, sizeof(szWhere) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );

		if( g_nWorkFlag == 620 || g_nWorkFlag == 690 )
		{
			Str_Cpy( szWhere, " AND A.ONCE_ITEM_CD IN( 'F00001','F00002') " );
		}
		else if(g_nWorkFlag == 640 )
		{
			Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
		}
		else if( g_nWorkFlag == 610 || g_nWorkFlag == 660 )
		{
			if(stUserinfo.szcenter_cd[0] == '4' )
		 	{
		 		if( stMw.szConn_yn[0] == 'Y' )
		 		{
		 			Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 AND A.ONCE_ITEM_CD != 'D00001'  OR  A.ONCE_ITEM_CD = 'E00001' ) " );
		 		}
		 		else if( stMw.szConn_yn[0] == 'N' )
		 		{
		 			Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0  OR A.ONCE_ITEM_CD IN ('D00001','E00001') ) " );
		 		}
		 		else
				{
					Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
				}
		 	}
		 	else
		 	{
		 		if( stMw.szConn_yn[0] == 'Y' )
		 		{
		 			Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 AND A.ONCE_ITEM_CD != 'B00002' AND A.ONCE_ITEM_CD != 'D00001' OR A.ONCE_ITEM_CD = 'E00001' ) " );
		 		}
		 		else if( stMw.szConn_yn[0] == 'N' )
		 		{
		 			Str_Cpy( szWhere, " AND A.ONCE_ITEM_CD = 'NO' " );
		 		}
		 		else
				{
					Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
				}
		 	}
		}
		else
		{
			if(Str_Len(stMw.szBar_yn) > 0)
			{
			 	if(stUserinfo.szcenter_cd[0] == '4' )
			 	{
			 		if( stMw.szConn_yn[0] == 'Y' )
			 		{
			 			Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 AND A.ONCE_ITEM_CD != 'D00001'  OR  A.ONCE_ITEM_CD = 'E00001' ) " );
			 		}
			 		else if( stMw.szConn_yn[0] == 'N' )
			 		{
			 			Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0  OR A.ONCE_ITEM_CD IN ('D00001','E00001') ) " );
			 		}
			 		else
					{
						Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
					}
			 	}
			 	else
			 	{
			 		if( stMw.szConn_yn[0] == 'Y' )
			 		{
			 			Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 AND A.ONCE_ITEM_CD != 'B00002' AND A.ONCE_ITEM_CD != 'D00001' OR A.ONCE_ITEM_CD = 'E00001' ) " );
			 		}
			 		else if( stMw.szConn_yn[0] == 'N' )
			 		{
			 			Str_Cpy( szWhere, " AND A.ONCE_ITEM_CD = 'NO' " );
			 		}
			 		else
					{
						Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
					}
			 	}
			}
			else
			{
				Str_Cpy( szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
			}
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)stMw.szOnce_account , 0x00, sizeof(stMw.szOnce_account ) );
		SPRINT(szSql, " SELECT SUM( A.ONCE_AMT ) FROM C6101_ONCE_INFO A WHERE  A.PROMISE_ASSIGN_SEQ = '%s' %s  ", g_szCHK_EXEC_NUM, szWhere, 0);
		g_Sql_RetStr( szSql, 10, stMw.szOnce_account );
	}
	
	bool Chk_prod_cardpay( void )
	{
		char sztmp[300];
		// PRINT("@@@@@@@@@@@@@@@@@@ : %s",stMtr.szProd_cd,0,0);
		// ��ǰ�ڵ� 40~49(����� ��ü), 79(���ۿ�) ī�� �����Ұ�
		if( Str_Cmp(stMtr.szProd_cd, "40") == 0 || Str_Cmp(stMtr.szProd_cd, "41") == 0 || Str_Cmp(stMtr.szProd_cd, "42") == 0 || Str_Cmp(stMtr.szProd_cd, "43") == 0 || Str_Cmp(stMtr.szProd_cd, "44") == 0
		 || Str_Cmp(stMtr.szProd_cd, "45") == 0 || Str_Cmp(stMtr.szProd_cd, "46") == 0 || Str_Cmp(stMtr.szProd_cd, "47") == 0 || Str_Cmp(stMtr.szProd_cd, "48") == 0 || Str_Cmp(stMtr.szProd_cd, "49") == 0
		 || Str_Cmp(stMtr.szProd_cd, "79") == 0 )
		{
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(sztmp, "��ǰ�� �����, ���ۿ��� ���\nī�� ������ �Ұ��մϴ�.\n���� ��ǰ�ڵ� : %s", stMtr.szProd_cd, 0, 0);
			MessageBoxEx (CONFIRM_OK, sztmp);
			return FALSE;
		}
		else
		{
			return TRUE;
		}
	}

	void Chk_Prod(void)
	{
	char szUrl[200];
	char szbuf[128];
	char* sndbuf;
	long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 64703, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "use_cont_num", stMtr.szUse_cont_num );
		JSON_SetValue( g_pjcomm, 'C', "prod_cd",      stMtr.szProd_cd );

		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR64703; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR64703_IN",  "FR64703" , sndbuf, szbuf );

	}

	long TR64703(void)
	{
		long ret = 0;
		char szSql[300];

		ret = Chk_Json_64703();
		
		g_Sock_Close();
		
		if( ret >= 0)
		{	
			// OnInit(INIT_MAIN);
  		    Card_Move("C6101_WSIGN");
			  ON_DRAW();
			return 1;
		}
		else
		{	
			Card_Move("C6101_WMTR");
			ON_DRAW();	
			
			return FALSE;

		}

	}

	long Chk_Json_64703(void)
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
		
		
		char *szRslt= NULL;
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 64703, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 64703, 0 );
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
			
			
			szRslt		= JSON_GetValue (g_pjcomm, "rslt", szType);
			
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
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SQL_ConvMbStr( szTmp, szRslt);
				
				Mem_Set((byte*) m_szTrans_info_rslt, 0x00, sizeof( m_szTrans_info_rslt) );
				Str_Cpy( m_szTrans_info_rslt, szTmp );
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
}




