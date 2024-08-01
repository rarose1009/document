/*----------------------------------------------------------------------------------
	Project Name:
	Smart Application : Ä«µå ±âº»Æû
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
----------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------
	Card Name : GM_REENTRY
	Card Desc : °ËÄ§µî·ÏÈ­¸é
	Card Hist :
----------------------------------------------------------------------------------*/
card GM_REENTRY
{
	#include <include.h>
	#include "globalcard.h"
	#include "SQL.lib"
	#include "Biglong.lib"
	
//	#define USE_ON_EXIT
	#define USE_ON_CHAR
	#define USE_ON_KEY
//	#define USE_ON_DRAW
//	#define USE_ON_TIMER 	
	#define USE_ON_POINTING
	#define USE_ON_SELECT
	#define USE_ON_UART
	
	#include "DefEvent.h"
	
	//---------------------------------------------------------------
	// BUTTON ID define
	//---------------------------------------------------------------
	BEGIN_BUTTON_ID()
		/****************************/
		/* °ËÄ§µî·Ï                 */
		/****************************/
		DEF_BUTTON_ID ( BID_ILLIGAL )	//ºÒ¹ý 
		DEF_BUTTON_ID ( BID_SC )		//¾ÈÀüÁ¡°Ë
		DEF_BUTTON_ID ( BID_NUM )		//»ó½Ã°è¼ö
		DEF_BUTTON_ID ( BID_MESSAGE )	//¸Þ¼¼Áö
		DEF_BUTTON_ID ( BID_BIZ )		//»ç¾÷ÀÚµî·ÏÁõ
		DEF_BUTTON_ID ( BID_ADDR1 )		//Áö¹ø
		DEF_BUTTON_ID ( BID_ADDR2 )		//»óÈ£
		DEF_BUTTON_ID ( BID_ADDR3 )		//°ø¹é
		DEF_BUTTON_ID ( BID_ADDR4 )		//±â¹°
		DEF_BUTTON_ID ( BID_ADDR5 )		//TEL
		DEF_BUTTON_ID ( BID_GMSND )		//°ËÄ§¼Û½ÅÈ­¸éÀ¸·Î ÀÌµ¿
		DEF_BUTTON_ID ( BID_TEL )		//ÀüÈ­°É±â 
		DEF_BUTTON_ID ( BID_USEQTY )	//»ç¿ë·®
		DEF_BUTTON_ID ( BID_SILSA )		//½Ç»ç
		DEF_BUTTON_ID ( BID_SMS_STS )	//¹®ÀÚ°ËÄ§¹ß¼ÛÁøÇà»óÅÂ

		DEF_BUTTON_ID ( BID_ZERO )		//0
		DEF_BUTTON_ID ( BID_ONE )		//1
		DEF_BUTTON_ID ( BID_TWO )		//2
		DEF_BUTTON_ID ( BID_THREE )		//3
		DEF_BUTTON_ID ( BID_FOUR )		//4
		DEF_BUTTON_ID ( BID_FIVE )		//5
		DEF_BUTTON_ID ( BID_SIX )		//6
		DEF_BUTTON_ID ( BID_SEVEN )		//7
		DEF_BUTTON_ID ( BID_EIGHT )		//8
		DEF_BUTTON_ID ( BID_NINE )		//9
		
		DEF_BUTTON_ID ( BID_PREVPG )	//ÀÌÀüÆäÀÌÁö
		DEF_BUTTON_ID ( BID_NEXTPG )	//´ÙÀ½ÆäÀÌÁö
		DEF_BUTTON_ID ( BID_NUMDEL )	//ÀÔ·Â¼ýÀÚ»èÁ¦
		DEF_BUTTON_ID ( BID_DELETE )	//»èÁ¦
		DEF_BUTTON_ID ( BID_SAVE )		//ÀúÀå
		DEF_BUTTON_ID ( BID_FEE )		//¿ä±Ý
		DEF_BUTTON_ID ( BID_CALCUL )	//°è»ê
		DEF_BUTTON_ID ( BID_CLIENT )	//°í°´
		DEF_BUTTON_ID ( BID_MEMO )		//¸Þ¸ð		
		DEF_BUTTON_ID ( BID_THMONTH )	//´ç¿ù
		DEF_BUTTON_ID ( BID_REMOTE )	//¿ø°ÝÁöÄ§
		
		DEF_BUTTON_ID ( BID_MTR_ID_NUM ) //±â¹°
		DEF_BUTTON_ID ( BID_MENU ) 		 //¸Þ´º
		
		/****************************/
		/* »ó¼¼ÁöÄ§³»¿ª             */
		/****************************/
		DEF_BUTTON_ID ( BID_OK )		//È®ÀÎ
		
		/****************************/
		/* »ó¼¼ÁöÄ§³»¿ª - º¸Á¤±â    */
		/****************************/
		DEF_BUTTON_ID ( BID_OK2 )		//È®ÀÎ
		
		/****************************/
		/* »ó½Ã°è¼öÀÔ·Â             */
		/****************************/
		DEF_BUTTON_ID ( BID_SAVE2 )		//ÀúÀå
		DEF_BUTTON_ID ( BID_CLOSE2 )	//´Ý±â
		DEF_BUTTON_ID ( BID_PHOTO_VC )	//VC»çÁø
		DEF_BUTTON_ID ( BID_PHOTO_VA )	//VA»çÁø
		DEF_BUTTON_ID ( BID_PHOTO_VM )	//VM»çÁø
		
		/****************************/
		/* »ç¿ë·® ÀÌ»ó ¼¼´ë         */
		/****************************/
		DEF_BUTTON_ID ( BID_POPPREV )
		DEF_BUTTON_ID ( BID_SAVE3 )		//ÀúÀå
		DEF_BUTTON_ID ( BID_BOX1 )		//Ã¼Å©¹Ú½º¹öÆ°
		DEF_BUTTON_ID ( BID_BOX2 )		//Ã¼Å©¹Ú½º¹öÆ°
		DEF_BUTTON_ID ( BID_BOX3 )		//Ã¼Å©¹Ú½º¹öÆ°
		DEF_BUTTON_ID ( BID_BOX4 )		//Ã¼Å©¹Ú½º¹öÆ°
		
		/****************************/
		/* º¸Á¤±â »èÁ¦              */
		/****************************/
		DEF_BUTTON_ID ( BID_COMPENS_SIGN )		//º¸Á¤±â_¼­¸í
		DEF_BUTTON_ID ( BID_COMPENS_CLOSE )		//º¸Á¤±â_´Ý±â
		DEF_BUTTON_ID ( BID_COMPENS_OK )		//º¸Á¤±â_ÀúÀå
		DEF_BUTTON_ID ( BID_COMPENS_CONF_NM )	//º¸Á¤±â_ÁöÄ§_È­¸éÀüÈ¯
		
	END_BUTTON_ID()
	
	//---------------------------------------------------------------
	// OBJECT ID define
	//---------------------------------------------------------------
	BEGIN_OBJECT_ID()
		/****************************/
		/* Å¸ÀÌÆ²                   */
		/****************************/
		DEF_OBJECT_ID ( TXT_TITLE )	
		DEF_OBJECT_ID ( ICON_TITLE )		
		
		/****************************/
		/* °ËÄ§                     */
		/****************************/
		DEF_BUTTON_ID ( TXT_ZERO )		//0
		DEF_BUTTON_ID ( TXT_ONE )		//1
		DEF_BUTTON_ID ( TXT_TWO )		//2
		DEF_BUTTON_ID ( TXT_THREE )		//3
		DEF_BUTTON_ID ( TXT_FOUR )		//4
		DEF_BUTTON_ID ( TXT_FIVE )		//5
		DEF_BUTTON_ID ( TXT_SIX )		//6
		DEF_BUTTON_ID ( TXT_SEVEN )		//7
		DEF_BUTTON_ID ( TXT_EIGHT )		//8
		DEF_BUTTON_ID ( TXT_NINE )		//9
		DEF_BUTTON_ID ( TXT_NUMDEL )	//¹é½ºÆäÀÌ½º
		DEF_BUTTON_ID ( TXT_PREVPG )	//ÀÌÀü
		DEF_BUTTON_ID ( TXT_NEXTPG )	//ÀÌÈÄ
		
		DEF_OBJECT_ID ( TXT_DATA1 )		//ÆäÀÌÁö¼ö
		DEF_OBJECT_ID ( TXT_DATA2 )		//°ËÄ§ÀÏ
		DEF_OBJECT_ID ( TXT_DATA3 )		//ÁÖ¼Ò
		DEF_OBJECT_ID ( TXT_DATA4 )		//¸Å¿ù
		DEF_OBJECT_ID ( TXT_DATA5 )		//»óÇ°
		DEF_OBJECT_ID ( TXT_DATA7 )		//»óÈ£
		DEF_OBJECT_ID ( TXT_DATA8 )		//Ã»±¸¹æ¹ý
		
		DEF_OBJECT_ID ( TXT_DATA11 )	//Àü¿ù
		DEF_OBJECT_ID ( TXT_DATA12 )	//ÀüÀü¿ù
		DEF_OBJECT_ID ( TXT_DATA13 )	//±³Ã¼ÀÏ
		DEF_OBJECT_ID ( TXT_DATA14 )	//±³Ã¼³¯Â¥
		DEF_OBJECT_ID ( TXT_DATA15 )	//ÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA16 )	//Àü¿ù°ËÄ§ÄÚµå_1 
		
		DEF_OBJECT_ID ( TXT_DATA17 )	//Àü¿ù°ËÄ§ÄÚµå_1, Àü¿ùÁöÄ§_º¸Á¤±â_VC_1 
		DEF_OBJECT_ID ( TXT_DATA18 )	//Àü¿ùÁöÄ§_º¸Á¤±â_VC_1, Àü¿ùÁöÄ§_°è·®±â_1
		DEF_OBJECT_ID ( TXT_DATA19 )	//Àü¿ù»ç¿ë·®_1, Àü¿ùÁöÄ§_º¸Á¤±â_VA_1 
		DEF_OBJECT_ID ( TXT_DATA20 )	//Àü¿ù°ËÄ§ÄÚµå_2, Àü¿ùÁöÄ§_°è·®±â_1, Àü¿ùÁöÄ§_º¸Á¤±â_VC_2 
		DEF_OBJECT_ID ( TXT_DATA21 )	//Àü¿ùÁöÄ§_º¸Á¤±â_VC_2, Àü¿ù°ËÄ§ÄÚµå_2
		DEF_OBJECT_ID ( TXT_DATA22 )	//Àü¿ù»ç¿ë·®_3, Àü¿ùÁöÄ§_º¸Á¤±â_VC_2 
		DEF_OBJECT_ID ( TXT_DATA23 )	//Àü¿ùÁöÄ§_º¸Á¤±â_VA_2 
		DEF_OBJECT_ID ( TXT_DATA24 )	//Àü¿ùÁöÄ§_°è·®±â_2 
		
		DEF_OBJECT_ID ( TXT_DATA97 )	//°í°´¼ºÇâ
		DEF_OBJECT_ID ( TXT_DATA98 )	//°ËÄ§¼Û´Þ¿©ºÎ
		DEF_OBJECT_ID ( TXT_DATA99 )	//°è·®±âÀ§Ä¡
		
		/****************************/
		/* »ó¼¼ÁöÄ§³»¿ª             */
		/****************************/
		DEF_OBJECT_ID ( TXT_DATA25 )	//±¸ºÐ
		DEF_OBJECT_ID ( TXT_DATA26 )	//Àü¿ùÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA27 )	//ÀüÀü¿ù
		DEF_OBJECT_ID ( TXT_DATA28 )	//Àü³âµ¿¿ù
		DEF_OBJECT_ID ( TXT_DATA29 )	//ÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA30 )	//ÁöÄ§_Àü¿ùÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA31 )	//ÁöÄ§_ÀüÀü¿ù
		DEF_OBJECT_ID ( TXT_DATA32 )	//ÁöÄ§_Àü³âµ¿¿ù
		DEF_OBJECT_ID ( TXT_DATA33 )	//»ç¿ë·®
		DEF_OBJECT_ID ( TXT_DATA34 )	//»ç¿ë·®_Àü¿ùÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA35 )	//»ç¿ë·®_ÀüÀü¿ù
		DEF_OBJECT_ID ( TXT_DATA36 )	//»ç¿ë·®_Àü³âµ¿¿ù
		
		/****************************/
		/* »ó¼¼ÁöÄ§³»¿ª_º¸Á¤±â      */
		/****************************/
		DEF_OBJECT_ID ( TXT_DATA37 )	//±¸ºÐ
		DEF_OBJECT_ID ( TXT_DATA38 )	//Àü¿ùÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA39 )	//ÀüÀü¿ù
		DEF_OBJECT_ID ( TXT_DATA40 )	//Àü³âµ¿¿ù
		DEF_OBJECT_ID ( TXT_DATA41 )	//VC
		DEF_OBJECT_ID ( TXT_DATA42 )	//VC_Àü¿ùÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA43 )	//VC_ÀüÀü¿ù
		DEF_OBJECT_ID ( TXT_DATA44 )	//VC_Àü³âµ¿¿ù
		DEF_OBJECT_ID ( TXT_DATA45 )	//VA
		DEF_OBJECT_ID ( TXT_DATA46 )	//VA_Àü¿ùÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA47 )	//VA_ÀüÀü¿ù
		DEF_OBJECT_ID ( TXT_DATA48 )	//VA_Àü³âµ¿¿ù
		DEF_OBJECT_ID ( TXT_DATA49 )	//VM
		DEF_OBJECT_ID ( TXT_DATA50 )	//VM_Àü¿ùÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA51 )	//VM_ÀüÀü¿ù
		DEF_OBJECT_ID ( TXT_DATA52 )	//VM_Àü³âµ¿¿ù
		DEF_OBJECT_ID ( TXT_DATA53 )	//»ç¿ë·®
		DEF_OBJECT_ID ( TXT_DATA54 )	//»ç¿ë·®_Àü¿ùÁöÄ§
		DEF_OBJECT_ID ( TXT_DATA55 )	//»ç¿ë·®_ÀüÀü¿ù
		DEF_OBJECT_ID ( TXT_DATA56 )	//»ç¿ë·®_Àü³âµ¿¿ù
		
		/****************************/
		/* »ó½Ã°è¼öÀÔ·Â             */
		/****************************/
		DEF_OBJECT_ID ( TXT_DATA57 )	//»ó½Ã¿Âµµ
		DEF_OBJECT_ID ( TXT_DATA58 )	//¡É
		DEF_OBJECT_ID ( TXT_DATA59 )	//»ó½Ã¾Ð·Â
		DEF_OBJECT_ID ( TXT_DATA60 )	//Kpa
		DEF_OBJECT_ID ( TXT_DATA61 )	//º¸Á¤°è¼ö
		
		/****************************/
		/* »ç¿ë·® ÀÌ»ó¼¼´ë          */
		/****************************/
		DEF_OBJECT_ID ( TXT_DATA62 )	//¼±ÅÃ
		DEF_OBJECT_ID ( TXT_DATA63 )	//±¸ºÐ
		DEF_OBJECT_ID ( TXT_DATA65 )	//Á¤»ó(»ç¿ë·® °¨¼Ò)	
		DEF_OBJECT_ID ( TXT_DATA67 )	//ºñÁ¤»ó(°è·®±â ÀÌ»ó)
		DEF_OBJECT_ID ( TXT_DATA69 )	//ºñÁ¤»ó(º¸Á¤ÀåÄ¡ ÀÌ»ó)
		DEF_OBJECT_ID ( TXT_DATA71 )	//ºñÁ¤»ó(±âÅ¸)
		
		/****************************/
		/* »ç¿ë·®(°è·®±â »ç¿ë·®)    */
		/****************************/
		DEF_OBJECT_ID ( TXT_USEQTY )	//EDT_DATA1 ¿¡¼­ ÅØ½ºÆ®·Î º¯°æ
		
		/****************************/
		/* º¸Á¤±â »èÁ¦              */
		/****************************/
		DEF_OBJECT_ID ( TXT_COMPENS_MAIN )		//TXT_º¸Á¤±â
		DEF_OBJECT_ID ( TXT_COMPENS_CONF_NM )	//TXT_È®ÀÎÀÚ
		DEF_OBJECT_ID ( EDT_COMPENS_CONF_NM )	//EDT_È®ÀÎÀÚ
		DEF_OBJECT_ID ( LINE_DATA1 )			//¶óÀÎ
		
		/****************************/
		/* LINE                     */
		/****************************/
		DEF_OBJECT_ID ( LINE_DATA_1 )	// ¶óÀÎ_1
		DEF_OBJECT_ID ( LINE_DATA_2 )	// ¶óÀÎ_2
		
		/****************************/
		/* EDIT                     */
		/****************************/
		//°ËÄ§µî·Ï
		DEF_OBJECT_ID ( EDT_VC )
		DEF_OBJECT_ID ( EDT_VA )
		DEF_OBJECT_ID ( EDT_VM )
		
		//»ó½Ã°è¼öÀÔ·Â
		DEF_OBJECT_ID ( EDT_DATA4 )
		DEF_OBJECT_ID ( EDT_DATA5 )
		DEF_OBJECT_ID ( EDT_DATA6 )
		
		/****************************/
		/* COMBO                    */
		/****************************/
		//°ËÄ§µî·Ï		
		DEF_OBJECT_ID ( CMB_RESULT )
	END_OBJECT_ID()
	
	//---------------------------------------------------------------
	// Define
	//---------------------------------------------------------------
	#define	EDITSETRANGE(h, x1, y1, x2, y2)		EditCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	#define	BUTSETRANGE(h, x1, y1, x2, y2)		ButCtrl_SetRange(h, DMS_X(x1),DMS_Y(y1), DMS_X(x2),DMS_Y(y2) )
	
	#define INIT_MAIN	 	   1 //Á¤»ó°ËÄ§
	#define INIT_JCHM	 	   2 //»ó¼¼ÁöÄ§³»¿ª
	#define INIT_BJCHM	 	   3 //»ó¼¼ÁöÄ§³»¿ª - º¸Á¤±â
	#define INIT_NUM	 	   4 //»ó½Ã°è¼öÀÔ·Â
	#define INIT_USE	 	   5 //»ç¿ë·® ÀÌ»ó¼¼´ë
	#define INIT_COMPENSREMOVE 6 //º¸Á¤±â »èÁ¦
	
	//ÁöÄ§ ÀÔ·Â°ª Refresh
	#define REFRESH_Y1  DMS_Y(STARTY)
	#define REFRESH_Y2  DMS_Y(STARTY+600)
	
	//¸Þ¼¼Áö¹Ú½º Refresh
	#define REFRESH_MSGY1  DMS_Y(STARTY-20)
	#define REFRESH_MSGY2  DMS_Y(STARTY+500)
	
	//---------------------------------------------------------------
	// Global Param
	//---------------------------------------------------------------
	handle m_hDlg;
	
	char m_szgr[11];
	char m_szbj[11];
	char m_sztp[11];
	char m_szZonemanagenum[20];	
	char m_szObjym[15];
	char m_szChkyear[10];
	char m_szChkorder[10];
	char m_szMtr_Code[11];		//´ç¿ù °ËÄ§ÄÚµå
	char szAddr[201];
	char m_szPhone[50];
	char m_szName[60];
	char m_szCnt_index[11];    	//ÀÎµ¦½º ¹®ÀÚ¿­(ÇöÀç ÆäÀÌÁö/ÃÑÆäÀÌÁö)
	char m_szIndiQty[11];
	
	char m_send_flag[2];
	char m_sms_desc_flag[2];
	char m_send_tel_flag[2];
	char m_szCpDdd[6];			//¹®ÀÚ°ËÄ§ ÀüÈ­¹øÈ£
	char m_szCpExn[6];			//¹®ÀÚ°ËÄ§ ÀüÈ­¹øÈ£
	char m_szCpNum[6];			//¹®ÀÚ°ËÄ§ ÀüÈ­¹øÈ£
	char m_szchktype[3];
	char m_szobjym[7];
	char m_szchkyear[5];
	char m_szchkorder[3];
	char m_szzone_manage_num[6];
	char m_szRcvDay[9];
	char m_beforeVc[11];
	char m_szfilenm[200];
	char m_szPhoto_CompensType[2];	//º¸Á¤±â »çÁø type : VC = 1, VA = 2, VM = 3
	
	long m_bFirst = 0;         	//È­¸é ÇÃ·¡±×
	long m_ltotcnt;
	long m_lNameFlag = 0;
    long m_lPhoneflag = 0;
    long m_lSmsDelFlag = 0;    	// = 0 default , = 1 ¹®ÀÚ´ë»ó -> ¾÷¹« Á¤»ó µî·Ï ½Ã »èÁ¦ , = 2 °ËÄ§Ãë¼Ò(»èÁ¦) ½Ã »èÁ¦
    long m_lSmsStsFlag = 0;    	// = 0 ¹®ÀÚ°ËÄ§ ´ë»ó »óÅÂ Ç¥½Ã , = 1 ¹®ÀÚ´ë»ó -> ¾÷¹« Á¤»ó(¹®ÀÚÃë¼Ò) µî·Ï ½Ã »óÅÂ , = 2 °ËÄ§Ãë¼Ò(»èÁ¦) ½Ã »óÅÂ, = 3 ¹®ÀÚ´ë»ó µî·Ï½Ã »óÅÂ
    long m_lSmsAgreeFlag = 0;  	// = 0 ¹®ÀÚ°ËÄ§ µ¿ÀÇ ¼¼´ë¿©ºÎ ¼ö½Å , = 1 ¹®ÀÚ°ËÄ§ µ¿ÀÇ ¼¼´ë¿©ºÎ ¼ö½Å X ÈÄ ¹®ÀÚ´ë»ó »óÅÂÃ¼Å©
	
	//ÆË¾÷,¾÷¹« ÀÌµ¿ ÈÄ ´Ù½Ã µ¹¾Æ¿ÔÀ»¶§, ÀÔ·ÂµÇ¾îÀÖ´Â °ªÀ» º¸Á¸ÇÏ±â À§ÇÑ flag	
	long m_lSetFlag = 0;		//m_lSetFlag = 0 > µðÆúÆ®		/ m_lSetFlag = 1 >¾÷¹« ÈÄ
	long m_lMonitorFlag = 0;	//ÀÌ»ó¼¼´ë ÇÃ·¡±×
	long m_lPrev = 0;	
	long m_lUserData = 0;		//°ËÄ§Ã¼Å©·ê
	long m_lEditCtrlIndex = -1; //ÇöÀç ¿¢Æ¼ºêµÈ EDITCTRLÀÇ ÀÎµ¦½º
	long m_lStyle = 0;
	long m_lChk = 0;
	long m_lLastSave = 0;		//¸¶Áö¸·´ë»ó ÀúÀå ½Ã ¹®ÀÚ°ËÄ§ ´ë»ó ¿©ºÎ¿¡ µû¸¥ »óÅÂ °ª ¼ö½Å °ü¸® Flag, = 0 ´ë»óX , = 1 ¹®ÀÚ´ë»óO
	long m_maxQtySaveCnt = 0;	// ÃÖ´ë »ç¿ë·® ³ÑÀº °æ¿ì ÀúÀå ¹öÆ° ´©¸¥ cnt
	char m_szIndiVc[10];
	
	//---------------------------------------------------------------
	// Function
	//---------------------------------------------------------------
	long FS_GetSrchTotCnt(void);	
	void SetStyle(void);
	void SetData(void);							// ½ºÆ®·°ÃÄ¿¡ Data´ã±â.
	void Set_Index(void);						// ¼±ÅÃµÈ ÀÎµ¦½º¸¦ ÀúÀåÇÑ´Ù.
	void SetTotCnt(void);						// °ËÄ§ ´ë»óÀÇ Ä«¿îÆ® ÀúÀå
	void REDRAW(void);							// È­¸é¿¡ ÀÚ·á µð½ºÇÃ·¹ÀÌÇÑ´Ù.
	void JCHM_DRAW(void);
	void NUM_DRAW(void);
	void COMPENSREMOVE_DRAW(void);
	void Prev_Gm(void);							// ÀÌÀü´ë»óÀ¸·Î ÀÎµ¦½º Ã£±â
	void Next_Gm(void);							// ´ÙÀ½´ë»óÀ¸·Î ÀÎµ¦½º Ã£±â
	bool Gm_ChkRule(void);						// °ËÄ§ Ã¼Å©·ê
	void Cal_UseQty(char *szIndi_VC);			// »ç¿ë·®°è»ê
	long Save_Gm(void);							// °ËÄ§ µ¥ÀÌÅÍ ÀúÀå
	void SaveInput(void);						// ÀÔ·Â°ª globalº¯¼ö¿¡ ÀúÀå, È­¸é ÀÌµ¿À¸·ÎºÎÅÍ ÀÔ·Â½ÃÅ² µ¥ÀÌÅÍ¸¦ º¸Á¸ÇÏ±âÀ§ÇØ!?
	void Del_Gm(void);
	long SearchStr(char *Str, CodeTable *CT);	// ÄÚµå °ªÀ» Ã£´Â´Ù.
	long SearchCD(char *CD, CodeTable *CT);		// ÄÚµå °ªÀ» Ã£´Â´Ù.
	void SetBtnImg(void);
	long Analy_Phone(char*phone, char* num1, char* num2, char* num3 );
	long Save_factor(void);
	long Chk_float( char * szfloat );
	long Sos_Key(void);
	void Clear_Flag(void);
	void Call_Tel(void);
	
	//¹®ÀÚ°ËÄ§ »óÅÂ
	long Rcv_Many(void);
	long TR25010(void);
	long Rcv_SmsSts(void);
	long TR25008(void);
	long GmSms_Sts(long nservicenum);
	
	//¹®ÀÚ°ËÄ§ ´ë»ó µî·Ï
	long Snd_Sms_New(void);
	long TR25004(void);
	
	//¹®ÀÚ ´ë»ó ¿¹¾àÃë¼Ò
	long Snd_Reserve_Cancel(void);
	long TR25006(void);
	
	//¹®ÀÚ ´ë»ó »èÁ¦ -> ¿¹¾à Ãë¼Ò ÈÄ »èÁ¦ ½ÇÇà
	long Snd_Delete(void);
	long TR25005(void);
	
	//°ËÄ§->Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å Äõ¸® Ãß°¡ ¿¹Á¤
	long safe_chkdata(void);
	long Read_RcvLog (void);
	long RCV311324(void);
	long TR311324(void);
	long RCV311317(void);
	long TR311317(void);
	long RCV311318(void);
	long TR311318(void);
	long RCV311311(void);
	long TR311311(void);
	long RCV311312(void);
	long TR311312(void);
	long RCV311313(void);
	long TR311313(void);
	long RCV311314(void);
	long TR311314(void);
	long RCV311315(void);
	long TR311315(void);
	long RCV311307(void);
	long TR311307(void);
	long RCV311308(void);
	long TR311308(void);
	long RCV311309(void);
	long TR311309(void);
	long RCV311310(void);
	long TR311310(void);
	long RCV311323(void);
	long TR311323(void);
	
	long Rcv_self_select(void);
	long TR25011(void);
	long SelfSelect(void);
	
	void fn_Compens_Sign(void);
	bool fn_Compens_Save(void);
	
	void Shoto_Photo_Compens( void );
	void FR26002( void );
	long TR26002( void );
	
	//---------------------------------------------------------------
	//	°øÅë
	//---------------------------------------------------------------
	SysButCtrl SysButRes_MAIN[] =
	{
		SYS_BUT_IMG( BTNX_1, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_HOME, 0 ),
		SYS_BUT_IMG( BTNX_2, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_KEYBOARD, 0 ),
		SYS_BUT_IMG( BTNX_3, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_SCREEN, 0 ),
		SYS_BUT_IMG( BTNX_4, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_CMMNWK, 0 ),
		SYS_BUT_IMG( BTNX_5, BTNY_1, BTNWD_1, BTNHT_1, 0, 0, BUTSTY_BOLD , 0, 0, 0, OBJ_BUT, GID_VMEXIT, 0 ),
		SYS_BUT_IMG( BTNX_6, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_MENU, 0 ),
		SYS_BUT_IMG( BTNX_7, BTNY_2, BTNWD_2, BTNHT_2, 0, 0, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, OBJ_BUT, GID_PREV, 0 ),
	};
	
	//---------------------------------------------------------------
	// ¸ÞÀÎ ´ÙÀÌ¾ó·Î±×
	//---------------------------------------------------------------
	DlgObject DlgRes[] =
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),	
		DLG_ICON(0, BTNY_2, ICON_TITLE, ""),
		
		DLG_TEXT(TX, TY, STWD, STHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "°ËÄ§ µî·Ï"),
		//DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_MENU, ""),
		
		DLG_BUTTON(STARTX,     STARTY+65 , 150, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_GMSND,   "¼Û½Å"),
		DLG_BUTTON(STARTX+150, STARTY+65 , 150, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ILLIGAL, "ºÒ¹ý"),
		DLG_BUTTON(STARTX+300, STARTY+65 , 150, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SC,      "Á¡°Ë"),
		//DLG_BUTTON(STARTX+450, STARTY+65 , 200, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MESSAGE, "¸Þ¼¼Áö"),
		//DLG_BUTTON(STARTX+650, STARTY+65 , 150, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SILSA, "½Ç»ç"),
		DLG_BUTTON(0, 0, 0, 0, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MESSAGE, "¸Þ¼¼Áö"),
		DLG_BUTTON(0, 0, 0, 0, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SILSA, "½Ç»ç"),
		DLG_TEXT ( STARTX+800, STARTY+65 , 100, 50 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, GREEN, TXT_DATA97, ""), 	// °í°´¼ºÇâ
		DLG_TEXT ( STARTX+900, STARTY+65 , 100, 50 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, GREEN, TXT_DATA98, ""), 	// °ËÄ§¼Û´Þ¿©ºÎ
		
		DLG_TEXT ( STARTX,     STARTY+115, 300, 50 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA1, m_szCnt_index),
		DLG_TEXT ( STARTX+300, STARTY+115, 100, 50 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA2, ""), 	// DAY
		DLG_BUTTON(STARTX+400, STARTY+115, 180, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NUM, ""), // »ó½Ã°è¼ö
		DLG_TEXT ( STARTX+580, STARTY+115, 150, 50 , 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA4, ""), // ¸Å
		DLG_TEXT ( STARTX+730, STARTY+115, 270, 50 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA5, ""), 
		
		DLG_BUTTON(STARTX,     STARTY+165, 130, 80 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR1, "Áö¹ø"),
		DLG_TEXT ( STARTX+130, STARTY+165, 870, 80 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA3, ""), 	// ÁÖ¼Ò
		
		DLG_BUTTON(STARTX,     STARTY+245, 130, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR2, "»óÈ£"),
		DLG_TEXT ( STARTX+130, STARTY+245, 500, 50 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA7, ""), 	// »óÈ£ ÅØ½ºÆ®
		DLG_TEXT ( STARTX+630, STARTY+245, 150, 50 , 0, 0, 0, EDITSTY_BORDER,      WHITE, TXTINCTRLBK, TXT_DATA99, ""), 
		DLG_TEXT ( STARTX+780, STARTY+245, 220, 50 , 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA8, ""), 	// »óÈ£ ÅØ½ºÆ®2
		DLG_BUTTON(STARTX+780, STARTY+245, 220, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SMS_STS, ""),
		
		DLG_BUTTON(STARTX,     STARTY+295, 130, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR4, "±â¹°"),
	 	
		DLG_BUTTON(STARTX+130, STARTY+295, 370, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MTR_ID_NUM, ""),
		
		DLG_BUTTON(STARTX+500, STARTY+295, 110, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_ADDR5, "HP"),	
		DLG_BUTTON(STARTX+610, STARTY+295, 390, 50 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_TEL, ""),
		
		/**********************************/
		/* ¼ýÀÚÆÇ & ±âÅ¸ È­¸é ¹öÆ°        */
		/**********************************/
		DLG_TEXT ( STARTX,     STARTY+605, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_ONE  , "1"),
		DLG_TEXT ( STARTX+196, STARTY+605, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_TWO  , "2"),
		DLG_TEXT ( STARTX+392, STARTY+605, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_THREE, "3"),
		DLG_TEXT ( STARTX+588, STARTY+605, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_NUMDEL , "¡ç"),
		DLG_BUTTON(STARTX+784, STARTY+605, 216, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_FEE, "¿ä±Ý"),
		
		DLG_TEXT ( STARTX,     STARTY+678, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_FOUR , "4"),
		DLG_TEXT ( STARTX+196, STARTY+678, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_FIVE , "5"),
		DLG_TEXT ( STARTX+392, STARTY+678, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_SIX  , "6"),
		DLG_BUTTON(STARTX+588, STARTY+678, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_DELETE, "»èÁ¦"),
		DLG_BUTTON(STARTX+784, STARTY+678, 216, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CALCUL, "°è»ê"),
		
		DLG_TEXT ( STARTX,     STARTY+751, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_SEVEN, "7"),
		DLG_TEXT ( STARTX+196, STARTY+751, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_EIGHT, "8"),
		DLG_TEXT ( STARTX+392, STARTY+751, 196, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_NINE , "9"),
		DLG_BUTTON(STARTX+588, STARTY+751, 196, 148, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, CORAL, CALL_FUNC , "", BID_SAVE, "ÀúÀå"),
		DLG_BUTTON(STARTX+784, STARTY+751, 216, 73 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLIENT, "°í°´"),
		
		//DLG_BUTTON(STARTX,     STARTY+824, 196, 75 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_PREVPG, "¢¸"),
		//DLG_TEXT ( STARTX+196, STARTY+824, 196, 75 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_ZERO , "0"),
		//DLG_BUTTON(STARTX+392, STARTY+824, 196, 75 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_NEXTPG, "¢º"),
		
		DLG_TEXT ( STARTX,     STARTY+824, 196, 75 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_PREVPG , "¢¸"),
		DLG_TEXT ( STARTX+196, STARTY+824, 196, 75 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_ZERO , "0"),
		DLG_TEXT ( STARTX+392, STARTY+824, 196, 75 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, TXT_NEXTPG , "¢º"),
		
		DLG_BUTTON(STARTX+784, STARTY+824, 216, 75 , 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_MEMO, "¸Þ¸ð"),
		
		/**********************************/
		/* ÀåÄ¡ Å¸ÀÔ¿¡ µû¶ó ´Þ¶óÁö´Â È­¸é */
		/**********************************/
		DLG_BUTTON(0, 0, 0, 0, 0,  0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_THMONTH, "´ç¿ù"),
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA11, "Àü¿ù"),   	// Àü¿ù		
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA12, "ÀüÀü¿ù"), 	// ÀüÀü¿ù		
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA13, "±³Ã¼ÀÏ"), 	// ±³Ã¼ÀÏ
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA14, ""),  	   	// ±³Ã¼³¯Â¥
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA15, "ÁöÄ§"),
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA16, ""),
		DLG_BUTTON(0, 0, 0, 0, 0, 20, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_USEQTY, ""),	
		DLG_BUTTON(0, 0, 0, 0, 0, 20, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_REMOTE, ""),	
		
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA17, ""),
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA18, ""),
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA19, ""),
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA20, ""),
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA21, ""),				
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA22, ""),
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA23, ""),
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA24, ""),
		
		DLG_TEXT ( 0, 0, 0, 0, 0,  0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_USEQTY, ""), // »ç¿ë·®(°è·®±â)
		DLG_EDIT ( 0, 0, 0, 0, 0,  0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_VC, 10,  ""),
		DLG_EDIT ( 0, 0, 0, 0, 0,  0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_VA, 10,  ""),
		DLG_EDIT ( 0, 0, 0, 0, 0,  0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_VM, 10,  ""),
	
		DLG_COMBO( 0, 0, 0, 0, 0,  0, TXTFRCOLOR, TXTINCTRLBK, CALL_FUNC, "", CMB_RESULT, 4),	// °ËÄ§ÄÚµå
	};	
	
	//---------------------------------------------------------------
	//  ´ÙÀÌ¾ó·Î±×:»ó¼¼ÁöÄ§³»¿ª
	//---------------------------------------------------------------
	DlgObject	DlgRes_JCHM[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "»ó¼¼ ÁöÄ§ ³»¿ª"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK, ""),
		
		DLG_TEXT ( STARTX ,    STARTY-29 , 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA25, "±¸ºÐ"),
		DLG_TEXT ( STARTX+250, STARTY-29 , 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA26, "Àü¿ùÁöÄ§"),
		DLG_TEXT ( STARTX+500, STARTY-29 , 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA27, "ÀüÀü¿ù"),
		DLG_TEXT ( STARTX+750, STARTY-29 , 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA28, "Àü³âµ¿¿ù"),
		
		DLG_TEXT ( STARTX ,    STARTY+51 , 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA29, "ÁöÄ§"),
		DLG_TEXT ( STARTX+250, STARTY+51 , 250, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA30, ""),
		DLG_TEXT ( STARTX+500, STARTY+51 , 250, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA31, ""),
		DLG_TEXT ( STARTX+750, STARTY+51 , 250, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA32, ""),
		DLG_TEXT ( STARTX ,    STARTY+131, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA33, "»ç¿ë·®"),
		DLG_TEXT ( STARTX+250, STARTY+131, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA34, ""),
		DLG_TEXT ( STARTX+500, STARTY+131, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA35, ""),
		DLG_TEXT ( STARTX+750, STARTY+131, 250, 80, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA36, ""),
		
		DLG_BUTTON(STARTX+650, STARTY+250, 350, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK,  "È®ÀÎ"),
	};
	
	//---------------------------------------------------------------
	//  ´ÙÀÌ¾ó·Î±×:»ó¼¼ÁöÄ§³»¿ª - º¸Á¤±â
	//---------------------------------------------------------------
	DlgObject	DlgRes_BJCHM[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "»ó¼¼ ÁöÄ§ ³»¿ª-º¸Á¤±â"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_OK2, ""),
		
		DLG_TEXT ( STARTX,     STARTY-29 , 250, 90, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA37, "±¸ºÐ"),
		DLG_TEXT ( STARTX+250, STARTY-29 , 250, 90, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA38, "Àü¿ùÁöÄ§"),
		DLG_TEXT ( STARTX+500, STARTY-29 , 250, 90, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA39, "ÀüÀü¿ù"),
		DLG_TEXT ( STARTX+750, STARTY-29 , 250, 90, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA40, "Àü³âµ¿¿ù"),
		DLG_TEXT ( STARTX,     STARTY+61 , 250, 90, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA41, "VC"),
		DLG_TEXT ( STARTX+250, STARTY+61 , 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA42, ""),
		DLG_TEXT ( STARTX+500, STARTY+61 , 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA43, ""),
		DLG_TEXT ( STARTX+750, STARTY+61 , 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA44, ""),
		DLG_TEXT ( STARTX,     STARTY+151, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA45, "VA"),
		DLG_TEXT ( STARTX+250, STARTY+151, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA46, ""),
		DLG_TEXT ( STARTX+500, STARTY+151, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA47, ""),
		DLG_TEXT ( STARTX+750, STARTY+151, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA48, ""),
		DLG_TEXT ( STARTX,     STARTY+241, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA49, "VM"),
		DLG_TEXT ( STARTX+250, STARTY+241, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA50, ""),
		DLG_TEXT ( STARTX+500, STARTY+241, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA51, ""),
		DLG_TEXT ( STARTX+750, STARTY+241, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA52, ""),
		DLG_TEXT ( STARTX,     STARTY+331, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK,   TXT_DATA53, "»ç¿ë·®"),
		DLG_TEXT ( STARTX+250, STARTY+331, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA54, ""),
		DLG_TEXT ( STARTX+500, STARTY+331, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA55, ""),
		DLG_TEXT ( STARTX+750, STARTY+331, 250, 90, 0,0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA56, ""),
		
		DLG_BUTTON(STARTX+650, STARTY+450, 350, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_OK2,  "È®ÀÎ"),
	};
	
	//---------------------------------------------------------------
	//  ´ÙÀÌ¾ó·Î±×:»ó½Ã°è¼öÀÔ·Â
	//---------------------------------------------------------------
	DlgObject	DlgRes_NUM[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "»ó½Ã °è¼ö ÀÔ·Â"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_CLOSE2, ""),
		
		DLG_TEXT ( STARTX,      STARTY  -29,  300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA57, "»ó½Ã¿Âµµ"),	
		DLG_EDIT ( STARTX +300, STARTY  -29,  550, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA4, 7,  ""),	
		DLG_TEXT ( STARTX +850, STARTY  -29,  150, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA58, "¡É"),
			
		DLG_TEXT ( STARTX,      STARTY  +41,  300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA59, "»ó½Ã¾Ð·Â"),
		DLG_EDIT ( STARTX +300, STARTY  +41,  550, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA5, 7,  ""),
		DLG_TEXT ( STARTX +850, STARTY  +41,  150, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA60, "Kpa"),
		
		DLG_TEXT ( STARTX,      STARTY +111,  300, 70, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA61, "º¸Á¤°è¼ö"),
		DLG_EDIT ( STARTX +300, STARTY +111,  700, 70, 0, 0, EDITSTY_BOLD, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_DATA6, 7,  ""),
		
		DLG_LINE ( STARTX,      STARTY +185, 1000, STARTY +185, DARKSLATEBLUE, 10, LINE_DATA_1),
		
		DLG_BUTTON(STARTX,      STARTY +190,  330, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, YELLOW, CALL_FUNC , "", BID_PHOTO_VC,  "VC»çÁø"),
		DLG_BUTTON(STARTX +330, STARTY +190,  340, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, YELLOW, CALL_FUNC , "", BID_PHOTO_VA,  "VA»çÁø"),
		DLG_BUTTON(STARTX +670, STARTY +190,  330, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, YELLOW, CALL_FUNC , "", BID_PHOTO_VM,  "VM»çÁø"),
		
		DLG_LINE ( STARTX,      STARTY +274, 1000, STARTY +274, DARKSLATEBLUE, 10, LINE_DATA_2),
	
		DLG_BUTTON(STARTX,      STARTY +279,  500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_CLOSE2,  "´Ý±â"),
		DLG_BUTTON(STARTX +500, STARTY +279,  500, 80, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE2,  "ÀúÀå"),
	};
	
	//---------------------------------------------------------------
	//  ´ÙÀÌ¾ó·Î±×:»ç¿ë·® ÀÌ»ó¼¼´ë
	//---------------------------------------------------------------
	DlgObject	DlgRes_USE[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "»ç¿ë·® ÀÌ»ó¼¼´ë"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_SAVE3, ""),
		
		DLG_TEXT ( STARTX,     STARTY-29 , 300, 90, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA62, "¼±ÅÃ"),
		DLG_TEXT ( STARTX+300, STARTY-29 , 700, 90, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_DATA63, "±¸ºÐ"),
		
		DLG_BUTTON(STARTX,     STARTY+61 , 300, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX1,  CHKOFF),
		DLG_TEXT ( STARTX+300, STARTY+61 , 700, 90, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA65, "Á¤»ó(»ç¿ë·® °¨¼Ò)"),
		
		DLG_BUTTON(STARTX, 	   STARTY+151, 300, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX2,  CHKOFF),
		DLG_TEXT ( STARTX+300, STARTY+151, 700, 90, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA67, "ºñÁ¤»ó(°è·®±â ÀÌ»ó)"),
		
		DLG_BUTTON(STARTX,     STARTY+241, 300, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX3,  CHKOFF),
		DLG_TEXT ( STARTX+300, STARTY+241, 700, 90, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA69, "ºñÁ¤»ó(º¸Á¤ÀåÄ¡ ÀÌ»ó)"),
		
		DLG_BUTTON(STARTX,     STARTY+331, 300, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNCHKFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_BOX4,  CHKOFF),
		DLG_TEXT ( STARTX+300, STARTY+331, 700, 90, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, TXT_DATA71, "ºñÁ¤»ó(±âÅ¸)"),
		
		DLG_BUTTON(STARTX+650, STARTY+480, 350, 90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_SAVE3,  "ÀúÀå"),
	};
	
	//---------------------------------------------------------------
	//  ´ÙÀÌ¾ó·Î±×:º¸Á¤±â »èÁ¦
	//---------------------------------------------------------------
	DlgObject	DlgRes_COMPENSREMOVE[] = 
	{
		NORM_DLG ("", "", DLGSTY_HSCROLLBAR|DLGSTY_VSCROLLBAR|DLGSTY_TITLE, 0, MAINBKCOLOR, WHITE, BLUE, TITLE_HEIGHT, 0),
		DLG_ICON(POPTX, POPTY, ICON_TITLE, ""),
		DLG_TEXT(POPTX, POPTY, POPSTWD, POPSTHT, 0, 0, EDITSTY_BORDER, EDITSTY_BOLD, TTLCTRLFR, TTLCTRLBK, TXT_TITLE, "º¸Á¤ÀåÄ¡ °íÀå È®ÀÎ¼­"),
		DLG_BUTTON(BTNX_7, P_BTNY, BTNWD_2, BTNHT_2, 0, 0, EDITSTY_BORDER, 0, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_COMPENS_CLOSE, ""),
		
		DLG_TEXT ( STARTX,     STARTY- 29, 1000, 652, 0, 0, 0, EDITSTY_BORDER|EDITSTY_BOLD, TXTFRCOLOR, EDTCTRLBK, TXT_COMPENS_MAIN, ""),
		
		DLG_TEXT ( STARTX,     STARTY+623,  330,  90, 0, 0, 0, EDITSTY_BORDER, TXTTTLFRCOLOR, TXTCTRLBK, TXT_COMPENS_CONF_NM, "È®ÀÎÀÚ"),
		
		DLG_BUTTON(STARTX+330, STARTY+623,  670,  90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLMNBKCOLOR, CALL_FUNC , "", BID_COMPENS_CONF_NM, ""),
		DLG_TEXT ( STARTX+330, STARTY+623,  670,  90, 0, 0, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, EDT_COMPENS_CONF_NM, ""),
		
		DLG_BUTTON(STARTX, 	   STARTY+713, 1000,  90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPENS_SIGN, "¼­¸í"),
		
		DLG_LINE ( STARTX,     STARTY+806, 1000, STARTY+806, DARKSLATEBLUE, 8, LINE_DATA1),
		
		DLG_BUTTON(STARTX,     STARTY+810,  500,  90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPENS_CLOSE, "Ãë¼Ò"),
		DLG_BUTTON(STARTX+500, STARTY+810,  500,  90, 0, 0, BUTSTY_BOLD, BUTSTY_BORDER, BTNMENUFRCOLOR, BTNCTRLBKCOLOR, CALL_FUNC , "", BID_COMPENS_OK,  "ÀúÀå"),
	};
	
	//---------------------------------------------------------------
	//	main 
	//---------------------------------------------------------------
	bool main(quad MsgType, quad wParam, quad lParam)
	{
		EVENT_HANDLER (MsgType, wParam, lParam);		
		return TRUE;
	}
	
	//---------------------------------------------------------------
	// OnInit Function
	//---------------------------------------------------------------	
	void OnInit(char bFirst)
	{
		long i;
		char szPhoneNum[32];
		char szPhoneNum1[5];
		char szPhoneNum2[5];
		char szPhoneNum3[5];
		char szToday[20];
		long lEndDate, lToDate;
		
		m_bFirst = bFirst;
		
		switch (bFirst)
		{
			/*************************/
			/* °ËÄ§µî·Ï              */
			/*************************/
			case INIT_MAIN:
				
				CREATE_GLOBAL_BUTTON (SysButRes_MAIN);
				CREATE_DIALOG_OBJECT (DlgRes, SIZEOF(DlgRes));
					
				SetBtnImg();
				SetTotCnt();
				
				g_nGmType = 1; // Á¤»ó°ËÄ§, Àç°Ë ±¸ºÐ 
				
				for ( i = 0 ;  RE_GM_CODE[i].Str[0] != 0 ; i++)
				{
					ListCtrl_AddItem (Get_hDlgCtrlByID(CMB_RESULT+2), RE_GM_CODE[i].Str, 0, ICON_NONE);
				}
				
				// Ã³À½ È­¸é µé¾î¿ÔÀ»½Ã ÇÑ¹ø¸¸ ½ÇÇà.
				if( g_lDataflag == 0 )
				{
					g_nSmsSndFlag = 0;
					SetData();
					SetStyle();
					REDRAW();
				}
				else
				{
					// SetData();
					SetStyle();
					REDRAW();
					
					//ÀÚ°¡°ËÄ§ ¿©ºÎ Ã¼Å©
					if( Str_Cmp(stGm.SELF_GMTR_YN, "Y") == 0 )
					{
						lToDate = Time_GetDate();
						lEndDate = Str_AtoI( stGm.SELF_GMTR_END_YMD );
						
						Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
						Str_ItoA(Time_GetDate(), szToday, 10); //0502
						
						// ÀÚ°¡°ËÄ§ ¼¼´ë¸é¼­ °ËÄ§°ü¸®»óÅÂ°¡ ´ë»óÁ¦¿ÜÀÎ°æ¿ì ÀÔ·Â ºÒ°¡
						if (Str_Cmp(stGm.MTR_LOC_FLAG, "20") == 0 && lEndDate > 0 && (lEndDate > lToDate))
						{
							MessageBoxEx(CONFIRM_OK, "ÀÚ°¡°ËÄ§ ±â°£ÀÌÁö¸¸ °è·®±â°¡ ¿ÜºÎ¿¡ ÀÖ¾î PDA°ËÄ§µµ °¡´ÉÇÕ´Ï´Ù.");

							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE);
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE );
							
							Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);	
						}
						else if( lEndDate > 0  && ( lToDate > lEndDate ) && Str_Cmp(stGm.GMTR_MANAGE_STS, "70") != 0 )
						{
							MessageBoxEx(CONFIRM_OK, "ÀÚ°¡°ËÄ§¼¼´ëÀÌÁö¸¸\nµî·Ï±â°£ÀÌ °æ°úµÇ¾î\nPDA°ËÄ§ÀÌ °¡´ÉÇÕ´Ï´Ù.");
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE);
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE );	
						}
						else if(Str_Cmp(stGm.MTR_LOC_FLAG, "10") == 0  && Str_Cmp(stGm.GMTR_JOB_YMD_END,szToday) == 0 )
						{
							MessageBoxEx(CONFIRM_OK, "ÀÚ°¡°ËÄ§ ±â°£ÀÌÁö¸¸ \n °è·®±â°¡ ³»ºÎ¿¡ ÀÖ°í \n ±ÝÀÏ °ËÄ§Á¾·áÀÏÀÌ¶ó PDA°ËÄ§ÀÌ °¡´ÉÇÕ´Ï´Ù.");
							// 20190129_¸¶°¨ÀÏº¯°æ °³¼±
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE);
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE );
							
							Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						}
						else
						{
							MessageBoxEx(CONFIRM_OK, "ÀÚ°¡°ËÄ§¼¼´ë´Â ÀÔ·ÂºÒ°¡ÇÕ´Ï´Ù _INIT_.");
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
							
							DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
							
							DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE);
							DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE );
							
							if( Str_Cmp(stGm.GMTR_MANAGE_STS, "70") == 0 && Str_Cmp(stGm.DEADLINE_CHG_YN, "Y") == 0 && Str_Cmp(stGm.SELF_GMTR_YN, "Y") == 0)
							{
								EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_RESULT), "¸¶°¨º¯°æ" );
								MessageBoxEx(CONFIRM_OK, "[¸¶°¨ÀÏº¯°æ¼¼´ë]´Â\nÀÔ·ÂºÒ°¡ÇÕ´Ï´Ù.");
							}
							else
							{
								EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_RESULT), "ÀÚ°¡°ËÄ§" );
								MessageBoxEx(CONFIRM_OK, "[ÀÚ°¡°ËÄ§¼¼´ë]´Â\nÀÔ·ÂºÒ°¡ÇÕ´Ï´Ù.");
							}	
						}
					}
					else if( Str_Cmp(stGm.REMOTE_GMTR_YN, "Y") == 0 )
					{
						DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_REMOTE), TRUE);
						ButCtrl_SetText(Get_hDlgCtrlByID(BID_REMOTE), "¿ø°ÝÁöÄ§");
						BUTSETRANGE(Get_hDlgCtrlByID(BID_REMOTE),	STARTX+500, STARTY+345,  785, 510);	
					}
				}

				if( Str_Cmp(stGm.SMS_GMTR_MAN_YN, "Y") == 0 || Str_Cmp(stGm.BEFO_GMTR_SMS_YN, "Y") == 0 )
				{
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), TRUE);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS_STS), RED);
					m_lSmsStsFlag = 0;
					Rcv_SmsSts();
				}
				else
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_SMS_STS), "");
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS_STS), BTNMENUFRCOLOR);
					DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), FALSE);
					
					if( Str_Cmp(stGm.SELF_GMTR_YN, "Y") == 0 )
					{
						Rcv_self_select();
					}
				}
				
				ON_DRAW();
				
				// »ç¿ë·® ÀÌ»ó¼¼´ë ¼³Á¤ ÈÄ °ËÄ§ÀúÀå
				if( m_lChk > 0 || g_nSmsSndFlag == 1 )
				{
					OnButton(BID_SAVE);
				}
				
				break;
			
			/*************************/
			/* »ó¼¼ÁöÄ§³»¿ª          */
			/*************************/
			case INIT_JCHM:
				
				CREATE_DIALOG_OBJECT (DlgRes_JCHM, SIZEOF(DlgRes_JCHM));
				
				SetBtnImg();
				JCHM_DRAW();
				
				break;
			
			/*************************/
			/* »ó¼¼ÁöÄ§³»¿ª - º¸Á¤±â */
			/*************************/
			case INIT_BJCHM:
				
				CREATE_DIALOG_OBJECT (DlgRes_BJCHM, SIZEOF(DlgRes_BJCHM));	
				
				SetBtnImg();
				JCHM_DRAW();
				
				break;
			
			/*************************/
			/* »ó½Ã°è¼öÀÔ·Â          */
			/*************************/
			case INIT_NUM:
				
				CREATE_DIALOG_OBJECT (DlgRes_NUM, SIZEOF(DlgRes_NUM));
					
				SetBtnImg();
				NUM_DRAW();
				
				break;
			
			/*************************/
			/* »ç¿ë·® ÀÌ»ó¼¼´ë       */
			/*************************/
			case INIT_USE:
				
				CREATE_DIALOG_OBJECT (DlgRes_USE, SIZEOF(DlgRes_USE));
				
				SetBtnImg();
				m_lChk = 0;
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA62), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA63), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA65), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA67), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA69), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA71), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				
				break;
				
			/*************************/
			/* º¸Á¤±â °íÀå ¼­¸í      */
			/*************************/
			case INIT_COMPENSREMOVE:
			
				CREATE_DIALOG_OBJECT (DlgRes_COMPENSREMOVE, SIZEOF(DlgRes_COMPENSREMOVE));
				
				SetBtnImg();
				COMPENSREMOVE_DRAW();
				
				break;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : OnKey
	±â  ´É : Å°¼³Á¤
	Param  : 
	Return :
	========================================================================================*/
	void OnKey(long nKey)
	{
		long i;
		char szMtr_Code[10];
		
		if( m_bFirst == INIT_MAIN)
		{
			// ¹é½ºÆäÀÌ½º Å° »ç¿ë½Ã »ç¿ë·® °è»ê
			if( nKey == 5  && m_lUserData == 10 )
			{
				if( Str_AtoI(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC))) > 0 )
				{
					Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
					Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
					Cal_UseQty(stGm.INDI_SET_VC);
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), m_szIndiQty);
				}
				else if( nKey != 10 )
				{
					Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
					Str_Cpy(m_szIndiQty, "0");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "0");
				}
			}
			// ³ª¸ÓÁö Å° »ç¿ë½Ã
			else
			{
				if( Str_AtoI(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC))) > 0 )
				{
					Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
					Mem_Set( (byte*)szMtr_Code, 0x00, sizeof(szMtr_Code));
					Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
					
					i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)), RE_GM_CODE );
					
					if(i >= 0)
					{
						Str_Cpy(szMtr_Code, RE_GM_CODE[i].Code);
					}

					if( nKey != 10 )
					{
						if( Str_Cmp(szMtr_Code, "3") == 0 )
						{
							Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
							EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
						}
						else
						{
							Cal_UseQty( stGm.INDI_SET_VC );
							EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), m_szIndiQty);
						}
					}
				}
				else if( nKey != 10 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "0");
					Str_Cpy(m_szIndiQty, "0");
				}
			}
			
			ON_DRAW();
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : OnChar
	±â  ´É : Å°º¸µå ¼³Á¤
	Param  : 
	Return : 
	========================================================================================*/
	void OnChar(long nChar)
	{
		long i;
		long nLen = 0;
		char szMtr_Code[13];
		char strMsg[100];
		
		if( m_bFirst == INIT_MAIN )
		{
			// ¼ýÀÚ¸¸ ÀÔ·Â °¡´É
			if( (nChar < 48 ||  nChar > 57) )
			{
				MessageBoxEx (ERROR_OK, "¼ýÀÚ¸¸ ÀÔ·Â°¡´ÉÇÕ´Ï´Ù.");
				EditCtrl_SetStr(Get_hDlgCtrlByIndex(m_lEditCtrlIndex), "");
				
				if( m_lUserData == 10 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
					Str_Cpy(m_szIndiQty, "");
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
					Str_Cpy(m_szIndiQty, "");
				}
				
				ON_DRAW();
				return;
			}
		
			//ÀÔ·Â ½Ã »ç¿ë·® ÀÚµ¿ °è»ê
			if( Get_iDlgCtrlByID(EDT_VC) == m_lEditCtrlIndex )
			{
				//2017.01.25 È²¿µÀÚ °úÀå´Ô ¿äÃ», °è·®±â ÁöÄ§VC ÀÚ¸´¼ö Ã¼Å©, szMtr_digit_cnt
				nLen = g_GetUtf8Size(EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));

				if( nLen > Str_AtoI(stGm.MTR_DIGIT_CNT) )
				{
					Mem_Set((byte *)strMsg, 0x00, sizeof(strMsg));

					Str_Cpy(strMsg, "°è·®±â ÁöÄ§ ÀÚ¸´¼ö¸¦ ÃÊ°úÇÏ¿´½À´Ï´Ù.\n ");
					Str_Cat(strMsg, "\n°è·®±â¹øÈ£ : ");
					Str_Cat(strMsg, stGm.MTR_NUM);
					Str_Cat(strMsg, "\nÁöÄ§ ÃÖ´ë ÀÚ¸´¼ö : ");
					Str_Cat(strMsg, stGm.MTR_DIGIT_CNT);;
					
					MessageBoxEx(ERROR_OK, strMsg);
					// ³Ñ¾î°¡¸é ¸¶Áö¸· char »èÁ¦
					ON_KEY( 5 );
					//return;
				}
				
				if( m_lUserData == 10 )
				{
					Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
					Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
					Cal_UseQty( stGm.INDI_SET_VC );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), m_szIndiQty);
					
					/* 2018.01.29 È²¿µÀÚ °úÀå´Ô ¿äÃ» : »ç¿ë·® Ã¼Å© ·ÎÁ÷ Á¦¿Ü
					if( m_szMtr_Code[0] != '6' )
					{
						if( Str_AtoI(m_szIndiQty) > Str_AtoI(stGm.MAX_GMTR_QTY) )
						{
							Mem_Set((byte *)strMsg, 0x00, sizeof(strMsg));
							
							Str_Cpy(strMsg, "ÃÖ´ë »ç¿ë·®À» ÃÊ°úÇÏ¿´½À´Ï´Ù.\n ");
							Str_Cat(strMsg, "\nÇöÀç »ç¿ë·® : ");
							Str_Cat(strMsg, m_szIndiQty);
							Str_Cat(strMsg, "\nÃÖ´ë »ç¿ë·® : ");
							Str_Cat(strMsg, stGm.MAX_GMTR_QTY);
							
							MessageBoxEx(ERROR_OK, strMsg);

							ON_DRAW();
							return;
						}
					}
					*/
				}
				else
				{
					Mem_Set( (byte*)szMtr_Code, 0x00, sizeof(szMtr_Code));
					Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
					
					Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
					
					i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)), RE_GM_CODE );
					
					if (i == -1)
					{
						Str_Cpy(m_szMtr_Code, RE_GM_CODE[0].Code);
					}
					else
					{
						Str_Cpy(m_szMtr_Code, RE_GM_CODE[i].Code);
					}

					if( m_szMtr_Code[0] == '3' )
					{
						Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
						EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
					}
					else
					{
						Cal_UseQty( stGm.INDI_SET_VC );
						EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), m_szIndiQty);
						
						/* 2018.01.29 È²¿µÀÚ °úÀå´Ô ¿äÃ» : »ç¿ë·® Ã¼Å© ·ÎÁ÷ Á¦¿Ü
						if( Str_AtoI(m_szIndiQty) > Str_AtoI(stGm.MAX_GMTR_QTY) )
						{
							Mem_Set((byte *)strMsg, 0x00, sizeof(strMsg));
							
							Str_Cpy(strMsg, "ÃÖ´ë »ç¿ë·®À» ÃÊ°úÇÏ¿´½À´Ï´Ù.\n ");
							Str_Cat(strMsg, "\nÇöÀç »ç¿ë·® : ");
							Str_Cat(strMsg, m_szIndiQty);
							Str_Cat(strMsg, "\nÃÖ´ë »ç¿ë·® : ");
							Str_Cat(strMsg, stGm.MAX_GMTR_QTY);
							
							MessageBoxEx(CONFIRM_OK, strMsg);

							ON_DRAW();
							return;
						}
						*/
					}
				}
			}

			ON_DRAW();
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : OnPointing
	±â  ´É : Å° ´©¸§
	Param  : 
	Return : 
	========================================================================================*/
	void OnPointing(long nAction, long X, long Y)
	{
		long lActiveIndex = -1;

		//EDITCTRL¿¡ ACTIVE½Ã¿¡ CTRLINDEX¸¦ ÀúÀå
		//Å°º¸µå BUTTONCTRLÀÌ ACTIVE½Ã¿¡µµ EDITCTRL¿¡ Ä¿¼­¸¦ µÎ±âÀ§ÇØ¼­ INDEX¸¦ ÀúÀå
		lActiveIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);	

		if( m_bFirst == INIT_MAIN )
		{
			if( 10 == m_lUserData )
			{
				if( Get_iDlgCtrlByID(EDT_VC) == lActiveIndex )
				{
					m_lEditCtrlIndex = lActiveIndex;
				}
			}
			else if( 20 == m_lUserData )
			{
				if( Get_iDlgCtrlByID(EDT_VM) == lActiveIndex )
				{
					m_lEditCtrlIndex = lActiveIndex;
				}
				else if( Get_iDlgCtrlByID(EDT_VA) == lActiveIndex )
				{
					m_lEditCtrlIndex = lActiveIndex;
				}
				else if( Get_iDlgCtrlByID(EDT_VC) == lActiveIndex )
				{
					m_lEditCtrlIndex = lActiveIndex;
				}
			}
			else
			{
				if( Get_iDlgCtrlByID(EDT_VM) == lActiveIndex )
				{
					m_lEditCtrlIndex = lActiveIndex;
				}
				else if( Get_iDlgCtrlByID(EDT_VC) == lActiveIndex )
				{
					m_lEditCtrlIndex = lActiveIndex;
				}
			}
			
			if( POINTING_DOWN == nAction )
			{
				if( X > DMS_X(STARTX) && X < DMS_X(STARTX+196) && Y > DMS_Y(STARTY+605) && Y < DMS_Y(STARTY+678)  )
				{
					ON_CHAR( '1' );
					VM_PlaySound("1");
				}
				else if( X > DMS_X(STARTX+196) && X < DMS_X(STARTX+392) && Y > DMS_Y(STARTY+605) && Y < DMS_Y(STARTY+678) )
				{
					ON_CHAR( '2' );
					VM_PlaySound("2");
				}
				else if( X > DMS_X(STARTX+392) && X < DMS_X(STARTX+588) && Y > DMS_Y(STARTY+605) && Y < DMS_Y(STARTY+678) )
				{
					ON_CHAR( '3' );
					VM_PlaySound("3");
				}
				else if( X > DMS_X(STARTX) && X < DMS_X(STARTX+196) && Y > DMS_Y(STARTY+678) && Y < DMS_Y(STARTY+751) )
				{
					ON_CHAR( '4' );
					VM_PlaySound("4");
				}
				else if( X > DMS_X(STARTX+196) && X < DMS_X(STARTX+392) && Y > DMS_Y(STARTY+678) && Y < DMS_Y(STARTY+751) )
				{
					ON_CHAR( '5' );
					VM_PlaySound("5");
				}
				else if( X > DMS_X(STARTX+392) && X < DMS_X(STARTX+588) && Y > DMS_Y(STARTY+678) && Y < DMS_Y(STARTY+751) )
				{
					ON_CHAR( '6' );
					VM_PlaySound("6");
				}
				else if( X > DMS_X(STARTX) && X < DMS_X(STARTX+196) && Y > DMS_Y(STARTY+751) && Y < DMS_Y(STARTY+824) )
				{
					ON_CHAR( '7' );
					VM_PlaySound("7");
				}
				else if( X > DMS_X(STARTX+196) && X < DMS_X(STARTX+392) && Y > DMS_Y(STARTY+751) && Y < DMS_Y(STARTY+824) )
				{
					ON_CHAR( '8' );
					VM_PlaySound("8");
				}
				else if( X > DMS_X(STARTX+392) && X < DMS_X(STARTX+588) && Y > DMS_Y(STARTY+751) && Y < DMS_Y(STARTY+824) )
				{
					ON_CHAR( '9' );
					VM_PlaySound("9");
				}
				else if( X > DMS_X(STARTX+196) && X < DMS_X(STARTX+392) && Y > DMS_Y(STARTY+824) && Y < DMS_Y(STARTY+899) )
				{
					ON_CHAR( '0' );
					VM_PlaySound("0");
				}
				else if( X > DMS_X(STARTX+588) && X < DMS_X(STARTX+784) && Y > DMS_Y(STARTY+605) && Y < DMS_Y(STARTY+678) )
				{
					ON_KEY( 5 );
					VM_PlaySound(CLICKSOUND);
				}
				else if( X > DMS_X(STARTX) && X < DMS_X(STARTX+196) && Y > DMS_Y(STARTY+824) && Y < DMS_Y(STARTY+899) )
				{
					Prev_Gm();
					Set_Index();
				}
				else if( X > DMS_X(STARTX+392) && X < DMS_X(STARTX+588) && Y > DMS_Y(STARTY+824) && Y < DMS_Y(STARTY+899) )
				{
					Next_Gm();
					Set_Index();
				}
			}
		}
		else if( m_bFirst == INIT_NUM )
		{
			if( POINTING_UP == nAction )
			{
				if( Get_iDlgCtrlByID(EDT_DATA4) == lActiveIndex ||
				    Get_iDlgCtrlByID(EDT_DATA5) == lActiveIndex ||
				    Get_iDlgCtrlByID(EDT_DATA6) == lActiveIndex )
				{
					ShowSip(TRUE);
					g_Sipflag = 1;
				}
				else
				{
					ShowSip(FALSE);
					g_Sipflag = 0;
				}
				
				ON_DRAW();
			}
		}
		
		return;
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : SetBtnImg
	±â  ´É : ¹öÆ° ÀÌ¹ÌÁö
	Param  : 
	Return : 
	========================================================================================*/
	void SetBtnImg(void)
	{
		handle h;
	
		if( m_bFirst == INIT_MAIN )
		{		
			IconCtrl_SetImage(Get_hDlgCtrlByID(ICON_TITLE), 0, g_pImgMainTtl );
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TITLE), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			//»ó´Ü°øÅë¸Þ´º
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
	ÇÔ¼ö¸í : OnButton
	±â  ´É : ¹öÆ° ÀÌº¥Æ®
	Param  : 
	Return : 
	========================================================================================*/
	void OnButton(long ID)
	{	
		long nchkcnt = 0;
		long i = 0;
		long lRet = 0;
		char szSql[512];
		char szPhoneNum[32];
		char szPhoneNum1[5];
		char szPhoneNum2[5];
		char szPhoneNum3[5];
		char szMsg[200];
		char szTmp[100];
		char strMsg[100];
		
		switch(ID)
		{
			/*************************/
			/* °øÅë                  */
			/*************************/
			case GID_HOME:
				if( MessageBoxEx (CONFIRM_YESNO, "¸ÞÀÎ ¸Þ´º·Î ³ª°¡½Ã°Ú½À´Ï±î?")  == MB_OK)
				{
					Mem_Set((byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG));
					Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
					Set_Index();
					
					if( g_nWorkFlag == 101 )
					{
						g_nWorkFlag = 100;
					}
					
					Card_Move("MENU");	
				}
				break;
			
			case GID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "°ËÄ§ ¸Þ´º·Î ³ª°¡½Ã°Ú½À´Ï±î?")  == MB_OK)
				{
					Mem_Set((byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG));
					Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
					Set_Index();
					
					if( g_nWorkFlag == 101 )
					{
						g_nWorkFlag = 100;
					}
					
					Card_Move("GM_MENU");
				}
				break;
				
			case GID_KEYBOARD:
				g_SHOW_SIP();
				break;
				
			case GID_SCREEN:
				g_MOVE_DLG(400);
				break;
				
			case GID_CMMNWK:
				// Sos_Key();
				
				if( MessageBoxEx (CONFIRM_YESNO, "SOS ±ä±ÞÈ£ÃâÀ» ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				}
				else
				{
					g_Send_SOS(0);
				}
				break;	
							
			case GID_PREV:
				g_nAddrFlag = 0;
				g_nTelFlag = 0;
				g_nNameFlag = 0;
				g_lDataflag = 0;
				
				Mem_Set((byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG));
				Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
				
				Set_Index();
				
				if( g_nWorkFlag == 103 )
				{
					Card_Move("GM_NOGMLST");
				}
				else if( g_nWorkFlag == 104 )
				{
					Card_Move("GM_ABSNCLST");
				}
				else
				{
					g_nWorkFlag = 100;
					Card_Move("GM_RELST");
				}
				break;
				
			case GID_VMEXIT:
				Set_Index();
				g_Exit();
				break;
			
			/*************************/
			/* °ËÄ§µî·Ï              */
			/*************************/
			case BID_MENU:
				if( MessageBoxEx (CONFIRM_YESNO, "°ËÄ§ ¸Þ´º·Î ³ª°¡½Ã°Ú½À´Ï±î?")  == MB_OK)
				{
					Mem_Set((byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG));
					Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
					Set_Index();
					
					if( g_nWorkFlag == 101 )
					{
						g_nWorkFlag = 100;
					}
					
					Card_Move("GM_MENU");
				}
				break;
			
			case BID_GMSND:
				if( MessageBoxEx (CONFIRM_YESNO, "¼Û½ÅÈ­¸éÀ¸·Î ÀÌµ¿ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					break;
				}
				Set_Index();
				Card_Move("GM_RESND");
				break;
				
			case BID_ILLIGAL:
				g_lDataflag = 1;
				SaveInput();
				Set_Index();
				Card_Move("CM_ILLEGAL");
				break;
				
			case BID_SC:
				g_lDataflag = 1;
				SaveInput();
				Set_Index();
				
				Mem_Set((byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM));
				Str_Cpy(g_szMTR_NUM, stGm.MTR_NUM);
				
				Mem_Set( (byte*)szSql, 0x00, sizeof( szSql) );
				SPRINT( szSql, " SELECT COUNT(*) FROM NORMAL_DATA WHERE INST_PLACE_NUM = '%s' ", stGm.USAGE_TITLE, 0, 0 );
				g_Sql_RetInt( szSql , &nchkcnt );
				
				if( nchkcnt > 0 )
				{
					if( MessageBoxEx (CONFIRM_YESNO, "Á¡°ËÈ­¸éÀ¸·Î ÀÌµ¿ÇÏ½Ã°Ú½À´Ï±î?")  == MB_OK)
					{
						if( safe_chkdata() >= 0 )
						{
							break;
						}
						else
						{
							Card_Move("SC_CONFIRM");	
						}
					}
				}
				else
				{
					if( MessageBoxEx (CONFIRM_YESNO, "´ç¿ù ¾ÈÀüÁ¡°ËÀÚ·á°¡ ¾ø½À´Ï´Ù.\nÇØ´ç ¼¼´ë Á¡°Ë µ¥ÀÌÅÍ¸¦ ¼ö½ÅÇÏ½Ã°Ú½À´Ï±î?") == MB_OK)
					{
						if( safe_chkdata() >= 0 )
						{
							break;
						}
						else
						{
							RCV311324();	
						}
					}
					else
					{
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					}
				}
				break;
				
			case BID_MESSAGE:
				g_lDataflag = 1;
				g_nSmsFlag = 1;
				
				Mem_Set((byte*)g_szCntSql, 0x00, sizeof(g_szCntSql));
				Str_Cpy(g_szCntSql, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA3)));	//ÀüÈ­¹øÈ£ º¯°æ > ÁÖ¼Ò Ãâ·Â
				
				SaveInput();
				
				Card_Move("GM_SMSSND");
				break;
				
			case BID_SILSA:
				if( Str_Cmp(stGm.SEND_YN, "Y") == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "ÀÌ¹Ì ¼Û½ÅÇÑ ÀÚ·áÀÔ´Ï´Ù.");
				}
				else if( Str_Cmp(stGm.INSP_YN, "Y") != 0 )
				{
					MessageBoxEx(CONFIRM_OK, "½Ç»ç ´ë»óÀÌ ¾Æ´Õ´Ï´Ù.");
				}
				else if( Str_Cmp(stGm.INSP_YN, "Y") == 0 && Str_Cmp(stGm.SEND_YN, "S") == 0 &&
				       ( Str_Cmp(stGm.MTR_WORK_CODE, "1") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "3") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "A") == 0 ||
				         Str_Cmp(stGm.MTR_WORK_CODE, "B") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "C") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "D") == 0 ||
				         Str_Cmp(stGm.MTR_WORK_CODE, "5") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "6") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "7") == 0 ) )
				{
					//Á¤»ó,±³Ã¼,¹ÌÀÔÁÖ,¹Ì»ç¿ë,¾øÀ½,¹Ì±âÅ¸,¼øÈ¸,°íÀå,ÇØ°¡ : ½Ç»ç ÁøÇà
					g_lDataflag = 1;
					SaveInput();
					Set_Index();
					Card_Move("GM_SILSA");
				}
				break;
				
			case BID_SMS_STS:
				if( Str_Cmp(stGm.GMTR_SEND_STS, "60") == 0 ||
				    Str_Cmp(stGm.GMTR_SEND_STS, "70") == 0 ||
				    Str_Cmp(stGm.GMTR_SEND_STS, "80") == 0 )
				{
					g_lDataflag = 1;
					g_nSmsFlag = 1;
					SaveInput();
					Set_Index();
					Card_Move("GM_SMS_VIEW");
				}
				break;
				
			case BID_NUM:
				g_lDataflag = 1;
				SaveInput();

				ON_EXIT();
				OnInit(INIT_NUM);
				
				break;
				
			case BID_ADDR1:
				g_lDataflag = 1;
				
				SaveInput();
				
				if( g_nAddrFlag == 0)
				{
					g_nAddrFlag = 1;
				}
				else
				{
					g_nAddrFlag = 0;
				}

				REDRAW();
				
				break;
				
			case BID_ADDR2:
				g_lDataflag = 1;
				
				SaveInput();

				if( g_nNameFlag == 0)
				{
					g_nNameFlag = 1;
				}
				else
				{
					g_nNameFlag = 0;
				}
				
				REDRAW();
				
				break;
				
			case BID_ADDR4:
				g_lDataflag = 1;
				SaveInput();
				Set_Index();
				
				REDRAW();
				
				Card_Move("GM_MTRINFO");
					
				break;
				
			case BID_ADDR5:
				g_lDataflag = 1;
				
				SaveInput();

				if( g_nTelFlag == 0)
				{
					g_nTelFlag = 1;
				}
				else
				{
					g_nTelFlag = 0;
				}
				
				REDRAW();
				
				break;
				
			case BID_TEL:
				Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
				if( g_nTelFlag == 0 )
				{
					SPRINT(szMsg, "%s °í°´´Ô²²\nÀüÈ­ÇÏ½Ã°Ú½À´Ï±î?\n(HP : %s)", stGm.CUST_NM,m_szPhone,0);	
				}
				else
				{
					SPRINT(szMsg, "%s °í°´´Ô²²\nÀüÈ­ÇÏ½Ã°Ú½À´Ï±î?\n(TEL : %s)", stGm.CUST_NM,m_szPhone,0);
				}
				
				if( MessageBoxEx(CONFIRM_YESNO, szMsg) == MB_OK)
				{
					Call_Tel();
				}
				
				break;
				
			case BID_USEQTY:
				if( MessageBoxEx (CONFIRM_YESNO, "»ç¿ë·® ÃßÀÌ È­¸éÀ¸·Î\nÀÌµ¿ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK )
				{
					break;
				}
				
				g_lDataflag = 1;
				SaveInput();
				
				Card_Move("GM_USEQTY");
				
				break;
				
			case BID_THMONTH:
				g_lDataflag = 1;
				
				SaveInput();
				
				if(m_lUserData == 10 || m_lUserData == 40 || m_lUserData == 41)
				{
					ON_EXIT();
					OnInit(INIT_JCHM);
				}
				else
				{
					ON_EXIT();
					OnInit(INIT_BJCHM);
				}
				
				break;
				
			case BID_PREVPG:
				Prev_Gm();
				Set_Index();
				
				break;
				
			case BID_NEXTPG:
				Next_Gm();
				Set_Index();
				
				break;
				
			case BID_DELETE:
				if( (stGm.SEND_YN[0] == 'S' || stGm.SEND_YN[0] == 'I') || Str_Cmp(stGm.MTR_WORK_CODE, "L") == 0 )
				{
					if( MessageBoxTitle(TITLE_ERROR_YESNO, "°ËÄ§Ãë¼Ò", "ÀúÀåÇÑ ÁöÄ§À» Ãë¼Ò ÇÏ½Ã°Ú½À´Ï±î?") == MB_OK )
					{
						if( Str_Cmp(stGm.SMS_GMTR_MAN_YN, "Y") == 0 && Str_Cmp(stGm.MTR_WORK_CODE, "L") == 0 )
						{
							//m_lSmsStsFlag = 0 ¹®ÀÚ°ËÄ§ ´ë»ó »óÅÂ Ç¥½Ã, = 1 ¹®ÀÚ´ë»ó -> ¾÷¹« Á¤»ó µî·Ï ½Ã »óÅÂ, = 2 °ËÄ§Ãë¼Ò(»èÁ¦) ½Ã »óÅÂ
							m_lSmsStsFlag = 2;
							Rcv_SmsSts();
						}
						else
						{
							Del_Gm();
							SetData();
							SetStyle();
							REDRAW();
						}
					}
				}
				else 
				{
					if( 10 == m_lUserData )
					{
						if( Get_iDlgCtrlByID(EDT_VC) == m_lEditCtrlIndex )
						{
							EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VC), "" );
							EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_USEQTY), "" );
						}
					}
					else if( 20 == m_lUserData )
					{
						if( Get_iDlgCtrlByID(EDT_VM) == m_lEditCtrlIndex )
						{
							EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VM), "" );
						}
						else if( Get_iDlgCtrlByID(EDT_VA) == m_lEditCtrlIndex )
						{
							EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VA), "" );
						}
						else if( Get_iDlgCtrlByID(EDT_VC) == m_lEditCtrlIndex )
						{
							EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VC), "" );
							EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13), "" );
						}
					}
					else
					{
						if( Get_iDlgCtrlByID(EDT_VM) == m_lEditCtrlIndex )
						{
							EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VM), "" );
						}
						else if( Get_iDlgCtrlByID(EDT_VC) == m_lEditCtrlIndex )
						{
							EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VC), "" );
							EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_DATA13), "" );
						}
					}
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				}
				
				ON_DRAW();
				
				break;
				
			case BID_SAVE:
				SaveInput();
				
				if( Str_Cmp(g_szIndi_MtrCode, "L:¹®ÀÚ¹ß¼Û") == 0 && g_nSmsSndFlag == 0 )
				{
					if( Str_Cmp(stGm.SMS_GMTR_MAN_YN, "Y") != 0 )
					{
						m_lSmsStsFlag = 3;
						Rcv_Many();
					}
					else
					{
						if( Str_Cmp(stGm.GMTR_SEND_FLAG, "120") == 0 || Str_Cmp(stGm.SEND_TYPE, "30") == 0 )
						{
							m_lSmsStsFlag = 3;
							Rcv_Many();
						}
						else
						{
							MessageBoxEx (CONFIRM_OK, "ÀÌ¹Ì ¹®ÀÚ°ËÄ§´ë»óÀÔ´Ï´Ù.");
						}

						break;
					}
				}
				else if( g_nSmsSndFlag == 1 )
				{
					//¸Þ¼¼Áö -> °³º°¸Þ¼¼Áö ¼Û½Å ÀÇ °æ¿ì¿¡ µ¥ÀÌÅÍ ÀúÀå
					Mem_Set((byte *)stGm.INDI_SET_VM, 0x00, sizeof(stGm.INDI_SET_VM));
					Mem_Set((byte *)stGm.INDI_SET_VA, 0x00, sizeof(stGm.INDI_SET_VA));
					Mem_Set((byte *)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
					Mem_Set((byte *)stGm.INDI_QTY, 0x00, sizeof(stGm.INDI_QTY));
					Mem_Set((byte *)stGm.INDI_DATE, 0x00, sizeof(stGm.INDI_DATE));
					Mem_Set((byte *)szSql, 0x00, sizeof(szSql));
					Mem_Set((byte *)szMsg, 0x00, sizeof(szMsg));
					
					Mem_Set((byte *)stGm.SMS_GMTR_MAN_YN, 0x00, sizeof(stGm.SMS_GMTR_MAN_YN));
					Mem_Set((byte *)m_szMtr_Code, 0x00, sizeof(m_szMtr_Code));
					Mem_Set((byte *)stGm.MTR_WORK_CODE, 0x00, sizeof(stGm.MTR_WORK_CODE));

					//³¯Â¥
					Str_ItoA(Time_GetDate(), szSql,10);
					g_Str_TimeType( szMsg, Time_GetTime());
					Str_Cat(szSql, szMsg);
					Str_Cpy(stGm.INDI_DATE, szSql);
					
					Str_Cpy(stGm.SMS_GMTR_MAN_YN, "Y");
					Str_Cpy(m_szMtr_Code, "L");
						
					Str_Cpy(stGm.MTR_WORK_CODE, m_szMtr_Code);		
					Str_Cpy(stGm.INDI_SET_VM, "");			
					Str_Cpy(stGm.INDI_SET_VA, "");			
					Str_Cpy(stGm.INDI_SET_VC, "");			
					Str_Cpy(stGm.INDI_QTY, "");			
					
					if( Save_Gm() > 0 )
					{
						if( 10 == m_lUserData )
						{
							Mem_Set((byte *)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
							Str_Cpy(g_szMtr_Code, stGm.MTR_WORK_CODE);
						}
						
						g_nBackFlag++;
						
						if( g_nBackFlag > 99)
						{
							g_Db_Backup();
							g_nBackFlag = 0;
						}
						
						g_nSmsSndFlag = 0;
						m_lLastSave = 1;
						Next_Gm();
						Set_Index();
					}
				}
				else
				{
					if( Gm_ChkRule() > 0 )
					{
						if( Str_Cmp(stGm.SMS_GMTR_MAN_YN, "Y") == 0 && Str_Cmp(stGm.SEND_TYPE, "30") != 0 )
						{
							//¹®ÀÚ ´ë»óÀÇ °æ¿ì -> ¹®ÀÚ ¿¹¾àÃë¼Ò, ¹®ÀÚ´ë»ó »èÁ¦ ÈÄ ±âÁ¸ ¾÷¹« ÀúÀå
							//2017-05-25 Sanghyun Lee
							//¹®ÀÚ´ë»ó -> ±âÁ¸¾÷¹«·Î º¯°æ ½Ã
							//¹ß¼Û ÀÌÈÄÀÇ »óÅÂ°ªÀÌ¸é ¹®ÀÚ´ë»ó Ãë¼Ò,»èÁ¦ ·ÎÁ÷Àº Å¸Áö ¾Ê°í
							//±âÁ¸ °ËÄ§¾÷¹« ÀúÀå ·ÎÁ÷¸¸ Å¸¾ßÇÔ.
							m_lSmsStsFlag = 1;
							Rcv_SmsSts();
						}
						else
						{
							if( Save_Gm() > 0 )
							{
								if( 10 == m_lUserData )
								{
									Str_Cpy(g_szMtr_Code, stGm.MTR_WORK_CODE);
								}
								
								g_nBackFlag++;
								
								if( g_nBackFlag > 99)
								{
									g_Db_Backup();
									g_nBackFlag = 0;
								}
		
								//stGm.INSP_YN -> Y : ½Ç»ç´ë»ó , stGm.INSP_YN -> N : ½Ç»ç´ë»ó ¾Æ´Ô.
								//Á¤»ó,±³Ã¼,¹ÌÀÔÁÖ,¹Ì»ç¿ë,¾øÀ½,¹Ì±âÅ¸,¼øÈ¸,°íÀå,ÇØ°¡ : ½Ç»ç ÁøÇà
								if( Str_Cmp(stGm.INSP_YN, "Y") == 0 && 
								  ( Str_Cmp(stGm.MTR_WORK_CODE, "1") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "3") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "A") == 0 ||
								    Str_Cmp(stGm.MTR_WORK_CODE, "B") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "C") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "D") == 0 ||
								    Str_Cmp(stGm.MTR_WORK_CODE, "5") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "6") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "7") == 0 ) )
								{
									g_nActIndex++;
									g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
							
									if( g_nActIndex > m_ltotcnt || g_lindex < 0 )
									{
										if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
										{
											g_nActIndex = g_nActIndex-1;
										}
										
										g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
									}
									
									g_lDataflag = 0;
									
									Mem_Set((byte *)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG));
									Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
									
									Mem_Set( (byte*)g_szIndi_MtrCode, 0x00, sizeof(g_szIndi_MtrCode) );
									Mem_Set( (byte*)g_szIndi_Qty, 0x00, sizeof(g_szIndi_Qty) );
	
									Card_Move("GM_SILSA");
								}
								else
								{
									Next_Gm();
								}
							}
							else
							{
								g_lDataflag = 1;
							}
							
							Set_Index();
						}
					}
					else
					{
						m_lChk = 0;
						g_lDataflag = 1;
						Set_Index();
					}
				}
				break;
				
			case BID_FEE:
				if( MessageBoxEx (CONFIRM_YESNO, "¿ä±Ý³»¿ªÀ» Á¶È¸ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					break;
				}
				
				g_lDataflag = 1;
				g_lPAYFlag = 0;
				g_nPhotoFlag = 1;
				
				Mem_Set( (byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM) );
				Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM) );
				
				Str_Cpy(g_szMTR_NUM, stGm.MTR_NUM);
				Str_Cpy(g_szUSE_CONT_NUM, stGm.USE_CONT_NUM);
				
				SaveInput();
				Set_Index();
				
				Card_Move("GM_PAYHSTR");
				
				break;
				
			case BID_CALCUL:
				if( MessageBoxEx (CONFIRM_YESNO, "¿ä±Ý°è»êÀ» ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					break;
				}
				
				g_lDataflag = 1;
				g_lPAYFlag = 0;
				
				Mem_Set( (byte*)g_szMTR_NUM, 0x00, sizeof(g_szMTR_NUM) );
				Mem_Set( (byte*)g_szUSE_CONT_NUM, 0x00, sizeof(g_szUSE_CONT_NUM) );
				
				Str_Cpy(g_szMTR_NUM, stGm.MTR_NUM);
				Str_Cpy(g_szUSE_CONT_NUM, stGm.USE_CONT_NUM);
				
				SaveInput();
				Set_Index();

				if( m_lUserData == 10 )
				{
					if( Str_Len(g_szIndi_Vc) == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "ÁöÄ§À» ÀÔ·ÂÇÏÁö ¾Ê¾Ò½À´Ï´Ù.");
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						break;
					}
				}
				else if( m_lUserData == 20 )
				{
					if( Str_Len(g_szIndi_Vm) == 0 || Str_Len(g_szIndi_Va) == 0 || Str_Len(g_szIndi_Vc) == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "ÁöÄ§À» ÀÔ·ÂÇÏÁö ¾Ê¾Ò½À´Ï´Ù.");
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);	
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						break;
					}
				}
				else
				{
					if( Str_Len(g_szIndi_Vm) == 0 || Str_Len(g_szIndi_Vc) == 0 )
					{
						MessageBoxEx (CONFIRM_OK, "ÁöÄ§À» ÀÔ·ÂÇÏÁö ¾Ê¾Ò½À´Ï´Ù.");
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						break;
					}
				}
				
				Card_Move("GM_PAYCAL");
				
				break;
				
			case BID_CLIENT:
				g_lDataflag = 1;
				
				SaveInput();
				Set_Index();
				
				Card_Move("GM_CUSTINFO");
				
				break;
				
			case BID_MEMO:
				g_lDataflag = 1;
				g_nMemoFlag = 1;
				
				SaveInput();
				Set_Index();
				
				Card_Move("CM_MRGMEMO");
				
				break;
			
			case BID_MTR_ID_NUM:
				if( Str_Cmp(stGm.COMPENS_REMOVE_ALARM_2, "Y") == 0 )
				{	
				ON_EXIT();
				OnInit(INIT_COMPENSREMOVE);
				}
			    break;
			/*************************/
			/* »ó¼¼ÁöÄ§³»¿ª          */
			/*************************/
			case BID_OK:
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
			
			/*************************/
			/* »ó¼¼ÁöÄ§³»¿ª - º¸Á¤±â */
			/*************************/
			case BID_OK2:
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
			
			/*************************/
			/* »ó½Ã°è¼öÀÔ·Â          */
			/*************************/
			case BID_SAVE2:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				if( Save_factor() > 0 )
				{				
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				
				break;
				
			case BID_CLOSE2:
				ShowSip(FALSE);
				g_Sipflag = 0;
				
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
				
			case BID_PHOTO_VC:
				// »çÁø Å¸ÀÔ : VC = 1
				Mem_Set( (byte*)m_szPhoto_CompensType, 0x00, sizeof(m_szPhoto_CompensType) );
				Str_Cpy( m_szPhoto_CompensType, "1" );
				
				Shoto_Photo_Compens();
				
				break;
				
			case BID_PHOTO_VA:
				// »çÁø Å¸ÀÔ : VA = 2
				Mem_Set( (byte*)m_szPhoto_CompensType, 0x00, sizeof(m_szPhoto_CompensType) );
				Str_Cpy( m_szPhoto_CompensType, "2" );
				
				Shoto_Photo_Compens();
				
				break;
				
			case BID_PHOTO_VM:
				// »çÁø Å¸ÀÔ : VM = 3
				Mem_Set( (byte*)m_szPhoto_CompensType, 0x00, sizeof(m_szPhoto_CompensType) );
				Str_Cpy( m_szPhoto_CompensType, "3" );
				
				Shoto_Photo_Compens();
				
				break;
				
			/*************************/
			/* »ç¿ë·® ÀÌ»ó¼¼´ë       */
			/*************************/	
			case BID_SAVE3:
				if( m_lChk > 0 )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}
				else
				{
					MessageBoxEx (CONFIRM_OK, "¼±ÅÃµÈ Ç×¸ñÀÌ ¾ø½À´Ï´Ù. Ç×¸ñÀ» ¼±ÅÃÇØÁÖ¼¼¿ä.");
				}
				break;
			
			case BID_BOX1:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKOFF);
				
				Mem_Set( (byte*)stGm.MONITOR_FLAG, 0x00, sizeof(stGm.MONITOR_FLAG) );
				Mem_Set( (byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG) );
				
				Str_Cpy(stGm.MONITOR_FLAG, "10");
				Str_Cpy(stGm.SUBMONITOR_FLAG, "10");
				
				m_lChk = 1;
				
				break;
				
			case BID_BOX2:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKOFF);
				
				Mem_Set( (byte*)stGm.MONITOR_FLAG, 0x00, sizeof(stGm.MONITOR_FLAG) );
				Mem_Set( (byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG) );
				
				Str_Cpy(stGm.MONITOR_FLAG, "20");
				Str_Cpy(stGm.SUBMONITOR_FLAG, "20");
				
				m_lChk = 2;
				
				break;
				
			case BID_BOX3:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKON);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKOFF);
				
				Mem_Set( (byte*)stGm.MONITOR_FLAG, 0x00, sizeof(stGm.MONITOR_FLAG) );
				Mem_Set( (byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG) );
				
				Str_Cpy(stGm.MONITOR_FLAG, "30");
				Str_Cpy(stGm.SUBMONITOR_FLAG, "30");
				
				m_lChk = 3;
				
				break;
				
			case BID_BOX4:
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX1), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX2), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX3), CHKOFF);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_BOX4), CHKON);
				
				Mem_Set( (byte*)stGm.MONITOR_FLAG, 0x00, sizeof(stGm.MONITOR_FLAG) );
				Mem_Set( (byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG) );
				
				Str_Cpy(stGm.MONITOR_FLAG, "40");
				Str_Cpy(stGm.SUBMONITOR_FLAG, "40");
				
				m_lChk = 4;
				
				break;
			
			/*************************/
			/* º¸Á¤±â °íÀå           */
			/*************************/	
			case BID_COMPENS_CLOSE:
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
				
				SPRINT(szSql, "SELECT REMOVE_REQ_EMPID FROM GUM_COMPENS_REMOVE_REQ WHERE REQ_YM = '%s' AND DEADLINE_FLAG = '%s' AND MTR_NUM = '%s'", stGm.REQ_YM, stGm.DEADLINE_FLAG, stGm.MTR_NUM);
				g_Sql_RetStr(szSql, 4, szTmp);
				
				if( Str_Cmp(szTmp, "") == 0 )
				{
					Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
					SPRINT(szSql, "DELETE FROM GUM_COMPENS_REMOVE_REQ WHERE REQ_YM = '%s' AND DEADLINE_FLAG = '%s' AND MTR_NUM = '%s'", stGm.REQ_YM, stGm.DEADLINE_FLAG, stGm.MTR_NUM);
					g_Sql_DirectExecute( szSql );	
				}
				
				ON_EXIT();
				OnInit(INIT_MAIN);
				
				break;
					
			case BID_COMPENS_SIGN:
				fn_Compens_Sign();
				break;
			
			case BID_COMPENS_OK:
				if( fn_Compens_Save() )
				{
					ON_EXIT();
					OnInit(INIT_MAIN);
				}	
				break;
				
			case BID_COMPENS_CONF_NM:
				g_EditCtrl_ShowEditInput( Get_hDlgCtrlByID(EDT_COMPENS_CONF_NM), EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_COMPENS_CONF_NM)) );
				break;
			
			case BID_REMOTE:

				Mem_Set((byte *)strMsg      , 0x00, sizeof(strMsg));
		
				Str_Cat(strMsg, "°ËÄ§ÀÏ½Ã : ");
				Str_Cat(strMsg, stGm.RECENT_GMTR_JOB_YMD_YEAR);
				Str_Cat(strMsg, "³â ");
				Str_Cat(strMsg, stGm.RECENT_GMTR_JOB_YMD_MONTHS);
				Str_Cat(strMsg, "¿ù ");
				Str_Cat(strMsg, stGm.RECENT_GMTR_JOB_YMD_DAYS);
				Str_Cat(strMsg, "ÀÏ");
				Str_Cat(strMsg, "\n °ËÄ§ÁöÄ§ : ");
				Str_Cat(strMsg, stGm.RECENT_INDI_MTR_MM_VC);
				
				MessageBoxEx(CONFIRM_OK, strMsg);

				// MessageBoxEx(CONFIRM_OK, "°ËÄ§ÀÏ½Ã :  \n °ËÄ§ÁöÄ§ :");
				break;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : OnUart
	±â  ´É : Ä«¸Þ¶ó
	Param  : 
	Return : 
	========================================================================================*/
	void OnUart( long nEvent, long nData )
	{
		char szfilenm[256];
		char szTmp[200];
		
		if( m_bFirst == INIT_NUM )
		{
			if( nEvent == UART_CAMERA )
			{
				if( nData == 1 )
				{
					Mem_Set( (byte*)szfilenm, 0x00, sizeof(szfilenm) );
					SPRINT( szfilenm, "Camera/%s",  m_szfilenm,0, 0 );
					
					if( FFS_Exist(szfilenm) )
					{
						MessageBoxEx( MESSAGE, "»çÁøÀ» ÀúÀåÁßÀÔ´Ï´Ù." );
						
						FFS_Copy( szfilenm, g_szphoto );
						
						VmSleep( 100 );

						Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
						
						if( Str_Cmp(m_szPhoto_CompensType, "1" ) == 0 )
						{	
							SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_COMPENS_VC_YN = 'S' WHERE ROWID = '%s'", stGm.ROWID, 0, 0 );
							g_Sql_DirectExecute( szTmp ); 
							
							Mem_Set( (byte*)stGm.PHOTO_COMPENS_VC_YN, 0x00, sizeof(stGm.PHOTO_COMPENS_VC_YN) );
							Str_Cpy( stGm.PHOTO_COMPENS_VC_YN, "S" );
						}
						else if( Str_Cmp(m_szPhoto_CompensType, "2" ) == 0  )
						{
							SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_COMPENS_VA_YN = 'S' WHERE ROWID = '%s'", stGm.ROWID, 0, 0 );
							g_Sql_DirectExecute( szTmp ); 
						
							Mem_Set( (byte*)stGm.PHOTO_COMPENS_VA_YN, 0x00, sizeof(stGm.PHOTO_COMPENS_VA_YN) );
							Str_Cpy( stGm.PHOTO_COMPENS_VA_YN, "S" );
						}
						else if( Str_Cmp(m_szPhoto_CompensType, "3" ) == 0  )
						{
							SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_COMPENS_VM_YN = 'S' WHERE ROWID = '%s'", stGm.ROWID, 0, 0 );
							g_Sql_DirectExecute( szTmp ); 
						
							Mem_Set( (byte*)stGm.PHOTO_COMPENS_VM_YN, 0x00, sizeof(stGm.PHOTO_COMPENS_VM_YN) );
							Str_Cpy( stGm.PHOTO_COMPENS_VM_YN, "S" );
						}
						
						VmSleep( 100 );
						
						FFS_Delete( szfilenm );
						
						VmSleep( 100 );
						
						// FR26002();
						NUM_DRAW();
					}
				}
			}
		}
		
		return;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : OnSelect
	±â  ´É : ÄÞº¸¹Ú½º¿¡ µû¸¥ È­¸é º¯È­
	Param  : 
	Return : 
	========================================================================================*/	
	void OnSelect(long Index)
	{
		long i = 0;
		char szMtr_Code[5];
		char strMsg[100];
		
		if(m_bFirst == INIT_MAIN)
		{		
			/***********************/
			/* °è·®±â              */
			/***********************/   
			if(10 == m_lUserData)
			{
				Mem_Set( (byte*)m_szgr, 0x00, sizeof(m_szgr));
				Str_Cpy(m_szgr, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)));
				
				/***********************/
				/* 2:ºÎÀç              */
				/***********************/       
				if( Str_Cmp(m_szgr, "2:ºÎÀç") == 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), RED);
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
					Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
				}
				/***********************/
				/* C:¾øÀ½, L:¹®ÀÚ¹ß¼Û  */
				/***********************/
				else if( Str_Cmp(m_szgr,"C:¾øÀ½") == 0 || Str_Cmp(m_szgr,"L:¹®ÀÚ¹ß¼Û") == 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);

					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
					Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				}
			}
			/***********************/
			/* º¸Á¤±â              */
			/***********************/ 
			else if(20 == m_lUserData)
			{
				Str_Cpy(m_szbj, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)));
				
				if( Str_Cmp(m_szbj,"2:ºÎÀç") == 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), RED);
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
					Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
				}
				else if( Str_Cmp(m_szbj,"C:¾øÀ½") == 0 || Str_Cmp(m_szbj,"L:¹®ÀÚ¹ß¼Û") == 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
					Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				}
			}
			/***********************/
			/* ¿Âµµ, ¿Â¾Ð º¸Á¤±â   */
			/***********************/ 
			else
			{
				Str_Cpy(m_sztp, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)));
				
				if( Str_Cmp(m_sztp,"2:ºÎÀç") == 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), RED);
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
					Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
				}
				else if( Str_Cmp(m_sztp,"C:¾øÀ½") == 0 || Str_Cmp(m_sztp,"L:¹®ÀÚ¹ß¼Û") == 0 )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
					Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
				}
				else
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				}
			}
			
			// ÁöÄ§ °ªÀ» ÀÔ·Â ÈÄ ÄÚµå°ªÀ» ¹Ù…fÀ» °æ¿ì °è»êÀÌ ´Ù½Ã µÇ°Ô ÇÏ±âÀ§ÇØ¼­.
			if( m_lUserData == 10 )
			{
				Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
				Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
				Cal_UseQty( stGm.INDI_SET_VC );
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), m_szIndiQty);
				
				if( Str_AtoI(m_szIndiQty) > Str_AtoI(stGm.MAX_GMTR_QTY) )
				{
					Mem_Set((byte *)strMsg      , 0x00, sizeof(strMsg));
		
					Str_Cat(strMsg, "ÃÖ´ë »ç¿ë·®À» ÃÊ°úÇÏ¿´½À´Ï´Ù.\n ");
					Str_Cat(strMsg, "\nÇöÀç »ç¿ë·® : ");
					Str_Cat(strMsg, m_szIndiQty);
					Str_Cat(strMsg, "\nÃÖ´ë »ç¿ë·® : ");
					Str_Cat(strMsg, stGm.MAX_GMTR_QTY);
					
					MessageBoxEx(ERROR_OK, strMsg);
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
					
					Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
					Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
					
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					return;
				}
			}
			else
			{
				Mem_Set( (byte*)szMtr_Code, 0x00, sizeof(szMtr_Code));
				Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
				Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
				
				i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)), RE_GM_CODE );
				if(i >= 0)
				{
					Str_Cpy(szMtr_Code, RE_GM_CODE[i].Code);
				}

				if( Str_Cmp(szMtr_Code, "3") == 0 )
				{
					Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
				}
				else
				{
					Cal_UseQty( stGm.INDI_SET_VC );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), m_szIndiQty);
					
					if( Str_AtoI(m_szIndiQty) > Str_AtoI(stGm.MAX_GMTR_QTY) )
					{
						Mem_Set((byte *)strMsg      , 0x00, sizeof(strMsg));
						
						Str_Cat(strMsg, "ÃÖ´ë »ç¿ë·®À» ÃÊ°úÇÏ¿´½À´Ï´Ù.\n ");
						Str_Cat(strMsg, "\nÇöÀç »ç¿ë·® : ");
						Str_Cat(strMsg, m_szIndiQty);
						Str_Cat(strMsg, "\nÃÖ´ë »ç¿ë·® : ");
						Str_Cat(strMsg, stGm.MAX_GMTR_QTY);
						
						MessageBoxEx(ERROR_OK, strMsg);
						
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
						
						Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
						Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
						
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						return;
					}
				}
			}
		}
		
		ON_DRAW();
		
		GrDev_Refresh();
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : Set_Index
	±â  ´É : ÃÖÁ¾ ÀÎµ¦½º ÀúÀåÇÑ´Ù.
	Param  : 
 	Return : TRUE :¼º°ø
 			 FALSE:ÆÄÀÏÀÌ ¾øÀ»½Ã¿¡ ½ÇÆÐ
	========================================================================================*/
	void Set_Index(void)
	{
		char sztmp[101];

		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		SPRINT(sztmp, "UPDATE RCV_LOG SET PARAM8 =%d WHERE GUBUN = '10' ", g_lindex, 0, 0);
		g_Sql_DirectExecute(sztmp);
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : SetStyle
	±â  ´É : È­¸é ½ºÅ¸ÀÏ
	Param  : 
 	Return : 
	========================================================================================*/
	void SetStyle(void)
	{
		if( m_bFirst == INIT_MAIN )
		{	
			/*********************************/
			/* È­¸é Style Setting            */
			/*********************************/		
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA1) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA2) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA4) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA5) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA7) , EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA8) , EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_USEQTY), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_VC)    , EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_VA)	   , EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_VM)    , EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA11), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA12), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA13), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA14), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA99), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(CMB_RESULT), EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA3) , EDITALIGN_MIDDLE);
			
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ZERO ) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_ONE  ) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_TWO  ) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_THREE) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FOUR ) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_FIVE ) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SIX  ) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_SEVEN) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_EIGHT) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NINE ) , EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NUMDEL), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_PREVPG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_NEXTPG), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
			
			EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_DATA3), TRUE, 2, EDITSEP_NONE );
			
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_ZERO ) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_ONE  ) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_TWO  ) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_THREE) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FOUR ) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_FIVE ) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_SIX  ) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_SEVEN) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_EIGHT) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_NINE ) , theDevInfo.m_nFontLageType );
			EditCtrl_SetFont( Get_hDlgCtrlByID(TXT_NUMDEL), theDevInfo.m_nFontLageType );
			
			/****************************************************************************************************************/
			/* »ó½Ã°è¼öÀÔ·Â																									*/
			/* GMTR_OBJ_FLAG(°ËÄ§´ë»ó±¸ºÐ) = 10:°è·®±â, 20:º¸Á¤±â, 30:°è·®±â+º¸Á¤±â, 40: ÀÏÃ¼Çü(¿Âµµ), 41: ÀÏÃ¼Çü(¿Âµµ¾Ð·Â) */
			/* COMPENS_FLAG(º¸Á¤±¸ºÐ) = 10:¹Ìº¸Á¤, 20:º¸Á¤, 30:°è¾àº¸Á¤, 40:ÀÏÃ¼Çü                                          */
			/* GMTR_OBJ_FLAG = 10 -> m_lUserData = 10 °è·®±â									  							*/
			/* GMTR_OBJ_FLAG = 40 -> m_lUserData = 40 ¿Âµµº¸Á¤±â															*/
			/* GMTR_OBJ_FLAG = 41 && COMPENS_FLAG > 40 -> m_lUserData = 41 ¿Â¾Ðº¸Á¤±â										*/
			/* À§ Á¶°Ç°ú ´Ù¸¥ °æ¿ì -> m_lUserData = 20 º¸Á¤±â																*/
			/****************************************************************************************************************/
			/*********************************/
			/* EDTÈ­¸é ÃÊ±âÈ­                */
			/*********************************/
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) , FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA) , FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM) , FALSE );
			
			/********************************/
			/* m_lUserData, BID_NUM Setting */
			/********************************/
			// °è·®±â
			if( Str_Cmp(stGm.GMTR_OBJ_FLAG, "10" ) == 0  )
			{
				m_lUserData = 10;
	
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_NUM), "ºñº¸Á¤");
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), TRUE );
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NUM), BTNMENUFRCOLOR);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_NUM), BTNCTRLBKCOLOR);
			}
			// ¿Âµµº¸Á¤±â
			else if( Str_Cmp(stGm.GMTR_OBJ_FLAG, "40" ) == 0 )
			{
				m_lUserData = 40;
	
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_NUM), "¿Âµµ");
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), FALSE );
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NUM), RED);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_NUM), BTNCTRLBKCOLOR);
			}
			// ¿Â¾Ðº¸Á¤±â
			else if( Str_Cmp(stGm.GMTR_OBJ_FLAG, "41" ) == 0 && Str_AtoI(stGm.COMPENS_FLAG) > 40 )
			{
				m_lUserData = 41;
	
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_NUM), "¿Â¾Ð");
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), FALSE );
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NUM), RED);
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_NUM), BTNCTRLBKCOLOR);
			}
			// º¸Á¤±â
			else
			{	
				m_lUserData = 20;
				
				if( Str_Cmp( stGm.SELF_GMTR_YN, "Y" ) == 0 )
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NUM), "º¸Á¤");
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), TRUE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NUM), BTNMENUFRCOLOR);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_NUM), BTNCTRLBKCOLOR);
				}
				else
				{
					ButCtrl_SetText(Get_hDlgCtrlByID(BID_NUM), "º¸Á¤");
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_NUM), FALSE );
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_NUM), RED);
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_NUM), BTNCTRLBKCOLOR);
				}
			}
			
			// 2017-04-25 Sanghyun Lee, °ËÄ§½Ç»ç È­¸é Ã¼Å©¸¦ À§ÇØ ÇØ´ç Á¤º¸ ÀúÀå.
			g_nUserData = m_lUserData;
			
			/***********************************************************/
			/* CMB_RESULT, EDT_VC, EDT_VA, EDT_VM, BID_MESSAGE Setting */
			/***********************************************************/
			// m_szgr = °ËÄ§ÄÚµå ÄÞº¸¹Ú½º °ª
			// °è·®±â
			if( 10 == m_lUserData )
			{
				if( Str_Cmp(m_szgr, "") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[0].Str );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) , FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA) , FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM) , FALSE );
					
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
				}
				else
				{	
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), m_szgr);
					
					if( Str_Cmp(m_szgr, "2:ºÎÀç") == 0 )
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) , TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA) , TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM) , TRUE );
						
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), RED);	
					}
					else
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) , FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA) , FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM) , FALSE );
						
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
					}
				}
	
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "±³Ã¼ÀÏ");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), "ÁöÄ§");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_USEQTY), "»ç¿ë·®");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA24), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "");
				
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA13), 	STARTX    , STARTY+345,  196, 510);	//±³Ã¼ÀÏ
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA14),	STARTX+196, STARTY+345,  500, 510);	//±³Ã¼³¯Â¥
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA15),	STARTX+500, STARTY+345,  785, 510);	//ÁöÄ§
				BUTSETRANGE(Get_hDlgCtrlByID(BID_USEQTY),	STARTX+785, STARTY+345, 1000, 510);	//»ç¿ë·®

				BUTSETRANGE(Get_hDlgCtrlByID(BID_THMONTH),	STARTX    , STARTY+410,  196, 575); //´ç¿ù
				EDITSETRANGE(Get_hDlgCtrlByID(CMB_RESULT),	STARTX+196, STARTY+410,  500, 575); //°ËÄ§ÄÚµå
				BUTSETRANGE(Get_hDlgCtrlByID(CMB_RESULT+1),	STARTX+400, STARTY+411,  500, 574);	//°ËÄ§ÄÚµå
				EDITSETRANGE(Get_hDlgCtrlByID(EDT_VC),		STARTX+500, STARTY+410,  785, 575);	//ÁöÄ§ÀÔ·Â
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_USEQTY),	STARTX+785, STARTY+410, 1000, 575);	//»ç¿ë·®

				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA11),	STARTX    , STARTY+475,  196, 640);	//Àü¿ù
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA17),	STARTX+196, STARTY+475,  500, 640);	//Àü¿ù°ËÄ§ÄÚµå
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA18),	STARTX+500, STARTY+475,  785, 640);	//Àü¿ùÁöÄ§
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA19),	STARTX+785, STARTY+475, 1000, 640);	//Àü¿ù»ç¿ë·®

				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA12),	STARTX    , STARTY+540,  196, 705);	//ÀüÀü¿ù			
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA20),	STARTX+196, STARTY+540,  500, 705);	//ÀüÀü¿ù°ËÄ§ÄÚµå
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA21),	STARTX+500, STARTY+540,  785, 705);	//ÀüÀü¿ùÁöÄ§
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA22),	STARTX+785, STARTY+540, 1000, 705);	//ÀüÀü¿ù»ç¿ë·®
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA15), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_USEQTY), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA23), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA24), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA)    , FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM)    , FALSE);
			}
			// º¸Á¤±â
			else if( 20 == m_lUserData )
			{
				if( Str_Cmp(m_szbj, "") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[0].Str );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) , FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA) , FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM) , FALSE );
					
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);				
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), m_szbj);
					
					if( Str_Cmp(m_szbj, "2:ºÎÀç") == 0 )
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) , TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA) , TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM) , TRUE );
						
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), RED);		
					}
					else
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) , FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA) , FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM) , FALSE );
						
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
					}
				}
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), "VC");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA15), "VA");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_USEQTY), "VM");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA24), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "");
				
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA13),  STARTX    , STARTY+345,  392, STARTY+410);	//±³Ã¼ÀÏ
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA14),  STARTX+392,	STARTY+345,  595, STARTY+410);	//VC
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA15),  STARTX+595,	STARTY+345,  798, STARTY+410);	//VA
				BUTSETRANGE(Get_hDlgCtrlByID(BID_USEQTY),   STARTX+798,	STARTY+345, 1000, STARTY+410);	//VM(»ç¿ë·®ÃßÀÌ)

				BUTSETRANGE(Get_hDlgCtrlByID(BID_THMONTH),	STARTX    ,	STARTY+410,  196, STARTY+475);	//´ç¿ù
				EDITSETRANGE(Get_hDlgCtrlByID(CMB_RESULT),	STARTX+196, STARTY+410,  392, STARTY+475);	//°ËÄ§ÄÚµå
				BUTSETRANGE(Get_hDlgCtrlByID(CMB_RESULT+1),	STARTX+308, STARTY+411,  392, STARTY+474);	//°ËÄ§ÄÚµå
				EDITSETRANGE(Get_hDlgCtrlByID(EDT_VC),		STARTX+390,	STARTY+410,  595, STARTY+475);	//VCÀÔ·Â
				EDITSETRANGE(Get_hDlgCtrlByID(EDT_VA),		STARTX+595,	STARTY+410,  798, STARTY+475);	//VAÀÔ·Â
				EDITSETRANGE(Get_hDlgCtrlByID(EDT_VM), 		STARTX+798,	STARTY+410, 1000, STARTY+475);	//VMÀÔ·Â
				
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA11),	STARTX	  ,	STARTY+475,  196, STARTY+540);	//Àü¿ù
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA17),	STARTX+196,	STARTY+475,  392, STARTY+540);	//Àü¿ùÄÚµå
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA18),	STARTX+392,	STARTY+475,  595, STARTY+540);	//Àü¿ùVC
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA19),	STARTX+595,	STARTY+475,  798, STARTY+540);	//Àü¿ùVA
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA20),	STARTX+798,	STARTY+475, 1000, STARTY+540);	//Àü¿ùVM

				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA12),	STARTX	  , STARTY+540,  196, STARTY+605);	//ÀüÀü¿ù
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA21),	STARTX+196, STARTY+540,  392, STARTY+605);	//ÀüÀü¿ùÄÚµå
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA22),	STARTX+392, STARTY+540,  595, STARTY+605);	//ÀüÀü¿ùVC
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA23),	STARTX+595, STARTY+540,  798, STARTY+605);	//ÀüÀü¿ùVA
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA24),	STARTX+798, STARTY+540, 1000, STARTY+605);	//ÀüÀü¿ùVM
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA15), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA23), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA24), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA15), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA21), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA23), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA24), TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA)    , TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM)    , TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_USEQTY), FALSE);
			}
			// ¿Âµµº¸Á¤±â, ¿Â¾Ðº¸Á¤±â
			else if( 41 == m_lUserData || 40 == m_lUserData )
			{
				if( Str_Cmp(m_sztp, "") == 0 )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[0].Str );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), m_sztp);
					
					if( Str_Cmp(m_sztp,"2:ºÎÀç") == 0 )
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
						
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), RED);	
					}
					else
					{
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
						DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
						DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
						
						ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
					}
				}
				
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), "VC");
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_USEQTY), "VM");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA24), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "");
				
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA13),  STARTX    ,	STARTY+345,  480, STARTY+410);	//±³Ã¼ÀÏ
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA14),  STARTX+480, STARTY+345,  740, STARTY+410);	//VC
				BUTSETRANGE(Get_hDlgCtrlByID(BID_USEQTY),   STARTX+740, STARTY+345, 1000, STARTY+410);	//VM

				BUTSETRANGE(Get_hDlgCtrlByID(BID_THMONTH),  STARTX    , STARTY+410,  196, STARTY+475);	//´ç¿ù
				EDITSETRANGE(Get_hDlgCtrlByID(CMB_RESULT),  STARTX+196, STARTY+410,  480, STARTY+475);	//°ËÄ§ÄÚµå
				BUTSETRANGE(Get_hDlgCtrlByID(CMB_RESULT+1), STARTX+390, STARTY+411,  480, STARTY+474);	//°ËÄ§ÄÚµå
				EDITSETRANGE(Get_hDlgCtrlByID(EDT_VC), 	    STARTX+480, STARTY+410,  740, STARTY+475);	//VCÀÔ·Â
				EDITSETRANGE(Get_hDlgCtrlByID(EDT_VM),      STARTX+740, STARTY+410, 1000, STARTY+475);	//VMÀÔ·Â

				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA11),  STARTX    , STARTY+475,  196, STARTY+540);	//Àü¿ù
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA16),  STARTX+196, STARTY+475,  480, STARTY+540);	//Àü¿ùÄÚµå
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA17),  STARTX+480, STARTY+475,  740, STARTY+540);	//Àü¿ùVC
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA18),  STARTX+740, STARTY+475, 1000, STARTY+540);	//Àü¿ùVM

				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA12),  STARTX    , STARTY+540,  196, STARTY+605);	//ÀüÀü¿ù
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA19),  STARTX+196, STARTY+540,  480, STARTY+605);	//ÀüÀü¿ùÄÚµå
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA20),  STARTX+480, STARTY+540,  740, STARTY+605);	//ÀüÀü¿ùVC
				EDITSETRANGE(Get_hDlgCtrlByID(TXT_DATA21),  STARTX+740, STARTY+540, 1000, STARTY+605);	//ÀüÀü¿ùVM
				
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA16), EDITALIGN_CENTER|EDITALIGN_MIDDLE);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA17), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA18), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA19), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA20), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA21), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);
				EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA22), EDITALIGN_MIDDLE|EDITALIGN_RIGHT);

				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA15), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA22), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA23), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_DATA24), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(TXT_USEQTY), FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA)	 , FALSE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC)	 , TRUE);
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM)	 , TRUE);
			}
		}	
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : SetData
	±â  ´É : Data Setting
	Param  : 
	Return : 
	========================================================================================*/
	void SetData(void)
	{
		long i;
		char szindex[10];
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set((byte*)&stGm, 0x00, sizeof(stGm));

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		hstmt = sql->CreateStatement(sql,
		" SELECT ROWID, REQ_YM, DEADLINE_FLAG, MTR_NUM, GMTR_APPLY_YMD \
			   , GMTR_OBJ_FLAG, SUPPLY_STS_CD, SUPPLY_STS_WHY, STR_IND_APPLY_YMD, BASE_YMD \
			   , MTR_ID_NUM, MTR_LOC_FLAG, MTR_RESOU_FLAG, GRD_TITLE, USAGE_TITLE \
			   , HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE, TRIM(USE_CONT_NUM), PROD_CD \
			   , CONT_YMD, CNL_YMD, PAY_METHOD, NONPAY_EXIST_YN, ZIP_NO1 \
			   , ZIP_NO2, AREA, TOWN, VILLAGE, ADDR1_M \
			   , TRIM(ADDR1_S), TRIM(CO_LIVE_NM), DONG_NUM, HOSU, TRIM(BLD_NM) \
			   , BLD_NUM, DETA_FLOOR, NEW_ADDR_UNION, CUST_NUM, CUST_TYPE_CD \
			   , CUST_NM, TRIM(FIRM_NM), BIZ_REGI_NUM, SOC_NUM, REPRE_NM \
			   , TRIM(CP_DDD), TRIM(CP_EXN), TRIM(CP_NUM), TRIM(OWNHOUSE_TEL_DDD), TRIM(OWNHOUSE_TEL_EXN) \
			   , TRIM(OWNHOUSE_TEL_NUM), BEFO_GMTR_CD_1, BEFO_MM_INDI_MTR_1, BEFO_MM_INDI_COMPENS_VA_1, BEFO_MM_INDI_COMPENS_VC_1 \
			   , BEFO_GMTR_CD_2, BEFO_MM_INDI_MTR_2, BEFO_MM_INDI_COMPENS_VA_2, BEFO_MM_INDI_COMPENS_VC_2, BEFO_GMTR_CD_3 \
			   , BEFO_MM_INDI_MTR_3, BEFO_MM_INDI_COMPENS_VA_3, BEFO_MM_INDI_COMPENS_VC_3, BEFO_YY_GMTR_CD, BEFO_YY_MTR \
			   , BEFO_YY_COMPENS_VA, BEFO_YY_COMPENS_VC, BEFO_MM_USE_QTY_1, BEFO_MM_USE_QTY_2, BEFO_MM_USE_QTY_3 \
			   , BEFO_YM_USE_QTY, TRIM(MTR_CHG_YMD), MTR_REPL_WHY, MTR_INDI_CUST, INDI_COMPENS_CIVIL_SERV_VA \
			   , INDI_COMPENS_CIVIL_SERV_VC, TRIM(RMK), MTR_WORK_CODE, INDI_SET_VM, INDI_SET_VA \
			   , INDI_SET_VC, INDI_DATE, SEND_YN, INDI_QTY, COMPENS_FLAG \
			   , GCHK_FLAG, GMTR_YM_FLAG, EBPP_FLAG, MTR_YN, MONITOR_FLAG \
			   , CUST_TRND_YN, GMETER_SEND_YN, CURR_TEMPER, CURR_PRES, CURR_REVIS_PARA \
			   , MAX_GMTR_QTY, LAW_TOWN, NEW_ROAD_NM, NEW_ADDR_M, NEW_ADDR_S \
			   , BIZ_TYPE_YN, SAME_GMTR_YN, SELF_GMTR_YN, MTR_FORM, TRIM(CHK_MEMO) \
			   , INSP_YN, INSP_MEMO, INDI_INSP_VM, INDI_INSP_VA, INDI_INSP_VC \
			   , INSP_YMD, INSP_SAVE_YN, SMS_GMTR_MAN_YN, NONPAY_MANAGE_SEC, SMS_CP_DDD \
			   , SMS_CP_EXN, SMS_CP_NUM, COMPENS_REMOVE_ALARM, MTR_DIGIT_CNT, SELF_GMTR_STR_YMD \
			   , SELF_GMTR_END_YMD, BEFO_GMTR_SMS_YN, GMTR_MANAGE_STS, DEADLINE_CHG_YN, COMPENS_REMOVE_ALARM_2 \
			   , INST_PLACE_NUM, OLD_COMPENS_REMOVE_ALARM_2, PHOTO_MTR_YN, PHOTO_COMPENS_VC_YN, PHOTO_COMPENS_VA_YN \
			   , PHOTO_COMPENS_VM_YN, GUM_TYPE, USE_CONT_STS_CD,REMOTE_GMTR_YN,RECENT_INDI_MTR_MM_VC,RECENT_GMTR_JOB_YMD, SUBSTR(RECENT_GMTR_JOB_YMD,0,5) AS RECENT_GMTR_JOB_YMD_YEAR \
		       , SUBSTR(RECENT_GMTR_JOB_YMD,5,2) AS RECENT_GMTR_JOB_YMD_MONTHS , SUBSTR(RECENT_GMTR_JOB_YMD,7,2) AS RECENT_GMTR_JOB_YMD_DAYS , DISC_CUST_YN\
		    FROM REGUMDATA WHERE ROWID = ? \
		   ORDER BY HOUSE_NUM_ORD, DONG_ORD, MTR_COURSE "
		);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		i = 0;
		Mem_Set((byte*)&szindex, 0x00, sizeof(szindex));
		Str_ItoA(g_lindex,szindex,10);

		sql->Bind(sql, i++, 'U', (long*)&szindex , 4, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Next(sql) == TRUE )
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) stGm.ROWID						, 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.REQ_YM						, 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.DEADLINE_FLAG				, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_NUM						, 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.GMTR_APPLY_YMD				, 8  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.GMTR_OBJ_FLAG				, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SUPPLY_STS_CD				, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SUPPLY_STS_WHY				, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.STR_IND_APPLY_YMD			, 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BASE_YMD						, 8  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_ID_NUM					, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_LOC_FLAG					, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_RESOU_FLAG				, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.GRD_TITLE					, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.USAGE_TITLE					, 30 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.HOUSE_NUM_ORD				, 40 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.DONG_ORD						, 40 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_COURSE					, 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.USE_CONT_NUM					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.PROD_CD						, 30 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.CONT_YMD						, 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CNL_YMD						, 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.PAY_METHOD					, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.NONPAY_EXIST_YN				, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.ZIP_NO1						, 3  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.ZIP_NO2						, 3  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.AREA							, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.TOWN							, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.VILLAGE						, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.ADDR1_M						, 30 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.ADDR1_S						, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CO_LIVE_NM					, 60 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.DONG_NUM						, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.HOSU							, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BLD_NM						, 60 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.BLD_NUM						, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.DETA_FLOOR					, 100+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.NEW_ADDR_UNION				, 100+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CUST_NUM						, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CUST_TYPE_CD					, 2  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.CUST_NM						, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.FIRM_NM						, 50 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BIZ_REGI_NUM					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SOC_NUM						, 13 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.REPRE_NM						, 30 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.CP_DDD						, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CP_EXN						, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CP_NUM						, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.OWNHOUSE_TEL_DDD				, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.OWNHOUSE_TEL_EXN				, 4  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.OWNHOUSE_TEL_NUM				, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_GMTR_CD_1				, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_INDI_MTR_1			, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_INDI_COMPENS_VA_1	, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_INDI_COMPENS_VC_1	, 10 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_GMTR_CD_2				, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_INDI_MTR_2			, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_INDI_COMPENS_VA_2	, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_INDI_COMPENS_VC_2	, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_GMTR_CD_3				, 10 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_INDI_MTR_3			, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_INDI_COMPENS_VA_3	, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_INDI_COMPENS_VC_3	, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_YY_GMTR_CD				, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_YY_MTR					, 10 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_YY_COMPENS_VA			, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_YY_COMPENS_VC			, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_USE_QTY_1			, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_USE_QTY_2			, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_MM_USE_QTY_3			, 10 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_YM_USE_QTY				, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_CHG_YMD					, 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_REPL_WHY					, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_INDI_CUST				, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_COMPENS_CIVIL_SERV_VA	, 10 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_COMPENS_CIVIL_SERV_VC	, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.RMK							, 200+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_WORK_CODE				, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_SET_VM					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_SET_VA					, 10 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_SET_VC					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_DATE					, 16 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SEND_YN						, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_QTY						, 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.COMPENS_FLAG					, 2  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.GCHK_FLAG					, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.GMTR_YM_FLAG					, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.EBPP_FLAG					, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_YN						, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MONITOR_FLAG					, 2  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.CUST_TRND_YN					, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.GMETER_SEND_YN				, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CURR_TEMPER					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CURR_PRES					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CURR_REVIS_PARA				, 10 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.MAX_GMTR_QTY					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.LAW_TOWN						, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.NEW_ROAD_NM					, 200+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.NEW_ADDR_M					, 30 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.NEW_ADDR_S					, 30 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.BIZ_TYPE_YN					, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SAME_GMTR_YN					, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SELF_GMTR_YN					, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_FORM						, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.CHK_MEMO						, 200+ 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.INSP_YN						, 5 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INSP_MEMO					, 300+ 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_INSP_VM					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_INSP_VA					, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INDI_INSP_VC					, 10 + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.INSP_YMD						, 20 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.INSP_SAVE_YN					, 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SMS_GMTR_MAN_YN				, 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.NONPAY_MANAGE_SEC			, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SMS_CP_DDD					, 5  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.SMS_CP_EXN					, 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SMS_CP_NUM					, 5  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.COMPENS_REMOVE_ALARM		    , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.MTR_DIGIT_CNT  		        , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.SELF_GMTR_STR_YMD  		    , 8  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.SELF_GMTR_END_YMD  		    , 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.BEFO_GMTR_SMS_YN  		    , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.GMTR_MANAGE_STS  		    , 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.DEADLINE_CHG_YN  		    , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.COMPENS_REMOVE_ALARM_2  		, 1  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.INST_PLACE_NUM      		    , 9  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.OLD_COMPENS_REMOVE_ALARM_2  	, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.PHOTO_MTR_YN  	    	    , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.PHOTO_COMPENS_VC_YN  	   	, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.PHOTO_COMPENS_VA_YN  	   	, 1  + 1, DECRYPT );
			
			sql->GetValue( sql, i++, 'U', (long*) stGm.PHOTO_COMPENS_VM_YN  	   	, 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.GUM_TYPE  	   	            , 1  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.USE_CONT_STS_CD     	     	, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.REMOTE_GMTR_YN    	     	, 2  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.RECENT_INDI_MTR_MM_VC    	, 10 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.RECENT_GMTR_JOB_YMD		 	, 8  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.RECENT_GMTR_JOB_YMD_YEAR 	, 6  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.RECENT_GMTR_JOB_YMD_MONTHS 	, 4  + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) stGm.RECENT_GMTR_JOB_YMD_DAYS 	, 4  + 1, DECRYPT );
			sql->GetValue(sql, i++,  'U', (long *)stGm.DISC_CUST_YN, 2 + 1, DECRYPT);
			
		}
		else
		{
			PRINT("::sql->Next fail [%s]",sql->GetLastError(sql),0,0);
			goto Finally;
		}

Finally:
		DelSqLite(sql);

		// °è¾à»óÅÂ ÇØÁö¸é °í°´¸í, ÀüÈ­¹øÈ£, »ý³â¿ùÀÏ ¾Èº¸ÀÌµµ·Ï ¼öÁ¤
		if( Str_Cmp(stGm.USE_CONT_STS_CD, "30") == 0 )
		{
			Mem_Set((byte *)stGm.CUST_NM, 0x00, sizeof(stGm.CUST_NM));
			Str_Cpy( stGm.CUST_NM, "" );
			
			Mem_Set((byte *)stGm.CP_DDD, 0x00, sizeof(stGm.CP_DDD));
			Str_Cpy( stGm.CP_DDD, "" );
			
			Mem_Set((byte *)stGm.CP_EXN, 0x00, sizeof(stGm.CP_EXN));
			Str_Cpy( stGm.CP_EXN, "" );
			
			Mem_Set((byte *)stGm.CP_NUM, 0x00, sizeof(stGm.CP_NUM));
			Str_Cpy( stGm.CP_NUM, "" );
			
			Mem_Set((byte *)stGm.OWNHOUSE_TEL_DDD, 0x00, sizeof(stGm.OWNHOUSE_TEL_DDD));
			Str_Cpy( stGm.OWNHOUSE_TEL_DDD, "" );
			
			Mem_Set((byte *)stGm.OWNHOUSE_TEL_EXN, 0x00, sizeof(stGm.OWNHOUSE_TEL_EXN));
			Str_Cpy( stGm.OWNHOUSE_TEL_EXN, "" );
			
			Mem_Set((byte *)stGm.OWNHOUSE_TEL_NUM, 0x00, sizeof(stGm.OWNHOUSE_TEL_NUM));
			Str_Cpy( stGm.OWNHOUSE_TEL_NUM, "" );
			
			Mem_Set((byte *)stGm.SOC_NUM, 0x00, sizeof(stGm.SOC_NUM));
			Str_Cpy( stGm.SOC_NUM, "" );
		}
		
		return;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : REDRAW
	±â  ´É : °ËÄ§ ÀÚ·á¸¦ ÀÐ¾î¿Í¼­ È­¸é¿¡ ¼³Á¤ÇÑ´Ù.
	Param  : 
	Return : 
	========================================================================================*/
	void REDRAW(void)
	{
		long i;
		long lAddr = 0;
		long lEndDate, lToDate;
		char szToday[20];
		long cnt = 0;
		char szTmp[200];
		char szTitle[200];
		char szSql[300];
		
		Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
		Str_ItoA(Time_GetDate(), szToday, 10); //0502
		/*****************************************/
		/* Å¸ÀÌÆ²                                */
		/*****************************************/
		Mem_Set((byte *)szTitle, 0x00, sizeof(szTitle));
		
		Str_Cpy(szTitle, "[");
		
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
		g_Sql_RetStr("SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '10'", 10, szTmp );
		
		Str_Cat(szTitle, szTmp);
		
		Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));		
		g_Sql_RetStr("SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '10'", 5, szTmp );
		
		Str_Cat(szTitle, "/");
		Str_Cat(szTitle, szTmp);
		Str_Cat(szTitle, "]");
		
		if( Str_Cmp( stGm.GUM_TYPE, "20" ) == 0 )
		{
			Str_Cat(szTitle, " Àç°Ë µî·Ï");
		}
		else
		{
			Str_Cat(szTitle, " Á¶Á¤ ¿¡·¯ µî·Ï");
		}
		
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_TITLE), szTitle);
		
		/*****************************************/
		/* ÇöÀçÆäÀÌÁö¸¦ Ç¥½Ã                     */
		/*****************************************/
		Mem_Set((byte *)m_szCnt_index, 0x00, sizeof(m_szCnt_index));
		SPRINT(m_szCnt_index, "%d/%d", g_nActIndex+1, m_ltotcnt, 0);
		
		/*****************************************/
		/* ³¯Â¥(ÀÏ) Ç¥½Ã                         */
		/*****************************************/
		EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA2), stGm.BASE_YMD);
		
		/*****************************************/
		/* ¿ä±Ý¿ëµµ                              */
		/*****************************************/
	    EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA5), stGm.PROD_CD);
		
		/*****************************************/
		/* °í°´¼ºÇâ                              */
		/*****************************************/
        if(Str_Cmp(stGm.CUST_TRND_YN, "Y") == 0)
        {
        	EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA97), RED);
        }
        else
        {
        	EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA97), GREEN);
        }
		
		/*****************************************/
		/* °ËÄ§¼Û´Þ¿©ºÎ                          */
		/*****************************************/
        if(Str_Cmp(stGm.GMETER_SEND_YN, "Y") == 0)
        {
        	EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA98), RED);
        }
        else
        {
        	EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA98), GREEN);
        }
		
		/*****************************************/
		/* °ËÄ§ ½Ç»ç ¿©ºÎ                        */
		/*****************************************/
        if(Str_Cmp(stGm.INSP_YN, "Y") == 0)
        {
        	ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SILSA), RED);
        }
        else
        {
        	ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SILSA), BTNMENUFRCOLOR);
        }
		
		/*****************************************/
		/* EBPP±¸ºÐ                              */
	  	/* EBPP_FLAG = Y [¸ÞÀÏ]					 */
  		/* EBPP_FLAG = L [LMS]					 */
  		/* EBPP_FLAG = M [¸ð¹ÙÀÏ]				 */
        /* ÀÌ¿Ü          []						 */						
        /*****************************************/
		if( Str_Cmp(stGm.EBPP_FLAG, "Y") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "¸ÞÀÏ");
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA8), RED);
		}
		else if( Str_Cmp(stGm.EBPP_FLAG, "L") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "LMS");
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA8), RED);
		}
		else if( Str_Cmp(stGm.EBPP_FLAG, "M") == 0 )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "¸ð¹ÙÀÏ");
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA8), RED);
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA8), "");
		}
		
		/*****************************************/
		/* °ËÄ§¿ù±¸ºÐ                            */
		/*****************************************/
		if(Str_Cmp(stGm.GMTR_YM_FLAG, "20") == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "Â¦");
		}
		else if(Str_Cmp(stGm.GMTR_YM_FLAG, "30") == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "È¦");
		}
		else if(Str_Cmp(stGm.GMTR_YM_FLAG, "21") == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "°ÝÂ¦");
		}
		else if(Str_Cmp(stGm.GMTR_YM_FLAG, "31") == 0)
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "°ÝÈ¦");
		}
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA4), "¸Å");
		}
		
		/*****************************************/
 		/* °è·®±âÀ§Ä¡±¸ºÐ                        */
 		/*****************************************/
        if(Str_Cmp(stGm.MTR_LOC_FLAG, "10") == 0)
        {
        	EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA99), BLUE);
        	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA99), "³»ºÎ");
        }
        else
        {
        	EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(TXT_DATA99), RED);
        	EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA99), "¿ÜºÎ");
        }
        
        /*****************************************/
		/* ¿ä±Ý ¹öÆ°                             */
		/*****************************************/
        if(Str_AtoI(stGm.MONITOR_FLAG) >= 10 )
        {
        	ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_FEE), THEBLUE);
        }
        else
        {
        	ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_FEE), BTNCTRLBKCOLOR);
        }
		
		/*******************************************************************************/
		/* »èÁ¦ ¹öÆ°																   */
		/* SEND_YN(¼Û½Å¿©ºÎ·Î ÆÇ´Ü, I, S, N)										   */
		/* °ËÄ§°á°ú°¡ ÀÖÀ¸¸é Ãë¼Ò red -> S, I(I´Â ¼ø¼ö¹Ì°ËÄ§ ´ë»óÀÌ ÀúÀå‰çÀ»¶§ÀÇ flag) */
		/* °ËÄ§°á°ú°¡ ¾øÀ¸¸ç »èÁ¦ darkturquoise -> N                                   */
		/*******************************************************************************/
        if((Str_Cmp(stGm.SEND_YN, "S") == 0 || Str_Cmp(stGm.SEND_YN, "I") == 0) || Str_Cmp(stGm.MTR_WORK_CODE, "L") == 0 )
        {
        	ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_DELETE), RED);
        	ButCtrl_SetText(Get_hDlgCtrlByID(BID_DELETE), "Ãë¼Ò");
        }
        else 
        {
        	ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_DELETE), BTNCTRLBKCOLOR);
        	ButCtrl_SetText(Get_hDlgCtrlByID(BID_DELETE), "»èÁ¦");

        }
		
		/*****************************************/
		/* ¸Þ¸ðÁ¤º¸À¯¹«Ã¼Å©                      */
		/*****************************************/
		if(Str_Len(stGm.RMK) > 0 || Str_Len(stGm.CHK_MEMO) > 0 )
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), RED);
		}
		else
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MEMO), BTNMENUFRCOLOR);
		}
		
		/*****************************************/	
		/* Á¡°Ë¹öÆ°                              */
		/*****************************************/	
		if(Str_AtoI(stGm.GCHK_FLAG) == 20)
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SC), RED);
		}
		else
		{
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SC), BTNMENUFRCOLOR);
		}
		
		/*****************************************/	
		/* ±â¹° ¹öÆ°                             */
		/*****************************************/	
		if( Str_Cmp(stGm.SUPPLY_STS_CD, "Á¤»ó") == 0 || Str_Cmp(stGm.SUPPLY_STS_CD, "ÇØÁö") == 0  || Str_Len(stGm.SUPPLY_STS_CD) == '0')
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_ADDR4), BTNMENUFRCOLOR);
		}
		else
		{
			EditCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_ADDR4), RED);
		}
		
		/**************************************************/	
		/* °í°´¹öÆ°                                       */  
		/* ÁßÁö»óÅÂÀÌ°Å³ª, ÀÓ½Ã°í°´ÀÏ¶§ °í°´¹öÆ° »öÀÌ RED */
		/**************************************************/
		if( Str_Cmp(stGm.CNL_YMD, "99991231") != 0 || stGm.CUST_NUM[0] == '0' || Str_Cmp(stGm.SUPPLY_STS_CD, "ÁßÁö") == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CLIENT), RED);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_CLIENT), BTNCTRLBKCOLOR);
		}
		
		/**************************************************/
		/* ÁÖ¼Ò											  */
		/**************************************************/
		Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
		
		// Áö¹ø
		if( g_nAddrFlag == 0)
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR1), "Áö¹ø");
			
			if(Str_Len(stGm.TOWN) > 0)
			{
				Str_Cpy(szAddr,  stGm.TOWN );
			}
			else
			{
				Str_Cpy(szAddr,  "" );
			}
			
			if(Str_Len(stGm.VILLAGE) > 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.VILLAGE );
			}
			
			if(Str_Len(stGm.ADDR1_M) > 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.ADDR1_M);
			}
			
			if(Str_Len(stGm.ADDR1_S) > 0)
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.ADDR1_S);
			}
			
			lAddr = Str_Len(stGm.CO_LIVE_NM) + Str_Len(stGm.BLD_NM);

			if( lAddr > 0 )
			{
				if( Str_Len(stGm.CO_LIVE_NM) > 0 )
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.CO_LIVE_NM );
				}
				else
				{
					Str_Cat(szAddr,  "" );
				}
				
				if( Str_Len(stGm.BLD_NM) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.BLD_NM );
				}
				
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szAddr,  "-" );	
					Str_Cat(szAddr,  stGm.HOSU );
				}
				
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.DETA_FLOOR );
				}
			}
			else
			{
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.HOSU );
				}
				else
				{
					Str_Cat(szAddr,  "" );
				}
				
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.DETA_FLOOR );
				}
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), szAddr);
		}
		// µµ·Î¸í
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR1), "µµ·Î¸í");
			
			if(Str_Len(stGm.NEW_ROAD_NM) > 0)
			{
				Str_Cpy(szAddr,  stGm.NEW_ROAD_NM );
			}
			else
			{
				Str_Cpy(szAddr,  "" );
			}
			
			if(Str_Len(stGm.NEW_ADDR_M) > 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.NEW_ADDR_M);
			}
			
			if(Str_Len(stGm.NEW_ADDR_S) > 0)
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.NEW_ADDR_S);
			}

			if( Str_Len(stGm.CO_LIVE_NM) > 0 )
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.CO_LIVE_NM );
			}
			else
			{
				Str_Cat(szAddr,  "" );
			}
			
			if( Str_Len(stGm.BLD_NM) > 0 )
			{
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.BLD_NM );
			}
			
			if( Str_Len(stGm.HOSU) > 0 )
			{
				Str_Cat(szAddr,  "-" );	
				Str_Cat(szAddr,  stGm.HOSU );
			}
			
			if( Str_Len(stGm.DETA_FLOOR) > 0 )
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.DETA_FLOOR );		//¼¼ºÎÃþ
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA3), szAddr);
		}
		
		/**************************************************/
		/* °í°´¸í&»óÈ£¸í Åä±Û , m_lNameFlag               */
		/**************************************************/
		Mem_Set( (byte*)m_szName, 0x00, sizeof(m_szName) );
		
		if( g_nNameFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR2), "»óÈ£");
			
			if( Str_Cmp( stGm.FIRM_NM, "" ) == 0 )
			{
				Str_Cpy(m_szName, stGm.CUST_NM);
			}
			else
			{
				Str_Cpy(m_szName, stGm.FIRM_NM);
				
				if( Str_Cmp( stGm.CUST_NM, "" ) != 0 )
				{
					Str_Cat(m_szName, "/");
					Str_Cat(m_szName, stGm.CUST_NM);
				}
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), m_szName );
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR2), "°Ç¹°");
				
			if( Str_Cmp( stGm.BLD_NM, "" ) == 0 )
			{
				Str_Cpy(m_szName, stGm.CUST_NM);
			}
			else
			{
				Str_Cpy(m_szName, stGm.BLD_NM);
				
				if( Str_Cmp( stGm.CUST_NM, "" ) != 0 )
				{
					Str_Cat(m_szName, "/");
					Str_Cat(m_szName, stGm.CUST_NM);
				}
			}
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA7), m_szName );
		}
		
		/**************************************************/
		/* ±â¹°¹øÈ£                                       */
		/**************************************************/
		ButCtrl_SetText(Get_hDlgCtrlByID(BID_MTR_ID_NUM), stGm.MTR_ID_NUM); 
		
		/**************************************************/
		/* ÇÚµåÆù&ÁýÀüÈ­¹øÈ£ Åä±Û , m_lPhoneflag          */
		/**************************************************/
		Mem_Set((byte *)m_szPhone, 0x00, sizeof(m_szPhone));
		
		// HP
		if( g_nTelFlag == 0 )
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR5), "HP");
		
			Str_Cpy(m_szPhone,  stGm.CP_DDD );
			Str_Cat(m_szPhone,  "-" );
			
			if(Str_Len(stGm.CP_EXN) == 0)
			{
				Str_Cat(m_szPhone,  " " );	
			}
			else
			{
				Str_Cat(m_szPhone,  stGm.CP_EXN);
			}
			
			Str_Cat(m_szPhone,  "-" );

			if(Str_Len(stGm.CP_NUM) == 0)
			{
				Str_Cat(m_szPhone,  " " );	
			}
			else
			{
				Str_Cat(m_szPhone,  stGm.CP_NUM);
			}
			
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_TEL), m_szPhone);
			
			if( Str_Len(m_szPhone) > 10)
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TEL), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TEL), FALSE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TEL), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TEL), TRUE );
			}
		}
		// TEL
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_ADDR5), "TEL");
		
			Str_Cpy(m_szPhone,  stGm.OWNHOUSE_TEL_DDD );
			Str_Cat(m_szPhone,  "-" );
			
			if(Str_Len(stGm.OWNHOUSE_TEL_EXN) == 0)
			{
				Str_Cat(m_szPhone,  " " );	
			}
			else
			{
				Str_Cat(m_szPhone,  stGm.OWNHOUSE_TEL_EXN);
			}
			
			Str_Cat(m_szPhone,  "-" );
			
			if(Str_Len(stGm.OWNHOUSE_TEL_NUM) == 0)
			{
				Str_Cat(m_szPhone,  " " );	
			}
			else
			{
				Str_Cat(m_szPhone,  stGm.OWNHOUSE_TEL_NUM);
			}
			
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_TEL), m_szPhone);
			
			if( Str_Len(m_szPhone) > 10)
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TEL), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TEL), FALSE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_TEL), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_TEL), TRUE );
			}
		}
		
		/**********************************************************************/
		/* MONITOR_FLAG >= 10 ÀÏ¶§, Àü¿ù¶óÀÎ »ö º¯°æ, Àü¿ù/ÀüÀü¿ù µ¥ÀÌÅÍ ÀÔ·Â */
		/**********************************************************************/
		/**************************************************/
		/* È­¸é Data Setting                              */
		/**************************************************/
		// °è·®±â
		if( 10 == m_lUserData )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA14), stGm.MTR_CHG_YMD );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), stGm.BEFO_GMTR_CD_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), stGm.BEFO_MM_INDI_COMPENS_VC_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), stGm.BEFO_MM_USE_QTY_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), stGm.BEFO_GMTR_CD_2 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), stGm.BEFO_MM_INDI_COMPENS_VC_2 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), stGm.BEFO_MM_USE_QTY_2 );
			
			if( Str_Cmp(stGm.BEFO_MM_INDI_COMPENS_VC_1, stGm.BEFO_MM_INDI_COMPENS_VC_2) == 0 && 
			    Str_Cmp(stGm.BEFO_MM_INDI_COMPENS_VC_1, stGm.BEFO_MM_INDI_COMPENS_VC_3) == 0)
			{
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA11), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA17), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA18), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA19), BRIGHTPINK);
				
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA16), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA20), TXTINCTRLBK);
			}
			else
			{
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA11), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA17), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA18), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA19), TXTINCTRLBK);
				
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA16), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA20), TXTINCTRLBK);
			}
		}
		// º¸Á¤±â
		else if( 20 == m_lUserData )
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), stGm.BEFO_GMTR_CD_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), stGm.BEFO_MM_INDI_COMPENS_VC_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), stGm.BEFO_MM_INDI_COMPENS_VA_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), stGm.BEFO_MM_INDI_MTR_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), stGm.BEFO_GMTR_CD_2 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA22), stGm.BEFO_MM_INDI_COMPENS_VC_2 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA23), stGm.BEFO_MM_INDI_COMPENS_VA_2 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA24), stGm.BEFO_MM_INDI_MTR_2 );

			if( Str_Cmp(stGm.BEFO_MM_INDI_COMPENS_VC_1, stGm.BEFO_MM_INDI_COMPENS_VC_2) == 0 && 
			    Str_Cmp(stGm.BEFO_MM_INDI_COMPENS_VC_1, stGm.BEFO_MM_INDI_COMPENS_VC_3) == 0)
			{
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA11), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA17), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA18), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA19), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA20), BRIGHTPINK);

				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA16), TXTINCTRLBK);
			}
			else
			{
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA11), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA17), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA18), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA19), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA20), TXTINCTRLBK);

				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA16), TXTINCTRLBK);
			}
		}
		// ¿Âµµ, ¿Â¾Ðº¸Á¤±â
		else
		{
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA16), stGm.BEFO_GMTR_CD_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA17), stGm.BEFO_MM_INDI_COMPENS_VC_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA18), stGm.BEFO_MM_INDI_MTR_1 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA19), stGm.BEFO_GMTR_CD_2 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA20), stGm.BEFO_MM_INDI_COMPENS_VC_2 );
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA21), stGm.BEFO_MM_INDI_MTR_2 );

			if( Str_Cmp(stGm.BEFO_MM_INDI_COMPENS_VC_1, stGm.BEFO_MM_INDI_COMPENS_VC_2) == 0 && 
			    Str_Cmp(stGm.BEFO_MM_INDI_COMPENS_VC_1, stGm.BEFO_MM_INDI_COMPENS_VC_3) == 0)
			{
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA11), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA16), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA17), BRIGHTPINK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA18), BRIGHTPINK);

				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA19), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA20), TXTINCTRLBK);
			}
			else
			{
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA11), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA16), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA17), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA18), TXTINCTRLBK);

				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA19), TXTINCTRLBK);
				EditCtrl_SetBkColorEx(Get_hDlgCtrlByID(TXT_DATA20), TXTINCTRLBK);
			}
		}
		
		/*****************************************************/	
		/* º¸Á¤±â »èÁ¦ ´ë»ó¿¡ µû¸¥ ±â¹°¹øÈ£ TXT, BTN SETTING */
		/*****************************************************/
		// 1. Àü´Þ ¼­¸íÀ» ¹Þ¾ÒÀ¸¸é ³ë¶õ»ö
		// 2. Àü´Þ ¼­¸íÀ» ¹ÞÁö ¾Ê¾ÆÀ¸¸ç °íÀåÀÌ¸é »¡°£»ö
		// 3, Á¤»óÀÌ¸é Èò»ö
		if( Str_Cmp( stGm.OLD_COMPENS_REMOVE_ALARM_2, "Y" ) == 0 )
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MTR_ID_NUM), YELLOW);
    		ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MTR_ID_NUM), TXTFRCOLOR);
		}
		else
		{
			if( Str_Cmp( stGm.COMPENS_REMOVE_ALARM_2, "Y" ) == 0 )
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MTR_ID_NUM), RED);
	    		ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MTR_ID_NUM), BTNMENUFRCOLOR);
			}
			else
			{
				ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_MTR_ID_NUM), TXTINCTRLBK);
	    		ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MTR_ID_NUM), TXTFRCOLOR);
			}
		}		
			
		/**************************************************/
		/* È­¸é Data Setting                              */
		/**************************************************/
		// È­¸é ÃÖÃÊ Á¢±Ù½Ã È­¸é Ç¥±â
		if( g_lDataflag == 0)
		{
			// °è·®±â
			if( 10 == m_lUserData )
			{
				if(stGm.SEND_YN[0] == 'N' || stGm.SEND_YN[0] == '')
				{
					if( Str_Len(g_szMtr_Code) > 0 )
					{
						Mem_Set( (byte*)stGm.MTR_WORK_CODE, 0x00, sizeof(stGm.MTR_WORK_CODE) );
						Str_Cpy(stGm.MTR_WORK_CODE, g_szMtr_Code);
					}
				}
			}
			
			i = SearchCD( stGm.MTR_WORK_CODE, RE_GM_CODE );
			
			if (i == -1)
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[0].Str);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[i].Str);
			}
			
			// ºÎÀç, ¾øÀ½, »çÈÄ¹®ÀÚ
			if( Str_Cmp(stGm.MTR_WORK_CODE,"2") == 0 || Str_Cmp(stGm.MTR_WORK_CODE,"C") == 0 || Str_Cmp(stGm.MTR_WORK_CODE,"L") == 0 )
			{
				// °è·®±â
				if( 10 == m_lUserData )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );

					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "" );	
				}
				// º¸Á¤±â
				else if( 20 == m_lUserData )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );

					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
				}
				// ¿Âµµ, ¿Â¾Ðº¸Á¤±â
				else
				{	
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );

					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
				}
				
				// ºÎÀçÀÎ °æ¿ì ¸Þ¼¼Áö RED
				if( Str_Cmp(stGm.MTR_WORK_CODE,"2") == 0 )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), RED);
				}
				else
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
				}
			}
			// ºÎÀç, ¾øÀ½, »çÈÄ¹®ÀÚ ÀÌ¿Ü
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
				
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
				
				// ÀÚ°¡°ËÄ§ ¼¼´ë°¡ ¾Æ´Ñ °æ¿ì
				if( Str_Cmp(stGm.SELF_GMTR_YN, "Y") != 0 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) );
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
				// ÀÚ°¡°ËÄ§ ¼¼´ëÀÎ °æ¿ì
				else
				{
					lToDate = Time_GetDate();
					lEndDate = Str_AtoI( stGm.SELF_GMTR_END_YMD );
					
					if( lEndDate > 0 && ( lToDate > lEndDate ) && Str_Cmp(stGm.GMTR_MANAGE_STS, "70") != 0 )
					{
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) );
						m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					}
				}
				
				// °è·®±â
				if( 10 == m_lUserData )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), stGm.INDI_SET_VC );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), stGm.INDI_QTY );
				}
				// º¸Á¤±â
				else if( 20 == m_lUserData )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), stGm.INDI_SET_VM );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), stGm.INDI_SET_VA );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), stGm.INDI_SET_VC );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), stGm.INDI_QTY);
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), stGm.INDI_QTY);
				}
				// ¿Âµµ, ¿Â¾Ðº¸Á¤±â
				else
				{	
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), stGm.INDI_SET_VM );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), stGm.INDI_SET_VC );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), stGm.INDI_QTY);
				}
			}
		}
		// ÃÖÃÊ Á¢±Ù ÀÌ¿Ü¿¡ È­¸é Ç¥±â
		else
		{
			// ºÎÀç, ¾øÀ½, »çÈÄ¹®ÀÚ
			if( g_szIndi_MtrCode[0] == '2' || g_szIndi_MtrCode[0] == 'C' || g_szIndi_MtrCode[0] == 'L' )
			{
				// °è·®±â
				if( 10 == m_lUserData )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );

					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "" );
				}
				// º¸Á¤±â
				else if( 20 == m_lUserData )
				{
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );

					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
				}
				// ¿Âµµ, ¿Â¾Ð º¸Á¤±â
				else
				{	
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );

					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), "");
				}
				
				// g_szIndi_MtrCode°¡ ºÎÀçÄÚµåÀÎ °æ¿ì ¸Þ¼¼Áö RED
				if( g_szIndi_MtrCode[0] == '2' )
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), RED);
				}
				else
				{
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
				}
			}
			// ºÎÀç, ¾øÀ½, »çÈÄ¹®ÀÚ ÀÌ¿Ü
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
				
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
				
				// ÀÚ°¡°ËÄ§ ¼¼´ë°¡ ¾Æ´Ñ °æ¿ì
				if( Str_Cmp(stGm.SELF_GMTR_YN, "Y") != 0 )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) );
					m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
				}
				// ÀÚ°¡°ËÄ§ ¼¼´ëÀÎ °æ¿ì
				else
				{
					lToDate = Time_GetDate();
					lEndDate = Str_AtoI( stGm.SELF_GMTR_END_YMD );
					
					if( lEndDate > 0 && lToDate > lEndDate && Str_Cmp(stGm.GMTR_MANAGE_STS, "70") != 0 )
					{
						Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) );
						m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
					}
				}
				
				// °è·®±â
				if( 10 == m_lUserData )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), g_szIndi_MtrCode );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), g_szIndi_Vc );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), g_szIndi_Qty );
				}
				//º¸Á¤±â
				else if( 20 == m_lUserData )
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), g_szIndi_MtrCode );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), g_szIndi_Vm );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), g_szIndi_Va );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), g_szIndi_Vc );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), g_szIndi_Qty );
				}
				//¿Âµµ, ¿Â¾Ð º¸Á¤±â
				else
				{	
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), g_szIndi_MtrCode );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), g_szIndi_Vm );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), g_szIndi_Vc );
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), g_szIndi_Qty );
				}
			}
		}
		
		m_maxQtySaveCnt = 0;
		
		// È­¸é draw ÈÄ ÇØ´ç ¸Þ½ÃÁö Ãâ·ÂÀ» À§ÇØ
		ON_DRAW();
		
		/**************************************************/
		/* È­¸é draw ÈÄ ¸Þ¼¼Áö Ãâ·Â                       */
		/**************************************************/
		// È­¸é ÃÖÃÊ Á¢±Ù½Ã È­¸é Ç¥±â
		if( g_lDataflag == 0 )
		{
			Mem_Set( (byte*)szToday, 0x00, sizeof(szToday) );
			Str_ItoA(Time_GetDate(), szToday, 10);
			// PRINT("111111111111111111111 :%s",szToday,0,0);
			// ÀÚ°¡°ËÄ§ ¼¼´ëÀÎ °æ¿ì
			if( Str_Cmp(stGm.SELF_GMTR_YN, "Y") == 0 )
			{
				lToDate = Time_GetDate();
				lEndDate = Str_AtoI( stGm.SELF_GMTR_END_YMD );
				
				if (Str_Cmp(stGm.MTR_LOC_FLAG, "20") == 0 && lEndDate > 0 && (lEndDate > lToDate))
				{
					MessageBoxEx(CONFIRM_OK, "ÀÚ°¡°ËÄ§ ±â°£ÀÌÁö¸¸ °è·®±â°¡ ¿ÜºÎ¿¡ ÀÖ¾î PDA°ËÄ§µµ °¡´ÉÇÕ´Ï´Ù.");

					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE);
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE );
					
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);	
				}
				else if( lEndDate > 0 && ( lToDate > lEndDate ) && Str_Cmp(stGm.GMTR_MANAGE_STS, "70") != 0 )
				{
					MessageBoxEx(CONFIRM_OK, "ÀÚ°¡°ËÄ§¼¼´ëÀÌÁö¸¸\nµî·Ï±â°£ÀÌ °æ°úµÇ¾î\nPDA°ËÄ§ÀÌ °¡´ÉÇÕ´Ï´Ù.");
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE);
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE );
					
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				}
				else if(Str_Cmp(stGm.MTR_LOC_FLAG, "10") == 0  && Str_Cmp(stGm.GMTR_JOB_YMD_END,szToday) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "ÀÚ°¡°ËÄ§ ±â°£ÀÌÁö¸¸ \n °è·®±â°¡ ³»ºÎ¿¡ ÀÖ°í \n ±ÝÀÏ °ËÄ§Á¾·áÀÏÀÌ¶ó PDA°ËÄ§ÀÌ °¡´ÉÇÕ´Ï´Ù.");
					// 20190129_¸¶°¨ÀÏº¯°æ °³¼±
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE);
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE );
					
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				}
				else
				{
					// 20190129_¸¶°¨ÀÏº¯°æ °³¼±
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
					
					DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
					
					DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE);
					DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE );
					
					if( Str_Cmp(stGm.GMTR_MANAGE_STS, "70") == 0 && Str_Cmp(stGm.DEADLINE_CHG_YN, "Y") == 0 && Str_Cmp(stGm.SELF_GMTR_YN, "Y") == 0)
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_RESULT), "¸¶°¨º¯°æ" );
						MessageBoxEx(CONFIRM_OK, "¸¶°¨ÀÏº¯°æ¼¼´ë´Â ÀÔ·ÂºÒ°¡ÇÕ´Ï´Ù.");
					}
					else
					{
						EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_RESULT), "ÀÚ°¡°ËÄ§" );
						MessageBoxEx(CONFIRM_OK, "ÀÚ°¡°ËÄ§¼¼´ë´Â ÀÔ·ÂºÒ°¡ÇÕ´Ï´Ù.");
					}
					
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				}
			}
			// ¿ø°Ý °ËÄ§ ¼¼´ëÀÎ °æ¿ì
			else if( Str_Cmp(stGm.REMOTE_GMTR_YN, "Y") == 0 )
			{	
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_REMOTE), TRUE);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_REMOTE), "¿ø°ÝÁöÄ§");
				BUTSETRANGE(Get_hDlgCtrlByID(BID_REMOTE),	STARTX+500, STARTY+345,  785, 510);	
				
				// if(Str_Cmp(stGm.GMTR_JOB_YMD_END,szToday) == 0 )
				// {
				// 	// EDT_VC
				// 	MessageBoxEx(CONFIRM_OK, "¿ø°Ý°ËÄ§ ¼¼´ëÀÌÁö¸¸ \n ±ÝÀÏ °ËÄ§Á¾·áÀÏÀÌ¶ó PDA°ËÄ§ÀÌ °¡´ÉÇÕ´Ï´Ù.");
					
				// 	// EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), GM_CODE[14].Str);
				// 	// EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), stGm.RECENT_INDI_MTR_MM_VC);

				// 	DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
				// 	DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );

				// 	DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE);
				// 	DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE );	

				// 	// DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_REMOTE), FALSE);
					
				// 	DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
				// 	DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );

				// 	DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
				// 	DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
				// }
				// else
				// {
				// 	//EDT_VC °ª ÀÔ·ÂÇØÁà¾ßÇÔ.
				// 	// MessageBoxEx(CONFIRM_OK, "¿ø°Ý°ËÄ§ ¼¼´ëÀÌÁö¸¸ \n ±ÝÀÏ °ËÄ§Á¾·áÀÏÀÌ¶ó PDA°ËÄ§ÀÌ °¡´ÉÇÕ´Ï´Ù.");
				// 	MessageBoxEx(CONFIRM_OK, "¿ø°Ý°ËÄ§ ¼¼´ë´Â ÀÔ·ÂºÒ°¡ÇÕ´Ï´Ù. ");	

				// 	// EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), GM_CODE[14].Str);
				// 	EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), "R:¿ø°Ý");

				// 	DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
				// 	DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );

				// 	EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), stGm.RECENT_INDI_MTR_MM_VC);

				// 	DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE);
				// 	DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE );

				// 	DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
				// 	DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );

				// 	DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
				// 	DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );

				// 	// Cal_UseQty( stGm.RECENT_INDI_MTR_MM_VC );

				// 	// DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_REMOTE), TRUE);
				// 	// ButCtrl_SetText(Get_hDlgCtrlByID(BID_REMOTE), "¿ø°ÝÁöÄ§");
				// 	// BUTSETRANGE(Get_hDlgCtrlByID(BID_REMOTE),	STARTX+500, STARTY+345,  785, 510);	

				// 	// Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);	

				// }
			}
			// ÀÚ°¡°ËÄ§ ¼¼´ë°¡ ¾Æ´Ñ °æ¿ì
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
				
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
				
				DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE);
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE );

				Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
			}
			
			// 2017.10.30 ½Å±âÈ£ Àü»êÃ¶°Å ¾Ë¶÷ Ãß°¡
			if( Str_Cmp(stGm.COMPENS_REMOVE_ALARM, "Y") == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "¿Â¾Ðº¸Á¤±â Àü»êÃ¶°Å ¼¼´ëÀÔ´Ï´Ù.");
			}
		}
		
		return;
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : Prev_Gm
	±â  ´É : ÀÌÀü ¹öÆ°½Ã ÀÌÀü´ë»óÀ» Ã£´Â´Ù.
	Param  : 
	Return : 
	========================================================================================*/
	void Prev_Gm(void)
	{
		long lToDate, lEndDate;
		
		if( g_nActIndex > 0 )
		{
			g_nActIndex--;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
		}
		else
		{
			g_nActIndex = -1;
		}
		
		if( g_nActIndex < 2 )
		{	
			//°Ë»ö ÈÄ, Ã¹¹øÂ° °í°´ ¸Þ¼¼Áö ¹Ú½º º¯¼ö
			m_lPrev--;
		}

		if( g_lindex <= 0 || g_nActIndex < 0 )
		{
			g_nActIndex = 0;
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

			if( m_lPrev < 0 )
			{
				m_lPrev = 0;
			}
			return;
		}
		
		Clear_Flag();
		SetData();
		SetStyle();
		REDRAW();
		
		if( Str_Cmp(stGm.SMS_GMTR_MAN_YN, "Y") == 0 || Str_Cmp(stGm.BEFO_GMTR_SMS_YN, "Y") == 0 )
		{
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), TRUE);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS_STS), RED);
			Rcv_SmsSts();
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SMS_STS), "");
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS_STS), BTNMENUFRCOLOR);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), FALSE);
			
			if( Str_Cmp(stGm.SELF_GMTR_YN, "Y") == 0 )
			{
				/*
				lToDate = Time_GetDate();
				lEndDate = Str_AtoI( stGm.SELF_GMTR_END_YMD );

				if( lToDate <= lEndDate )
				{
					Rcv_self_select();
				}
				*/
				Rcv_self_select();
			}
		}
		ON_DRAW();
		return;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Next_Gm
	±â  ´É : ´Ù¿î ¹öÆ°½Ã ´ÙÀ½´ë»óÀ» Ã£´Â´Ù.
	Param  : 
	Return : 
	========================================================================================*/
	void Next_Gm(void)
	{
		long lToDate, lEndDate;
		
		m_lPrev = 0;

		g_nActIndex++;
		g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);

		if( g_nActIndex > m_ltotcnt || g_lindex < 0 )
		{
			if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
			{
				g_nActIndex = g_nActIndex-1;
			}
			g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
			
			Clear_Flag();
			SetData();
			SetStyle();
			REDRAW();
			
			if( m_lLastSave > 0 )
			{
				Rcv_SmsSts();
			}
			
			MessageBoxEx (CONFIRM_OK, "¸¶Áö¸· °í°´ÀÔ´Ï´Ù.");
			
			ON_DRAW();
			return;
		}

		Clear_Flag();
		SetData();
		SetStyle();
		REDRAW();

		if( Str_Cmp(stGm.SMS_GMTR_MAN_YN, "Y") == 0 || Str_Cmp(stGm.BEFO_GMTR_SMS_YN, "Y") == 0 )
		{
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), TRUE);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS_STS), RED);
			Rcv_SmsSts();
		}
		else
		{
			ButCtrl_SetText(Get_hDlgCtrlByID(BID_SMS_STS), "");
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS_STS), BTNMENUFRCOLOR);
			DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), FALSE);
			
			if( Str_Cmp(stGm.SELF_GMTR_YN, "Y") == 0 )
			{
				/*
				lToDate = Time_GetDate();
				lEndDate = Str_AtoI( stGm.SELF_GMTR_END_YMD );

				if( lToDate <= lEndDate )
				{
					Rcv_self_select();
				}
				*/
				
				Rcv_self_select();
			}
		}
		ON_DRAW();
		
		return;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Gm_ChkRule
	±â  ´É : °ËÄ§ Ã¼Å© ·ê
	Param  : 
	Return : 
	========================================================================================*/
	bool Gm_ChkRule(void)
	{
		long nIndi_VC;			//´ç¿ù VCÁöÄ§ 
		long nIndi_VM;			//´ç¿ù VMÁöÄ§ 
		long nIndi_VA;			//´ç¿ù VAÁöÄ§ 
		long nIndi_Qty;
		long nBefo_Indi_VC_1;
		long nBefo_Indi_VM_1;
		long nBefo_Indi_VA_1;
		
		long nIndi_VMUse;
		long nIndi_VAUse;
		long nValue;
		long nRemain;
		long nhigh_v;
		long nlow_v;
		long nfactor_h;
		long nfactor_l;
		long nGmMgnfctn = 0;	//°ËÄ§¹èÀ²
		long nBefo_UseQty_1;
		long nBefo_UseQty_2;
		long nBefo_UseQty_3;
		long nBefo_UseQty;
		long nChk_Use;
		long nChk_Cnt;
		long idx=0;
		long i;
		long nChkplus1 = 0;
		long nChkplus2 = 0;
		long nChkplus3 = 0;
		
		char szIndi_VM[10];		//´ç¿ù VM ÁöÄ§ 
		char szIndi_VA[10];		//´ç¿ù VAÁöÄ§ 
		char szIndi_VC[10];		//´ç¿ù VCÁöÄ§
		char szIndi_VCUse[10];
		char szIndi_VMUse[10];
		char szIndi_VAUse[10];
		
		//º¸Á¤±âÁöÄ§ÀÌ»ó Ã¼Å©
		char szValue[10];		//³ª´°¼ÀÀÇ ¸ò
		char szRemain[10];		//³ª´°¼ÀÀÇ ³ª¸ÓÁö
		char szhigh_v[10];
		char szlow_v[10];
		char szMsg[20];
		char szStr1[300];
		char szDate[18];        //³¯Â¥ ¹®ÀÚ¿­
		char szTime[9];        	//½Ã°£ ¹®ÀÚ¿­
		char szSql[128];
		char sztmp[10];
		char strMsg1[100];
		long lEndDate, lToDate;
		
		/****************************************************/
		/* ÃÖÃÊ Mem_Set                    				    */
		/****************************************************/
		Mem_Set((byte *)szIndi_VM   , 0x00, sizeof(szIndi_VM));
		Mem_Set((byte *)szIndi_VA   , 0x00, sizeof(szIndi_VA));
		Mem_Set((byte *)szIndi_VC   , 0x00, sizeof(szIndi_VC));
		Mem_Set((byte *)szIndi_VCUse, 0x00, sizeof(szIndi_VCUse));
		Mem_Set((byte *)szIndi_VMUse, 0x00, sizeof(szIndi_VMUse));
		Mem_Set((byte *)szIndi_VAUse, 0x00, sizeof(szIndi_VAUse));
		Mem_Set((byte *)szValue		, 0x00, sizeof(szValue));
		Mem_Set((byte *)szRemain	, 0x00, sizeof(szRemain));
		Mem_Set((byte *)szhigh_v    , 0x00, sizeof(szhigh_v));
		Mem_Set((byte *)szlow_v     , 0x00, sizeof(szlow_v));
		Mem_Set((byte *)szMsg       , 0x00, sizeof(szMsg));
		Mem_Set((byte *)szStr1      , 0x00, sizeof(szStr1));
		
		/****************************************************/
		/* ³¯Â¥ Setting                    				    */
		/****************************************************/
		Mem_Set((byte *)szDate, 0x00, sizeof(szDate));
		Mem_Set((byte *)szTime, 0x00, sizeof(szTime));
		
		Str_ItoA(Time_GetDate(),szDate,10);
		g_Str_TimeType( szTime , Time_GetTime());
		Str_Cat(szDate, szTime);
		
		/****************************************************/
		/* °ËÄ§ÄÚµå ÄÞº¸¹Ú½º ½ºÆ®¸µÀ¸·ÎµÈ °ªÀ» ÄÚµå·Î º¯°æ  */
		/****************************************************/
		Mem_Set((byte *)m_szMtr_Code, 0x00, sizeof(m_szMtr_Code));
		
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)), RE_GM_CODE );
		if (i == -1)
		{
			Str_Cpy(m_szMtr_Code, "");
		}
		else
		{
			Str_Cpy(m_szMtr_Code, RE_GM_CODE[i].Code);
		}
		
		/****************************************************/
		/* »çÀüÈ¸½Å, ÀÚ°¡°ËÄ§, ¸¶°¨º¯°æ ÀúÀå ºÒ°¡           */
		/****************************************************/
		if ( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)), "»çÀüÈ¸½Å" ) == 0 ||
		     Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)), "ÀÚ°¡°ËÄ§" ) == 0 ||
		     Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)), "¸¶°¨º¯°æ" ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "°ËÄ§ ÄÚµå¸¦ ¼±ÅÃÇØÁÖ¼¼¿ä.");
			
			return FALSE;	
		}
		
		/****************************************************/
		/* ETC¿¡¼­ °¡Á®¿Â °ªÀÎ °°Àº ÁöÄ§°ª ÀúÀå ºÒ°¡        */
		/****************************************************/
		if ( Str_Cmp( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)), m_szIndiVc ) == 0 )
		{
			MessageBoxEx(CONFIRM_OK, "ÀÔ·ÂÇÏ´Â ÁöÄ§°ú ¼ö½ÅµÈ ÁöÄ§ÀÌ µ¿ÀÏÇÑ °æ¿ì °ËÄ§ÄÚµå ¼öÁ¤ÀÌ ºÒ°¡´ÉÇÕ´Ï´Ù.");
			
			return FALSE;
		}
		
		/****************************************************/
		/* ÀÚ°¡°ËÄ§ ¿©ºÎ Ã¼Å©								*/
		/****************************************************/
		if( Str_Cmp(stGm.SELF_GMTR_YN, "Y") == 0 )
		{
			lToDate = Time_GetDate();
			lEndDate = Str_AtoI( stGm.SELF_GMTR_END_YMD );

			if( ( lToDate <= lEndDate ) && Str_Cmp(stGm.GMTR_MANAGE_STS, "70") == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "ÀÚ°¡°ËÄ§¼¼´ë´Â ÀÔ·ÂºÒ°¡ÇÕ´Ï´Ù.");
				
				Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				
				return FALSE;
			}
		}
		
		/****************************************************/
		/* ¸ð´ÏÅÍ ±¸ºÐ °ªÀÌ ÀÖÀ» ¶§ »ç¿ë·® ÀÌ»ó¼¼´ë Ã¢ ÆË¾÷	*/
		/****************************************************/
		if( Str_AtoI(stGm.MONITOR_FLAG) >= 10 && m_lChk == 0 )
		{
			ON_EXIT();
			OnInit(INIT_USE);
			
			return FALSE;
		}
		
		/****************************************************/
		/* 2:ºÎÀç, C:¾øÀ½ ÀÎ °æ¿ì							*/
		/****************************************************/
		if( Str_Cmp(m_szMtr_Code, "2") != 0 && Str_Cmp(m_szMtr_Code, "C") != 0 )
		{
			// ¿Âµµº¸Á¤±â »ó½Ã°è¼ö ÀÔ·Â È®ÀÎ 
			if( (m_lUserData == 40 && Str_Len(stGm.CURR_TEMPER) == 0) ||
			    (m_lUserData == 40 && Str_Len(stGm.CURR_REVIS_PARA) == 0) )
			{
				MessageBoxEx(CONFIRM_OK, "¿Âµµº¸Á¤°è·®±â »ó½Ã°è¼ö ÀÔ·ÂÀ» È®ÀÎÇÏ¼¼¿ä.");
				ON_EXIT();
				OnInit(INIT_NUM);
				
				return FALSE;
			}
			
			// ¿Â¾Ðº¸Á¤±â »ó½Ã°è¼ö ÀÔ·Â È®ÀÎ 
			if( m_lUserData == 41 && Str_Len(stGm.CURR_TEMPER) == 0 ||
				m_lUserData == 41 && Str_Len(stGm.CURR_PRES) == 0 ||
				m_lUserData == 41 && Str_Len(stGm.CURR_REVIS_PARA) == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "¿Â¾Ðº¸Á¤°è·®±â »ó½Ã°è¼ö ÀÔ·ÂÀ» È®ÀÎÇÏ¼¼¿ä.");
				ON_EXIT();
				OnInit(INIT_NUM);
				
				return FALSE;
			}
			
			// º¸Á¤±â »ó½Ã°è¼ö ÀÔ·Â È®ÀÎ 
			if( m_lUserData == 20 && Str_Len(stGm.CURR_TEMPER) == 0 ||
				m_lUserData == 20 && Str_Len(stGm.CURR_PRES) == 0 ||
				m_lUserData == 20 && Str_Len(stGm.CURR_REVIS_PARA) == 0 )		
			{
				MessageBoxEx(CONFIRM_OK, "º¸Á¤ÀåÄ¡ »ó½Ã°è¼ö ÀÔ·ÂÀ» È®ÀÎÇÏ¼¼¿ä.");
				ON_EXIT();
				OnInit(INIT_NUM);
				
				return FALSE;
			}
		}
		
		/****************************************************/
		/* ÇöÀç VM, VA, VC Setting   					    */
		/****************************************************/
		Mem_Set((byte *)szIndi_VM   , 0x00, sizeof(szIndi_VM));
		Mem_Set((byte *)szIndi_VA   , 0x00, sizeof(szIndi_VA));
		Mem_Set((byte *)szIndi_VC   , 0x00, sizeof(szIndi_VC));
			
		// °è·®±â
		if(m_lUserData == 10)
		{
			Str_Cpy(szIndi_VM, "-1");
			Str_Cpy(szIndi_VA, "-1");
			Str_Cpy(szIndi_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
		}
		//º¸Á¤±â
		else if(m_lUserData == 20)
		{
			Str_Cpy(szIndi_VM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VM)));
			Str_Cpy(szIndi_VA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VA)));
			Str_Cpy(szIndi_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
		}
		//¿Âµµ¿Â¾Ðº¸Á¤
		else
		{
			Str_Cpy(szIndi_VM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VM)));
			Str_Cpy(szIndi_VA, "-1");
			Str_Cpy(szIndi_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
		}		
		
		nIndi_VM = Str_AtoI(szIndi_VM);
		nIndi_VA = Str_AtoI(szIndi_VA);
		nIndi_VC = Str_AtoI(szIndi_VC);
		
		/****************************************************/
		/* 3:±³Ã¼ÀÌ°í °è·®±â°¡ ¾Æ´Ñ °æ¿ì                    */
		/****************************************************/
		if( Str_Cmp(m_szMtr_Code, "3") == 0 && m_lUserData != 10 )
		{
			Mem_Set((byte *)m_szIndiQty, 0x00, sizeof(m_szIndiQty));
		}
		else
		{
			Cal_UseQty(szIndi_VC);
		}
		
		/****************************************************/
		/* 2:ºÎÀç °Ë»ç									 	*/
		/****************************************************/
		if( Str_Cmp(m_szMtr_Code, "2") == 0 )
		{
			// 100µî±Þ ÀÌ»óÀÏ °æ¿ì ºÎÀç ºÒ°¡
			if( Str_AtoI(stGm.GRD_TITLE) >= 100 )
			{
				MessageBoxEx(CONFIRM_OK, "°è·®±â 100µî±Þ ÀÌ»ó\nºÎÀçÄÚµå(2) ÀÔ·ÂºÒ°¡ ");
				
				Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				
				return FALSE;
			}
			
			// °è¾à»óÅÂ ÁßÁöÀÎ °æ¿ì ºÎÀç ºÒ°¡
			if( Str_Cmp(stGm.SUPPLY_STS_CD, "ÁßÁö") == 0 )
			{
				MessageBoxEx(CONFIRM_OK, "ÁßÁö¼¼´ë\nºÎÀçÄÚµå(2) ÀÔ·ÂºÒ°¡");
				
				Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				
				return FALSE;
			}
			
			// ºÎÀç´Â ÁöÄ§ ÀÔ·Â ºÒ°¡
			if( Str_Len(szIndi_VC) != 0 )
			{
				MessageBoxEx(CONFIRM_OK, "ºÎÀçÄÚµå(2)\nÁöÄ§ ÀÔ·ÂºÒ°¡");
				
				Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				
				if(m_lUserData == 10)
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "" );
				}
				else if(m_lUserData == 20)
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "" );
				}
				else 
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "" );
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "" );
				}
				
				return FALSE;
			}
			
			// º¸Á¤ÀåÄ¡ÀÌ¸ç VAÀÔ·ÂµÈ °æ¿ì( ¿Âµµ,¿Â¾Ðº¸Á¤ Ãß°¡·Î ÀÎÇÑ ¼öÁ¤(VA¹ÌÀÔ·Â) )
			if( Str_Len(szIndi_VA) != 0 && m_lUserData == 20)   
			{
				MessageBoxEx(CONFIRM_OK, "ºÎÀçÄÚµå(2)\nÁöÄ§ ÀÔ·ÂºÒ°¡");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "" );
				
				Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				
				return FALSE;
			}
			
			// °è·®±â°¡ ¾Æ´Ñ ÀÌ¿ÜÀÇ ÀåÄ¡ ÀÏ¶§ VMÀÌ ÀÔ·ÂµÈ °æ¿ì
			if( Str_Len(szIndi_VM) != 0 && m_lUserData != 10)
			{
				MessageBoxEx(CONFIRM_OK, "ºÎÀçÄÚµå(2)\nÁöÄ§ ÀÔ·ÂºÒ°¡");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "" );
				
				Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
				
				return FALSE;
			}
			
			// ºÎÀç µ¥ÀÌÅÍ ÀÔ·Â
			Mem_Set((byte *)szIndi_VM   , 0x00, sizeof(szIndi_VM));
			Mem_Set((byte *)szIndi_VA   , 0x00, sizeof(szIndi_VA));
			Mem_Set((byte *)szIndi_VC   , 0x00, sizeof(szIndi_VC));
			Mem_Set((byte *)m_szIndiQty  , 0x00, sizeof(m_szIndiQty));
		
			Str_Cpy(szIndi_VM, "");
			Str_Cpy(szIndi_VA, "");
			Str_Cpy(szIndi_VC, "");
			Str_Cpy(m_szIndiQty, "");
			
			// stGm ºÎÀçÀÏ¶§ ÀúÀå
			Mem_Set((byte *)stGm.MTR_WORK_CODE, 0x00, sizeof(stGm.MTR_WORK_CODE));
			Mem_Set((byte *)stGm.INDI_SET_VM, 0x00, sizeof(stGm.INDI_SET_VM));
			Mem_Set((byte *)stGm.INDI_SET_VA, 0x00, sizeof(stGm.INDI_SET_VA));
			Mem_Set((byte *)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
			Mem_Set((byte *)stGm.INDI_QTY, 0x00, sizeof(stGm.INDI_QTY));
			Mem_Set((byte *)stGm.INDI_DATE, 0x00, sizeof(stGm.INDI_DATE));
			Mem_Set((byte *)stGm.SEND_YN, 0x00, sizeof(stGm.SEND_YN));
			
			Str_Cpy(stGm.MTR_WORK_CODE, m_szMtr_Code);		//ÄÚµå
			Str_Cpy(stGm.INDI_SET_VM, szIndi_VM);			//VM
			Str_Cpy(stGm.INDI_SET_VA, szIndi_VA);			//VA
			Str_Cpy(stGm.INDI_SET_VC, szIndi_VC);			//VC
			Str_Cpy(stGm.INDI_QTY, m_szIndiQty);			//»ç¿ë·®
			Str_Cpy(stGm.INDI_DATE, szDate);				//³¯Â¥
			Str_Cpy(stGm.SEND_YN, "S");						//¼Û½Å¿©ºÎ
			
			return TRUE;
		}
		/****************************************************/
		/* 2:ºÎÀç ¿Ü °Ë»ç									*/
		/****************************************************/
		else
		{	
			// ÇöÀçÁöÄ§, Àü¿ùÁöÄ§, ÀüÀü¿ùÁöÄ§ÀÌ ¸ðµÎ °°Àº °æ¿ì
			if( Str_Cmp(szIndi_VC, stGm.BEFO_MM_INDI_COMPENS_VC_1) == 0 &&
				Str_Cmp(szIndi_VC, stGm.BEFO_MM_INDI_COMPENS_VC_2) == 0)
			{
				// A:¹ÌÀÔÁÖ, B:¹Ì»ç¿ë, C:¾øÀ½, D:¹Ì±âÅ¸, 6:°íÀå, 7:ÇØ°¡ÀÎ °æ¿ì
				if( Str_Cmp(m_szMtr_Code, "A") !=0 && Str_Cmp(m_szMtr_Code, "B") !=0 && Str_Cmp(m_szMtr_Code, "C") !=0 &&
					Str_Cmp(m_szMtr_Code, "D") !=0 && Str_Cmp(m_szMtr_Code, "6") !=0 && Str_Cmp(m_szMtr_Code, "7") !=0 )
				{
					MessageBoxEx(CONFIRM_OK, "Àü3°³¿ù µ¿ÀÏÁöÄ§½Ã\n¹ÌÀÔÁÖ, ¹Ì»ç¿ë ÄÚµå¸¸\nÀÔ·Â°¡´É");
					
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}	
			}
			
			// 7:ÇØ°¡ ÀÎ °æ¿ì
			if( Str_Cmp(m_szMtr_Code, "7") == 0 )
			{
				// º¸Á¤ÀåÄ¡ÀÎ °æ¿ì
				if( m_lUserData == 20 )
				{
					// VC, VA, VM ¸ðµÎ ÀÔ·ÂÇÏ°Å³ª ¸ðµÎ »èÁ¦ÇØ¾ßÇÔ
					if( !( (Str_Len(szIndi_VC) > 0 && Str_Len(szIndi_VA) > 0 && Str_Len(szIndi_VM) > 0) ||
					       (Str_Len(szIndi_VC) == 0 && Str_Len(szIndi_VA) == 0 && Str_Len(szIndi_VM) == 0) ) )
					{
						MessageBoxEx(CONFIRM_OK, "ÁöÄ§°ªÀ» ¸ðµÎ ÀÔ·ÂÇÏ°Å³ª\n»èÁ¦ÇÏ½Ê½Ã¿À!");
						
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						
						return FALSE;
					}
				}
			}
			
			// C:¾øÀ½ÀÎ °æ¿ì
			if( Str_Cmp(m_szMtr_Code, "C") == 0 )
			{
				// º¸Á¤ÀåÄ¡ÀÎ °æ¿ì
				if( m_lUserData == 20 ) 
				{
					// VC, VA, VM ¸ðµÎ ÀÔ·ÂºÒ°¡
					if( !( Str_Len(szIndi_VC) == 0 && Str_Len(szIndi_VA) == 0 && Str_Len(szIndi_VM) == 0) )
					{
						MessageBoxEx(CONFIRM_OK, "ÁöÄ§°ª ÀÔ·ÂºÒ°¡");
						
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						
						return FALSE;
					}
				}
				// º¸Á¤ÀåÄ¡°¡ ¾Æ´Ñ °æ¿ì
				else
				{
					// VCÀÔ·ÂºÒ°¡
					if(  Str_Len(szIndi_VC) != 0 )
					{
						MessageBoxEx(CONFIRM_OK, "ÁöÄ§°ª ÀÔ·ÂºÒ°¡");
						
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						
						return FALSE;
					}			
				}
				
				// ¾øÀ½ µ¥ÀÌÅÍ ÀÔ·Â
				Mem_Set((byte *)szIndi_VM   , 0x00, sizeof(szIndi_VM));
				Mem_Set((byte *)szIndi_VA   , 0x00, sizeof(szIndi_VA));
				Mem_Set((byte *)szIndi_VC   , 0x00, sizeof(szIndi_VC));
				Mem_Set((byte *)m_szIndiQty  , 0x00, sizeof(m_szIndiQty));
				
				Str_Cpy(szIndi_VM, "");
				Str_Cpy(szIndi_VA, "");
				Str_Cpy(szIndi_VC, "");
				Str_Cpy(m_szIndiQty, "");
				
				// stGm ºÎÀçÀÏ¶§ ÀúÀå
				Mem_Set((byte *)stGm.MTR_WORK_CODE, 0x00, sizeof(stGm.MTR_WORK_CODE));
				Mem_Set((byte *)stGm.INDI_SET_VM, 0x00, sizeof(stGm.INDI_SET_VM));
				Mem_Set((byte *)stGm.INDI_SET_VA, 0x00, sizeof(stGm.INDI_SET_VA));
				Mem_Set((byte *)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
				Mem_Set((byte *)stGm.INDI_QTY, 0x00, sizeof(stGm.INDI_QTY));
				Mem_Set((byte *)stGm.INDI_DATE, 0x00, sizeof(stGm.INDI_DATE));
				Mem_Set((byte *)stGm.SEND_YN, 0x00, sizeof(stGm.SEND_YN));
				
				Str_Cpy(stGm.MTR_WORK_CODE,m_szMtr_Code);		//ÄÚµå
				Str_Cpy(stGm.INDI_SET_VM, szIndi_VM);			//VM
				Str_Cpy(stGm.INDI_SET_VA, szIndi_VA);			//VA
				Str_Cpy(stGm.INDI_SET_VC, szIndi_VC);			//VC
				Str_Cpy(stGm.INDI_QTY, m_szIndiQty);			//»ç¿ë·®
				Str_Cpy(stGm.INDI_DATE, szDate);				//³¯Â¥
				Str_Cpy(stGm.SEND_YN, "S");						//¼Û½Å¿©ºÎ
				
				return TRUE;
			}
			// C:¾øÀ½ÀÌ ¾Æ´Ñ °æ¿ì
			else
			{
				// VCÀÔ·Â È®ÀÎ
				if( Str_Len(szIndi_VC) == 0 )
				{
					MessageBoxEx(CONFIRM_OK, "°ËÄ§ ÁöÄ§(VC)¸¦ ÀÔ·ÂÇÏ¼¼¿ä.");
					
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
				
				// º¸Á¤ÀåÄ¡ÀÎ °æ¿ì VA ÀÔ·ÂÈ®ÀÎ
				if( Str_Len(szIndi_VA) == 0 && m_lUserData == 20 )
				{
					MessageBoxEx(CONFIRM_OK, "°ËÄ§ ÁöÄ§(VA)¸¦ ÀÔ·ÂÇÏ¼¼¿ä.");
					
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
				
				// °è·®±â°¡ ¾Æ´Ñ °æ¿ì VM ÀÔ·Â È®ÀÎ
				if( Str_Len(szIndi_VM) == 0 && m_lUserData != 10 )
				{
					MessageBoxEx(CONFIRM_OK, "°ËÄ§ ÁöÄ§(VM)¸¦ ÀÔ·ÂÇÏ¼¼¿ä.");
					
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
		}		
		
		/****************************************************/
		/* Àü¿ùÁöÄ§ È®ÀÎ									*/
		/****************************************************/
		
		// Àü¿ùÁöÄ§ ÀúÀå
		nBefo_Indi_VC_1 = Str_AtoI(stGm.BEFO_MM_INDI_COMPENS_VC_1);
		
		// 1:Á¤»ó°ËÄ§, G:´ë¹®°ËÄ§, T:ÀüÈ­°ËÄ§, N:¿ø°ÝÁö½ÃºÎ
		if( Str_Cmp(m_szMtr_Code, "1") == 0 || Str_Cmp(m_szMtr_Code, "G") == 0 || Str_Cmp(m_szMtr_Code, "T") == 0 || Str_Cmp(m_szMtr_Code, "N") == 0 )
		{
			// Àü¿ùÁöÄ§ÀÌ ÇöÀçÁöÄ§º¸´Ù Å« °æ¿ì
			if( nBefo_Indi_VC_1 > nIndi_VC )
			{
				if(MessageBoxTitle(TITLE_ERROR_YESNO, "¿ªÁöÄ§ ¹ß»ý","ÁöÄ§ ¶Ç´Â °ËÄ§ÄÚµå ÀçÈ®ÀÎ\n(°è·®±â±³Ã¼, ¼øÈ¸È®ÀÎ)\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
			
			// Àü¿ùÁöÄ§ÀÌ ÇöÀçÁöÄ§°ú °°Àº °æ¿ì
			if( nBefo_Indi_VC_1 == nIndi_VC )
			{
				if(MessageBoxEx(CONFIRM_YESNO, "´ç¿ù »ç¿ë·®ÀÌ '0'\nÁöÄ§ ¶Ç´Â °ËÄ§ÄÚµå(¹Ì»ç¿ë) ÀçÈ®ÀÎ\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
		}
		// 3:±³Ã¼, 5:¼øÈ¸
		else if( Str_Cmp(m_szMtr_Code, "3") == 0 || Str_Cmp(m_szMtr_Code, "5") == 0 )
		{
			// Àü¿ùÁöÄ§ÀÌ ÇöÀçÁöÄ§º¸´Ù ÀÛÀº °æ¿ì
			if( nBefo_Indi_VC_1 < nIndi_VC)
			{
				if(MessageBoxEx(CONFIRM_YESNO, "´ç¿ùÁöÄ§ÀÌ Àü¿ùÁöÄ§º¸´Ù Å®´Ï´Ù\nÁöÄ§ ¶Ç´Â °ËÄ§ÄÚµå ÀçÈ®ÀÎ\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
			
			// Àü¿ùÁöÄ§ÀÌ ÇöÀçÁöÄ§°ú °°Àº °æ¿ì
			if( nBefo_Indi_VC_1 == nIndi_VC)
			{
				if( MessageBoxEx(CONFIRM_YESNO, "´ç¿ùÁöÄ§°ú Àü¿ùÁöÄ§ÀÌ µ¿ÀÏ\nÁöÄ§ ¶Ç´Â °ËÄ§ÄÚµå ÀçÈ®ÀÎ\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
		}
		// A:¹ÌÀÔÁÖ, B:¹Ì»ç¿ë, D:¹Ì±âÅ¸
		else if( Str_Cmp(m_szMtr_Code, "A") == 0 || Str_Cmp(m_szMtr_Code, "B") == 0 || Str_Cmp(m_szMtr_Code, "D") == 0 )
		{	
			// Àü¿ùÁöÄ§ÀÌ ÇöÀçÁöÄ§º¸´Ù ÀÛÀº °æ¿ì
			if( nBefo_Indi_VC_1 < nIndi_VC)		
			{
				if( MessageBoxEx(CONFIRM_YESNO, "¹Ì»ç¿ë °ËÄ§ÄÚµåÀÌ³ª ´ç¿ù»ç¿ë·® ¹ß»ý\nÁ¤»ó°ËÄ§ÄÚµå·Î º¯°æ ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
				else
				{
					Str_Cpy(m_szMtr_Code, RE_GM_CODE[0].Code);
				}
			}
			// Àü­”ÁöÄ§ÀÌ ÇöÀçÁöÄ§º¸´Ù Å« °æ¿ì
			else if( nBefo_Indi_VC_1 > nIndi_VC)
			{
				if(MessageBoxTitle(TITLE_ERROR_YESNO, "¿ªÁöÄ§ ¹ß»ý", "ÁöÄ§ ¶Ç´Â °ËÄ§ÄÚµå ÀçÈ®ÀÎ\n(°è·®±â ±³Ã¼, ¼øÈ¸, °íÀå ¿©ºÎÈ®ÀÎ)\nÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK )
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
			// Àü­”ÁöÄ§ÀÌ ÇöÀçÄ§°ú °°Àº °æ¿ì
			else if( nBefo_Indi_VC_1 == nIndi_VC)
			{
				Mem_Set((byte *)stGm.MTR_WORK_CODE, 0x00, sizeof(stGm.MTR_WORK_CODE));
				Mem_Set((byte *)stGm.INDI_SET_VM, 0x00, sizeof(stGm.INDI_SET_VM));
				Mem_Set((byte *)stGm.INDI_SET_VA, 0x00, sizeof(stGm.INDI_SET_VA));
				Mem_Set((byte *)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
				Mem_Set((byte *)stGm.INDI_QTY, 0x00, sizeof(stGm.INDI_QTY));
				Mem_Set((byte *)stGm.INDI_DATE, 0x00, sizeof(stGm.INDI_DATE));
				Mem_Set((byte *)stGm.SEND_YN, 0x00, sizeof(stGm.SEND_YN));

				Str_Cpy(stGm.MTR_WORK_CODE,m_szMtr_Code);		//ÄÚµå
				Str_Cpy(stGm.INDI_SET_VM, szIndi_VM);			//VM
				Str_Cpy(stGm.INDI_SET_VA, szIndi_VA);			//VA
				Str_Cpy(stGm.INDI_SET_VC, szIndi_VC);			//VC
				Str_Cpy(stGm.INDI_QTY, m_szIndiQty);			//»ç¿ë·®
				Str_Cpy(stGm.INDI_DATE, szDate);				//³¯Â¥
				Str_Cpy(stGm.SEND_YN, "S");						//¼Û½Å¿©ºÎ
				
				return TRUE;
			}
		}
		
		/****************************************************/
		/* »ç¿ë·® È®ÀÎ  									*/
		/****************************************************/
		nBefo_Indi_VM_1 = Str_AtoI(stGm.BEFO_MM_INDI_MTR_1);
		nBefo_Indi_VA_1 = Str_AtoI(stGm.BEFO_MM_INDI_COMPENS_VA_1);
		nIndi_Qty = Str_AtoI(m_szIndiQty);
		nIndi_VMUse = (nIndi_VM - nBefo_Indi_VM_1);
		nIndi_VAUse = (nIndi_VA - nBefo_Indi_VA_1);
		
		// »ç¿ë·®ÀÌ ¸¶ÀÌ³Ê½ºÀÏ °æ¿ì -> Å«¼ö ³ª´°±â°¡ ¾ÈµÇ¾î ¾çÀÇÁ¤¼ö·Î º¯È¯ÇÑ´Ù.
		if(nIndi_Qty < 0)
		{
			nIndi_Qty = nIndi_Qty * (-1);
			nChkplus1 = 1;
		}
		if(nIndi_VMUse < 0)
		{
			nIndi_VMUse = nIndi_VMUse * (-1);
			nChkplus2 = 1;
		}
		if(nIndi_VAUse < 0)
		{
			nIndi_VAUse = nIndi_VAUse * (-1);
			nChkplus3 = 1;
		}
		
		Str_ItoA(nIndi_VMUse, szIndi_VMUse, 10);
		Str_ItoA(nIndi_VAUse, szIndi_VAUse, 10);
		
		/****************************************************/
		/* º¸Á¤°è¼ö È®ÀÎ									*/
		/****************************************************/
		Mem_Set((byte *)szhigh_v, 0x00, sizeof(szhigh_v));
		Mem_Set((byte *)szlow_v, 0x00, sizeof(szlow_v));
		
		// Àú¾Ð º¸Á¤°è¼ö Ã¼Å©
		if( Str_Cmp(stGm.COMPENS_FLAG, "10") == 0 ) 
		{
			Str_Cpy(szhigh_v, "1.05");
			Str_Cpy(szlow_v, "0.88");
			nhigh_v = 105;
			nlow_v = 88;
			nfactor_h = 10;
			nfactor_l = -10;
		}
		// Áß°£¾Ð º¸Á¤°è¼ö Ã¼Å©
		else if( Str_Cmp(stGm.COMPENS_FLAG, "20") == 0 || Str_Cmp(stGm.COMPENS_FLAG, "41") == 0) 
		{

			Str_Cpy(szhigh_v, "1.40");
			Str_Cpy(szlow_v, "1.00");
			nhigh_v = 140;
			nlow_v = 100;
			nfactor_h = 300;
			nfactor_l = -300;
		}
		// Áß¾Ð º¸Á¤°è¼ö Ã¼Å©
		else if( Str_Cmp(stGm.COMPENS_FLAG, "30") == 0 || Str_Cmp(stGm.COMPENS_FLAG, "42") == 0) 
		{
			Str_Cpy(szhigh_v, "10.00");
			Str_Cpy(szlow_v, "4.00");
			nhigh_v = 1000;
			nlow_v = 400;
			nfactor_h = 300;
			nfactor_l = -300;	
		}
		
		// º¸Á¤ÀåÄ¡
		if( m_lUserData == 20 )
		{
			nIndi_VA = Str_AtoI(szIndi_VA);
			nIndi_VM = Str_AtoI(szIndi_VM);

			if( (nIndi_VA - nIndi_VM) < nfactor_l )		
			{
				if(MessageBoxEx(CONFIRM_YESNO, "Va ¶Ç´Â Vm ÁöÄ§ÀÌ»ó\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK) 
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
			if( (nIndi_VA-nIndi_VM) > nfactor_h )
			{
				if(MessageBoxEx(CONFIRM_YESNO, "Va ¶Ç´Â Vm ÁöÄ§ÀÌ»ó\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
			
			Str_ItoA( nIndi_Qty, szIndi_VCUse, 10);	
			Str_Mul10x(2, szIndi_VCUse, szIndi_VCUse);
			Str_Div(szIndi_VCUse, szIndi_VAUse, szValue, szRemain);
			nValue = Str_AtoI(szValue);

			if(nChkplus1 == 1)
			{
				nValue = nValue * (-1);
			}
			if(nChkplus3 == 1)
			{
				nValue = nValue * (-1);
			}
			
			if( (nValue) > nhigh_v )
			{
				if(MessageBoxEx(CONFIRM_YESNO, "Vc ¶Ç´Â Va,Vm ÁöÄ§ÀÌ»ó\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
			
			if( (nValue) <  nlow_v )
			{
				if(MessageBoxEx(CONFIRM_YESNO, "Vc ¶Ç´Â Va,Vm ÁöÄ§ÀÌ»ó\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
		}
		// ¿Âµµ, ¿Â¾Ð º¸Á¤±âÀÎ °æ¿ì
		else if( m_lUserData == 41 )
		{
			Str_ItoA(nIndi_Qty, szIndi_VCUse, 10);
			Str_Mul10x(2, szIndi_VCUse, szIndi_VCUse);
			Str_Div(szIndi_VCUse, szIndi_VAUse, szValue, szRemain);
			nValue = Str_AtoI(szValue);
			
			if(nChkplus1 == 1)
			{
				nValue = nValue * (-1);
			}
			if(nChkplus2 == 1)
			{
				nValue = nValue * (-1);
			}
			if( (nValue) > nhigh_v )
			{
				if(MessageBoxEx(CONFIRM_YESNO, "Vc ¶Ç´Â Vm ÁöÄ§ÀÌ»ó\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
			if( (nValue) < nlow_v )
			{
				if(MessageBoxEx(CONFIRM_YESNO, "Vc ¶Ç´Â Vm ÁöÄ§ÀÌ»ó\n°è¼Ó ÁøÇà ÇÏ½Ã°Ú½À´Ï±î?") != MB_OK)
				{
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
					
					return FALSE;
				}
			}
		}
		
		/****************************************************/
		/* C:¾øÀ½, °ø±Þ»óÅÂ ÁßÁö							*/
		/****************************************************/
		if( Str_Cmp(m_szMtr_Code, "C") != 0 && Str_Cmp(stGm.SUPPLY_STS_CD, "ÁßÁö") == 0)
		{
			// Àü¿ùÁöÄ§°ú ÇöÀçÁöÄ§ÀÌ ´Ù¸¥ °æ¿ì
			if( nBefo_Indi_VC_1 != nIndi_VC )
			{
				MessageBoxEx(CONFIRM_OK, "ÁßÁö¼¼´ë\n´ç¿ù»ç¿ë·® ¹ß»ý");
				
				Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
				Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
			}
		}
		
		/****************************************************/
		/* »ç¿ë·®Ã¼Å©					   		            */
		/****************************************************/
		if( Str_AtoI(m_szIndiQty) > 0 )
		{
			// °è·®±âÀÚ¿ø±¸ºÐ Áß ÀÏ¹ÝÀÌ ¾Æ´Ñ °æ¿ì
			if( Str_AtoI(stGm.MTR_RESOU_FLAG) != 10 )
			{
				Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				
				SPRINT( szSql, "SELECT PARAM10 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
				g_Sql_RetStr(szSql, 4, sztmp);
				
				nGmMgnfctn = Str_AtoI(sztmp);
			}else
			{
				Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
				Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
				
				SPRINT( szSql, "SELECT PARAM9 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
				g_Sql_RetStr(szSql, 4, sztmp);
				
				nGmMgnfctn = Str_AtoI(sztmp);
			}
			
			nBefo_UseQty_1 = Str_AtoI(stGm.BEFO_MM_USE_QTY_1);
			nBefo_UseQty_2 = Str_AtoI(stGm.BEFO_MM_USE_QTY_2);
			nBefo_UseQty_3 = Str_AtoI(stGm.BEFO_MM_USE_QTY_3);
			nBefo_UseQty = Str_AtoI(stGm.BEFO_YM_USE_QTY);
			nChk_Use = 0;
			nChk_Cnt = 0;

			// Àü³â µ¿¿ù
			if( (nBefo_UseQty > 0) && (nGmMgnfctn > 0) && (nChk_Cnt == 0) )
			{
				// Àü³â´ëºñ »ç¿ë·® °ú´Ù
				if( (nIndi_Qty * 100) > (nBefo_UseQty * nGmMgnfctn) )
				{
					Str_ItoA(nIndi_Qty/nBefo_UseQty, szMsg, 10);
					Str_ItoA(nIndi_VC, szIndi_VC, 10);
					Str_ItoA(nIndi_Qty, m_szIndiQty, 10);

					Str_Cpy(szStr1, "Àü³âµ¿¿ù »ç¿ë·® ´ëºñ\n");
					Str_Cat(szStr1, szMsg);	
					Str_Cat(szStr1, "¹è »ç¿ë·® ¹ß»ý\nÁöÄ§ : ");
					Str_Cat(szStr1, szIndi_VC);
					Str_Cat(szStr1, "  »ç¿ë·® : ");
					Str_Cat(szStr1, m_szIndiQty);
					
					if(MessageBoxTitle(TITLE_ERROR_YESNO, "»ç¿ë·®°ú´Ù ¹ß»ý", szStr1) != MB_OK)
					{
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						
						return FALSE;
					}
				}
				// Àü³â´ëºñ »ç¿ë·® °¨¼Ò
				else if( nIndi_Qty * nGmMgnfctn < (nBefo_UseQty * 100)  )
				{
					Str_ItoA(nIndi_VC, szIndi_VC, 10);
					Str_ItoA(nIndi_Qty, m_szIndiQty, 10);
					
					Str_Cpy(szStr1, " Àü³âµ¿¿ù »ç¿ë·® ´ëºñ\n»ç¿ë·® °¨¼Ò\nÁöÄ§ : ");
					Str_Cat(szStr1, szIndi_VC);
					Str_Cat(szStr1, "  »ç¿ë·® : ");
					Str_Cat(szStr1, m_szIndiQty);
					
					if(MessageBoxTitle(TITLE_ERROR_YESNO, "»ç¿ë·®°¨¼Ò ¹ß»ý", szStr1) != MB_OK)
					{
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						
						return FALSE;
					}
				}
				
				nChk_Cnt++;
			}
			
			// 3°³¿ù
			if( nBefo_UseQty_1 > 0 )
			{
				nChk_Use += nBefo_UseQty_1;
				idx++;
			}
			
			if( nBefo_UseQty_2 > 0 )
			{
				nChk_Use += nBefo_UseQty_2;
				idx++;			
			}
			
			if( nBefo_UseQty_3 > 0 )
			{
				nChk_Use += nBefo_UseQty_3;
				idx++;			
			}
			
			if( idx > 0 )
			{
				nChk_Use = nChk_Use / idx;
			}
			
			if( nChk_Use > 0 && nGmMgnfctn > 0 && nChk_Cnt == 0 )
			{
				// 3°³¿ù´ëºñ »ç¿ë·®°ú´Ù
				if( (nIndi_Qty * 100) > (nChk_Use * nGmMgnfctn) )
				{
					Str_ItoA((nIndi_Qty / nChk_Use), szMsg, 10);
					Str_ItoA(nIndi_VC, szIndi_VC, 10);
					Str_ItoA(nIndi_Qty, m_szIndiQty, 10);
					
					Str_Cpy(szStr1, "3°³¿ù Æò±Õ »ç¿ë·® ´ëºñ\n");
					Str_Cat(szStr1, szMsg);
					Str_Cat(szStr1, "¹è »ç¿ë·® ¹ß»ý\nÁöÄ§ : ");
					Str_Cat(szStr1, szIndi_VC);
					Str_Cat(szStr1, "  »ç¿ë·® : ");
					Str_Cat(szStr1, m_szIndiQty);

					if(MessageBoxTitle(TITLE_ERROR_YESNO, "»ç¿ë·®°ú´Ù ¹ß»ý",szStr1) != MB_OK)
					{
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						
						return FALSE;
					}
					
					nChk_Cnt++;
				}
				
				// 3°³¿ù´ëºñ »ç¿ë·®°¨¼Ò
				if( nIndi_Qty * nGmMgnfctn < nChk_Use * 100 )
				{
					Str_ItoA((nIndi_Qty / nChk_Use), szMsg, 10);
					Str_ItoA(nIndi_VC, szIndi_VC, 10);
					Str_ItoA(nIndi_Qty, m_szIndiQty, 10);
					
					Str_Cpy(szStr1, "3°³¿ù Æò±Õ ´ëºñ »ç¿ë·® °¨¼Ò\nÁöÄ§ : ");
					Str_Cat(szStr1, szIndi_VC);
					Str_Cat(szStr1, "  »ç¿ë·® : ");
					Str_Cat(szStr1, m_szIndiQty);
				
					if(MessageBoxTitle(TITLE_ERROR_YESNO, "»ç¿ë·®°¨¼Ò ¹ß»ý",szStr1) != MB_OK)
					{
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						
						return FALSE;
					}
					
					nChk_Cnt++;
				}
			}
		}
		
		/****************************************************/
		/* ÃÖ´ë»ç¿ë·®Ã¼Å© : 2017.11.30 ½Å±âÈ£	            */
		/****************************************************/ 
		
		// 6:°íÀåÀÌ ¾Æ´Ñ °æ¿ì
		if( m_szMtr_Code[0] != '6' )
		{
			// ÃÖ´ë»ç¿ë·® ÀúÀåÀ» ÇÑ¹ø ÀÌ»ó ÇÑ °æ¿ì
			if( m_maxQtySaveCnt > 0 )
			{
				// ÃÖ´ë»ç¿ë·® ÀÌÀü ÀúÀå ÁöÄ§°ú ÇöÀçÁöÄ§ÀÌ ´Ù¸¥ °æ¿ì
				if( Str_Cmp(m_beforeVc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)) ) != 0 )
				{
					Mem_Set((byte *)strMsg1, 0x00, sizeof(strMsg1));
						
					Str_Cpy(strMsg1, "ÁöÄ§À» ÀúÀå ÇÏ½Ã°Ú½À´Ï±î?\n ");
					Str_Cat(strMsg1, "\nÇöÀç »ç¿ë·® : ");
					Str_Cat(strMsg1, m_szIndiQty);
					Str_Cat(strMsg1, "\nÃÖ´ë »ç¿ë·® : ");
					Str_Cat(strMsg1, stGm.MAX_GMTR_QTY);
					
					if(MessageBoxTitle(TITLE_ERROR_YESNO, "»ç¿ë·® È®ÀÎ", strMsg1) != MB_OK)
					{	
						EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
						EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
						
						Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
						Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
						
						Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
						Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
						
						return FALSE;
					}
					else
					{
						Mem_Set((byte *)m_beforeVc, 0x00, sizeof(m_beforeVc));
						m_maxQtySaveCnt = 0;
					}
				}
			}
			// ÃÖ´ë»ç¿ë·® ÀúÀåÀ» Ã³À½ ÇÏ´Â °æ¿ì
			else
			{
				// ÃÖ´ë »ç¿ë·®À» ÃÊ°úÇÑ °æ¿ì
				if( Str_AtoI(m_szIndiQty) > Str_AtoI(stGm.MAX_GMTR_QTY) )
				{
					Mem_Set((byte *)strMsg1, 0x00, sizeof(strMsg1));
							
					Str_Cpy(strMsg1, "ÃÖ´ë »ç¿ë·®À» ÃÊ°úÇÏ¿´½À´Ï´Ù");
					Str_Cat(strMsg1, "\nÇöÀç »ç¿ë·® : ");
					Str_Cat(strMsg1, m_szIndiQty);
					Str_Cat(strMsg1, "\nÃÖ´ë »ç¿ë·® : ");
					Str_Cat(strMsg1, stGm.MAX_GMTR_QTY);
					Str_Cat(strMsg1, "\n ");
					Str_Cat(strMsg1, "\n[Àç ÀÔ·ÂÇØÁÖ¼¼¿ä]");
					MessageBoxEx(ERROR_OK, strMsg1);
					
					Mem_Set((byte *)m_beforeVc, 0x00, sizeof(m_beforeVc));
					Str_Cpy( m_beforeVc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)) );
					
					m_maxQtySaveCnt++;
					
					EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
					EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
	
					Mem_Set( (byte*)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
					Str_Cpy( stGm.INDI_SET_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
					
					Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
					Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
	
					return FALSE;	
				}	
			}
		}
		
		// °è·®±â
		if( m_lUserData == 10 )
		{
			Mem_Set((byte *)szIndi_VC   , 0x00, sizeof(szIndi_VC));
			
			Str_Cpy(szIndi_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
		}
		//º¸Á¤ÀåÄ¡
		else if( m_lUserData == 20 )
		{
			Mem_Set((byte *)szIndi_VM   , 0x00, sizeof(szIndi_VM));
			Mem_Set((byte *)szIndi_VA   , 0x00, sizeof(szIndi_VA));
			Mem_Set((byte *)szIndi_VC   , 0x00, sizeof(szIndi_VC));
			
			Str_Cpy(szIndi_VM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VM)));
			Str_Cpy(szIndi_VA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VA)));
			Str_Cpy(szIndi_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
		}
		//¿Âµµ, ¿Â¾Ðº¸Á¤ÀåÄ¡
		else
		{
			Mem_Set((byte *)szIndi_VM   , 0x00, sizeof(szIndi_VM));
			Mem_Set((byte *)szIndi_VC   , 0x00, sizeof(szIndi_VC));
			
			Str_Cpy(szIndi_VM, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VM)));
			Str_Cpy(szIndi_VC, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
		}

		Mem_Set((byte *)stGm.MTR_WORK_CODE, 0x00, sizeof(stGm.MTR_WORK_CODE));
		Mem_Set((byte *)stGm.INDI_SET_VM, 0x00, sizeof(stGm.INDI_SET_VM));
		Mem_Set((byte *)stGm.INDI_SET_VA, 0x00, sizeof(stGm.INDI_SET_VA));
		Mem_Set((byte *)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
		Mem_Set((byte *)stGm.INDI_QTY, 0x00, sizeof(stGm.INDI_QTY));
		Mem_Set((byte *)stGm.INDI_DATE, 0x00, sizeof(stGm.INDI_DATE));
		Mem_Set((byte *)stGm.SEND_YN, 0x00, sizeof(stGm.SEND_YN));
		
		Str_Cpy(stGm.MTR_WORK_CODE,m_szMtr_Code);		//ÄÚµå
		Str_Cpy(stGm.INDI_SET_VM, szIndi_VM);			//VM
		Str_Cpy(stGm.INDI_SET_VA, szIndi_VA);			//VA
		Str_Cpy(stGm.INDI_SET_VC, szIndi_VC);			//VC
		Str_Cpy(stGm.INDI_QTY, m_szIndiQty);			//»ç¿ë·®
		Str_Cpy(stGm.INDI_DATE, szDate);				//³¯Â¥
		Str_Cpy(stGm.SEND_YN, "S");						//¼Û½Å¿©ºÎ
		
		return TRUE;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Cal_UseQty
	±â  ´É : »ç¿ë·® °è»ê
	Param  : 
	Return : 
	========================================================================================*/	
	void Cal_UseQty(char *szIndi_VC)
	{
		long i = 0;
		long lLength = 0;
		long lAddValue = 10;
		long lUseQty = 0;		//ÇöÀç»ç¿ë·®
		long lIndi_VC = 0;		//ÇöÀçÁöÄ§
		long lPrevVc = 0;		//Àü¿øÁöÄ§
		long lCivilVc = 0;		//ÁöÄ§º¸Á¤±â¹Î¿ø_VC
		
		Mem_Set((byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty) );
		Mem_Set((byte*)m_szMtr_Code, 0x00, sizeof(m_szMtr_Code) );
		
		i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)), RE_GM_CODE );
		
		if (i == -1)
		{
			Str_Cpy(m_szMtr_Code, RE_GM_CODE[0].Code);
		}
		else
		{
			Str_Cpy(m_szMtr_Code, RE_GM_CODE[i].Code);
		}
		
		lIndi_VC = Str_AtoI(szIndi_VC);
		lPrevVc = Str_AtoI(stGm.BEFO_MM_INDI_COMPENS_VC_1);
		lCivilVc = Str_AtoI(stGm.INDI_COMPENS_CIVIL_SERV_VC);
		
		/*************************/
		/* °è»ê ½Ã ADDVALUE °è»ê */
		/*************************/
		// 5:¼øÈ¸
		if( m_szMtr_Code[0] == '5' )
		{	
			lLength = Str_Len(stGm.BEFO_MM_INDI_COMPENS_VC_1);
			
			for(i = 0 ; i < (lLength - 1) ; i++)
			{
				lAddValue = lAddValue * 10;
			}
		}
		// 3:±³Ã¼
		else if( m_szMtr_Code[0] == '3' )
		{
			lAddValue = lCivilVc-lPrevVc;

		    if(lAddValue < 1)
		    {
				lAddValue = 0;
			}
		}
		// ³ª¸ÓÁö
		else
		{
			lAddValue = 0;
		}
		
		/**************************/
		/* VC°¡ 0º¸´Ù Å«°æ¿ì °è»ê */
		/**************************/
		if(Str_Len(szIndi_VC) > 0)
		{
			// 3:±³Ã¼
			if( m_szMtr_Code[0] == '3' )
			{		
				lUseQty = lIndi_VC + lAddValue;
				Str_ItoA(lUseQty, m_szIndiQty, 10);
			}
			// ³ª¸ÓÁö
			else
			{
				lUseQty = lIndi_VC - lPrevVc + lAddValue;
				Str_ItoA(lUseQty, m_szIndiQty, 10);
			}
		}
		
		return;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Save_Gm
	±â  ´É : °ËÄ§ µ¥ÀÌÅÍ¸¦ ÀúÀåÇÑ´Ù.
	Param  : 
	Return : ¿Âµµ¿Â¾Ðº¸Á¤, º¸Á¤±â µÑ´Ù °è»êÇØ¼­ Qty ÀúÀåÇØ¾ßÇÔ.
	========================================================================================*/
	long Save_Gm(void)
	{
		char sztmp[100];
		long idx, ret = -1, fd;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		long lsign, lSign_Len;
		char* pRst = NULL;
		
		// 2017-05-28 Sanghyun Lee
		// ¹®ÀÚ°ËÄ§ ´ë»óÀÌ ¾Æ´Ò °æ¿ì¿¡¸¸ ¼­¸í µî·Ï, ¹®ÀÚ°ËÄ§ ´ë»óÀº °ËÄ§ Ã¼Å©·ê Åë°ú
		if( Str_Cmp(stGm.MTR_WORK_CODE, "L") != 0 )
		{
			// ´ë¿ë·® ÀÏ°æ¿ì »çÀÎÀ» ¹Þ´Â´Ù. 100µî±Þ ÀÌ»óÀÏ °æ¿ì ¼­¸í.
			if( Str_AtoI(stGm.GRD_TITLE) >= 100 )
			{
				//¼­¸í
				Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
				lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "°í °´ ¼­ ¸í", SIGN_OPT_NONE );
				
				if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
				{
					ret = -1;
					return ret;
				}
				else
				{
					g_png_getbmp(SIGN_WIDTH, SIGN_HEIGHT, g_SignBuf );
					if(g_pjcomm != NULL )
					{
						BASE64_Finalize(g_pjcomm);
						g_pjcomm = NULL;
					}
					
					g_pjcomm = BASE64_Create();
					lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
					pRst = BASE64_GetResult(g_pjcomm);				
				}
			}
		}

		// ¼ø¼ö¹Ì°ËÄ§ÀÇ °æ¿ì, °ËÄ§ ÁøÇà Áß ¸®½ºÆ®·Î µ¹¾Æ°¡¸é ¼ø¼ö¹Ì°ËÄ§ ´ë»óÀÌ °ËÄ§ÀÌ µÇ¾ú¾îµµ º¸ÀÌ°Ô ÇÏ±â À§ÇØ¼­
		// °ËÄ§¸Þ´º(GM_MENU)È­¸é ·Îµå ½Ã 'SEND_YN' À» 'S'·Î ¾÷µ¥ÀÌÆ®
		Mem_Set( (byte*)stGm.SEND_YN, 0x00, sizeof(stGm.SEND_YN) );
		
		if( g_nWorkFlag == 103 ) // 103¹ø : ¹Ì°ËÄ§ ¸ñ·Ï(¸®½ºÆ®)
		{
			Str_Cpy(stGm.SEND_YN, "I");
		}
		else
		{
			Str_Cpy(stGm.SEND_YN, "S");
		}

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}

		// 2017-05-28 Sanghyun Lee
		// ¹®ÀÚ°ËÄ§ ´ë»óÀÌ ¾Æ´Ò °æ¿ì¿¡¸¸ ¼­¸í µî·Ï, ¹®ÀÚ°ËÄ§ ´ë»óÀº °ËÄ§ Ã¼Å©·ê Åë°ú
		if( Str_Cmp(stGm.MTR_WORK_CODE, "L") != 0 )
		{
			// 100µî±Þ ÀÌ»ó
			if( Str_AtoI(stGm.GRD_TITLE) >= 100 )
			{
				hstmt = sql->CreateStatement(sql, "UPDATE REGUMDATA \
													  SET MTR_WORK_CODE = ?, INDI_SET_VM = ?, INDI_SET_VA = ?, INDI_SET_VC = ?, INDI_QTY = ? \
													    , INDI_DATE = ?, SEND_YN = ?, CURR_TEMPER = ?, CURR_PRES = ?, CURR_REVIS_PARA = ? \
													    , SMS_GMTR_MAN_YN = ?, CUSTOM_SIGN = ? WHERE ROWID = ? " 
				);
			}
			// ³ª¸ÓÁö
			else
			{		
				hstmt = sql->CreateStatement(sql, "UPDATE REGUMDATA \
													  SET MTR_WORK_CODE = ?, INDI_SET_VM = ?, INDI_SET_VA = ?, INDI_SET_VC = ?, INDI_QTY = ? \
													    , INDI_DATE = ?, SEND_YN = ?, CURR_TEMPER = ?, CURR_PRES = ?, CURR_REVIS_PARA = ? \
													    , SMS_GMTR_MAN_YN = ? WHERE ROWID = ? " 
				);
			}
		}
		// ¹®ÀÚ°ËÄ§ ´ë»óÀÎ °æ¿ì
		else
		{
			hstmt = sql->CreateStatement(sql, "UPDATE REGUMDATA \
												  SET MTR_WORK_CODE = ?, INDI_SET_VM = ?, INDI_SET_VA = ?, INDI_SET_VC = ?, INDI_QTY = ? \
												    , INDI_DATE = ?, SEND_YN = ?, CURR_TEMPER = ?, CURR_PRES = ?, CURR_REVIS_PARA = ? \
												    , SMS_GMTR_MAN_YN = ? WHERE ROWID = ? " 
			);
		}
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		idx = 0;
		sql->Bind(sql, idx++, 'U', (long *)stGm.MTR_WORK_CODE	,2	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.INDI_SET_VM		,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.INDI_SET_VA		,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.INDI_SET_VC		,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.INDI_QTY		,9	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stGm.INDI_DATE		,16 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.SEND_YN			,1  ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.CURR_TEMPER		,10	,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.CURR_PRES		,10 ,DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.CURR_REVIS_PARA	,10	,DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stGm.SMS_GMTR_MAN_YN	,5	,DECRYPT);

		if( Str_AtoI(stGm.GRD_TITLE) >= 100 && Str_Cmp(stGm.MTR_WORK_CODE, "L") != 0 )
		{
			sql->Bind(sql, idx++, 'U', (long *)pRst, Str_Len(pRst), DECRYPT);
		}
		
		sql->Bind(sql, idx++, 'U', (long *)stGm.ROWID, 5, DECRYPT);

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}	
		
		ret = 1;
		
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}			
		
		DelSqLite(sql);
		
		return ret;
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : SearchStr
	±â  ´É : ½ºÆ®¸µÀ¸·Î ÄÚµåÀÎµ¦½º¸¦ Ã£´Â´Ù.
	Param  : 
	Return : ÄÚµåÀÎµ¦½º, ¾øÀ¸¸é -1
	========================================================================================*/
	long SearchStr( char *Str, CodeTable *CT )
	{
		long i;

		for ( i = 0 ; CT[i].Code[0] != 0 ; i++)
		{
			if( Str_Cmp(Str, CT[i].Str) == 0 )
			{
				return i;
			}
		}
		
		return -1;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : SearchCD
	±â  ´É : ÄÚµå°ªÀ¸·Î ÄÚµåÀÎµ¦½º¸¦ Ã£´Â´Ù.
	Param  : 
	Return : ÄÚµåÀÎµ¦½º, ¾øÀ¸¸é -1
	========================================================================================*/
	long SearchCD( char *CD, CodeTable *CT )
	{
		long i;
		
		for(i = 0; CT[i].Code[0] != 0; i++)
		{	
			if ( Str_Cmp(CD, CT[i].Code) == 0)
			{
				return i;
			}
		}
		
		return -1;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : SaveInput
	±â  ´É : ´Ù¸¥ ¾÷¹« È­¸é, ÆË¾÷Ã¢ÀÌ »ç¿ëµÇµµ 
	         ¿ø·¡ °ËÄ§µî·Ï È­¸éÀ¸·Î µ¹¾Æ¿À¸é ÀÔ·ÂµÇÀÖ´Â °ªÀÌ ´Ù½Ã ³ª¿Ã¼öÀÖµµ·Ï ÇÏ±âÀ§ÇÑ ÇÔ¼ö
	Param  : 
	Return :
	========================================================================================*/
	void SaveInput(void)
	{
		Mem_Set((byte *)g_szIndi_MtrCode, 0x00, sizeof(g_szIndi_MtrCode));
		Mem_Set((byte *)g_szIndi_Vm, 0x00, sizeof(g_szIndi_Vm));
		Mem_Set((byte *)g_szIndi_Va, 0x00, sizeof(g_szIndi_Va));
		Mem_Set((byte *)g_szIndi_Vc, 0x00, sizeof(g_szIndi_Vc));
		Mem_Set((byte *)g_szIndi_Qty, 0x00, sizeof(g_szIndi_Qty));

		if( 10 == m_lUserData )
		{
			Str_Cpy(g_szIndi_MtrCode, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)));
			Str_Cpy(g_szIndi_Vc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
			Str_Cpy(g_szIndi_Qty, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_USEQTY)));
		}
		else if( 20 == m_lUserData )
		{
			Str_Cpy(g_szIndi_MtrCode, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)));
			Str_Cpy(g_szIndi_Vm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VM)));
			Str_Cpy(g_szIndi_Va, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VA)));
			Str_Cpy(g_szIndi_Vc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
			Str_Cpy(g_szIndi_Qty, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA13)));
		}
		else
		{	
			Str_Cpy(g_szIndi_MtrCode, EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)));
			Str_Cpy(g_szIndi_Vm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VM)));
			Str_Cpy(g_szIndi_Vc, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)));
			Str_Cpy(g_szIndi_Qty, EditCtrl_GetStr(Get_hDlgCtrlByID(TXT_DATA13)));
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Del_Gm
	±â  ´É : °ËÄ§ Ãë¼Ò
	Param  : 
	Return :
	========================================================================================*/
	void Del_Gm(void)
	{
		char szSql[400];
		long idx;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
	
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "UPDATE REGUMDATA \
						  SET MTR_WORK_CODE = '', INDI_SET_VM = '', INDI_SET_VA = '', INDI_SET_VC = '', INDI_QTY = '' \
						    , INDI_DATE = '', SEND_YN = 'N', INDI_DATE = '', CURR_TEMPER = '', CURR_PRES = '' \
						    , CURR_REVIS_PARA = '' \
				        WHERE ROWID = '%s' "
				    , stGm.ROWID, 0, 0);
	
		hstmt = sql->CreateStatement(sql, szSql);
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		else
		{
			if( 10 == m_lUserData )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[0].Str);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), "");
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
			}
			else if( 20 == m_lUserData )
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[0].Str);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VA), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
			}
			else
			{
				EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[0].Str);
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VM), "");
				EditCtrl_SetStr(Get_hDlgCtrlByID(EDT_VC), "");
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
			}
			
			MessageBoxEx (CONFIRM_OK, "°ËÄ§ÀÌ Ãë¼Ò µÇ¾ú½À´Ï´Ù.");
			
			Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);			
			Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
		}
		
Finally:
		DelSqLite(sql);
		return;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : FS_GetSrchTotCnt
	±â  ´É : °Ë»öÀÎµ¦½ºÆÄÀÏÀÇ ·¹ÄÚµå ¼ö¸¦ ¸®ÅÏÇÑ´Ù.
	Param  : nPos:°Ë»ö ÀÎµ¦½º ÆÄÀÏÀÇ ¼ø¹ø
 	Return : ·¹ÄÚµå¼ö
	========================================================================================*/
	long FS_GetSrchTotCnt(void)
	{
		long size = 0;

		size = FFS_GetSize( SREACH_FILE );
		size = size/SRCH_FS_SIZE;
		return size;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Analy_Phone
	±â  ´É : ÇÚµåÆù ¹øÈ£ Çü½Ä °ËÁõ
	Param  : 
 	Return : 1 = Á¤»ó, -1 = ºñÁ¤»ó
	========================================================================================*/
	long Analy_Phone( char* phone, char* num1, char* num2, char* num3 )
	{
		long len;
	
		Str_Chg(phone, STRCHG_DEL_NONDIGIT );
		len = Str_Len(phone);
		
		if( len == 9 )
		{
			Mem_Cpy( (byte*)num1, (byte*)phone,   2);
			Mem_Cpy( (byte*)num2, (byte*)phone+2, 3);
			Mem_Cpy( (byte*)num3, (byte*)phone+5, 4);
		}
		else if( len == 10 )
		{
			if( Mem_Cmp((byte*)phone, (byte*)"01", 2) == 0  )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,   3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3, 3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6, 4);
			}
			else if(  Mem_Cmp((byte*)phone, (byte*)"02", 2) == 0 )
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,   2);
				Mem_Cpy( (byte*)num2, (byte*)phone+2, 4);
				Mem_Cpy( (byte*)num3, (byte*)phone+6, 4);
			}
			else
			{
				Mem_Cpy( (byte*)num1, (byte*)phone,   3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3, 3);
				Mem_Cpy( (byte*)num3, (byte*)phone+6, 4);
			}
		}
		else if( len == 11 )
		{
				Mem_Cpy( (byte*)num1, (byte*)phone,   3);
				Mem_Cpy( (byte*)num2, (byte*)phone+3, 4);
				Mem_Cpy( (byte*)num3, (byte*)phone+7, 4);
		}
		else
		{
			return -1;
		}
		
		return 1;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Save_factor
	±â  ´É : »ó½Ã°è¼ö ÀúÀå
	Param  : 
 	Return :
	========================================================================================*/
	long Save_factor(void)
	{
		long ret = -1;
		char szTmp[10];		
		
		/********************************/
		/* »ó½Ã°è¼ö Àú»ó Validation     */
		/********************************/
		if( Str_Cmp(stGm.GMTR_OBJ_FLAG, "40") == 0 )
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4))  == 0 
			||  EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA6))  == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "»ó½Ã °è¼ö¸¦ ÀÔ·ÂÇÏ¼¼¿ä.");
				goto Finally2;
			}

		}
		else
		{
			if( EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA4))  == 0 
			||  EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA5))  == 0 
			||  EditCtrl_GetStrLen(Get_hDlgCtrlByID(EDT_DATA6))  == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "»ó½Ã °è¼ö¸¦ ÀÔ·ÂÇÏ¼¼¿ä.");
				goto Finally2;
			}
		}
		
		Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp) );
		Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) );
		ret = Chk_float(szTmp);
		if( ret == -1 )
		{
			MessageBoxEx (CONFIRM_OK, "¿ÂµµÀÇ ÀÔ·ÂÇÑ ³»¿ëÀ» È®ÀÎÇÏ¼¼¿ä.");
		}
		else if( ret == -2 )
		{
			MessageBoxEx (CONFIRM_OK, "Á¤¼ö´Â 4ÀÚ¸® ÀÌ»óÀÏ ¼ö ¾ø½À´Ï´Ù.");
		}
		else if( ret == -3 )
		{
			MessageBoxEx (CONFIRM_OK, "¼Ò¼öÁ¡ ÀÚ¸´¼ö´Â 4ÀÚ¸®±îÁö¸¸ ÀÔ·ÂÇØÁÖ¼¼¿ä.");
		}
		else if( ret == -4 )
		{
			MessageBoxEx (CONFIRM_OK, "¿ÂµµÀÇ ÀÔ·Â µ¥ÀÌÅÍ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. ´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
		}
		else if( ret == -5 )
		{
			MessageBoxEx (CONFIRM_OK, "¿ÂµµÀÇ ÀÔ·Â µ¥ÀÌÅÍ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. ´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
		}
		if( ret < 0 )
		{	
			ret = -1;
			goto Finally2;
		}
		
		if( Str_Cmp(stGm.GMTR_OBJ_FLAG, "40") != 0 )
		{
			Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)) );
			ret = Chk_float(szTmp);
			if( ret == -1 )
			{
				MessageBoxEx (CONFIRM_OK, "¾Ð·ÂÀÇ ÀÔ·ÂÇÑ ³»¿ëÀ» È®ÀÎÇÏ¼¼¿ä.");
			}
			else if( ret == -2 )
			{
				MessageBoxEx (CONFIRM_OK, "Á¤¼ö´Â 4ÀÚ¸® ÀÌ»óÀÏ ¼ö ¾ø½À´Ï´Ù.");
			}
			else if( ret == -3 )
			{
				MessageBoxEx (CONFIRM_OK, "¼Ò¼öÁ¡ ÀÚ¸´¼ö´Â 4ÀÚ¸®±îÁö¸¸ ÀÔ·ÂÇØÁÖ¼¼¿ä.");
			}
			else if( ret == -4 )
			{
				MessageBoxEx (CONFIRM_OK, "¾Ð·ÂÀÇ ÀÔ·Â µ¥ÀÌÅÍ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. ´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
			}
			else if( ret == -5 )
			{
				MessageBoxEx (CONFIRM_OK, "¾Ð·ÂÀÇ ÀÔ·Â µ¥ÀÌÅÍ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. ´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
			}
			if( ret < 0 )
			{	
				goto Finally2;
			}
		}
		
		Str_Cpy( szTmp, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)) );
		ret = Chk_float(szTmp);
		if( ret == -1 )
		{
			MessageBoxEx (CONFIRM_OK, "º¸Á¤°è¼öÀÇ ÀÔ·ÂÇÑ ³»¿ëÀ» È®ÀÎÇÏ¼¼¿ä.");
		}
		else if( ret == -2 )
		{
			MessageBoxEx (CONFIRM_OK, "Á¤¼ö´Â 4ÀÚ¸® ÀÌ»óÀÏ ¼ö ¾ø½À´Ï´Ù.");
		}
		else if( ret == -3 )
		{
			MessageBoxEx (CONFIRM_OK, "¼Ò¼öÁ¡ ÀÚ¸´¼ö´Â 4ÀÚ¸®±îÁö¸¸ ÀÔ·ÂÇØÁÖ¼¼¿ä.");
		}
		else if( ret == -4 )
		{
			MessageBoxEx (CONFIRM_OK, "º¸Á¤°è¼öÀÇ ÀÔ·Â µ¥ÀÌÅÍ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. ´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
		}
		else if( ret == -5 )
		{
			MessageBoxEx (CONFIRM_OK, "º¸Á¤°è¼öÀÇ ÀÔ·Â µ¥ÀÌÅÍ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. ´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.");
		}
		if( ret < 0 )
		{	
			goto Finally2;
		}
		
		ret = 1;
		
		/********************************/
		/* »ó½Ã°è¼ö ÀúÀå                */
		/********************************/
		Mem_Set((byte*)stGm.CURR_TEMPER, 0x00, sizeof(stGm.CURR_TEMPER) );
		Mem_Set((byte*)stGm.CURR_PRES, 0x00, sizeof(stGm.CURR_PRES) );
		Mem_Set((byte*)stGm.CURR_REVIS_PARA, 0x00, sizeof(stGm.CURR_REVIS_PARA) );
		
		Str_Cpy( stGm.CURR_TEMPER, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA4)) );
		Str_Cpy( stGm.CURR_PRES, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA5)) );
		Str_Cpy( stGm.CURR_REVIS_PARA, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_DATA6)) );
		
Finally2:
		return ret;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Chk_float
	±â  ´É : »ó½Ã°è¼ö Á¤¼ö, ¼ÒÁÖÁ¡ Ã¼Å©
	Param  : 
 	Return : -1 = ¿ÂµµÀÇ ÀÔ·ÂÇÑ ³»¿ëÀ» È®ÀÎÇÏ¼¼¿ä
 	         -2 = Á¤¼ö´Â 4ÀÚ¸® ÀÌ»óÀÏ ¼ö ¾ø½À´Ï´Ù.
 	         -3 = ¼Ò¼öÁ¡ ÀÚ¸´¼ö´Â 4ÀÚ¸®±îÁö¸¸ ÀÔ·ÂÇØÁÖ¼¼¿ä.
 	         -4 = ¿ÂµµÀÇ ÀÔ·Â µ¥ÀÌÅÍ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. ´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.
 	         -5 = ¿ÂµµÀÇ ÀÔ·Â µ¥ÀÌÅÍ Çü½ÄÀÌ Àß¸øµÇ¾ú½À´Ï´Ù. ´Ù½Ã ÀÔ·ÂÇØ ÁÖ¼¼¿ä.
	========================================================================================*/
	long Chk_float( char * szfloat )
	{
		char szTmp[10];
		char szTmp2[10];
		char szTmp3[10];
		long i, len;
		long chk=0;
		long ret = -1;
	
		len = Str_Len(szfloat);
		
		// ÀÔ·Â ³»¿ë È®ÀÎ
		if(len > 9)
		{	
			ret = -1;
			goto Finally;
		}
		
		chk = 0;
		
		for( i = 0; i < len; i++ )
		{
			if(szfloat[i] == '.')
			{
				chk = i + 1;
				break;
			}
		}
		
		// Á¤¼öºÎºÐ ±æÀÌÃ¼Å©
		if( chk == 0 &&  len > 4 )
		{
			ret = -2;
			goto Finally;
		}
		
		if( chk - 1 > 4 )
		{
			ret = -2;
			goto Finally;
		}
		
		// ¼Ò¼öÁ¡ºÎºÐ ±æÀÌÃ¼Å©
		if(len - (chk) > 4)
		{
			ret = -3;
			goto Finally;
		}
		
		if( chk == 0 )
		{
			chk = len + 1;
		}
		
		Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2) );
		Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3) );
		Mem_Cpy( (byte*)szTmp2, (byte*)szfloat, chk-1 );
		Mem_Cpy( (byte*)szTmp3, (byte*)szfloat, chk-1 );
		
		Str_Chg(szTmp3, STRCHG_DEL_NONDIGIT);
		Str_ItoA(Str_AtoI(szTmp2), szTmp3, 10 );
		
		// ¿ÂµµÀÔ·Â Çü½Ä
		if( Str_Cmp(szTmp2, szTmp3) != 0)
		{
			ret = -4;
			goto Finally;
		}
		
		if( chk < len && len-chk > 0)
		{
			Mem_Set((byte*)szTmp2, 0x00, sizeof(szTmp2) );
			Mem_Set((byte*)szTmp3, 0x00, sizeof(szTmp3) );
			Mem_Cpy( (byte*)szTmp2, (byte*)szfloat+chk, len-(chk) );
			Mem_Cpy( (byte*)szTmp3, (byte*)szfloat+chk, len-(chk) );
			
			Str_Chg(szTmp3, STRCHG_DEL_NONDIGIT);
			if( Str_Cmp(szTmp2, szTmp3) != 0)
			{
				ret = -5;
				goto Finally;
			}
		}
		
		ret = 1;
Finally:
		return ret;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Sos_Key
	±â  ´É : SOS ±â´É
	Param  : 
 	Return :
	========================================================================================*/
	long Sos_Key(void)
	{
		long lLen = 0;
		long lTime = 100;
		long ret = 0;
		char szCustTel[20];
		char szUserTel[20];
		char szMsg[100];
	
		if( MessageBoxEx (CONFIRM_YESNO, "SOS±â´É È°¼ºÈ­") != MB_OK )
		{
			Dialog_SetActiveCtrl(this->m_hDlg, m_lEditCtrlIndex);
			Graphic_RefreshRegion(REFRESH_MSGY1, REFRESH_MSGY2);
			return FALSE;
		}
		
		lLen = Str_Len(stGm.CO_LIVE_NM) + Str_Len(stGm.BLD_NM);
		
		/***************************/
		/* 1¹øÂ° ¸Þ¼¼Áö ¹ß¼Û       */
		/***************************/
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		if( lLen == 0 )
		{
			Str_Cpy(szMsg, "[¾ÈÀü¸Å´ÏÀú]\nÀ§±Þ»óÈ². µµ¿ÍÁÖ¼¼¿ä!\n");
			
			if( Str_Len(stGm.TOWN) > 0 )
			{
				Str_Cat(szMsg, stGm.TOWN);
			}
			if( Str_Len(stGm.ADDR1_M) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stGm.ADDR1_M);
			}
			if( Str_Len(stGm.ADDR1_S) > 0 )
			{
				Str_Cat(szMsg, "-");
				Str_Cat(szMsg, stGm.ADDR1_S);
			}
			if( Str_Len(stGm.DETA_FLOOR) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stGm.DETA_FLOOR);
			}
			if( Str_Len(stGm.HOSU) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stGm.HOSU);
			}
		}
		else
		{
			Str_Cpy(szMsg, "[¾ÈÀü¸Å´ÏÀú]\nÀ§±Þ»óÈ². µµ¿ÍÁÖ¼¼¿ä!\n");
			
			if( Str_Len(stGm.TOWN) > 0 )
			{
				Str_Cat(szMsg, stGm.TOWN);
			}
			if( Str_Len(stGm.CO_LIVE_NM) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stGm.CO_LIVE_NM);
			}
			if( Str_Len(stGm.BLD_NM) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stGm.BLD_NM);
			}
			if( Str_Len(stGm.DETA_FLOOR) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stGm.DETA_FLOOR);
			}
			if( Str_Len(stGm.HOSU) > 0 )
			{
				Str_Cat(szMsg, " ");
				Str_Cat(szMsg, stGm.HOSU);
			}
		}

		Str_Chg(stUserinfo.szSos_SmsNum1, STRCHG_DEL_NONDIGIT );
		Str_Chg(stUserinfo.szpda_ip, STRCHG_DEL_NONDIGIT );
		
		ret = Tapi_SendSmsEx(stUserinfo.szSos_SmsNum1, stUserinfo.szpda_ip, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "¸Þ½ÃÁö ¹ÞÀ» ÀüÈ­ ¹øÈ£°¡ Àß¸øµÇ¾ú½À´Ï´Ù.");
					return ret;
				case -2:
					MessageBoxEx (WARNING_OK, "ÀÀ´äÀ» ¹ÞÀ» ÀüÈ­¹øÈ£°¡ Àß¸øµÇ¾ú½À´Ï´Ù.");
					return ret;
				case -3:
					MessageBoxEx (WARNING_OK, "³»¿ëÀÌ ºñ¾ú½À´Ï´Ù.");
					return ret;
				case -4:
					MessageBoxEx (WARNING_OK, "³»¿ëÀÌ ³Ê¹« ±é´Ï´Ù.");
					return ret;
				default:
					MessageBoxEx (WARNING_OK, "¸Þ¼¼Áö Àü¼Û¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
					return ret;
			}
		}
		
		VmSleep(lTime);
		
		/***************************/
		/* 2¹øÂ° ¸Þ¼¼Áö ¹ß¼Û       */
		/***************************/
		
		Str_Chg(stUserinfo.szSos_SmsNum2, STRCHG_DEL_NONDIGIT );
		Str_Chg(stUserinfo.szpda_ip, STRCHG_DEL_NONDIGIT );
		
		ret = Tapi_SendSmsEx(stUserinfo.szSos_SmsNum2, stUserinfo.szpda_ip, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "¸Þ½ÃÁö ¹ÞÀ» ÀüÈ­ ¹øÈ£°¡ Àß¸øµÇ¾ú½À´Ï´Ù.");
					return ret;
				case -2:
					MessageBoxEx (WARNING_OK, "ÀÀ´äÀ» ¹ÞÀ» ÀüÈ­¹øÈ£°¡ Àß¸øµÇ¾ú½À´Ï´Ù.");
					return ret;
				case -3:
					MessageBoxEx (WARNING_OK, "³»¿ëÀÌ ºñ¾ú½À´Ï´Ù.");
					return ret;
				case -4:
					MessageBoxEx (WARNING_OK, "³»¿ëÀÌ ³Ê¹« ±é´Ï´Ù.");
					return ret;
				default:
					MessageBoxEx (WARNING_OK, "¸Þ¼¼Áö Àü¼Û¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
					return ret;
			}
		}
		
		VmSleep(lTime);
		
		/***************************/
		/* 3¹øÂ° ¸Þ¼¼Áö ¹ß¼Û       */
		/***************************/
		Str_Chg(stUserinfo.szSos_SmsNum3, STRCHG_DEL_NONDIGIT );
		Str_Chg(stUserinfo.szpda_ip, STRCHG_DEL_NONDIGIT );
		
		ret = Tapi_SendSmsEx(stUserinfo.szSos_SmsNum3, stUserinfo.szpda_ip, szMsg, Str_Len(szMsg) );
		
		if(ret != 0)
		{
			switch(ret)
			{
				case -1:
					MessageBoxEx (WARNING_OK, "¸Þ½ÃÁö ¹ÞÀ» ÀüÈ­ ¹øÈ£°¡ Àß¸øµÇ¾ú½À´Ï´Ù.");
					return ret;
				case -2:
					MessageBoxEx (WARNING_OK, "ÀÀ´äÀ» ¹ÞÀ» ÀüÈ­¹øÈ£°¡ Àß¸øµÇ¾ú½À´Ï´Ù.");
					return ret;
				case -3:
					MessageBoxEx (WARNING_OK, "³»¿ëÀÌ ºñ¾ú½À´Ï´Ù.");
					return ret;
				case -4:
					MessageBoxEx (WARNING_OK, "³»¿ëÀÌ ³Ê¹« ±é´Ï´Ù.");
					return ret;
				default:
					MessageBoxEx (WARNING_OK, "¸Þ¼¼Áö Àü¼Û¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
					return ret;
			}
		}
		
		VmSleep(lTime);
		
		/***************************/
		/* 4¹øÂ° ÀüÈ­°É±â(112)     */
		/***************************/
		Str_Chg(stUserinfo.szSos_TelNum, STRCHG_DEL_NONDIGIT );
		Tapi_MakeCall((byte*)stUserinfo.szSos_TelNum);
		
		return ret;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Clear_Flag
	±â  ´É : FLAG ÃÊ±âÈ­
	Param  : 
 	Return :
	========================================================================================*/
	void Clear_Flag(void)
	{
		m_lLastSave = 0;
		m_lChk = 0;	// »ç¿ë·®ÀÌ»ó¼¼´ë ÀúÀå°ü·Ã chk
		m_lSmsDelFlag = 0;
		m_lSmsStsFlag = 0;
		g_lDataflag = 0;
		g_nSmsSndFlag = 0;
		
		Mem_Set( (byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG) );
		Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
		
		Mem_Set( (byte*)g_szIndi_MtrCode, 0x00, sizeof(g_szIndi_MtrCode) );
		Mem_Set( (byte*)g_szIndi_Qty, 0x00, sizeof(g_szIndi_Qty) );
		Mem_Set( (byte*)g_szIndi_Vc, 0x00, sizeof(g_szIndi_Vc) );
		Mem_Set( (byte*)g_szIndi_Vm, 0x00, sizeof(g_szIndi_Vm) );
		Mem_Set( (byte*)g_szIndi_Va, 0x00, sizeof(g_szIndi_Va) );
		Mem_Set( (byte*)m_szIndiQty, 0x00, sizeof(m_szIndiQty) );
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : JCHM_DRAW
	±â  ´É : »ó¼¼ÁöÄ§ ³»¿ª DRAW
	Param  : 
 	Return :
	========================================================================================*/
	void JCHM_DRAW(void)
	{
		if( m_bFirst == INIT_JCHM )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA25), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA26), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA27), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA28), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA29), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA30), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA31), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA32), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA33), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA34), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA35), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA36), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA30), stGm.BEFO_MM_INDI_COMPENS_VC_1);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA34), stGm.BEFO_MM_USE_QTY_1);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA31), stGm.BEFO_MM_INDI_COMPENS_VC_2);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA35), stGm.BEFO_MM_USE_QTY_2);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA32), stGm.BEFO_YY_COMPENS_VC);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA36), stGm.BEFO_YM_USE_QTY);
		}
		else if( m_bFirst == INIT_BJCHM )
		{
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA37), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA38), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA39), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA40), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA41), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA42), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA43), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA44), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA45), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA46), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA47), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA48), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA49), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA50), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA51), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA52), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA53), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA54), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA55), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA56), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
			
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA42), stGm.BEFO_MM_INDI_COMPENS_VC_1);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA43), stGm.BEFO_MM_INDI_COMPENS_VC_2);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA44), stGm.BEFO_YY_COMPENS_VC);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA46), stGm.BEFO_MM_INDI_COMPENS_VA_1);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA47), stGm.BEFO_MM_INDI_COMPENS_VA_2);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA48), stGm.BEFO_YY_COMPENS_VA);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA50), stGm.BEFO_MM_INDI_MTR_1);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA51), stGm.BEFO_MM_INDI_MTR_2);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA52), stGm.BEFO_YY_MTR);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA54), stGm.BEFO_MM_USE_QTY_1);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA55), stGm.BEFO_MM_USE_QTY_2);
			EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA56), stGm.BEFO_YM_USE_QTY);
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : NUM_DRAW
	±â  ´É : »ó½Ã°è¼ö DRAW
	Param  : 
 	Return :
	========================================================================================*/
	void NUM_DRAW(void)
	{
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA57), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA58), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA59), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA60), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_DATA61), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA4), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA5), EDITALIGN_MIDDLE);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(EDT_DATA6), EDITALIGN_MIDDLE);
		
		if( Str_Cmp(stGm.GMTR_OBJ_FLAG, "40") == 0 )
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), stGm.CURR_TEMPER );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), stGm.CURR_REVIS_PARA );
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5), FALSE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5), TRUE );
		}
		else
		{
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA4), stGm.CURR_TEMPER );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA5), stGm.CURR_PRES );
			EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_DATA6), stGm.CURR_REVIS_PARA );
			
			DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5), TRUE );
			DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_DATA5), FALSE );
		}
		
		// »çÁø ¹öÆ° VC
		if( Str_Cmp(stGm.PHOTO_COMPENS_VC_YN, "Y") == 0 )
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO_VC), RED );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO_VC), BTNMENUFRCOLOR );
		}
		else if( Str_Cmp(stGm.PHOTO_COMPENS_VC_YN, "S") == 0 )
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO_VC), GREEN );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO_VC), BTNMENUFRCOLOR );
		}
		else
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO_VC), YELLOW );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO_VC), TXTFRCOLOR );
		}
		
		// »çÁø ¹öÆ° VA
		if( Str_Cmp(stGm.PHOTO_COMPENS_VA_YN, "Y") == 0 )
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO_VA), RED );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO_VA), BTNMENUFRCOLOR );
		}
		else if( Str_Cmp(stGm.PHOTO_COMPENS_VA_YN, "S") == 0 )
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO_VA), GREEN );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO_VA), BTNMENUFRCOLOR );
		}
		else
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO_VA), YELLOW );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO_VA), TXTFRCOLOR );
		}
		
		// »çÁø ¹öÆ° VM
		if( Str_Cmp(stGm.PHOTO_COMPENS_VM_YN, "Y") == 0 )
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO_VM), RED );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO_VM), BTNMENUFRCOLOR );
		}
		else if( Str_Cmp(stGm.PHOTO_COMPENS_VM_YN, "S") == 0 )
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO_VM), GREEN );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO_VM), BTNMENUFRCOLOR );
		}
		else
		{
			ButCtrl_SetBkColorEx( Get_hDlgCtrlByID(BID_PHOTO_VM), YELLOW );
			ButCtrl_SetForeColorEx( Get_hDlgCtrlByID(BID_PHOTO_VM), TXTFRCOLOR );
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : COMPENSREMOVE_DRAW
	±â  ´É : º¸Á¤±â »èÁ¦ DRAW
	Param  : 
 	Return :
	========================================================================================*/
	void COMPENSREMOVE_DRAW(void)
	{
		char szMsg[500];
		char szAddr[500];
		char szMtr_Num[20];
		char szTmp[500];
		long lLen = 0;
		
		/********************************/
		/* Style Setting                */
		/********************************/
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_COMPENS_MAIN), EDITALIGN_MIDDLE|EDITALIGN_LEFT);
		EditCtrl_SetAlign( Get_hDlgCtrlByID(TXT_COMPENS_CONF_NM), EDITALIGN_MIDDLE|EDITALIGN_CENTER);
		EditCtrl_SetMultiLine(Get_hDlgCtrlByID(TXT_COMPENS_MAIN), TRUE, 2, EDITSEP_NONE );
		
		/********************************/
		/* ÁÖ¼Ò                         */
		/********************************/
		Mem_Set((byte *)szAddr, 0x00, sizeof(szAddr));
		
		if( g_nAddrFlag == 0)
		{
			if(Str_Len(stGm.TOWN) > 0)
			{
				Str_Cpy(szAddr,  stGm.TOWN );
			}
			else
			{
				Str_Cpy(szAddr,  "" );
			}
			if(Str_Len(stGm.VILLAGE) > 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.VILLAGE );
			}
			if(Str_Len(stGm.ADDR1_M) > 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.ADDR1_M);
			}			
			if(Str_Len(stGm.ADDR1_S) > 0)
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.ADDR1_S);
			}
			
			lLen = Str_Len(stGm.CO_LIVE_NM) + Str_Len(stGm.BLD_NM);

			if( lLen > 0 )
			{
				if( Str_Len(stGm.CO_LIVE_NM) > 0 )
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.CO_LIVE_NM );
				}
				else
				{
					Str_Cat(szAddr,  "" );
				}
					
				if( Str_Len(stGm.BLD_NM) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.BLD_NM );
				}
				
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szAddr,  "-" );	
					Str_Cat(szAddr,  stGm.HOSU );
				}
				
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.DETA_FLOOR );
				}
			}
			else
			{
				if( Str_Len(stGm.HOSU) > 0 )
				{
					Str_Cat(szAddr,  " " );
					Str_Cat(szAddr,  stGm.HOSU );
				}
				else
				{
					Str_Cat(szAddr,  "" );
				}
				
				if( Str_Len(stGm.DETA_FLOOR) > 0 )
				{
					Str_Cat(szAddr,  " " );	
					Str_Cat(szAddr,  stGm.DETA_FLOOR );
				}
			}
		}
		else
		{
			if(Str_Len(stGm.NEW_ROAD_NM) > 0)
			{
				Str_Cpy(szAddr,  stGm.NEW_ROAD_NM );
			}
			else
			{
				Str_Cpy(szAddr,  "" );
			}
			if(Str_Len(stGm.NEW_ADDR_M) > 0)
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.NEW_ADDR_M);
			}
			if(Str_Len(stGm.NEW_ADDR_S) > 0)
			{
				Str_Cat(szAddr,  "-" );
				Str_Cat(szAddr,  stGm.NEW_ADDR_S);
			}

			if( Str_Len(stGm.CO_LIVE_NM) > 0 )
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.CO_LIVE_NM );
			}
			else
			{
				Str_Cat(szAddr,  "" );
			}
			if( Str_Len(stGm.BLD_NM) > 0 )
			{
				Str_Cat(szAddr,  " " );	
				Str_Cat(szAddr,  stGm.BLD_NM );
			}
			if( Str_Len(stGm.HOSU) > 0 )
			{
				Str_Cat(szAddr,  "-" );	
				Str_Cat(szAddr,  stGm.HOSU );
			}
			if( Str_Len(stGm.DETA_FLOOR) > 0 )
			{
				Str_Cat(szAddr,  " " );
				Str_Cat(szAddr,  stGm.DETA_FLOOR );
			}
		}
		
		/********************************/
		/* º¸Á¤±â »èÁ¦ ¹®±¸             */
		/********************************/
		// 1. ÁÖ¼Ò
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		Str_Cpy(szMsg, "ÁÖ    ¼Ò : ");
		Str_Cat(szMsg, szAddr);
		Str_Cat(szMsg, "\n\n");
		
		// 2. °í°´¸í
		Str_Cat(szMsg, "°í°´¸í : ");
		Str_Cat(szMsg, stGm.CUST_NM);
		Str_Cat(szMsg, "\n\n");
		
		// 3. »óÈ£
		if( Str_Len( stGm.FIRM_NM ) > 0 )
		{
			Str_Cat(szMsg, "»ó   È£ : ");
			Str_Cat(szMsg, stGm.FIRM_NM);
			Str_Cat(szMsg, "\n\n");
		}
		
		// 4. °è·®±â¹øÈ£
		Mem_Set( (byte*)szMtr_Num, 0x00, sizeof(szMtr_Num) );
		Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
		
		Mem_Cpy((byte *)szMtr_Num, (byte *)stGm.MTR_NUM, 5);
		Mem_Cpy((byte *)szTmp, (byte *)stGm.MTR_NUM+5, 4);
		Str_Cat(szMtr_Num, "-");
		Str_Cat(szMtr_Num, szTmp);
		
		Str_Cat(szMsg, "°è·®±â¹øÈ£ : ");
		Str_Cat(szMsg, szMtr_Num);
		Str_Cat(szMsg, "\n\n\n\n");
		
		// 5. ¹®±¸
		Str_Cat(szMsg, " ¿Â¾Ð º¸Á¤ÀåÄ¡ °íÀåÀ¸·Î ÀÎÇØ º¸Á¤ÀåÄ¡·Î");
		Str_Cat(szMsg, "\n\nÃøÁ¤µÈ µµ½Ã°¡½º °ø±Þ·®À» Àû¿ëÇÒ ¼ö ¾øÀ½À»");
		Str_Cat(szMsg, "\n\nÈ®ÀÎÇßÀ¸¸ç, µµ½Ã°¡½º °ø±Þ±ÔÁ¤¿¡ µû¶ó °¡½º");
		Str_Cat(szMsg, "\n\n»ç¿ë·®À» »êÁ¤ÇÕ´Ï´Ù.");
		
		// 6. ½ÇÁ¦ ¹Ý¿µ
		EditCtrl_SetStr( Get_hDlgCtrlByID(TXT_COMPENS_MAIN), szMsg );
		
		/********************************/
		/* È®ÀÎÀÚ                       */
		/********************************/
		Mem_Set( (byte*) szMsg, 0x00, sizeof( szMsg) );
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		SPRINT(szMsg, "SELECT CONF_NM FROM GUM_COMPENS_REMOVE_REQ WHERE REQ_YM = '%s' AND DEADLINE_FLAG = '%s' AND MTR_NUM = '%s'", stGm.REQ_YM, stGm.DEADLINE_FLAG, stGm.MTR_NUM);
		g_Sql_RetStr(szMsg, 10, szTmp);
		
		EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_COMPENS_CONF_NM), szTmp );
		
		/********************************/
		/* ¼­¸í ¹öÆ°                    */
		/********************************/
		lLen = 0;
		
		Mem_Set( (byte*)szMsg, 0x00, sizeof(szMsg) );
		SPRINT(szMsg, "SELECT LENGTH( SIGN ) FROM GUM_COMPENS_REMOVE_REQ WHERE REQ_YM = '%s' AND DEADLINE_FLAG = '%s' AND MTR_NUM = '%s'", stGm.REQ_YM, stGm.DEADLINE_FLAG, stGm.MTR_NUM);
		g_Sql_RetInt( szMsg, &lLen );
		
		if( lLen < 100)
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_COMPENS_SIGN), BTNCTRLBKCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_COMPENS_SIGN), BTNMENUFRCOLOR);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_COMPENS_SIGN), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_COMPENS_SIGN), BTNMENUFRCOLOR);
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : SetTotCnt
	±â  ´É : °ËÄ§ ´ë»ó COUNT
	Param  : 
 	Return :
	========================================================================================*/
	void SetTotCnt(void)
	{
		char szSql[200];
		
		// 2016-05-26 Sanghyun Lee
		// ÃÑ Ä«¿îÆ® ¼ÂÆÃ , ÆÄÀÏ¿¡ ´ãÀº ³»¿ëÀº º¯ÇÏÁö ¾ÊÀ½.
		
		// ¹Ì°ËÄ§ ¸ñ·Ï(¸®½ºÆ®)
		if( g_nWorkFlag == 103 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM REGUMDATA WHERE SEND_YN = 'N' OR SEND_YN = 'I' OR SEND_YN = '' OR SEND_YN IS NULL ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE", 0, 0, 0);
			g_Sql_RetInt( szSql , &m_ltotcnt );
		}
		// ºÎÀç(¸®½ºÆ®)
		else if( g_nWorkFlag == 104 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM REGUMDATA WHERE MTR_WORK_CODE = '2' ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE", 0, 0, 0);
			g_Sql_RetInt( szSql , &m_ltotcnt );
		}
		// ³ª¸ÓÁö
		else
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "SELECT COUNT(*) FROM REGUMDATA ORDER BY DONG_ORD, HOUSE_NUM_ORD, MTR_COURSE ", 0, 0, 0);
			g_Sql_RetInt( szSql , &m_ltotcnt );
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Call_Tel
	±â  ´É : ÀüÈ­°É±â
	Param  : 
 	Return :
	========================================================================================*/
	void Call_Tel(void)
	{
		char szNum[15];
		Mem_Set( (byte*)szNum, 0x00, sizeof(szNum) );
		
		Str_Cpy(szNum, m_szPhone);
		Str_Chg(szNum, STRCHG_DEL_NONDIGIT );
		
		if( Str_Len(szNum) > 8 )
		{
			Tapi_MakeCall((byte*)szNum);
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311324
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å ÀÏÀÎÁö Ã¼Å©
	Param  : 
 	Return :
	========================================================================================*/
	long RCV311324(void)
	{
		char szBuf[20];
		char sztmp[128];
		char szUrl[256];
		char* sndbuf;
		long ret;
	
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));
		Str_ItoA(Time_GetDate(), sztmp, 10);
		
		Mem_Set((byte*)m_szObjym, 0x00, sizeof(m_szObjym));
		Mem_Set((byte*)m_szChkyear, 0x00, sizeof(m_szChkyear));
		Mem_Set((byte*)szBuf, 0x00, sizeof(szBuf));

		Mem_Cpy( (byte*)m_szObjym, (byte*)sztmp, 6 );
		Mem_Cpy( (byte*)m_szChkyear, (byte*)sztmp, 4 );
		Mem_Cpy( (byte*)szBuf, (byte*)sztmp+4, 2 );
		
		if( Str_AtoI(szBuf) < 7 )
		{
			Str_Cpy(m_szChkorder, "10");
		}
		else
		{
			Str_Cpy(m_szChkorder, "70");
		}
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311324, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "chk_year",       m_szChkyear );
		JSON_SetValue( g_pjcomm, 'C', "chk_order",      m_szChkorder);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311324;
		ret = HTTP_DownloadData(szUrl, "FR311324_IN",  "FR311324" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311324
	±â  ´É : RCV311324 Callback
	Param  : 
 	Return :
	========================================================================================*/
	long TR311324(void)
	{
		g_Sock_Close();

		if(g_Chk_Json(311324) >= 0)
		{
			RCV311317();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311317
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å_Á¶Á¤±â
	Param  : 
 	Return :
	========================================================================================*/
	long RCV311317(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	long chk = 0, totcnt;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311317, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "center_cd",    stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",      stGm.BLD_NUM );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_SeverConnection();
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311317; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311317_IN",  "FR311317" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311317
	±â  ´É : TR311317 Callback
	Param  : 
 	Return :
	========================================================================================*/
	long TR311317(void)
	{
		if(g_Chk_Json(311317) >= 0)
		{
			RCV311318();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311318
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å_Á¶Á¤±â
	Param  : 
 	Return :
	========================================================================================*/
	long RCV311318(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		Mem_Set((byte*)m_szZonemanagenum, 0x00, sizeof(m_szZonemanagenum));	
		g_Sql_RetStr("SELECT PARAM6 FROM RCV_LOG WHERE GUBUN = '10'", 4, m_szZonemanagenum);
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311318, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "center_cd",    stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "bld_num",      stGm.BLD_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311318; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311318_IN",  "FR311318" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311318
	±â  ´É : RCV311318 Callback
	Param  : 
 	Return :
	========================================================================================*/
	long TR311318(void)
	{
		g_Sock_Close();
		
		if(g_Chk_Json(311318) >= 0)
		{
			RCV311311();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311311
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311311(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311311, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szObjym);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		g_Save_JsonFile(sndbuf);
		
		callBackfunc = TR311311; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311311_IN",  "FR311311" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311317
	±â  ´É : TR311317 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311311(void)
	{
		if(g_Chk_Json(311311) >= 0)
		{
			RCV311312();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311312
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311312(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311312, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szObjym);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311312; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311312_IN",  "FR311312" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311312
	±â  ´É : TR311312 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311312(void)
	{
		if(g_Chk_Json(311312) >= 0)
		{
			RCV311313();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311313
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311313(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311313, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szObjym);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311313; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311313_IN",  "FR311313" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311313
	±â  ´É : TR311313 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311313(void)
	{
		if(g_Chk_Json(311313) >= 0)
		{
			RCV311314();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311314
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311314(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311314, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szObjym);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311314; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311314_IN",  "FR311314" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311314
	±â  ´É : TR311317 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311314(void)
	{
	char szSql[256];
	
		if(g_Chk_Json(311314) >= 0)
		{
			//Á¶°ÇÀý ³Ö¾îÁà¾ßÇÔ
			Mem_Set((byte*)szSql ,0x00, sizeof(szSql) );
			SPRINT(szSql, " UPDATE NORMAL_ADDR SET BEFO_ADDR1_M = ADDR1_M, BEFO_ADDR1_S = ADDR1_S, BEFO_NEW_ADDR_M = NEW_ADDR_M, BEFO_NEW_ADDR_S = NEW_ADDR_S ", 0, 0, 0);
			g_Sql_DirectExecute( szSql );
		
			RCV311315();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311315
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311315(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311315, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szObjym);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311315; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311315_IN",  "FR311315" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311315
	±â  ´É : TR311315 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311315(void)
	{
		if(g_Chk_Json(311315) >= 0)
		{
			RCV311307();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311307
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311307(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311307, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "obj_ym",     m_szObjym);
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311307; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311307_IN",  "FR311307" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311317
	±â  ´É : TR311317 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311307(void)
	{
		if(g_Chk_Json(311307) >= 0)
		{
			RCV311308();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311308
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311308(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311308, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311308; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311308_IN",  "FR311308" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311308
	±â  ´É : TR311308 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311308(void)
	{
		if(g_Chk_Json(311308) >= 0)
		{
			RCV311309();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311309
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311309(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311309, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311309; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311309_IN",  "FR311309" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311309
	±â  ´É : TR311309 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311309(void)
	{
		if(g_Chk_Json(311309) >= 0)
		{
			RCV311310();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311310
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311310(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311310, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311310; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311310_IN",  "FR311310" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311310
	±â  ´É : TR311310 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311310(void)
	{
		if(g_Chk_Json(311310) >= 0)
		{
			RCV311323();
			return 1;
		}
		else
		{
			g_Sock_Close();
			return -1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : RCV311323
	±â  ´É : ¾ÈÀüÁ¡°Ë ÀÚ·á ¼ö½Å
	Param  : 
	Return :
	========================================================================================*/
	long RCV311323(void)
	{
	char sztmp[128];
	char szUrl[256];
	char* sndbuf;
	long ret;
	
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 311323, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        "20");		//10 : ÀÏ¹ÝÁ¡°Ë ¼ö½Å , 20 : °ËÄ§-Á¡°Ë ¾÷¹«ÀÌµ¿ ¼ö½Å
		JSON_SetValue( g_pjcomm, 'C', "chk_year",   m_szChkyear);
		JSON_SetValue( g_pjcomm, 'C', "chk_order",  m_szChkorder );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",  stUserinfo.szcenter_cd);
		JSON_SetValue( g_pjcomm, 'C', "bld_num",    stGm.BLD_NUM);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",    stGm.MTR_NUM);
		
		sndbuf = JSON_toString(g_pjcomm);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR311323; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR311323_IN",  "FR311323" , sndbuf, sztmp );
		return 0 ;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR311323
	±â  ´É : TR311323 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR311323(void)
	{
		long totcnt = 0;
		long Rcvcnt = 0;
		char szDate[20];
		char szSql[256];
	
		g_Sock_Close();
		
		if(g_Chk_Json(311323) >= 0)
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, " SELECT COUNT(*) FROM NORMAL_DATA WHERE INST_PLACE_NUM = '%s'", stGm.USAGE_TITLE, 0, 0   );
			g_Sql_RetInt( szSql , &Rcvcnt );

			if( Rcvcnt > 0 )
			{
				Str_ItoA(Time_GetDate(), szDate, 10);
				g_Sql_RetInt( "SELECT COUNT(*) FROM RCV_LOG WHERE GUBUN = '2'" , &totcnt );
				if( totcnt > 0 )
				{
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "UPDATE RCV_LOG SET PARAM7 = '%s' WHERE GUBUN = '2'", szDate, 0, 0);		
				}
				else
				{
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "INSERT INTO RCV_LOG(GUBUN, PARAM7) VALUES('2', '%s') ", szDate, 0, 0);		
				}
				g_Sql_DirectExecute(szSql);
				
				//ÇØ´ç ´ë»ó group ÀüÃ¼ ¼ö½Å ÈÄ normal_group Å×ÀÌºí update
				totcnt = 0;
				Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
				SPRINT(szSql, "SELECT COUNT(*) FROM NORMAL_GROUP WHERE BLD_NUM = '%s'", stGm.BLD_NUM, 0, 0);		
				g_Sql_RetInt(szSql, &totcnt );
				if( totcnt > 0 )
				{
					Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
					SPRINT(szSql, "UPDATE NORMAL_GROUP SET CHK_YN = '1', SEND_YN = 'Y' WHERE BLD_NUM = '%s'", stGm.BLD_NUM, 0, 0);		
					g_Sql_DirectExecute(szSql);
				}
	
				Card_Move("SC_CONFIRM");
			}
			else
			{
				MessageBoxEx(CONFIRM_OK, "´ç¿ù ¾ÈÀüÁ¡°ËÀÚ·á°¡ ¾ø½À´Ï´Ù.");
			}
			
			return 1;
		}
		else
		{
			return -1;
		}
	}
		
	/*=======================================================================================
	ÇÔ¼ö¸í : Snd_Sms_New
	±â  ´É : ¹®ÀÚ°ËÄ§ ´ë»ó µî·Ï / FR25004
	Param  : 
	Return :
	========================================================================================*/
	long Snd_Sms_New(void)
	{
		char szSql[256];
		char sztmp[32];
		char szUrl[256];
		char szReqym[10];
		char szDeadlineFlag[10];
		char szPhoneNum[32];
		char szPhoneNum1[5];
		char szPhoneNum2[5];
		char szPhoneNum3[5];
		char* sndbuf;
		long ret;
		long lTelNumFlag;		// = 0 ¹®ÀÚ°ËÄ§ ¹øÈ£ »ç¿ë , = 1 °ËÄ§°í°´ ÀüÈ­¹øÈ£ »ç¿ë

		//2017-05-29 Sanghyun Lee
		//¹®ÀÚ°ËÄ§ ÀüÈ­¹øÈ£ È®ÀÎ ¼ø¼­ : ¹®ÀÚ°ËÄ§ µî·Ï ÀüÈ­¹øÈ£ È®ÀÎ -> °ËÄ§´ë»ó ±âº» ÀüÈ­¹øÈ£ È®ÀÎ 
		Mem_Set( (byte*) szPhoneNum, 0x00, sizeof( szPhoneNum) );
		Mem_Set( (byte*) szPhoneNum1, 0x00, sizeof( szPhoneNum1) );
		Mem_Set( (byte*) szPhoneNum2, 0x00, sizeof( szPhoneNum2) );
		Mem_Set( (byte*) szPhoneNum3, 0x00, sizeof( szPhoneNum3) );
		
		Str_Cpy(szPhoneNum, stGm.SMS_CP_DDD);
		Str_Cat(szPhoneNum, stGm.SMS_CP_EXN);
		Str_Cat(szPhoneNum, stGm.SMS_CP_NUM);
		
		ret = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
		
		lTelNumFlag = 0;
		
		if(ret < 0)
		{
			Mem_Set( (byte*) szPhoneNum, 0x00, sizeof( szPhoneNum) );
			Mem_Set( (byte*) szPhoneNum1, 0x00, sizeof( szPhoneNum1) );
			Mem_Set( (byte*) szPhoneNum2, 0x00, sizeof( szPhoneNum2) );
			Mem_Set( (byte*) szPhoneNum3, 0x00, sizeof( szPhoneNum3) );
			
			Str_Cpy(szPhoneNum, stGm.CP_DDD);
			Str_Cat(szPhoneNum, stGm.CP_EXN);
			Str_Cat(szPhoneNum, stGm.CP_NUM);
			
			ret = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
			
			lTelNumFlag = 1;
			
			if( ret < 0 )
			{
				MessageBoxEx (CONFIRM_OK, "ÀüÈ­¹øÈ£¸¦ µî·ÏÇØÁÖ¼¼¿ä.");
				return 0;
			}
		}

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}	
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25004, FALSE);

		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set( (byte*) szReqym, 0x00, sizeof( szReqym) );
		SPRINT( szSql, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, szReqym);
		
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		Mem_Set((byte*)szDeadlineFlag, 0x00, sizeof(szDeadlineFlag));	
		SPRINT( szSql, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 10, szDeadlineFlag);
		
		JSON_SetValue( g_pjcomm, 'C', "gubun",        		"I" );
		JSON_SetValue( g_pjcomm, 'C', "req_ym",        		szReqym );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",      szDeadlineFlag );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",       stGm.USE_CONT_NUM );
		
		if( lTelNumFlag == 0 )
		{
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_ddd",        		stGm.SMS_CP_DDD );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_exn",        		stGm.SMS_CP_EXN );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_num",        	    stGm.SMS_CP_NUM );
		}
		else
		{
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_ddd",        		stGm.CP_DDD );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_exn",        		stGm.CP_EXN );
			JSON_SetValue( g_pjcomm, 'C', "receiver_tel_num",        	    stGm.CP_NUM );
		}
		
		JSON_SetValue( g_pjcomm, 'C', "cust_num",        	stGm.CUST_NUM );
		JSON_SetValue( g_pjcomm, 'C', "center_cd",        	stUserinfo.szcenter_cd );
		JSON_SetValue( g_pjcomm, 'C', "send_type",        	"10" );	//10 : °³ÀÎ , 20 : ±×·ì
		JSON_SetValue( g_pjcomm, 'C', "nonpay_manage_sec",  stGm.NONPAY_MANAGE_SEC );

		sndbuf = JSON_toString(g_pjcomm);

		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25004; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		ret = HTTP_DownloadData(szUrl, "FR25004_IN",  "FR25004" , sndbuf, sztmp );
		return 0 ;
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : TR25004
	±â  ´É : TR25004 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR25004(void)
	{
		long ntotcnt = 0, i = 0;
		char szIndi_VM[10];		//´ç¿ù VM ÁöÄ§ 
		char szIndi_VA[10];		//´ç¿ù VAÁöÄ§ 
		char szIndi_VC[10];		//´ç¿ù VCÁöÄ§
		char szIndi_Qty[10];
		char szDate[20];
		char szTmp[256];
		
		if( g_Chk_Json(25004) >= 0)
		{
			// ÁöÄ§
			Mem_Set((byte *)stGm.INDI_SET_VM, 0x00, sizeof(stGm.INDI_SET_VM));
			Mem_Set((byte *)stGm.INDI_SET_VA, 0x00, sizeof(stGm.INDI_SET_VA));
			Mem_Set((byte *)stGm.INDI_SET_VC, 0x00, sizeof(stGm.INDI_SET_VC));
			Mem_Set((byte *)stGm.INDI_QTY, 0x00, sizeof(stGm.INDI_QTY));
			Mem_Set((byte *)m_szMtr_Code, 0x00, sizeof(m_szMtr_Code));
			Mem_Set((byte *)stGm.MTR_WORK_CODE, 0x00, sizeof(stGm.MTR_WORK_CODE));
				
			i = SearchStr( EditCtrl_GetStr(Get_hDlgCtrlByID(CMB_RESULT)), RE_GM_CODE );
			if (i == -1)
			{
				Str_Cpy(m_szMtr_Code, "");
			}
			else
			{
				Str_Cpy(m_szMtr_Code, RE_GM_CODE[i].Code);
			}

			Str_Cpy(stGm.MTR_WORK_CODE, m_szMtr_Code);		
			Str_Cpy(stGm.INDI_SET_VM, "");			
			Str_Cpy(stGm.INDI_SET_VA, "");			
			Str_Cpy(stGm.INDI_SET_VC, "");			
			Str_Cpy(stGm.INDI_QTY, "");			

			// ³¯Â¥
			Mem_Set((byte *)szDate, 0x00, sizeof(szDate));
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte *)szTmp, 0x00, sizeof(szTmp));
			Mem_Set((byte *)stGm.INDI_DATE, 0x00, sizeof(stGm.INDI_DATE));
			Mem_Set((byte *)stGm.SMS_GMTR_MAN_YN, 0x00, sizeof(stGm.SMS_GMTR_MAN_YN));
			
			Str_ItoA(Time_GetDate(), szDate,10);
			g_Str_TimeType( szTmp , Time_GetTime());
			Str_Cat(szDate, szTmp);
			
			Str_Cpy(stGm.INDI_DATE, szDate);
			Str_Cpy(stGm.SMS_GMTR_MAN_YN, "Y");

			if( Save_Gm() > 0 )
			{
				if( 10 == m_lUserData )
				{
					Mem_Set((byte *)g_szMtr_Code, 0x00, sizeof(g_szMtr_Code));
					Str_Cpy(g_szMtr_Code, stGm.MTR_WORK_CODE);
				}
				
				g_nBackFlag++;
				
				if( g_nBackFlag > 99)
				{
					g_Db_Backup();
					g_nBackFlag = 0;
				}
	
				Next_Gm();
				Set_Index();
			}

			return 1;	
		}
		else
		{
			g_Sock_Close();
			
			ON_DRAW();
			return -1;
		}
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : Snd_Reserve_Cancel
	±â  ´É : ¹®ÀÚ°ËÄ§ ¿¹¾à Ãë¼Ò / FR25006
	Param  : 
	Return :
	========================================================================================*/
	long Snd_Reserve_Cancel(void)
	{
		char szTmp[500];
		char szUrl[200];
		char szbuf[128];
		char szReqym[10];
		char szDeadlineFlag[10];
		char szSmsChgWhy[10];
		char szPhoneNum[32];
		char szPhoneNum1[5];
		char szPhoneNum2[5];
		char szPhoneNum3[5];
		char* sndbuf;
		long i = 0;
		long ntotcnt = 0;
		long nLen = 0;
		long lTelNumFlag = 0, ret = 0;		// = 0 ¹®ÀÚ°ËÄ§ ¹øÈ£ »ç¿ë , = 1 °ËÄ§°í°´ ÀüÈ­¹øÈ£ »ç¿ë

		//2017-05-29 Sanghyun Lee
		//¹®ÀÚ°ËÄ§ ÀüÈ­¹øÈ£ È®ÀÎ ¼ø¼­ : ¹®ÀÚ°ËÄ§ µî·Ï ÀüÈ­¹øÈ£ È®ÀÎ -> °ËÄ§´ë»ó ±âº» ÀüÈ­¹øÈ£ È®ÀÎ 
		Mem_Set( (byte*) szPhoneNum, 0x00, sizeof( szPhoneNum) );
		Mem_Set( (byte*) szPhoneNum1, 0x00, sizeof( szPhoneNum1) );
		Mem_Set( (byte*) szPhoneNum2, 0x00, sizeof( szPhoneNum2) );
		Mem_Set( (byte*) szPhoneNum3, 0x00, sizeof( szPhoneNum3) );
		
		Str_Cpy(szPhoneNum, stGm.SMS_CP_DDD);
		Str_Cat(szPhoneNum, stGm.SMS_CP_EXN);
		Str_Cat(szPhoneNum, stGm.SMS_CP_NUM);
		
		ret = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
		
		lTelNumFlag = 0;
		
		if(ret < 0)
		{
			Mem_Set( (byte*) szPhoneNum, 0x00, sizeof( szPhoneNum) );
			Mem_Set( (byte*) szPhoneNum1, 0x00, sizeof( szPhoneNum1) );
			Mem_Set( (byte*) szPhoneNum2, 0x00, sizeof( szPhoneNum2) );
			Mem_Set( (byte*) szPhoneNum3, 0x00, sizeof( szPhoneNum3) );
			
			Str_Cpy(szPhoneNum, stGm.CP_DDD);
			Str_Cat(szPhoneNum, stGm.CP_EXN);
			Str_Cat(szPhoneNum, stGm.CP_NUM);
			ret = Analy_Phone(szPhoneNum, szPhoneNum1, szPhoneNum2, szPhoneNum3 );
			
			lTelNumFlag = 1;
			if( ret < 0 )
			{
				MessageBoxEx (CONFIRM_OK, "ÀüÈ­¹øÈ£¸¦ µî·ÏÇØÁÖ¼¼¿ä.");
				return 0;
			}
		}

		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set( (byte*) szReqym, 0x00, sizeof( szReqym) );
		SPRINT( szTmp, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szTmp, 10, szReqym);
		
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set((byte*)szDeadlineFlag, 0x00, sizeof(szDeadlineFlag));	
		SPRINT( szTmp, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szTmp, 10, szDeadlineFlag);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25006, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "req_ym",              szReqym                );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",       szDeadlineFlag         );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        stGm.USE_CONT_NUM      );
		JSON_SetValue( g_pjcomm, 'C', "sms_num",             stGm.SMS_NUM           );
		JSON_SetValue( g_pjcomm, 'C', "send_seq",            stGm.SEND_SEQ          );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		//Àü¼Ûµ¥ÀÌÅÍ È®ÀÎ
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR25006; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		HTTP_DownloadData( szUrl, "FR25006_IN",  "FR25006" , sndbuf, szbuf );

		return 1;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR25006
	±â  ´É : TR25006 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR25006(void)
	{
		char szSql[250];
		char szTmp[100];
		long ntotcnt = 0, i = 0;

		if(g_Chk_Json(25006) >= 0)
		{
			Snd_Delete();

			ON_DRAW();
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			return -1;
		}
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : Snd_Delete
	±â  ´É : ¹®ÀÚ°ËÄ§ Ãë¼Ò / FR25005
	Param  : 
	Return :
	========================================================================================*/
	long Snd_Delete(void)
	{
		char szTmp[500];
		char szUrl[200];
		char szbuf[128];
		char szReqym[10];
		char szDeadlineFlag[10];
		char szSmsChgWhy[10];
		char* sndbuf;
		long i = 0;
		long ret = 0;
		long nLen = 0;
	
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set( (byte*) szReqym, 0x00, sizeof( szReqym) );
		SPRINT( szTmp, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szTmp, 10, szReqym);
		
		Mem_Set( (byte*) szTmp, 0x00, sizeof( szTmp) );
		Mem_Set((byte*)szDeadlineFlag, 0x00, sizeof(szDeadlineFlag));	
		SPRINT( szTmp, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szTmp, 10, szDeadlineFlag);
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25005, FALSE);

		JSON_SetValue( g_pjcomm, 'C', "req_ym",              szReqym               );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",       szDeadlineFlag        );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        stGm.USE_CONT_NUM     );
				
		sndbuf = JSON_toString(g_pjcomm);
		
		//Àü¼Ûµ¥ÀÌÅÍ È®ÀÎ
		g_Save_JsonFile(sndbuf);

		Mem_Set((byte*)szbuf, 0x00, sizeof(szbuf));	
		GET_FILENM(szbuf, SQLITE_DB);

		callBackfunc = TR25005; //Åë½Å¿Ï·á ÈÄ¿¡ È£Ãâ ÇÔ¼ö
		HTTP_DownloadData( szUrl, "FR25005_IN",  "FR25005" , sndbuf, szbuf );

		return 1;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR25005
	±â  ´É : TR25005 Callback
	Param  : 
	Return :
	========================================================================================*/
	long TR25005(void)
	{
		char szSql[250];
		char szTmp[100];
		long ntotcnt = 0, i = 0;

		if(g_Chk_Json(25005) >= 0 )
		{
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			SPRINT(szSql, "UPDATE REGUMDATA SET SMS_GMTR_MAN_YN = 'N' WHERE USE_CONT_NUM = '%s' ", stGm.USE_CONT_NUM, 0, 0);		
			g_Sql_DirectExecute(szSql);
			
			Str_Cpy(stGm.SMS_GMTR_MAN_YN, "N");

			//m_lSmsDelFlag = 0 default , = 1 ¹®ÀÚ´ë»ó -> ¾÷¹« Á¤»ó µî·Ï ½Ã »èÁ¦ , = 2 °ËÄ§Ãë¼Ò(»èÁ¦) ½Ã »èÁ¦
			if( m_lSmsDelFlag == 1 )
			{
				m_lSmsDelFlag = 0;
				
				if( Save_Gm() > 0 )
				{
					if( 10 == m_lUserData )
					{
						Str_Cpy(g_szMtr_Code, stGm.MTR_WORK_CODE);
					}
					
					g_nBackFlag++;
					
					if( g_nBackFlag > 99)
					{
						g_Db_Backup();
						g_nBackFlag = 0;
					}

					//stGm.INSP_YN -> Y : ½Ç»ç´ë»ó , stGm.INSP_YN -> N : ½Ç»ç´ë»ó ¾Æ´Ô.
					if( Str_Cmp(stGm.INSP_YN, "Y") == 0 && 
					   (Str_Cmp(stGm.MTR_WORK_CODE, "1") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "3") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "A") == 0 ||
					    Str_Cmp(stGm.MTR_WORK_CODE, "B") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "C") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "D") == 0 ||
					    Str_Cmp(stGm.MTR_WORK_CODE, "5") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "6") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "7") == 0 ) )
					{
						g_nActIndex++;
						g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
				
						if( g_nActIndex > m_ltotcnt || g_lindex < 0 )
						{
							if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
							{
								g_nActIndex = g_nActIndex-1;
							}
							g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
						}

						g_lDataflag = 0;
						
						Mem_Set( (byte*)stGm.SUBMONITOR_FLAG, 0x00, sizeof(stGm.SUBMONITOR_FLAG) );
						Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
						
						Mem_Set( (byte*)g_szIndi_MtrCode, 0x00, sizeof(g_szIndi_MtrCode) );
						Mem_Set( (byte*)g_szIndi_Qty, 0x00, sizeof(g_szIndi_Qty) );

						Card_Move("GM_SILSA");
					}
					else
					{
						Next_Gm();
					}
				}
				else
				{
					g_lDataflag = 1;
				}
				
				Set_Index();
			}
			else if( m_lSmsDelFlag == 2 )
			{
				m_lSmsDelFlag = 0;
				
				Del_Gm();
				SetData();
				SetStyle();
				REDRAW();

				//»èÁ¦µÈ Á¤º¸ ¹®ÀÚ°ËÄ§ ´ë»ó »óÅÂ ¼ö½Å
				Rcv_SmsSts();
			}

			ON_DRAW();
			return 1;
		}
		else
		{
			g_Sock_Close();
			CloseMessageBox();
			ON_DRAW();
			
			return -1;
		}
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : Rcv_Many
	±â  ´É : ¹®ÀÚ µ¿ÀÇ ¼¼´ë È®ÀÎ
	Param  : 
	Return :
	========================================================================================*/
	long Rcv_Many(void)
	{
		char sztmp[256];
		char szUrl[256];
		char szReqym[10];
		char szDeadlineFlag[10];
		char* sndbuf;
		long ret;

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
			
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25010, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        stGm.USE_CONT_NUM     );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25010;
		ret = HTTP_DownloadData(szUrl, "FR25010_IN",  "FR25010" , sndbuf, sztmp );
		
		return 1 ;
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : TR25010
	±â  ´É : FRTR25010 CALLBACK
	Param  : 
	Return :
	========================================================================================*/
	long TR25010(void)
	{
		long lRet = -1;
		
		if( g_Chk_Json(25010) >= 0)
		{
			lRet = GmSms_Sts(25010);
			Rcv_SmsSts();
			ON_DRAW();
			return lRet;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return lRet;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Rcv_SmsSts
	±â  ´É : ¹®ÀÚ °ËÄ§ µ¥ÀÌÅÍ SELECT
	Param  : 
	Return :
	========================================================================================*/
	long Rcv_SmsSts(void)
	{
		char sztmp[256];
		char szUrl[256];
		char szReqym[10];
		char szDeadlineFlag[10];
		char* sndbuf;
		long ret;
		
		if( m_lSmsStsFlag == 3 )
		{
			if( Str_Cmp(stGm.MULTI_USE_CONT_YN, "Y") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "ÇØ´ç ¼¼´ë´Â º¹¼ö°è¾à ¼¼´ë ÀÔ´Ï´Ù.\nº¹¼ö°è¾à ¼¼´ë´Â ¹®ÀÚ°ËÄ§À» ÇÒ ¼ö ¾ø½À´Ï´Ù.");
				return 1;
			}
			else if( Str_Cmp(stGm.SMS_SEND_AGREE_YN, "N") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "¹®ÀÚ°ËÄ§ µ¿ÀÇ ¼¼´ë°¡ ¾Æ´Õ´Ï´Ù.");
				return 1;
			}
			else if( Str_Cmp(stGm.CONT_STS_CD, "N") == 0 )
			{
				MessageBoxEx (CONFIRM_OK, "»ç¿ë°è¾à»óÅÂ°¡ Á¤»óÀÌ ¾Æ´Õ´Ï´Ù.");
				return 1;
			}
		}

		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szReqym, 0x00, sizeof( szReqym) );
		SPRINT( sztmp, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(sztmp, 10, szReqym);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set((byte*)szDeadlineFlag, 0x00, sizeof(szDeadlineFlag));	
		SPRINT( sztmp, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(sztmp, 10, szDeadlineFlag);

		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
				
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25008, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "req_ym",              szReqym               );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",       szDeadlineFlag        );
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num",        stGm.USE_CONT_NUM     );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25008;
		ret = HTTP_DownloadData(szUrl, "FR25008_IN",  "FR25008" , sndbuf, sztmp );
		
		return 1 ;
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : TR25008
	±â  ´É : FR25008 CALLBACK
	Param  : 
	Return :
	========================================================================================*/
	long TR25008(void)
	{
		long lRet = -1;
		
		if( g_Chk_Json(25008) >= 0)
		{
			lRet = GmSms_Sts(25008);
			ON_DRAW();
			return lRet;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return lRet;
		}
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : GmSms_Sts
	±â  ´É : ¹®ÀÚ°ËÄ§ ±¸Á¶Ã¼ SETTING
	Param  : 
	Return :
	========================================================================================*/
	long GmSms_Sts(long nservicenum)
	{
		char szJsonpath[500];
		char szMsg[500];
		char szCol[128];
		char szTmp[100];
		long *nCol;
		long nCnt = 0;
		long fd, i;
		long chkmsg = 0;
		long chkcode = 0;
		long fsize = 0;
		long lServerDtm = 0 , lReceiveDtm = 0 , lRet = 0;
		char *pStr;
		char *szcode;
		char *szmessage;
		char *szitem;
		char *szSmsSts;
		char *szSmsdesc;
		char *szServerDtm;
		char *szPlanDtm;
		char *szAgreeYn;
		char *szContCd;
		long *nSmsnum;
		long *nSendSeq;
		char *szSendType;
		char *szGmtrSendFlag;
		char szType[2] = {0,0};
		long ret = 11;
		handle hitem = NULL;
		handle hcnt = NULL;
		
		Mem_Set( (byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT( szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, nservicenum, 0 );
		
		if( FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set( (byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT( szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, nservicenum, 0 );
		}
		
		fsize = FFS_GetSize(szJsonpath);
		
		if(fsize <= 15)
		{
			ret = -1;
			goto Finally;
		}
		
		pStr = Mem_Alloc(fsize);
		
		fd = FFS_Open( szJsonpath, FS_READ_MODE, FS_NORMAL_FLAG );
		
		if(fd == -1)
		{
			ret = -1;
			goto Finally;
		}

		FFS_Read(fd, (byte*)pStr, fsize);
		
		for( i = 0 ; i < fsize-9 ; i++ )
		{
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"code\"", 6) == 0  )
			{
				chkcode++;
			}
			
			if( Mem_Cmp((byte*)pStr+i,(byte*) "\"message\"", 9) == 0  )
			{
				chkmsg++;
			}
			
			if(chkmsg > 0 &&  chkcode > 0)
			{
				break;
			}
		}

		FFS_Close(fd);
		
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

		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
			
				MessageBoxEx (WARNING_OK, szJsonpath);
				ON_DRAW();
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "item", szType);
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
							
							if( ret > 0 )
							{
								/***************************************************/
								/* FR25008 / ¹®ÀÚ°ËÄ§ ´ë»ó »óÅÂ ¹× Á¤º¸ ¼ö½Å       */
								/***************************************************/
								if( nservicenum == 25008 )
								{
									//¹®ÀÚ°ËÄ§ ´ë»ó »óÅÂ ¹× Á¤º¸ ¼ö½Å
									//¼ö½Å¹®ÀÚ³»¿ë
									Mem_Set((byte*) stGm.RCV_SMS_DESC, 0x00, sizeof( stGm.RCV_SMS_DESC) );
									szSmsdesc = (char*)JSON_GetArrayItem ( hitem, 0, "rcv_sms_desc", szType);
									SQL_ConvMbStr(stGm.RCV_SMS_DESC, szSmsdesc);
	
									//¹®ÀÚ°ËÄ§¹ß¼ÛÁøÇà»óÅÂ
									Mem_Set((byte*) stGm.GMTR_SEND_STS, 0x00, sizeof( stGm.GMTR_SEND_STS) );
									szSmsSts = (char*)JSON_GetArrayItem ( hitem, 0, "gmtr_send_sts", szType);
									Str_Cpy(stGm.GMTR_SEND_STS, szSmsSts);
									Str_Chg(stGm.GMTR_SEND_STS, STRCHG_DEL_NONDIGIT);
	
									//SMS_NUM
									Mem_Set((byte*) stGm.SMS_NUM, 0x00, sizeof( stGm.SMS_NUM) );
									nSmsnum = (long*)JSON_GetArrayItem ( hitem, 0, "sms_num", szType);
									nCnt = *nSmsnum;
									Str_ItoA(nCnt, stGm.SMS_NUM, 10);
	
									//¼­¹ö½Ã°£
									Mem_Set((byte*) stGm.SERVER_DTM, 0x00, sizeof( stGm.SERVER_DTM) );
									szServerDtm = (char*)JSON_GetArrayItem ( hitem, 0, "server_dtm", szType);
									Str_Cpy(stGm.SERVER_DTM, szServerDtm);
	
									//¿¹¾à½Ã°£
									Mem_Set((byte*) stGm.PLAN_DTM, 0x00, sizeof( stGm.PLAN_DTM) );
									szPlanDtm = (char*)JSON_GetArrayItem ( hitem, 0, "plan_dtm", szType);
									Str_Cpy(stGm.PLAN_DTM, szPlanDtm);
									
									//¹®ÀÚ°ËÄ§ È¸½Å°ËÁõÄÚµå
									Mem_Set((byte*) stGm.RCV_STS_VERIFY_CD, 0x00, sizeof( stGm.RCV_STS_VERIFY_CD) );
									szSmsSts = (char*)JSON_GetArrayItem ( hitem, 0, "rcv_sts_verify_cd", szType);
									Str_Cpy(stGm.RCV_STS_VERIFY_CD, szSmsSts);
									
									//stGm.SEND_SEQ
									Mem_Set((byte*) stGm.SEND_SEQ, 0x00, sizeof( stGm.SEND_SEQ) );
									nSendSeq = (long*)JSON_GetArrayItem ( hitem, 0, "send_seq", szType);
									nCnt = *nSendSeq;
									Str_ItoA(nCnt, stGm.SEND_SEQ, 10);
									
									//stGm.SEND_TYPE
									Mem_Set((byte*) stGm.SEND_TYPE, 0x00, sizeof( stGm.SEND_TYPE) );
									szSendType = (char*)JSON_GetArrayItem ( hitem, 0, "send_type", szType);
									Str_Cpy(stGm.SEND_TYPE, szSendType);	
									
									Mem_Set((byte*) stGm.GMTR_SEND_FLAG, 0x00, sizeof( stGm.GMTR_SEND_FLAG) );
									szGmtrSendFlag = (char*)JSON_GetArrayItem ( hitem, 0, "gmtr_send_flag", szType);
									Str_Cpy(stGm.GMTR_SEND_FLAG, szGmtrSendFlag);	
								}
								/***************************************************/
								/* 25010 / º¹¼ö, µ¿ÀÇ, »ç¿ë°è¾à»óÅÂ È®ÀÎ           */
								/***************************************************/
								else if( nservicenum == 25010 )
								{
									//º¹¼ö¼¼´ë ¿©ºÎ
									Mem_Set((byte*) stGm.MULTI_USE_CONT_YN, 0x00, sizeof( stGm.MULTI_USE_CONT_YN) );
									szServerDtm = (char*)JSON_GetArrayItem ( hitem, 0, "multi_use_cont_yn", szType);
									Str_Cpy(stGm.MULTI_USE_CONT_YN, szServerDtm);
									
									//¹®ÀÚ°ËÄ§ µ¿ÀÇ ¿©ºÎ
									Mem_Set((byte*) stGm.SMS_SEND_AGREE_YN, 0x00, sizeof( stGm.SMS_SEND_AGREE_YN) );
									szAgreeYn = (char*)JSON_GetArrayItem ( hitem, 0, "sms_send_agree_yn", szType);
									Str_Cpy(stGm.SMS_SEND_AGREE_YN, szAgreeYn);
									
									//»ç¿ë°è¾à»óÅÂ
									Mem_Set((byte*) stGm.CONT_STS_CD, 0x00, sizeof( stGm.CONT_STS_CD) );
									szContCd = (char*)JSON_GetArrayItem ( hitem, 0, "cont_sts_cd", szType);
									Str_Cpy(stGm.CONT_STS_CD, szContCd);
								}
							}
							
							JSON_Finalize(hitem);
							hitem = NULL;
							
							if( nservicenum == 25010 )
							{
								goto Finally2;
							}
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

		//m_lSmsStsFlag = 0 ¹®ÀÚ°ËÄ§ ´ë»ó »óÅÂ Ç¥½Ã
		if( m_lSmsStsFlag == 0 )
		{
			//¹®ÀÚ»óÅÂ ¹öÆ°
			i = 0;
			i = SearchCD( stGm.GMTR_SEND_STS, GM_SEND_STS );
			
			if (i == -1 || Str_Cmp(stGm.GMTR_SEND_STS, "90") == 0)
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), FALSE);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS_STS), BTNMENUFRCOLOR);
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SMS_STS), "");

				ret = 1;
				goto Finally2;
			}
			else
			{
				DlgCtrl_SetVisible(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), TRUE);
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS_STS), RED);

				Mem_Set((byte*) szTmp, 0x00, sizeof(szTmp) );
				
				if( Str_Cmp(stGm.SEND_TYPE, "30") == 0 )
				{
					Str_Cpy(szTmp, "»çÀü");
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS_STS), YELLOW);
				}
				else
				{
					Str_Cpy(szTmp, "»çÈÄ");
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS_STS), BTNCTRLBKCOLOR);
				}
				
				if( Str_Cmp(stGm.GMTR_SEND_STS , "10") == 0 )
				{
					Str_Cat(szTmp, "´ë»ó");
				}
				else if( Str_Cmp(stGm.GMTR_SEND_STS , "20") == 0 || Str_Cmp(stGm.GMTR_SEND_STS , "30") == 0 || Str_Cmp(stGm.GMTR_SEND_STS , "40") == 0 )
				{
					Str_Cat(szTmp, "¹ß¼Û");
				}
				else if( Str_Cmp(stGm.GMTR_SEND_STS , "60") == 0 || Str_Cmp(stGm.GMTR_SEND_STS , "70") == 0 || Str_Cmp(stGm.GMTR_SEND_STS , "80") == 0 )
				{
					Str_Cat(szTmp, "È¸½Å");
					ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_SMS_STS), RED);
					ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_SMS_STS), BTNMENUFRCOLOR);
				}
				else
				{
					Str_Cat(szTmp, GM_SEND_STS[i].Str);
				}
				
				ButCtrl_SetText(Get_hDlgCtrlByID(BID_SMS_STS), szTmp);
				
			}

			if( Str_Cmp(stGm.GMTR_SEND_STS, "60") == 0 ||
			    Str_Cmp(stGm.GMTR_SEND_STS, "70") == 0 ||
			    Str_Cmp(stGm.GMTR_SEND_STS, "80") == 0 )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), TRUE );

				if( Str_Cmp(stGm.INDI_SET_VC, "") == 0 && ( Str_Cmp(stGm.MTR_WORK_CODE,"2") != 0 && Str_Cmp(stGm.MTR_WORK_CODE,"C") != 0 ) )
				{
					if( Str_Cmp(stGm.GMTR_SEND_STS, "80") == 0)
					{
						// VC
						EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VC), stGm.RCV_SMS_DESC );
						
						//»ç¿ë·®
						Cal_UseQty( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)) );
						
						if( m_lUserData == 10 )
						{	
							EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), m_szIndiQty);
						}
						else
						{
							EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), m_szIndiQty);
						}
					}
				}	
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SMS_STS), FALSE );
			}
			
			//¹®ÀÚ ´ë»óÀÇ °æ¿ì -> ÄÚµå°ª ¼³Á¤ : "L:¹®ÀÚ¹ß¼Û" ±âº» ¼ÂÆÃ
			if( Str_Cmp(stGm.GMTR_SEND_STS, "") != 0 && Str_Cmp(stGm.GMTR_SEND_STS, "null") != 0 )
			{
				i = SearchCD( stGm.MTR_WORK_CODE, RE_GM_CODE );
	
				if (i == -1)
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[0].Str);
					
					// »çÀüÈ¸½ÅÀÎ °æ¿ì
					if( Str_Cmp(stGm.GMTR_SEND_STS, "60") == 0 ||
					    Str_Cmp(stGm.GMTR_SEND_STS, "70") == 0 ||
					    Str_Cmp(stGm.GMTR_SEND_STS, "80") == 0 )
					{
						if( Str_Cmp(stGm.INDI_SET_VC, "") == 0 && ( Str_Cmp(stGm.MTR_WORK_CODE,"2") != 0 && Str_Cmp(stGm.MTR_WORK_CODE,"C") != 0 ) && Str_Cmp(stGm.SEND_TYPE, "30") == 0  )
						{
							if( Str_Cmp(stGm.GMTR_SEND_STS, "80") == 0)
							{
								EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_RESULT), "»çÀüÈ¸½Å" );
							}
						}	
					}
				}
				else
				{
					EditCtrl_SetStr(Get_hDlgCtrlByID(CMB_RESULT), RE_GM_CODE[i].Str);
				}
			}

			//ºÎÀç , ¾øÀ½, ¹®ÀÚ°ËÄ§
			if( ( Str_Cmp(stGm.MTR_WORK_CODE,"2") == 0 || Str_Cmp(stGm.MTR_WORK_CODE,"C") == 0 || Str_Cmp(stGm.MTR_WORK_CODE,"L") == 0 ) )
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
			}
			else
			{
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), TRUE );
				DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), TRUE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VA), FALSE );
				DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VM), FALSE );
				ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_MESSAGE), BTNMENUFRCOLOR);
				
				Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC) );
				m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
			}
		}
		else if( m_lSmsStsFlag == 1 || m_lSmsStsFlag == 2 )
		{
			if( Str_Cmp(stGm.GMTR_SEND_STS, "30") == 0 )
			{
				//¿¹¾àÃë¼Ò
				if( nservicenum == 25008 )
				{
					lRet = 0;
					Mem_Set((byte*) szTmp, 0x00, sizeof( szTmp) );
					Str_Sub(stGm.PLAN_DTM, stGm.SERVER_DTM, szTmp);
					lRet = Str_AtoI(szTmp);
					
					if( lRet > 1000 )
					{
						//m_lSmsStsFlag = 1 ¹®ÀÚ´ë»ó -> ¾÷¹« Á¤»ó µî·Ï ½Ã »óÅÂ , = 2 °ËÄ§Ãë¼Ò(»èÁ¦) ½Ã »óÅÂ
						//m_lSmsDelFlag = 0 default , = 1 ¹®ÀÚ´ë»ó -> ¾÷¹« Á¤»ó µî·Ï ½Ã »èÁ¦ , = 2 °ËÄ§Ãë¼Ò(»èÁ¦) ½Ã »èÁ¦
						if( m_lSmsStsFlag == 1 )
						{
							m_lSmsDelFlag = 1;
						}
						else if( m_lSmsStsFlag == 2 )
						{
							m_lSmsDelFlag = 2;
						}
						
						//¹®ÀÚ°ËÄ§ ´ë»ó ¿¹¾à Ãë¼Ò ÈÄ »èÁ¦
						m_lSmsStsFlag = 0;
						Snd_Reserve_Cancel();
						ret = 1;
					}
					else if( lRet >= 0 && lRet < 1000 )
					{
						m_lSmsStsFlag = 0;
						Mem_Set((byte*) szTmp, 0x00, sizeof( szTmp) );
						Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
						g_Str_DateType(szCol, stGm.PLAN_DTM);
						SPRINT(szTmp, "¹®ÀÚ¹ß¼Û ¿¹¾à½Ã°£ 10ºÐ Àü¿¡´Â Ãë¼Ò°¡ ºÒ°¡´ÉÇÕ´Ï´Ù.\n[¿¹¾àÀÏÀÚ:%s]", szCol,0,0);
						MessageBoxEx (CONFIRM_OK, szTmp);
						ret = 0;
						goto Finally2;
					}
					else
					{
						//»óÅÂ°¡ ¿¹¾àÀÎµ¥ ¿¹¾à½Ã°£ÀÌ Áö³­ °æ¿ì
						//1.Ãë¼Ò : ¸Þ¼¼Áö Ãâ·Â(¹®ÀÚ¹ß¼Û ¿¹¾à½Ã°£À» È®ÀÎÇØÁÖ¼¼¿ä.\n[¿¹¾àÀÏÀÚ:%s])
						//2.Á¤»ó ÀúÀå : ÀÏ¹Ý Á¡°Ë ÀúÀå ·ÎÁ÷ ½ÇÇà.
						//3.Á¤»ó ÀúÀå -> Ãë¼Ò : ÀÏ¹Ý Á¡°Ë ÀúÀå ·ÎÁ÷ ½ÇÇà.(´Ü, ¹®ÀÚ »óÅÂ ¹× ¿¹¾à ½Ã°£ È®ÀÎ ÈÄ Ãë¼Ò·ÎÁ÷ Å¸¾ßÇÔ. ½Ã°£È®ÀÎ ÇÊ¿ä)
						if( m_lSmsStsFlag == 1 )
						{
							//À§ÀÇ 2¹øÀÇ °æ¿ì
							if( Save_Gm() > 0 )
							{
								if( 10 == m_lUserData )
								{
									Str_Cpy(g_szMtr_Code, stGm.MTR_WORK_CODE);
								}
								
								g_nBackFlag++;
								
								if( g_nBackFlag > 99)
								{
									g_Db_Backup();
									g_nBackFlag = 0;
								}
			
								//stGm.INSP_YN -> Y : ½Ç»ç´ë»ó , stGm.INSP_YN -> N : ½Ç»ç´ë»ó ¾Æ´Ô.
								if( Str_Cmp(stGm.INSP_YN, "Y") == 0 && 
								(Str_Cmp(stGm.MTR_WORK_CODE, "1") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "3") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "A") == 0 ||
								 Str_Cmp(stGm.MTR_WORK_CODE, "B") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "C") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "D") == 0 ||
								 Str_Cmp(stGm.MTR_WORK_CODE, "5") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "6") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "7") == 0 ))
								{
									g_nActIndex++;
									g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
							
									if( g_nActIndex > m_ltotcnt || g_lindex < 0 )
									{
										if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
										{
											g_nActIndex = g_nActIndex-1;
										}
										g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
									}
									
									g_lDataflag = 0;
									Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
									Mem_Set( (byte*)g_szIndi_MtrCode, 0x00, sizeof(g_szIndi_MtrCode) );
									Mem_Set( (byte*)g_szIndi_Qty, 0x00, sizeof(g_szIndi_Qty) );
			
									Card_Move("GM_SILSA");
								}
								else
								{
									m_lLastSave = 1;
									Next_Gm();
								}
							}
							else
							{
								g_lDataflag = 1;
							}
							
							m_lSmsStsFlag = 0;
							ret = 1;
							goto Finally2;
						}
						else if( m_lSmsStsFlag == 2 )
						{
							//À§ÀÇ 1, 3¹øÀÇ °æ¿ì.
							Mem_Set((byte*) szTmp, 0x00, sizeof( szTmp) );
							Mem_Set((byte*) szCol, 0x00, sizeof( szCol) );
							g_Str_DateType(szCol, stGm.PLAN_DTM);
							SPRINT(szTmp, "¹®ÀÚ¹ß¼Û ¿¹¾à½Ã°£À» È®ÀÎÇØÁÖ¼¼¿ä.\n[¿¹¾àÀÏÀÚ:%s]", szCol,0,0);
							MessageBoxEx (CONFIRM_OK, szTmp);
							m_lSmsStsFlag = 0;
							ret = 0;
							goto Finally2;
						}
					}
				}
			}
			else if( Str_Cmp(stGm.GMTR_SEND_STS, "10") == 0 || Str_Cmp(stGm.GMTR_SEND_STS, "50") == 0 )
			{	
				//m_lSmsStsFlag = 1 ¹®ÀÚ´ë»ó -> ¾÷¹« Á¤»ó µî·Ï ½Ã »óÅÂ , = 2 °ËÄ§Ãë¼Ò(»èÁ¦) ½Ã »óÅÂ
				//m_lSmsDelFlag = 0 default , = 1 ¹®ÀÚ´ë»ó -> ¾÷¹« Á¤»ó µî·Ï ½Ã »èÁ¦ , = 2 °ËÄ§Ãë¼Ò(»èÁ¦) ½Ã »èÁ¦
				if( m_lSmsStsFlag == 1 )
				{
					m_lSmsDelFlag = 1;
				}
				else if( m_lSmsStsFlag == 2 )
				{
					m_lSmsDelFlag = 2;
				}
				
				m_lSmsStsFlag = 0;
				Snd_Delete();
				ret = 1;
				goto Finally2;
			}
			else
			{
				if( m_lSmsStsFlag == 1 )
				{
					m_lSmsStsFlag = 0;
					
					if( Save_Gm() > 0 )
					{
						if( 10 == m_lUserData )
						{
							Str_Cpy(g_szMtr_Code, stGm.MTR_WORK_CODE);
						}
						
						g_nBackFlag++;
						
						if( g_nBackFlag > 99)
						{
							g_Db_Backup();
							g_nBackFlag = 0;
						}
	
						//stGm.INSP_YN -> Y : ½Ç»ç´ë»ó , stGm.INSP_YN -> N : ½Ç»ç´ë»ó ¾Æ´Ô.
						if( Str_Cmp(stGm.INSP_YN, "Y") == 0 && 
						(Str_Cmp(stGm.MTR_WORK_CODE, "1") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "3") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "A") == 0 ||
						 Str_Cmp(stGm.MTR_WORK_CODE, "B") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "C") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "D") == 0 ||
						 Str_Cmp(stGm.MTR_WORK_CODE, "5") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "6") == 0 || Str_Cmp(stGm.MTR_WORK_CODE, "7") == 0 ))
						{
							g_nActIndex++;
							g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
					
							if( g_nActIndex > m_ltotcnt || g_lindex < 0 )
							{
								if( g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex) < g_nActIndex )
								{
									g_nActIndex = g_nActIndex-1;
								}
								g_lindex = g_SREACHFILE_GetSeq(SREACH_FILE, g_nActIndex);
							}
							
							g_lDataflag = 0;
							Str_Cpy(stGm.SUBMONITOR_FLAG, "0");
							Mem_Set( (byte*)g_szIndi_MtrCode, 0x00, sizeof(g_szIndi_MtrCode) );
							Mem_Set( (byte*)g_szIndi_Qty, 0x00, sizeof(g_szIndi_Qty) );
	
							Card_Move("GM_SILSA");
						}
						else
						{
							m_lLastSave = 1;
							Next_Gm();
						}
					}
					else
					{
						g_lDataflag = 1;
					}
					
					Set_Index();
					ret = 1;
					goto Finally2;
				}
				else if( m_lSmsStsFlag == 2 )
				{
					m_lSmsStsFlag = 0;

					if( Str_Cmp(stGm.GMTR_SEND_STS, "") == 0 || Str_Cmp(stGm.GMTR_SEND_STS, "null") == 0 || Str_Cmp(stGm.GMTR_SEND_STS, "NULL") == 0 )
					{	
						Del_Gm();
						SetData();
						SetStyle();
						REDRAW();
						
						ret = 1;
						goto Finally2;
					}
					else
					{
						//À§ÀÇ »óÅÂ°ªÀ» Á¦¿ÜÇÑ »óÅÂ °ªÀÎ °æ¿ì Ãë¼Ò ºÒ°¡.
						MessageBoxEx (CONFIRM_OK, "Ãë¼Ò ÇÒ ¼ö ¾ø´Â ¹®ÀÚ°ËÄ§ ´ë»óÀÔ´Ï´Ù.");
						ret = -1;

						//»èÁ¦µÈ Á¤º¸ ¹®ÀÚ°ËÄ§ ´ë»ó »óÅÂ ¼ö½Å
						Rcv_SmsSts();
						//Rcv_Many();
					}
				}
			}
		}
		else if( m_lSmsStsFlag == 3 )
		{
			//m_lSmsStsFlag = 3 ¹®ÀÚ´ë»ó µî·Ï½Ã »óÅÂ
			m_lSmsStsFlag = 0;
			//m_lSmsAgreeFlag = 0;

			if( nservicenum == 25008 )
			{
				if( Str_Cmp(stGm.GMTR_SEND_STS, "90") == 0 || Str_Cmp(stGm.GMTR_SEND_STS, "") == 0 || 
			        Str_Cmp(stGm.GMTR_SEND_STS, "null") == 0 || Str_Cmp(stGm.GMTR_SEND_STS, "NULL") == 0 )
				{
					Snd_Sms_New();
					
					ret = 1;
					goto Finally2;
				}
				else
				{
					if( Str_Cmp(stGm.SEND_TYPE, "30") == 0 )
					{
						Snd_Sms_New();
						ret = 1;
						goto Finally2;
					}
					else
					{
						MessageBoxEx (CONFIRM_OK, "ÀÌ¹Ì ¹®ÀÚ°ËÄ§´ë»óÀÔ´Ï´Ù.");
						ret = 1;
						goto Finally2;
					}
				}
			}
		}
		
Finally2 :
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}

		g_Close_SubDlg();
		EvtDraw();
		
		return ret;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : safe_chkdata
	±â  ´É : °ËÄ§ -> Á¡°ËÀ¸·Î °¥¶§ CHK
	Param  : 
	Return :
	========================================================================================*/
	long safe_chkdata(void)
	{
		char sztmp[200];
		char szSql[1000];
		char szbuf[10];
		
		Read_RcvLog();
		
		if( Str_Len(m_szRcvDay) != 8 )
		{
			return -1;
		}
		
		if( Str_AtoI(m_szRcvDay) != Time_GetDate() )
		{
			//Á¡°Ë¼Û½ÅÄ«¿îÆ® Àç¼ö½Å ¸Þ¼¼Áö Ã³¸®...>
			Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
			Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
			SPRINT( szSql ,"SELECT SUM(C.CNT) AS CNT \
			                  FROM ( SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_INFO  WHERE SEND_YN = 'S' \
									  UNION ALL SELECT COUNT(SEND_YN) AS CNT  FROM NORMAL_NOGOOD  WHERE SEND_YN = 'S' \
									  UNION ALL SELECT COUNT(SEND_YN) AS CNT  FROM NORMAL_NOGOOD_CHA  WHERE SEND_YN = 'S' \
									  UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_NOGOOD_DETAL  WHERE SEND_YN = 'S' \
									  UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_VISIT  WHERE SEND_YN = 'S' \
									  UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_BUR  WHERE SEND_YN = 'S' \
									  UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_MTR  WHERE SEND_YN = 'S' and  length(UPD_EMPID) > 0 \
									  UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_DATA  WHERE SEND_YN = 'S' \
									  UNION ALL SELECT COUNT(SEND_YN) AS CNT FROM NORMAL_STANDPIPE_CHK_RSLT WHERE SEND_YN = 'S' ) C "
            , 0, 0, 0 );

			g_Sql_RetStr(szSql, 4, sztmp );
			
			if(Str_AtoI(sztmp) > 0) 
			{
				MessageBoxEx(CONFIRM_OK, "Á¡°ËÀÚ·á°¡ ±ÝÀÏÀÚ·á°¡ ¾Æ´Õ´Ï´Ù.\n¹ÌÀü¼Û µ¥ÀÌÅÍ Àü¼ÛÈÄ\nÀÚ·á¸¦ ¼ö½ÅÇÏ¼¼¿ä!");
				return 0;
			}
			else
			{
				MessageBoxEx(CONFIRM_OK, "Á¡°ËÀÚ·á°¡ ±ÝÀÏÀÚ·á°¡ ¾Æ´Õ´Ï´Ù.\nÁ¡°ËÀÚ·á ¼ö½ÅÀ» ½ÃÀÛ ÇÕ´Ï´Ù.");

				g_Sql_DirectExecute("DELETE FROM NORMAL_ADDR");
				g_Sql_DirectExecute("DELETE FROM NORMAL_BUR");
				g_Sql_DirectExecute("DELETE FROM NORMAL_DATA");
				g_Sql_DirectExecute("DELETE FROM NORMAL_GROUP");
				g_Sql_DirectExecute("DELETE FROM NORMAL_INFO");
				g_Sql_DirectExecute("DELETE FROM NORMAL_MTR");
				g_Sql_DirectExecute("DELETE FROM NORMAL_NOGOOD");
				g_Sql_DirectExecute("DELETE FROM NORMAL_NOGOOD_CHA");
				g_Sql_DirectExecute("DELETE FROM NORMAL_NOGOOD_DETAL");
				g_Sql_DirectExecute("DELETE FROM NORMAL_PIPE_CHK_DATA");
				g_Sql_DirectExecute("DELETE FROM NORMAL_PREV_NO");
				g_Sql_DirectExecute("DELETE FROM NORMAL_VISIT");
				g_Sql_DirectExecute("DELETE FROM CUST_PATT_COLL_INFO");	
				g_Sql_DirectExecute("DELETE FROM NORMAL_STANDPIPE_CHK_RSLT");	

				RCV311324();
				ON_DRAW();
				return 1;
			}
		}
		
		return -1;
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : Read_RcvLog
	±â  ´É : °ËÄ§ -> Á¡°ËÀ¸·Î °¥¶§ ÀúÀåµÇ¾îÀÖ´Â Á¡°ËÀÏÀÚ °¡Á®¿È
	Param  : 
	Return :
	========================================================================================*/
	long Read_RcvLog(void)
	{
		long i;
		long ret= 0;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();

		Mem_Set( (byte*) m_szchktype, 0x00, sizeof( m_szchktype) );
		Mem_Set( (byte*) m_szobjym, 0x00, sizeof( m_szobjym) );
		Mem_Set( (byte*) m_szchkyear, 0x00, sizeof( m_szchkyear) );
		Mem_Set( (byte*) m_szchkorder, 0x00, sizeof( m_szchkorder) );
		Mem_Set( (byte*) m_szzone_manage_num, 0x00, sizeof( m_szzone_manage_num) );
		Mem_Set( (byte*) m_szRcvDay, 0x00, sizeof( m_szRcvDay) );

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql,"SELECT PARAM1, PARAM2, PARAM3, PARAM4, PARAM6, PARAM7 FROM RCV_LOG WHERE GUBUN = '2' ");
		
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}

		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
		
		if(sql->Next(sql) == TRUE)
		{	
			i = 0;
			sql->GetValue( sql, i++, 'U', (long*) m_szchkyear			, 4 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szchkorder			, 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szobjym				, 6 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szchktype			, 2 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szzone_manage_num	, 5 + 1, DECRYPT );
			sql->GetValue( sql, i++, 'U', (long*) m_szRcvDay	        , 8 + 1, DECRYPT );
			
			ret++;
		}
		
Finally:
		DelSqLite(sql);
		return ret;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Rcv_self_select / FR25011
	±â  ´É : ÀÚ°¡°ËÄ§ ÁöÄ§ SELECT
	Param  : 
	Return :
	========================================================================================*/
	long Rcv_self_select(void)
	{
		char sztmp[256];
		char szUrl[256];
		char szReqym[10];
		char szDeadlineFlag[10];
		char* sndbuf;
		long ret;
		
		if( Str_Cmp( stGm.SEND_YN, "" ) != 0 && Str_Cmp( stGm.SEND_YN, "N" ) != 0 )
		{
			return 1;
		}
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szReqym, 0x00, sizeof( szReqym) );
		SPRINT( sztmp, "SELECT PARAM1 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(sztmp, 10, szReqym);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set((byte*)szDeadlineFlag, 0x00, sizeof(szDeadlineFlag));	
		SPRINT( sztmp, "SELECT PARAM2 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(sztmp, 10, szDeadlineFlag);
	
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}		
		
		g_pjcomm = g_CreateJsonHead(g_pjcomm, szUrl, 25011, FALSE);
		
		JSON_SetValue( g_pjcomm, 'C', "req_ym",              szReqym               );
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag",       szDeadlineFlag        );
		JSON_SetValue( g_pjcomm, 'C', "mtr_num",             stGm.MTR_NUM     );
		
		sndbuf = JSON_toString(g_pjcomm);
		
		g_Save_JsonFile(sndbuf);
		
		Mem_Set((byte*)sztmp, 0x00, sizeof(sztmp));	
		GET_FILENM(sztmp, SQLITE_DB);
		
		callBackfunc = TR25011;
		ret = HTTP_DownloadData(szUrl, "FR25011_IN",  "FR25011" , sndbuf, sztmp );
		return 1 ;
	}

	/*=======================================================================================
	ÇÔ¼ö¸í : TR25011
	±â  ´É : FR25011 CALLBACK
	Param  : 
	Return :
	========================================================================================*/
	long TR25011(void)
	{
		if( g_Chk_Json(25011) >= 0)
		{
			SelfSelect();		
			ON_DRAW();
			return 1;	
		}
		else
		{
			g_Sock_Close();
			ON_DRAW();
			return 1;
		}
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : SelfSelect
	±â  ´É : FR25011 DATA SETTING
	Param  : 
	Return :
	========================================================================================*/
	long SelfSelect(void)
	{
		char szJsonpath[500]; 
		char szMsg[500];
		char szTmp[100];
		long nCnt = 0;
		long fd, i;
		long chkmsg = 0;
		long chkcode = 0;
		long fsize = 0;
		char *pStr;
		char *szcode;
		char *szmessage;
		char *szitem;
		long *szSelfIndiVc;
		char szType[2] = {0,0};
		long ret = 11;
		handle hitem = NULL;
		handle hcnt = NULL;
		
		Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
		SPRINT(szJsonpath, "%sFR%d_Res.JSON",  SYSTEM_COMM, 25011, 0 );
		
		if(FFS_Exist(szJsonpath) != TRUE )
		{
			Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
			SPRINT(szJsonpath, "%sFR%d.JSON",  SYSTEM_COMM, 25011, 0 );
		}
		
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

		FFS_Read(fd, (byte*)pStr, fsize);
		
		for(i = 0 ; i < fsize-9 ; i++ )
		{
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

		if( JSON_LoadFile(g_pjcomm, szJsonpath) > 0)
		{
			szcode    = JSON_GetValue (g_pjcomm, "code",    szType);
			szmessage = JSON_GetValue (g_pjcomm, "message", szType);

			if( Str_Cmp(szcode, "0000") != 0)
			{
				Mem_Set((byte*) szJsonpath, 0x00, sizeof( szJsonpath) );
				if(Str_Len(szmessage) < 500 )
					SQL_ConvMbStr( szMsg, szmessage);
				
				SPRINT(szJsonpath, "[%s] %s", szcode, szMsg, 0 );
			
				MessageBoxEx (WARNING_OK, szJsonpath);
				ON_DRAW();
				ret = -1;
			}
			else
			{
				ret = 0;
				szitem =JSON_GetValue(g_pjcomm, "item", szType);
				if(szitem != NULL)
				{
					if( Str_Len(szitem) > 0 )
					{
						hitem = JSON_Create( JSON_Array );
						if( hitem != NULL)
						{
							JSON_toJson(hitem, szitem ) ;
							ret = JSON_GetArrayCount( hitem );
							
							if( ret > 0 )
							{
								szSelfIndiVc = (long*)JSON_GetArrayItem ( hitem, 0, "indi_compens_this_mm_vc", szType);
								nCnt = *szSelfIndiVc;
								Mem_Set((byte*)szTmp, 0x00, sizeof(szTmp));
								Str_ItoA(nCnt, szTmp, 10);
								
								// VC
								EditCtrl_SetStr( Get_hDlgCtrlByID(EDT_VC), szTmp );
								
								//»ç¿ë·®
								Cal_UseQty( EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_VC)) );
								
								if( m_lUserData == 10 )
								{	
									EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_USEQTY), m_szIndiQty);
								}
								else
								{
									EditCtrl_SetStr(Get_hDlgCtrlByID(TXT_DATA13), m_szIndiQty);
								}
								
								//DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), FALSE );
								//DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_SAVE), TRUE );
								
								//DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), FALSE );
								//DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(BID_DELETE), TRUE );
								
								//DlgCtrl_SetEnable(this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), FALSE );
								//DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(EDT_VC), TRUE );
								
								//DlgCtrl_SetEnable( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), FALSE);
								//DlgCtrl_SetGray( this->m_hDlg, Get_iDlgCtrlByID(CMB_RESULT+1), TRUE );
								
								EditCtrl_SetStr( Get_hDlgCtrlByID(CMB_RESULT), "ÀÚ°¡°ËÄ§" );
								
								Mem_Set((byte*) m_szIndiVc, 0x00, sizeof( m_szIndiVc) );
								Str_Cpy( m_szIndiVc, szTmp );

								Dialog_SetActiveCtrl(this->m_hDlg, Get_iDlgCtrlByID(BID_NEXTPG) );
								m_lEditCtrlIndex = Dialog_GetActiveCtrlIndex(this->m_hDlg);
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
		if(g_pjcomm != NULL)
		{
			JSON_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}

		g_Close_SubDlg();
		EvtDraw();
		
		return ret;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : fn_Compens_Sign
	±â  ´É : º¸Á¤±â »èÁ¦ ¼­¸í µ¥ÀÌÅÍ SETTING
	Param  : 
	Return :
	========================================================================================*/
	void fn_Compens_Sign(void)
	{
		char szSql[300];
		char* pRst = NULL;
		char szTmp[300];
		char szYmd[20];
		char szTime[20];
		long idx;
		long lsign, lSign_Len;
		long cnt = 0;	
		
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/**************************/
		/* SIGN                   */
		/**************************/
		Mem_Set((byte*)g_SignBuf, 0xff, sizeof(g_SignBuf));
		lsign = GetSignImgTitleWithOpt( SIGN_WIDTH, SIGN_HEIGHT, (char*)g_SignBuf, "¼º¸í", SIGN_OPT_NONE );
		
		if( lsign == SIGN_RET_CANCEL || lsign == SIGN_RET_FAIL )
		{
			return;
		}
		else if( lsign == SIGN_RET_SUCCESS )
		{
			g_png_getbmp(SIGN_WIDTH, SIGN_HEIGHT, g_SignBuf );
			
			if(g_pjcomm != NULL )
			{
				BASE64_Finalize(g_pjcomm);
				g_pjcomm = NULL;
			}
			
			g_pjcomm = BASE64_Create();
			lSign_Len = BASE64_Encode(g_pjcomm, g_SignBuf, BMP_SIZE );
			pRst = BASE64_GetResult(g_pjcomm);				
		}
		
		/**************************/
		/* Data Setting           */
		/**************************/
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT COUNT(1) FROM GUM_COMPENS_REMOVE_REQ WHERE REQ_YM = %s AND DEADLINE_FLAG = %s AND MTR_NUM = %s", stGm.REQ_YM, stGm.DEADLINE_FLAG, stGm.MTR_NUM);
		g_Sql_RetInt( szSql , &cnt );

		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			goto Finally;
		}
		
		// INSERT
		if( cnt <= 0 )
		{	
			hstmt = sql->CreateStatement(sql, "INSERT INTO GUM_COMPENS_REMOVE_REQ \
										       ( REQ_YM, DEADLINE_FLAG, MTR_NUM, USE_CONT_NUM, SIGN ) \
										       VALUES \
										       ( ?, ?, ?, ?, ? )"
			);
			
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			idx = 0;
			
			sql->Bind(sql, idx++, 'U', (long *)stGm.REQ_YM				,6	+1, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stGm.DEADLINE_FLAG		,2  +1, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stGm.MTR_NUM				,9  +1, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stGm.USE_CONT_NUM		,10 +1, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)pRst			        	,Str_Len(pRst), DECRYPT);
		}
		// UPDATE
		else
		{
			hstmt = sql->CreateStatement(sql, "UPDATE GUM_COMPENS_REMOVE_REQ \
			                                      SET SIGN = ? \
			                                    WHERE REQ_YM = ? AND DEADLINE_FLAG = ? AND MTR_NUM = ? "
			);
			
			if( hstmt == NULL )
			{
				PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
				goto Finally;
			}
			
			idx = 0;
			
			sql->Bind(sql, idx++, 'U', (long *)pRst			        	,Str_Len(pRst), DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stGm.REQ_YM				,6	+1, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stGm.DEADLINE_FLAG		,2  +1, DECRYPT);
			sql->Bind(sql, idx++, 'U', (long *)stGm.MTR_NUM				,9  +1, DECRYPT);
		}
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			goto Finally;
		}
			
Finally:

		if(g_pjcomm != NULL )
		{
			BASE64_Finalize(g_pjcomm);
			g_pjcomm = NULL;
		}			
		
		DelSqLite(sql);
		
		cnt = 0;
		
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT LENGTH( SIGN ) FROM GUM_COMPENS_REMOVE_REQ WHERE REQ_YM = '%s' AND DEADLINE_FLAG = '%s' AND MTR_NUM = '%s'", stGm.REQ_YM, stGm.DEADLINE_FLAG, stGm.MTR_NUM);
		g_Sql_RetInt( szSql, &cnt );
		
		if( cnt < 100)
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_COMPENS_SIGN), BTNCTRLBKCOLOR);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_COMPENS_SIGN), BTNMENUFRCOLOR);
		}
		else
		{
			ButCtrl_SetBkColorEx(Get_hDlgCtrlByID(BID_COMPENS_SIGN), RED);
			ButCtrl_SetForeColorEx(Get_hDlgCtrlByID(BID_COMPENS_SIGN), BTNMENUFRCOLOR);
		}
		
		ON_DRAW();
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : fn_Compens_Save
	±â  ´É : º¸Á¤±â »èÁ¦ µ¥ÀÌÅÍ SETTING
	Param  : 
	Return :
	========================================================================================*/
	bool fn_Compens_Save(void)
	{
		char szSql[300];
		char szTmp[300];
		char szYmd[20];
		char szTime[20];
		char szConfNm[30];
		long idx = 0;
		long lLen = 0;
		bool ret = TRUE;
		handle hdb = NULL;
		handle hstmt = NULL;
		SQLITE sql = NewSqLite();
		
		/**************************/
		/* Validation             */
		/**************************/
		// 1. È®ÀÎÀÚ
		Mem_Set( (byte*)szConfNm, 0x00, sizeof(szConfNm) );
		Str_Cpy( szConfNm, EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_COMPENS_CONF_NM)) );
		
		if( Str_Cmp(szConfNm, "") == 0 )
		{
			MessageBoxEx (CONFIRM_OK, "È®ÀÎÀÚ¸¦ ÀÔ·ÂÇØÁÖ¼¼¿ä.");
			ret = FALSE;
			goto Finally;
		}
		
		// 2. ¼­¸í
		Mem_Set( (byte*)szSql, 0x00, sizeof(szSql) );
		SPRINT(szSql, "SELECT LENGTH( SIGN ) FROM GUM_COMPENS_REMOVE_REQ WHERE REQ_YM = %s AND DEADLINE_FLAG = %s AND MTR_NUM = %s", stGm.REQ_YM, stGm.DEADLINE_FLAG, stGm.MTR_NUM);
		g_Sql_RetInt( szSql, &lLen );
		if( lLen < 100 )
		{
			MessageBoxEx (CONFIRM_OK, "¼­¸íÀ» ÀÔ·ÂÇØÁÖ¼¼¿ä.");
			ret = FALSE;
			goto Finally;
		}
		
		/**************************/
		/* REMOVE_REQ_YMD         */
		/**************************/
		Mem_Set( (byte*)szYmd, 0x00, sizeof(szYmd));
		Str_ItoA(Time_GetDate(), szYmd, 10);
		
		/**************************/
		/* REMOVE_REQ_TIME        */
		/**************************/
		Mem_Set( (byte*)szTime, 0x00, sizeof(szTime));
		g_Str_TimeType( szTime, Time_GetTime());
		
		/**************************/
		/* DATA_UPDATE            */
		/**************************/
		hdb = sql->Open(sql);
		
		if( hdb == NULL )
		{
			ret = 0;
			goto Finally;
		}
		
		hstmt = sql->CreateStatement(sql, "UPDATE GUM_COMPENS_REMOVE_REQ \
		                                      SET REMOVE_REQ_YMD = ?, REMOVE_REQ_TIME = ?, REMOVE_REQ_EMPID = ?, CONF_NM = ?, SEND_YN = 'S' \
		                                    WHERE REQ_YM = ? AND DEADLINE_FLAG = ? AND MTR_NUM = ? "
		);
			
		if( hstmt == NULL )
		{
			PRINT("::SQL_CreateStatement fail [%s]", sql->GetLastError(sql), 0, 0);
			MessageBoxEx (CONFIRM_OK, "ÀúÀå¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
			ret = 0;
			goto Finally;
		}
			
		idx = 0;
		
		sql->Bind(sql, idx++, 'U', (long *)szYmd       		    	,8	+1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)szTime		        	,6  +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stUserinfo.szemployee_id	,9  +1, DECRYPT);	
		sql->Bind(sql, idx++, 'U', (long *)szConfNm					,30 +1, DECRYPT);
		
		sql->Bind(sql, idx++, 'U', (long *)stGm.REQ_YM				,6	+1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.DEADLINE_FLAG		,2  +1, DECRYPT);
		sql->Bind(sql, idx++, 'U', (long *)stGm.MTR_NUM				,9  +1, DECRYPT);
		
		if(sql->Execute(sql) == FALSE)
		{
			PRINT("::SQL_Execute fail [%s]", sql->GetLastError(sql), 0, 0);
			MessageBoxEx (CONFIRM_OK, "ÀúÀå¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
			ret = 0;
			goto Finally;
		}	
		
Finally:
		DelSqLite(sql);	
		
		return ret;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : Shoto_Photo_Compens
	±â  ´É : »çÁøÃÔ¿µ
	Param  : 
	Return : 
	========================================================================================*/
	void Shoto_Photo_Compens( void )
	{
		char *pCamera;
		char sztmp[100];
		char sztmp2[100];
		char szDate[100];
		long nRet;
		
		handle h = NULL;
		handle hdata = NULL;
		
		// C48(ÄÚµå) | M(°è·®±â¹øÈ£) | R(Ã»±¸³â¿ù) | D(³³±â)| T( Å¸ÀÔ : VC = 1, VA = 2, VM = 3 ) | D(»ý¼º³¯Â¥(SYSDATE : YYYYMMDDHHMMSS))
		Mem_Set( (byte*)m_szfilenm, 0x00, sizeof(m_szfilenm) );
		Str_Cpy( m_szfilenm, stGm.MTR_NUM );
		Str_Cat( m_szfilenm, "_" );
		Str_Cat( m_szfilenm, stGm.REQ_YM );
		Str_Cat( m_szfilenm, "_" );
		Str_Cat( m_szfilenm, stGm.DEADLINE_FLAG );
		Str_Cat( m_szfilenm, "_" );
		Str_Cat( m_szfilenm, m_szPhoto_CompensType );
		Str_Cat( m_szfilenm, ".jjp" );
		
		Mem_Set( (byte*)g_szphoto, 0x00, sizeof(g_szphoto) );
		SPRINT( g_szphoto, "%s/%s", PHOTO_GMCOMPENS, m_szfilenm, 0 );
		
		ShootPhoto( 1, 0, m_szfilenm );
		
		return;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : FR26002
	±â  ´É : »çÁø Àü¼Û
	Param  : 
	Return : 
	========================================================================================*/
	void FR26002( void )
	{
		char szUrl[200];
		char szbuf[200];
		char sztmp[200];
		char szSql[200];
		char szScrPht[200];
		char* sndbuf;
		char* szfile = NULL;
		
		long filesize = 0;
		long ret = 0;
		long i, idx, fd;
		
		byte* signimg = NULL;
		
		handle file;
			
		// SERVER CONNECTION
		Mem_Set( (byte*)szUrl, 0x00, sizeof(szUrl) );
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );
		
		if( g_pjcomm != NULL)
		{
			JSON_Finalize( g_pjcomm );
			g_pjcomm = NULL;
		}
		
		// Json Setting
		g_pjcomm = g_CreateJsonHead( g_pjcomm, szUrl, 26002, FALSE );
		
		JSON_SetValue( g_pjcomm, 'C', "center_cd"       , stUserinfo.szcenter_cd 	);
		JSON_SetValue( g_pjcomm, 'C', "use_cont_num"	, stGm.USE_CONT_NUM 		);
		JSON_SetValue( g_pjcomm, 'C', "inst_place_num"  , stGm.INST_PLACE_NUM		);
		JSON_SetValue( g_pjcomm, 'C', "mtr_num"   		, stGm.MTR_NUM 				);
		JSON_SetValue( g_pjcomm, 'C', "req_ym"   		, stGm.REQ_YM 				);
		JSON_SetValue( g_pjcomm, 'C', "deadline_flag"   , stGm.DEADLINE_FLAG 		);
		JSON_SetValue( g_pjcomm, 'C', "type"   			, m_szPhoto_CompensType  	);
		JSON_SetValue( g_pjcomm, 'C', "mtr_id_num"      , stGm.MTR_ID_NUM 			);
		
		Mem_Set( (byte*) sztmp, 0x00, sizeof( sztmp) );
		Mem_Set( (byte*) szSql, 0x00, sizeof( szSql) );
		SPRINT( szSql, "SELECT PARAM6 FROM RCV_LOG WHERE GUBUN = '10' ", 0, 0, 0 );
		g_Sql_RetStr(szSql, 5, sztmp);
		
		JSON_SetValue( g_pjcomm, 'C', "zone_manage_num" , sztmp );
		
		// FILE NAME
		Mem_Set( (byte*)sztmp, 0x00, sizeof(sztmp) );
		Str_Cpy( sztmp, stGm.MTR_NUM );
		Str_Cat( sztmp, "_" );
		Str_Cat( sztmp, stGm.REQ_YM );
		Str_Cat( sztmp, "_" );
		Str_Cat( sztmp, stGm.DEADLINE_FLAG );
		Str_Cat( sztmp, "_" );
		Str_Cat( sztmp, m_szPhoto_CompensType );
		Str_Cat( sztmp, ".jjp" );
		
		Mem_Set( (byte*)szScrPht, 0x00, sizeof(szScrPht) );
		SPRINT( szScrPht, "%s/%s", PHOTO_GMCOMPENS, sztmp, 0 );
		filesize = FFS_GetSize( szScrPht );
		
		if( filesize > 0 )
		{
			signimg = Mem_Alloc( filesize );
			
			fd = FFS_Open( szScrPht, FS_READ_MODE, FS_NORMAL_FLAG );
			FFS_Read ( fd, (byte*)signimg, filesize );
			FFS_Close( fd );
	
			file = BASE64_Create();
			BASE64_Encode( file, signimg, filesize );
			szfile = BASE64_GetResult( file );	
			JSON_SetValue( g_pjcomm, 'C', "photo_compens", szfile );
			free( (byte*)signimg );
			BASE64_Finalize( file );
			file = NULL;
		}
		
		sndbuf = JSON_toString( g_pjcomm );
		
		g_SeverConnection();
		
		Mem_Set( (byte*)szbuf, 0x00, sizeof(szbuf) );	
		GET_FILENM( szbuf, SQLITE_DB );
		
		callBackfunc = TR26002;
		ret = HTTP_DownloadData( szUrl, "FR26002_IN", "FR26002", sndbuf, szbuf );
		
		return;
	}
	
	/*=======================================================================================
	ÇÔ¼ö¸í : TR26002
	±â  ´É : FR26002 Callback
	Param  : 
	Return : 
	========================================================================================*/
	long TR26002( void )
	{
		char szTmp[300];
		
		g_Sock_Close();
		CloseMessageBox();
		
		if( g_Chk_Json(26002) >= 0 )
		{
			VmSleep( 100 );
			
			Mem_Set( (byte*)szTmp, 0x00, sizeof(szTmp) );
			
			if( Str_Cmp(m_szPhoto_CompensType, "1" ) == 0 )
			{	
				SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_COMPENS_VC_YN = 'Y' WHERE ROWID = '%s'", stGm.ROWID, 0, 0 );
				g_Sql_DirectExecute( szTmp ); 
				
				Mem_Set( (byte*)stGm.PHOTO_COMPENS_VC_YN, 0x00, sizeof(stGm.PHOTO_COMPENS_VC_YN) );
				Str_Cpy( stGm.PHOTO_COMPENS_VC_YN, "Y" );
			}
			else if( Str_Cmp(m_szPhoto_CompensType, "2" ) == 0  )
			{
				SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_COMPENS_VA_YN = 'Y' WHERE ROWID = '%s'", stGm.ROWID, 0, 0 );
				g_Sql_DirectExecute( szTmp ); 
			
				Mem_Set( (byte*)stGm.PHOTO_COMPENS_VA_YN, 0x00, sizeof(stGm.PHOTO_COMPENS_VA_YN) );
				Str_Cpy( stGm.PHOTO_COMPENS_VA_YN, "Y" );
			}
			else if( Str_Cmp(m_szPhoto_CompensType, "3" ) == 0  )
			{
				SPRINT( szTmp, "UPDATE REGUMDATA SET PHOTO_COMPENS_VM_YN = 'Y' WHERE ROWID = '%s'", stGm.ROWID, 0, 0 );
				g_Sql_DirectExecute( szTmp ); 
			
				Mem_Set( (byte*)stGm.PHOTO_COMPENS_VM_YN, 0x00, sizeof(stGm.PHOTO_COMPENS_VM_YN) );
				Str_Cpy( stGm.PHOTO_COMPENS_VM_YN, "Y" );
			}
			
			FFS_Delete( g_szphoto );
			
			VmSleep( 100 );
			
			NUM_DRAW();
			
			return 1;
		}
		else
		{	
			NUM_DRAW();
			return -1;
		}
	}
}

