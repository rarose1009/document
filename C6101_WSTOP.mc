/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_WSTOP
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
		
		DEF_BUTTON_ID ( BID_STOP )			//
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
		DEF_OBJECT_ID ( TAB_COVER )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TAB_LINE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_PAGE )		//Ÿ��Ʋ

		DEF_OBJECT_ID ( TTL_SUM )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_SUM )		//Ÿ��Ʋ
	
		DEF_OBJECT_ID ( TTL_MTR_NUM )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_MTR_NUM )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TTL_KEEPER_YN )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TTL_SEALED_STS )	//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( TTL_INDI_VC )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_INDI_VC )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TTL_INDI_VA )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_INDI_VA )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TTL_INDI_VM )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_INDI_VM )		//Ÿ��Ʋ
		
		DEF_OBJECT_ID ( CMB_KEEPER_YN )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( CMB_SEALED_STS = CMB_KEEPER_YN+3 )	//Ÿ��Ʋ
		DEF_OBJECT_ID ( ID_TBLLIST = CMB_SEALED_STS+3 )
	
	END_OBJECT_ID()
	
	#define INIT_MAIN	  1

	#define		W_MAIN		CWD*39+10
	#define		H_MAIN		CHT*21
	//-------------------------------------------------------------------------------------------------	
	//	Table���ǿ� ���õ� �����
	//-------------------------------------------------------------------------------------------------
	#define		ROW 	    2					// table�� �ళ��
	#define		COL 	    4					// table�� ������
	#define		GRID_H		(CHT+15)			// table �� ����
	#define		GRID_H_P	(CHT+48)			// table �� ���� PDA
	#define		GRID_CLR	TRANSPARENT   		// table Ŭ���� color
	#define		GRID_X		STARTX 			    // table ����x��ǥ
	#define		MAXCHAR		101 			    // table�� ���� �ִ� �ִ�  char ����
	#define		GRID_Y		STARTY+60  	    //table ����y��ǥ
	#define		GRID_Y_P	STARTY+200  	    //table ����y��ǥ PDA
	#define		GRID_ENDY	(GRID_Y+(ROW+1)*GRID_H) //table������ row�� Y��
	
	#define 	SYH			(CHT+15)
	#define 	Line(x)	    (GRID_ENDY+15+SYH*x)
	
	char	m_szTableBuf [COL*(ROW+1)*MAXCHAR]; // �� CELL�� �� �ؽ�Ʈ ������ ���� ����
		
	Column m_stGridTitle[] = {
		{"�⹰��ȣ", CWD*18,  EDITALIGN_LEFT|EDITALIGN_MIDDLE,   TABLE_TEXT, 0},
		{"��ġ��ġ", CWD*11,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{"����"    , CWD*10+23,  EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0},
		{""        , CWD*0,   EDITALIGN_CENTER|EDITALIGN_MIDDLE, TABLE_TEXT, 0}
	};
	 
	#define	BUTSETRANGE(h, x1, y1, x2, y2)		ButCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	 
	long m_bFirst;
	char m_szCnt_index[11];     //�ε��� ���ڿ�(���� ������)
	long m_lpage;
	long m_lTotpage;
	long m_lActIndex;
	long m_lActRow;
	
	void SetBtnImg(void);
	void SetStyle(void);
	void ReDraw(void);
	void Draw_Tb(void);
	long Sql_SetCombo(char* szSql, long CTRLID );
	void Save_Mtr(void);
	void Save_MtrStop(void);
	
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
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WONE, "��ȸ��"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WPAY, "���"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC, "", BID_WSTOP, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WRELE, "����"),
		DLG_BUTTON(0, STARTY, 0, CHT+10, 0, 0, 0, BUTSTY_THICKBORDER|BUTSTY_BORDER,  TXTFRCOLOR, TXTCTRLBK, CALL_FUNC, "", BID_WCHK, "����"),
		//DLG_TEXT ( 10, STARTY+35, W_MAIN, H_MAIN, 0, 0, 0, EDITSTY_THICKBORDER|EDITSTY_BORDER, TTLCTRLBK, TTLCTRLBK, TAB_LINE, ""),	
		//DLG_TEXT ( 0, 0, 0, 0, 0, 0, 0, 0, TXTFRCOLOR, TXTINCTRLBK, TAB_COVER, ""),
		
		// ����Ʈ
		DLG_TABLE (GRID_X, GRID_Y, ROW, COL, 0, GRID_H, 1, GRID_H, SEL_ROW, MAXCHAR, m_stGridTitle, ID_TBLLIST, m_szTableBuf),	

		DLG_BUTTON( STARTX,    GRID_ENDY+20, 225,   SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_UP, " ��"),
		DLG_BUTTON(STARTX+225, GRID_ENDY+20, 225,   SYH, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DOWN, " ��"),
		DLG_TEXT(  STARTX+725, GRID_ENDY+20, 275, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_PAGE, m_szCnt_index),
		
		DLG_TEXT( STARTX,      Line(1)+25, 325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_MTR_NUM, "�跮���ȣ"),
		DLG_TEXT( STARTX+325,  Line(1)+25, 675, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_MTR_NUM, ""),
		DLG_TEXT( STARTX,      Line(2)+25, 325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_SEALED_STS, "���ν�ƼĿ"),
		DLG_COMBO( STARTX+325, Line(2)+25, 675, SYH*6, SYH*3, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_SEALED_STS, 10),
		DLG_TEXT( STARTX,      Line(3)+25, 325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_KEEPER_YN, "Ű��"),
		DLG_COMBO( STARTX+325, Line(3)+25, 675, SYH*6, SYH*3, SYH, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_KEEPER_YN, 10),
		
		DLG_TEXT( STARTX,     Line(4)+25,  325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_VC, "VC"),
		DLG_TEXT( STARTX+325, Line(4)+25,  675, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_VC, ""),
		DLG_TEXT( STARTX,     Line(5)+25,  325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_VA, "VA"),
		DLG_TEXT( STARTX+325, Line(5)+25,  675, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_VA, ""),
		DLG_TEXT( STARTX,     Line(6)+25,  325, SYH, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TTL_INDI_VM, "VM"),
		DLG_TEXT( STARTX+325, Line(6)+25,  675, SYH, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_INDI_VM, ""),
				
		DLG_BUTTON( STARTX+700, Line(7)+50, 300, SYH+20, 0, 0, BUTSTY_BOLD, BUTSTY_ROUNDBORDER , BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_STOP,"�������"),
	};	

	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "��������"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE, ""),
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
						Draw_Tb();
						Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
						Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						Draw_Tb();
						Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
						Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );
						break;		
				}
				break;
		}
		
		SetBtnImg();
		SetStyle();
		ReDraw();
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
				Draw_Tb();
				m_lActRow = 0;
				Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
				Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );

				break;			
			case BID_DOWN:
				m_lpage++;
				if( m_lpage > m_lTotpage-1 )
				{
					m_lpage = m_lTotpage-1;
				}
				Draw_Tb();
				m_lActRow = 0;
				Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
				Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );
				break;
				
			case BID_STOP:
			    if( Str_Cmp(stMw.szCont_sts_cd , "30") == 0)
			    {
			    	MessageBoxEx (CONFIRM_OK, "�������°� ������ ��� ó���� �� �����ϴ�.");
			    	return;
			    }
				Save_MtrStop();
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
				//Card_Move("C6101_WSTOP");
				break;
			case BID_WRELE:
				Card_Move("C6101_WRELE");
				break;
			case BID_WPAY:
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
		}
	}
	
	void	OnSelect(long Index)
	{
		long index = -1;
		char szcmb[20];
		char szAddr[200];
		
		if( INIT_MAIN == m_bFirst )
		{
			//���� TBL�� ���õǾ������� Ȯ��
			if (DlgTbl_IsSelect(ID_TBLLIST))
			{
				// ���� ���õ� �ε���
				index = DlgTbl_GetActiveRow(ID_TBLLIST);
				// ���� �ε����� ���� �ε����� ���� �� ���
				Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
				Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, index-1, 3)  );
				ReDraw();
				
				m_lActRow = index-1;
			}
		}
	}
	
	void	OnChar(long nChar)
	{
		if( m_bFirst == INIT_MAIN )
		{
			if( Get_iDlgCtrlByID(TXT_INDI_VC) == m_lActIndex )
			{
				//���ڸ� �Է� ����
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					ON_KEY(5);
					return;
				}
			}
			else if( Get_iDlgCtrlByID(TXT_INDI_VA) == m_lActIndex )
			{
				//���ڸ� �Է� ����
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					ON_KEY(5);
					return;
				}
			}
			else if( Get_iDlgCtrlByID(TXT_INDI_VM) == m_lActIndex )
			{
				//���ڸ� �Է� ����
				if( (nChar < 48 ||  nChar > 57) )
				{
					MessageBoxEx (CONFIRM_OK, "���ڸ� �Է°����մϴ�.");
					ON_KEY(5);
					return;
				}
			}
		}
	}
	
	
	void	OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	
		m_lActIndex = lActiveIndex;
		
		if( m_bFirst == INIT_MAIN )
		{
			Save_Mtr();
			
			if( POINTING_UP == nAction )
			{
				if( theDevInfo.m_nType > FAMILY_PDA )
				{
					if( X > DMS_X(STARTX+325) && X < DMS_X(STARTX+1000) && Y > DMS_Y(Line(4)+20-(g_Dlgflag*400)) && Y < DMS_Y(Line(7)+20-(g_Dlgflag*400)) )
					{
						if( Get_iDlgCtrlByID(TXT_INDI_VC) == lActiveIndex ||
						    Get_iDlgCtrlByID(TXT_INDI_VA) == lActiveIndex ||
						    Get_iDlgCtrlByID(TXT_INDI_VM) == lActiveIndex )	
						{
							g_Dlgflag = 0;
							g_MOVE_DLG(400);		
							
							ShowSip(TRUE);
							g_Sipflag = 1;
						}
						
					}
					else
					{
						g_Dlgflag = 1;
						g_MOVE_DLG(1);
					
						ShowSip(FALSE);
						g_Sipflag = 0;
					}
					ON_DRAW();
				}
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
			
			if(   g_nWorkFlag == 640 || g_nWorkFlag == 650 )
			{
				TABCNT = 4;
				//lenX = CWD*9+20;
				lenX = CWD*10;
				
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
			
			//610:����[��, ���ұ�, ��ǰ, ��ȸ��, ��� ]
			//620:����[��, ���ұ�, ����,  ��ȸ��, ��� ]
			//630:����[��, ����, ����, ��ȸ��, ��� ]
			//640:����[��, ����, ��ȸ��, ��� ]
			//650:��ü[��, ���ұ�, �跮��, ��ȸ��, ��� ]
			//660:����[��, ���ұ�, ����(�跮�ⱳü), ��ȸ��, ��� ]
			i = 0;
			//���������� ����[��, �跮��, ���ұ�]
			EditCtrl_SetStr( Get_hDlgCtrlByID( TXT_TITLE ),  stMw.szPda_duty );
			
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
				//EDITSETRANGE( Get_hDlgCtrlByID( TAB_COVER ),  sX[2]+4, highty-5, eX[2]-4, highty+5 );

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
				
			}
			else if( g_nWorkFlag == 650 )
			{
				//650:��ü[��, ���ұ�, �跮��, ��ȸ��, ��� ]
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
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_WMTR), "�跮��" );
			}
			else if( g_nWorkFlag == 660 )
			{
				//660:����[��, ���ұ�, ����(�跮�ⱳü), ��ȸ��, ��� ]
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WMTR), FALSE);// �跮��
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WSTOP), FALSE);// ����
				DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(BID_WRELE), FALSE);// ����
				
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCUST), sX[i], starty, eX[i], highty );	
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WBUR), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WCHK), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WONE), sX[i], starty, eX[i], highty );
				i++;
				BUTSETRANGE(Get_hDlgCtrlByID(BID_WPAY), sX[i], starty, eX[i], highty );
			}
		}
	}

//------------------------------------------------------------------
	void SetStyle(void)
	{
	char szSql[200];
	
		if( m_bFirst == INIT_MAIN )
		{
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PAGE       ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_MTR_NUM    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_MTR_NUM    ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_SEALED_STS ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_SEALED_STS ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_KEEPER_YN  ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_KEEPER_YN  ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_VC    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VC    ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_VA    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VA    ), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TTL_INDI_VM    ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_INDI_VM    ), EDITALIGN_MIDDLE);
	
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );//����
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30089' ",0, 0, 0   );
			Sql_SetCombo(szSql, CMB_SEALED_STS+2);
			
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );//Ű��
			SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID = 'C30107' ",0, 0, 0   );
			Sql_SetCombo(szSql, CMB_KEEPER_YN+2);
		}
	}
	
	void Draw_Tb(void)
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
		SPRINT(m_szCnt_index, "%d/%d", m_lpage+1, m_lTotpage,0);

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		hstmt = sql->CreateStatement(sql, "SELECT MTR_ID_NUM, MTR_LOC_FLAG_NM, PROD_STS_CD, MTR_NUM FROM C6101_PROMISE_MTR  WHERE PROMISE_ASSIGN_SEQ = ? ORDER BY MTR_ID_NUM LIMIT ?, ? " );
		
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
					continue;
				}
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 0, 'U', (long*)sztmp, 26, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 0, sztmp );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 1, 'U', (long*)sztmp, 50, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 1, sztmp );

				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 2, 'U', (long*)sztmp, 50, DECRYPT);

				if(Str_Cmp(sztmp, "10") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
				else if(Str_Cmp(sztmp, "20") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
				else if(Str_Cmp(sztmp, "30") == 0 )
					DlgTbl_SetStr ( ID_TBLLIST, i, 2, "����" );
				
				Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
				sql->GetValue(sql, 3, 'U', (long*)sztmp, 10, DECRYPT);
				DlgTbl_SetStr ( ID_TBLLIST, i, 3, sztmp );
			}
		}

Finally:

		//sql->Commit(sql);
		DelSqLite(sql);
		
		if( m_lTotpage > 0)
		{
			DlgTbl_SetActive(ID_TBLLIST , m_lActRow+1 );
			DlgTbl_SetRowColor(ID_TBLLIST, m_lActRow+1, TABLEACTIVE_COLOR);
				
			Str_Cpy( stMtr.szPromise_assign_seq , g_szCHK_EXEC_NUM  );
			Str_Cpy( stMtr.szMtr_num , DlgTbl_GetStr( ID_TBLLIST, m_lActRow, 3)  );
		}
		
		
		ON_DRAW();
	}
	
	
	void ReDraw(void)
	{
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	char sztmp[50];
	char szSql[200];
	long i;
		
		
		Mem_Set( (byte*)stMtr.szIndi_vc, 0x00, sizeof(stMtr.szIndi_vc) );
		Mem_Set( (byte*)stMtr.szIndi_va, 0x00, sizeof(stMtr.szIndi_va) );
		Mem_Set( (byte*)stMtr.szIndi_vm, 0x00, sizeof(stMtr.szIndi_vm) );
		Mem_Set( (byte*)stMtr.szSealed_sts, 0x00, sizeof(stMtr.szSealed_sts) );
		Mem_Set( (byte*)stMtr.szKeeper_yn, 0x00, sizeof(stMtr.szKeeper_yn) );
		
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql," select SEALED_STS, KEEPER_YN, INDI_VC,INDI_VA, INDI_VM, REVIS_FLAG  from C6101_PROMISE_MTR where PROMISE_ASSIGN_SEQ = ? and MTR_NUM = ?");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)stMtr.szPromise_assign_seq , 10, DECRYPT);
		sql->Bind(sql, i++, 'U', (long*)stMtr.szMtr_num , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szSealed_sts ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szKeeper_yn  ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_vc    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_va    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szIndi_vm    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMtr.szRevis_flag ,2  +1, DECRYPT );
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}
Finally:
//		sql->Commit(sql);
		DelSqLite(sql);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_MTR_NUM ), stMtr.szMtr_num );
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID= 'C30089' AND  CODE_ITEM ='%s' ", stMtr.szSealed_sts, 0, 0   );
		g_Sql_RetStr( szSql, 50, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_SEALED_STS ), sztmp );
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );//Ű��
		SPRINT(szSql, " SELECT ITEM_KNAME FROM COMMONCODE WHERE CODE_ID= 'C30107' AND  CODE_ITEM ='%s' ",stMtr.szKeeper_yn, 0, 0   );
		g_Sql_RetStr( szSql, 50, sztmp );
		EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_KEEPER_YN ), sztmp );
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VC), stMtr.szIndi_vc);
		
		if( g_nStopReleFlag == 1)
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_STOP), RED); 
		else
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_STOP), BTNMENUFRCOLOR);
		
		if(Str_Cmp(stMtr.szRevis_flag, "10") == 0)
		{
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA), FALSE); // ����
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VA), FALSE); // ����
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM), FALSE); // ����
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VM), FALSE); // ����
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VA ), stMtr.szIndi_va);
			EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_INDI_VM ), stMtr.szIndi_vm);			
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VA), TRUE); // ����
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VA), TRUE); // ����
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TXT_INDI_VM), TRUE); // ����
			DlgCtrl_SetVisible(hCurDlg, Get_iDlgCtrlByID(TTL_INDI_VM), TRUE); // ����
		}
		
		ON_DRAW();
	}
	
	
	long Sql_SetCombo(char* szSql, long CTRLID )
	{
	long ret = -1;
	char szBuf[101];
	long cnt  = 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
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
		if(sql != NULL)
			sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	void Save_Mtr(void)
	{
	char szSql[300];
	char sztmp[50];
	handle* sql;
	char * sqlstr = "";	
	
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEALED_STS)));
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30089' AND  ITEM_KNAME ='%s' ", sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 2, stMtr.szSealed_sts );
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_KEEPER_YN)));		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );//Ű��
		SPRINT(szSql, " SELECT CODE_ITEM FROM COMMONCODE WHERE  CODE_ID = 'C30107' AND  ITEM_KNAME ='%s' ",sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 2, stMtr.szKeeper_yn );

		Mem_Set( (byte*)stMtr.szIndi_vc, 0x00, sizeof(stMtr.szIndi_vc) );
		Mem_Set( (byte*)stMtr.szIndi_va, 0x00, sizeof(stMtr.szIndi_va) );
		Mem_Set( (byte*)stMtr.szIndi_vm, 0x00, sizeof(stMtr.szIndi_vm) );
		Str_Cpy( stMtr.szIndi_vc, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VC ) ) );
		if(Str_Cmp(stMtr.szRevis_flag, "10") != 0)
		{
			Str_Cpy( stMtr.szIndi_va, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VA ) ) );
			Str_Cpy( stMtr.szIndi_vm, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VM ) ) );
		}
		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
		STRING_Append(sql," SEALED_STS =  '");
		STRING_Append(sql,stMtr.szSealed_sts);
		STRING_Append(sql,"' ,KEEPER_YN ='");
		STRING_Append(sql,stMtr.szKeeper_yn);
		STRING_Append(sql,"' ,INDI_VC ='");
		STRING_Append(sql,stMtr.szIndi_vc);
		STRING_Append(sql,"' ,INDI_VA ='");
		STRING_Append(sql,stMtr.szIndi_va);
		STRING_Append(sql,"' ,INDI_VM ='");
		STRING_Append(sql,stMtr.szIndi_vm);
		STRING_Append(sql,"'  WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  stMtr.szPromise_assign_seq );
		STRING_Append(sql,"' AND MTR_NUM = '");
		STRING_Append(sql,  stMtr.szMtr_num );
		STRING_Append(sql,"' ");
		
		sqlstr = STRING_toString(sql);		
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(sql);
	}
	
	
	void Save_MtrStop(void)
	{
	char szSql[300];
	char sztmp[50];
	long cnt = 0;
	handle* sql;
	char * sqlstr = "";	
	
		
		if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_VC ) ) == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "��ħVC�� �Է��ϼ���!");
			return;
		}
		
		if(Str_Cmp(stMtr.szRevis_flag, "10") != 0)
		{
			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_VA ) ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ħVA�� �Է��ϼ���!");
				return;
			}

			if( EditCtrl_GetStrLen( Get_hDlgCtrlByID(TXT_INDI_VM ) ) == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "��ħVM�� �Է��ϼ���!");
				return;
			}
		}
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_SEALED_STS)));
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT CODE_ITEM FROM COMMONCODE WHERE CODE_ID = 'C30089' AND  ITEM_KNAME ='%s' ", sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 2, stMtr.szSealed_sts );
		
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy(sztmp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_KEEPER_YN)));		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );//Ű��
		SPRINT(szSql, " SELECT CODE_ITEM FROM COMMONCODE WHERE  CODE_ID = 'C30107' AND  ITEM_KNAME ='%s' ",sztmp, 0, 0   );
		g_Sql_RetStr( szSql, 2, stMtr.szKeeper_yn );

		Mem_Set( (byte*)stMtr.szIndi_vc, 0x00, sizeof(stMtr.szIndi_vc) );
		Mem_Set( (byte*)stMtr.szIndi_va, 0x00, sizeof(stMtr.szIndi_va) );
		Mem_Set( (byte*)stMtr.szIndi_vm, 0x00, sizeof(stMtr.szIndi_vm) );
		Str_Cpy( stMtr.szIndi_vc, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VC ) ) );
		if(Str_Cmp(stMtr.szRevis_flag, "10") != 0)
		{
			Str_Cpy( stMtr.szIndi_va, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VA ) ) );
			Str_Cpy( stMtr.szIndi_vm, EditCtrl_GetStr( Get_hDlgCtrlByID(TXT_INDI_VM ) ) );
		}
		sql = STRING_Create(sqlstr);
		STRING_Empty(sql);
		STRING_Append(sql," UPDATE C6101_PROMISE_MTR SET ");
		STRING_Append(sql," SEALED_STS =  '");
		STRING_Append(sql,stMtr.szSealed_sts);
		STRING_Append(sql,"' ,KEEPER_YN ='");
		STRING_Append(sql,stMtr.szKeeper_yn);
		STRING_Append(sql,"' ,INDI_VC ='");
		STRING_Append(sql,stMtr.szIndi_vc);
		STRING_Append(sql,"' ,INDI_VA ='");
		STRING_Append(sql,stMtr.szIndi_va);
		STRING_Append(sql,"' ,INDI_VM ='");
		STRING_Append(sql,stMtr.szIndi_vm);
		STRING_Append(sql,"',PROD_STS_CD = '20' ");
		STRING_Append(sql," ,UPD_EMPID = '");
		STRING_Append(sql,  stUserinfo.szemployee_id);
		STRING_Append(sql,"',PDA_IP = '");
		STRING_Append(sql,  stUserinfo.szpda_ip);
		STRING_Append(sql,"',SEND_YN = 'Y'  WHERE PROMISE_ASSIGN_SEQ = '");
		STRING_Append(sql,  stMtr.szPromise_assign_seq );
		STRING_Append(sql,"' AND MTR_NUM = '");
		STRING_Append(sql,  stMtr.szMtr_num );
		STRING_Append(sql,"' ");
		
		sqlstr = STRING_toString(sql);		
		g_Sql_DirectExecute(sqlstr);
		STRING_Finalize(sql);
		
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(*) FROM C6101_PROMISE_MTR WHERE PROMISE_ASSIGN_SEQ ='%s' AND  PROD_STS_CD <> '20'  ", stMtr.szPromise_assign_seq, 0, 0   );
		g_Sql_RetInt( szSql , &cnt );
		
		if( cnt > 0 )
			Str_Cpy(stMw.szCont_sts_cd , "10" ); 
		else
			Str_Cpy(stMw.szCont_sts_cd , "20" );
		
		g_nStopReleFlag = 1;
		
		MessageBoxEx (CONFIRM_OK, "���� ��� �Ǿ����ϴ�.");
		Draw_Tb();
		ReDraw();
	}
}



