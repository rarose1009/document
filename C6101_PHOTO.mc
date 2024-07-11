/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card C6101_PHOTO
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
	#define USE_ON_UART
	#define USE_ON_TASK

	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_PREVPHOTO )		//��ü�跮�� �����Կ�
		DEF_BUTTON_ID ( BID_PREVVIEW   )	//��ü�跮�� ��������
		DEF_BUTTON_ID ( BID_AFTERPHOTO  )	//��ġ�跮�� �����Կ�
		DEF_BUTTON_ID ( BID_AFTERVIEW )		//��ġ�跮�� ��������
		DEF_BUTTON_ID ( BID_OK )

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
		DEF_OBJECT_ID ( TXT_DATA1 )
		DEF_OBJECT_ID ( TXT_DATA2 )
		DEF_OBJECT_ID ( TXT_DATA3 )
		DEF_OBJECT_ID ( TXT_DATA4 )
		DEF_OBJECT_ID ( TXT_DATA5 )
		DEF_OBJECT_ID ( TXT_DATA6 )
		
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	#define INIT_BOJUNG		2

	char m_szfilenm[50];	 
	char m_szSql[500];
	char m_szTmp[400];
	char m_Title[30];
	char m_szPrevTitle[30];
	char m_szNextTitle[30];

	void SetBtnImg(void);
	void ReDraw(void);
	bool Validate(void);
	void Shoto_Photo(long ID);
	void Photo_View(long ID);
	void Delete_Photo(void);

	
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

	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, ""),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, m_Title),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),
			
		DLG_BUTTON(STARTX,		STARTY+115, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVVIEW, "���� ����"),
		DLG_BUTTON(STARTX+500,	STARTY+115, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPHOTO, "���� �Կ�"),
		DLG_BUTTON(STARTX,		STARTY+360, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERVIEW, "���� ����"),
		DLG_BUTTON(STARTX+500,	STARTY+360, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERPHOTO, "���� �Կ�"),
		DLG_BUTTON(STARTX+500,	STARTY+450, 500, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ��"),
		
		DLG_TEXT(STARTX,			STARTY-29,  1000, 73, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1 , m_szPrevTitle),
		DLG_TEXT(STARTX,			STARTY+45,  500, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2 , "���� ����"),
		DLG_TEXT(STARTX+500,		STARTY+45,  500, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		DLG_TEXT(STARTX,			STARTY+220,  1000, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4 , m_szNextTitle),
		DLG_TEXT(STARTX,			STARTY+290,  500, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA5 , "���� ����"),
		DLG_TEXT(STARTX+500, 	  	STARTY+290,  500, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6 , ""),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),		
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, m_Title),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),

		DLG_BUTTON(STARTX,		STARTY+115, 490, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVVIEW, "���� ����"),
		DLG_BUTTON(STARTX+490,	STARTY+115, 503, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPHOTO, "���� �Կ�"),
		DLG_BUTTON(STARTX,		STARTY+360, 490, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERVIEW, "���� ����"),
		DLG_BUTTON(STARTX+490,	STARTY+360, 503, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_AFTERPHOTO, "���� �Կ�"),
		DLG_BUTTON(STARTX+593,	STARTY+450, 400, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK, "Ȯ��"),
		
		DLG_TEXT(STARTX,			STARTY-25,  993, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA1 , m_szPrevTitle),
		DLG_TEXT(STARTX,			STARTY+45,  490, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA2 , "���� ����"),
		DLG_TEXT(STARTX+490,		STARTY+45,  503, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3 , ""),
		DLG_TEXT(STARTX,			STARTY+220,  993, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA4 , m_szNextTitle),
		DLG_TEXT(STARTX,			STARTY+290,  490, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTCTRLBK, TXT_DATA5 , "���� ����"),
		DLG_TEXT(STARTX+490, 	  	STARTY+290,  503, 70, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA6 , ""),
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
		switch (bFirst)
		{
			long i;
		
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:	
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
						break;		
				}
				
				SetBtnImg();
				ReDraw();
				break;
		}
	}

//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;
	
		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgPopTtlL );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
	}

//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
		switch(ID)
		{
			case BID_PREVPHOTO:
			case BID_AFTERPHOTO:
				Shoto_Photo(ID);
				break;
			case BID_PREVVIEW:
			case BID_AFTERVIEW:
				Photo_View(ID);
				break;
			case GID_PREV:
			case BID_OK:
//				2017-07-06 Sanghyun Lee
//				�ַ����(����) ��û���� üũ���� ����. ��ü ȭ�鿡�� '�Ϸ�'��ư �����ÿ��� üũ �ϵ���.
				//if( Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA3)), "N") == 0 &&
				//    Str_Cmp(EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA6)), "N") == 0 )
				//{
				//	Card_Prev();
				//}
				//else if( Validate() )
				//{
				//	g_DirFS_Clear(PHOTO_MW, "*.jpg");
				//	Card_Prev();
				//}

				g_DirFS_Clear(PHOTO_MW, "*.jpg");
				Card_Prev();
				break;
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_DirFS_Clear(PHOTO_MW, "*.jpg");
					g_Del_GcPhoto();
					Card_Move("MENU");
				}
				break;
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "���� �޴��� �����ðڽ��ϱ�?")  == MB_OK)
				{
					g_DirFS_Clear(PHOTO_MW, "*.jpg");
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
			case GID_VMEXIT:
				g_DirFS_Clear(PHOTO_MW, "*.jpg");
				g_Exit_DelGcData();
				break;
		}
	}
	
	
//------------------------------------------------------------------
	void ReDraw(void)
	{
		char szfilenm[256];

        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA6 ), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
        
        if( g_nPhotoFlag == 7 )
        {
        	Str_Cpy(m_Title, "�跮�� ����");
        	Str_Cpy(m_szPrevTitle, "ö�� �跮��");
        	Str_Cpy(m_szNextTitle, "��ġ �跮��");
        }
        else if( g_nPhotoFlag == 8 )
        {
        	Str_Cpy(m_Title, "������ ����");
        	
        	Str_Cpy(m_szPrevTitle, "ö�� ������");
        	Str_Cpy(m_szNextTitle, "��ġ ������");
        }
        
        //�������� Ȯ���ؼ� Y/Nǥ��
		if( g_nPhotoFlag == 7 )
		{
			//ö�Ű跮��
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "M");
			Str_Cat(szfilenm, "B");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, stMtr.szMtr_num);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
			
			if(FFS_Exist(m_szTmp) > 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3),   "Y");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), BLUE);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3),   "N");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), RED);
			}
			
			//��ġ�跮��
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "M");
			Str_Cat(szfilenm, "A");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, stMtr.szMtr_num);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
			
			if(FFS_Exist(m_szTmp) > 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6),   "Y");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), BLUE);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6),   "N");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), RED);
			}
		}
		else if( g_nPhotoFlag == 8 )
		{
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "C");
			Str_Cat(szfilenm, "B");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, stMtr.szMtr_num);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
			
			if(FFS_Exist(m_szTmp) > 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3),   "Y");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), BLUE);				
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3),   "N");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA3), RED);
			}
			
			//��ġ�跮��
			Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
			Str_Cpy(szfilenm, "C");
			Str_Cat(szfilenm, "A");
			Str_Cat(szfilenm, "M");
			Str_Cat(szfilenm, stMtr.szMtr_num);
			Str_Cat(szfilenm, ".jjp");
	
			Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
			SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
			
			if(FFS_Exist(m_szTmp) > 0)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6),   "Y");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), BLUE);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA6),   "N");
				EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA6), RED);
			}
		}
		
		ON_DRAW();
		return;
	}

//----------------------------------------------------------------------------------------------
	void	OnUart(long nEvent, long nData)
	{
		char szfilenm[256];
		long size = 0;
		
		if (nEvent == UART_CAMERA)
		{
			if(nData == 1 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				SPRINT (szfilenm, "Camera/%s",  m_szfilenm,0, 0);
				
				if( FFS_Exist(szfilenm)  )
				{
					size = FFS_GetSize( szfilenm );
					
					if( size > 1048576 )
					{
						MessageBoxEx (CONFIRM_OK, "���� �뷮�� �ʰ��Ͽ����ϴ�.\nī�޶� ���� Ȥ�� ���Կ����ּ���.");
					}
					else
					{
						MessageBoxEx( MESSAGE, "������ �������Դϴ�." );
					
						FFS_Copy( szfilenm, g_szphoto );
						
						VmSleep( 100 );
					}
					
					VmSleep( 100 );
					
					FFS_Delete( szfilenm );
					
					VmSleep(100);
					
					// ȭ�� REFRESH
					ReDraw();
				}
			}
		}
		
		return;
	}

//----------------------------------------------------------------------------------------------
	void	OnTask(long nEvent, long nData)
	{
		char szTmp[256];
		char szfilenm[256];
		char szPhotopath[256];
		char* szPath = NULL;
		long nRet = 0;
		long nLen = 0;
		
//PRINT("nEvent : %d , nData : %d",nEvent,nData,0);
		CloseMessageBox();
		
		if( nEvent == TASK_SYS_CALL )
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
				ReDraw();
			}
		}

		ON_DRAW();
		return;
	}


//----------------------------------------------------------------------------------------------
/*
�跮�ⱳü		C31(��������) | M(�跮��), C(������) | B(ö��), A(��ġ) | M(�跮���ȣ) | D( ������¥(SYSDATE : YYYYMMDDHHMMSS )
���� ���� ���� : C31MBM302410422D20161129111620(�跮�ⱳü ö�� ����), C31CBM302410422D20161129111620(�跮�ⱳü ��ġ ����)
Ŭ���̾�Ʈ ���� ���ϸ� ���� : MBM302410422
*/
	void Shoto_Photo(long ID)
	{
		char *pCamera;
		long nRet;
		char szDate[20];
		handle h = NULL;
		handle hdata = NULL;

		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		if( g_nPhotoFlag == 7 )
		{
			Str_Cpy(m_szfilenm, "M");
		}
		else if( g_nPhotoFlag == 8 )
		{
			Str_Cpy(m_szfilenm, "C");
		}
		
		if( ID == BID_PREVPHOTO )
		{
			Str_Cat(m_szfilenm, "B");
		}
		else if( ID == BID_AFTERPHOTO )
		{
			Str_Cat(m_szfilenm, "A");
		}
		
		Str_Cat(m_szfilenm, "M");
		Str_Cat(m_szfilenm, stMtr.szMtr_num);
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

			Mem_Set((byte*)m_szSql, 0x00, sizeof(m_szSql));
			Str_Cpy( m_szSql, stMw.szCounty);
			Str_Cat( m_szSql," " );
			Str_Cat( m_szSql, stMw.szTown);
			Str_Cat( m_szSql," " );
			Str_Cat( m_szSql, stMw.szVillage_ri);
			Str_Cat( m_szSql," " );
			Str_Cat( m_szSql, stMw.szAddr1_m);
			Str_Cat( m_szSql,"-" );
			Str_Cat( m_szSql, stMw.szAddr1_s);
			Str_Cat( m_szSql,"\n" );
			if( ( Str_Len(stMw.szVillage)+Str_Len(stMw.szBuilding) ) > 0 )
			{
				Str_Cat( m_szSql, stMw.szVillage);
				Str_Cat( m_szSql," " );
				Str_Cat( m_szSql, stMw.szBuilding);
				Str_Cat( m_szSql,"-" );
				Str_Cat( m_szSql, stMw.szHouse_cnt);
				Str_Cat( m_szSql," " );
				Str_Cat( m_szSql, stMw.szEtc_addr);
			}
			else
			{
				Str_Cat( m_szSql, stMw.szHouse_cnt);
				Str_Cat( m_szSql," " );
				Str_Cat( m_szSql, stMw.szEtc_addr);
			}
			
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
				JSON_SetValue	(hdata	, 'C', "position_info"		, m_szSql);
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

//----------------------------------------------------------------------------------------------
	void Photo_View(long ID)
	{	
		char szTmp[256];
		char szViewnm[256];
		char szViewPath[256];
	
		Mem_Set((byte*)m_szfilenm, 0x00, sizeof(m_szfilenm));
		Mem_Set((byte*)szViewnm, 0x00, sizeof(szViewnm));
		if( g_nPhotoFlag == 7 )
		{
			Str_Cat(m_szfilenm, "M");
		}
		else if( g_nPhotoFlag == 8 )
		{
			Str_Cat(m_szfilenm, "C");
		}
		
		if( ID == BID_PREVVIEW )
		{
			Str_Cat(m_szfilenm, "B");
		}
		else if( ID == BID_AFTERVIEW )
		{
			Str_Cat(m_szfilenm, "A");
		}
		
		Str_Cat(m_szfilenm, "M");
		Str_Cat(m_szfilenm, stMtr.szMtr_num);
		
		Str_Cpy(szViewnm, m_szfilenm);
		
		//���� ���� �� JPG ���ϸ�
		Str_Cat(szViewnm, ".jpg");
		//���� ���� �� JJP ���ϸ�
		Str_Cat(m_szfilenm, ".jjp");

		//���� ���� �� JJP ���ϸ�
		Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
		SPRINT (m_szTmp, "%s/%s",PHOTO_MW, m_szfilenm, 0);
		//���� ���� �� JPG ���ϸ�
		Mem_Set((byte*)szViewPath, 0x00, sizeof(szViewPath));
		SPRINT (szViewPath, "%s/%s",PHOTO_MW, szViewnm, 0);
		
		//����(.jjp)�� .jpg �������� ����.
		FFS_Copy( m_szTmp, szViewPath );

		//PDA
		if(Str_Cmp(g_szDEVICE_NAME, "DS3") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 || Str_Cmp(g_szDEVICE_NAME, "M3T") == 0 )
		{
			if( FFS_Exist("\\windows\\iexplore.exe" ) )
			{
				RunApp( "iexplore.exe", m_szTmp);
			}
			else if( FFS_Exist("\\windows\\iesample.exe" ) )
			{
				RunApp( "iesample.exe", m_szTmp);
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "������ȸ ���α׷��� �����ϴ�.");
			}
		}
		else
		{	
			if(FFS_Exist(szViewPath) > 0)
			{
				//WEBVIEWER ȣ�� �� ��ü ��θ� �� �������.
				//Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
				//Str_Cpy(szTmp, "/mnt/sdcard/Smart/");
				//Str_Cat(szTmp, szViewPath);
				RunApp( "WEBVIEWER", szViewPath );
			}
			else
			{
				MessageBoxEx (CONFIRM_OK, "������ �����ϴ�.");
			}
		}
		return;
	}


//----------------------------------------------------------------------------------------------
	bool Validate(void)
	{
		char szfilenm[128];
	
/*
�跮�ⱳü		C31(��������) | M(�跮��), C(������) | B(ö��), A(��ġ) | M(�跮���ȣ) | D( ������¥(SYSDATE : YYYYMMDDHHMMSS )
���� ���� ���� : C31MBM302410422D20161129111620(�跮�ⱳü ö�� ����), C31CBM302410422D20161129111620(�跮�ⱳü ��ġ ����)
Ŭ���̾�Ʈ ���� ���ϸ� ���� : MBM302410422
*/
		if( g_nPhotoFlag == 7 )
		{
			if( Str_Cmp(stChgMtr.szRevis_flag, "10") == 0 || Str_Cmp(stChgMtr.szRevis_flag, "30") == 0 )
			{
				//ö�Ű跮��
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Str_Cpy(szfilenm, "M");
				Str_Cat(szfilenm, "B");
				Str_Cat(szfilenm, "M");
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
		
				Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
				SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
	
				if(FFS_Exist(m_szTmp) <= 0)
				{
					MessageBoxEx (CONFIRM_OK, "�跮�� ������ �Կ��ϼ���.");
					return FALSE;
				}
	
				//��ġ�跮��
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Str_Cpy(szfilenm, "M");
				Str_Cat(szfilenm, "A");
				Str_Cat(szfilenm, "M");
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
		
				Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
				SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
	
				if(FFS_Exist(m_szTmp) <= 0)
				{
					MessageBoxEx (CONFIRM_OK, "�跮�� ������ �Կ��ϼ���.");
					return FALSE;
				}
			}
		}
		else if ( g_nPhotoFlag == 8 )
		{
			if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "30") == 0 )
			{
				//ö�ź�����
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Str_Cpy(szfilenm, "C");
				Str_Cat(szfilenm, "B");
				Str_Cat(szfilenm, "M");
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
		
				Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
				SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
	
				if(FFS_Exist(m_szTmp) <= 0)
				{
					MessageBoxEx (CONFIRM_OK, "������ ������ �Կ��ϼ���.");
					return FALSE;
				}
				
				//��ġ������
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Str_Cpy(szfilenm, "C");
				Str_Cat(szfilenm, "A");
				Str_Cat(szfilenm, "M");
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
		
				Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
				SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
	
				if(FFS_Exist(m_szTmp) <= 0)
				{
					MessageBoxEx (CONFIRM_OK, "������ ������ �Կ��ϼ���.");
					return FALSE;
				}
			}
			else if( Str_Cmp(stMtrChg.PDA_REPL_JOB_ITEM, "20") == 0 )
			{
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Str_Cpy(szfilenm, "C");
				Str_Cat(szfilenm, "B");
				Str_Cat(szfilenm, "M");
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
		
				Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
				SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
	
				if(FFS_Exist(m_szTmp) <= 0)
				{
					MessageBoxEx (CONFIRM_OK, "������ ������ �Կ��ϼ���.");
					return FALSE;
				}
	
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Str_Cpy(szfilenm, "C");
				Str_Cat(szfilenm, "A");
				Str_Cat(szfilenm, "M");
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
		
				Mem_Set((byte*)m_szTmp, 0x00, sizeof(m_szTmp));
				SPRINT (m_szTmp, "%s/%s",PHOTO_MW, szfilenm, 0);
	
				if(FFS_Exist(m_szTmp) <= 0)
				{
					MessageBoxEx (CONFIRM_OK, "������ ������ �Կ��ϼ���.");
					return FALSE;
				}
			}
		}


		return TRUE;
	}
	
//----------------------------------------------------------------------------------------------	
//�Կ��� ���� ����
	void Delete_Photo(void)
	{
		char *pCamera;
		char szFullpath[256];
		char szfilenm[100];
		long nRet;

		if( Str_Cmp(stMtrChg.SEND_YN, "S") != 0 && Str_Cmp(stMtrChg.SEND_YN, "Y") != 0 )
		{
			if( g_nPhotoFlag == 7 )
			{
				//ö���� �跮��
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
				Str_Cpy(szfilenm, "MBM");
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
				SPRINT (szFullpath, "%s/%s", PHOTO_MW,  szfilenm, 0);
		
				if(FFS_Exist(szFullpath) > 0)
				{
					FFS_Delete( szFullpath );
				}
				
				Sleep(50);
		
				//��ġ�� �跮��
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
				Str_Cpy(szfilenm, "MAM");				
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
				SPRINT (szFullpath, "%s/%s", PHOTO_MW,  szfilenm, 0);
		
				if(FFS_Exist(szFullpath) > 0)
				{
					FFS_Delete( szFullpath );
				}
			}
			else if( g_nPhotoFlag == 8 )
			{
				//ö���� ������
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
				Str_Cpy(szfilenm, "CBM");
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
				SPRINT (szFullpath, "%s/%s", PHOTO_MW,  szfilenm, 0);
		
				if(FFS_Exist(szFullpath) > 0)
				{
					FFS_Delete( szFullpath );
				}
				
				Sleep(50);
		
				//��ġ�� ������
				Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
				Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
				Str_Cpy(szfilenm, "CAM");				
				Str_Cat(szfilenm, stMtr.szMtr_num);
				Str_Cat(szfilenm, ".jjp");
				SPRINT (szFullpath, "%s/%s", PHOTO_MW,  szfilenm, 0);
		
				if(FFS_Exist(szFullpath) > 0)
				{
					FFS_Delete( szFullpath );
				}
			}
		}
		
		return;
	}

}


