/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/
card CM_PHOTO
{
	#include <include.h>
	#include "globalcard.h"
	
//	#define USE_ON_EXIT
//	#define USE_ON_CHAR
//	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER
//	#define USE_ON_POINTING
//	#define USE_ON_SELECT
	#define USE_ON_UART
	
	#include "DefEvent.h"
	
	//BUTTON ID define
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( BID_FLASHON )		//FLASH ON
		DEF_BUTTON_ID ( BID_FLASHOFF )		//FLASH OFF
		DEF_BUTTON_ID ( BID_CAMERAON )		//ī�޶� �ѱ�
		DEF_BUTTON_ID ( BID_SHOOT )			//�Կ�
		DEF_BUTTON_ID ( BID_PHOTO )			//���� ����
		DEF_BUTTON_ID ( BID_SAVE )			//����
		DEF_BUTTON_ID ( BID_OUT )
		DEF_BUTTON_ID ( BID_SEE )
	//ȭ�� ��� ���� �޴� ����
		DEF_BUTTON_ID ( BID_HOME )			//Ȩ
		DEF_BUTTON_ID ( BID_MENU )			//�޴�
		DEF_BUTTON_ID ( BID_KEYBOARD )		//Ű����
		DEF_BUTTON_ID ( BID_SCREEN )		//ȭ�� ����
		DEF_BUTTON_ID ( BID_CMMNWORK )		//�������
		DEF_BUTTON_ID ( BID_PREV )			//����
		DEF_BUTTON_ID ( BID_EXIT )			//����
	END_BUTTON_ID()
	
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( TXT_TITLE )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( TXT_CAMERA )		//ī�޶�
		DEF_OBJECT_ID ( TXT_STATUS )		//���¹�
		
		DEF_OBJECT_ID ( ICON_IMG )			//Ÿ��Ʋ
		DEF_OBJECT_ID ( ICON_TITLE )		//Ÿ��Ʋ
		DEF_OBJECT_ID ( ICO_PHOTO )			// ����
	END_OBJECT_ID()
	
	#define INIT_MAIN	1
	
	#define PHOTO_NM	"Camera/Chk.jpg"
	
	#define FLASH_ON    1
	#define FLASH_OFF   0
	
	#define PHT_WIDTH   200
	#define PHT_HEIGHT  200
	
	byte  	m_Photo[3 + PHT_WIDTH * PHT_HEIGHT * 16 / 8];
	char 	m_chImgBuf[512];
	long	m_nSaveFlag = 0;		//m_nSaveFlag = 0 ���� ���� ����. // m_nSaveFlag = 1 ���� ���� �Ϸ�
	
	long PHOTODRAW (char* PHOTOPATH);
	void SetBtnImg(void);
	
	
	
	// ���� ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),		
		//Ÿ��Ʋ
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TXTFRCOLOR, TXTCTRLBK, TXT_TITLE, "�� �� �� ��"),
		
		//ȭ�� ���� �޴�
		DLG_BUTTON(STARTX,      5, 145, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_HOME, "HOME"),
		DLG_BUTTON(STARTX+150,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, "�޴�"),
		DLG_BUTTON(STARTX+290,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_KEYBOARD, "����"),
		DLG_BUTTON(STARTX+430,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SCREEN,  "ȭ��"),
		DLG_BUTTON(STARTX+570,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CMMNWORK,"����"),
		DLG_BUTTON(STARTX+710,  5, 135, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV,  "����"),
		DLG_BUTTON(STARTX+850,  5, 130, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_EXIT, "����"),
			
		DLG_BUTTON(STARTX, STARTY+620, 480, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FLASHON, "FLASH ON"),
		DLG_BUTTON(STARTX+495, STARTY+620, 480, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FLASHOFF, "FLASH OFF"),
		DLG_BUTTON(STARTX,     STARTY+595, 480, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERAON, "ī�޶� ON"),
		DLG_BUTTON(STARTX, STARTY+710, 480, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEE, "��������"),
		DLG_BUTTON(STARTX+495, STARTY+710, 480, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SHOOT, "�� ��"),
		DLG_BUTTON(STARTX, STARTY+800, 480, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PHOTO, "�ݱ�"),
		DLG_BUTTON(STARTX+495, STARTY+800, 480, 70, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "�� ��"),
		
		DLG_TEXT(STARTX+10, STARTY+40, 965, 550, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, WHITE, TXT_CAMERA, ""),
	};	
	
	// PDA ���̾�α�
	//---------------------------------------------------------------
	DlgObject	DlgRes_P[] = 
	{
		//ȭ��ĸ��
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),	
		DLG_ICON(P_TTLTX, 0, ICON_TITLE, ""),
		//Ÿ��Ʋ
		DLG_TEXT(P_TX, P_TY, P_STWD, P_STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, WHITE, TRANSPARENT, TXT_TITLE, "���� �Կ�"),
		DLG_BUTTON(P_BTNX, P_BTNY, P_BTNWD, P_BTNHD, 0, 0, BUTSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_PREV, ""),

		DLG_BUTTON(STARTX,     STARTY+510, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FLASHON, "FLASH ON"),
		DLG_BUTTON(STARTX+500, STARTY+510, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FLASHOFF, "FLASH OFF"),
		DLG_BUTTON(STARTX,     STARTY+590, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CAMERAON, "ī�޶� ON"),
		DLG_BUTTON(STARTX+500, STARTY+590, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SHOOT, "�� ��"),
		DLG_BUTTON(STARTX,     STARTY+670, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SEE, "��������"),
		DLG_BUTTON(STARTX+500, STARTY+670, 500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE, "�� ��"),
		DLG_BUTTON(STARTX,     STARTY+750, 1000, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OUT, "������"),
		
		DLG_TEXT(STARTX, STARTY-40, 1000, 550, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, WHITE, TXT_CAMERA, ""),
		DLG_TEXT(STARTX, STARTY+830, 1000, 69, 0, 0, 0, EDITSTY_BORDER, RED, TXTCTRLBK, TXT_STATUS, ""),
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
			case INIT_MAIN:
				switch (theDevInfo.m_nType)
				{
					case FAMILY_PDA:
						CREATE_DIALOG_OBJECT (DlgRes_P, SIZEOF(DlgRes_P));
						EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_STATUS), EDITALIGN_MIDDLE);
						Camera_Open("K");
						break;
					default:
						CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));					
						EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_MIDDLE);
						break;		
				}
				
				SetBtnImg();
				break;
		}
	}


//------------------------------------------------------------------
	void SetBtnImg(void)
	{
		void* h;

		IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );		//Ÿ��Ʋ
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
		
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


//------------------------------------------------------------------
	void	OnButton(long ID)
	{	
	long ret;
	long i;
	char sztmp[256];
	
		switch(ID)
		{					
			case BID_FLASHON:
				Camera_Flash(FLASH_ON);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_STATUS), "FLASH ON");
				break;
			case BID_FLASHOFF:
				Camera_Flash(FLASH_OFF);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_STATUS), "FLASH OFF");
				break;
			case BID_CAMERAON:
				Camera_Close();
				VmSleep(50);
				
				Camera_Open("K");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_STATUS), "");
				break;
			case BID_SEE:
				if( FFS_Exist(PHOTO_NM)  )
				{
					Camera_Close();
					RunApp(PHOTO_NM, "");
				}
				
				if( m_nSaveFlag == 1 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_STATUS), "������ �������ּ���.");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_STATUS), "");
				}
				break;
			case BID_SHOOT:
				Camera_Shoot( PHOTO_NM );
				m_nSaveFlag = 1;
				
				//2016-11-10 Sanghyun Lee
				//���� �Կ� �� , 1�� �� vm�� ���� ���Ѽ� �Կ��� �Ϸ�ǵ��� ��ٸ�.
				//�Կ��� �Ϸ�Ǳ� ��, Camera_Close() �� ȣ�� �ϸ� ����� �������� �ʴ� ��찡 �����ϱ� ������.
				VmSleep(100);
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_STATUS), "������ �Կ��Ǿ����ϴ�.�������ּ���!!");
				break;
			case BID_PHOTO:
				Camera_Close();
				break;
			case BID_SAVE:
				if( FFS_Exist(PHOTO_NM)  )
				{
					FFS_Copy ( PHOTO_NM, g_szphoto);
					VmSleep(100);
					FFS_Delete( PHOTO_NM );
					
					//MessageBoxEx (CONFIRM_OK, "�����Ͽ����ϴ�.");
					m_nSaveFlag = 0;
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_STATUS), "������ ����Ǿ����ϴ�.");
				}
				break;
			case BID_OUT:
			case BID_PREV:
				Camera_Close();
				
				if( FFS_Exist(PHOTO_NM) )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "������ �������� �ʾҽ��ϴ�.\n�����Ͻðڽ��ϱ�?")  == MB_OK)
					{
						FFS_Copy ( PHOTO_NM, g_szphoto);
						FFS_Delete( PHOTO_NM );
					}
					else
					{
						FFS_Delete( PHOTO_NM );
					}
				}

				Card_Prev();
				break;
			case BID_HOME:
				Camera_Close();
				Card_Move("MENU");
				break;
			case BID_MENU:
				Camera_Close();
				Card_Move("MENU");
				break;
			case BID_KEYBOARD:
				break;
			case BID_SCREEN:
				break;
			case BID_CMMNWORK:
				break;
			case BID_EXIT:
				g_Exit();
				break;
		}
	}		
	
	
	void OnUart(long wParam, long lParam)
	{
		switch( wParam )
		{
			case UART_CAMERA:
				if( lParam == 1 )
				{
					Camera_SetScreen(0, 0, 240, 180);
				}
				else if( lParam == 2 )
				{
					PRINT("CAMERA SHOOT lParam = 2",0,0,0);
				}
				break;
		}
	}
	
	
//----------------------------------------------------------------------------------------------------------
	long PHOTODRAW (char* PHOTOPATH)
	{
		long fd, nOfs, i;
		word wNum;
		long nReadSize;
		long nBinSize;
		char szImgPath[128+1];
		char szBinPath[128+1];
		handle h;
		long nPHOTOSize;
		
		nPHOTOSize = FS_GetSize ( PHOTOPATH );
		fd = FS_Open( PHOTOPATH, FS_READ_MODE, FS_NORMAL_FLAG);
		if ( fd < 0 )
		{
			
			return -1;
		}

/*
		// �̹�������.C.N , g_szphoto
		for(i=0, nReadSize=0; i<g_stPath.nSize; i+=nReadSize)
		{
			nReadSize = MIN (sizeof(m_chImgBuf), nPHOTOSize-i);
			
			// ��������Ÿ
			FS_Read(fd, (byte*)m_chImgBuf, nReadSize);
		}
*/
		
		FS_Close (fd);
		
		SPRINT (szBinPath, "%s\\%s", DIR_IMG, "Photo.bin", 0);
		
		MessageBoxEx(MESSAGE, "������ ���� �ֽ��ϴ�.\n��ø� ��ٷ��ֽʽÿ�.");
		
		if( ConvertImage ( JPGTOBIN, PHOTOPATH, PHT_WIDTH, PHT_HEIGHT, g_szphoto, 60*1000)!= 0)
			MessageBoxEx(CONFIRM_OK, "���� ��ȯ�� �����߽��ϴ�.\n�ٽ� �õ� �Ͻʽÿ�.");
		
		
		
		CloseMessageBoxEx();
		
		nBinSize = FS_GetSize (szBinPath);
		fd = FS_Open( szBinPath, FS_READ_MODE, FS_NORMAL_FLAG);
		FS_Read ( fd, m_Photo, nBinSize );
		FS_Close (fd);
		
		IconCtrl_Draw( Get_hDlgCtrlByID(ICO_PHOTO));

		return 0;
	}
}


