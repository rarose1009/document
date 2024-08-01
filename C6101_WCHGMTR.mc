/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_WCHGMTR
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
	#define USE_ON_UART
	#define USE_ON_TASK
	
	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_CLOSE )		//
		DEF_BUTTON_ID ( BID_BARCODE )	//
		DEF_BUTTON_ID ( BID_PHOTO )		//
		DEF_BUTTON_ID ( BID_SAVE )		//
		DEF_BUTTON_ID ( BID_PAY )			//��ü�ҿ��� ��ư
		DEF_BUTTON_ID ( BID_REMOTE )		//���ݼ�ġ���� ��ư

		//��ü�ҿ���
		DEF_BUTTON_ID ( BID_PAYOK )
		DEF_BUTTON_ID ( BID_REMOTEOK )
		DEF_BUTTON_ID ( BID_WRITE3 )		//�Է�â ���ڵ��ȣ
		
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
		DEF_OBJECT_ID ( TXT_TITLE    )//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_BORDER   )
		DEF_OBJECT_ID ( ICON_TITLE   )//Ÿ��Ʋ
		DEF_OBJECT_ID ( TTL_GUBUN           )
		DEF_OBJECT_ID ( TTL_BF_MTR          )
		DEF_OBJECT_ID ( TTL_AF_MTR          )
		DEF_OBJECT_ID ( TTL_GRD             )
		DEF_OBJECT_ID ( TXT_BF_GRD          )
		DEF_OBJECT_ID ( TXT_AF_GRD          )
		DEF_OBJECT_ID ( TTL_MODEL_NM        )
		DEF_OBJECT_ID ( TXT_BF_MODEL_NM     )
		DEF_OBJECT_ID ( TXT_AF_MODEL_NM     )
		DEF_OBJECT_ID ( TTL_TYPE            )
		DEF_OBJECT_ID ( TXT_BF_TYPE         )
		DEF_OBJECT_ID ( TXT_AF_TYPE         )
		DEF_OBJECT_ID ( TTL_DIGIT_CNT       )
		DEF_OBJECT_ID ( TXT_BF_DIGIT_CNT    )
		DEF_OBJECT_ID ( TXT_AF_DIGIT_CNT    )
		DEF_OBJECT_ID ( TTL_MTR_ID_NUM      )
		DEF_OBJECT_ID ( TXT_BF_MTR_ID_NUM   )
		DEF_OBJECT_ID ( TXT_AF_MTR_ID_NUM   )
		DEF_OBJECT_ID ( TTL_REMOTE_FLAG     )
		DEF_OBJECT_ID ( TXT_BF_REMOTE_FLAG  )
		DEF_OBJECT_ID ( TTL_KIND            )
		DEF_OBJECT_ID ( TXT_BF_KIND         )
		DEF_OBJECT_ID ( TTL_NEW_FIX_FLAG    )
		DEF_OBJECT_ID ( TXT_BF_NEW_FIX_FLAG )
		DEF_OBJECT_ID ( TTL_VALID_YM        )
		DEF_OBJECT_ID ( TXT_BF_VALID_YM     )
		DEF_OBJECT_ID ( TTL_VC              )
		DEF_OBJECT_ID ( TXT_BF_VC           )
		DEF_OBJECT_ID ( TXT_AF_VC           )
		DEF_OBJECT_ID ( TTL_VA              )
		DEF_OBJECT_ID ( TXT_BF_VA           )
		DEF_OBJECT_ID ( TXT_AF_VA           )
		DEF_OBJECT_ID ( TTL_VM              )
		DEF_OBJECT_ID ( TXT_BF_VM           )
		DEF_OBJECT_ID ( TXT_AF_VM           )		
		DEF_OBJECT_ID ( TTL_PERMITWHY       )
		DEF_OBJECT_ID ( TXT_FEE_FREE_FLAG   )

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
		
		DEF_OBJECT_ID ( CMB_AF_REMOTE_FLAG )
		DEF_OBJECT_ID ( CMB_AF_KIND = CMB_AF_REMOTE_FLAG+3 )
		DEF_OBJECT_ID ( CMB_AF_NEW_FIX_FLAG = CMB_AF_KIND+3 )
		DEF_OBJECT_ID ( CMB_AF_VALID_YM = CMB_AF_NEW_FIX_FLAG+3 )
		DEF_OBJECT_ID ( CMB_PERMITWHY = CMB_AF_VALID_YM+3 )
		DEF_OBJECT_ID ( CMB_AF_NEW_FIX_FLAG2  = CMB_PERMITWHY+3 )

		DEF_OBJECT_ID ( CMB_DATA13 = CMB_PERMITWHY+3 )
		DEF_OBJECT_ID ( CMB_DATA14 = CMB_DATA13+3 )
		DEF_OBJECT_ID ( CMB_DATA15 = CMB_DATA14+3 )
		
	END_OBJECT_ID()
	
	#define INIT_MAIN	  1
	#define INIT_PAY	  2
	#define INIT_REMOTE	  3

	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (STARTY+SYH*(x-1))
	 
	long m_bFirst;
	char m_szMtrBarcode[128];
	char m_szRemote[1100];
	char m_szSql[1100];
	char m_szTmp[400];
	char m_szfilenm[50];
	char m_szMtrBarnum[20];		//MTR_MODEL�� BARCODE_NUM ����
	char m_szMakernum[20];		//MTR_MODEL�� MAKER_NUM ����
	char m_lCheckPAY[20]; 
	char m_lCheckPAY_2[20]; 
	long m_lEditCtrlIndex = -1;
	char m_lCheckRemoteFlag[20]; 
	
	void Barcode_Strat(void);
	void OnBarcodeScan(void);
	
	void Analyze_Barcode(void);
	void Analyze_OldBarcode(void);
	
	void SetStyle(void);
	void Read_Data(void);
	void SetCombo(void);
	void ReDraw(void);
	// void RePay(void);
	void ReRemote(void);
	bool Validate(void);
	void SaveInput(void);
	bool Save_ChgMtr(void);
	bool Save_Pay(void);
	bool Save_Remote(void);
	void ClearData(void);

	void setBarCodeRsltView(long flag);

	long RCV75110(void);
	long TR75110(void);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "������ �ο���ü"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
													
		// DLG_TEXT(STARTX, 		 Line(1),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_GUBUN , "�׸�"),
		DLG_BUTTON(STARTX, 		 Line(1),  200, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR,BTNCTRLGRAY,CALL_FUNC,"", BID_PAY , "��ü"),
		DLG_TEXT(STARTX+200, 	 Line(1),  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BF_MTR , "ö�� �跮��"),
		DLG_TEXT(STARTX+580, 	 Line(1),  420, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_AF_MTR , "��ġ �跮��"),
		DLG_TEXT(STARTX, 		 Line(2),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_GRD , "���"),
		DLG_TEXT(STARTX+200, 	 Line(2),  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BF_GRD , ""),
		DLG_TEXT(STARTX+580, 	 Line(2),  420, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AF_GRD , ""),
		DLG_TEXT(STARTX, 	 	 Line(3),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MODEL_NM, "��"),
		DLG_TEXT(STARTX+200, 	 Line(3),  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BF_MODEL_NM, ""),
		DLG_TEXT(STARTX+580, 	 Line(3),  420, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AF_MODEL_NM, ""),
		DLG_TEXT(STARTX, 	 	 Line(4),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TYPE, "Ÿ��"),
		DLG_TEXT(STARTX+200, 	 Line(4),  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BF_TYPE, ""),
		DLG_TEXT(STARTX+580, 	 Line(4),  420, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AF_TYPE, ""),
		DLG_TEXT(STARTX, 	 	 Line(5),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_DIGIT_CNT, "�ڸ�"),
		DLG_TEXT(STARTX+200, 	 Line(5),  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BF_DIGIT_CNT, ""),
		DLG_TEXT(STARTX+580, 	 Line(5),  420, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_AF_DIGIT_CNT, ""),
		DLG_TEXT(STARTX, 		 Line(6),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_ID_NUM, "�⹰"),
		DLG_TEXT(STARTX+200, 	 Line(6),  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BF_MTR_ID_NUM, ""),
		DLG_EDIT(STARTX+580,	 Line(6),  420, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_AF_MTR_ID_NUM, 20, ""),
		// DLG_TEXT(STARTX, 		 Line(7),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_REMOTE_FLAG, "����"),
		DLG_BUTTON(STARTX, 		 Line(7),  200, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR,BTNCTRLGRAY,CALL_FUNC,"", BID_REMOTE , "����"),
		DLG_TEXT(STARTX+200, 	 Line(7),  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BF_REMOTE_FLAG, ""),		
		DLG_COMBO(STARTX+580,    Line(7),  420, SYH*6, 100, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_AF_REMOTE_FLAG, 10),
		DLG_TEXT(STARTX, 		 Line(8),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_KIND, "����"),
		DLG_TEXT(STARTX+200, 	 Line(8),  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BF_KIND, ""),
		DLG_COMBO(STARTX+580,    Line(8),  420, SYH*6, 100, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_AF_KIND, 10),
		DLG_TEXT(STARTX, 	 	 Line(9),  200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_NEW_FIX_FLAG, "����"),
		DLG_TEXT(STARTX+200, 	 Line(9),  380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BF_NEW_FIX_FLAG, ""),
		DLG_COMBO(STARTX+580,    Line(9),  420, SYH*6, 100, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_AF_NEW_FIX_FLAG, 10),
		DLG_COMBO(0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_AF_NEW_FIX_FLAG2, 10),
		
		DLG_TEXT(STARTX, 	   Line(10), 200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_VALID_YM, "��ȿ"),
		DLG_TEXT(STARTX+200,   Line(10), 380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BF_VALID_YM, ""),
		DLG_COMBO(STARTX+580,  Line(10), 420, SYH*6, 100, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_AF_VALID_YM, 6),
		DLG_TEXT(STARTX, 	   Line(11), 200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_VC, "VC"),
		DLG_EDIT(STARTX+200,   Line(11), 380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_BF_VC,9, ""),
		DLG_EDIT(STARTX+580,   Line(11), 420, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_AF_VC,9, ""),
		DLG_TEXT(STARTX, 	   Line(12), 200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_VA, "VA"),
		DLG_EDIT(STARTX+200,   Line(12), 380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_BF_VA,9, ""),
		DLG_EDIT(STARTX+580,   Line(12), 420, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_AF_VA,9, ""),
		DLG_TEXT(STARTX, 	   Line(13), 200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_VM, "VM"),
		DLG_EDIT(STARTX+200,   Line(13), 380, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_BF_VM,9, ""),
		DLG_EDIT(STARTX+580,   Line(13), 420, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_AF_VM,9, ""),
		
		DLG_TEXT(STARTX, 	   Line(14), 200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_PERMITWHY, "����"),
		DLG_COMBO(STARTX+200,  Line(14), 600, SYH*6, 100, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_PERMITWHY, 10),
		DLG_TEXT( STARTX+800,  Line(14), 200, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_FEE_FREE_FLAG, ""),
		
		DLG_BUTTON(STARTX,     Line(14)+SYH+30, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, SANDYBROWN, CALL_FUNC , "", BID_BARCODE   , "���ڵ�"),
		DLG_BUTTON(STARTX+333, Line(14)+SYH+30, 333, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, SANDYBROWN, CALL_FUNC , "", BID_PHOTO     , "����"),
		DLG_BUTTON(STARTX+666, Line(14)+SYH+30, 334, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE  , "�Ϸ�"),
	
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
		
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
	};

	DlgObject	DlgRes_PAY[] = 
	{	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		// DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ü�ҿ���"),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��ü�ҿ���"),
		
		DLG_BUTTON(STARTX+600, STARTY+350, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PAYOK , "Ȯ ��"),
		
		DLG_TEXT(STARTX, 		 STARTY+65,  230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA57 , " �� �� "),
		// DLG_TEXT(STARTX+230, 	 STARTY+65,  350, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA43 , "ö�� �跮��"),
		DLG_TEXT(STARTX+230, 	 STARTY+65,  770, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA58 , "�ҿ���"),
		DLG_TEXT(STARTX, 		 STARTY+115, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA59 , "���͸�"),
		DLG_TEXT(STARTX, 		 STARTY+165, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA60 , "���ú�"),
		// DLG_TEXT(STARTX, 		 STARTY+215, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA61 , "��Ÿ���"),
		// DLG_TEXT(STARTX+230,     STARTY+215, 760, 50, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_DATA48, ""),
		// DLG_EDIT(STARTX+230, 	 STARTY+215, 760, 50, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, TXT_AF_MTR_ID_NUM2,9, ""),
		
		DLG_COMBO(STARTX+230,  STARTY+115, 770, 50, 80, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA13, 15),
		DLG_COMBO(STARTX+230,  STARTY+165, 770, 50, 80, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA14, 15),

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

	DlgObject	DlgRes_REMOTE[] = 
	{	
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_TEXT(0, 0, 998, BTNHT_1, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_BORDER, ""),
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ݽý��� �����׸�"),
		
		DLG_BUTTON(STARTX+600, STARTY+350, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REMOTEOK , "Ȯ ��"),
		
		DLG_TEXT(STARTX, 		 STARTY+65,  230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA62 , " �� �� "),
		DLG_TEXT(STARTX+230, 	 STARTY+65,  770, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA63 , "���ݽý���"),
		DLG_TEXT(STARTX, 		 STARTY+115, 230, 50, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA64 , "������"),
		
		DLG_COMBO(STARTX+230,  STARTY+115, 770, 50, 80, 50, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA15, 15),
		

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
			{
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						SetStyle();
						Read_Data();
						RCV75110();
						ReDraw();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						SetStyle();
						Read_Data();
						RCV75110();
						ReDraw();
						break;		
				}
				break;
			}
			case INIT_PAY:
				switch (theDevInfo.m_nType)
				{
					default:
						CREATE_DIALOG_OBJECT (DlgRes_PAY, SIZEOF(DlgRes_PAY));
						break;
				}
				SetCombo();
				break;

			case INIT_REMOTE:
				switch (theDevInfo.m_nType)
				{
					default:
						CREATE_DIALOG_OBJECT (DlgRes_REMOTE, SIZEOF(DlgRes_REMOTE));
						break;
				}
				SetCombo();
				break;
		}
	}
	
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_BARCODE:
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM) ) < 11 )
				{
					if( theDevInfo.m_nType > FAMILY_PDA )
						Barcode_Strat();
					else
					{
						OnBarcodeScan();
					}
						
				}
				else
				{
					Mem_Set((byte*)m_szMtrBarcode, 0x00, sizeof(m_szMtrBarcode));
					Str_Cpy( m_szMtrBarcode, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM)) );
					
					if( Str_Len(m_szMtrBarcode) == 12 )
					{
						Analyze_Barcode();
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "�⹰��ȣ �ڸ����� �����մϴ� \n (12�ڸ�)");
						// EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),   "");
					}
					/*
					if( Str_NCmp(m_szMtrBarcode, "A", 1) >= 0 )
					{
						Analyze_OldBarcode();
					}
					else
					{
						Analyze_Barcode();
					}
					*/
					
				}
				
				break;
				
			case BID_PHOTO:
				SaveInput();
				g_nPhotoFlag = 7;
				Card_Move("C6101_PHOTO");
				break;
				
			case BID_SAVE:
				if( Validate() )
				{
					if( Save_ChgMtr() )
					{
						Card_Move("C6101_WCHK");
					}
				}
				break;
			
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_Del_GcPhoto();
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_Del_GcPhoto();
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
				g_Del_GcPhoto();
				ClearData();
				Card_Move("C6101_WCHK");
				break;	
			case GID_VMEXIT:
				g_Exit_DelGcData();
				break;
				
			case BID_CLOSE:
				ClearData();
				g_Del_GcPhoto();
				Card_Move("C6101_WCHK");
				break;

			case BID_PAY:
				// if(Str_Cmp(stUserinfo.szcenter_cd, "41") )
				g_lDataflag = 1;
				SaveInput();
				Mem_Set( (byte*)m_lCheckPAY, 0x00, sizeof(m_lCheckPAY));
				Str_Cpy(m_lCheckPAY, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)));				

				Mem_Set( (byte*)m_lCheckPAY_2, 0x00, sizeof(m_lCheckPAY_2));
				Str_Cpy(m_lCheckPAY_2, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG)));				
			
				if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
				{
					if(Str_Cmp(m_lCheckPAY, "�޽�") == 0 || Str_Cmp(m_lCheckPAY, "�ٱ��") == 0 || Str_Cmp(m_lCheckPAY, "�������˿�") == 0 
					|| Str_Cmp(m_lCheckPAY, "������ ����") == 0	|| Str_Cmp(m_lCheckPAY, "�������˿�(���)") == 0 || Str_Cmp(m_lCheckPAY, "������ ����(���)") == 0 )
					{
						// if(Str_Cmp(m_lCheckPAY_2, "�̼�ġ") != 0 && Str_Cmp(m_lCheckPAY_2, "") != 0 )
						if(Str_Cmp(m_lCheckPAY_2, "���ú���") == 0 || Str_Cmp(m_lCheckPAY_2, "CDMA") == 0 || Str_Cmp(m_lCheckPAY_2, "���տ���") == 0 || Str_Cmp(m_lCheckPAY_2, "�����α�") == 0 || Str_Cmp(m_lCheckPAY_2, "�����к�ȯ��") == 0 )
						{
							if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
							{
								// OnInit(INIT_PAY);
								SaveInput();								
								Card_Move("C6101_PAY");
								// RePay();
								break;
							}
							
						}
					}
					
				}

				// break;
			
			// case BID_PAYOK:
			// 	if( Save_Pay() )
			// 	{
			// 		ON_EXIT();
			// 		OnInit(INIT_MAIN);
			// 	}
			// 	break;
			
			case BID_REMOTE:
				// if(Str_Cmp(stUserinfo.szcenter_cd, "41") )
				g_lDataflag = 1;
				SaveInput();
				Mem_Set( (byte*)m_lCheckPAY, 0x00, sizeof(m_lCheckPAY));
				Str_Cpy(m_lCheckPAY, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)));				

				Mem_Set( (byte*)m_lCheckPAY_2, 0x00, sizeof(m_lCheckPAY_2));
				Str_Cpy(m_lCheckPAY_2, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG)));				
				if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
				{
					if(Str_Cmp(m_lCheckPAY, "�Ϲ�") != 0  )
					{
						// if(Str_Cmp(m_lCheckPAY_2, "�̼�ġ") != 0 && Str_Cmp(m_lCheckPAY_2, "") != 0 )
						if(Str_Cmp(m_lCheckPAY_2, "���ú���") == 0 || Str_Cmp(m_lCheckPAY_2, "CDMA") == 0 || Str_Cmp(m_lCheckPAY_2, "���տ���") == 0 || Str_Cmp(m_lCheckPAY_2, "�����α�") == 0 || Str_Cmp(m_lCheckPAY_2, "�����к�ȯ��") == 0 )
						{
							if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
							{
								// OnInit(INIT_REMOTE);
								// ReRemote();
								SaveInput();								
								Card_Move("C6101_REMOTE");
								break;
								
							}
							
						}
					}
					
				}

				// break;
			
			// case BID_REMOTEOK:
			// 	if( Save_Remote() )
			// 	{
			// 		ON_EXIT();
			// 		OnInit(INIT_MAIN);
			// 	// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_AMI), GREEN);
			// 	}
			// 	// SaveInputAmi();

			// 	break;
		}
	}
	
	//-----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		char szfilenm[256];

		if (nEvent == UART_BARCODE)
		{
			OnBarcodeScan();
		}		
		else if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				if( FFS_Exist(szfilenm)  )
				{
					//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h�� ���ǵǾ�����
					ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);
				
					ON_DRAW();
					VmSleep(100);
					FFS_Delete( szfilenm );
				}
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
			Mem_Set( (byte*)m_szMtrBarcode, 0x00, sizeof(m_szMtrBarcode) );
			ptr = (char*)System_GetResult((char*)&nRet);
			Str_Cpy(m_szMtrBarcode, ptr);

			if( theDevInfo.m_nType > FAMILY_PDA )
			{
				OnBarcodeScan();
			}
		}
	}

	//-----------------------------------------------------------------------------------------------
	void	OnChar(long nChar)
	{
		if( m_bFirst == INIT_MAIN )
		{
			//���ڸ� �Է� ����
			if( Get_iDlgCtrlByID(TXT_BF_VC) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(TXT_AF_VC) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(TXT_BF_VA) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(TXT_AF_VA) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(TXT_BF_VM) == m_lEditCtrlIndex ||
			    Get_iDlgCtrlByID(TXT_AF_VM) == m_lEditCtrlIndex  )
			{
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					ON_KEY( 5 );
					return;
				}
			}
		}
		
	}
	
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		
		if( m_bFirst == INIT_MAIN )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{			
					if( X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y( Line(11)-(g_Dlgflag*400) ) && Y < DMS_Y( Line(12)-(g_Dlgflag*400) )  
					|| (X > DMS_X(STARTX+200) && X < DMS_X(STARTX+1000) && Y > DMS_Y( Line(12)-(g_Dlgflag*400) ) && Y < DMS_Y( Line(14)-(g_Dlgflag*400) ) && Str_Cmp(stChgMtr.szRevis_flag, "10") != 0)
					)
					{
						if( Get_iDlgCtrlByID(TXT_BF_VC) == lActiveIndex 
						||  Get_iDlgCtrlByID(TXT_AF_VC) == lActiveIndex 
						||  Get_iDlgCtrlByID(TXT_BF_VA) == lActiveIndex 
						||  Get_iDlgCtrlByID(TXT_AF_VA) == lActiveIndex 
						||  Get_iDlgCtrlByID(TXT_BF_VM) == lActiveIndex 
						||  Get_iDlgCtrlByID(TXT_AF_VM) == lActiveIndex 
						)	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);
						
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							//SetKeyMode(KEYMODE_NUMBER);
			
							//ShowSip(TRUE);
							//g_Sipflag = 1;
						}
					}
					else if( X > DMS_X(STARTX+580) && X < DMS_X(STARTX+1000) && Y > DMS_Y( Line(6) )  && Y < DMS_Y( Line(7) )  )
					{
						if( Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					else
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
					
					ON_DRAW();
				}
				
			}
		}
		else if( m_bFirst == INIT_PAY )
		{
			if( POINTING_UP == nAction )
			{
				m_lEditCtrlIndex = lActiveIndex;
				
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+230) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+215-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+465-(g_Dlgflag*400)))
					{}
					else
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
					
					ON_DRAW();
				}
			}
		}
	}
	
	void OnSelect(long Index)
	{
		char szSql[200];
		char szRemoteCd[20];
		char szMtrKindCd[20];
		char szTmp[30];
		long i;
		long lActiveIndex;
		
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
		
		if( m_bFirst == INIT_MAIN )
		{
			if( lActiveIndex == Get_iDlgCtrlByID(CMB_PERMITWHY + 1) )
			{
				Mem_Set( (byte*) szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30009' AND ITEM_KNAME = '%s'", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PERMITWHY)), 0, 0   );
				g_Sql_RetStr( szSql, 30, stChgMtr.szMtr_repl_why );
			
				if( Str_Cmp(stChgMtr.szMtr_repl_why, "300") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_FEE_FREE_FLAG), "����");
					Str_Cpy(stChgMtr.szMtr_fee_free_flag, "Y");
				}
				else if( Str_Cmp(stChgMtr.szMtr_repl_why, "301") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_FEE_FREE_FLAG), "����");
					Str_Cpy(stChgMtr.szMtr_fee_free_flag, "Y");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_FEE_FREE_FLAG), "����");
					Str_Cpy(stChgMtr.szMtr_fee_free_flag, "N");
				}
			}
			else if( lActiveIndex == Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG + 1) )
			{	
				Mem_Set( (byte*)szRemoteCd, 0x00, sizeof(szRemoteCd) );
				Mem_Set( (byte*)szMtrKindCd, 0x00, sizeof(szMtrKindCd) );
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM))+5, 1);
				i = Str_AtoI(szTmp);
	
				if( i == 2)
				{	
					if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG)), "N:��ǰ") != 0 )
					{
						// ���� : �Ϲ�
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 0));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
	
						// ���� : �̼�ġ, ��Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 0));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					}
					else
					{
						// ���� : �޽�
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 2));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
	
						// ���� : ���ú���, Ȱ��ȭ
						/*
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 1));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						*/
						
						// ���� : Ȱ��ȭ
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
					}
				}
			}
			else if(lActiveIndex == Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG + 1))
			{
				Mem_Set( (byte*)m_szRemote, 0x00, sizeof(m_szRemote));
				Str_Cpy(m_szRemote, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG)));

				Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
				Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
				SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30008' AND ITEM_KNAME = '%s' ", m_szRemote, 0, 0 );
				g_Sql_RetStr( m_szSql, 20, m_szTmp );		
				
				if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
				{
				
					if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "�ٱ��") == 0 
						|| Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "�������˿�") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "������ ����") == 0
						|| Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "�������˿�(���)") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "������ ����(���)") == 0)
					{
						if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
							// DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), TRUE );
							// DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), FALSE );
						}
						
						// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);
						
					}
					else if(Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "������") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "������(���)") == 0 )
					{
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
						// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);
					}
					else if (Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "�޽�") == 0)
					{
						
						// if(Str_Cmp(m_szTmp, "10") != 0 ) //�̼�ġ�� �ƴϸ�
						if(Str_Cmp(m_szTmp, "20") == 0 || Str_Cmp(m_szTmp, "30") == 0 || Str_Cmp(m_szTmp, "40") == 0 || Str_Cmp(m_szTmp, "50") == 0 || Str_Cmp(m_szTmp, "60") == 0 )
						{
							if(Str_Cmp(stMtrChg.OLD_MTR_ID_NUM, "N") == 0)
							{
								ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
								ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
								// DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), TRUE );
								// DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), FALSE );
							}
						}
						// else if(Str_Cmp(m_szTmp, "10") == 0) //�̼�ġ
						else
						{
							
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), BTNCTRLGRAY);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), BTNCTRLGRAY);

						}
						
						// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
						// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);
					}
					else
					{
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), BTNCTRLBKCOLOR);
					}
					
					if( Str_Cmp(stMtrChg.REPL_OCCU_FLAG, "10") == 0 ) //���ı�ü�϶���
					{
						if(Str_Cmp(stMtrChg.MTR_REMOTE_FLAG,"50") == 0 ) //�����α�
						{
							if (Str_Cmp(m_szTmp, "20") == 0 || Str_Cmp(m_szTmp, "40") == 0 ) //���ú����� ���տ������� ���氡��.
							{}
							else if(Str_Cmp(m_szTmp,stMtrChg.MTR_REMOTE_FLAG) != 0)
							{
								MessageBoxEx (CONFIRM_OK, "Ư���跮�� ������ �����Ͽ�\n ó�� �� �� �����ϴ�.");
								return;
							}
							else
							{
								
							}
						}
						else if( Str_Cmp(stMtrChg.MTR_REMOTE_FLAG, stMtrChg.AFTER_MTR_REMOTE_FLAG) != 0)
						{	
							// MessageBoxEx (CONFIRM_OK, "ö�Ű跮��� ��ġ�跮��\n ���ݱ����� ���ƾ� �մϴ�.");
							MessageBoxEx (CONFIRM_OK, "Ư���跮�� ������ �����Ͽ�\n ó�� �� �� �����ϴ�.");
							return;
						}

					}
					

					// if( Str_Cmp(stMtrChg.MTR_KIND,"20") == 0 && Str_Cmp(stMtrChg.AFTER_MTR_KIND,"21") == 0) //�������� ������(���)�� ��ü����
					// {}
					// else if( Str_Cmp(stMtrChg.MTR_KIND,"60") == 0 && Str_Cmp(stMtrChg.AFTER_MTR_KIND,"61") == 0)//���������� ��������(���) ��ü����
					// {}
					// else if( Str_Cmp(stMtrChg.MTR_KIND,"65") == 0 && Str_Cmp(stMtrChg.AFTER_MTR_KIND,"66") == 0)//�����д��������� �����д�������(���) ��ü����
					// {}
					// else if( Str_Cmp(stMtrChg.AFTER_MTR_KIND, stMtrChg.MTR_KIND) != 0)
					// {
					// 	// MessageBoxEx (CONFIRM_OK, "ö�Ű跮��� ��ġ�跮�� \n ������ ���ƾ� �մϴ�.");
					// 	MessageBoxEx (CONFIRM_OK, "Ư���跮�� ������ �����Ͽ�\n ó�� �� �� �����ϴ�.44444");
					// 	return;
					// }
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PAY), FALSE );								
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GRAY);
				}
			}
			
			ON_DRAW();
		}
		return;
	}	
	
	void Barcode_Strat(void)
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
	
	void OnBarcodeScan(void)
	{
		long lret = 0;

		if( Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Mem_Set( (byte*)m_szMtrBarcode, 0x00, sizeof(m_szMtrBarcode) );
			lret = Barcode_Read( m_szMtrBarcode );
		}

		if( lret < 0 )
		{
			//MessageBoxEx (CONFIRM_OK, "���ڵ� �б� ����");
			goto Finally;
		}
		else
		{
			if( Str_Cmp(m_szMtrBarcode, "READ_FAIL") != 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_KIND),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
				ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2));
				ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2));
				
				if( Str_Len(m_szMtrBarcode) != 12 )
				{
					MessageBoxEx (CONFIRM_OK, "�⹰��ȣ �ڸ����� �����մϴ� \n (12�ڸ�).");
				}
				else
				{
					Analyze_Barcode();	
				}
				/*
				//���� value
				g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME	FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL	SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
				//���� code
				g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2);
				*/
				
				/* 20180529 ��û����ȣ : 2018040094 / ��ǰ, ����ǰ ���� : ���س⵵�� ���⵵�� ��ǰ, �׿ܴ� ����ǰ���� �����Ѵ�.
				if( Str_NCmp(m_szMtrBarcode, "A", 1) >= 0 )
				{
					Analyze_OldBarcode();
				}
				else
				{
					Analyze_Barcode();
				}
				*/
			}
		}
Finally:

		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}
		
		Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM));
		
		ON_DRAW();
		return;
	}
	

//------------------------------------------------------------------
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID( ICON_TITLE ), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
			EditCtrl_SetAlign( Get_hDlgCtrlByID( TXT_TITLE ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GUBUN   ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BF_MTR  ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_AF_MTR  ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_GRD     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_GRD  ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AF_GRD  ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MODEL_NM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_MODEL_NM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AF_MODEL_NM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TYPE           ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_TYPE        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AF_TYPE        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_DIGIT_CNT      ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_DIGIT_CNT   ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT   ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_ID_NUM     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_MTR_ID_NUM  ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM  ), EDITALIGN_MIDDLE);
	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_REMOTE_FLAG     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_REMOTE_FLAG  ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_KIND            ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_KIND         ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_NEW_FIX_FLAG    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_NEW_FIX_FLAG ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VALID_YM        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_VALID_YM     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VC     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_VC  ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AF_VC  ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VA     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_VA  ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AF_VA  ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_VM     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BF_VM  ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_AF_VM  ), EDITALIGN_MIDDLE);

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_PERMITWHY       ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FEE_FREE_FLAG   ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG  ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_AF_KIND         ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_AF_VALID_YM     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_PERMITWHY       ), EDITALIGN_MIDDLE);
			
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
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(CMB_AF_KIND), TRUE, 2, EDITSEP_NONE );
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG), TRUE, 2, EDITSEP_NONE );

			
			SetCombo();	
		}
	}
	
	
	void SetCombo(void)
	{
		long i;
		long lRet, lDate, lYear, lMonth;
		char szSql[300];
		char szDate[30];
		char szYear[20];
		char szYear2[20];
		char szMonth[20];
		char sztmp[30];
	
		if( m_bFirst == INIT_MAIN )
		{
			//����
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30008'", CMB_AF_REMOTE_FLAG+2);
			//����
			g_Sql_SetCombo("SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30087'", CMB_AF_KIND+2);

			//stChgMtr.szAfter_mtr_id_num
			if( Str_Len(stChgMtr.szAfter_mtr_id_num) > 0 )
			{	
				Mem_Set( (byte*)szYear, 0x00, sizeof(szYear) );
				Mem_Set( (byte*)szYear2, 0x00, sizeof(szYear2) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				
				// ���ڵ� �⵵
				Mem_Cpy((byte *)szYear, (byte *)stChgMtr.szAfter_mtr_id_num, 2);

				// ���� �⵵
				Str_ItoA(Time_GetYear(), szDate, 10);
				Mem_Cpy((byte *)szYear2, (byte *)szDate+2, 2);
				
				// ���� ��
				lMonth = Time_GetMonth();
				
				ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2));
				ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2));

				// ��ݱ�
				if( lMonth < 7 )
				{
					// ��ü(��) ���� (1��~ 6��)�� �⹰��ȣ ���ڵ� �� 2�ڸ��� (����) �� (���س⵵) �� ��� [��ǰ]
					if( Str_AtoI(szYear) == Str_AtoI(szYear2) || Str_AtoI(szYear) == (Str_AtoI(szYear2) - 1) )
					{
						//���� value
						g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME	FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL	SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
						//���� code
						g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);
					}
					else
					{
						//���� value
						g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM <> '10' AND A.CODE_ITEM <> '20' UNION ALL SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
						//���� code
						g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004'  AND A.CODE_ITEM <> '10'  AND A.CODE_ITEM <> '20' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);					  
					}
				}
				//�Ϲݱ�
				else
				{
					// ��ü(��) ���� (7��~12��)�� �⹰��ȣ ���ڵ� �� 2�ڸ��� (���س⵵) �� ��� [��ǰ]
					if( Str_AtoI(szYear) == Str_AtoI(szYear2) )
					{
						//���� value
						g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME	FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL	SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
						//���� code
						g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);
					}
					else
					{
						//���� value
						g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM <> '10' AND A.CODE_ITEM <> '20' UNION ALL SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
						//���� code
						g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004'  AND A.CODE_ITEM <> '10'  AND A.CODE_ITEM <> '20' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);					  
					}
				}
			}
			else
			{
				if( Str_Cmp(stChgMtr.szAfter_mtr_new_fix_flag, "10") != 0 )
				{
					//���� ���ڵ�(����ǰ)
					//���� value
					g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM <> '10' AND A.CODE_ITEM <> '20' UNION ALL SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
					//���� code
					g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004'  AND A.CODE_ITEM <> '10'  AND A.CODE_ITEM <> '20' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);		
				}
				else
				{
					//���� value
					g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME	FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL	SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
					//���� code
					g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);
				}
			}
			
			//��ȿ
			Mem_Set( (byte*)szYear, 0x00, sizeof(szYear) );
			lYear = Time_GetYear();
			Str_ItoA(lYear, szYear, 10);
			
			Mem_Set( (byte*)szMonth, 0x00, sizeof(szMonth) );
			lMonth = Time_GetMonth();
			if( lMonth < 10 )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_ItoA(lMonth, sztmp, 10);
				Str_Cpy(szMonth, "0");
				Str_Cat(szMonth, sztmp);
			}
			else
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_ItoA(lMonth, sztmp, 10);
				Str_Cpy(szMonth, sztmp);
			}

			Str_Cat(szYear, szMonth);
			Str_Cat(szYear, "15");
			lDate = Str_AtoI(szYear) + 50000;		//5��
			for(i = 0 ; i < 6 ; i++)
			{
				lRet = Time_DateUpDown ( lDate, -(i*30) ); 
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
				Str_ItoA( lRet, szDate, 10);
				Mem_Cpy( (byte*)sztmp, (byte*)szDate, 6);
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_AF_VALID_YM+2), sztmp, 0, ICON_NONE);
			}

			//��ü����
			g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30009' AND CODE_ITEM <> '300' AND CODE_ITEM <> '001' AND CODE_ITEM <> '202' AND CODE_ITEM <> '301'", CMB_PERMITWHY+2);	
		}
		else if( m_bFirst == INIT_PAY)
		{
			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			g_Sql_SetCombo("SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM != 'U'", CMB_DATA13+2);

			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			g_Sql_SetCombo("SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM != 'U'", CMB_DATA14+2);

		}
		else if( m_bFirst == INIT_REMOTE)
		{
			Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
			g_Sql_SetCombo("SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C31097' ORDER BY CAST(CODE_ITEM AS INTEGER)", CMB_DATA15+2);

		}
		return;
	}
	
	void Read_Data(void)
	{
	char szSql[320];
	long i;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql," SELECT MTR_ID_NUM,  MTR_GRD, MTR_TYPE, MTR_REMOTE_FLAG, MTR_KIND, MTR_DIGIT_CNT,\
MTR_NEW_FIX_FLAG, FIX_FIRM_NM_CD, MTR_VALID_YM, MTR_APPRO_YN, MTR_MODEL_CD, REVIS_FLAG, PROD_CD, INDI_VC_AFTER , MTR_SUPPLY_STS \
FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = ? AND MTR_NUM = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)stMw.szPromise_assign_seq, 10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stMtr.szMtr_num, 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_id_num       , 20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_grd          , 8 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_type         , 2 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_remote_flag  , 2 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_kind         , 2 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_digit_cnt    , 2 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_new_fix_flag , 2 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_fix_firm_nm_cd   , 2 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_valid_ym     , 6 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_appro_yn     , 1 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szBefo_mtr_model_cd     , 5 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szRevis_flag            , 2 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szProd_cd               , 5 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szLastvc                , 9 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stChgMtr.szMtr_supply_sts        , 2 +1, DECRYPT );
		
			stChgMtr.szAfter_form_appro_yn[0] = 'Y';
			Str_Cpy( stChgMtr.szMtr_num ,            stMtr.szMtr_num);
			Str_Cpy( stChgMtr.szPromise_assign_seq , stMw.szPromise_assign_seq);
			Str_Cpy( stChgMtr.szInst_place_num ,     stMw.szInst_place_num);
			Str_Cpy( stChgMtr.szCenter_cd ,          stUserinfo.szcenter_cd);
			Str_ItoA( Time_GetDate(),                stChgMtr.szRepl_treat_ymd, 10 );
			
			Str_Cpy( stChgMtr.szRemove_indi_va, "0");
			Str_Cpy( stChgMtr.szInst_indi_va,   "0");
			Str_Cpy( stChgMtr.szRemove_indi_vm, "0");
			Str_Cpy( stChgMtr.szInst_indi_vm,   "0");
		};
		

Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
	}

	void ReRemote(void)
	{	
		long lCnt = 0;
		long i;
		
		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
		Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
		SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C31097' AND CODE_ITEM = '%s' ", stChgMtr.remote_system, 0, 0 );
		g_Sql_RetStr( m_szSql, 20, m_szTmp );		

		
		if( Str_Cmp(m_szTmp, "") == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA15)   , "");	
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA15)   , m_szTmp);	
			}
		
		ON_DRAW();
		return;
	}

	long RCV75110(void)
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
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 75110, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",  stChgMtr.szMtr_num );
						
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR75110; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR75110_IN",  "FR75110" , sndbuf, sztmp );
		return 0 ;
	}

	long TR75110(void)
	{
		long ntotcnt = 0;
		char szMsg[128];
		
		g_Sock_Close();
		
		if(g_Chk_Json(75110) >= 0)
		{
			
		 	SPRINT(m_szSql, "SELECT MAX(BULD_CENTER_CD) FROM C6101_CHK_BULD_CENTER_CD WHERE MTR_NUM = '%s' ", stChgMtr.szMtr_num, 0, 0 );
		 	g_Sql_RetStr( m_szSql, 20, m_szTmp );		
			Str_Cpy(stChgMtr.chk_buld_center_cd, m_szTmp);
			return 1;
		}
		else
		{
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}
	
	
	// void RePay(void)
	// {	
	// 	long lCnt = 0;
	// 	long i;
		
	// 	Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
	// 	Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
	// 	SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM = '%s' ", stChgMtr.battery_yn, 0, 0 );
	// 	g_Sql_RetStr( m_szSql, 20, m_szTmp );		

		
	// 	if( Str_Cmp(m_szTmp, "") == 0 )
	// 		{
	// 			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA13)   , "�̼�ġ");	
	// 		}
	// 		else
	// 		{
	// 			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA13)   , m_szTmp);	
	// 		}

	// 	Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
	// 	Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
	// 	SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM = '%s' ", stChgMtr.mtrdisplay_yn, 0, 0 );
	// 	g_Sql_RetStr( m_szSql, 20, m_szTmp );		
		
		
	// 	if( Str_Cmp(m_szTmp, "") == 0 )
	// 		{
	// 			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA14)   , "�̼�ġ");	
	// 		}
	// 		else
	// 		{
	// 			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA14)   , m_szTmp);	
	// 		}
		
	// 	ON_DRAW();
	// 	return;
	// }
	
	void ReDraw(void)
	{
	
	char szfilenm[128];
	char sztmp[256];
	char szSql[301];
	long i, lCnt;
	
		if( m_bFirst == INIT_MAIN )
		{	
	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_GRD ),       stChgMtr.szBefo_mtr_grd );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_GRD ),       stChgMtr.szAfter_mtr_grd );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_DIGIT_CNT ), stChgMtr.szBefo_mtr_digit_cnt );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT ), stChgMtr.szAfter_mtr_digit_cnt );
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_MTR_ID_NUM ), stChgMtr.szBefo_mtr_id_num);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM ), stChgMtr.szAfter_mtr_id_num);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_VALID_YM ),   stChgMtr.szBefo_mtr_valid_ym);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_VALID_YM ),   stChgMtr.szAfter_mtr_valid_ym);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_REMOTE_FLAG ),  stChgMtr.szBefo_mtr_remote_flag);	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_KIND ),         stChgMtr.szBefo_mtr_kind);	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_NEW_FIX_FLAG ), stChgMtr.szBefo_mtr_new_fix_flag);	
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30087' AND CODE_ITEM = '%s' ",stChgMtr.szBefo_mtr_kind, 0, 0   );
			g_Sql_RetStr( szSql, 20, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_KIND), sztmp);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30087' AND CODE_ITEM = '%s' ",stChgMtr.szAfter_mtr_kind, 0, 0   );
			g_Sql_RetStr( szSql, 20, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), sztmp);

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30008' AND CODE_ITEM = '%s' ",stChgMtr.szBefo_mtr_remote_flag, 0, 0   );
			g_Sql_RetStr( szSql, 20, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_REMOTE_FLAG), sztmp);
			
			//2017-05-05 Sanghyun Lee
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30008' AND CODE_ITEM = '%s' ",stChgMtr.szAfter_mtr_remote_flag, 0, 0   );
			g_Sql_RetStr( szSql, 20, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), sztmp);

			if( Str_Cmp(stChgMtr.szAfter_mtr_kind, "10") == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
			}
			else if( Str_Cmp(stChgMtr.szAfter_mtr_kind, "70") == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
			}
			
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND))) == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
			}
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT MTR_MODEL_NM FROM MTR_MODEL WHERE MTR_MODEL_CD = '%s' ",stChgMtr.szBefo_mtr_model_cd, 0, 0   );
			g_Sql_RetStr( szSql, 20, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_MODEL_NM), sztmp);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, " SELECT MTR_MODEL_NM FROM MTR_MODEL WHERE MTR_MODEL_CD = '%s' ",stChgMtr.szAfter_mtr_model_cd, 0, 0   );
			g_Sql_RetStr( szSql, 20, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_MODEL_NM), sztmp);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, "SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'B30003' AND CODE_ITEM = '%s'",stChgMtr.szBefo_mtr_type, 0, 0   );
			g_Sql_RetStr( szSql, 20, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_TYPE), sztmp);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT(szSql, "SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'B30003' AND CODE_ITEM = '%s'",stChgMtr.szAfter_mtr_type, 0, 0   );
			g_Sql_RetStr( szSql, 20, sztmp );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_TYPE), sztmp);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			if( Str_Len(stChgMtr.szBefo_mtr_new_fix_flag) > 0 )
			{
				if( Str_Cmp(stChgMtr.szBefo_mtr_new_fix_flag, "20") == 0 )
				{
					lCnt = ListCtrl_GetItemNum(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2));
					for( i = 0 ; i < lCnt ; i++ )
					{
						Mem_Cpy((byte *)sztmp, (byte *)ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2), i)+2, 2);
						if( Str_Cmp(sztmp, stChgMtr.szBefo_fix_firm_nm_cd) == 0 )
						{
							EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_NEW_FIX_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2), i));
							break;
						}
					}
				}
				else
				{
					//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_NEW_FIX_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2), 0));
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_NEW_FIX_FLAG), "N:��ǰ");
				}
			}

			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			if( Str_Len(stChgMtr.szAfter_mtr_new_fix_flag) > 0 )
			{
				if( Str_Cmp(stChgMtr.szAfter_mtr_new_fix_flag, "20") == 0 && Str_Len(stChgMtr.szAfter_fix_firm_nm_cd) > 0 )
				{
					lCnt = ListCtrl_GetItemNum(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2));
					
					for( i = 0 ; i < lCnt ; i++ )
					{
						Mem_Cpy((byte *)sztmp, (byte *)ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2), i)+2, 2);

						if( Str_Cmp(sztmp, stChgMtr.szAfter_fix_firm_nm_cd) == 0 )
						{
							EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2), i));
							break;
						}
					}
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );			
				}
				else if( Str_Cmp(stChgMtr.szAfter_mtr_new_fix_flag, "10") == 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2), 0));
				}
			}

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			if( Str_Len(stChgMtr.szMtr_repl_why) > 0 )
			{
				SPRINT(szSql, "SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30009' AND CODE_ITEM = '%s'",stChgMtr.szMtr_repl_why, 0, 0   );
				g_Sql_RetStr( szSql, 20, sztmp );
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_PERMITWHY), sztmp);
			}
			else
			{
				//2017-05-05 Sanghyun Lee
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_PERMITWHY), "����");
			}
			
			//2017-05-05 Sanghyun Lee
			if( Str_Cmp(stChgMtr.szMtr_repl_why, "300") == 0 || Str_Cmp(stChgMtr.szMtr_repl_why, "301") == 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FEE_FREE_FLAG), "����");
				stChgMtr.szMtr_fee_free_flag[0] = 'Y';
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_FEE_FREE_FLAG), "����");
				stChgMtr.szMtr_fee_free_flag[0] = 'N';
			}
			
			//2017-08-01 Sanghyun Lee
			//��ġ �跮�� ��ħ�� '0'�Է� �߰�
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_VC ),        stChgMtr.szRemove_indi_vc);
			
			if( Str_Len(stChgMtr.szInst_indi_vc) > 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_VC ),        stChgMtr.szInst_indi_vc);
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_VC ),        "0");
			}
			
			if( Str_Cmp(stChgMtr.szRevis_flag, "10") != 0 )
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_VA ),        stChgMtr.szRemove_indi_va);
	
				if( Str_Len(stChgMtr.szInst_indi_va) > 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_VA ),        stChgMtr.szInst_indi_va);
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_VA ),        "0");
				}
				

				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BF_VM ),        stChgMtr.szRemove_indi_vm);

				if( Str_Len(stChgMtr.szInst_indi_vm) > 0 )
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_VM ),        stChgMtr.szInst_indi_vm);
				}
				else
				{
					EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_VM ),        "0");
				}
			}
			else
			{
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_VA), FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_VM), FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_BF_VA), FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_VA), FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_BF_VM), FALSE );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_VM), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_BF_VA), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_VA), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_BF_VM), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_VM), FALSE );
			}
			
			//�������� ��ư ���� ����
			lCnt = 0;
			
			//ö�Ű跮��
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "M");
			Str_Cat(szfilenm, "B");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, stMtr.szMtr_num);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			SPRINT (sztmp, "%s/%s",PHOTO_MW, szfilenm, 0);

			if(FFS_Exist(sztmp) <= 0)
			{
				lCnt++;
			}

			//��ġ�跮��
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "M");
			Str_Cat(szfilenm, "A");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, stMtr.szMtr_num);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
			SPRINT (sztmp, "%s/%s",PHOTO_MW, szfilenm, 0);

			if(FFS_Exist(sztmp) <= 0)
			{
				lCnt++;
			}
	
			if( lCnt == 0 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
			}
			else
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), SANDYBROWN);
			}

			// szMtr_supply_sts
			if( Str_Cmp(stChgMtr.szMtr_supply_sts, "20") == 0 )
			{
				if( MessageBoxEx (CONFIRM_YESNO, "���޻��� '����'���� �Դϴ�. \n ��ü�� �����Ͻðڽ��ϱ�?")  == MB_OK)
				{
				}
				else
				{
					g_Del_GcPhoto();
					ClearData();
					Card_Move("C6101_WCHK");
				}
			}
			else if( Str_Cmp(stChgMtr.szMtr_supply_sts, "30") == 0 )
			{
				if( MessageBoxEx (CONFIRM_YESNO, "���޻��� '����'���� �Դϴ�. \n ��ü�� �����Ͻðڽ��ϱ�?")  == MB_OK)
				{
				}
				else
				{
					g_Del_GcPhoto();
					ClearData();
					Card_Move("C6101_WCHK");
				}
			}

			
			if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
			{
				if(Str_Cmp(stChgMtr.szAfter_mtr_kind, "20") == 0 || Str_Cmp(stChgMtr.szAfter_mtr_kind, "21") == 0
				||Str_Cmp(stChgMtr.szAfter_mtr_kind, "50") == 0 || Str_Cmp(stChgMtr.szAfter_mtr_kind, "60") == 0
				||Str_Cmp(stChgMtr.szAfter_mtr_kind, "61") == 0 || Str_Cmp(stChgMtr.szAfter_mtr_kind, "65") == 0
				||Str_Cmp(stChgMtr.szAfter_mtr_kind, "66") == 0 ) 
				{
					if( Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "20") == 0 ||Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "30") == 0 
					|| Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "40") == 0  ||Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "50") == 0 
					|| Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "60") == 0)
					{
						
						// m_lSpecialMtrFlag = 1;
						if(Str_Cmp(stChgMtr.battery_yn, "") == 0)
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
						}
						else
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), RED);
						}
						
						// DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), TRUE );
						// DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), FALSE );

						if(Str_Cmp(stChgMtr.remote_system, "") == 0)
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
						}
						else
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), RED);
						}
						
						// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);
					}
					else if(Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "10") == 0 )
					{
						// m_lSpecialMtrFlag = 1;
						if(Str_Cmp(stChgMtr.battery_yn, "") == 0)
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
						}
						else
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), RED);
						}
						// DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), TRUE );
						// DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), FALSE );

						if(Str_Cmp(stChgMtr.remote_system, "") == 0)
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
						}
						else
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), RED);
						}
						// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);

					}
				}
			

				if(Str_Cmp(stChgMtr.szAfter_mtr_kind, "30") == 0 )
				{
					if(Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "20") == 0 || Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "30") == 0
					  ||Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "40") == 0 || Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "50") == 0
					  || Str_Cmp(stChgMtr.szAfter_mtr_remote_flag, "60") == 0)
					{
						// m_lSpecialMtrFlag = 1;
						//BID_PAY ���� ������ ������ ������ �ʷϻ�
						if(Str_Cmp(stChgMtr.battery_yn, "") == 0)
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
						}
						else
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), RED);
						}
						// DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), TRUE );
						// DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA11), FALSE );

						//BID_REMOTE ���� ������ ������ ������ �ʷϻ�
						if(Str_Cmp(stChgMtr.remote_system, "") == 0)
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
						}
						else
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), RED);
						}

						//BID_BALANCE ���� ������ ������ ������ �ʷϻ�
						// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);
						
					}
				}
			}
			
		}
	}
	
	
	//----------------------------------------------------------------------------------------------
	long Chk_Grd(char* szAfterGrd)
	{
		long lPrevGrd, lAfterGrd, lProdCd;
		
		//2.5 -> 25�� �ٲ� ���
		if( Str_Cmp(stChgMtr.szBefo_mtr_grd, "2.5") == 0 )
		{
			lPrevGrd = 25;
		}
		else
		{
			lPrevGrd = Str_AtoI(stChgMtr.szBefo_mtr_grd);
		}

		if( Str_Cmp(szAfterGrd, "2.5") == 0 )
		{
			lAfterGrd = 25;
		}
		else
		{
			lAfterGrd = Str_AtoI(szAfterGrd);
		}		
		
		lProdCd = Str_AtoI(stChgMtr.szProd_cd);
	
		switch(lPrevGrd)
		{
			case 2:
			case 25:	//2.5 -> 25�� �ٲ� ���
				if( lAfterGrd == 2 || lAfterGrd == 25 || lAfterGrd == 3 )
				{
					return 0;
				}
				else
				{
					return -1;
				}
				break;
			case 3:
				if( lProdCd == 11 || lProdCd == 81 )
				{
					if( lAfterGrd == 2 || lAfterGrd == 25 || lAfterGrd == 3 )
					{
						return 0;
					}
					else
					{
						return -2;
					}
				}
				else
				{
					if( lAfterGrd == 3 || lAfterGrd == 4 )
					{
						return 0;
					}
					else
					{
						return -1;
					}
				}
				break;
			case 4:
				if( lProdCd == 11 || lProdCd == 81)
				{
					if( lAfterGrd == 2 || lAfterGrd == 25 || lAfterGrd == 3 || lAfterGrd == 4 )
					{
						return 0;
					}
					else
					{
						return -2;
					}
				}
				else
				{
					if( lAfterGrd == 4 )
					{
						return 0;
					}
					else
					{
						return -1;
					}
				}
				break;
			case 5:
				if( lProdCd == 11 || lProdCd == 81 )
				{
					if( lAfterGrd == 2 || lAfterGrd == 25 || lAfterGrd == 3 || lAfterGrd == 5 )
					{
						return 0;
					}
					else
					{
						return -2;
					}
				}
				else
				{
					if( lAfterGrd == 5 || lAfterGrd == 6 || lAfterGrd == 7 )
					{
						return 0;
					}
					else
					{
						return -1;
					}
				}
				break;
			case 6:
			case 7:
				if( lAfterGrd == 6 || lAfterGrd == 7 )
				{
					return 0;
				}
				else
				{
					return -1;
				}
				break;
			case 10:
				if( lAfterGrd == 10 )
				{
					return 0;
				}
				else
				{
					return -1;
				}
				break;
		}
	
		return -1;
	}
	
//----------------------------------------------------------------------------------------------
	long Chk_MakerCd(char* szMakerCd)
	{
		long lRet;
	
		if( szMakerCd[0] == 'A' )
		{
			lRet = 1;
		}
		else if( szMakerCd[0] == 'B' )
		{
			lRet = 2;
		}
		else if( szMakerCd[0] == 'C' )
		{
			lRet = 3;
		}
		else if( szMakerCd[0] == 'D' )
		{
			lRet = 4;
		}
		else if( szMakerCd[0] == 'E' )
		{
			lRet = 5;
		}
		else if( szMakerCd[0] == 'F' )
		{
			lRet = 6;
		}
		else if( szMakerCd[0] == 'G' )
		{
			lRet = 7;
		}
		else if( szMakerCd[0] == 'H' )
		{
			lRet = 8;
		}
		else if( szMakerCd[0] == 'I' )
		{
			lRet = 9;
		}
		else if( szMakerCd[0] == 'J' )
		{
			lRet = 10;
		}
		else if( szMakerCd[0] == 'K' )
		{
			lRet = 11;
		}
		else if( szMakerCd[0] == 'L' )
		{
			lRet = 12;
		}
		else if( szMakerCd[0] == 'M' )
		{
			lRet = 13;
		}
		else if( szMakerCd[0] == 'N' )
		{
			lRet = 14;
		}
		else if( szMakerCd[0] == 'O' )
		{
			lRet = 15;
		}
		else if( szMakerCd[0] == 'P' )
		{
			lRet = 16;
		}
		else if( szMakerCd[0] == 'Q' )
		{
			lRet = 17;
		}
		else if( szMakerCd[0] == 'R' )
		{
			lRet = 18;
		}
		else if( szMakerCd[0] == 'S' )
		{
			lRet = 19;
		}
		else if( szMakerCd[0] == 'T' )
		{
			lRet = 20;
		}
		else if( szMakerCd[0] == 'U' )
		{
			lRet = 21;
		}
		else
		{
			lRet = -1;
		}
		
		return lRet;
	}
	
	
	void Analyze_Barcode(void)
	{
		char szTmp[100];
		char szDate[20];
		char szMonth[4];
		char szYear[10];
		char szYear2[10];
		char szModelCd[20];
		char szModelNm[30];
		char szMakerCd[20];
		char szTypeCd[20];
		char szGrdNum[20];
		char szMtrNum1[30];
		char szMtrNum2[15];
		char szMtrCnt[20];
		char szRemoteCd[20];
		char szMtrKindCd[20];
		char szBarNum[20];
		char szSql[300];
		long lDate, lBarLen, lCnt, lMonth;
		long lret = 0;
		long lFlag = -1;
		long i, idx, z;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		Mem_Set( (byte*)szMonth, 0x00, sizeof(szMonth) );
		Mem_Set( (byte*)szYear, 0x00, sizeof(szYear) );
		Mem_Set( (byte*)szYear2, 0x00, sizeof(szYear2) );
		Mem_Set( (byte*)szModelCd, 0x00, sizeof(szModelCd) );
		Mem_Set( (byte*)szModelNm, 0x00, sizeof(szModelNm) );
		Mem_Set( (byte*)szMakerCd, 0x00, sizeof(szMakerCd) );
		Mem_Set( (byte*)szTypeCd, 0x00, sizeof(szTypeCd) );
		Mem_Set( (byte*)szGrdNum, 0x00, sizeof(szGrdNum) );
		Mem_Set( (byte*)szMtrNum1, 0x00, sizeof(szMtrNum1) );
		Mem_Set( (byte*)szMtrNum2, 0x00, sizeof(szMtrNum2) );
		Mem_Set( (byte*)szMtrCnt, 0x00, sizeof(szMtrCnt) );
		Mem_Set( (byte*)szRemoteCd, 0x00, sizeof(szRemoteCd) );
		Mem_Set( (byte*)szBarNum, 0x00, sizeof(szBarNum) );
		Mem_Set( (byte*)szMtrKindCd, 0x00, sizeof(szMtrKindCd) );

		// g_szBartmp�� ���ڵ� ����
		Mem_Set( (byte*)g_szBartmp, 0x00, sizeof(g_szBartmp) );
		Str_Cpy(g_szBartmp, m_szMtrBarcode);
		
		Mem_Cpy((byte *)szYear, (byte *)m_szMtrBarcode, 2);
		
		// ���� �⵵
		Str_ItoA(Time_GetYear(), szDate, 10);
		Mem_Cpy((byte *)szYear2, (byte *)szDate+2, 2);
		
		// ���� ��
		lMonth = Time_GetMonth();

		// ��ݱ�
		if( lMonth < 7 )
		{
			// ��ü(��) ���� (1��~ 6��)�� �⹰��ȣ ���ڵ� �� 2�ڸ��� (����) �� (���س⵵) �� ��� [��ǰ]
			if( Str_AtoI(szYear) == Str_AtoI(szYear2) || Str_AtoI(szYear) == (Str_AtoI(szYear2) - 1) )
			{
				if( MessageBoxEx (CONFIRM_YESNO, "��ǰ �跮�Ⱑ �½��ϱ�?")  == MB_OK)
				{
					setBarCodeRsltView(0);
				}
				else
				{
					setBarCodeRsltView(1);
				}	
			}
			else
			{
				setBarCodeRsltView(2);
			}
		}
		//�Ϲݱ�
		else
		{
			// ��ü(��) ���� (7��~12��)�� �⹰��ȣ ���ڵ� �� 2�ڸ��� (���س⵵) �� ��� [��ǰ]
			if( Str_AtoI(szYear) == Str_AtoI(szYear2) )
			{
				if( MessageBoxEx (CONFIRM_YESNO, "��ǰ �跮�Ⱑ �½��ϱ�?")  == MB_OK)
				{
					setBarCodeRsltView(0);
				}
				else
				{
					setBarCodeRsltView(1);
				}
			}
			else
			{
				setBarCodeRsltView(2);
			}
		}
		//�����⹰��ȣ ���� ������ ���� Y -> N ���� ���� (20231019)
		SPRINT(m_szSql, "SELECT CASE WHEN COUNT(*) > 0 THEN 'N' ELSE 'N' END AS CNT FROM C6301_OLDMTRIDNUM WHERE MTR_ID_NUM = '%s' ", m_szMtrBarcode, 0, 0 );
		// SPRINT(m_szSql, "SELECT CASE WHEN COUNT(*) > 0 THEN 'Y' ELSE 'N' END AS CNT FROM C6301_OLDMTRIDNUM WHERE MTR_ID_NUM = '%s' ", m_szMtrBarcode, 0, 0 );
		g_Sql_RetStr( m_szSql, 20, stChgMtr.old_mtr_id_num );
		
		//������ �ڵ�
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)m_szMakernum, 0x00, sizeof(m_szMakernum) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szMtrBarcode+2, 1);
		if( Str_NCmp(szTmp, "0", 1) < 0 || Str_NCmp(szTmp, "9", 1) > 0 )
		{
			//�ش�Ǵ� ���� �ƴ� ���ڰ� ���������, ������ ���� ���� ���� �Է�
			Str_Cpy(szTmp, "99");
		}
		i = Str_AtoI(szTmp);
		switch( i ) 
		{
			case 1:
				Str_Cpy(m_szMakernum, "10001");
				break;
			case 2:
				Str_Cpy(m_szMakernum, "10002");
				break;
			case 3:
				Str_Cpy(m_szMakernum, "10003");
				break;
			case 4:
				Str_Cpy(m_szMakernum, "10004");
				break;
			case 5:
				Str_Cpy(m_szMakernum, "10005");
				break;
			case 6:
				Str_Cpy(m_szMakernum, "10043");
				break;
			case 7:
				Str_Cpy(m_szMakernum, "10006");
				break;
			case 8:
				Str_Cpy(m_szMakernum, "10038");
				break;
			case 9:
				Str_Cpy(m_szMakernum, "10008");
				break;
			case 0:
				Str_Cpy(m_szMakernum, "10037");
				break;
			default:
				MessageBoxEx (CONFIRM_OK, "�⹰��ȣ ���ۻ簡 �߸� �Ǿ����ϴ�.");
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_KIND),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
				ClearData();
				goto Finally;
				break;
		}

		//���
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szMtrBarcode+3, 1);
		i = Str_AtoI(szTmp);
		switch( i ) 
		{
			case 2:
				Str_Cpy(szGrdNum, "2.5");
				break;
			case 3:
				Str_Cpy(szGrdNum, "4");
				break;
			case 4:
				Str_Cpy(szGrdNum, "6");
				break;
			case 5:
				Str_Cpy(szGrdNum, "10");
				break;
			default:
				MessageBoxEx (CONFIRM_OK, "�⹰��ȣ ����� �߸� �Ǿ����ϴ�.");
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_KIND),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
				ClearData();
				goto Finally;
				break;
		}

		lret = Chk_Grd(szGrdNum);
		if( lret != 0 )
		{
			if( lret == -2 )
			{
				MessageBoxEx (CONFIRM_OK, "������� ����� ����� Ȯ���ϼ���.");
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��޺��� �Ұ� �մϴ�.");
			}
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_KIND),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
			ClearData();
			goto Finally;
		}

		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szMtrBarcode+4, 1);
		i = Str_AtoI(szTmp);
		switch( i )
		{
			case 1:
				if( Str_Cmp(stChgMtr.szBefo_mtr_type, "20") != 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�⹰��ȣ Ÿ���� ���� �跮�� Ÿ�԰� �ٸ��ϴ�.");
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_KIND),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
					ClearData();
					goto Finally;
				}
				Str_Cpy(szTypeCd, "20");
				break;
			case 2:
				if( Str_Cmp(stChgMtr.szBefo_mtr_type, "10") != 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�⹰��ȣ Ÿ���� ���� �跮�� Ÿ�԰� �ٸ��ϴ�.");
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_KIND),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
					ClearData();
					goto Finally;
				}
				Str_Cpy(szTypeCd, "10");
				break;
			default:
				MessageBoxEx (CONFIRM_OK, "�⹰��ȣ Ÿ���� �߸� �Ǿ����ϴ�.");
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_KIND),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
				ClearData();
				goto Finally;
				break;
				
		}

		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szMtrBarcode+5, 1);
		i = Str_AtoI(szTmp);
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szMtrBarcode+6, 1);
		z = Str_AtoI(szTmp);
		
		switch( i )
		{
			case 1:
				if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
				{	
					// ���� : �Ϲ�
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 0));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					Str_Cpy(szMtrKindCd, "10");
					
					// ���� : �̼�ġ, ��Ȱ��ȭ
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 0));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					Str_Cpy(szRemoteCd, "10");
					
				}
				else
				{
					// ���� : �Ϲ�
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 0));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					Str_Cpy(szMtrKindCd, "10");
					
					// ���� : �̼�ġ, ��Ȱ��ȭ
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 0));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					Str_Cpy(szRemoteCd, "10");
				}
				
				break;
			case 2:
					// ��ǰ�� ��� �޽�, ���ú���
					if( Str_Cmp(stChgMtr.szAfter_mtr_new_fix_flag,"10") == 0 )
					{
						// ���� : �޽�
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 3));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
						Str_Cpy(szMtrKindCd, "30");
					
						// ���� : ���ú���, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 1));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "20");
						
					}
					else//����ǰ�� ��� �Ϲ�, �̼�ġ
					{
						// ���� : �Ϲ�
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 0));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
						Str_Cpy(szMtrKindCd, "10");
						
						// ���� : �̼�ġ, ��Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 0));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						Str_Cpy(szRemoteCd, "10");
					}

					if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
						|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
						|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
						{
							Mem_Set( (byte*)m_lCheckRemoteFlag, 0x00, sizeof(m_lCheckRemoteFlag));
							Str_Cpy(m_lCheckRemoteFlag, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG)));
							
							if( Str_Cmp(m_lCheckRemoteFlag,"�̼�ġ") != 0  ) //���ݱ����� �̼�ġ�� �ƴѰ�
							{		
								if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
								{
									ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
									ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
									DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), TRUE );
									DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), FALSE );
								}
								
								
							}
						}

				

				break;
			case 3:
				if( z == 5 )
				{
					// ���� : �������˿�
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 8));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					Str_Cpy(szMtrKindCd, "60");	
					
					//Ư���跮���� ��� ö�Ű跮���� ���� ������ ������ ����.
					if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
					{
							EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
							Str_Cpy(szRemoteCd, "10");
							
							if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
							{
								
								ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
								ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
								DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), FALSE );
							}
								// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);


					}
					else //�������Ͱ� �ƴ� ������ ���
					{
						// ���� : ���տ���, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "10");

						// DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						// DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					}
				}
				else
				{
					// ���� : �ٱ��
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 7));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					Str_Cpy(szMtrKindCd, "50");

					//Ư���跮���� ��� ö�Ű跮���� ���� ������ ������ ����.
					if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
					{
						// if( Str_Cmp(stChgMtr.REPL_OCCU_FLAG, "10") == 0 )
						// {
						// 	if( Str_Cmp(stChgMtr.szBefo_mtr_kind, "50") != 0 )
						// 	{
						// 		MessageBoxEx (CONFIRM_OK, "Ư���跮�� ������ �����Ͽ�\n ó�� �� �� �����ϴ�.");
						// 		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						// 		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						// 		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
						// 		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
						// 		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
						// 		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
						// 		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
						// 		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
						// 		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
						// 		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
						// 		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
						// 		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_KIND),  "");
						// 		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
						// 		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
						// 		ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), BTNCTRLGRAY);
						// 		ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), BTNCTRLGRAY);
						// 		ClearData();
						// 		goto Finally;
						// 	}
							
						// 	Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
						// 	Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
						// 	SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30008' AND CODE_ITEM = '%s' ", stChgMtr.szBefo_mtr_remote_flag, 0, 0 );
						// 	g_Sql_RetStr( m_szSql, 20, m_szTmp );
						// 	EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG)   , m_szTmp);	

						// 	if( Str_Cmp(stChgMtr.szBefo_mtr_remote_flag,"50") == 0 ) //���� ������ �����α��� ��쿡�� ���տ���, ���ú� ���ð���
						// 	{
						// 		ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2));
						// 		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
						// 		g_Sql_SetCombo("SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30008'  AND CODE_ITEM IN ('20','40','50')", CMB_AF_REMOTE_FLAG+2);
						// 		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						// 		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						// 	}
						// 	else
						// 	{	
						// 		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						// 		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						// 	}
						// }
						// else
						// {
							// ���� : �̼�ġ, Ȱ��ȭ
							EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 0));
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
							Str_Cpy(szRemoteCd, "10");

						// }

							
							if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
							{
								ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
								ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
								DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), FALSE );
							}
							// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);

							
					}
					else //�������Ͱ� �ƴ� ������ ���
					{
						// ���� : �̼�ġ, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 0));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "10");

						// DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						// DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					}
					
				}
				
				break;
			case 4:
				if( z == 5 )
				{
					// ���� : ������ �������˿�
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 10));
					// EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), "������ ����");
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					Str_Cpy(szMtrKindCd, "65");	
					
				
					//Ư���跮���� ��� ö�Ű跮���� ���� ������ ������ ����.
					if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
					{
							// ���� : �̼�ġ, Ȱ��ȭ
							EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
							Str_Cpy(szRemoteCd, "40");
						

						
							if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
							{
								ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
								ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
								DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), TRUE );
								DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), FALSE );
							}
								// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);
							
					}
					else //�������Ͱ� �ƴ� ������ ���
					{
						// ���� : �̼�ġ, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "40");
					}
				}
				else
				{
					// ���� : ������
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 1));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					Str_Cpy(szMtrKindCd, "20");
					
					//Ư���跮���� ��� ö�Ű跮���� ���� ������ ������ ����.
					if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
					{
						// ���� : ���տ���, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "40");

						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);

					}
					else //�������Ͱ� �ƴ� ������ ���
					{
						// ���� : ���տ���, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "40");
					}
				}
				
				
				break;
			case 5: 
			// ���� : ��������(KT)
				if( z == 5 )
				{
					//ö�Ű跮���� �跮�� ������ ���� ���ؾ���.
					//ex) ö�Ű跮�Ⱑ ��������(���) 61 (9) �̸� ��ġ�� ��������(���) 61(9)
					//    ö�Ű跮�Ⱑ �����д�������(���) 66 �̸� ��ġȭ�鵵 �����д�������(���) 66 (11)
					
					// ���� : ������ �������˿�
					if( Str_Cmp(stChgMtr.szBefo_mtr_kind, "60") == 0 || Str_Cmp(stChgMtr.szBefo_mtr_kind, "61") == 0)
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 9));
					}
					else if( Str_Cmp(stChgMtr.szBefo_mtr_kind, "65") == 0 || Str_Cmp(stChgMtr.szBefo_mtr_kind, "66") == 0)
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 11));
					}

					// Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
					// Mem_Set( (byte*)m_szTmp, 0x00, sizeof(m_szTmp) );
					// SPRINT(m_szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30087' AND CODE_ITEM = '%s' ", stChgMtr.szBefo_mtr_kind, 0, 0 );
					// g_Sql_RetStr( m_szSql, 20, m_szTmp );
					// EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND)   , m_szTmp);
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					Str_Cpy(szMtrKindCd, "");	

					// ���� : ������ �������˿�
					//Ư���跮���� ��� ö�Ű跮���� ���� ������ ������ ����.
					if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
					{
						// ���� : �̼�ġ, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "40");
						
						
						if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
						{
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PAY), GREEN);
							ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(TXT_AF_MTR_ID_NUM), FALSE );
						}
								// ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BALANCE), GREEN);
							
					}
					else //�������Ͱ� �ƴ� ������ ���
					{
						// ���� : �̼�ġ, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "40");
					}
				}
				else
				{
					// ���� : ������(���)
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 2));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					Str_Cpy(szMtrKindCd, "21");

					//Ư���跮���� ��� ö�Ű跮���� ���� ������ ������ ����.
					if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
					{
						// ���� : ���տ���, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "40");
						
						ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_REMOTE), GREEN);
						
							
					}
					else //�������Ͱ� �ƴ� ������ ���
					{
						// ���� : ���տ���, Ȱ��ȭ
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
						Str_Cpy(szRemoteCd, "40");
					}
					
				}
			

			    break;
			case 7:
				
					// ���� : ��������
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 12));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
					Str_Cpy(szMtrKindCd, "70");
					
					// ���� : �̼�ġ, ��Ȱ��ȭ
					EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 0));
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					Str_Cpy(szRemoteCd, "10");
				
				
				break;
			case 8:
				// ���� : ��������(SKT)
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 10));
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
				Str_Cpy(szMtrKindCd, "80");
				
				// ���� : ���տ���, Ȱ��ȭ
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				Str_Cpy(szRemoteCd, "40");
				
				break;
			case 9:
				// ���� : ��������(LGT)
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_KIND), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_KIND+2), 10));
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
				Str_Cpy(szMtrKindCd, "80");
				
				// ���� : ���տ���, Ȱ��ȭ
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 3));
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				Str_Cpy(szRemoteCd, "40");
				
				break;
			default:
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_KIND+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_KIND),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
				ClearData();
				MessageBoxEx (CONFIRM_OK, "�⹰��ȣ ������ �߸� �Ǿ����ϴ�.");
				goto Finally;
				break;
		}

		Mem_Set( (byte*)m_szMtrBarnum, 0x00, sizeof(m_szMtrBarnum) );
		Mem_Cpy((byte *)m_szMtrBarnum, (byte *)m_szMtrBarcode+2, 3);
		lFlag = 0;
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ClearData();
			goto Finally2;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT MTR_MODEL_CD, MTR_GRD, MTR_DIGIT_CNT, MTR_TYPE, MTR_MODEL_NM FROM MTR_MODEL \
WHERE MAKER_NUM = ? AND BARCODE_NUM = ? AND MTR_GRD = ? AND MTR_TYPE = ?"
		);

		if( hstmt == NULL )
		{
			ClearData();
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally2;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)m_szMakernum ,   5, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)m_szMtrBarnum ,   10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)szGrdNum ,    8, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)szTypeCd ,    2, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ClearData();
			goto Finally2;
		}

		if(sql->Next(sql) == TRUE )
		{	
			idx = 0;
			sql->GetValue( sql, idx++, 'U', (long*) szModelCd			, 5  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) szGrdNum			, 8  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) szMtrCnt			, 3  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) szTypeCd			, 2  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) szModelNm			, 50 + 1, DECRYPT );
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			ClearData();
			goto Finally2;
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   szGrdNum);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  szModelNm);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  szMtrCnt);
					
		Str_Cpy(stChgMtr.szMtr_bar, m_szMtrBarcode);
		Str_Cpy(stChgMtr.szAfter_mtr_id_num, m_szMtrBarcode);
		Str_Cpy(stChgMtr.szAfter_mtr_grd, szGrdNum);
		Str_Cpy(stChgMtr.szAfter_mtr_model_cd, szModelCd);
		Str_Cpy(stChgMtr.szAfter_mtr_digit_cnt, szMtrCnt);
		Str_Cpy(stChgMtr.szAfter_mtr_type, szTypeCd);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM)   , stChgMtr.szAfter_mtr_id_num);

		Str_Cpy(stChgMtr.szMtr_fee_free_flag, "10");
		/* 20180529 ��ܿ��� ��¥�� ��,����ǰ ����
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2), 0));
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );			
		*/
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szSql, "SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'B30003' AND CODE_ITEM = '%s'",stChgMtr.szAfter_mtr_type, 0, 0   );
		g_Sql_RetStr( szSql, 20, szTmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_TYPE)   , szTmp);
		
		lFlag = 1;
		
Finally2:
		DelSqLite(sql);
		
		if( lFlag == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�� ���ÿ� �����Ͽ����ϴ�.");
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
			ClearData();
		}

Finally:
		
		ON_DRAW();
		return;
	}
	
	
	void Analyze_OldBarcode(void)
	{
	char szSql[300];
	char szTmp[100];
	char szDate[20];
	char szMonth[4];
	char szYear[10];
	char szYear2[10];
	char szModelCd[20];
	char szModelNm[30];
	char szMakerCd[20];
	char szTypeCd[20];
	char szGrdNum[20];
	char szMtrNum1[30];
	char szMtrNum2[15];
	char szMtrCnt[20];
	char szRemoteCd[20];
	char szBarNum[20];
	long lDate, lBarLen, lCnt;
	long lret = 0;
	long lFlag = -1;
	long i, idx;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szDate, 0x00, sizeof(szDate) );
		Mem_Set( (byte*)szMonth, 0x00, sizeof(szMonth) );
		Mem_Set( (byte*)szYear, 0x00, sizeof(szYear) );
		Mem_Set( (byte*)szYear2, 0x00, sizeof(szYear2) );
		Mem_Set( (byte*)szModelCd, 0x00, sizeof(szModelCd) );
		Mem_Set( (byte*)szModelNm, 0x00, sizeof(szModelNm) );
		Mem_Set( (byte*)szMakerCd, 0x00, sizeof(szMakerCd) );
		Mem_Set( (byte*)szTypeCd, 0x00, sizeof(szTypeCd) );
		Mem_Set( (byte*)szGrdNum, 0x00, sizeof(szGrdNum) );
		Mem_Set( (byte*)szMtrNum1, 0x00, sizeof(szMtrNum1) );
		Mem_Set( (byte*)szMtrNum2, 0x00, sizeof(szMtrNum2) );
		Mem_Set( (byte*)szMtrCnt, 0x00, sizeof(szMtrCnt) );
		Mem_Set( (byte*)szRemoteCd, 0x00, sizeof(szRemoteCd) );
		Mem_Set( (byte*)szBarNum, 0x00, sizeof(szBarNum) );
		
		if( Str_Len(m_szMtrBarcode) < 12 || Str_NCmp(m_szMtrBarcode, "A", 1) < 0 || Str_NCmp(m_szMtrBarcode, "U", 1) > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "��ϵ��� ���� ���ۻ� �Դϴ�.");
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");			
			ClearData();
			goto Finally;
		}
	
		//������ �ڵ�
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)m_szMakernum, 0x00, sizeof(m_szMakernum) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szMtrBarcode, 1);
		
		i = Chk_MakerCd(szTmp);
		switch( i ) 
		{
			case 1:
				Str_Cpy(m_szMakernum, "10001");
				break;
			case 2:
				Str_Cpy(m_szMakernum, "10016");
				break;
			case 3:
				Str_Cpy(m_szMakernum, "10015");
				break;
			case 4:
				Str_Cpy(m_szMakernum, "10003");
				break;
			case 5:
				Str_Cpy(m_szMakernum, "10004");
				break;
			case 6:
				Str_Cpy(m_szMakernum, "10014");
				break;
			case 7:
				Str_Cpy(m_szMakernum, "10013");
				break;
			case 8:
				Str_Cpy(m_szMakernum, "10019");
				break;
			case 9:
				Str_Cpy(m_szMakernum, "10012");
				break;
			case 10:
				Str_Cpy(m_szMakernum, "10017");
				break;
			case 11:
				Str_Cpy(m_szMakernum, "10006");
				break;
			case 12:
				Str_Cpy(m_szMakernum, "10011");
				break;
			case 13:
				Str_Cpy(m_szMakernum, "10010");
				break;
			case 14:
				Str_Cpy(m_szMakernum, "10009");
				break;
			case 15:
				Str_Cpy(m_szMakernum, "10002");
				break;
			case 16:
				Str_Cpy(m_szMakernum, "10005");
				break;
			case 17:
				Str_Cpy(m_szMakernum, "10007");
				break;
			case 18:
				Str_Cpy(m_szMakernum, "10008");
				break;
			case 19:
				Str_Cpy(m_szMakernum, "10037");
				break;
			case 20:
				Str_Cpy(m_szMakernum, "10043");
				break;
			case 21:
				Str_Cpy(m_szMakernum, "10038");
				break;
			default:
				MessageBoxEx (CONFIRM_OK, "�⹰��ȣ ���ۻ簡 �߸� �Ǿ����ϴ�.");
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
				ClearData();
				goto Finally;
				break;
		}

		//���
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szMtrBarcode+1, 1);
		i = Str_AtoI(szTmp);
		switch( i ) 
		{
			case 1:
				Str_Cpy(szGrdNum, "2");
				break;
			case 2:
				Str_Cpy(szGrdNum, "3");
				break;
			case 3:
			case 7:
				Str_Cpy(szGrdNum, "4");
				break;
			case 4:
				Str_Cpy(szGrdNum, "5");
				break;
			case 5:
				Str_Cpy(szGrdNum, "7");
				break;
			case 6:
				Str_Cpy(szGrdNum, "2.5");
				break;
			case 8:
				Str_Cpy(szGrdNum, "6");
				break;
			default:
				MessageBoxEx (CONFIRM_OK, "�⹰��ȣ ����� �߸� �Ǿ����ϴ�.");
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
				ClearData();
				goto Finally;
				break;
		}
		
		lret = Chk_Grd(szGrdNum);
		if( lret != 0 )
		{
			if( lret == -2 )
			{
				MessageBoxEx (CONFIRM_OK, "������� ����� ����� Ȯ���ϼ���.");
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "��޺��� �Ұ� �մϴ�.");
			}
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
			ClearData();
			goto Finally;
		}

		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szMtrBarcode+2, 1);
		i = Str_AtoI(szTmp);
		switch( i )
		{
			case 1:
				if( Str_Cmp(stChgMtr.szBefo_mtr_type, "20") != 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�⹰��ȣ Ÿ���� ���� �跮�� Ÿ�԰� �ٸ��ϴ�.");
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
					ClearData();
					goto Finally;
				}
				Str_Cpy(szTypeCd, "20");
				break;
			case 2:
				if( Str_Cmp(stChgMtr.szBefo_mtr_type, "10") != 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�⹰��ȣ Ÿ���� ���� �跮�� Ÿ�԰� �ٸ��ϴ�.");
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
					ClearData();
					goto Finally;
				}
				Str_Cpy(szTypeCd, "10");
				break;
			default:
				ClearData();
				MessageBoxEx (CONFIRM_OK, "�⹰��ȣ Ÿ���� �߸� �Ǿ����ϴ�.");
				goto Finally;
				break;
				
		}

		//����
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Cpy((byte *)szTmp, (byte *)m_szMtrBarcode+3, 1);
		i = Str_AtoI(szTmp);
		switch( i )
		{
			case 1:
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 0));
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				Str_Cpy(szRemoteCd, "10");
				break;
			case 2:
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 1));
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				Str_Cpy(szRemoteCd, "20");
				break;
			case 3:
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 1));
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				Str_Cpy(szRemoteCd, "20");
				break;
			case 4:
				EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG+2), 1));
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				Str_Cpy(szRemoteCd, "20");
				break;
			default:
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
				ClearData();
				MessageBoxEx (CONFIRM_OK, "�⹰��ȣ ���ݿ��ΰ� �߸� �Ǿ����ϴ�.");
				goto Finally;
				break;
		}

		Mem_Set( (byte*)m_szMtrBarnum, 0x00, sizeof(m_szMtrBarnum) );
		Mem_Cpy((byte *)m_szMtrBarnum, (byte *)m_szMtrBarcode, 3);
		lFlag = 0;
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ClearData();
			goto Finally2;
		}

		hstmt = sql->CreateStatement(sql,
"SELECT MTR_MODEL_CD, MTR_GRD, MTR_DIGIT_CNT, MTR_TYPE, MTR_MODEL_NM FROM MTR_MODEL \
WHERE MAKER_NUM = ? AND BARCODE_NUM = ? AND MTR_GRD = ? AND MTR_TYPE = ?"
		);

		if( hstmt == NULL )
		{
			ClearData();
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally2;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&m_szMakernum ,  10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&m_szMtrBarnum ,   10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&szGrdNum ,    5, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)&szTypeCd ,    5, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			ClearData();
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally2;
		}

		if(sql->Next(sql) == TRUE )
		{	
			idx = 0;
			sql->GetValue( sql, idx++, 'U', (long*) szModelCd			, 5  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) szGrdNum			, 8  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) szMtrCnt			, 3  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) szTypeCd			, 2  + 1, DECRYPT );
			sql->GetValue( sql, idx++, 'U', (long*) szModelNm			, 50 + 1, DECRYPT );
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			ClearData();
			goto Finally2;
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   szGrdNum);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  szModelNm);
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  szMtrCnt);
		
		Mem_Cpy((byte *)szMtrNum1, (byte *)m_szMtrBarcode+4, Str_Len(m_szMtrBarcode)-4);
		
		Str_Cpy(stChgMtr.szMtr_bar, m_szMtrBarcode);
		Str_Cpy(stChgMtr.szAfter_mtr_id_num, szMtrNum1);
		Str_Cpy(stChgMtr.szAfter_mtr_grd, szGrdNum);
		Str_Cpy(stChgMtr.szAfter_mtr_model_cd, szModelCd);
		Str_Cpy(stChgMtr.szAfter_mtr_digit_cnt, szMtrCnt);
		Str_Cpy(stChgMtr.szAfter_mtr_type, szTypeCd);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM)   , stChgMtr.szAfter_mtr_id_num);
	
		//�ű� �ڵ� �� ����
		DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
		DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );	
		ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2));
		ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2));

		//���� value
		g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM <> '10' AND A.CODE_ITEM <> '20' UNION ALL SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
		//���� code
		g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004'  AND A.CODE_ITEM <> '10'  AND A.CODE_ITEM <> '20' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);
		//���� value
		//g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME	FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL	SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
		//���� code
		//g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2);
	
		//Ÿ��
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szSql, "SELECT  ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'B30003' AND CODE_ITEM = '%s'",stChgMtr.szAfter_mtr_type, 0, 0   );
		g_Sql_RetStr( szSql, 20, szTmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_AF_TYPE)   , szTmp);
		
		lFlag = 1;
		
Finally2:
		DelSqLite(sql);
		
		if( lFlag == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�� ���ÿ� �����Ͽ����ϴ�.");
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_REMOTE_FLAG+1), FALSE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_GRD),   "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_TYPE),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM),  "");
			ClearData();
		}

Finally:

		ON_DRAW();
		return;
	}
	
	bool Validate(void)
	{
		char szMsg[256];
		char szTmp[256];
		char szfilenm[256];
		long lCnt = 0;
		long i;
		bool bRet = TRUE;
		
		//�Էµ� ������ ��Ʈ���� ����
		SaveInput();
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM))) == 0 ||
		    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM))) == 0 ||
		    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_TYPE))) == 0 ||
		    Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_GRD))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�⹰��ȣ�� �Է��ϼ���.");
			bRet = FALSE;
			goto Finally;
		}
		
		
		if( Str_Cmp( g_szBartmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM)) ) != 0 )
		{
			MessageBoxEx (CONFIRM_OK, "��ĵ �Ǵ� ���ڵ��ư��\n�ٽ� �����ּ���.");
			bRet = FALSE;
			goto Finally;
		}
		
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�⹰��ȣ�� �߸��Ǿ����ϴ�.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�跮�� ������ �����ϼ���.");
			bRet = FALSE;
			goto Finally;
		}
		
		if( Str_Cmp(stChgMtr.szAfter_mtr_kind, "40") == 0 || Str_Cmp(stChgMtr.szAfter_mtr_kind, "41") == 0 || Str_Cmp(stChgMtr.szAfter_mtr_kind, "42") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "������(10��޹̸�)�� ��ü�� ���� ���� �Ұ�.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ݿ��θ� �����ϼ���.");
			bRet = FALSE;
			goto Finally;
		}
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�跮�� ���¸� �����ϼ���.");
			bRet = FALSE;
			goto Finally;
		}
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_VALID_YM))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�跮�� ��ȿ����� �����ϼ���.");
			bRet = FALSE;
			goto Finally;
		}
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BF_VC))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "ö�� �跮�� ��ħ�� �Է��ϼ���.");
			bRet = FALSE;
			goto Finally;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_VC))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "��ġ �跮�� ��ħ�� �Է��ϼ���.");
			bRet = FALSE;
			goto Finally;
		}
		
		if( Str_Cmp(stChgMtr.szRevis_flag, "10") != 0 )
		{
		
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BF_VA))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "ö�� VA ��ħ�� �Է��ϼ���.");
				bRet = FALSE;
				goto Finally;
			}
	
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_VA))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ġ VA ��ħ�� �Է��ϼ���.");
				bRet = FALSE;
				goto Finally;
			}
		
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BF_VM))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "ö�� VM ��ħ�� �Է��ϼ���.");
				bRet = FALSE;
				goto Finally;
			}
	
			if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_VM))) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ġ VM ��ħ�� �Է��ϼ���.");
				bRet = FALSE;
				goto Finally;
			}
		}
			
				
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PERMITWHY))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�跮�� ��ü������ �����ϼ���.");
			bRet = FALSE;
			goto Finally;
		}

/*
�跮�ⱳü		C31(��������) | M(�跮��), C(������) | B(ö��), A(��ġ) | M(�跮���ȣ) | D( ������¥(SYSDATE : YYYYMMDDHHMMSS )
���� ���� ���� : C31MBM302410422D20161129111620(�跮�ⱳü ö�� ����), C31CBM302410422D20161129111620(�跮�ⱳü ��ġ ����)
Ŭ���̾�Ʈ ���� ���ϸ� ���� : MBM302410422
*/
		lCnt = 0;
		
		//ö�Ű跮��
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		Str_Cpy(szfilenm, "M");
		Str_Cat(szfilenm, "B");
		Str_Cat(szfilenm, "M");
		Str_Cat(szfilenm, stMtr.szMtr_num);
		Str_Cat(szfilenm, ".jjp");

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SPRINT (szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);

		if(FFS_Exist(szTmp) <= 0)
		{
			lCnt++;
		}

		//��ġ�跮��
		Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
		Str_Cpy(szfilenm, "M");
		Str_Cat(szfilenm, "A");
		Str_Cat(szfilenm, "M");
		Str_Cat(szfilenm, stMtr.szMtr_num);
		Str_Cat(szfilenm, ".jjp");

		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
		SPRINT (szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);

		if(FFS_Exist(szTmp) <= 0)
		{
			lCnt++;
		}
		
		if( lCnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�跮�� ������ �Կ��ϼ���.");
			bRet = FALSE;
			goto Finally;
		}
		
//		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PERMITWHY)), "����") != 0 )
//		{
//			if( MessageBoxEx (CONFIRM_YESNO, "��ü���� ��������\n������ Ȯ���մϴ�.")  != MB_OK)
//			{
//				bRet = FALSE;
//				goto Finally;
//			}
//		}

		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql));
		Str_Cpy(m_szSql, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG)));
		
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "�޽�") == 0)
		{	
			if(Str_Cmp(m_szSql, "�̼�ġ") != 0 && Str_Cmp(m_szSql, "") != 0 )
			{
				
				if( Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
				    || Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0 
					|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0)
				{
					if(Str_Cmp(m_szSql, "���ú���") == 0 || Str_Cmp(m_szSql, "CDMA") == 0 || Str_Cmp(m_szSql, "���տ���") == 0 || Str_Cmp(m_szSql, "�����α�") == 0 || Str_Cmp(m_szSql, "�����к�ȯ��") == 0 )
					{	
						if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
						{
							if(Str_Len(stChgMtr.remote_system) == 0 )
							{
								MessageBoxEx (CONFIRM_OK, "���ݰ��� �׸��� �����ؾ� �մϴ�. \n �ش� ȭ������ �̵��մϴ�.");
								bRet = FALSE;
								g_lDataflag = 1;
								SaveInput();					
								Card_Move("C6101_REMOTE");
								// ReRemote();
								goto Finally;
							}
						}
						
					}
				}						
			}
		}
		else if(Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "�ٱ��") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "������") == 0 
			|| Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "������") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "������(���)") == 0
			|| Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "�������˿�") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "�������˿�(���)") == 0
			|| Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "������ ����") == 0 || Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), "������ ����(���)") == 0)
		{	
			
			if(Str_Cmp(stChgMtr.chk_buld_center_cd,"41") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"42") == 0 
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"43") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"44") == 0
				|| Str_Cmp(stChgMtr.chk_buld_center_cd,"45") == 0 || Str_Cmp(stChgMtr.chk_buld_center_cd,"46") == 0 )
				{	
					if(Str_Cmp(stChgMtr.old_mtr_id_num, "N") == 0)
					{
						if(Str_Len(stChgMtr.remote_system) == 0 )
						{
							MessageBoxEx (CONFIRM_OK, "���ݰ��� �׸��� �����ؾ� �մϴ�. \n �ش� ȭ������ �̵��մϴ�.");
							bRet = FALSE;
							g_lDataflag = 1;
							SaveInput();
							Card_Move("C6101_REMOTE");
							// ReRemote();
							goto Finally;
						}
					}
					
				}
		}
		
		if( Str_AtoI(stChgMtr.szLastvc) > Str_AtoI(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BF_VC))) )
		{
			Mem_Set((byte*)szMsg, 0x00, sizeof(szMsg));
			SPRINT(szMsg, "ö����ħ(%s)��\n������ħ(%s)���� �۽��ϴ� .\n��� �����Ͻðڽ��ϱ�?", EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BF_VC)), stChgMtr.szLastvc,0);
			if( MessageBoxEx (CONFIRM_YESNO, szMsg) != MB_OK )
			{
				bRet = FALSE;
				goto Finally;
			}
		}


		
Finally:

		return bRet;
	}
	
	void SaveInput(void)
	{		
		char szTmp[128];
		char szbuf[50];
		char szSql[300];
		long i, lCnt;
	
		//��ġ�跮�� ���
		Str_Cpy(stChgMtr.szAfter_mtr_grd, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_GRD)));

		//��ġ�跮�� Ÿ��
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'B30003' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_TYPE)), 0, 0 );
		g_Sql_RetStr( szSql, 20, stChgMtr.szAfter_mtr_type );

		//��ġ�跮�� ��
		/*
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MTR_MODEL_CD FROM MTR_MODEL WHERE MTR_MODEL_NM = '%s'  ", EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_MODEL_NM)), 0, 0   );
		g_Sql_RetStr( szSql, 20, stChgMtr.szAfter_mtr_model_cd );
		*/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szSql, "SELECT MTR_MODEL_CD FROM MTR_MODEL WHERE MAKER_NUM = '%s' AND BARCODE_NUM = '%s'  ", m_szMakernum, m_szMtrBarnum, 0 );
		SPRINT(szTmp, " AND MTR_GRD = '%s' AND MTR_TYPE = '%s'", stChgMtr.szAfter_mtr_grd, stChgMtr.szAfter_mtr_type,0);
		Str_Cat(szSql, szTmp);
		g_Sql_RetStr( szSql, 20, stChgMtr.szAfter_mtr_model_cd );
		
		//��ġ�跮�� �ڸ�
		Str_Cpy(stChgMtr.szAfter_mtr_digit_cnt, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_DIGIT_CNT)));
		//��ġ�跮�� �⹰
		Str_Cpy(stChgMtr.szAfter_mtr_id_num, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_MTR_ID_NUM)));
		//��ġ�跮�� ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30008' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_REMOTE_FLAG)), 0, 0 );
		g_Sql_RetStr( szSql, 20, stChgMtr.szAfter_mtr_remote_flag );
		//��ġ�跮�� ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30087' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_KIND)), 0, 0 );
		g_Sql_RetStr( szSql, 20, stChgMtr.szAfter_mtr_kind );
		
		//��ġ�跮�� ����
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		Str_Cpy(szbuf, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG)));
		lCnt = ListCtrl_GetItemNum(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2));
		
		for( i = 0 ; i < lCnt ; i++ )
		{
			Str_Cpy(szTmp, ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2), i));
			if( Str_Cmp(szbuf, szTmp) == 0 )
			{
				Mem_Cpy((byte *)stChgMtr.szAfter_mtr_new_fix_flag, (byte *)ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2), i), 2);
				Mem_Cpy((byte *)stChgMtr.szAfter_fix_firm_nm_cd, (byte *)ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2), i)+2, 2);

				break;
			}
		}
		
		//��ġ�跮�� ��ȿ
		Str_Cpy(stChgMtr.szAfter_mtr_valid_ym, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_AF_VALID_YM)));
		//ö�Ű跮�� ��ħ
		Str_Cpy(stChgMtr.szRemove_indi_vc, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BF_VC)));
		//��ġ�跮�� ��ħ
		Str_Cpy(stChgMtr.szInst_indi_vc, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_VC)));
		
		if( Str_Cmp(stChgMtr.szRevis_flag, "10") != 0 )
		{
			Str_Cpy(stChgMtr.szRemove_indi_va, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BF_VA)));
			Str_Cpy(stChgMtr.szInst_indi_va,   EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_VA)));
			Str_Cpy(stChgMtr.szRemove_indi_vm, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BF_VM)));
			Str_Cpy(stChgMtr.szInst_indi_vm,   EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_AF_VM)));
		}
		
		//��ü����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30009' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_PERMITWHY)), 0, 0 );
		g_Sql_RetStr( szSql, 20, stChgMtr.szMtr_repl_why );
		
		if( Str_Cmp(stChgMtr.szMtr_repl_why, "300") == 0 || Str_Cmp(stChgMtr.szMtr_repl_why, "301") == 0 )
		{
			Str_Cpy(stChgMtr.szMtr_fee_free_flag, "Y");
		}
		else
		{
			Str_Cpy(stChgMtr.szMtr_fee_free_flag, "N");
		}
	}

// 	bool Save_Pay(void)
// 	{
// 		long idx;
// 		long i;
// 		bool lRet = TRUE;

// 		SQLITE sql = NewSqLite();

		
// 		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA13))) == 0 )
// 		{
// 			MessageBoxEx (CONFIRM_OK, "Ư���跮�� ���͸� ������ �������ּ���.");
// 			lRet = FALSE;
// 			goto Finally;
// 		}
// 		else if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA14))) == 0 )
// 		{
// 			MessageBoxEx (CONFIRM_OK, "Ư���跮�� ���ú� ������ �������ּ���.");
// 			lRet = FALSE;
// 			goto Finally;
// 		}

// 		// // ���͸�
// 		// i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA13)), C6301_battery_yn );
// 		// Str_Cpy(stChgMtr.battery_yn, C6301_battery_yn[i].Code);
// 		// PRINT("C6301_battery_yn[i].Code : %s",C6301_battery_yn[i].Code,0,0);

// 		// i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA14)), C6301_mtrdisplay_yn );
// 		// Str_Cpy(stChgMtr.mtrdisplay_yn, C6301_mtrdisplay_yn[i].Code);
// 		// PRINT("stChgMtr.mtrdisplay_yn222222222222 : %s",stChgMtr.mtrdisplay_yn,0,0);

// 		// ;
		
// 		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
// 		SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM != 'U' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA13)), 0, 0 );
// 		g_Sql_RetStr( m_szSql, 20, stChgMtr.battery_yn );

// 		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
// 		SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30023' AND CODE_ITEM != 'U' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA14)), 0, 0 );
// 		g_Sql_RetStr( m_szSql, 20, stChgMtr.mtrdisplay_yn );




// Finally:

// 		DelSqLite(sql);
// 		return lRet;
// 	}

// 	bool Save_Remote(void)
// 	{
// 		long idx;
// 		long i;
// 		bool lRet = TRUE;

// 		SQLITE sql = NewSqLite();

		
// 		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA15))) == 0 )
// 		{
// 			MessageBoxEx (CONFIRM_OK, "���ݽý��� ���� ȸ�縦 �������ּ���.");
// 			lRet = FALSE;
// 			goto Finally;
// 		}

// 		Mem_Set( (byte*)m_szSql, 0x00, sizeof(m_szSql) );
// 		// SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30023' AND ITEM_KNAME = '��ġ' ", 0, 0, 0 );
// 		SPRINT(m_szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C31097' AND ITEM_KNAME = '%s' ", EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA15)), 0, 0 );
// 		g_Sql_RetStr( m_szSql, 20, stChgMtr.remote_system );

// Finally:

// 		DelSqLite(sql);
// 		return lRet;
// 	}
	
	
	bool Save_ChgMtr(void)
	{
	long lSign, lSign_Len;
	long idx;
	bool bRet = TRUE;
	char sztmp[128];
	char* pRst;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		//����
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_ItoA(Time_GetDate(), stChgMtr.szJob_dtm, 10);
		g_Str_TimeType( stChgMtr.szJob_dtm+8 , Time_GetTime());
		Str_Cpy(stChgMtr.szAfter_form_appro_yn, "Y");
		Str_Cpy(stChgMtr.szSend_yn, "S");
		Str_Cpy(stChgMtr.other_price, "0");

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			bRet = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, 
" INSERT INTO C6101_CHG_MTR_INFO (MTR_NUM,REPL_TREAT_YMD,PROMISE_ASSIGN_SEQ,INST_PLACE_NUM,CENTER_CD \
,MTR_FEE_FREE_FLAG,MTR_REPL_WHY,MTR_BAR,AFTER_MTR_ID_NUM,AFTER_MTR_MODEL_CD \
,AFTER_MTR_GRD,AFTER_MTR_TYPE,AFTER_MTR_REMOTE_FLAG,AFTER_MTR_KIND,AFTER_MTR_DIGIT_CNT \
,AFTER_MTR_NEW_FIX_FLAG,AFTER_FIX_FIRM_NM_CD,AFTER_MTR_VALID_YM,AFTER_FORM_APPRO_YN,BEFO_MTR_ID_NUM \
,BEFO_MTR_MODEL_CD,BEFO_MTR_GRD,BEFO_MTR_TYPE,BEFO_MTR_REMOTE_FLAG,BEFO_MTR_KIND \
,BEFO_MTR_DIGIT_CNT,BEFO_MTR_NEW_FIX_FLAG,BEFO_FIX_FIRM_NM_CD,BEFO_MTR_VALID_YM,BEFO_MTR_APPRO_YN \
,REMOVE_INDI_VM,REMOVE_INDI_VA,REMOVE_INDI_VC,INST_INDI_VM,INST_INDI_VA \
,INST_INDI_VC,SEND_YN,JOB_DTM ,UPD_EMPID,PDA_IP \
,BATTERY_YN , OTHER_PRICE , MTRDISPLAY_YN , REMOTE_SYSTEM , OLD_MTR_ID_NUM ) VALUES \
(?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? \
,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?) " );
        
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szMtr_num               ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szRepl_treat_ymd        ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szPromise_assign_seq    ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szInst_place_num        ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szCenter_cd             ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szMtr_fee_free_flag     ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szMtr_repl_why          ,3  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szMtr_bar               ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_mtr_id_num      ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_mtr_model_cd    ,5  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_mtr_grd         ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_mtr_type        ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_mtr_remote_flag ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_mtr_kind        ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_mtr_digit_cnt   ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_mtr_new_fix_flag,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_fix_firm_nm_cd  ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_mtr_valid_ym    ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szAfter_form_appro_yn   ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_id_num       ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_model_cd     ,5  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_grd          ,8  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_type         ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_remote_flag  ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_kind         ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_digit_cnt    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_new_fix_flag ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_fix_firm_nm_cd   ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_valid_ym     ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szBefo_mtr_appro_yn     ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szRemove_indi_vm        ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szRemove_indi_va        ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szRemove_indi_vc        ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szInst_indi_vm          ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szInst_indi_va          ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szInst_indi_vc          ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szSend_yn               ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.szJob_dtm               ,15 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id         ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip              ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.battery_yn              ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.other_price             ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.mtrdisplay_yn           ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.remote_system           ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stChgMtr.old_mtr_id_num          ,25 ,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			bRet = FALSE;
			goto Finally;
		}
		bRet = TRUE;	
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		DelSqLite(sql);
		stMw.szMtr_chg_yn[0] = 'Y';
		
		return bRet;
	}
	
	//----------------------------------------------------------------------------------------------
	//���ڵ� �߸��� ��� ����� ���, ���� ������ Ŭ����
	void ClearData(void)
	{
		Mem_Set( (byte*)stChgMtr.szAfter_mtr_grd, 0x00, sizeof(stChgMtr.szAfter_mtr_grd) );
		Mem_Set( (byte*)stChgMtr.szAfter_mtr_type, 0x00, sizeof(stChgMtr.szAfter_mtr_type) );
		Mem_Set( (byte*)stChgMtr.szAfter_mtr_model_cd, 0x00, sizeof(stChgMtr.szAfter_mtr_model_cd) );
		Mem_Set( (byte*)stChgMtr.szAfter_mtr_digit_cnt, 0x00, sizeof(stChgMtr.szAfter_mtr_digit_cnt) );
		Mem_Set( (byte*)stChgMtr.szAfter_mtr_id_num, 0x00, sizeof(stChgMtr.szAfter_mtr_id_num) );
		Mem_Set( (byte*)stChgMtr.szAfter_mtr_remote_flag, 0x00, sizeof(stChgMtr.szAfter_mtr_remote_flag) );
		Mem_Set( (byte*)stChgMtr.szAfter_mtr_kind, 0x00, sizeof(stChgMtr.szAfter_mtr_kind) );
		Mem_Set( (byte*)stChgMtr.szAfter_mtr_new_fix_flag, 0x00, sizeof(stChgMtr.szAfter_mtr_new_fix_flag) );
		Mem_Set( (byte*)stChgMtr.szAfter_fix_firm_nm_cd, 0x00, sizeof(stChgMtr.szAfter_fix_firm_nm_cd) );
		Mem_Set( (byte*)stChgMtr.szAfter_mtr_valid_ym, 0x00, sizeof(stChgMtr.szAfter_mtr_valid_ym) );
		Mem_Set( (byte*)stChgMtr.szMtr_repl_why, 0x00, sizeof(stChgMtr.szMtr_repl_why) );
		Mem_Set( (byte*)stChgMtr.szMtr_fee_free_flag, 0x00, sizeof(stChgMtr.szMtr_fee_free_flag) );
		Mem_Set( (byte*)stChgMtr.szRemove_indi_vm, 0x00, sizeof(stChgMtr.szRemove_indi_vm) );
		Mem_Set( (byte*)stChgMtr.szRemove_indi_va, 0x00, sizeof(stChgMtr.szRemove_indi_va) );
		Mem_Set( (byte*)stChgMtr.szRemove_indi_vc, 0x00, sizeof(stChgMtr.szRemove_indi_vc) );
		Mem_Set( (byte*)stChgMtr.szInst_indi_vm, 0x00, sizeof(stChgMtr.szInst_indi_vm) );
		Mem_Set( (byte*)stChgMtr.szInst_indi_va, 0x00, sizeof(stChgMtr.szInst_indi_va) );
		Mem_Set( (byte*)stChgMtr.szInst_indi_vc, 0x00, sizeof(stChgMtr.szInst_indi_vc) );
	}
	
	void setBarCodeRsltView(long flag)
	{
		char szSql[300];
		
		if( flag == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
			Mem_Set( (byte*)stChgMtr.szAfter_mtr_new_fix_flag, 0x00, sizeof(stChgMtr.szAfter_mtr_new_fix_flag) );
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
			
			ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2));
			ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2));
			
			//���� value
			g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME	FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL	SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
			//���� code
			g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2), 0));
			
			Str_Cpy(stChgMtr.szAfter_mtr_new_fix_flag, "10");
		}
		else if ( flag == 1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
			Mem_Set( (byte*)stChgMtr.szAfter_mtr_new_fix_flag, 0x00, sizeof(stChgMtr.szAfter_mtr_new_fix_flag) );
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
			
			ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2));
			ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2));
			
			//���� value
			g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME	FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL	SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
			//���� code
			g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM = '10' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A, COMMONCODE B WHERE A.CODE_ID = 'C30004' AND B.CODE_ID = 'C30005' AND A.CODE_ITEM <> '10' AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);
			
			Str_Cpy(stChgMtr.szAfter_mtr_new_fix_flag, "20");
		}
		else if ( flag == 2 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG),  "");
			Mem_Set( (byte*)stChgMtr.szAfter_mtr_new_fix_flag, 0x00, sizeof(stChgMtr.szAfter_mtr_new_fix_flag) );
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+1), FALSE );
				
			ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG+2));
			ListCtrl_ResetAllItems(Get_hDlgCtrlByID(CMB_AF_NEW_FIX_FLAG2+2));
			
			//���� value
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			g_Sql_SetCombo("SELECT 'N:'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A WHERE A.CODE_ID = 'C30004' AND A.CODE_ITEM <> '10' AND A.CODE_ITEM <> '20' UNION ALL SELECT B.ITEM_KNAME||':'||A.ITEM_KNAME AS ITEM_KNAME FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG+2);
			//���� code
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			g_Sql_SetCombo("SELECT A.CODE_ITEM||'' AS CODE_ITEM FROM COMMONCODE A WHERE A.CODE_ID = 'C30004'  AND A.CODE_ITEM <> '10'  AND A.CODE_ITEM <> '20' UNION ALL SELECT A.CODE_ITEM||B.CODE_ITEM AS CODE_ITEM FROM COMMONCODE A , COMMONCODE B WHERE A.CODE_ID = 'C30004'  AND B.CODE_ID = 'C30005'  AND A.CODE_ITEM <> '10'  AND B.CODE_ITEM NOT IN ('R1', 'R3')", CMB_AF_NEW_FIX_FLAG2+2);					  

			Str_Cpy(stChgMtr.szAfter_mtr_new_fix_flag, "20");
		}
	}
	
}



