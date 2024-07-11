/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : C6101_GASCARD
	Card Desc : �ο� ���� ī�� ����
	Card Hist :
----------------------------------------------------------------------------------*/
card C6101_GASCARD
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
	#define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CARD_APPRO )		// ī�����
		DEF_BUTTON_ID ( BID_RECEIVE )  			// ������
		DEF_BUTTON_ID ( BID_UP )				// �׸��� UP
		DEF_BUTTON_ID ( BID_DOWN )				// �׸��� DOWN
		DEF_BUTTON_ID ( BID_BEFO )				// ����
		DEF_BUTTON_ID ( BID_NEXT )				// ����
		DEF_BUTTON_ID ( BID_CLOSE )				// �ݱ�
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// ī�峻���� ���� ��Ʈ�� ���̵� ����
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )				// Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )			// Ÿ��Ʋ
		DEF_OBJECT_ID ( ST_ADJ )				// ST ����ݾ�
		DEF_OBJECT_ID ( TXT_ADJ )				// TXT ����ݾ�
		DEF_OBJECT_ID ( TXT_PAGE )				// TXT �̳��ݾ����̺�PAGE
		DEF_OBJECT_ID ( ST_AMT )				// ST �����ݾ�
		DEF_OBJECT_ID ( TXT_AMT )				// TXT �����ݾ�
		DEF_OBJECT_ID ( ST_APPRO_RSLT )			// ST ���ΰ��
		DEF_OBJECT_ID ( TXT_APPRO_RSLT )		// TXT ���ΰ��
		DEF_OBJECT_ID ( ST_ALLOTMENT_MM  )      // �Һ�
		DEF_OBJECT_ID ( ID_TBLLIST )
		
		DEF_OBJECT_ID ( CMB_ALLOTMENT_MM  )     // �Һ��޺�
	END_OBJECT_ID()

	//---------------------------------------------------------------
	// �⺻���� DLGȭ�� ����
	//---------------------------------------------------------------
	
	#define INIT_MAIN		1
	
	long m_lpage = 0;			// ���� ������
	long m_lTotpage = 0;
	long m_lHist_Flag = 0;
	char m_sAllotment_mm[3];
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void GaspayDraw(void);
	void setCardRslt(void);
	void setReceiveRslt(void);
	long Save_ApproCard(void);
	void Save_ApproCancelCard(void);
	
	void Snd_CardHist(long flag);
	void Rcv_Mcpay(void);
	long TR67061(void);
	long TR67062(void);
	
	void Run_Mcpay(long i);
	void Rcv_CardData(char* szCardData);
	
	long SearchStr( char *Str, CodeTable *CT);
	long SearchCD( char *CD, CodeTable *CT);
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    5						// table�� �ళ��
	#define		COL 	    2						// table�� ������
	#define		GRID_H		(CHT+23)				// table �� ����
	#define		GRID_CLR	TRANSPARENT   			// table Ŭ���� color
	#define		GRID_X		STARTX 					// table ����x��ǥ
	#define		MAXCHAR		31 			    		// table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+CHT*2-40	        // table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table������ row�� Y��
	
	#define 	SYH			(CHT+10)
	#define 	Line(x)	    (GRID_ENDY2+5+SYH*(x-1))
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
	
	Column m_stGridTitle[] = {
		{"û�����", CWD*12, EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"�̳��ݾ�", CWD*28, EDITALIGN_RIGHT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
	};
	
	//---------------------------------------------------------------
	//	main entry map
	//---------------------------------------------------------------
	CARD_ENTRY_MAP()
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������� ī�� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_TEXT ( STARTX,     STARTY-29 , 300 , 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK  , ST_ADJ , "����ݾ�"),
		DLG_TEXT ( STARTX+300, STARTY-29 , 700 , 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_ADJ, ""),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_COL, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	
		
		DLG_TEXT ( STARTX    , STARTY+415, 300,  71, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, ""),
		
		DLG_BUTTON(STARTX+300, STARTY+417, 350 , 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP,  "��"),
		DLG_BUTTON(STARTX+650, STARTY+417, 350 , 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN,  "��"),
		
		DLG_TEXT ( STARTX,	   STARTY+488, 300 , 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_AMT, "�����ݾ�"),
		DLG_TEXT ( STARTX+300, STARTY+488, 700 , 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AMT, ""),
		
		DLG_TEXT ( STARTX,	   STARTY+553, 300 , 65, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_APPRO_RSLT, "���ΰ��"),
		DLG_TEXT ( STARTX+300, STARTY+553, 700 , 65, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_APPRO_RSLT, ""),
		
		DLG_TEXT ( STARTX,     STARTY+618, 300 , 70, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, ST_ALLOTMENT_MM , "�Һΰ���"),
		DLG_COMBO( STARTX+300, STARTY+618, 700 , 70, 189, 68, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_ALLOTMENT_MM, 3),
		
		DLG_BUTTON(STARTX,     STARTY+688, 1000, 72, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CARD_APPRO,  ""),
		DLG_BUTTON(STARTX,     STARTY+760, 1000, 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_RECEIVE,  ""),
		
		DLG_BUTTON(STARTX,     STARTY+830, 500 , 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BEFO,  "����"),	
		DLG_BUTTON(STARTX+500, STARTY+830, 500 , 70, 0, 0, 0, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXT,  "����"),	
	};

	//������������������������������������������������������������������������������
	//�� 				   ��	OnInit Function  ��  				              ��
	//������������������������������������������������������������������������������
	void OnInit(char bFirst)
	{
		CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
		SetBtnImg();
		SetStyle();
		ReDraw();
		GaspayDraw();
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
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}
	
	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		long i;
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_ADJ)		   , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ADJ)       , EDITALIGN_MIDDLE|EDITALIGN_RIGHT  );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE)      , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_AMT)        , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AMT)       , EDITALIGN_MIDDLE|EDITALIGN_RIGHT  );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_APPRO_RSLT) , EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_APPRO_RSLT), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(ST_ALLOTMENT_MM), EDITALIGN_MIDDLE|EDITALIGN_CENTER );
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), g_szGas_ApproRslt);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_APPRO_RSLT), TRUE, 3, EDITSEP_NONE );
		
		// �Һ��޺� ����
		for ( i = 0 ;  CK_CARDMM[i].Str[0] != 0 ; i++)
		{	
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_ALLOTMENT_MM+2), CK_CARDMM[i].Str, 0, ICON_NONE);
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
		long i = 0;
		char szSql[200];
		char szTmp[100];
		
		//����ī����� flag, = 0 ī�����, = 1 �������
		if(g_lGasCardFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CARD_APPRO), "ī�����");
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_RECEIVE), TRUE);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_CARD_APPRO), "�������");
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_RECEIVE), FALSE);
		}
		
		//���������� flag, = 0 ������, = 1 ������ ���
		if(g_lGasRecevieFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_RECEIVE), "������");
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_CARD_APPRO), TRUE);
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_RECEIVE), "������ ���");
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_CARD_APPRO), FALSE);
		}
		
		// �Һ��޺� ����
		if( Str_Len(m_sAllotment_mm) == 0 )
		{
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)m_sAllotment_mm, 0x00, sizeof(m_sAllotment_mm));
			
			SPRINT(szSql, "SELECT ALLOTMENT_MM FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_RetStr( szSql, 10, szTmp );
		
			if( Str_Len(szTmp) == 0 )
			{	
				Str_Cpy(m_sAllotment_mm, "00");
			}
			else
			{
				Str_Cpy(m_sAllotment_mm, szTmp);
			}
		}
		
		i = SearchCD( m_sAllotment_mm, CK_CARDMM );
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_ALLOTMENT_MM), CK_CARDMM[i].Str);
				
		// �ݾ��� 5���� �̻��� ��� �Һ� ����/ī�� ����, ������ ���Ѱ�츸 ��밡��
		if( Str_AtoI( stMw.szCard_gaspay ) >= 50000 && g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0)
		{

			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_ALLOTMENT_MM+1), TRUE );
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : OnTask
	��  �� : �ܺ� �� ����
	Param  : 
	Return : 
	========================================================================================*/ 
	void OnTask(long nEvent, long nData)
	{
		char* szCardData;
		long nRet = 0;
	
		if( nEvent == TASK_SYS_CALL )
		{
			if( nData == TASK_IC_CARD )
			{
				//�ý�����
				szCardData = (char*)System_GetResult((char*)&nRet);
				
				//�Ʒ� �ּ��� Ǯ�� ��� �����͸� json ���Ϸ� ���� �� �� ����(������ġ : smart/SND.json)
				//g_Save_JsonFile(szCardData);
		
				//��� ����
				Rcv_CardData(szCardData);
			}
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
		switch(ID)
		{
			case BID_CLOSE:
				/* ���� + ��ȸ�� */
				if(Str_AtoI(stMw.szCard_gaspay) > 0 || g_lOneCardPageFlag == 0 )
				{
					if( g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0 && g_lOneCardFlag == 0 && g_lOneRecevieFlag == 0 )
					{
						Card_Move("C6101_WPAY");
					}
					else
					{
						if( g_lGasCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "������� ī������� ����ϼ���");
						}
						else if (g_lGasRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "������� �������� ����ϼ���");
						}
						else if (g_lOneCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "��ȸ����� ī������� ����ϼ���");
						}
						else if (g_lOneRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "��ȸ����� �������� ����ϼ���");
						}
					}
				}
				/* ���� */
				else
				{
					if( g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0 )
					{
						Card_Move("C6101_WPAY");
					}
					else
					{
						if( g_lGasCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "������� ī������� ����ϼ���");
						}
						else if (g_lGasRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "������� �������� ����ϼ���");
						}
					}
				}
				break;
				
			case BID_CARD_APPRO:
				setCardRslt();
				break;
				
			case BID_RECEIVE:
				setReceiveRslt();
				break;
				
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
					break;
				}
				GaspayDraw();
				break;
						
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					break;
				}
				GaspayDraw();
				break;
			
			case BID_BEFO:
				/* ���� + ��ȸ�� */
				if(Str_AtoI(stMw.szCard_gaspay) > 0 || g_lOneCardPageFlag == 0)
				{
					if( g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0 && g_lOneCardFlag == 0 && g_lOneRecevieFlag == 0 )
					{
						Card_Move("C6101_WPAY");
					}
					else
					{
						if( g_lGasCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "������� ī������� ����ϼ���");
						}
						else if (g_lGasRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "������� �������� ����ϼ���");
						}
						else if (g_lOneCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "��ȸ����� ī������� ����ϼ���");
						}
						else if (g_lOneRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "��ȸ����� �������� ����ϼ���");
						}
					}
				}
				/* ���� */
				else
				{
					if( g_lGasCardFlag == 0 && g_lGasRecevieFlag == 0 )
					{
						Card_Move("C6101_WPAY");
					}
					else
					{
						if( g_lGasCardFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "������� ī������� ����ϼ���");
						}
						else if (g_lGasRecevieFlag == 1 )
						{
							MessageBoxEx (CONFIRM_OK, "������� �������� ����ϼ���");
						}
					}
				}
				break;

			case BID_NEXT:
				// ��ȸ�� ī������ �ִ� ���
				if(g_lOneCardPageFlag == 0)
				{
					Card_Move("C6101_ONECARD");
				}
				// ������ݸ� �ִ� ���
				else
				{	
					if( g_lGasCardFlag == 1 || g_lGasRecevieFlag == 1 )
					{
						Card_Move("C6101_WSIGN");
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "ī����� Ȥ�� �������� ���ּ���.");
					}
				}
				break;
		}
	}
	
	//----------------------------------------------------------------------
	//�Լ��� : SearchStr
	//��  �� : ��Ʈ������ �ڵ��ε����� ã�´�.
	//Param  : 
	//Return : �ڵ��ε���, ������ -1
	//----------------------------------------------------------------------
	long SearchStr( char *Str, CodeTable *CT)
	{
		long i;

		for ( i = 0 ; GM_CODE[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
				return i;
		}
		
		return -1;
	}
	
	//----------------------------------------------------------------------
	//�Լ��� : SearchCD
	//��  �� : �ڵ尪���� �ڵ��ε����� ã�´�.
	//Param  : 
	//Return : �ڵ��ε���, ������ -1
	//----------------------------------------------------------------------
	long SearchCD( char *CD, CodeTable *CT)
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
				return i;
		}
		return -1;
	}
	
	/*=======================================================================================
	�Լ��� : GaspayDraw
	��  �� : ����ݾ� && ������� ���̺� Setting && �����ݾ�
	Param  : 
	Return : 
	========================================================================================*/
	void GaspayDraw(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		long lstartidx;
		long account = 0;
		long amt = 0;
		long mtrCnt , nonPayCnt , amtChkYn;
		char sztmp[100];
		char szSql[300];
		char szbuf[51];
		char szCardChk[20];
		char * sqlstr1 = "";		
		bool ret = TRUE;	
		handle* sql1 = NULL;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		/* ����ݾ� */
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(szSql, "SELECT ACCOUNT FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1'", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &account);
		Str_ItoA( account, sztmp, 10 );
		Str_Chg( sztmp, STRCHG_INS_COMMA );
		Str_Cat(sztmp, "��");
		EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_ADJ ), sztmp );

		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// Mem_Set( (byte*)szCardChk, 0x00, sizeof(szCardChk) );
		// SPRINT(szSql, "SELECT ADJ_AMT_YN C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s'", g_szCHK_EXEC_NUM, 0, 0   );
		// g_Sql_RetStr( szSql, 9 , szCardChk );

		// if( Str_Cmp( szCardChk, "Y") == 0 )
		// {
		mtrCnt = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK_YN ='1' AND CARD_YN = '1'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &mtrCnt );

		nonPayCnt = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK ='1' AND CARD_YN = '1'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &nonPayCnt );
		
		amtChkYn = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK ='1' AND CARD_YN = '1' AND AMT_CHK_YN ='Y'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &amtChkYn );
		// }

		/* �����ݾ� */
		PRINT("amtChkYnamtChkYnamtChkYnamtChkYnamtChkYn :%d",amtChkYn,0,0);
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		if(amtChkYn > 0)
		{
			PRINT("AAAAAAAAAAAAAAAAAA",0,0,0);
			SPRINT(szSql, "SELECT SUM(AMT) AS AMT \
					     FROM ( SELECT CASE WHEN AMT_CHK_YN ='Y' THEN SUB_ACCOUNT WHEN AMT_CHK_YN ='N' THEN ACCOUNT END AS AMT FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1' \
							     UNION ALL \
							    SELECT SUM(SUB_UNPAY_AMT) AS AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1' AND AMT_CHK_YN ='Y')", g_szCHK_EXEC_NUM, g_szCHK_EXEC_NUM, 0);
		}
		else
		{
			PRINT("BBBBBBBBBBBBBBBBB",0,0,0);
			SPRINT(szSql, "SELECT SUM(AMT) AS AMT \
					     FROM ( SELECT CASE WHEN AMT_CHK_YN ='Y' THEN SUB_ACCOUNT WHEN AMT_CHK_YN ='N' THEN ACCOUNT END AS AMT FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1' \
							     UNION ALL \
							    SELECT SUM(UNPAY_AMT) AS AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1' AND IFNULL(AMT_CHK_YN,'N')  ='N')", g_szCHK_EXEC_NUM, g_szCHK_EXEC_NUM, 0);

		}
		
		g_Sql_RetInt(szSql, &amt);
		PRINT("szSqlszSqlszSqlszSql : %s",szSql,0,0);
		Str_ItoA( amt, sztmp, 10 );
		PRINT("amtamtamtamtamtamt : %d",amt,0,0);
		Str_Chg( sztmp, STRCHG_INS_COMMA );
		Str_Cat(sztmp, "��");
		PRINT("sztmpsztmpsztmpsztmp : %s",sztmp,0,0);
		EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_AMT ), sztmp );

		/* �̳��ݾ� PAGE */
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CARD_LIST_YN ='1'", g_szCHK_EXEC_NUM, 0, 0);
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

		/* �̳��ݾ� */
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		amtChkYn = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = '%s' AND CHK ='1' AND CARD_YN = '1' AND AMT_CHK_YN ='Y'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &amtChkYn );

		PRINT("00000000000000000000 : %d",amtChkYn,0,0);

		if(amtChkYn > 0)
		{
			PRINT("������� 111",0,0,0);
			hstmt = sql->CreateStatement(sql, "SELECT REQ_YM, SUB_UNPAY_AMT AS UNPAY_AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND CARD_LIST_YN = '1' ORDER BY REQ_YM DESC LIMIT ?, ?");
		}
		else
		{
			PRINT("������� 222",0,0,0);
			hstmt = sql->CreateStatement(sql, "SELECT REQ_YM, UNPAY_AMT FROM C6101_NONPAY WHERE PROMISE_ASSIGN_SEQ = ? AND CARD_LIST_YN = '1' ORDER BY REQ_YM DESC LIMIT ?, ?");
		}
		
		
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
				k = i + 1;
			}
			else
			{
				if(sql->Next(sql) == FALSE)
				{
					k = i + 1;
					DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 8, DECRYPT);
				g_Str_DateType(szbuf, sztmp);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, szbuf );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 10, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				Str_Cat( sztmp, "��" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
			}
		}
Finally:

		DelSqLite(sql);
		ON_DRAW();	
	}
	
	/*=======================================================================================
	�Լ��� : setCardRslt
	��  �� : ���ι�ư Ŭ���� ī����� ��� ������
	Param  : 
	Return : 
	========================================================================================*/
	void setCardRslt(void)
	{
		// g_lGasCardFlag ����ī����� flag, = 0 ī�����, = 1 �������
		// Snd_CardHist, = 1 : ī����� �õ�, = 2 : ī����� �Ϸ�, = 3 : ī����ҿϷ�, = 4 : ī����� �õ�
		if(g_lGasCardFlag == 0)
		{
			// ���� HIST ���
			Snd_CardHist(1);
		}
		else
		{
			// ���� HIST ���
			Snd_CardHist(4);
		}
	}
	
	/*=======================================================================================
	�Լ��� : setReceiveRslt
	��  �� : ������ ���� ��� ������
	Param  : 
	Return : 
	========================================================================================*/
	void setReceiveRslt(void)
	{
		handle* sql1 = NULL;
		handle* sql2 = NULL;
		char * sqlstr1 = "";
		char * sqlstr2 = "";
		char szSql[300];
		char szMtrnum[10];

		long gasnonpay = 0;
		long gasacconut = 0;
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT MTR_NUM FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s'", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetStr( szSql, 10, szMtrnum );

		//���������� flag, = 0 ������, = 1 ������ ���
		if(g_lGasRecevieFlag == 0)
		{
			// 1.����ݾ�
			sql1 = STRING_Create(sqlstr1);
			STRING_Empty(sql1);
			STRING_Append(sql1,"UPDATE C6101_PROMISE_MTR");
			STRING_Append(sql1,"   SET CHK_YN = '1'");
			STRING_Append(sql1,"     , CARD_YN = '0'");
			STRING_Append(sql1," WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql1, g_szCHK_EXEC_NUM );
			STRING_Append(sql1,"'  AND MTR_NUM = '");
			STRING_Append(sql1, szMtrnum );
			STRING_Append(sql1,"'  AND CARD_YN = '1'");
			sqlstr1 = STRING_toString(sql1);
			g_Sql_DirectExecute(sqlstr1);
			STRING_Finalize(sql1);
			
			// 2.�̳��ݾ�
			sql2 = STRING_Create(sqlstr2);
			STRING_Empty(sql2);
			STRING_Append(sql2,"UPDATE C6101_NONPAY");
			STRING_Append(sql2,"   SET CHK = '1'");
			STRING_Append(sql2,"     , CARD_YN = '0'");
			STRING_Append(sql2," WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql2, g_szCHK_EXEC_NUM );
			STRING_Append(sql2,"'  AND MTR_NUM = '");
			STRING_Append(sql2, szMtrnum );
			STRING_Append(sql2,"'  AND CARD_YN = '1'");
			sqlstr2 = STRING_toString(sql2);
			g_Sql_DirectExecute(sqlstr2);
			STRING_Finalize(sql2);
						
			Mem_Set( (byte*)stMw.szCash_gaspay, 0x00, sizeof(stMw.szCash_gaspay) );
			Str_Cpy(stMw.szCash_gaspay, stMw.szCard_gaspay);
			
			Mem_Set( (byte*)stMw.szCard_gaspay, 0x00, sizeof(stMw.szCard_gaspay) );
			Str_Cpy(stMw.szCard_gaspay, "0");

			MessageBoxEx (CONFIRM_OK, "��������� ������ ó���Ǿ����ϴ�.");
			g_lGasRecevieFlag = 1;
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "������ �Ϸ�");
			Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
			Str_Cpy(g_szGas_ApproRslt,"������ �Ϸ�");
		}
		else
		{	
			// 1.����ݾ�
			sql1 = STRING_Create(sqlstr1);
			STRING_Empty(sql1);
			STRING_Append(sql1,"UPDATE C6101_PROMISE_MTR ");
			STRING_Append(sql1,"   SET CARD_YN = '1' ");
			STRING_Append(sql1," WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql1, g_szCHK_EXEC_NUM );
			STRING_Append(sql1,"'  AND MTR_NUM = '");
			STRING_Append(sql1, szMtrnum );
			STRING_Append(sql1,"'  AND CHK_YN = '1'");
			STRING_Append(sql1,"   AND CARD_YN = '0'");
			sqlstr1 = STRING_toString(sql1);
			g_Sql_DirectExecute(sqlstr1);
			STRING_Finalize(sql1);

			// 2.�̳��ݾ�
			sql2 = STRING_Create(sqlstr2);
			STRING_Empty(sql2);
			STRING_Append(sql2,"UPDATE C6101_NONPAY ");
			STRING_Append(sql2,"   SET CARD_YN = '1' ");
			STRING_Append(sql2," WHERE PROMISE_ASSIGN_SEQ = '");
			STRING_Append(sql2, g_szCHK_EXEC_NUM );
			STRING_Append(sql2,"'  AND MTR_NUM = '");
			STRING_Append(sql2, szMtrnum );
			STRING_Append(sql2,"'  AND CHK = '1'");
			STRING_Append(sql2,"   AND CARD_YN = '0'");
			sqlstr2 = STRING_toString(sql2);
			g_Sql_DirectExecute(sqlstr2);
			STRING_Finalize(sql2);
			
			Mem_Set( (byte*)stMw.szCard_gaspay, 0x00, sizeof(stMw.szCard_gaspay) );
			Str_Cpy(stMw.szCard_gaspay, stMw.szCash_gaspay);
			
			Mem_Set( (byte*)stMw.szCash_gaspay, 0x00, sizeof(stMw.szCash_gaspay) );
			Str_Cpy(stMw.szCash_gaspay, "0");

			MessageBoxEx (CONFIRM_OK, "��������� ������ ��� ó���Ǿ����ϴ�.");
			g_lGasRecevieFlag = 0;
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "");
			Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
			Str_Cpy(g_szGas_ApproRslt,"");
		}
		
		ReDraw();
	}

	/*=======================================================================================
	�Լ��� : Save_ApproCard
	��  �� : C6101_PROMISE_CARD DB�� �����͸� ��´�. [ ī�� ���� ]
	Param  : 
	Return : 
	========================================================================================*/
	long Save_ApproCard(void)
	{
		long Cnt, idx;
		bool rtn = FALSE;
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NULL;

		Cnt = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql ,"SELECT COUNT(1) FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'",g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt(szSql, &Cnt );

		sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		if( Cnt > 0 )
		{

			hstmt = sql->CreateStatement(sql, "UPDATE C6101_PROMISE_CARD \
											      SET REQ_YMD = ?, RECEV_SEQ = ?, TERMINAL_NUM = ?, CARD_NUM = ?, VALID_YM = ? \
													, ALLOTMENT_MM = ?, DATA_FLAG = ?, ITEM_FLAG = ?, APPROVAL_AMT = ?, RSLT_CD = 'O' \
													, APPROVAL_NUM = ?, APPROVAL_TIME = ?, CARD_COM = ?, CARD_TYPE_NM = ?, BUYING_COMP = ? \
													, BUYING_COMP_NM = ?, UPD_EMPID = ?, UPD_IP = ? \
											    WHERE PROMISE_ASSIGN_SEQ = ? AND ITEM_FLAG = '10'");
	
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szReq_ymd       ,8  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szRecev_seq     ,3  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szTerminal_num  ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_num      ,128,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szValid_ym      ,4  ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szAllotment_mm  ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szData_flag     ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szItem_flag     ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_amt  ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_num  ,12 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_time ,14 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_com      ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_type_nm  ,50 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szBuying_comp   ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szBuying_comp_nm,50 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id   ,20 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip        ,15 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM           ,10 ,DECRYPT);
		}
		else
		{

			hstmt = sql->CreateStatement(sql, "INSERT INTO C6101_PROMISE_CARD \
											   ( PROMISE_ASSIGN_SEQ, CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, USE_CONT_NUM, ITEM_FLAG \
											   , REQ_YMD, RECEV_SEQ, TERMINAL_NUM, CARD_NUM, VALID_YM \
											   , ALLOTMENT_MM, APPROVAL_AMT, DATA_FLAG, APPROVAL_NUM, APPROVAL_TIME \
											   , CARD_COM, CARD_TYPE_NM, BUYING_COMP, BUYING_COMP_NM, UPD_EMPID \
											   , UPD_IP, RSLT_CD \
											   ) \
											   VALUES \
											   ( ?, ?, ?, ?, ? \
											   , ?, ?, ?, ?, ? \
											   , ?, ?, ?, ?, ? \
											   , ?, ?, ?, ?, ? \
											   , ?, 'O' ) ");

			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM                     ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCivil_serv_receive_num  ,14 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szTreat_seq               ,3  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szUse_cont_num            ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szItem_flag               ,2  ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szReq_ymd                 ,8  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szRecev_seq               ,3  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szTerminal_num            ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_num                ,128,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szValid_ym                ,4  ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szAllotment_mm            ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_amt            ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szData_flag               ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_num            ,12 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szApproval_time           ,14 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_com                ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szCard_type_nm            ,50 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szBuying_comp             ,2  ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stCardinfo.szBuying_comp_nm          ,50 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id             ,20 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip                  ,15 ,DECRYPT);

		}

		if(hstmt == NULL)
		{
			MessageBoxEx (ERROR_OK, "ī��������� ���忡 �����߽��ϴ�.");
			goto Finally;
		}
		else
		{
			if(sql->Execute(sql) == FALSE)
			{
				MessageBoxEx (ERROR_OK, "ī��������� ���忡 �����߽��ϴ�.");
				goto Finally;
			}
		}
		rtn = TRUE;

Finally	:
		//sql->Commit(sql);
		DelSqLite(sql);
		return rtn;
	}
	
	/*=======================================================================================
	�Լ��� : Save_ApproCancelCard
	��  �� : C6101_PROMISE_CARD DB�� �����͸� ��´�. [ ī�� ��� ]
	Param  : 
	Return : 
	========================================================================================*/
	void Save_ApproCancelCard(void)
	{
		handle* sql;
		char * sqlstr = "";
		char szSql[300];

		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," DELETE FROM C6101_PROMISE_CARD  ");
		STRING_Append(sql,"  WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  stCardinfo.szPromise_assign_seq );
		STRING_Append(sql,"'   AND ITEM_FLAG = '10' ");
		sqlstr = STRING_toString(sql);
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(sql);
	}
	
	/*=======================================================================================
	�Լ��� : Snd_CardHist
	��  �� : Snd_CardHist, = 1 : ī����� �õ�, = 2 : ī����� �Ϸ�, = 3 : ī����ҿϷ�, = 4 : ī����� �õ�
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_CardHist(long flag)
	{
		char szTmp[100];
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
		long nLen = 0;
		char szUcovert[100];
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		m_lHist_Flag = flag;
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		
		g_SeverConnection();	
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 66706, FALSE);
		
		// ī�� ���� �õ�, ī����� �õ�
		if(flag == 1 || flag == 4)
		{
			JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq"     , stMw.szPromise_assign_seq    	   );
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num" , stMw.szCivil_serv_receive_num     );
			JSON_SetValue( g_pjcomm, 'C', "treat_seq"			   , stMw.szTreat_seq  		   		   );
			JSON_SetValue( g_pjcomm, 'C', "item_flag"			   , "10"			   				   );
			JSON_SetValue( g_pjcomm, 'C', "terminal_num"		   , stUserinfo.szcard_term_id1		   );
			JSON_SetValue( g_pjcomm, 'C', "card_num"		       , "*"     			           	   );
		}
		// ī�� ���� �Ϸ�, ī�� ��� �Ϸ�
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq"     , stMw.szPromise_assign_seq         );
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num" , stMw.szCivil_serv_receive_num     );
			JSON_SetValue( g_pjcomm, 'C', "treat_seq"			   , stMw.szTreat_seq  		           );
			JSON_SetValue( g_pjcomm, 'C', "item_flag"			   , "10"			                   );
			JSON_SetValue( g_pjcomm, 'C', "rslt_cd"			       , "O"			   				   );
			JSON_SetValue( g_pjcomm, 'C', "terminal_num"		   , stCardinfo.szTerminal_num 		   );
			JSON_SetValue( g_pjcomm, 'C', "card_num"		       , stCardinfo.szCard_num			   );
			JSON_SetValue( g_pjcomm, 'C', "valid_ym"			   , stCardinfo.szValid_ym			   );
			JSON_SetValue( g_pjcomm, 'C', "allotment_mm"		   , stCardinfo.szAllotment_mm		   );
			
			JSON_SetValue( g_pjcomm, 'C', "card_com"		       , stCardinfo.szCard_com		       );
			JSON_SetValue( g_pjcomm, 'C', "buying_comp"		       , stCardinfo.szBuying_comp		   );
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SQL_ConvUcStr( szTmp, stCardinfo.szCard_type_nm );
			JSON_SetValue( g_pjcomm, 'C', "card_type_nm"		   , szTmp		   );
			
			Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
			SQL_ConvUcStr( szTmp, stCardinfo.szBuying_comp_nm );
			JSON_SetValue( g_pjcomm, 'C', "buying_comp_nm"		   , szTmp		   );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "approval_amt"		   , stMw.szCard_gaspay 		  		   );
		
		// ī����� �õ�
		if( flag == 1 )
		{
			JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "10"	 );	
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "1"     );	
		}
		// ī����� �Ϸ�
		else if( flag == 2 )
		{
			JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "10"	 );	
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "2"     );	
			JSON_SetValue( g_pjcomm, 'C', "approval_num"		   , stCardinfo.szApproval_num		   );
			JSON_SetValue( g_pjcomm, 'C', "approval_time"		   , stCardinfo.szApproval_time		   );
		}		
		// ī����� �Ϸ�
		else if( flag == 3 )
		{
			JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "20"	 );
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "3"     );	
			JSON_SetValue( g_pjcomm, 'C', "approval_cancel_num"	   , stCardinfo.szApproval_cancel_num     );	
			JSON_SetValue( g_pjcomm, 'C', "approval_cancel_date"   , stCardinfo.szApproval_cancel_date    );	
			
		}
		// ī����� �õ�
		else if( flag == 4 )
		{
			JSON_SetValue( g_pjcomm, 'C', "data_flag"			   , "20"	 );
			JSON_SetValue( g_pjcomm, 'C', "prcss_status"		   , "4"     );	
		}

		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		if(flag == 2 || flag == 3)
		{
			callBackfunc = TR67061;
		}
		else
		{
			callBackfunc = TR67062;
		}

		HTTP_DownloadData( szUrl, "FR66706_IN",  "FR66706" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : TR67061
	��  �� : ī�� ���� �� hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR67061(void)
	{
		g_Sock_Close();
		CloseMessageBox();
			
		if(g_Chk_Json(66706) >= 0)
		{
			if ( m_lHist_Flag == 3)
			{
				g_lGasCardFlag = 0;
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "�������");
				Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
				Str_Cpy(g_szGas_ApproRslt,"�������");
			}
			else
			{
				if( Save_ApproCard() ) 
				{
					g_lGasCardFlag = 1;
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "���οϷ�");
					Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
					Str_Cpy(g_szGas_ApproRslt,"���οϷ�");	
				}
				else
				{
					g_lGasCardFlag = 0;
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), "���ν��� : DB ERROR");
					Mem_Set( (byte*)g_szGas_ApproRslt, 0x00, sizeof(g_szGas_ApproRslt) );
					Str_Cpy(g_szGas_ApproRslt,"���ν��� : DB ERROR");
				}
			}
			
			ReDraw();
			
			return 1;
		}
		else
		{	
			ON_DRAW();
			
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : TR67061
	��  �� : ī�� ���� �� hist
	Param  : 
	Return : 
	========================================================================================*/
	long TR67062(void)
	{
		char szSql[350];
		
		g_Sock_Close();
		CloseMessageBox();
		
		if(g_Chk_Json(66706) >= 0)
		{
			Rcv_Mcpay();
			
			return 1;
		}
		else
		{
			ON_DRAW();
			
			return -1;
		}	
		
	}
	/*=======================================================================================
	�Լ��� : Rcv_Mcpay
	��  �� : Mcpay �۵� function
	Param  : 
	Return : 
	========================================================================================*/
	void Rcv_Mcpay(void)
	{
		// ����ī����� flag, = 0 ī�����, = 1 �������
		// Snd_CardHist, = 1 : ī����� �õ�, = 2 : ī����� �Ϸ�, = 3 : ī����ҿϷ�, = 4 : ī����� �õ�
		if(g_lGasCardFlag == 0)
		{
			Run_Mcpay(0);
		}
		else
		{
			Run_Mcpay(1);
		}

		ReDraw();
	}

	/*=======================================================================================
	�Լ��� : Run_Mcpay
	��  �� : Run_Mcpay Ȱ��ȭ
	Param  : 0 = ����, 1 = ���
	Return : 
	========================================================================================*/
	void Run_Mcpay(long i)
	{
		long ret = 0;
		handle h = NULL;
		handle hdata = NULL;
	
		char szSql[100];
		char szTmp[100];
		
		char card_receipt_YN[2];

		Mem_Set( (byte*)card_receipt_YN, 0x00, sizeof(card_receipt_YN) );
		// ������ �߱޹���
		if( MessageBoxEx (CONFIRM_YESNO, "ī�� ���� ���̿�������\n�����Ͻðڽ��ϱ�?")  == MB_OK)
		{						
			Str_Cpy(card_receipt_YN, "Y");		
		}
		else
		{
			Str_Cpy(card_receipt_YN, "N");		
		}
		
		h = JSON_Create( JSON_Object );
		
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			if(hdata == NULL)
			{
				goto Finally;
			}
			
			JSON_SetValue	(hdata	, 'C', "receiptyn"			, card_receipt_YN);
			
			// ����
			if( i == 0)
			{
				JSON_SetValue	(hdata	, 'C', "call"				, "creditAppr");
				JSON_SetValue	(hdata	, 'C', "desc"				, "�ſ����");
				JSON_SetValue	(hdata	, 'C', "bussno"				, "1098131605");
				JSON_SetValue	(hdata	, 'C', "type"				, "");
				JSON_SetValue	(hdata	, 'C', "totalprice"			, stMw.szCard_gaspay);
				JSON_SetValue	(hdata	, 'C', "tax"				, "0");
				JSON_SetValue	(hdata	, 'C', "svc"				, "0");

				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM)) );
				i = SearchStr( szTmp, CK_CARDMM );
				
				if (i > -1)
				{
					JSON_SetValue	(hdata	, 'C', "inst"		    , CK_CARDMM[i].Code);
					
					Mem_Set((byte*)m_sAllotment_mm, 0x00, sizeof(m_sAllotment_mm));
					Str_Cpy(m_sAllotment_mm, CK_CARDMM[i].Code);
				}
				
				JSON_SetValue	(hdata	, 'C', "printdata"			, "");
				JSON_SetValue	(hdata	, 'C', "approvaldate"		, "");
				JSON_SetValue	(hdata	, 'C', "approvalno"			, "");
				JSON_SetValue	(hdata	, 'C', "cashtradetype"		, "");
				JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, "");
				JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
				JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
				JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id1);
				
			}
			// ���
			else if( i == 1 )
			{
				JSON_SetValue	(hdata	, 'C', "call"				, "creditVoid");
				JSON_SetValue	(hdata	, 'C', "desc"				, "�ſ����");
				JSON_SetValue	(hdata	, 'C', "bussno"				, "1098131605");
				JSON_SetValue	(hdata	, 'C', "type"				, "");
				JSON_SetValue	(hdata	, 'C', "totalprice"			, stMw.szCard_gaspay);
				JSON_SetValue	(hdata	, 'C', "tax"				, "0");
				JSON_SetValue	(hdata	, 'C', "svc"				, "0");
				
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SPRINT(szSql, "SELECT ALLOTMENT_MM FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetStr( szSql, 10, szTmp );
				JSON_SetValue	(hdata	, 'C', "inst"				, szTmp);
				
				JSON_SetValue	(hdata	, 'C', "printdata"			, "");

				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SPRINT(szSql, "SELECT SUBSTR(APPROVAL_TIME,3,6) FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetStr( szSql, 10, szTmp );
				JSON_SetValue	(hdata	, 'C', "approvaldate"		, szTmp);
				
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				SPRINT(szSql, "SELECT APPROVAL_NUM FROM C6101_PROMISE_CARD WHERE PROMISE_ASSIGN_SEQ = '%s' AND ITEM_FLAG = '10'", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetStr( szSql, 10, szTmp );
				JSON_SetValue	(hdata	, 'C', "approvalno"			, szTmp);
				
				JSON_SetValue	(hdata	, 'C', "cashtradetype"		, "");
				JSON_SetValue	(hdata	, 'C', "cashtradeinfo"		, "");
				JSON_SetValue	(hdata	, 'C', "voidcashreason"		, "");
				JSON_SetValue	(hdata	, 'C', "verificationCode"	, "");
				JSON_SetValue	(hdata	, 'C', "vsno"				, stUserinfo.szcard_term_id1);
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
		return;
	
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_CardData
	��  �� : MCPAY RETRUN
	Param  : 
	Return : 
	========================================================================================*/ 
	void Rcv_CardData(char* szCardData)
	{
		char szTmp[500];
		char szBuf[256];
		char szRet[50];
		long fd, i = 0, j = 0, k = 0;
		long lFileLen = 0;
		long lRet = 0;
		long lCnt = 0;
		char *szitem;
		char *szData;
		long *nCol;
		long nCnt = 0;
		char szType[2] = {0,0};
		long ret = 0;
		handle hItem = NULL;
		handle hData = NULL;
	
		hItem = JSON_Create( JSON_Object );
		
		if( hItem != NULL)
		{
			JSON_toJson(hItem, szCardData ) ;

			Mem_Set((byte*)&stCardinfo, 0x00, sizeof(stCardinfo));

			if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "null") == 0 )
			{
				Str_ItoA( Time_GetDate(),  stCardinfo.szReq_ymd  , 10);
				Str_Cpy( stCardinfo.szPromise_assign_seq     , stMw.szPromise_assign_seq     				);
				Str_Cpy( stCardinfo.szCivil_serv_receive_num , stMw.szCivil_serv_receive_num 				);
				Str_Cpy( stCardinfo.szTreat_seq              , stMw.szTreat_seq              				);
				Str_Cpy( stCardinfo.szUse_cont_num           , stMw.szUse_cont_num           	   			);
				Str_Cpy( stCardinfo.szRecev_seq              , "001"                                    	);
				Str_Cpy( stCardinfo.szItem_flag     		 , "10"							                );
				Str_Cpy( stCardinfo.szTerminal_num  		 , JSON_GetValue(hItem, "tid",   	    szType) );
				Str_Cpy( stCardinfo.szApproval_amt 			 , JSON_GetValue(hItem, "totalamount", szType) );
				
				// �Һ�
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy( szTmp, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_ALLOTMENT_MM) ) );
				i = SearchStr( szTmp, CK_CARDMM );
				if ( i > -1 )
				{
					Str_Cpy( stCardinfo.szAllotment_mm, CK_CARDMM[i].Code );
				}

				Str_Cpy( stCardinfo.szCard_num		, JSON_GetValue (hItem, "cardno",   szType) );
				Str_Cpy( stCardinfo.szCard_type_nm	, JSON_GetValue (hItem, "cardname", szType) );
				Str_Cpy( stCardinfo.szValid_ym		, "0000" 						 			);
				
				if( g_lGasCardFlag == 0 )
				{
					Str_Cpy( stCardinfo.szData_flag 			 , "10" ); 	
					Str_Cpy( stCardinfo.szApproval_num			 , JSON_GetValue (hItem, "approvalno",	szType) );
					Str_Cpy( stCardinfo.szApproval_time			 , JSON_GetValue (hItem, "approvaldate",szType) );
				}
				else
				{
					Str_Cpy( stCardinfo.szData_flag 			 , "20" 	);
					Str_Cpy( stCardinfo.szApproval_cancel_num			 ,  JSON_GetValue (hItem, "approvalno",    	szType) );
					Str_Cpy( stCardinfo.szApproval_cancel_date			 ,  JSON_GetValue (hItem, "approvaldate",   szType) );
				}	

				Str_Cpy( stCardinfo.szCard_com				 , JSON_GetValue (hItem, "code2",    	szType) 						 );	
				Str_Cpy( stCardinfo.szBuying_comp			 , JSON_GetValue (hItem, "code1",    	szType)							 );
				Str_Cpy( stCardinfo.szBuying_comp_nm		 ,  JSON_GetValue (hItem, "purchasename",    	szType) );

				if( g_lGasCardFlag == 0 )
				{	
					Snd_CardHist(2);
				}
				else
				{
					Save_ApproCancelCard();
					Snd_CardHist(3);	
				}
			}
			else
			{
				if( Str_Cmp(JSON_GetValue (hItem, "resultcode", szType), "M016") == 0 )
				{
					Card_Move("C6101_WPAY");
					return;	
				}
				
				if( g_lGasCardFlag == 0 )
				{
					g_lGasCardFlag = 0;
					
					Str_Cpy( szTmp, "���ν��� : ");
					Str_Cat( szTmp, JSON_GetValue (hItem, "resultcode",  		szType));
					Str_Cat( szTmp, "\n");
					Str_Cat( szTmp, JSON_GetValue (hItem, "resultmsg",  		szType));
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), szTmp);
					Mem_Set( (byte*)g_szOne_ApproRslt, 0x00, sizeof(g_szOne_ApproRslt) );
					Str_Cpy(g_szOne_ApproRslt, szTmp);
					
					
				}
				else
				{
					g_lGasCardFlag = 1;
					
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					Str_Cpy( szTmp, "��ҽ��� : ");
					Str_Cat( szTmp, JSON_GetValue (hItem, "resultcode",  		szType));
					Str_Cat( szTmp, "\n");
					Str_Cat( szTmp, JSON_GetValue (hItem, "resultmsg",  		szType));
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_APPRO_RSLT), szTmp);
					Mem_Set( (byte*)g_szOne_ApproRslt, 0x00, sizeof(g_szOne_ApproRslt) );
					Str_Cpy(g_szOne_ApproRslt, szTmp);
				}	
			}
		}
	
		if(hItem != NULL)
		{
			JSON_Finalize(hItem);
			hItem = NULL;
		}
	
		g_Close_SubDlg();
	
		ON_DRAW();
		return;
	}
}
