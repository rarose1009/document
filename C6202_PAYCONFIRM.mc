/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6202_PAYCONFIRM
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
	#define USE_ON_SELECT
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_DEL )		//����
		DEF_BUTTON_ID ( BID_RCV )		//�ڷ����
		DEF_BUTTON_ID ( BID_ADDR )		//���� �ּ�
		DEF_BUTTON_ID ( BID_NADDR )		//���θ� �ּ�
		DEF_BUTTON_ID ( BID_QUICK_ADDR )	//�ּ� ��ũ�� ȣ��
		DEF_BUTTON_ID ( BID_UP )		//����������
		DEF_BUTTON_ID ( BID_DOWN )		//����������
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
//��ħ ����Ʈ
		DEF_OBJECT_ID ( TXT_PAGE )			//������
		DEF_OBJECT_ID ( TXT_DATA1 )			//�ּ�

		DEF_OBJECT_ID ( ID_TBLLIST )		// ���̺� ����Ʈ
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( CMB_DATA1 )
	END_OBJECT_ID()
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    7					// table�� �ళ��
	#define		COL 	    7					// table�� ������
	#define		GRID_H		(CHT+32)			// table �� ����
	#define		GRID_H_P	(CHT+48)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX	 			// table ����x��ǥ
	#define		MAXCHAR		201 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+255  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+200  	    //table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�ּ�",     	       CWD*19+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"ü���ݾ�",           CWD*15,    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����",     	       CWD*5+13,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"���ּ�",   	       CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"USE_CONT_NUM",       CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"SEQ",                CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"PROMISE_ASSIGN_SEQ", CWD*0,     EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};	
	
	#define INIT_MAIN	1
	
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
		char PDFPATH			 [256];
	}	OZDATA;

	OZDATA m_stOzData;
	
	//ozview body �ڵ�
	handle m_hBody = NULL;
	
	long m_lActiveIndex = -1;
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;		// �� ������
	long m_lstartidx = 0;
	long m_nActIndex = -1;		//���õ� row index
	long m_bFirst;
	long m_lPlanCnt = 0;
	
	char m_Title[30];
	char m_szCnt_page[20];		// ������ ǥ�� ����
	char m_szCobSel[20];
	char m_szQuickSql[1000];
	char m_szVisit_flag[5];
	char m_szUse_cont_num[20];
	char m_szpromise_assign_seq[20];
	char m_szSeq[20];

	bool REDRAW(void);
	void SetStyle(void);
	long FS_GetSrchTotCnt(void);
	void Set_Index(void); 	//������ ��� �ε��� ����
	void Get_Index(void); 	//���õ� ��� �ε��� �б�
	void SetBtnImg(void);
	long Rcv_Data(void);
	long TR82255(void);
	long Rcv_Info(void);
	long TR822552(void);
	void SetInfo(void);
	long Rcv_Plan(void);
	long TR822554(void);
	void SetPlan(void);
	void OzView(void);
	void SetJsonBody(SQLITE sql);
	void Rcv_OzData(char* OzData);
	long Snd_OzView(void);
	long TR822556(void);

	void OnList(quad lParam);
	void Grid_QuickList(void);
	
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
	
	// ���� ���̾�α�(����Ʈ)
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "����Ȯ�༭ ��󸮽�Ʈ"),
	
		DLG_BUTTON(STARTX,	 	STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+250,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(STARTX+500,  STARTY+65, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_QUICK_ADDR, "����\n��ũ��"),

		DLG_BUTTON(0,          STARTY+831, 250, 68, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL, "����"),
		DLG_BUTTON(STARTX+250, STARTY+831, 250, 68, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+500, STARTY+831, 250, 68, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),
		DLG_BUTTON(STARTX+750, STARTY+831, 250, 68, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "�ڷ����"),
		
		DLG_TEXT(STARTX,	   STARTY+135, 1000, 120, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),			//�⺻�ּ�

		DLG_TEXT(STARTX+750,    STARTY+65, 250, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/�������� , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	

		DLG_COMBO_LIST (STARTX, 	   STARTY+255, 495, 290, 150, 71, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
	};	
	

	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "����Ȯ�༭ ��󸮽�Ʈ"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", GID_PREV, ""),

		DLG_BUTTON(STARTX,	 	STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR, "�� ��"),
		DLG_BUTTON(STARTX+220,  STARTY+70, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NADDR, "���θ�"),
		DLG_BUTTON(0,          STARTY+825, 250, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL, "����"),
		DLG_BUTTON(STARTX+265, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, "��"),
		DLG_BUTTON(STARTX+480, STARTY+825, 200, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, "��"),
		DLG_BUTTON(STARTX+695, STARTY+825, 298, 70, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RCV, "�ڷ����"),
		
		DLG_TEXT(STARTX,	   STARTY+150, 985, 100, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),			//�⺻�ּ�

		DLG_TEXT(STARTX+585,   STARTY+70, 400, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_page), 	//����������/�������� , BTNMENUFRCOLOR, BTNCTRLBKCOLOR
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	

		DLG_COMBO_LIST (STARTX, 	   STARTY+260, 495, 290, 150, 69, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 30),
	};

	//----------------------------------------------------------------------
	bool	main (quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);

		if (MsgType == MSG_EXTCTRL && wParam == EXTCTRL_LIST)
		{
			OnList(lParam);
		}
		
		return TRUE;
	}
	
//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
		long i, j, nRet = 0;
		char szTmp[200];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		i = lParam;
//PRINT(">>>>>> lParam : %d , i : %d",lParam,i,0);
		if( i > -1 )
		{
			g_Sql_SaveSeq( "SELECT ROWID FROM C6202_PAYCONFIRM ORDER BY TOWN, ADDR1_M", SREACH_FILE);

			g_nActIndex = lParam;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			SPRINT(szTmp, "SELECT VISIT_FLAG FROM C6202_PAYCONFIRM WHERE ROWID = '%d'", g_lindex, 0, 0);
			g_Sql_RetStr(szTmp, 5, m_szVisit_flag);
			
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				nRet = -1;
				goto Finally;
			}

			hstmt = sql->CreateStatement(sql, "SELECT VISIT_FLAG, USE_CONT_NUM, PROMISE_ASSIGN_SEQ FROM C6202_PAYCONFIRM WHERE ROWID = ?");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				nRet = -1;
				goto Finally;
			}

			sql->Bind(sql, 0, 'X', &g_lindex, 4, DECRYPT);

			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				nRet = -1;
				goto Finally;
			}

			if(sql->Next(sql) == TRUE)
			{
				Mem_Set((byte*)m_szVisit_flag, 0x00, sizeof(m_szVisit_flag));
				Mem_Set((byte*)m_szUse_cont_num, 0x00, sizeof(m_szUse_cont_num));
				Mem_Set((byte*)m_szpromise_assign_seq, 0x00, sizeof(m_szpromise_assign_seq));
				
				j = 0;
				sql->GetValue(sql, j++, 'U', (long*)m_szVisit_flag, 5, DECRYPT);
				sql->GetValue(sql, j++, 'U', (long*)m_szUse_cont_num, 20, DECRYPT);
				sql->GetValue(sql, j++, 'U', (long*)m_szpromise_assign_seq, 20, DECRYPT);

				nRet = 1;
			}
			else
			{
				nRet = -1;
				goto Finally;
			}

Finally:
			DelSqLite(sql);
			
			if( nRet < 0 )
			{
				return;
			}

			if( Str_Cmp(m_szVisit_flag, "Y") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "���� �Ϸ� ����Դϴ�.");
			}
			else
			{
				Rcv_Info();
			}
		}
		
		return;
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

				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "�ּ�", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "��ȣ", 0, ICON_NONE);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA1+2), "����", 0, ICON_NONE);

				g_nAddrFlag = 0;
				Mem_Set( (byte*)m_szCobSel, 0x00, sizeof(m_szCobSel));
				Str_Cpy(m_szCobSel, "�ּ�");
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_szCobSel);

				g_nAddrFlag = 0;
				SetBtnImg();
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
	
//��������������������������������������������������������������������������������������������
	void	OnTask(long nEvent, long nData)
	{
		char* szOzData;
		long nRet = 0;

		//PRINT("nEvent : %d , nData : %d",nEvent,nData,0);		
		if( nEvent == 1 )
		{
			//MessageBoxEx (CONFIRM_OK, "������!!!!!!!!!!!!");
			//�ý�����
			szOzData = (char*)System_GetResult((char*)&nRet);
			//g_Save_JsonFile(szOzData);
			Rcv_OzData(szOzData);
		}
	}

	//��������������������������������������������������������������������������������������������
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
					Str_Chg(m_stOzData.USE_CONT_NUM, STRCHG_DEL_NONDIGIT);
					
					Str_Cpy(m_stOzData.PROMISE_ASSIGN_SEQ, m_stPayInfo.PROMISE_ASSIGN_SEQ);
					Str_Cpy(m_stOzData.SEQ               , m_stPayInfo.SEQ);

					//�Է� �ּ� ����(����,���θ�,����)
					//ADDR_GB = 'N ' ���� X | 'Y' ���� O
					//ADDR_TYPE = 'Z' ���� | 'R' ���θ�
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_Cpy(szTmp           , JSON_GetValue (hData, "pmSuretyaddr", szType));
//PRINT("ozdata addr : %s",szTmp,0,0);
//PRINT("basic addr : %s",m_stPayInfo.ADDR_UNION,0,0);
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
							if( Str_Len(szTmp) > 7 )
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
							if( Str_Len(szTmp) > 6 )
							{
								Mem_Cpy((byte *)m_stOzData.NEW_ADDR_UNION, (byte *)szTmp+6, Str_Len(szTmp)-6);
							}
							else
							{
								Str_Cpy(m_stOzData.NEW_ADDR_UNION, szTmp);
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
					if( FFS_Exist(szBuf) )
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

//��������������������������������������������������������������������������������������������
	void	OnSelect(long Index)
	{
		long index = -1;
		char szMsg[100];
		char szcmb[20];
		char sztmp[200];
		
		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				
				// ���� �ε����� ���� �ε����� ���� �� ���
				if ( index-1 == m_nActIndex )
				{
					//���õ� ������ ��ġ INDEX�� �۷ι������� ����
					g_nActIndex = m_lpage*ROW + m_nActIndex;
					g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

					if( Str_Cmp(m_szVisit_flag, "Y") == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "���� �Ϸ� ����Դϴ�.");
					}
					else
					{
						Rcv_Info();
					}
					return;
				}
				else
				{
					m_nActIndex = index - 1;//���õ� INDEX ����

					//m_szVisit_flag
					Mem_Set( (byte*)m_szVisit_flag, 0x00, sizeof(m_szVisit_flag));
					Str_Cpy(m_szVisit_flag, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2));
					//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
					Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
					//use_cont_num
					Mem_Set( (byte*)m_szUse_cont_num, 0x00, sizeof(m_szUse_cont_num));
					Str_Cpy( m_szUse_cont_num, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
					//seq
					Mem_Set( (byte*)m_szSeq, 0x00, sizeof(m_szSeq));
					Str_Cpy( m_szSeq, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
					//promise_assign_seq
					Mem_Set( (byte*)m_szpromise_assign_seq, 0x00, sizeof(m_szpromise_assign_seq));
					Str_Cpy( m_szpromise_assign_seq, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
				}
			}
			else
			{
				Mem_Set((byte*)szcmb, 0x00, sizeof(szcmb));
				Str_Cpy( szcmb ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1) ) );
				//�޺��ڽ� �������� ����Ʈ ��� ���͸�.(��ħ,�̰�ħ,��ü���)
				if( Str_Cmp(m_szCobSel, szcmb ) != 0 )
				{
					Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
					SPRINT(szMsg, "�׸��� %s�� �����Ͻðڽ��ϱ�?", szcmb, 0, 0);
					if( MessageBoxEx (CONFIRM_YESNO, szMsg)  == MB_OK)
					{
						Str_Cpy(m_szCobSel, szcmb);
						
						REDRAW();
					}
					else
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), m_szCobSel);
					}
				}
				else
				{
					REDRAW();
				}
			}
		}
	}
	
//-----------------------------------------------------------------
	void	SetStyle(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA1), TRUE, 2, EDITSEP_NONE );
	}


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		char szSql[300];
	
		switch(ID)
		{
			case BID_QUICK_ADDR:
				Grid_QuickList();
				break;
			case BID_RCV:
				Rcv_Data();
				break;
			case BID_DEL:
				if(m_lTotpage > 0 && m_nActIndex > -1)
				{
					if( MessageBoxEx (CONFIRM_YESNO, "����� �����Ͻðڽ��ϱ�?")  == MB_OK)
					{
						Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
						SPRINT(szSql, "DELETE FROM C6202_PAYCONFIRM PROMISE_ASSIGN_SEQ = '%s' AND USE_CONT_NUM = '%s' AND SEQ = '%s'", m_szpromise_assign_seq, m_szUse_cont_num, m_szSeq);		
						g_Sql_DirectExecute(szSql);
						REDRAW();
					}
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "����� �������ּ���.");
				}
				break;
			case BID_ADDR:
				g_nAddrFlag = 0;
				REDRAW();
				break;
			case BID_NADDR:
				g_nAddrFlag = 1;
				REDRAW();
				break;
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0)
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex = 0;
				REDRAW();
				break;			
			case BID_DOWN:
				m_lpage++ ;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}
					if(m_lTotpage > 0)
					{
						if( m_nActIndex < 0 )
						{
							m_nActIndex = 0;
						}
					
						DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
						DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);
					}
					break;
				}
				m_nActIndex = 0;
				REDRAW();
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
				Card_Move("C6202_MENU");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
		}
	}	

//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
	bool REDRAW(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		char sztmp[256];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		g_Sql_SaveSeq( "SELECT ROWID FROM C6202_PAYCONFIRM ORDER BY TOWN, ADDR1_M", SREACH_FILE);
		lTotPage = FS_GetSrchTotCnt();
		m_lTotpage = lTotPage;
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if( m_lIdxFlag == 0)
		{
			//���α׷� ���� �� �ҷ����� �ε���
			//Get_Index();
		}

		SPRINT(m_szCnt_page, "%d/%d , %d", m_lpage+1, m_lTotpage, lTotPage);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( g_nAddrFlag == 0)
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), TRUE );
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "����\n��ũ��");

			hstmt = sql->CreateStatement(sql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , PROMISE_TOT_AMT, VISIT_FLAG, CURR_ADDR_UNION, USE_CONT_NUM, FIRM_NM, CUST_NM, SEQ, PROMISE_ASSIGN_SEQ FROM C6202_PAYCONFIRM ORDER BY TOWN, ADDR1_M LIMIT ?, ?");
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_ADDR), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NADDR), FALSE );
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_QUICK_ADDR), "���θ�\n��ũ��");

			hstmt = sql->CreateStatement(sql, "SELECT CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END , PROMISE_TOT_AMT, VISIT_FLAG, NEW_ADDR_UNION, USE_CONT_NUM, FIRM_NM, CUST_NM, SEQ, PROMISE_ASSIGN_SEQ FROM C6202_PAYCONFIRM ORDER BY TOWN, ADDR1_M LIMIT ?, ?");
		}

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		m_lstartidx = m_lpage*ROW;
		sql->Bind(sql, idx++, 'X', &m_lstartidx, 4, DECRYPT);
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, "" );
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
					continue;
				}
				
				//�ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "�ּ�") == 0 )
				{
					sql->GetValue(sql, 0, 'U', (long*)sztmp, 200, DECRYPT);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "��ȣ") == 0 )
				{
					sql->GetValue(sql, 5, 'U', (long*)sztmp, 200, DECRYPT);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "����") == 0 )
				{
					sql->GetValue(sql, 6, 'U', (long*)sztmp, 200, DECRYPT);
				}
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				//ü���ݾ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 20, DECRYPT);
				Str_Chg(sztmp, STRCHG_INS_COMMA);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				//����
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 5, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				//���ּ�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 200, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				//USE_CONT_NUM
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				//SEQ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 7, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				//PROMISE_ASSIGN_SEQ
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 8, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 6, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);

		if(m_lTotpage > 0)
		{
			if( m_nActIndex < 0 )
			{
				m_nActIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_nActIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_nActIndex+1, TABLEACTIVE_COLOR);

			//m_szVisit_flag
			Mem_Set( (byte*)m_szVisit_flag, 0x00, sizeof(m_szVisit_flag));
			Str_Cpy(m_szVisit_flag, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 2));
			//ó�� ���õ� ����� �ּҸ� ��ܿ� ǥ��
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp));
			Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 3));
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), sztmp);
			//use_cont_num
			Mem_Set( (byte*)m_szUse_cont_num, 0x00, sizeof(m_szUse_cont_num));
			Str_Cpy( m_szUse_cont_num, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 4));
			//seq
			Mem_Set( (byte*)m_szSeq, 0x00, sizeof(m_szSeq));
			Str_Cpy( m_szSeq, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 5));
			//promise_assign_seq
			Mem_Set( (byte*)m_szpromise_assign_seq, 0x00, sizeof(m_szpromise_assign_seq));
			Str_Cpy( m_szpromise_assign_seq, DlgTbl_GetStr( ID_TBLLIST, m_nActIndex, 6));
			
			m_lIdxFlag = 1;
		}
		else
		{
			m_nActIndex = -1;
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA1), "");
		}

		ON_DRAW();		

		return TRUE;
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
	
	/*=======================================================================================
	�Լ��� : Set_Index
	��  �� : ���� �ε��� �����Ѵ�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Set_Index(void)
	{
		char szSql[101];
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE RCV_LOG SET PARAM9 =%d WHERE GUBUN = '9' ", g_lindex, 0, 0);		
		g_Sql_DirectExecute(szSql);
	}
	
	/*=======================================================================================
	�Լ��� : Get_Index
	��  �� : ���� �ε��� �о�´�.
	Param  : 
 	Return : TRUE :����
 			 FALSE:������ �����ÿ� ����
	========================================================================================*/
	void Get_Index(void)
	{
		long lParam9;
		
		g_Sql_RetInt("SELECT PARAM9 FROM RCV_LOG WHERE GUBUN = '9'", &lParam9);
		
		g_nActIndex = lParam9;		
		m_lpage = g_nActIndex / ROW;
		m_nActIndex = (g_nActIndex % ROW);
	}
	
//------------------------------------------------------------------------------------------
	long Rcv_Data(void)
	{
		char szNonpayManageZone[20];
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;

		g_Sql_DirectExecute("DELETE FROM C6202_PAYCONFIRM");

		Mem_Set((byte*)szNonpayManageZone, 0x00, sizeof(szNonpayManageZone));	
		g_Sql_RetStr("SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '9'", 10, szNonpayManageZone);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 82255, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        		stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_zone",     szNonpayManageZone );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR82255; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR82255_IN",  "FR82255" , sndbuf, sztmp );
		return 0 ;
	}
	
	
//------------------------------------------------------------------------------------------
	long TR82255(void)	
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(82255) >= 0)
		{
			g_Sql_RetInt("SELECT COUNT(*) FROM C6202_PAYCONFIRM", &ntotcnt);
			
			if(ntotcnt > 0 )
			{
				MessageBoxEx (CONFIRM_OK, "�ڷ������ �Ϸ��Ͽ����ϴ�.");
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "�ڷᰡ �����ϴ�.");
			}
			REDRAW();
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
	long Rcv_Info(void)
	{
		char szNonpayManageZone[20];
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;

		g_Sql_DirectExecute("DELETE FROM RCV_TMP");

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822552, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",           m_szUse_cont_num );
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq",     m_szpromise_assign_seq );
		JSON_SetValue( g_pjcomm, 'C', "seq",                    m_szSeq );
		JSON_SetValue( g_pjcomm, 'C', "type_flag",              "A" ); //��༭ �ۼ����� > A(�������Ȯ�༭), B(�������Ȯ�༭+�̻�����)
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR822552; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR822552_IN",  "FR822552" , sndbuf, sztmp );
		return 0 ;
	}
	
	
//------------------------------------------------------------------------------------------
	long TR822552(void)	
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(822552) >= 0)
		{
			Rcv_Plan();
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
	long Rcv_Plan(void)
	{
		char szNonpayManageZone[20];
		char sztmp[32];
		char szUrl[256];
		char* sndbuf;
		long ret;

		//RCV_RELEASE -> ü�� ������ TEMP ���̺�, ���������� ���� ���� ���� �̱⿡ ���� ���.
		g_Sql_DirectExecute("DELETE FROM RCV_RELEASE");

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822554, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",       m_szUse_cont_num );
		JSON_SetValue( g_pjcomm, 'C', "seq",                m_szSeq );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR822554; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR822554_IN",  "FR822554" , sndbuf, sztmp );
		return 0 ;
	}
	
	
//------------------------------------------------------------------------------------------
	long TR822554(void)	
	{
		long ntotcnt = 0;
	
		if( g_Chk_Json(822554) >= 0)
		{
			SetInfo();
			SetPlan();
			OzView();
			//MessageBoxEx (CONFIRM_OK, "���ż���");
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
  , PARAM28, PARAM29, PARAM30, PARAM31, PARAM32, PARAM33, PARAM34, PARAM35, PARAM36, PARAM37, PARAM38, PARAM39, PARAM40 FROM RCV_TMP" );
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;

		sql->Bind(sql, i++, 'U', (long*)&m_szUse_cont_num , 11, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
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
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.ZIP_SEQ              , 20, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.NEW_ADDR_BLD_SEQ     , 20, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_TYPE_GB      , 100, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_EMPID        , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_YMD          , 20 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPayInfo.PROMISE_TOT_AMT      , 20 , DECRYPT );
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}

Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		return;
	}
	
//------------------------------------------------------------------------------------------
//����Ȯ�� ��ȹ 
	void SetPlan(void)
	{
		long i, j;
		char szindex[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&m_stPayPlan, 0x00, sizeof(m_stPayPlan));
		g_Sql_RetInt("SELECT COUNT(*) FROM RCV_RELEASE", &m_lPlanCnt);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PARAM1, PARAM2, PARAM3, PARAM4, PARAM5, PARAM6, PARAM7, PARAM8 FROM RCV_RELEASE" );
		
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

		for(j = 0 ; j < m_lPlanCnt ; j++)
		{
			if(sql->Next(sql) == TRUE )
			{	
				i = 0;
				sql->GetValue( sql, i++, 'U', (long*) m_stPayPlan[j].USE_CONT_NUM      , 20, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) m_stPayPlan[j].SEQ               , 10, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) m_stPayPlan[j].PROMISE_PLAN_SEQ  , 10, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) m_stPayPlan[j].PROMISE_PLAN_REQ  , 50, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) m_stPayPlan[j].PROMISE_PLAN_AMT  , 50, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) m_stPayPlan[j].PROMISE_PLAN_YMD  , 20, DECRYPT );
			}
			else
			{
				PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
				goto Finally;
			}
		}

Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		return;
	}



//------------------------------------------------------------------------------------------
	void OzView(void)
	{
		handle hHeader = NULL;
		handle h = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		PRINT("OzView start", 0, 0, 0);
		
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
//PRINT("m_hBody : %s",JSON_toString(m_hBody),0,0);
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
		PRINT("OzView DelSqLite", 0, 0, 0);
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

	
//------------------------------------------------------------------------------------------
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
		
		// PROMISE_TYPE_GB Ȯ�༭ ���� ( �������� : 10, ���볳�� : 20 , ����༭�� �ƿ� �ٸ�)

		if(Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "10") == 0 )
		{
			//��༭ �ۼ����� > 1(�������Ȯ�༭) > �ο� �� , 2(�������Ȯ�༭+�̻�����) > �ο�
			//1 >> �������� ���� �Ұ� / ���� �Կ� ����
			//2 >> �������� ���� ���� / ���� �Կ� �Ұ�
			//3 >> �������� ���� ���� / ���� �Կ� ����
			JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "1");
			
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
			//JSON_SetValue	(m_hBody	, 'C', "pmPhone"			, szUseHpNum);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone1"			, m_stPayInfo.USE_CP_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone2"			, m_stPayInfo.USE_CP_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone3"			, m_stPayInfo.USE_CP_NUM);
			
			Mem_Set((byte*)szUseTelNum, 0x00, sizeof(szUseTelNum));	
			//SPRINT(szUseTelNum, "%s-%s-%s", m_stPayInfo.USE_OWNHOUSE_TEL_DDD, m_stPayInfo.USE_OWNHOUSE_TEL_EXN, m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			//JSON_SetValue	(m_hBody	, 'C', "pmTel"			    , szUseTelNum);
			JSON_SetValue	(m_hBody	, 'C', "pmTel1"			    , m_stPayInfo.USE_OWNHOUSE_TEL_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmTel2"			    , m_stPayInfo.USE_OWNHOUSE_TEL_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmTel3"			    , m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			
			
			//�ٵ� - ���ð��� �̳����� �� ��ȯ(��������) ��ȹ , m_lPlanCnt
			lAllAmt = 0;
			for(i = 0 ; i < m_lPlanCnt ; i++)
			{
				Mem_Set((byte*)szpmChargedate, 0x00, sizeof(szpmChargedate));	
				Mem_Set((byte*)szpmCost, 0x00, sizeof(szpmCost));	
				Mem_Set((byte*)szpmPaybackdate, 0x00, sizeof(szpmPaybackdate));	
				j = i+1;
				SPRINT(szpmChargedate, "pmChargedate%d",j,0,0);
				SPRINT(szpmCost, "pmCost%d",j,0,0);
				SPRINT(szpmPaybackdate, "pmPaybackdate%d",j,0,0);
				
				JSON_SetValue	(m_hBody	, 'C', szpmChargedate	, m_stPayPlan[i].PROMISE_PLAN_REQ);
				JSON_SetValue	(m_hBody	, 'C', szpmCost			, m_stPayPlan[i].PROMISE_PLAN_AMT);
				JSON_SetValue	(m_hBody	, 'C', szpmPaybackdate	, m_stPayPlan[i].PROMISE_PLAN_YMD);

				lAllAmt += Str_AtoI(m_stPayPlan[i].PROMISE_PLAN_AMT);
			}
			
			Mem_Set((byte*)szAllAmt, 0x00, sizeof(szAllAmt));
			Str_ItoA(lAllAmt, szAllAmt, 10);
			JSON_SetValue	(m_hBody	, 'C', "pmTotal"			, szAllAmt);
			
			
			//JSON_SetValue	(m_hBody	, 'C', "paCurrentdate1"			, "2017��04��19��");
	

			//�ٵ� - ������ �ͻ�κ��� ���ð����� ���޹޾� ~ Ȯ�༭�� �ۼ� �����մϴ�.
			JSON_SetValue	(m_hBody	, 'C', "pmGascost"			, m_stPayInfo.PROMISE_TOT_AMT);
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail1"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail2"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail3"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail4"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail5"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "paCurrentdate2"			, "2017��04��19��");

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
			//Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			//SPRINT(szTmp," CODE_ID = 'A10110' ORDER BY SORT_ORDER ",0,0,0);
			//JSON_SetValue	(m_hBody	, 'C', "pmSuretytelcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));
			
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
			
			JSON_SetValue	(m_hBody	, 'C', "pmUsename"		, m_stPayInfo.CUST_NM);
			
		}
		else if( Str_Cmp(m_stPayInfo.PROMISE_TYPE_GB, "20") == 0 )
		{
			//��༭ �ۼ����� > 1(���볳��Ȯ�༭), 2(���볳��Ȯ�༭+�̻�����)
			//1 >> �������� ���� �Ұ� / ���� �Կ� ����
			//2 >> �������� ���� ���� / ���� �Կ� �Ұ�
			//3 >> �������� ���� ���� / ���� �Կ� ����
			JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "1");

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
			//JSON_SetValue	(m_hBody	, 'C', "pmPhone"			, szUseHpNum);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone1"			, m_stPayInfo.USE_CP_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone2"			, m_stPayInfo.USE_CP_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone3"			, m_stPayInfo.USE_CP_NUM);
			
			Mem_Set((byte*)szUseTelNum, 0x00, sizeof(szUseTelNum));	
			//SPRINT(szUseTelNum, "%s-%s-%s", m_stPayInfo.USE_OWNHOUSE_TEL_DDD, m_stPayInfo.USE_OWNHOUSE_TEL_EXN, m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			//JSON_SetValue	(m_hBody	, 'C', "pmTel"			    , szUseTelNum);
			JSON_SetValue	(m_hBody	, 'C', "pmTel1"			    , m_stPayInfo.USE_OWNHOUSE_TEL_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmTel2"			    , m_stPayInfo.USE_OWNHOUSE_TEL_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmTel3"			    , m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			
			
			//�ٵ� - ���ð��� �̳����� �� ��ȯ(��������) ��ȹ , m_lPlanCnt
			lAllAmt = 0;
			for(i = 0 ; i < m_lPlanCnt ; i++)
			{
				Mem_Set((byte*)szpmChargedate, 0x00, sizeof(szpmChargedate));	
				Mem_Set((byte*)szpmCost, 0x00, sizeof(szpmCost));	
				Mem_Set((byte*)szpmPaybackdate, 0x00, sizeof(szpmPaybackdate));	
				j = i+1;
				SPRINT(szpmChargedate, "pmChargedate%d",j,0,0);
				SPRINT(szpmCost, "pmCost%d",j,0,0);
				SPRINT(szpmPaybackdate, "pmPaybackdate%d",j,0,0);
				
				JSON_SetValue	(m_hBody	, 'C', szpmChargedate	, m_stPayPlan[i].PROMISE_PLAN_REQ);
				JSON_SetValue	(m_hBody	, 'C', szpmCost			, m_stPayPlan[i].PROMISE_PLAN_AMT);
				JSON_SetValue	(m_hBody	, 'C', szpmPaybackdate	, m_stPayPlan[i].PROMISE_PLAN_YMD);

				lAllAmt += Str_AtoI(m_stPayPlan[i].PROMISE_PLAN_AMT);
			}
			
			Mem_Set((byte*)szAllAmt, 0x00, sizeof(szAllAmt));
			Str_ItoA(lAllAmt, szAllAmt, 10);
			JSON_SetValue	(m_hBody	, 'C', "pmTotal"			, szAllAmt);
			
			
			//JSON_SetValue	(m_hBody	, 'C', "paCurrentdate1"			, "2017��04��19��");
	

			//�ٵ� - ������ �ͻ�κ��� ���ð����� ���޹޾� ~ Ȯ�༭�� �ۼ� �����մϴ�.
			JSON_SetValue	(m_hBody	, 'C', "pmGascost"			, m_stPayInfo.PROMISE_TOT_AMT);
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail1"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail2"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail3"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail4"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail5"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "paCurrentdate2"			, "2017��04��19��");

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
			//Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
			//SPRINT(szTmp," CODE_ID = 'A10110' ORDER BY SORT_ORDER ",0,0,0);
			//JSON_SetValue	(m_hBody	, 'C', "pmSuretytelcombo"			, g_SetOzComboData(sql, szTmp, szComboData, 0));

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
			
			JSON_SetValue	(m_hBody	, 'C', "pmUsename"		, m_stPayInfo.CUST_NM);
		}
		else
		{
			//��༭ �ۼ����� > 1(���Թο�), 2(��������), 3(���Ǻ���)
			JSON_SetValue	(m_hBody	, 'C', "pmWritetype"		, "1");
		
			//�ٵ� - ��������
			JSON_SetValue	(m_hBody	, 'C', "pmUsecontnum"		, m_stPayInfo.USE_CONT_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmName"			    , m_stPayInfo.USE_CUST_NM);
			JSON_SetValue	(m_hBody	, 'C', "pmBirthdate"		, "20170419");
			//JSON_SetValue	(m_hBody	, 'C', "pmSex"				, "M");
			//JSON_SetValue	(m_hBody	, 'C', "pmCorpname"			, m_stPayInfo.USE_FIRM_NM);
			//JSON_SetValue	(m_hBody	, 'C', "pmCorpno"			, "1111");
			
			
			//if( Str_Len(m_stPayInfo.NEW_ADDR_UNION) > 5 )
			//{
				//�⺻ ���θ��ּ� �Է�
			//	JSON_SetValue	(m_hBody	, 'C', "pmAddr"			    , m_stPayInfo.USE_NEW_ADDR_UNION);
			//}
			//else
			//{
				//���θ��ּ� ���� �� �����ּ� �Է�
			//	JSON_SetValue	(m_hBody	, 'C', "pmAddr"			    , m_stPayInfo.USE_CURR_ADDR_UNION);
			//}
			
			//JSON_SetValue	(m_hBody	, 'C', "pmVat"			    , "");
			//JSON_SetValue	(m_hBody	, 'C', "pmVatno"			, m_stPayInfo.USE_BIZ_REGI_NUM);
			
			
			Mem_Set((byte*)szUseTelNum, 0x00, sizeof(szUseTelNum));	
			//SPRINT(szUseTelNum, "%s-%s-%s", m_stPayInfo.USE_OWNHOUSE_TEL_DDD, m_stPayInfo.USE_OWNHOUSE_TEL_EXN, m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmTelcombo"			, "02,031,032,070");
			JSON_SetValue	(m_hBody	, 'C', "pmTel1"			    , m_stPayInfo.USE_OWNHOUSE_TEL_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmTel2"			    , m_stPayInfo.USE_OWNHOUSE_TEL_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmTel3"			    , m_stPayInfo.USE_OWNHOUSE_TEL_NUM);
			
			
			Mem_Set((byte*)szUseHpNum, 0x00, sizeof(szUseHpNum));	
			//SPRINT(szUseHpNum, "%s-%s-%s", m_stPayInfo.USE_CP_DDD, m_stPayInfo.USE_CP_EXN, m_stPayInfo.USE_CP_NUM);
			JSON_SetValue	(m_hBody	, 'C', "pmPhoneCombo"		, "010,011,016,017,019");
			JSON_SetValue	(m_hBody	, 'C', "pmPhone1"			, m_stPayInfo.USE_CP_DDD);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone2"			, m_stPayInfo.USE_CP_EXN);
			JSON_SetValue	(m_hBody	, 'C', "pmPhone3"			, m_stPayInfo.USE_CP_NUM);
			
			JSON_SetValue	(m_hBody	, 'C', "pmEmail1"			, "test");
			JSON_SetValue	(m_hBody	, 'C', "pmEmail2"			, "naver.com");
			JSON_SetValue	(m_hBody	, 'C', "pmEmailcombo"		, "daum.net,google.com,nate.com,naver.com");
			
			JSON_SetValue	(m_hBody	, 'C', "pmBilling"			, "LMS");
			//JSON_SetValue	(m_hBody	, 'C', "pmPayment"			, "ī���ڵ���ü");
			JSON_SetValue	(m_hBody	, 'C', "pmBankcombo"		, "��������,�츮����,��������,�ϳ�����,�������");
			JSON_SetValue	(m_hBody	, 'C', "pmBank"				, "�츮����");
			
			JSON_SetValue	(m_hBody	, 'C', "pmAcc"				, "111222333333");
			JSON_SetValue	(m_hBody	, 'C', "pmAccname"			, "ȫ�浿");
			JSON_SetValue	(m_hBody	, 'C', "pmAccbirthdate"		, "880505");
			JSON_SetValue	(m_hBody	, 'C', "pmAccphone1"		, "010");
			JSON_SetValue	(m_hBody	, 'C', "pmAccphone2"		, "3333");
			JSON_SetValue	(m_hBody	, 'C', "pmAccphone3"		, "4444");
			JSON_SetValue	(m_hBody	, 'C', "pmAccrelationcombo"	, "��,��,��,����");
			JSON_SetValue	(m_hBody	, 'C', "pmAccrelation"		, "��");
			
			JSON_SetValue	(m_hBody	, 'C', "pmAgentname"		, "ȫ�浿");
			JSON_SetValue	(m_hBody	, 'C', "pmAgentphone1"		, "010");
			JSON_SetValue	(m_hBody	, 'C', "pmAgentphone2"		, "1111");
			JSON_SetValue	(m_hBody	, 'C', "pmAgentphone3"		, "2222");
	

			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail1"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail2"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail3"			, "N");
			//JSON_SetValue	(m_hBody	, 'C', "pmAgreedetail4"			, "N");

			//JSON_SetValue	(m_hBody	, 'C', "paCurrentdate"			, "2017��04��19��");

			//JSON_SetValue	(m_hBody	, 'C', "pmCenter"				, "ȫ�浿");
		}
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
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 822556, FALSE);

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
		JSON_SetValue( g_pjcomm, 'C', "cust_nm",              szTmp                        );
		
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn",      m_stOzData.INFO_USE_AGREE_YN );
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn2",     m_stOzData.INFO_USE_AGREE_YN2);
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn3",     m_stOzData.INFO_USE_AGREE_YN3);
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn4",     m_stOzData.INFO_USE_AGREE_YN4);
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn5",     m_stOzData.INFO_USE_AGREE_YN5);

/*
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Cpy((byte *)szTmp, (byte *)m_stOzData.PDFPATH+8, Str_Len(m_stOzData.PDFPATH)-8);
		JSON_SetValue( g_pjcomm, 'C', "oz_file",     szTmp);
*/

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

		callBackfunc = TR822556; //��ſϷ� �Ŀ� ȣ�� �Լ�
		HTTP_DownloadData( szUrl, "FR822556_IN",  "FR822556" , sndbuf, szbuf );
		
		return 1;
	}
	
//------------------------------------------------------------------
	long TR822556(void)
	{
		char szSql[350];
	
		if(g_Chk_Json(822556) >= 0)
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			SPRINT(szSql, "UPDATE C6202_PAYCONFIRM SET VISIT_FLAG = 'Y' WHERE PROMISE_ASSIGN_SEQ = '%s' AND USE_CONT_NUM = '%s' AND SEQ = '%s'", m_szpromise_assign_seq, m_szUse_cont_num, m_szSeq);		
			g_Sql_DirectExecute(szSql);

			//��ȣȭ pdf ����
			if( FFS_Exist(m_stOzData.PDFPATH) )
			{
				FFS_Delete(m_stOzData.PDFPATH);
			}
			
			MessageBoxEx (CONFIRM_OK, "����Ȯ�༭ ���忡 �����Ͽ����ϴ�.");
			REDRAW();
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

	//---------------------------------------------------------------------------------------------------------------
	void Grid_QuickList(void)
	{
		handle h = NULL;
		handle hData = NULL;
		handle hHead = NULL;
		char key[32];
		char val[32];
		long i, j;
		long col_count;
		long col_height;
		long start_position;
		
		char col_name_Addr[5][32] = {"�ּ�", "ü���ݾ�", "����", "", ""};
		char col_name_Firm[5][32] = {"��ȣ", "ü���ݾ�", "����", "", ""};
		char col_name_Cust[5][32] = {"����", "ü���ݾ�", "����", "", ""};
		//�ʵ� ���� ����
		char col_weight[5][10] = {"3","1","2","0","0"};
		char col_align[5][10]  = {"left", "center", "center","", ""};
		
		Mem_Set( (byte*)m_szQuickSql, 0x00, sizeof(m_szQuickSql) );
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "�ּ�") == 0 )
		{
			if( g_nAddrFlag == 0 )
			{
				Str_Cpy(m_szQuickSql, "SELECT \
CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 \
THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
ELSE IFNULL(ADDR1_M, '') ||'-'|| IFNULL(ADDR1_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END \
, PROMISE_TOT_AMT, VISIT_FLAG \
FROM C6202_PAYCONFIRM ORDER BY TOWN, ADDR1_M");
			}
			else
			{
				Str_Cpy(m_szQuickSql, "SELECT \
CASE WHEN LENGTH(TRIM(CO_LIVE_NM) ||''|| TRIM(BLD_NM)) > 0 \
THEN IFNULL(TRIM(CO_LIVE_NM), '') ||' '|| IFNULL(BLD_NM, '') ||'-'|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') \
ELSE IFNULL(NEW_ADDR_M, '') ||'-'|| IFNULL(NEW_ADDR_S, '') ||' '|| IFNULL(HOSU, '') ||' '|| IFNULL(DETAIL_FLOOR, '') END \
, PROMISE_TOT_AMT, VISIT_FLAG \
FROM C6202_PAYCONFIRM ORDER BY TOWN, ADDR1_M");
			}
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "��ȣ") == 0 )
		{
			Str_Cpy(m_szQuickSql, "SELECT FIRM_NM, PROMISE_TOT_AMT, VISIT_FLAG FROM C6202_PAYCONFIRM ORDER BY TOWN, ADDR1_M");
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "����") == 0 )
		{
			Str_Cpy(m_szQuickSql, "SELECT CUST_NM, PROMISE_TOT_AMT, VISIT_FLAG FROM C6202_PAYCONFIRM ORDER BY TOWN, ADDR1_M");
		}

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
			JSON_SetValue	(hData	, 'C', "list_position_save"	, "true");		//true/false
			
			col_count = 3;
			JSON_SetValue	(hData	, 'X', "col_count"			, &col_count);

			col_height = 250;
			JSON_SetValue	(hData	, 'X', "col_height"			, &col_height);

			start_position = m_lpage*ROW + m_nActIndex;
			JSON_SetValue	(hData	, 'X', "start_position"		, &start_position);
			
			JSON_SetValue	(hData	, 'C', "bind_type"	, "query");				//json or query
			JSON_SetValue	(hData	, 'C', "dbname"		, "APP_DBF/SCGGAS.db");
			
			JSON_SetValue	(hData	, 'C', "query", m_szQuickSql);
			
			hHead = JSON_Create( JSON_Array );
			if(hHead == NULL)
			{
				goto Finally;
			}		
	
			for (i=0; i<col_count; i++)
			{
				JSON_AddArrayItem(hHead);

				if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "�ּ�") == 0 )
				{
					JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name_Addr[i]);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "��ȣ") == 0 )
				{
					JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name_Firm[i]);
				}
				else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)), "����") == 0 )
				{
					JSON_SetArrayItem(hHead, 'C', "col_head"	, col_name_Cust[i]);
				}

				JSON_SetArrayItem(hHead, 'C', "col_weight"	, col_weight[i]);
				JSON_SetArrayItem(hHead, 'C', "col_align"	, col_align[i]);
			}
			
			JSON_Attach 	(hData	, "head"				, hHead);
			
			JSON_SetValue	(h		, 'C', "title"			, "����Ȯ�༭ ��󸮽�Ʈ");
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
}



