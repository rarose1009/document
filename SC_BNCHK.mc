/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : SC_BNCHK
	Card Desc : ���ұ�����
	Card Hist :
----------------------------------------------------------------------------------*/
card SC_BNCHK
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
	
	//-----------------------------------------------------------------------------------------------
	// BUTTON ID define
	//-----------------------------------------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/********************************/
		/* ȭ�� ��� ���� �޴� ����     */
		/********************************/
		DEF_BUTTON_ID ( BID_HOME )			// Ȩ
		DEF_BUTTON_ID ( BID_MENU )			// �޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )		// Ű����
		DEF_BUTTON_ID ( BID_SCREEN )		// ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )		// �������
		DEF_BUTTON_ID ( BID_PREV )			// ����
		DEF_BUTTON_ID ( BID_EXIT )			// ����
		
		/********************************/
		/* ���ұ� ���� ȭ��             */
		/********************************/
		DEF_BUTTON_ID ( BID_PREVLST )
		DEF_BUTTON_ID ( BID_NEXTLST )
		DEF_BUTTON_ID ( BID_PHOTO )			// ����
		DEF_BUTTON_ID ( BID_DELCANCEL )		// �������
		DEF_BUTTON_ID ( BID_DELETE )		// ����
		DEF_BUTTON_ID ( BID_CHANGE )		// ����
		DEF_BUTTON_ID ( BID_NEW )			// �ű�
		DEF_BUTTON_ID ( BID_BNCHK )			// ����
		DEF_BUTTON_ID ( BID_OK1 )			// Ȯ��
		DEF_BUTTON_ID ( BID_PROD )			// ��ǰ
		DEF_BUTTON_ID ( BID_BUR_PHOTO )   	// ���ұ� ����
		
		DEF_BUTTON_ID ( BID_BUR_PHOTO_OLD ) // ���ұ� ���Ż��� & PAGE
		DEF_BUTTON_ID ( BID_BUNPHOTO_OLD )	// ���ұ� ���Ż���
		
		/********************************/
		/* ���ұ� �ű�/���� ���        */
		/********************************/
		DEF_BUTTON_ID ( BID_CANCLE )		// ���
		DEF_BUTTON_ID ( BID_OK2 )			// ����
		DEF_BUTTON_ID ( BID_OK3 )			// �űԵ��
		DEF_BUTTON_ID ( BID_INSTYMD )		// �űԵ��
		DEF_BUTTON_ID ( BID_WRITE )			// �𵨸��Է�
		DEF_BUTTON_ID ( BID_WRITE2 )		// ������˻�
		
		/********************************/
		/* ���ұ� ����                  */
		/********************************/
		DEF_BUTTON_ID ( BID_HOSECHK )		// ȣ�� ����
		DEF_BUTTON_ID ( BID_BURCHK )		// ���ұ� ����
		DEF_BUTTON_ID ( BID_CLOSE )			// �ݱ�
		DEF_BUTTON_ID ( BID_CHKSAVE )		// ����
		
		/********************************/
		/* ���ұ� ���Ż���              */
		/********************************/
		DEF_BUTTON_ID ( BID_PHOTO_CLOSE )	// ���ұ���� CLOSE
		
	END_BUTTON_ID()
	
	//-----------------------------------------------------------------------------------------------
	// OBJECT ID define
	//-----------------------------------------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/********************************/
		/* ����                         */
		/********************************/
		DEF_OBJECT_ID ( TXT_PAGE )
		DEF_OBJECT_ID ( TXT_TITLE )			// Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_TYPE )			// ����
		DEF_OBJECT_ID ( ICON_TITLE )		// Ÿ��Ʋ
		
		/********************************/
		/* ���ұ� ���� ȭ��             */
		/********************************/
		DEF_OBJECT_ID ( TXT_MAKENUM )		// ������ȣ
		DEF_OBJECT_ID ( TXT_TYPE2 )			// ����
		DEF_OBJECT_ID ( TXT_MAKECMPN )		// ������
		DEF_OBJECT_ID ( TXT_MODELNM )		// �𵨸�
		DEF_OBJECT_ID ( TXT_VOLUME )		// �뷮
		DEF_OBJECT_ID ( TXT_INSDT )			// ��ġ����
		DEF_OBJECT_ID ( TXT_DATATYPE )		// �ڷᱸ��
		DEF_OBJECT_ID ( TXT_DATA15 )		// ��ġ����
		DEF_OBJECT_ID ( TXT_DATA16 )		// ������ȣ	
		DEF_OBJECT_ID ( TXT_DATA17 )		// ����
		DEF_OBJECT_ID ( TXT_DATA18 )		// ������
		DEF_OBJECT_ID ( TXT_DATA19 )		// �𵨸�
		DEF_OBJECT_ID ( TXT_DATA20 )		// �뷮
		DEF_OBJECT_ID ( TXT_DATA21 )		// �뷮
		DEF_OBJECT_ID ( TXT_DATA22 )		// �ڷᱸ��
		
		DEF_OBJECT_ID ( TXT_DATA42 )		// ������
		DEF_OBJECT_ID ( TXT_DATA43 )		// Ÿ�̸���
		DEF_OBJECT_ID ( TXT_DATA44 )		// �÷��׸����̺�
		DEF_OBJECT_ID ( TXT_KIT_SPRINKLER ) 	// �ֹ��ڵ���ȭ��ġ��ġ����
		
		/********************************/
		/* ���ұ� �ű�/���� ���        */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA23 )		// �⹰, ���ұ��ȣ
		DEF_OBJECT_ID ( TXT_DATA24 )		// �⹰��ȣ
		DEF_OBJECT_ID ( TXT_DATA25 )		// ����
		DEF_OBJECT_ID ( TXT_DATA26 )		// ����	
		DEF_OBJECT_ID ( TXT_DATA27 )		// �𵨸�		
		DEF_OBJECT_ID ( TXT_DATA29 )		// �뷮
		DEF_OBJECT_ID ( TXT_DATA31 )		// ��ġ����
		DEF_OBJECT_ID ( TXT_DATA32 )		// ��ġ����	
		DEF_OBJECT_ID ( TXT_DATA33 )		// ����, �������
		DEF_OBJECT_ID ( TXT_DATA34 )		// ����	
			
		DEF_OBJECT_ID ( TXT_DATA35 )		// ��ġ����_1
		DEF_OBJECT_ID ( TXT_DATA36 )		// ��ġ����_2
		DEF_OBJECT_ID ( TXT_DATA37 )		// ��ġ����_3
		DEF_OBJECT_ID ( TXT_DATA38 )		// ��ġ����_4
		
		/********************************/
		/* ���ұ� ����                  */
		/********************************/
		DEF_OBJECT_ID ( TXT_DATA40 )		// ȣ��
		DEF_OBJECT_ID ( TXT_DATA41 )		// ȣ��_���պ�����
		DEF_OBJECT_ID ( TXT_DATA45 )		// ���ұ�
		DEF_OBJECT_ID ( TXT_DATA46 )		// ���ұ�_���պ�����
		DEF_OBJECT_ID ( TXT_DATA47 )		// ���ұ�_���պ�����
		
		/********************************/
		/* EDIT                         */
		/********************************/
		// ���ұ� �ű�/���� ���
		DEF_OBJECT_ID ( EDT_DATA1 )			// �𵨸�
		DEF_OBJECT_ID ( EDT_DATA2 )			// �뷮
		DEF_OBJECT_ID ( EDT_DATA3 )			// ��ġ����_1
		DEF_OBJECT_ID ( EDT_DATA4 )			// ��ġ����_2
		DEF_OBJECT_ID ( EDT_DATA5 )			// ��ġ����_3
		DEF_OBJECT_ID ( EDT_DATA6 )			// ��ġ����_3
		
		/********************************/
		/* TABLE                        */
		/********************************/
		DEF_OBJECT_ID ( ID_TBLLIST )		// ���ұ�GRID
		
		/********************************/
		/* LINE                         */
		/********************************/
		DEF_OBJECT_ID ( LINE_DATA1 )		// LINE_DATA_1
		DEF_OBJECT_ID ( LINE_DATA2 )		// LINE_DATA_2
		DEF_OBJECT_ID ( LINE_DATA3 )		// LINE_DATA_3
		
		/********************************/
		/* COMBO                        */
		/********************************/
		DEF_OBJECT_ID ( CMB_DATA1 )					// ����
		DEF_OBJECT_ID ( CMB_DATA2 = CMB_DATA1 + 3 )	// �������, �⹰��ȣ
		DEF_OBJECT_ID ( CMB_DATA3 = CMB_DATA2 + 3 )	// �뷮
		DEF_OBJECT_ID ( CMB_DATA4 = CMB_DATA3 + 3 )	// �������
		DEF_OBJECT_ID ( CMB_DATA6 = CMB_DATA4 + 3 )	// ������
		DEF_OBJECT_ID ( CMB_DATA7 = CMB_DATA6 + 3 )	// Ÿ�̸���
		DEF_OBJECT_ID ( CMB_DATA8 = CMB_DATA7 + 3 )	// �÷��׸����̺�
		DEF_OBJECT_ID ( CMB_KIT_SPRINKLER = CMB_DATA8 + 3 ) // �ֹ��ȭ��ġ
		
	
	END_OBJECT_ID()

	//-----------------------------------------------------------------------------------------------
	// ���ұ� ����ü( ������ ������ ������ ������Ʈ ���ؾ��� )
	//-----------------------------------------------------------------------------------------------
	typedef struct _BURINFO
	{
		char BURNER_KIND_NM     	[40 +1]; 
		char BURNER_MODEL_NM     	[50 +1]; 
		char BURNER_CAPA         	[10 +1]; 
		char BURNER_CAPA_UNIT    	[10 +1]; 
		char BURNER_INST_YMD     	[12 +1];
		char MAKER_NUM           	[20 +1];  
		char MTR_ID_NUM          	[15 +1];  
		char CHG_FLAG            	[5  +1];  
	}	BURINFO;
	
	BURINFO m_stScBur;
	
	//-----------------------------------------------------------------------------------------------
	// ���ұ� ���Ż��� ����ü
	//-----------------------------------------------------------------------------------------------
	typedef struct _PHOTODATA
	{
		char ORG_FILE_NAME				[200 +1];		// ��ü�����̸�
		char FILE_NAME					[200 +1]; 		// Ȯ���ڸ� �� �����̸�
		char FILE_PATH					[200 +1]; 		// ���� ���� ���
		char PHOTO_LENGTH				[50  +1];		// ���� SIZE
		char PHOTO_SAVE_JPG_PATH		[256 +1];		// �ܸ��⿡ ����� ���� ��� - JPG
		char PHOTO_SAVE_JPG_SIZE_PATH	[256 +1];		// �ܸ��⿡ ����� ���� ��� - ������ ���� JPG
		char PHOTO_SAVE_PNG_PATH		[256 +1];		// �ܸ��⿡ ����� ���� ��� - PNG
	}	PHOTODATA;
	
	PHOTODATA m_stPhotoData;

	//-------------------------------------------------------------------------------------------------
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    3						// table�� �ళ��
	#define		COL 	    6						// table�� ������
	#define		GRID_H		(CHT+10)				// table �� ����
	#define		GRID_H_P	(CHT+25)				// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   			// table Ŭ���� color
	#define		GRID_X		STARTX 			    	// table ����x��ǥ
	#define		MAXCHAR		51 			    		// table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+65  	   			// table ����y��ǥ
	#define		GRID_Y_P	STARTY-40          		// table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) // table������ row�� Y��
	
	char m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
	
	Column m_stGridTitle[] = {
		{"�⹰��ȣ",	CWD*15,   EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",		CWD*9+23, EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�뵵",		CWD*7 ,   EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"����",		CWD*8 ,   EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"���ұ��ȣ",	CWD*0 ,   EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�跮���ȣ",	CWD*0 ,   EDITALIGN_CENTER|EDITALIGN_MIDDLE,   TABLE_TEXT, 0}
	};
	
	//-----------------------------------------------------------------------------------------------
	// Define
	//-----------------------------------------------------------------------------------------------
	#define INIT_MAIN		   1 // ���ұ� ����
	#define INIT_BN	    	   2 // ���ұ� �ű�, ����
	#define INIT_BNCHK  	   3 // ���ұ� ����
	#define INIT_BUNPHOTO_OLD  4 // ���ұ� ���� ����
	
	//-----------------------------------------------------------------------------------------------
	// Global Param
	//-----------------------------------------------------------------------------------------------
	long m_bFirst;
	long m_lDrawFlag = 0; 		// = 0 default , = 1 ȭ�� �̵� �� ����� Ÿ�̸���, ������ �ҷ�����.
	long m_nBtnId;
	long m_lpage = 0;
	long m_lTotCnt = 0;
	long m_lTotpage = 0;
	long m_lSelIndex = -1;
	long m_lIdxFlag = 0;		// index ���� flag
	long m_lActiveIndex = -1;
	long m_lchk_prod_popup = 0;
	
	char m_szChk_Rslt[3];
	char m_szCnt_page[10];	
	char m_szChkSecNm[40];
	char m_szNotPassItemNm[40];
	char m_szMtrNum[20];
	char m_szfilenm[256];
	char m_lBunPhoto_Old = 0; // ���� ���ұ���� �������� ���ϴ� flag : 0 = �Ȱ�����, 1= ������
	char m_lphoto_flag = 0; // ī�޶� flag : 0 = ���ұ� ����, 1 = �÷��׸��� �̺�
	char m_szTxt [10]; // 10 : ���� , 20 : �ű� 
	
	
	//-----------------------------------------------------------------------------------------------
	// Function
	//-----------------------------------------------------------------------------------------------
	void SetStyle(void);
	void SetStruct(void); // ���� �� ������ ��Ʈ���Ŀ� �����ϴ� �Լ�
	void SetData(void);
	void SetCombo(void);
	void SetComboMaker(void);
	void SetBtnImg(void);
	void Set_Alarm(void);
	
	void SetClickData(void);
	
	void CockDraw(void);
	void BUN_DRAW(long nbuttonid);
	void CHG_DRAW(void);
	void CHK_DRAW(void);
	
	bool Validate(void);
	long Update_Result(void);
	
	void Del_Bur(void);
	bool Chg_Bur(void);
	bool New_Bur(void);
	
	bool Compare_Data(void);
	
	void Clear_Screen(void);
	void SaveInput(void);
	bool Save_NotPassItem(void);
	void Del_Plug_Nogood(void);
	bool Save_Bun(void);
	
	void Shoto_Photo(void);
	void Shoto_Bur_Photo(void);
	
	void Find_Burner_Class_Cd(void);
	void Chk_Prod_Cd_Alarm(char* burclscd);
	
	void Snd_FR311328(void);
	long Rcv_FR311328(void);
	void SetBunPhoto_Old(void);
	
	void PhotoDraw(void);
	void JpgToPng(void);
	void SetBunPhoto_Old(void);
	
	//-----------------------------------------------------------------------------------------------
	//	main 
	//-----------------------------------------------------------------------------------------------
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
	
	//-----------------------------------------------------------------------------------------------
	// ���� ���̾�α�
	//-----------------------------------------------------------------------------------------------
	DlgObject DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT ( TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� ����"),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		
		DLG_BUTTON(STARTX,     STARTY+265, 220,  60,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BUR_PHOTO_OLD, m_szCnt_page), // PAGE & ���Ż���
		DLG_BUTTON(STARTX+220, STARTY+265, 280,  60,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, YELLOW, CALL_FUNC , "", BID_BUR_PHOTO, "�� ��"),
		DLG_BUTTON(STARTX+220, STARTY+265, 280,  60,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PROD     , "�� ǰ"),
		DLG_BUTTON(STARTX+500, STARTY+265, 250,  60,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVLST  , "��"),
		DLG_BUTTON(STARTX+750, STARTY+265, 250,  60,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTLST  , "��"),
		
		DLG_LINE ( STARTX,     STARTY+329, 1000, STARTY+329, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_TEXT ( STARTX,	   STARTY+334, 220,  50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_MAKENUM , "������ȣ"),
		DLG_TEXT ( STARTX+220, STARTY+334, 780,  50,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA16  , ""),
		
		DLG_TEXT ( STARTX,	   STARTY+384, 220,  50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_TYPE2   , "����"),
		DLG_TEXT ( STARTX+220, STARTY+384, 780,  50,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA17  , ""),
		
		DLG_TEXT ( STARTX,	   STARTY+434, 220,  50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_MAKECMPN, "������"),
		DLG_TEXT ( STARTX+220, STARTY+434, 280,  50,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA18  , ""),
		
		DLG_TEXT ( STARTX+500, STARTY+434, 180,  50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_MODELNM , "�𵨸�"),
		DLG_TEXT ( STARTX+680, STARTY+434, 320,  50,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR	  , TXTINCTRLBK, TXT_DATA19  , ""),
		
		DLG_TEXT ( STARTX, 	   STARTY+484, 220,  50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_VOLUME  , "�뷮"),
		DLG_TEXT ( STARTX+220, STARTY+484, 280,  50,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR	  , TXTINCTRLBK, TXT_DATA20  , ""),
		DLG_TEXT ( STARTX+500, STARTY+484, 500,  50,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR	  , TXTINCTRLBK, TXT_DATA21  , ""),
		
		DLG_TEXT ( STARTX, 	   STARTY+534, 220,  50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_INSDT   , "��ġ����"),
		DLG_TEXT ( STARTX+220, STARTY+534, 350,  50,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR	  , TXTINCTRLBK, TXT_DATA15  , ""),
		
		DLG_TEXT ( STARTX+570, STARTY+534, 220,  50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATATYPE, "�ڷᱸ��"),
		DLG_TEXT ( STARTX+790, STARTY+534, 210,  50,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR	  , TXTINCTRLBK, TXT_DATA22  , ""),

		DLG_LINE ( STARTX,     STARTY+588, 1000, STARTY+588, DARKSLATEBLUE, 10, LINE_DATA2),
		
		DLG_TEXT ( STARTX,	   STARTY+593, 400,  50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA44, "�÷��׸����̺�"),
		DLG_COMBO (STARTX+400, STARTY+593, 430, 200, 170, 50,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA8, 10), // �÷��׸����̺�
		DLG_BUTTON(STARTX+830, STARTY+593, 170,  50,   0,  0,    BUTSTY_BOLD   , BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "�� ��"),
		
		DLG_TEXT ( STARTX,	   STARTY+643, 400,  50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA42, "������"),
		DLG_COMBO (STARTX+400, STARTY+643, 600, 200, 170, 50,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA6, 10), // ������
		
		DLG_TEXT ( STARTX,	   STARTY+693, 400 , 50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA43, "Ÿ�̸���"),
		DLG_COMBO (STARTX+400, STARTY+693, 600, 200, 170, 50, 	 TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA7, 10), // Ÿ�̸���
		
		DLG_TEXT ( STARTX,	   STARTY+743, 430 , 50,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_KIT_SPRINKLER, "�ֹ��ڵ���ȭ��ġ"),
		DLG_COMBO (STARTX+430, STARTY+743, 570, 200, 170, 50, 	 TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_KIT_SPRINKLER, 10), // �ֹ��ڵ���ȭ��ġ

		DLG_LINE ( STARTX,     STARTY+797, 1000, STARTY+797, DARKSLATEBLUE, 10, LINE_DATA3),
		
		DLG_BUTTON(STARTX,     STARTY+802, 166,  97,   0,  0, 	 BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELCANCEL, "�� ��\n�� ��"),
		DLG_BUTTON(STARTX+166, STARTY+802, 166,  97,   0,  0, 	 BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE   , "�� ��"),
		DLG_BUTTON(STARTX+332, STARTY+802, 166,  97,   0,  0, 	 BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHANGE   , "�� ��"),
		DLG_BUTTON(STARTX+498, STARTY+802, 166,  97,   0,  0, 	 BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEW      , "�� ��"),
		DLG_BUTTON(STARTX+664, STARTY+802, 166,  97,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BNCHK    , "�� ��"),
		DLG_BUTTON(STARTX+830, STARTY+802, 170,  97,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK1      , "�� ��"),
	};	
	
	//-----------------------------------------------------------------------------------------------
	//  ���̾�α�:���ұ�űԵ��//����
	//-----------------------------------------------------------------------------------------------
	DlgObject DlgRes_BN[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, ""),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CANCLE, ""),

		DLG_TEXT ( STARTX,	   STARTY -29, 350,  80,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA23, ""),
		DLG_TEXT ( STARTX+350, STARTY -29, 650,  80,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, ""),
		
		DLG_TEXT ( STARTX,	   STARTY +51, 350,  80,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA25, "����"),
		DLG_COMBO (STARTX+350, STARTY +51, 650, 200, 150, 80,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA1, 10),
		
		DLG_TEXT ( STARTX,	   STARTY+131, 350,  80,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, ""),
		DLG_COMBO (STARTX+350, STARTY+131, 650, 200, 150, 80,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
		
		DLG_TEXT ( STARTX,	   STARTY+211, 350,  80,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA27, "�𵨸�"),
		DLG_BUTTON(STARTX+350, STARTY+211, 650,  80,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE,  ""),
		DLG_TEXT ( STARTX+350, STARTY+211, 650,  80,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA1,  ""),
		
		DLG_TEXT ( STARTX,	   STARTY+291, 350,  80,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA29, "�뷮"),
		DLG_EDIT ( STARTX+350, STARTY+291, 250,  80,   0,  0,    EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA2, 10,  ""),
		DLG_COMBO (STARTX+600, STARTY+291, 400, 200, 150, 80,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA3, 10),
		
		DLG_TEXT ( STARTX,	   STARTY+371, 350,  80,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA31, "��ġ����"),
		DLG_EDIT ( STARTX+350, STARTY+371, 175,  80,   0,  0,    EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA3, 4,  ""),
		DLG_TEXT ( STARTX+525, STARTY+371,  18,  50,   0,  0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA35, ""),
		DLG_TEXT ( STARTX+525, STARTY+421,  18,  30,   0,  0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA36, "."),
		DLG_EDIT ( STARTX+543, STARTY+371, 145,  80,   0,  0,    EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA4, 2,  ""),
		DLG_TEXT ( STARTX+688, STARTY+371,  17,  50,   0,  0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA37, ""),
		DLG_TEXT ( STARTX+688, STARTY+421,  17,  30,   0,  0, 0, 0, TXTFRCOLOR, EDTCTRLBK, TXT_DATA38, "."),
		DLG_EDIT ( STARTX+705, STARTY+371, 145,  80,   0,  0,    EDITSTY_BOLD, 0, BLACK, EDTCTRLBK, EDT_DATA5, 2,  ""),
		DLG_BUTTON(STARTX+850, STARTY+371, 150,  80,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, PDAEDTCTRLBK, CALL_FUNC , "", BID_INSTYMD, "��"),

		DLG_TEXT ( STARTX,	   STARTY+451, 350,  80,   0,  0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA33, ""),
		DLG_TEXT ( STARTX+350, STARTY+451, 650,  80,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA34, ""),
		DLG_COMBO (STARTX+350, STARTY+451, 650, 200, 150, 80,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA4, 10),

		DLG_TEXT(STARTX, 	 STARTY+531, 350, 80, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, 	TXT_DATA47,"������˻�"),
		DLG_BUTTON(STARTX+350, STARTY+531, 650,  80, 175  ,  50, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_WRITE2,  ""),
		DLG_TEXT(STARTX+350, STARTY+531, 650,  80, 175  ,  50, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6,  ""),
		
		DLG_LINE ( STARTX,     STARTY+535, 1000, STARTY+535, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_BUTTON(STARTX,	   STARTY+619, 500,  80,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CANCLE,  "�ݱ�"),
		DLG_BUTTON(STARTX+500, STARTY+619, 500,  80,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "����"),
		DLG_BUTTON(STARTX+500, STARTY+619, 500,  80,   0,  0,    BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK3,  "����"),
	};
	
	//-----------------------------------------------------------------------------------------------
	//  ���̾�α�:���ұ� ����
	//-----------------------------------------------------------------------------------------------
	DlgObject DlgRes_CHK[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���ұ� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
				
		DLG_TEXT ( STARTX,     STARTY -29, 300,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA40, "ȣ��"),
		DLG_TEXT ( STARTX+300, STARTY -29, 450,  70,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA41, ""),
		DLG_BUTTON(STARTX+750, STARTY -29, 250,  70,   0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_HOSECHK, "����"),
		
		DLG_TEXT ( STARTX,     STARTY +41, 300,  70,   0,  0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK  , TXT_DATA45, "���ұ�"),
		DLG_TEXT ( STARTX+300, STARTY +41, 450,  70,   0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR   , TXTINCTRLBK, TXT_DATA46, ""),
		DLG_BUTTON(STARTX+750, STARTY +41, 250,  70,   0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_BURCHK, "����"),
		
		DLG_LINE ( STARTX,     STARTY+115, 1000, STARTY+115, DARKSLATEBLUE, 10, LINE_DATA1),
		
		DLG_BUTTON(STARTX,     STARTY+120, 500,  70,   0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE  , "�ݱ�"),
		DLG_BUTTON(STARTX+500, STARTY+120, 500,  70,   0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CHKSAVE, "����"),	
	};

	//-----------------------------------------------------------------------------------------------
	// ���̾�α�:���ұ���Ż���
	//-----------------------------------------------------------------------------------------------
	DlgObject DlgRes_BUNPHOTO_OLD[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "���� ���ұ� ����"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
		
		DLG_BUTTON(STARTX, STARTY -29, 1000, 858, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BUNPHOTO_OLD,  ""),
		
		DLG_BUTTON(STARTX, STARTY+829, 1000,  70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO_CLOSE  , "�ݱ�"),
	};
	
	//-----------------------------------------------------------------------------------------------
	// main
	//-----------------------------------------------------------------------------------------------
	bool main( quad MsgType, quad wParam, quad lParam )
	{
		long i = 0;
	
		EVENT_HANDLER (MsgType, wParam, lParam);
		
		return TRUE;
	}
	
	//-----------------------------------------------------------------------------------------------
	// SYSTEM FUCTION
	//-----------------------------------------------------------------------------------------------
	
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
			/* ���ұ� ���� ȭ��             */
			/********************************/
			case INIT_MAIN:
				
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
				
				SetBtnImg();
				SetStyle();
				SetCombo();
				
				if( g_lSCMoveFlag == 1 && g_lNewBurFlag != 2 )
				{
					g_lSCMoveFlag = 0;
					m_lDrawFlag = 1;
					
					ON_EXIT();
					OnInit(INIT_BNCHK);
					break;
				}

				SetData();	
				CockDraw();	
				Set_Alarm();
						
				break;
			
			/********************************/
			/* ���ұ� �ű�/���� ���        */
			/********************************/
			case INIT_BN:
				
				CREATE_DIALOG_OBJECT (DlgRes_BN, SIZEOF(DlgRes_BN));
					
				SetBtnImg();
				SetCombo();
				
				BUN_DRAW(m_nBtnId);
				
				break;
			
			/********************************/
			/* ���ұ� ����                  */
			/********************************/	
			case INIT_BNCHK:

				CREATE_DIALOG_OBJECT (DlgRes_CHK, SIZEOF(DlgRes_CHK));

				SetBtnImg();
				SetStyle();
				SetCombo();
				CHK_DRAW();
				
				ON_DRAW();
				
				break;
			
			/********************************/
			/* ���ұ� ���Ż���              */
			/********************************/
			case INIT_BUNPHOTO_OLD:
			
				CREATE_DIALOG_OBJECT (DlgRes_BUNPHOTO_OLD, SIZEOF(DlgRes_BUNPHOTO_OLD));
				
				SetBtnImg();
				JpgToPng();
				
				ON_DRAW();
				
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
		long d, k, lCnt;
		char sztmp[15];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		char szDp[11];
		char szSql[200];
	
		m_nBtnId = ID;
		
		switch (ID )
		{
			/********************************/
			/* ȭ�� ��� ���� �޴� ����     */
			/********************************/
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
				Card_Move("SC_START");
				break;	
				
			case GID_VMEXIT:
				if( Str_Cmp(stSc.SEND_YN, "N") == 0 || Str_Cmp(stSc.SEND_YN, "") == 0 )
				{
					g_Exit_DelScData();
					return;
				}
				
				g_Exit();
				
				break;
			
			/********************************/
			/* ���ұ� ���� ȭ��             */
			/********************************/
			case BID_PREVLST:
				m_lpage--;
				
				if(m_lpage < 0)
				{
					m_lpage = 0;
					break;
				}
				
				m_lSelIndex = 0;
				
				SetData();
				ON_DRAW();
				break;
				
			case BID_NEXTLST:
				m_lpage++ ;
				
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
					
					if(m_lpage < 0)
					{
						m_lpage = 0;
					}

					break;
				}
				
				m_lSelIndex = 0;
				
				SetData();
				ON_DRAW();
				break; 
				
			case BID_DELCANCEL:
				g_lSCMoveFlag = 1;
				g_lNewBurFlag = 2;
				
				SaveInput();
				
				g_nProdMoveFlag = 1;
				Card_Move("SC_NODEL");
				
				break;
				
			case BID_DELETE:
				if( m_lTotpage == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "���ұⰡ �����ϴ�.");
				}
				else
				{
					if( m_lSelIndex != -1 )
					{
						if( Str_Cmp(m_szChk_Rslt, "N") == 0 )
						{
							MessageBoxEx (CONFIRM_OK, "������ ���ұ�� �����Ұ� �մϴٴ�.");
						}
						else if( MessageBoxEx (CONFIRM_YESNO, "�����Ͻðڽ��ϱ�??")  == MB_OK )
						{
							m_lpage = 0;
							m_lSelIndex = 0;
							Del_Bur();
							
							SetData();
							ON_DRAW();
							
							Find_Burner_Class_Cd();
						}
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "���ұ⸦ �������ּ���.");
					}
				}
				
				break;
				
			case BID_CHANGE:
				if( m_lTotpage == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "���ұⰡ �����ϴ�.");
				}
				else
				{
					if( m_lSelIndex != -1 )
					{
						m_lIdxFlag = 1;
						SaveInput();
						ON_EXIT();
						OnInit(INIT_BN);
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "���ұ⸦ �������ּ���.");
					}
				}
				
				break;
				
			case BID_NEW:
				m_lIdxFlag = 1;
				SaveInput();
				
				ON_EXIT();
				OnInit(INIT_BN);
				break;
				
			case BID_BNCHK:
				if( m_lTotpage == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "���ұⰡ �����ϴ�.");
				}
				else
				{
					SaveInput();
					ON_EXIT();
					OnInit(INIT_BNCHK);
				}
				
				break;
				
			case BID_OK1:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_BUR WHERE CHK_EXEC_NUM ='%s' AND (CHK_RSLT ='' OR CHK_RSLT IS NULL) AND BURNER_KIND_NUM NOT IN ('201', '301') AND (INST_FLAG <> '30' or INST_FLAG IS NULL or INST_FLAG = '') ", g_szCHK_EXEC_NUM, 0, 0);
				g_Sql_RetInt( szSql, &lCnt );
				
				if( lCnt > 0)
				{
					MessageBoxEx (CONFIRM_OK, "���ұ� �����ϼ���!!");
				}
				else
				{
					if( Update_Result() > 0 )
					{
						Card_Move("SC_START");
					}
				}
				
				break;
				
			case BID_PHOTO:
				Shoto_Photo();
				break;
				
			case BID_BUR_PHOTO:
				Shoto_Bur_Photo();
				break;
				
			case BID_PROD:
				g_nProdMoveFlag = 1;
				Card_Move("SC_PRODCHG");
				break;
			
			case BID_BUR_PHOTO_OLD:
				
				if( m_lBunPhoto_Old == 1 )
				{
					if( MessageBoxEx(CONFIRM_YESNO, "���� ���ұ� ���� ������\n���ðڽ��ϱ�?") == MB_OK)
					{
						Snd_FR311328();	
					}
				}
				
				break;
			
			/********************************/
			/* ���ұ� �ű�/���� ���        */
			/********************************/
			case BID_INSTYMD:
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));		
				Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
				Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
				k = Str_AtoI(sztmp);			
			
				Load_Calendar_Card();
				d = CalendarDialog( &k );
				Unload_Calendar_Card();
				
				if(d == 0)
				{
					break;
				}
				else
				{
					Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
					Str_ItoA ( d, sztmp, 10);
					
					Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
					Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
					Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
					Mem_Cpy((byte *)szYear, (byte *)sztmp, 4);
					Mem_Cpy((byte *)szMonth, (byte *)sztmp+4, 2);
					Mem_Cpy((byte *)szDay, (byte *)sztmp+6, 2);
					
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szYear );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szMonth );
					EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szDay );
				}
				
				break;
				
			case BID_CANCLE:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
				
			case BID_WRITE:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA1), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
				break;	
			
			case BID_WRITE2:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_DATA6), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)) );
				break;	

			case BID_OK2:		//����
			case BID_OK3:		//�űԵ��
				ShowSip(FALSE);
				g_Sipflag = 0;

				if( ID == BID_OK2 )
				{
					if( !Compare_Data() )
					{
						if( Chg_Bur() )
						{
							Find_Burner_Class_Cd();
						}
					}
					else
					{
						ON_EXIT();
						OnInit(INIT_MAIN);
					}
				}
				else if( ID == BID_OK3 )
				{
					if( New_Bur() )
					{
						Find_Burner_Class_Cd();
					}
				}
				
				break;
			
			/********************************/
			/* ���ұ� ����                  */
			/********************************/
			case BID_HOSECHK:
				g_nWorkChkFlag = 13;
				g_lSCMoveFlag = 1;
				Str_Cpy(stScNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stScNogood.CHK_SEC_CD, "60");
				Str_Cpy(stScNogood.MTR_NUM, stScBur.MTR_NUM);
				Str_Cpy(stScNogood.BURNER_NUM, stScBur.BURNER_NUM);
				Str_Cpy(stScNogood.CHK_SEC_NM, "ȣ��");
				Card_Move("CHK_DTL");
				break;
				
			case BID_BURCHK:
				g_nWorkChkFlag = 14;
				g_lSCMoveFlag = 1;
				Str_Cpy(stScNogood.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
				Str_Cpy(stScNogood.CHK_SEC_CD, "51");
				Str_Cpy(stScNogood.MTR_NUM, stScBur.MTR_NUM);
				Str_Cpy(stScNogood.BURNER_NUM, stScBur.BURNER_NUM);
				Str_Cpy(stScNogood.CHK_SEC_NM, "���ұ�");
				Card_Move("CHK_DTL");
				break;
				
			case BID_CLOSE:
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
				
			case BID_CHKSAVE:
				if( Save_Bun() )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				break;
				
			/********************************/
			/* ���ұ� ���Ż���              */
			/********************************/	
			case BID_PHOTO_CLOSE:
				g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
				g_DirFS_Clear(PHOTO_WORK, "*");
				
				ON_EXIT();
				OnInit(INIT_MAIN);
				break;
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnChar
	��  �� : üũ
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar(long nChar)
	{
		char szVc[10];
		char szTmp[10];
		long nRet = 0;
		long nDate = 0;
		
		/********************************/
		/* ���ұ� ����                  */
		/********************************/
		if( m_bFirst == INIT_BN )
		{
			if( Get_iDlgCtrlByID(EDT_DATA2) == m_lActiveIndex 
			 || Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex
			 || Get_iDlgCtrlByID(EDT_DATA4) == m_lActiveIndex
			 || Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex )
			{
				//���ڸ� �Է� ����
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					ON_KEY( 5 );
					return;
				}
			}
			
			if( Get_iDlgCtrlByID(EDT_DATA3) == m_lActiveIndex )
			{
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA3)) == 4 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA4));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA4) == m_lActiveIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)), 1);
				if( Str_AtoI(szTmp) > 1 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 12) )
				{
					ON_KEY( 5 );
					return;
				}
				
				if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4)) == 2 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}
			else if( Get_iDlgCtrlByID(EDT_DATA5) == m_lActiveIndex )
			{
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)), 1);
				if( Str_AtoI(szTmp) > 3 )
				{
					ON_KEY( 5 );
					return;
				}
				
				Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
				Mem_Cpy((byte *)szTmp, (byte *)EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)), 2);
				if( Str_Len(szTmp) > 1 && (Str_AtoI(szTmp) == 0 || Str_AtoI(szTmp) > 31) )
				{
					ON_KEY( 5 );
					return;
				}
			}
	
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
			Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
			
			if( Str_Len(szTmp) == 8 )
			{
				Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
				nDate = Str_AtoI(szTmp);
				nRet = Time_ValidateDate(nDate);
				
				if( nRet == 0 )
				{
					MessageBoxEx (CONFIRM_OK, "��ȿ�� ��¥�� �ƴմϴ�.\n��¥�� Ȯ�����ּ���.");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA3), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA4), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA5), "");
					
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA3));
					m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
			}

			ON_DRAW();
			
			return;
		}
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

		m_lActiveIndex = lActiveIndex;

		if( m_bFirst == INIT_BN )
		{
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+350) && X < DMS_X(STARTX+600) && Y > DMS_Y(STARTY+291) && Y < DMS_Y(STARTY+371) ||
						X > DMS_X(STARTX+350) && X < DMS_X(STARTX+525) && Y > DMS_Y(STARTY+371) && Y < DMS_Y(STARTY+451) ||
						X > DMS_X(STARTX+543) && X < DMS_X(STARTX+145) && Y > DMS_Y(STARTY+371) && Y < DMS_Y(STARTY+451) ||
						X > DMS_X(STARTX+705) && X < DMS_X(STARTX+850) && Y > DMS_Y(STARTY+371) && Y < DMS_Y(STARTY+451) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA2) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA3) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex ||
							Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex )	
						{
							ShowSip(FALSE);
							g_Sipflag = 0;
							
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
					}
					// �ű�
					else if (X > DMS_X(STARTX+350) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+451) && Y < DMS_Y(STARTY+521))
					{
						PRINT("m_szTxtm_szTxtm_szTxtm_szTxt : %s",m_szTxt,0,0);
						if( Str_Cmp(m_szTxt, "20") == 0)
						{
							SetComboMaker();
						}
					}
					// DLG_COMBO (STARTX+350, STARTY+131, 650, 200, 150, 80,    TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_DATA2, 10),
					else if (X > DMS_X(STARTX+350) && X < DMS_X(STARTX+1000) && Y > DMS_Y(STARTY+131) && Y < DMS_Y(STARTY+201))
					{
						PRINT("44444444444444",0,0,0);
						PRINT("m_szTxtm_szTxtm_szTxtm_szTxt :%s",m_szTxt,0,0);
						if( Str_Cmp(m_szTxt, "10") == 0)
						{
							SetComboMaker();
						}
						
					}
					else
					{
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
				}
				else if( theDevInfo.m_nType == FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+400) && X < DMS_X(STARTX+950) && Y > DMS_Y(STARTY+240) && Y < DMS_Y(STARTY+320) )
					{
						if( Get_iDlgCtrlByID(EDT_DATA1) == lActiveIndex )
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
					
					ON_DRAW();
				}
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : OnSelect
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void OnSelect( long Index )
	{
		long index;
		long lCnt = 0;
		long i = 0;
		char szSql[300];

		/********************************/
		/* ���ұ� ���� ȭ��             */
		/********************************/
		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				m_lSelIndex = index - 1;
				g_nActRow = m_lpage*ROW + m_lSelIndex;
				
				Str_Cpy(stScBur.MTR_ID_NUM		, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));
				Str_Cpy(stScBur.BURNER_NUM 		, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
				Str_Cpy(stScBur.MTR_NUM 		, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));

				SetClickData();
			}
			else
			{
				//������
				Mem_Set( (byte*)stScBur.FUSE_COCK_INST_YN, 0x00, sizeof(stScBur.FUSE_COCK_INST_YN) );
				i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6)), SC_MTRFUSE );
				
				if (i == -1)
				{
					Str_Cpy(stScBur.FUSE_COCK_INST_YN, "");
				}
				else
				{
					Str_Cpy(stScBur.FUSE_COCK_INST_YN, SC_MTRFUSE[i].Code);
					
					//2018.01.22 CS�� �̼��� ����� ��û : ������ũ �̼�ġ ���� �� ��� ����	
					if( i == 1 )
					{
						MessageBoxEx (CONFIRM_OK, "������ �̼�ġ�� ������ ����Դϴ�.\nȮ���Ͻñ� �ٶ��ϴ�.");		
					} 
				}
				
				//Ÿ�̸���
				Mem_Set( (byte*)stScBur.TIMER_COCK_INST_YN, 0x00, sizeof(stScBur.TIMER_COCK_INST_YN) );
				
				i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7)), SCTIMER_COCK );
				
				if (i == -1)
				{
					Str_Cpy(stScBur.TIMER_COCK_INST_YN, "");
				}
				else
				{
					Str_Cpy(stScBur.TIMER_COCK_INST_YN, SCTIMER_COCK[i].Code);
				}
				
				//�ֹ��ڵ���ȭ��ġ
				Mem_Set( (byte*)stSc.KIT_AUTO_EXTINGU_INST_YN, 0x00, sizeof(stSc.KIT_AUTO_EXTINGU_INST_YN) );
				
				i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_KIT_SPRINKLER)), SCKITAUTOSPRIN );
				
				if (i == -1)
				{
					Str_Cpy(stSc.KIT_AUTO_EXTINGU_INST_YN, "");
				}
				else
				{
					Str_Cpy(stSc.KIT_AUTO_EXTINGU_INST_YN, SCKITAUTOSPRIN[i].Code);
				}
				
				//�ش� �޺��ڽ� ���� �� �����տ��� �ش� ���� Ż���ֵ��� �ڵ�
				if( Get_iDlgCtrlByID(CMB_DATA8+1) == m_lActiveIndex )
				{
					if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)), "������") == 0 )
					{
						Save_NotPassItem();

						//������ ���ý�, ���� ȣ��
						Shoto_Photo();
						
						EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(CMB_DATA8), RED);
						//ī�޶� ���� ���� �� ī�޶� �����Կ��� ������ ��츦 ����� �ڵ�
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE );
					}
					else
					{
						if(  MessageBoxEx (CONFIRM_YESNO, "[�÷��׸����̺�]\n�����ջ����� �����˴ϴ�.\n�����Ͻðڽ��ϱ�?")  == MB_OK )
						{
							g_nPhotoFlag = 0;
							Del_Plug_Nogood();
							CockDraw();
						}
						else
						{
							EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(CMB_DATA8), RED);
							EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA8)   , "������");
						}
					}
				}
			}
		}
		
		ON_DRAW();
		
		return;
	}

	/*=======================================================================================
	�Լ��� : OnTask
	��  �� : ���� Ȯ��
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
			/********************************/
			/* ���ұ� ���� ȭ��             */
			/********************************/
			if( INIT_MAIN == m_bFirst )
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
						SPRINT (g_szphoto, "%s/%s", PHOTO_SC,  m_szfilenm, 0);
					}
	
					if( FFS_Exist(szPhotopath) )
					{
						FFS_Copy(szPhotopath, g_szphoto);
						FFS_Delete(szPhotopath);
						
						ON_DRAW();
						MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
						
						CockDraw();
					}
				}
			}
			/********************************/
			/* ���ұ� ���Ż���              */
			/********************************/
			else if( INIT_BUNPHOTO_OLD == m_bFirst )
			{
				PhotoDraw();
			}
		}

		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : OnUart
	��  �� : ī�޶�
	Param  : 
	Return : 
	========================================================================================*/
	void OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		char szTmp[256];
		char szTmp2[256];
		
		int size = 0;
		
		if( m_bFirst == INIT_MAIN )
		{
			if (nEvent == UART_CAMERA)
			{
				if( nData == 1 )
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
							MessageBoxEx(MESSAGE, "������ �������Դϴ�.");
							
							FFS_Copy(szfilenm, g_szphoto);
							VmSleep(100);
							
							// ���ұ� ����
							if( m_lphoto_flag == 0 )
							{
								Mem_Set((byte*)stSc.PHOTO_BUR_YN, 0x00, sizeof(stSc.PHOTO_BUR_YN));
								Str_Cpy(stSc.PHOTO_BUR_YN, "Y");
								
								Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
								SPRINT(szTmp, "UPDATE NORMAL_DATA SET PHOTO_BUR_YN = 'Y' WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0);
								g_Sql_DirectExecute(szTmp); 
								VmSleep(100);
							}
						
							VmSleep(100);
							FFS_Delete( szfilenm );
							VmSleep(100);
							
							CockDraw();
						}
					}
				}
			}	
		}
		
		return;
	}
	
	//-----------------------------------------------------------------------------------------------
	// �Ϲ� FUCTION
	//-----------------------------------------------------------------------------------------------
	
	/*=======================================================================================
	�Լ��� : SetBtnImg
	��  �� : ��ư �̹���
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		void* h;
		
		/********************************/
		/* ���ұ� ���� ȭ��             */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
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
		else
		{
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		}
	}

	/*=======================================================================================
	�Լ��� : SetStyle
	��  �� :��Ÿ�� SETTING
	Param  : 
	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		char szProd[5];
		char szSql[50];
		
		/********************************/
		/* ���ұ� ���� ȭ��             */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKENUM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TYPE2), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MAKECMPN), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MODELNM), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_VOLUME), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INSDT), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATATYPE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA44), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_KIT_SPRINKLER), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA6), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA7), EDITALIGN_MIDDLE);
			
			if( Str_Cmp(stSc.CENTER_CD, "41") == 0 || Str_Cmp(stSc.CENTER_CD, "42") == 0 || Str_Cmp(stSc.CENTER_CD, "43") == 0 || Str_Cmp(stSc.CENTER_CD, "44") == 0 || Str_Cmp(stSc.CENTER_CD, "45") == 0 || Str_Cmp(stSc.CONT_STS_CD, "30") == 0)
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PROD), FALSE);
			}	
			else
			{
				Mem_Set((byte*)szProd, 0x00, sizeof(szProd));
				Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
				
				SPRINT(szSql, "SELECT PROD_CD FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0);
	
				g_Sql_RetStr(szSql, 10, szProd);
	
				if( Str_Cmp(szProd, "11") == 0 || Str_Cmp(szProd, "12") == 0 || Str_Cmp(szProd, "13") == 0 || Str_Cmp(szProd, "81") == 0
				   || Str_Cmp(szProd, "82") == 0 || Str_Cmp(szProd, "83") == 0)
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PROD), TRUE);
				}
				else
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_PROD), FALSE);
				}
			}
			
		}
		/********************************/
		/* ���ұ� ����                  */
		/********************************/
		else if( m_bFirst == INIT_BNCHK )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA45), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA46), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
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
		char szSql[300];
		char sztmp[100];
		long i;
		
		/********************************/
		/* ���ұ� ���� ȭ��             */
		/********************************/
		if( m_bFirst == INIT_MAIN )
		{
			//������
			for ( i = 0 ;  SC_MTRFUSE[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA6+2), SC_MTRFUSE[i].Str, 0, ICON_NONE);
			}
			
			//Ÿ�̸���
			for ( i = 0 ;  SCTIMER_COCK[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA7+2), SCTIMER_COCK[i].Str, 0, ICON_NONE);
			}
			
			//�÷��׸����̺�
			for ( i = 0 ;  SC_GASCHK[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA8+2), SC_GASCHK[i].Str, 0, ICON_NONE);
			}			
			
			//�ֹ��ڵ���ȭ��ġ
			for ( i = 0 ;  SCKITAUTOSPRIN[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_KIT_SPRINKLER+2), SCKITAUTOSPRIN[i].Str, 0, ICON_NONE);
			}
			
		}
		/********************************/
		/* ���ұ� �ű�/���� ���        */
		/********************************/
		else if( m_bFirst == INIT_BN )
		{
			ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA1+2));
			ListCtrl_ResetAllItems (Get_hDlgCtrlByID(CMB_DATA3+2));
			
			//����
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM NOT IN ('201', '301') ORDER BY BURNER_KIND_NM",0, 0, 0   );		
			g_Sql_SetCombo(szSql, CMB_DATA1+2);
			
			//�뷮����
			for ( i = 0 ;  SCBOIL_CAPA[i].Str[0] != 0 ; i++)
			{
				ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_DATA3+2), SCBOIL_CAPA[i].Str, 0, ICON_NONE);
			}
		}
	}

	void SetComboMaker(void)
	{	
		char szSql[300];
		char sztmp[100];
		long i;
		
		//�������
		// Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		// SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BOILER_SEQ ",0, 0, 0   );
		
		//�ű�
		if( Str_Cmp(m_szTxt, "20") == 0)
		{
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DATA4+2 ) );
	
			Str_Cpy( sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)) );	

			PRINT("sztmpsztmpsztmp : %s",sztmp,0,0);

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			
			Str_Cpy( szSql, "SELECT MAKER_NM FROM USE_MAKER" );
			Str_Cat( szSql, " WHERE MAKER_FLAG = '50'" );
			Str_Cat( szSql, " AND MAKER_NM LIKE '%" );
			Str_Cat( szSql, sztmp );
			Str_Cat( szSql, "%'" );
			Str_Cat( szSql, " ORDER BY BOILER_SEQ" );

			PRINT("szSqlszSqlszSql : %s",szSql,0,0);

			g_Sql_SetCombo(szSql, CMB_DATA4+2);
		}
		else if( Str_Cmp(m_szTxt, "10") == 0)
		{
			PRINT("222222222222222",0,0,0);
			ListCtrl_ResetAllItems( Get_hDlgCtrlByID(CMB_DATA2+2 ) );
		
			Str_Cpy( sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)) );	

			PRINT("sztmpsztmpsztmp : %s",sztmp,0,0);

			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			
			Str_Cpy( szSql, "SELECT MAKER_NM FROM USE_MAKER" );
			Str_Cat( szSql, " WHERE MAKER_FLAG = '50'" );
			Str_Cat( szSql, " AND MAKER_NM LIKE '%" );
			Str_Cat( szSql, sztmp );
			Str_Cat( szSql, "%'" );
			Str_Cat( szSql, " ORDER BY BOILER_SEQ" );

			PRINT("szSqlszSqlszSql : %s",szSql,0,0);

			g_Sql_SetCombo(szSql, CMB_DATA2+2);
		}

	
		return;
	}
	
	/*=======================================================================================
	�Լ��� : SetData
	��  �� : ���ұ� ������ SETTING
	Param  : 
	Return : 
	========================================================================================*/
	void SetData(void)
	{
		long i, idx, j;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		char sztmp[200];
		char szSql[800];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		Mem_Set((byte*)&stScBur, 0x00, sizeof(stScBur));
		
		//������
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(sztmp, "SELECT COUNT(*) FROM NORMAL_BUR WHERE CHK_EXEC_NUM = '%s' AND (CHG_FLAG <> '3' OR CHG_FLAG IS NULL) AND BURNER_KIND_NUM NOT IN (201, 301) ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt( sztmp, &m_lTotpage );
		
		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}

		if(m_lIdxFlag == 1 || g_lSCMoveFlag == 1)
		{
			m_lpage = g_nActRow / ROW;
			m_lSelIndex = (g_nActRow % ROW);
			
			m_lIdxFlag = 0;
			g_lSCMoveFlag = 0;
			m_lDrawFlag = 1;
		}

		SPRINT(m_szCnt_page, "%d/%d", m_lpage+1, m_lTotpage, 0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT MTR_ID_NUM, BURNER_KIND_NUM, BURNER_CLASS_NM, CHK_RSLT, BURNER_NUM, MTR_NUM \
					  	 FROM NORMAL_BUR WHERE CHK_EXEC_NUM = '%s' AND (INST_FLAG <> '30' or INST_FLAG IS NULL or INST_FLAG = '') \
						  AND BURNER_KIND_NUM NOT IN (201, 301) ORDER BY SEQ DESC, BURNER_NUM LIMIT ?, ? "
		, g_szCHK_EXEC_NUM, 0, 0);

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		i = 0;
		lstartidx = m_lpage*ROW;
		sql->Bind(sql, i++, 'X', &lstartidx, 4, DECRYPT);
		j = m_lpage*ROW+ROW;
		sql->Bind(sql, i++, 'X', &j, 4, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		for ( i = 0; i < ROW; i++ )
		{
			if( k == i )
			{
				k++;
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, "" );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, "" );
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
				
				// �⹰��ȣ
				idx = 0;
				Mem_Set( (byte*)stScBur.MTR_ID_NUM, 0x00, sizeof(stScBur.MTR_ID_NUM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScBur.MTR_ID_NUM, 20 + 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, stScBur.MTR_ID_NUM );
				
				// ����
				Mem_Set( (byte*)stScBur.BURNER_KIND_NUM, 0x00, sizeof(stScBur.BURNER_KIND_NUM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_KIND_NUM, 3+ 1, DECRYPT );	
				
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM = '%s'  ",stScBur.BURNER_KIND_NUM, 0, 0   );
				g_Sql_RetStr( szSql, 20, sztmp );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				
				// �뵵
				Mem_Set( (byte*)stScBur.BURNER_CLASS_NM, 0x00, sizeof(stScBur.BURNER_CLASS_NM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_CLASS_NM, 20+ 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 2, stScBur.BURNER_CLASS_NM );
				
				// ����
				Mem_Set( (byte*)stScBur.BURNER_CLASS_NM, 0x00, sizeof(stScBur.BURNER_CLASS_NM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScBur.CHK_RSLT, 2+ 1, DECRYPT );
				
				if( Str_Cmp(stScBur.CHK_RSLT, "Y") == 0 )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 3 ), GREEN);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "����" );
				}
				else if( Str_Cmp(stScBur.CHK_RSLT, "N") == 0 )
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 3 ), RED);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "������" );
				}
				else
				{
					EditCtrl_SetForeColorEx( DlgTbl_GetHandle( ID_TBLLIST, i, 3 ), TXTFRCOLOR);
					DlgTbl_SetStr ( ID_TBLLIST, i, 3, "��Ȯ��" );
				}

				// ���ұ��ȣ
				Mem_Set( (byte*)stScBur.BURNER_NUM, 0x00, sizeof(stScBur.BURNER_NUM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_NUM            , 6+ 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, stScBur.BURNER_NUM );
				
				// �跮���ȣ
				Mem_Set( (byte*)stScBur.MTR_NUM, 0x00, sizeof(stScBur.MTR_NUM) );
				sql->GetValue( sql, idx++, 'U', (long*) stScBur.MTR_NUM            , 9+ 1, DECRYPT );
				DlgTbl_SetStr ( ID_TBLLIST, i, 5, stScBur.MTR_NUM );
			}
		}
		
Finally:
		DelSqLite(sql);

		//2017-07-31 Sanghyun Lee
		//Ÿ�̸���, ������ �����ʹ� NORMAL_MTR ���̺��� ������(���ұⰡ �������� ���� �� �ֱ⶧����)
		//Ÿ�̸���
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)stScBur.TIMER_COCK_INST_YN, 0x00, sizeof(stScBur.TIMER_COCK_INST_YN) );
		SPRINT(szSql, "SELECT TIMER_COCK_INST_YN FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetStr( szSql, 20, stScBur.TIMER_COCK_INST_YN );

		//������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)stScBur.FUSE_COCK_INST_YN, 0x00, sizeof(stScBur.FUSE_COCK_INST_YN) );
		SPRINT(szSql, "SELECT FUSE_COCK_INST_YN FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetStr( szSql, 20, stScBur.FUSE_COCK_INST_YN );
		
		//�ֹ��ڵ���ȭ��ġ
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)stSc.KIT_AUTO_EXTINGU_INST_YN, 0x00, sizeof(stSc.KIT_AUTO_EXTINGU_INST_YN) );
		SPRINT(szSql, "SELECT KIT_AUTO_EXTINGU_INST_YN FROM NORMAL_DATA WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetStr( szSql, 20, stSc.KIT_AUTO_EXTINGU_INST_YN );

		if(m_lTotpage > 0)
		{
			if( m_lSelIndex == -1 )
			{
				m_lSelIndex = 0;
			}
		
			DlgTbl_SetActive(ID_TBLLIST , m_lSelIndex+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lSelIndex+1, TABLEACTIVE_COLOR);
			
			Str_Cpy(stScBur.MTR_ID_NUM		, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 0));
			Str_Cpy(stScBur.BURNER_NUM 		, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 4));
			Str_Cpy(stScBur.MTR_NUM 		, DlgTbl_GetStr( ID_TBLLIST, m_lSelIndex, 5));

			SetClickData();	

			g_nActRow = m_lpage*ROW + m_lSelIndex;	
		}
		else
		{
			Clear_Screen();
		}
		
		//ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	�Լ��� : SetClickData
	��  �� : ���ұ⸦ ���������� ������ ���� ����
	Param  : 
	Return : 
	========================================================================================*/	
	void SetClickData(void)
	{
		long i, idx, j;
		long n;
		long k = ROW+1;
		long lstartidx;
		long lindex = 0;
		char szSql[500];
		char sztmp[100];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		//BURNER_KIND_NUM = 201 || 301 �̸� ���Ϸ�, �������� ���ұ�
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT MAKE_NUM, BURNER_KIND_NUM, MAKER_NUM, BURNER_MODEL_NM, BURNER_CAPA \
							 , BURNER_CAPA_UNIT, BURNER_INST_YMD, CHG_FLAG, MTR_ID_NUM, MTR_NUM \
							 , BURNER_NUM, CHK_RSLT \
		                  FROM NORMAL_BUR WHERE CHK_EXEC_NUM = ? AND BURNER_NUM = '%s' AND MTR_NUM = '%s' AND BURNER_KIND_NUM NOT IN (201, 301) "
		            , stScBur.BURNER_NUM, stScBur.MTR_NUM, 0);
		            
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		sql->Bind(sql, i++, 'U', (long*)&g_szCHK_EXEC_NUM, 12, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE)
		{
			idx = 0;
			
			//�������ȣ
			Mem_Set( (byte*)stScBur.MAKE_NUM, 0x00, sizeof(stScBur.MAKE_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.MAKE_NUM              , 30+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16)   , stScBur.MAKE_NUM);
			
			//����
			Mem_Set( (byte*)stScBur.BURNER_KIND_NUM, 0x00, sizeof(stScBur.BURNER_KIND_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_KIND_NUM       , 3+ 1, DECRYPT );	

			//������
			Mem_Set( (byte*)stScBur.MAKER_NUM, 0x00, sizeof(stScBur.MAKER_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.MAKER_NUM             , 5 + 1, DECRYPT );

			//�𵨸�
			Mem_Set( (byte*)stScBur.BURNER_MODEL_NM, 0x00, sizeof(stScBur.BURNER_MODEL_NM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_MODEL_NM       , 50 + 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19)   , stScBur.BURNER_MODEL_NM);
			
			//�뷮
			Mem_Set( (byte*)stScBur.BURNER_CAPA, 0x00, sizeof(stScBur.BURNER_CAPA) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_CAPA           , 10+ 1, DECRYPT );
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20)   , stScBur.BURNER_CAPA);
			
			//�뷮����
			Mem_Set( (byte*)stScBur.BURNER_CAPA_UNIT, 0x00, sizeof(stScBur.BURNER_CAPA_UNIT) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_CAPA_UNIT   , 2+ 1, DECRYPT );
			n = g_SearchCD( stScBur.BURNER_CAPA_UNIT, SCBOIL_CAPA );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), SCBOIL_CAPA[n].Str);
			
			//��ġ����
			Mem_Set( (byte*)stScBur.BURNER_INST_YMD, 0x00, sizeof(stScBur.BURNER_INST_YMD) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_INST_YMD       , 8 + 1, DECRYPT );
			g_Str_DateType( sztmp, stScBur.BURNER_INST_YMD);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), sztmp);
			
			//�ڷᱸ��
			Mem_Set( (byte*)stScBur.CHG_FLAG, 0x00, sizeof(stScBur.CHG_FLAG) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.CHG_FLAG              , 1 + 1, DECRYPT );
			n = g_SearchCD( stScBur.CHG_FLAG, SCCHG_FLAG );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), SCCHG_FLAG[n].Str);
			
			//�⹰��ȣ
			Mem_Set( (byte*)stScBur.MTR_ID_NUM, 0x00, sizeof(stScBur.MTR_ID_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.MTR_ID_NUM            , 20 + 1, DECRYPT );
			
			//�跮���ȣ
			Mem_Set( (byte*)stScBur.MTR_NUM, 0x00, sizeof(stScBur.MTR_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.MTR_NUM               , 9 + 1, DECRYPT );
				
			//���ұ��ȣ
			Mem_Set( (byte*)stScBur.BURNER_NUM, 0x00, sizeof(stScBur.BURNER_NUM) );
			sql->GetValue( sql, idx++, 'U', (long*) stScBur.BURNER_NUM            , 6+ 1, DECRYPT );
			
			//���˰��
			Mem_Set( (byte*)m_szChk_Rslt, 0x00, sizeof(m_szChk_Rslt) );
			sql->GetValue( sql, idx++, 'U', (long*) m_szChk_Rslt            , 1+ 1, DECRYPT );

		}

		//����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM = '%s'  ",stScBur.BURNER_KIND_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17)   , sztmp);

		//������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NUM = '%s' ",stScBur.MAKER_NUM, 0, 0);
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18)   , sztmp);

Finally:
		
		DelSqLite(sql);
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : BUN_DRAW
	��  �� : ���ұ� �űԻ���/���� ���÷���
	Param  : 
	Return : 
	========================================================================================*/	
	void BUN_DRAW(long nbuttonid)
	{
		char szSql[300];
		char szDP[11];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA47), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA1), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA2), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA3), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);

		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA1), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA2), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA3), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
		//����
		if( nbuttonid == BID_CHANGE )
		{	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_TITLE), "���ұ� ����");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), "�⹰��ȣ");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA26), "�������");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA33), "����");

			//m_szTxt
			Str_Cpy( m_szTxt, "10" );
			
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4+1), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA34), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_OK2), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_OK3), FALSE);
			
			//�������
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BURNER_SEQ ",0, 0, 0   );
			g_Sql_SetCombo(szSql, CMB_DATA2+2);
			
			CHG_DRAW();
		}
		//�űԵ��
		else
		{	
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_DATA4), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_TITLE), "���ұ� �űԵ��");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), "���ұ��ȣ");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA26), "�⹰��ȣ");
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA33), "�������");

			Str_Cpy( m_szTxt, "20" );
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA4), TRUE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA34), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_OK2), FALSE);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_OK3), TRUE);
			
			//�⹰��ȣ
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT MTR_ID_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ",g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_SetCombo(szSql, CMB_DATA2+2);
			
			//�������
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' ORDER BY BURNER_SEQ ",0, 0, 0   );
			g_Sql_SetCombo(szSql, CMB_DATA4+2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2), ListCtrl_GetStr( Get_hDlgCtrlByID(CMB_DATA2+2), 0) );
			EditCtrl_SetStr (Get_hDlgCtrlByID(CMB_DATA3), SCBOIL_CAPA[0].Str);

			Mem_Set((byte*)szDP, 0x00, sizeof(szDP));
			Str_ItoA(Time_GetDate(), szDP, 10);
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Mem_Cpy((byte *)szYear, (byte *)szDP, 4);
			Mem_Cpy((byte *)szMonth, (byte *)szDP+4, 2);
			Mem_Cpy((byte *)szDay, (byte *)szDP+6, 2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szYear );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szMonth );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szDay );
		}
	}
	
	/*=======================================================================================
	�Լ��� : CockDraw
	��  �� : �÷��׸����̺�, ������, Ÿ�̸��� Draw
	Param  : 
	Return : 
	========================================================================================*/	
	void CockDraw(void)
	{
		long i = 0;
		long lCount = 0;
		char szFilePath[256];
		char szNOT_PASS_ITEM_CD[5];
		char szChk_Sec_Cd[5];
		char szTmp[200];
		char szProd_cd[100];
		
		/*************************************/
		/* ���� ���ϸ� ����                  */
		/*************************************/
		Mem_Set((byte*)szFilePath ,0x00, sizeof(szFilePath) );
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Mem_Set((byte*)szChk_Sec_Cd ,0x00, sizeof(szChk_Sec_Cd) );
		Str_Cpy( szNOT_PASS_ITEM_CD, "50" );
		Str_Cpy( szChk_Sec_Cd, "60" );
		
		Mem_Set( (byte*)szFilePath, 0x00, sizeof(szFilePath) );
		Mem_Set((byte*)m_szMtrNum ,0x00, sizeof(m_szMtrNum) );
		SPRINT(szFilePath, "SELECT MTR_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szFilePath, 20, m_szMtrNum );
		
		Str_Cpy(szFilePath , "1");
		Str_Cat(szFilePath , "_");
		Str_Cat(szFilePath , g_szCHK_EXEC_NUM);
		Str_Cat(szFilePath , "_");
		
		if(Str_Len(m_szMtrNum) > 0)
		{
			Str_Cat(szFilePath , m_szMtrNum);
		}
		else
		{
			Str_Cat(szFilePath , "000000000");
		}
		
		Str_Cat(szFilePath , "_");
		Str_Cat(szFilePath , "000000");		// burner_num > �÷��׸����̺� ����
		Str_Cat(szFilePath , "_");
		Str_Cat(szFilePath , szChk_Sec_Cd);
		Str_Cat(szFilePath , "_");
		Str_Cat(szFilePath , szNOT_PASS_ITEM_CD);
		Str_Cat(szFilePath , ".jjp");
		
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		SPRINT (m_szfilenm, "%s/%s", PHOTO_SC, szFilePath,  0);
		
		/*************************************/
		/* �÷��׸����̺�                    */
		/*************************************/
		Mem_Set((byte*)szFilePath ,0x00, sizeof(szFilePath) );
		SPRINT(szFilePath, "SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND CHK_SEC_CD ='60' AND NOT_PASS_ITEM_CD = '50' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szFilePath, &lCount);
		//PRINT("lCount : %d , szFilePath : %s",lCount,szFilePath,0);
		
		// �÷��׸����̺� ������
		if( lCount > 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA8), SC_GASCHK[1].Str);
			
			Mem_Set((byte*)stScBur.PLUG_NOGOOD_YN ,0x00, sizeof(stScBur.PLUG_NOGOOD_YN) );
			Str_Cpy(stScBur.PLUG_NOGOOD_YN, "N");
			
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(CMB_DATA8), RED);
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE );
		}
		// �÷��׸����̺� ����
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA8), SC_GASCHK[0].Str);

			Mem_Set((byte*)stScBur.PLUG_NOGOOD_YN ,0x00, sizeof(stScBur.PLUG_NOGOOD_YN) );
			Str_Cpy(stScBur.PLUG_NOGOOD_YN, "Y");
			
			//�����϶� ������ �����Ѵٸ� ���� ����
			if( FFS_Exist(m_szfilenm) > 0 )
			{
				FFS_Delete(m_szfilenm);
			}
			
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(CMB_DATA8), TXTFRCOLOR);
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_PHOTO), TRUE );
		}

		if( FFS_Exist(m_szfilenm) > 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNCTRLBKCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_PHOTO), BTNMENUFRCOLOR);
		}
		
		/*************************************/
		/* ���ұ� ����, ���ϸ�               */
		/*************************************/
		Mem_Set( (byte*)szFilePath, 0x00, sizeof(szFilePath) );
	
		Str_Cpy(szFilePath , "E");
		Str_Cat(szFilePath , g_szCHK_EXEC_NUM);
		Str_Cat(szFilePath , "_");
		Str_Cat(szFilePath , stScBur.MTR_NUM);
		Str_Cat(szFilePath , "_");
		Str_Cat(szFilePath , stSc.INST_PLACE_NUM);
		Str_Cat(szFilePath , ".jjp");
		
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		SPRINT (m_szfilenm, "%s/%s", PHOTO_SCBUR, szFilePath,  0);
		
		// ���ұ� ���� ��ư VISIBLE ���� // ���ұ� ���� ���� ��ư VISIBLE
		// 1. �������°� ������ ��� �Կ�
		// 2. ��ǰ�ڵ尡 11, 12, 21�� ��� �Կ�
		if( Str_Cmp( stSc.CONT_STS_CD, "30" ) == 0 )
		{
			Mem_Set((byte*)szProd_cd, 0x00, sizeof(szProd_cd));
			Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
			
			SPRINT(szTmp, "SELECT PROD_CD FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0);

			g_Sql_RetStr(szTmp, 10, szProd_cd);
			
			if( Str_Cmp( szProd_cd, "11" ) == 0 || Str_Cmp( szProd_cd, "12" ) == 0 || Str_Cmp( szProd_cd, "21" ) == 0 
			   || Str_Cmp( szProd_cd, "81" ) == 0 || Str_Cmp( szProd_cd, "82" ) == 0)
			{
				// ���ұ� ����
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_BUR_PHOTO), TRUE);
				
				// ���ұ� ���� ����
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO_OLD), YELLOW);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO_OLD), TXTFRCOLOR);
				m_lBunPhoto_Old = 1;
			}
			else
			{
				// ���ұ� ����
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_BUR_PHOTO), FALSE);
				
				// ���ұ� ���� ����
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO_OLD), BTNCTRLMNBKCOLOR);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO_OLD), TXTFRCOLOR);
				m_lBunPhoto_Old = 0;
			}
		}
		else
		{
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_BUR_PHOTO), FALSE);
			
			// ���ұ� ���� ����
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO_OLD), BTNCTRLMNBKCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO_OLD), TXTFRCOLOR);
			m_lBunPhoto_Old = 0;
		}
		
		// ���ұ� ���� ��ư ����
		if( FFS_Exist(m_szfilenm) > 0 || Str_Cmp(stSc.PHOTO_BUR_YN, "Y") == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO), BTNMENUFRCOLOR);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO), YELLOW);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_BUR_PHOTO), TXTFRCOLOR);
		}
		
		/*************************************/
		/* �÷��׸����̺� �޺��ڽ�           */
		/*************************************/
		lCount = 0;
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		SPRINT(szTmp, "SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' AND PRE_CHK_OBJ_YN = 'Y' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szTmp, &lCount);
		
		if( ( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") == 0 && lCount <= 0 )
		 || ( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") != 0 && Str_Cmp(stSc.PREUSE_CHK_WHY, "30") != 0 ) )
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8+1), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8+1), FALSE );
		}
		else
		{
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8+1), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_DATA8+1), TRUE );
		}
		
		/***********************************************/
		/* ������, Ÿ�̸���, �ֹ��ڵ���ȭ��ġ �޺��ڽ� */
		/***********************************************/
		if( m_lDrawFlag == 1 || g_nPhotoFlag == 2 )
		{
			m_lDrawFlag = 0;
			
			//������
			i = 0;
			i = g_SearchCD( g_szFuseCock, SC_MTRFUSE );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6), SC_MTRFUSE[0].Str);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6), SC_MTRFUSE[i].Str);
			}
			
			//Ÿ�̸���
			i = 0;
			i = g_SearchCD( g_szTimerCock, SCTIMER_COCK );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), SCTIMER_COCK[i].Str);
			}
			
			// �ֹ��ڵ���ȭ��ġ
			i = 0;
			i = g_SearchCD( g_szKitsprinkler, SCKITAUTOSPRIN );
			
			if( i == -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_KIT_SPRINKLER), SCKITAUTOSPRIN[1].Str);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_KIT_SPRINKLER), SCKITAUTOSPRIN[i].Str);
			}	
		}
		else
		{
			//������
			i = 0;
			i = g_SearchCD( stScBur.FUSE_COCK_INST_YN, SC_MTRFUSE );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6), SC_MTRFUSE[0].Str);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA6), SC_MTRFUSE[i].Str);
			}

			//Ÿ�̸���
			i = 0;
			i = g_SearchCD( stScBur.TIMER_COCK_INST_YN, SCTIMER_COCK );
			if(i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), "");
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA7), SCTIMER_COCK[i].Str);
			}
				
			// �ֹ��ڵ���ȭ��ġ
			i = 0;
			i = g_SearchCD( stSc.KIT_AUTO_EXTINGU_INST_YN, SCKITAUTOSPRIN );
			
			if( i == -1 )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_KIT_SPRINKLER), SCKITAUTOSPRIN[1].Str);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_KIT_SPRINKLER), SCKITAUTOSPRIN[i].Str);
			}	
		}
		
		ON_DRAW();
		
		return;
	}

	void Set_Alarm(void)
	{
		char szSql[500];
		long cnt;
		long lChkCnt = 0;
		

		//g_szCHK_EXEC_NUM

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM NORMAL_BUR WHERE CHK_EXEC_NUM ='%s' AND BURNER_KIND_NUM NOT IN('201','301') AND MAKER_NUM ='50099' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lChkCnt);

		if( lChkCnt > 0 )
		// if(Str_Cmp( stScBur.MAKER_NUM, "50099" ) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ұ� ������ ��Ī�� Ȯ�� �� \n ���� �ٶ��ϴ�");

			// ON_EXIT();
			// OnInit(INIT_BN);
		}
		
		
		/********************************************/
		/* ���Ϸ� �𵨸�, �����翡 ���� �˸� Ȱ��ȭ */
		/********************************************/
		// 20190212 CS�� �̼��� ����� ��û( ���Ϸ� ������ = �Ե�, ���Ϸ� �𵨸� = LGB-204�� �˸� ) -> �ݿ� ���
		// ** �ʵ� ** : LIKE % ���� �Ʒ��� ���� String���� �����ؾ���, SPRINT ���� % �ν� �Ұ�
		/*
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		Str_Cpy( szSql, "SELECT COUNT(1) FROM NORMAL_BUR" );
		Str_Cat( szSql, " WHERE CHK_EXEC_NUM = '" );
		Str_Cat( szSql, g_szCHK_EXEC_NUM );
		Str_Cat( szSql, "'" );
		Str_Cat( szSql, " AND BURNER_NUM = '" );
		Str_Cat( szSql, stScBur.BURNER_NUM );
		Str_Cat( szSql, "'" );
		Str_Cat( szSql, " AND BURNER_KIND_NUM IN (201, 301)" );
		Str_Cat( szSql, " AND MAKER_NUM = '50031'" );
		Str_Cat( szSql, " AND BURNER_MODEL_NM LIKE '%LGB%'" );
		Str_Cat( szSql, " AND BURNER_MODEL_NM LIKE '%204%'" );
		
		g_Sql_RetInt( szSql, &cnt );
		
		if( cnt > 0 )
		{
			MessageBoxEx (CONFIRM_OK, "������ [�Ե�], �𵨸� [ LGB-204 ]\n����� ���� ����");
		}
		*/
		
		g_nBoil_inst_cnt++;	
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	�Լ��� : CHG_DRAW
	��  �� : ���ұ� �űԻ���/���� ���÷���
	Param  : 
	Return : 
	========================================================================================*/	
	void CHG_DRAW(void)
	{
		char sztmp[100];
		char szSql[300];
		char szDate[20];
		char szYear[5];
		char szMonth[3];
		char szDay[3];
		long i;
	
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA24), stScBur.MTR_ID_NUM);			//�⹰��ȣ

		//����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT BURNER_KIND_NM FROM BURNER_KIND WHERE BURNER_KIND_NUM = '%s'  ",stScBur.BURNER_KIND_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA1)   , sztmp);
		
		//�������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT MAKER_NM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NUM = '%s' ",stScBur.MAKER_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_DATA2)   , sztmp);
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA1), stScBur.BURNER_MODEL_NM);	//�𵨸�
		EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_DATA2), stScBur.BURNER_CAPA);		//�뷮
		
		//��ġ����
		if( Str_Cmp(stScBur.BURNER_INST_YMD, "99991231") == 0 || Str_Cmp(stScBur.BURNER_INST_YMD, "00000000") == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), "" );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), "" );
		}
		else
		{
			Mem_Set((byte*)szDate, 0x00, sizeof(szDate));
			Mem_Set((byte*)szYear, 0x00, sizeof(szYear));
			Mem_Set((byte*)szMonth, 0x00, sizeof(szMonth));
			Mem_Set((byte*)szDay, 0x00, sizeof(szDay));
			Mem_Cpy((byte *)szYear, (byte *)stScBur.BURNER_INST_YMD, 4);
			Mem_Cpy((byte *)szMonth, (byte *)stScBur.BURNER_INST_YMD+4, 2);
			Mem_Cpy((byte *)szDay, (byte *)stScBur.BURNER_INST_YMD+6, 2);
			
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA3), szYear );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), szMonth );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), szDay );
		}

		//����
		i = g_SearchCD( stScBur.BURNER_CAPA_UNIT, SCBOIL_CAPA );
		EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_DATA3), SCBOIL_CAPA[i].Str);
		
		//����
		i = g_SearchCD( stScBur.CHG_FLAG, SCCHG_FLAG );
		if( i == -1 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA34), SCCHG_FLAG[1].Str);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA34), SCCHG_FLAG[i].Str);
		}
		
		//ȭ�� ������ ���� ��Ʈ���Ŀ� ����
		SetStruct();
	}

	/*=======================================================================================
	�Լ��� : CHK_DRAW
	��  �� : ���ұ� ���� DRAW
	Param  : 
	Return : 
	========================================================================================*/
	void CHK_DRAW(void)
	{
		long lCount = 0;
		long i;
		char szSql[300];
		char sztmp[100];
	
		/********************************/
		/* ȣ�����                     */
		/********************************/
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND BURNER_NUM = '%s' AND CHK_SEC_CD ='60' AND NOT_PASS_ITEM_CD NOT IN('50')", g_szCHK_EXEC_NUM, stScBur.BURNER_NUM, 0);
		g_Sql_RetInt(szSql, &lCount);
		
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA41), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA41), "������");
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA41), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA41), "����");	
		}
		
		/********************************/
		/* ���ұ���                   */
		/********************************/
		lCount = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND BURNER_NUM = '%s' AND CHK_SEC_CD ='51' ", g_szCHK_EXEC_NUM, stScBur.BURNER_NUM, 0);
		g_Sql_RetInt(szSql, &lCount);
		
		if( lCount > 0 )
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA46), RED);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA46), "������");
		}
		else
		{
			EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(TXT_DATA46), TXTFRCOLOR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA46), "����");	
		}
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Update_Result
	��  �� : �޺��ڽ� ����
	Param  : 
	Return : 
	========================================================================================*/
	long Update_Result(void)
	{
		long lBurCnt = 0;
		long lNogoodCnt = 0;
		long lGasCnt = 0;
		long lHoseCnt = 0;
		long lBurChkCnt = 0;
		long lFlagCnt = 0;
		long lDelCnt = 0;
		long lChkCnt = 0;
		long i = 0;
		char szSql[400];
		char szSqlCat[150];
		char szFilePath[256];
		char szNOT_PASS_ITEM_CD[5];
		char szChk_Sec_Cd[5];
		char szChk[20];
		char szBurner_Num[10];
		char szProd_cd[100];
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/********** Validation ***********/
		// 1. �÷��׸����̺� : �켱������ �ƴ� ��쿡�� ���� üũ
		lChkCnt = 0;
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50' AND PRE_CHK_OBJ_YN = 'Y' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt(szSql, &lChkCnt);
		
		if( ( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") == 0 && lChkCnt <= 0 )
		 || ( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") != 0 && Str_Cmp(stSc.PREUSE_CHK_WHY, "30") != 0 ) )
		{
			if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA8)), "������") == 0 )
			{
				//�÷��׸����̺�
				//���ϸ�
				Mem_Set((byte*)szFilePath ,0x00, sizeof(szFilePath) );
				Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
				Mem_Set((byte*)szChk_Sec_Cd ,0x00, sizeof(szChk_Sec_Cd) );
				Str_Cpy( szNOT_PASS_ITEM_CD, "50" );
				Str_Cpy( szChk_Sec_Cd, "60" );

				Mem_Set( (byte*)szFilePath, 0x00, sizeof(szFilePath) );
				Mem_Set((byte*)m_szMtrNum ,0x00, sizeof(m_szMtrNum) );
				SPRINT(szFilePath, "SELECT MTR_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
				g_Sql_RetStr( szFilePath, 20, m_szMtrNum );
				
				Str_Cpy(szFilePath , "1");
				Str_Cat(szFilePath , "_");
				Str_Cat(szFilePath , g_szCHK_EXEC_NUM);
				Str_Cat(szFilePath , "_");
				
				if(Str_Len(m_szMtrNum) > 0)
				{
					Str_Cat(szFilePath , m_szMtrNum);
				}
				else
				{
					Str_Cat(szFilePath , "000000000");
				}
				
				Str_Cat(szFilePath , "_");
				Str_Cat(szFilePath , "000000");		//burner_num > �÷��׸����̺� ����
				Str_Cat(szFilePath , "_");
				Str_Cat(szFilePath , szChk_Sec_Cd);
				Str_Cat(szFilePath , "_");
				Str_Cat(szFilePath , szNOT_PASS_ITEM_CD);
				Str_Cat(szFilePath , ".jjp");
				
				Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
				SPRINT (m_szfilenm, "%s/%s", PHOTO_SC, szFilePath,  0);
	
				if( FFS_Exist(m_szfilenm) <= 0 )
				{
					MessageBoxEx (CONFIRM_OK, "�÷α׸����̺� ������ ������\n�Կ����ּ���.");
					return -1;
				}
			}
		}
		
		// 2. Ÿ�̸��� ����
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "Ÿ�̸����� �������ּ���.");
			return -1;
		}
		
		// 3. ������ ������ ��� ���ұ� ���� �Կ� ����
		if( Str_Cmp( stSc.CONT_STS_CD, "30" ) == 0 )
		{	
			Mem_Set((byte*)szProd_cd, 0x00, sizeof(szProd_cd));
			Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
			
			SPRINT(szSql, "SELECT PROD_CD FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0);

			g_Sql_RetStr(szSql, 10, szProd_cd);
			
			if( Str_Cmp( szProd_cd, "11" ) == 0 || Str_Cmp( szProd_cd, "12" ) == 0 || Str_Cmp( szProd_cd, "21" ) == 0 
			    || Str_Cmp( szProd_cd, "81" ) == 0 || Str_Cmp( szProd_cd, "82" ) == 0)
			{
				Mem_Set( (byte*)szFilePath, 0x00, sizeof(szFilePath) );
				Str_Cpy(szFilePath , "E");
				Str_Cat(szFilePath , g_szCHK_EXEC_NUM);
				Str_Cat(szFilePath , "_");
				Str_Cat(szFilePath , m_szMtrNum);
				Str_Cat(szFilePath , "_");
				Str_Cat(szFilePath , stSc.INST_PLACE_NUM);
				Str_Cat(szFilePath , ".jjp");
				
				Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
				SPRINT (m_szfilenm, "%s/%s", PHOTO_SCBUR, szFilePath,  0);
				
				if( FFS_Exist(m_szfilenm) <= 0 && Str_Cmp(stSc.PHOTO_BUR_YN, "Y") != 0 )
				{
					MessageBoxEx (CONFIRM_OK, "��������� �����Դϴ�.\n���ұ⸶������ ������ �Կ����ּ���.");
					return -1;
				}
			}
		}
		
		/********************************************************************************************************/
		/* Ÿ�̸���, ������ ���� : �跮������ -> ���ұ��������� �ű�                                         	*/
		/* ���� update �Ǵ� ���̺��� ������ �����ϰ� �跮�������� ���̺� �̹Ƿ�									*/
		/* ��� ����ÿ� �跮�����������̺� ���ұ������� ���� �����ϰ� update��. �۽��� ���� ���� ���ص���.	*/
		/********************************************************************************************************/
		//������
		Mem_Set( (byte*)stScBur.FUSE_COCK_INST_YN, 0x00, sizeof(stScBur.FUSE_COCK_INST_YN) );
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6)), SC_MTRFUSE );
		if (i == -1)
		{
			Str_Cpy(stScBur.FUSE_COCK_INST_YN, SC_MTRFUSE[0].Code);
		}
		else
		{
			Str_Cpy(stScBur.FUSE_COCK_INST_YN, SC_MTRFUSE[i].Code);
			
			//2018.01.22 CS�� �̼��� ����� ��û : ������ũ �̼�ġ ���� �� ��� ����	
			if( i == 1 )
			{		
				if( MessageBoxEx (CONFIRM_YESNO, "������ �̼�ġ�� ������ ����Դϴ�\n���ұ� ������ �Ϸ��Ͻðڽ��ϱ�?")  != MB_OK)
				{		
					return -1;
				}
			}
		}
		
		//Ÿ�̸���
		Mem_Set( (byte*)stScBur.TIMER_COCK_INST_YN, 0x00, sizeof(stScBur.TIMER_COCK_INST_YN) );
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7)), SCTIMER_COCK );
		if (i == -1)
		{
			Str_Cpy(stScBur.TIMER_COCK_INST_YN, "");
		}
		else
		{
			Str_Cpy(stScBur.TIMER_COCK_INST_YN, SCTIMER_COCK[i].Code);
		}

		// �ֹ��ڵ���ȭ��ġ
		Mem_Set( (byte*)stSc.KIT_AUTO_EXTINGU_INST_YN, 0x00, sizeof(stSc.KIT_AUTO_EXTINGU_INST_YN) );
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_KIT_SPRINKLER)), SCKITAUTOSPRIN );
		
		if (i == -1)
		{
			Str_Cpy(stSc.KIT_AUTO_EXTINGU_INST_YN, "");
		}
		else
		{
			Str_Cpy(stSc.KIT_AUTO_EXTINGU_INST_YN, SCKITAUTOSPRIN[i].Code);
		}
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		//���ұ� ���̺� UPDATE -> ȭ�� ǥ�� ������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szSqlCat, 0x00, sizeof(szSqlCat) );
		SPRINT(szSql, "UPDATE NORMAL_BUR SET FUSE_COCK_INST_YN = '%s', TIMER_COCK_INST_YN = '%s' ", stScBur.FUSE_COCK_INST_YN, stScBur.TIMER_COCK_INST_YN, 0);
		SPRINT(szSqlCat, " WHERE CHK_EXEC_NUM = '%s' AND MTR_NUM = '%s'", g_szCHK_EXEC_NUM, stScBur.MTR_NUM, 0);
		Str_Cat(szSql, szSqlCat);
		g_Sql_DirectExecute2(sql, szSql );

		//�跮�����̺� UPDATE -> ���� ���� ������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szSqlCat, 0x00, sizeof(szSqlCat) );
		SPRINT(szSql, "UPDATE NORMAL_MTR SET FUSE_COCK_INST_YN = '%s', TIMER_COCK_INST_YN = '%s' ", stScBur.FUSE_COCK_INST_YN, stScBur.TIMER_COCK_INST_YN, 0);
		SPRINT(szSqlCat, " WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		Str_Cat(szSql, szSqlCat);
		g_Sql_DirectExecute2(sql, szSql );
		
		// �ֹ��ڵ���ȭ��ġ UPDATE		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szSqlCat, 0x00, sizeof(szSqlCat) );
		SPRINT(szSql, "UPDATE NORMAL_DATA SET KIT_AUTO_EXTINGU_INST_YN = '%s'", stSc.KIT_AUTO_EXTINGU_INST_YN, 0, 0);
		SPRINT(szSqlCat, " WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		Str_Cat(szSql, szSqlCat);
		g_Sql_DirectExecute2(sql, szSql );
		
		//���ұ� CNT
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_BUR WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND BURNER_KIND_NUM NOT IN (201, 301)", g_szCHK_EXEC_NUM, stScBur.MTR_NUM, 0);
		g_Sql_RetInt2( sql, szSql, &lBurCnt );

		for( i = 0; i < lBurCnt; i++ )
		{
			//2018-09-03 ���� ����
			//���ұ��ȣ   
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)szBurner_Num, 0x00, sizeof(szBurner_Num) );
			SPRINT(szSql, " SELECT BURNER_NUM FROM NORMAL_BUR WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND BURNER_KIND_NUM NOT IN (201, 301) limit %d ,1", g_szCHK_EXEC_NUM, stScBur.MTR_NUM, i);
			g_Sql_RetStr2( sql, szSql, 7,szBurner_Num );
			
			//�������� ����
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND BURNER_NUM = '%s' AND CHK_SEC_CD ='70' ", g_szCHK_EXEC_NUM, stScBur.MTR_NUM, szBurner_Num);
			g_Sql_RetInt2( sql, szSql, &lGasCnt );
			lNogoodCnt += lGasCnt;

			//2018-09-03 ���� ����
			//ȣ�� ����(�÷��׸����̺� ���� ī��Ʈ)
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND BURNER_NUM = '%s' AND CHK_SEC_CD ='60' AND NOT_PASS_ITEM_CD NOT IN('50')", g_szCHK_EXEC_NUM, stScBur.MTR_NUM, szBurner_Num);
			g_Sql_RetInt2( sql, szSql, &lHoseCnt );
			lNogoodCnt += lHoseCnt;
			
			//20181127 ���ұ� ���� �߰�
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND BURNER_NUM = '%s' AND CHK_SEC_CD ='51' ", g_szCHK_EXEC_NUM, stScBur.MTR_NUM, szBurner_Num);
			g_Sql_RetInt2( sql, szSql, &lBurChkCnt );
			lNogoodCnt += lBurChkCnt;
		}
		
		//ȣ�� ����(�÷��׸����̺� ī��Ʈ)
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND CHK_SEC_CD ='60' AND NOT_PASS_ITEM_CD = '50'", g_szCHK_EXEC_NUM, stScBur.MTR_NUM, 0);
		g_Sql_RetInt2( sql, szSql, &lFlagCnt );
		lNogoodCnt += lFlagCnt;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND MTR_NUM = '%s' AND SUBSTR(BURNER_NUM,1,1) = '2'", g_szCHK_EXEC_NUM, stScBur.MTR_NUM, 0);
		g_Sql_RetInt2( sql, szSql, &lDelCnt );
		lDelCnt += lFlagCnt;
		
		if( lBurCnt > 0 && lDelCnt > 0 && lDelCnt == lNogoodCnt)
		{
			Str_Cpy( stSc.BUR_FLAG, "N" );
			Str_Cpy( stSc.NOGOOD_RSLT, "N" );
		}
		else if( lBurCnt > 0 && lDelCnt > 0 && lDelCnt > lNogoodCnt && lNogoodCnt == 0 )
		{
			Str_Cpy( stSc.BUR_FLAG, "Y" );
		}
		else if( lBurCnt > 0 && lDelCnt > 0 && lDelCnt > lNogoodCnt && lNogoodCnt > 0 )
		{
			Str_Cpy( stSc.BUR_FLAG, "N" );
			Str_Cpy( stSc.NOGOOD_RSLT, "N" );
		}
		
		else if( lBurCnt <= 0 && lDelCnt ==1 && lNogoodCnt == 1 )
		{
			Str_Cpy( stSc.BUR_FLAG, "N" );
			Str_Cpy( stSc.NOGOOD_RSLT, "N" );
		}
		else
		{
			Str_Cpy( stSc.BUR_FLAG, "Y" );
		}

Finally:
	
		DelSqLite(sql);

		return 1;
	}
	
	/*=======================================================================================
	�Լ��� : Validate
	��  �� : ���ұ� �űԻ��� �� ĭ üũ
	Param  : 
	Return : 
	========================================================================================*/	
	bool Validate(void)
	{
		char szMsg[150];
		char szTmp[10];
		long nLen = 0;
	
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ұ� ������ ������ �ּ���.");
			return FALSE;
		}
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "���ұ� �����縦 ������ �ּ���.");
			return FALSE;
		}

		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�뷮�� �Է����ּ���.");
			return FALSE;
		}
		
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		if( Str_Len(szTmp) > 0 && Str_Len(szTmp) < 8 )
		{
			MessageBoxEx (CONFIRM_OK, "��ȿ�� ��¥ ������ �ƴմϴ�.\n(ex: 2016. 01. 01)");
			return FALSE;
		}

		if(  Str_AtoI( szTmp ) > Time_GetDate() )
		{
			MessageBoxEx (CONFIRM_OK, "��ġ���ڰ� ���纸�� ���ķ� \n����� �� �����ϴ�.");
			return FALSE;
		}

		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		if( nLen > 50 )
		{
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "�������!\n(�𵨸��� �ѱ� 16��,\n����,���� 50�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szMsg);
			return FALSE;
		}

		return TRUE;
	}
	
	/*=======================================================================================
	�Լ��� : Chg_Bur
	��  �� : ���ұ� �űԻ���/���� ���÷���
	Param  : 
	Return : 
	========================================================================================*/	
	bool Chg_Bur(void)
	{
		char szSql[500];
		char sztmp[300];
		char szMsg[150];
		bool ret = TRUE;
		long idx;
		long i;
		long nLen = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		
		if( nLen > 50 )
		{
			Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
			SPRINT(szMsg, "�������!\n(�𵨸��� �ѱ� 16��,\n����,���� 50�� ������\n�Է°����մϴ�.)\n[%d]", nLen, 0, 0);
			MessageBoxEx(CONFIRM_OK, szMsg);
			return FALSE;
		}
		
		if( Str_Len(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "�뷮�� �Է����ּ���.");
			return FALSE;
		}
		
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		
		if( Str_Len(sztmp) > 0 && Str_Len(sztmp) < 8 )
		{
			MessageBoxEx (CONFIRM_OK, "��ȿ�� ��¥ ������ �ƴմϴ�.\n(ex: 2016. 01. 01)");
			return FALSE;
		}

		if(  Str_AtoI( sztmp ) > Time_GetDate() )
		{
			MessageBoxEx (CONFIRM_OK, "��ġ���ڰ� ���纸�� ���ķ� \n����� �� �����ϴ�.");
			return FALSE;
		}
		
		Str_Cpy(stScBur.MTR_ID_NUM, 	 EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA24))); //�⹰��ȣ
		Str_Cpy(stScBur.BURNER_MODEL_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));	 //�𵨸�
		Str_Cpy(stScBur.BURNER_CAPA, 	 EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));	 //�뷮
		
		// ��ġ����
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Chg(sztmp, STRCHG_DEL_NONDIGIT);
		Str_Cpy(stScBur.BURNER_INST_YMD, sztmp );
		
		// ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(stScBur.BURNER_KIND_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)));
		SPRINT(szSql, "SELECT BURNER_KIND_NM, BURNER_KIND_NUM FROM BURNER_KIND ", 0, 0, 0   );
		g_Sql_Bind(szSql, 30, stScBur.BURNER_KIND_NM, 3, stScBur.BURNER_KIND_NUM);

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT BURNER_CLASS_CD FROM BURNER_KIND WHERE BURNER_KIND_NUM = '%s'  ", stScBur.BURNER_KIND_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 2, stScBur.BURNER_CLASS_CD );
		
		i = g_SearchCD(stScBur.BURNER_CLASS_CD, BURNERCLASS);
		
		if (i > -1)
		{
			Str_Cpy(stScBur.BURNER_CLASS_NM, BURNERCLASS[i].Str);		
		}
		
		// 20180326 CS�� ��̿� ����� ��û, �ش� CLASS_CD �� ���ұ������ �˾� ����� ����
		if( Str_Cmp( stScBur.BURNER_CLASS_CD, "40" ) == 0 || Str_Cmp( stScBur.BURNER_CLASS_CD, "50" ) == 0 || Str_Cmp( stScBur.BURNER_CLASS_CD, "60" ) == 0 || Str_Cmp( stScBur.BURNER_CLASS_CD, "70" ) == 0 )
		{
			m_lchk_prod_popup = 0;
		}
		else
		{
			if( Str_Cmp( stScBur.BURNER_KIND_NUM, "398" ) == 0 )
			{
				m_lchk_prod_popup = 0;
			}
			else
			{
				m_lchk_prod_popup = 1;
			}
		}
		
		//�������
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)));
		SPRINT(szSql, "SELECT MAKER_NUM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NM = '%s' ", sztmp, 0, 0);
		
		g_Sql_RetStr( szSql, 20, stScBur.MAKER_NUM );

		// ����
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), SCBOIL_CAPA );
		
		if (i == -1)
		{
			Str_Cpy(stScBur.BURNER_CAPA_UNIT, "");
		}
		else
		{
			Str_Cpy(stScBur.BURNER_CAPA_UNIT, SCBOIL_CAPA[i].Code);
			Str_Cpy(stScBur.BURNER_CAPA_UNIT_NM, SCBOIL_CAPA[i].Str);
		}

		// ����
		if(stScBur.CHG_FLAG[0] != '1' )
		{
			Mem_Set( (byte*)stScBur.CHG_FLAG, 0x00, sizeof(stScBur.CHG_FLAG) );
			Str_Cpy(stScBur.CHG_FLAG, "2");
			
			Mem_Set( (byte*)stScBur.DATA_FLAG, 0x00, sizeof(stScBur.DATA_FLAG) );
			Str_Cpy( stScBur.DATA_FLAG, "20" );
		}
			
		// send_yn
		Str_Cpy(stScBur.SEND_YN, "S" );

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE NORMAL_BUR \
						  SET MTR_ID_NUM = ?, BURNER_KIND_NUM = ?, BURNER_KIND_NM = ?, BURNER_CLASS_CD = ?, BURNER_CLASS_NM= ? \
						    , MAKER_NUM = ?, BURNER_MODEL_NM = ?, BURNER_CAPA = ?, BURNER_CAPA_UNIT = ?, BURNER_CAPA_UNIT_NM = ? \
						    , BURNER_INST_YMD = ?, CHG_FLAG = ?, SEND_YN = ?, BLD_NUM = ?, INST_PLACE_NUM = ? \
						    , CHK_TYPE = ?, CHK_YEAR = ?, CHK_ORDER = ?, OBJ_YM = ?, PLAN_YM = ? \
						    , UPD_EMPID = ?, PDA_IP = ?, DATA_FLAG = ? \
						WHERE CHK_EXEC_NUM = ? AND MTR_NUM = ? AND BURNER_NUM = ?"
		            , 0, 0, 0);
		
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MTR_ID_NUM		    ,15	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_KIND_NUM	    ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_KIND_NM	    ,30	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CLASS_CD	    ,2 	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CLASS_NM	    ,20	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MAKER_NUM	      	,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_MODEL_NM	    ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CAPA		    ,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CAPA_UNIT	    ,20	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CAPA_UNIT_NM	,20	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_INST_YMD	    ,8	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.CHG_FLAG			    ,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.SEND_YN			    ,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM       		    ,9  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM		    ,9  ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE      		    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR      		    ,4  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER     		    ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM        		    ,6  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM       		    ,6  ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id     ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip          ,32 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.DATA_FLAG            ,2  ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM       	    ,12 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MTR_NUM              ,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_NUM           ,6  ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "�����Ǿ����ϴ�!");
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : New_Bur
	��  �� : ���ұ� �űԻ���/���� ���÷���
	Param  : 
	Return : 
	========================================================================================*/	
	bool New_Bur(void)
	{
		char sztmp[300];
		char szSql[300];
		char szSeq[4];
		long lSeq;
		long idx;
		long i;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
	
		if( !Validate() )
		{
			ret = FALSE;
			goto Finally;
		}
		
		//���˽����ȣ
		Str_Cpy(stScBur.CHK_EXEC_NUM, g_szCHK_EXEC_NUM);
		
		//�⹰��ȣ
		Str_Cpy(stScBur.MTR_ID_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)) );
		
		//�跮���ȣ(MTR_NUM)
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT MTR_NUM FROM NORMAL_MTR where CHK_EXEC_NUM = '%s' "
		, g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 10, stScBur.MTR_NUM );

		//���ұ��ȣ
		// WHERE AND SUBSTR(BURNER_NUM,0,1)= '1' �־���ϴ�����?? 2�� �����ϴ°͵� ����.
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT ifnull(MAX(BURNER_NUM)+1,'200001' ) AS MAX_NUM  FROM NORMAL_BUR WHERE CHK_EXEC_NUM='%s' AND MTR_NUM='%s' AND BURNER_KIND_NUM NOT IN ('201', '301') AND SUBSTR(BURNER_NUM,1,1)= '2' "
		, g_szCHK_EXEC_NUM, stScBur.MTR_NUM, 0   );
		g_Sql_RetStr( szSql, 20, stScBur.BURNER_NUM );

		//����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(stScBur.BURNER_KIND_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)));
		SPRINT(szSql, "SELECT BURNER_KIND_NUM FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stScBur.BURNER_KIND_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stScBur.BURNER_KIND_NUM );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT(szSql, "SELECT BURNER_CLASS_CD FROM BURNER_KIND WHERE BURNER_KIND_NM = '%s'  ", stScBur.BURNER_KIND_NM, 0, 0   );
		g_Sql_RetStr( szSql, 20, stScBur.BURNER_CLASS_CD );
		
		i = g_SearchCD(stScBur.BURNER_CLASS_CD, BURNERCLASS);
		
		if (i > -1)
		{
			Str_Cpy(stScBur.BURNER_CLASS_NM, BURNERCLASS[i].Str);
		}
		
		// 20180326 CS�� ��̿� ����� ��û, �ش� CLASS_CD �� ���ұ������ �˾� ����� ����
		if( Str_Cmp( stScBur.BURNER_CLASS_CD, "40" ) == 0 || Str_Cmp( stScBur.BURNER_CLASS_CD, "50" ) == 0 || Str_Cmp( stScBur.BURNER_CLASS_CD, "60" ) == 0 || Str_Cmp( stScBur.BURNER_CLASS_CD, "70" ) == 0 )
		{
			m_lchk_prod_popup = 0;
		}
		else
		{
			if( Str_Cmp( stScBur.BURNER_KIND_NUM, "398" ) == 0 )
			{
				m_lchk_prod_popup = 0;
			}
			else
			{
				m_lchk_prod_popup = 1;
			}
		}

		//�𵨸�
		Str_Cpy(stScBur.BURNER_MODEL_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)) );
		
		//�뷮
		Str_Cpy(stScBur.BURNER_CAPA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)) );
		
		//����
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)), SCBOIL_CAPA );
		if (i == -1)
		{
			Str_Cpy(stScBur.BURNER_CAPA_UNIT, "");
		}
		else
		{
			Str_Cpy(stScBur.BURNER_CAPA_UNIT, SCBOIL_CAPA[i].Code);
			Str_Cpy(stScBur.BURNER_CAPA_UNIT_NM, SCBOIL_CAPA[i].Str);
		}
		
		//��ġ����
		Mem_Set((byte *)sztmp, 0x00, sizeof(sztmp));
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Cat(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Chg(sztmp, STRCHG_DEL_NONDIGIT);
		Str_Cpy(stScBur.BURNER_INST_YMD, sztmp );
		
		//������� 
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA4)));
		SPRINT(szSql, "SELECT MAKER_NUM FROM USE_MAKER WHERE MAKER_FLAG = '50' AND MAKER_NM = '%s' ", sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 20, stScBur.MAKER_NUM );
		
		//��ġ����  > �ű�(1)�� �۾Ƴ���
		Str_Cpy(stScBur.CHG_FLAG, "1" );
		Str_Cpy(stScBur.SEND_YN, "S" );
		
		//seq����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szSeq, 0x00, sizeof(szSeq) );
		SPRINT(szSql, "SELECT ifnull(MAX(SEQ)+1, 1) FROM NORMAL_BUR  WHERE CHK_EXEC_NUM = '%s' AND BURNER_KIND_NUM NOT IN (201, 301)", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_RetInt( szSql, &lSeq );
			
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "INSERT INTO NORMAL_BUR \
										  ( CHK_EXEC_NUM, MTR_ID_NUM, MTR_NUM, BURNER_NUM, BURNER_KIND_NUM \
										  , BURNER_KIND_NM, BURNER_CLASS_CD, BURNER_CLASS_NM, BURNER_MODEL_NM, BURNER_CAPA \
										  , BURNER_CAPA_UNIT, BURNER_CAPA_UNIT_NM , BURNER_INST_YMD, MAKER_NUM, CHG_FLAG \
										  , SEND_YN, BLD_NUM, INST_PLACE_NUM, CHK_TYPE, CHK_YEAR \
										  , CHK_ORDER, OBJ_YM, PLAN_YM, UPD_EMPID, PDA_IP \
										  , SEQ ) \
										  VALUES \
										  ( ?, ?, ?, ?, ? \
										  , ?, ?, ?, ?, ? \
										  , ?, ?, ?, ?, ? \
										  , ?, ?, ?, ?, ? \
										  , ?, ?, ?, ?, ? \
										  , ? )" 
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScBur.CHK_EXEC_NUM      	,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MTR_ID_NUM         	,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MTR_NUM        		,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_NUM      		,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_KIND_NUM 		,3 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_KIND_NM 		,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CLASS_CD 		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CLASS_NM 		,30,DECRYPT);	
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_MODEL_NM 		,50,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CAPA     		,10,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CAPA_UNIT		,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_CAPA_UNIT_NM  ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_INST_YMD		,8 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MAKER_NUM			,30,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.CHG_FLAG        		,1 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stScBur.SEND_YN        		,1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM       			,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM			,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE      			,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR      			,4 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER     			,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM        			,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM       			,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id     ,20,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip          ,32 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'X', &lSeq                                ,4 ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		else
		{
			MessageBoxEx (CONFIRM_OK, "�ű�����Ǿ����ϴ�!");
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Del_Bur
	��  �� : ���ұ� ����
	Param  : 
	Return : 
	========================================================================================*/
	void Del_Bur(void)
	{
		char szSql[600];
		char sztmp[10];
		long idx;
		handle hdb = NULL;
		handle hstmt = NULL;

		if( Str_Cmp(stScBur.CHG_FLAG, "1") != 0 )
		{
			SQLITE sql = NewSqLite();
			//��ġ����  > ����(3), decode(CHG_FLAG,'1','�ű�','2','����','3','����')
			Str_Cpy(stScBur.CHG_FLAG, "3" );
			Str_Cpy(stScBur.INST_FLAG, "30" );
			Str_Cpy(stScBur.SEND_YN, "S" );
			
			hdb = sql->Open(sql);
			if( hdb == NULL )
			{
				goto Finally2;
			}
			
			hstmt = sql->CreateStatement(sql, "UPDATE NORMAL_BUR \
												 SET CHG_FLAG = ?, INST_FLAG = ?, SEND_YN = ?, PDA_IP = ?, UPD_EMPID = ? \
												   , BURNER_REMOV_YMD = ? \
											   WHERE CHK_EXEC_NUM = ? AND BURNER_NUM = ? AND MTR_NUM = ? " );
			idx = 0;
			
			sql->Bind(sql, idx++, 'U', (long *)stScBur.CHG_FLAG	         ,1	 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScBur.INST_FLAG         ,2	 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScBur.SEND_YN	         ,1	 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szpda_ip       ,20 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	 ,9	 ,DECRYPT);
			
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			Str_ItoA(Time_GetDate(), sztmp, 10);
			sql->Bind(sql, idx++, 'U', (long *)sztmp	                  ,8 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM	         ,12 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_NUM	     ,6	 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stScBur.MTR_NUM	         ,9 ,DECRYPT);

			if(sql->Execute(sql) == FALSE)
			{
				PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
				goto Finally2;
			}
			else
			{
				goto Finally;
			}
			
	Finally2:
			DelSqLite(sql);
			return;
			
	Finally:
			DelSqLite(sql);
		}
		else
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM NORMAL_BUR \
			                 WHERE CHK_EXEC_NUM ='%s' \
			                   AND BURNER_NUM = '%s' \
			                   AND MTR_NUM = '%s' \
							   AND BURNER_KIND_NUM NOT IN (201, 301) "
						, g_szCHK_EXEC_NUM, stScBur.BURNER_NUM, stScBur.MTR_NUM);
						
			g_Sql_DirectExecute( szSql );
		}
	
		// 20180326 CS�� ��̿� ����� ��û, �ش� CLASS_CD �� ���ұ������ �˾� ����� ����
		if( Str_Cmp( stScBur.BURNER_CLASS_CD, "40" ) == 0 || Str_Cmp( stScBur.BURNER_CLASS_CD, "50" ) == 0 || Str_Cmp( stScBur.BURNER_CLASS_CD, "60" ) == 0 || Str_Cmp( stScBur.BURNER_CLASS_CD, "70" ) == 0 )
		{
			m_lchk_prod_popup = 0;
		}
		else
		{
			if( Str_Cmp( stScBur.BURNER_KIND_NUM, "398" ) == 0 )
			{
				m_lchk_prod_popup = 0;
			}
			else
			{
				m_lchk_prod_popup = 1;
			}
		}
		
		MessageBoxEx (CONFIRM_OK, "�����Ǿ����ϴ�!");

		return;
	}

	/*=======================================================================================
	�Լ��� : Clear_Screen
	��  �� : ȭ�� CLEAR
	Param  : 
	Return : 
	========================================================================================*/
	void Clear_Screen(void)
	{
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA15), "" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA16), "" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA17), "" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA18), "" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA19), "" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA20), "" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA21), "" );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA22), "" );
	}
	
	/*=======================================================================================
	�Լ��� : SetStruct
	��  �� : ���ұ� �ű�, ���� �� ����ü SETTING
	Param  : 
	Return : 
	========================================================================================*/
	void SetStruct(void)
	{
		char szTmp[10];
	
		Mem_Set((byte*)&m_stScBur, 0x00, sizeof(m_stScBur));
	
		//�⹰��ȣ
		Str_Cpy(m_stScBur.MTR_ID_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA24)));
		
		//����
		Str_Cpy(m_stScBur.BURNER_KIND_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1)));
		
		//�������
		Str_Cpy(m_stScBur.MAKER_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2)));
		
		//�𵨸�
		Str_Cpy(m_stScBur.BURNER_MODEL_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1)));
		
		//�뷮
		Str_Cpy(m_stScBur.BURNER_CAPA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2)));
		
		//�뷮����
		Str_Cpy(m_stScBur.BURNER_CAPA_UNIT, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3)));
		
		//��ġ����
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
		Str_Cpy(m_stScBur.BURNER_INST_YMD, szTmp );
		
		//����
		Str_Cpy(m_stScBur.CHG_FLAG,	EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA34)));
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Compare_Data
	��  �� : ���ұ� ������ ��
	Param  : 
	Return : 
	========================================================================================*/
	bool Compare_Data(void)
	{
		bool ret = TRUE;
		char szTmp[10];
	
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA3)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)));
		Str_Cat(szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)));
		Str_Chg(szTmp, STRCHG_DEL_NONDIGIT);
	
		if( Str_Cmp(m_stScBur.MTR_ID_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA24))) != 0      ||
			Str_Cmp(m_stScBur.BURNER_KIND_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA1))) != 0   ||
			Str_Cmp(m_stScBur.MAKER_NUM, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA2))) != 0        ||
			Str_Cmp(m_stScBur.BURNER_MODEL_NM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA1))) != 0  ||
			Str_Cmp(m_stScBur.BURNER_CAPA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA2))) != 0      ||
			Str_Cmp(m_stScBur.BURNER_CAPA_UNIT, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA3))) != 0 ||
			Str_Cmp(m_stScBur.BURNER_INST_YMD, szTmp) != 0                                         ||
			Str_Cmp(m_stScBur.CHG_FLAG, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA34))) != 0 )
		{
			ret = FALSE;
		}

		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : Save_NotPassItem
	��  �� : ������ ����
	Param  : 
	Return : 
	========================================================================================*/	
	bool Save_NotPassItem(void)
	{
		long idx;
		bool ret = TRUE;
		long nDate;
		long BettePlanymd;
		char sztmp[20];	
		char szMtrIdNum[21];
		char szSql[800];	
		char szNOT_PASS_ITEM_CD[5];
		char szChk_Sec_Cd[5];
		SQLITE sql = NewSqLite();
		handle hdb = NULL;
		handle hstmt = NULL;
		
		Mem_Set((byte*)m_szChkSecNm ,0x00, sizeof(m_szChkSecNm) );
		Mem_Set((byte*)m_szNotPassItemNm ,0x00, sizeof(m_szNotPassItemNm) );
		Mem_Set((byte*)szChk_Sec_Cd ,0x00, sizeof(szChk_Sec_Cd) );
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		
		if( m_bFirst == INIT_MAIN )
		{
			Str_Cpy(m_szChkSecNm, "ȣ��");
			Str_Cpy(m_szNotPassItemNm, "�÷��׸����̺�");
			Str_Cpy(szChk_Sec_Cd, "60");
			Str_Cpy(szNOT_PASS_ITEM_CD, "50");
		}
		else
		{
			// 20171012 �ű�ȣ : �ڵ� ����
			Str_Cpy(m_szChkSecNm, "ȣ��");
			Str_Cpy(m_szNotPassItemNm, "��������");
			Str_Cpy(szChk_Sec_Cd, "60");
			Str_Cpy(szNOT_PASS_ITEM_CD, "60");
		}

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set((byte*)m_szMtrNum ,0x00, sizeof(m_szMtrNum) );
		SPRINT(szSql, "SELECT MTR_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, m_szMtrNum );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set((byte*)szMtrIdNum ,0x00, sizeof(szMtrIdNum) );
		SPRINT(szSql, "SELECT MTR_ID_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, szMtrIdNum );
	
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		nDate = Time_GetDate();
		BettePlanymd = Time_DateUpDown(nDate, 30 );
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}	
			
		hstmt = sql->CreateStatement(sql, "INSERT INTO NORMAL_NOGOOD_DETAL \
										   ( CHK_EXEC_NUM, CHK_SEC_CD, MTR_NUM, MTR_ID_NUM, BURNER_NUM \
										   , NOT_PASS_ITEM_CD, OBJ_YM, BLD_NUM, CHK_YEAR, CHK_ORDER \
										   , CHK_TYPE, INST_PLACE_NUM, PLAN_YM, CHK_SEC_NM, NOT_PASS_ITEM_NM \
										   , VISIT_DTM, BETTER_PLAN_YMD, BLD_NUM, SEND_YN, BETTER_YN \
										   , PDA_IP, UPD_EMPID, EXCEP_PREUSE_CHK ) \
										   VALUES \
										   ( ?, ?, ?, ?, ? \
										   , ?, ?, ?, ?, ? \
										   , ?, ?, ?, ?, ? \
										   , ?, ?, ?,'S','N' \
										   , ?, ?, 'N' ) " 
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM    ,12,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szChk_Sec_Cd    ,2,DECRYPT);
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "000000000");
		
		if(  Str_Len(m_szMtrNum) > 0  )
		{
			sql->Bind(sql, idx++, 'U', (long *)m_szMtrNum         ,9 ,DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)szMtrIdNum              ,9,DECRYPT);
		}
		else
		{
			sql->Bind(sql, idx++, 'U', (long *)sztmp                   ,9 ,DECRYPT);
			
			Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
			sql->Bind(sql, idx++, 'U', (long *)sztmp                   ,9 ,DECRYPT);
		}
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, "000000");
		
		if( m_bFirst == INIT_MAIN )
		{
			//�÷��׸����̺�  ->> ���ұⰡ ������ �޸� ��츦 �����ؼ� ������ �⺻��('000000') �����ϱ����.
			sql->Bind(sql, idx++, 'U', (long *)sztmp                      ,6 ,DECRYPT);
		}
		else
		{
			//���ұ����� ����
			if(  Str_Len(stScBur.BURNER_NUM) > 0  )			
				sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_NUM         ,6 ,DECRYPT);
			else
				sql->Bind(sql, idx++, 'U', (long *)sztmp                      ,6 ,DECRYPT);
		}
			
		sql->Bind(sql, idx++, 'U', (long *)szNOT_PASS_ITEM_CD         ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM          	  ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM         	  ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR        	  ,4 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER       	  ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE        	  ,2 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM  	  ,9 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM         	  ,6 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szChkSecNm               ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)m_szNotPassItemNm          ,32,DECRYPT);
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_ItoA( nDate, sztmp, 10);
		g_Str_TimeType(sztmp+8, Time_GetTime( ) );
		sql->Bind(sql, idx++, 'U', (long *)sztmp  , 8 ,DECRYPT);
		
		Mem_Set((byte*)sztmp ,0x00, sizeof(sztmp) );
		Str_ItoA( BettePlanymd, sztmp,10);
		sql->Bind(sql, idx++, 'U', (long *)sztmp , 8 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM               ,9,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip		  ,32,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id    ,20,DECRYPT);
		
		sql->Execute(sql);
		
Finally:
		DelSqLite(sql);
		
		if( m_bFirst == INIT_MAIN )
		{
			//�÷��׸����̺� ������ �Է� �� �ش� ���ұ����� ����� ����
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_BUR SET PLUG_NOGOOD_YN = 'N' WHERE CHK_EXEC_NUM = '%s'  AND BURNER_KIND_NUM NOT IN ('201', '301')", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute( szSql );

			Mem_Set((byte*)stScBur.PLUG_NOGOOD_YN ,0x00, sizeof(stScBur.PLUG_NOGOOD_YN) );
			Str_Cpy(stScBur.PLUG_NOGOOD_YN, "N");
		}

		return ret;
	}

//------------------------------------------------------------------------------------------------
	bool Save_Bun(void)
	{
		char szSql[300];
		bool ret = TRUE;
		long idx, i;
		long lGasCnt, lHoseCnt, lPhotoCnt, lBurCnt = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/********************************************/
		/* ȣ�� ���                                */
	    /********************************************/
	    Mem_Set( (byte*)stScBur.HOSE_RSLT, 0x00, sizeof(stScBur.HOSE_RSLT) );
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA41)), "����") == 0 )
		{
			Str_Cpy( stScBur.HOSE_RSLT, "Y" );
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA41)), "������") == 0 )
		{
			Str_Cpy( stScBur.HOSE_RSLT, "N" );
		}
		
		/********************************************/
		/* ���ұ� ���                              */
		/********************************************/
		Mem_Set( (byte*)stScBur.BUR_RSLT, 0x00, sizeof(stScBur.BUR_RSLT) );
		if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA46)), "����") == 0 )
		{
			Str_Cpy( stScBur.BUR_RSLT, "Y" );
		}
		else if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA46)), "������") == 0 )
		{
			Str_Cpy( stScBur.BUR_RSLT, "N" );
		}
		
		/********************************************/
		/* �������� COUNT                           */
		/********************************************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND BURNER_NUM = '%s' AND CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '60' ", g_szCHK_EXEC_NUM, stScBur.BURNER_NUM, 0);
		g_Sql_RetInt(szSql, &lGasCnt);
		
		/********************************************/
		/* ȣ��(�÷��׸����̺�,�������� ����) COUNT */
		/********************************************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND BURNER_NUM = '%s' AND CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD NOT IN('50','60') ", g_szCHK_EXEC_NUM, stScBur.BURNER_NUM, 0);
		g_Sql_RetInt(szSql, &lHoseCnt);
		
		/********************************************/
		/* ���ұ� COUNT                             */
		/********************************************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND BURNER_NUM = '%s' AND CHK_SEC_CD = '51' ", g_szCHK_EXEC_NUM, stScBur.BURNER_NUM, 0);
		g_Sql_RetInt(szSql, &lBurCnt);
		
		/********************************************/
		/* ���                                     */
		/********************************************/
		if( lGasCnt > 0 || lHoseCnt > 0 || lBurCnt > 0 )
		{
			Str_Cpy(stScBur.CHK_RSLT, "N" );
		}
		else
		{
			Str_Cpy(stScBur.CHK_RSLT, "Y" );
		}
		
		/********************************************/
		/* ��� ����                                */
		/********************************************/
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, " UPDATE NORMAL_BUR \
		                                       SET GAS_RSLT = ?, HOSE_RSLT = ?, CHK_RSLT = ?, BLD_NUM = ?, INST_PLACE_NUM = ? \
												 , CHK_TYPE = ?, CHK_YEAR = ?, CHK_ORDER = ?, OBJ_YM = ?, PLAN_YM = ? \
												 , PDA_IP = ?, UPD_EMPID = ?, BUR_RSLT = ? \
											 WHERE CHK_EXEC_NUM = ? AND BURNER_NUM = ? AND MTR_NUM = ? AND BURNER_KIND_NUM NOT IN ('201', '301')" );
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stScBur.GAS_RSLT			    ,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.HOSE_RSLT			,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.CHK_RSLT				,1	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.BLD_NUM       			,9	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.INST_PLACE_NUM			,9	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_TYPE      			,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_YEAR      			,4	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.CHK_ORDER     			,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.OBJ_YM        			,6	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stSc.PLAN_YM       			,6	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szpda_ip			,32 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long*)stUserinfo.szemployee_id  	,20 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BUR_RSLT				,1	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM       		,12	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.BURNER_NUM       	,6	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stScBur.MTR_NUM       		,10	,DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}

	/*=======================================================================================
	�Լ��� : SaveInput
	��  �� : �ٸ� ���� ȭ��, �˾�â�� ���ǵ� ���� ��ħ��� ȭ������ ���ƿ��� �Էµ��ִ� ���� �ٽ� ���ü��ֵ��� �ϱ�����.
	Param  : 
	Return : 
	========================================================================================*/	
	void SaveInput(void)
	{
		char szSql[200];
		char szTmp[20];
		long i;

		m_lDrawFlag = 1;

		//������
		Mem_Set( (byte*)g_szFuseCock, 0x00, sizeof(g_szFuseCock) );
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA6)), SC_MTRFUSE );
		if (i == -1)
		{
			Str_Cpy(g_szFuseCock, "");
		}
		else
		{
			Str_Cpy(g_szFuseCock, SC_MTRFUSE[i].Code);
		}
		
		//Ÿ�̸���
		Mem_Set( (byte*)g_szTimerCock, 0x00, sizeof(g_szTimerCock) );
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_DATA7)), SCTIMER_COCK );
		if (i == -1)
		{
			Str_Cpy(g_szTimerCock, "");
		}
		else
		{
			Str_Cpy(g_szTimerCock, SCTIMER_COCK[i].Code);
		}
		
		// �ֹ��ڵ���ȭ��ġ
		Mem_Set( (byte*)g_szKitsprinkler, 0x00, sizeof(g_szKitsprinkler) );
		i = g_SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_KIT_SPRINKLER)), SCKITAUTOSPRIN );
		if( i == -1 )
		{
			Str_Cpy(g_szKitsprinkler, "");
		}
		else
		{
			Str_Cpy(g_szKitsprinkler, SCKITAUTOSPRIN[i].Code);
		}
		
		return;
	}

	/*=======================================================================================
	�Լ��� : Shoto_Photo
	��  �� : �÷��׸����̺� �����Կ�
	Param  : 
	Return : 
	========================================================================================*/	
	void Shoto_Photo(void)
	{
		char szSql[256];
		char szScrPht[256];
		char szTgrPht[256];
		char szDirPath[256];
		char szNOT_PASS_ITEM_CD[5];
		char szChk_Sec_Cd[5];
		char *pCamera;
		long nRet, idx;
		long lrow, lcol, lRet;
		handle h = NULL;
		handle hdata = NULL;
		
		m_lphoto_flag = 1;
		
		//���ϸ�
		Mem_Set((byte*)m_szfilenm ,0x00, sizeof(m_szfilenm) );
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Mem_Set((byte*)szChk_Sec_Cd ,0x00, sizeof(szChk_Sec_Cd) );
		Str_Cpy( szNOT_PASS_ITEM_CD, "50" );
		Str_Cpy( szChk_Sec_Cd, "60" );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set((byte*)m_szMtrNum ,0x00, sizeof(m_szMtrNum) );
		SPRINT(szSql, "SELECT MTR_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, m_szMtrNum );
		
		Str_Cpy(m_szfilenm , "1");
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , g_szCHK_EXEC_NUM);
		Str_Cat(m_szfilenm , "_");
		
		if(Str_Len(m_szMtrNum) > 0)
		{
			Str_Cat(m_szfilenm , m_szMtrNum);
		}
		else
		{
			Str_Cat(m_szfilenm , "000000000");
		}
		
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , "000000");		//burner_num > �÷��׸����̺� ����
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , szChk_Sec_Cd);
		Str_Cat(m_szfilenm , "_");
		Str_Cat(m_szfilenm , szNOT_PASS_ITEM_CD);
		Str_Cat(m_szfilenm , ".jjp");

		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			SaveInput();
		
			g_nPhotoFlag = 2;
			
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_SC,  m_szfilenm, 0);
			
			Card_Move("CM_PHOTO");
			return;
		}
		else
		{
			//��������
			Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
			SPRINT (g_szphoto, "%s/%s", PHOTO_SC, m_szfilenm,  0);
			//���Ŀ��� Ȯ�ν�...
			ShootPhoto ( 1, 0, m_szfilenm );
			/*
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
	}
	
	/*=======================================================================================
	�Լ��� : Del_Plug_Nogood
	��  �� : �÷��׸����̺� ���������� ����
	Param  : 
	Return : 
	========================================================================================*/	
	void Del_Plug_Nogood(void)
	{
		char szSql[256];
		char szNOT_PASS_ITEM_CD[5];
		char szChk_Sec_Cd[5];
		long lCnt = 0;
		handle hdb = NULL;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		EditCtrl_SetForeColorEx( Get_hDlgCtrlByID(CMB_DATA8), TXTFRCOLOR);
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' AND CHK_SEC_CD ='60' AND NOT_PASS_ITEM_CD = '50' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute2( sql, szSql );
		
		//�÷��׸����̺� ������ �Է� �� �ش� ���ұ����� ����� ����
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' AND CHK_SEC_CD = '60' AND NOT_PASS_ITEM_CD = '50'", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetInt2( sql, szSql, &lCnt );

		if( lCnt == 0 )
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_BUR SET PLUG_NOGOOD_YN = 'Y' WHERE CHK_EXEC_NUM = '%s'  AND BURNER_KIND_NUM NOT IN ('201', '301')", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute2( sql, szSql );

			Mem_Set((byte*)stScBur.PLUG_NOGOOD_YN ,0x00, sizeof(stScBur.PLUG_NOGOOD_YN) );
			Str_Cpy(stScBur.PLUG_NOGOOD_YN, "Y");
		}
		else if( lCnt > 0 )
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE NORMAL_BUR SET CHK_RSLT = 'N' WHERE CHK_EXEC_NUM = '%s'  AND BURNER_KIND_NUM NOT IN ('201', '301')", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute2( sql, szSql );
		}

		//���ϸ�
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		Mem_Set((byte*)szNOT_PASS_ITEM_CD ,0x00, sizeof(szNOT_PASS_ITEM_CD) );
		Mem_Set((byte*)szChk_Sec_Cd ,0x00, sizeof(szChk_Sec_Cd) );
		Str_Cpy( szNOT_PASS_ITEM_CD, "50" );
		Str_Cpy( szChk_Sec_Cd, "60" );

		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set((byte*)m_szMtrNum ,0x00, sizeof(m_szMtrNum) );
		SPRINT(szSql, "SELECT MTR_NUM FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
		g_Sql_RetStr( szSql, 20, m_szMtrNum );
		
		Str_Cpy(szSql , "1");
		Str_Cat(szSql , "_");
		Str_Cat(szSql , g_szCHK_EXEC_NUM);
		Str_Cat(szSql , "_");
		
		if(Str_Len(m_szMtrNum) > 0)
		{
			Str_Cat(szSql , m_szMtrNum);
		}
		else
		{
			Str_Cat(szSql , "000000000");
		}
		
		Str_Cat(szSql , "_");
		Str_Cat(szSql , "000000");		// burner_num > �÷��׸����̺� ����
		Str_Cat(szSql , "_");
		Str_Cat(szSql , szChk_Sec_Cd);
		Str_Cat(szSql , "_");
		Str_Cat(szSql , szNOT_PASS_ITEM_CD);
		Str_Cat(szSql , ".jjp");
		
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		SPRINT (m_szfilenm, "%s/%s", PHOTO_SC, szSql,  0);

		if( FFS_Exist(m_szfilenm) > 0 )
		{
			FFS_Delete(m_szfilenm);
		}
		
Finally:
		DelSqLite(sql);
		
		return;
	}
	
	/*=======================================================================================
	�Լ��� : Find_Burner_Class_Cd
	��  �� : ���ұ� ���� �˸�
	Param  : 
	Return : 
	========================================================================================*/	
	void Find_Burner_Class_Cd(void)
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
 										     FROM NORMAL_BUR \
										    WHERE (INST_FLAG <> '30' OR  INST_FLAG  IS NULL) \
											  AND CHK_EXEC_NUM= ? \
											  AND BURNER_KIND_NUM <> '398' \
										    GROUP BY BURNER_CLASS_CD ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)g_szCHK_EXEC_NUM , 10, DECRYPT);

		if( sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		while( sql->Next(sql) == TRUE )
		{	
			i = 0;
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, i++, 'U', (long*)sztmp    ,8 +1, DECRYPT );
			Str_Cat(burclscd, sztmp);
		}
		
		Chk_Prod_Cd_Alarm(burclscd);

	Finally:
		DelSqLite(sql);
		return;	
	}
	
	/*=======================================================================================
	�Լ��� : Chk_Prod_Cd_Alarm
	��  �� : ��ǰ �˶�
	Param  : 
	Return : 
	========================================================================================*/
	void Chk_Prod_Cd_Alarm(char* burclscd)
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
		
		SPRINT(szSql, "SELECT PROD_CD FROM NORMAL_MTR WHERE CHK_EXEC_NUM = '%s'", g_szCHK_EXEC_NUM, 0, 0);

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

		if( m_lchk_prod_popup == 0 )
		{
			ON_EXIT();
			OnInit(INIT_MAIN);
		}
		else
		{
			if( Str_Cmp(stSc.CENTER_CD, "41") == 0 || Str_Cmp(stSc.CENTER_CD, "42") == 0 || Str_Cmp(stSc.CENTER_CD, "43") == 0 || Str_Cmp(stSc.CENTER_CD, "44") == 0 || Str_Cmp(stSc.CENTER_CD, "45") == 0 || Str_Cmp(stSc.CONT_STS_CD, "30") == 0)
			{
				ON_EXIT();
				OnInit(INIT_MAIN);	
			}
			else
			{
				if( Str_Cmp(szProd, "11") == 0 || Str_Cmp(szProd, "12") == 0 || Str_Cmp(szProd, "13") == 0
				   ||  Str_Cmp(szProd, "81") == 0  ||  Str_Cmp(szProd, "82") == 0 ||  Str_Cmp(szProd, "83") == 0)
				{
					
					if(chk_count == 0)
					{
							MessageBoxEx (CONFIRM_OK, "��ǰ�� �������ּ���!");
							g_nProdMoveFlag = 1;
							Card_Move("SC_PRODCHG");
					}
					else
					{
						ON_EXIT();
						OnInit(INIT_MAIN);
					}
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
			}
		}
Finally:
		DelSqLite(sql);
		return;	
	}
	
	/*=======================================================================================
	�Լ��� : Shoto_Bur_Photo
	��  �� : ���ұ� �����Կ�
	Param  : 
	Return : 
	========================================================================================*/
	void Shoto_Bur_Photo(void)
	{
		handle h = NULL;
		handle hdata = NULL;
		char *pCamera;
		long nRet;
		
		m_lphoto_flag = 0;
		
		// C39(��������) | E(���˽����ȣ) | M(�跮���ȣ) | I(��ġ��ҹ�ȣ) | D( ������¥(SYSDATE : YYYYMMDDHHMMSS )
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Str_Cpy(m_szfilenm, "E");				
		Str_Cat(m_szfilenm, g_szCHK_EXEC_NUM);
		Str_Cat(m_szfilenm, "_");			
		Str_Cat(m_szfilenm, m_szMtrNum);
		Str_Cat(m_szfilenm, "_");			
		Str_Cat(m_szfilenm, stSc.INST_PLACE_NUM);
		Str_Cat(m_szfilenm, ".jjp");

		//2018-01-30 Sanghyun Lee
		//PM80 ī�޶� ȣ��
		//��������
		Mem_Set((byte*)g_szphoto, 0x00, sizeof(g_szphoto));
		SPRINT (g_szphoto, "%s/%s", PHOTO_SCBUR,  m_szfilenm, 0);
		//���Ŀ��� Ȯ�ν�...
		ShootPhoto ( 1, 0, m_szfilenm );

		return;
	}
	
	/*=======================================================================================
	�Լ��� : Snd_FR311328
	��  �� : ���ұ���Ż��� / FR311328
	Param  : 
	Return : 
	========================================================================================*/
	void Snd_FR311328(void)
	{
		char szUrl[200];
		char szbuf[128];
		char* sndbuf;
		long ret = 0;
	
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		// TABLE CLEAR
		g_Sql_DirectExecute(" DELETE FROM RCV_TMP ");
		
		// PHOTO_FLODER_DELETE
		g_DirFS_Clear(PHOTO_WORK, "*");
		
		// PARAM SETTING
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311328, FALSE);
		
		// INST_PLACE_NUM
		// JSON_SetValue( g_pjcomm, 'C', "inst_place_num",  "202734913" );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num",  stSc.INST_PLACE_NUM );
		
		// BLD_NUM
		// JSON_SetValue( g_pjcomm, 'C', "bld_num",  "400241229" );
		JSON_SetValue( g_pjcomm, 'C', "bld_num",  stSc.BLD_NUM );
		
		// INFLOW_FLAG
		JSON_SetValue( g_pjcomm, 'C', "inflow_flag",  "10" );
		
		// FLAG_ITEM
		JSON_SetValue( g_pjcomm, 'C', "flag_item",  "10" );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = Rcv_FR311328;
		ret = HTTP_DownloadData(szUrl, "FR311328_IN",  "FR311328" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : Rcv_FR90003
	��  �� : FR90003 CallBack
	Param  : 
	Return : 
	========================================================================================*/	
	long Rcv_FR311328(void)
	{
		g_Sock_Close();
		CloseMessageBox();
	
		if( g_Chk_Json(311328) >= 0)
		{
			SetBunPhoto_Old();
			return 1;
		}
		else
		{
			ON_DRAW();
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : SetBunPhoto_Old
	��  �� : ���ұ���Ż��� ��ư
	Param  : 
	Return : 
	========================================================================================*/
	void SetBunPhoto_Old(void)
	{
		long i;
		char szindex[10];
		char* szfile;
		char* filedata;
		long nRet, filesize, fd;
		handle file;		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&m_stPhotoData, 0x00, sizeof(m_stPhotoData));

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		// param1 = file_full_name, param2 = file_path, param3 = file_name, param4 = file_size, param5 = file
		hstmt = sql->CreateStatement(sql, "SELECT PARAM1, PARAM2, PARAM3, LENGTH(PARAM101), PARAM101 FROM RCV_TMP");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) m_stPhotoData.ORG_FILE_NAME  		, 200, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPhotoData.FILE_PATH      		, 200, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPhotoData.FILE_NAME     		, 50 , DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_stPhotoData.PHOTO_LENGTH   		, 50 , DECRYPT );
			
			filesize = Str_AtoI(m_stPhotoData.PHOTO_LENGTH);
			
			filedata = Mem_Alloc(filesize+1);

			sql->GetValue( sql, i++, 'U', (long*) filedata   		, filesize+1 , DECRYPT );
			
			file = BASE64_Create();
			BASE64_Decode(file, filedata, filesize );
			szfile = BASE64_GetResult(file);	
			
			//JPG PATH
			SPRINT (m_stPhotoData.PHOTO_SAVE_JPG_PATH, "%s/%s",PHOTO_WORK, m_stPhotoData.ORG_FILE_NAME, 0);
			fd = FFS_Open(m_stPhotoData.PHOTO_SAVE_JPG_PATH, FS_WRITE_MODE, FS_CREATE_FLAG );
			
			FFS_Write ( fd, (byte*)szfile, filesize );
			FFS_Close(fd);
			
			if(file != NULL )
			{
				BASE64_Finalize(file);
				file = NULL;
			}
		}
		
Finally:

		DelSqLite(sql);
		
		ON_EXIT();
		OnInit(INIT_BUNPHOTO_OLD);
					
		return;
	}
	
	/*=======================================================================================
	�Լ��� : JpgToPng
	��  �� : JPG�� ����� �̹����� ȭ�鿡 �����ֱ����ؼ� PNG�� ��ȯ
	Param  : 
	Return : 
	========================================================================================*/
	void JpgToPng(void)
	{
		long lLen = 0;
		long ret = 0;
		long i = 0;
		char szTmp[256];
		handle h = NULL;
		handle hdata = NULL;
		
		SPRINT( m_stPhotoData.PHOTO_SAVE_PNG_PATH, "%s/%s%s", PHOTO_WORK, m_stPhotoData.FILE_NAME, ".png");
		Str_Cpy(m_stPhotoData.PHOTO_SAVE_JPG_SIZE_PATH, m_stPhotoData.PHOTO_SAVE_JPG_PATH);
		
		ConvertImage( JPG, m_stPhotoData.PHOTO_SAVE_JPG_PATH, DMS_X(1000), DMS_Y(858), m_stPhotoData.PHOTO_SAVE_JPG_SIZE_PATH, 60*1000 );
		
		h = JSON_Create( JSON_Object );
		
		if (h)
		{
			hdata = JSON_Create( JSON_Object );
			
			if(hdata == NULL)
			{
				goto Finally;
			}

			JSON_SetValue	(hdata	, 'C', "jpeg_path"		, m_stPhotoData.PHOTO_SAVE_JPG_SIZE_PATH);
			JSON_SetValue	(hdata	, 'C', "png_path"		, m_stPhotoData.PHOTO_SAVE_PNG_PATH);

			System_Call		("ConvertJpegToPng" , JSON_toString(hdata));
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
	
	/*=======================================================================================
	�Լ��� : PhotoDraw
	��  �� : ���ұ� ���Ż��� DRAW
	Param  : 
	Return : 
	========================================================================================*/
	void PhotoDraw(void)
	{
		char szDate[50];
		char szfilenm[128];
		char szPhotopath[256];
		void* pImgBiz;
		
		if( FFS_Exist(m_stPhotoData.PHOTO_SAVE_PNG_PATH) )
		{
			pImgBiz = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  m_stPhotoData.PHOTO_SAVE_PNG_PATH );
			
			ButCtrl_SetImage( Get_hDlgCtrlByID(BID_BUNPHOTO_OLD),  pImgBiz);
		}
		
		ON_DRAW();
	}
}


