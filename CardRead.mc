/*----------------------------------------------------------------------------------
	Project Name: Smart 
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
	----------	------		------------------------------------------------------
	2014.10.01	�̻���		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/

sharecard CardRead
{
	#include "include.h"

#define VER_RELEASE

	/*---------------------------------------------------------------------------*/
	// Description
	//	 ĳ���� ���̾�α� ���� ��¥�� ������ ���� �Ѱ��ش�.
	// prameter
	// 	 dayOfWeek : ������ �Ѱ��ش�. 0-��, 1-��
	// return 
	//	 0           : ������ �� �Ǿ���.
	//	 0�� �ƴ� �� : yy * 10000 + mm * 100 + dd �������� ���õ� ��¥�� �Ѱ��ش�.
	/*---------------------------------------------------------------------------*/
	long CardReadDialog(long nTrack, char* szCardNum);

#define CWD			25
#define CHT			40
#define	SPRINT(buf,fmt,a,b,c) Str_Printf((buf),fmt,(quad)(a),(quad)(b),(quad)(c))

#define FREE(x) \
{\
	if(x)\
	{\
		MEM_DEL((void*)x);\
		x = NULL;\
	}\
}
		
		// ����̽� ȭ�� ũ�� �з�
enum
{
	FAMILY_SMALL,
	FAMILY_MIDDLE,
	FAMILY_LARGE,
	FAMILY_SUPER
} DisplayType;

#define SIZE_PDA		240*320		// PDA  (PDA �迭)
#define SIZE_SMALL		720*1280	// small (galaxy phone�迭)
#define SIZE_MIDDLE		1080*1920	// middle  (galaxy note �迭)
#define SIZE_LARGE		1440*2560	// large  (galaxy pad  �迭)
#define SIZE_SUPER		1440*2560	// super  (galaxy pad  �迭)


#define	MAKE_RGB(r, g, b) ( ( ( (unsigned long)r << 8 ) & 0x0000f800) | \
							( ( (unsigned long)g << 3 ) & 0x000007e0) | \
							( ( (unsigned long)b >> 3 ) & 0x0000001f)  )

#define		THEBLACK     	MAKE_RGB(0, 0, 0)
#define		THEBLUE     	MAKE_RGB(0, 0, 255)
#define		THERED	     	MAKE_RGB(255, 0, 0)
#define		THEWHITE	    MAKE_RGB(255, 255, 255)
#define 	TRANSPARENT		MAKE_RGB(255, 0, 255)
#define		YELLOWORANGE    MAKE_RGB(255, 204, 153)
#define		YELLOWGREEN     MAKE_RGB(255, 255, 204)
#define		REDSHINE 		MAKE_RGB(255, 204, 204)


#define		MEGBKCOLOR_CONFIRM		YELLOWGREEN          //MAKE_RGB( 7, 26, 42) 55,113,152      7, 26, 42
#define		MEGBKCOLOR_WARNING		YELLOWORANGE          //MAKE_RGB( 7, 26, 42) 55,113,152      7, 26, 42
#define		MEGBKCOLOR_ERROR		REDSHINE          //MAKE_RGB( 7, 26, 42) 55,113,152      7, 26, 42


#define	TEXTTITLEBACKCOLOR	THEWHITE
#define	TITLE_BKCOLOR		THEWHITE
#define	DLG_BKCOLOR			THEWHITE
#define	TITLE_FGCOLOR		THEBLACK
#define		BTNCTRLFRCOLOR		THEBLACK  //�Ϲݹ�ư���ڻ�
#define		BTNCTRLBKCOLOR		MAKE_RGB(144, 217, 255) //MAKE_RGB(224, 244, 255) //�Ϲݹ�ư ����


#define MSG_CONNECT	10
#define MSG_SCANING	20
#define MSG_ERROR	30
#define MSG_WARNING	40
#define MSG_SCANED	50


#define BTNID_CANNCEL	1001
#define BTNID_EXIT		1002
#define BTNID_OK 		1003
#define BTNID_YES		1004
#define CARD_READ_EVENT 3000

VM_PROFILE 	stProfile;//VM ������������
long	m_nFontType;
long	m_nType = 0;
long	m_nStuts = 0;
long 	m_nTimerid = 0;
long	m_nTOT = 0;

long DMS_X( long x );
long DMS_Y( long y );
char* Get_ImgPath(char* trgpath, char* imggb, char* fsnm);
handle MAIN_DLG(char* text, quad del, quad add, quad bkClr, quad TfrClr, quad TbkClr, long T_height );
handle DLG_TXT(handle h_dlg, long id, long x, long y, long width, long height, quad bkClr, quad style, long align, char* text);
handle DLG_BUT(handle hDlg, long index, long x, long y, long width, long height, quad bkClr, quad frClr, quad add, long id, char* text);
handle DLG_IBUT(handle hDlg, long index, long x, long y, long width, long height, long dx, long dy, 
								quad bkClr,quad frClr, quad add, long id, byte* img, byte* actimg, char* text);



//������������������������������������������������������������������������������
//��					�� Card Variables and Functions  					  ��
//������������������������������������������������������������������������������
	// STATIC VARIABLES
	handle	m_hDlg = 0;
	char m_szMsg[200];
	char m_sztitle[50];
	
	
//������������������������������������������������������������������������������
//�� 					    ��  Event Handler  ��							  ��
//������������������������������������������������������������������������������
	// STATIC FUNCTIONS
	void OnInit(char bFirst);
	void OnExit(void);
	void OnChar(long nChar);
	void OnKey( long nKey );
	void OnDraw(void);
	void OnTimer(long nTimerID);
	void OnPointing(long nAction,long X, long Y);
	long OnButton(long ID);
	void OnSelect(long Index);

	void GetDeviceInfo (void);
	void DisPaly(long nStuts);
	void CloseDlg(void);
	

	long DMS_X( long x )
	{
	long dms_x = 0;
		dms_x = (x*stProfile.LCD_WIDTH)/1000;
		return dms_x;
	}
		
	long DMS_Y( long y )
	{
	long dms_y = 0;
		dms_y = (y*stProfile.LCD_HEIGHT)/1000;
		return dms_y;		
	}
	
	
	void GetDeviceInfo (void)
	{
		long 	nSize = 0;

		Mem_Set ((byte*)&stProfile, 0, sizeof(stProfile));
		
		// ����̽��� ���� profile�� �����´�.
		VM_GetProfile(&stProfile);
	
		nSize = stProfile.LCD_WIDTH*stProfile.LCD_HEIGHT;
		
		if ( nSize <= SIZE_SMALL )
		{
			m_nType = FAMILY_SMALL;
		}
		else if ( nSize > SIZE_SMALL && nSize < SIZE_MIDDLE )
		{
			m_nType = FAMILY_SMALL;
		}
		else if ( nSize >= SIZE_MIDDLE && nSize < SIZE_LARGE )
		{
			m_nType = FAMILY_MIDDLE;
		}
		else if ( nSize >= SIZE_LARGE && nSize < SIZE_SUPER )
		{
			m_nType = FAMILY_LARGE;
		}
		else if ( nSize >= SIZE_SUPER )
		{
			m_nType = FAMILY_LARGE;
		}
		
		switch (m_nType)
		{
			case FAMILY_SMALL:
				m_nFontType = FONT_36;
				break;
			case FAMILY_MIDDLE:
				m_nFontType = FONT_56;
				break;
			case FAMILY_LARGE:
				m_nFontType = FONT_72;
				break;
			case FAMILY_SUPER:
				m_nFontType = FONT_72;
				break;
			default:
				m_nFontType = FONT_24;
				break;
		}
	}
	
//������������������������������������������������������������������������������
//�� 						��	Main Function ��	   				          ��
//������������������������������������������������������������������������������
	//sharecard���� main�Լ��� �ε�� �Ŀ� �Լ� �̸� �Ѱ� �޾Ƽ�
	//�Լ� ������ �Ѱ��ִ� ������ �Ѵ�.
	int	main (quad MsgType, quad wParam, quad lParam)
	{
		if ( Str_Cmp("CardReadDialog", (char*)MsgType) == 0 )
			return (int)CardReadDialog;
		return 0;
	}
	
	long CardReadDialog(long nTrack, char* szCardNum)
	{
	long ret;
	long iTrack;
	char CardNum[100];
		
		HandlerMsg msg;
		
		GetDeviceInfo();
		
		//DisPaly( MSG_CONNECT );
		
//		CardReader_Open("WOOSIM");
		
		DisPaly( MSG_SCANING );
		
		while ( Handler_PeekMessage(&msg)==0 )
		{
			
			if ( msg.MsgType == MSG_EXIT )
			{
				HandlerMsg exitMsg;
				OnExit();
				return 0;		
			}
			Handler_GetMessage(&msg);
			
			Print("msg.MsgType=[%d], msg.wParam=[%d]", msg.MsgType , msg.wParam, 0);
			
			if( m_nTOT == 7  &&  msg.MsgType != MSG_BUTTON && msg.MsgType != MSG_POINTING && msg.MsgType != MSG_EXIT )
			{
				msg.MsgType = 16;
				msg.wParam = CARD_READ_EVENT;
				Print("CARD_READ_EVENT msg.MsgType=[%d], msg.wParam=[%d]", msg.MsgType , msg.wParam, 0);
			}
			
			switch ( msg.MsgType)
			{
				case MSG_CHAR:			
					OnChar (msg.wParam);	
					break;
				case MSG_KEY:
					OnKey (msg.wParam);		
					break;
				case MSG_POINTING:
					OnPointing (msg.wParam, (long)(msg.lParam & 0xFFFF), (long)(msg.lParam >> 16));
					break;
					
				case MSG_TIMER:
					OnTimer(msg.wParam);
					break;	
							
				case MSG_BUTTON:
				{
					long ret;
					ret = OnButton (msg.wParam);	
					if ( ret < 0 )
					{
						OnExit();
						Print("CARDREAD END eeeeee", 0 , 0, 0);
						return -1;
					}
					else if(ret == 1 )
					{
						OnExit();
						Print("CARDREAD END susess", 0 , 0, 0);
						return 1;
					}
					break;
				}
				case 16:
					if( msg.wParam == CARD_READ_EVENT )
					{
						Print("MSG_SCANED", 0 , 0, 0);
					
						Mem_Set((byte*)CardNum, 0x00, sizeof(CardNum) );
						//CardReader_ReadRawData( nTrack, CardNum, 50 );
						Str_Cpy(CardNum, "test1111111"  );
						Print("CardReader_ReadRawData=[%s]", (long)CardNum , 0, 0);
						
						if( Str_Len (CardNum) > 0)
						{
							Str_Cpy( szCardNum, CardNum );
							//OnExit();
							DisPaly( MSG_SCANED );
							Print("CARDREAD END 11111", 0 , 0, 0);
							break;
							//return 1;
						}
						DisPaly( MSG_WARNING );
					}
					break;
				
			}//end of switch
			OnDraw();
			GrDev_Refresh();
		}// end of while
		
		Print("CARDREAD END 00000", 0 , 0, 0);
		return 0;
	}
	
	void DisPaly(long nStuts)
	{
	long ret = 1;
	
		CloseDlg();
		Print("nStuts=[%d]", nStuts , 0, 0);
		switch(nStuts)
		{		
			case MSG_CONNECT:
				Print("MSG_CONNECT", 0 , 0, 0);
				m_nStuts = MSG_CONNECT;
				//CardReader_Open();
				break;
				
			case MSG_SCANING:
				Print("MSG_SCANING", 0 , 0, 0);
				m_nStuts = MSG_SCANING;
				//ret= CardReader_StartEvent( CARD_READ_EVENT );
				if(ret >= 0)
				{
					if(	m_nTimerid == 0	)
					{
						//m_nTimerid = Timer_Set( 500, 0 );
						m_nTOT = 0;
					}	
				}
				else
				{
					m_nStuts = MSG_ERROR;	
				}	
				break;
			case MSG_SCANED:
				m_nStuts = MSG_SCANED;
				break;
				
			case MSG_ERROR:
				Print("MSG_ERROR", 0 , 0, 0);
				m_nStuts = MSG_ERROR;
				break;
			
			case MSG_WARNING:
				Print("MSG_WARNING", 0 , 0, 0);
				m_nStuts = MSG_WARNING;
				//CardReader_StopEvent();
				break;
		}
		OnInit(1);
		OnDraw();
		GrDev_Refresh();
	}
	
	
//������������������������������������������������������������������������������
//�� 				   ��	OnInit Function  ��  				              ��
//������������������������������������������������������������������������������
	void OnInit(char bFirst)
	{
		handle htext;
		long index = 0;
		
		// Title
		m_hDlg = MAIN_DLG("", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0,  DLG_BKCOLOR, TITLE_FGCOLOR,  TITLE_BKCOLOR , 15);		
		Dialog_SetRange(m_hDlg, DMS_X(90), DMS_Y(100), DMS_X(925), DMS_Y(570) );
		
		Str_Cpy(m_sztitle, "ī �� �� ��");
		htext = DLG_TXT(m_hDlg, index++,  0,  0,  835,  70, MEGBKCOLOR_CONFIRM, 0, EDITALIGN_MIDDLE|EDITALIGN_CENTER,  m_sztitle);
		if( m_nStuts == MSG_CONNECT || m_nStuts == MSG_SCANING || m_nStuts == MSG_SCANED )
		{
			EditCtrl_SetBkColorEx( htext, MEGBKCOLOR_CONFIRM );
		}
		else if( m_nStuts == MSG_WARNING )
		{
			EditCtrl_SetBkColorEx( htext, MEGBKCOLOR_WARNING );
		}
		else if(m_nStuts == MSG_ERROR )
		{
			EditCtrl_SetBkColorEx( htext, MEGBKCOLOR_ERROR );
		}
	
		Mem_Set( (byte*)m_szMsg, 0x00, sizeof(m_szMsg) );
		
		if( m_nStuts == MSG_CONNECT )
		{
			Str_Cpy(m_szMsg, "ī�帮���� ���� �� �Դϴ�...");
		}
		else if( m_nStuts == MSG_SCANING )
		{ 
			Str_Cpy(m_szMsg, "ī�带 ��ĵ�ϼ���...");
		}
		else if( m_nStuts == MSG_SCANED )
		{ 
			Str_Cpy(m_szMsg, "ī�带 �����Ͽ����ϴ�.");
		}
		else if( m_nStuts == MSG_WARNING )
		{
			Str_Cpy(m_szMsg, "ī�彺ĵ �����Ͽ����ϴ�. ��õ� �Ͻðڽ��ϱ�?");
		}
		else if(m_nStuts == MSG_ERROR )
		{
			Str_Cpy(m_szMsg, "ī�彺ĵ�� �����߻��߽��ϴ�. ��õ� �Ͻðڽ��ϱ�?");
		}
		
		htext = DLG_TXT(m_hDlg, index++,  20,  170,  800,  140, THEWHITE,  0, EDITALIGN_MIDDLE|EDITALIGN_CENTER, m_szMsg);
		EditCtrl_SetMultiLine(htext, TRUE, 10, EDITSEP_NONE);
		
		
		//��� ��ư
		if( m_nStuts == MSG_SCANING )
		{
			DLG_BUT(m_hDlg, index++, 540, 380, 233, 70, BTNCTRLBKCOLOR, BTNCTRLFRCOLOR, 0, BTNID_CANNCEL, "ī�帮�����");				
		}
		else if(m_nStuts == MSG_ERROR || m_nStuts == MSG_WARNING  )
		{
			//ok
			DLG_BUT(m_hDlg, index++,  50, 380, 233, 70, BTNCTRLBKCOLOR, BTNCTRLFRCOLOR, 0, BTNID_OK, "��õ�");
			
			DLG_BUT(m_hDlg, index++, 540, 380, 233, 70,  BTNCTRLBKCOLOR, BTNCTRLFRCOLOR, 0, BTNID_EXIT, "�ݱ�");
		}
		else if( m_nStuts == MSG_SCANED )
		{
			DLG_BUT(m_hDlg, index++, 540, 380, 233, 70,  BTNCTRLBKCOLOR, BTNCTRLFRCOLOR, 0, BTNID_YES, "�Ϸ�");
		}
	}
	
	
	void CloseDlg(void)
	{
		if(m_hDlg)
		{
			Dialog_DeleteObject(m_hDlg);
			m_hDlg = 0;
		}
	}
	
//������������������������������������������������������������������������������
//�� 					��	OnExit Function  ��   				              ��
//������������������������������������������������������������������������������
	void OnExit(void)
	{
		Print("OnExit CardEND", 0 , 0, 0);
		if( m_hDlg )
		{
			Dialog_DeleteObject(m_hDlg);
			m_hDlg = 0;
		}
		
		//CardReader_Close();
		
		if( m_nTimerid )
			Timer_Kill( m_nTimerid );
	}
	
//������������������������������������������������������������������������������
//�� 					��	OnKey Function  ��   				              ��
//������������������������������������������������������������������������������
	void OnKey(long Key)
	{
		if( m_hDlg )
			Dialog_KeyProcess(m_hDlg, Key);		
	}
	
//������������������������������������������������������������������������������
//�� 					��	OnChar Function  ��   				              ��
//������������������������������������������������������������������������������
	void OnChar(long Code)
	{
		if( m_hDlg )
			Dialog_CharProcess(m_hDlg, Code);
	}
	
//������������������������������������������������������������������������������
//�� 					��	OnDraw Function  ��   				              ��
//������������������������������������������������������������������������������
	void OnDraw(void)
	{
		if( m_hDlg )
			Dialog_Draw(m_hDlg, TRUE);
	}
	
//������������������������������������������������������������������������������
//�� 					��	OnTimer Function  ��   				              ��
//������������������������������������������������������������������������������
	void OnTimer(long nTimerID)
	{
		if( m_hDlg )
		{
			Dialog_Timer(m_hDlg);
		}
		
		Print("OnTimer   nTimerID=%d m_nTOT=%d", nTimerID, m_nTOT, 0);
		
		if(m_nTimerid == nTimerID)
		{
			if(m_nTOT == 10)
			{
				Timer_Kill( m_nTimerid );
				m_nTimerid = -1;
				m_nTOT=0;
				Print("OnTimer TIME OUT", 0, 0, 0);
				DisPaly( MSG_WARNING );
			}
			m_nTOT++;
		}
	}
	
//������������������������������������������������������������������������������
//�� 					��	OnPointing Function  ��  			              ��
//������������������������������������������������������������������������������
	void OnPointing(long nAction, long X, long Y)
	{		
		if( m_hDlg )
			Dialog_PointingProcess(m_hDlg, nAction, X, Y);
	}
	
//������������������������������������������������������������������������������
//�� 				   ��	OnButton Function  ��  				              ��
//������������������������������������������������������������������������������
	long OnButton(long ID)
	{
	long ret = 0;
	
		switch(ID)
		{		
			case BTNID_CANNCEL:
				//CardReader_StopEvent();
				return -1;
			
			case BTNID_EXIT:
				return -1;
			
			case BTNID_OK:
				DisPaly( MSG_SCANING );
				return 0;
				
			case BTNID_YES:
				return 1;	
				
		}
		return 0;
	}
	
//������������������������������������������������������������������������������
//�� 				   ��	OnSelect Function  ��  				              ��
//������������������������������������������������������������������������������	
	void OnSelect(long Index)
	{
	}

//������������������������������������������������������������������������������
//�� �� Dialog Control Create												  ��
//������������������������������������������������������������������������������
	handle MAIN_DLG(char* text, quad del, quad add, quad bkClr, quad TfrClr, quad TbkClr, long T_height )
	{
			// Ÿ��Ʋ , ����Ÿ��, �߰�Ÿ��, ����, Ÿ��Ʋ�����, Ÿ��Ʋ����, Ÿ��Ʋ����
			handle m_hDLGMain;
			m_hDLGMain = Dialog_CreateObject();
			Dialog_SetTitle (m_hDLGMain, text);
			Dialog_SetBkColorEx(m_hDLGMain,bkClr);
			Dialog_SetTitleBkColorEx (m_hDLGMain, TbkClr);
			Dialog_SetTitleForeColorEx(m_hDLGMain, TfrClr);
			Dialog_SetTitleHeight (m_hDLGMain, T_height);
			Dialog_ModifyStyle(m_hDLGMain, del, add);
			return m_hDLGMain;
	}
//������������������������������������������������������������������������������
//�� �� Dialog [Text] Control Create										  ��
//������������������������������������������������������������������������������
	handle DLG_TXT(handle h_dlg, long id, long x, long y, long width, long height, quad bkClr, quad style, long align, char* text)
	{
		handle h;
		h = Dialog_CreateTextCtrl(h_dlg,id, DMS_X(x), DMS_Y(y), DMS_X(x+width), DMS_Y(y+height),text);
		EditCtrl_ModifyStyle( h, 0, style );
		EditCtrl_SetAlign ( h, align );
		EditCtrl_SetBkColorEx ( h, bkClr );
		EditCtrl_SetFont(h, m_nFontType);
		return h;
	}
	
//������������������������������������������������������������������������������
//�� �� Dialog [Button] Control Create										  ��
//������������������������������������������������������������������������������
	handle DLG_BUT(handle hDlg, long index, long x, long y, long width, long height, quad bkClr, quad frClr, quad add, long id, char* text)
	{
		handle h;
		h = Dialog_CreateButCtrl(hDlg, index, DMS_X(x), DMS_Y(y), DMS_X(x+width), DMS_Y(y+height), id, text);
		ButCtrl_ModifyStyle( h, BUTSTY_ROUNDBORDER|BUTSTY_BOLD, add );
		//ButCtrl_ModifyStyle( h, del, add );
		ButCtrl_SetBkColorEx ( h, bkClr );
		ButCtrl_SetForeColorEx(h,frClr);
		ButCtrl_SetFont(h, m_nFontType);
		return h;//����.����.����0 �޸𸮶�����..
	}

//������������������������������������������������������������������������������
//�� �� Dialog [Image Button] Control Create								  ��
//������������������������������������������������������������������������������
	handle DLG_IBUT(handle hDlg, long index, long x, long y, long width, long height, long dx, long dy, 
								quad bkClr,quad frClr, quad add, long id, byte* img, byte* actimg, char* text)
	{
		handle h;
		h = Dialog_CreateButCtrl(hDlg, index, DMS_X(x), DMS_Y(y), DMS_X(x+width), DMS_Y(y+height), id, text);
		ButCtrl_ModifyStyle( h, BUTSTY_BORDER|BUTSTY_BOLD, add );
		//ButCtrl_ModifyStyle( h, del, add );
		ButCtrl_SetBkColorEx ( h, bkClr );
		ButCtrl_SetForeColorEx(h, frClr);
		ButCtrl_SetDelta(h, dx, dy);
		ButCtrl_SetFont(h, m_nFontType);
		return h;
	}
} // End of Card Calendar

