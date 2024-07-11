/*----------------------------------------------------------------------------------
	Project Name: Smart 
	Smart Application : �����Լ�
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
	----------	------		------------------------------------------------------
	2014.10.01	�̻���		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/
card globalcard
{
#include	"include.h"
#include	"globalcard.h"
#include	"CardGui.lib"
//#include	"MemMgr.lib"
#include	"FileMgr.lib"
#include 	"SQL.lib"
	 
	#include	"ArrayList.c"
//	#include	"HashMap.c"
//	#include	"List.c"
//	#include	"Vector.c"

	//--------------------------------------------------------------------------------------
	// Global ���ʷ� ����Ǵ� �Լ�
	//--------------------------------------------------------------------------------------
	void g_LoadGlobal(void)
	{
		char szBarFlag[5];
		char buf[256];
		char path[256];
		//char* ptr = NULL;
	
		//�۷ι����� �ʱ�ȭ�Ǿ�� �ϴ� ��� �͵�....
		
		Print ("Loaded g_LoadGlobal...",0,0,0);
		
		g_GetImgLoad();

		SetExtEvtUart		( g_OnUart );

		//PUSH �̺�Ʈ ����
		SetExtEvtTask		( g_OnTask );
		
		SetExtEvtTimer		( g_OnTimer );
		
		//���� �ݹ� ����
		SetExtSession 		( g_EvtSessionCallback );
		SetExtEndSession 	( g_EndSessionCallback );
		
		//ptr = Get_BasePath(buf);
		//PRINT("path = %s", ptr, 0,0);
		
		SPRINT (path, "%s/%s", Get_BasePath(buf), "loading%d.pngi", 0);
		
		//�޽��� �ڽ� �̹��� �ε� ��� ����.
		//g_SetProgressIcoPath( "img/HD720/loading%d.pngi" );
		g_SetProgressIcoPath( path );
		
		////////////////////////////
		//�� ��Ÿ�� ���� ����
		//��Ÿ�� ����ü�� �����Ѵ�.
		////////////////////////////
		
		//�׸��� Ÿ��Ʋ ������ �����Ѵ�.
		theApp.m_style.m_nGridTitleColor = GRIDTTLBK;
		
		//�׸��� ���� ���� �����Ѵ�.
		theApp.m_style.m_nGridSelectedColor = TABLETITLE_COLOR;

		//�׸��� ��Ʈ������ ������ �����Ѵ�.		
		theApp.m_style.m_nGridStripedColor = MINTCREAM;
		//theApp.m_style.m_nGridStripedColor = GAINSBORO;		
		//theApp.m_style.m_nGridStripedColor = LIGHTGRAY;
		
		g_nPrinterTimerID = -1;
		
		//������, ī�� ��� ����. ��� : WOOSIM(IODEV_WOOSIM) , PM80 : PM80(IODEV_PM80)
		Str_Cpy( g_szPrintPort, IODEV_WOOSIM );
	}
	
	//--------------------------------------------------------------------------------------
	//WAS URL ����
	//WAS RELEASE_1(21) -> https://smart.seoulgas.co.kr/scgas-0.0.1-SNAPSHOT/services/neptune
	//WAS RELEASE_2(22) -> https://smart.seoulgas.co.kr/scgas-0.0.2-SNAPSHOT/services/neptune
	//WAS TEST_1(37)	-> https://smart-test.seoulgas.co.kr/scgas-0.0.1-SNAPSHOT/services/neptune
	//WAS TEST_2(38)	-> https://smart-test.seoulgas.co.kr/scgas-0.0.2-SNAPSHOT/services/neptune
	//--------------------------------------------------------------------------------------
	
	//SERVER URL RELEASE/TEST	
	#ifdef VER_RELEASE
	
			#define KEY_URL ""
	
	#else
	
			#define KEY_URL "-test"
			
	#endif //__USE_RELEASE__
	
	//SERVER TYPE
	#ifdef TYPE_BASIC
		
		#define KEY_TYPE "0.0.1"
	
	#else
	
		#define KEY_TYPE "0.0.2"
	
	#endif //__TYPE_BASIC__

	
	//WAS main url
	#define G_WAS_BASE_URL 	"https://smart-test.seoulgas.co.kr/scgas-0.0.2-SNAPSHOT/services/neptune"
	//#define G_WAS_BASE_URL 	"http://localhost:8081/scgas-0.0.2-SNAPSHOT/services/neptune"
	//#define G_WAS_BASE_URL 	"https://smart" 	KEY_URL ".seoulgas.co.kr/scgas-" KEY_TYPE "-SNAPSHOT/services/neptune"
	//#define G_WAS_BASE_URL 	"http://10.20.1.22:8080/scgas-" KEY_TYPE "-SNAPSHOT/services/neptune"

	//OZ main url
	//#define G_OZ_BASE_URL 	"https://smart-test.seoulgas.co.kr/oz70/server/"
	#define G_OZ_BASE_URL 	"https://smart.seoulgas.co.kr/oz70/server/"
	//#define G_OZ_BASE_URL 	"https://smart" 	KEY_URL ".seoulgas.co.kr/oz70/server/"
	
	//MDM main url
	//#define G_MDM_BASE_URL 	"https://smartver" 	KEY_URL ".seoulgas.co.kr/main/get/jsonrpc"
	#define G_MDM_BASE_URL 	"https://smartver-test.seoulgas.co.kr/main/get/jsonrpc"

	//-----------------------------------------------------------------
	//����̽� PUSH ����
	//-----------------------------------------------------------------
	//PUSH Service main url (tcp://�� �տ� �ڵ����� �߰��Ǳ� ������...)
	#define G_PUSH_BASE_URL "smart" KEY_URL ".seoulgas.co.kr"
	//#define G_PUSH_BASE_URL "smart-test.seoulgas.co.kr"
	#define G_PUSH_PORT "1883"
 
	//-----------------------------------------------------------------
	//ī�� ���� ����
	//define CARD_APPRO_RELEASE => �������� ���Ź��� �����ͷ� ���� 
	//undef  CARD_APPRO_RELEASE => �׽�Ʈ ������ȣ�� ����(cert_num = 1002189855 , card_term_id1, card_term_id2 : DPT0TEST03)
	//-----------------------------------------------------------------
	//#define CARD_APPRO_RELEASE -->>>>> ����

	//--------------------------------------------------------------------------------------
	char* g_GetBaseUrl(long url_alias)
	{
		switch(url_alias)
		{
			default:
			case WAS_BASE_URL:
				PRINT("global g_GetBaseUrl G_WAS_BASE_URL:[%s]", G_WAS_BASE_URL, 0, 0);
				return G_WAS_BASE_URL;
				
			case MDM_BASE_URL:
				PRINT("global g_GetBaseUrl G_MDM_BASE_URL:[%s]", G_MDM_BASE_URL, 0, 0);
				return G_MDM_BASE_URL;
				
			case PUSH_BASE_URL:
				PRINT("global g_GetBaseUrl G_PUSH_BASE_URL:[%s]", G_PUSH_BASE_URL, 0, 0);
				return G_PUSH_BASE_URL;
			
			case OZ_BASE_URL:
				PRINT("global g_GetBaseUrl G_OZ_BASE_URL:[%s]", G_OZ_BASE_URL, 0, 0);
				return G_OZ_BASE_URL;
		}
	}
	
	//-----------------------------------------------------------------
	bool g_IsCardReader(void)
	{
		return MATCH(IODEV_PM80, g_szPrintPort);
	}

	//-----------------------------------------------------------------
	long g_Push_GetValue(char* pszKey)
	{
		long nRet = 0;
		handle h = NULL;
	
		h = JSON_Create( JSON_Object );
		if(h == NULL)
		{
			nRet = -1;
			goto Finally;
		}
		
		JSON_SetValue (h, 'C', "key", pszKey);

		System_Call	("GetPushConfig" , JSON_toString(h));
		
		//����� �ݹ����� ���� ��.

	Finally:
	
		JSON_Finalize(h);
		
		return nRet;
	}

	//-----------------------------------------------------------------
	long g_Push_SetValue(char* pszKey, char* pszVal)
	{
		long nRet = 0;
		handle h = NULL;
	
		h = JSON_Create( JSON_Object );
		if(h == NULL)
		{
			nRet = -1;
			PRINT("JSON ��ü ���� ����.",0,0,0 );
			goto Finally;
		}
		
		JSON_SetValue (h, 'C', "key", pszKey);
		JSON_SetValue (h, 'C', "val", pszVal);

		System_Call	("SetPushConfig", JSON_toString(h));

	Finally:
	
		JSON_Finalize(h);
		
		return nRet;
	}
	
	//-----------------------------------------------------------------
	long g_FormatPhoneNumber(char *in, char *out)
	{
	    long c = 0;
	    
	    while (*in != 0)
	     {
	        if (c == 3 || c == 7)
	        {
	            *out++ = '-';
	        }
	        
	        *out++ = *in++;
	        c++;
	    }
	    *out = 0;
	    
	    return c + 2;
	}
	
	//-----------------------------------------------------------------
	void g_InitPush(void)
	{
		char szTelnum[20];
		char szBuf[20];
		
		g_SetPushLogin();
		
		//Push url
		g_Push_SetValue("hostUrl", GET_URL(PUSH_BASE_URL));
		
		//Push port
		g_Push_SetValue("hostPort", G_PUSH_PORT);
		
		//'-' : hyphen �ִ� �ڵ� �ʿ� ��.
		Mem_Set( (byte*)szTelnum, 0x00, sizeof(szTelnum) );
		Tapi_GetPhoneNum( (byte*)szTelnum, 0);
		
		g_FormatPhoneNumber(szTelnum, szBuf);
		
		//phone number
		g_Push_SetValue("topicID", szBuf);
		
		//2017-09-15 Sanghyun Lee
		//Push ���׷��̵� ��ġ �ڵ�
		//g_Push_SetValue("isDownloadedVm", "false");

		//StartPushService
		g_StartPush();
	}

	//-----------------------------------------------------------------
	void g_SetPushLogin(void)
	{
		g_Push_SetValue("isLogged", "true");
	}

	//-----------------------------------------------------------------
	void g_SetPushLogout(void)
	{
		g_Push_SetValue("isLogged", "false");
	}
	
	//-----------------------------------------------------------------
	void g_StartPush(void)
	{
		System_Call	("StartPushService" , "");
	}

	//-----------------------------------------------------------------
	void g_StopPush(void)
	{
		System_Call	("StopPushService" , "");
	}
	
	//-----------------------------------------------------------------
	void g_SetPrinterCallBack(PrinterCallBack pf)
	{
		printerCallBack = pf;
	}

	//--------------------------------------------------------------------------------------
	void Update_DB(char* szDate)
	{
	}
	
	//--------------------------------------------------------------------------------------
	void g_GetImgLoad(void)
	{
		char szImg[256];
		char szbuf[256];
		Mem_Set( (byte*)szImg, 0x00, sizeof(szImg) );
	
		//PROGRESS_Start();
	
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			g_ImgNameChg();
		
			//���� ȭ��
			g_pImgMainExit = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "main_btn_out" ) );
			g_pImgLogo     = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "main_logo" ) );
			
			//Ÿ��Ʋ
			g_pImgMainTtl  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "title_bg_main_all" ) );
			g_pImgPopTtlL = g_pImgMainTtl;
			g_pImgSubTtl = g_pImgPopTtlL;

			//2�� �þ�
			//PNG_COLOR_ALPHA or PNG_COLOR_NORMAL
			//���� �޴� ��ư PNG_COLOR_ALPHA
			g_pImgGm       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_gm" ) );
			g_pImgSc       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_sc" ) );
			g_pImgBs       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_bs" ) );
			g_pImgBf       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_bf" ) );
			g_pImgMw       = GrDev_LoadPngImage(PNG_COLOR_ALPHA,  Get_ImgPath( szImg,  0, "menu_mw" ) );
			g_pImgGc       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_gc" ) );
			g_pImgNp       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_np" ) );
			g_pImgCmm      = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_cmm" ) );
			g_pImgNotice   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_notice" ) );
		}
		else
		{

			//�̹��� ���� ���� �� Ȯ���ڸ� ����
			g_ImgNameChg();
			
 			//���� ȭ��
			g_pImgMainExit = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "main_btn_out" ) );
			g_pImgLogo     = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "main_logo" ) );

			//Ÿ��Ʋ
			g_pImgMainTtl_GM  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "title_bg_main_all_GM" ) );
			g_pImgMainTtl     = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "title_bg_main_all" ) );
			g_pImgBlankTtl    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "title_bg_main" ) );
			g_pImgPopTtlL     = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "title_bg_pop_large" ) );
			g_pImgSubTtlClose = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "title_bg_pop_close" ) );
			
			//��� �޴���ư_�⺻
			g_pImgHomeI    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_home_on" ) );
			g_pImgKeybrdI  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_keypad_on" ) );
			g_pImgScreenI  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_updown_on" ) );
			g_pImgCmmnwrkI = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_sos_on" ) );
			g_pImgExitI    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_logout_on" ) );
			
			//��� �޴���ư_Ŭ��
			g_pImgHomeA    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_home_act" ) );
			g_pImgKeybrdA  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_keypad_act" ) );
			g_pImgScreenA  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_updown_act" ) );
			g_pImgCmmnwrkA = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_sos_act" ) );
			g_pImgExitA    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "nav_logout_act" ) );
			
			//���� �޴� ��ư
			g_pImgMnTop    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu01" ) );
			g_pImgMnMidpl  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu01_plus" ) );
			g_pImgMnMid    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu02" ) );
			g_pImgMnBot    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu03" ) );
			
			//2�� �þ�
			//PNG_COLOR_ALPHA or PNG_COLOR_NORMAL
			//���� �޴� ��ư PNG_COLOR_ALPHA
			g_pImgGm       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_gm" ) );
			g_pImgSc       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_sc" ) );
			g_pImgBs       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_bs" ) );
			g_pImgBf       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_bf" ) );
			g_pImgMw       = GrDev_LoadPngImage(PNG_COLOR_ALPHA ,  Get_ImgPath( szImg,  0, "menu_mw" ) );
			g_pImgGc       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_gc" ) );
			g_pImgNp       = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_np" ) );
			g_pImgCmm      = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_cmm" ) );
			g_pImgNotice   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_notice" ) );
			g_pImgFeeview  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "menu_feeview" ) );
			
			//�ο� �޴� ��ư
			g_pImgMw_Work   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_Work" ) );
			g_pImgMw_Receipt= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_Receipt" ) );
			g_pImgMw_Data   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_Data" ) );
			g_pImgMw_Snd    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_Snd" ) );
			g_pImgMw_Card   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_Card" ) );
			g_pImgMw_Print  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_Print" ) );
			g_pImgMw_Silsa   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_Silsa" ) );
			g_pImgMw_Report  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_Report" ) );

			//�ο� �ڷ���� ȭ�� �޴� ��ư
			g_pImgMw_DayDataRcv   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_DayDataRcv" ) );
			g_pImgMw_CmmDataRcv  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Mw_CmmDataRcv" ) );
			
			//��ħ �޴� ��ư
			g_pImgGm_Normal = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_Normal" ) );
			g_pImgGm_Nogm	= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_Nogm" ) );
			g_pImgGm_Absnc  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_Absnc" ) );
			g_pImgGm_Sel    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_Sel" ) );
			g_pImgGm_Go   	= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_Go" ) );
			g_pImgGm_Data  	= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_Data" ) );
			g_pImgGm_Sms  	= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_Sms" ) );
			g_pImgGm_Feeview= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_Feeview" ) );
			g_pImgGm_Regm= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_Regm" ) );
			
			// ��ħ �ڷ���� ȭ�� �޴� ��ư
			g_pImgGm_DataRcv= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_DataRcv" ) );
			g_pImgGm_DataSnd= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_DataSnd" ) );
			g_pImgGm_DataDel= GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gm_DataDel" ) );
			
			//�跮�ⱳü �޴� ��ư
			g_pImgGc_Old    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gc_Old" ) );
			g_pImgGc_Mw     = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gc_Mw" ) );
			g_pImgGc_Imp    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gc_Imp" ) );
			g_pImgGc_Sel    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gc_Sel" ) );
			g_pImgGc_Ret    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gc_Ret" ) );
			g_pImgGc_Data   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gc_Data" ) );
			g_pImgGc_Remark   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gc_Remark" ) );

			//�跮�ⱳü �ڷ���� ��ư
			g_pImgGc_BigDataRcv = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gc_BigDataRcv" ) );
			g_pImgGc_DataRcv    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Gc_DataRcv" ) );

			//���������� �޴� ��ư
			g_pImgBf_Solo    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bf_Solo" ) );
			g_pImgBf_Tgt     = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bf_Tgt" ) );
			g_pImgBf_Rfrm    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bf_Rfrm" ) );
			g_pImgBf_Data    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bf_Data" ) );
		
			//���������� �ڷ���� ��ư
			g_pImgBf_DataRcv    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bf_Rcv" ) );
			g_pImgBf_TgtDataRcv   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bf_TgtRcv" ) );
			g_pImgBf_DataSnd   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bf_DataSnd" ) );

			//�������� �޴� ��ư
			g_pImgSc_Data    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_Data" ) );
			g_pImgSc_First   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_First" ) );
			g_pImgSc_Go      = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_Go" ) );
			g_pImgSc_Jojung  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_Jojung" ) );
			g_pImgSc_Normal  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_Normal" ) );
			g_pImgSc_Ptrn    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_Ptrn" ) );
			g_pImgSc_Reserve = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_Reserve" ) );
			g_pImgSc_Result  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_Result" ) );
			g_pImgSc_Rfrm    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_Rfrm" ) );
			g_pImgSc_Sel     = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_Sel" ) );

			//�������� �ڷ���� ��ư
			g_pImgSc_DataRcv        = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_DataRcv" ) );
			g_pImgSc_DataSnd        = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_DataSnd" ) );
			g_pImgSc_DayDataRcv     = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_DayDataRcv" ) );
			g_pImgSc_JojungDataRcv  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_JojungDataRcv" ) );
			g_pImgSc_JojungDataSnd  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_JojungDataSnd" ) );
			g_pImgSc_SnnDataRcv     = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_SnnDataRcv" ) );
			g_pImgSc_SnnTotDataRcv  = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_SnnTotDataRcv" ) );
			g_pImgSc_ScgsDataRcv    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_ScgsDataRcv" ) );
			g_pImgSc_ScgsTotDataRcv = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Sc_ScgsTotDataRcv" ) );
			
			//Ư������ �޴� ��ư
			g_pImgBs_Normal    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bs_Normal" ) );
			g_pImgBs_Rfrm    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bs_Rfrm" ) );
			g_pImgBs_Data    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bs_Data" ) );
			g_pImgBs_TotDataRcv    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bs_TotDataRcv" ) );
			g_pImgBs_DayDataRcv    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bs_DayDataRcv" ) );
			g_pImgBs_DataSnd    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bs_DataSnd" ) );
			g_pImgBs_SafeDataRcv    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bs_SafeDataRcv" ) );
			g_pImgBs_First    = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Bs_First" ) );

			//��뷮 ������(��ħ)
			g_pImgAmount   = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "icon_amount" ) );
			
			//���� Reflesh
			g_pImgCm_Reflesh = GrDev_LoadPngImage(PNG_COLOR_NORMAL,  Get_ImgPath( szImg,  0, "Cm_Reflesh" ) );
			
			
		}
		
		//PROGRESS_Stop();
	}
	
	//--------------------------------------------------------------------------------------
	long g_Exit(void)
	{
		if(MessageBoxEx (CONFIRM_YESNO, "���α׷��� �����Ͻðڽ��ϱ�?") != MB_OK)
		{
			return 0;
		}
		
		//g_nWorkFlag = 698:�ο� ��������, ���̺� Ŭ����.
		if( g_nWorkFlag == 698 )
		{
			g_Sql_DirectExecute("DELETE FROM C6101_WORK_REPORT");
			g_DirFS_Clear(PHOTO_WORK, "*");
		}
		
		//Ǫ�� �α׾ƿ� ����.
		g_SetPushLogout();
		
		g_Db_Backup();
		
		//����̹���
		EvtExit();
		g_ImgFree();
		VM_AmEnd();
		return 1;
	}
	
	//--------------------------------------------------------------------------------------
	void g_ImgFree(void)
	{
		if( g_nTimerID != 0 )
			Timer_Kill(g_nTimerID);
		
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
			FREE(g_pImgMainExit);
			FREE(g_pImgLogo);
			
			FREE(g_pImgMainTtl);
			//FREE(g_pImgSubTtl);
			FREE(g_pImgPopTtlL);
			
			FREE(g_pImgGm);
			FREE(g_pImgSc);
			FREE(g_pImgBs);
			FREE(g_pImgCmm);
			
			FREE(g_pImgMnTop);
			FREE(g_pImgMnMid);
			FREE(g_pImgMnMidpl);
			FREE(g_pImgMnBot);
			
			FREE(g_pImgChkI);
			FREE(g_pImgRadioI);
			
			FREE(g_pImgChkA);
			FREE(g_pImgRadioA);
		}
		else
		{
			//2�� ���� �̹���
			FREE(g_pImgMainBg);
			FREE(g_pImgMainExit);
			FREE(g_pImgLogo);
			FREE(g_pImgMainTtl_GM);
			FREE(g_pImgMainTtl);
			FREE(g_pImgBlankTtl);
			FREE(g_pImgSubTtl);
			FREE(g_pImgSubTtlPrev);
			FREE(g_pImgSubTtlClose);
			FREE(g_pImgPopTtlL);
			FREE(g_pImgPopTtlPrev);
			FREE(g_pImgHomeI);
			FREE(g_pImgKeybrdI);
			FREE(g_pImgScreenI);
			FREE(g_pImgCmmnwrkI);
			FREE(g_pImgExitI);
			FREE(g_pImgHomeA);
			FREE(g_pImgKeybrdA);
			FREE(g_pImgScreenA);
			FREE(g_pImgCmmnwrkA);
			FREE(g_pImgExitA);
			FREE(g_pImgGm);
			FREE(g_pImgSc);
			FREE(g_pImgBs);
			FREE(g_pImgBf);
			FREE(g_pImgMw);
			FREE(g_pImgGc);
			FREE(g_pImgNp);
			FREE(g_pImgCmm);
			FREE(g_pImgNotice);
			FREE(g_pImgFeeview);
			FREE(g_pImgMnTop);
			FREE(g_pImgMnMid);
			FREE(g_pImgMnMidpl);
			FREE(g_pImgMnBot);
			FREE(g_pImgGmBtn);
			FREE(g_pImgNoGmBtn);
			FREE(g_pImgAbsncBtn);
			FREE(g_pImgGmSlctBtn);
			FREE(g_pImgGmgoBtn);
			FREE(g_pImgGmDataBtn);
			FREE(g_pImgScBtn);
			FREE(g_pImgPtrnBtn);
			FREE(g_pImgRsrvBtn);
			FREE(g_pImgScDataBtn);
			FREE(g_pImgFrstScBtn);
			FREE(g_pImgRsltBtn);
			FREE(g_pImgRfrmBtn);
			FREE(g_pImgScgoBtn);
			FREE(g_pImgJojungBtn);
			FREE(g_pImgScSlctBtn);
			FREE(g_pImgChkI);
			FREE(g_pImgRadioI);
			FREE(g_pImgChkA);
			FREE(g_pImgRadioA);
			FREE(g_pImgGm_Normal);
			FREE(g_pImgGm_Nogm);
			FREE(g_pImgGm_Absnc);
			FREE(g_pImgGm_Sel);
			FREE(g_pImgGm_Go);
			FREE(g_pImgGm_Data);
			FREE(g_pImgGm_Sms);
			FREE(g_pImgGm_Feeview);
			FREE(g_pImgGm_Regm);
			FREE(g_pImgGm_DataRcv);
			FREE(g_pImgGm_DataSnd);
			FREE(g_pImgGm_DataDel);
			FREE(g_pImgSc_Data);
			FREE(g_pImgSc_First);
			FREE(g_pImgSc_Go);
			FREE(g_pImgSc_Jojung);
			FREE(g_pImgSc_Normal);
			FREE(g_pImgSc_Ptrn);
			FREE(g_pImgSc_Reserve);
			FREE(g_pImgSc_Result);
			FREE(g_pImgSc_Rfrm);
			FREE(g_pImgSc_Sel);
			FREE(g_pImgSc_DataRcv);
			FREE(g_pImgSc_DataSnd);
			FREE(g_pImgSc_DayDataRcv);
			FREE(g_pImgSc_JojungDataRcv);
			FREE(g_pImgSc_JojungDataSnd);
			FREE(g_pImgSc_SnnDataRcv);
			FREE(g_pImgSc_SnnTotDataRcv);
			FREE(g_pImgBs_Normal);
			FREE(g_pImgBs_Rfrm);
			FREE(g_pImgBs_Data);
			FREE(g_pImgBs_TotDataRcv);
			FREE(g_pImgBs_DayDataRcv);
			FREE(g_pImgBs_DataSnd);
			FREE(g_pImgBs_SafeDataRcv);
			FREE(g_pImgBf_Tgt);
			FREE(g_pImgBf_Solo);
			FREE(g_pImgBf_Rfrm);
			FREE(g_pImgBf_Data);
			FREE(g_pImgBf_DataSnd);
			FREE(g_pImgBf_DataRcv);
			FREE(g_pImgBf_TgtDataRcv);
			FREE(g_pImgMw_Work);
			FREE(g_pImgMw_Receipt);
			FREE(g_pImgMw_Data);
			FREE(g_pImgMw_Snd);
			FREE(g_pImgMw_Card);
			FREE(g_pImgMw_Print);
			FREE(g_pImgMw_DayDataRcv);
			FREE(g_pImgMw_Silsa);
			FREE(g_pImgMw_Report);
			FREE(g_pImgMw_CmmDataRcv);
			FREE(g_pImgGc_Old);
			FREE(g_pImgGc_Mw);
			FREE(g_pImgGc_Remark);
			FREE(g_pImgGc_Imp);
			FREE(g_pImgGc_Sel);
			FREE(g_pImgGc_Ret);
			FREE(g_pImgGc_Data);
			FREE(g_pImgGc_BigDataRcv);
			FREE(g_pImgGc_DataRcv);
			FREE(g_pImgNp_Auction);
			FREE(g_pImgNp_Clear);
			FREE(g_pImgNp_Data);
			FREE(g_pImgNp_Normal);
			FREE(g_pImgNp_Part);
			FREE(g_pImgNp_Receipt);
			FREE(g_pImgNp_Stop);
			FREE(g_pImgChkOff);
			FREE(g_pImgChkOn);
			FREE(g_pImgCash);
			FREE(g_pImgCashDark);
			FREE(g_pImgAmount);
			FREE(g_pImgLoad1);
			FREE(g_pImgBs_First);
			FREE(g_pImgSc_ScgsDataRcv);
			FREE(g_pImgSc_ScgsTotDataRcv);
			FREE(g_pImgCm_Reflesh);
		}
	}
	
	//--------------------------------------------------------------------------------------
	void g_ImgNameChg	(void)
	{
		long nRet = 0;
		char szTmp[256];
		char szCopy[256];
		char szImg[256];
		char szpath[256];
		char szbuf[256];
		
		Mem_Set( (byte*)szImg, 0x00, sizeof(szImg) );
		Mem_Set( (byte*)szpath, 0x00, sizeof(szpath) );
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		
		//theDevInfo.m_nType = FAMILY_SMALL;
		
		PRINT("g_ImgNameChg:: theDevInfo.m_nType = %d", theDevInfo.m_nType,0,0);
		PRINT("g_ImgNameChg:: FAMILY_PDA = %d", FAMILY_PDA,0,0);
		PRINT("g_ImgNameChg:: FAMILY_SMART = %d", FAMILY_SMART,0,0);
		PRINT("g_ImgNameChg:: FAMILY_SMALL = %d", FAMILY_SMALL,0,0);
		PRINT("g_ImgNameChg:: FAMILY_MIDDLE = %d", FAMILY_MIDDLE,0,0);

		PRINT("g_ImgNameChg:: FAMILY_LARGE = %d", FAMILY_LARGE,0,0);	
		
		if( FFS_Exist( "img/FHD/img+FHD+Gc_Remark.pngi" ) )
		{
			FFS_Rename( "img/FHD/img+FHD+Gc_Remark.pngi",  Get_ImgPath( szImg,  0, "Gc_Remark" ));
		}
		if( FFS_Exist( "img/FHD/img+FHD+Gc_Data.pngi" ) )
		{
			FFS_Rename( "img/FHD/img+FHD+Gc_Data.pngi",  Get_ImgPath( szImg,  0, "Gc_Data" ));
		}

		if( FFS_Exist( "img/FHD/img+FHD+Gc_Imp.pngi" ) )
		{
			FFS_Rename( "img/FHD/img+FHD+Gc_Imp.pngi",  Get_ImgPath( szImg,  0, "Gc_Imp" ));
		}

		if( FFS_Exist( "img/FHD/img+FHD+Gc_Mw.pngi" ) )
		{
			FFS_Rename( "img/FHD/img+FHD+Gc_Mw.pngi",  Get_ImgPath( szImg,  0, "Gc_Mw" ));
		}

		if( FFS_Exist( "img/FHD/img+FHD+Gc_Old.pngi" ) )
		{
			FFS_Rename( "img/FHD/img+FHD+Gc_Old.pngi",  Get_ImgPath( szImg,  0, "Gc_Old" ));
		}

		if( FFS_Exist( "img/FHD/img+FHD+Gc_Ret.pngi" ) )
		{
			FFS_Rename( "img/FHD/img+FHD+Gc_Ret.pngi",  Get_ImgPath( szImg,  0, "Gc_Ret" ));
		}

		if( FFS_Exist( "img/FHD/img+FHD+Gc_Sel.pngi" ) )
		{
			FFS_Rename( "img/FHD/img+FHD+Gc_Sel.pngi",  Get_ImgPath( szImg,  0, "Gc_Sel" ));
		}
		


		
		if( theDevInfo.m_nType == FAMILY_PDA || theDevInfo.m_nType == FAMILY_SMART )
		{
			if( FFS_Exist("SCGGAS/menu_gm_.png") )
			{
				SPRINT (szpath, "img/menu_gm_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_gm_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/menu_sc_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_sc_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/menu_bs_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_bs_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/menu_bf_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_bf_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/menu_cmm_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_cmm_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/menu_cmm_1.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_cmm_1.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/menu01.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu01.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
			}
		
			if( FFS_Exist( "img/main_bg.png" ) )
			{
				FFS_Rename( "img/main_bg.png", Get_ImgPath( szImg,  0, "main_bg" ) );
				FFS_Rename( "img/main_btn_out.png", Get_ImgPath( szImg,  0, "main_btn_out" ) );
				FFS_Rename( "img/main_logo.png", Get_ImgPath( szImg,  0, "main_logo" ) );
				
				FFS_Rename( "img/title_bg_main_all_GM.png", Get_ImgPath( szImg,  0, "title_bg_main_all_GM" ) );
				FFS_Rename( "img/title_bg_main_all.png", Get_ImgPath( szImg,  0, "title_bg_main_all" ) );
				FFS_Rename( "img/title_bg_sub_all.png", Get_ImgPath( szImg,  0, "title_bg_sub_all" ) );
				FFS_Rename( "img/title_bg_sub_back.png", Get_ImgPath( szImg,  0, "title_bg_sub_back" ) );
				FFS_Rename( "img/title_bg_pop_samll.png", Get_ImgPath( szImg,  0, "title_bg_pop_samll" ) );
				FFS_Rename( "img/title_bg_pop_large.png", Get_ImgPath( szImg,  0, "title_bg_pop_large" ) );
				FFS_Rename( "img/title_bg_pop_prev.png", Get_ImgPath( szImg,  0, "title_bg_pop_prev" ) );
				
				FFS_Rename( "img/menu_gm_.png", Get_ImgPath( szImg,  0, "menu_gm" ) );
				FFS_Rename( "img/menu_sc_.png", Get_ImgPath( szImg,  0, "menu_sc" ) );
				FFS_Rename( "img/menu_bs_.png", Get_ImgPath( szImg,  0, "menu_bs" ) );
				FFS_Rename( "img/menu_bf_.png", Get_ImgPath( szImg,  0, "menu_bf" ) );
				FFS_Rename( "img/menu_cmm_.png", Get_ImgPath( szImg,  0, "menu_cmm" ) );
				FFS_Rename( "img/menu_cmm_1.png", Get_ImgPath( szImg,  0, "menu_notice" ) );
				FFS_Rename( "img/menu01.png", Get_ImgPath( szImg,  0, "menu01" ) );
				FFS_Rename( "img/menu01_plus.png", Get_ImgPath( szImg,  0, "menu01_plus" ) );
				FFS_Rename( "img/menu02.png", Get_ImgPath( szImg,  0, "menu02" ) );
				FFS_Rename( "img/menu03.png", Get_ImgPath( szImg,  0, "menu03" ) );
				
				FFS_Rename( "img/GmBtn.png", Get_ImgPath( szImg,  0, "Gm_Btn" ) );
				FFS_Rename( "img/NoGmBtn.png", Get_ImgPath( szImg,  0, "Gm_nogmBtn" ) );
				FFS_Rename( "img/AbsncBtn.png", Get_ImgPath( szImg,  0, "Gm_absncBtn" ) );
				FFS_Rename( "img/GmSlctBtn.png", Get_ImgPath( szImg,  0, "Gm_slctBtn" ) );
				FFS_Rename( "img/GmgoBtn.png", Get_ImgPath( szImg,  0, "Gm_goBtn" ) );
				FFS_Rename( "img/GmDataBtn.png", Get_ImgPath( szImg,  0, "Gm_dataBtn" ) );
				
				FFS_Rename( "img/ScBtn.png", Get_ImgPath( szImg,  0, "Sc_Btn" ) );
				FFS_Rename( "img/PtrnBtn.png", Get_ImgPath( szImg,  0, "Sc_ptrnBtn" ) );
				FFS_Rename( "img/RsrvBtn.png", Get_ImgPath( szImg,  0, "Sc_rsrvBtn" ) );
				FFS_Rename( "img/ScDataBtn.png", Get_ImgPath( szImg,  0, "Sc_dataBtn" ) );
				FFS_Rename( "img/FrstScBtn.png", Get_ImgPath( szImg,  0, "Sc_frstBtn" ) );
				FFS_Rename( "img/RsltBtn.png", Get_ImgPath( szImg,  0, "Sc_rsltBtn" ) );
				FFS_Rename( "img/RfrmBtn.png", Get_ImgPath( szImg,  0, "Sc_rfrmBtn" ) );
				FFS_Rename( "img/ScgoBtn.png", Get_ImgPath( szImg,  0, "Sc_goBtn" ) );
				FFS_Rename( "img/JojungBtn.png", Get_ImgPath( szImg,  0, "Sc_jojungBtn" ) );
				FFS_Rename( "img/ScSlctBtn.png", Get_ImgPath( szImg,  0, "Sc_slctBtn" ) );
				
				FFS_Rename( "img/input_check.png", Get_ImgPath( szImg,  0, "input_check" ) );
				FFS_Rename( "img/input_check_off.png", Get_ImgPath( szImg,  0, "input_check_off" ) );
				FFS_Rename( "img/input_check_on.png", Get_ImgPath( szImg,  0, "input_check_on" ) );
				FFS_Rename( "img/input_radio.png", Get_ImgPath( szImg,  0, "input_radio" ) );
				FFS_Rename( "img/input_radio_off.png", Get_ImgPath( szImg,  0, "input_radio_off" ) );
				FFS_Rename( "img/input_radio_on.png", Get_ImgPath( szImg,  0, "input_radio_on" ) );
				FFS_Rename( "img/menu_bs.png", Get_ImgPath( szImg,  0, "menu_bs_" ) );
				FFS_Rename( "img/menu_ccm.png", Get_ImgPath( szImg,  0, "menu_ccm_" ) );
				FFS_Rename( "img/menu_cmm.png", Get_ImgPath( szImg,  0, "menu_cmm_" ) );
				FFS_Rename( "img/menu_gm.png", Get_ImgPath( szImg,  0, "menu_gm_" ) );
				FFS_Rename( "img/menu_sc.png", Get_ImgPath( szImg,  0, "menu_sc_" ) );
				FFS_Rename( "img/select_arrow.png", Get_ImgPath( szImg,  0, "select_arrow" ) );
				FFS_Rename( "img/title_bg_main.png", Get_ImgPath( szImg,  0, "title_bg_main" ) );
				FFS_Rename( "img/title_bg_main_back.png", Get_ImgPath( szImg,  0, "title_bg_main_back" ) );
				FFS_Rename( "img/title_bg_main_menu.png", Get_ImgPath( szImg,  0, "title_bg_main_menu" ) );
				FFS_Rename( "img/title_bg_pop.png", Get_ImgPath( szImg,  0, "title_bg_pop" ) );
				FFS_Rename( "img/title_bg_pop_.png", Get_ImgPath( szImg,  0, "title_bg_pop_" ) );
				FFS_Rename( "img/title_bg_pop_close.png", Get_ImgPath( szImg,  0, "title_bg_pop_close" ) );
				FFS_Rename( "img/title_bg_sub.png", Get_ImgPath( szImg,  0, "title_bg_sub" ) );
				FFS_Rename( "img/title_bg_sub_menu.png", Get_ImgPath( szImg,  0, "title_bg_sub_menu" ) );
				FFS_Rename( "img/title_dot.png", Get_ImgPath( szImg,  0, "title_dot" ) );
				FFS_Rename( "img/menu02_plus.png", Get_ImgPath( szImg,  0, "menu02_plus" ) );
			}
		}
		else if( theDevInfo.m_nType == FAMILY_SMALL )
		{	
			//2018-01-05 Sanghyun Lee
			//Ŭ���̾�Ʈ ���׷��̵� �� �̹��� �̵� ����
			//szbuf		: POP ���׷��̵� �� �߰��� ���� ���� ���
			//szpath	: POP ���׷��̵� �� �߰��� ���� ���� ��� + �̹�����
			//szCopy	: �̹�����
			//szImg		: �̹��� ���� ���� ���+�̹�����
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			Str_Cpy(szbuf, "SCGGAS" );
			while( 1 )
			{
				Mem_Set( (byte*)szpath, 0x00, sizeof(szpath) );
				Mem_Set( (byte*)szImg, 0x00, sizeof(szImg) );
				Mem_Set( (byte*)szCopy, 0x00, sizeof(szCopy) );

				nRet = g_FindFiles( szbuf, "*.pngi" , szpath);
				if( nRet > 0 )
				{
					//�̹�����
					Mem_Cpy((byte*)szCopy, (byte*)szpath+7, Str_Len(szpath)-7);
					//�̹��� ���� ���� ���+�̹�����
					SPRINT(szImg, "img/HD720/%s",szCopy,0,0);
					//���� �̹��� ��ο� �ش� ������ �ִ��� Ȯ��
					if( FFS_Exist(szImg) > 0 )
					{
						//�ִ� ������ SCGGAS�������� ����
						FFS_Delete(szpath);
					}
					else
					{
						//���� �̹����� ���� �̹��� ��ο� �̵�
						FFS_Rename( szpath, szImg );
					}
				}
				else
				{
					break;
				}
			}
		}
		else if( theDevInfo.m_nType == FAMILY_MIDDLE )
		{
			Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
			Str_Cpy(szbuf, "SCGGAS" );
			
			while( 1 )
			{
				Mem_Set( (byte*)szpath, 0x00, sizeof(szpath) );
				Mem_Set( (byte*)szImg, 0x00, sizeof(szImg) );
				Mem_Set( (byte*)szCopy, 0x00, sizeof(szCopy) );

				nRet = g_FindFiles( szbuf, "*.pngi" , szpath);
				
				if( nRet > 0 )
				{
					//�̹�����
					Mem_Cpy((byte*)szCopy, (byte*)szpath+7, Str_Len(szpath)-7);
					
					//�̹��� ���� ���� ���+�̹�����
					SPRINT(szImg, "img/FHD/%s",szCopy,0,0);
					
					//���� �̹��� ��ο� �ش� ������ �ִ��� Ȯ��
					if( FFS_Exist(szImg) > 0 )
					{
						//�ִ� ������ SCGGAS�������� ����
						FFS_Delete(szpath);
					}
					else
					{
						//���� �̹����� ���� �̹��� ��ο� �̵�
						FFS_Rename( szpath, szImg );
					}
				}
				else
				{
					break;
				}
			}
		}
		else if( theDevInfo.m_nType == FAMILY_LARGE )
		{
			if( FFS_Exist("SCGGAS/menu_gm_.png") )
			{
				SPRINT (szpath, "img/WQHD/menu_gm_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_gm_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_sc_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_sc_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_bs_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_bs_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_bf_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_bf_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_cmm_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_cmm_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_cmm_1.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_cmm_1.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu01.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu01.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
			}
			
			if( FFS_Exist( "img/WQHD/main_bg.png" ) )
			{
				FFS_Rename( "img/WQHD/main_bg.png", Get_ImgPath( szImg,  0, "main_bg" ) );
				FFS_Rename( "img/WQHD/main_btn_out.png", Get_ImgPath( szImg,  0, "main_btn_out" ) );
				FFS_Rename( "img/WQHD/main_logo.png", Get_ImgPath( szImg,  0, "main_logo" ) );
				
				FFS_Rename( "img/WQHD/title_bg_main_all_GM.png", Get_ImgPath( szImg,  0, "title_bg_main_all_GM" ) );
				FFS_Rename( "img/WQHD/title_bg_main_all.png", Get_ImgPath( szImg,  0, "title_bg_main_all" ) );
				FFS_Rename( "img/WQHD/title_bg_sub_all.png", Get_ImgPath( szImg,  0, "title_bg_sub_all" ) );
				FFS_Rename( "img/WQHD/title_bg_sub_back.png", Get_ImgPath( szImg,  0, "title_bg_sub_back" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_samll.png", Get_ImgPath( szImg,  0, "title_bg_pop_samll" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_large.png", Get_ImgPath( szImg,  0, "title_bg_pop_large" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_prev.png", Get_ImgPath( szImg,  0, "title_bg_pop_prev" ) );
				
				FFS_Rename( "img/WQHD/nav01_home_on.png", Get_ImgPath( szImg,  0, "nav_home_on" ) );
				FFS_Rename( "img/WQHD/nav02_keypad_on.png", Get_ImgPath( szImg,  0, "nav_keypad_on" ) );
				FFS_Rename( "img/WQHD/nav03_updown_on.png", Get_ImgPath( szImg,  0, "nav_updown_on" ) );
				FFS_Rename( "img/WQHD/nav04_setting_on.png", Get_ImgPath( szImg,  0, "nav_setting_on" ) );
				FFS_Rename( "img/WQHD/nav05_logout_on.png", Get_ImgPath( szImg,  0, "nav_logout_on" ) );
				FFS_Rename( "img/WQHD/nav01_home_act.png", Get_ImgPath( szImg,  0, "nav_home_act" ) );
				FFS_Rename( "img/WQHD/nav02_keypad_act.png", Get_ImgPath( szImg,  0, "nav_keypad_act" ) );
				FFS_Rename( "img/WQHD/nav03_updown_act.png", Get_ImgPath( szImg,  0, "nav_updown_act" ) );
				FFS_Rename( "img/WQHD/nav04_setting_act.png", Get_ImgPath( szImg,  0, "nav_setting_act" ) );
				FFS_Rename( "img/WQHD/nav05_logout_act.png", Get_ImgPath( szImg,  0, "nav_logout_act" ) );
				
				FFS_Rename( "img/WQHD/menu_gm_.png", Get_ImgPath( szImg,  0, "menu_gm" ) );
				FFS_Rename( "img/WQHD/menu_sc_.png", Get_ImgPath( szImg,  0, "menu_sc" ) );
				FFS_Rename( "img/WQHD/menu_bs_.png", Get_ImgPath( szImg,  0, "menu_bs" ) );
				FFS_Rename( "img/WQHD/menu_bf_.png", Get_ImgPath( szImg,  0, "menu_bf" ) );
				FFS_Rename( "img/WQHD/menu_cmm_.png", Get_ImgPath( szImg,  0, "menu_cmm" ) );
				FFS_Rename( "img/WQHD/menu_cmm_1.png", Get_ImgPath( szImg,  0, "menu_notice" ) );
				FFS_Rename( "img/WQHD/menu01.png", Get_ImgPath( szImg,  0, "menu01" ) );
				FFS_Rename( "img/WQHD/menu01_plus.png", Get_ImgPath( szImg,  0, "menu01_plus" ) );
				FFS_Rename( "img/WQHD/menu02.png", Get_ImgPath( szImg,  0, "menu02" ) );
				FFS_Rename( "img/WQHD/menu03.png", Get_ImgPath( szImg,  0, "menu03" ) );
				
				FFS_Rename( "img/WQHD/GmBtn.png", Get_ImgPath( szImg,  0, "Gm_Btn" ) );
				FFS_Rename( "img/WQHD/NoGmBtn.png", Get_ImgPath( szImg,  0, "Gm_nogmBtn" ) );
				FFS_Rename( "img/WQHD/AbsncBtn.png", Get_ImgPath( szImg,  0, "Gm_absncBtn" ) );
				FFS_Rename( "img/WQHD/GmSlctBtn.png", Get_ImgPath( szImg,  0, "Gm_slctBtn" ) );
				FFS_Rename( "img/WQHD/GmgoBtn.png", Get_ImgPath( szImg,  0, "Gm_goBtn" ) );
				FFS_Rename( "img/WQHD/GmDataBtn.png", Get_ImgPath( szImg,  0, "Gm_dataBtn" ) );
				
				FFS_Rename( "img/WQHD/ScBtn.png", Get_ImgPath( szImg,  0, "Sc_Btn" ) );
				FFS_Rename( "img/WQHD/PtrnBtn.png", Get_ImgPath( szImg,  0, "Sc_ptrnBtn" ) );
				FFS_Rename( "img/WQHD/RsrvBtn.png", Get_ImgPath( szImg,  0, "Sc_rsrvBtn" ) );
				FFS_Rename( "img/WQHD/ScDataBtn.png", Get_ImgPath( szImg,  0, "Sc_dataBtn" ) );
				FFS_Rename( "img/WQHD/FrstScBtn.png", Get_ImgPath( szImg,  0, "Sc_frstBtn" ) );
				FFS_Rename( "img/WQHD/RsltBtn.png", Get_ImgPath( szImg,  0, "Sc_rsltBtn" ) );
				FFS_Rename( "img/WQHD/RfrmBtn.png", Get_ImgPath( szImg,  0, "Sc_rfrmBtn" ) );
				FFS_Rename( "img/WQHD/ScgoBtn.png", Get_ImgPath( szImg,  0, "Sc_goBtn" ) );
				FFS_Rename( "img/WQHD/JojungBtn.png", Get_ImgPath( szImg,  0, "Sc_jojungBtn" ) );
				FFS_Rename( "img/WQHD/ScSlctBtn.png", Get_ImgPath( szImg,  0, "Sc_slctBtn" ) );
				
				FFS_Rename( "img/WQHD/input_check.png", Get_ImgPath( szImg,  0, "input_check" ) );
				FFS_Rename( "img/WQHD/input_check_off.png", Get_ImgPath( szImg,  0, "input_check_off" ) );
				FFS_Rename( "img/WQHD/input_check_on.png", Get_ImgPath( szImg,  0, "input_check_on" ) );
				FFS_Rename( "img/WQHD/input_radio.png", Get_ImgPath( szImg,  0, "input_radio" ) );
				FFS_Rename( "img/WQHD/input_radio_off.png", Get_ImgPath( szImg,  0, "input_radio_off" ) );
				FFS_Rename( "img/WQHD/input_radio_on.png", Get_ImgPath( szImg,  0, "input_radio_on" ) );
				FFS_Rename( "img/WQHD/menu_bs.png", Get_ImgPath( szImg,  0, "menu_bs_" ) );
				FFS_Rename( "img/WQHD/menu_ccm.png", Get_ImgPath( szImg,  0, "menu_ccm_" ) );
				FFS_Rename( "img/WQHD/menu_cmm.png", Get_ImgPath( szImg,  0, "menu_cmm_" ) );
				FFS_Rename( "img/WQHD/menu_gm.png", Get_ImgPath( szImg,  0, "menu_gm_" ) );
				FFS_Rename( "img/WQHD/menu_sc.png", Get_ImgPath( szImg,  0, "menu_sc_" ) );
				FFS_Rename( "img/WQHD/nav01_home.png", Get_ImgPath( szImg,  0, "nav01_home" ) );
				FFS_Rename( "img/WQHD/nav02_keypad", Get_ImgPath( szImg,  0, "nav02_keypad" ) );
				FFS_Rename( "img/WQHD/nav03_updown.png", Get_ImgPath( szImg,  0, "nav03_updown" ) );
				FFS_Rename( "img/WQHD/nav04_setting.png", Get_ImgPath( szImg,  0, "nav04_setting" ) );
				FFS_Rename( "img/WQHD/nav05_logout.png", Get_ImgPath( szImg,  0, "nav05_logout" ) );
				FFS_Rename( "img/WQHD/select_arrow.png", Get_ImgPath( szImg,  0, "select_arrow" ) );
				FFS_Rename( "img/WQHD/title_bg_main.png", Get_ImgPath( szImg,  0, "title_bg_main" ) );
				FFS_Rename( "img/WQHD/title_bg_main_back.png", Get_ImgPath( szImg,  0, "title_bg_main_back" ) );
				FFS_Rename( "img/WQHD/title_bg_main_menu.png", Get_ImgPath( szImg,  0, "title_bg_main_menu" ) );
				FFS_Rename( "img/WQHD/title_bg_pop.png", Get_ImgPath( szImg,  0, "title_bg_pop" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_.png", Get_ImgPath( szImg,  0, "title_bg_pop_" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_close.png", Get_ImgPath( szImg,  0, "title_bg_pop_close" ) );
				FFS_Rename( "img/WQHD/title_bg_sub.png", Get_ImgPath( szImg,  0, "title_bg_sub" ) );
				FFS_Rename( "img/WQHD/title_bg_sub_menu.png", Get_ImgPath( szImg,  0, "title_bg_sub_menu" ) );
				FFS_Rename( "img/WQHD/title_dot.png", Get_ImgPath( szImg,  0, "title_dot" ) );
				FFS_Rename( "img/WQHD/menu02_plus.png", Get_ImgPath( szImg,  0, "menu02_plus" ) );
			}

		}
		else if( theDevInfo.m_nType == FAMILY_SUPER )
		{
			if( FFS_Exist("SCGGAS/menu_gm_.png") )
			{
				SPRINT (szpath, "img/WQHD/menu_gm_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_gm_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_sc_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_sc_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_bs_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_bs_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_bf_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_bf_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_cmm_.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_cmm_.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu_cmm_1.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu_cmm_1.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
				
				SPRINT (szpath, "img/WQHD/menu01.png",  0, 0, 0);
				SPRINT (szbuf, "SCGGAS/menu01.png",  0, 0, 0);
				FFS_Copy(szbuf, szpath);
				FFS_Delete(szbuf);
			}
		
			if( FFS_Exist( "img/WQHD/main_bg.png" ) )
			{
				FFS_Rename( "img/WQHD/main_bg.png", Get_ImgPath( szImg,  0, "main_bg" ) );
				FFS_Rename( "img/WQHD/main_btn_out.png", Get_ImgPath( szImg,  0, "main_btn_out" ) );
				FFS_Rename( "img/WQHD/main_logo.png", Get_ImgPath( szImg,  0, "main_logo" ) );
				
				FFS_Rename( "img/WQHD/title_bg_main_all_GM.png", Get_ImgPath( szImg,  0, "title_bg_main_all_GM" ) );
				FFS_Rename( "img/WQHD/title_bg_main_all.png", Get_ImgPath( szImg,  0, "title_bg_main_all" ) );
				FFS_Rename( "img/WQHD/title_bg_sub_all.png", Get_ImgPath( szImg,  0, "title_bg_sub_all" ) );
				FFS_Rename( "img/WQHD/title_bg_sub_back.png", Get_ImgPath( szImg,  0, "title_bg_sub_back" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_samll.png", Get_ImgPath( szImg,  0, "title_bg_pop_samll" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_large.png", Get_ImgPath( szImg,  0, "title_bg_pop_large" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_prev.png", Get_ImgPath( szImg,  0, "title_bg_pop_prev" ) );
				
				FFS_Rename( "img/WQHD/nav01_home_on.png", Get_ImgPath( szImg,  0, "nav_home_on" ) );
				FFS_Rename( "img/WQHD/nav02_keypad_on.png", Get_ImgPath( szImg,  0, "nav_keypad_on" ) );
				FFS_Rename( "img/WQHD/nav03_updown_on.png", Get_ImgPath( szImg,  0, "nav_updown_on" ) );
				FFS_Rename( "img/WQHD/nav04_setting_on.png", Get_ImgPath( szImg,  0, "nav_setting_on" ) );
				FFS_Rename( "img/WQHD/nav05_logout_on.png", Get_ImgPath( szImg,  0, "nav_logout_on" ) );
				FFS_Rename( "img/WQHD/nav01_home_act.png", Get_ImgPath( szImg,  0, "nav_home_act" ) );
				FFS_Rename( "img/WQHD/nav02_keypad_act.png", Get_ImgPath( szImg,  0, "nav_keypad_act" ) );
				FFS_Rename( "img/WQHD/nav03_updown_act.png", Get_ImgPath( szImg,  0, "nav_updown_act" ) );
				FFS_Rename( "img/WQHD/nav04_setting_act.png", Get_ImgPath( szImg,  0, "nav_setting_act" ) );
				FFS_Rename( "img/WQHD/nav05_logout_act.png", Get_ImgPath( szImg,  0, "nav_logout_act" ) );
				
				FFS_Rename( "img/WQHD/menu_gm_.png", Get_ImgPath( szImg,  0, "menu_gm" ) );
				FFS_Rename( "img/WQHD/menu_sc_.png", Get_ImgPath( szImg,  0, "menu_sc" ) );
				FFS_Rename( "img/WQHD/menu_bs_.png", Get_ImgPath( szImg,  0, "menu_bs" ) );
				FFS_Rename( "img/WQHD/menu_bf_.png", Get_ImgPath( szImg,  0, "menu_bf" ) );
				FFS_Rename( "img/WQHD/menu_cmm_.png", Get_ImgPath( szImg,  0, "menu_cmm" ) );
				FFS_Rename( "img/WQHD/menu_cmm_1.png", Get_ImgPath( szImg,  0, "menu_notice" ) );
				FFS_Rename( "img/WQHD/menu01.png", Get_ImgPath( szImg,  0, "menu01" ) );
				FFS_Rename( "img/WQHD/menu01_plus.png", Get_ImgPath( szImg,  0, "menu01_plus" ) );
				FFS_Rename( "img/WQHD/menu02.png", Get_ImgPath( szImg,  0, "menu02" ) );
				FFS_Rename( "img/WQHD/menu03.png", Get_ImgPath( szImg,  0, "menu03" ) );
				
				FFS_Rename( "img/WQHD/GmBtn.png", Get_ImgPath( szImg,  0, "Gm_Btn" ) );
				FFS_Rename( "img/WQHD/NoGmBtn.png", Get_ImgPath( szImg,  0, "Gm_nogmBtn" ) );
				FFS_Rename( "img/WQHD/AbsncBtn.png", Get_ImgPath( szImg,  0, "Gm_absncBtn" ) );
				FFS_Rename( "img/WQHD/GmSlctBtn.png", Get_ImgPath( szImg,  0, "Gm_slctBtn" ) );
				FFS_Rename( "img/WQHD/GmgoBtn.png", Get_ImgPath( szImg,  0, "Gm_goBtn" ) );
				FFS_Rename( "img/WQHD/GmDataBtn.png", Get_ImgPath( szImg,  0, "Gm_dataBtn" ) );
				
				FFS_Rename( "img/WQHD/ScBtn.png", Get_ImgPath( szImg,  0, "Sc_Btn" ) );
				FFS_Rename( "img/WQHD/PtrnBtn.png", Get_ImgPath( szImg,  0, "Sc_ptrnBtn" ) );
				FFS_Rename( "img/WQHD/RsrvBtn.png", Get_ImgPath( szImg,  0, "Sc_rsrvBtn" ) );
				FFS_Rename( "img/WQHD/ScDataBtn.png", Get_ImgPath( szImg,  0, "Sc_dataBtn" ) );
				FFS_Rename( "img/WQHD/FrstScBtn.png", Get_ImgPath( szImg,  0, "Sc_frstBtn" ) );
				FFS_Rename( "img/WQHD/RsltBtn.png", Get_ImgPath( szImg,  0, "Sc_rsltBtn" ) );
				FFS_Rename( "img/WQHD/RfrmBtn.png", Get_ImgPath( szImg,  0, "Sc_rfrmBtn" ) );
				FFS_Rename( "img/WQHD/ScgoBtn.png", Get_ImgPath( szImg,  0, "Sc_goBtn" ) );
				FFS_Rename( "img/WQHD/JojungBtn.png", Get_ImgPath( szImg,  0, "Sc_jojungBtn" ) );
				FFS_Rename( "img/WQHD/ScSlctBtn.png", Get_ImgPath( szImg,  0, "Sc_slctBtn" ) );
				
				FFS_Rename( "img/WQHD/input_check.png", Get_ImgPath( szImg,  0, "input_check" ) );
				FFS_Rename( "img/WQHD/input_check_off.png", Get_ImgPath( szImg,  0, "input_check_off" ) );
				FFS_Rename( "img/WQHD/input_check_on.png", Get_ImgPath( szImg,  0, "input_check_on" ) );
				FFS_Rename( "img/WQHD/input_radio.png", Get_ImgPath( szImg,  0, "input_radio" ) );
				FFS_Rename( "img/WQHD/input_radio_off.png", Get_ImgPath( szImg,  0, "input_radio_off" ) );
				FFS_Rename( "img/WQHD/input_radio_on.png", Get_ImgPath( szImg,  0, "input_radio_on" ) );
				FFS_Rename( "img/WQHD/menu_bs.png", Get_ImgPath( szImg,  0, "menu_bs_" ) );
				FFS_Rename( "img/WQHD/menu_ccm.png", Get_ImgPath( szImg,  0, "menu_ccm_" ) );
				FFS_Rename( "img/WQHD/menu_cmm.png", Get_ImgPath( szImg,  0, "menu_cmm_" ) );
				FFS_Rename( "img/WQHD/menu_gm.png", Get_ImgPath( szImg,  0, "menu_gm_" ) );
				FFS_Rename( "img/WQHD/menu_sc.png", Get_ImgPath( szImg,  0, "menu_sc_" ) );
				FFS_Rename( "img/WQHD/nav01_home.png", Get_ImgPath( szImg,  0, "nav01_home" ) );
				FFS_Rename( "img/WQHD/nav02_keypad", Get_ImgPath( szImg,  0, "nav02_keypad" ) );
				FFS_Rename( "img/WQHD/nav03_updown.png", Get_ImgPath( szImg,  0, "nav03_updown" ) );
				FFS_Rename( "img/WQHD/nav04_setting.png", Get_ImgPath( szImg,  0, "nav04_setting" ) );
				FFS_Rename( "img/WQHD/nav05_logout.png", Get_ImgPath( szImg,  0, "nav05_logout" ) );
				FFS_Rename( "img/WQHD/select_arrow.png", Get_ImgPath( szImg,  0, "select_arrow" ) );
				FFS_Rename( "img/WQHD/title_bg_main.png", Get_ImgPath( szImg,  0, "title_bg_main" ) );
				FFS_Rename( "img/WQHD/title_bg_main_back.png", Get_ImgPath( szImg,  0, "title_bg_main_back" ) );
				FFS_Rename( "img/WQHD/title_bg_main_menu.png", Get_ImgPath( szImg,  0, "title_bg_main_menu" ) );
				FFS_Rename( "img/WQHD/title_bg_pop.png", Get_ImgPath( szImg,  0, "title_bg_pop" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_.png", Get_ImgPath( szImg,  0, "title_bg_pop_" ) );
				FFS_Rename( "img/WQHD/title_bg_pop_close.png", Get_ImgPath( szImg,  0, "title_bg_pop_close" ) );
				FFS_Rename( "img/WQHD/title_bg_sub.png", Get_ImgPath( szImg,  0, "title_bg_sub" ) );
				FFS_Rename( "img/WQHD/title_bg_sub_menu.png", Get_ImgPath( szImg,  0, "title_bg_sub_menu" ) );
				FFS_Rename( "img/WQHD/title_dot.png", Get_ImgPath( szImg,  0, "title_dot" ) );
				FFS_Rename( "img/WQHD/menu02_plus.png", Get_ImgPath( szImg,  0, "menu02_plus" ) );
			}
		}
	}
	
	//--------------------------------------------------------------------------------------
	char* Get_ImgPath(char* trgpath, char* imggb, char* fsnm)
	{
		char imgpath[256];
		
		Mem_Set( (byte*)imgpath, 0x00, sizeof(imgpath) );
		
		switch (theDevInfo.m_nType)
		{
			case FAMILY_PDA:
				SPRINT (imgpath, "IMG\\%s", fsnm, 0, 0);
				break;
				
			case FAMILY_SMART:
				SPRINT (imgpath, "IMG\\%s",fsnm, 0, 0 ) ;
				break;
				
			case FAMILY_SMALL:
				SPRINT (imgpath, "IMG\\%s%s", HD720_DIR, fsnm,0);
				break;
			case FAMILY_MIDDLE:
				SPRINT (imgpath, "IMG\\%s%s", FHD_DIR, fsnm,0);
				break;
			case FAMILY_LARGE:
				SPRINT (imgpath, "IMG\\%s%s", WQHD_DIR, fsnm,0);
				break;
			case FAMILY_SUPER:
				SPRINT (imgpath, "IMG\\%s%s", WQHD_DIR, fsnm,0);
				break;
			default:
				Str_Cpy( trgpath, "");
				break;
		}
		
		SPRINT (trgpath, "%s.%s", imgpath, PNG_EXIT, 0);

		return trgpath;
	}

	//--------------------------------------------------------------------------------------
	char* Get_BasePath(char* trgpath)
	{
		char imgpath[256];
		
		Mem_Set( (byte*)imgpath, 0x00, sizeof(imgpath) );
	
		switch (theDevInfo.m_nType)
		{
			case FAMILY_PDA:
				SPRINT (imgpath, "IMG\\", 0, 0, 0);
				break;
				
			case FAMILY_SMART:
				SPRINT (imgpath, "IMG\\",0, 0, 0 ) ;
				break;
				
			case FAMILY_SMALL:
				SPRINT (imgpath, "IMG\\%s", HD720_DIR, 0,0);
				break;
			case FAMILY_MIDDLE:
				SPRINT (imgpath, "IMG\\%s", FHD_DIR, 0,0);
				break;
			case FAMILY_LARGE:
				SPRINT (imgpath, "IMG\\%s", WQHD_DIR, 0,0);
				break;
			case FAMILY_SUPER:
				SPRINT (imgpath, "IMG\\%s", WQHD_DIR, 0,0);
				break;
			default:
				Str_Cpy( trgpath, "");
				break;
		}
		
		Str_Cpy( trgpath, imgpath);
		
		return trgpath;
	}

	//--------------------------------------------------------------------------------------
	long g_ChkDay(void)
	{
		if( Str_AtoI (stUserinfo.szloginday) != Time_GetDate() )
		{
			MessageBoxEx (CONFIRM_OK, "����� �����Ⱓ����. ���α׷� ���� �մϴ�.");
			
			g_Db_Backup();

			EvtExit();
			g_ImgFree();
			VM_AmEnd();
			return 1;
		}
		return 0;
	}

	/*=======================================================================================
	�Լ��� : g_GET_IP
	��  �� : ��Ʈ���� �����Ǹ� ����Ÿ������ �ٲ�
	Param  : Data
 	Return : G_IP:������
	========================================================================================*/
	quad	g_GET_IP ( char *Data )
	{
	quad 	G_IP;
	long	G_IndexC, G_IndexS, G_IndexD;
	char	G_Str[4];

		G_IndexS = 0;
		G_IP = 0;
		for ( G_IndexC = 0; G_IndexC < Str_Len(Data) +1; G_IndexC++)
		{
			if ( Data[G_IndexC] == '.' || Data[G_IndexC] == 0 )
			{
				G_IndexD = G_IndexC-G_IndexS;
				Mem_Cpy((byte*)G_Str, (byte*)Data+G_IndexS, G_IndexD);
				G_Str[G_IndexD] = 0;
				G_IP = G_IP*256 + (quad)Str_AtoI(G_Str);
				G_IndexS = G_IndexC+1;
			}
		}
		return G_IP;
	}
	
	/*=======================================================================================
	�Լ��� : Dat_Type
	��  �� : YYMMDD ==> YY/MM/DD ���·� ��ȯ�Ѵ�.
	Param  : Dp: ��� ���ڿ� ������
			 YYMMDD:���� ���ڿ� ������
	Return : 
	========================================================================================*/
	void g_Str_DateType(char* Dp, char* YYMMDD)
	{
	char temp[22];
		Mem_Set((byte*)temp,0x00,sizeof(temp));
		
		if(Str_Len(YYMMDD) == 8 && YYMMDD[0] != '0')
		{
			Mem_Cpy((byte*)temp, (byte*)YYMMDD, 4);
			Mem_Cpy((byte*)temp+4, (byte*)".", 1);
			Mem_Cpy((byte*)temp+5, (byte*)YYMMDD+4, 2);
			Mem_Cpy((byte*)temp+7, (byte*)".", 1);
			Mem_Cpy((byte*)temp+8, (byte*)YYMMDD+6, 2);
			temp[10] = 0;
			Str_Cpy(Dp, temp);	
			
		}
		else if(  Str_Len(YYMMDD) == 6 && YYMMDD[0] != '0' )
		{
			Mem_Cpy((byte*)temp, (byte*)YYMMDD, 4);
			Mem_Cpy((byte*)temp+4, (byte*)".", 1);
			Mem_Cpy((byte*)temp+5, (byte*)YYMMDD+4, 2);
			temp[7] = 0;
			Str_Cpy(Dp, temp);	
		}
		else if(Str_Len(YYMMDD) == 14 && YYMMDD[0] != '0')
		{
			Mem_Cpy((byte*)temp, (byte*)YYMMDD, 4);
			Mem_Cpy((byte*)temp+4, (byte*)".", 1);
			Mem_Cpy((byte*)temp+5, (byte*)YYMMDD+4, 2);
			Mem_Cpy((byte*)temp+7, (byte*)".", 1);
			Mem_Cpy((byte*)temp+8, (byte*)YYMMDD+6, 2);
			Mem_Cpy((byte*)temp+10, (byte*)" ", 1);
			Mem_Cpy((byte*)temp+11, (byte*)YYMMDD+8, 2);
			Mem_Cpy((byte*)temp+13, (byte*)":", 1);
			Mem_Cpy((byte*)temp+14, (byte*)YYMMDD+10, 2);
			Mem_Cpy((byte*)temp+16, (byte*)":", 1);
			Mem_Cpy((byte*)temp+17, (byte*)YYMMDD+12, 2);
			
			temp[20] = 0;
			Str_Cpy(Dp, temp);
		}
		else
		{
			Str_Cpy(Dp,"");
		}
		
	}

	/*=======================================================================================
	�Լ��� : Str_NTime
	��  �� : �ڷḦ �ð������� ��ȯ�Ѵ�.
	Param  : temp: ��� ���ڿ� ������
			 time: ���� long��
	Return : TRUE : ����
			 FALSE : ����
	========================================================================================*/
	void g_Str_TimeType(char *temp, long time )
	{
	char buffer[10];
	char buffer1[10];
	long i;
	
		Str_ItoA(time, buffer1, 10);
		Mem_Set((byte*)buffer,'0', sizeof(buffer));
		
		i = Str_Len(buffer1);
		Mem_Cpy((byte*)temp, (byte*)buffer, 6-i);
		Mem_Cpy((byte*)temp+6-i, (byte*)buffer1, i);
		temp[6] = 0;
		
	}
	
	/*=======================================================================================
	�Լ��� : Str_DateForm
	��  �� : hhmmss ==> HH:MM:SS �� ��ȯ
	Param  : temp1: ��� ���ڿ� ������
			 temp: ���� ���ڿ�������
	Return : 
	========================================================================================*/
	void g_Str_TimeForm(char* Dp,   char* HHMMDD)
	{
		Mem_Cpy((byte*)Dp,  (byte*)HHMMDD  , 2);
		Mem_Cpy((byte*)Dp+2,(byte*)":"   , 1);
		Mem_Cpy((byte*)Dp+3,(byte*)HHMMDD+2, 2);
		Mem_Cpy((byte*)Dp+5,(byte*)":"   , 1);
		Mem_Cpy((byte*)Dp+6,(byte*)HHMMDD+4, 2);
		Dp[8] = 0;
	}

	/*=======================================================================================
	�Լ��� : Card_Move
	��  �� : ȭ�� �� �̵�(Card_Load)
	Param  : temp1: ��� ���ڿ� ������
			 temp: ���� ���ڿ�������
	Return : 
	global	char	g_CurrentCard[33];		//���� ȭ�� Card
	global	char	g_PrevCard[33];			//���� ������ ȭ�� Card
	========================================================================================*/
	void Card_Move(char* Cardnm)
	{
		Mem_Set ((byte*)g_PrevCard, 0x00, sizeof(g_PrevCard));		
		Str_Cpy(g_PrevCard, g_CurrentCard);
		Mem_Set ((byte*)g_CurrentCard, 0x00, sizeof(g_CurrentCard));		
		Str_Cpy(g_CurrentCard, Cardnm);

		Card_Load(Cardnm);
	}
	
	/*=======================================================================================
	�Լ��� : Card_Prev
	��  �� : ȭ�� �� �̵�(Card_Load)
	Param  : temp1: ��� ���ڿ� ������
			 temp: ���� ���ڿ�������
	Return : 
	global	char	g_CurrentCard[33];		//���� ȭ�� Card
	global	char	g_PrevCard[33];			//���� ������ ȭ�� Card
	========================================================================================*/
	void Card_Prev( void )
	{
		char temp[33];
		
		Mem_Set ((byte*)temp, 0x00, sizeof(temp));
		Str_Cpy(temp, g_PrevCard);		
		Mem_Set ((byte*)g_PrevCard, 0x00, sizeof(g_PrevCard));		
		Str_Cpy(g_PrevCard, g_CurrentCard);
		Mem_Set ((byte*)g_CurrentCard, 0x00, sizeof(g_CurrentCard));		
		Str_Cpy(g_CurrentCard, temp);							
		
		Card_Load(g_CurrentCard);
	}

	/*=======================================================================================
	�Լ��� : g_FlagClear
	��  �� : ���� FLAG �ʱ�ȭ
	Param  :
	Return : 
	========================================================================================*/
	global void g_FlagClear(void)
	{
     	g_lindex = 0;			//�����ʹ� ���ڵ��� ��ġ
	    g_nActIndex = 0;		//index ��ȣ
	    g_nObjIndex = 0;		//Ư������ �跮�� index ��ȣ
	    g_nActRow = 0;			//���õ� Row(�跮������ ȭ�� ���� ������ ���)
	    g_nChkIndex = 0;		//������ ���� ����Ʈ index
		g_nGrpIndex = 0;		//������ ���� �׷츮��Ʈ index
		g_nUserData = 0;		//��ħ���� �ǻ���� ���� �� �ʿ��� ����
		
		g_nAddrFlag = 0;		//���ּ�&���ּ� �÷��� g_nAddrFlag = 0 -> ���ּ�    g_nAddrFlag = 1 -> ���ּ�             
		g_nTelFlag = 0;			//��ħ���,���˽��� �� ��ȭ��ȣ flag , g_nTelFlag = 0 > �ڵ��� , g_nTelFlag = 1 > ��,ȸ��
		g_nNameFlag = 0;		//��ħ���,���˽��� �� �̸�,��ȣ�� flag , g_nNameFlag = 0 > �̸�, g_nNameFlag = 1 > ȸ��,��ȣ
		g_nGrpFlag = 0;
		g_nGmType = 0;
		
		//g_lDataflag : SetData�� �ٽ� ȣ�� ���ϵ����ϱ����� flag, ó�� ȭ�� ������ �ÿ� 1��, ����&����ȭ��, ���� �Ҷ��� ����.
		g_lDataflag = 0;		//��ħȭ�� flag, g_lDataflag = 0 -> ȣ��, g_lDataflag = 1 -> ȣ��X
		g_nWorkFlag = 0;		//���� �÷���                                                                             
		g_nMemoFlag = 0;		//��ħ,����,������ ���� �÷���, 1:��ħ , 2:��������, 3:������, 4:Ư������ �޸�            
		g_lSCMoveFlag = 0;		//���� ȭ�� ���� ȭ���̵� flag(��������,Ư������)                                         
		g_lMoveFlag = 0;		//(����Ʈ) ȭ�� ���� ȭ���̵� flag, g_lMoveFlag = 0 > default , g_lMoveFlag = 1 > ȭ���̵�
		g_lNewBurFlag = 0;      //Ư������ ���ұ� �űԵ�� ���� �÷���(���Ϸ�, ���ұ�) g_lNewBurFlag = 1:���Ϸ�, 2:���ұ� 
		g_lConfrimFlag = 0;  	//���� �� Ȯ���ؾ��ϴ� ȭ�� ���� Flag =0 default, =1 �̵�                                                                                                
		g_lPAYFlag = 0;		    //�����ȸ ��û����       
		g_TRNUM = 0;			//��ſ� �÷���
		g_lRfrmFlag = 0;        //���˽��ۿ� �����չ��� �ؽ�Ʈ ���� �÷���, = 0 default, =1 �̵�              
		g_lGrpCmbFlag = 0;		//������ ���� �޺��ڽ� �׷� ����Ʈ ���� index,                                
		g_lDtlCmbFlag = 0;		//������ ���� �޺��ڽ� �� ����Ʈ ���� index,                                
		g_nWorkChkFlag = 0;     //���� �� ������ ���� ���� �÷���
		g_nPhotoFlag = 0;       //�����÷���( ��ħ:1, ��������:2, ������:3, Ư������:4, ��������������:5)       
		                        //�����ȸ ȭ���̵�( ��ħ:1, ��������:2, ������:3, Ư������:4, ��������������:5)
		g_nPhotoYNFlag = 0;		//�跮�ⱳü, ���� �Կ� ���� Ȯ�� FLAG, 0 = �Կ� ����. 1 = �Կ� �Ϸ�.
		g_nBojungFlag = 0;
		g_lNpChkFlag = 0;
		g_lNpMemoChkFlag = 0;
		g_nSmsSndFlag = 0;

		Mem_Set((byte*)g_szSubCHK_EXEC_NUM, 0x00, sizeof(g_szSubCHK_EXEC_NUM));	   //�������� ��ݼ��� ȭ�� ���� �ش� ���˹�ȣ
		Mem_Set((byte*)g_szPtrn_Week, 0x00, sizeof(g_szPtrn_Week) );
		Mem_Set((byte*)g_szPtrn_Time, 0x00, sizeof(g_szPtrn_Time) );
		Mem_Set((byte *)g_szIndi_Vm, 0x00, sizeof(g_szIndi_Vm));
		Mem_Set((byte *)g_szIndi_Va, 0x00, sizeof(g_szIndi_Va));
		Mem_Set((byte *)g_szIndi_Vc, 0x00, sizeof(g_szIndi_Vc));
		Mem_Set((byte *)g_szMtr_Loc_Flag, 0x00, sizeof(g_szMtr_Loc_Flag));
		Mem_Set((byte *)g_szSealed_Sts, 0x00, sizeof(g_szSealed_Sts));		
		Mem_Set((byte *)g_szCurrBar, 0x00, sizeof(g_szCurrBar));	
		Mem_Set((byte *)g_szSqlWhere, 0x00, sizeof(g_szSqlWhere));	
		Mem_Set((byte *)g_szCntSql, 0x00, sizeof(g_szCntSql));	
		Mem_Set((byte *)g_szOBJ_CRT_YMD, 0x00, sizeof(g_szOBJ_CRT_YMD));	
		Mem_Set((byte *)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM));	
		Mem_Set((byte *)g_szUSE_CONT_NUM_Fee, 0x00, sizeof(g_szUSE_CONT_NUM_Fee));	
		Mem_Set((byte *)g_szCpNum, 0x00, sizeof(g_szCpNum));	
		Mem_Set((byte *)g_szCp_ddd, 0x00, sizeof(g_szCp_ddd));	
		Mem_Set((byte *)g_szCp_exn, 0x00, sizeof(g_szCp_exn));	
		Mem_Set((byte *)g_szCp_num, 0x00, sizeof(g_szCp_num));	
		Mem_Set((byte *)g_szCmb_Str, 0x00, sizeof(g_szCmb_Str));	
		Mem_Set((byte *)g_szTimerCock, 0x00, sizeof(g_szTimerCock));	
		Mem_Set((byte *)g_szFuseCock, 0x00, sizeof(g_szFuseCock));	
		Mem_Set((byte *)g_szKitsprinkler, 0x00, sizeof(g_szKitsprinkler));
	}
	
//-------------------------------------------------------------------
	long g_Sql_Bind(char* szSql, long szBindLen, char* szBind, long Retlen, char* szRet)
	{
	long i = 0;
	long ret = -1;
	char szBuf[30];	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = -1;
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -2;
			goto Finally;
		}
		
		ret = sql->Execute(sql);
		
		while( sql->Next(sql))
		{
			Mem_Set((byte *)szBuf, 0x00, sizeof(szBuf));
			sql->GetValue( sql, 0, 'U', (long*)szBuf, szBindLen, DECRYPT );
			if( Mem_Cmp((byte*)szBind, (byte*)szBuf, Str_Len(szBind)) == 0 )
			{
				sql->GetValue( sql, 1, 'U', (long*)szRet, Retlen, DECRYPT );
				ret = 1;
				break;
			}
		}
		
		
Finally:
		//if(sql != NULL)
		//	sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}

//-------------------------------------------------------------------
	long g_Sql_RetStr(char* szSql, long Retlen, char* szRet )
	{
	long ret = -1;
	char szBuf[10];	
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();
	
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = -1;
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::g_Sql_RetStr SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -2;
			goto Finally;
		}
		
		if(sql->Begin(sql) == FALSE)
		{
			PRINT("::g_Sql_RetStr Begin fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}

		//ret = sql->Execute(sql);
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::g_Sql_RetStr SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
				
		if(sql->Next(sql) == FALSE)
		{
			//PRINT("::SQL_Next fail [%s]", sql->GetLastError(sql), 0, 0);
			ret= -3;
			goto Finally;
		}
		else
		{
			Mem_Set((byte *)szBuf, 0x00, sizeof(szBuf));
			sql->GetValue( sql, 0, 'U', (long*)szRet, Retlen, DECRYPT );
		}
		
		ret = 1;

Finally:
		//if(sql != NULL)
		//	sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	long g_Sql_RetInt(char* szSql, long* nvalue)
	{
		long ret = -1;
		char szBuf[10];	
		handle hdb = NULL;
		handle hstmt = NULL;
		long ntmp = 0;
		SQLITE sql = NewSqLite();

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::g_Sql_RetInt SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Begin(sql) == FALSE)
		{
			PRINT("::g_Sql_RetInt Begin fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
		
		//ret = sql->Execute(sql);
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::g_Sql_RetInt SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
	
		if(sql->Next(sql) == FALSE)
		{
			PRINT("::g_Sql_RetInt SQL_Next fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = 0;
			goto Finally;
		}
		else
		{
			Mem_Set((byte *)szBuf, 0x00, sizeof(szBuf));
			sql->GetValue( sql, 0, 'U', (long*)szBuf, 4, DECRYPT );
			ntmp = Str_AtoI(szBuf);
		}
		
		ret = 1;			

Finally:
		*nvalue = ntmp;
		//if(sql != NULL)
		//	sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	
	long g_Sql_RetStr2(SQLITE sql, char* szSql, long Retlen, char* szRet )
	{
	long ret = -1;
	char szBuf[10];	
	handle hdb = NULL;
	handle hstmt = NULL;
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::g_Sql_RetStr2 SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -2;
			goto Finally;
		}
		/*
		if(sql->Begin(sql) == FALSE)
		{
			PRINT("::g_Sql_RetStr2 Begin fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
		*/
		//ret = sql->Execute(sql);
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::g_Sql_RetStr2 SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
				
		if(sql->Next(sql) == FALSE)
		{
			PRINT("::g_Sql_RetStr2 SQL_Next fail [%s]", sql->GetLastError(sql), 0, 0);
			ret= -3;
			goto Finally;
		}
		else
		{
			Mem_Set((byte *)szBuf, 0x00, sizeof(szBuf));
			sql->GetValue( sql, 0, 'U', (long*)szRet, Retlen, DECRYPT );
		}
		
		ret = 1;
		
Finally:
		sql->DeleteStatement(sql);
		
		return ret;
	}
	
	long g_Sql_RetInt2(SQLITE sql, char* szSql, long* nvalue)
	{
	long ret = -1;
	char szBuf[10];	
	handle hdb = NULL;
	handle hstmt = NULL;
	long ntmp = 0;

		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::g_Sql_RetInt2 SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		/*
		if(sql->Begin(sql) == FALSE)
		{
			PRINT("::g_Sql_RetInt2 Begin fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
		*/
		//ret = sql->Execute(sql);
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::g_Sql_RetInt2 SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
	
		if(sql->Next(sql) == FALSE)
		{
			PRINT("::g_Sql_RetInt2 SQL_Next fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = 0;
			goto Finally;
		}
		else
		{
			Mem_Set((byte *)szBuf, 0x00, sizeof(szBuf));
			sql->GetValue( sql, 0, 'U', (long*)szBuf, 4, DECRYPT );
			ntmp = Str_AtoI(szBuf);
		}
		ret = 1;			

Finally:
		sql->DeleteStatement(sql);
		*nvalue = ntmp;
		
		return ret;
	}
	
	long g_Sql_DirectExecute(char* szSql)
	{
		long ret = -1;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//PRINT("::g_Sql_DirectExecute start", 0, 0, 0);
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::g_Sql_DirectExecute SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Begin(sql) == FALSE)
		{
			PRINT("::g_Sql_DirectExecute Begin fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::g_Sql_DirectExecute SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
		else
		{
			ret = 0;
			//PRINT("::g_Sql_DirectExecute sql->Execute(sql) == TRUE", 0, 0, 0);
		}
Finally:
		//if(sql != NULL)
		//	sql->Commit(sql);
			
		DelSqLite(sql);
		return ret;
	}
	
	long g_Sql_DirectExecute2(SQLITE sql, char* szSql)
	{
		long ret = -1;
		handle hdb = NULL;
		handle hstmt = NULL;
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::g_Sql_DirectExecute2 SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		/*
		if(sql->Begin(sql) == FALSE)
		{
			PRINT("::g_Sql_DirectExecute2 Begin fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
		*/
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::g_Sql_DirectExecute2 SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
		else
		{
			ret = 0;
			//PRINT("::g_Sql_DirectExecute sql->Execute(sql) == TRUE", 0, 0, 0);
		}
Finally:
		sql->DeleteStatement(sql);

		return ret;
	}

	
	long g_Sql_SetCombo(char* szSql, long CTRLID )
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
			PRINT("::g_Sql_SetCombo hdb == NULL", 0, 0, 0);
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, szSql);
		if( hstmt == NULL )
		{
			PRINT("::g_Sql_SetCombo SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Begin(sql) == FALSE)
		{
			PRINT("::g_Sql_SetCombo Begin fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::g_Sql_SetCombo SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}
		
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
		
		ret = 0;
		
Finally:
		//if(sql != NULL)
		//	sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	//---------------------------------------------------------------------------------
	//�Լ���: g_Sql_SaveSeq
	//��  ��: ��������� seq���� ���Ͽ� �����Ѵ�.
	//Param : szSql : ������ ���� FSNM:SEQ�������ϸ� 
	//Return: ����:1 ����:-1 
	//---------------------------------------------------------------------------------
	long g_Sql_SaveSeq(char* szSql, char* FSNM)
	{
	long 	ret = -1;
	long 	fd;
	char	sztmp[11];
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		fd = FFS_Open(FSNM, FS_WRITE_MODE, FS_CREATE_FLAG ) ;
		if( fd == -1)
		{
			//���Ͽ��½��нÿ� ���� ī��� �̵��Ѵ�.
			MessageBoxEx (ERROR_OK, "���ϻ�������.");
			goto Finally;
		}

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			FFS_Flush(fd);
			FFS_Close(fd);
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, szSql);

		if( hstmt == NULL )
		{
			PRINT("::g_Sql_SaveSeq SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			FFS_Flush(fd);
			FFS_Close(fd);
			goto Finally;
		}

		sql->Begin(sql);

		//ret = sql->Execute(sql);
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::g_Sql_SaveSeq SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			//sql->Rollback(sql);
			goto Finally;
		}

		while(sql->Next(sql) == TRUE)
		{	
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );

			sql->GetValue( sql, 0, 'C', (long*)sztmp, sizeof(sztmp), DECRYPT );
			sztmp[8] = 0x0D;
			sztmp[9] = 0x0A;
			FFS_Write(fd, (byte*)sztmp, 10 );
		}

		FFS_Flush(fd);
		FFS_Close(fd);
		
		ret = 0;
		
Finally:
		//if(sql != NULL)
		//	sql->Commit(sql);

		DelSqLite(sql);

		return ret;
	}	
	
	/*=======================================================================================
	�Լ��� : g_SREACHFILE_GetSeq
	��  �� : �˻��� ���Ͽ��� �ε���(Seq)�� ���� �´�.
	Param  : nPos:�˻� �ε��� ������ ����
 	Return : TRUE : �ε���
 			 FALSE:-1
	========================================================================================*/
	long g_SREACHFILE_GetSeq(char *SREACHFILE, long nPos)
	{
	long 	fd, nIndex;
	char 	sztmp[10];
		
		fd = FFS_Open( SREACHFILE, FS_READ_MODE, FS_NORMAL_FLAG);

		if(fd == -1)
		{
			MessageBoxEx (ERROR_OK, "������ ã���� �����ϴ�.");
			return -1;
		}
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		if(FREAD(fd, nPos*SRCH_FS_SIZE+SRCH_FS_INDEX_POS, sztmp, 8) == FALSE)
		{
		  	FFS_Flush(fd);
			FFS_Close(fd);
			return -1;
		}
		if(Str_Len(sztmp) == 0)
		{
		  	FFS_Flush(fd);
			FFS_Close(fd);
			return -1;
		}
		nIndex = Str_AtoI(sztmp);

		FFS_Flush(fd);
		FFS_Close(fd);
		return nIndex;
	}

	/*=======================================================================================
	 �Լ��� : g_Get_FsIndex
	 ��  �� : �ε����� �׷��� ��ġ�� ���� �´�.
	 Param  : 
	  Return : TRUE :����
	     FALSE:������ �����ÿ� ����
	 ========================================================================================*/
	long g_Get_FsIndex(long lRowid, char* FSNM)
	{
		long i;
		long fd;
		char sztmp[20];
		long ltotcnt;
		long lRowindex = 0;
		
		////�� ���ڵ��
		ltotcnt = g_FS_GetSrchTotCnt(FSNM);
		
		fd = FFS_Open(FSNM, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			//���Ͽ��½��нÿ� ���� ī��� �̵��Ѵ�.
			MessageBoxEx (ERROR_OK, "�ڷῡ �̻��� �ֽ��ϴ�.");
			//OnButton(BID_EXIT);
			return -1;
		}
		
		for ( i = 0 ; i < ltotcnt; i++)
		{
			//�ε���
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			FREAD(fd, i*SRCH_FS_SIZE+SRCH_FS_INDEX_POS, sztmp, 8);
			lRowindex = Str_AtoI(sztmp);

			if( lRowid == lRowindex )
			{
				FFS_Flush(fd);
				FFS_Close(fd);
				return i; 
			}
		}
		
		FFS_Flush(fd);
		FFS_Close(fd);
		return -1;
	}


	/*=======================================================================================
	�Լ��� : FS_GetSrchTotCnt
	��  �� : �˻��ε��������� ���ڵ� ���� �����Ѵ�.
	Param  : nPos:�˻� �ε��� ������ ����
 	Return : ���ڵ��
	========================================================================================*/
	long g_FS_GetSrchTotCnt(char* FSNM)
	{
		long size = 0;
		
		size = FFS_GetSize( FSNM );
		size = size/SRCH_FS_SIZE;
		return size;
	}

	/*=======================================================================================
	�Լ��� : Del_Sc
	��  �� : �������
	Param  : 
	Return :
	========================================================================================*/
	void g_Del_ScData(void)
	{
		char szSql[500];
		char szDay[50];
		long idx;
		long cnt = 0 ;
		/*
		//��� �Ÿ� �� ���� ����
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM NORMAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		//�跮�� ��������
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE NORMAL_MTR SET SEND_YN = 'N',FUSE_COCK_INST_YN='',TIMER_COCK_INST_YN='', CHK_RSLT=''  WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		//���Ϸ�,���ұ� ����
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE NORMAL_BUR SET SEND_YN = 'N',LOC_RSLT='',AIR_RSLT='',PIPE_RSLT='', ETC_RSLT=''  WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		//�ű� ���Ϸ� �� ���ұ� ����..
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM NORMAL_BUR WHERE CHK_EXEC_NUM ='%s' AND CHG_FLAG ='1' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		//���Ϸ�, ���ұ� SEQ�� �ʱ�ȭ
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE NORMAL_BUR SET SEQ = null " , 0, 0, 0);
		
		//����������
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM NORMAL_INFO WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		//�� �ּ�Ȯ��
		//Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		//SPRINT(szSql, "UPDATE NORMAL_ADDR SET CURR_ADDR_RSLT = '', NEW_ADDR_RSLT = '', SEND_YN = 'N' WHERE BLD_NUM = '%s' "
		//			, stSc.BLD_NUM, 0, 0);
		//g_Sql_DirectExecute( szSql );
		
		//������ �׸� ����(��, ������ �켱������ ����� ��� �������� �ʵ���)
		if ( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") != 0 && Str_Cmp(stSc.PREUSE_CHK_WHY, "30") != 0 )
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM NORMAL_NOGOOD WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute( szSql );
			
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM NORMAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute( szSql );
			
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute( szSql );
		}
		
		//��� ����
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE NORMAL_DATA SET PIPE_RSLT = '', LOC_RSLT = '', MTR_RSLT = '' \
					, BO_RSLT = '', BUR_FLAG = '', CUST_FLAG = '', NOGOOD_RSLT = '', PIPE_BURY_YN = '', \
					PIPE_HIDE_YN = '', SEND_YN = 'N', CHK_EXCEP_WHY = '', CURR_BAR ='', BAR_WHY ='', \
					CHKER_NM ='', CHK_YMD ='', SIGN_RELAT = '', CHK_RSLT = '' WHERE CHK_EXEC_NUM ='%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		*/

		//�跮�� ��������
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE NORMAL_MTR SET MTR_RSLT='', PIPE_RSLT = '', CHK_RSLT='' WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		//���Ϸ�,���ұ� ,SEQ�� �ʱ�ȭ
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE NORMAL_BUR SET CHK_RSLT='', SEQ = null  WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		/*
		// �����ǰ� �׸�
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT COUNT(1) FROM NORMAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);			
		g_Sql_RetInt( szSql, &cnt );
		*/
		//������ �׸� ����(��, ������ �켱������ ����� ��� �������� �ʵ���)
		if ( Str_Cmp(stSc.PREUSE_CHK_WHY, "10") != 0 && Str_Cmp(stSc.PREUSE_CHK_WHY, "30") != 0 )
		{
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM NORMAL_NOGOOD \
			                 WHERE CHK_EXEC_NUM = '%s' \
			                   AND ( PRE_CHK_OBJ_YN IS NULL OR PRE_CHK_OBJ_YN <> 'Y') \
			                   AND CHK_EXEC_NUM NOT IN ( SELECT CHK_EXEC_NUM \
													       FROM NORMAL_NOGOOD_DETAL \
													      WHERE EXCEP_PREUSE_CHK = 'Y' \
													   ) ", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute( szSql );
			
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM NORMAL_NOGOOD_CHA \
			                 WHERE CHK_EXEC_NUM = '%s' \
			                   AND ( PRE_CHK_OBJ_YN IS NULL OR PRE_CHK_OBJ_YN <> 'Y' ) \
			                   AND CHK_EXEC_NUM NOT IN ( SELECT CHK_EXEC_NUM \
														     FROM NORMAL_NOGOOD_DETAL \
														    WHERE EXCEP_PREUSE_CHK = 'Y' \
														 )", g_szCHK_EXEC_NUM, 0, 0);
			g_Sql_DirectExecute( szSql );

			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " DELETE FROM NORMAL_NOGOOD_DETAL \
			                 WHERE CHK_EXEC_NUM = '%s' \
			                   AND ( PRE_CHK_OBJ_YN IS NULL OR PRE_CHK_OBJ_YN <> 'Y' ) \
			                   AND EXCEP_PREUSE_CHK = 'N' ", g_szCHK_EXEC_NUM, 0, 0);
			                   
			g_Sql_DirectExecute( szSql );

		}
		
		/*
		//��� ����
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE NORMAL_DATA SET PIPE_RSLT = '', LOC_RSLT = '', MTR_RSLT = '' \
					, BO_RSLT = '', BUR_FLAG = '', CUST_FLAG = '', NOGOOD_RSLT = '', SEND_YN = 'N', CHK_EXCEP_WHY = '' \
					, CURR_BAR ='', BAR_WHY ='', CHKER_NM ='', CHK_YMD ='', CHK_RSLT = '' WHERE CHK_EXEC_NUM ='%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		*/
		
		//��� ����
		//2016-05-25 Sanghyun Lee / ����Ʈ���� CURR_BAR�� ��� ��� DB�� ������Ʈ�ϵ��� ����. ���˽���ȭ���� ������ ���Ʈ���Ŀ� ���� �� ���� �� �� ���� ����
		//2019-01-15 �ű�ȣ / �Ұ����� ����
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE NORMAL_DATA \
		                   SET PIPE_RSLT = '', LOC_RSLT = '', MTR_RSLT = '', BO_RSLT = '', BUR_FLAG = '' \
						  	 , CUST_FLAG = '', NOGOOD_RSLT = '', SEND_YN = 'N', CHK_EXCEP_WHY = '', CHKER_NM = '' \
							 , CHK_YMD = '', CHK_RSLT = '' WHERE CHK_EXEC_NUM = '%s' "
					, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );

		//MessageBoxEx (CONFIRM_OK, "������ ��ҵǾ����ϴ�.");
		return;
	}
	
	/*=======================================================================================
	�Լ��� : g_Del_BsData
	��  �� : ���� ���� ����
	Param  : 
	Return :
	========================================================================================*/
	void g_Del_BsData(void)
	{
		char szSql[300];
		char szDay[50];
		long idx;
/*
		//��� �Ÿ� �� ���� ����
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM SPECIAL_PIPE_CHK_DATA WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		//���������� ��������
		//Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		//SPRINT(szSql, " UPDATE SPECIAL_GOV_REG SET SEND_YN='N', DISJOINT_CHK_YMD='', UPD_EMPID='', PDA_IP=''  WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		//g_Sql_DirectExecute( szSql );

		//�跮�� ��������
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE SPECIAL_MTR SET SEND_YN = 'N', INDI_VC_CUR = '', INDI_VA_CUR = '', MTR_INDI_CUR = '', MRT_RSLT=''  WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		//���Ϸ�,���ұ� ����
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " UPDATE SPECIAL_BUR SET SEND_YN = 'N',BUR_RSLT='' WHERE CHK_EXEC_NUM ='%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );

		//�ű� ���Ϸ� �� ���ұ� ����..
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM SPECIAL_BUR WHERE CHK_EXEC_NUM ='%s' AND CHG_FLAG ='1' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );

		//������ �׸� ����(��, ������ �켱������ ����� ��� �������� �ʵ���)
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM SPECIAL_NOGOOD WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM SPECIAL_NOGOOD_CHA WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
		SPRINT(szSql, " DELETE FROM SPECIAL_NOGOOD_DETAL WHERE CHK_EXEC_NUM = '%s' ", g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );
		
		//��� ����
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
SPRINT(szSql, " UPDATE SPECIAL_DATA SET GOV_RSLT = '', REG_RSLT = '', PIPE_RSLT = '', PIPEETC_RSLT = '' \
, ADV_DIST_YN = '', HEAT_PUMP_YN = '', SPECIAL_RSLT = '', INFO_FLAG = '', MRT_RSLT = '', CHK_RSLT ='' \
, CHK_TIME_FROM ='', CHK_TIME_TO ='', SIGN_RELAT ='', SIGN ='', CURR_BAR = '', BAR_WHY = '' \
, PERIOD_CHK_YMD ='', PIPE_BURY_YN = '', PIPE_HIDE_YN = '', SEND_YN = 'N' WHERE CHK_EXEC_NUM ='%s' "
, g_szCHK_EXEC_NUM, 0, 0);
		
		g_Sql_DirectExecute( szSql );
*/
				
		//��� ����
		Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
SPRINT(szSql, " UPDATE SPECIAL_DATA SET CHK_RSLT ='' \
, CHK_TIME_FROM ='', CHK_TIME_TO ='', SEND_YN = 'N' WHERE CHK_EXEC_NUM ='%s' "
, g_szCHK_EXEC_NUM, 0, 0);
		g_Sql_DirectExecute( szSql );


		return;
	}
	
	//-----------------------------------------------------------------------------------
	void g_Exit_DelScData (void)
	{
		if(MessageBoxEx (CONFIRM_YESNO, "���α׷��� �����Ͻðڽ��ϱ�?") != MB_OK)
		{
			return;
		}
		
		g_Del_ScData();
		
		g_Db_Backup();
		
		//����̹���
		EvtExit();
		g_ImgFree();
		VM_AmEnd();
		return;
	}
	
	//-----------------------------------------------------------------------------------
	void g_Exit_DelBsData (void)
	{
		if(MessageBoxEx (CONFIRM_YESNO, "���α׷��� �����Ͻðڽ��ϱ�?") != MB_OK)
		{
			return;
		}
		
		g_Del_BsData();
		
		g_Db_Backup();
		
		//����̹���
		EvtExit();
		g_ImgFree();
		VM_AmEnd();
		return;
	}
	
	//-----------------------------------------------------------------------------------
	void g_Exit_DelGcData (void)
	{
		if(MessageBoxEx (CONFIRM_YESNO, "���α׷��� �����Ͻðڽ��ϱ�?") != MB_OK)
		{
			return;
		}
		
		g_Del_GcPhoto();
		
		g_Db_Backup();
		
		//����̹���
		EvtExit();
		g_ImgFree();
		VM_AmEnd();
		return;
	}
	
	//-----------------------------------------------------------------------------------
	void g_Del_GcPhoto(void)
	{
		char *pCamera;
		char szFullpath[256];
		char szfilenm[100];
		long nRet;

		if( g_nWorkFlag > 599 && g_nWorkFlag < 700 )
		{
			//�ο�
			if( Str_Cmp(stChgMtr.szSend_yn, "S") != 0 && Str_Cmp(stChgMtr.szSend_yn, "Y") != 0 )
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
		}
		else //if( g_nWorkFlag > 699 && g_nWorkFlag < 800 )
		{
			//�跮�ⱳü
			if( Str_Cmp(stMtrChg.SEND_YN, "S") != 0 && Str_Cmp(stMtrChg.SEND_YN, "Y") != 0 )
			{
				if( g_nPhotoFlag == 7 )
				{
					//ö���� �跮��
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
					Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
					Str_Cpy(szfilenm, "MBM");
					Str_Cat(szfilenm, "_");
					Str_Cat(szfilenm, stMtrChg.MTR_NUM);
					Str_Cat(szfilenm, ".jjp");
					SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
			
					if(FFS_Exist(szFullpath) > 0)
					{
						FFS_Delete( szFullpath );
					}
					
					Sleep(50);
			
					//��ġ�� �跮��
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
					Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
					Str_Cpy(szfilenm, "MAM");				
					Str_Cat(szfilenm, "_");
					Str_Cat(szfilenm, stMtrChg.MTR_NUM);
					Str_Cat(szfilenm, ".jjp");
					SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
			
					if(FFS_Exist(szFullpath) > 0)
					{
						FFS_Delete( szFullpath );
					}
				}
				else if( g_nPhotoFlag == 8 )
				{
					//ö���� �跮��
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
					Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
					Str_Cpy(szfilenm, "MBM");
					Str_Cat(szfilenm, "_");
					Str_Cat(szfilenm, stMtrChg.MTR_NUM);
					Str_Cat(szfilenm, ".jjp");
					SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
			
					if(FFS_Exist(szFullpath) > 0)
					{
						FFS_Delete( szFullpath );
					}
					
					Sleep(50);
			
					//��ġ�� �跮��
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
					Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
					Str_Cpy(szfilenm, "MAM");				
					Str_Cat(szfilenm, "_");
					Str_Cat(szfilenm, stMtrChg.MTR_NUM);
					Str_Cat(szfilenm, ".jjp");
					SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
			
					if(FFS_Exist(szFullpath) > 0)
					{
						FFS_Delete( szFullpath );
					}
	
					//ö���� ������
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
					Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
					Str_Cpy(szfilenm, "CBM");
					Str_Cat(szfilenm, "_");
					Str_Cat(szfilenm, stMtrChg.MTR_NUM);
					Str_Cat(szfilenm, ".jjp");
					SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
			
					if(FFS_Exist(szFullpath) > 0)
					{
						FFS_Delete( szFullpath );
					}
					
					Sleep(50);
			
					//��ġ�� ������
					Mem_Set((byte*)szfilenm, 0x00, sizeof(szfilenm));
					Mem_Set((byte*)szFullpath, 0x00, sizeof(szFullpath));
					Str_Cpy(szfilenm, "CAM");				
					Str_Cat(szfilenm, "_");
					Str_Cat(szfilenm, stMtrChg.MTR_NUM);
					Str_Cat(szfilenm, ".jjp");
					SPRINT (szFullpath, "%s/%s", PHOTO_GC,  szfilenm, 0);
			
					if(FFS_Exist(szFullpath) > 0)
					{
						FFS_Delete( szFullpath );
					}
				}
			}
		}
		
		return;
	}
	
	//----------------------------------------------------------------------
	//�Լ���: g_Save_JsonFile
	//��  ��: JSON_toString ������ ���Ͽ� �����ϴ� �Լ�
	//Param : 
	//Return: 
	//----------------------------------------------------------------------
	long g_Save_JsonFile(char* pStrJson)
	{
	long fd;
	long len;
		
		fd = FS_Open ( "SND.JSON", FS_WRITE_MODE,  FS_CREATE_FLAG);
		if(fd < 0)
		{
			return -1;
		}	
		len = Str_Len(pStrJson);
		FS_Write(fd,(byte*)pStrJson, len);
		FS_Close(fd);
		return 1;
	}
	
	/*
	//----------------------------------------------------------------------
	//�Լ���: SQL_FSTODB
	//��  ��: ���������� ���̺������� �о ���Ͽ��� DB�� �����͸� �ִ´�.
	//Param : TBL ����
	//Return: TRUE:����, FALSE:����
	//----------------------------------------------------------------------
	bool g_Sql_RowSetToDB( DBInfo* info )
	{
	long	ret = -1, idx = 0;
	long 	nTCnt, i;
	char	sztmp[100];
	long	nCnt = 0;
	SQLITE sql = NewSqLite();
	handle   json = JSON_Create( JSON_Object );
		
		//JSON_LoadFile (json, info->szFSnm );
	
		sql->Open(sql);
		if( sql->m_hdb == NULL )
		{
			DelSqLite(sql);
			MessageBoxEx(ERROR_OK, "�����ͺ��̽� ���� ����.. \n������ �ʱ������ �缳ġ �� �ּ���.");
			return ret;
		}
	
		MessageBoxEx(MESSAGE, "�����͸� Ȯ���� �Դϴ�.");

		sql->CreateStatement(sql, sql->m_szSql);
		if( sql->m_hStmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			sql->Close(sql);
			DelSqLite(sql);
			return ret;
		}
	
		sql->Begin(sql);
		
		ret = sql->Execute(sql);
		
		while(sql->Next(sql) == TRUE)
		{
			Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp) );
			sql->GetValue( sql, 0, 'C', (long*)sztmp, sizeof(sztmp), DECRYPT );
			sztmp[8] = 0x0D;
			sztmp[9] = 0x0A;
			//FS_Write(fd, (byte*)sztmp, 10 );
		}
		
		for(i=0 ; i < nTCnt ; i++)
		{			
			if( i % 100 == 0 || i == nTCnt-1 )
			{
				DRAW_PROGRESS (BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, i+1, nTCnt);
			}
			                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
			for(idx = 0; idx < info->nTotCnt ; idx++)
			{
				Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
				//FREAD(fd, i*info->nSize+info->fldinfo[idx].offset, sztmp, info->fldinfo[idx].len   );

				switch( info->fldinfo[idx].type)
				{
				case SQLITE_STR:
					sql->Bind(sql, idx, 'C', (long*)sztmp, info->fldinfo[idx].len, info->fldinfo[idx].encrypt );
					break;
				case SQLITE_UTF:
					sql->Bind(sql, idx, 'U', (long*)sztmp, info->fldinfo[idx].len, info->fldinfo[idx].encrypt );
					break;
				case SQLITE_BIN:					
					sql->Bind(sql, idx, 'B', (long*)sztmp, info->fldinfo[idx].len, info->fldinfo[idx].encrypt );
					break;
				case SQLITE_INT:
					sql->Bind(sql, idx, 'X', (long*)sztmp, info->fldinfo[idx].len, info->fldinfo[idx].encrypt );
					break;
				case SQLITE_SEQ:
					sql->Bind(sql, idx, 'X', (long*)sztmp, info->fldinfo[idx].len, info->fldinfo[idx].encrypt );
					break;					
				}
			}
		}
		
		sql->DeleteStatement(sql);
		sql->Commit(sql);
		sql->Close(sql);
		DelSqLite(sql);
		return TRUE;	
	}
	*/
	
	//---------------------------------------------------------------------------------
	//�Լ���: g_EncryptDecrypt
	//��  ��: ������ ��ȣȭ, ��ȣȭ
	//	���Ͽ� read �ϰ� ����, write �ϱ� ����
	//Param : long flag : ��ȣ/��ȣȭ ���� 
	//Return:
	//---------------------------------------------------------------------------------
	long g_EncryptDecrypt(long flag, char *szData, long nFieldLen)
	{
		long i, j, nDataLen, nKeyLen;
		char szKeyword[20];
		char *szBuf;
		char sztmp[101];
		
		Mem_Set((byte*)sztmp,0x00, sizeof(sztmp) );
		if( Str_Len(szData) > 0)
		{
			if( flag == ENCRYPT )
				Encode(  szData, nFieldLen, sztmp, nFieldLen);
			else
				Decode(  szData, nFieldLen, sztmp, nFieldLen);
			
			Mem_Cpy((byte *)szData, (byte *)sztmp, nFieldLen);
		}	

		return 1;
	}
	
	//-----------------------------------------------------------------------------
	void	EncodeBlock( quad i32Key, quad i32Input, quad* i32Output )	
	{	
		*(i32Output) = i32Input ^ i32Key;			
	}
	
	//-----------------------------------------------------------------------------
	void	DecodeBlock( quad i32Key, quad i32Input, quad* i32Output )	
	{	
		EncodeBlock( i32Key, i32Input, i32Output );	
	}
	
	//-----------------------------------------------------------------------------
	BOOL Encode(char* pszPlainText, quad unPlainTextLen, char* pszEncodedText, quad unEncodedTextLen )
	{
		 quad i32Key = 0xE234DD09;
	
		if ( FALSE == EncodeCore( i32Key, pszPlainText, unPlainTextLen, pszEncodedText, unEncodedTextLen ) )
		{
			return FALSE;
		}
	
		if ( FALSE == EncodeCore( 0x9ECA3DD0, pszEncodedText, unEncodedTextLen, pszEncodedText, unEncodedTextLen ) )
		{
			return FALSE;
		}
	
		return TRUE;
	}
	
	//-----------------------------------------------------------------------------
	BOOL Decode(char* pszEncodedText, quad unEncodedTextLen, char* pszPlainText, quad unPlainTextLen )
	{
		 quad i32Key = 0xE234DD09;
	
		if ( FALSE == DecodeCore( 0x9ECA3DD0, pszEncodedText, unEncodedTextLen, pszPlainText, unPlainTextLen ) )
		{
			return FALSE;
		}
	
		if ( FALSE == DecodeCore( i32Key, pszPlainText, unPlainTextLen, pszPlainText, unPlainTextLen ) )
		{
			return FALSE;
		}
	
		return TRUE;
	}
	
	//-----------------------------------------------------------------------------
	BOOL EncodeCore( quad i32Key, char* pszPlainText, quad unPlainTextLen, char* pszEncodedText, quad unEncodedTextLen )
	{
		quad unCurLocation = 0;
		if ( unPlainTextLen > unEncodedTextLen )
		{
			return FALSE;
		}
	
		// Encoded Length �� Plain Text Length ���� ũ�ų� ����
	
		// Encoded Text�� �־��� ���۸� ��� ä���� ��
		// Plain Text�� ������ ���̷� ������ �ʴ´ٴ� ���� ����
		while ( unCurLocation < unEncodedTextLen )
		{
			if ( unPlainTextLen - unCurLocation >= sizeof(i32Key) )
			{
				// ���� Plain Text�� ��ȣȭ �� �κ��� Key Size ���� ū ���
				// Key ��ü�� �̿��ؼ� ��ȣȭ
				EncodeBlock( i32Key, *(quad*)(pszPlainText + unCurLocation), (quad*)(pszEncodedText + unCurLocation) );
				unCurLocation += sizeof(i32Key);
			}
			else if ( unPlainTextLen > unCurLocation )
			{
				// ���� Plain Text�� ��ȣȭ �� �κ��� Key Size ���� ���� ���
				// Key �� 1byte �� ��ȸ�ϸ鼭 ��ȣȭ
				while ( unPlainTextLen > unCurLocation )
				{
					char cRemainInput	= *(pszPlainText + unCurLocation);
					char cRemainKey		= *(((char*)(&i32Key)) + (unCurLocation % sizeof(i32Key)));
	
					*(pszEncodedText + unCurLocation) = cRemainInput ^ cRemainKey;
					++unCurLocation;
				}
			}
			else if ( unEncodedTextLen - unCurLocation >= sizeof(i32Key) )
			{
				// Plain Text�� ��� ��ȣȭ �ϰ� ���� Output �κп� �� ä���ֱ�
				// ���� ũ�Ⱑ Key Size ���� ū ��� Key ��ü�� �̿��ؼ� ä���ֱ�
				EncodeBlock( i32Key, 0, (quad*)(pszEncodedText + unCurLocation) );
				unCurLocation += sizeof(i32Key);
			}
			else if ( unEncodedTextLen > unCurLocation )
			{
				// Plain Text�� ��� ��ȣȭ �ϰ� ���� Output �κп� �� ä���ֱ�
				// ���� ũ�Ⱑ Key Size ���� ���� ��� Key�� 1byte �� ��ȸ�ϸ鼭 ä���ֱ�
				while ( unEncodedTextLen > unCurLocation )
				{
					char cRemainKey = *(((char*)(&i32Key)) + (unCurLocation % sizeof(i32Key)));
	
					*(pszEncodedText + unCurLocation) = 0 ^ cRemainKey;
					++unCurLocation;
				}
			}
			else
			{
				// ������ �ɷ����� ���� ��Ȳ�� ���� �� ����
				return FALSE;
			}
		}
	
		return TRUE;
	}
	
	//-----------------------------------------------------------------------------
	BOOL DecodeCore( quad i32Key, char* pszEncodedText, quad unEncodedTextLen, char* pszPlainText, quad unPlainTextLen )
	{
		quad unCurLocation = 0;
		if ( unPlainTextLen > unEncodedTextLen )
		{
			return FALSE;
		}
	
		// Plain Text Length �� Encoded Length ���� �۰ų� ����
		
	
		while ( unCurLocation < unPlainTextLen )
		{
			if ( unPlainTextLen - unCurLocation >= sizeof(i32Key) )
			{
				// ���� Encoded Text�� Decode �� �κ��� Key Size ���� ū ���
				// Key ��ü�� �̿��ؼ� ��ȣȭ
				DecodeBlock( i32Key, *(quad*)(pszEncodedText + unCurLocation), (quad*)(pszPlainText + unCurLocation) );
				unCurLocation += sizeof(i32Key);
			}
			else
			{
				// ���� Encoded Text�� Decode �� �κ��� Key Size ���� ���� ���
				// Key �� 1byte �� ��ȸ�ϸ鼭 ��ȣȭ
				while ( unPlainTextLen > unCurLocation )
				{
					char cRemainInput	= *(pszEncodedText + unCurLocation);
					char cRemainKey		= *(((char*)(&i32Key)) + (unCurLocation % sizeof(i32Key)));
	
					*(pszPlainText + unCurLocation) = cRemainInput ^ cRemainKey;
					++unCurLocation;
				}
			}
		}
	
		return TRUE;
	}
	
	//----------------------------------------------------------------------------------
	// ��  �� : ��������� �����.
	// ��  �� : 
	// ���ϰ� : 1:�������� ��ſϷ�, 0: ��������or�������Ŀ���, -1: �˼����� ����
	//----------------------------------------------------------------------------------
	void* g_CreateJsonHead(void* pJson, char* szUrl ,long nservice, bool bClassName)
	{
	char szClassName[20];
	char szService[20];
	long len=0;
	char sztmp[10];
		
		Mem_Set( (byte*)szClassName, 0x00, sizeof(szClassName) );
		Mem_Set( (byte*)szService, 0x00, sizeof(szService) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		Str_ItoA(nservice , sztmp, 10);
		sztmp[1] = 0;
		
		SPRINT( szClassName, "FR%d_IN", nservice, 0,0 );
		SPRINT( szService  , "FR%d", nservice, 0,0 );
		SPRINT( stUserinfo.szworkcd  , "%s", sztmp, 0,0 );
		
		if( pJson != NULL)
		{
			JSON_Finalize( pJson );
			g_pjcomm = NULL;
		}
		
		pJson = JSON_Create( JSON_Object );
		if( bClassName )
		{
			JSON_SetValue			(pJson, 'C', "className", szClassName);
			JSON_SetValue			(pJson, 'C', "service",   szService);
		}
		JSON_SetValue			(pJson, 'C', "clientid",  stUserinfo.szpda_ip );
		JSON_SetValue			(pJson, 'C', "workcd",    stUserinfo.szworkcd);
		JSON_SetValue			(pJson, 'C', "appversion",stUserinfo.szappversion);
		JSON_SetValue			(pJson, 'C', "vmversion", stUserinfo.szver_num);
		JSON_SetValue			(pJson, 'C', "userid",    stUserinfo.szemployee_id);

		//Str_Cpy(szUrl, "http://10.20.12.124:8081/scgas-0.0.2-SNAPSHOT/services/neptune" );	//å�Ӵ� ���� ����
		//Str_Cpy(szUrl, "http://10.20.12.124:8081/scgas-0.0.1-SNAPSHOT/services/neptune" );		//å�Ӵ� ���� ����
		//Str_Cpy(szUrl, "http://127.0.0.1:8081/scgas-0.0.1-SNAPSHOT/services/neptune" );
		//Str_Cpy(szUrl, "https://smart.seoulgas.co.kr/scgas-0.0.1-SNAPSHOT/services/neptune" );
		//Str_Cpy(szUrl, "https://smart-test.seoulgas.co.kr/scgas-0.0.1-SNAPSHOT/services/neptune" );
		
		Str_Cpy(szUrl, GET_URL(WAS_BASE_URL) );
		
		return pJson;
	}
	
	//----------------------------------------------------------------------------------
	// ��  �� : ��������� �����.
	// ��  �� : 
	// ���ϰ� : 1:�������� ��ſϷ�, 0: ��������or�������Ŀ���, -1: �˼����� ����
	//----------------------------------------------------------------------------------
	void* g_CreateJsonHead_Login(void* pJson, char* szUrl, char* szid, long nservice, bool bClassName)
	{
	char szClassName[20];
	char szService[20];
	long len=0;
	char sztmp[10];
	
		Mem_Set( (byte*)szClassName, 0x00, sizeof(szClassName) );
		Mem_Set( (byte*)szService, 0x00, sizeof(szService) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		
		Str_ItoA(nservice , sztmp, 10);
		sztmp[1] = 0;
		
		SPRINT( szClassName, "FR%d_IN", nservice, 0,0 );
		SPRINT( szService  , "FR%d", nservice, 0,0 );
		SPRINT( stUserinfo.szworkcd  , "%s", sztmp, 0,0 );
		
		if( pJson != NULL)
		{
			JSON_Finalize( pJson );
			g_pjcomm = NULL;
		}
		
		pJson = JSON_Create( JSON_Object );
		if( bClassName )
		{
			JSON_SetValue			(pJson, 'C', "className", szClassName);
			JSON_SetValue			(pJson, 'C', "service",   szService);
		}
		JSON_SetValue			(pJson, 'C', "clientid",  stUserinfo.szpda_ip );
		JSON_SetValue			(pJson, 'C', "workcd",    stUserinfo.szworkcd);
		JSON_SetValue			(pJson, 'C', "appversion",stUserinfo.szappversion);
		JSON_SetValue			(pJson, 'C', "vmversion", stUserinfo.szver_num);
		JSON_SetValue			(pJson, 'C', "userid",    szid);

		//Str_Cpy(szUrl, "http://10.20.12.124:8081/scgas-0.0.2-SNAPSHOT/services/neptune" );	//å�Ӵ� ���� ����
		//Str_Cpy(szUrl, "http://10.20.12.124:8081/scgas-0.0.1-SNAPSHOT/services/neptune" );		//å�Ӵ� ���� ����
		//Str_Cpy(szUrl, "http://127.0.0.1:8081/scgas-0.0.1-SNAPSHOT/services/neptune" );
		//Str_Cpy(szUrl, "https://smart.seoulgas.co.kr/scgas-0.0.1-SNAPSHOT/services/neptune" );
		//Str_Cpy(szUrl, "https://smart-test.seoulgas.co.kr/scgas-0.0.1-SNAPSHOT/services/neptune" );
		
		Str_Cpy(szUrl, GET_URL(WAS_BASE_URL) );
		return pJson;
	}
	
	
	long g_StartSession(char* szSessionKey)
	{
	char szUrl[200];
	char szmag[600];
	char szUmag[600];
	char* sndbuf;
	char* pResBuf;
	char* code= NULL;
	char* session_key = NULL;
	char* szvalue;
	char szType[2] = {0,0};
	long ret = 0;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 512307, TRUE);
		JSON_SetValue( g_pjcomm, 'C', "session_flag",   "start" );
		JSON_SetValue( g_pjcomm, 'C', "session_key",    szSessionKey );
		JSON_SetValue( g_pjcomm, 'C', "work_id",        "" );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		pResBuf = Mem_Alloc(10000);
		Mem_Set((byte*)pResBuf, 0x00, 10000);
		HTTP_Url2Buf("POST", szUrl, sndbuf, pResBuf);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}
		
		JSON_toJson ( g_pjcomm, pResBuf);
		code = JSON_GetValue (g_pjcomm, "code",  szType);
		if(Str_Cmp(code, "0000") == 0)
		{
			session_key = JSON_GetValue (g_pjcomm, "url",  szType);
			Str_Cpy(szSessionKey, session_key);
			ret = 1;
		}
		else
		{
			Mem_Set((byte*)szmag, 0, sizeof(szmag) );
			Mem_Set((byte*)szUmag, 0, sizeof(szUmag) );
			szvalue = JSON_GetValue (g_pjcomm, "message",  szType);
			if(Str_Len(szvalue) < 500 )
			{
				SQL_ConvMbStr( szUmag, szvalue);				
				SPRINT(szmag, "%s", szUmag, 0, 0 );
				MessageBoxEx (CONFIRM_OK, szmag );
			}
			ret = -1;
		}
		
Finally:
	
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}	
		Mem_Free((byte*)pResBuf);
		
		return ret;
	}
	
	//----------------------------------------------------------------------------------
	// ��  �� : ������ ������ �˷� ���� ������ �Է��� �Ѵ�.
	// ��  �� : 
	// ���ϰ� : 
	//----------------------------------------------------------------------------------
	long g_EndSession(char* szSessionKey,char* szworkid)
	{
	char szUrl[200];
	char szcode[5];
	char szmag[600];
	char szUmag[600];
	char* szvalue;
	char* sndbuf;
	char* pResBuf;
	long ret = -1;
	char szType[2] = {0,0};
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 512307, TRUE);
		JSON_SetValue( g_pjcomm, 'C', "session_flag",   "end" );
		JSON_SetValue( g_pjcomm, 'C', "session_key",    szSessionKey );
		JSON_SetValue( g_pjcomm, 'C', "work_id",        szworkid );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		pResBuf = Mem_Alloc(10000);
		Mem_Set((byte*)pResBuf, 0x00, 10000);

		HTTP_Url2Buf("POST", szUrl, sndbuf, pResBuf);
	
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}	

		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}

		JSON_toJson ( g_pjcomm, pResBuf);
		szvalue = JSON_GetValue (g_pjcomm, "code",  szType);
		Str_Cpy(szcode, szvalue);
		szvalue = JSON_GetValue (g_pjcomm, "message",  szType);

		if(Str_Cmp(szcode, "0000") == 0 )
		{
			ret = 1;
		}
		else
		{
			Mem_Set((byte*)szmag, 0, sizeof(szmag) );
			Mem_Set((byte*)szUmag, 0, sizeof(szUmag) );
			if(Str_Len(szvalue) < 250 && Str_Len(szvalue) != 0 )
			{
				SQL_ConvMbStr( szUmag, szvalue);	
				SPRINT(szmag, "[%s] %s", szcode, szUmag, 0 );
				//SPRINT(szmag, "ERROR_OK [%s] %s", szcode, szvalue, 0 );
				MessageBoxEx (CONFIRM_OK, szmag );
			}
			else
			{
				Mem_Cpy((byte*)szmag, (byte*)szvalue, 200);			
				SQL_ConvMbStr( szUmag, szmag);	
				SPRINT(szmag, "[%s] %s", szcode, szUmag, 0 );
				//SPRINT(szmag, "WARNING_OK [%s] %s", szcode, szmag, 0 );

				//Mem_Set((byte*)szmag, 0, sizeof(szmag) );
				MessageBoxEx (CONFIRM_OK, szmag );
				
			}
			ret = -1;
		}
		
Finally:
	
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		Mem_Free((byte*)pResBuf);
		return ret;
	}
	
	//----------------------------------------------------------------------------------
	// ��  �� : ���� ��� ������ �����Ѵ�.
	// ��  �� : 
	// ���ϰ� : 1:�������� ��ſϷ�, 0: ��������or�������Ŀ���, -1: �˼����� ����
	//----------------------------------------------------------------------------------
	char szJsonpath[500];
	char szMsg[1000];
	
	long g_Chk_Json(long nservicenum)
	{
	char szBuf[64];
	long fd, i, j;
	long chkmsg = 0;
	long chkcode = 0;
	long fsize = 0;
	long count = 0;
	char *pStr;
	char *szcode;
	char *szmessage;
	char *szitem;
	char szType[2] = {0,0};
	long ret = 11;
	handle hitem = NULL;
	handle hcnt = NULL;
		
		MessageBox(MESSAGE, "�ڷ� Ȯ���� �Դϴ�.", 0, 0, 0, 0);
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, nservicenum, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, nservicenum, 0 );
		}

		SetMessageBoxText("10 % ó����...");
		
		fsize = FFS_GetSize(szJsonpath);

		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		
		pStr = Mem_Alloc(fsize);
		fd = FFS_Open(szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG);
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		SetMessageBoxText("20 % ó����...");
		
		count = (fsize-9) / 4;
		
		FFS_Read(fd, (byte*)pStr, fsize);
		for(i = 0, j = 30 ; i < fsize-9 ; i++ )
		{
			if (i % count == 0)
			{
				SPRINT(szBuf, "%d %% ó����...", j, 0, 0);
				SetMessageBoxText(szBuf);
				j += 10;
			}
		
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			
			if(chkmsg > 0 &&  chkcode > 0)
				break;
		}

		FFS_Close(fd);
		
		SetMessageBoxText("60 % ó����...");
		
		Mem_Free((byte*)pStr);
		if(chkmsg == 0 || chkcode == 0)
		{
			ret = -1;
			goto Finally;
		}
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		if(g_pjcomm == NULL)
		{
			ret = -1;
			goto Finally;
		}
	
		SetMessageBoxText("70 % ó����...");
		
		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			SetMessageBoxText("80 % ó����...");

			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
				char* pMsg = NULL;
				
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
				if(Str_Len(szmessage) < 1000 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				pMsg = g_Chk_Code(szJsonpath, szcode, szMsg);
				
				MessageBoxEx (WARNING_OK, pMsg);
				EvtDraw();
				
				//����(ī��) ���� -> OZ �� ���ο��� ����. 
				//if( nservicenum == 822566 )
				//{
				//	ret = 822566;
				//}
				//else
				//{
				//	ret = -1;
				//}
				
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem = JSON_GetValue(g_pjcomm, "item", szType);
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
				}
				
				//2017-05-27 Sanghyun Lee 
				//����༭ ��� ���� ī��, ���� ���� ���? ���� �� �ش� �޽��� ���.
				if( nservicenum == 822566 )
				{
					Mem_Set((byte*) szMsg, 0x00, sizeof( szMsg) );
					SQL_ConvMbStr( szMsg, szmessage);
					if( Str_Cmp(szMsg, "OK") != 0 )
					{
						MessageBoxEx (CONFIRM_OK, szMsg);
					}
				}
			}
		}
		else
		{
			ret = -1;
		}
		
Finally:		
		
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		SetMessageBoxText("100 % �Ϸ�.");
			
		EvtDraw();
		
		return ret;
	}

	//-----------------------------------------------------------------
	char* g_Chk_Code( char* pBuf, char* code, char* msg)
	{
		char* ptr = "Could not resolve host";
		long len = strlen(ptr);

		if( LMATCH(msg, ptr, len) )
		{
			SPRINT(pBuf, "[%s] ���ͳ� ���� ����.", code, 0, 0 );
		}
		else
		{
			SPRINT(pBuf, "[%s] %s", code, msg, 0 );
		}
		
		return pBuf;
	}
		
	//----------------------------------------------------------------------------------
	// ��  �� : Ppp �����Ѵ�.
	// ��  �� : Ppp_Connect �� �õ��Ѵ�. ù��° ���ڰ� TRUE �̸� �������� �����ش�.
	//	    �̹� ���ӵǾ� �ִ� ���� ���� �õ����� ����.
	// ���ϰ� : TRUE, FALSE
	//----------------------------------------------------------------------------------
	long	g_SeverConnection(void)
	{
		long ret;
	
		MessageBoxEx (MESSAGE, "��ȭ���� ���� ���Դϴ�.");
		/*
		if( theDevInfo.m_nType >= FAMILY_SMALL )
		{	
			PROGRESS_Start();
		}
		else
		{
			DRAW_PROGRESS (BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, Time_GetSecond()%10, DRAW_PROGRESS_TOT);
		}
		*/
		if( theDevInfo.m_nType < FAMILY_SMALL )
		{
			DRAW_PROGRESS (BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, Time_GetSecond()%10, DRAW_PROGRESS_TOT);
		}
		
		//chan 2004-07-13                                                                               
		//Ppp_Connect�Լ� ���ο��� Ppp_IsConnected�� üũ��
		//Ppp_IsConnected�� �ܺο��� üũ�ϰ� �Ǹ� ���� ���׷��̵尡
		//�������� �ʰԵȴ�.
		
		//SSL_SetEnable(TRUE);
		
		ret = Ppp_Connect();	// �����Ͽ��� ��� 0�� ����
		if ( ret )		// ������ ���� ������..
		{
			// dkjung 2003-08-20
			// TIME_SLEEP�� ���� �����̸� �ش�.
			VmSleep(TIME_SLEEP);
			MessageBoxEx (ERROR_OK, "��ſ����� ���� �ʽ��ϴ�.\n��ȭ�⸦ Ȯ���ϼ���!");
			return -1;
		}
		
		return 0;
	}
	
	//----------------------------------------------------------------------------------
	// ��  �� : Ppp ����� Socket ���� ��θ� ���´�.
	// ��  �� : �켱 Socket ������ ����, Ppp �� ����Ǿ� �ִ����� Ȯ���� �� Ppp ������ ���´�.
	// ���ϰ� : TRUE, FALSE
	//----------------------------------------------------------------------------------
	void	g_Sock_Close( void )
	{
	long	ret;
	long	i;

	//Sock_Close();
	
		/*
		if( theDevInfo.m_nType >= FAMILY_SMALL )
		{
			PROGRESS_Stop();
		}
		else
		{
			DRAW_PROGRESS (BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, DRAW_PROGRESS_TOT, DRAW_PROGRESS_TOT);
		}
		*/
		
		if( theDevInfo.m_nType < FAMILY_SMALL )
		{
			DRAW_PROGRESS (BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, DRAW_PROGRESS_TOT, DRAW_PROGRESS_TOT);
		}
		
		if ( Ppp_IsConnected() )
		{
			for(i = 0; i < 2; i++)
			{
				ret = Ppp_Disconnect();
	
				if(ret == 0)	// ���� ���⸦ �����ϸ�
					break;
					
				// dkjung 2003-08-20
				// TIME_SLEEP�� ���� �����̸� �ش�.
				VmSleep (TIME_SLEEP);
			}
		}
	}
	
	//----------------------------------------------------------------------------------
	// ��  �� : g_MOVE_DLG
	// ��  �� : ȭ�� ���� �̵�
	// ���ϰ� : 
	//----------------------------------------------------------------------------------
	void g_MOVE_DLG(long npos)
	{
		if(npos == 0)
		npos = 500;
		
		if( g_Dlgflag == 0)
		{
			Dialog_SetScroll( this->m_hDlg, 0, DMS_Y(npos) );
			g_Dlgflag = 1;
		}
		else
		{
			Dialog_SetScroll( this->m_hDlg, 0, 0 );
			g_Dlgflag = 0;
		}
	}

	//----------------------------------------------------------------------------------
	// ��  �� : g_SHOW_SIP
	// ��  �� : Ű���� â ����
	// ���ϰ� : 
	//----------------------------------------------------------------------------------
	void g_SHOW_SIP(void)
	{
		if( g_Sipflag == 0)
		{
			ShowSip(TRUE);
			g_Sipflag = 1;
		}
		else
		{
			ShowSip(FALSE);
			g_Sipflag = 0;
		}
	}

	//----------------------------------------------------------------------------------
	// ��  �� : g_EditCtrl_ShowEditInput
	// ��  �� : �ܺ� ����Ʈ ȣ�� �� Ű���带 �ڵ����� ȣ���ϵ��� �����ϴ� �Լ�
	// ���ϰ� : 
	//----------------------------------------------------------------------------------
	void g_EditCtrl_ShowEditInput(handle h, char* sztmp)
	{
		//õ���� Ű���� ���� �� FALSE ����
/*		
		if( g_nKeyMode == 1 )
		{
			SetKeyMode(KEYMODE_NUMBER);
			ShowSip(TRUE);
			g_Sipflag = 1;
						
			//ShowSip(FALSE);
			//g_Sipflag = 0;
		}
		else if( g_nKeyMode == 2 )
		{
			SetKeyMode(KEYMODE_ENGLISH);
			ShowSip(TRUE);
			g_Sipflag = 1;
						
			//ShowSip(FALSE);
			//g_Sipflag = 0;
		}
		else if( g_nKeyMode == 3)
		{
			SetKeyMode(KEYMODE_HANGUL);
			ShowSip(TRUE);
			g_Sipflag = 1;
						
			//ShowSip(FALSE);
			//g_Sipflag = 0;
		}
		EditCtrl_ShowEditInput( h, sztmp );
*/
		
		if( theDevInfo.m_nType > FAMILY_PDA )
		{
			EditCtrl_ShowEditInput( h, sztmp );
			ShowSip(TRUE);
		}
	}

	//----------------------------------------------------------------------------------
	// ��  �� : g_png_getwbmp
	// ��  �� : �������
	// ���ϰ� : 
	//----------------------------------------------------------------------------------
	long g_png_getbmp(long width, long height, byte* img )
	{
	bool flag = FALSE;
	long fd, ret=-1;
	byte b;
	long color;
	long ncolor;
	byte pixel[2];
	int i=0, j=0, k = 5;
	int headlen = 0;
    int size = 0;
    
	byte *  Singimg =NULL;
    byte * buf = NULL;
	byte* pucSignSrc= NULL;
	byte* pucSignDest= NULL;
	byte	BmpHeader[] =
{
	/* 
	typedef struct tagBITMAPFILEHEADER
	{
		WORD	bfType;	// ������ Ÿ���� ��Ÿ����.(��Ʈ���� ��쿡�� BM = 0x424d)
		DWORD	bfSize;	// ������ ũ�⸦ ��Ÿ����.
		WORD	bfReserved1;	// 0���� ����Ǿ� �ִ�.
		WORD	bfReserved2;	// 0���� ����Ǿ� �ִ�.
		DWORD	bfOffbits;		// BITMAPFILEHEADER �κ��� ���� ��Ʈ�� �����Ͱ� ��ġ�� ���� �������� ����ִ�.
	}BITMAPFILEHEADER
	*/
	0x42,0x4D,
	0x0E,0x08,0x00,0x00,
	0x00,0x00,
	0x00,0x00,
	0x3E,0x00,0x00,0x00,
	/*
	typedef struct tagBITMAPINFOHEADER
	{
		DWORD	biSize;	// BITMAPINFOHEADER �� ũ��
		LONG	biWidth;	// ��Ʈ���� ��
		LONG	biHeight;	// ��Ʈ���� ����
		WORD	biPlanes;	// �׻� 1
		WORD	biBitCount;	// 1, 4, 8, 24 ���� �ϳ�
		DWORD	biCompression;	// BI_RGB, BI_RLE4, BI_RLE8
		DWORD	biSizeImage;	// �̹��� ��ü�� ũ��
		LONG	biXPelsPerMeter;	// ��ǥ ����̽��� ���� 1m �� �ȼ���
		LONG	biYPelsPerMeter;	// ��ǥ ����̽��� ���� 1m �� �ȼ���
		DWORD	biClrUsed;	// �ȷ�Ʈ���� ������ ���̴� ������ ��, 0�̸� ��� �� ����
		DWORD	biClrImportant;	// �̹����� ǥ���Կ� �־ �߿��� ������ ��, 0�̸� �� �߿��ϴٴ� ���� �ǹ��Ѵ�.
	}BITMAPINFOHEADER
	*/
	0x28,0x00,0x00,0x00,
	0xA0,0x00,0x00,0x00,
	0x64,0x00,0x00,0x00,
	0x01,0x00,
	0x01,0x00,
	0x00,0x00,0x00,0x00,
	0x38,0x0E,0x00,0x00,
	0xC4,0x0E,0x00,0x00,
	0xC4,0x0E,0x00,0x00,
	0x00,0x00,0x00,0x00,
	0x00,0x00,0x00,0x00,
	/*
	typedef struct tagRGBQUAD
	{
		BYTE	 rgbBlue;
		BYTE	 rgbGreen;
		BYTE	 rgbRed;
		BYTE	 rgbReserved;
	}RGBQUAD
	// RGB ���̺��� ũ��� biBitCount �ʵ忡 ���� ���� - �� �ʵ��� ���� 2�� �������� ���� �ٷ� RGB ���̺��� ũ��
	*/
	0x00,
	0x00,
	0x00,
	0x00,
	0xFF,0xFF,0xFF,0x00,
};
/*
// RGBQUAD �� BITMAPINFOHEADER �� ���� ���� BITMAPINFO ��� ����ü ����
typedef struct tagBITMAPINFO
{
	BITMAPFILEHEADER	 bmiHeader;
	RGBQUAD	 bmiColors[1];
}BITMAPINFO
*/	
	
		if( theDevInfo.m_nType != FAMILY_PDA )
		{
			Singimg = GrDev_LoadPngImage(PNG_COLOR_NORMAL, "sign.png" );
			if(Singimg == NULL)
				return ret;
			if(width > 160 )
				k = 6;
				
			headlen = k;
			size = k + width * height / 8;
			buf = Mem_Alloc(size);
			ncolor = WHITE;
			b = 0xFF;
	
			for(j=0; j < height; j++)
	        {
		        for(i=0; i < width; i++)
		        {
	                if (i % 8 == 0)
	                {
	                    //�ʱ� ������ �����ϱ� ����.
	                    if (flag == TRUE)
	                    {
	                        buf[k++] = b;
	                        b = 0xFF;
	                    }
	
	                    flag = TRUE;
	                }
	                else
	                {
	                        b<<=1;                      
	                }
					//16��Ʈ ������ �÷����� �о�´�.
	                pixel[0] = (byte)Singimg[ headlen+i*2+j*width*2 ];
	                pixel[1] = (byte)Singimg[ headlen+i*2+j*width*2+1 ];
	                
	                color = BtoI ( pixel, 2 );              
	                if ( color == ncolor )
	                {
	                        //������� �����Ѵ�.
	                        b |= 0x01;
	                }
	                else
	                {
	                        //���������� �����Ѵ�.
	                        b &= 0xFE;
	                }
		        }
	        }
	        FREE(Singimg);
	
			buf[k++] = b;
			
			if(width == 160)
			{
				buf[0] = 0x00;
		        buf[1] = 0x00;
		        buf[2] = 0x81;
		        buf[3] = 0x20;
		        buf[4] = 0x64;
				
			}
			else if(width > 160)
			{
				buf[0] = 0x00;
		        buf[1] = 0x00;
		        buf[2] = 0x81;
		        buf[3] = 0x58;
		        buf[4] = 0x81;
		        buf[5] = 0x02;
			}
			else
			{
		        //��� �ۼ�
		        buf[0] = 0x00;
		        buf[1] = 0x00;
		        buf[2] = 0x81;
		        buf[3] = (byte)width/8;
		        buf[4] = (byte)height;
	        }
	        Mem_Cpy(img, buf, size);
			
	        fd = FFS_Open( "sign.wbmp", FS_WRITE_MODE, FS_CREATE_FLAG);
	        if( fd == -1)
	        {
	        	free(buf);
	        	return ret;
	        }
	
	        FFS_Write(fd, (byte*)buf, size);
	    	FFS_Flush(fd);
			FFS_Close(fd);
			
			free(buf);
		}
		
		Mem_Set(g_ucSignDest, 0x00, sizeof(g_ucSignDest));
		Mem_Set(g_ucSignSrc, 0x00, sizeof(g_ucSignSrc));

		Mem_Cpy(g_ucSignDest, BmpHeader, sizeof(BmpHeader));
		pucSignDest = g_ucSignDest + sizeof(BmpHeader) + (SIGN_BYTES_PER_LINE) * SIGN_HEIGHT;
		Mem_Cpy(g_ucSignSrc, img + SIGN_HEADER, WBMP_SIZE - SIGN_HEADER);
		pucSignSrc = g_ucSignSrc;

		for(i = 1; i <= SIGN_HEIGHT; i++)
		{
			pucSignDest -= (SIGN_BYTES_PER_LINE);
			Mem_Cpy(pucSignDest, pucSignSrc, SIGN_BYTES_PER_LINE);
			pucSignSrc += SIGN_BYTES_PER_LINE;
		}
		/*
		fd = FFS_Open( "sign.bmp", FS_WRITE_MODE, FS_CREATE_FLAG);
        if( fd == -1)
        {
        	free(buf);
        	return ret;
        }
        FFS_Write(fd, (byte*)g_ucSignDest, BMP_SIZE );
    	FFS_Flush(fd);
		FFS_Close(fd);
		*/
		Mem_Cpy(img, g_ucSignDest, BMP_SIZE);
		
	    ret = 1;       
	    return ret;
	}
	
	void g_PhtoBase64(char* szpath, handle* Base64, char* pRst)
	{
	handle g_Base64 = NULL;
	long size = 0;
	byte* pimg = NULL;
	byte* pBase = NULL;
	long fd,fd1;
	long ret;
	
	
		size = FFS_GetSize(szpath);
		if(Base64 != NULL )
		{
			BASE64_Finalize(Base64);
			Base64 = NULL;
		}
		
		Base64 = BASE64_Create();
		if(  Base64 == NULL )
		{
			goto Finally;
		}
	
		pimg = Mem_Alloc (size);
		if(pimg == NULL)
		{
			goto Finally;
		}
		
		fd = FFS_Open ( szpath, FS_READ_MODE, FS_NORMAL_FLAG );
		if(fd == -1)
		{
			goto Finally;
		}

		FFS_Read(fd, pimg, size);
		FFS_Close(fd);
					
		ret = BASE64_Encode(Base64, pimg, size);
		pRst = BASE64_GetResult(Base64);
		
//		pBase, Str_Len((char*)pBase)
		//������Ȯ�������ؼ� ���߿� ���ƾ���.
		//fd1= FFS_Open ( "BASE64_Encode.txt", FS_WRITE_MODE , FS_CREATE_FLAG );
		//FFS_Write(fd1, (byte*)pRst, Str_Len(pRst) );
		//FFS_Close(fd1);
Finally:	
		if(pimg != NULL)
		{
			Mem_Free(pimg);
			pimg = NULL;
		}
	}
	
	//---------------------------------------------------------------
	// ���ۿ� �ִ� �����͸� ���̸�ŭ long������ ��ȯ
	long BtoI (byte* pBuf, long length)
	{
		long i;
		long nVal;
		
		nVal = 0;
		for( i=0; i<length; i++ )
		{ 
			nVal <<= 8;
			nVal |= pBuf[i];
		}
		
		return nVal;
	}
	
	//---------------------------------------------------------------
	//edit ���ڼ� üũ
	long g_GetUtf8Size(char* str)
	{
		long nSize = 0;
		long nLen = 0;
		long i;
		
		nLen = Str_Len(str);
		
		for(i=0; i < nLen; )
		{
			if ( (str[i] & 0x80) && (str[i+1] & 0x80) )
			{
				nSize += 3;
				i += 2;
			}
			else
			{
				nSize++;
				i++;
			}
		}
		return nSize;
	}
	
	
//---------------------------------------------------------------
/*
//������ ������ ���� ���� �� ��θ����
#define DIR_DBF		"APP_DBF"    //������ DB ����
#define DIR_BACKDBF "APP_BACKDB" //��� ���DB ���� ����
#define UP_BACKDBF  "DBF_BAK"    //VM ���׷��̵�� DB��� ����
#define PHOTO_SC	"PHOTO_SC"   //�������˻�������
#define PHOTO_JO	"PHOTO_JO"   //�������������
#define PHOTO_BS	"PHOTO_BS"   //Ư������ ��������
#define PHOTO_BF	"PHOTO_BF"   //�������������� ��������
#define PHOTO_MW	"PHOTO_MW"   //�ο� ��������
#define PHOTO_GC	"PHOTO_GC"   //�跮�ⱳü ��������
#define PHOTO_NP	"PHOTO_NP"   //ü�� ��������
*/
//���������� DB�� ��������� ����
	void g_Db_Backup(void)
	{
		char szPath[50];
		char szBackPath[50];
	
		Mem_Set( (byte*)szPath, 0x00, sizeof(szPath) );
		Mem_Set( (byte*)szBackPath, 0x00, sizeof(szBackPath) );
		//�������� DB
		SPRINT (szPath, "%s/SCGGAS.db",  DIR_DBF, 0, 0);
		
		//������� DB
		SPRINT (szBackPath, "%s/SCGGAS.db",  DIR_BACKDBF, 0, 0);
	
		if( FFS_Exist(szPath) )
		{
			FFS_Copy(szPath, szBackPath);
		}
	}
	
//---------------------------------------------------------------
//����ص� DB�� ���������� DB�� �ٲ�
//��� ����.
	void g_Db_Restore(void) 
	{
		char szPath[50];
		char szBackPath[50];
		char szUpgradeBakPath[50];
	
		Mem_Set( (byte*)szPath, 0x00, sizeof(szPath) );
		Mem_Set( (byte*)szBackPath, 0x00, sizeof(szBackPath) );
		Mem_Set( (byte*)szUpgradeBakPath, 0x00, sizeof(szUpgradeBakPath) );
		//�������� DB
		SPRINT (szPath, "%s/SCGGAS.db",  DIR_DBF, 0, 0);
		//������� DB
		SPRINT (szBackPath, "%s/SCGGAS.db",  DIR_BACKDBF, 0, 0);
		//VM ���׷��̵�� ����ص� DB
		SPRINT (szUpgradeBakPath, "%s/SCGGAS.db",  UP_BACKDBF, 0, 0);
	
	
		if( FFS_Exist(szUpgradeBakPath) )
		{
			//VM���׷��̵带 �ߴٸ� ���׷��̵� �� backup�ص� DB���Ϸ� ���������� DB�� ����.
			FFS_Copy(szUpgradeBakPath, szPath);
		}
		else
		{
			//����ص� DB�� ���������� DB�� ����.
			if( FFS_Exist(szBackPath) )
			{
				FFS_Copy(szBackPath, szPath);
			}
		}
	}
	
	
	/*=======================================================================================
	�Լ��� : g_DirFS_Clear
	��  �� : ������ ���丮���� pszFilter�� �˻��� ���ϵ��� ��� �����Ѵ�.
	Parameter : pszDir : ���丮
			  : pszFilter : ã������
	Return    :  0 : ����
				-1 : ����
	========================================================================================*/
	long g_DirFS_Clear (char* pszDir, char* pszFilter)
	{
		long	fh;
		char	szPath[256];
		char	szTemp[256];
		char	szFileName[256] = {""};
		
		if (pszDir[0] == '\0')
		{
			Str_Cpy (szPath, pszFilter);
		}
		else
		{
			SPRINT(szPath, "%s\\%s", (quad)pszDir+((pszDir[0]=='\\')?1:0), (quad)pszFilter, 0);
			// pszDir+((pszDir[0]=='\\')?1:0)�� pszDir[1] ���� ���� pszDir[0] ���͸� ���Ѵ�.
		}
		
		fh = FFS_FindFirst(szPath, szFileName);
		if (fh < 0 )
		{
			return 0;
		}

		// ������ �ϳ��� ���� ���.
		if (szFileName[0] == '\0')
		{
			FFS_FindClose(fh);
			return 0;
		}

		do
		{
			if (pszDir[0] != '\0')
			{
				SPRINT(szTemp, "%s\\%s", (quad)pszDir+((pszDir[0]=='\\')?1:0), (quad)szFileName, 0);
			}
			else
				Str_Cpy (szTemp, szFileName);
			
			//��¥���������������Ѵ�
			FFS_Delete( szTemp );

			
		} while (FFS_FindNext(fh, szFileName));
		FFS_FindClose(fh);
		
	
		return 0;
	}
	
	
	//-----------------------------------------------------------------------------
	//�Լ���: Line_Print
	//��  ��:
	//Param :
	//Return:
	//-----------------------------------------------------------------------------
	void g_Line_Print( void* p, char* sztmp1, char* sztmp2, char* sztmp3, long Style, long pos )
	{
		byte szPline[97];
		byte szPline1[33];
		byte szPline2[65];
		long lineLen1=0;
		long lineLen2=0;
		long lineLen3=0;
		char sztmp[100];
		long n_tmp1;
		long n_tmp2;
		char LineSpace[]={0x1b,0x20,0x00};
		
		CARRAYLIST list = (CARRAYLIST)p;

		if (list == NULL)
		{
			return;
		}
		
		lineLen1 = Str_Len(sztmp1);

		if(Str_Len(sztmp2) > 32-lineLen1 )
		{

			Mem_Set( szPline,  0x20, sizeof(szPline) );
			lineLen3 = Str_Len(sztmp2);

			//�ѱ��� ��� �ٿ� ������ ��µǴ� �� ���ƾ� �Ѵ�.
			for(lineLen2=0;lineLen2 < 32-lineLen1;)
			{
				if ( sztmp2[lineLen2] & 0x80 )	//�ѱ�
					lineLen2+=2;			//2����
				else
					lineLen2++;
			}
			
			//�����Ǹ��������ڰ� �ѱ��ΰ��
			if ( lineLen2 == ( 32 + 1 - lineLen1) )	//�ѱ��� ������ ���
				lineLen2 = 32 - 1 - lineLen1;	//�ѱ� ����
			
			//�Ѷ��γѾ��������	
			Mem_Set((byte*)sztmp,  0x00, sizeof(sztmp) );
			if( lineLen3-lineLen2 > 0 )
			{
				Mem_Cpy((byte*)sztmp, (byte*)sztmp2+lineLen2, lineLen3-lineLen2);
			}
			n_tmp1 = 0;
			
			//�����������Ѷ����� �Ѿ�� ���
			if( Str_Len(sztmp) > 32)
			{
				for(n_tmp1=0;n_tmp1 < 32;)
				{
					if ( sztmp[n_tmp1] & 0x80 )	//�ѱ�
						n_tmp1+=2;			//2����
					else
						n_tmp1++;
				}
				if ( n_tmp1 == ( 32 + 1) )	//�ѱ��� ������ ���
					n_tmp1 = 32 - 1 ;	//�ѱ� ����
				
				if( lineLen1 > 0 )
				{
					Mem_Cpy((byte*)szPline, (byte*)sztmp1, lineLen1); //ù��°��
				}
		
				if( lineLen2 > 0 )
				{
					Mem_Cpy((byte*)szPline+lineLen1, (byte*)sztmp2, lineLen2); //1+2��������
				}
		
				if( n_tmp1 > 0 )
				{
					Mem_Cpy((byte*)szPline+32, (byte*)sztmp, n_tmp1); //�ι�°��
				}
		
				if( Str_Len(sztmp)-n_tmp1 > 0 )
				{
					Mem_Cpy((byte*)szPline+64, (byte*)sztmp+n_tmp1, Str_Len(sztmp)-n_tmp1); //����°��
				}
				szPline[96] = 0;
				list->append(list, (char*)szPline);

				//PRINT("global g_Line_Print step 1 szPline:[%s]", szPline, 0, 0);
			}
			else
			{
				//PRINT("global g_Line_Print step 2 start", 0, 0, 0);
				
				Mem_Set( szPline2,  0x20, sizeof(szPline2) );
				if( lineLen1 > 0 )
				{
					Mem_Cpy((byte*)szPline2, (byte*)sztmp1, lineLen1);
				}
			
				if( lineLen2 > 0 )
				{
					Mem_Cpy((byte*)szPline2+lineLen1, (byte*)sztmp2, lineLen2);
				}
			
				if( lineLen3-lineLen2 > 0 )
				{
					Mem_Cpy((byte*)szPline2+32, (byte*)sztmp2+lineLen2, lineLen3-lineLen2);
				}
				szPline2[64] = 0;
				list->append(list, (char*)szPline2);

				//PRINT("global g_Line_Print step 2 szPline2:[%s]", szPline2, 0, 0);
			}
		}
		else
		{
		
			//PRINT("global g_Line_Print step 3 start", 0, 0, 0);
			
			Mem_Set( szPline1 ,  0x20, sizeof(szPline1) );
			lineLen1 = Str_Len(sztmp1);
			lineLen2 = Str_Len(sztmp2);
			lineLen3 = Str_Len(sztmp3);
		
			switch ( Style )
			{
			case LEFT :
				if( lineLen1 > 0 )
				{
					Mem_Cpy( (byte*)szPline1 ,           (byte*)sztmp1 , lineLen1 );
				}
				
				if( lineLen2 > 0 )
				{
					Mem_Cpy( (byte*)szPline1+lineLen1 ,  (byte*)sztmp2 , lineLen2 );
				}
				
				if( lineLen3 > 0 )
				{
					Mem_Cpy( (byte*)szPline1+lineLen1+lineLen2 , (byte*)sztmp3 , lineLen3 );
				}
				break;
			case RIGHT :
				if( lineLen1 > 0 )
				{
					Mem_Cpy( (byte*)szPline1 , (byte*)sztmp1 , lineLen1 );
				}
				
				if( lineLen3 > 0 )
				{
					Mem_Cpy((byte*)szPline1+32-lineLen3, (byte*)sztmp3 , lineLen3 );
				}
				break;
			case CENTER :
				if( lineLen1 > 0 )
				{
					Mem_Cpy( (byte*)szPline1 ,            (byte*)sztmp1 , lineLen1 );
				}
				
				if( lineLen2 > 0 )
				{
					Mem_Cpy((byte*)szPline1+pos-lineLen2, (byte*)sztmp2 , lineLen2 );
				}
				
				if( lineLen3 > 0 )
				{
					Mem_Cpy((byte*)szPline1+32-lineLen3,  (byte*)sztmp3 , lineLen3 );
				}
				break;
			}

			szPline1[32] = 0;
			//BT_Control_Command(LineSpace, 3);
			list->append(list, (char*)szPline1);
			
			//PRINT("global g_Line_Print step 3 szPline1:[%s]", szPline1, 0, 0);
		}
	}

	//-----------------------------------------------------------------------------
	void Line_Print( char* sztmp1, char* sztmp2, char* sztmp3, long Style, long pos)
	{
	byte szPline[97];
	byte szPline1[33];
	byte szPline2[65];
	long lineLen1=0;
	long lineLen2=0;
	long lineLen3=0;
	char sztmp[100];
	long n_tmp1;
	long n_tmp2;
	char LineSpace[]={0x1b,0x20,0x00};
		
		lineLen1 = Str_Len(sztmp1);

		if(Str_Len(sztmp2) > 32-lineLen1 )
		{
			Mem_Set( szPline,  0x20, sizeof(szPline) );
			lineLen3 = Str_Len(sztmp2);

			//�ѱ��� ��� �ٿ� ������ ��µǴ� �� ���ƾ� �Ѵ�.
			for(lineLen2=0;lineLen2 < 32-lineLen1;)
			{
				if ( sztmp2[lineLen2] & 0x80 )	//�ѱ�
					lineLen2+=2;			//2����
				else
					lineLen2++;
			}
			
			//�����Ǹ��������ڰ� �ѱ��ΰ��
			if ( lineLen2 == ( 32 + 1 - lineLen1) )	//�ѱ��� ������ ���
				lineLen2 = 32 - 1 - lineLen1;	//�ѱ� ����
			
			//�Ѷ��γѾ��������	
			Mem_Set((byte*)sztmp,  0x00, sizeof(sztmp) );
			Mem_Cpy((byte*)sztmp, (byte*)sztmp2+lineLen2, lineLen3-lineLen2);
			n_tmp1 = 0;
			
			//�����������Ѷ����� �Ѿ�� ���
			if( Str_Len(sztmp) > 32)
			{
				for(n_tmp1=0;n_tmp1 < 32;)
				{
					if ( sztmp[n_tmp1] & 0x80 )	//�ѱ�
						n_tmp1+=2;			//2����
					else
						n_tmp1++;
				}
				if ( n_tmp1 == ( 32 + 1) )	//�ѱ��� ������ ���
					n_tmp1 = 32 - 1 ;	//�ѱ� ����
				
				
				Mem_Cpy((byte*)szPline, (byte*)sztmp1, lineLen1); //ù��°��
				Mem_Cpy((byte*)szPline+lineLen1, (byte*)sztmp2, lineLen2); //1+2��������
				Mem_Cpy((byte*)szPline+32, (byte*)sztmp, n_tmp1); //�ι�°��
				Mem_Cpy((byte*)szPline+64, (byte*)sztmp+n_tmp1, Str_Len(sztmp)-n_tmp1); //����°��
				szPline[96] = 0;
				BT_Save_Spool( (char*)szPline, 0, 0);
			}
			else
			{
				Mem_Set( szPline2,  0x20, sizeof(szPline) );
				Mem_Cpy((byte*)szPline2, (byte*)sztmp1, lineLen1);
				Mem_Cpy((byte*)szPline2+lineLen1, (byte*)sztmp2, lineLen2);
				Mem_Cpy((byte*)szPline2+32, (byte*)sztmp2+lineLen2, lineLen3-lineLen2);
				szPline2[64] = 0;
				BT_Save_Spool( (char*)szPline2, 0, 0);
			}
		}
		else
		{
			Mem_Set( szPline1 ,  0x20, sizeof(szPline1) );
			lineLen1 = Str_Len(sztmp1);
			lineLen2 = Str_Len(sztmp2);
			lineLen3 = Str_Len(sztmp3);
		
			switch ( Style )
			{
			case LEFT :
				Mem_Cpy( (byte*)szPline1 ,           (byte*)sztmp1 , lineLen1 );
				Mem_Cpy( (byte*)szPline1+lineLen1 ,  (byte*)sztmp2 , lineLen2 );
				Mem_Cpy( (byte*)szPline1+lineLen1+lineLen2 , (byte*)sztmp3 , lineLen3 );
				break;
			case RIGHT :
				Mem_Cpy( (byte*)szPline1 , (byte*)sztmp1 , lineLen1 );
				Mem_Cpy((byte*)szPline1+32-lineLen3, (byte*)sztmp3 , lineLen3 );
				break;
			case CENTER :
				Mem_Cpy( (byte*)szPline1 ,            (byte*)sztmp1 , lineLen1 );
				Mem_Cpy((byte*)szPline1+pos-lineLen2, (byte*)sztmp2 , lineLen2 );
				Mem_Cpy((byte*)szPline1+32-lineLen3,  (byte*)sztmp3 , lineLen3 );
				break;
			}

			szPline1[32] = 0;
			BT_Control_Command(LineSpace, 3);
			BT_Save_Spool( (char*)szPline1, 0, 0);
		}
	}

	//---------------------------------------------------------------
	void g_EvtSessionCallback (long wParam)
	{
		PRINT("g_EvtSessionCallback = %d", wParam,0,0);
		
		if( wParam == SESSION_OPEN )
		{
			//MessageBoxEx(MESSAGE, "������ ����� �Դϴ�.");
			MessageBoxEx(PROGRESS_LOADING, "������ ����� �Դϴ�.");
			
			PROGRESS_SetCallbackFlag(1);
		
			if( theDevInfo.m_nType < FAMILY_SMALL )
				DRAW_PROGRESS (BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, Time_GetSecond()%10, DRAW_PROGRESS_TOT);
		}
		else if( wParam == SESSION_PATCH_OPEN )
		{
			MessageBox(MESSAGE, "���� ���׷��̵� ���Դϴ�.", 0, 0, 0, 0);
			if( theDevInfo.m_nType < FAMILY_SMALL )
				DRAW_PROGRESS (BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, Time_GetSecond()%10, DRAW_PROGRESS_TOT);
			//else
			//	PROGRESS_Start();
		}
		else if( wParam == SESSION_PATCH_CLOSE )
		{
			//MessageBox(MESSAGE, "���� ��ġ�� �����մϴ�.", 0, 0, 0, 0);
			//if( theDevInfo.m_nType >= FAMILY_SMALL )
			//	PROGRESS_Stop();
			
			g_Sock_Close();
			
			MessageBoxEx (CONFIRM_OK, "���� ���׷��̵尡 �Ϸ�Ǿ����ϴ�.\n���α׷��� �ٽ� ���� ���ּ���.");
			
			if( g_Upgrade_flag == 1  )
			{
				//2017-07-18 Sanghyun Lee
				//���׷��̵� ���� �� �ش� DB ��� ��ġ?!
			
				EvtExit();
				g_ImgFree();
				VM_AmEnd();
			}
		}
		else
		{
			MessageBoxEx(MESSAGE, "�ڷ� ������ �Դϴ�.");
			g_EndSessionCallback(wParam);
		}
	}
	
	//---------------------------------------------------------------
	void g_EndSessionCallback (long wParam)
	{
		if(g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm =NULL;			
		}
		
		if( callBackfunc != NULL)
		{
			callBackfunc();
		}
		
		EvtDraw();
	}
	
	//-----------------------------------------------------------------------------
	void g_OnTimer (long nTimerId)
	{
		if (g_nPrinterTimerID == nTimerId)
		{
			//������ Ÿ�̸�.
			Timer_Kill( nTimerId );
			g_nPrinterTimerID = -1;
			//CloseMessageBox();
			//EvtDraw();
			
			if (printerCallBack != NULL)
			{
				long nRet = PRINTER_TIMEOUT;
				
				printerCallBack( &nRet );
			}
			
		}
	}
	
	//-----------------------------------------------------------------------------
	void g_OnUart (long nType, long nData)
	{
		if (nType == UART_PRINTER)
		{
			if (g_printerCallBack != NULL)
			{
				//EvtDraw() �޼��� �ڽ� ���� �߰�
				EvtSession	(SESSION_CLOSE);
				g_printerCallBack(g_pList);
			}
		}
	}
		
	//-----------------------------------------------------------------------------
	void g_OnTask (long nType, long nData)
	{
		char* ptr;
		long nRet = 0;
		char szBuf[32];
		
		//SPRINT(szBuf, "g_OnTask(nType=0x%x, nData=0x%x)",nType,nData,0);
		//MessageBoxEx(PUSH_OK, szBuf);
		//ptr = (char*)System_GetResult((char*)&nRet);
		//PRINT(">>>>>>>>>>>>>>EvtTask PUSH nType : %d , nData : %d ",nType,nData,0);
		
		if (nType == TASK_PUSH)
		{
			//PUSH �̺�Ʈ
			ptr = (char*)System_GetResult((char*)&nRet);
			MessageBoxEx(PUSH_OK, ptr);
		}
		else if(nType == TASK_SYS_CALL)
		{
			//�ý�����
			//ptr = (char*)System_GetResult((char*)&nRet);
			//MessageBoxEx (CONFIRM_OK, ptr);
			//PRINT("TASK_SYS_CALL:: System_GetResult = %s, size = %d ", ptr, nRet, 0);
		}
		else if(nType == TASK_PUSH_CONFIG)
		{
			//PUSH CONFIG
			//ptr = (char*)System_GetResult((char*)&nRet);
			//MessageBoxEx (CONFIRM_OK, ptr);
			//PRINT("TASK_PUSH_CONFIG:: System_GetResult = %s, size = %d , Msg : %s", ptr, nRet, ptr);
		}
		else if(nType == TASK_PUSH_APPEXIT)
		{
			Toast (5000, "���� ����Ǿ����ϴ�.\n���α׷��� �����մϴ�");
			//���� ���� ȣ�� �� ���α׷� ����
			EvtExit();
			g_ImgFree();
			VM_AmEnd();
		}
		else if(nType == TASK_PUSH_LOCK)
		{
			Toast (5000, "�������\n���α׷��� �����մϴ�");
			
			g_Sql_DirectExecute("UPDATE USER_INFO SET LOCK_YN = 'Y'");
			
			VmSleep(100);
			
			//��� db ���� �� �������� db ����.
			if(  FFS_Exist("DBF_BAK/SCGGAS.db") )
			{
				FFS_Delete("DBF_BAK/SCGGAS.db");
			}

			if(  FFS_Exist("APP_BACKDB/SCGGAS.db") )
			{
				FFS_Delete("APP_BACKDB/SCGGAS.db");
			}
			
			if(  FFS_Exist("APP_DBF/SCGGAS.db") )
			{
				FFS_Copy("APP_DBF/SCGGAS.db", "DBF_BAK/SCGGAS.db");
				FFS_Copy("APP_DBF/SCGGAS.db", "APP_BACKDB/SCGGAS.db");
			}

			EvtExit();
			g_ImgFree();
			VM_AmEnd();
		}
		else if(nType == TASK_PUSH_UNLOCK)
		{
			Toast (5000, "�����������\n���α׷��� �����մϴ�");
			
			g_Sql_DirectExecute("UPDATE USER_INFO SET LOCK_YN = 'N'");
			
			//��� db ���� �� �������� db ����.
			if(  FFS_Exist("DBF_BAK/SCGGAS.db") )
			{
				FFS_Delete("DBF_BAK/SCGGAS.db");
			}

			if(  FFS_Exist("APP_BACKDB/SCGGAS.db") )
			{
				FFS_Delete("APP_BACKDB/SCGGAS.db");
			}
			
			//���� ���� �� INIT_DBF�� �ִ� ���� DB�� �ٲ��ش�.
			VmSleep(100);
			
			if(  FFS_Exist("APP_DBF/SCGGAS.db") )
			{
				FFS_Copy("APP_DBF/SCGGAS.db", "DBF_BAK/SCGGAS.db");
				FFS_Copy("APP_DBF/SCGGAS.db", "APP_BACKDB/SCGGAS.db");
			}

			EvtExit();
			g_ImgFree();
			VM_AmEnd();
		}
		else if(nType == TASK_PUSH_RESET)
		{
//������ ������ ���� ���� �� ��θ����
//#define DIR_DBF		"APP_DBF"    //������ DB ����
//#define DIR_BACKDBF "APP_BACKDB" //��� ���DB ���� ����
//#define UP_BACKDBF  "DBF_BAK"    //VM ���׷��̵�� DB��� ����
//----DB ����

			MessageBoxEx (MESSAGE, "���ݸ���\n���α׷��� �����մϴ�");
			
			if(  FFS_Exist("APP_DBF/SCGGAS.db") )
			{
				FFS_Delete("APP_DBF/SCGGAS.db");
			}

			if(  FFS_Exist("DBF_BAK/SCGGAS.db") )
			{
				FFS_Delete("DBF_BAK/SCGGAS.db");
			}

			if(  FFS_Exist("APP_BACKDB/SCGGAS.db") )
			{
				FFS_Delete("APP_BACKDB/SCGGAS.db");
			}
			
			//����&OZ ���� ����
			g_DirFS_Clear(DIR_DBF	  , "*");
			g_DirFS_Clear(DIR_BACKDBF , "*");
			g_DirFS_Clear(UP_BACKDBF  , "*");
			g_DirFS_Clear(PHOTO_GM    , "*");
			g_DirFS_Clear(PHOTO_SC	  , "*");
			g_DirFS_Clear(PHOTO_SCMTR , "*");
			g_DirFS_Clear(PHOTO_SCBUR , "*");
			g_DirFS_Clear(PHOTO_SCBOIL, "*");
			g_DirFS_Clear(PHOTO_SCBAR , "*");
			g_DirFS_Clear(PHOTO_SCREFUSE, "*");
			g_DirFS_Clear(PHOTO_SCABSENCE, "*");
			g_DirFS_Clear(PHOTO_JO	  , "*");
			g_DirFS_Clear(PHOTO_BS	  , "*");
			g_DirFS_Clear(PHOTO_BF	  , "*");
			g_DirFS_Clear(PHOTO_MW	  , "*");
			g_DirFS_Clear(PHOTO_GC	  , "*");
			g_DirFS_Clear(PHOTO_NP	  , "*");
			g_DirFS_Clear(PHOTO_BIZ   , "*");
			g_DirFS_Clear(PHOTO_WORK  , "*");
			g_DirFS_Clear(OZ_FILE	  , "*");
			g_DirFS_Clear(LC_OZ_FILE  , "*");
			g_DirFS_Clear(PHOTO_GMMTR , "*");
			g_DirFS_Clear(PHOTO_GMCOMPENS , "*");
			
			//���� ���� �� INIT_DBF�� �ִ� ���� DB�� �ٲ��ش�.
			VmSleep(100);
			
			if(  FFS_Exist("INIT_DBF/SCGGAS.db") )
			{
				FFS_Copy("INIT_DBF/SCGGAS.db", "APP_DBF/SCGGAS.db");
			}
			
			CloseMessageBox();
			EvtExit();
			g_ImgFree();
			VM_AmEnd();
		}
	}
	
	//------------------------------------------------------------------
	char* g_Printer_GetLastError(long code)
	{
		char* ptr = "";
		
		switch(code)
		{
			case PRINTER_OK:
				ptr = "������ ��� �Ϸ�.";
				break;
			case PRINTER_TIMEOUT:
				ptr = "������ ���� ����.";
				break;
			case PRINTER_NODATA:
				ptr = "������ ��� ������ ����.";
				break;
		}
	
		return ptr;
	}	
	
	//------------------------------------------------------------------
	long g_Printer_Start(void* p, void* result)
	{
		//1. ������ ���� ��û
		//EvtDraw() �޼��� �ڽ� ���� �÷��� ����
		EvtSession	(SESSION_OPEN);
		MessageBoxEx (MESSAGE, "������ ��� �غ����Դϴ�.");
		EvtDraw();
		
		BT_Init_Printer(g_szPrintPort, 57600, 1);
		
		//2. ������ ���� ��, ȣ��� �ݹ鼳��
		g_pList = p;
		g_printerCallBack = g_Printer_Process;
		
		//3. ����� ���� �ݹ� ����
		g_SetPrinterCallBack((PrinterCallBack)result);
		
		if (g_nPrinterTimerID >= 0)
		{
			Timer_Kill(g_nPrinterTimerID);
			g_nPrinterTimerID = -1;
		}
				
		//4. �޽��� �ڽ� Ÿ�̸� ����
		g_nPrinterTimerID = Timer_Set(7000, 0);
		
		//PDA �� ����Ʈ���� �����ؼ� �����ؾ� �Ѵ�.
		if( theDevInfo.m_nType == FAMILY_PDA )
		{
		}
		return 0;
	}
	
	//------------------------------------------------------------------
	long g_Printer_Process(void* p)
	{
		CARRAYLIST list = (CARRAYLIST)p;
		long nRet = PRINTER_OK;
		long size = 0;
		long i;
		char* ptr = NULL;
		
		MessageBoxEx (MESSAGE, "������ ��� �� �Դϴ�.");
		EvtDraw();
		
		Timer_Kill(g_nPrinterTimerID);
		g_nPrinterTimerID = -1;

		if (list != NULL)
		{
			size = list->size(list);
			for (i=0; i<size; i++)
			{
				ptr = list->getStr(list, i);
				BT_Save_Spool(ptr, 0, 0);
			}
				
			BT_Print_Spool(TRUE);
			VmSleep(200);
			
			BT_Clear_Spool();
			BT_Close_Printer();
	
			//CloseMessageBox();
			//EvtDraw();
		}
		else
		{
			nRet = PRINTER_NODATA;
		}
		
		if (printerCallBack != NULL)
		{
			printerCallBack( &nRet );
		}
		
		return 0;
	}
	
	//----------------------------------------------------------------------
	//�Լ���: g_SetOzComboData
	//��  ��: 
	//Param : 
	//Return: ����༭ �޺��� ������ ������ ��Ʈ��
	//----------------------------------------------------------------------
	char* g_SetOzComboData(SQLITE sql, char* szWhere, char* szComboData, long convFlag)
	{			
		//bool ret = FALSE;
		bool sret = FALSE;
		handle hstmt = NULL;	
		char szBuf[256];
		char szRet[256];
		char szSql[300];
		long i = 0;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, " SELECT CASE WHEN CODE_ID = 'A10140' THEN REPLACE(ITEM_KNAME, '@', '') WHEN CODE_ID = 'C61998' OR CODE_ID = 'C61999' THEN SUBSTR(ITEM_KNAME, 6) ELSE ITEM_KNAME END ITEM_KNAME FROM COMMONCODE WHERE %s", szWhere,  0, 0 );
		//PRINT("g_SetOzComboData szSql:[%s]", szSql, 0, 0);
		hstmt = sql->CreateStatement( sql, szSql );
		
		if( hstmt == NULL )
		{
			PRINT("::g_SetOzComboData SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
	
		sret = sql->Execute(sql);	
		if(sret == FALSE)
		{
			PRINT("::g_SetOzComboData sql->Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
	
		Mem_Set( (byte*)szComboData, 0x00, sizeof(szComboData) );

		while( sql->Next(sql) == TRUE )
		{
			Mem_Set( (byte*)szBuf, 0x00, sizeof(szBuf) );
			sql->GetValue( sql, 0, 'U', (long*)szBuf, sizeof(szBuf), DECRYPT );
			//PRINT("C6101_WINFO SetOzComboData ITEM_KNAME:[%s]", szBuf, 0, 0);
			
			if(i > 0)
			{
				Str_Cat(szComboData, ",");
			}
			Mem_Set( (byte*)szRet, 0x00, sizeof(szRet) );
			if (convFlag == 1) 
			{
				SQL_ConvMbStr( szRet, szBuf);
				Str_Cat(szComboData, szRet);
			}
			else
			{
				Str_Cat(szComboData, szBuf);
			}
				
			i++;
		}
		
		//SQL_ConvMbStr( szComboData, szRet);
			
		//PRINT("global SetOzComboData Len:[%d], szComboData:[%s]", Str_Len(szComboData), szComboData, 0);
					
Finally:		
		sql->DeleteStatement(sql);
		
		return szComboData;
	}
	
	//----------------------------------------------------------------------
	//�Լ���: g_CheckPhoneNumber
	//��  ��: �޴���/������ȭ ���� üũ
	//Param : type(1:�޴���/2:������ȭ), szDDD(����), szEXN (����), szNUM (��ȭ��ȣ ���� 4�ڸ�)
	//Return: boolean(����(true)  / ���� ���̽��� �ش�(false))
	//----------------------------------------------------------------------
	bool g_CheckPhoneNumber(char* type, char* szDDD, char* szEXN, char* szNUM)
	{
		char phoneNum[20];
		
		Mem_Set( (byte*)phoneNum, 0x00, sizeof(phoneNum) );
		
		Str_Cpy(phoneNum, szDDD);
		Str_Cat(phoneNum, szEXN);
		Str_Cat(phoneNum, szNUM);
		
		if( Str_Len(phoneNum) == 0 )
		{
			return TRUE;
		}
		
		if( Str_Len(phoneNum) > 0 && Str_Len(phoneNum) < 9 )
		{
			return FALSE;
		}
		
		if( Str_Cmp(type, "1") == 0)
		{
			if( Str_Len(szDDD) < 3 )
			{
				return FALSE;
			}
		}
		else
		{
			if( Str_Len(szDDD) < 2 )
			{
				return FALSE;
			}
		}
		
		if( Str_Len(szEXN) < 3 )
		{
			return FALSE;
		}
		
		if( Str_Len(szNUM) < 4 )
		{
			return FALSE;
		}
		
		if( !g_CheckPhoneNumberFormat(szEXN, szNUM) )
		{
			return FALSE;
		}
		
		return TRUE;
	}
	//----------------------------------------------------------------------
	//�Լ���: g_CheckPhoneNumberFormat
	//��  ��: �޴���/������ȭ ���Է� ��ȣ üũ
	//			1) 2��° ���� = "0000" or 3��° ��ȣ = "0000"
	//			2) 2��° ���� + 3��° ��ȣ = "11111111" ~ "99999999" (���ϼ��� ����)
	//Param : szEXN (����), szNUM (��ȭ��ȣ ���� 4�ڸ�)
	//Return: boolean(����(true)  / ���� ���̽��� �ش�(false))
	//----------------------------------------------------------------------
	bool g_CheckPhoneNumberFormat(char* szEXN, char* szNUM)
	{
		char phoneNum[8+1];
		char firstNum[1+1];
		char subPhoneNum[1+1];
		int i;
		
		if( Str_Cmp(szEXN, "000") == 0 || Str_Cmp(szEXN,"0000") == 0 )
		{
			return FALSE;
		}
		
		if( Str_Cmp(szNUM, "000") == 0 )
		{
			return FALSE;
		}
		
		Mem_Set( (byte*)phoneNum, 0x00, sizeof(phoneNum) );
		Str_Cpy(phoneNum, szEXN);
		Str_Cat(phoneNum, szNUM);
		
		if( Str_Len(phoneNum) < 7 )
		{
			return FALSE;
		}
		
		Mem_Set( (byte*)firstNum, 0x00, sizeof(firstNum) );
		Mem_Cpy((byte *)firstNum, (byte *)phoneNum,1);

		for(i = 0 ; i< Str_Len(phoneNum) ; i++)
		{
			Mem_Set( (byte*)subPhoneNum, 0x00, sizeof(subPhoneNum) );
			Mem_Cpy((byte *)subPhoneNum, (byte *)phoneNum + i, 1);
			
			if( Str_Cmp(firstNum, subPhoneNum) != 0 )
			{
				
				return TRUE;
			}
		}
		
		return FALSE;
	}
	
	long g_Save_Assign_690(void)
	{
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		long ret = 0, idx;
	
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = -1;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "UPDATE C6101_PROMISE_ASSIGN SET \
CHK_TIME_FROM=?,CHK_TIME_END=?,BUILT_IN_YN= ?,CONT_STS_CD= ? \
,AUTO_YN= ?,PRICE_YN= ?,BUR_YN = ?,PROD_YN= ?,ONCE_YN= ?,MTR_CHG_YN = ? \
,ACCOUNT= ?,ONCE_ACCOUNT = ?,ADJ_ALT_AMT= ? \
,APPRO_NUM = ?,ADJ_CAUSE = ?,CARD_GASPAY = ?,CARD_ONEPAY = ?,CASH_GASPAY = ? \
,TRANS_CONN_YN = ?,CONN_YN= ?,BAR_YN= ?,BAR_GBN= ?,BAR_WHY= ?,CHK_YN= ?,CONN_GBN= ? \
,Gmtr_base_day=?,Deadline_flag=?,Memo=?,Email=?\
,Ownhouse_tel_ddd=?,Ownhouse_tel_exn=?,Ownhouse_tel_num=?\
,Cust_nm=?,Soc_num=?,Cp_ddd=?,Cp_exn=?,Cp_num=?,Firm_nm=?\
,Cust_trnd_cd=?,Square_meter=?,Info_use_agree_yn=?,Appro_num=?,BIZ_REGI_NUM=?\
,SEND_YN='S' \
WHERE PROMISE_ASSIGN_SEQ = ? " );

		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stMw.szChk_time_from         ,16 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szChk_time_end          ,16 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBuilt_in_yn           ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCont_sts_cd           ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAuto_yn               ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szPrice_yn              ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBur_yn                ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szProd_yn               ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOnce_yn               ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szMtr_chg_yn            ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAccount               ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOnce_account          ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAdj_alt_amt           ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAppro_num             ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAdj_cause             ,2  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCard_gaspay           ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCard_onepay           ,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCash_gaspay           ,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szTrans_conn_yn     ,1  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szConn_yn           ,1  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBar_yn            ,1  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBar_gbn           ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBar_why           ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szChk_yn            ,1  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szConn_gbn          ,2  +1 ,DECRYPT);

		sql->Bind(sql, idx++, 'U', (long *)stMw.szGmtr_base_day      ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szDeadline_flag      ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szMemo               ,500+1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szEmail              ,50 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOwnhouse_tel_ddd   ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOwnhouse_tel_exn   ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szOwnhouse_tel_num   ,4  +1 ,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCust_nm            ,50 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szSoc_num            ,13 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCp_ddd             ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCp_exn             ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCp_num             ,4  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szFirm_nm            ,50 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szCust_trnd_cd       ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szSquare_meter       ,5  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szInfo_use_agree_yn  ,2  +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szAppro_num          ,10 +1 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stMw.szBiz_regi_num       ,10 +1 ,DECRYPT);
				
		sql->Bind(sql, idx++, 'U', (long *)g_szCHK_EXEC_NUM             ,10 ,DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s] ", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}
		ret = 1;
		
Finally	:
		
		//sql->Commit(sql);
		DelSqLite(sql);
		return ret;
	}
	
	long g_Load_Assign_690(char* assign_seq)
	{
	long i;
	long ret = 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stMw, 0x00, sizeof(stMw));

		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			ret = -1;
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,"SELECT PROMISE_ASSIGN_SEQ, REG_FLAG,BRANCH_CD,CENTER_CD,ASSIGN_EMPID \
,CUST_NUM,USE_CONT_NUM,INST_PLACE_NUM,ZIP_SEQ,ETC_ADDR \
,CIVIL_SERV_CLASS_CD,PROMISE_YMD,PROMISE_TIME,END_EXPECT_TIME,JOB_STR_DTM \
,JOB_END_DTM,PROMISE_ASSIGN_DESC,CIVIL_SERV_RECEIVE_NUM,TREAT_SEQ,PROC_STS_CD \
,PDA_NUM,ONCE_PAY,SEND_YN,CIVIL_SERV_CLASS_NM,PDA_DUTY \
,REQ_TEL_DDD,REQ_TEL_EXN,REQ_TEL_NUM,REQ_CP_DDD,REQ_CP_EXN,REQ_CP_NUM \
,TRANS_IN_CUST_NM,TRANS_IN_SOC_NUM,REQ_NM,REQ_SOC_NUM,RECEIVE_DTM,CUST_TYPE_CD \
,CUST_NM,FIRM_NM,SOC_NUM,BIZ_REGI_NUM,CP_DDD,CP_EXN \
,CP_NUM,OWNHOUSE_TEL_DDD,OWNHOUSE_TEL_EXN,OWNHOUSE_TEL_NUM,FIRM_TEL_DDD \
,FIRM_TEL_EXN,FIRM_TEL_NUM,SCG_RELAT_CD,EMAIL,FAMILY_CNT \
,CUST_TRND_CD,CHK,BUILT_IN_YN,SQUARE_METER,CURR_ADDR_UNION \
,BLD_FLOOR,HOUSE_CNT,PDA_DUTY_FLAG,PAY_CALU,PDA_TRANS_FLAG \
,REQ_INFO_NUM,TRANS_IN_CUST_NUM,CONT_STS_CD,PDA_READ_DTM,MEMO \
,AUTO_YN,CUST_YN,BUR_YN,PROD_YN,ONCE_YN \
,PRICE_YN,ZIP_NO1,ZIP_NO2,CITY,COUNTY \
,TOWN,VILLAGE_RI,VILLAGE,BUILDING,ADDR1_M \
,ADDR1_S,ACCOUNT,ONCE_ACCOUNT,CHK_TIME_FROM \
,CHK_TIME_END,MTR_CHG_YN,INFO_USE_AGREE_YN,PAS_USE_CONT_NUM_YN,ADJ_ALT_AMT \
,PAS_DEFRAY_ACCOUNT_NUM,PAS_CUST_NUM,PAS_REQ_INFO_NUM,APPRO_NUM,APPRO_TEL,ADJ_CAUSE \
,DEADLINE_FLAG,GMTR_BASE_DAY,CARD_GASPAY,CARD_ONEPAY,CASH_GASPAY \
,INFO_USE_YN,USE_CONT_DOC_YN,PAY_METHOD,DEFRAY_ACCOUNT_NUM,DEPOSITOR_NM \
,BANK_NM,DEBT_AMT,LAW_ETC_AMT,LAW_TOWN,NEW_ROAD_NM \
,NEW_ADDR_M,NEW_ADDR_S,NEW_ADDR_UNION,BILL_GUBUN,TRANS_CONN_YN \
,CONN_YN,BAR_YN,BAR_GBN,BAR_WHY,CHK_YN,CONN_GBN \
FROM C6101_PROMISE_ASSIGN WHERE PROMISE_ASSIGN_SEQ = ? AND SEND_YN='S' ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}

		i = 0;
		
		sql->Bind(sql, i++, 'U', (long*)assign_seq , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = -1;
			goto Finally;
		}

		while(sql->Next(sql) )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_assign_seq    ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReg_flag              ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBranch_cd             ,6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCenter_cd             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAssign_empid          ,9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_num              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szUse_cont_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInst_place_num        ,9  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szZip_seq               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEtc_addr              ,100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCivil_serv_class_cd   ,6  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_ymd           ,8  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_time          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEnd_expect_time       ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szJob_str_dtm           ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szJob_end_dtm           ,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPromise_assign_desc   ,500+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCivil_serv_receive_num,14 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTreat_seq             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szProc_sts_cd           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_num               ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOnce_pay              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSend_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCivil_serv_class_nm   ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_duty              ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_tel_ddd           ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_tel_exn           ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_tel_num           ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_ddd            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_exn            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_cp_num            ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_in_cust_nm      ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_in_soc_num      ,13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_nm                ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_soc_num           ,13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReceive_dtm           ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_type_cd          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_nm               ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_nm               ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSoc_num               ,13 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBiz_regi_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_ddd                ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_exn                ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCp_num                ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_ddd      ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_exn      ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOwnhouse_tel_num      ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_tel_ddd          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_tel_exn          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFirm_tel_num          ,4  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szScg_relat_cd          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szEmail                 ,50 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szFamily_cnt            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_trnd_cd          ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk                   ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBuilt_in_yn           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szSquare_meter          ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCurr_addr_union       ,100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBld_floor             ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szHouse_cnt             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_duty_flag         ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPay_calu              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_trans_flag        ,5  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szReq_info_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_in_cust_num     ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCont_sts_cd           ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPda_read_dtm          ,15 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szMemo                  ,500+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAuto_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCust_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBur_yn                ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szProd_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOnce_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPrice_yn              ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szZip_no1               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szZip_no2               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCity                  ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCounty                ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTown                  ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szVillage_ri            ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szVillage               ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBuilding              ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAddr1_m               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAddr1_s               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAccount               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szOnce_account          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk_time_from         ,16 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk_time_end          ,16 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szMtr_chg_yn            ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInfo_use_agree_yn     ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_use_cont_num_yn   ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAdj_alt_amt           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_defray_account_num,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_cust_num          ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPas_req_info_num      ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAppro_num             ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAppro_tel             ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szAdj_cause             ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDeadline_flag         ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szGmtr_base_day         ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCard_gaspay           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCard_onepay           ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szCash_gaspay           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szInfo_use_yn           ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szUse_cont_doc_yn       ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szPay_method            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDefray_account_num    ,20 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDepositor_nm          ,16 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBank_nm               ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szDebt_amt              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szLaw_etc_amt           ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szLaw_town              ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_road_nm           ,30 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_addr_m            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_addr_s            ,10 +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szNew_addr_union        ,100+1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBill_gubun            ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szTrans_conn_yn         ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szConn_yn               ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBar_yn                ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBar_gbn               ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szBar_why               ,2  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szChk_yn                ,1  +1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*)stMw.szConn_gbn              ,2  +1, DECRYPT );
			
			ret = 1;
		}
		
Finally:
		DelSqLite(sql);
		
		return ret;
	}
	
	long g_Add_Bo_690(handle pj)
	{
	long ret = -1;
	long idx = 0;
	handle hdb = NULL;
	handle hstmt = NULL;
	char szUcovert[100];
	SQLITE sql = NewSqLite();
	handle js = NULL;
	MWBURINFO stBur;
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, "SELECT  mtr_num,burner_num,burner_class_cd,burner_kind_num, trim(burner_model_cd) \
,burner_capa,burner_capa_unit,burner_inst_ymd,burner_remov_ymd,burner_model_nm \
,maker_nm,boiler_form,maker_num,make_num,make_ymd,inst_flag \
,inst_loc,boiler_inst_firm_cd \
 FROM C6101_PROMISE_BUR WHERE PROMISE_ASSIGN_SEQ= ? AND SUBSTR(BURNER_NUM,1,1) = '1' AND SEND_YN = 'S' ");
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
					
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)&stBur, 0x00, sizeof(stBur) );
			idx = 0;
      		sql->GetValue(sql, idx++, 'U', (long*)stBur.szMtr_num             ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_num          ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_class_cd     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_kind_num     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_model_cd     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_capa         ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_capa_unit    ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_inst_ymd     ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_remov_ymd    ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_model_nm     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMaker_nm            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBoiler_form         ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMaker_num            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMake_num            ,30+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMake_ymd            ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInst_flag           ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInst_loc            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBoiler_inst_firm_cd ,20+1, DECRYPT);
				
			JSON_AddArrayItem(js);
				
			JSON_SetArrayItem(js, 'C',  "mtr_num"            , stBur.szMtr_num             );
			JSON_SetArrayItem(js, 'C',  "burner_num"         , stBur.szBurner_num          );
			JSON_SetArrayItem(js, 'C',  "burner_class_cd"    , stBur.szBurner_class_cd     );
			JSON_SetArrayItem(js, 'C',  "burner_kind_num"    , stBur.szBurner_kind_num     );
			JSON_SetArrayItem(js, 'C',  "burner_model_cd"    , stBur.szBurner_model_cd     );
			JSON_SetArrayItem(js, 'C',  "burner_capa"        , stBur.szBurner_capa         );
			JSON_SetArrayItem(js, 'C',  "burner_capa_unit"   , stBur.szBurner_capa_unit    );
			JSON_SetArrayItem(js, 'C',  "burner_inst_ymd"    , stBur.szBurner_inst_ymd     );
			JSON_SetArrayItem(js, 'C',  "burner_remov_ymd"   , stBur.szBurner_remov_ymd    );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szBurner_model_nm );
			JSON_SetArrayItem(js, 'C',  "burner_model_nm"    , szUcovert                   );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMaker_nm );
			JSON_SetArrayItem(js, 'C',  "maker_nm"           , szUcovert                   );
			JSON_SetArrayItem(js, 'C',  "boiler_form"        , stBur.szBoiler_form         );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMaker_num );			
			JSON_SetArrayItem(js, 'C',  "maker_num"           , szUcovert                   );
			
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMake_num );			
			JSON_SetArrayItem(js, 'C',  "make_num"           , szUcovert                   );
			
			JSON_SetArrayItem(js, 'C',  "make_ymd"           , stBur.szMake_ymd            );
			JSON_SetArrayItem(js, 'C',  "inst_flag"          , stBur.szInst_flag           );
			JSON_SetArrayItem(js, 'C',  "inst_loc"           , stBur.szInst_loc            );
			JSON_SetArrayItem(js, 'C',  "boiler_inst_firm_cd", stBur.szBoiler_inst_firm_cd );
			
			ret =1;
		}
		
		if( ret == 1 )
			JSON_Attach(pj, "bo", js);
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		//sql->Commit(sql);
		DelSqLite(sql);

		return ret;
	}
	
	long g_Add_Bur_690(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		char szUcovert[100];
		SQLITE sql = NewSqLite();
		handle js = NULL;
		MWBURINFO stBur;
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement(sql, " SELECT mtr_num,burner_num,burner_class_cd,burner_kind_num,trim(burner_model_cd) \
,burner_capa,burner_capa_unit,burner_inst_ymd,burner_remov_ymd,burner_model_nm \
,maker_nm,boiler_form,maker_num,make_num,make_ymd,inst_flag \
,inst_loc,boiler_inst_firm_cd \
 FROM C6101_PROMISE_BUR WHERE PROMISE_ASSIGN_SEQ=? AND SUBSTR(BURNER_NUM,1,1) <> '1' AND SEND_YN = 'S' ");
 
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);
				
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)&stBur, 0x00, sizeof(stBur) );
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMtr_num             ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_num          ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_class_cd     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_kind_num     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_model_cd     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_capa         ,10+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_capa_unit    ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_inst_ymd     ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_remov_ymd    ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBurner_model_nm     ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMaker_nm            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBoiler_form         ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMaker_num            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMake_num            ,30+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szMake_ymd            ,8 +1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInst_flag           ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szInst_loc            ,20+1, DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)stBur.szBoiler_inst_firm_cd ,20+1, DECRYPT);
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C',  "mtr_num"            , stBur.szMtr_num             );
			JSON_SetArrayItem(js, 'C',  "burner_num"         , stBur.szBurner_num          );
			JSON_SetArrayItem(js, 'C',  "burner_class_cd"    , stBur.szBurner_class_cd     );
			JSON_SetArrayItem(js, 'C',  "burner_kind_num"    , stBur.szBurner_kind_num     );
			JSON_SetArrayItem(js, 'C',  "burner_model_cd"    , stBur.szBurner_model_cd     );
			JSON_SetArrayItem(js, 'C',  "burner_capa"        , stBur.szBurner_capa         );
			JSON_SetArrayItem(js, 'C',  "burner_capa_unit"   , stBur.szBurner_capa_unit    );
			JSON_SetArrayItem(js, 'C',  "burner_inst_ymd"    , stBur.szBurner_inst_ymd     );
			JSON_SetArrayItem(js, 'C',  "burner_remov_ymd"   , stBur.szBurner_remov_ymd    );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szBurner_model_nm );
			JSON_SetArrayItem(js, 'C',  "burner_model_nm"    , szUcovert                   );
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMaker_nm );
			JSON_SetArrayItem(js, 'C',  "maker_nm"           , szUcovert                   );
			JSON_SetArrayItem(js, 'C',  "boiler_form"        , stBur.szBoiler_form         );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMaker_num );
			JSON_SetArrayItem(js, 'C',  "maker_num"           , szUcovert            );
			
			Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
			SQL_ConvUcStr( szUcovert, stBur.szMake_num );
			JSON_SetArrayItem(js, 'C',  "make_num"           , szUcovert            );
			
			JSON_SetArrayItem(js, 'C',  "make_ymd"           , stBur.szMake_ymd            );
			JSON_SetArrayItem(js, 'C',  "inst_flag"          , stBur.szInst_flag           );
			JSON_SetArrayItem(js, 'C',  "inst_loc"           , stBur.szInst_loc            );
			JSON_SetArrayItem(js, 'C',  "boiler_inst_firm_cd", stBur.szBoiler_inst_firm_cd );
			
			ret =1;
		}
		
		if(ret == 1)
			JSON_Attach(pj, "bur", js);
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		//sql->Commit(sql);
		DelSqLite(sql);

		return ret;
	}
	
	
	long g_Add_Once_690(handle pj)
	{
		long ret = -1;
		long idx = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		handle js = NULL;
		
		char szcivil_serv_receive_num[14+1]; //
		char sztreat_seq             [2 +1]; //
		char szuse_cont_num          [10+1]; //
		char szonce_item_cd          [6 +1]; //
		char szcenter_cd             [2 +1]; //
		char szstr_apply_ymd         [8 +1]; //
		char szonce_unit_prc         [12+1]; //
		char szonce_qty              [5 +1]; //
		char szonce_amt              [12+1]; //
		char szexcept_yn             [1 +1]; //
		char szpay_promise_yn        [1 +1]; //
		char szbuilt_in_yn           [1 +1]; //
		
		js = JSON_Create(JSON_Array);
		if( js == NULL  )
		{
			goto Finally;
		}
		
		hdb = sql->Open(sql);
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql, "SELECT CIVIL_SERV_RECEIVE_NUM, TREAT_SEQ, USE_CONT_NUM, ONCE_ITEM_CD, CENTER_CD \
										        , STR_APPLY_YMD, ONCE_UNIT_PRC, ONCE_QTY, ONCE_AMT, EXCEPT_YN, PAY_PROMISE_YN, BUILT_IN_YN \
										     FROM C6101_ONCE_INFO WHERE PROMISE_ASSIGN_SEQ = ? AND SEND_YN = 'S' AND ONCE_QTY > 0 ");
 
 
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long*)stMw.szPromise_assign_seq , 10, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
					
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szcivil_serv_receive_num, 0x00, sizeof(szcivil_serv_receive_num) );
			Mem_Set( (byte*)sztreat_seq             , 0x00, sizeof(sztreat_seq             ) );
			Mem_Set( (byte*)szuse_cont_num          , 0x00, sizeof(szuse_cont_num          ) );
			Mem_Set( (byte*)szonce_item_cd          , 0x00, sizeof(szonce_item_cd          ) );
			Mem_Set( (byte*)szcenter_cd             , 0x00, sizeof(szcenter_cd             ) );
			Mem_Set( (byte*)szstr_apply_ymd         , 0x00, sizeof(szstr_apply_ymd         ) );
			Mem_Set( (byte*)szonce_unit_prc         , 0x00, sizeof(szonce_unit_prc         ) );
			Mem_Set( (byte*)szonce_qty              , 0x00, sizeof(szonce_qty              ) );
			Mem_Set( (byte*)szonce_amt              , 0x00, sizeof(szonce_amt              ) );
			Mem_Set( (byte*)szexcept_yn             , 0x00, sizeof(szexcept_yn             ) );
			Mem_Set( (byte*)szpay_promise_yn        , 0x00, sizeof(szpay_promise_yn        ) );
			Mem_Set( (byte*)szbuilt_in_yn           , 0x00, sizeof(szbuilt_in_yn           ) );
			
			idx = 0;
			sql->GetValue(sql, idx++, 'U', (long*)szcivil_serv_receive_num,14+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)sztreat_seq             ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szuse_cont_num          ,10+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_item_cd          ,6 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szcenter_cd             ,2 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szstr_apply_ymd         ,8 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_unit_prc         ,12+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_qty              ,5 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szonce_amt              ,12+1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szexcept_yn             ,1 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szpay_promise_yn        ,1 +1 , DECRYPT);
			sql->GetValue(sql, idx++, 'U', (long*)szbuilt_in_yn           ,1 +1 , DECRYPT);
				
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "civil_serv_receive_num" , szcivil_serv_receive_num );
			JSON_SetArrayItem(js, 'C', "treat_seq"              , sztreat_seq              );
			JSON_SetArrayItem(js, 'C', "use_cont_num"           , szuse_cont_num           );
			JSON_SetArrayItem(js, 'C', "once_item_cd"           , szonce_item_cd           );
			JSON_SetArrayItem(js, 'C', "center_cd"              , szcenter_cd              );
			JSON_SetArrayItem(js, 'C', "str_apply_ymd"          , szstr_apply_ymd          );
			JSON_SetArrayItem(js, 'C', "once_unit_prc"          , szonce_unit_prc          );
			JSON_SetArrayItem(js, 'C', "once_qty"               , szonce_qty               );
			JSON_SetArrayItem(js, 'C', "once_amt"               , szonce_amt               );
			JSON_SetArrayItem(js, 'C', "built_in_yn"            , stMw.szBuilt_in_yn       );

			if(stMw.szAuto_yn[0] == 'Y')
			{
				JSON_SetArrayItem(js, 'C', "pay_promise_yn"         , "Y"          );
			}
			else
			{
				JSON_SetArrayItem(js, 'C', "pay_promise_yn"         , szpay_promise_yn );
			}
			
			if( Str_AtoI(szonce_qty ) > 0 && Str_Cmp(szonce_item_cd, "F00001") == 0 && stMw.szAuto_yn[0] == 'Y' )
			{
				JSON_SetArrayItem(js, 'C', "except_yn"              , "Y"              );
			}
			else
			{
				JSON_SetArrayItem(js, 'C', "except_yn"              , szexcept_yn              );
			}

			ret =1;
		}
		
		if(ret == 1)
			JSON_Attach(pj, "one", js);
		
Finally:
		if(js != NULL)
		{
			JSON_Finalize(js);
			js = NULL;
		}
		//sql->Commit(sql);
		DelSqLite(sql);

		return ret;
	}
	
	// flag 0 : validation ����, 1: validation ����
	void g_Snd_RstMin_690(long flag)
	{
		char szUrl[200];
		char szbuf[128];
		char sztmp[128];
		char szSql[200];
		char szScrPht[128];
		char szUcovert[1000];
		char* sndbuf;
		long ret = 0;
		long i, idx, fd, once_qty;
		byte* signimg = NULL;
		char* szfile =  NULL;
		long filesize = 0;
		handle file;
		
		if( flag == 1 )
		{
			/**** Validate ****/
			// 0. ���ڵ�
			if( (Str_Len(stMw.szBar_why) == 0 && Str_Len(stMw.szBar_yn) == 0) ||
				(Str_Len(stMw.szBar_why) == 0 && Str_Cmp(stMw.szBar_yn, "N") == 0) )
			{
				MessageBoxEx (ERROR_OK, "���ڵ� �����ϼ���.");
				Card_Move("C6101_WBUR");
				return;
			}
			// 1. ��ȸ��
			once_qty = 0;
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT SUM(ONCE_QTY) FROM C6101_ONCE_INFO WHERE PROMISE_ASSIGN_SEQ = '%s' ", g_szCHK_EXEC_NUM, 0, 0   );
			g_Sql_RetInt( szSql, &once_qty );
			
			if( once_qty == 0 )
			{
				MessageBoxEx (ERROR_OK, "��ȸ�� �׸��� �����ϼ���.");
				Card_Move("C6101_WONE");
				return;
				
			}
			else if( once_qty > 1  )
			{
				MessageBoxEx (ERROR_OK, "��ȸ�� �Ϲ��ڵ�� �����ڵ�� �ߺ� ���þȵ˴ϴ�. �ٽ� ����ϼ���.");
				Card_Move("C6101_WONE");
				return;
			}
			
			// 2. ��ӹ��� ����
			if( g_Save_Assign_690() < 0 )
				return;	
		}

		// 3. ��ӹ��� �ҷ�����
		if( g_Load_Assign_690(g_szCHK_EXEC_NUM)  < 0) // �ο���������� ����´�.
			return;

		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		

		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 68902, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "center_cd"             , stUserinfo.szcenter_cd     );		
		JSON_SetValue( g_pjcomm, 'C', "promise_assign_seq"    , stMw.szPromise_assign_seq     );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_receive_num", stMw.szCivil_serv_receive_num );
		JSON_SetValue( g_pjcomm, 'C', "treat_seq"             , stMw.szTreat_seq              );
		JSON_SetValue( g_pjcomm, 'C', "branch_cd"             , stMw.szBranch_cd              );
		JSON_SetValue( g_pjcomm, 'C', "civil_serv_class_cd"   , stMw.szCivil_serv_class_cd    );
		JSON_SetValue( g_pjcomm, 'C', "pda_duty_flag"         , stMw.szPda_duty_flag          );
		//����� ����.
		JSON_SetValue( g_pjcomm, 'C', "req_info_num"          , stMw.szReq_info_num         );
		//JSON_SetValue( g_pjcomm, 'C', "req_info_num"          , ""           );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num"          , stMw.szUse_cont_num           );
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num"        , stMw.szInst_place_num         );
		JSON_SetValue( g_pjcomm, 'C', "account"               , stMw.szAccount                );
		JSON_SetValue( g_pjcomm, 'C', "adj_alt_amt"           , stMw.szAdj_alt_amt            );
		JSON_SetValue( g_pjcomm, 'C', "chk_time_from"         , stMw.szChk_time_from          );
		JSON_SetValue( g_pjcomm, 'C', "chk_time_end"          , stMw.szChk_time_end           );
		JSON_SetValue( g_pjcomm, 'C', "once_account"          , stMw.szOnce_account           );
		JSON_SetValue( g_pjcomm, 'C', "auto_yn"               , stMw.szAuto_yn                );
		JSON_SetValue( g_pjcomm, 'C', "price_yn"              , "2"                           );
		JSON_SetValue( g_pjcomm, 'C', "card_gaspay"           , stMw.szCard_gaspay            );
		JSON_SetValue( g_pjcomm, 'C', "cash_gaspay"           , stMw.szCash_gaspay            );
		JSON_SetValue( g_pjcomm, 'C', "card_onepay"           , stMw.szCard_onepay            );
		JSON_SetValue( g_pjcomm, 'C', "trans_conn_yn"         , stMw.szTrans_conn_yn          );
		JSON_SetValue( g_pjcomm, 'C', "bur_yn"                , stMw.szBur_yn                 );
		JSON_SetValue( g_pjcomm, 'C', "conn_yn"               , stMw.szConn_yn                );
		JSON_SetValue( g_pjcomm, 'C', "bar_gbn"               , stMw.szBar_gbn                );
		JSON_SetValue( g_pjcomm, 'C', "bar_yn"                , stMw.szBar_yn                 );
		JSON_SetValue( g_pjcomm, 'C', "bar_why"               , stMw.szBar_why                );
		JSON_SetValue( g_pjcomm, 'C', "chk_yn"                , stMw.szChk_yn                 );
		JSON_SetValue( g_pjcomm, 'C', "conn_gbn"              , stMw.szConn_gbn               );
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szMemo );
		JSON_SetValue( g_pjcomm, 'C', "memo"                  , szUcovert                     );
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szCurr_addr_union );
		JSON_SetValue( g_pjcomm, 'C', "curr_addr_union"       , szUcovert                     );
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szNew_addr_union );
		JSON_SetValue( g_pjcomm, 'C', "new_addr_union"        , szUcovert                     );
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szEmail );
		JSON_SetValue( g_pjcomm, 'C', "email"                 , szUcovert                     );
		JSON_SetValue( g_pjcomm, 'C', "trans_in_cust_num"     , stMw.szTrans_in_cust_num      );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_ddd"      , stMw.szOwnhouse_tel_ddd       );
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_exn"      , stMw.szOwnhouse_tel_exn       );		
		JSON_SetValue( g_pjcomm, 'C', "ownhouse_tel_num"      , stMw.szOwnhouse_tel_num       );
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szCust_nm );
		JSON_SetValue( g_pjcomm, 'C', "cust_nm"               , szUcovert                     );
		JSON_SetValue( g_pjcomm, 'C', "soc_num"               , stMw.szSoc_num                );
		JSON_SetValue( g_pjcomm, 'C', "cp_ddd"                , stMw.szCp_ddd                 );
		JSON_SetValue( g_pjcomm, 'C', "cp_exn"                , stMw.szCp_exn                 );
		JSON_SetValue( g_pjcomm, 'C', "cp_num"                , stMw.szCp_num                 );
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szFirm_nm );
		JSON_SetValue( g_pjcomm, 'C', "firm_nm"               , szUcovert                     );
		JSON_SetValue( g_pjcomm, 'C', "family_cnt"            , stMw.szFamily_cnt             );
		JSON_SetValue( g_pjcomm, 'C', "cust_trnd_cd"          , stMw.szCust_trnd_cd           );
		JSON_SetValue( g_pjcomm, 'C', "built_in_yn"           , stMw.szBuilt_in_yn            );
		JSON_SetValue( g_pjcomm, 'C', "square_meter"          , stMw.szSquare_meter           );
		JSON_SetValue( g_pjcomm, 'C', "info_use_agree_yn"     , stMw.szInfo_use_agree_yn      );
		JSON_SetValue( g_pjcomm, 'C', "cont_sts_cd"           , stMw.szCont_sts_cd            );
		JSON_SetValue( g_pjcomm, 'C', "pas_use_cont_num_yn"   , stMw.szPas_use_cont_num_yn    );
		JSON_SetValue( g_pjcomm, 'C', "pas_defray_account_num", stMw.szPas_defray_account_num );
		JSON_SetValue( g_pjcomm, 'C', "pas_cust_num"          , stMw.szPas_cust_num           );
		JSON_SetValue( g_pjcomm, 'C', "pas_req_info_num"      , stMw.szPas_req_info_num       );
		JSON_SetValue( g_pjcomm, 'C', "chk_cable"             , "N"       );
		Mem_Set((byte*)szUcovert, 0x00, sizeof(szUcovert));
		SQL_ConvUcStr( szUcovert, stMw.szTrans_in_cust_nm );
		JSON_SetValue( g_pjcomm, 'C', "trans_in_cust_nm"      , szUcovert                     );
 		JSON_SetValue( g_pjcomm, 'C', "req_tel_ddd"           , stMw.szReq_tel_ddd            );
		JSON_SetValue( g_pjcomm, 'C', "req_tel_exn"           , stMw.szReq_tel_exn            );
		JSON_SetValue( g_pjcomm, 'C', "req_tel_num"           , stMw.szReq_tel_num            );
		JSON_SetValue( g_pjcomm, 'C', "req_cp_ddd"            , stMw.szReq_cp_ddd             );
		JSON_SetValue( g_pjcomm, 'C', "req_cp_exn"            , stMw.szReq_cp_exn             );
		JSON_SetValue( g_pjcomm, 'C', "req_cp_num"            , stMw.szReq_cp_num             );
		JSON_SetValue( g_pjcomm, 'C', "apro_num"              , stMw.szAppro_num              );
		JSON_SetValue( g_pjcomm, 'C', "bill_gubun"            , stMw.szBill_gubun             );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag"         , stMw.szDeadline_flag          );
		JSON_SetValue( g_pjcomm, 'C', "adj_cause"             , stMw.szAdj_cause              );
		JSON_SetValue( g_pjcomm, 'C', "biz_regi_num"          , stMw.szBiz_regi_num           );

		//���ڵ彺ĵ or ��������
		g_Add_Bo_690(g_pjcomm); //���Ϸ���������
		g_Add_Bur_690(g_pjcomm); //���ұ��������
		g_Add_Once_690(g_pjcomm);//��ȸ�����

		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		g_SeverConnection();
		
		callBackfunc = g_Rcv_RstMIn_690; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR68902_IN",  "FR68902" , sndbuf, szbuf );	
	}
	
	long g_Rcv_RstMIn_690(void)
	{
		char szSql[200];
	
		g_Sock_Close();
		
		if( g_Chk_Json(68902) >= 0)
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, " UPDATE C6101_PROMISE_ASSIGN SET SEND_YN = 'Y' WHERE Promise_assign_seq = '%s' ", g_szCHK_EXEC_NUM, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			MessageBoxEx (CONFIRM_OK, "�ο��� �Ϸ��Ͽ����ϴ�.");
			
			Card_Move("C6101_LST");
			
			return 1;
		}
		else
		{
			Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
			SPRINT( szSql, " UPDATE C6101_PROMISE_ASSIGN SET SEND_YN = 'N' WHERE Promise_assign_seq = '%s' ", g_szCHK_EXEC_NUM, 0, 0 );
			g_Sql_DirectExecute( szSql );
			
			MessageBoxEx (ERROR_OK, "���� �������.");
			return -1;
		}
	}
	
	// param_start_time = HH24MMSS, param_end_time = HH24MMSS
	bool g_Chk_Time( char* param_start_time, char* param_end_time )
	{
		char sztmp[200];
		char sztmp2[200];
		char sztmp3[200];
		long current_time = 0;
		long start_time = 0;
		long end_time = 0;
		
		// �̳������� �ƴϸ� ������ TRUE
		if( Str_Cmp(stUserinfo.szcenter_cd, "98") != 0 )
		{
			return TRUE;
		}
		
		if( Str_Len(param_start_time) == 6 )
		{
			start_time = Str_AtoI(param_start_time);
		}
		else
		{
			PRINT("::::ERR : ���۽ð� ���� [%s]", param_start_time, 0, 0);
			return FALSE;
		}
		
		if( Str_Len(param_end_time) == 6 )
		{
			end_time = Str_AtoI(param_end_time);
		}
		else
		{
			PRINT("::::ERR : ����ð� ���� [%s]", param_end_time, 0, 0);
			return FALSE;
		}
		
		//HH24MMSS
		current_time = Time_GetTime();
		
		//PRINT(":::: start_time [%d]", start_time, 0, 0);
		//PRINT(":::: current_time [%d]", current_time, 0, 0);
		//PRINT(":::: end_time [%d]", end_time, 0, 0);
		
		if( start_time <= current_time && current_time <= end_time )
		{
			//PRINT(":::: TRUE", 0, 0, 0);
			return TRUE;
		}
		else
		{
			//PRINT(":::: FALSE", 0, 0, 0);
			
			Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
			Str_Cpy( sztmp, "�������ɽð��� �ƴմϴ�.\n" );
			Str_Cat( sztmp, "�������ɽð� : " );
			
			Mem_Set( (byte*) sztmp2, 0x00, sizeof( sztmp2) );
			Mem_Set( (byte*) sztmp3, 0x00, sizeof( sztmp3) );
			
			g_Str_TimeType( sztmp2 , start_time);
			Str_Chg(sztmp2, STRCHG_DEL_NONDIGIT);
			g_Str_TimeForm(sztmp3, sztmp2);
			Str_Cat( sztmp, sztmp3 );
			
			Str_Cat( sztmp, "~" );
			
			Mem_Set( (byte*) sztmp2, 0x00, sizeof( sztmp2) );
			Mem_Set( (byte*) sztmp3, 0x00, sizeof( sztmp3) );
			
			g_Str_TimeType( sztmp2 , end_time);
			Str_Chg(sztmp2, STRCHG_DEL_NONDIGIT);
			g_Str_TimeForm(sztmp3, sztmp2);
			Str_Cat( sztmp, sztmp3 );
			
			MessageBoxEx (ERROR_OK, sztmp);
			
			return FALSE;
		}
	}
	
	/*=======================================================================================
	�Լ��� : g_SearchStr
	��  �� : ��Ʈ������ �ڵ��ε����� ã�´�.
	Param  : 
	Return : �ڵ��ε���, ������ -1
	========================================================================================*/
	long g_SearchStr( char *Str, CodeTable *CT)
	{
		long i;

		for ( i = 0 ; CT[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
				return i;
		}
		
		return -1;
	}
	
	/*=======================================================================================
	�Լ��� : g_SearchCD
	��  �� : �ڵ尪���� �ڵ��ε����� ã�´�.
	Param  : 
	Return : �ڵ��ε���, ������ -1
	========================================================================================*/
	long g_SearchCD( char *CD, CodeTable *CT)
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
	�Լ��� : g_Send_SOS
	��  �� : SOS ��� / ������ 3���� ���� �߼� ��, 112�� ��ȭ�ɱ��� Ȱ��ȭ
	Param  : ���� �� �ּ� ������ ������ �޶� type ����, type : 0 = ��ħ, 1 = ��������
	Return : ���۹��� 1,2,3 : [�����Ŵ���]
	                          ���޻�Ȳ. �����ּ���!
	                          ~~~~ �ּҰ� ���� ~~~~~
	========================================================================================*/
	void g_Send_SOS( long type )
	{
		long lAddr = 0;
		long ret = 0;
		
		char sztmp[500];
		char szUrl[500];
		char szbuf[500];
		char szMsg[1000];
		char tel_ddd[5];
		char tel_exn[5];
		char tel_num[5];
		char szUMsg[1000];
		
		char* sndbuf;
		
		/***********************************/
		/* �ܸ��� ��ȭ��ȣ Check           */
		/***********************************/
		if( Str_Cmp(stUserinfo.szpda_ip, "000-0000-0000") == 0 )
		{
			MessageBoxEx (ERROR_OK, "SOS ���� ����");
			return;
		}
		
		/***********************************/
		/* �ܸ��� ��ȭ��ȣ Setting         */
		/***********************************/
		Mem_Set( (byte*)tel_ddd, 0x00, sizeof(tel_ddd) );
		Mem_Set( (byte*)tel_exn, 0x00, sizeof(tel_exn) );
		Mem_Set( (byte*)tel_num, 0x00, sizeof(tel_num) );
		
		g_Fsgetitem(stUserinfo.szpda_ip, tel_ddd, 1, Str_Len(stUserinfo.szpda_ip) );
		g_Fsgetitem(stUserinfo.szpda_ip, tel_exn, 2, Str_Len(stUserinfo.szpda_ip) );
		g_Fsgetitem(stUserinfo.szpda_ip, tel_num, 3, Str_Len(stUserinfo.szpda_ip) );
		
		/***********************************/
		/* ��޻�Ȳ ��Ʈ                   */
		/***********************************/
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		
		Str_Cpy(szMsg, "[�����Ŵ���]\n���޻�Ȳ. �����ּ���!\n");
		
		/***********************************/
		/* �ּ� Setting                    */
		/***********************************/
		// ��ħ
		if( type == 0 )
		{
			if(Str_Len(stGm.AREA) > 0)
			{
				Str_Cat(szMsg,  stGm.AREA );
			}
			else
			{
				Str_Cat(szMsg,  "" );
			}
			
			if(Str_Len(stGm.TOWN) > 0)
			{
				Str_Cat(szMsg,  " " );
				Str_Cat(szMsg,  stGm.TOWN );
			}
			
			if(Str_Len(stGm.VILLAGE) > 0)
			{
				Str_Cat(szMsg,  " " );
				Str_Cat(szMsg,  stGm.VILLAGE );
			}
			
			if(Str_Len(stGm.ADDR1_M) > 0)
			{
				Str_Cat(szMsg,  " " );
				Str_Cat(szMsg,  stGm.ADDR1_M);
			}
			
			if(Str_Len(stGm.ADDR1_S) > 0)
			{
				Str_Cat(szMsg,  "-" );
				Str_Cat(szMsg,  stGm.ADDR1_S);
			}
			
			lAddr = Str_Len(stGm.CO_LIVE_NM) + Str_Len(stGm.BLD_NM);

			if( lAddr > 0 )
			{
				if( Str_Len(stGm.CO_LIVE_NM) > 0 )
				{
					Str_Cat(szMsg,  " " );
					Str_Cat(szMsg,  stGm.CO_LIVE_NM );
				}
				else
				{
					Str_Cat(szMsg,  "" );
				}
				
				if( Str_Len(stGm.BLD_NM) > 0 )
				{
					Str_Cat(szMsg,  " " );	
					Str_Cat(szMsg,  stGm.BLD_NM );
				}
				
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szMsg,  "-" );	
					Str_Cat(szMsg,  stGm.HOSU );
				}
				
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szMsg,  " " );	
					Str_Cat(szMsg,  stGm.DETA_FLOOR );
				}
			}
			else
			{
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szMsg,  " " );
					Str_Cat(szMsg,  stGm.HOSU );
				}
				else
				{
					Str_Cat(szMsg,  "" );
				}
				
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szMsg,  " " );	
					Str_Cat(szMsg,  stGm.DETA_FLOOR );
				}
			}
		}
		// ��������
		else if( type == 1 )
		{	
			// �ñ���
			if(Str_Len(stSc.COUNTY) > 0)		
			{
				Str_Cat(szMsg,  stSc.COUNTY );
			}
			
			// ���鵿	
			if(Str_Len(stSc.TOWN) > 0)			
			{
				Str_Cat(szMsg,  " " );
				Str_Cat(szMsg,  stSc.TOWN );
			}
			
			// ���鵿
			if(Str_Len(stSc.VILLAGE) > 0)			
			{
				Str_Cat(szMsg,  " " );
				Str_Cat(szMsg,  stSc.VILLAGE );
			}
			
			// ����
			if(Str_Len(stSc.ADDR1_M) > 0)		
			{
				Str_Cat(szMsg,  " " );
				Str_Cat(szMsg,  stSc.ADDR1_M);
			}
			
			// �ι�
			if(Str_Len(stSc.ADDR1_S) > 0)		
			{
				Str_Cat(szMsg,  "-" );
				Str_Cat(szMsg,  stSc.ADDR1_S);
			}
			
			Str_Cat(szMsg,  " " );
			
			// �ܵ��� ���
			if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "10") == 0 )
			{
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(szMsg,  stSc.HOUSE_CNT);
				}
				if(Str_Len(stSc.LOT_NUM_SECOND_ADDR) > 0)
				{
					Str_Cat(szMsg,  " " );
					Str_Cat(szMsg,  stSc.LOT_NUM_SECOND_ADDR);
				}
			}
			// ������ ���
			else if( Str_Cmp(stSc.SINGLE_COLIVE_FLAG, "20") == 0 )
			{
				if(Str_Len(stSc.CO_LIVE_NM) > 0)
				{
					Str_Cat(szMsg,  stSc.CO_LIVE_NM );
				}
				if(Str_Len(stSc.BLD_NM) > 0)
				{
					Str_Cat(szMsg,  " " );
					Str_Cat(szMsg,  stSc.BLD_NM);
				}
				if(Str_Len(stSc.HOUSE_CNT) > 0)
				{
					Str_Cat(szMsg,  "-" );
					Str_Cat(szMsg,  stSc.HOUSE_CNT);
				}
			}
		}
		
		/***********************************/
		/* ���� ����                       */
		/***********************************/
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 685030, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd"   ,   stUserinfo.szcenter_cd ); 
		JSON_SetValue( g_pjcomm, 'C', "send_tel_ddd",   tel_ddd );
		JSON_SetValue( g_pjcomm, 'C', "send_tel_exn",   tel_exn );
		JSON_SetValue( g_pjcomm, 'C', "send_tel_num",   tel_num );
		
		Mem_Set((byte*)szUMsg, 0x00, sizeof(szUMsg) );
		SQL_ConvUcStr( szUMsg, szMsg );
		JSON_SetValue( g_pjcomm, 'C', "sms_desc", szUMsg );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
				
		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);
		
		callBackfunc = g_Rcv_SOS; //��ſϷ� �Ŀ� ȣ�� �Լ�
		ret = HTTP_DownloadData(szUrl, "FR685030_IN",  "FR685030" , sndbuf, szbuf );
	}
	
	/*=======================================================================================
	�Լ��� : g_Rcv_SOS
	��  �� : g_Send_SOS CallBack
	Param  : 
	Return : 
	========================================================================================*/
	long g_Rcv_SOS(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(685030) >= 0)
		{
			VmSleep(100);		
			/***************************/
			/* ��ȭ�ɱ�(112)           */
			/***************************/
			Str_Chg(stUserinfo.szSos_TelNum, STRCHG_DEL_NONDIGIT );
			Tapi_MakeCall((byte*)stUserinfo.szSos_TelNum);
			
			return 1;
		}
		else
		{
			MessageBoxEx (ERROR_OK, "SOS ���� ����");
			return -1;
		}
	}
	
	/*=======================================================================================
	�Լ��� : g_Fsgetitem
	��  �� : ��ȭ��ȣ�� -�� �ڸ�
	Param  : 
	Return : 
	========================================================================================*/
	void g_Fsgetitem( char* szSource, char* szTarget, int id, int len )
	{
		int i;
		int idx;
		int ids;
	
		idx = 0;
		ids = 1;
		
		for( i = 0; i < len; i++ )
		{
			if( szSource[i] == '-' || szSource[i] == '_' || szSource[i] == '.' )
			{
				if( ids == id )
				{
					szTarget[idx] = 0x00;
					break;
				}
				
				idx = 0;
				ids++;
				continue;
			}
			if( ids == id )
			{
				szTarget[idx] = szSource[i];
				idx++;
			}
		}
	}
	
	/*=======================================================================================
	�Լ��� : g_DirFS_Count
	��  �� : ������ ���丮���� pszFilter�� �˻��� ���� ������ ��ȯ
	Parameter : pszDir : ���丮
			  : pszFilter : ã������
	Return    :  0 : ����
				-1 : ����
	========================================================================================*/
	long g_DirFS_Count( char* pszDir, char* pszFilter )
	{
		long	fh;
		char	szPath[256];
		char	szTemp[256];
		char	szFileName[256] = {""};
		long 	dirCount = 0;
		
		if (pszDir[0] == '\0')
		{
			Str_Cpy (szPath, pszFilter);
		}
		else
		{
			SPRINT(szPath, "%s\\%s", (quad)pszDir+((pszDir[0]=='\\')?1:0), (quad)pszFilter, 0);
			// pszDir+((pszDir[0]=='\\')?1:0)�� pszDir[1] ���� ���� pszDir[0] ���͸� ���Ѵ�.
		}
		
		fh = FFS_FindFirst(szPath, szFileName);
		if (fh < 0 )
		{
			return 0;
		}
	
		// ������ �ϳ��� ���� ���
		if (szFileName[0] == '\0')
		{
			FFS_FindClose(fh);
			return 0;
		}
	
		do
		{
			if (pszDir[0] != '\0')
			{
				SPRINT(szTemp, "%s\\%s", (quad)pszDir+((pszDir[0]=='\\')?1:0), (quad)szFileName, 0);
			}
			else
			{
				Str_Cpy (szTemp, szFileName);
			}
			
			dirCount++;
	
			
		} while (FFS_FindNext(fh, szFileName));
		FFS_FindClose(fh);
		
	
		return dirCount;
	}
	
	/*=======================================================================================
	�Լ��� : g_GM_Mtr_Add_Item
	��  �� : �跮�� ��ȸ
	Param  : 
	Return : 
	========================================================================================*/	
	long g_GM_Mtr_Add_Item(handle pj)
	{
		char szSql[500];
		char sztmp[20];
		char szMtrnum[11];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		handle js = NULL;
		SQLITE sql = NewSqLite();
		
		js = JSON_Create(JSON_Array);
		
		if( js == NULL )
		{
			goto Finally;
		}
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement( sql, "SELECT MTR_NUM FROM GUMDATA WHERE ( TRIM(SEND_YN) IS NULL OR TRIM(SEND_YN) = '' OR TRIM(SEND_YN) = 'N' )" );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szMtrnum,0x00, sizeof(szMtrnum) );
			
			sql->GetValue( sql, 0, 'U', (long*)szMtrnum, 11, DECRYPT );
			
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "mtr_num", szMtrnum );
			
			ret =1;
		}
		
		JSON_Attach( pj, "item", js );
		JSON_Attach( pj, "item3", js );
		
	Finally:
	
		if( js != NULL )
		{
			JSON_Finalize(js);
			js = NULL;
		}
		
		DelSqLite(sql);
		
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : g_GM_Use_Cont_Num_Add_Item
	��  �� : ������ȣ ��ȸ
	Param  : 
	Return : 
	========================================================================================*/
	long g_GM_Use_Cont_Num_Add_Item(handle pj)
	{
		char szSql[500];
		char sztmp[20];
		char szUsecontnum[11];
		long ret = -1;	
		handle hdb = NULL;
		handle hstmt = NULL;
		handle js = NULL;
		SQLITE sql = NewSqLite();
		
		js = JSON_Create(JSON_Array);
		
		if( js == NULL )
		{
			goto Finally;
		}
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		hstmt = sql->CreateStatement( sql, "SELECT USE_CONT_NUM FROM GUMDATA WHERE ( TRIM(SEND_YN) IS NULL OR TRIM(SEND_YN) = '' OR TRIM(SEND_YN) = 'N' ) AND BEFO_GMTR_SMS_YN IS NULL" );

		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
		while( sql->Next(sql) )
		{
			Mem_Set( (byte*)szUsecontnum,0x00, sizeof(szUsecontnum) );
			
			sql->GetValue( sql, 0, 'U', (long*)szUsecontnum, 11, DECRYPT );
			
			JSON_AddArrayItem(js);
			JSON_SetArrayItem(js, 'C', "use_cont_num", szUsecontnum );
			
			ret =1;
		}
		
		JSON_Attach( pj, "item2", js );
		
	Finally:
	
		if( js != NULL )
		{
			JSON_Finalize(js);
			js = NULL;
		}
		
		DelSqLite(sql);
		
		return ret;
	}
	
	
	/*=======================================================================================
	�Լ��� : SetFR25012
	��  �� : FR25012 DATA SETTING
	Param  : 
	Return :
	========================================================================================*/
	long g_GM_SetFR25012(void)
	{
		char szJsonpath[500]; 
		char szMsg[500];
		char szTmp[100];
		
		long nCnt = 0;
		long fd, i;
		long chkmsg = 0;
		long chkcode = 0;
		long fsize = 0;
		long ret = 11;
		long k;
		
		char *pStr;
		char *szcode;
		char *szmessage;
		char *szitem;
		char *szitem2;
		char *szitem3;

		
		char *szMtrNum;
		char *szGmtrMethod;
		char *szGmtrJobCd;
		char *szVc;
		char *szVa;
		char *szVm;
		
		char *szUseContNum;
		char *szGmtrSendSts;
		char *szRcvSmsDesc;

		char *szRecentIndiMtrMMVC;
		
		char *szRecentGmtrJobYmd;
		char *szRecentVc;
		
		char szType[2] = {0,0};

		handle hitem = NULL;
		handle hcnt = NULL;
		
		Mem_Set( (byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT( szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 25012, 0 );
		
		if( FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set( (byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT( szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 25012, 0 );
		}
		
		fsize = FFS_GetSize(szJsonpath);
		
		if( fsize <= 15 )
		{
			ret = -1;
			goto Finally;
		}
		
		pStr = Mem_Alloc(fsize);
		
		fd = FFS_Open( szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG );
		
		if( fd == -1 )
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read( fd, (byte*)pStr, fsize );
		
		for( i = 0 ; i < fsize - 9 ; i++ )
		{
			if( Mem_Cmp( (byte*)pStr+i,(byte*) "\"code\"", 6 ) == 0  )
			{
				chkcode++;
			}
			
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9 ) == 0  )
			{
				chkmsg++;
			}
			
			if( chkmsg > 0 &&  chkcode > 0 )
			{
				break;
			}
		}

		FFS_Close(fd);
		
		Mem_Free( (byte*)pStr );
		
		if( chkmsg == 0 || chkcode == 0 )
		{
			ret = -1;
			goto Finally;
		}
		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}
		
		g_pjcomm = JSON_Create( JSON_Object );
		
		if( g_pjcomm == NULL )
		{
			ret = -1;
			goto Finally;
		}

		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0 )
		{
			szcode = JSON_GetValue( g_pjcomm, "code", szType );
			szmessage = JSON_GetValue( g_pjcomm, "message", szType );

			if( Str_Cmp(szcode, "0000") != 0 )
			{
				Mem_Set( (byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				
				if( Str_Len(szmessage) < 500 )
				{
					SQL_ConvMbStr( szMsg, szmessage );
				}
				
				SPRINT( szJsonpath, "[%s] %s", szcode, szMsg, 0 );
			
				MessageBoxEx( WARNING_OK, szJsonpath );
				
				//ON_DRAW();
				
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem = JSON_GetValue( g_pjcomm, "item", szType );
				
				if( szitem != NULL )
				{
					if( Str_Len(szitem) > 0 )
					{		
						hitem = JSON_Create( JSON_Array );
						
						if( hitem != NULL )
						{
							JSON_toJson( hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
							
							if( ret > 0 )
							{
								for( k = 0 ; k < ret ; k++)
								{
									//PRINT("", 0, 0,0 );
									//PRINT("################################## START FOR1 [%d]", k, 0,0 );

									szMtrNum = (char*)JSON_GetArrayItem ( hitem, k, "mtr_num", szType);
									szGmtrMethod = (char*)JSON_GetArrayItem ( hitem, k, "gmtr_method", szType);
									szGmtrJobCd = (char*)JSON_GetArrayItem ( hitem, k, "gmtr_job_cd", szType);
									szVc = (char*)JSON_GetArrayItem ( hitem, k, "vc", szType);
									szVa = (char*)JSON_GetArrayItem ( hitem, k, "va", szType);
									szVm = (char*)JSON_GetArrayItem ( hitem, k, "vm", szType);
									
									//PRINT("# szMtrNum    : %s", szMtrNum,0,0);
									//PRINT("# szGmtrMethod: %s", szGmtrMethod,0,0);
									//PRINT("# szGmtrJobCd : %s", szGmtrJobCd,0,0);
									//PRINT("# szVc        : %s", szVc,0,0);
									//PRINT("# szVa        : %s", szVa,0,0);
									//PRINT("# szVm        : %s", szVm,0,0);
									
									g_GM_Etc_Update( szMtrNum, szGmtrJobCd, szVc, szVa, szVm );
									
									//PRINT("################################## END FOR1 [%d]", k, 0, 0);
									//PRINT("", 0, 0,0 );
								}
							}
							
							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
				}
				
				ret = 0;
				szitem2 = JSON_GetValue( g_pjcomm, "item2", szType );
				
				if( szitem2 != NULL )
				{
					if( Str_Len(szitem2) > 0 )
					{		
						hitem = JSON_Create( JSON_Array );
						
						if( hitem != NULL )
						{
							JSON_toJson( hitem, szitem2 ) ;
							ret = JSON_GetArrayCount( hitem );
							
							if( ret > 0 )
							{
								for( k = 0 ; k < ret ; k++)
								{
									//PRINT("", 0, 0,0 );
									//PRINT("################################## START FOR2 [%d]", k, 0,0 );

									szUseContNum = (char*)JSON_GetArrayItem ( hitem, k, "use_cont_num", szType);
									szGmtrSendSts = (char*)JSON_GetArrayItem ( hitem, k, "gmtr_send_sts", szType);
									szRcvSmsDesc = (char*)JSON_GetArrayItem ( hitem, k, "rcv_sms_desc", szType);
									
									//PRINT("# szUseContNum : %s", szUseContNum,0,0);
									//PRINT("# szGmtrSendSts: %s", szGmtrSendSts,0,0);
									//PRINT("# szRcvSmsDesc : %s", szRcvSmsDesc,0,0);
									
									g_GM_Befo_Sms_Update( szUseContNum );
									
									//PRINT("################################## END FOR2 [%d]", k, 0, 0);
									//PRINT("", 0, 0,0 );
								}
							}
							
							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
				}

				ret = 0;
				szitem3 = JSON_GetValue( g_pjcomm, "item3", szType );
				
				if( szitem3 != NULL )
				{
					if( Str_Len(szitem3) > 0 )
					{		
						hitem = JSON_Create( JSON_Array );
						
						if( hitem != NULL )
						{
							JSON_toJson( hitem, szitem3 ) ;
							ret = JSON_GetArrayCount( hitem );
							
							
							if( ret > 0 )
							{
								for( k = 0 ; k < ret ; k++)
								{
									szRecentVc = (char*)JSON_GetArrayItem ( hitem, k, "recent_indi_mtr_mm_vc", szType);
									szMtrNum = (char*)JSON_GetArrayItem ( hitem, k, "mtr_num", szType);
									szRecentGmtrJobYmd = (char*)JSON_GetArrayItem ( hitem, k, "recent_gmtr_job_ymd", szType);
									
									
									g_GM_Remote_Update( szMtrNum, szRecentVc, szRecentGmtrJobYmd);
									
									
								}
							}
							
							JSON_Finalize(hitem);
							hitem = NULL;
						}
					}
				}
			}
		}
		else
		{
			ret = 1;
		}
		
	Finally:		
		if( g_pjcomm != NULL )
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}

		g_Close_SubDlg();
		EvtDraw();
		
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : g_GM_Rcv25012
	��  �� : FR25012
	Param  : 
	Return : 
	========================================================================================*/	
	void g_GM_Rcv25012(void)
	{
		char sztmp[32];
		char szUrl[256];
		char szSql[256];
		char* sndbuf;
		char szReqym[20];
		char szDeadlineflag[20];
		long ret = 0;
		
		Mem_Set( (byte*)szReqym, 0x00, sizeof(szReqym) );
		g_Sql_RetStr( "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '1'", 10, szReqym );
		
		Mem_Set( (byte*)szDeadlineflag, 0x00, sizeof(szDeadlineflag) );
		g_Sql_RetStr( "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '1'", 5, szDeadlineflag );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25012, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "req_ym",          szReqym );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",   szDeadlineflag );
		
		g_GM_Mtr_Add_Item(g_pjcomm);
		g_GM_Use_Cont_Num_Add_Item(g_pjcomm);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = g_GM_TR25012;
		ret = HTTP_DownloadData( szUrl, "FR25012_IN",  "FR25012" , sndbuf, sztmp );
		
		return;		
	}
	
	/*=======================================================================================
	�Լ��� : g_GM_TR25012
	��  �� : FR25012 CALLBACK
	Param  : 
	Return : 
	========================================================================================*/	
	long g_GM_TR25012(void)
	{
		long lRet = -1;
		
		g_Sock_Close();
		
		if(g_Chk_Json(25012) >= 0)
		{
			lRet = g_GM_SetFR25012();
			
			MessageBoxEx (CONFIRM_OK, "��ħ �����͸� �ݿ� �Ϸ��߽��ϴ�.");
			return lRet;
		}
		else
		{
			return lRet;
		}
	}
	
	/*=======================================================================================
	�Լ��� : g_GM_Etc_Update
	��  �� : Etc ��ħ ������Ʈ
	Param  : 
	Return : 
	========================================================================================*/	
	bool g_GM_Etc_Update( char * mtrnum, char* code, char* vc, char* va, char* vm )
	{
		char szSql[500];
		char szCal[300];
		char szMsg[300];
		bool ret = TRUE;
		long idx;
		long i;
		long cal = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//PRINT("#### START UPDATE",0 ,0,0);
		
		cal = g_GM_Cal_UseQty( vc, code, mtrnum );
		Mem_Set( (byte*)szCal, 0x00, sizeof(szCal) );
		Str_ItoA( cal, szCal, 10 );
		
		//PRINT("# szCal : %s",szCal,0,0);
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		SPRINT( szSql, "UPDATE GUMDATA \
						   SET MTR_WORK_CODE = ? \
						     , INDI_SET_VC = ? \
						     , INDI_SET_VA = ? \
						     , INDI_SET_VM = ? \
						     , INDI_QTY = ? \
						     , SEND_YN = 'E' \
						 WHERE ( TRIM(SEND_YN) IS NULL OR TRIM(SEND_YN) = '' OR TRIM(SEND_YN) = 'N' ) \
						   AND MTR_NUM = ?"
		             , 0, 0, 0 );
		
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		
		sql->Bind(sql, idx++, 'U', (long *)code  , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)vc	 , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)va 	 , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)vm	 , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szCal, 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)mtrnum, 10, DECRYPT);
		
		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
	Finally:
		
		DelSqLite(sql);
		//PRINT("#### END UPDATE",0, 0,0);
		return ret;
	}
	
	/*=======================================================================================
	�Լ��� : g_GM_Cal_UseQty
	��  �� : ��뷮 ���
	Param  : 
	Return : 
	========================================================================================*/	
	long g_GM_Cal_UseQty( char *szIndi_VC, char* szCode, char* szMtrnum )
	{
		long i = 0;
		long lLength = 0;
		long lAddValue = 10;
		long lUseQty = 0;		// �����뷮
		long lIndi_VC = 0;		// ������ħ
		long lPrevVc = 0;		// ������ħ
		long lCivilVc = 0;		// ��ħ������ο�_VC
		
		char szSql[300];
		char sztmp[300];
		char szPrevVc[300];
		char rslt[300];
		
		//PRINT("## START Cal_UseQty",0 ,0,0);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)szPrevVc, 0x00, sizeof(szPrevVc) );
		SPRINT( szSql ,"SELECT BEFO_MM_INDI_COMPENS_VC_1 FROM GUMDATA WHERE MTR_NUM = '%s'", szMtrnum, 0, 0 );
		g_Sql_RetStr(szSql, 10, szPrevVc );
		
		lPrevVc = Str_AtoI(szPrevVc);
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		SPRINT( szSql ,"SELECT INDI_COMPENS_CIVIL_SERV_VC FROM GUMDATA WHERE MTR_NUM = '%s'", szMtrnum, 0, 0 );
		g_Sql_RetStr(szSql, 10, sztmp );
		
		lCivilVc = Str_AtoI(sztmp);
		
		lIndi_VC = Str_AtoI(szIndi_VC);

		/*************************/
		/* ��� �� ADDVALUE ��� */
		/*************************/
		// 5:��ȸ
		if( Str_Cmp(szCode, "5") == 0 )
		{	
			lLength = Str_Len(szPrevVc);
			
			for( i = 0 ; i < (lLength - 1) ; i++ )
			{
				lAddValue = lAddValue * 10;
			}
		}
		// 3:��ü
		else if( Str_Cmp(szCode, "3") == 0 )
		{
			lAddValue = lCivilVc - lPrevVc;

		    if( lAddValue < 1 )
		    {
				lAddValue = 0;
			}
		}
		// ������
		else
		{
			lAddValue = 0;
		}
		
		/**************************/
		/* VC�� 0���� ū��� ��� */
		/**************************/
		if( Str_Len(szIndi_VC) > 0 )
		{
			// 3:��ü
			if( Str_Cmp(szCode, "3") == 0 )
			{		
				lUseQty = lIndi_VC + lAddValue;
			}
			// ������
			else
			{
				lUseQty = lIndi_VC - lPrevVc + lAddValue;
			}
		}
		
		//PRINT("## END Cal_UseQty",0 ,0,0);
		
		return lUseQty;
	}
	
	/*=======================================================================================
	�Լ��� : g_GM_Befo_Sms_Update
	��  �� : ���� ���� update
	Param  : 
	Return : 
	========================================================================================*/	
	bool g_GM_Befo_Sms_Update( char * usecontnum )
	{
		char szSql[500];
		char szCal[300];
		char szMsg[300];
		bool ret = TRUE;
		long idx;
		long i;
		long cal = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//PRINT("#### START UPDATE2",0 ,0,0);
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		SPRINT( szSql, "UPDATE GUMDATA \
						   SET BEFO_GMTR_SMS_YN ='Y' \
						 WHERE ( TRIM(SEND_YN) IS NULL OR TRIM(SEND_YN) = '' OR TRIM(SEND_YN) = 'N' ) \
						   AND USE_CONT_NUM = ?"
		             , 0, 0, 0 );
		
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		

		sql->Bind(sql, idx++, 'U', (long *)usecontnum, 10, DECRYPT);
		
		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
	Finally:
		
		DelSqLite(sql);
		//PRINT("#### END UPDATE2",0, 0,0);
		return ret;
	}


	/*=======================================================================================
	�Լ��� : g_GM_Remote_Update
	��  �� : ���� ��ħ update
	Param  : 
	Return : 
	========================================================================================*/	
	bool g_GM_Remote_Update( char * mtrnum, char* indiVc, char* gmtrYmd)
	{
		char szSql[500];
		char szCal[300];
		char szMsg[300];
		bool ret = TRUE;
		long idx;
		long i;
		long cal = 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		//PRINT("#### START UPDATE",0 ,0,0);
		
		// cal = g_GM_Cal_UseQty( vc, code, mtrnum );
		// Mem_Set( (byte*)szCal, 0x00, sizeof(szCal) );
		// Str_ItoA( cal, szCal, 10 );
		
		//PRINT("# szCal : %s",szCal,0,0);
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = FALSE;
			goto Finally;
		}
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		
		SPRINT( szSql, "UPDATE GUMDATA \
						   SET RECENT_INDI_MTR_MM_VC = ? \
						     , RECENT_GMTR_JOB_YMD = ? \
						 WHERE MTR_NUM = ?"
		             , 0, 0, 0 );
		
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
		idx = 0;
		
		sql->Bind(sql, idx++, 'U', (long *)indiVc  , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)gmtrYmd	 , 10, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)mtrnum, 10, DECRYPT);
		
		if( sql->Execute(sql) == FALSE )
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			ret = FALSE;
			goto Finally;
		}
		
	Finally:
		
		DelSqLite(sql);
		//PRINT("#### END UPDATE",0, 0,0);
		return ret;
	}
}
