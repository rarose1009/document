/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_WONE
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
	#define USE_ON_POINTING
	#define USE_ON_SELECT

	#include "DefEvent.h"
	
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
		DEF_BUTTON_ID ( BID_WFIN )
		
		DEF_BUTTON_ID ( BID_UP )	//
		DEF_BUTTON_ID ( BID_DOWN )	//

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
	
		DEF_OBJECT_ID ( TTL_SUM )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_SUM )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_MSG )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( CMB_USE1  )	// 
		DEF_OBJECT_ID ( CMB_USE2 = CMB_USE1+3)	// 
		DEF_OBJECT_ID ( CMB_USE3 = CMB_USE2+3)	// 
		DEF_OBJECT_ID ( CMB_USE4 = CMB_USE3+3)	// 
		DEF_OBJECT_ID ( CMB_USE5 = CMB_USE4+3)	//
		DEF_OBJECT_ID ( CMB_USE6 = CMB_USE5+3)	//
		DEF_OBJECT_ID ( CMB_USE7 = CMB_USE6+3)	//
		DEF_OBJECT_ID ( CMB_USE8 = CMB_USE7+3)	//
		DEF_OBJECT_ID ( CMB_USE9 = CMB_USE8+3)	//
		DEF_OBJECT_ID ( CMB_USE10 = CMB_USE9+3)	//
		DEF_OBJECT_ID ( CMB_USE11 = CMB_USE10+3)	//
		DEF_OBJECT_ID ( CMB_USE12 = CMB_USE11+3)	//
		DEF_OBJECT_ID ( CMB_USE13 = CMB_USE12+3)	//
		DEF_OBJECT_ID ( ID_TBLLIST = CMB_USE13+ 3)

	END_OBJECT_ID()
	
	#define INIT_MAIN	  1

	#define		W_MAIN		CWD*39+10
	#define		H_MAIN		CHT*21
	
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    13					// table�� �ళ��
	#define		COL 	    5					// table�� ������
	#define		GRID_H		(CHT+10)			// table �� ����
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		101 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+65  	    //table ����y��ǥ
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	#define 	SYH			(CHT+10)
	#define 	Line(x)	    (GRID_ENDY+15+SYH*x)
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�׸�", CWD*15+23, EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"�ܰ�", CWD*7,  	EDITALIGN_RIGHT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"����", CWD*7,  	EDITALIGN_RIGHT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"�ݾ�", CWD*10, 	EDITALIGN_RIGHT|EDITALIGN_MIDDLE,  TABLE_TEXT, 0},
		{"�ڵ�", 0,      	EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
		 
	#define	BUTSETRANGE(h, x1, y1, x2, y2)		ButCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	
	long m_bFirst;
	char m_szCnt_index[11];     //�ε��� ���ڿ�(���� ������)
	long m_lActiveIndex = -1;
	long m_lpage;
	long m_lTotpage;
	char m_szWhere[200];
	char m_szWhere2[200];
	
	void SetBtnImg(void);
	void SetStyle(void);
	void Draw_Tb(void);
	void ReDraw(void);
	void Data_Filter(void);

	
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCUST, "��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "���ұ�"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_WONE, "��ȸ��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WPAY, "���"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WSTOP, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WRELE, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCHK, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WFIN, "�Ϸ�"),
		//DLG_TEXT ( 10, STARTY+35, W_MAIN, H_MAIN, 0, 0, 0, EDITSTY_THICKBORDER|EDITSTY_BORDER, TTLCTRLBK, TTLCTRLBK, TAB_LINE, ""),	
		//DLG_TEXT ( 0, 0, 0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, TAB_COVER, ""),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H  ,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE1, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*2,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE2, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*3,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE3, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*4,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE4, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*5,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE5, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*6,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE6, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*7,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE7, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*8,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE8, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*9,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE9, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*10, CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE10, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*11, CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE11, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*12, CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE12, 3),
		DLG_COMBO ( GRID_X+CWD*22+23, GRID_Y+GRID_H*13, CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE13, 3),
		
		DLG_TEXT( GRID_X,           GRID_ENDY,  CWD*29+22, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SUM, "�հ�"),
		DLG_TEXT( GRID_X+CWD*29+23, GRID_ENDY,  CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_SUM, ""),

		DLG_BUTTON(STARTX,      GRID_ENDY+15+SYH, 200, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+200,  GRID_ENDY+15+SYH, 200, 69, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		DLG_TEXT(  STARTX+700,  GRID_ENDY+15+SYH, 300, 69, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),
		DLG_TEXT(  GRID_X,  GRID_Y+GRID_H, CWD*38, GRID_H*ROW, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MSG, "����ð��� �ƴ� ��� \n ��ȸ���� �Է��� �� �����ϴ�."),
	};	

	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),

		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCUST, "��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WBUR, "���ұ�"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WMTR, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC , "", BID_WONE, "��ȸ��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WPAY, "���"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WSTOP, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WRELE, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCHK, "����"),
		DLG_TEXT ( 10, STARTY+35, W_MAIN, H_MAIN, 0, 0, 0, EDITSTY_THICKBORDER|EDITSTY_BORDER, TTLCTRLBK, TTLCTRLBK, TAB_LINE, ""),	
		//DLG_TEXT ( 0, 0, 0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, TAB_COVER, ""),
		
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H  ,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE1, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*2,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE2, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*3,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE3, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*4,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE4, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*5,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE5, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*6,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE6, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*7,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE7, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*8,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE8, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*9,  CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE9, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*10, CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE10, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*11, CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE11, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*12, CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE12, 3),
		DLG_COMBO ( GRID_X+CWD*21, GRID_Y+GRID_H*13, CWD*7,  GRID_H*5, 80, GRID_H, BTNCTRLFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", CMB_USE13, 3),
		
		DLG_TEXT( GRID_X,        GRID_ENDY,  CWD*28, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TTL_SUM, "�հ�"),
		DLG_TEXT( GRID_X+CWD*28, GRID_ENDY,  CWD*10, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_SUM, ""),
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
						ReDraw();
						Draw_Tb();
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						ReDraw();
						Draw_Tb();
						break;		
				}
				break;
		
		}
		
		SetBtnImg();
		SetStyle();
		
	}
	
//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
				case BID_UP:
				m_lpage--;
				if(m_lpage < 0)
				{
					m_lpage = 0;
				}
				ReDraw();
				Draw_Tb();
				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
				}
				ReDraw();
				Draw_Tb();
				break;
				
			case BID_WCUST:
				Data_Filter();
				Card_Move("C6101_WCUST");
				break;
			case BID_WMTR:
				Data_Filter();
				Card_Move("C6101_WMTR");
				break;
			case BID_WBUR:
				Data_Filter();
				Card_Move("C6101_WBUR");
				break;
			case BID_WCHK:
				Data_Filter();
				Card_Move("C6101_WCHK");
				break;
			case BID_WONE:
				//Card_Move("C6101_WONE");
				break;
			case BID_WSTOP:
				Data_Filter();
				Card_Move("C6101_WSTOP");
				break;
			case BID_WRELE:
				Data_Filter();
				Card_Move("C6101_WRELE");
				break;
			case BID_WPAY:
				Data_Filter();
				Card_Move("C6101_WPAY");
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
			case BID_WFIN:
				Data_Filter();
				if( MessageBoxEx (CONFIRM_YESNO, "����Ȯ���� �Ϸ��Ͻðڽ��ϱ�?")  == MB_OK)
				{
					Str_ItoA( Time_GetDate(), stMw.szChk_time_end, 10);
					g_Str_TimeType(stMw.szChk_time_end+8, Time_GetTime());

					g_Snd_RstMin_690(1);
				}
				break;
		}
	}
	
	void	OnPointing(long nAction, long X, long Y)
	{
		m_lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
	}
	
	void	OnSelect(long Index)
	{
		handle* hsql;
		char * sqlstr = "";
		char sztmp[32];
		char sztmp2[32];
		long unit, amt, qty;
		long i;
		long Ctrltiltle[ROW] = {CMB_USE1,CMB_USE2,CMB_USE3,CMB_USE4,CMB_USE5,CMB_USE6,CMB_USE7
								,CMB_USE8,CMB_USE9,CMB_USE10,CMB_USE11,CMB_USE12,CMB_USE13};
	
		for(i = 0 ; i < ROW ; i++ )
		{
			if( m_lActiveIndex == Get_iDlgCtrlByID( Ctrltiltle[i] +1) )
			{
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_Cpy(sztmp, EditCtrl_GetStr( Get_hDlgCtrlByID(Ctrltiltle[i] )) );
				qty = Str_AtoI(sztmp );
				Str_Cpy(sztmp, DlgTbl_GetStr( ID_TBLLIST, i, 1)  );
				Str_Chg(sztmp, STRCHG_DEL_NONDIGIT);
				unit = Str_AtoI(sztmp ); 
				amt = qty* unit;
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				Str_ItoA( amt , sztmp, 10);
				Str_Cpy( sztmp2, sztmp);
				Str_Chg(sztmp2, STRCHG_INS_COMMA);
				DlgTbl_SetStr( ID_TBLLIST, i, 3, sztmp2 );
				
				if( ( g_nWorkFlag == 620 || g_nWorkFlag == 690 ) && qty > 0)
				{
					hsql = STRING_Create(sqlstr);
					STRING_Empty(hsql);
					STRING_Append(hsql," UPDATE C6101_ONCE_INFO SET ONCE_AMT = '0', ONCE_QTY = '0' ");
					STRING_Append(hsql," WHERE PROMISE_ASSIGN_SEQ = '");
					STRING_Append(hsql,  g_szCHK_EXEC_NUM);
					STRING_Append(hsql,"' ");
					sqlstr = STRING_toString(hsql);
					g_Sql_DirectExecute( sqlstr);
					STRING_Finalize(hsql);
					hsql = NULL;				
				}
				
				if(	Str_Len( stMw.szAppro_num ) > 0   )
				{
					MessageBoxEx (ERROR_OK, "���ݽ����� ��ϵǾ����ϴ�. ��� �� �����ϼ���.");
				}
				else if( stMw.szAuto_yn[0] == 'Y' )
				{
					MessageBoxEx (ERROR_OK, "�ĺ�ó���� ��ϵǾ����ϴ�. ��� �� �����ϼ���.");
				}
				else
				{
					hsql = STRING_Create(sqlstr);
					STRING_Empty(hsql);
					STRING_Append(hsql," UPDATE C6101_ONCE_INFO SET ONCE_AMT = '");
					STRING_Append(hsql,  sztmp );
					STRING_Append(hsql,"', ONCE_QTY = '");
					STRING_Append(hsql,  EditCtrl_GetStr( Get_hDlgCtrlByID(Ctrltiltle[i] ))  );
					STRING_Append(hsql,"' WHERE PROMISE_ASSIGN_SEQ = '");
					STRING_Append(hsql,  g_szCHK_EXEC_NUM);
					STRING_Append(hsql,"' AND ONCE_ITEM_CD ='");
					STRING_Append(hsql,DlgTbl_GetStr( ID_TBLLIST, i, 4));
					STRING_Append(hsql,"' ");
					sqlstr = STRING_toString(hsql);				
					g_Sql_DirectExecute( sqlstr);
					STRING_Finalize(hsql);
					hsql = NULL;			
				}
				
				ReDraw();
				
				//if( g_nWorkFlag == 620 && qty > 0)
				Draw_Tb();
				
				ON_DRAW();
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
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[3]+4, highty-5, eX[3]-4, highty+5 );
				
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
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[3]+4, highty-5, eX[3]-4, highty+5 );
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
				//���õ� ���� Ȱ��ȭ�Ȱ�ó�� ���̰� ��.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[3]+4, highty-5, eX[3]-4, highty+5 );
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
				//���õ� ���� Ȱ��ȭ�Ȱ�ó�� ���̰� ��.			
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[2]+4, highty-5, eX[2]-4, highty+5 );
				
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
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[2]+4, highty-5, eX[2]-4, highty+5 );
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
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[3]+4, highty-5, eX[3]-4, highty+5 );
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
	}

//------------------------------------------------------------------
	void SetStyle(void)
	{
	long i, j, tot;
	char sztmp[10];
	long Ctrltiltle[ROW] = {CMB_USE1,CMB_USE2,CMB_USE3,CMB_USE4,CMB_USE5,CMB_USE6,CMB_USE7
							,CMB_USE8,CMB_USE9,CMB_USE10,CMB_USE11,CMB_USE12,CMB_USE13};
	
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_SUM ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SUM ), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MSG ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_MSG), TRUE, 2, EDITSEP_NONE );
		
		for ( i = 0 ;  i < ROW  ; i++)
		{
			Mem_Set((byte*)sztmp ,0x00 , sizeof(sztmp) );
			if( g_nWorkFlag == 620 || g_nWorkFlag == 690 )
				tot = 2;
			else
				tot = 10;
			for ( j = 0 ;  j < tot  ; j++)
			{
				Str_ItoA( j, sztmp ,10 );
				ListCtrl_AddItem (Get_hDlgCtrlByID( Ctrltiltle[i]+2), sztmp, 0, ICON_NONE);
			}
			EditCtrl_SetAlign(Get_hDlgCtrlByID(Ctrltiltle[i]),  EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		}
		
		
	}
	
	void ReDraw(void)
	{
	char szSql[450];
	char sztmp[32];
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)m_szWhere, 0x00, sizeof(m_szWhere) );
		Mem_Set( (byte*)m_szWhere2, 0x00, sizeof(m_szWhere2) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );

//PRINT("[%s] stMw.szChk_yn=[%s]", stMw.szPda_duty, stMw.szChk_yn, 0);	
//PRINT("stMw.szTrans_conn_yn=[%s],stMw.szConn_yn=[%s],stMw.szBar_yn=[%s]",stMw.szTrans_conn_yn,stMw.szConn_yn,stMw.szBar_yn);
//PRINT("stMw.szBar_gbn=[%s],stMw.szBar_why=[%s],stMw.szConn_gbn=[%s]",stMw.szBar_gbn,stMw.szBar_why,stMw.szConn_gbn);


		// PRINT("g_nWorkFlag : %s",g_nWorkFlag,0,0);
		if( g_nWorkFlag == 620 || g_nWorkFlag == 690 )
		{
			Str_Cpy( m_szWhere, " AND A.ONCE_ITEM_CD IN( 'F00001','F00002') " );
			Str_Cpy( m_szWhere2, " AND ONCE_ITEM_CD IN( 'F00001','F00002') " );
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
		}
		else if(g_nWorkFlag == 640 )
		{
			Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
			Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 OR  ONCE_ITEM_CD IN( 'D00001','E00001') )" );			
			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
		}
		else if( g_nWorkFlag == 610 || g_nWorkFlag == 660 )
		{
			if(stUserinfo.szcenter_cd[0] == '4' )
		 	{
		 		if( stMw.szConn_yn[0] == 'Y' )
		 		{
                	if (Str_Cmp( stMw.szConn_gbn, "10" ) == 0 )
					{
                      Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 AND A.ONCE_ITEM_CD != 'D00001'  OR  A.ONCE_ITEM_CD = 'E00001' ) " );
                      Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 AND ONCE_ITEM_CD != 'D00001'  OR  ONCE_ITEM_CD = 'E00001' ) " );
                      DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
                    }
					else
					{
						Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0  OR A.ONCE_ITEM_CD IN ('D00001','E00001') ) " );
		 				Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0  OR ONCE_ITEM_CD IN ( 'D00001','E00001') ) " );
		 				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
					}
		 		}
		 		else if( stMw.szConn_yn[0] == 'N' )
		 		{
		 			Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0  OR A.ONCE_ITEM_CD IN ('D00001','E00001') ) " );
		 			Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0  OR ONCE_ITEM_CD IN ( 'D00001','E00001') ) " );
		 			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
		 		}
		 		else
				{
					Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
					Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 OR  ONCE_ITEM_CD IN( 'D00001','E00001') )" );
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
				}
		 	}
		 	else
		 	{
		 		if( stMw.szConn_yn[0] == 'Y' )
		 		{
		 			Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 AND A.ONCE_ITEM_CD != 'B00002' AND A.ONCE_ITEM_CD != 'D00001' OR A.ONCE_ITEM_CD = 'E00001' ) " );
		 			Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 AND ONCE_ITEM_CD != 'B00002' AND ONCE_ITEM_CD != 'D00001' OR ONCE_ITEM_CD = 'E00001' ) " );
		 			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
		 		}
		 		else if( stMw.szConn_yn[0] == 'N' )
		 		{
		 			Str_Cpy( m_szWhere, " AND A.ONCE_ITEM_CD = 'NO' " );
		 			Str_Cpy( m_szWhere2, " AND ONCE_ITEM_CD = 'NO' " );
		 			
		 			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), TRUE );
		 			
		 			
		 		}
		 		else
				{
					Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
					Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 OR  ONCE_ITEM_CD IN( 'D00001','E00001') )" );
					
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
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
			 			if (Str_Cmp( stMw.szConn_gbn, "10" ) == 0 )
						{
							Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 AND A.ONCE_ITEM_CD != 'D00001'  OR  A.ONCE_ITEM_CD = 'E00001' ) " );
							Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 AND ONCE_ITEM_CD != 'D00001'  OR  ONCE_ITEM_CD = 'E00001' ) " );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
						}
						else
						{
							Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0  OR A.ONCE_ITEM_CD IN ('D00001','E00001') ) " );
							Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0  OR ONCE_ITEM_CD IN ( 'D00001','E00001') ) " );
							DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
						}
			 		}
			 		else if( stMw.szConn_yn[0] == 'N' )
			 		{
			 			Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0  OR A.ONCE_ITEM_CD IN ('D00001','E00001') ) " );
			 			Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0  OR ONCE_ITEM_CD IN ( 'D00001','E00001') ) " );
			 			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
			 		}
			 		else
					{
						Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
						Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 OR  ONCE_ITEM_CD IN( 'D00001','E00001') )" );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
					}
			 	}
			 	else
			 	{
			 		if( stMw.szConn_yn[0] == 'Y' )
			 		{
			 			Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 AND A.ONCE_ITEM_CD != 'B00002' AND A.ONCE_ITEM_CD != 'D00001' OR A.ONCE_ITEM_CD = 'E00001' ) " );
			 			Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 AND ONCE_ITEM_CD != 'B00002' AND ONCE_ITEM_CD != 'D00001' OR ONCE_ITEM_CD = 'E00001' ) " );
			 			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
			 		}
			 		else if( stMw.szConn_yn[0] == 'N' )
			 		{
			 			Str_Cpy( m_szWhere, " AND A.ONCE_ITEM_CD = 'NO' " );
			 			Str_Cpy( m_szWhere2, " AND ONCE_ITEM_CD = 'NO' " );
			 			DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), TRUE );
			 		}
			 		else
					{
						Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
						Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 OR  ONCE_ITEM_CD IN( 'D00001','E00001') )" );
						DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
					}
			 	}
			}
			else
			{
				Str_Cpy( m_szWhere, " AND ( A.ONCE_UNIT_PRC > 0 OR  A.ONCE_ITEM_CD IN( 'D00001','E00001') )" );
				Str_Cpy( m_szWhere2, " AND ( ONCE_UNIT_PRC > 0 OR  ONCE_ITEM_CD IN( 'D00001','E00001') )" );
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(TXT_MSG), FALSE );
			}
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)stMw.szOnce_account , 0x00, sizeof(stMw.szOnce_account ) );
		SPRINT(szSql, " SELECT SUM( A.ONCE_AMT ) FROM C6101_ONCE_INFO A WHERE  A.PROMISE_ASSIGN_SEQ = '%s' %s  ", g_szCHK_EXEC_NUM, m_szWhere, 0);
		g_Sql_RetStr( szSql, 10, stMw.szOnce_account );
		Str_Cpy( sztmp, stMw.szOnce_account );
		Str_Chg( sztmp, STRCHG_INS_COMMA );
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_SUM ), sztmp);
	}
	
	
	void Draw_Tb(void)
	{
		long i, idx;
		long k = ROW+1;
		long lTotPage;
		long lstartidx;
		char sztmp[100];
		char szSql[450];
		char szWhere[100];
		bool ret = TRUE;	
		handle hdb = NULL;
		handle hstmt = NULL;
		long Ctrltiltle[ROW] = {CMB_USE1,CMB_USE2,CMB_USE3,CMB_USE4,CMB_USE5,CMB_USE6,CMB_USE7
							,CMB_USE8,CMB_USE9,CMB_USE10,CMB_USE11,CMB_USE12,CMB_USE13};
		
		SQLITE sql = NULL;
		
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_ONCE_INFO A WHERE A.PROMISE_ASSIGN_SEQ = '%s' %s ", g_szCHK_EXEC_NUM, m_szWhere, 0);
		g_Sql_RetInt(szSql, &m_lTotpage);

		if( m_lTotpage % ROW > 0 )
		{
			m_lTotpage = (m_lTotpage / ROW) + 1;
		}
		else
		{
			m_lTotpage = m_lTotpage / ROW;
		}
			
		SPRINT(m_szCnt_index, "%d/%d", m_lpage+1, m_lTotpage,0);
	
		sql = NewSqLite();
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		SPRINT(szSql, " SELECT B.ONCE_ITEM_NM, A.ONCE_UNIT_PRC, A.ONCE_QTY, A.ONCE_AMT, A.ONCE_ITEM_CD \
FROM C6101_ONCE_INFO A , C6101_ONCE_ITEM B WHERE  PROMISE_ASSIGN_SEQ = ? AND A.ONCE_ITEM_CD = B.ONCE_ITEM_CD  \
%s  ORDER BY B.SORT_SEQ LIMIT ?, ?  ", m_szWhere, 0, 0);
//		PRINT("szSql=[%s]",szSql,0,0);		

		hstmt = sql->CreateStatement(sql,  szSql );

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
				EditCtrl_SetStr( Get_hDlgCtrlByID( Ctrltiltle[i] ), "");
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(Ctrltiltle[i]), FALSE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(Ctrltiltle[i]+1), FALSE);
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
					EditCtrl_SetStr( Get_hDlgCtrlByID( Ctrltiltle[i] ), "");
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(Ctrltiltle[i]), FALSE);
					DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(Ctrltiltle[i]+1), FALSE);
					
					
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 10, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 6, DECRYPT);
				EditCtrl_SetStr( Get_hDlgCtrlByID( Ctrltiltle[i] ), sztmp);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(Ctrltiltle[i]), TRUE);
				DlgCtrl_SetVisible( this->m_hDlg, Get_iDlgCtrlByID(Ctrltiltle[i]+1), TRUE);

				//DlgTbl_SetStr ( ID_TBLLIST, i, 2, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 14, DECRYPT);
				Str_Chg( sztmp, STRCHG_INS_COMMA );
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 4, 'U', (long*)sztmp, 6, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 4, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		ON_DRAW();
				
	}
	
	//��� �۽Žÿ� �۽��� �����͸� �����ϱ� ����.
	//�������� ������ ���Ϳ� ���� �׸��� ����Ǿ���.
	void Data_Filter(void)
	{
	char szSql[400];
	
		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE C6101_ONCE_INFO  SET SEND_YN = 'N' WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute(szSql);

		Mem_Set((byte*)szSql, 0x00, sizeof(szSql));
		SPRINT(szSql, "UPDATE C6101_ONCE_INFO  SET SEND_YN = 'S' WHERE PROMISE_ASSIGN_SEQ = '%s' AND ONCE_QTY > 0 %s ", g_szCHK_EXEC_NUM, m_szWhere2, 0);
		g_Sql_DirectExecute(szSql);

	}
}



