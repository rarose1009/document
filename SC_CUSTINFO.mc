/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_CUSTINFO
	Card Desc : ������
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_CUSTINFO
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
	//---------------------------------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/*  ����                        */
		/********************************/
		DEF_BUTTON_ID ( BID_HOME )		// Ȩ
		DEF_BUTTON_ID ( BID_MENU )		// �޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )	// Ű����
		DEF_BUTTON_ID ( BID_SCREEN )	// ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )	// �������
		DEF_BUTTON_ID ( BID_PREV )		// ����
		DEF_BUTTON_ID ( BID_EXIT )		// ����
		
		/********************************/
		/* ��1                        */
		/********************************/
		DEF_BUTTON_ID ( BID_CLIENT )	// ��1
		DEF_BUTTON_ID ( BID_CLIENT2 )	// ��2
		DEF_BUTTON_ID ( BID_CUSTPTRN)	// ������
		DEF_BUTTON_ID ( BID_SMSREQ)		// SMS��û
		DEF_BUTTON_ID ( BID_OK )		// Ȯ��
		DEF_BUTTON_ID ( BID_REQ )		// û�����
		
		/********************************/
		/* SMS��û                      */
		/********************************/
		DEF_BUTTON_ID ( BID_ADDR )		// �ּ�
		DEF_BUTTON_ID ( BID_BOX1 )		// ��
		DEF_BUTTON_ID ( BID_BOX2 )		// �ƴϿ�
		DEF_BUTTON_ID ( BID_ENTRY )	 	// ���
		DEF_BUTTON_ID ( BID_CANCEL ) 	// ���
	END_BUTTON_ID()
	
	//---------------------------------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* ����                         */
		/********************************/
		DEF_OBJECT_ID ( ICON_TITLE )	// Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_TITLE )		// Ÿ��Ʋ
		
		/********************************/
		/* ��1                        */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA1 )		// ST_�����
		DEF_OBJECT_ID ( TXT_DATA2 )		// TXT_������ȣ
		DEF_OBJECT_ID ( TXT_DATA3 )		// TXT_��������
		DEF_OBJECT_ID ( TXT_DATA4 )		// ST_����
		DEF_OBJECT_ID ( TXT_DATA5 )		// ST_����
		DEF_OBJECT_ID ( TXT_DATA6 )		// ST_����
		DEF_OBJECT_ID ( TXT_DATA8 )		// ST_�ڵ�����ȣ1
		DEF_OBJECT_ID ( TXT_DATA9 )		// ST_�ڵ�����ȣ2
		DEF_OBJECT_ID ( TXT_DATA10 )	// ST_�ڵ�����ȣ3
		DEF_OBJECT_ID ( TXT_DATA11 )	// ST_������ȭ1
		DEF_OBJECT_ID ( TXT_DATA12 )	// ST_������ȭ2
		DEF_OBJECT_ID ( TXT_DATA13 )	// ST_������ȭ3
		DEF_OBJECT_ID ( TXT_DATA14 )	// ST_��Ʈ��
		DEF_OBJECT_ID ( TXT_DATA15 )	// ST_�ּ�
		DEF_OBJECT_ID ( TXT_DATA16 )	// ST_����
		DEF_OBJECT_ID ( TXT_DATA17 )	// ST_ȣ��
		DEF_OBJECT_ID ( TXT_DATA18 )	// ST_����ȣ��
		DEF_OBJECT_ID ( TXT_DATA19 )	// ST_��Ÿ�ּ�
		DEF_OBJECT_ID ( TXT_DATA20 )	// TXT_����	
		DEF_OBJECT_ID ( TXT_DATA22 )	// TXT_����
		DEF_OBJECT_ID ( TXT_DATA23 )	// TXT_ȣ��
		DEF_OBJECT_ID ( TXT_DATA24 )	// TXT_����ȣ��
		DEF_OBJECT_ID ( TXT_DATA25 )	// TXT_��Ÿ�ּ�
		DEF_OBJECT_ID ( TXT_DATA41 )	// ST_�������
		DEF_OBJECT_ID ( TXT_DATA42 )	// TXT_�������
		DEF_OBJECT_ID ( TXT_DATA55 ) 	// ST_�δ���
		DEF_OBJECT_ID ( TXT_DATA56 ) 	// ST_��ȸ�����ü�
		DEF_OBJECT_ID ( TXT_DATA57 ) 	// TXT_����
		
		/********************************/
		/* ��2                        */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA26 )	// ST_ȸ���ȣ1
		DEF_OBJECT_ID ( TXT_DATA27 )	// ST_ȸ���ȣ2
		DEF_OBJECT_ID ( TXT_DATA28 )	// ST_ȸ���ȣ3
		DEF_OBJECT_ID ( TXT_DATA29 )	// ST_�ѽ�1
		DEF_OBJECT_ID ( TXT_DATA30 )	// ST_�ѽ�2
		DEF_OBJECT_ID ( TXT_DATA31 )	// ST_�ѽ�3
		DEF_OBJECT_ID ( TXT_DATA32 )	// ST_����ڹ�ȣ
		DEF_OBJECT_ID ( TXT_DATA33 )	// ST_��ȣ
		DEF_OBJECT_ID ( TXT_DATA34 )	// ST_�̸���1
		DEF_OBJECT_ID ( TXT_DATA35 )	// ST_�̸���2
		DEF_OBJECT_ID ( TXT_DATA36 )	// ST_����
		DEF_OBJECT_ID ( TXT_DATA37 )	// ST_������
		DEF_OBJECT_ID ( TXT_DATA38 )	// ST_������
		DEF_OBJECT_ID ( TXT_DATA39 )	// TXT_����ڹ�ȣ
		DEF_OBJECT_ID ( TXT_DATA40 )	// TXT_��ȣ
		
		/********************************/
		/* SMS��û                      */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA43 )	// ST_��SMS�����ȳ� ���� ��û
		DEF_OBJECT_ID ( TXT_DATA44 )	// ST_������
		DEF_OBJECT_ID ( TXT_DATA45 )	// TXT_������
		DEF_OBJECT_ID ( TXT_DATA46 )	// TXT_�ּ�
		DEF_OBJECT_ID ( TXT_DATA47 )	// ST_��û�ڸ�
		DEF_OBJECT_ID ( TXT_DATA48 )	// TXT_��û�ڸ�
		DEF_OBJECT_ID ( TXT_DATA49 )	// ST_H.P1
		DEF_OBJECT_ID ( TXT_DATA50 )	// ST_H.P2
		DEF_OBJECT_ID ( TXT_DATA51 )	// ST_H.P3
		DEF_OBJECT_ID ( TXT_DATA52 )	// ST_�������� ����
		DEF_OBJECT_ID ( TXT_DATA53 )	// ST_��
		DEF_OBJECT_ID ( TXT_DATA54 )	// ST_�ƴϿ�
		
		/********************************/
		/* ����                         */
		/********************************/
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
		
		/********************************/
		/* ����                         */
		/********************************/
		DEF_OBJECT_ID ( LINE_DATA_1 )	// ����_1
		DEF_OBJECT_ID ( LINE_DATA_2 )	// ����_2
		DEF_OBJECT_ID ( LINE_DATA_3 )	// ����_3
		DEF_OBJECT_ID ( LINE_DATA_4 )	// ����_4
		
		/********************************/
		/* EDIT                         */
		/********************************/
		// ��
		DEF_OBJECT_ID ( EDT_DATA1 )		// EDT_�ڵ�����ȣ1
		DEF_OBJECT_ID ( EDT_DATA2 )		// EDT_�ڵ�����ȣ2
		DEF_OBJECT_ID ( EDT_DATA3 )		// EDT_���ù�ȣ1
		DEF_OBJECT_ID ( EDT_DATA4 )		// EDT_���ù�ȣ2
		DEF_OBJECT_ID ( EDT_DATA5 )		// EDT_ȸ���ȣ1
		DEF_OBJECT_ID ( EDT_DATA6 )		// EDT_ȸ���ȣ2
		DEF_OBJECT_ID ( EDT_DATA7 )		// EDT_�ѽ���ȣ1
		DEF_OBJECT_ID ( EDT_DATA8 )		// EDT_�ѽ���ȣ2
		DEF_OBJECT_ID ( EDT_DATA9 )		// EDT_�̸���
		DEF_OBJECT_ID ( EDT_DATA10 )	// EDT_������

		// SMS��û
		DEF_OBJECT_ID ( EDT_DATA11 )	// EDT_H.P1
		DEF_OBJECT_ID ( EDT_DATA12 )	// EDT_H.P2
		
		/********************************/
		/* COMBO BOX                    */
		/********************************/
		// ��
		DEF_OBJECT_ID ( CMB_DATA1 )					// ����(������ )
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1+3 )	// ����
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2+3 )	// �ڵ�����ȣ
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3+3 )	// ���ù�ȣ
		DEF_OBJECT_ID ( CMB_DATA5 = CMB_DATA4+3 )	// ��Ʈ��
		DEF_OBJECT_ID ( CMB_DATA6 = CMB_DATA5+3 )	// ȸ���ȣ
		DEF_OBJECT_ID ( CMB_DATA7 = CMB_DATA6+3 )	// �ѽ�
		DEF_OBJECT_ID ( CMB_DATA8 = CMB_DATA7+3 )	// �̸���
		DEF_OBJECT_ID ( CMB_DATA9 = CMB_DATA8+3 )	// ����
		DEF_OBJECT_ID ( CMB_DATA10 = CMB_DATA9+3 )	// ������
		DEF_OBJECT_ID ( CMB_DATA12 = CMB_DATA10+3 )	// ��ȣ��
		DEF_OBJECT_ID ( CMB_DATA13 = CMB_DATA12+3 )	// �δ���
		DEF_OBJECT_ID ( CMB_DATA14 = CMB_DATA13+3 )	// ��ȸ�����ü�
		
		// SMS��û
		DEF_OBJECT_ID ( CMB_DATA11 = CMB_DATA14+3 )	// H.P
		
	END_OBJECT_ID()
	
	//---------------------------------------------------------------------------------------
	// Define
	//---------------------------------------------------------------------------------------
	#define	EDITSETRANGE( h, x1, y1, x2, y2 ) EditCtrl_SetRange( h, DMS_X(x1), DMS_Y(y1), DMS_X(x2), DMS_Y(y2) )
	#define INIT_MAIN 1
	#define INIT_SMSREQ 2
	
	//---------------------------------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------------------------------
	handle m_hDlg;				// ���̾�α�
	long m_lCnt = 0;			// NORMAL_CUSTINFO CNT
	long m_nOptionSet = 0;		// m_nOptionSet == 0 ��1, m_nOptionSet == 1 ��2	
	long m_bFirst;				// ȭ��
	long m_lDrawFlag = 0;		// �������Կ���
	long m_lActiveIndex = -1;
	long m_lSmsReqFlag = 0;		// ���ǿ���
	
	//---------------------------------------------------------------------------------------
	// Function
	//---------------------------------------------------------------------------------------
	// ��
	void SetStyle(void);		// Style Setting
	void SetStruct(void);		// ����ڷḦ ���� ��Ʈ���Ŀ� ����
	void SetCombo(void);		// ComboBox Setting
	void SetBtnImg(void);		// ��ưimg
	void REDRAW(void);			// ���� ��Ʈ���� ���÷���
	void Cust_SetData(void);	// Normal_Cust�� ������ �ִٸ� ��
	void Copy_Info(void);		// ������ �� ������ ��������� copy�Ͽ� ������Ʈ
	bool Save_Cust(void);		// Normal_Info ���̺� ���� or ������Ʈ
	bool Validate(void);		// ������ ���� Validate
	bool Compare_Data(void);	// ���������Ϳ� ���� �ԷµǾ��ִ� ������ ��. ������ ������ ������ ���� �ʱ����ؼ�.
	bool Chk_Ptrn(void);		// �����ϼ��� ��� Ȯ��
	void ReqMsg(void);			// û����� �޼���
		
	// SMS��û
	void SMSREQ_DRAW(void);		// SMS��û DRAW
	bool Save_SmsReq(void);		// SMS��û(����)
	void Snd_SmsReq(void);		// SMS��û(����)
	long TR312314(void);		// SMS��û ����
	
	//---------------------------------------------------------------------------------------
	// Global Button
	//---------------------------------------------------------------------------------------
	SysButCtrl SysButRes_MAIN[] =
	{
		SYS_BUT_IMG( BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_HOME, 0 ),
		SYS_BUT_IMG( BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0 ),
		SYS_BUT_IMG( BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_SCREEN, 0 ),
		SYS_BUT_IMG( BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_CMMNWK, 0 ),
		SYS_BUT_IMG( BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD, 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0 ),
		SYS_BUT_IMG( BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0 ),
		SYS_BUT_IMG( BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0 ),
	};
	
	//---------------------------------------------------------------------------------------
	// ������ ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG( "", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0 ),
		DLG_ICON( 0, BTNY_2, ICON_TITLE, "" ),
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�� ����"),
		
		DLG_TEXT  (STARTX,      STARTY +65,  230, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA1, "�����"),
		DLG_TEXT  (STARTX +230, STARTY +65,  325, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""), 
		DLG_TEXT  (STARTX +550, STARTY +65,  160, 60, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 
		DLG_BUTTON(STARTX +710, STARTY +65,  290, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_REQ, ""),
		
		DLG_LINE ( STARTX,      STARTY +129, 1000, STARTY +129,     DARKSLATEBLUE, 10, LINE_DATA_1),
		
		DLG_BUTTON(STARTX,      STARTY +141, 245, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CLIENT, "��1"),
		DLG_BUTTON(STARTX +245, STARTY +141, 245, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CLIENT2, "��2"),
		DLG_BUTTON(STARTX +510, STARTY +141, 245, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_CUSTPTRN, "������"),
		DLG_BUTTON(STARTX +755, STARTY +141, 245, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_SMSREQ, "SMS��û"),
		
		DLG_LINE ( STARTX,      STARTY +205, 1000, STARTY +205,     DARKSLATEBLUE, 10, LINE_DATA_2),
		
		DLG_LINE ( STARTX,      STARTY +815, 1000, STARTY +815,     DARKSLATEBLUE, 10, LINE_DATA_3),
		DLG_BUTTON(STARTX +10,  STARTY +825, 980, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_OK, "Ȯ ��"),
				
        // ������_1
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA5, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA6, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA8, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA9, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA10, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA11, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA12, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA13, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA14, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA55, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA56, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA15, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA16, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA17, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA18, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA19, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA25, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA41, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA42, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA57, ""),
		
		// ������_2
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA27, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA29, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA30, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA31, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA32, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA33, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA34, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA35, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA36, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA37, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA38, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA39, ""),
		DLG_TEXT(0, 0, 0, 0, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA40, ""),
		
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA3, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA7, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA8, 4,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA9, 30,  ""),
		DLG_EDIT(0, 0, 0, 0, 0, 0, EDITSTY_BORDER, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA10, 3,  ""),
		
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA5, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA13, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA14, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA7, 10),
		DLG_COMBO_DWE (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA8, 20),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA9, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA10, 10),
		DLG_COMBO (0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA12, 50),
		
		//���� ����
		DLG_LINE(STARTX, STARTY +906, 1000, STARTY +906, DARKSLATEBLUE, 10, LINE_DATA_4),
		DLG_TEXT(0,    STARTY+910, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ONE, "1"),
		DLG_TEXT(333,  STARTY+910, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_TWO, "2"),
		DLG_TEXT(666,  STARTY+910, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_THREE, "3"),
		DLG_TEXT(0,   STARTY+1000, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FOUR, "4"),
		DLG_TEXT(333, STARTY+1000, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_FIVE, "5"),
		DLG_TEXT(666, STARTY+1000, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SIX, "6"),
		DLG_TEXT(0,   STARTY+1090, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_SEVEN, "7"),
		DLG_TEXT(333, STARTY+1090, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_EIGHT, "8"),
		DLG_TEXT(666, STARTY+1090, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_NINE, "9"),
		DLG_TEXT(333, STARTY+1180, 333, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_ZERO, "0"),
		DLG_TEXT(666, STARTY+1180, 334, 90, 0, 0, 0, EDITSTY_BOLD|EDITSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_KEY_DEL, "��"),
	};
	
	//---------------------------------------------------------------------------------------
	// �������� SMS ��û ���̾�α�
	//---------------------------------------------------------------------------------------
	DlgObject DlgRes_SMSREQ[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "�������� SMS ��û"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCEL, ""),

		DLG_BUTTON(STARTX,		STARTY+110, 300, 150, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR,  "����\n�ּ�"),
		DLG_BUTTON(STARTX,		STARTY+600, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1,  CHKOFF),
		DLG_BUTTON(STARTX+600,  STARTY+600, 200, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2,  CHKOFF),		
		DLG_BUTTON(STARTX,		STARTY+700, 400, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ENTRY,  "���"),
		DLG_BUTTON(STARTX+600,  STARTY+700, 400, 60, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCEL,  "���"),
		
		DLG_TEXT  (STARTX,		 STARTY-29, 850, 70, 0,0, EDITSTY_BORDER, 0, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, "��SMS�����ȳ� ���� ��û"),
		DLG_TEXT  (STARTX,		 STARTY+50, 300, 60, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA44, "������"),
		DLG_TEXT  (STARTX+300,	 STARTY+50, 700, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA45, ""),
		DLG_TEXT  (STARTX+300,	STARTY+110, 700,150, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA46, ""),
		DLG_TEXT  (STARTX,		STARTY+260, 300, 60, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA47, "��û�ڸ�"),
		DLG_TEXT  (STARTX+300,	STARTY+260, 700, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA48, ""),
		
		DLG_TEXT  (STARTX,		STARTY+320, 150, 60, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA49, "H.P"),
		DLG_TEXT  (STARTX+450,	STARTY+320,  50, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA50, "-"),
		DLG_EDIT  (STARTX+500,	STARTY+320, 225, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA11, 4,  ""),
		DLG_TEXT  (STARTX+725,	STARTY+320,  50, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA51, "-"),
		DLG_EDIT  (STARTX+775,	STARTY+320, 225, 60, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA12, 4,  ""),
		
		DLG_TEXT  (STARTX,		STARTY+430, 1000,150, 0,0, 0, EDITSTY_BOLD|EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA52, "�������� �������̿� ������ \n�����ϰ� �̿� �����ϸ�,\n�������� SMS �����ȳ�\n���񽺸� ��û�մϴ�."),
		DLG_TEXT  (STARTX+200,	STARTY+600, 200, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA53, "��"),
		DLG_TEXT  (STARTX+800,	STARTY+600, 200, 60, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA54, "�ƴϿ�"),
		
		DLG_COMBO (STARTX+150,  STARTY+320, 300, 200, 100, 60, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA11, 4),		
	};
	
	//---------------------------------------------------------------------------------------
	// Main
	//---------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		EVENT_HANDLER( MsgType, wParam, lParam );
		return TRUE;
	}
	
	//---------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//---------------------------------------------------------------------------------------
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
			/******************************/
			/* ��                       */
			/******************************/
			case INIT_MAIN:
					
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				SetBtnImg();
				SetStyle();
				
				if( Chk_Ptrn() )
				{
					MessageBoxEx (CONFIRM_OK, "���������� ��������Դϴ�.");
					g_lPtrnFlag = 2;
					Card_Move("SC_CUSTPTRN");
					return;
				}
				
				SetCombo();
				
				if( g_lPtrnFlag != 2 )
				{
					if( m_lDrawFlag == 0)
					{
						SetStruct();
						REDRAW();
						m_lDrawFlag = 1;
					}
					else
					{
						REDRAW();
					}
				}
				else
				{
					REDRAW();
				}
				
				break;
			
			/******************************/
			/* SMS ��û                   */
			/******************************/	
			case INIT_SMSREQ:
				
				CREATE_DIALOG_OBJECT (DlgRes_SMSREQ, SIZEOF(DlgRes_SMSREQ));
				
				SetBtnImg();
				SMSREQ_DRAW();
				
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
		long i, length;
	
		switch(ID)
		{
			/******************************/
			/* ����                       */
			/******************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
					{
						g_Del_ScData();
					}
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
				if( MessageBoxEx (CONFIRM_YESNO, "SOS ���ȣ���� �Ͻðڽ��ϱ�?") == MB_OK )
				{
					g_Send_SOS(1);
				}
				break;	
							
			case GID_PREV:
				g_lSCMoveFlag = 0;
				g_lPtrnFlag = 0;
				Card_Move("SC_START");
				break;
					
			case GID_VMEXIT:
				if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
				{
					g_Exit_DelScData();
					return;
				}
				g_Exit();
				return;
				
			/******************************/
			/* ��                       */
			/******************************/
			case BID_CLIENT:
				m_nOptionSet = 0;
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
				
			case BID_CLIENT2:
				m_nOptionSet = 1;
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
				
			case BID_SMSREQ:
				ON_EXIT();
				OnInit(INIT_SMSREQ);
				
				break;
				
			case BID_CUSTPTRN:
				g_lPtrnFlag = 2;
				Card_Move("SC_CUSTPTRN");
				
				break;
					
			case BID_REQ:
				ReqMsg();
				
				break;
					
			case BID_OK:
				g_lPtrnFlag = 0;
				
				if( !Compare_Data() )
				{
					if( Save_Cust() )
					{
						Card_Move("SC_START");
					}
				}
				else
				{
					Card_Move("SC_START");
				}
				
				break;
				
			/******************************/
			/* SMS ��û                   */
			/******************************/
			case BID_ADDR:
				// g_nAddrFlag = 0 -> ���ּ�,  g_nAddrFlag = 1 -> ���ּ�
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}
				
				SMSREQ_DRAW();
				
				break;
				
			case BID_ENTRY:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( Validate() )
				{
					Snd_SmsReq();
				}
				
				break;
			
			case BID_CANCEL:
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
				
			case BID_BOX1:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				m_lSmsReqFlag = 1;
				
				break;
				
			case BID_BOX2:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKON);
				m_lSmsReqFlag = 2;
				
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
		char sztmp[50];
		long i;
		
		if( 0 == m_nOptionSet )
		{	
			// ����
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.CUST_TRND_CD, 0x00, sizeof(stSubCustInfo.CUST_TRND_CD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA2) ) );
			
			i = g_SearchStr( sztmp, SCTRND_CD );
			
			if( i == -1 )
			{
				Str_Cpy(stSubCustInfo.CUST_TRND_CD, "");
			}
			else
			{
				Str_Cpy(stSubCustInfo.CUST_TRND_CD, SCTRND_CD[i].Code);
			}

			// �ڵ�����ȣ ���� ó��
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA3) ) );
			
			if( Str_Cmp(sztmp, "����") == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3),  "");
			}
			
			// �ڵ�����ȣ ó��
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.CP_DDD, 0x00, sizeof(stSubCustInfo.CP_DDD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA3) ) );
			
			if( Str_Cmp(stSubCustInfo.CP_DDD, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.CP_DDD, sztmp);
			}
			
			// ������ȭ ���� ó��
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA4) ) );
			
			if( Str_Cmp(sztmp, "����") == 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4),  "");
			}
			
			// ������ȭ ó��
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_DDD, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_DDD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA4) ) );
			
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_DDD, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_DDD, sztmp);
			}
			
			// ��Ʈ�ο���
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.BUILT_IN_YN, 0x00, sizeof(stSubCustInfo.BUILT_IN_YN));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA5) ) );
			
			if( Str_Cmp(stSubCustInfo.BUILT_IN_YN, sztmp ) != 0 )
			{	
				i = g_SearchStr( sztmp, SCBUILT_IN );
				
				if( i == -1 )
				{
					Str_Cpy(stSubCustInfo.BUILT_IN_YN, "");
				}
				else
				{
					Str_Cpy(stSubCustInfo.BUILT_IN_YN, SCBUILT_IN[i].Code);
				}
			}
			
			// �δ��ǿ���
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.INDUCTION_INST_YN, 0x00, sizeof(stSubCustInfo.INDUCTION_INST_YN));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA13) ) );
			
			if( Str_Cmp(stSubCustInfo.INDUCTION_INST_YN, sztmp ) != 0 )
			{
				i = g_SearchStr( sztmp, SCBUILT_IN );
				
				if( i == -1 )
				{
					Str_Cpy(stSubCustInfo.INDUCTION_INST_YN, "");
				}
				else
				{
					Str_Cpy(stSubCustInfo.INDUCTION_INST_YN, SCBUILT_IN[i].Code);
				}
			}
			
			// ��ȸ�����ü�����
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.FACI_STS_CD, 0x00, sizeof(stSubCustInfo.FACI_STS_CD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA14) ) );
			
			if( Str_Cmp(stSubCustInfo.FACI_STS_CD, sztmp ) != 0 )
			{
				i = g_SearchStr( sztmp, SOCIAL_FACI_STS_CD );
				
				if( i == -1 )
				{
					Str_Cpy(stSubCustInfo.FACI_STS_CD, "");
				}
				else
				{
					Str_Cpy(stSubCustInfo.FACI_STS_CD, SOCIAL_FACI_STS_CD[i].Code);
				}
			}
		}
		else if( 1 == m_nOptionSet )
		{
			// ȸ���ȣ
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.FIRM_TEL_DDD, 0x00, sizeof(stSubCustInfo.FIRM_TEL_DDD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA6) ) );
			
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_DDD, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.FIRM_TEL_DDD, sztmp);
			}
			
			// �ѽ�
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.FAX_DDD, 0x00, sizeof(stSubCustInfo.FAX_DDD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA7) ) );
			
			if( Str_Cmp(stSubCustInfo.FAX_DDD, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.FAX_DDD, sztmp);
			}
			
			// �̸���
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.EMAILADDR, 0x00, sizeof(stSubCustInfo.EMAILADDR));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA8) ) );
			
			if( Str_Cmp(stSubCustInfo.EMAILADDR, sztmp ) != 0 )
			{
				Str_Cpy(stSubCustInfo.EMAILADDR, sztmp);
			}
			
			// ����
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.SQUARE_METER, 0x00, sizeof(stSubCustInfo.SQUARE_METER));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA9) ) );
			
			i = g_SearchStr( sztmp, SCSQUARE );
			
			if( i == -1 )
			{
				Str_Cpy(stSubCustInfo.SQUARE_METER, "");
			}
			else
			{
				Str_Cpy(stSubCustInfo.SQUARE_METER, SCSQUARE[i].Code);
			}
			
			// ������
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			Mem_Set((byte*)stSubCustInfo.SCG_RELAT_CD, 0x00, sizeof(stSubCustInfo.SCG_RELAT_CD));
			
			Str_Cpy( sztmp ,EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA10) ) );
			
			if( Str_Cmp(stSc.PROD_CD, "20") == 0 || Str_Cmp(stSc.PROD_CD, "21") == 0 || Str_Cmp(stSc.PROD_CD, "22") == 0 )
			{
				i = g_SearchStr( sztmp, SCRELAT );
				
				if( i == -1 )
				{
					Str_Cpy(stScCustInfo.SCG_RELAT_CD, "");
				}
				else
				{
					Str_Cpy(stSubCustInfo.SCG_RELAT_CD, SCRELAT[i].Code);
				}
			}
		}
	}
		
	/*=======================================================================================
	�Լ��� : OnKey
	��  �� : Ű �̺�Ʈ
	Param  : 
	Return : 
	========================================================================================*/
	void OnKey( long nKey )
	{
		if( 0 == m_nOptionSet )
		{
			// �Է� �� �ڵ�����
			if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.CP_EXN, 0x00, sizeof(stSubCustInfo.CP_EXN));
				Str_Cpy(stSubCustInfo.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.CP_NUM, 0x00, sizeof(stSubCustInfo.CP_NUM));
				Str_Cpy(stSubCustInfo.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_EXN, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_EXN));
				Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA4) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_NUM, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_NUM));
				Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
			}
		}
		else if( 1 == m_nOptionSet )
		{
			if( Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FIRM_TEL_EXN, 0x00, sizeof(stSubCustInfo.FIRM_TEL_EXN));
				Str_Cpy(stSubCustInfo.FIRM_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA6) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FIRM_TEL_NUM, 0x00, sizeof(stSubCustInfo.FIRM_TEL_NUM));
				Str_Cpy(stSubCustInfo.FIRM_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA7) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FAX_EXN, 0x00, sizeof(stSubCustInfo.FAX_EXN));
				Str_Cpy(stSubCustInfo.FAX_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA8) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FAX_NUM, 0x00, sizeof(stSubCustInfo.FAX_NUM));
				Str_Cpy(stSubCustInfo.FAX_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA9) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.EMAIL, 0x00, sizeof(stSubCustInfo.EMAIL));
				Str_Cpy(stSubCustInfo.EMAIL, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
			}
			else if( Get_iDlgCtrlByID(EDT_DATA10) == m_lActiveIndex )
			{
				Mem_Set((byte*)stSubCustInfo.FAMILY_CNT, 0x00, sizeof(stSubCustInfo.FAMILY_CNT));
				Str_Cpy(stSubCustInfo.FAMILY_CNT, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
			}
			else if( Get_iDlgCtrlByID(CMB_DATA8) == m_lActiveIndex )
			{
				PRINT("@@@@@@@@@@@@@@@@@@2@@@@@@@@@@@@@@@@@@",0,0,0);
				Mem_Set((byte*)stSubCustInfo.EMAILADDR, 0x00, sizeof(stSubCustInfo.EMAILADDR));
				Str_Cpy(stSubCustInfo.EMAILADDR, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)));
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnChar
	��  �� : ���ڸ� �Է� ���� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar( long nChar )
	{
		if( m_bFirst == INIT_MAIN )
		{
			if( 0 == m_nOptionSet )
			{
				if( Get_iDlgCtrlByID(EDT_DATA1) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.CP_EXN, 0x00, sizeof(stSubCustInfo.CP_EXN));
					Str_Cpy(stSubCustInfo.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.CP_NUM, 0x00, sizeof(stSubCustInfo.CP_NUM));
					Str_Cpy(stSubCustInfo.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_EXN, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_EXN));
					Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA4) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.OWNHOUSE_TEL_NUM, 0x00, sizeof(stSubCustInfo.OWNHOUSE_TEL_NUM));
					Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
				}
			}
			else if( 1 == m_nOptionSet )
			{
				if( Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FIRM_TEL_EXN, 0x00, sizeof(stSubCustInfo.FIRM_TEL_EXN));
					Str_Cpy(stSubCustInfo.FIRM_TEL_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA6) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FIRM_TEL_NUM, 0x00, sizeof(stSubCustInfo.FIRM_TEL_NUM));
					Str_Cpy(stSubCustInfo.FIRM_TEL_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA7) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FAX_EXN, 0x00, sizeof(stSubCustInfo.FAX_EXN));
					Str_Cpy(stSubCustInfo.FAX_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA7)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA8) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FAX_NUM, 0x00, sizeof(stSubCustInfo.FAX_NUM));
					Str_Cpy(stSubCustInfo.FAX_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA8)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA9) == m_lActiveIndex )
				{
				
					Mem_Set((byte*)stSubCustInfo.EMAIL, 0x00, sizeof(stSubCustInfo.EMAIL));
					Str_Cpy(stSubCustInfo.EMAIL, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
				}
				else if( Get_iDlgCtrlByID(EDT_DATA10) == m_lActiveIndex )
				{
					if( (nChar < 48 ||  nChar > 57) )
					{
						MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
						EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
						return;
					}
					
					Mem_Set((byte*)stSubCustInfo.FAMILY_CNT, 0x00, sizeof(stSubCustInfo.FAMILY_CNT));
					Str_Cpy(stSubCustInfo.FAMILY_CNT, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA10)));
				}
			}
		}
		else if( m_bFirst == INIT_SMSREQ )
		{
			if( Get_iDlgCtrlByID(EDT_DATA11) == m_lActiveIndex ||
			    Get_iDlgCtrlByID(EDT_DATA12) == m_lActiveIndex )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lActiveIndex), "");
					return;
				}
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnPointing
	��  �� : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing( long nAction, long X, long Y )
	{
		long lActiveIndex = -1;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		m_lActiveIndex = lActiveIndex;
		
		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( 0 == m_nOptionSet )
					{
						if( X > DMS_X(STARTX+625) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+570-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+630-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+825) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+570-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+630-(g_Dlgflag*370))||
						    X > DMS_X(STARTX+625) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+630-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+690-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+825) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+630-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+690-(g_Dlgflag*370)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex )	
							{
								g_Dlgflag = 0;
								g_MOVE_DLG(370);
							
								ShowSip(FALSE);
								g_Sipflag = 0;
							}
						}
						else
						{
							if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370))  )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '1' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '2' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '3' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '4' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '5' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '6' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '7' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '8' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '9' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1180-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1270-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '0' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1180-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1270-(g_Dlgflag*370)) )
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
					}
					else if( 1 == m_nOptionSet )
					{
						if( X > DMS_X(STARTX+625) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+450-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+510-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+825) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+450-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+510-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+625) && X < DMS_X(STARTX+775) && Y > DMS_Y(STARTY+510-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+570-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+825) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+510-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+570-(g_Dlgflag*370)) ||
						    X > DMS_X(STARTX+300) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+630-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+690-(g_Dlgflag*370)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA7) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA8) == lActiveIndex ||
							    Get_iDlgCtrlByID(EDT_DATA10) == lActiveIndex )	
							{
								g_Dlgflag = 0;
								g_MOVE_DLG(370);
							
								ShowSip(FALSE);
								g_Sipflag = 0;
							}
						}
						else if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+895) && Y > DMS_Y(STARTY+330-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+390-(g_Dlgflag*370)) ||
						         X > DMS_X(STARTX+300) && X < DMS_X(STARTX+895) && Y > DMS_Y(STARTY+390-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+450-(g_Dlgflag*370)) )
						{
							if( Get_iDlgCtrlByID(EDT_DATA9) == lActiveIndex ||
							    Get_iDlgCtrlByID(CMB_DATA8) == lActiveIndex ) 
							{
								ShowSip(FALSE);
								g_Sipflag = 0;

								ShowSip(TRUE);
								g_Sipflag = 1;
							}
						}
						else
						{
							if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370))  )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '1' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '2' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+910-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1000-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '3' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '4' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '5' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1000-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1090-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '6' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(0) && X < DMS_X(333) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '7' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '8' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1090-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1180-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '9' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(333) && X < DMS_X(666) && Y > DMS_Y(STARTY+1180-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1270-(g_Dlgflag*370)) )
							{
								if( g_Dlgflag == 1 )
								{
									ON_CHAR( '0' );
									VM_PlaySound(CLICKSOUND);
								}
							}
							else if( X > DMS_X(666) && X < DMS_X(1000) && Y > DMS_Y(STARTY+1180-(g_Dlgflag*370)) && Y < DMS_Y(STARTY+1270-(g_Dlgflag*370)) )
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
					}
				}
			}
		}
		else if( m_bFirst == INIT_SMSREQ )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+500) && X < DMS_X(STARTX+725) && Y > DMS_Y(STARTY+320) && Y < DMS_Y(STARTY+380) ||
					    X > DMS_X(STARTX+775) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+320) && Y < DMS_Y(STARTY+380) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA11) == lActiveIndex ||
						    Get_iDlgCtrlByID(EDT_DATA12) == lActiveIndex )	
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
		
		ON_DRAW();
		return;
	}
	
	//---------------------------------------------------------------------------------------
	// �Ϲ� FUCTION
	//---------------------------------------------------------------------------------------
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ��ư �̹���
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
	
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			// ��ܰ���޴�
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
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );
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
		long i;
		char ch[2];
		Mem_Set((byte *)ch, 0x00, sizeof(ch));
		
		/********************************/
		/* ����                         */
		/********************************/
		// �����
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
		// ������
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
		
		/********************************/
		/* ������1                    */
		/********************************/
		if( 0 == m_nOptionSet )
		{
			/*********************** SetVisible ***********************/
			// ������1 true
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA5), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA6), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA8), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA9), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA10), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA11), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA12), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA13), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA55), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA15), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA16), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA17), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA18), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA19), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA20), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA23), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA24), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA25), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA41), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA42), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA57), TRUE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4), TRUE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5+1), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA13), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA13+1), TRUE);
			
			// ������2 false
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA26), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA27), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA28), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA29), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA30), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA31), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA32), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA33), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA34), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA35), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA36), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA37), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA38), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA39), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), FALSE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA6), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA7), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA8), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA9), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA10), FALSE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA6), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA6+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA7), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA7+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8+1), FALSE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA9), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA9+1), FALSE);	
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA10), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA10+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12+1), FALSE);
			
			// ��ȸ�����ü� Visible				
			if( Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") == 0 )
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA56), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14+1), TRUE);
			}
			else
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA56), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14+1), FALSE);
			}
			
			/*********************** SetRange ***********************/
			// �ּ�
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), "�ּ�");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA15),   STARTX,     STARTY+210, STARTX+150,  STARTY+270);
			
			// ����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), "����");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA16),   STARTX+150, STARTY+210, STARTX+300,  STARTY+270);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA22),   STARTX+300, STARTY+210, STARTX+575,  STARTY+270);
			
			// ȣ��
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "ȣ��");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA17),   STARTX+575, STARTY+210, STARTX+720,  STARTY+270);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA23),   STARTX+720, STARTY+210, STARTX+1000, STARTY+270);
			
			// ����ȣ��
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), "����ȣ��");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA18),   STARTX,     STARTY+270, STARTX+300,  STARTY+330);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA24),   STARTX+300, STARTY+270, STARTX+500,  STARTY+330);
			
			// ��Ÿ�ּ�
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), "��Ÿ�ּ�");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA19),   STARTX+500, STARTY+270, STARTX+720,  STARTY+330);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA25),   STARTX+720, STARTY+270, STARTX+1000, STARTY+330);
			
			// ����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), "����");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA5),    STARTX,     STARTY+330, STARTX+300,  STARTY+390);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA57),   STARTX+300, STARTY+330, STARTX+1000, STARTY+390);
			
			// ����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "����");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA4),    STARTX,     STARTY+390, STARTX+300,  STARTY+450);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA20),   STARTX+300, STARTY+390, STARTX+1000, STARTY+450);
			
			// �������
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA41), "�������");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA41),   STARTX,     STARTY+450, STARTX+300,  STARTY+510);
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA42),   STARTX+300, STARTY+450, STARTX+1000, STARTY+510);
			
			// ����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6), "����");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA6),    STARTX,     STARTY+510, STARTX+300,  STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA2), 	 STARTX+300, STARTY+510, STARTX+1000, STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA2+1),  STARTX+895, STARTY+510, STARTX+1000, STARTY+570);
			
			// �ڵ�����ȣ
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "�ڵ�����ȣ");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA8),    STARTX,     STARTY+570, STARTX+300,  STARTY+630);	
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA3), 	 STARTX+300, STARTY+570, STARTX+575,  STARTY+630);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA3+1),  STARTX+470, STARTY+572, STARTX+575,  STARTY+628);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA9), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA9),    STARTX+575, STARTY+570, STARTX+625,  STARTY+630);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA1),    STARTX+625, STARTY+570, STARTX+775,  STARTY+630);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA10), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA10),   STARTX+775, STARTY+570, STARTX+825,  STARTY+630);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA2),    STARTX+825, STARTY+570, STARTX+1000, STARTY+630);
			
			// ���ù�ȣ
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA11), "������ȭ");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA11),   STARTX,     STARTY+630, STARTX+300,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA4), 	 STARTX+300, STARTY+630, STARTX+575,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA4+1),  STARTX+470, STARTY+630, STARTX+575,  STARTY+690);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA12), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA12),   STARTX+575, STARTY+630, STARTX+625,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA3),    STARTX+625, STARTY+630, STARTX+775,  STARTY+690);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "-");		
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA13),   STARTX+775, STARTY+630, STARTX+825,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA4),    STARTX+825, STARTY+630, STARTX+1000, STARTY+690);
			
			// �δ���
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA55), "�δ���");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA55),   STARTX,     STARTY+690, STARTX+220,  STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA13), 	 STARTX+220, STARTY+690, STARTX+395,  STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA13+1), STARTX+395, STARTY+690, STARTX+500,  STARTY+750);
			
			// ��Ʈ��
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), "��Ʈ��");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA14),   STARTX+500, STARTY+690, STARTX+720,  STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA5), 	 STARTX+720, STARTY+690, STARTX+895,  STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA5+1),  STARTX+895, STARTY+690, STARTX+1000, STARTY+750);
			
			// ��ȸ�����ü�����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA56), "��ȸ�����ü�����");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA56),   STARTX,     STARTY+750, STARTX+500,  STARTY+810);	
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA14),   STARTX+500, STARTY+750, STARTX+900,  STARTY+810);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA14+1), STARTX+895, STARTY+750, STARTX+1000, STARTY+810);
			
			/*********************** SetAlign ***********************/
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA9), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA10), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA55), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA56), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA57), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA5), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
		/********************************/
		/* ������2                    */
		/********************************/
		else if( 1 == m_nOptionSet )
		{
			/*********************** SetVisible ***********************/
			// ������1 false
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA4), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA5), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA6), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA8), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA9), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA10), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA11), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA12), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA13), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA14), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA55), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA56), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA15), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA16), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA17), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA18), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA19), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA20), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA23), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA24), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA25), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA41), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA42), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA57), FALSE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4), FALSE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA2+1), FALSE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA3+1), FALSE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), FALSE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA5+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA13), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA13+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA14+1), FALSE);
			
			// ������2 true
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA26), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA27), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA28), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA29), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA30), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA31), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA32), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA33), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA34), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA35), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA36), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA37), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA38), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA39), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), TRUE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA6), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA7), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA8), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA9), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA10), TRUE);
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA6), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA6+1), TRUE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA7), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA7+1), TRUE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8+1), TRUE);		
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA9), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA9+1), TRUE);	
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA10), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA10+1), TRUE);
			
			/*********************** SetRange ***********************/
			// ��ȣ
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA33), "��ȣ");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA33),   STARTX,     STARTY+210, STARTX+300,  STARTY+270);
			
			if( Str_Cmp(stSc.PROD_CD, "20") == 0 || Str_Cmp(stSc.PROD_CD, "21") == 0 || Str_Cmp(stSc.PROD_CD, "22") == 0 )
			{
				if( Str_Len(stSc.FIRM_NM) == 0 )
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12), TRUE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12+1), TRUE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), FALSE);

					EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA12),   STARTX+300, STARTY+210, STARTX+1000, STARTY+270);
					EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA12+1), STARTX+895, STARTY+210, STARTX+1000, STARTY+270);
					
					for( i = 0;  FIRM_CD[i].Str[0] != 0; i++ )
					{
						ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA12+2), FIRM_CD[i].Str, 0, ICON_NONE);
					}
				}
				else
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12), FALSE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12+1), FALSE);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), TRUE);
					
					EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA40), STARTX+300, STARTY+210, STARTX+1000, STARTY+270);
				}
			}
			else
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA12+1), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA40), TRUE);
				
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA40), STARTX+300, STARTY+210, STARTX+1000, STARTY+270);
			}
			
			// ����ڹ�ȣ
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA32), "����ڹ�ȣ");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA32),   STARTX,     STARTY+270, STARTX+300,  STARTY+330);
			
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA39),   STARTX+300, STARTY+270, STARTX+1000, STARTY+330);
			
			// �̸���
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA34), "�̸���");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA34),   STARTX,     STARTY+330, STARTX+300,  STARTY+450);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA9),    STARTX+300, STARTY+330, STARTX+895,  STARTY+390);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA35), "@");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA35),   STARTX+895, STARTY+330, STARTX+1000, STARTY+390);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA8), 	 STARTX+300, STARTY+390, STARTX+895,  STARTY+450);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA8+1),  STARTX+895, STARTY+390, STARTX+1000, STARTY+450);

			// ȸ���ȣ	
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA26), "ȸ���ȣ");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA26),  STARTX,     STARTY+450, STARTX+300,   STARTY+510);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA6), 	STARTX+300, STARTY+450, STARTX+575,   STARTY+510);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA6+1), STARTX+470, STARTY+450, STARTX+575,   STARTY+510);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA27), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA27),  STARTX+575, STARTY+450, STARTX+625,   STARTY+510);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA5),   STARTX+625, STARTY+450, STARTX+775,   STARTY+510);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA28), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA28),  STARTX+775, STARTY+450, STARTX+825,   STARTY+510);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA6),   STARTX+825, STARTY+450, STARTX+1000,  STARTY+510);
			
			// �ѽ�
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA29), "�ѽ�");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA29),   STARTX,     STARTY+510, STARTX+300,  STARTY+570);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA7),  	 STARTX+300, STARTY+510, STARTX+575,  STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA7+1),  STARTX+470, STARTY+510, STARTX+575,  STARTY+570);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA30), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA30),   STARTX+575, STARTY+510, STARTX+625,  STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA7),    STARTX+625, STARTY+510, STARTX+775,  STARTY+570);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA31), "-");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA31),   STARTX+775, STARTY+510, STARTX+825,  STARTY+570);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA8),    STARTX+825, STARTY+510, STARTX+1000, STARTY+570);
			
			// ����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA36), "����");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA36),   STARTX,     STARTY+570, STARTX+170,  STARTY+630);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA9), 	 STARTX+170, STARTY+570, STARTX+1000, STARTY+630);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA9+1),  STARTX+895, STARTY+570, STARTX+1000, STARTY+630);
			
			// ������
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA37), "������");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA37),   STARTX,     STARTY+630, STARTX+300,  STARTY+690);
			EDITSETRANGE(Get_hDlgCtrlByID(EDT_DATA10),   STARTX+300, STARTY+630, STARTX+1000, STARTY+690);
			
			// ������
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA38), "������");
			EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA38),   STARTX,     STARTY+690, STARTX+300,  STARTY+750);
			
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA10), 	 STARTX+300, STARTY+690, STARTX+1000, STARTY+750);
			EDITSETRANGE(Get_hDlgCtrlByID(CMB_DATA10+1), STARTX+895, STARTY+690, STARTX+1000, STARTY+750);
			
			/*********************** SetAlign ***********************/
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA32), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA9), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA10), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA7), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA8), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA9), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA10), EDITALIGN_MIDDLE);		
		}
	}
	
	/*=======================================================================================
	�Լ��� : SetCombo
	��  �� : SetCombo
	Param  : 
	Return : 
	========================================================================================*/
	void SetCombo(void)
	{
		long i;
		
		if( 0 == m_nOptionSet )
		{
			// ����
			for( i = 0 ;  SCTRND_CD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA2+2), SCTRND_CD[i].Str, 0, ICON_NONE);
			}
			
			// �ڵ���
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_DATA3+2), "����", 0, ICON_NONE);
			
			for( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			// ����
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_DATA4+2), "����", 0, ICON_NONE);
			
			for( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA4+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			/*
			// �ڵ���
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_DATA3+2) , "",0,ICON_NONE);
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '1' ORDER BY SORT_ORDER", CMB_DATA3+2);
			
			// ����
			ListCtrl_AddItem( Get_hDlgCtrlByID(CMB_DATA4+2) , "",0,ICON_NONE);
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'A10110' AND C_VALUE = '2' ORDER BY SORT_ORDER", CMB_DATA4+2);
			*/
			
			// ��Ʈ��
			for( i = 0 ;  SCBUILT_IN[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA5+2), SCBUILT_IN[i].Str, 0, ICON_NONE);
			}
			
			// �δ���
			for( i = 0 ;  SCBUILT_IN[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA13+2), SCBUILT_IN[i].Str, 0, ICON_NONE);
			}
			
			// ��ȸ�����ü�
			for( i = 0 ;  SOCIAL_FACI_STS_CD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA14+2), SOCIAL_FACI_STS_CD[i].Str, 0, ICON_NONE);
			}
		}
		else
		{
			// ȸ��
			for( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA6+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			// �ѽ�
			for( i = 0 ;  SCTEL_DDD[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA7+2), SCTEL_DDD[i].Str, 0, ICON_NONE);
			}
			
			// �����ּ�
			for( i = 0 ;  SCEMAIL[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA8+2), SCEMAIL[i].Str, 0, ICON_NONE);
			}
			
			// ����
			for( i = 0 ;  SCSQUARE[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA9+2), SCSQUARE[i].Str, 0, ICON_NONE);
			}
			
			// ������
			for( i = 0 ;  SCRELAT[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA10+2), SCRELAT[i].Str, 0, ICON_NONE);
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : Cust_SetData
	��  �� : stScCustInfo setting
	Param  : 
	Return : 
	========================================================================================*/
	void Cust_SetData(void)
	{
		long i, idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stScCustInfo, 0x00, sizeof(stScCustInfo));
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, " SELECT CHK_EXEC_NUM, BUILT_IN_YN, Trim(SQUARE_METER), CUST_NUM, CUST_NM \
												 , Trim(CUST_TYPE_CD), Trim(CUST_TRND_CD), Trim(OWNHOUSE_TEL_DDD), Trim(OWNHOUSE_TEL_EXN), Trim(OWNHOUSE_TEL_NUM) \
												 , Trim(CP_DDD), Trim(CP_EXN), Trim(CP_NUM), FAMILY_CNT, FIRM_NM \
												 , EMAIL, Trim(FIRM_TEL_DDD), Trim(FIRM_TEL_EXN), Trim(FIRM_TEL_NUM), Trim(FAX_DDD) \
												 , Trim(FAX_EXN), Trim(FAX_NUM), SOC_NUM, Trim(SCG_RELAT_CD), PDA_IP \
											     , UPD_EMPID, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR \
											     , CHK_ORDER, OBJ_YM, PLAN_YM, SEND_YN, INDUCTION_INST_YN \
											     , FACI_STS_CD \
											  FROM NORMAL_INFO \
											 WHERE CHK_EXEC_NUM = ? "
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szCHK_EXEC_NUM , 12, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CHK_EXEC_NUM      , 12 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.BUILT_IN_YN       , 1  + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.SQUARE_METER      , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CUST_NUM          , 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CUST_NM           , 30 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CUST_TYPE_CD      , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CUST_TRND_CD      , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.OWNHOUSE_TEL_DDD  , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.OWNHOUSE_TEL_EXN  , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.OWNHOUSE_TEL_NUM  , 4  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CP_DDD            , 4  + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CP_EXN            , 4  + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CP_NUM            , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FAMILY_CNT        , 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FIRM_NM           , 50 + 1, DECRYPT );
				
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.EMAIL             , 50 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FIRM_TEL_DDD      , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FIRM_TEL_EXN      , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FIRM_TEL_NUM      , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FAX_DDD           , 4  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FAX_EXN           , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FAX_NUM           , 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.SOC_NUM           , 13 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.SCG_RELAT_CD      , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.PDA_IP            , 32 + 1, DECRYPT );
				
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.UPD_EMPID         , 20 + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.BLD_NUM           , 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.INST_PLACE_NUM    , 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CHK_TYPE          , 2  + 1, DECRYPT );	
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CHK_YEAR          , 4  + 1, DECRYPT );
				
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.CHK_ORDER         , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.OBJ_YM            , 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.PLAN_YM           , 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.SEND_YN           , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.INDUCTION_INST_YN , 1  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stScCustInfo.FACI_STS_CD       , 1  + 1, DECRYPT );
		}
		
	Finally:

		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	�Լ��� : SetStruct
	��  �� : stSubCustInfo setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetStruct(void)
	{
		char szSql[200];
		long lCnt;
		long i;
		long len;
		long length;
		long k = 0;
		
		Mem_Set( (byte*)&stSubCustInfo, 0x00, sizeof(stSubCustInfo) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_INFO WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &m_lCnt);	

		if( m_lCnt > 0 )
		{
			Cust_SetData();

			Str_Cpy(stSubCustInfo.CUST_NUM,			stScCustInfo.CUST_NUM);
			Str_Cpy(stSubCustInfo.CUST_NM,			stScCustInfo.CUST_NM);
			Str_Cpy(stSubCustInfo.CUST_TYPE_CD,		stScCustInfo.CUST_TYPE_CD);
			Str_Cpy(stSubCustInfo.CUST_TRND_CD,		stScCustInfo.CUST_TRND_CD);
			Str_Cpy(stSubCustInfo.SOC_NUM,		    stScCustInfo.SOC_NUM);
			Str_Cpy(stSubCustInfo.CP_DDD, 			stScCustInfo.CP_DDD);
			Str_Cpy(stSubCustInfo.CP_EXN, 			stScCustInfo.CP_EXN);
			Str_Cpy(stSubCustInfo.CP_NUM, 			stScCustInfo.CP_NUM);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_DDD,	stScCustInfo.OWNHOUSE_TEL_DDD);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_EXN,	stScCustInfo.OWNHOUSE_TEL_EXN);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_NUM,	stScCustInfo.OWNHOUSE_TEL_NUM);
			Str_Cpy(stSubCustInfo.BUILT_IN_YN,		stScCustInfo.BUILT_IN_YN);
			Str_Cpy(stSubCustInfo.FIRM_TEL_DDD,		stScCustInfo.FIRM_TEL_DDD);
			Str_Cpy(stSubCustInfo.FIRM_TEL_EXN,		stScCustInfo.FIRM_TEL_EXN);
			Str_Cpy(stSubCustInfo.FIRM_TEL_NUM,		stScCustInfo.FIRM_TEL_NUM);
			Str_Cpy(stSubCustInfo.FAX_DDD,			stScCustInfo.FAX_DDD);
			Str_Cpy(stSubCustInfo.FAX_EXN,			stScCustInfo.FAX_EXN);
			Str_Cpy(stSubCustInfo.FAX_NUM,			stScCustInfo.FAX_NUM);
			Str_Cpy(stSubCustInfo.FIRM_NM,          stScCustInfo.FIRM_NM);
	
			length = Str_Len(stScCustInfo.EMAIL);
			
			if( length > 0 )
			{
				for( i=0 ; length ; i++)
				{
					if(stScCustInfo.EMAIL[i] == '@')
					{
						len = i;
						break;
					}
					else if(stScCustInfo.EMAIL[i] == '')
					{
						k++;
						break;
					}
				}

				Mem_Cpy((byte *)stSubCustInfo.EMAIL, (byte *)stScCustInfo.EMAIL, len);
				
				if( k == 0 )
				{
					Mem_Cpy((byte *)stSubCustInfo.EMAILADDR, (byte *)stScCustInfo.EMAIL+(len+1), length-(len+1));
				}
			}
			
			Str_Cpy(stSubCustInfo.SQUARE_METER,		stScCustInfo.SQUARE_METER);
			Str_Cpy(stSubCustInfo.FAMILY_CNT,		stScCustInfo.FAMILY_CNT);
			Str_Cpy(stSubCustInfo.SCG_RELAT_CD,		stScCustInfo.SCG_RELAT_CD);
			Str_Cpy(stSubCustInfo.INDUCTION_INST_YN,stScCustInfo.INDUCTION_INST_YN);
			Str_Cpy(stSubCustInfo.FACI_STS_CD,      stScCustInfo.FACI_STS_CD);
		}
		else
		{
			Str_Cpy(stSubCustInfo.CUST_NUM,			stSc.CUST_NUM);
			Str_Cpy(stSubCustInfo.CUST_NM,			stSc.CUST_NM);
			Str_Cpy(stSubCustInfo.CUST_TYPE_CD,		stSc.CUST_TYPE_CD);
			Str_Cpy(stSubCustInfo.CUST_TRND_CD,		stSc.CUST_TRND_CD);
			Str_Cpy(stSubCustInfo.SOC_NUM,	    	stSc.SOC_NUM);
			Str_Cpy(stSubCustInfo.CP_DDD, 			stSc.CP_DDD);
			Str_Cpy(stSubCustInfo.CP_EXN, 			stSc.CP_EXN);
			Str_Cpy(stSubCustInfo.CP_NUM, 			stSc.CP_NUM);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_DDD,	stSc.OWNHOUSE_TEL_DDD);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_EXN,	stSc.OWNHOUSE_TEL_EXN);
			Str_Cpy(stSubCustInfo.OWNHOUSE_TEL_NUM,	stSc.OWNHOUSE_TEL_NUM);
			Str_Cpy(stSubCustInfo.BUILT_IN_YN,		stSc.BUILT_IN_YN);
			Str_Cpy(stSubCustInfo.FIRM_TEL_DDD,		stSc.FIRM_TEL_DDD);
			Str_Cpy(stSubCustInfo.FIRM_TEL_EXN,		stSc.FIRM_TEL_EXN);
			Str_Cpy(stSubCustInfo.FIRM_TEL_NUM,		stSc.FIRM_TEL_NUM);
			Str_Cpy(stSubCustInfo.FAX_DDD,			stSc.FAX_DDD);
			Str_Cpy(stSubCustInfo.FAX_EXN,			stSc.FAX_EXN);
			Str_Cpy(stSubCustInfo.FAX_NUM,			stSc.FAX_NUM);
			Str_Cpy(stSubCustInfo.FIRM_NM,          stSc.FIRM_NM);
			
			length = Str_Len(stSc.EMAIL);
			
			if( length > 0 )
			{
				for( i=0 ; length ; i++)
				{
					if(stSc.EMAIL[i] == '@')
					{
						len = i;
						break;
					}
					else if(stSc.EMAIL[i] == '')
					{
						k++;
						break;
					}
				}
				
				Mem_Cpy((byte *)stSubCustInfo.EMAIL, (byte *)stSc.EMAIL, len+1);
				
				if( k == 0 )
				{
					Mem_Cpy((byte *)stSubCustInfo.EMAILADDR, (byte *)stSc.EMAIL+(len+1), length-(len+1));
				}
			}
			
			Str_Cpy(stSubCustInfo.SQUARE_METER,		 stSc.SQUARE_METER);
			Str_Cpy(stSubCustInfo.FAMILY_CNT,		 stSc.FAMILY_CNT);
			Str_Cpy(stSubCustInfo.SCG_RELAT_CD,		 stSc.SCG_RELAT_CD);
			Str_Cpy(stSubCustInfo.INDUCTION_INST_YN, stSc.INDUCTION_INST_YN);
			Str_Cpy(stSubCustInfo.FACI_STS_CD,       "1" );
		}
	}
	
	/*=======================================================================================
	�Լ��� : REDRAW
	��  �� : ȭ�� DRAW
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		long i;
		char szTmp[11];
		char szTmp2[30];
		
		/******************************/
		/* ����                       */
		/******************************/
		// ������ȣ
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), stSc.USE_CONT_NUM);
		
		// ���޻���
		i = g_SearchCD( stSc.CONT_STS_CD, SCCONTSTS );
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), SCCONTSTS[i].Str);
		
		if( Str_Cmp(stSc.CONT_STS_CD, "30") == 0 )
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), RED);
		}
		
		if( Str_Cmp(stSc.BILL_SEND_METHOD, "S" ) == 0 )
		{
			Str_Cpy( szTmp2, "�۴�" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "E" ) == 0 )
		{
			Str_Cpy( szTmp2, "�̸���" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "L" ) == 0 )
		{
			Str_Cpy( szTmp2, "LMS" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "M" ) == 0 )
		{
			Str_Cpy( szTmp2, "�����" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "A" ) == 0 )
		{
			Str_Cpy( szTmp2, "EM+��" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "B" ) == 0 )
		{
			Str_Cpy( szTmp2, "LM+��" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "C" ) == 0 )
		{
			Str_Cpy( szTmp2, "��+��" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "D" ) == 0 )
		{
			Str_Cpy( szTmp2, "E+LM" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "F" ) == 0 )
		{
			Str_Cpy( szTmp2, "��+EM" );
		}
		else if( Str_Cmp(stSc.BILL_SEND_METHOD, "G" ) == 0 )
		{
			Str_Cpy( szTmp2, "��+LM" );
		}

		// û�����ǥ��
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_REQ), szTmp2);
		
		/* ���� SMS������û
			if( Str_Cmp(stSc.SMS_SEND_AGREE_YN, "Y") == 0 )
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMSREQ), BTNMENUFRCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMSREQ), BTNCTRLBKCOLOR);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), TRUE );
			}
			else
			{
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMSREQ), RED);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMSREQ), PDAEDTCTRLBK);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), FALSE );
			}
		*/
		
		// SMS��û : Y = GREEN, N = YELLOW
		if( Str_Cmp(stSc.SMS_SEND_AGREE_YN, "Y") == 0 )
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMSREQ), TXTTTLFRCOLOR);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMSREQ), GREEN);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), FALSE );
		}
		else
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMSREQ), TXTTTLFRCOLOR);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMSREQ), RED);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SMSREQ), FALSE );
		}
		
		/******************************/
		/* ������1                  */
		/******************************/
		if( m_nOptionSet == 0 )
		{
			// ������_1
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLIENT), FALSE );
			
			// ������_2
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLIENT2), TRUE );
			
			// ����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), stSc.CUST_NM);
				
			// ����
			i = g_SearchCD( stSubCustInfo.CUST_TYPE_CD, SCTYPE_CD );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA57), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA57), SCTYPE_CD[i].Str);
			}
			
			// ����
			i = g_SearchCD( stSubCustInfo.CUST_TRND_CD, SCTRND_CD );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA2), SCTRND_CD[i].Str);
			}
			
			// �������
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			Mem_Cpy((byte *)szTmp, (byte *)stSubCustInfo.SOC_NUM, 6);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA42),  szTmp);
			
			// �޴���ȭ1
			if(Str_Len(stSubCustInfo.CP_DDD) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3),  stSubCustInfo.CP_DDD);
			}
			
			// �޴���ȭ2
			if(Str_Len(stSubCustInfo.CP_EXN) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1),  stSubCustInfo.CP_EXN);
			}
			
			// �޴���ȭ3
			if(Str_Len(stSubCustInfo.CP_NUM) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2),  stSubCustInfo.CP_NUM);
			}
			
			// ������ȭ1
			if(Str_Len(stSubCustInfo.OWNHOUSE_TEL_DDD) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA4), stSubCustInfo.OWNHOUSE_TEL_DDD);
			}
			
			// ������ȭ2
			if(Str_Len(stSubCustInfo.OWNHOUSE_TEL_EXN) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), stSubCustInfo.OWNHOUSE_TEL_EXN);
			}
			
			// ������ȭ3
			if(Str_Len(stSubCustInfo.OWNHOUSE_TEL_NUM) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), stSubCustInfo.OWNHOUSE_TEL_NUM);
			}

			// ��Ʈ��
			i = g_SearchCD( stSubCustInfo.BUILT_IN_YN, SCBUILT_IN );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA5), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA5), SCBUILT_IN[i].Str);
			}
			
			// �δ���
			i = g_SearchCD( stSubCustInfo.INDUCTION_INST_YN, SCBUILT_IN );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA13), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA13), SCBUILT_IN[i].Str);
			}
			
			// ��ȸ�����ü�
			i = g_SearchCD( stSubCustInfo.FACI_STS_CD, SOCIAL_FACI_STS_CD );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA14), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA14), SOCIAL_FACI_STS_CD[i].Str);
			}
			
			// ����
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), stSc.ADDR1_M);
			
			// ȣ��		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), stSc.ADDR1_S);
							
			// ����ȣ��
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA24), stSc.HOUSE_CNT);
			
			// ��Ÿ�ּ�			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA25), stSc.LOT_NUM_SECOND_ADDR);
		}
		else
		{
			// ������_1
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLIENT), TRUE );
			
			// ������_2
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CLIENT2), FALSE );
			
			// ȸ���ȣ1
			if(Str_Len(stSubCustInfo.FIRM_TEL_DDD) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6),  stSubCustInfo.FIRM_TEL_DDD);
			}
			
			// ȸ���ȣ2
			if(Str_Len(stSubCustInfo.FIRM_TEL_EXN) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5),  stSubCustInfo.FIRM_TEL_EXN);
			}
			
			// ȸ���ȣ3
			if(Str_Len(stSubCustInfo.FIRM_TEL_NUM) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA6),  stSubCustInfo.FIRM_TEL_NUM);
			}
			
			// ������ȭ1
			if(Str_Len(stSubCustInfo.FAX_DDD) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), stSubCustInfo.FAX_DDD);
			}
			
			// ������ȭ2
			if(Str_Len(stSubCustInfo.FAX_EXN) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA7), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA7), stSubCustInfo.FAX_EXN);
			}
			
			// ������ȭ3
			if(Str_Len(stSubCustInfo.FAX_NUM) == 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA8), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA8), stSubCustInfo.FAX_NUM);
			}
			
			// ����ڹ�ȣ
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA39), stSc.BIZ_REGI_NUM);
			
			// ��ȣ
			if( Str_Cmp(stSc.PROD_CD, "20") == 0 || Str_Cmp(stSc.PROD_CD, "21") == 0 || Str_Cmp(stSc.PROD_CD, "22") == 0 )
			{
				if( Str_Len(stSc.FIRM_NM) == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA12), stSubCustInfo.FIRM_NM);	
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA40), stSubCustInfo.FIRM_NM);
				}
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA40), stSubCustInfo.FIRM_NM);
			}
			
			// �̸���
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA9), stSubCustInfo.EMAIL);
			
			// �̸����ּ�	
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA8), stSubCustInfo.EMAILADDR);
			
			// ����
			i = g_SearchCD( stSubCustInfo.SQUARE_METER, SCSQUARE );
			if( i == -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA9), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA9), SCSQUARE[i].Str);
			}
			
			// ������
			EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA10), stSubCustInfo.FAMILY_CNT);
			
			// ������
			i = g_SearchCD( stSubCustInfo.SCG_RELAT_CD, SCRELAT );
			if( i == -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA10), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA10), SCRELAT[i].Str);
			}
		}
	}

	/*=======================================================================================
	�Լ��� : Validate
	��  �� : Ȯ�� Validation
	Param  : 
	Return : 
	========================================================================================*/	
	bool Validate(void)
	{
		char szEmail[60];
		char szMsg[100];
		long nLen = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA5))) < 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��Ʈ�� ���θ� �����ּ���.");
				return FALSE;
			}
	
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9))) == 0 && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8))) > 0)
			{
				MessageBoxEx (CONFIRM_OK, "�̸��� �ּҸ� Ȯ�����ּ���.");
				return FALSE;
			}
			else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9))) > 0 && Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "�̸��� �ּҸ� Ȯ�����ּ���.");
				return FALSE;
			}
			
			/*
			if( stSubCustInfo.CUST_NUM[0] == '0' )
			{
				MessageBoxEx (CONFIRM_OK, "�ӽð��� ������ �Ұ����մϴ�.");
				return FALSE;
			}
			*/
			
			if( stSubCustInfo.CUST_NUM[0] == '0' && Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") != 0 )
			{
				MessageBoxEx (CONFIRM_OK, "�ӽð��� ������ �Ұ����մϴ�.");
				return FALSE;
			}
			
			// ����
			Mem_Set( (byte*)szEmail, 0x00, sizeof(szEmail) );
			Str_Cpy(szEmail, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
			Str_Cat(szEmail, "@");
			Str_Cat(szEmail, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)));
			
			// �޸�
			nLen = g_GetUtf8Size(szEmail);
			if( nLen > 50 )
			{
				Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
				SPRINT(szMsg, "�������!\n(�̸����� �ѱ� 16��,\n����,���� 50�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
				MessageBoxEx(CONFIRM_OK, szMsg);
				return FALSE;
			}
			
			// �ڵ���
			if( !g_CheckPhoneNumber( "1", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) ))
			{
				MessageBoxEx(CONFIRM_OK, "������ �ڵ�����ȣ��\nȮ�����ּ���.");
				return FALSE;
			}

			// ���ù�ȣ
			if( !g_CheckPhoneNumber("2", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)) , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)) , EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) ))
			{
				MessageBoxEx(CONFIRM_OK, "������ ������ȭ��ȣ��\nȮ�����ּ���.");
				return FALSE;
			}
			
		}
		else if( m_bFirst == INIT_SMSREQ )
		{
			if( m_lSmsReqFlag == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "���ǿ��θ� �������ּ���.");
				return FALSE;
			}

			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA11))) == 0 ||
			    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11))) == 0 || 
			    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA12))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "�޴���ȭ ��ȣ�� �Է��ϼ���!");
				return FALSE;
			}
		}
		
		return TRUE;
	}
	
	/*=======================================================================================
	�Լ��� : Save_Cust
	��  �� : ������ ����
	Param  : 
	Return : 
	========================================================================================*/	
	bool Save_Cust(void)
	{
		char szSql[650];
		long idx;
		long i;
		long lCnt;
		bool ret = TRUE;
		char szToday[20];
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_INFO WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lCnt);	
		
		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		//���˽����ȣ
		Mem_Set( (byte*)stScCustInfo.CHK_EXEC_NUM, 0x00, sizeof(stScCustInfo.CHK_EXEC_NUM) );
		Str_Cpy(stScCustInfo.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
		
		//����ȣ
		Mem_Set( (byte*)stScCustInfo.CUST_NUM, 0x00, sizeof(stScCustInfo.CUST_NUM) );
		Str_Cpy(stScCustInfo.CUST_NUM, stSubCustInfo.CUST_NUM);
		
		//����
		Mem_Set( (byte*)stScCustInfo.CUST_NM, 0x00, sizeof(stScCustInfo.CUST_NM) );
		Str_Cpy(stScCustInfo.CUST_NM, stSubCustInfo.CUST_NM);
		
		//����
		Mem_Set( (byte*)stScCustInfo.CUST_TYPE_CD, 0x00, sizeof(stScCustInfo.CUST_TYPE_CD) );
		Str_Cpy(stScCustInfo.CUST_TYPE_CD, stSubCustInfo.CUST_TYPE_CD);
		
		//����
		Mem_Set( (byte*)stScCustInfo.CUST_TRND_CD, 0x00, sizeof(stScCustInfo.CUST_TRND_CD) );
		Str_Cpy(stScCustInfo.CUST_TRND_CD, stSubCustInfo.CUST_TRND_CD);
		
		//�ڵ�����ȣ
		Mem_Set( (byte*)stScCustInfo.CP_DDD, 0x00, sizeof(stScCustInfo.CP_DDD) );
		Mem_Set( (byte*)stScCustInfo.CP_EXN, 0x00, sizeof(stScCustInfo.CP_EXN) );
		Mem_Set( (byte*)stScCustInfo.CP_NUM, 0x00, sizeof(stScCustInfo.CP_NUM) );
		
		Str_Cpy(stScCustInfo.CP_DDD, stSubCustInfo.CP_DDD);
		Str_Cpy(stScCustInfo.CP_EXN, stSubCustInfo.CP_EXN);
		Str_Cpy(stScCustInfo.CP_NUM, stSubCustInfo.CP_NUM);
		
		//������ȭ
		Mem_Set( (byte*)stScCustInfo.OWNHOUSE_TEL_DDD, 0x00, sizeof(stScCustInfo.OWNHOUSE_TEL_DDD) );
		Mem_Set( (byte*)stScCustInfo.OWNHOUSE_TEL_EXN, 0x00, sizeof(stScCustInfo.OWNHOUSE_TEL_EXN) );
		Mem_Set( (byte*)stScCustInfo.OWNHOUSE_TEL_NUM, 0x00, sizeof(stScCustInfo.OWNHOUSE_TEL_NUM) );
		
		Str_Cpy(stScCustInfo.OWNHOUSE_TEL_DDD, stSubCustInfo.OWNHOUSE_TEL_DDD);
		Str_Cpy(stScCustInfo.OWNHOUSE_TEL_EXN, stSubCustInfo.OWNHOUSE_TEL_EXN);
		Str_Cpy(stScCustInfo.OWNHOUSE_TEL_NUM, stSubCustInfo.OWNHOUSE_TEL_NUM);
		
		//��Ʈ�ο���
		Str_Cpy(stScCustInfo.BUILT_IN_YN, stSubCustInfo.BUILT_IN_YN);
		
		//ȸ���ȣ
		Str_Cpy(stScCustInfo.FIRM_TEL_DDD, stSubCustInfo.FIRM_TEL_DDD);
		Str_Cpy(stScCustInfo.FIRM_TEL_EXN, stSubCustInfo.FIRM_TEL_EXN);
		Str_Cpy(stScCustInfo.FIRM_TEL_NUM, stSubCustInfo.FIRM_TEL_NUM);
		
		//�ѽ�
		Str_Cpy(stScCustInfo.FAX_DDD, stSubCustInfo.FAX_DDD);
		Str_Cpy(stScCustInfo.FAX_EXN, stSubCustInfo.FAX_EXN);
		Str_Cpy(stScCustInfo.FAX_NUM, stSubCustInfo.FAX_NUM);
		
		//��ȣ
		Str_Cpy(stScCustInfo.FIRM_NM, stSubCustInfo.FIRM_NM);

		//�̸���
		Str_Cpy(stSubCustInfo.EMAIL, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA9)));
		Str_Cpy(stSubCustInfo.EMAILADDR, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)));
		
		if(Str_Len(stSubCustInfo.EMAIL) > 0 && Str_Len(stSubCustInfo.EMAILADDR) > 0 )
		{
			Str_Cpy(stScCustInfo.EMAIL, stSubCustInfo.EMAIL);
			Str_Cat(stScCustInfo.EMAIL, "@");
			Str_Cat(stScCustInfo.EMAIL, stSubCustInfo.EMAILADDR);
		}
		else
		{
			Str_Cpy(stScCustInfo.EMAIL, stSubCustInfo.EMAIL);
			Str_Cat(stScCustInfo.EMAIL, stSubCustInfo.EMAILADDR);
		}
		//����
		Str_Cpy(stScCustInfo.SQUARE_METER, stSubCustInfo.SQUARE_METER);
		//������
		Str_Cpy(stScCustInfo.FAMILY_CNT, stSubCustInfo.FAMILY_CNT);
		//������
		Str_Cpy(stScCustInfo.SCG_RELAT_CD, stSubCustInfo.SCG_RELAT_CD);
		
		//�δ���
		Str_Cpy(stScCustInfo.INDUCTION_INST_YN, stSubCustInfo.INDUCTION_INST_YN);
		//��ȸ�����ü�
		Str_Cpy(stScCustInfo.FACI_STS_CD, stSubCustInfo.FACI_STS_CD);
		
		//�۽ſ���
		Str_Cpy(stScCustInfo.SEND_YN, "S" );
		
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		Str_ItoA(Time_GetDate(), szToday, 10);
		
		//��ȸ�����ü� üũ ��¥
		Str_Cpy( stScCustInfo.CHK_YMD, szToday );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		if( Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") == 0 )
		{
			if( lCnt > 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " UPDATE NORMAL_INFO \
				                   SET CHK_EXEC_NUM = ?, CUST_NUM = ?, CUST_NM = ?, CUST_TYPE_CD = ?, CUST_TRND_CD = ? \
				                     , CP_DDD = ?, CP_EXN = ?, CP_NUM = ?, OWNHOUSE_TEL_DDD = ?, OWNHOUSE_TEL_EXN = ? \
				                     , OWNHOUSE_TEL_NUM = ?, BUILT_IN_YN = ?, FIRM_TEL_DDD = ?, FIRM_TEL_EXN = ?, FIRM_TEL_NUM = ? \
				                     , FAX_DDD = ?, FAX_EXN = ?, FAX_NUM = ?, FIRM_NM = ?, EMAIL = ? \
				                     , SQUARE_METER = ?, FAMILY_CNT = ?, SCG_RELAT_CD = ?, SEND_YN = ?, BLD_NUM = ?, INST_PLACE_NUM = ? \
				                     , CHK_TYPE = ?, CHK_YEAR = ?, CHK_ORDER = ?, OBJ_YM = ?, PLAN_YM = ? \
				                     , PDA_IP = ?, UPD_EMPID = ?, INDUCTION_INST_YN = ?, CHK_YMD = ?, FACI_STS_CD = ? \
				                 WHERE CHK_EXEC_NUM = '%s' "
				      , g_szCHK_EXEC_NUM, 0, 0);
			}
			else
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " INSERT INTO NORMAL_INFO \
				                ( CHK_EXEC_NUM, CUST_NUM, CUST_NM, CUST_TYPE_CD, CUST_TRND_CD, CP_DDD, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN \
				                , OWNHOUSE_TEL_NUM, BUILT_IN_YN, FIRM_TEL_DDD, FIRM_TEL_EXN, FIRM_TEL_NUM, FAX_DDD, FAX_EXN, FAX_NUM, FIRM_NM, EMAIL \
				                , SQUARE_METER, FAMILY_CNT, SCG_RELAT_CD, SEND_YN, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR, CHK_ORDER, OBJ_YM \
				                , PLAN_YM, PDA_IP, UPD_EMPID, INDUCTION_INST_YN, CHK_YMD, FACI_STS_CD ) \
				                VALUES( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
					 	              , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
						              , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
						              , ?, ?, ?, ?, ?, ? ) "
				      , 0, 0, 0);
			}
		}
		else
		{
			if( lCnt > 0 )
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " UPDATE NORMAL_INFO \
				                   SET CHK_EXEC_NUM = ?, CUST_NUM = ?, CUST_NM = ?, CUST_TYPE_CD = ?, CUST_TRND_CD = ? \
				                     , CP_DDD = ?, CP_EXN = ?, CP_NUM = ?, OWNHOUSE_TEL_DDD = ?, OWNHOUSE_TEL_EXN = ? \
				                     , OWNHOUSE_TEL_NUM = ?, BUILT_IN_YN = ?, FIRM_TEL_DDD = ? , FIRM_TEL_EXN = ?, FIRM_TEL_NUM = ? \
				                     , FAX_DDD = ?, FAX_EXN = ?, FAX_NUM = ?, FIRM_NM = ?, EMAIL = ? \
				                     , SQUARE_METER = ?, FAMILY_CNT = ?, SCG_RELAT_CD = ?, SEND_YN = ?, BLD_NUM = ?, INST_PLACE_NUM = ? \
				                     , CHK_TYPE = ?, CHK_YEAR = ?, CHK_ORDER = ?, OBJ_YM = ?, PLAN_YM = ? \
				                     , PDA_IP = ?, UPD_EMPID = ?, INDUCTION_INST_YN = ?, CHK_YMD = ? \
				                 WHERE CHK_EXEC_NUM = '%s' "
				      , g_szCHK_EXEC_NUM, 0, 0);
			}
			else
			{
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, " INSERT INTO NORMAL_INFO \
						        ( CHK_EXEC_NUM, CUST_NUM, CUST_NM, CUST_TYPE_CD, CUST_TRND_CD, CP_DDD, CP_EXN, CP_NUM, OWNHOUSE_TEL_DDD, OWNHOUSE_TEL_EXN \
							    , OWNHOUSE_TEL_NUM, BUILT_IN_YN, FIRM_TEL_DDD, FIRM_TEL_EXN, FIRM_TEL_NUM, FAX_DDD, FAX_EXN, FAX_NUM, FIRM_NM, EMAIL \
							    , SQUARE_METER, FAMILY_CNT, SCG_RELAT_CD, SEND_YN, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR, CHK_ORDER, OBJ_YM \
							    , PLAN_YM, PDA_IP, UPD_EMPID, INDUCTION_INST_YN, CHK_YMD ) \
							    VALUES \
							    ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
							    , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
							    , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? \
							    , ?, ?, ?, ?, ? ) " 
					  , 0, 0, 0);
			}
		}	

		hstmt = sql->CreateStatement(sql, szSql);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CHK_EXEC_NUM      	,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_NUM         	,10,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_NM         	,30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_TYPE_CD        ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_TRND_CD      	,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_DDD 				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_EXN 				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_NUM     			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_DDD	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_EXN	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_NUM	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.BUILT_IN_YN			,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_DDD		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_EXN		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_NUM		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_DDD        		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_EXN 			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_NUM 			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_NM     		,50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.EMAIL				,50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SQUARE_METER		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAMILY_CNT			,3 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SCG_RELAT_CD		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SEND_YN				,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM       				,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM				,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE      				,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR      				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER     				,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM        				,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM       				,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip		        ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id         ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.INDUCTION_INST_YN	,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CHK_YMD             ,8 + 1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FACI_STS_CD         ,1 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			Copy_Info();
			MessageBoxEx (CONFIRM_OK, "��ϵǾ����ϴ�.");
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Copy_Info
	��  �� : TEXTBOX, EDITER
	Param  : 
	Return : 
	========================================================================================*/	
	void Copy_Info(void)
	{
		long idx = 0;
		char szSql[650];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE NORMAL_DATA \
		                  SET CP_DDD = ?, CP_EXN = ?, CP_NUM = ?, OWNHOUSE_TEL_DDD = ?, OWNHOUSE_TEL_EXN = ? \
							, OWNHOUSE_TEL_NUM = ?, BUILT_IN_YN = ?, FIRM_TEL_DDD = ?, FIRM_TEL_EXN = ?, FIRM_TEL_NUM = ? \
							, FAX_DDD = ?, FAX_EXN = ?, FAX_NUM = ?, FIRM_NM = ?, EMAIL = ? \
							, SQUARE_METER = ?, FAMILY_CNT = ?, SCG_RELAT_CD = ?, CUST_TRND_CD = ?, INDUCTION_INST_YN = ? \
					    WHERE CHK_EXEC_NUM = '%s' "
				    , g_szCHK_EXEC_NUM, 0, 0);
			
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_DDD 				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_EXN 				,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CP_NUM     			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_DDD	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_EXN	,4 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.OWNHOUSE_TEL_NUM	,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.BUILT_IN_YN			,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_DDD		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_EXN		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_TEL_NUM		,4 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_DDD        		,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_EXN 			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAX_NUM 			,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FIRM_NM     		,50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.EMAIL				,50,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SQUARE_METER		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.FAMILY_CNT			,3 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.SCG_RELAT_CD		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.CUST_TRND_CD      	,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScCustInfo.INDUCTION_INST_YN   ,1 ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

Finally:
		DelSqLite(sql);
		return ;
	}
	
	/*=======================================================================================
	�Լ��� : Compare_Data
	��  �� : ��������� ������ ��
	Param  : 
	Return : 
	========================================================================================*/
	bool Compare_Data(void)
	{
		char szTmp[100];
		long lChk = 0;
		long i;
		bool ret = TRUE;

		if( m_lCnt > 0 )
		{
			// ����
			if( Str_Cmp(stSubCustInfo.CUST_TRND_CD, stScCustInfo.CUST_TRND_CD) != 0 )
			{
				lChk++;
			}
			
			// �ڵ�����ȣ1
			if( Str_Cmp(stSubCustInfo.CP_DDD, stScCustInfo.CP_DDD) != 0 )
			{
				lChk++;
			}
			
			// �ڵ�����ȣ2
			if( Str_Cmp(stSubCustInfo.CP_EXN, stScCustInfo.CP_EXN) != 0 )
			{
				lChk++;
			}
			
			// �ڵ�����ȣ3
			if( Str_Cmp(stSubCustInfo.CP_NUM, stScCustInfo.CP_NUM) != 0 )
			{
				lChk++;
			}
			
			// ���ù�ȣ1
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_DDD, stScCustInfo.OWNHOUSE_TEL_DDD) != 0 )
			{
				lChk++;
			}
			
			// ���ù�ȣ2
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_EXN, stScCustInfo.OWNHOUSE_TEL_EXN) != 0 )
			{
				lChk++;
			}
			
			// ���ù�ȣ3
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_NUM, stScCustInfo.OWNHOUSE_TEL_NUM) != 0 )
			{
				lChk++;
			}
			
			// ��Ʈ��
			if( Str_Cmp(stSubCustInfo.BUILT_IN_YN, stScCustInfo.BUILT_IN_YN) != 0 )
			{
				lChk++;
			}
			
			// �δ���
			if( Str_Cmp(stSubCustInfo.INDUCTION_INST_YN, stScCustInfo.INDUCTION_INST_YN) != 0 )
			{
				lChk++;
			}
			
			// ��ȸ�����ü� -> ����� Y�� ���� ������ ������ ���鵵�� �Ѵ�.
			if( Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") == 0 )
			{
				lChk++;
			}

			// ȸ���ȣ1
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_DDD, stScCustInfo.FIRM_TEL_DDD) != 0 )
			{
				lChk++;
			}
			
			// ȸ���ȣ2
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_EXN, stScCustInfo.FIRM_TEL_EXN) != 0 )
			{
				lChk++;
			}
			
			// ȸ���ȣ3
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_NUM, stScCustInfo.FIRM_TEL_NUM) != 0 )
			{
				lChk++;
			}
			
			// �ѽ�1
			if( Str_Cmp(stSubCustInfo.FAX_DDD, stScCustInfo.FAX_DDD) != 0 )
			{
				lChk++;
			}
			
			// �ѽ�2
			if( Str_Cmp(stSubCustInfo.FAX_EXN, stScCustInfo.FAX_EXN) != 0 )
			{
				lChk++;
			}
			
			// �ѽ�3
			if( Str_Cmp(stSubCustInfo.FAX_NUM, stScCustInfo.FAX_NUM) != 0 )
			{
				lChk++;
			}
			
			// �̸���
			if( Str_Len(stSubCustInfo.EMAIL) > 0 || Str_Len(stSubCustInfo.EMAILADDR) > 0 )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, stSubCustInfo.EMAIL);
				Str_Cat(szTmp, "@");
				Str_Cat(szTmp, stSubCustInfo.EMAILADDR);
				if( Str_Cmp(szTmp, stScCustInfo.EMAIL) != 0 )
				{
					lChk++;
				}
			}
			
			// ����
			if( Str_Cmp(stSubCustInfo.SQUARE_METER, stScCustInfo.SQUARE_METER) != 0 )
			{
				lChk++;
			}
			
			// ������
			if( Str_Cmp(stSubCustInfo.FAMILY_CNT, stScCustInfo.FAMILY_CNT) != 0 )
			{
				lChk++;
			}
			
			// ������
			if( Str_Cmp(stSubCustInfo.SCG_RELAT_CD, stScCustInfo.SCG_RELAT_CD) != 0 )
			{
				lChk++;
			}
		}
		else
		{
			// ����
			if( Str_Cmp(stSubCustInfo.CUST_TRND_CD, stSc.CUST_TRND_CD) != 0 )
			{
				lChk++;
			}
			
			// �ڵ�����ȣ1
			if( Str_Cmp(stSubCustInfo.CP_DDD, stSc.CP_DDD) != 0 )
			{
				lChk++;
			}
			
			// �ڵ�����ȣ2
			if( Str_Cmp(stSubCustInfo.CP_EXN, stSc.CP_EXN) != 0 )
			{
				lChk++;
			}
			
			// �ڵ�����ȣ3
			if( Str_Cmp(stSubCustInfo.CP_NUM, stSc.CP_NUM) != 0 )
			{
				lChk++;
			}
			
			// ���ù�ȣ1
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_DDD, stSc.OWNHOUSE_TEL_DDD) != 0 )
			{
				lChk++;
			}
			
			// ���ù�ȣ2
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_EXN, stSc.OWNHOUSE_TEL_EXN) != 0 )
			{
				lChk++;
			}
			
			// ���ù�ȣ3
			if( Str_Cmp(stSubCustInfo.OWNHOUSE_TEL_NUM, stSc.OWNHOUSE_TEL_NUM) != 0 )
			{
				lChk++;
			}
			
			// ��Ʈ��
			if( Str_Cmp(stSubCustInfo.BUILT_IN_YN, stSc.BUILT_IN_YN) != 0 )
			{
				lChk++;
			}
			
			// �δ���
			if( Str_Cmp(stSubCustInfo.INDUCTION_INST_YN, stSc.INDUCTION_INST_YN) != 0 )
			{
				lChk++;
			}
			
			// ��ȸ�����ü� -> ����� Y�� ���� ������ ������ ���鵵�� �Ѵ�.
			if( Str_Cmp(stSc.SOCIAL_WELF_FACI_YN, "Y") == 0 )
			{
				lChk++;
			}
			
			// ȸ���ȣ1
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_DDD, stSc.FIRM_TEL_DDD) != 0 )
			{
				lChk++;
			}
			
			// ȸ���ȣ2
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_EXN, stSc.FIRM_TEL_EXN) != 0 )
			{
				lChk++;
			}
			
			// ȸ���ȣ3
			if( Str_Cmp(stSubCustInfo.FIRM_TEL_NUM, stSc.FIRM_TEL_NUM) != 0 )
			{
				lChk++;
			}
			
			// �ѽ�1
			if( Str_Cmp(stSubCustInfo.FAX_DDD, stSc.FAX_DDD) != 0 )
			{
				lChk++;
			}
			
			// �ѽ�2
			if( Str_Cmp(stSubCustInfo.FAX_EXN, stSc.FAX_EXN) != 0 )
			{
				lChk++;
			}
			
			// �ѽ�3
			if( Str_Cmp(stSubCustInfo.FAX_NUM, stSc.FAX_NUM) != 0 )
			{
				lChk++;
			}
			
			// �̸���
			if( Str_Len(stSubCustInfo.EMAILADDR) > 0 )
			{
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				Str_Cpy(szTmp, stSubCustInfo.EMAIL);
				Str_Cat(szTmp, "@");
				Str_Cat(szTmp, stSubCustInfo.EMAILADDR);
				if( Str_Cmp(szTmp, stSc.EMAIL) != 0 )
				{
					lChk++;
				}
			}
			
			// ����
			if( Str_Cmp(stSubCustInfo.SQUARE_METER, stSc.SQUARE_METER) != 0 )
			{
				lChk++;
			}
			
			// ������
			if( Str_Cmp(stSubCustInfo.FAMILY_CNT, stSc.FAMILY_CNT) != 0 )
			{
				lChk++;
			}
			
			// ������
			if( Str_Cmp(stSubCustInfo.SCG_RELAT_CD, stSc.SCG_RELAT_CD) != 0 )
			{
				lChk++;
			}
		}
		
		if( lChk > 0 )
		{
			ret = FALSE;
		}
		else
		{
			ret = TRUE;
		}

		return ret;
	}


	/*=======================================================================================
	�Լ��� : SMSREQ_DRAW
	��  �� : SMS draw
	Param  : 
	Return :
	========================================================================================*/	
	void SMSREQ_DRAW(void)
	{
		long i;
		char szAddr[100];
	
		for ( i = 0 ;  SCSMSTEL[i].Str[0] != 0 ; i++)
		{
			ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA11+2), SCSMSTEL[i].Str, 0, ICON_NONE);
		}
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA44), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA45), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA47), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA48), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA49), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA50), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA51), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA52), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA53), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA54), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA11), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA12), EDITALIGN_MIDDLE);
		
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA11), EDITALIGN_MIDDLE);
		
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA46), TRUE, 2, EDITSEP_NONE );
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA52), TRUE, 2, EDITSEP_NONE );
		
		// ������
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA45), stSc.CUST_NM);
		
		// �ּ�
		Mem_Set( (byte*)szAddr, 0x00, sizeof(szAddr) );
		
		if( g_nAddrFlag == 0)
		{
			Str_Cpy(szAddr,  stSc.CITY );
			
			if(Str_Len(stSc.COUNTY) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.COUNTY );
			}
						
			if(Str_Len(stSc.TOWN) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.TOWN );
			}
			
			if(Str_Len(stSc.ADDR1_M) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.ADDR1_M);
			}
						
			if(Str_Len(stSc.ADDR1_S) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stSc.ADDR1_S);
			}
			
			// ��ȸȭ�鿡���� �ּ�
			Str_Cat(szAddr,  stSc.LOT_NUM_SECOND_ADDR );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.CO_LIVE_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.BLD_NM );		
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.HOUSE_CNT );		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA46), szAddr);
		}
		else
		{
			Str_Cpy(szAddr,  stSc.CITY );
			
			if(Str_Len(stSc.COUNTY) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.COUNTY );
			}
					
			if(Str_Len(stSc.NEW_ROAD_NM) != 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.NEW_ROAD_NM );
			}
			
			if(Str_Len(stSc.NEW_ADDR_M) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stSc.NEW_ADDR_M);
			}
			
			if(Str_Len(stSc.NEW_ADDR_S) == 0)
			{
				Str_Cat(szAddr,  " " );	
			}
			else
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stSc.NEW_ADDR_S);
			}
			
			// ��ȸȭ�鿡���� �ּ�
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.CO_LIVE_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.BLD_NM );
			Str_Cat(szAddr,  " " );	
			Str_Cat(szAddr,  stSc.HOUSE_CNT );		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA46), szAddr);
		}
		
		// �޴���ȭ
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA11), stSc.CP_DDD);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA11), stSc.CP_EXN);
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA12), stSc.CP_NUM);
		
		// ��, �ƴϿ�
		if( Str_Cmp( stSc.SMS_SEND_AGREE_YN, "Y" ) == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
			
			m_lSmsReqFlag = 1;
		}
		else if( Str_Cmp( stSc.SMS_SEND_AGREE_YN, "N" ) == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKON);
			
			m_lSmsReqFlag = 2;
		}
	}
	
	/*=======================================================================================
	�Լ��� : Snd_SmsReq
	��  �� : SMS��û/FR312314
	Param  : 
	Return :
	========================================================================================*/	
	void Snd_SmsReq(void)
	{
		char szUrl[200];
		char szbuf[128];
		char szCUST_NM[62];
		char szDay[11];
		char* sndbuf;
		long ret = 0;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
			
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 312314, FALSE);
		
		Str_Cpy(stSc.CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA11)) );
		Str_Cpy(stSc.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)) );
		Str_Cpy(stSc.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA12)) );
		
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",   stSc.USE_CONT_NUM );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num", stSc.INST_PLACE_NUM );
		
		Mem_Set( (byte*) szCUST_NM, 0x00, sizeof( szCUST_NM) );
		SQL_ConvUcStr( szCUST_NM, stSc.CUST_NM );
		
		JSON_SetValue( g_pjcomm, 'C', "cust_nm",  szCUST_NM );
		JSON_SetValue( g_pjcomm, 'C', "tel_ddd",  stSc.CP_DDD );
		JSON_SetValue( g_pjcomm, 'C', "tel_exn",  stSc.CP_EXN );
		JSON_SetValue( g_pjcomm, 'C', "tel_num",  stSc.CP_NUM );
		
		if( m_lSmsReqFlag == 1 )
		{
			JSON_SetValue( g_pjcomm, 'C', "sms_send_agree_yn",  "Y" );
		}
		else if( m_lSmsReqFlag == 2 )
		{
			JSON_SetValue( g_pjcomm, 'C', "sms_send_agree_yn",  "N" );
		}
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR312314;
		ret = HTTP_DownloadData(szUrl, "FR312314_IN",  "FR312314" , sndbuf, szbuf );
		return;
	}

	/*=======================================================================================
	�Լ��� : TR312314
	��  �� : FR312314 callback
	Param  : 
	Return :
	========================================================================================*/	
	long TR312314(void)
	{
		g_Sock_Close();
		
		if( g_Chk_Json(312314) >= 0 )
		{
			CloseMessageBox();
			
			if( Save_SmsReq() )
			{
				ON_EXIT();
				OnInit(INIT_MAIN);
				ON_DRAW();
			}
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
	�Լ��� : Save_SmsReq
	��  �� : SMS ��û ����
	Param  : 
	Return :
	========================================================================================*/	
	bool Save_SmsReq(void)
	{
		char szSql[100];
		long idx;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		// �ڵ�����ȣ
		Str_Cpy(stSc.CP_DDD, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA11)) );
		Str_Cpy(stSc.CP_EXN, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA11)) );
		Str_Cpy(stSc.CP_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA12)) );
		
		// ���ǿ���
		if( m_lSmsReqFlag == 1 )
		{
			Str_Cpy(stSc.SMS_SEND_AGREE_YN, "Y");
		}
		else
		{
			Str_Cpy(stSc.SMS_SEND_AGREE_YN, "N");
		}
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE NORMAL_DATA SET SMS_SEND_AGREE_YN = ? WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stSc.SMS_SEND_AGREE_YN	,2 ,DECRYPT);

		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			if( Str_Cmp( stSc.SMS_SEND_AGREE_YN, "Y" ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "SMS��û �����\n�Ϸ��Ͽ����ϴ�.");
			}
			else if( Str_Cmp( stSc.SMS_SEND_AGREE_YN, "N" ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "SMS��û �źθ�\n�Ϸ��Ͽ����ϴ�.");
			}
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}

	/*=======================================================================================
	�Լ��� : Chk_Ptrn
	��  �� : ������ check
	Param  : 
	Return :
	========================================================================================*/	
	bool Chk_Ptrn(void)
	{
		char szSql[200];
		char szTmp[20];
		long lCnt = 0;
		bool bRet = FALSE;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		
		SPRINT(szSql, "SELECT COUNT(*) FROM CUST_PATT_COLL_INFO WHERE BLD_NUM = '%s' AND INST_PLACE_NUM = '%s' ", stSc.BLD_NUM, stSc.INST_PLACE_NUM, 0 );

		g_Sql_RetInt(szSql, &lCnt);

		if( lCnt == 0 )
		{
			bRet = TRUE;
		}

		return bRet;
	}
	
	/*=======================================================================================
	�Լ��� : ReqMsg
	��  �� : û����� �޼���
	Param  : 
	Return :
	========================================================================================*/
	void ReqMsg(void)
	{
		char strMsg[200];
		
		Mem_Set( (byte *)strMsg, 0x00, sizeof(strMsg) );
		
		if( Str_Cmp(stSc.CONT_STS_CD, "30") != 0 )
		{
			if( Str_Cmp(stSc.BILL_SEND_METHOD, "M") == 0 )
			{
				Str_Cat(strMsg, "������ û�������\n[ ����� ] �Դϴ�.\n \n");
				Str_Cat(strMsg, "��ȭ��ȣ : ");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "L") == 0 )
			{
				Str_Cat(strMsg, "������ û�������\n[ LMS ] �Դϴ�.\n \n");
				Str_Cat(strMsg, "��ȭ��ȣ : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "E") == 0 )
			{
				Str_Cat(strMsg, "������ û�������\n[ �̸��� ] �Դϴ�.\n \n");
				Str_Cat(strMsg, "�̸����ּ� : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_EMAIL);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "A") == 0 )
			{
				Str_Cat(strMsg, "������ û�������\n[ �̸��� ] �Դϴ�.\n \n");
				Str_Cat(strMsg, "�̸����ּ� : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_EMAIL);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "B") == 0 )
			{
				Str_Cat(strMsg, "������ û�������\n[ LMS ] �Դϴ�.\n \n");
				Str_Cat(strMsg, "��ȭ��ȣ : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "C") == 0 )
			{
				Str_Cat(strMsg, "������ û�������\n[ ����� ] �Դϴ�.\n \n");
				Str_Cat(strMsg, "��ȭ��ȣ : ");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "D") == 0 )
			{
				Str_Cat(strMsg, "������ û�������\n[ �����,EMAIL ] �Դϴ�.\n \n");
				Str_Cat(strMsg, "��ȭ��ȣ : ");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				Str_Cat(strMsg, "�̸����ּ� : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_EMAIL);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "F") == 0 )
			{
				Str_Cat(strMsg, "������ û�������\n[ LMS,EMAIL ] �Դϴ�.\n \n");
				Str_Cat(strMsg, "��ȭ��ȣ : ");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				Str_Cat(strMsg, "�̸����ּ� : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_EMAIL);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
			else if( Str_Cmp(stSc.BILL_SEND_METHOD, "G") == 0 )
			{
				Str_Cat(strMsg, "������ û�������\n[ LMS,����� ] �Դϴ�.\n \n");
				Str_Cat(strMsg, "��ȭ��ȣ : \n");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_DDD);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_EXN);
				Str_Cat(strMsg, "-");
				Str_Cat(strMsg, stSc.BILL_SEND_CP_NUM);
				MessageBoxEx (CONFIRM_OK, strMsg);
			}
		}

		REDRAW();	
	}
}
