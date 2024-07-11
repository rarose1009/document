/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_WBUR
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
	#define USE_ON_EXTCTRL
	#define USE_ON_UART
	#define USE_ON_TASK
	
	#include "DefEvent.h"

#define CHK_N1	   "��N"
#define CHK_N2	   "��N"
#define CHK_Y1	   "��Y"
#define CHK_Y2	   "��Y"

#define CONGBN_N1	   "�౳ü"
#define CONGBN_N2	   "�ñ�ü"
#define CONGBN_Y1	   "������"
#define CONGBN_Y2	   "������"


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
		DEF_BUTTON_ID ( BID_SUBCLOSE )		//
		DEF_BUTTON_ID ( BID_WFIN )
		
		DEF_BUTTON_ID ( BID_UP )	//
		DEF_BUTTON_ID ( BID_DOWN )	//
		
		DEF_BUTTON_ID ( BID_NEW )		//
		DEF_BUTTON_ID ( BID_NEWSAVE )	//
		DEF_BUTTON_ID ( BID_BOILER )	//
		DEF_BUTTON_ID ( BID_BUNNER )	//
		DEF_BUTTON_ID ( BID_BURNER_INST_YMD )	//
		DEF_BUTTON_ID ( BID_CREATE )	//
		DEF_BUTTON_ID ( BID_BOILER_INST_FIRM_CD )	//

		DEF_BUTTON_ID ( BID_BARCODE)			//
		DEF_BUTTON_ID ( BID_BURNER_MODEL_NM)	//
		DEF_BUTTON_ID ( BID_MAKE_NUM)			//

		DEF_BUTTON_ID ( BID_INDUC_INST_Y )	//
		DEF_BUTTON_ID ( BID_INDUC_INST_N )	//
		
		DEF_BUTTON_ID ( BID_TRANS_CONN_Y )	//
		DEF_BUTTON_ID ( BID_TRANS_CONN_N )	//
		DEF_BUTTON_ID ( BID_CONN_Y )	//
		DEF_BUTTON_ID ( BID_CONN_N )	//
		DEF_BUTTON_ID ( BID_G_CONN_Y )	//
		DEF_BUTTON_ID ( BID_G_CONN_N )	//
		DEF_BUTTON_ID ( BID_G_CONNGBN_Y )	//
		DEF_BUTTON_ID ( BID_G_CONNGBN_N )	//
		
		DEF_BUTTON_ID ( BID_CHG  )			//
		DEF_BUTTON_ID ( BID_SAVE )			//
		DEF_BUTTON_ID ( BID_DEL  )			//
		DEF_BUTTON_ID ( BID_PHOTO_MTR )		//
		DEF_BUTTON_ID ( BID_PHOTO_POS )		//
		DEF_BUTTON_ID ( BID_BAR_WHY )		//
		
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
	
		DEF_OBJECT_ID ( TXT_TITLE )		//
		DEF_OBJECT_ID ( ICON_TITLE )	//
		DEF_OBJECT_ID ( TAB_COVER )		//
		DEF_OBJECT_ID ( TAB_LINE )		//
		DEF_OBJECT_ID ( TXT_PAGE )		//
		
		DEF_OBJECT_ID (TTL_BURNER_NUM     )// ��ȣ
		DEF_OBJECT_ID (TXT_BURNER_NUM     )//
		
		DEF_OBJECT_ID (TTL_BURNER_KIND_NUM)//����
		DEF_OBJECT_ID (TTL_MTR_ID_NUM     )//�⹰��ȣ
		DEF_OBJECT_ID (TTL_INST_LOC       )//��ġ��ġ
		DEF_OBJECT_ID (TTL_BOILER_FORM    )//����
		DEF_OBJECT_ID (TTL_MAKE_NUM       )//������ȣ
		DEF_OBJECT_ID (TXT_MAKE_NUM       )//
		DEF_OBJECT_ID (TTL_BOILER_INST_FIRM_CD)//��ġ��ü
		
		DEF_OBJECT_ID (TTL_REPRE_NM      )//��ǥ�ڸ�
		DEF_OBJECT_ID (TXT_REPRE_NM      )//
		DEF_OBJECT_ID (TTL_REG_NUM1      )//�����ȣ
		DEF_OBJECT_ID (TXT_REG_NUM1      )//
		DEF_OBJECT_ID (TTL_TEL      )//��ȭ��ȣ
		DEF_OBJECT_ID (TXT_TEL      )//
		DEF_OBJECT_ID (TTL_INST_FLAG      )//��ġ����
		DEF_OBJECT_ID (TXT_INST_FLAG      )//
		
		DEF_OBJECT_ID (TXT_G_CONN_YN      )//
		DEF_OBJECT_ID (TXT_G_CONNGBN_YN      )//
		
		DEF_OBJECT_ID (TTL_MAKER_NM           )// ������
		DEF_OBJECT_ID (TXT_MAKER_NM           )//
		DEF_OBJECT_ID (TTL_BURNER_MODEL_NM    )// ��
		DEF_OBJECT_ID (TXT_BURNER_MODEL_NM    )// 
		DEF_OBJECT_ID (TTL_BURNER_INST_YMD    )// ��ġ����
		DEF_OBJECT_ID (TXT_BURNER_INST_YMD    )// 
		DEF_OBJECT_ID (TTL_BURNER_DATA_FLAG   )// ���� true2k
		DEF_OBJECT_ID (TXT_BURNER_DATA_FLAG   )// 
		
		
		DEF_OBJECT_ID (TTL_MTR_GRD            )// ���
		DEF_OBJECT_ID (TXT_MTR_GRD            )//
		DEF_OBJECT_ID (TTL_BURNER_CAPA        )// �뷮
		DEF_OBJECT_ID (TXT_BURNER_CAPA        )// 
		DEF_OBJECT_ID (TXT_BURNER_CAPA_UNIT_NM)//         
		DEF_OBJECT_ID (TTL_INST_LOC_NM        )// ��ġ��ġ
		DEF_OBJECT_ID (TXT_INST_LOC_NM        )// 
		DEF_OBJECT_ID (TTL_BOILER_FORM_NM     )// ����
		DEF_OBJECT_ID (TXT_BOILER_FORM_NM     )//   
		DEF_OBJECT_ID (TTL_BOILER_INST_FIRM_NM)// ��ġ��ü
		DEF_OBJECT_ID (TXT_BOILER_INST_FIRM_NM)//         

		DEF_OBJECT_ID (TTL_INDUC_INST_YN      )// �δ��� ��ġ����
		DEF_OBJECT_ID (TXT_INDUC_INST_YN      )// 

		DEF_OBJECT_ID (TTL_TRANS_CONN_YN      )// ���Կ���
		DEF_OBJECT_ID (TXT_TRANS_CONN_YN      )// 
		DEF_OBJECT_ID (TTL_CONN_YN            )// ���Ῡ��
		DEF_OBJECT_ID (TXT_CONN_YN            )//  
		DEF_OBJECT_ID (TTL_BAR_GBN            )// ���ڵ�
		DEF_OBJECT_ID (TXT_MTR_ID_NUM         )// 
		DEF_OBJECT_ID (TTL_BAR_WHY            )// �Ұ�����
		
		DEF_OBJECT_ID (CMB_BAR_WHY            )//
		DEF_OBJECT_ID (CMB_BAR_GBN = CMB_BAR_WHY+3  )// 
		DEF_OBJECT_ID (CMB_BURNER_KIND_NUM = CMB_BAR_GBN+3  )// 
		DEF_OBJECT_ID (CMB_MTR_ID_NUM = CMB_BURNER_KIND_NUM+3  )// 
		DEF_OBJECT_ID (CMB_CAPA_UNIT_NM = CMB_MTR_ID_NUM+3  )// 
		DEF_OBJECT_ID (CMB_MAKER_NM = CMB_CAPA_UNIT_NM+3  )// 
		DEF_OBJECT_ID (CMB_INST_LOC = CMB_MAKER_NM+3  )// 
		DEF_OBJECT_ID (CMB_BOILER_FORM = CMB_INST_LOC+3  )// 
		DEF_OBJECT_ID (CMB_INST_FIRM_NM = CMB_BOILER_FORM+3  )// 		
		DEF_OBJECT_ID (ID_TBLLIST =CMB_INST_FIRM_NM +3 )
	END_OBJECT_ID()
	
	#define INIT_MAIN	  1
	#define INIT_BURNEW	  2
	#define INIT_BURCHG	  3
	#define INIT_BURGBN	  4
	
	#define		W_MAIN		CWD*39+10
	#define		H_MAIN		CHT*21+20
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    3					// table�� �ళ��
	#define		COL 	    6					// table�� ������
	#define		GRID_H		(CHT+10)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		51 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+50  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	#define 	SYH			(CHT+20)
	#define 	Line(x)	    (GRID_ENDY+20+SYH*x)
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�⹰��ȣ", CWD*16,  	EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���ұ�" , CWD*8, 		EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����"   , CWD*10+23,   EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����"   , CWD*5,	    EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"MTR_NUM", 0,   		EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"BURNUM_NUM", 0,   	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	
	#define	BUTSETRANGE(h, x1, y1, x2, y2)		ButCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	
	long m_bFirst;
	char m_szCnt_index[11];     //�ε��� ���ڿ�(���� ������)
	long m_lpage = 0;
	long m_lTotpage = 0;
	long m_lActiveIndex;
	long m_lActRow = 0;
	long m_lNewflag = 0;
	char m_szfilenm[128];
	char m_szBarcode_Value[20];	//���ڵ� ��ĵ ���
	long m_lCard = 0; // 0.C6101_WCUST, 1.C6101_WMTR, 2.C6101_WCHK, 3.C6101_WONE, 4.C6101_WSTOP, 5.C6101_WRELE, 6.C6101_WPAY, 7.MENU, 8.C6101_MENU, 9.C6101_LST
	long m_lPhoto_Flag = 0 ; //0.�跮��,1 .���
	
	MWBURINFO stBur;
	handle m_hdb;
	SQLITE m_sql;
	handle m_hstmt;
	
	void SetBtnImg(void);
	void SetStyle(void);
	void Draw_Tb(void);
	void ReDraw(void);
	void Set_BarRadio(void);
	void Set_Bar(void);
	void Barcode_Strat(void);
	void OnBarcodeRead(void);
	void Shoto_Photo(long ID);

	void Save_Induction(void);
	
	long Sql_SetCombo(char* szSql, long CTRLID );
	void SetCombo(void);
	
	void OnList(quad lParam);
	void INST_DRAW(void);
	void Save_Chg(void);
	void Save_New(void);
	void Save_Del(void);
	long SearchStr( char *Str, CodeTable *CT);
	long SearchCD( char *CD, CodeTable *CT);
	void QuickList(void);
	
	void Snd_Promise_Assign(void);
	long TR62804(void);
	
	void Snd_Photo(long flag);
	long TR62806(void);
	
	void Snd_Delete_Photo(void);
	long TR62807(void);
	
	void Find_Burner_Class_Cd(long flag);
	void Chk_Prod_Cd_Alarm(char* burclscd, long flag);
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WCUST, "��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_WBUR, "���ұ�"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WONE, "��ȸ��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WPAY, "���"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WSTOP, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WRELE, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WCHK, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC , "", BID_WFIN, "�Ϸ�"),
		//DLG_TEXT ( 10, STARTY+35, W_MAIN, H_MAIN, 0, 0, 0, EDITSTY_THICKBORDER|EDITSTY_BORDER, TTLCTRLBK, TTLCTRLBK, TAB_LINE, ""),	
		//DLG_TEXT ( 0, 0, 0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, TAB_COVER, ""),
		
		// ����Ʈ
		DLG_TABLE (GRID_X,      GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		DLG_BUTTON(STARTX,      GRID_ENDY+10, 200,    SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+200,  GRID_ENDY+10, 200,    SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		DLG_TEXT(  STARTX+774,  GRID_ENDY+10, CWD*9, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),
		
		DLG_TEXT( STARTX,     Line(1),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MAKER_NM, "������"),
		DLG_TEXT( STARTX+215, Line(1),  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MAKER_NM, ""),
		DLG_TEXT( STARTX+500, Line(1),  150, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_MODEL_NM, "��"),
		DLG_TEXT( STARTX+650, Line(1),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BURNER_MODEL_NM, ""),
		DLG_TEXT( STARTX,     Line(2),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_INST_YMD, "��ġ����"),
		DLG_TEXT( STARTX+215, Line(2),  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BURNER_INST_YMD, ""),
		DLG_TEXT( STARTX+500, Line(2),  150, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_GRD, "���"),
		DLG_TEXT( STARTX+650, Line(2),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_GRD, ""),
		DLG_TEXT( STARTX,     Line(3),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_CAPA, "�뷮"),
		DLG_TEXT( STARTX+215, Line(3),  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BURNER_CAPA, ""),
		DLG_TEXT( STARTX+500, Line(3),  500, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BURNER_CAPA_UNIT_NM, ""),
		DLG_TEXT( STARTX,     Line(4),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INST_LOC_NM, "��ġ��ġ"),
		DLG_TEXT( STARTX+215, Line(4),  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INST_LOC_NM, ""),
		DLG_TEXT( STARTX+500, Line(4),  150, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BOILER_FORM_NM, "����"),
		DLG_TEXT( STARTX+650, Line(4),  350, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BOILER_FORM_NM, ""),
		DLG_TEXT( STARTX,     Line(5),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BOILER_INST_FIRM_NM, "��ġ��ü"),
		DLG_TEXT( STARTX+215, Line(5),  785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BOILER_INST_FIRM_NM, ""),
		DLG_TEXT( STARTX+500, Line(5),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDUC_INST_YN, "�δ���"),
		DLG_TEXT( STARTX+715, Line(5),  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDUC_INST_YN, ""),
		DLG_BUTTON(STARTX+715,Line(5),  142, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_INDUC_INST_Y,  CHK_Y1),
		DLG_BUTTON(STARTX+857,Line(5),  142, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_INDUC_INST_N,  CHK_N1),
		
		DLG_TEXT( STARTX,     Line(6),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TRANS_CONN_YN, "���Կ���"),
		DLG_TEXT( STARTX+215, Line(6),  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TRANS_CONN_YN, ""),
		DLG_BUTTON(STARTX+215,Line(6),  142, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TRANS_CONN_Y,  CHK_Y1),
		DLG_BUTTON(STARTX+357,Line(6),  143, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_TRANS_CONN_N,  CHK_N1),
		DLG_TEXT( STARTX+500, Line(6),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_CONN_YN, "���Ῡ��"),
		DLG_TEXT( STARTX+715, Line(6),  285, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_CONN_YN, ""),
		DLG_BUTTON(STARTX+715,Line(6),  142, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CONN_Y,  CHK_Y1),
		DLG_BUTTON(STARTX+857,Line(6),  142, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CONN_N,  CHK_N1),

		DLG_TEXT( STARTX+215, Line(6),  392, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_G_CONN_YN, ""),
		DLG_TEXT( STARTX+607, Line(6),  392, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_G_CONNGBN_YN, ""),
		DLG_BUTTON(STARTX+215,Line(6),  196, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_G_CONN_Y,  CHK_Y1),
		DLG_BUTTON(STARTX+412,Line(6),  196, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_G_CONN_N,  CHK_N1),
		DLG_BUTTON(STARTX+608,Line(6),  196, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_G_CONNGBN_Y,  CONGBN_Y1),
		DLG_BUTTON(STARTX+804,Line(6),  195, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_G_CONNGBN_N,  CONGBN_N1),
		
		DLG_TEXT(  STARTX,    Line(7),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BAR_GBN, "���ڵ�"),
		DLG_BUTTON(STARTX,    Line(7),  215, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BARCODE, "���ڵ�"),
		DLG_COMBO_UP(STARTX+215, Line(7), 285, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BAR_GBN, 10),
		
		//DLG_TEXT( STARTX+500, Line(7),  500, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_ID_NUM, ""),
		DLG_TEXT( STARTX+215, Line(7),  785, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_ID_NUM, ""),
		
		DLG_TEXT( STARTX,     Line(8),  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BAR_WHY, "�Ұ�����"),
		DLG_BUTTON( STARTX,   Line(8), 215, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BAR_WHY, "�Ұ�����"),
		DLG_COMBO_UP( STARTX+215, Line(8),  785, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BAR_WHY, 10),

		DLG_BUTTON( STARTX,     Line(9)+9, 166, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEW, "�ű�"),
		DLG_BUTTON( STARTX+166, Line(9)+9, 166, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHG, "����"),
		DLG_BUTTON( STARTX+332, Line(9)+9, 166, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DEL, "����"),
		DLG_BUTTON( STARTX+498, Line(9)+9, 250, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO_MTR, "�跮��\n��ȣ ����"),
		DLG_BUTTON( STARTX+749, Line(9)+9, 250, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO_POS, "�ش�����\n�ּ� ����"),
	};

	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, ""),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
	};	
	
	//---------------------------------------------------------------
	DlgObject	DlgRes_NEW[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� �ű��߰�"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX,      STARTY-29,      300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_NUM, "���ұ��ȣ"),
		DLG_TEXT( STARTX+300,  STARTY-29,      700, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BURNER_NUM, ""),
		DLG_TEXT( STARTX,      STARTY+SYH-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_KIND_NUM, "����"),
		DLG_COMBO( STARTX+300, STARTY+SYH-29,  700, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BURNER_KIND_NUM, 10),
		
		DLG_TEXT( STARTX,      STARTY+SYH*2-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_ID_NUM, "�⹰��ȣ"),
		DLG_COMBO( STARTX+300, STARTY+SYH*2-29,  700, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_MTR_ID_NUM, 10),
		
		DLG_TEXT( STARTX,      STARTY+SYH*3-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_MODEL_NM, "�𵨸�"),
		DLG_BUTTON(STARTX+300, STARTY+SYH*3-29,  700, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BURNER_MODEL_NM,  ""),
		DLG_TEXT( STARTX+300,  STARTY+SYH*3-29,  700, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_BURNER_MODEL_NM, ""),
		
		DLG_TEXT( STARTX,      STARTY+SYH*4-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_CAPA, "�뷮"),
		DLG_EDIT( STARTX+300,  STARTY+SYH*4-29,  260, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_BURNER_CAPA,10, ""),
		DLG_COMBO( STARTX+560, STARTY+SYH*4-29,  440, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_CAPA_UNIT_NM, 10),
		
		DLG_TEXT( STARTX,      STARTY+SYH*5-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MAKER_NM, "�������"),
		DLG_COMBO( STARTX+300, STARTY+SYH*5-29,  700, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_MAKER_NM, 10),
		
		DLG_TEXT( STARTX,      STARTY+SYH*6-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_INST_YMD, "��ġ����"),
		DLG_TEXT( STARTX+300,  STARTY+SYH*6-29,  580, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_BURNER_INST_YMD, ""),
		DLG_BUTTON(STARTX+880, STARTY+SYH*6-29, SYH*2, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BURNER_INST_YMD, "��"),
		
		DLG_TEXT( STARTX,      STARTY+SYH*7-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INST_LOC, "��ġ��ġ"),
		DLG_COMBO( STARTX+300, STARTY+SYH*7-29,  700, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_INST_LOC, 10),
		
		DLG_TEXT( STARTX,      STARTY+SYH*8-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BOILER_FORM, "����"),
		DLG_COMBO( STARTX+300, STARTY+SYH*8-29,  700, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BOILER_FORM, 10),
		
		DLG_TEXT( STARTX,      STARTY+SYH*9-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MAKE_NUM, "������ȣ"),
		DLG_BUTTON(STARTX+300, STARTY+SYH*9-29,  700, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MAKE_NUM,  ""),
		DLG_TEXT( STARTX+300,  STARTY+SYH*9-29,  700, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_MAKE_NUM, ""),
		
		DLG_TEXT( STARTX,      STARTY+SYH*10-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BOILER_INST_FIRM_CD, "��ġ��ü"),
		//DLG_COMBO( STARTX+240, STARTY+SYH*10,  730, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_INST_FIRM_NM, 10),
		DLG_TEXT( STARTX+300,  STARTY+SYH*10-29,  580, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CMB_INST_FIRM_NM, ""),
		DLG_BUTTON(STARTX+880, STARTY+SYH*10-29, SYH*2, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BOILER_INST_FIRM_CD, "��"),
		
		DLG_TEXT( STARTX,     STARTY+SYH*11-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_REPRE_NM, "��ǥ�ڸ�"),
		DLG_TEXT( STARTX+300, STARTY+SYH*11-29,  260, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_REPRE_NM, ""),
		DLG_TEXT( STARTX+560, STARTY+SYH*11-29,  215, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_REG_NUM1, "�����ȣ"),
		DLG_TEXT( STARTX+775, STARTY+SYH*11-29,  225, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_REG_NUM1, ""),
				
		DLG_TEXT( STARTX,     STARTY+SYH*12-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_TEL, "��ȭ��ȣ"),
		DLG_TEXT( STARTX+300, STARTY+SYH*12-29,  700, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_TEL, ""),
		
		DLG_TEXT( STARTX,     STARTY+SYH*13-29,  300, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INST_FLAG, "��ġ����"),
		DLG_TEXT( STARTX+300, STARTY+SYH*13-29,  700, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INST_FLAG, "�ű�"),

		DLG_BUTTON( STARTX+699, STARTY+SYH*13+40, 300, SYH+19, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEWSAVE, "�� ��"),
	};
	
	//---------------------------------------------------------------
	DlgObject	DlgRes_CHG[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_TEXT( STARTX,      STARTY-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_ID_NUM, "�⹰��ȣ"),
		DLG_TEXT( STARTX+240,  STARTY-29,  760, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_ID_NUM, ""),
		
		DLG_TEXT( STARTX,      STARTY+SYH-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_KIND_NUM, "����"),
		DLG_COMBO( STARTX+240, STARTY+SYH-29,  760, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BURNER_KIND_NUM, 10),
		
		DLG_TEXT( STARTX,      STARTY+SYH*2-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MAKER_NM, "�������"),
		DLG_COMBO( STARTX+240, STARTY+SYH*2-29,  760, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_MAKER_NM, 10),

		DLG_TEXT( STARTX,      STARTY+SYH*3-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_MODEL_NM, "�𵨸�"),
		DLG_BUTTON(STARTX+240, STARTY+SYH*3-29,  760, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BURNER_MODEL_NM,  ""),
		DLG_TEXT( STARTX+240,  STARTY+SYH*3-29,  760, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_BURNER_MODEL_NM,  ""),

		DLG_TEXT( STARTX,      STARTY+SYH*4-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_CAPA, "�뷮"),
		DLG_EDIT( STARTX+240,  STARTY+SYH*4-29,  330, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_BURNER_CAPA,10, ""),
		DLG_COMBO( STARTX+570, STARTY+SYH*4-29,  430, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_CAPA_UNIT_NM, 10),
		
		DLG_TEXT( STARTX,      STARTY+SYH*5-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_INST_YMD, "��ġ����"),
		// true2k DLG_TEXT( STARTX+240, STARTY+SYH*5,  730, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BURNER_INST_YMD, ""),
		// true2k DLG_BUTTON(STARTX+970-SYH*2, STARTY+SYH*5, SYH*2, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BURNER_INST_YMD, "��"),
		DLG_TEXT( STARTX+240,  STARTY+SYH*5-29,  330, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BURNER_INST_YMD, ""),
		DLG_BUTTON(STARTX+570, STARTY+SYH*5-29, SYH*2, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BURNER_INST_YMD, "��"),
		// ���� // true2k 
		DLG_TEXT( STARTX+690,  STARTY+SYH*5-29,  140, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BURNER_DATA_FLAG, "����"),
		DLG_TEXT( STARTX+830,  STARTY+SYH*5-29,  170, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_BURNER_DATA_FLAG, ""),
							
		DLG_TEXT( STARTX,      STARTY+SYH*6-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INST_LOC, "��ġ��ġ"),
		DLG_COMBO( STARTX+240, STARTY+SYH*6-29,  760, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_INST_LOC, 10),
		
		DLG_TEXT( STARTX,      STARTY+SYH*7-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MAKE_NUM, "������ȣ"),
		DLG_BUTTON(STARTX+240, STARTY+SYH*7-29,  760, SYH, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MAKE_NUM,  ""),
		DLG_TEXT( STARTX+240,  STARTY+SYH*7-29,  760, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, TXT_MAKE_NUM,  ""),
		
		DLG_TEXT( STARTX,      STARTY+SYH*8-29,  240, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_BOILER_FORM, "����"),
		DLG_COMBO( STARTX+240, STARTY+SYH*8-29,  760, SYH*6, SYH*2, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_BOILER_FORM, 10),

		DLG_BUTTON( STARTX+730,STARTY+SYH*9+10-20, 270, SYH+10, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "�� ��"),
	};
	
	//---------------------------------------------------------------
	DlgObject	DlgRes_GBN[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� �ű��߰�"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SUBCLOSE, ""),
		
		DLG_BUTTON( STARTX+25,  STARTY+SYH, 400, SYH*2, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BOILER, "���Ϸ�"),
		DLG_BUTTON( STARTX+570, STARTY+SYH, 400, SYH*2, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BUNNER, "���ұ�"),
		
		DLG_BUTTON( STARTX+730, STARTY+SYH*4, 240, SYH+30, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CREATE, "�űԻ���"),
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
						m_lActRow = 0;
						Draw_Tb();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						m_lActRow = 0;
						Draw_Tb();
						break;		
				}
				break;
			case INIT_BURNEW:
				CREATE_DIALOG_OBJECT (DlgRes_NEW, SIZEOF(DlgRes_NEW));
				break;
			case INIT_BURCHG:
				CREATE_DIALOG_OBJECT (DlgRes_CHG, SIZEOF(DlgRes_CHG));
				break;
			case INIT_BURGBN:
				CREATE_DIALOG_OBJECT (DlgRes_GBN, SIZEOF(DlgRes_GBN));
				break;
			
		}
		SetBtnImg();
		SetStyle();
		ReDraw();
		
	}
	
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
	long d, k;
	char sztmp[10];
		
		switch(ID)
		{
			case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
				}
				m_lActRow = 0;
				Draw_Tb();
				ReDraw();
				break;
				
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
				}
				m_lActRow = 0;
				Draw_Tb();
				ReDraw();
				break;

			case BID_TRANS_CONN_Y:
				stMw.szTrans_conn_yn[0] = 'Y';
				if(Str_Cmp( stMw.szCivil_serv_class_cd , "060103") != 0)
				{
					if( stMw.szBar_yn[0] == 0)
						Str_Cpy(stMw.szBar_gbn, "20");
					
				}
				Set_BarRadio();
				break;
				
			case BID_TRANS_CONN_N:
				if( Str_Cmp(stMw.szTrans_conn_yn, "Y") == 0 &&
				( g_nWorkFlag != 620 && Str_Cmp( stMw.szCivil_serv_class_cd , "060103") != 0 ) )
				{
					//��� || ����
					if( MessageBoxEx (CONFIRM_YESNO, "���ڵ� �� �� ������ �ʱ�ȭ�˴ϴ�.\n��� �����Ͻðڽ��ϱ�?") != MB_OK )
					{
						return;
					}
				}
				
				stMw.szTrans_conn_yn[0] = 'N';
				
				if(Str_Cmp( stMw.szCivil_serv_class_cd , "060103") != 0)
				{
					Mem_Set((byte*)stMw.szConn_yn,0, sizeof(stMw.szConn_yn) );
					if( stMw.szBar_yn[0] == 0)
						Mem_Set((byte*)stMw.szBar_gbn,0, sizeof(stMw.szBar_gbn) );
				}
				Set_BarRadio();
				break;
			
			case BID_INDUC_INST_Y:
				stBur.szInduc_inst_yn[0] = 'Y';				
				Set_BarRadio();
				Save_Induction();
				break;
				
			case BID_INDUC_INST_N:
				stBur.szInduc_inst_yn[0] = 'N';				
				Set_BarRadio();
				Save_Induction();
				break;

			case BID_CONN_Y:
				if(Str_Cmp( stMw.szCivil_serv_class_cd , "060103") == 0)
					stMw.szChk_yn[0] = 'Y';
				else
					stMw.szConn_yn[0] = 'Y';
				Set_BarRadio();
				break;
				
			case BID_CONN_N:
				if(Str_Cmp( stMw.szCivil_serv_class_cd , "060103") == 0)
					stMw.szChk_yn[0] = 'N';
				else
					stMw.szConn_yn[0] = 'N';
				Set_BarRadio();
				break;
				
			//���-����ο�
			case BID_G_CONN_Y:
				stMw.szConn_yn[0] = 'Y';
				
				if( stMw.szBar_yn[0] == 0)
					Str_Cpy(stMw.szBar_gbn, "20");
			
				Set_BarRadio();
				break;
			//���-����ο�
			case BID_G_CONN_N:
				if( Str_Cmp(stMw.szConn_yn, "Y") == 0 && stUserinfo.szcenter_cd[0] == '4' )
				{
					//��� || ����
					if( MessageBoxEx (CONFIRM_YESNO, "���ڵ� �� �� ������ �ʱ�ȭ�˴ϴ�.\n��� �����Ͻðڽ��ϱ�?") != MB_OK )
					{
						return;
					}
				}

				stMw.szConn_yn[0] = 'N';
				Mem_Set((byte*)stMw.szConn_gbn,0, sizeof(stMw.szConn_gbn) );
				
				if( stMw.szBar_yn[0] == 0)
					Mem_Set((byte*)stMw.szBar_gbn,0, sizeof(stMw.szBar_gbn) );
				Set_BarRadio();
				break;
				
			case BID_G_CONNGBN_Y:
				Str_Cpy(stMw.szConn_gbn, "10");
				Set_BarRadio();
				break;
				
			case BID_G_CONNGBN_N:
				Str_Cpy(stMw.szConn_gbn, "60");
				Set_BarRadio();
				break;
				
			case BID_BAR_WHY:
				Mem_Set( (byte*)stMw.szBar_why, 0x00, sizeof(stMw.szBar_why) );
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BAR_WHY), "");
				Set_BarRadio();
				break;
		
			case BID_BURNER_INST_YMD:
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BURNER_INST_YMD)));
				k = Str_AtoI(sztmp);
				Load_Calendar_Card();
				d = CalendarDialog(&k);
				Unload_Calendar_Card();
				if(d == 0)
				{
					break;
				}
				else
				{
					if( d > Time_GetDate() )
					{
						MessageBoxEx (CONFIRM_OK, "���纸�� ���ķ� ����� �� �����ϴ�.");
						break;
					}
					Mem_Set((byte*)stBur.szBurner_inst_ymd, 0x00, sizeof(stBur.szBurner_inst_ymd));
					Str_ItoA ( d, stBur.szBurner_inst_ymd, 10);
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
					g_Str_DateType(sztmp, stBur.szBurner_inst_ymd);
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_BURNER_INST_YMD), sztmp);
				}
				break;
				
			case BID_BOILER:
				m_lNewflag = 1;
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOILER), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BUNNER), TRUE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CREATE), TRUE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CREATE), FALSE );
				break;
				
			case BID_BUNNER:
				m_lNewflag = 2;
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOILER), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BUNNER), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CREATE), TRUE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CREATE), FALSE );
				break;
				
			case BID_CREATE:
				Mem_Set((byte*)&stBur, 0x00, sizeof(stBur));
				ON_EXIT();
				OnInit(INIT_BURNEW);
				break;
				
			case BID_NEWSAVE:
				Save_New();
				break;
					
			case BID_BURNER_MODEL_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_BURNER_MODEL_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BURNER_MODEL_NM)) );
				break;
				
			case BID_MAKE_NUM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(TXT_MAKE_NUM), EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MAKE_NUM)) );
				break;
				
			case BID_BOILER_INST_FIRM_CD:	
				QuickList();
				break;
				
			case BID_BARCODE:
				Barcode_Strat();
				break;
					
			case BID_PHOTO_MTR:
			case BID_PHOTO_POS:
				Shoto_Photo(ID);
				break;
				
			case BID_NEW:
				ON_EXIT();
				OnInit(INIT_BURGBN);
				break;
				
			case BID_CHG:
				if( m_lActRow == -1)
				{
					MessageBoxEx (ERROR_OK, "���ұ⸦ �����ϼ���.");
					break;
				}
				ON_EXIT();
				OnInit(INIT_BURCHG);
				break;
				
			case BID_DEL:
				if( m_lActRow == -1)
				{
					MessageBoxEx (ERROR_OK, "���ұ⸦ �����ϼ���.");
					break;
				}
				
				if( MessageBoxEx (CONFIRM_YESNO, "�����Ͻðڽ��ϱ�?") != MB_OK )
				{
					break;
				}
				
				Save_Del();
				break;
				
			case BID_SAVE:
				Save_Chg();
				break;
				
			case BID_SUBCLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
			case BID_WCUST:
				m_lCard = 0;
				Set_Bar();
				Snd_Promise_Assign();
				//Card_Move("C6101_WCUST");
				break;
			case BID_WMTR:
				m_lCard = 1;
				Set_Bar();
				Snd_Promise_Assign();
				//Card_Move("C6101_WMTR");
				break;
			case BID_WBUR:
				Set_Bar();
				//Card_Move("C6101_WBUR");
				break;
			case BID_WCHK:
				m_lCard = 2;
				Set_Bar();
				Snd_Promise_Assign();
				//Card_Move("C6101_WCHK");
				break;
			case BID_WONE:
				m_lCard = 3;
				Set_Bar();
				Snd_Promise_Assign();
				//Card_Move("C6101_WONE");
				break;
			case BID_WSTOP:
				m_lCard = 4;
				Set_Bar();
				Snd_Promise_Assign();
				//Card_Move("C6101_WSTOP");
				break;
			case BID_WRELE:
				m_lCard = 5;
				Set_Bar();
				Snd_Promise_Assign();
				//Card_Move("C6101_WRELE");
				break;
			case BID_WPAY:
				m_lCard = 6;
				Set_Bar();
				Snd_Promise_Assign();
				//Card_Move("C6101_WPAY");
				break;			
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					m_lCard = 7;
					Set_Bar();
					Snd_Promise_Assign();
					//Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					m_lCard = 8;
					Set_Bar();
					Snd_Promise_Assign();
					//Card_Move("C6101_MENU");
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
				m_lCard = 9;
				Set_Bar();
				Snd_Promise_Assign();
				//Card_Move("C6101_LST");
				break;	
			case GID_VMEXIT:
				g_Exit();
				break;
			case BID_CLOSE:
				if( MessageBoxEx (CONFIRM_YESNO, "�۾�����Ʈ ȭ������ �����ðڽ��ϱ�?")  == MB_OK)
				{
					m_lCard = 9;
					Set_Bar();
					Snd_Promise_Assign();
					//Card_Move("C6101_LST");
				}
				break;
			case BID_WFIN:
				Set_Bar();
				Snd_Promise_Assign();
				
				if( MessageBoxEx (CONFIRM_YESNO, "����Ȯ���� �Ϸ��Ͻðڽ��ϱ�?")  == MB_OK)
				{
					Str_ItoA( Time_GetDate(), stMw.szChk_time_end, 10);
					g_Str_TimeType(stMw.szChk_time_end+8, Time_GetTime());

					g_Snd_RstMin_690(1);
				}
				break;
		}
	}
	
	void	OnChar(long nChar)
	{
		if( INIT_BURNEW == m_bFirst  || INIT_BURCHG == m_bFirst )
		{
			if( Get_iDlgCtrlByID(TXT_BURNER_CAPA) == m_lActiveIndex )
			{
				//���ڸ� �Է� ����
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					ON_KEY( 5 );
					return;
				}

				Str_Cpy(stBur.szBurner_capa, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BURNER_CAPA)));
			}
		}
	}
	
	void	OnPointing(long nAction, long X, long Y)
	{
		if( INIT_BURNEW == m_bFirst )
		{
			m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			
			if( POINTING_UP == nAction )
			{
				if( X > DMS_X(STARTX+300) && X < DMS_X(STARTX+560) && Y > DMS_Y(STARTY+SYH*4-29-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+SYH*5-29-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(TXT_BURNER_CAPA) == m_lActiveIndex )	
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
		else if( INIT_BURCHG == m_bFirst )
		{
			m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			
			if( POINTING_UP == nAction )
			{
				if( X > DMS_X(STARTX+240) && X < DMS_X(STARTX+570) && Y > DMS_Y(STARTY+SYH*4-29-(g_Dlgflag*400)) && Y < DMS_Y(STARTY+SYH*5-29-(g_Dlgflag*400)) )
				{
					if( Get_iDlgCtrlByID(TXT_BURNER_CAPA) == m_lActiveIndex )	
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
	
	void	OnSelect(long Index)
	{
		long index = -1, i;
		char szcmb[51];
		
		
		if( INIT_MAIN == m_bFirst )
		{
			m_lActiveIndex = -1;
			
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_lActRow = index-1;
				
				// ���� �ε����� ���� �ε����� ���� �� ���
				Mem_Set((byte*)&stBur, 0x00, sizeof(stBur));
				Str_Cpy( stBur.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
				Str_Cpy( stBur.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 4)  );
				Str_Cpy( stBur.szBurner_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 5)  );
				ReDraw();
			}
			else
			{
				m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				  
				if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_BAR_WHY+1) )
				{
					Str_Cpy(szcmb, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_BAR_WHY )) );
					i = SearchStr(szcmb, BAR_WHY );
					if (i > -1)
					{
						Str_Cpy(stMw.szBar_why, BAR_WHY[i].Code);
						Mem_Set( (byte*)stMw.szBar_gbn, 0x00, sizeof(stMw.szBar_gbn) );
						Str_Cpy(stMw.szBar_yn, "N" );
						MessageBoxEx (CONFIRM_OK, "�Ұ����� ���� ��\n[ �����Կ� ]�� �� ���ּ���.");
						
						m_lCard = 99;
						Set_Bar();
						Snd_Promise_Assign();
					}
					else
					{
						Mem_Set( (byte*)stMw.szBar_why, 0x00, sizeof(stMw.szBar_why) );
					}
					Set_BarRadio();
				}
				else if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_BAR_GBN+1) )
				{
					Str_Cpy(szcmb, EditCtrl_GetStr( Get_hDlgCtrlByID(CMB_BAR_GBN )) );
					i = SearchStr(szcmb, BARGBN );
					if (i > -1)
					{
						Str_Cpy(stMw.szBar_gbn, BARGBN[i].Code);
					}
					Set_BarRadio();
				}
			}
		}
		else
		{
			//if( m_lActiveIndex == Get_iDlgCtrlByID(CMB_INST_FIRM_NM+1) )
			//	INST_DRAW();
		}
	}
	
	void	OnExtctrl(long nEvent, long nData)
	{
		if( nEvent == EXTCTRL_LIST && theDevInfo.m_nType > FAMILY_PDA  )
		{
			OnList(nData);
		}
	}
	
	//--------------------------------------------------------------------------------------------------------
	void OnList(quad lParam)
	{
	long i;
	char szSql[150];
		
		i = lParam+1;
		if( i > 0 )
		{			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)stBur.szBoiler_inst_firm_nm, 0x00, sizeof(stBur.szBoiler_inst_firm_nm) );
			SPRINT(szSql, "SELECT WORK_FIRM FROM BO_INST WHERE ROWID = '%d'", i, 0, 0   );
			g_Sql_RetStr( szSql, 20, stBur.szBoiler_inst_firm_nm );
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_INST_FIRM_NM), stBur.szBoiler_inst_firm_nm );
			
			INST_DRAW();		//��ġ��ü ����
			ON_DRAW();
		}
		return;
	}
	
	
	void OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		long size = 0;
		
		if( INIT_MAIN == m_bFirst )
		{
			if (nEvent == UART_BARCODE)
			{
				OnBarcodeRead();
			}
			else if (nEvent == UART_CAMERA)
			{
				if(nData == 1 )
				{
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
					SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
					
					if( FFS_Exist(szfilenm) )
					{
						//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h�� ���ǵǾ�����
						//ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);	
						
						size = FFS_GetSize( szfilenm );
						
						if( size > 1048576 )
						{
							MessageBoxEx (CONFIRM_OK, "���� �뷮�� �ʰ��Ͽ����ϴ�.\nī�޶� ���� Ȥ�� ���Կ����ּ���.");
						}
						else
						{
							MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
							
							FFS_Copy(szfilenm, g_szphoto);
							
							VmSleep(100);
						}
						
						VmSleep(100);
						
						FFS_Delete( szfilenm );
						
						VmSleep(100);
						
						if( m_lPhoto_Flag == 0 )
						{
							Snd_Photo(0);
						}
						else if( m_lPhoto_Flag == 1)
						{
							Snd_Photo(1);
						}
					}
				}
			}
		}
		
		return;
	}

//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		long nRet = 0;
		long nLen = 0;
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		char* ptr;
		
		if( INIT_MAIN == m_bFirst )
		{
			if(nEvent == TASK_SYS_CALL )
			{
				if( nData == TASK_BARCODE )
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
				else if( nData == TASK_CAMERA )
				{
					//2017-07-11 Sanghyun Lee
					//���ο� ī�޶� ���� �ڵ�, ���� ���� ����
					Mem_Set((byte*)szPhotopath, 0x00, sizeof(szPhotopath));
					Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
					
					szPath = (char*)System_GetResult((char*)&nRet);
					nLen = Str_Len(szPath);
					if( nLen > 19 )
					{
						Mem_Cpy((byte *)szTmp, (byte *)szPath+19, nLen-19);
						Str_Cpy(szPhotopath, "..");
						Str_Cat(szPhotopath, szTmp);
	//					PRINT(">>> TASK_SYS_CALL:: TASK_CAMERA: path = %s, size = %d ", szPhotopath, nRet, 0);
						
						//�������� +19
						Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
						SPRINT (g_szphoto, "%s/%s", PHOTO_MW,  m_szfilenm, 0);
		
						if( FFS_Exist(szPhotopath) )
						{
							//CONVERT_WD : 384, CONVERT_HT : 512 / FileMgr.h�� ���ǵǾ�����
							//ConvertImage(JPG, szfilenm, CONVERT_WD, CONVERT_HT, g_szphoto, 60*1000);
							//ConvertImage(JPG, szfilenm, 240, 320, g_szphoto, 60*1000);
							FFS_Copy(szPhotopath, g_szphoto);
							FFS_Delete(szPhotopath);
						}
					}
	
					//ȭ�� REFRESH
					//ReDraw();
					if( m_lPhoto_Flag == 0 )
					{
						Snd_Photo(0);
					}
					else if( m_lPhoto_Flag == 1)
					{
						Snd_Photo(1);
					}
				}
			}
		}
		ON_DRAW();
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
	
	void OnBarcodeRead(void)
	{
	char szSql[300];
	char szMtridnum[22];
	char szBar[10];
	long lCnt, lRow;
	long RetFlag = -1;
	long ret = 0;
	long i = 0;

		if( Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
			// ������ 2017.07.26 Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			ret = Barcode_Read( m_szBarcode_Value );	
			if( ret < 0)
			{
				MessageBoxEx (ERROR_OK, "���ڵ� �б� ����");
				goto Finally;
			}
		}
		
		//20180711 ���ڵ� ���� ����
		Mem_Set( (byte*)stMw.szBar_gbn, 0x00, sizeof(stMw.szBar_gbn) );
		Str_Cpy(stMw.szBar_gbn, "10");
		
		if( Str_Len(m_szBarcode_Value) > 8 )
		{
			//i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BAR_GBN)), BARGBN );
			//Str_Cpy(stMw.szBar_gbn, BARGBN[i].Code);

			if( Str_Cmp( stMw.szBar_gbn,"10") == 0 )
			{
				if( Str_NCmp( stMw.szInst_place_num, m_szBarcode_Value, 9 ) == 0 )
				{
					// ������ 2017.07.26 Str_Cpy(g_szCurrBar, m_szBarcode_Value);
					stMw.szBar_yn[0] = 'Y'; // Str_Cpy(stMw.szBar_yn, "Y" );
					Mem_Set( (byte*)stMw.szBar_why, 0x00, sizeof(stMw.szBar_why) );
					m_lCard = 99;
					Set_Bar();
					Snd_Promise_Assign();
				}
				else
				{
					//2017-05-03 Sanghyun Lee
					//���ڵ� ������ �ٸ� �� �޼��� ���
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Str_Cpy(szSql, "���ڵ� ������ �����ʽ��ϴ�.\n");
					Str_Cat(szSql, m_szBarcode_Value);
					MessageBoxEx (CONFIRM_OK, szSql);
					// ������ 2017.07.26 Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
					
					//2017-07-07 Sanghyun Lee
					//���ڵ� �б⿡ ������ ��� �ʱ�ȭ �Ұ�.(����̽� �翷�� ���ڵ� ��ư ����� �Ǽ��� ������ ��찡 ����.)
					if( Str_Cmp(stMw.szBar_yn, "Y") != 0 )
					{
						stMw.szBar_yn[0] = 0; // Str_Cpy(stMw.szBar_yn, "" );
					}
				}
			}
			else
			{
				//2017-05-03 Sanghyun Lee
				//���ڵ� ������ �ٸ� �� �޼��� ���
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Str_Cpy(szSql, "���ڵ� ������ �����ʽ��ϴ�.\n");
				Str_Cat(szSql, m_szBarcode_Value);
				MessageBoxEx (CONFIRM_OK, szSql);
				// ������ 2017.07.26 Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
				
				//2017-07-07 Sanghyun Lee
				//���ڵ� �б⿡ ������ ��� �ʱ�ȭ �Ұ�.(����̽� �翷�� ���ڵ� ��ư ����� �Ǽ��� ������ ��찡 ����.)
				if( Str_Cmp(stMw.szBar_yn, "Y") != 0 )
				{
					stMw.szBar_yn[0] = 0; // Str_Cpy(stMw.szBar_yn, "" );
				}
			}
			/*
			else
			{
				//2017-08-08 Sanghyun Lee
				//���ұ� �跮���ȣ�� �ƴ� �跮���� �跮�� ��ȣ�� ���ϵ��� ����
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szMtridnum, 0x00, sizeof(szMtridnum) );
				SPRINT(szSql, "SELECT MTR_ID_NUM FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s'", g_szCHK_EXEC_NUM, 0, 0   );
				g_Sql_RetStr( szSql, 20, szMtridnum );

				//����ǰ ���ڵ�
				if( Str_NCmp(m_szBarcode_Value, "A", 1) >= 0 && Str_Cmp(m_szBarcode_Value, "READ_FAIL") != 0 )
				{
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Mem_Cpy((byte *)szSql, (byte *)m_szBarcode_Value+4, Str_Len(m_szBarcode_Value)-4);

					Mem_Set( (byte*)m_szBarcode_Value, 0x00, sizeof(m_szBarcode_Value) );
					Str_Cpy(m_szBarcode_Value, szSql);
				}

				//2017-08-08 Sanghyun Lee
				//���ұ� �跮���ȣ�� �ƴ� �跮���� �跮�� ��ȣ�� ���ϵ��� ����
				//if( Str_Cmp( stBur.szMtr_id_num,  m_szBarcode_Value ) == 0 )
				if( Str_Cmp( szMtridnum,  m_szBarcode_Value ) == 0 )
				{
					// ������ 2017.07.26 Str_Cpy(g_szCurrBar, m_szBarcode_Value);
					stMw.szBar_yn[0] = 'Y'; // Str_Cpy(stMw.szBar_yn, "Y" );
					Mem_Set( (byte*)stMw.szBar_why, 0x00, sizeof(stMw.szBar_why) );
					
					m_lCard = 99;
					Set_Bar();
					Snd_Promise_Assign();
				}
				else
				{
					//2017-05-03 Sanghyun Lee
					//���ڵ� ������ �ٸ� �� �޼��� ���
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					Str_Cpy(szSql, "���ڵ� ������ �����ʽ��ϴ�.\n");
					Str_Cat(szSql, m_szBarcode_Value);
					MessageBoxEx (CONFIRM_OK, szSql);
					// ������ 2017.07.26 Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
					
					//2017-07-07 Sanghyun Lee
					//���ڵ� �б⿡ ������ ��� �ʱ�ȭ �Ұ�.(����̽� �翷�� ���ڵ� ��ư ����� �Ǽ��� ������ ��찡 ����.)
					if( Str_Cmp(stMw.szBar_yn, "Y") != 0 )
					{
						stMw.szBar_yn[0] = 0; // Str_Cpy(stMw.szBar_yn, "" );
					}
				}
			}
			*/
			
			//ó�� �� ��ư active ctrl �̵�. 
			//-> ��ư ���� �� �ش� ��ư�� enable ó���� �Ǿ��� ��, ��Ŀ���� �״�� ������ Ŭ���Ǳ� ������ ��Ŀ�� �ٸ���ư���� �̵�.
			Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(BID_UP));
			
			ReDraw();
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "���ڵ� ���̰� ���� �ʽ��ϴ�.");

			//2017-07-07 Sanghyun Lee
			//���ڵ� �б⿡ ������ ��� �ʱ�ȭ �Ұ�.(����̽� �翷�� ���ڵ� ��ư ����� �Ǽ��� ������ ��찡 ����.)
			// ������ 2017.07.26 Mem_Set( (byte*)g_szCurrBar, 0x00, sizeof(g_szCurrBar) );
			if( Str_Cmp(stMw.szBar_yn, "Y") != 0 )
			{
				stMw.szBar_yn[0] = 0; // Str_Cpy(stMw.szBar_yn, "" );
			}
			goto Finally;
		}
		
		//ON_DRAW();
Finally:

		if( theDevInfo.m_nType > FAMILY_PDA && Str_Cmp(g_szBarcodeSet, BEAM_BARCODE) == 0 )
		{
			Barcode_Exit();
		}

		ON_DRAW();
		return;
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
			//690:����[��, ���ұ�, ��ȸ��, �Ϸ� ]
			
			if(   g_nWorkFlag == 640 || g_nWorkFlag == 690 )
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
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);
				
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
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[1]+4, highty-5, eX[1]-4, highty+5 );
			}
			else if( g_nWorkFlag == 620 )
			{
				//620:����[��, ���ұ�, ����,  ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);
					
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
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[1]+4, highty-5, eX[1]-4, highty+5 );
			}
			else if( g_nWorkFlag == 630 )
			{
				//630:����[��, ����, ����, ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);// ���ұ�
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);
					
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
			}
			else if( g_nWorkFlag == 640 )
			{
				//640:����[��, ����, ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WBUR), FALSE);// ���ұ�
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// �跮��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE); // ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);
					
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WRELE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
			}
			else if( g_nWorkFlag == 650 )
			{
				//650:��ü[��, ���ұ�, ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE); // ����
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE); // ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);
				
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
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[1]+4, highty-5, eX[1]-4, highty+5 );
			}
			else if( g_nWorkFlag == 660 )
			{
				//660:����[��, ���ұ�, ����(�跮�ⱳü), ��ȸ��, ��� ]
				//DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// �跮��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WFIN), FALSE);
				
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
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[1]+4, highty-5, eX[1]-4, highty+5 );
			}
			else if( g_nWorkFlag == 690 )
			{
				//690:����[��, ���ұ�, �Ϸ� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// �跮��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WPAY), FALSE);
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WCHK), FALSE);
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WFIN), sX[i], starty, eX[i], highty ); // �Ϸ�
			}
		}
		else
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
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE              ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MAKER_NM           ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKER_NM           ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_MODEL_NM    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_MODEL_NM    ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_INST_YMD    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_INST_YMD    ), EDITALIGN_MIDDLE);		
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_GRD            ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_GRD            ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_CAPA        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_CAPA        ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_CAPA_UNIT_NM), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INST_LOC_NM        ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INST_LOC_NM        ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BOILER_FORM_NM     ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BOILER_FORM_NM     ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BOILER_INST_FIRM_NM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BOILER_INST_FIRM_NM), EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDUC_INST_YN      ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDUC_INST_YN      ), EDITALIGN_MIDDLE);
			

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TRANS_CONN_YN      ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TRANS_CONN_YN      ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_CONN_YN            ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_CONN_YN            ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BAR_GBN            ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BAR_GBN            ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_ID_NUM         ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BAR_WHY            ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BAR_WHY            ), EDITALIGN_MIDDLE);
			
			for ( i = 0 ;  BARGBN[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BAR_GBN+2), BARGBN[i].Str, 0, ICON_NONE);
			}
			
			for ( i = 0 ;  BAR_WHY[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BAR_WHY+2), BAR_WHY[i].Str, 0, ICON_NONE);
			}
			
			//2018.04.05 �ű�ȣ CS�� ��û �跮�� ���ڵ� ����
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_GBN), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_GBN+1), FALSE);
		}
		else if( m_bFirst == INIT_BURNEW )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_NUM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_NUM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_KIND_NUM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BURNER_KIND_NUM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_ID_NUM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_MTR_ID_NUM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_MODEL_NM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_MODEL_NM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_CAPA ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_CAPA ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CAPA_UNIT_NM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MAKER_NM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_MAKER_NM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_INST_YMD ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_INST_YMD ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INST_LOC ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_INST_LOC ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BOILER_FORM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BOILER_FORM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MAKE_NUM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKE_NUM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BOILER_INST_FIRM_CD ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_INST_FIRM_NM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_REPRE_NM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REPRE_NM ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_REG_NUM1 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_REG_NUM1 ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_TEL ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TEL ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INST_FLAG ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INST_FLAG ), EDITALIGN_MIDDLE);
			
			if( m_lNewflag == 2 )
			{
				BUTSETRANGE(Get_hDlgCtrlByID(BID_NEWSAVE), STARTX+699, STARTY+SYH*6+40, STARTX+999, STARTY+SYH*6+40+SYH+19 );	
			}
			
			for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CAPA_UNIT_NM+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
			}
			
			for ( i = 0 ;  SCBOIL_FORM[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BOILER_FORM+2), SCBOIL_FORM[i].Str, 0, ICON_NONE);
			}
			
			SetCombo();
		}
		else if( m_bFirst == INIT_BURCHG )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_ID_NUM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_ID_NUM ), EDITALIGN_MIDDLE);		
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_KIND_NUM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BURNER_KIND_NUM ), EDITALIGN_MIDDLE);		
		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MAKER_NM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_MAKER_NM ), EDITALIGN_MIDDLE);		

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_MODEL_NM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_MODEL_NM ), EDITALIGN_MIDDLE);		

			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_CAPA ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_CAPA ), EDITALIGN_MIDDLE);		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_CAPA_UNIT_NM ), EDITALIGN_MIDDLE);		

 			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_INST_YMD ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_INST_YMD ), EDITALIGN_MIDDLE);		
    
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BURNER_DATA_FLAG   ), EDITALIGN_CENTER|EDITALIGN_MIDDLE); // true2k
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_BURNER_DATA_FLAG   ), EDITALIGN_CENTER|EDITALIGN_MIDDLE); // true2k	
			
  			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INST_LOC ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_INST_LOC ), EDITALIGN_MIDDLE);		
 
  			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MAKE_NUM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKE_NUM ), EDITALIGN_MIDDLE);		

  			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_BOILER_FORM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_BOILER_FORM ), EDITALIGN_MIDDLE);		
		
			if( m_lNewflag == 2 )
			{
				BUTSETRANGE(Get_hDlgCtrlByID(BID_SAVE), STARTX+730, STARTY+SYH*5+40, STARTX+999, STARTY+SYH*6+50 );	
			}

			for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_CAPA_UNIT_NM+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
			}
			
			for ( i = 0 ;  SCBOIL_FORM[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_BOILER_FORM+2), SCBOIL_FORM[i].Str, 0, ICON_NONE);
			}
			
			SetCombo();
		}
		else
		{
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BUNNER), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BOILER), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_CREATE), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_CREATE), TRUE );
		}
	}
	
	void Draw_Tb(void)
	{
	long i, idx;
	long k = ROW+1;
	long lTotPage;
	long lstartidx;
	char sztmp[100];
	char szbuf[100];
	char szSql[200];
	bool ret = TRUE;	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NULL;
	
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_PROMISE_BUR WHERE PROMISE_ASSIGN_SEQ = '%s' AND ( DATA_FLAG <> '30' OR DATA_FLAG IS NULL )  ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &m_lTotpage);
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
		
		if( m_lTotpage > 0)
		{
			SPRINT(m_szCnt_index, "%d/%d", m_lpage+1, m_lTotpage,0);
		}
		else
		{
			SPRINT(m_szCnt_index, "%d/%d", 0, 0, 0);
		}
		
		sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, " SELECT MTR_ID_NUM, BURNER_NUM, BURNER_KIND_NM, DATA_FLAG,MTR_NUM FROM C6101_PROMISE_BUR \
		 WHERE PROMISE_ASSIGN_SEQ = ? AND ( DATA_FLAG <> '30' OR DATA_FLAG IS NULL )  ORDER BY PDA_IP DESC, BURNER_NUM LIMIT ?, ? " );
		
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
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, sztmp );
				if(sztmp[0] == '1')
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "���Ϸ�" );
				else
					DlgTbl_SetStr ( ID_TBLLIST, i, 1, "���ұ�" );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 20, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				//decode(DATA_FLAG,'10','�ű�','20','����','30','����')
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 2, DECRYPT);
				if(Str_Cmp( sztmp, "10") == 0)
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "�ű�" );
				else if (Str_Cmp( sztmp, "20") == 0)
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "����" );
				else if (Str_Cmp( sztmp, "30") == 0)
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "����" );
				else 
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 15, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
				
			}
		}

Finally:
		DelSqLite(sql);
		
		if( m_lTotpage > 0 )
		{
			if(m_lActRow == -1 )
				m_lActRow = 0;
			DlgTbl_SetActive(ID_TBLLIST , m_lActRow+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActRow+1, TABLEACTIVE_COLOR);
			
			Str_Cpy( stBur.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
			Str_Cpy( stBur.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 4)  );
			Str_Cpy( stBur.szBurner_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 5)  );
		}
		else
		{
			m_lActRow = -1;
			Mem_Set((byte*)&stBur, 0x00, sizeof(stBur));
		}
		
		ON_DRAW();
				
	}
	
	
	void ReDraw(void)
	{
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NULL;
	char sztmp[32];
	long i;
	long n;
		
		if( m_bFirst == INIT_MAIN )
		{
			sql = NewSqLite();
		
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally;
			}
	
			hstmt = sql->CreateStatement(sql," select A.CIVIL_SERV_RECEIVE_NUM,A.TREAT_SEQ \
,A.INST_PLACE_NUM,A.BURNER_CLASS_CD,A.BURNER_KIND_NUM,A.BURNER_KIND_NM,A.BURNER_MODEL_CD \
,A.BURNER_CAPA,A.BURNER_CAPA_UNIT,A.BURNER_CAPA_UNIT_NM,A.BURNER_INST_YMD,A.BURNER_REMOV_YMD \
,A.BURNER_MODEL_NM,A.BURNER_QTY,A.MAKER_NM,A.BOILER_FORM,A.BOILER_FORM_NM \
,A.MAKE_NUM,A.MAKE_YMD,A.WORK_DOCU_RECEIVE_YMD,A.INST_FLAG,A.INST_LOC \
,A.INST_LOC_NM,A.BOILER_INST_FIRM_CD,A.BOILER_INST_FIRM_NM,A.DATA_FLAG,A.MTR_ID_NUM \
,A.SEND_YN,A.MAKER_NUM, B.MTR_GRD, A.INDUCTION_INST_YN, A.SPECIAL_YN from C6101_PROMISE_BUR A, C6101_PROMISE_MTR B \
where A.PROMISE_ASSIGN_SEQ = ? and  A.MTR_NUM = ? and  A.BURNER_NUM = ? AND A.MTR_NUM = B.MTR_NUM ");
			
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
	
			i = 0;
		
			sql->Bind(sql, i++, 'U', (long*)stBur.szPromise_assign_seq , 10, DECRYPT);
			sql->Bind(sql, i++, 'U', (long*)stBur.szMtr_num , 10, DECRYPT);
			sql->Bind(sql, i++, 'U', (long*)stBur.szBurner_num , 10, DECRYPT);
	
			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			if(sql->Next(sql) == TRUE )
			{	
				i = 0;
				sql->GetValue( sql, i++, 'U', (long*) stBur.szCivil_serv_receive_num,2 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szTreat_seq             ,10+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szInst_place_num        ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_class_cd       ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_kind_num       ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_kind_nm        ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_model_cd       ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_capa           ,10+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_capa_unit      ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_capa_unit_nm   ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_inst_ymd       ,8 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_remov_ymd      ,8 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_model_nm       ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBurner_qty            ,10+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szMaker_nm              ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBoiler_form           ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBoiler_form_nm        ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szMake_num              ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szMake_ymd              ,8 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szWork_docu_receive_ymd ,8 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szInst_flag             ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szInst_loc              ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szInst_loc_nm           ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBoiler_inst_firm_cd   ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szBoiler_inst_firm_nm   ,20+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szData_flag             ,2 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szMtr_id_num            ,15+1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szSend_yn               ,1 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szMaker_num             ,5 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szMtr_grd               ,8 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szInduc_inst_yn      	,1 +1, DECRYPT );
				sql->GetValue( sql, i++, 'U', (long*) stBur.szSpecial_yn         	,1 +1, DECRYPT );
		
			}
			else
			{
				PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
				goto Finally;
			}
	
	Finally:
	//		sql->Commit(sql);
			DelSqLite(sql);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MAKER_NM ), stBur.szMaker_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BURNER_MODEL_NM ), stBur.szBurner_model_nm);
			g_Str_DateType(sztmp, stBur.szBurner_inst_ymd);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BURNER_INST_YMD ), sztmp);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_GRD ), stBur.szMtr_grd);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BURNER_CAPA ), stBur.szBurner_capa);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BURNER_CAPA_UNIT_NM ), stBur.szBurner_capa_unit_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INST_LOC_NM ), stBur.szInst_loc_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BOILER_FORM_NM ), stBur.szBoiler_form_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BOILER_INST_FIRM_NM ), stBur.szBoiler_inst_firm_nm);
			
			if( Str_Cmp( stBur.szSpecial_yn, "Y") == 0 )
			{
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_NEW), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CHG), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_DEL), FALSE);
			}
			
			

			if( Str_Cmp( stBur.szBurner_kind_num, "201") == 0  || Str_Cmp( stBur.szBurner_kind_num, "301") == 0  )
				m_lNewflag = 1;
			else
				m_lNewflag = 2;
				
			Set_BarRadio();
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BOILER_INST_FIRM_NM ), stBur.szBoiler_inst_firm_nm);

			// �δ��� ��ġ ����	
			// PRINT("222222222stBur.szInduc_inst_yn %s",stBur.szInduc_inst_yn,0,0);
			if( stBur.szInduc_inst_yn[0] == 'Y' )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_N), CHK_N1);
			}
			else if( stBur.szInduc_inst_yn[0] == 'N' )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_N), CHK_N2);
			}
			// else
			// {
			// 	ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_Y), CHK_Y1);
			// 	ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_N), CHK_N1);
			// }

			if( Str_Cmp( stBur.szSpecial_yn, "Y") == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "Ư�����ü��Դϴ�. \n ���ұ� ���������� Ư������ڿ��� �����ϼ���.");
			}
				
		}
		else if( m_bFirst == INIT_BURNEW )
		{
			if( m_lNewflag != 1)
			{

				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_INST_LOC), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_INST_LOC), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_INST_LOC+1), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BOILER_FORM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BOILER_FORM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BOILER_FORM+1), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_MAKE_NUM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MAKE_NUM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_MAKE_NUM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BOILER_INST_FIRM_CD), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_INST_FIRM_NM), FALSE);
//				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_INST_FIRM_NM+1), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BOILER_INST_FIRM_CD), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_REPRE_NM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_REPRE_NM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_REG_NUM1), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_REG_NUM1), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_TEL), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_TEL), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_INST_FLAG), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_INST_FLAG), FALSE);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TITLE ), "���ұ� �ű� ȭ��");
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TITLE ), "���Ϸ� �ű� ȭ��");
			}
			EditCtrl_SetStr( Get_hDlgCtrlByID( CMB_MTR_ID_NUM ), ListCtrl_GetStr (Get_hDlgCtrlByID(CMB_MTR_ID_NUM+2), 0) );
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			Str_ItoA(Time_GetDate(), stBur.szBurner_inst_ymd,10);
			g_Str_DateType(sztmp, stBur.szBurner_inst_ymd);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BURNER_INST_YMD ), sztmp);
			
		}
		else if( m_bFirst == INIT_BURCHG )
		{
			if( m_lNewflag != 1 )
			{
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_INST_LOC), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_INST_LOC), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_INST_LOC+1), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_MAKE_NUM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MAKE_NUM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_MAKE_NUM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BOILER_FORM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BOILER_FORM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BOILER_FORM+1), FALSE);
				
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TITLE ), "���ұ� ���� ȭ��");
			}
			else
			{
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TITLE ), "���Ϸ� ���� ȭ��");
			}
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_MAKER_NM ), stBur.szMaker_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_ID_NUM ), stBur.szMtr_id_num);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_BURNER_KIND_NUM ), stBur.szBurner_kind_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BURNER_MODEL_NM ), stBur.szBurner_model_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BURNER_CAPA ), stBur.szBurner_capa);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_CAPA_UNIT_NM ), stBur.szBurner_capa_unit_nm);
			
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			//if( Str_Len(stBur.szBurner_inst_ymd) == 0 )
			Str_ItoA( Time_GetDate(), stBur.szBurner_inst_ymd, 10);			
			g_Str_DateType(sztmp, stBur.szBurner_inst_ymd);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_BURNER_INST_YMD ), sztmp);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_INST_LOC ), stBur.szInst_loc_nm);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MAKE_NUM ), stBur.szMake_num);
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_BOILER_FORM ), stBur.szBoiler_form_nm);
				
			// true2k stBur.szData_flag ('10','�ű�','20','����','30','����')
			if(Str_Cmp( stBur.szData_flag, "10") == 0)
				EditCtrl_SetStr ( Get_hDlgCtrlByID(TXT_BURNER_DATA_FLAG), "�ű�" );
			else if (Str_Cmp( stBur.szData_flag, "20") == 0)
				EditCtrl_SetStr ( Get_hDlgCtrlByID(TXT_BURNER_DATA_FLAG), "����" );
			else if (Str_Cmp( stBur.szData_flag, "30") == 0)
				EditCtrl_SetStr ( Get_hDlgCtrlByID(TXT_BURNER_DATA_FLAG), "����" );
			else 
				EditCtrl_SetStr ( Get_hDlgCtrlByID(TXT_BURNER_DATA_FLAG), "" );
		}
		
//PRINT("promise_assign_seq=[%s],stMw.szUse_cont_num=[%s],stMw.szCivil_serv_receive_num=[%s]", g_szCHK_EXEC_NUM, stMw.szUse_cont_num, stMw.szCivil_serv_receive_num);
//PRINT("stMw.szTrans_conn_yn=[%s],stMw.szConn_yn=[%s],stMw.szBar_yn=[%s]", stMw.szTrans_conn_yn ,stMw.szConn_yn, stMw.szBar_yn);
//PRINT("stMw.szBar_gbn=[%s],stMw.szBar_why=[%s],stMw.szConn_gbn=[%s]", stMw.szBar_gbn, stMw.szBar_why, stMw.szConn_gbn);

		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : Set_BarRadio
	��  �� : ���ڵ�, �Ұ�����, ���� ��ư SETTING
	Param  : 
	Return : 
	========================================================================================*/
	void Set_BarRadio(void)
	{
		long n;
		char szFilenm[256];
		char * sqlstr = "";	
		
		handle* hsql;
		
		/*********************************************/
		/* �δ��� ��ġ ����                          */
		/*********************************************/
		if( stBur.szInduc_inst_yn[0] == 'Y' )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_Y), CHK_Y2);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_N), CHK_N1);				
		}
		else if( stBur.szInduc_inst_yn[0] == 'N' )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_Y), CHK_Y1);
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_INDUC_INST_N), CHK_N2);				
		}

		/*********************************************/
		/* ����, ���� Ȯ��                           */
		/*********************************************/
		// ���Կ��� �� ���˿��� ���� ��Ʈ�� ��� �Ⱥ���, ���ڵ� ��ĵ ���úκи� ����, ���� ��ư�� ��� Ȱ��ȭ
		if(g_nWorkFlag == 620 || g_nWorkFlag == 690)
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_TRANS_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_TRANS_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_CONN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_CONN_N), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_N), FALSE);
			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_TRANS_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_G_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_G_CONNGBN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONN_N), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_N), FALSE);
			
			// 20181210 CS�� �ڼ��� ����� ��û : ����, ����Ȯ�ν� �跮��, �ش����� ���� �׻� �Կ� �����ϵ���
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), BTNCTRLBKCOLOR);
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), BTNCTRLBKCOLOR);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), TRUE);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), TRUE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), FALSE );
		}
		
		/*********************************************/
		/* ���Խð�                                  */
		/*********************************************/
		else if(Str_Cmp( stMw.szCivil_serv_class_cd , "060103") == 0)
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONN_N), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_N), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_G_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_G_CONNGBN_YN), FALSE);
			
			/* ������� */
			if(stUserinfo.szcenter_cd[0] == '4' )
			{
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_TRANS_CONN_YN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_TRANS_CONN_YN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_CONN_Y), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_CONN_N), FALSE);
			}
			/* �������� */
			else
			{
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_TRANS_CONN_YN), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_TRANS_CONN_YN), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_CONN_Y), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_CONN_N), TRUE);
			}

			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_GBN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MTR_ID_NUM), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_WHY), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), FALSE);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TTL_CONN_YN ), "���˿���");
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_CONN_YN), TRUE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_CONN_YN), TRUE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_Y), TRUE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_N), TRUE);
						
			if( stMw.szTrans_conn_yn[0] == 'Y' )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_TRANS_CONN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_TRANS_CONN_N), CHK_N1);
				
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_Y), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_N), TRUE);
			
			}
			else if( stMw.szTrans_conn_yn[0] == 'N' )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_TRANS_CONN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_TRANS_CONN_N), CHK_N2);
				
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_CONN_YN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_CONN_YN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_Y), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_N), FALSE);
				Mem_Set( (byte*)stMw.szChk_yn, 0x00, sizeof(stMw.szChk_yn) );
			}
			else
			{
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_CONN_YN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_CONN_YN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_Y), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_N), FALSE);
				Mem_Set( (byte*)stMw.szChk_yn, 0x00, sizeof(stMw.szChk_yn) );
			}
			
			if( stMw.szChk_yn[0] == 'Y' )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_N), CHK_N1);
			}
			else if( stMw.szChk_yn[0] == 'N' )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_N), CHK_N2);
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_N), CHK_N1);
			}
		}
		
		/*********************************************/
		/* �������                                  */
		/*********************************************/
		else if(stUserinfo.szcenter_cd[0] == '4' )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TTL_TRANS_CONN_YN ), "����ο�");
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_TRANS_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_CONN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_TRANS_CONN_N), FALSE);
			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_N), FALSE);
			
			if( stMw.szConn_yn[0] == 'Y' )
			{
				stMw.szTrans_conn_yn[0] = 'N';
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONN_N), CHK_N1);
				
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_G_CONNGBN_YN), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_Y), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_N), TRUE);
				
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_GBN), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MTR_ID_NUM), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_WHY), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), TRUE);	
			}
			else 
			{
				stMw.szTrans_conn_yn[0] = 'N';
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONN_Y), CHK_Y1);
				
				if( stMw.szConn_yn[0] == 'N' )
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONN_N), CHK_N2);
				}
				else
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONN_N), CHK_N1);
				}
				
				Mem_Set((byte*)stMw.szConn_gbn, 0x00, sizeof(stMw.szConn_gbn) );
					
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_G_CONNGBN_YN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_Y), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_N), FALSE);
				
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_GBN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MTR_ID_NUM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_WHY), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), FALSE);
				
				Mem_Set((byte*)szFilenm, 0x00, sizeof(szFilenm));
				SPRINT (szFilenm, "%s/%sM.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);
				if( FFS_Exist(szFilenm) > 0 )
				{
					FFS_Delete(szFilenm);	
				}

				Mem_Set((byte*)szFilenm, 0x00, sizeof(szFilenm));
				SPRINT (szFilenm, "%s/%sP.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);
				if( FFS_Exist(szFilenm) > 0 )
				{
					FFS_Delete(szFilenm);
				}
				
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), BTNCTRLBKCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), BTNCTRLBKCOLOR);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), FALSE);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), FALSE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), TRUE );

				// 2017-08-07 Sanghyun Lee
				// ����ο�,���Կ��� ���� ����
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), FALSE );
				
				Mem_Set( (byte*)stMw.szBar_why, 0x00, sizeof(stMw.szBar_why) );
				Mem_Set( (byte*)stMw.szBar_gbn, 0x00, sizeof(stMw.szBar_gbn) );
				Mem_Set( (byte*)stMw.szBar_yn, 0x00, sizeof(stMw.szBar_yn) );
				Str_Cpy(stMw.szBar_yn, "N");
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_ID_NUM ), "");
			}
			
			if(Str_Cmp(stMw.szConn_gbn, "10") ==0  )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONNGBN_Y), CONGBN_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONNGBN_N), CONGBN_N1);
				
			}
			else if(Str_Cmp(stMw.szConn_gbn, "60") ==0  )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONNGBN_Y), CONGBN_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONNGBN_N), CONGBN_N2);
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONNGBN_Y), CONGBN_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_G_CONNGBN_N), CONGBN_N1);			
			}
			
			//2017-08-07 Sanghyun Lee
			//����ο�,���Կ��� ���� ����
			if( stMw.szConn_yn[0] == 'N' )
			{
				ON_DRAW();
				return;
			}
		}
		/*********************************************/
		/* ��������( ������� �� )                   */
		/*********************************************/
		else
		{
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_G_CONN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONN_N), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_G_CONNGBN_YN), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_Y), FALSE);
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_G_CONNGBN_N), FALSE);
			
			if( stMw.szTrans_conn_yn[0] == 'Y' )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_TRANS_CONN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_TRANS_CONN_N), CHK_N1);

				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_CONN_YN), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_CONN_YN), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_Y), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_N), TRUE);	
				
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_GBN), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MTR_ID_NUM), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_WHY), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), TRUE);			
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_TRANS_CONN_Y), CHK_Y1);
				
				if( stMw.szTrans_conn_yn[0] == 'N' )
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_TRANS_CONN_N), CHK_N2);
				}
				else
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_TRANS_CONN_N), CHK_N1);
				}

				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_CONN_YN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_CONN_YN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_Y), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_CONN_N), FALSE);
				
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_GBN), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MTR_ID_NUM), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TTL_BAR_WHY), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), FALSE);
				
				//2017-08-07 Sanghyun Lee
				//����ο�,���Կ��� ���� ����
				Mem_Set((byte*)szFilenm, 0x00, sizeof(szFilenm));
				SPRINT (szFilenm, "%s/%sM.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);
				if( FFS_Exist(szFilenm) > 0 )
				{
					FFS_Delete(szFilenm);
				}

				Mem_Set((byte*)szFilenm, 0x00, sizeof(szFilenm));
				SPRINT (szFilenm, "%s/%sP.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);
				if( FFS_Exist(szFilenm) > 0 )
				{
					FFS_Delete(szFilenm); 
				}
				
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), BTNCTRLBKCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), BTNCTRLBKCOLOR);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), FALSE);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), FALSE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), TRUE );

				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), FALSE );
				
				Mem_Set((byte*)stMw.szConn_yn, 0x00, sizeof(stMw.szConn_yn) );
				Mem_Set( (byte*)stMw.szBar_why, 0x00, sizeof(stMw.szBar_why) );
				Mem_Set( (byte*)stMw.szBar_gbn, 0x00, sizeof(stMw.szBar_gbn) );
				Mem_Set( (byte*)stMw.szBar_yn, 0x00, sizeof(stMw.szBar_yn) );
				Str_Cpy(stMw.szBar_yn, "N");
				EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_ID_NUM ), "");
			}
			
			if( stMw.szConn_yn[0]  == 'Y' )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_Y), CHK_Y2);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_N), CHK_N1);
			}
			else if( stMw.szConn_yn[0]  == 'N' )
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_N), CHK_N2);				
			}
			else
			{
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_Y), CHK_Y1);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_CONN_N), CHK_N1);
			}
			
			//2017-08-07 Sanghyun Lee
			//����ο�,���Կ��� ���� ����
			if( stMw.szTrans_conn_yn[0] == 'N' )
			{
				ON_DRAW();
				return;
			}			
		}
		
		/*********************************************/
		/* ���ڵ� �ν� ������ ���                   */
		/*********************************************/
		if(stMw.szBar_yn[0] == 'Y' )
		{
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), TRUE );
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), TRUE);
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), TRUE );
			
			// 20181210 CS�� �ڼ��� ����� ��û : ����, ����Ȯ�ν� �跮��, �ش����� ���� �׻� �Կ� �����ϵ���
			if(g_nWorkFlag == 620 || g_nWorkFlag == 690)
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), BTNCTRLBKCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), BTNCTRLBKCOLOR);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), TRUE);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), TRUE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), FALSE );	
			}
			else
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), BTNCTRLBKCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), BTNCTRLBKCOLOR);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), FALSE);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), FALSE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), TRUE );
			}
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), TRUE );
			
			if( DlgCtrl_IsVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE) ) == FALSE )
			{
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE ); 	
			}
			
			n = SearchCD( stMw.szBar_gbn, BARGBN );
			if( n > -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BAR_GBN), BARGBN[n].Str);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BAR_GBN), BARGBN[0].Str);
			}
		
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BAR_WHY), "");
			
			//2017-05-04 Sanghyun Lee
			//���ڵ� ���� �ƴ� �ؽ�Ʈ�� �Ѹ����� ����
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_ID_NUM ), "���ڵ� �νĿϷ�");
		}
		/*********************************************/
		/* ���ڵ� �ν� ������ ���                   */
		/*********************************************/
		else
		{	
			n = SearchCD( stMw.szBar_why, BAR_WHY );
			if( n >= 0 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BAR_WHY), BAR_WHY[n].Str);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BAR_WHY), "");
			}
			
			DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), TRUE);
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BAR_WHY), FALSE );
			
			/* �Ұ������� �ִ� ��� */
			if( Str_Len( stMw.szBar_why ) > 0)
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), BTNCTRLBKCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), BTNCTRLBKCOLOR);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), TRUE);
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), TRUE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), FALSE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), TRUE );
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BAR_GBN), "");	
			}
			/* �Ұ������� ���� ��� */
			else
			{
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), TRUE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE );
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_BAR_WHY+1), TRUE);
				
				// 20181210 CS�� �ڼ��� ����� ��û : ����, ����Ȯ�ν� �跮��, �ش����� ���� �׻� �Կ� �����ϵ���
				if(g_nWorkFlag == 620 || g_nWorkFlag == 690)
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), BTNCTRLBKCOLOR);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), BTNCTRLBKCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), TRUE);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), TRUE);
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), FALSE );	
				}
				else
				{
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), BTNCTRLBKCOLOR);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), BTNCTRLBKCOLOR);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), FALSE);
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), FALSE);
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_MTR), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO_POS), TRUE );
				}
				
				n = SearchCD( stMw.szBar_gbn, BARGBN );
				if( n > -1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BAR_GBN), BARGBN[n].Str);		
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_BAR_GBN), BARGBN[0].Str);		
				}
			}
			
			if( DlgCtrl_IsVisible( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE) ) == FALSE )
			{
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_BARCODE), FALSE ); 	
			}
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_ID_NUM ), "");
		}
		
		/*********************************************/
		/* ���� ���� ����                            */
		/*********************************************/
		SPRINT (g_szphoto, "%s/%sM.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);
		// �������� �˻�
		if( Str_Cmp( stMw.szMtr_Photo_yn, "Y" ) == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), RED);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_MTR), BTNCTRLBKCOLOR);
		}
		
		SPRINT (g_szphoto, "%s/%sP.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);	
		if( Str_Cmp( stMw.szPlace_Photo_yn, "Y" ) == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), RED);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO_POS), BTNCTRLBKCOLOR);
		}
		
		ON_DRAW();
		return;
	}
	
	void Set_Bar(void)
	{
	handle* hsql;
	char * sqlstr = "";	
	
		hsql = STRING_Create(sqlstr);
		STRING_Empty(hsql);
		STRING_Append(hsql," UPDATE C6101_PROMISE_ASSIGN SET ");
		STRING_Append(hsql," TRANS_CONN_YN =  '");
		STRING_Append(hsql,  stMw.szTrans_conn_yn );
		STRING_Append(hsql,"' ,CONN_YN ='");
		STRING_Append(hsql,  stMw.szConn_yn);
		STRING_Append(hsql,"' ,BAR_YN = '");
		STRING_Append(hsql,  stMw.szBar_yn);
		STRING_Append(hsql,"' ,BAR_GBN = '");
		STRING_Append(hsql,  stMw.szBar_gbn);
		STRING_Append(hsql,"' ,BAR_WHY = '");
		STRING_Append(hsql,  stMw.szBar_why);
		STRING_Append(hsql,"' ,CONN_GBN = '");
		STRING_Append(hsql,  stMw.szConn_gbn);
		STRING_Append(hsql,"' WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(hsql,  g_szCHK_EXEC_NUM);
		STRING_Append(hsql,"' AND (BAR_YN <> 'Y' OR BAR_YN IS NULL) ");		
		sqlstr = STRING_toString(hsql);
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(hsql);		
	}
	
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
		if( m_bFirst == INIT_BURNEW )
		{
		
			if(m_lNewflag == 1)//���Ϸ�1, ���ұ�2
				SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM IN (201, 301) ", 0, 0, 0);
			else
				SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM <> '201' AND BURNER_KIND_NUM <> '301'  ORDER BY (CASE WHEN BURNER_CLASS_CD ='30' THEN 1 ELSE 2 END) ", 0, 0, 0);
			Sql_SetCombo(szSql, CMB_BURNER_KIND_NUM+2);
			
			//���Ϸ� ��ġ��ġ
			if(m_lNewflag == 1)
			{
				SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30028' ", 0, 0, 0);
				Sql_SetCombo(szSql, CMB_INST_LOC+2);
			}
			
			if(m_lNewflag == 1)//���Ϸ�1, ���ұ�2
				SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BOILER_SEQ ", 0 , 0, 0);
			else
				SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BURNER_SEQ ", 0 , 0, 0);
			Sql_SetCombo(szSql, CMB_MAKER_NM+2);
			
			SPRINT(szSql, "select MTR_ID_NUM  from C6101_PROMISE_MTR where PROMISE_ASSIGN_SEQ = '%s'  ", g_szCHK_EXEC_NUM, 0, 0);			
			Sql_SetCombo(szSql, CMB_MTR_ID_NUM+2);
			
			//SPRINT(szSql, "SELECT WORK_FIRM FROM BO_INST  ", 0, 0, 0);			
			//Sql_SetCombo(szSql, CMB_INST_FIRM_NM+2);

		}
		else if( m_bFirst == INIT_BURCHG )
		{
			if(m_lNewflag == 1)//���Ϸ�1, ���ұ�2
				SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM IN (201, 301) ", 0, 0, 0);
			else
				SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM <> '201' AND BURNER_KIND_NUM <> '301'  ORDER BY (CASE WHEN BURNER_CLASS_CD ='30' THEN 1 ELSE 2 END)  ", 0, 0, 0);
			Sql_SetCombo(szSql, CMB_BURNER_KIND_NUM+2);
			
			//���Ϸ� ��ġ��ġ
			if(m_lNewflag == 1)
			{
				SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30028' ", 0, 0, 0);
				Sql_SetCombo(szSql, CMB_INST_LOC+2);
			}
			
			if(m_lNewflag == 1)//���Ϸ�1, ���ұ�2
				SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BOILER_SEQ ", 0 , 0, 0);
			else
				SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BURNER_SEQ ", 0 , 0, 0);
			Sql_SetCombo(szSql, CMB_MAKER_NM+2);
		}
		
Finally:
		if(m_sql != NULL)
			m_sql->Commit(m_sql);
		
		DelSqLite(m_sql);
		return;
	}
	
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
	
	void Save_Del(void)
	{
	char szSql[300];
	char sztmp[10];
	long idx;
	handle hdb = NULL;
	handle hstmt = NULL;

		if( Str_Cmp(stBur.szData_flag, "10") != 0 )
		{
			SQLITE sql = NewSqLite();
			//��ġ����  > ����(3)�� �۾Ƴ��� , decode(CHG_FLAG,'1','�ű�','2','����','3','����')
			Str_Cpy(stBur.szData_flag, "30" );
			Str_Cpy(stBur.szInst_flag, "30" );
			Str_Cpy(stBur.szSend_yn, "S" );
			
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally;
			}
			
			hstmt = sql->CreateStatement(sql, "UPDATE C6101_PROMISE_BUR SET \
DATA_FLAG = ?, INST_FLAG = ?, SEND_YN = ?, BURNER_REMOV_YMD=? \
WHERE PROMISE_ASSIGN_SEQ =?  AND BURNER_NUM = ? AND MTR_NUM = ? " );
			idx = 0;
			sql->Bind(sql, idx++, 'U', (long *)stBur.szData_flag	     ,2	 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBur.szInst_flag         ,2	 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBur.szSend_yn	         ,1	 ,DECRYPT);
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			Str_ItoA(Time_GetDate(), sztmp, 10);
			sql->Bind(sql, idx++, 'U', (long *)sztmp	             ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM      ,10 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBur.szBurner_num    ,6	 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stBur.szMtr_num       ,9 ,DECRYPT);

			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
	Finally:
			//sql->Commit(sql);
			DelSqLite(sql);
			stMw.szBur_yn[0] = 'Y';
		}
		else
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM C6101_PROMISE_BUR WHERE PROMISE_ASSIGN_SEQ ='%s' AND BURNER_NUM = '%s' AND MTR_NUM = '%s' "
			, g_szCHK_EXEC_NUM, stBur.szBurner_num, stBur.szMtr_num);
			g_Sql_DirectExecute( szSql );
		}
		
		//2017-05-03 Sanghyun Lee
		//���� �� ���̺� ROW ù��°�� �̵�.
		m_lpage = 0;
		
		MessageBoxEx (CONFIRM_OK, "�����Ǿ����ϴ�!");
		m_lActRow = 0;
		Draw_Tb();
		ReDraw();
		
		if( g_nWorkFlag == 610 )
		{
			Find_Burner_Class_Cd(1);
		}
		
		
		return;
	}
	
	void Save_Chg(void)
	{
	char szSql[300];
	long idx, i;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	long nLen = 0;
		
		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MAKE_NUM)));
		if( nLen > 30 )
		{
			MessageBoxEx (ERROR_OK, "������ȣ�� �ʹ� ��ϴ�. �ٽ� Ȯ���ϼ���.");
			return;
		}
		
		Mem_Set( (byte*)stBur.szBurner_model_nm, 0x00, sizeof(stBur.szBurner_model_nm) );
		Mem_Set( (byte*)stBur.szBurner_capa, 0x00, sizeof(stBur.szBurner_capa) );
		Mem_Set( (byte*)stBur.szBurner_capa_unit_nm, 0x00, sizeof(stBur.szBurner_capa_unit_nm) );
		Mem_Set( (byte*)stBur.szMaker_nm, 0x00, sizeof(stBur.szMaker_nm) );
		Mem_Set( (byte*)stBur.szBurner_kind_nm, 0x00, sizeof(stBur.szBurner_kind_nm) );
		Mem_Set( (byte*)stBur.szInst_loc_nm, 0x00, sizeof(stBur.szInst_loc_nm) );
		Mem_Set( (byte*)stBur.szMake_num, 0x00, sizeof(stBur.szMake_num) );
		Mem_Set( (byte*)stBur.szBoiler_form_nm, 0x00, sizeof(stBur.szBoiler_form_nm) );
		
		Str_Cpy(stBur.szBurner_model_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BURNER_MODEL_NM)));
		Str_Cpy(stBur.szBurner_capa, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BURNER_CAPA)));
		Str_Cpy(stBur.szBurner_capa_unit_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CAPA_UNIT_NM)));
		Str_Cpy(stBur.szMaker_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_MAKER_NM)));
		Str_Cpy(stBur.szBurner_kind_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BURNER_KIND_NUM)));
		Str_Cpy(stBur.szInst_loc_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_INST_LOC)));
		Str_Cpy(stBur.szMake_num, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MAKE_NUM)));
		Str_Cpy(stBur.szBoiler_form_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BOILER_FORM)));
		
		//����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT BURNER_KIND_NUM FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stBur.szBurner_kind_nm, 0, 0   );
		g_Sql_RetStr( szSql, 5, stBur.szBurner_kind_num );

		SPRINT(szSql, "SELECT BURNER_CLASS_CD FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stBur.szBurner_kind_nm, 0, 0   );
		g_Sql_RetStr( szSql, 2, stBur.szBurner_class_cd );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MAKER_NUM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NM = '%s' ", stBur.szMaker_nm, 0, 0   );
		g_Sql_RetStr( szSql, 5, stBur.szMaker_num );

		//���Ϸ� ��ġ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30028' AND ITEM_KNAME = '%s' ", stBur.szInst_loc_nm, 0, 0   );
		g_Sql_RetStr( szSql, 2, stBur.szInst_loc );

		//����
		i = SearchStr( stBur.szBurner_capa_unit_nm, SCBOIL_CAPA );
		if (i > -1)
		{
			Str_Cpy(stBur.szBurner_capa_unit, SCBOIL_CAPA[i].Code);
		}

		//�����ڵ�
		i = SearchStr( stBur.szBoiler_form_nm, SCBOIL_FORM );
		if (i > -1)
		{
			Str_Cpy(stBur.szBoiler_form, SCBOIL_FORM[i].Code);
		}
		
		//��ġ����  > ����(3)�� �۾Ƴ��� , decode(CHG_FLAG,'1','�ű�','2','����','3','����')
		if(Str_Cmp(stBur.szData_flag, "10") != 0  )
		{
			Str_Cpy(stBur.szData_flag, "20" );
			Str_Cpy(stBur.szInst_flag, "20" );
		}
		
		Str_Cpy(stBur.szSend_yn, "S" );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "UPDATE C6101_PROMISE_BUR SET \
BURNER_CLASS_CD=?,BURNER_KIND_NUM=?,BURNER_KIND_NM=?,BURNER_MODEL_CD=?,BURNER_CAPA=?,\
BURNER_CAPA_UNIT=?,BURNER_CAPA_UNIT_NM=?,BURNER_INST_YMD=?,BURNER_REMOV_YMD='',BURNER_MODEL_NM=?,\
BURNER_QTY=?,MAKER_NM=?,BOILER_FORM=?,BOILER_FORM_NM=?,MAKER_NUM=?,MAKE_NUM=?,MAKE_YMD=?,\
WORK_DOCU_RECEIVE_YMD=?,INST_LOC=?,INST_LOC_NM=?,BOILER_INST_FIRM_CD=?,BOILER_INST_FIRM_NM=?,\
DATA_FLAG = ?, INST_FLAG = ?, SEND_YN = ? \
WHERE PROMISE_ASSIGN_SEQ =?  AND BURNER_NUM = ? AND MTR_NUM = ? " );
		idx = 0;
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_class_cd       ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_kind_num       ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_kind_nm        ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_model_cd       ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_capa           ,10+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_capa_unit      ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_capa_unit_nm   ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_inst_ymd       ,8 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_model_nm       ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_qty            ,10+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szMaker_nm              ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBoiler_form           ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBoiler_form_nm        ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szMaker_num             ,5 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szMake_num              ,30+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szMake_ymd              ,8 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szWork_docu_receive_ymd ,8 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szInst_loc              ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szInst_loc_nm           ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBoiler_inst_firm_cd   ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBoiler_inst_firm_nm   ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)stBur.szData_flag	          ,2   , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)stBur.szInst_flag             ,2   , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)stBur.szSend_yn	              ,1   , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM              ,12  , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)stBur.szBurner_num            ,6   , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)stBur.szMtr_num               ,9   , DECRYPT );

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		stMw.szBur_yn[0] = 'Y';
		
		MessageBoxEx (CONFIRM_OK, "�����Ǿ����ϴ�!");
		
		if( g_nWorkFlag == 610 )
		{
			Find_Burner_Class_Cd(0);
		}
		else
		{
			ON_EXIT();
			OnInit(INIT_MAIN);
		}
	}
	
	void INST_DRAW(void)
	{
		long i, idx;
		char sztmp[300];
		char szSql[300];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)stBur.szBoiler_inst_firm_nm, 0x00, sizeof(stBur.szBoiler_inst_firm_nm));
		Str_Cpy(stBur.szBoiler_inst_firm_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_INST_FIRM_NM)));
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		//BURNER_KIND_NUM = 201 || 301 �̸� ���Ϸ�, �������� ���ұ�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT boiler_inst_firm_cd, REPRE_NM, REG_NUM1, WORK_FIRM_TEL_DDD||'-'||WORK_FIRM_TEL_EXN||'-'||WORK_FIRM_TEL_NUM \
		FROM BO_INST WHERE WORK_FIRM = ?  "
		, 0, 0, 0);
		hstmt = sql->CreateStatement(sql, szSql);

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)stBur.szBoiler_inst_firm_nm, 20, DECRYPT);
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{
			idx = 0;
			//��ġ��ü�ڵ�
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 20+ 1, DECRYPT );
			//EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_REPRE_NM)   , sztmp);
			
			Mem_Set((byte*)stBur.szBoiler_inst_firm_cd, 0x00, sizeof(stBur.szBoiler_inst_firm_cd));
			Str_Cpy(stBur.szBoiler_inst_firm_cd, sztmp);
			//PRINT("C6101_WBUR INST_DRAW sztmp:[%s], stBur.szBoiler_inst_firm_cd:[%s]", sztmp, stBur.szBoiler_inst_firm_cd, 0);
			
			//��ǥ�ڸ�
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 30+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_REPRE_NM)   , sztmp);
			
			//�����ȣ
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp       , 15+ 1, DECRYPT );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_REG_NUM1)   , sztmp);
			
			//��ȭ_1
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) sztmp      , 12+1, DECRYPT );	
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_TEL)   , sztmp);
				
		}
	
Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
		return;
	}
	
	void Save_New(void)
	{
	char szSql[300];
	long idx, i;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NULL;
	long nLen = 0;
		
		if(  EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_BURNER_KIND_NUM)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "���ұ� ������ �������ּ���.");
			return;
		}
		
		if(  EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_MAKER_NM)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "���ұ� �����縦 �������ּ���.");
			return;
		}
		
		if(  EditCtrl_GetStrLen(Get_hDlgCtrlByID(TXT_BURNER_CAPA)) == 0 )
		{
			MessageBoxEx (ERROR_OK, "�뷮�� �Է��� �ּ���.");
			return;
		}
		
		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MAKE_NUM)));
		if( nLen > 30 )
		{
			MessageBoxEx (ERROR_OK, "������ȣ�� �ʹ� ��ϴ�. �ٽ� Ȯ���ϼ���.");
			return;
		}
		
		
		if( m_lNewflag == 1 )
		{
			if(  EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_BOILER_FORM)) == 0 )
			{
				MessageBoxEx (ERROR_OK, "���ұ� ������ ������ �ּ���.");
				return;
			}
			
			if(  EditCtrl_GetStrLen(Get_hDlgCtrlByID(CMB_INST_LOC)) == 0 )
			{
				MessageBoxEx (ERROR_OK, "���ұ� ��ġ��ġ�� �Է��� �ּ���.");
				return;
			}
		}
		
		Str_Cpy(stBur.szBurner_model_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BURNER_MODEL_NM)));
		Str_Cpy(stBur.szBurner_capa, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_BURNER_CAPA)));
		Str_Cpy(stBur.szBurner_capa_unit_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_CAPA_UNIT_NM)));
		Str_Cpy(stBur.szMaker_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_MAKER_NM)));
		Str_Cpy(stBur.szBurner_kind_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BURNER_KIND_NUM)));
		Str_Cpy(stBur.szInst_loc_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_INST_LOC)));
		Str_Cpy(stBur.szMake_num, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_MAKE_NUM)));
		Str_Cpy(stBur.szBoiler_form_nm, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_BOILER_FORM)));
		Str_Cpy(stBur.szMtr_id_num, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_MTR_ID_NUM)) );
		Str_Cpy(stBur.szData_flag, "10" );
		Str_Cpy(stBur.szInst_flag, "10" );
		Str_Cpy(stBur.szSend_yn, "S" );
				
		//�跮���ȣ(MTR_NUM)
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MTR_NUM FROM C6101_PROMISE_MTR where PROMISE_ASSIGN_SEQ = '%s' AND MTR_ID_NUM = '%s' ", g_szCHK_EXEC_NUM, stBur.szMtr_id_num, 0   );
		g_Sql_RetStr( szSql, 10, stBur.szMtr_num );
		if( m_lNewflag == 1 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );	
			SPRINT(szSql, "SELECT ifnull(MAX(BURNER_NUM)+1,'100001' ) AS MAX_NUM  FROM C6101_PROMISE_BUR WHERE PROMISE_ASSIGN_SEQ = '%s' AND MTR_NUM = '%s' AND SUBSTR(BURNER_NUM,1,1)= '1'  AND BURNER_KIND_NUM IN (201, 301)"
			, g_szCHK_EXEC_NUM, stBur.szMtr_num, 0   );
			g_Sql_RetStr( szSql, 6, stBur.szBurner_num );
		}
		else
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT ifnull(MAX(BURNER_NUM)+1,'200001' ) AS MAX_NUM  FROM C6101_PROMISE_BUR WHERE PROMISE_ASSIGN_SEQ='%s' AND MTR_NUM='%s' AND BURNER_KIND_NUM NOT IN ('201', '301') AND SUBSTR(BURNER_NUM,1,1)= '2' "
			, g_szCHK_EXEC_NUM, stBur.szMtr_num, 0   );
			g_Sql_RetStr( szSql, 6, stBur.szBurner_num );
		}
		//����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT BURNER_KIND_NUM FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stBur.szBurner_kind_nm, 0, 0   );
		g_Sql_RetStr( szSql, 5, stBur.szBurner_kind_num );

		SPRINT(szSql, "SELECT BURNER_CLASS_CD FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stBur.szBurner_kind_nm, 0, 0   );
		g_Sql_RetStr( szSql, 2, stBur.szBurner_class_cd );
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MAKER_NUM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NM = '%s' ", stBur.szMaker_nm, 0, 0   );
		g_Sql_RetStr( szSql, 5, stBur.szMaker_num );

		//���Ϸ� ��ġ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30028' AND ITEM_KNAME = '%s' ", stBur.szInst_loc_nm, 0, 0   );
		g_Sql_RetStr( szSql, 2, stBur.szInst_loc );

		//����
		i = SearchStr( stBur.szBurner_capa_unit_nm, SCBOIL_CAPA );
		if (i > -1)
		{
			Str_Cpy(stBur.szBurner_capa_unit, SCBOIL_CAPA[i].Code);
		}

		//�����ڵ�
		i = SearchStr( stBur.szBoiler_form_nm, SCBOIL_FORM );
		if (i > -1)
		{
			Str_Cpy(stBur.szBoiler_form, SCBOIL_FORM[i].Code);
		}		
    	
		sql = NewSqLite();
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "INSERT INTO  C6101_PROMISE_BUR \
(PROMISE_ASSIGN_SEQ    ,BURNER_NUM            ,MTR_NUM               ,CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ             \
,INST_PLACE_NUM        ,BURNER_CLASS_CD       ,BURNER_KIND_NUM       ,BURNER_KIND_NM        ,BURNER_MODEL_CD       \
,BURNER_CAPA           ,BURNER_CAPA_UNIT      ,BURNER_CAPA_UNIT_NM   ,BURNER_INST_YMD       ,BURNER_REMOV_YMD      \
,BURNER_MODEL_NM       ,BURNER_QTY            ,MAKER_NM              ,BOILER_FORM           ,BOILER_FORM_NM        \
,MAKER_NUM              ,MAKE_NUM              ,MAKE_YMD              ,WORK_DOCU_RECEIVE_YMD ,INST_FLAG             ,INST_LOC              \
,INST_LOC_NM           ,BOILER_INST_FIRM_CD   ,BOILER_INST_FIRM_NM   ,DATA_FLAG             ,MTR_ID_NUM            \
,SEND_YN               ,PDA_IP                ,UPD_EMPID ) \
VALUES ( ?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,? ) " );
		idx = 0;
		
		sql->Bind( sql, idx++, 'U', (long*) g_szCHK_EXEC_NUM              ,12  , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_num            ,6   , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szMtr_num               ,9   , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stMw.szCivil_serv_receive_num ,2 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stMw.szTreat_seq              ,10+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stMw.szInst_place_num         ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_class_cd       ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_kind_num       ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_kind_nm        ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_model_cd       ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_capa           ,10+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_capa_unit      ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_capa_unit_nm   ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_inst_ymd       ,8 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_remov_ymd      ,8 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_model_nm       ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBurner_qty            ,10+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szMaker_nm              ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBoiler_form           ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBoiler_form_nm        ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szMaker_num              ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szMake_num              ,30+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szMake_ymd              ,8 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szWork_docu_receive_ymd ,8 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szInst_flag             ,2 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szInst_loc              ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szInst_loc_nm           ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBoiler_inst_firm_cd   ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szBoiler_inst_firm_nm   ,20+1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long*) stBur.szData_flag             ,2 +1, DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)stBur.szMtr_id_num            ,15  , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)stBur.szSend_yn               ,1   , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)stUserinfo.szpda_ip           ,20  , DECRYPT );
		sql->Bind( sql, idx++, 'U', (long *)stUserinfo.szemployee_id	  ,9   , DECRYPT );

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

Finally:
		//sql->Commit(sql);
		DelSqLite(sql);
		
		stMw.szBur_yn[0] = 'Y';
		
		MessageBoxEx (CONFIRM_OK, "�ű� ����Ǿ����ϴ�.");
		
		if( g_nWorkFlag == 610 )
		{
			Find_Burner_Class_Cd(0);
		}
		else
		{
			ON_EXIT();
			OnInit(INIT_MAIN);
		}
	}
	
	void Shoto_Photo(long ID)
	{
		char *pCamera;
		long nRet;
		char szfilenm[128];
		handle h = NULL;
		handle hdata = NULL;

		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Str_Cat(m_szfilenm, g_szCHK_EXEC_NUM);
		if( ID == BID_PHOTO_MTR )
		{
			Str_Cat(m_szfilenm, "M");
			m_lPhoto_Flag = 0;
		}
		else
		{
			Str_Cat(m_szfilenm, "P");
			m_lPhoto_Flag = 1;
		}
		
		Str_Cat(m_szfilenm, ".jjp");

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_MW,  m_szfilenm, 0);
			Card_Move("CM_PHOTO");
			return;
			
		}
		else
		{
			//��������
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_MW,  m_szfilenm, 0);
			//���Ŀ��� Ȯ�ν�...
			//Str_Cpy(szScrPht, szfilenm);
			ShootPhoto ( 1, 0, m_szfilenm );
			/*
			//2017-07-11 Sanghyun Lee
			//���ο� ī�޶� ���� �ڵ�, ���� ���� ����
			h = JSON_Create( JSON_Object );
			if (h)
			{
				hdata = JSON_Create( JSON_Object );
				if(hdata == NULL)
				{
					goto Finally;
				}
				
				//2017-08-18 Sanghyun Lee
				//ī�޶� ȭ�� ����(photo_quality)	
				//"MEDIA_QUALITY_AUTO" ->> ���� �߻�, �ʿ�X
				//"MEDIA_QUALITY_LOWEST"
				//"MEDIA_QUALITY_LOW" ->> ���õǴ� ȭ���� ���� , �ʿ�X
				//"MEDIA_QUALITY_MEDIUM" ->> ���� ������ι���
				//"MEDIA_QUALITY_HIGH"
				//"MEDIA_QUALITY_HIGHEST"
				JSON_SetValue	(hdata	, 'C', "photo_quality"		, "MEDIA_QUALITY_MEDIUM");
				//JSON_SetValue	(hdata	, 'C', "desc"				, "photo");
				JSON_SetValue	(hdata	, 'C', "position_info"		, " ");
				JSON_SetValue	(h		, 'C', "method"				, "CameraActivity");
				
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
			*/	
		}
		
		return;
	}

	void Save_Induction(void)
	{
		handle* hsql;
		char * sqlstr = "";	
		PRINT("#1",0,0,0);
		hsql = STRING_Create(sqlstr);
		PRINT("g_szCHK_EXEC_NUM %s",g_szCHK_EXEC_NUM,0,0);
		STRING_Empty(hsql);
		STRING_Append(hsql," UPDATE C6101_PROMISE_BUR SET ");
		STRING_Append(hsql," SEND_YN =  'S'");
		STRING_Append(hsql," ,INDUCTION_INST_YN =  '");
		STRING_Append(hsql,  stBur.szInduc_inst_yn);
		STRING_Append(hsql,"' WHERE PROMISE_ASSIGN_SEQ = ");
		STRING_Append(hsql,  g_szCHK_EXEC_NUM);
		sqlstr = STRING_toString(hsql);
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(hsql);
	}
	
	void QuickList(void)
	{
		handle js = NULL;
		char* sztmp;

		js = JSON_Create(JSON_Object);
		if( js == NULL  )
		{
			goto Finally;
		}

		JSON_SetValue ( js, 'C', "title", "���Ϸ� ��ġ��ü");
		JSON_SetValue ( js, 'C', "dbname", "APP_DBF/SCGGAS.db");
		JSON_SetValue ( js, 'C', "query", "SELECT WORK_FIRM, WORK_FIRM FROM BO_INST");

		sztmp = JSON_toString(js);
		ListCtrl_QuickView(sztmp, LISTCTRL_QUERY);

Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		return;
	}
	
	void Snd_Promise_Assign(void)
	{
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
	
		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 62804, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stMw.szCivil_serv_receive_num );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq"			  , stMw.szTreat_seq  );
		JSON_SetValue( g_pjcomm, 'C', "trans_conn_yn"		  , stMw.szTrans_conn_yn );
		JSON_SetValue( g_pjcomm, 'C', "conn_yn"				  , stMw.szConn_yn );
		JSON_SetValue( g_pjcomm, 'C', "bar_gbn"				  , stMw.szBar_gbn );
		JSON_SetValue( g_pjcomm, 'C', "bar_yn"				  , stMw.szBar_yn );
		JSON_SetValue( g_pjcomm, 'C', "bar_why"				  , stMw.szBar_why );
		JSON_SetValue( g_pjcomm, 'C', "chk_yn"				  , stMw.szChk_yn );
		JSON_SetValue( g_pjcomm, 'C', "conn_gbn"			  , stMw.szConn_gbn );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR62804; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR62804_IN",  "FR62804" , sndbuf, szbuf );
		
		return;
	}
	
	// m_lCard : 0.C6101_WCUST, 1.C6101_WMTR, 2.C6101_WCHK, 3.C6101_WONE, 4.C6101_WSTOP, 5.C6101_WRELE, 6.C6101_WPAY, 7.MENU, 8.C6101_MENU, 9.C6101_LST
	long TR62804(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(62804) >= 0)
		{
			CloseMessageBox();
			
			if( m_lCard == 0 )
			{
				Card_Move("C6101_WCUST");
			}
			else if( m_lCard == 1 )
			{
				Card_Move("C6101_WMTR");
			}
			else if( m_lCard == 2 )
			{
				Card_Move("C6101_WCHK");
			}
			else if( m_lCard == 3 )
			{
				Card_Move("C6101_WONE");
			}
			else if( m_lCard == 4 )
			{
				Card_Move("C6101_WSTOP");
			}
			else if( m_lCard == 5 )
			{
				Card_Move("C6101_WRELE");
			}
			else if( m_lCard == 6 )
			{
				Card_Move("C6101_WPAY");
			}
			else if( m_lCard == 7 )
			{
				Card_Move("MENU");
			}
			else if( m_lCard == 8 )
			{
				Card_Move("C6101_MENU");
			}
			else if( m_lCard == 9 )
			{
				Card_Move("C6101_LST");
			}
			
			return 1;
		}
		else
		{
			CloseMessageBox();
			
			MessageBoxEx (ERROR_OK, "���� �������.");
			
			return -1;
		}
	}
	
	// flag = 0 : �跮�����, flag = 1 : ��һ���
	void Snd_Photo(long flag)
	{
		char szUrl[200];
		char szbuf[128];
		char sztmp[128];
		char szScrPht[128];
		char szUcovert[1000];
		char* sndbuf;
		long ret = 0;
		long i, idx, fd;
		byte* signimg = NULL;
		char* szfile =  NULL;
		long filesize = 0;
		handle file;
	
		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 62806, FALSE);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		Str_ItoA( flag, sztmp, 10 );
		JSON_SetValue( g_pjcomm, 'C', "center_cd"             , stUserinfo.szcenter_cd     );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num"   ,stMw.szCivil_serv_receive_num );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq"   ,stMw.szTreat_seq );
		JSON_SetValue( g_pjcomm, 'C', "flag"   , sztmp );
		
		if(flag == 0)
		{
			Mem_Set( (byte*)szScrPht, 0x00, sizeof(szScrPht) );
			SPRINT (szScrPht, "%s/%sM.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);
			filesize = FFS_GetSize( szScrPht );
			
			if(filesize > 0)
			{
				signimg = Mem_Alloc(filesize);
				
				fd = FFS_Open(szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
				FFS_Read ( fd, (byte*)signimg, filesize );
				FFS_Close(fd);
		
				file = BASE64_Create();
				BASE64_Encode(file, signimg, filesize );
				szfile = BASE64_GetResult(file);	
				JSON_SetValue( g_pjcomm, 'C', "mtr_photo"   ,szfile );
				free((byte*)signimg);
				BASE64_Finalize(file);
				file = NULL;
				
				JSON_SetValue( g_pjcomm, 'C', "inst_photo"   ,"" );
			}
		}
		else if (flag == 1)
		{
			Mem_Set( (byte*)szScrPht, 0x00, sizeof(szScrPht) );
			SPRINT (szScrPht, "%s/%sP.jjp", PHOTO_MW,  g_szCHK_EXEC_NUM, 0);
			filesize = FFS_GetSize( szScrPht );
			
			if(filesize > 0)
			{
				signimg = Mem_Alloc(filesize);
				
				fd = FFS_Open(szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
				FFS_Read ( fd, (byte*)signimg, filesize );
				FFS_Close(fd);
		
				file = BASE64_Create();
				BASE64_Encode(file, signimg, filesize );
				szfile = BASE64_GetResult(file);	
				JSON_SetValue( g_pjcomm, 'C', "inst_photo"   ,szfile );
				free((byte*)signimg);
				BASE64_Finalize(file);
				file = NULL;
				
				JSON_SetValue( g_pjcomm, 'C', "mtr_photo"   ,"" );
			}
		}
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = TR62806; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR62806_IN",  "FR62806" , sndbuf, szbuf );
		
		return;
	}

	long TR62806(void)
	{
		handle* hsql;
		char * sqlstr = "";	
		
		g_Sock_Close();
		
		if(g_Chk_Json(62806) >= 0)
		{
			CloseMessageBox();
			
			if( m_lPhoto_Flag == 0 )
			{
				hsql = STRING_Create(sqlstr);
				STRING_Empty(hsql);
				STRING_Append(hsql," UPDATE C6101_PROMISE_ASSIGN SET ");
				STRING_Append(hsql," MTR_PHOTO_YN =  'Y'");
				STRING_Append(hsql,"WHERE PROMISE_ASSIGN_SEQ = '");
				STRING_Append(hsql,  g_szCHK_EXEC_NUM);
				STRING_Append(hsql,"' ");		
				sqlstr = STRING_toString(hsql);
				g_Sql_DirectExecute(sqlstr);
				STRING_Finalize(hsql);	
				
				VmSleep(100);

				Mem_Set((byte*)stMw.szMtr_Photo_yn, 0x00, sizeof(stMw.szMtr_Photo_yn));
				Str_Cpy(stMw.szMtr_Photo_yn, "Y");
			}
			else if( m_lPhoto_Flag == 1 )
			{	
				hsql = STRING_Create(sqlstr);
				STRING_Empty(hsql);
				STRING_Append(hsql," UPDATE C6101_PROMISE_ASSIGN SET ");
				STRING_Append(hsql," PLACE_PHOTO_YN =  'Y'");
				STRING_Append(hsql,"WHERE PROMISE_ASSIGN_SEQ = '");
				STRING_Append(hsql,  g_szCHK_EXEC_NUM);
				STRING_Append(hsql,"' ");		
				sqlstr = STRING_toString(hsql);
				g_Sql_DirectExecute(sqlstr);
				STRING_Finalize(hsql);
				
				VmSleep(100);
				
				Mem_Set((byte*)stMw.szPlace_Photo_yn, 0x00, sizeof(stMw.szPlace_Photo_yn));
				Str_Cpy(stMw.szPlace_Photo_yn, "Y");
			}

			ReDraw();
			return 1;
		}
		else
		{
			CloseMessageBox();
			
			MessageBoxEx (ERROR_OK, "���� �������.");
			
			return -1;
		}
	}
	
	void Snd_Delete_Photo(void)
	{
		char szUrl[200];
		char szbuf[128];
		char sztmp[128];
		char* sndbuf;
		long ret = 0;
		long i, idx, fd;

		Mem_Set((byte*)szUrl, 0x00, sizeof(szUrl));	
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		if( Str_Cmp(stMw.szMtr_Photo_yn, "Y") == 0 || Str_Cmp(stMw.szPlace_Photo_yn, "Y") == 0 )
		{
			g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 62807, FALSE);
	
			JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num"   ,stMw.szCivil_serv_receive_num );
			JSON_SetValue( g_pjcomm, 'C', "treat_seq"   ,stMw.szTreat_seq );
	
			sndbuf = JSON_toString(g_pjcomm);
			
			g_SeverConnection();
			
			Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
			GET_FILENM(szbuf, SQLITE_DB);
			
			callBackfunc = TR62807; //��ſϷ� �Ŀ� ȣ�� �Լ�
			ret = HTTP_DownloadData(szUrl, "FR62807_IN",  "FR62807" , sndbuf, szbuf );
		}
		
		return;
	}

	long TR62807(void)
	{
		handle* hsql;
		char * sqlstr = "";	
		
		g_Sock_Close();
		
		if(g_Chk_Json(62807) >= 0)
		{
			CloseMessageBox();

			hsql = STRING_Create(sqlstr);
			STRING_Empty(hsql);
			STRING_Append(hsql,"UPDATE C6101_PROMISE_ASSIGN SET ");
			STRING_Append(hsql," MTR_PHOTO_YN = NULL");
			STRING_Append(hsql,",PLACE_PHOTO_YN = NULL");
			STRING_Append(hsql,"WHERE PROMISE_ASSIGN_SEQ = ");
			STRING_Append(hsql,  g_szCHK_EXEC_NUM);	
			sqlstr = STRING_toString(hsql);
			g_Sql_DirectExecute(sqlstr);
			STRING_Finalize(hsql);	
			
			Mem_Set((byte*)stMw.szMtr_Photo_yn, 0x00, sizeof(stMw.szMtr_Photo_yn));
			Str_Cpy(stMw.szMtr_Photo_yn, "");
			Mem_Set((byte*)stMw.szPlace_Photo_yn, 0x00, sizeof(stMw.szPlace_Photo_yn));
			Str_Cpy(stMw.szPlace_Photo_yn, "");

			return 1;
		}
		else
		{
			CloseMessageBox();
			return -1;
		}
	}
	
	
	// ���ұ� ���� �� �˸�(���Ը�) flag = 0 �ű�,����, flag = 1 ����
	void Find_Burner_Class_Cd(long flag)
	{	
		long i;
		char sztmp[8];
		char burclscd[8];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*)burclscd, 0x00, sizeof(burclscd) );

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql," SELECT BURNER_CLASS_CD \
 										     FROM C6101_PROMISE_BUR \
										    WHERE (INST_FLAG <> '30' OR  INST_FLAG IS NULL) \
											  AND PROMISE_ASSIGN_SEQ = ? \
										    GROUP BY BURNER_CLASS_CD ");
		
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
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp    ,8 +1, DECRYPT );
			Str_Cat(burclscd, sztmp);
		}
		
		Chk_Prod_Cd_Alarm(burclscd, flag);

	Finally:
		DelSqLite(sql);
		return;	
	}
	
	void Chk_Prod_Cd_Alarm(char* burclscd, long flag)
	{
		long i;
		long chk_count = 0;
		
		char sztmp[8];

		char szSql[50];
		char szProd[5];
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)szProd, 0x00, sizeof(szProd));
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		
		SPRINT(szSql, "SELECT PROD_CD FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ = '%s'", g_szCHK_EXEC_NUM, 0, 0);

		g_Sql_RetStr(szSql, 10, szProd);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql," SELECT PROD_CD FROM C6101_BIZ_BURN A WHERE BURNER_CLASS_CD = ? ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)burclscd , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE )
		{	
			i = 0;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp    , 8 +1, DECRYPT );
			
			if( Str_Cmp(sztmp, szProd) == 0 )
			{
				chk_count ++;
			}	
		}
		
		if(chk_count == 0)
		{
			MessageBoxEx (CONFIRM_OK, "��ǰ�� �������ּ���!");
			g_lWmtrMoveFlag = 1;
			Card_Move("C6101_WMTR");
		}
		else
		{
			if( flag != 1 )
			{
				ON_EXIT();
				OnInit(INIT_MAIN);
			}
		}
Finally:
		DelSqLite(sql);
		return;	
	}
}



