/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_START
	Card Desc : �������� ����ȭ��
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_START
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
	#define USE_ON_TIMER
//	#define USE_ON_POINTING
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
		
		//��������
		DEF_BUTTON_ID ( BID_ADDR )		//����
		DEF_BUTTON_ID ( BID_PLACE )		//��ġ���
		DEF_BUTTON_ID ( BID_GR )		//�跮��
		DEF_BUTTON_ID ( BID_BOILER )	//���Ϸ�
		DEF_BUTTON_ID ( BID_COMBUSTOR )	//���ұ�
		DEF_BUTTON_ID ( BID_CLINFO )	//������
		DEF_BUTTON_ID ( BID_REFORM )	//�����ǰ�
		DEF_BUTTON_ID ( BID_BAR )		//���ڵ�
		DEF_BUTTON_ID ( BID_SAVE )		//����
		DEF_BUTTON_ID ( BID_BAR_PHOTO )	//���ڵ� �Ұ����� ����
		DEF_BUTTON_ID ( BID_MOVING_CENT ) // �̵������� ��ư
		
		//��ȸ�ڰ���
		DEF_BUTTON_ID ( BID_SIGN )		//����
		DEF_BUTTON_ID ( BID_CANCEL )	//���
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		//��������
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_CLNAME )		//��/��ǥ��
		DEF_OBJECT_ID ( TXT_PLACE )			//��ġ���
		DEF_OBJECT_ID ( TXT_GR )			//�跮��
		DEF_OBJECT_ID ( TXT_BOILER )		//���Ϸ�
		DEF_OBJECT_ID ( TXT_COMBUSTOR )		//���ұ�
		DEF_OBJECT_ID ( TXT_CLINFO )		//������
		DEF_OBJECT_ID ( TXT_COMPLETE )		//�ϼ��˻翩��
		DEF_OBJECT_ID ( TXT_REFORM )		//�����ǰ�
		DEF_OBJECT_ID ( TXT_IMPRSN )		//�Ұ�����
		DEF_OBJECT_ID ( TXT_TTLSPEND )		//�ѼҺ�
		DEF_OBJECT_ID ( TXT_USESCHDL )		//��뿹����
		DEF_OBJECT_ID ( TXT_DATA1 )			//��/��ǥ��
		DEF_OBJECT_ID ( TXT_DATA2 )			//�ּ�
		DEF_OBJECT_ID ( TXT_DATA4 )			//��ġ���
		DEF_OBJECT_ID ( TXT_DATA5 )			//�跮��
		DEF_OBJECT_ID ( TXT_DATA6 )			//���Ϸ�
		DEF_OBJECT_ID ( TXT_DATA7 )			//���ұ�
		DEF_OBJECT_ID ( TXT_DATA8 )			//������
		DEF_OBJECT_ID ( TXT_DATA9 )			//�����ǰ�
		DEF_OBJECT_ID ( TXT_DATA10 )		//���ڵ�
		DEF_OBJECT_ID ( TXT_DATA11 )		//�ü�����
		DEF_OBJECT_ID ( TXT_DATA12 )		//��뷮����1
		DEF_OBJECT_ID ( TXT_DATA13 )		//��뷮����2
		
		//����
		DEF_OBJECT_ID ( TTL_TIME_FROM )		//���˽��۽ð�
		DEF_OBJECT_ID ( TXT_TIME_FROM )		//���˽��۽ð�
		DEF_OBJECT_ID ( TTL_TIME_TO )		//����ð�
		DEF_OBJECT_ID ( TXT_TIME_TO )		//����ð�
		DEF_OBJECT_ID ( TTL_TIME_LEFT )		//�����ð�
		DEF_OBJECT_ID ( TXT_TIME_LEFT )		//�����ð�
		
		DEF_OBJECT_ID ( ICON_TITLE )		//������
		
		//LINE
		DEF_OBJECT_ID ( LINE_DATA1 )		//LINE_DATA_1
		DEF_OBJECT_ID ( LINE_DATA2 )		//LINE_DATA_2
		
		//�޺��ڽ�
		DEF_OBJECT_ID ( CMB_COMPLETE ) 						//�ϼ��˻翩�� �޺��ڽ�
		DEF_OBJECT_ID ( CMB_BARWHY = CMB_COMPLETE+3 ) 		//�Ұ����� �޺��ڽ�
		DEF_OBJECT_ID ( CMB_DATA1 = CMB_BARWHY+3 )			//��ȸ�ڰ���
	END_OBJECT_ID()
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define INIT_MAIN	 1
	#define INIT_RLTCHK  2
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	char m_szSms_Desc[1500];
	char m_szReceiver_Tel[50];
	char m_szBartmp[100];
	char m_szAddr[200];
	long m_bFirst;
	long m_nBtnId;
	long m_nNogoodCnt = 0;
	long m_nCheck = 0;
	long m_lActiveIndex = -1;
	long m_nTimerCnt = 1000;
	long m_nTimerId = -1;
	char m_szBuf[32];
	char m_szfilenm[128];
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	void Barcode(void);
	void OnBarcodeRead(void);
	void PDA_OnBarcodeRead(void);
	void SetStyle(void);
	void SetCombo(void);
	void REDRAW(void);
	bool Save_Result(void);
	bool Save_Issue(void);						//�켱���˴�� -> �����ǰ� ��������
	bool New_Nogood(void);
	bool Validate(void);
	long SearchStr(char *Str, CodeTable *CT);	//�ڵ� ���� ã�´�.
	long SearchCD(char *CD, CodeTable *CT);		//�ڵ� ���� ã�´�.
	void SetBtnImg(void);
	void Next_SC(void);
	long FS_GetSrchTotCnt(void);
	long Sos_Key(void);
	
	long Analy_Phone(char*phone, char* num1, char* num2, char* num3 );
	long Snd_Sms(void);
	long Snd_Sms_Hist(void);
	long TR312400(void);
	
	//Ÿ�̸�
	void SetStatus(char* pText);
	void Start_Timer(void);
	void Stop_Timer(void);
	
	void Shoto_Photo(void);
	
	//---------------------------------------------------------------
	//	�����ư
	//---------------------------------------------------------------
	SysButCtrl SysButRes_MAIN[] =
	{
		  SYS_BUT_IMG( BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME, 0 ),
		  SYS_BUT_IMG( BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0 ),
		  SYS_BUT_IMG( BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0 ),
		  SYS_BUT_IMG( BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK, 0 ),
		  SYS_BUT_IMG( BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0),
		  SYS_BUT_IMG( BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0 ),
		  SYS_BUT_IMG( BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER , 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0 ),
	};
	
	//---------------------------------------------------------------
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�Ϲݻ��ü� ��������"),
		
		DLG_TEXT(  STARTX, 	   STARTY+ 65, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLNAME, "��/��ǥ��"),
		DLG_TEXT(  STARTX+320, STARTY+ 65, 680,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, ""),
		
		DLG_BUTTON(STARTX,     STARTY+115, 200, 122, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_ADDR, "����"),
		DLG_TEXT(  STARTX+200, STARTY+115, 800, 122, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""),
		
		DLG_LINE ( STARTX,     STARTY+241, 1000, STARTY+241,  DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT(  STARTX, 	   STARTY+246, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_PLACE, "��ġ���"),
		DLG_TEXT(  STARTX+320, STARTY+246, 455,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA4, ""),
		DLG_BUTTON(STARTX+775, STARTY+246, 225,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_PLACE, "����"),
		
		DLG_TEXT(  STARTX, 	   STARTY+296, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_GR, "�跮��"),
		DLG_TEXT(  STARTX+320, STARTY+296, 455,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""),
		DLG_BUTTON(STARTX+775, STARTY+296, 225,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_GR, "����"),
		
		DLG_TEXT(  STARTX, 	   STARTY+346, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_BOILER, "���Ϸ�"),
		DLG_TEXT(  STARTX+320, STARTY+346, 455,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6, ""),
		DLG_BUTTON(STARTX+775, STARTY+346, 225,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_BOILER, "����"),
		
		DLG_TEXT(  STARTX, 	   STARTY+396, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMBUSTOR, "���ұ�"),
		DLG_TEXT(  STARTX+320, STARTY+396, 455,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""),
		DLG_BUTTON(STARTX+775, STARTY+396, 225,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_COMBUSTOR, "����"),
		
		DLG_TEXT(  STARTX, 	   STARTY+446, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_CLINFO, "������"),
		DLG_TEXT(  STARTX+320, STARTY+446, 200,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""),
		DLG_BUTTON(STARTX+520, STARTY+446, 255,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_MOVING_CENT, "�̵���"),
		DLG_BUTTON(STARTX+775, STARTY+446, 225,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CLINFO, "Ȯ��"),	
		
		DLG_TEXT(  STARTX, 	   STARTY+496, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMPLETE, "�ϼ��˻翩��"),
		DLG_COMBO( STARTX+320, STARTY+496, 680, 290, 225, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_COMPLETE, 10), //�ϼ��˻翩��
		
		DLG_TEXT(  STARTX, 	   STARTY+546, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_REFORM, "�����ǰ�"),
		DLG_TEXT(  STARTX+320, STARTY+546, 455,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA9, ""),
		DLG_BUTTON(STARTX+775, STARTY+546, 225,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_REFORM, "����"),
		
		DLG_BUTTON(STARTX,     STARTY+596, 320,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_BAR, "���ڵ�"),
		DLG_TEXT(  STARTX+320, STARTY+596, 680,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA10, ""),	//���ڵ��Է�
		
		DLG_TEXT(  STARTX,	   STARTY+646, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_IMPRSN, "�Ұ�����"),
		DLG_COMBO (STARTX+320, STARTY+646, 455, 290, 200, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BARWHY, 10), //�Ұ�����
		DLG_BUTTON(STARTX+775, STARTY+646, 225,  50, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, YELLOW, CALL_FUNC, "", BID_BAR_PHOTO, "����"),
		
		DLG_TEXT(  STARTX, 	   STARTY+696, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_TTLSPEND, "�ü�����"),
		DLG_TEXT(  STARTX+320, STARTY+696, 340,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(  STARTX+660, STARTY+696, 340,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, ""),
		
		DLG_TEXT(  STARTX, 	   STARTY+746, 320,  50, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_USESCHDL, "��뿹����"),
		DLG_TEXT(  STARTX+320, STARTY+746, 680,  50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, ""),	
		
		DLG_LINE ( STARTX,     STARTY+800, 1000, STARTY+800, DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_BUTTON(STARTX+15,  STARTY+813, 970,  80, 0, 0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SAVE, "�� ��"),
	};

	//---------------------------------------------------------------
	// ��ȸ�ڰ���
	//---------------------------------------------------------------
	DlgObject DlgRes_RLTCHK[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		
		//Ÿ��Ʋ
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ȸ�� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),

		DLG_COMBO( STARTX,     STARTY-29, 1000, 200, 200, 80, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 20),

		DLG_TEXT(  STARTX,	   STARTY+ 51, 450, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TIME_FROM, "���˽��۽ð�"),
		DLG_TEXT(  STARTX+450, STARTY+ 51, 550, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TIME_FROM, ""),
		DLG_TEXT(  STARTX,	   STARTY+131, 450, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TIME_TO, "����ð�"),
		DLG_TEXT(  STARTX+450, STARTY+131, 550, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TIME_TO, ""),	
		DLG_TEXT(  STARTX,	   STARTY+211, 450, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TIME_LEFT, "�����ð�"),
		DLG_TEXT(  STARTX+450, STARTY+211, 550, 80, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TIME_LEFT, ""),

		DLG_BUTTON(STARTX,	   STARTY+300, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "�� ��"),
		DLG_BUTTON(STARTX+500, STARTY+300, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SIGN,  "�� ��"),
	};
	
	//---------------------------------------------------------------
	// main
	//---------------------------------------------------------------
	bool main(quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam)
		return TRUE;
	}
	
	//---------------------------------------------------------------
	// OnInit Function
	//---------------------------------------------------------------
	void OnInit(char bFirst)
	{
		long i, lCount=0;
		char sztmp[200];
		char szSql[300];

		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			case INIT_MAIN:

				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				REDRAW();
				
				g_lNewBurFlag = 0;
				PRINT(g_szCHK_EXEC_NUM,0,0,0);
				
				if( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") == 0 || Str_Cmp(stSc.PREUSE_CHK_WHY, "30") == 0 )
				{
					lCount = 0;
					
					Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
					SPRINT(sztmp, "SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
					
					g_Sql_RetInt( sztmp, &lCount );
					
					if( lCount == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "�켱���� ������ �׸� ��\n������ �����ϴ�.\nȮ���� �ּ���.");
						Card_Move("SC_CONFIRM");
						return;
					}
				}
				
				if(g_lSCMoveFlag == 1)
				{
					g_lSCMoveFlag = 0;
					Card_Move("SC_PLACECHK");
					return;
				}
				
				break;
				
			case INIT_RLTCHK:

				CREATE_DIALOG_OBJECT (DlgRes_RLTCHK, SIZEOF(DlgRes_RLTCHK));
				
				IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				g_Sql_SetCombo(" SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C10004' ORDER BY CODE_ITEM ", CMB_DATA1+2);
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA1+2), 0)  );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) );
				SPRINT(szSql, " SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s' ", sztmp, 0, 0   );
				g_Sql_RetStr( szSql, 10, stSc.SIGN_RELAT );
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TIME_FROM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TIME_FROM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TIME_TO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TIME_TO), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TIME_LEFT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TIME_LEFT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				
				// ���� ���۽ð�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Str_TimeForm( sztmp, stSc.CHK_TIME_FROM);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TIME_FROM), sztmp);
				
				// ����ð� ����
				Mem_Set( (byte*)stSc.CHK_TIME_TO, 0x00, sizeof(stSc.CHK_TIME_TO) );
				g_Str_TimeType( stSc.CHK_TIME_TO, Time_GetTime() );
				
				// ���� �ð�
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				g_Str_TimeForm( sztmp, stSc.CHK_TIME_TO);
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TIME_TO), sztmp);

				/* ���ڵ�
				if( Str_Len(g_szCurrBar) > 0 )
				{
					Str_Cpy(stSc.CURR_BAR, g_szCurrBar);
					Mem_Set((byte*)stSc.BAR_WHY, 0, sizeof(stSc.BAR_WHY));
				}
				*/

				// �������׸񰹼�
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL) AND EXCEP_PREUSE_CHK <> 'Y' "
							, g_szCHK_EXEC_NUM, 0, 0);
							
				g_Sql_RetInt(szSql, &m_nNogoodCnt);

				if( Str_Len(stSc.BAR_WHY) > 0 || m_nNogoodCnt > 0 )
				{
					m_nCheck = 0;
				}
				else
				{
					m_nCheck = 1;
				}
			
				// 2017.11.13 �ű�ȣ Ÿ�̸� �߰�
				Start_Timer();

				break;
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
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CLNAME)   , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PLACE)    , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_GR)       , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BOILER)   , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_COMBUSTOR), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CLINFO)   , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_COMPLETE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REFORM)   , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_IMPRSN)   , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TTLSPEND) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USESCHDL) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1)   , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4)   , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5)   , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6)   , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7)   , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8)   , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9)   , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10)  , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11)  , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12)  , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13)  , EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_COMPLETE), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BARWHY)  , EDITALIGN_MIDDLE);
	
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA2), TRUE, 2, EDITSEP_NONE );
		
		return;
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
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);	
			
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

	/*=======================================================================================
	�Լ��� : SetCombo
	��  �� : Combo Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i;
		char szSql[300];
		char szUsageCd[10];

		// ��ǰ�ڵ�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT USAGE_CD FROM NORMAL_DATA WHERE CHK_EXEC_NUM ='%s' " , g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetStr(szSql, 2, szUsageCd);
		
		//�ϼ��˻翩��
		for ( i = 0 ;  SCCOMP_CHK[i].Str[0] != 0 ; i++)
		{
			if(Str_Cmp(szUsageCd, "20") == 0 || Str_Cmp(szUsageCd, "21") == 0 || Str_Cmp(szUsageCd, "22") == 0 )
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_COMPLETE+2), SCCOMP_CHK[i].Str, 0, ICON_NONE);
			}
		}
		
		//���ڵ�Ұ�����
		for ( i = 0 ;  SCBARWHY[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BARWHY+2), SCBARWHY[i].Str, 0, ICON_NONE);
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
		char szSql[300];
		char sztmp[200];
		char szToday[15];
		long i;
		long lCount = 0;
		long lRet = 0;
		long fd;
		long nfromtime = 0;
		long ntotime = 0;
					
		m_nBtnId = ID;
		
		switch(ID)
		{	
			/*************************************/
			/* ���� ��ư                         */
			/*************************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
					{
						g_Del_ScData();
					}
					g_lDataflag = 0;		//��ħ ���� flag
					g_lMoveFlag = 0;		//����Ʈ ȭ���̵� flag
					Card_Move("MENU");			
				}
				
				break;
				
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "�������� �޴���\n�����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
					{
						g_Del_ScData();
					}			
					g_lDataflag = 0;		//��ħ ���� flag
					g_lMoveFlag = 0;		//����Ʈ ȭ���̵� flag
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
				//Sos_Key();
				if( MessageBoxEx (CONFIRM_YESNO, "SOS ���ȣ���� �Ͻðڽ��ϱ�?") == MB_OK )
				{
					g_Send_SOS(1);
				}
				
				break;	
							
			case GID_PREV:
				if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
				{
					g_Del_ScData();
				}
				g_lRfrmFlag = 0;
				Card_Move("SC_CONFIRM");			
				break;
					
			case GID_VMEXIT:
				if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
				{
					g_Exit_DelScData();
					return;
				}
				g_Exit();
							
				return;
			
			/*************************************/
			/* �������� ȭ��                     */
			/*************************************/			
			case BID_ADDR:
				if( 0 == g_nAddrFlag )
				{
					g_nAddrFlag = 1;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�");
				}
				else
				{
					g_nAddrFlag = 0;
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����");
				}
				
				REDRAW();
				
				break;
				
			case BID_PLACE:
				if( Str_Cmp(stSc.SEND_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
				}
				else
				{
					Card_Move("SC_PLACECHK");
				}
				
				break;
				
			case BID_GR:
				if( Str_Cmp(stSc.SEND_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
				}
				else
				{
					Mem_Set((byte *)g_szIndi_Vm, 0x00, sizeof(g_szIndi_Vm));
					Mem_Set((byte *)g_szIndi_Va, 0x00, sizeof(g_szIndi_Va));
					Mem_Set((byte *)g_szIndi_Vc, 0x00, sizeof(g_szIndi_Vc));
					Mem_Set((byte*)g_szSubCHK_EXEC_NUM, 0x00, sizeof(g_szSubCHK_EXEC_NUM));	
					g_lSCMoveFlag = 0;
					g_lDataflag = 0;
					Card_Move("SC_MTRCHK");
				}
				
				break;
				
			case BID_BOILER:
			
				g_nBoil_inst_cnt = 0;
			
				if( Str_Cmp(stSc.SEND_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
				}
				else
				{
					Card_Move("SC_BOILCHK");
				}
				
				break;
				
			case BID_COMBUSTOR:
				if( Str_Cmp(stSc.SEND_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
				}
				else
				{
					g_nPhotoFlag = 0;
					Card_Move("SC_BNCHK");
				}
				
				break;
				
			case BID_CLINFO:
				if( Str_Cmp(stSc.SEND_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
				}
				else
				{
					Mem_Set( (byte*)stSc.CUST_FLAG, 0x00, sizeof(stSc.CUST_FLAG) );
					Str_Cpy( stSc.CUST_FLAG, "Y" );
					Card_Move("SC_CUSTINFO");
				}
				
				break;
				
			case BID_REFORM:
				if( Str_Cmp(stSc.LOC_RSLT, "") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "��ġ��Ҹ� �����ϼ���!!");
					break;
				}
				else if( Str_Cmp(stSc.MTR_RSLT, "") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�跮�⸦ �����ϼ���!!");
					break;
				}
				else if( Str_Cmp(stSc.BO_RSLT, "") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "���Ϸ��� �����ϼ���!!");
					break;
				}
				else if( Str_Cmp(stSc.BUR_FLAG, "") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "���ұ⸦ �����ϼ���!!");
					break;
				}
				else if( Str_Cmp( stSc.SEND_YN, "Y") == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�̹� �۽� �Ϸ��� �ڷ��Դϴ�.");
					break;
				}
				
				g_lRfrmFlag = 1;
				Card_Move("SC_RFRMISSU");
				
				break;
				
			case BID_BAR:
				Barcode();
				
				break;
				
			case BID_SAVE:
				if( !Validate() )
				{
					break;
				}
				
				ON_EXIT();
				OnInit(INIT_RLTCHK);
				
				break;
			
			case BID_BAR_PHOTO:
				Shoto_Photo();
				
				break;
				
			case BID_MOVING_CENT:
				Mem_Set( (byte*)g_szMC_InstPlaceNum, 0x00, sizeof(g_szMC_InstPlaceNum) );
				Str_Cpy( g_szMC_InstPlaceNum, stSc.INST_PLACE_NUM );
				
				g_lMC_MoveCard_Flag = 0;
				
				Card_Move("CM_MOVING_CENT");
				
				break;
			
			/*************************************/
			/* ��ȸ�ڰ���                         */
			/*************************************/	
			case BID_SIGN:
				// ���� �ð� ��		
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Cpy((byte*)sztmp, (byte*)stSc.CHK_TIME_FROM, 2);
				nfromtime = 60*60*Str_AtoI(sztmp);
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Cpy((byte*)sztmp, (byte*)stSc.CHK_TIME_FROM+2, 2);
				nfromtime += 60*Str_AtoI(sztmp);
				Mem_Cpy((byte*)sztmp, (byte*)stSc.CHK_TIME_FROM+4, 2);
				nfromtime += Str_AtoI(sztmp);
				
				// ����ð� ����
				Mem_Set( (byte*)stSc.CHK_TIME_TO, 0x00, sizeof(stSc.CHK_TIME_TO) );
				g_Str_TimeType( stSc.CHK_TIME_TO , Time_GetTime());
				
				// ���� �ð� ��
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Cpy((byte*)sztmp, (byte*)stSc.CHK_TIME_TO, 2);
				ntotime = 60*60*Str_AtoI(sztmp);
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Cpy((byte*)sztmp, (byte*)stSc.CHK_TIME_TO+2, 2);
				ntotime += 60*Str_AtoI(sztmp);
				Mem_Cpy((byte*)sztmp, (byte*)stSc.CHK_TIME_TO+4, 2);
				ntotime += Str_AtoI(sztmp);
				
				// ��ǰ�ڵ�
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " SELECT MAX(PROD_CD) FROM NORMAL_MTR WHERE CHK_EXEC_NUM ='%s' " , g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetStr(szSql, 2, stScMtr.PROD_CD);
				
				// �׽�Ʈ�� ���� �ּ�ó��
				if( Str_Cmp(stScMtr.PROD_CD, "11") == 0 || Str_Cmp(stScMtr.PROD_CD, "81") == 0)
				{
					if( ntotime - nfromtime < 120 )
					{
						Timer_Kill( m_nTimerId );
						m_nTimerId = -1;
						SetStatus("");
						
						MessageBoxEx (CONFIRM_OK, "���˱��ؽð� ��������\n���� �Ϸ� ó���� ���� �ʽ��ϴ�.\n( ������뼼�� : 2�� )");
						
						Mem_Set( (byte*)stSc.CHK_TIME_TO, 0x00, sizeof(stSc.CHK_TIME_TO) );
						g_Str_TimeType( stSc.CHK_TIME_TO, Time_GetTime() );
						Start_Timer();
						
						break;
					}
				}
				else
				{
					if( ntotime - nfromtime < 150 )
					{
						Timer_Kill( m_nTimerId );
						m_nTimerId = -1;
						SetStatus("");
						
						MessageBoxEx (CONFIRM_OK, "���˱��ؽð� ��������\n���� �Ϸ� ó���� ���� �ʽ��ϴ�.\n( ���漼�� : 2��30�� )");
						
						Mem_Set( (byte*)stSc.CHK_TIME_TO, 0x00, sizeof(stSc.CHK_TIME_TO) );
						g_Str_TimeType( stSc.CHK_TIME_TO, Time_GetTime() );
						Start_Timer();
						
						break;
					}
				}
				
				//���� ��� ����
				if( Save_Result() )
				{
					g_nBackFlag++;
					
					if( g_nBackFlag > 9 )
					{
						g_Db_Backup();
						g_nBackFlag = 0;
					}
					
					if( g_nWorkFlag >= 200 )
					{
						Next_SC();
					}
					
					// ������ �켱������ ��� �����ǰ� ȭ������ �̵� ��� �߰�
					if( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") == 0 )
					{
						Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
						lCount = 0;
						SPRINT(szSql, "SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
						g_Sql_RetInt( szSql, &lCount );
						if( lCount > 0 )
						{
							if( MessageBoxEx (CONFIRM_YESNO, "�����ǰ� ȭ������\n�̵��Ͻðڽ��ϱ�?")  == MB_OK )
							{
								g_lMoveFlag = 2;
								Card_Move("SC_RFRMPRGRS");
								break;		
							}
						}
					}
					
					//2017-08-14 Sanghyun Lee
					//�켱���� ����� ��� �����ճ��� ���ڹ߼� �� �̷� ����. ����ó�� �ڵ� �� �ٽ� ��� ����.
					if( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") != 0 && Str_Cmp(stSc.PREUSE_CHK_WHY, "30") != 0 )
					{
						//������ ���� �߻� �� �ش� ������ ���� ������ ��������.
						Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
						lCount = 0;
						//SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' GROUP BY BETTER_PLAN_YMD", g_szCHK_EXEC_NUM, 0, 0   );
						SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND EXCEP_PREUSE_CHK <> 'Y' ", g_szCHK_EXEC_NUM, 0, 0   );
						g_Sql_RetInt( szSql, &lCount );
						
						// 2018-03-19 ������� �� ���� �߼� ����
						if( lCount > 0 && Str_Cmp(stSc.CONT_STS_CD, "30") != 0 )
						{
							lRet = Snd_Sms();
							if( lRet > 0 )
							{
								Snd_Sms_Hist();
								break;
							}
						}
					}
					
					Card_Move("SC_CONFIRM");
				}
				break;
				
			case BID_CANCEL:
				
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
		long i;
		char sztmp[100];
		char szSql[200];
		char szFilenm[100];
		
		if( INIT_MAIN == m_bFirst )
		{	
			/********************************/
			/* 1. ���ڵ� �νĺҰ�����       */
			/********************************/
			// 1-1. ���ڵ� �Ұ����� ����ü ����
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARWHY)), SCBARWHY );
			
			Mem_Set((byte*)stSc.BAR_WHY, 0x00, sizeof(stSc.BAR_WHY));
			
			if (i == -1)
			{
				Str_Cpy(stSc.BAR_WHY, "");
			}
			else
			{
				Str_Cpy(stSc.BAR_WHY, SCBARWHY[i].Code);
			}
			
			// 1-2. ���ڵ� �Ұ����� ����DB ����
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_DATA SET BAR_WHY = '%s' WHERE CHK_EXEC_NUM = '%s' ", stSc.BAR_WHY, g_szCHK_EXEC_NUM, 0);
			g_Sql_DirectExecute(szSql);
			
			// 1-3. ���ڵ� ���� ��ư
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARWHY)), "��Ÿ") == 0 )
			{
				Mem_Set((byte*)szFilenm, 0x00, sizeof(szFilenm));
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			
				Str_Cpy(sztmp, "C42_");
				Str_Cat(sztmp, g_szCHK_EXEC_NUM);
				Str_Cat(sztmp, "_");						
				Str_Cat(sztmp, stSc.INST_PLACE_NUM);
				Str_Cat(sztmp, ".jjp");
				
				SPRINT (szFilenm, "%s/%s", PHOTO_SCBAR, sztmp, 0);
				
				if( FFS_Exist(szFilenm) > 0 )
				{
					FFS_Delete(szFilenm);
				}
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE NORMAL_DATA SET PHOTO_BAR_YN = 'N' WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_DirectExecute(szSql);
				
				Mem_Set((byte*)stSc.PHOTO_BAR_YN, 0x00, sizeof(stSc.PHOTO_BAR_YN));
				Str_Cpy(stSc.PHOTO_BAR_YN, "N");
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), TRUE );
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BAR_PHOTO), YELLOW);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BAR_PHOTO), TXTFRCOLOR);
			}
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), FALSE );	
			}
			
			/********************************/
			/* 2. �ϼ��˻翩��              */
			/********************************/
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_COMPLETE)), SCCOMP_CHK );
			
			Mem_Set((byte*)stSc.COMP_CHK_OBJ_YN, 0x00, sizeof(stSc.COMP_CHK_OBJ_YN));
			
			if (i == -1)
			{
				Str_Cpy(stSc.COMP_CHK_OBJ_YN, "");
			}
			else
			{
				Str_Cpy(stSc.COMP_CHK_OBJ_YN, SCCOMP_CHK[i].Code);
			}
		}
		else if( INIT_RLTCHK == m_bFirst )
		{
			/********************************/
			/* 1. ���� ����                    */
			/********************************/
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)stSc.SIGN_RELAT, 0x00, sizeof(stSc.SIGN_RELAT) );
			
			Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)) );
			SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C10004' AND ITEM_KNAME = '%s' ", sztmp, 0, 0   );
			g_Sql_RetStr( szSql, 10, stSc.SIGN_RELAT );
			
			Timer_Kill( m_nTimerId );
			m_nTimerId = -1;
			SetStatus("");
			
			Mem_Set( (byte*)stSc.CHK_TIME_TO, 0x00, sizeof(stSc.CHK_TIME_TO) );
			g_Str_TimeType( stSc.CHK_TIME_TO, Time_GetTime() );
			Start_Timer();
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
	
	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : ȭ�� ���� ��ħ
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		char szName[128];
		char szDirPath[100];
		char szScrPht[128];
		char szTmp[200];
		char szSql[300];
		char szUsageCd[10];
		long nRet;
		long i;
		
		/*******************************/
		/* 1. ����                   */
		/*******************************/
		Mem_Set((byte*)szName, 0x00, sizeof(szName));
			
		Str_Cpy(szName, stSc.CUST_NM );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA1), szName);
		
		/*******************************/
		/* 2. �ּ�                     */
		/*******************************/
		Mem_Set((byte*)m_szAddr, 0x00, sizeof(m_szAddr));
		
		// 1. ����
		if( g_nAddrFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "����");
			
			// 1. �ñ���
			if(Str_Len(stSc.COUNTY) > 0)		
			{
				Str_Cpy(m_szAddr,  stSc.COUNTY );
			}
			
			// 2. ���鵿
			if(Str_Len(stSc.TOWN) > 0)			
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.TOWN );
			}
			
			// 3. ��
			if(Str_Len(stSc.VILLAGE) > 0)			
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.VILLAGE );
			}
			
			// 4. ����
			if(Str_Len(stSc.ADDR1_M) > 0)
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.ADDR1_M);
			}
			
			// 5. �ι�
			if(Str_Len(stSc.ADDR1_S) > 0)		
			{
				Str_Cat(m_szAddr,  "-" );
				Str_Cat(m_szAddr,  stSc.ADDR1_S);
			}
			
			// 6-1. �ܵ� : ȣ�� + ETC
			if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "10") == 0 )
			{
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
				}
				if(Str_Len(stSc.LOT_NUM_SECOND_ADDR) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.LOT_NUM_SECOND_ADDR);
				}
			}
			// 6-2. ���� : �������ø� + �ǹ��� + ȣ��
			else if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "20") == 0 )
			{
				if(Str_Len(stSc.CO_LIVE_NM) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.CO_LIVE_NM );
				}
				if(Str_Len(stSc.BLD_NM) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.BLD_NM);
				}
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(m_szAddr,  "-" );
					Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
				}
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), m_szAddr);
		}
		// 2. ���θ�
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR), "���θ�");
			
			// 1. �ñ���
			if(Str_Len(stSc.COUNTY) > 0)		
			{
				Str_Cpy(m_szAddr,  stSc.COUNTY );
			}
			
			// 2. ���θ�
			if(Str_Len(stSc.NEW_ROAD_NM) > 0)
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.NEW_ROAD_NM );
			}
			
			// 3. ���θ�_����
			if(Str_Len(stSc.NEW_ADDR_M) > 0)
			{
				Str_Cat(m_szAddr,  " " );
				Str_Cat(m_szAddr,  stSc.NEW_ADDR_M);
			}
			
			// 4. ���θ�_�ι�
			if(Str_Len(stSc.NEW_ADDR_S) > 0)
			{
				Str_Cat(m_szAddr,  "-" );
				Str_Cat(m_szAddr,  stSc.NEW_ADDR_S);
			}
			
			// 5-1. �ܵ� : ȣ�� + ETC
			if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "10") == 0 )
			{
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
				}
				if(Str_Len(stSc.LOT_NUM_SECOND_ADDR) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.LOT_NUM_SECOND_ADDR);
				}
			}
			
			// 5-2. ���� : �������ø� + �ǹ��� + ȣ��
			else if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "20") == 0 )
			{
				if(Str_Len(stSc.CO_LIVE_NM) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.CO_LIVE_NM );
				}
				if(Str_Len(stSc.BLD_NM) > 0)
				{
					Str_Cat(m_szAddr,  " " );
					Str_Cat(m_szAddr,  stSc.BLD_NM);
				}
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(m_szAddr,  "-" );
					Str_Cat(m_szAddr,  stSc.HOUSE_CNT);
				}
				//220127
				// if(Str_Len(stSc.LOT_NUM_SECOND_ADDR) > 0)
				// {
				// 	Str_Cat(m_szAddr,  " " );
				// 	Str_Cat(m_szAddr,  stSc.LOT_NUM_SECOND_ADDR);
				// }
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), m_szAddr);
		}
		
		/*******************************/
		/* 3. ��ġ���                 */
		/*******************************/
		if( Str_Cmp( stSc.LOC_RSLT, "Y") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA4), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "����");
		}
		else if( Str_Cmp( stSc.LOC_RSLT, "N") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA4), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "������");
		}
		else
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA4), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "������");
		}
		
		/*******************************/
		/* 4. �跮��                   */
		/*******************************/
		if( Str_Cmp( stSc.MTR_RSLT, "Y") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA5), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), "����");
		}
		else if( Str_Cmp( stSc.MTR_RSLT, "N") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA5), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), "������");
		}
		else
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA5), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), "������");
		}
		
		/*******************************/
		/* 5. ���Ϸ�                   */
		/*******************************/
		if( Str_Cmp( stSc.BO_RSLT, "Y") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "����");
		}
		else if( Str_Cmp( stSc.BO_RSLT, "N") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "������");
		}
		else
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "������");
		}
		
		/*******************************/
		/* 6. ���ұ�                   */
		/*******************************/
		if( Str_Cmp( stSc.BUR_FLAG, "Y") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA7), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), "����");
		}
		else if( Str_Cmp( stSc.BUR_FLAG, "N") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA7), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), "������");
		}
		else
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA7), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), "������");
		}
		
		/*******************************/
		/* 7. ������                 */
		/*******************************/
		if( Str_Cmp( stSc.CUST_FLAG, "Y") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "Ȯ��");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "��Ȯ��");
		}
		
		/*******************************/
		/* 8. �ϼ��˻�                */
		/*******************************/
		if(Str_Len(stSc.COMP_CHK_OBJ_YN) == 0)
		{
			Str_Cpy(stSc.COMP_CHK_OBJ_YN, "N");
		}
		
		i = SearchCD( stSc.COMP_CHK_OBJ_YN, SCCOMP_CHK );
		
		// ��ǰ�뵵
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT USAGE_CD FROM NORMAL_DATA WHERE CHK_EXEC_NUM ='%s' " , g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetStr(szSql, 2, szUsageCd);
		
		
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_COMPLETE), "");
		}
		else
		{
			if( Str_Cmp(szUsageCd, "20") == 0 || Str_Cmp(szUsageCd, "21") == 0 || Str_Cmp(szUsageCd, "22") == 0 )
			{	
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_COMPLETE), SCCOMP_CHK[i].Str);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_COMPLETE), "");
			}
			
		}
		
		/*******************************/
		/* 9. �����ǰ�                 */
		/*******************************/
		// �����սÿ� �����ǹ��� ��û, �����ճ����Է½ÿ� ����Ϸ� ǥ��, g_lRfrmFlag
		if( g_lRfrmFlag == 0 && (Str_Cmp(stSc.LOC_RSLT, "N") == 0 || Str_Cmp(stSc.MTR_RSLT, "N") == 0 || Str_Cmp(stSc.BO_RSLT, "N") == 0 || Str_Cmp(stSc.BUR_FLAG, "N") == 0 ) )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), FALSE );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), "�� ������ �ּ���.");
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA9), RED);
		}
		else if( g_lRfrmFlag == 1 && Str_Cmp(stSc.LOC_RSLT, "N") == 0 || Str_Cmp(stSc.MTR_RSLT, "N") == 0 || Str_Cmp(stSc.BO_RSLT, "N") == 0 || Str_Cmp(stSc.BUR_FLAG, "N") == 0 )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), FALSE );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), "����Ϸ�");
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA9), RED);
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_REFORM), TRUE );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), "");
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA9), TXTFRCOLOR);
		}
		
		/*******************************/
		/* 10. �ü�����                */
		/*******************************/
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), stSc.PROTE_FACI_GRD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), stSc.PARCEL_OUT_YN);
		
		/*******************************/
		/* 11. ��뿹����              */
		/*******************************/
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), stSc.USE_PLAN_QTY);
		
		/*******************************/
		/* 12. ���ڵ�                  */
		/*******************************/
		// 12-1. ���ڵ�, �Ұ����� ǥ��
		if( Str_Len(stSc.CURR_BAR) > 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), "���ڵ� �ν� ����");
			
			//����Ʈȭ�鿡�� ���ڵ�� ����� ã�� �����Ե� ��� disable
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_BAR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR), TRUE );
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY+1), TRUE );
		}
		else
		{
			//�Ұ�����
			i = SearchCD( stSc.BAR_WHY, SCBARWHY );
			
			if( i == -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARWHY), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARWHY), SCBARWHY[i].Str);
			}
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY+1), FALSE );
		}
		
		// 12-2. ���ڵ� �Ұ����� ������ư
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARWHY)), "") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARWHY)), "��Ÿ") == 0 )
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), TRUE );	
		}
		else
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), FALSE );
		}
		
		// 12-3. ���ڵ� �Ұ����� ������ư ����
		Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		Mem_Set((byte*)szScrPht, 0x00, sizeof(szScrPht));
		
		Str_Cpy( szDirPath, PHOTO_SCBAR );
		Str_Cpy( szTmp, "C42_" );
		Str_Cat( szTmp, g_szCHK_EXEC_NUM );
		Str_Cat( szTmp, "_" );						
		Str_Cat( szTmp, stSc.INST_PLACE_NUM );
		Str_Cat( szTmp, ".jjp" );
		
		nRet = g_FindFiles( szDirPath, szTmp , szScrPht);
		
		if( Str_Cmp( stSc.PHOTO_BAR_YN, "Y") == 0 || nRet > 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BAR_PHOTO), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BAR_PHOTO), BTNMENUFRCOLOR);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BAR_PHOTO), YELLOW);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BAR_PHOTO), TXTFRCOLOR);	
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : Validate
	��  �� : ���� Validate
	Param  : 
	Return : 
	========================================================================================*/
	bool Validate(void)
	{
		bool ret = FALSE;
		char szDirPath[100];
		char szScrPht[128];
		char szTmp[200];
		long nRet;
		
		// 1. ��ġ��� ����
		if( Str_Cmp(stSc.LOC_RSLT, "") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "��ġ��Ҹ� �����ϼ���!!");
			return ret;
		}
		// 2. �跮�� ����
		else if( Str_Cmp(stSc.MTR_RSLT, "") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�跮�⸦ �����ϼ���!!");
			return ret;
		}
		// 3. ���Ϸ� ����
		else if( Str_Cmp(stSc.BO_RSLT, "") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���Ϸ��� �����ϼ���!!");
			return ret;
		}
		// 4. ���ұ� ����
		else if( Str_Cmp(stSc.BUR_FLAG, "") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ұ⸦ Ȯ���ϼ���!!");
			return ret;
		}
		// 5. ������ ����
		else if( Str_Cmp(stSc.CUST_FLAG, "") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�������� Ȯ���ϼ���!!");
			return ret;
		}
		
		// 6. ���ڵ�
		if( Str_Len(stSc.CURR_BAR) == 0 )
		{
			if( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA10)), "") == 0 
			 && Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARWHY)), "") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "���ڵ带 ��ĵ�ϰų� �Ұ������� �����ϼ���.");
				return ret;
			}
		}
		
		// 7. ���ڵ� �ν� �Ұ��� ��� (�Ѽ�, �̺���, �νĺҰ�) ���� ����
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARWHY)), "") != 0 && Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BARWHY)), "��Ÿ") != 0 )
		{
			Mem_Set((byte*)szDirPath, 0x00, sizeof(szDirPath));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte*)szScrPht, 0x00, sizeof(szScrPht));
			
			Str_Cpy( szDirPath, PHOTO_SCBAR );
			Str_Cpy( szTmp, "C42_"  );
			Str_Cat( szTmp, g_szCHK_EXEC_NUM );
			Str_Cat( szTmp, "_");						
			Str_Cat( szTmp, stSc.INST_PLACE_NUM);
			Str_Cat( szTmp, ".jjp" );
		
			nRet = g_FindFiles( szDirPath, szTmp , szScrPht);
			
			if( nRet <= 0 && Str_Cmp( stSc.PHOTO_BAR_YN, "Y" ) != 0 )
			{
				MessageBoxEx (CONFIRM_OK, "���ڵ� �Ұ����� ������\n�Կ����ּ���.");
				return ret;
			}
		}
		
		ret = TRUE;
		
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Save_Result
	��  �� : ���� ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	bool Save_Result(void)
	{
		char szSql[500];
		char szToday[15];
		char sztmp[15];
		long idx, i;
		long lCount = 0;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		long lsign, lSign_Len;
		char* pRst;
		SQLITE sql = NewSqLite();
		
		long lExcepCnt = 0;
		
		/********************************************/
		/* ����                                     */
		/********************************************/
		// lsign = GetSignImgTitle ( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "�� �� �� ��" );
		// 2016-06-02 Sanghyun Lee , ���ǿ� ���� ���� ���� �߰�
		// SIGN_OPT_NONE : �ʼ��� �Է��ؾ��ϴ� ���� , SIGN_OPT_CHECK : �Է����� �ʾƵ� �Ѿ���ִ� ����
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
		
		/********************************************/
		/* ����                                     */
		/********************************************/
		if( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") != 0 && Str_Cmp(stSc.PREUSE_CHK_WHY, "30") != 0 )
		{
			if( m_nNogoodCnt > 0)
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				lExcepCnt = 0;
				
				// �����ǰ� �׸� ����
				SPRINT(szSql, " SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND EXCEP_PREUSE_CHK = 'Y' ", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetInt(szSql, &lExcepCnt);
					
				if( lExcepCnt == 0 )
				{
					if( !New_Nogood() )
					{
						ret = FALSE;
						goto Finally;
					}
	
					//�����ǰ� ��������
					if( !Save_Issue() )
					{
						ret = FALSE;
						goto Finally;
					}
				}
			}
		}
		
		/********************************************/
		/* ������                                   */
		/********************************************/
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		Str_ItoA(Time_GetDate(), szToday, 10);
		
		Mem_Set( (byte*)stSc.CHK_YMD, 0x00, sizeof(stSc.CHK_YMD) );
		Str_Cpy(stSc.CHK_YMD, szToday);
		g_Str_TimeType( stSc.CHK_TIME_TO , Time_GetTime());
		
		/********************************************/
		/* ���                                     */
		/********************************************/
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		/*
			2016-10-14 Sanghyun Lee
			PDA�� �����ϰ� -> ������ ���� ���ο� ������� ��� �����հ����� �ľ��Ͽ� ������&���� �Ǵ�
			SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND (BETTER_YN = 'N' OR BETTER_YN IS NULL)", g_szCHK_EXEC_NUM, 0, 0);
		*/
		
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCount);
		
		Mem_Set( (byte*)stSc.CHK_RSLT, 0x00, sizeof(stSc.CHK_RSLT) );
		
		if( lCount > 0 )
		{
			Str_Cpy(stSc.CHK_RSLT, "21");
		}
		else
		{
			Str_Cpy(stSc.CHK_RSLT, "20");
		}
		
		Mem_Set( (byte*)stSc.SEND_YN, 0x00, sizeof(stSc.SEND_YN) );
		Str_Cpy(stSc.SEND_YN, "S");

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		// 2016-05-23 Sanghyun Lee / ���ǿ� ���� ������ �Է����� �ʰ� ��ҹ�ư�� ������ �Ǹ� ����ǵ��� ����
		if( lsign == SIGN_RET_SUCCESS )
		{
			hstmt = sql->CreateStatement(sql, " UPDATE NORMAL_DATA \
												   SET CHK_RSLT = ?, LOC_RSLT = ?, PIPE_RSLT = ?, MTR_RSLT = ?, BO_RSLT = ? \
												     , BUR_FLAG = ?, CUST_FLAG = ?, COMP_CHK_OBJ_YN = ?,NOGOOD_RSLT = ?, CURR_BAR = ? \
												     , BAR_WHY = ?, CHKER_NM = ?, CHK_EMPID= ?, CHK_YMD = ?, CHK_TIME_FROM= ? \
												     , CHK_TIME_TO = ?, SIGN_RELAT = ?, SIGN = ?, SEND_YN = ?, UPD_EMPID = ? \
												     , PDA_IP = ? \
												 WHERE CHK_EXEC_NUM = ? ");
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}

			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_RSLT		    ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.LOC_RSLT		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.PIPE_RSLT		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.MTR_RSLT		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.BO_RSLT			    ,1 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stSc.BUR_FLAG		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CUST_FLAG		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.COMP_CHK_OBJ_YN	    ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.NOGOOD_RSLT		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CURR_BAR		    ,20,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stSc.BAR_WHY			    ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor	    ,12,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YMD			    ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TIME_FROM		,6 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TIME_TO			,6 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.SIGN_RELAT		    ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)pRst			            ,Str_Len(pRst) ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.SEND_YN			    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,20,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      ,32,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM		    ,12,DECRYPT);
		}
		else
		{
			hstmt = sql->CreateStatement(sql, " UPDATE NORMAL_DATA \
												   SET CHK_RSLT = ?, LOC_RSLT = ?, PIPE_RSLT = ?, MTR_RSLT = ?, BO_RSLT = ? \
													 , BUR_FLAG = ?, CUST_FLAG = ?, COMP_CHK_OBJ_YN = ?, NOGOOD_RSLT = ?, CURR_BAR = ? \
													 , BAR_WHY = ?, CHKER_NM = ?, CHK_EMPID= ?, CHK_YMD = ?,CHK_TIME_FROM= ? \
													 , CHK_TIME_TO = ?, SIGN_RELAT = ?, SEND_YN = ?, UPD_EMPID = ?, PDA_IP = ? \
												 WHERE CHK_EXEC_NUM = ? ");
	 		
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				ret = FALSE;
				goto Finally;
			}
	  
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_RSLT		    ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.LOC_RSLT		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.PIPE_RSLT		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.MTR_RSLT		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.BO_RSLT			    ,1 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stSc.BUR_FLAG		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CUST_FLAG		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.COMP_CHK_OBJ_YN	    ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.NOGOOD_RSLT		    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CURR_BAR		    ,20,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stSc.BAR_WHY			    ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.sznm_kor	    ,12,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YMD			    ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TIME_FROM		,6 ,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TIME_TO			,6 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.SIGN_RELAT		    ,2 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stSc.SEND_YN			    ,1 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,20,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      ,32,DECRYPT);
			
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM		    ,12,DECRYPT);
		}

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "������ �Ϸ�Ǿ����ϴ�.");
		}
		
Finally:
		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		DelSqLite(sql);
		
		if( ret == TRUE )
		{
			//���Ϸ� SEQ �ʱ�ȭ
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE NORMAL_BUR SET SEQ = null WHERE CHK_EXEC_NUM = '%s' " , g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute( szSql );
		}
		
		return ret;
	}
	

	/*=======================================================================================
	�Լ��� : Next_SC
	��  �� : ���˿Ϸ� ���� ������� �̵��Ѵ�.
	Param  : 
	Return : 
	========================================================================================*/
	void Next_SC(void)
	{
		long ltotcnt;
		
		ltotcnt = FS_GetSrchTotCnt();
		
		g_nActIndex++;
		g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

		if( g_nActIndex > ltotcnt || g_lindex < 0 )
		{
			if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
			{
				g_nActIndex = g_nActIndex-1;
			}
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		}
		
		Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
		//g_nAddrFlag = 0;
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
	�Լ��� : Save_Issue
	��  �� : �����ǰ� ����
	Param  : 
	Return : 
	========================================================================================*/
	bool Save_Issue(void)
	{
		char szZero[10];
		long idx;
		long i;
		long lDegree = 0;
		long lCount;
		long lDate;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		// 1. ��������
		Str_Chg( stScNogoodCha.BETTER_ADVICE_DEGREE, STRCHG_CONV_ZERO_TO_SPACE);
		Str_Chg( stScNogoodCha.BETTER_ADVICE_DEGREE, STRCHG_DEL_NONDIGIT);
		
		lDegree = Str_AtoI(stScNogoodCha.BETTER_ADVICE_DEGREE)+1;	
			
		Str_ItoA(lDegree, stScNogoodCha.BETTER_ADVICE_DEGREE, 10);
		
		if( Str_AtoI(stScNogoodCha.BETTER_ADVICE_DEGREE) < 10 )
		{
			Mem_Set( (byte*)szZero, 0x00, sizeof(szZero) );
			Str_Cpy(szZero, "0");
			Str_Cat(szZero, stScNogoodCha.BETTER_ADVICE_DEGREE);
			
			Mem_Set( (byte*)stScNogoodCha.BETTER_ADVICE_DEGREE, 0x00, sizeof(stScNogoodCha.BETTER_ADVICE_DEGREE) );
			Str_Cpy(stScNogoodCha.BETTER_ADVICE_DEGREE, szZero);
		}

		// 2. �����ǰ�����
		lDate = Time_GetDate();
		Str_ItoA(lDate, stScNogoodCha.BETTER_ADVICE_YMD, 10);
		
		// 3. �����ǰ����	
		lDate = Time_DateUpDown(lDate, 30);
		Str_ItoA(lDate, stScNogoodCha.BETTER_ADVICE_EXPIRE, 10);	
		
		// 4. ���˽����ȣ
		Mem_Set( (byte*)stScNogoodCha.CHK_EXEC_NUM, 0x00, sizeof(stScNogoodCha.CHK_EXEC_NUM) );
		Mem_Set( (byte*)stScNogoodCha.SEND_YN, 0x00, sizeof(stScNogoodCha.SEND_YN) );
		Mem_Set( (byte*)stScNogoodCha.BETTER_YN, 0x00, sizeof(stScNogoodCha.BETTER_YN) );
		
		Str_Cpy(stScNogoodCha.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
		Str_Cpy(stScNogoodCha.SEND_YN, "S");
		Str_Cpy(stScNogoodCha.BETTER_YN, "N");
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			lDegree = Str_AtoI(stScNogoodCha.BETTER_ADVICE_DEGREE)-1;		
			Str_ItoA(lDegree, stScNogoodCha.BETTER_ADVICE_DEGREE, 10);
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, " INSERT INTO NORMAL_NOGOOD_CHA \
											( BETTER_ADVICE_YMD, BETTER_ADVICE_EXPIRE, SUPPLY_STOP_YMD, NOT_PERMIT_WHY, CHK_EXEC_NUM \
											, BETTER_ADVICE_DEGREE, INST_PLACE_NUM, OBJ_YM, CHK_TYPE, BETTER_YN \
											, BETTER_END_YMD, PRE_CHK_OBJ_YN, SEND_YN, PDA_IP, UPD_EMPID \
											, BLD_NUM, CHK_YEAR, CHK_ORDER, PLAN_YM ) \
											VALUES \
											( ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
										    , ?, ?, ?, ?, ? \
										    , ?, ?, ?, ? )" 
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			
			lDegree = Str_AtoI(stScNogoodCha.BETTER_ADVICE_DEGREE)-1;		
			Str_ItoA(lDegree, stScNogoodCha.BETTER_ADVICE_DEGREE, 10);
			
			ret = FALSE;
			
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.BETTER_ADVICE_YMD   , 8 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.BETTER_ADVICE_EXPIRE, 8 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.SUPPLY_STOP_YMD     , 8 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.NOT_PERMIT_WHY      , 2 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.CHK_EXEC_NUM        , 12, DECRYPT);
		 
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.BETTER_ADVICE_DEGREE, 2 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM               , 9 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM                       , 6 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE                     , 2 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.BETTER_YN           , 1 , DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.BETTER_END_YMD      , 8 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.PRE_CHK_OBJ_YN      , 1 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScNogoodCha.SEND_YN             , 1 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip               , 32, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id          , 20, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM                      , 9 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR                     , 4 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER                    , 2 , DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM                      , 6 , DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			
			lDegree = Str_AtoI(stScNogoodCha.BETTER_ADVICE_DEGREE)-1;		
			Str_ItoA(lDegree, stScNogoodCha.BETTER_ADVICE_DEGREE, 10);
			
			ret = FALSE;
			
			goto Finally;
		}
				
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : New_Nogood
	��  �� : ������ ���� ����� NORMAL_NOGOOD ���̺� ������ �߰�
	Param  : 
	Return : 
	========================================================================================*/
	bool New_Nogood(void)
	{
		char sztmp[300];
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)stSc.SEND_YN, 0x00, sizeof(stSc.SEND_YN) );
		Str_Cpy(stSc.SEND_YN, "S" );
			
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, " INSERT INTO NORMAL_NOGOOD \
											( CHK_EXEC_NUM, ZIP_NO1, ZIP_NO2, CITY, COUNTY \
											, TOWN, VILLAGE, ADDR1_M, ADDR1_S, LOT_NUM_SECOND_ADDR \
											, CO_LIVE_NM, HOUSE_CNT, BLD_NM, DETA_FLOOR, INST_PLACE_NUM \
											, CHK_TYPE, CHK_YEAR, CHK_ORDER, OBJ_YM, PLAN_YM \
											, CUST_NUM, CUST_NM, CUST_TYPE_CD, CUST_TRND_CD, USE_CONT_NUM \
											, FIRM_NM, BIZ_REGI_NUM, SOC_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN \
											, OWNHOUSE_TEL_NUM, CP_DDD, CP_EXN, CP_NUM, CENTER_CD \
											, ZONE_MANAGE_NUM, SEND_YN, PDA_IP, UPD_EMPID, BLD_NUM \
											, SMS_SEND_AGREE_YN, LAW_TOWN, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S ) \
											VALUES \
											( ?, ?, ?, ?, ? \
										    , ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? \
											, ?, ?, ?, ?, ? ) "
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_EXEC_NUM        ,  12, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.ZIP_NO1             ,   3, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.ZIP_NO2             ,   3, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CITY                ,  30, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.COUNTY              ,  30, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.TOWN                ,  30, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.VILLAGE             ,  30, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.ADDR1_M             ,  30, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.ADDR1_S             ,  30, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.LOT_NUM_SECOND_ADDR , 100, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.CO_LIVE_NM          ,  60, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.HOUSE_CNT           ,   6, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NM              , 150, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.DETA_FLOOR          ,   6, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM      ,   9, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE            ,   2, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR            ,   4, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER           ,   2, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM              ,   6, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM             ,   6, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.CUST_NUM            ,  10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CUST_NM             ,  30, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CUST_TYPE_CD        ,   2, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CUST_TRND_CD        ,   2, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.USE_CONT_NUM        ,  10, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.FIRM_NM             ,  50, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BIZ_REGI_NUM        ,  10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.SOC_NUM             ,  13, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OWNHOUSE_TEL_DDD    ,   4, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OWNHOUSE_TEL_EXN    ,   4, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.OWNHOUSE_TEL_NUM    ,   4, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CP_DDD              ,   4, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CP_EXN              ,   4, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CP_NUM              ,   4, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CENTER_CD           ,   2, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.ZONE_MANAGE_NUM     ,   5, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.SEND_YN             ,   1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip      ,  32, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id ,  20, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM             ,   9, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.SMS_SEND_AGREE_YN   ,  2,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.LAW_TOWN            , 30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.NEW_ROAD_NM         ,100,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.NEW_ADDR_M          , 10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.NEW_ADDR_S          , 10,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : OnUart
	��  �� : ���ڵ� / ī�޶�
	Param  : 
	Return : 
	========================================================================================*/
	void OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		char szTmp[256];
		int size = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			if (nEvent == UART_BARCODE)
			{
				OnBarcodeRead();		
			}
			else if(nEvent == UART_CAMERA)
			{
				if(nData == 1 )
				{
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
					SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
					
					if( FFS_Exist(szfilenm) )
					{
						size = FFS_GetSize( szfilenm );
						
						if( size > 1048576 )
						{
							MessageBoxEx (CONFIRM_OK, "���� �뷮�� �ʰ��Ͽ����ϴ�.\nī�޶� ���� Ȥ�� ���Կ����ּ���.");
						}
						else
						{
							FFS_Copy(szfilenm, g_szphoto);
	
							MessageBoxEx(MESSAGE, "������ �������Դϴ�.");

							Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
							SPRINT(szTmp, "UPDATE NORMAL_DATA SET PHOTO_BAR_YN = 'Y' WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
							g_Sql_DirectExecute(szTmp);
							
							Mem_Set((byte*)stSc.PHOTO_BAR_YN, 0x00, sizeof(stSc.PHOTO_BAR_YN));
							Str_Cpy(stSc.PHOTO_BAR_YN, "Y");	
						}
						
						VmSleep(100);
						FFS_Delete( szfilenm );
						
						REDRAW();
					}
				}
			}
		}
	}

	/*=======================================================================================
	�Լ��� : OnTask
	��  �� : ī�޶� ���ڵ�
	Param  : 
	Return : 
	========================================================================================*/
	void OnTask(long nEvent, long nData)
	{
		char* ptr;
		long nRet = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			if(nEvent == TASK_SYS_CALL && nData == TASK_BARCODE )
			{
				//ī�޶� ���ڵ� ��ĵ ��
				Mem_Set( (byte*)m_szBartmp, 0x00, sizeof(m_szBartmp) );
				ptr = (char*)System_GetResult((char*)&nRet);
				Str_Cpy(m_szBartmp, ptr);
	
				OnBarcodeRead();
			}
		}
	}

	/*=======================================================================================
	�Լ��� : Barcode
	��  �� : ���ڵ�
	Param  : 
	Return : 
	========================================================================================*/
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
			
			if(h)
			{
				hdata = JSON_Create( JSON_Object );
				
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				JSON_SetValue	(hdata	, 'C', "desc"				, "ī�޶���ڵ�");
				JSON_SetValue	(hdata	, 'C', "imgSaveEnabled"		, "false");
				JSON_SetValue	(hdata	, 'C', "imgOutPath"			, "Barcode/barcode.jpg");
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
	}
	

	/*=======================================================================================
	�Լ��� : OnBarcodeRead
	��  �� : ���ڵ�
	Param  : 
	Return : 
	========================================================================================*/
	void OnBarcodeRead(void)
	{
		char szBar[50];
		char szSql[300];
		char szFilenm[100];
		char szTmp[100];
		long ret = 0;
		long lFlag = 100;

		if( Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Mem_Set( (byte*)m_szBartmp, 0x00, sizeof(m_szBartmp) );
			ret = Barcode_Read( m_szBartmp );
			
			if( ret < 0 )
			{
				lFlag = 0;
				goto Finally;
			}
		}
		
		Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
		Mem_Cpy((byte *)szBar, (byte *)m_szBartmp, 9);

		if( Str_Cmp(stSc.INST_PLACE_NUM, szBar) == 0 )	
		{
			// 1. ���ڵ� ����
			Mem_Set( (byte*)stSc.CURR_BAR, 0x00, sizeof(stSc.CURR_BAR) );
			Str_Cpy(stSc.CURR_BAR, m_szBartmp);
			
			//2. ���� DB ������Ʈ
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_DATA SET CURR_BAR = '%s' WHERE CHK_EXEC_NUM = '%s' ", stSc.CURR_BAR, g_szCHK_EXEC_NUM, 0);
			g_Sql_DirectExecute(szSql);
			
			// 3. ���ڵ� �Ұ����� �ʱ�ȭ
			Mem_Set( (byte*)stSc.BAR_WHY, 0x00, sizeof(stSc.BAR_WHY) );
			Str_Cpy(stSc.BAR_WHY, "");				
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARWHY), "");
			
			// 4. ���ڵ� �Ұ����� ������ �ʱ�ȭ
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_DATA SET BAR_WHY = NULL WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute(szSql);	
			
			// 5. ���ڵ� �Ұ����� ���� ������ �ʱ�ȭ
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_DATA SET PHOTO_BAR_YN = 'N' WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute(szSql);	
			
			// 6. ���ڵ� �Ұ����� ���� ����	
			Mem_Set((byte*)szFilenm, 0x00, sizeof(szFilenm));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			Str_Cpy(szTmp, "C42_");
			Str_Cat(szTmp, g_szCHK_EXEC_NUM);
			Str_Cat(szTmp, "_");						
			Str_Cat(szTmp, stSc.INST_PLACE_NUM);
			Str_Cat(szTmp, ".jjp");
			
			SPRINT (szFilenm, "%s/%s", PHOTO_SCBAR, szTmp, 0);
			
			if( FFS_Exist(szFilenm) > 0 )
			{
				FFS_Delete(szFilenm);
			}
			
			// 7. ���ڵ��ν� ǥ��
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), "���ڵ� �ν� ����" ) ;
			
			// 8. ���ڵ� �Ұ����� �޺��ڽ�
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY+1), TRUE );
			
			// 9. ���ڵ� �Ұ����� ������ư
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_PHOTO), TRUE );
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BAR_PHOTO), YELLOW);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BAR_PHOTO), TXTFRCOLOR);
		}
		else
		{
			lFlag = 1;
		}

Finally:
		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}
		
		if( lFlag == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� �б� ����");
		}
		else if( lFlag == 1 )
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� ������ ���� �ʽ��ϴ�.");
		}
		
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : PDA_OnBarcodeRead
	��  �� : PDA ���ڵ�
	Param  : 
	Return : 
	========================================================================================*/
	void PDA_OnBarcodeRead(void)
	{
		char szSql[400];
		char szBar[20];
		long ret = 0;
		long lFlag = 100;

		Mem_Set( (byte*)m_szBartmp, 0x00, sizeof(m_szBartmp) );
		Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
		
		ret = Barcode_Read( m_szBartmp );

		if( ret < 0)
		{
			lFlag = 0;
			goto Finally;
		}
		else
		{
			Mem_Set( (byte*)szBar, 0x00, sizeof(szBar) );
			Mem_Cpy((byte *)szBar, (byte *)m_szBartmp, 9);

			if( Str_Cmp(stSc.INST_PLACE_NUM, szBar) == 0 )	
			{
				//���ڵ� ����
				Str_Cpy(stSc.CURR_BAR, m_szBartmp);
				//Str_Cpy(g_szCurrBar, sztmp);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), m_szBartmp ) ;
				
				//���ڵ� �Ұ�����
				Str_Cpy(stSc.BAR_WHY, "");				
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BARWHY), "");
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BARWHY+1), TRUE );
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "UPDATE NORMAL_DATA SET CURR_BAR = '%s' WHERE CHK_EXEC_NUM = '%s' ", stSc.CURR_BAR, g_szCHK_EXEC_NUM, 0);
				g_Sql_DirectExecute(szSql);				
			}
			else
			{
				lFlag = 1;
			}
		}

Finally:
		if( lFlag == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� �б� ����");
		}
		else if( lFlag == 1 )
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� ������ ���� �ʽ��ϴ�.");
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Sms
	��  �� : ������, ���� �׸� ����
	Param  : 
	Return : // -������-
			 // 1. xxxx�� xx�� xx��(������) �� ���� �������� ��� ������ ������ �߻��Ǿ� �ȳ��帮���� ������ ������ ��û�帳�ϴ�.
			 // 2. �����ճ��� : NOT_PASS_ITEM_NM(�������׸�)
			 //    �������� : xxxx.xx.xx
			 // 3. ���ﵵ�ð��� xxx ������
		     //    �������˿� : xxx(xxx-xxxx-xxxx)
		     //    *�����ð��� ��ȭ�����մϴ�.
		     //    (09��~18��)
		    
		     // -�����ǰ�-
			 // 1. xxxx�� xx�� xx��(������) �� ���� �������� ��� �����ǰ� ������ �߻��Ǿ� �ȳ��帮���� ������ ������ ��û�帳�ϴ�.
			 // 2. �����ǰ��� : NOT_PASS_ITEM_NM(�����ǰ��׸�)
			 //    �������� : xxxx.xx.xx
			 // 3. ���ﵵ�ð��� xxx ������
		     //    �������˿� : xxx(xxx-xxxx-xxxx)
		     //    *�����ð��� ��ȭ�����մϴ�.
		     //    (09��~18��)
		    
		     // -������+�����ǰ�-
			 // 1. xxxx�� xx�� xx��(������) �� ���� �������� ��� ������, �����ǰ� ������ �߻��Ǿ� �ȳ��帮���� ������ ������ ��û�帳�ϴ�.
			 // 2. �����ճ��� : NOT_PASS_ITEM_NM(�������׸�)
			 //    �����ǰ��� : NOT_PASS_ITEM_NM(�����ǰ��׸�)
			 //    �������� : xxxx.xx.xx
			 // 3. ���ﵵ�ð��� xxx ������
		     //    �������˿� : xxx(xxx-xxxx-xxxx)
		     //    *�����ð��� ��ȭ�����մϴ�.
		     //    (09��~18��)
		    
		     // -(��������, �÷��׸����̺�)-
			 // 1. xxxx�� xx�� xx��(������) �� ���� �������� ��� ������ ������ �߻��Ǿ� �ȳ��帮���� ������ ������ ��û�帳�ϴ�.
			 // 2. �����ճ��� : (��������, �÷��׸����̺�)
			 //    �������� : ��ð������
			 // 3. ���ﵵ�ð��� xxx ������
		     //    �������˿� : xxx(xxx-xxxx-xxxx)
		     //    *�����ð��� ��ȭ�����մϴ�.
		     //    (09��~18��)
		     
		     // -������+(��������, �÷��׸����̺�)-
			 // 1. xxxx�� xx�� xx��(������) �� ���� �������� ��� ������ ������ �߻��Ǿ� �ȳ��帮���� ������ ������ ��û�帳�ϴ�.
			 // 2. �����ճ��� : NOT_PASS_ITEM_NM(�������׸�)
			 //    �������� : xxxx.xx.xx
			 // 3. �����ճ��� : (��������, �÷��׸����̺�)
			 //    �������� : ��ð������
			 // 4. ���ﵵ�ð��� xxx ������
		     //    �������˿� : xxx(xxx-xxxx-xxxx)
		     //    *�����ð��� ��ȭ�����մϴ�.
		     //    (09��~18��)
		    
		     // -������+�����ǰ�+(��������, �÷��׸����̺�)-
			 // 1. xxxx�� xx�� xx��(������) �� ���� �������� ��� ������, �����ǰ� ������ �߻��Ǿ� �ȳ��帮���� ������ ������ ��û�帳�ϴ�.
			 // 2. �����ճ��� : NOT_PASS_ITEM_NM(�������׸�)
			 //    �����ǰ��� : NOT_PASS_ITEM_NM(�����ǰ��׸�)
			 //    �������� : xxxx.xx.xx
			 // 3. �����ճ��� : (��������, �÷��׸����̺�)
			 //    �������� : ��ð������
			 // 4. ���ﵵ�ð��� xxx ������
		     //    �������˿� : xxx(xxx-xxxx-xxxx)
			 //    *�����ð��� ��ȭ�����մϴ�.
		     //    (09��~18��)
    /*========================================================================================*/
	long Snd_Sms(void)
	{
		char szSql[800];
		char szMsg[300];
		char szMsg2[300];
		
		char szUserTel[20];
		char szUserTel2[20];
		
		char szNogoodMsg[1500];
		char szNogoodMsg2[1500];
		char szNogoodItem[200];
		char szNogoodItem2[200];
		
		char szPlanYmd[20][20];
		char szDate[20];
		char szYear[20];
		char szMonth[20];
		char szDay[20];
		
		char szNogoodDate[30];
		
		char szRecvTelDdd[6];
		char szRecvTelExn[6];
		char szRecvTelNum[6];
		
		long lNogoodCnt = 0; 	// ���Ϸ����������� �� COUNT
		long lNogoodCnt2 = 0;	// ���Ϸ����������� COUNT
		long lNogoodCnt3 = 0;	// ��������, �÷��׸����̺� COUNT
		
		long lPlanYmdCnt = 0;
		long idx, i, j;
		long lret = -1;
		long lTime = 100;
		
		long lChkCnt1 = 0;
		long lChkCnt2 = 0;
		
		handle hdb = NULL;
		handle hstmt = NULL;
		
		SQLITE sql = NewSqLite();
		
		/*******************************************************************/
		/* ��ȭ��ȣ ����                                                   */
		/*******************************************************************/
		Mem_Set( (byte*)szUserTel, 0x00, sizeof(szUserTel) );
		Tapi_GetPhoneNum( (byte*)szUserTel, 0);
		Str_Chg( szUserTel, STRCHG_DEL_NONDIGIT);

		// �׽�Ʈ ���� ���� ��ȣ �Է� 
		//Mem_Set( (byte*)m_szReceiver_Tel, 0x00, sizeof(m_szReceiver_Tel) );
		//Str_Cpy(m_szReceiver_Tel, "01023100247");
		
		// ����� ���� ���� ��ȣ.
		Mem_Set( (byte*)m_szReceiver_Tel, 0x00, sizeof(m_szReceiver_Tel) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ifnull(CP_DDD, '') ||''|| ifnull(CP_EXN, '') ||''|| ifnull(CP_NUM, '') FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s'",g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 30, m_szReceiver_Tel );
		Str_Chg( m_szReceiver_Tel, STRCHG_DEL_NONDIGIT);
		
		// ���� ��ȭ��ȣ üũ ����
		Mem_Set((byte*)szRecvTelDdd, 0x00, sizeof(szRecvTelDdd));	
		Mem_Set((byte*)szRecvTelExn, 0x00, sizeof(szRecvTelExn));	
		Mem_Set((byte*)szRecvTelNum, 0x00, sizeof(szRecvTelNum));
		Analy_Phone(m_szReceiver_Tel, szRecvTelDdd, szRecvTelExn, szRecvTelNum);
		
		if( !g_CheckPhoneNumberFormat( szRecvTelExn, szRecvTelNum) )
		{
			return -1;
		}
		
		/*******************************************************************/
		/* 1.������/�����ǰ� ���� ����                                     */
		/*******************************************************************/
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		Str_ItoA(Time_GetDate(), szDate, 10);
		Mem_Cpy((byte *)szYear, (byte *)szDate, 4);
		Mem_Cpy((byte *)szMonth, (byte *)szDate+4, 2);
		Mem_Cpy((byte *)szDay, (byte *)szDate+6, 2);

		// ���Ϸ����������� �� COUNT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND NOT ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD= '80') AND EXCEP_PREUSE_CHK <> 'Y' ", g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt( szSql, &lChkCnt1 );
		
		// ���Ϸ����������� COUNT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD = '80')  AND EXCEP_PREUSE_CHK <> 'Y' ", g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt( szSql, &lChkCnt2 );
		
		Mem_Set( (byte*)szNogoodMsg, 0x00, sizeof(szNogoodMsg) );

		if( lChkCnt1 == 0 && lChkCnt2 > 0 ) // �����ǰ�
		{
			SPRINT( szNogoodMsg, "%s�� %s�� %s��(������) �� ���� �������� ��� �����ǰ� ������ �߻��Ǿ� �ȳ��帮���� ������ ������ ��û�帳�ϴ�.", szYear, szMonth, szDay );
		}
		else if( lChkCnt1 > 0 &&  lChkCnt2 == 0 ) // ������
		{
			SPRINT( szNogoodMsg, "%s�� %s�� %s��(������) �� ���� �������� ��� ������ ������ �߻��Ǿ� �ȳ��帮���� ������ ������ ��û�帳�ϴ�.", szYear, szMonth, szDay );
		}
		else // ������, �����ǰ�
		{
			SPRINT( szNogoodMsg, "%s�� %s�� %s��(������) �� ���� �������˰�� ������, �����ǰ������ �߻��Ǿ� �ȳ��帮���� ������ ������ ��û�帳�ϴ�.", szYear, szMonth, szDay );
		}
		
		/*******************************************************************/
		/* 2.������/�����ǰ� �� ����                                     */
		/*******************************************************************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, "SELECT COUNT(1) \
					  	  FROM ( SELECT DISTINCT BETTER_PLAN_YMD \
								   FROM NORMAL_NOGOOD_DETAL \
							  	  WHERE CHK_EXEC_NUM = '%s' \
							   	    AND NOT ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
								    AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
								    AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) \
								    AND EXCEP_PREUSE_CHK <> 'Y' )", g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt( szSql, &lPlanYmdCnt );
		
		Mem_Set( (byte*)szPlanYmd, 0x00, sizeof(szPlanYmd) );
		
		for( i = 0; i < lPlanYmdCnt; i++ )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, "SELECT BETTER_PLAN_YMD \
							  FROM NORMAL_NOGOOD_DETAL \
						 	 WHERE CHK_EXEC_NUM = '%s' \
						   	   AND NOT ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
							   AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
							   AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) \
							   AND EXCEP_PREUSE_CHK <> 'Y' \
							 GROUP BY BETTER_PLAN_YMD LIMIT %d, 1", g_szCHK_EXEC_NUM, i, 0 );
			g_Sql_RetStr( szSql, 30, szPlanYmd[i] );
		}
		
		for( j = 0; j < lPlanYmdCnt; j++ )
		{
			Str_Cat(szNogoodMsg, "\n");
		
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " SELECT COUNT(1) \
			                   FROM NORMAL_NOGOOD_DETAL \
			                  WHERE CHK_EXEC_NUM = '%s' \
			                    AND BETTER_PLAN_YMD = '%s' \
			                    AND NOT ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD = '80' ) \
								AND NOT ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
								AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
								AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) \
								AND EXCEP_PREUSE_CHK <> 'Y' ", g_szCHK_EXEC_NUM, szPlanYmd[j], 0 );
			g_Sql_RetInt( szSql, &lNogoodCnt );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " SELECT COUNT(1) \
						 	   FROM NORMAL_NOGOOD_DETAL \
							  WHERE CHK_EXEC_NUM = '%s' \
							    AND BETTER_PLAN_YMD = '%s' \
							    AND ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD = '80' ) \
							    AND EXCEP_PREUSE_CHK <> 'Y' ", g_szCHK_EXEC_NUM, szPlanYmd[j], 0 );
							    
			g_Sql_RetInt( szSql, &lNogoodCnt2 );
			
			Mem_Set( (byte*)szNogoodMsg2, 0x00, sizeof(szNogoodMsg2) );
			Mem_Set( (byte*)szNogoodItem, 0x00, sizeof(szNogoodItem) );
			Mem_Set( (byte*)szNogoodItem2, 0x00, sizeof(szNogoodItem2) );
			
			/************** 2-1.������ �󼼹��� **************/
			for( i = 0; i < lNogoodCnt; i++ )
			{	
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szNogoodItem, 0x00, sizeof(szNogoodItem) );
				
				SPRINT( szSql, " SELECT NOT_PASS_ITEM_NM \
								   FROM NORMAL_NOGOOD_DETAL \
							 	  WHERE CHK_EXEC_NUM = '%s' \
							        AND BETTER_PLAN_YMD = '%s' \
								    AND NOT ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD = '80' ) \
									AND NOT ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
									AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
									AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) \
									AND EXCEP_PREUSE_CHK <> 'Y' LIMIT %d, 1 ", g_szCHK_EXEC_NUM, szPlanYmd[j], i );
				g_Sql_RetStr( szSql, 50, szNogoodItem );
	
				if( i == 0 )
				{
					Str_Cat(szNogoodMsg, "�����ճ��� : ");	
					Str_Cat(szNogoodMsg, szNogoodItem);

					if( lNogoodCnt > 1 )
					{
						Str_Cat(szNogoodMsg, ", ");
					}
				}
				else
				{
					Str_Cat(szNogoodMsg, szNogoodItem);

					if( i < lNogoodCnt-1 )
					{
						Str_Cat(szNogoodMsg, ", ");
					}
				}	
			}
			
			if( lNogoodCnt > 0 && lNogoodCnt2 > 0 )
			{
				Str_Cat(szNogoodMsg, "\n");
			}
			
			/************** 2-2.���� �󼼹��� **************/
			for( i = 0; i < lNogoodCnt2; i++ )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szNogoodItem2, 0x00, sizeof(szNogoodItem2) );
	
				SPRINT( szSql, " SELECT NOT_PASS_ITEM_NM \
								   FROM NORMAL_NOGOOD_DETAL \
							  	  WHERE CHK_EXEC_NUM = '%s' \
								    AND BETTER_PLAN_YMD = '%s' \
								    AND ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD = '80' ) \
								    AND EXCEP_PREUSE_CHK <> 'Y' LIMIT %d, 1 ", g_szCHK_EXEC_NUM, szPlanYmd[j], i );
				g_Sql_RetStr( szSql, 50, szNogoodItem2 );
				
				if( i == 0 )
				{
					Str_Cpy(szNogoodMsg2, "�����ǰ��� : ");
					Str_Cat(szNogoodMsg2, szNogoodItem2);

					if( lNogoodCnt2 > 1 )
					{
						Str_Cat(szNogoodMsg2, ", ");
					}
				}
				else
				{
					Str_Cat(szNogoodMsg2, szNogoodItem2);
					
					if( i < lNogoodCnt2-1 )
					{
						Str_Cat(szNogoodMsg2, ", ");
					}
				}	
			}
			
			Str_Cat(szNogoodMsg, szNogoodMsg2);
			Str_Cat(szNogoodMsg, "\n");
			
			/************** 2-3.�������� **************/
			Str_Cat(szNogoodMsg, "�������� : ");
			
			Mem_Set( (byte*)szNogoodDate, 0x00, sizeof(szNogoodDate) );
			g_Str_DateType(szNogoodDate, szPlanYmd[j]);
			Str_Cat(szNogoodMsg, szNogoodDate);
		}
		
		/*******************************************************************/
		/* 3.��������, �÷��׸����̺�                                      */
		/*******************************************************************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT COUNT(1) \
						   FROM NORMAL_NOGOOD_DETAL \
						  WHERE CHK_EXEC_NUM = '%s' \
						    AND ( ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
							 OR   ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
							 OR   ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) )\
							AND EXCEP_PREUSE_CHK <> 'Y' ", g_szCHK_EXEC_NUM, 0, 0 );
							
		g_Sql_RetInt( szSql, &lNogoodCnt3 );
		
		if( lNogoodCnt3 > 0 )
		{
			Str_Cat(szNogoodMsg, "\n");
			
			Mem_Set( (byte*)szNogoodItem, 0x00, sizeof(szNogoodItem) );
			
			/************** 3-1.��������, �÷��׸����̺� �󼼹��� **************/
			for( i = 0; i < lNogoodCnt3; i++ )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szNogoodItem, 0x00, sizeof(szNogoodItem) );
				
				SPRINT( szSql, " SELECT CASE WHEN ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) OR ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) THEN CHK_SEC_NM || ' ' || NOT_PASS_ITEM_NM \
									         ELSE NOT_PASS_ITEM_NM \
									     END AS NOT_PASS_ITEM_NM \
								   FROM NORMAL_NOGOOD_DETAL \
								  WHERE CHK_EXEC_NUM = '%s' \
								    AND ( ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
									 OR   ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
									 OR   ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) ) \
									AND EXCEP_PREUSE_CHK <> 'Y' LIMIT %d, 1 ", g_szCHK_EXEC_NUM, i, 0 );
				g_Sql_RetStr( szSql, 50, szNogoodItem );
			
				if( i == 0 )
				{
					Str_Cat(szNogoodMsg, "�����ճ��� : ");	
					Str_Cat(szNogoodMsg, szNogoodItem);
			
					if( lNogoodCnt3 > 1 )
					{
						Str_Cat(szNogoodMsg, ", ");
					}
				}
				else
				{
					Str_Cat(szNogoodMsg, szNogoodItem);
			
					if( i < lNogoodCnt3-1 )
					{
						Str_Cat(szNogoodMsg, ", ");
					}
				}	
			}
	
			Str_Cat(szNogoodMsg, "\n");
			
			/************** 3-2.��������, �÷��׸����̺� �������� **************/
			Str_Cat(szNogoodMsg, "�������� : ��ð������");
		}
		
		/*******************************************************************/
		/* 4.���˿� �Ҽ�                                                   */
		/*******************************************************************/
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );
		Mem_Set( (byte*)szUserTel2, 0x00, sizeof(szUserTel2) );

		g_FormatPhoneNumber(szUserTel, szUserTel2);	
		
		SPRINT(szMsg, "\n���ﵵ�ð��� %s ������", stUserinfo.szcenter_nm, 0, 0);
		SPRINT(szMsg2, "\n�������˿� : %s(%s)\n*�����ð��� ��ȭ�����մϴ�.\n(09��~18��)", stUserinfo.sznm_kor, szUserTel2, 0);
		
		Str_Cat(szNogoodMsg, szMsg);
		Str_Cat(szNogoodMsg, szMsg2);
		
		Mem_Set( (byte*)m_szSms_Desc, 0x00, sizeof(m_szSms_Desc) );
		Str_Cpy(m_szSms_Desc, szNogoodMsg);
		
		lret = Tapi_SendSmsEx( m_szReceiver_Tel, szUserTel, szNogoodMsg, Str_Len(szNogoodMsg) );
		
		if(lret != 0)
		{
			switch(lret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
					return lret;
				case -2:
					MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
					return lret;
				case -3:
					MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
					return lret;
				case -4:
					MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
					return lret;
				default:
					MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
					return lret;
			}
		}
		
		VmSleep(lTime);
		
		/*******************************************************************/
		/* 2.������/�����ǰ� �� ����                                     */
		/*******************************************************************/
		/*
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, "SELECT COUNT(1) \
					  	  FROM ( SELECT DISTINCT BETTER_PLAN_YMD \
								   FROM NORMAL_NOGOOD_DETAL \
							  	  WHERE CHK_EXEC_NUM = '%s' \
							   	    AND NOT ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
								    AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
								    AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) \
								    AND EXCEP_PREUSE_CHK <> 'Y' )", g_szCHK_EXEC_NUM, 0, 0 );
		g_Sql_RetInt( szSql, &lPlanYmdCnt );
		
		Mem_Set( (byte*)szPlanYmd, 0x00, sizeof(szPlanYmd) );
		
		for( i = 0; i < lPlanYmdCnt; i++ )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, "SELECT BETTER_PLAN_YMD \
							  FROM NORMAL_NOGOOD_DETAL \
						 	 WHERE CHK_EXEC_NUM = '%s' \
						   	   AND NOT ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
							   AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
							   AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) \
							   AND EXCEP_PREUSE_CHK <> 'Y' \
							 GROUP BY BETTER_PLAN_YMD LIMIT %d, 1", g_szCHK_EXEC_NUM, i, 0 );
			g_Sql_RetStr( szSql, 30, szPlanYmd[i] );
		}
		
		for( j = 0; j < lPlanYmdCnt; j++ )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " SELECT COUNT(1) \
			                   FROM NORMAL_NOGOOD_DETAL \
			                  WHERE CHK_EXEC_NUM = '%s' \
			                    AND BETTER_PLAN_YMD = '%s' \
			                    AND NOT ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD = '80' ) \
								AND NOT ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
								AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
								AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) \
								AND EXCEP_PREUSE_CHK <> 'Y' ", g_szCHK_EXEC_NUM, szPlanYmd[j], 0 );
			g_Sql_RetInt( szSql, &lNogoodCnt );
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT( szSql, " SELECT COUNT(1) \
						 	   FROM NORMAL_NOGOOD_DETAL \
							  WHERE CHK_EXEC_NUM = '%s' \
							    AND BETTER_PLAN_YMD = '%s' \
							    AND ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD = '80' ) \
							    AND EXCEP_PREUSE_CHK <> 'Y' ", g_szCHK_EXEC_NUM, szPlanYmd[j], 0 );
							    
			g_Sql_RetInt( szSql, &lNogoodCnt2 );
			
			Mem_Set( (byte*)szNogoodMsg, 0x00, sizeof(szNogoodMsg) );
			Mem_Set( (byte*)szNogoodMsg2, 0x00, sizeof(szNogoodMsg2) );
			Mem_Set( (byte*)szNogoodItem, 0x00, sizeof(szNogoodItem) );
			Mem_Set( (byte*)szNogoodItem2, 0x00, sizeof(szNogoodItem2) );
		*/	
			/************** 2-1.������ �󼼹��� **************/
		/*
			for( i = 0; i < lNogoodCnt; i++ )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szNogoodItem, 0x00, sizeof(szNogoodItem) );
				
				SPRINT( szSql, " SELECT NOT_PASS_ITEM_NM \
								   FROM NORMAL_NOGOOD_DETAL \
							 	  WHERE CHK_EXEC_NUM = '%s' \
							        AND BETTER_PLAN_YMD = '%s' \
								    AND NOT ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD = '80' ) \
									AND NOT ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
									AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
									AND NOT ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) \
									AND EXCEP_PREUSE_CHK <> 'Y' LIMIT %d, 1 ", g_szCHK_EXEC_NUM, szPlanYmd[j], i );
				g_Sql_RetStr( szSql, 50, szNogoodItem );
	
				if( i == 0 )
				{
					Str_Cpy(szNogoodMsg, "�����ճ��� : ");	
					Str_Cat(szNogoodMsg, szNogoodItem);

					if( lNogoodCnt > 1 )
					{
						Str_Cat(szNogoodMsg, ", ");
					}
				}
				else
				{
					Str_Cat(szNogoodMsg, szNogoodItem);

					if( i < lNogoodCnt-1 )
					{
						Str_Cat(szNogoodMsg, ", ");
					}
				}	
			}
			
			if( lNogoodCnt > 0 && lNogoodCnt2 > 0 )
			{
				Str_Cat(szNogoodMsg, "\n");
			}
		*/	
			/************** 2-2.���� �󼼹��� **************/
		/*
			for( i = 0; i < lNogoodCnt2; i++ )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szNogoodItem2, 0x00, sizeof(szNogoodItem2) );
	
				SPRINT( szSql, " SELECT NOT_PASS_ITEM_NM \
								   FROM NORMAL_NOGOOD_DETAL \
							  	  WHERE CHK_EXEC_NUM = '%s' \
								    AND BETTER_PLAN_YMD = '%s' \
								    AND ( CHK_SEC_CD = '90' AND NOT_PASS_ITEM_CD = '80' ) \
								    AND EXCEP_PREUSE_CHK <> 'Y' LIMIT %d, 1 ", g_szCHK_EXEC_NUM, szPlanYmd[j], i );
				g_Sql_RetStr( szSql, 50, szNogoodItem2 );
				
				if( i == 0 )
				{
					Str_Cpy(szNogoodMsg2, "�����ǰ��� : ");
					Str_Cat(szNogoodMsg2, szNogoodItem2);

					if( lNogoodCnt2 > 1 )
					{
						Str_Cat(szNogoodMsg2, ", ");
					}
				}
				else
				{
					Str_Cat(szNogoodMsg2, szNogoodItem2);
					
					if( i < lNogoodCnt2-1 )
					{
						Str_Cat(szNogoodMsg2, ", ");
					}
				}	
			}
			
			Str_Cat(szNogoodMsg, szNogoodMsg2);
			Str_Cat(szNogoodMsg, "\n");
		*/	
			/************** 2-3.�������� **************/
		/*
			Str_Cat(szNogoodMsg, "�������� : ");
			
			Mem_Set( (byte*)szNogoodDate, 0x00, sizeof(szNogoodDate) );
			g_Str_DateType(szNogoodDate, szPlanYmd[j]);
			Str_Cat(szNogoodMsg, szNogoodDate);
			
			Str_Cat(m_szSms_Desc, "\n");
			Str_Cat(m_szSms_Desc, szNogoodMsg);
			
			lret = Tapi_SendSmsEx(m_szReceiver_Tel, szUserTel, szNogoodMsg, Str_Len(szNogoodMsg) );
			
			if(lret != 0)
			{
				switch(lret)
				{
					case -1:
						MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
						return lret;
					case -2:
						MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
						return lret;
					case -3:
						MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
						return lret;
					case -4:
						MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
						return lret;
					default:
						MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
						return lret;
				}
			}
			
			VmSleep(lTime);
		}
		*/
		
		/*******************************************************************/
		/* 3.��������, �÷��׸����̺�                                      */
		/*******************************************************************/
		/*
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT( szSql, " SELECT COUNT(1) \
						   FROM NORMAL_NOGOOD_DETAL \
						  WHERE CHK_EXEC_NUM = '%s' \
						    AND ( ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
							 OR   ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
							 OR   ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) )\
							AND EXCEP_PREUSE_CHK <> 'Y' ", g_szCHK_EXEC_NUM, 0, 0 );
							
		g_Sql_RetInt( szSql, &lNogoodCnt3 );
		
		if( lNogoodCnt3 > 0 )
		{
			Mem_Set( (byte*)szNogoodMsg, 0x00, sizeof(szNogoodMsg) );
			Mem_Set( (byte*)szNogoodItem, 0x00, sizeof(szNogoodItem) );
		*/
			/************** 3-1.��������, �÷��׸����̺� �󼼹��� **************/
			/*
			for( i = 0; i < lNogoodCnt3; i++ )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szNogoodItem, 0x00, sizeof(szNogoodItem) );
				
				SPRINT( szSql, " SELECT CASE WHEN ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) OR ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) THEN CHK_SEC_NM || ' ' || NOT_PASS_ITEM_NM \
									         ELSE NOT_PASS_ITEM_NM \
									     END AS NOT_PASS_ITEM_NM \
								   FROM NORMAL_NOGOOD_DETAL \
								  WHERE CHK_EXEC_NUM = '%s' \
								    AND ( ( CHK_SEC_CD = '50' AND NOT_PASS_ITEM_CD = '50' ) \
									 OR   ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' ) \
									 OR   ( CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ) ) \
									AND EXCEP_PREUSE_CHK <> 'Y' LIMIT %d, 1 ", g_szCHK_EXEC_NUM, i, 0 );
				g_Sql_RetStr( szSql, 50, szNogoodItem );
			
				if( i == 0 )
				{
					Str_Cpy(szNogoodMsg, "�����ճ��� : ");	
					Str_Cat(szNogoodMsg, szNogoodItem);
			
					if( lNogoodCnt3 > 1 )
					{
						Str_Cat(szNogoodMsg, ", ");
					}
				}
				else
				{
					Str_Cat(szNogoodMsg, szNogoodItem);
			
					if( i < lNogoodCnt3-1 )
					{
						Str_Cat(szNogoodMsg, ", ");
					}
				}	
			}
	
			Str_Cat(szNogoodMsg, "\n");
			
			/************** 3-2.��������, �÷��׸����̺� �������� **************/
			/*
			Str_Cat(szNogoodMsg, "�������� : ��ð������");
			
			Str_Cat(m_szSms_Desc, "\n");
			Str_Cat(m_szSms_Desc, szNogoodMsg);
			
			lret = Tapi_SendSmsEx(m_szReceiver_Tel, szUserTel, szNogoodMsg, Str_Len(szNogoodMsg) );
			
			if(lret != 0)
			{
				switch(lret)
				{
					case -1:
						MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
						return lret;
					case -2:
						MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
						return lret;
					case -3:
						MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
						return lret;
					case -4:
						MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
						return lret;
					default:
						MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
						return lret;
				}
			}
			
			VmSleep(lTime);
		}
		*/
		
		/*******************************************************************/
		/* 4.���˿� �Ҽ�                                                   */
		/*******************************************************************/
		/*
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Mem_Set( (byte*)szMsg2, 0x00, sizeof(szMsg2) );
		Mem_Set( (byte*)szUserTel2, 0x00, sizeof(szUserTel2) );

		g_FormatPhoneNumber(szUserTel, szUserTel2);	
		
		SPRINT(szMsg, "���ﵵ�ð��� %s ������\n", stUserinfo.szcenter_nm, 0, 0);
		SPRINT(szMsg2, "�������˿� : %s(%s)\n*�����ð��� ��ȭ�����մϴ�.\n(09��~18��)", stUserinfo.sznm_kor, szUserTel2, 0);
		
		Str_Cat(szMsg, szMsg2);
		Str_Cat(m_szSms_Desc, "\n");
		Str_Cat(m_szSms_Desc, szMsg);
		
		lret = Tapi_SendSmsEx(m_szReceiver_Tel, szUserTel, szMsg, Str_Len(szMsg) );
		
		if(lret != 0)
		{
			switch(lret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
					return lret;
				case -2:
					MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
					return lret;
				case -3:
					MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
					return lret;
				case -4:
					MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
					return lret;
				default:
					MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
					return lret;
			}
		}
		
		VmSleep(lTime);
		*/
		
		lret = 1;
		
		return lret;
	}
	
	/*=======================================================================================
	�Լ��� : Snd_Sms_Hist
	��  �� : ���� �̷� / FR312400
	Param  : 
	Return : 
	========================================================================================*/
	long Snd_Sms_Hist(void)
	{
		char szUrl[200];
		char szbuf[128];
		char szTmp[800];
		char szSendYmd[20];
		char szSendTime[10];
		char szSendDtm[50];
		char szSendTelDdd[6];
		char szSendTelExn[6];
		char szSendTelNum[6];
		char szRecvTelDdd[6];
		char szRecvTelExn[6];
		char szRecvTelNum[6];
		char* sndbuf;
		long i = 0;
		long ntotcnt = 0;
		long nLen = 0;
		long ret = 0;
	
		Mem_Set((byte*)szSendYmd, 0x00, sizeof(szSendYmd));	
		Mem_Set((byte*)szSendTime, 0x00, sizeof(szSendTime));	
		Mem_Set((byte*)szSendDtm, 0x00, sizeof(szSendDtm));	
		Mem_Set((byte*)szSendTelDdd, 0x00, sizeof(szSendTelDdd));	
		Mem_Set((byte*)szSendTelExn, 0x00, sizeof(szSendTelExn));	
		Mem_Set((byte*)szSendTelNum, 0x00, sizeof(szSendTelNum));	
		Mem_Set((byte*)szRecvTelDdd, 0x00, sizeof(szRecvTelDdd));	
		Mem_Set((byte*)szRecvTelExn, 0x00, sizeof(szRecvTelExn));	
		Mem_Set((byte*)szRecvTelNum, 0x00, sizeof(szRecvTelNum));	
		
		Str_ItoA(Time_GetDate(), szSendYmd, 10);
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));	
		g_Str_TimeType( szTmp , Time_GetTime());
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		Mem_Cpy((byte*)szSendTime, (byte*)szTmp, 4);
		
		Str_Cpy(szSendDtm, szSendYmd);
		Str_Cat(szSendDtm, szTmp);

		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Tapi_GetPhoneNum( (byte*)szTmp, 0);
		ret = Analy_Phone(szTmp, szSendTelDdd, szSendTelExn, szSendTelNum);
		if( ret < 0 )
		{
			MessageBoxEx (WARNING_OK, "����ڹ�ȣ�� Ȯ�����ּ���.");
			return -1;
		}

		Analy_Phone(m_szReceiver_Tel, szRecvTelDdd, szRecvTelExn, szRecvTelNum);
		
		if( ret < 0 )
		{
			MessageBoxEx (WARNING_OK, "����ȣ�� Ȯ�����ּ���.");
			return -1;
		}
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312400, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "center_cd",          stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",       stSc.USE_CONT_NUM);
		JSON_SetValue( g_pjcomm, 'C', "cust_num",        	stSc.CUST_NUM);
		JSON_SetValue( g_pjcomm, 'C', "send_ymd",           szSendYmd);
		JSON_SetValue( g_pjcomm, 'C', "send_time",          szSendTime);
		JSON_SetValue( g_pjcomm, 'C', "send_dtm",           szSendDtm);
		JSON_SetValue( g_pjcomm, 'C', "send_tel_ddd",       szSendTelDdd);
		JSON_SetValue( g_pjcomm, 'C', "send_tel_exn",       szSendTelExn);
		JSON_SetValue( g_pjcomm, 'C', "send_tel_num",       szSendTelNum);
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_ddd",   szRecvTelDdd);
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_exn",   szRecvTelExn);
		JSON_SetValue( g_pjcomm, 'C', "receiver_tel_num",   szRecvTelNum);
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SQL_ConvUcStr( szTmp, m_szSms_Desc );
		JSON_SetValue( g_pjcomm, 'C', "sms_desc",           szTmp );
		
		JSON_SetValue( g_pjcomm, 'C', "sms_type",          "10");

		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR312400;
		HTTP_DownloadData( szUrl, "FR312400_IN",  "FR312400" , sndbuf, szbuf );

		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : TR312400
	��  �� : FR312400 CallBack
	Param  : 
	Return : 
	========================================================================================*/
	long TR312400(void)
	{
		char szSql[250];
		char szTmp[100];
		long ntotcnt = 0, i = 0;

		if(g_Chk_Json(312400) >= 0)
		{
			ON_DRAW();
			Card_Move("SC_CONFIRM");
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			Card_Move("SC_CONFIRM");
			return -1;
		}	
	}
	
	/*=======================================================================================
	�Լ��� : Analy_Phone
	��  �� : ��ȭ��ȣ ����
	Param  : 
	Return : 
	========================================================================================*/
	long Analy_Phone(char*phone, char* num1, char* num2, char* num3 )
	{
		long len;
	
		Str_Chg(phone, STRCHG_DEL_NONDIGIT );
		len = Str_Len(phone);
		
		if( len == 9 )
		{
			Mem_Cpy( (byte*)num1, (byte*)phone,    2);
			Mem_Cpy( (byte*)num2, (byte*)phone+2,  3);
			Mem_Cpy( (byte*)num3, (byte*)phone+5,  4);
		}
		else if( len == 10 )
		{
			if( Mem_Cmp((byte*)phone, (byte*)"01", 2) == 0  )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,    3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else if(  Mem_Cmp((byte*)phone, (byte*)"02", 2) == 0 )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,    2);
				Mem_Cpy( (byte*)num2, (byte*)phone+2,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
			else
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,    3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6,  4);
			}
		}
		else if( len == 11 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,    3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+7,  4);
		}
		else if( len == 12 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,    4);
				Mem_Cpy( (byte*)num2, (byte*)phone+4,  4);
				Mem_Cpy( (byte*)num3, (byte*)phone+8,  4);
		}
		else
		{
			return -1;
		}
		
		return 1;
	}

	/*=======================================================================================
	�Լ��� : Sos_Key
	��  �� : sos ���
	Param  : 
	Return : 
	========================================================================================*/
	long Sos_Key(void)
	{
		long lLen = 0;
		long lTime = 100;
		long ret = 0;
		char szMsg[100];
	
		if( MessageBoxEx (CONFIRM_YESNO, "SOS��� Ȱ��ȭ") != MB_OK )
		{
			return FALSE;
		}

		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "20") == 0 )
		{
			Str_Cpy(szMsg, "[�����Ŵ���]\n���޻�Ȳ. �����ּ���!\n");
			
			if( Str_Len(stSc.TOWN) > 0 )
			{
				Str_Cat(szMsg, stSc.TOWN);
			}
			if( Str_Len(stSc.CO_LIVE_NM) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stSc.CO_LIVE_NM);
			}
			if( Str_Len(stSc.BLD_NM) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stSc.BLD_NM);
			}
			if( Str_Len(stSc.HOUSE_CNT) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stSc.HOUSE_CNT);
			}
		}
		else
		{
			Str_Cpy(szMsg, "[�����Ŵ���]\n���޻�Ȳ. �����ּ���!\n");
			
			if( Str_Len(stSc.TOWN) > 0 )
			{
				Str_Cat(szMsg, stSc.TOWN);
			}
			if( Str_Len(stSc.ADDR1_M) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stSc.ADDR1_M);
			}
			if( Str_Len(stSc.ADDR1_S) > 0 )
			{
				Str_Cat(szMsg, "-");
				Str_Cat(szMsg, stSc.ADDR1_S);
			}
			if( Str_Len(stSc.HOUSE_CNT) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stSc.HOUSE_CNT);
			}
			if( Str_Len(stSc.LOT_NUM_SECOND_ADDR) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stSc.LOT_NUM_SECOND_ADDR);
			}
		}
		
		Str_Chg(stUserinfo.szSos_SmsNum1, STRCHG_DEL_NONDIGIT );
		Str_Chg(stUserinfo.szpda_ip, STRCHG_DEL_NONDIGIT );
		
		// 1��° �޼��� �߼�
		ret = Tapi_SendSmsEx(stUserinfo.szSos_SmsNum1, stUserinfo.szpda_ip, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
					return ret;
				case -2:
					MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
					return ret;
				case -3:
					MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
					return ret;
				case -4:
					MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
					return ret;
				default:
					MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
					return ret;
			}
		}
		
		VmSleep(lTime);

		Str_Chg(stUserinfo.szSos_SmsNum2, STRCHG_DEL_NONDIGIT );
		Str_Chg(stUserinfo.szpda_ip, STRCHG_DEL_NONDIGIT );
		
		// 2��° �޼��� �߼�
		ret = Tapi_SendSmsEx(stUserinfo.szSos_SmsNum2, stUserinfo.szpda_ip, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
					return ret;
				case -2:
					MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
					return ret;
				case -3:
					MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
					return ret;
				case -4:
					MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
					return ret;
				default:
					MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
					return ret;
			}
		}
		
		VmSleep(lTime);

		Str_Chg(stUserinfo.szSos_SmsNum3, STRCHG_DEL_NONDIGIT );
		Str_Chg(stUserinfo.szpda_ip, STRCHG_DEL_NONDIGIT );
		
		// 3��° �޼��� �߼�
		ret = Tapi_SendSmsEx(stUserinfo.szSos_SmsNum3, stUserinfo.szpda_ip, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "�޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ����ϴ�.");
					return ret;
				case -2:
					MessageBoxEx (WARNING_OK, "������ ���� ��ȭ��ȣ�� �߸��Ǿ����ϴ�.");
					return ret;
				case -3:
					MessageBoxEx (WARNING_OK, "������ ������ϴ�.");
					return ret;
				case -4:
					MessageBoxEx (WARNING_OK, "������ �ʹ� ��ϴ�.");
					return ret;
				default:
					MessageBoxEx (WARNING_OK, "�޼��� ���ۿ� �����߽��ϴ�.");
					return ret;
			}
		}
		
		// 4��° ��ȭ�ɱ�
		VmSleep(lTime);
		
		Str_Chg(stUserinfo.szSos_TelNum, STRCHG_DEL_NONDIGIT );
		Tapi_MakeCall((byte*)stUserinfo.szSos_TelNum);
		
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : SetStatus
	��  �� : Ÿ�̸� TXT_TIME_LEFT ǥ��
	Param  : 
	Return : 
	========================================================================================*/
	void SetStatus(char* pText)
	{	
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_TIME_LEFT), pText);
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : Start_Timer
	��  �� : Ÿ�̸� ����
	Param  : 
	Return : 
	========================================================================================*/
	void Start_Timer(void)
	{
		char temp[2];
		long fromTime = 0; // ���۽ð� ��
		long toTime = 0;   // ����ð� ��
		long time_Result = 0;
		char szSql[100];
		char prod_cd[2];
		
		/*** �ð� ��� Start ***/
		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stSc.CHK_TIME_FROM, 2);
		
		fromTime = 60 * 60 * Str_AtoI(temp);
		
		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stSc.CHK_TIME_FROM + 2, 2);
		
		fromTime += 60 * Str_AtoI(temp);
		
		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stSc.CHK_TIME_FROM + 4, 2);
		
		fromTime += Str_AtoI(temp);

		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stSc.CHK_TIME_TO, 2);
		
		toTime = 60 * 60 * Str_AtoI(temp);

		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stSc.CHK_TIME_TO + 2, 2);
		
		toTime += 60 * Str_AtoI(temp);
		
		Mem_Set((byte*)temp, 0x00, sizeof(temp));
		Mem_Cpy((byte *)temp, (byte *)stSc.CHK_TIME_TO + 4, 2); 
		
		toTime += Str_AtoI(temp);
		
		time_Result = toTime - fromTime;

		/*** �ð� ��� End ***/	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)prod_cd, 0x00, sizeof(prod_cd) );
		SPRINT(szSql, " SELECT MAX(PROD_CD) FROM NORMAL_MTR WHERE CHK_EXEC_NUM ='%s' " , g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetStr(szSql, 2, prod_cd);

		if( Str_Cmp(prod_cd, "11") == 0  || Str_Cmp(prod_cd, "81") == 0)
		{
			if( time_Result < 120 ) //2��
			{
				if(m_nTimerId == -1)
				{
					m_nTimerCnt = 120 - time_Result;
					m_nTimerId = Timer_Set(1000,0);
				}
			}
			else
			{
				SetStatus("0��");
			}
		}
		else
		{
			if( time_Result < 150 ) //2��30��
			{
				if(m_nTimerId == -1)
				{
					m_nTimerCnt = 150 - time_Result;
					m_nTimerId = Timer_Set(1000,0);
				}
			}
			else
			{
				SetStatus("0��");
			}
		}
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Stop_Timer
	��  �� : Ÿ�̸� ����
	Param  : 
	Return : 
	========================================================================================*/
	void Stop_Timer(void)
	{
		if(m_nTimerCnt == 0)
		{
			SetStatus("0��");
			Timer_Kill( m_nTimerId );
			m_nTimerId = -1;
			return;
		}
		else
		{
			Mem_Set( (byte*)m_szBuf, 0x00, sizeof(m_szBuf) );
			Str_Printf(m_szBuf, "%d��", m_nTimerCnt,0,0);
			SetStatus( m_szBuf );
			m_nTimerCnt--;
			return;
		}
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : OnTimer
	��  �� : Ÿ�̸� ȣ�� �Լ�
	Param  : 
	Return : 
	========================================================================================*/
	void OnTimer(long nTimerID)
	{	
		if( INIT_RLTCHK == m_bFirst )
		{
			if(m_nTimerId == nTimerID)
			{
				Stop_Timer();
			}
			else
			{
				Mem_Set( (byte*)stSc.CHK_TIME_TO, 0x00, sizeof(stSc.CHK_TIME_TO) );
				g_Str_TimeType( stSc.CHK_TIME_TO, Time_GetTime() );
				Start_Timer();
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnExit
	��  �� : ȭ�� ����� Ÿ�̸� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnExit(void)
	{
		if( INIT_RLTCHK == m_bFirst )
		{
			if(m_nTimerId != -1)
			{
				Timer_Kill(m_nTimerId);
				m_nTimerId = -1;
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : Shoto_Photo
	��  �� : ���ڵ� �ν� �Ұ� ����
		     C42(��������) | E(���˽����ȣ) | I(��ġ��ҹ�ȣ) | D(������¥(SYSDATE : YYYYMMDDHHMMSS))
	Param  : 
	Return : 
	========================================================================================*/
	void Shoto_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet;
		
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		
		Str_Cpy(m_szfilenm, "C42_");
		Str_Cat(m_szfilenm, g_szCHK_EXEC_NUM);
		Str_Cat(m_szfilenm, "_");						
		Str_Cat(m_szfilenm, stSc.INST_PLACE_NUM);
		Str_Cat(m_szfilenm, ".jjp");
		
		Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
		SPRINT (g_szphoto, "%s/%s", PHOTO_SCBAR,  m_szfilenm, 0);
		
		// PM80 ī�޶� ȣ��
		ShootPhoto ( 1, 0, m_szfilenm );
		
		return;
	}
}
