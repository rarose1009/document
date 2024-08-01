/*----------------------------------------------------------------------------------
	Project Name: Smart SCGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
----------------------------------------------------------------------------------*/

#ifndef		__GLOBALCRAD_H__
#define		__GLOBALCRAD_H__

#define PNG_EXIT		"pngi"
#define IMG_DIR 		"IMG\\"

#define WQHD_DIR 		"WQHD\\"
#define FHD_DIR 		"FHD\\"
#define HD720_DIR 		"HD720\\"
#define PDA_DIR 		"PDA\\"
#define SMART_DIR 		"SMART\\"

#define IODEV_WOOSIM	"WOOSIM"
#define IODEV_PM80		"PM80"
#define IODEV_DEFAULT	IODEV_PM80
#define PHOTO_BARCODE	"P"
#define BEAM_BARCODE	"B"
//#define CHG_OPTION			//���� ���ڵ� ����

#include	"ComDef.h"

#include	"FileMgr.h"	
#include 	"CardGui.h"
#include 	"SQL.h"
#include	"ChkCode.h"		//���� �ڵ�
#include	"GmData.h"		//��ħ
#include	"ScData.h"		//��������
#include	"BsData.h"		//��������
#include	"BfData.h"		//������
#include	"C6202Data.h"	//ü��
#include	"C6301Data.h"	//�跮�ⱳü
#include	"C6101Data.h"	//�ο�
#include	"McData.h"		//�̵�������
#include    "MudData.h"		//����ϻ���༭

//������������������������������������������������������������������������������
//�� 		�α����������� �� ��ħ, ������������ ����                        ��
//������������������������������������������������������������������������������

#define SERVER_IP		1
#define SERVER_PORT		2
#define DEFAULT_FONT	3
#define LARGE_FONT		4
#define PRINT_PORT		5
#define DB_CHGDATE		6

//-----------------------------------------------------------------------------
// �̺�Ʈ üũ�ð�(���� 100ms-> 1, 20ms->5, 10ms->10 )
// 
//-----------------------------------------------------------------------------
#define TIMERPERIOD		1000


#define SYSTEM_COMM      	"system/comm/"
#define SREACH_FILE	 		"SREACHFILE.dat"
#define CMBFILTER_FILE 		"CMBFILTER.dat"		//�޺��ڽ� ���͸� �� index������ ���� ��� ��� ���� ����
#define GROUP_FILE			"GROUPFILE.dat"		//ü�� �׷츮��Ʈ �׷� ���̺� ROW ���� �ľ��� ���� ����.
#define SRCH_FS_SIZE		10
#define SRCH_FS_INDEX_POS   0

//-----------------------------------------------------------------------------
// ���̾�α� Ÿ��Ʋ ����
//-----------------------------------------------------------------------------
#define TITLE_HEIGHT 	72

#define CWD			25
#define CHT			40
#define COMWD		70
//#define STARTX		5
#define STARTX		0
#define	STARTY		100
#define	STARTPOPY	80

//-----------------------------------------------------------------------------
// ����Ʈ�� Ÿ��Ʋ(ȭ���) ����
//-----------------------------------------------------------------------------
//����
#define TX			0
#define TY			95
#define STWD		1000
#define STHT		70

//����Ʈ�� �˾� ���� ��ư
#define POPTX		0
#define POPTY		0
#define POPSTWD		995
#define POPSTHT		70

//-----------------------------------------------------------------------------
// PDA Ÿ��Ʋ(ȭ���) ����
//-----------------------------------------------------------------------------
//����
#define P_TX		2
#define P_TY		2
#define P_STWD		985
#define P_STHT		55

//�˾�
#define P_TTLTX		0			//PDA Ÿ��Ʋ �̹��� X ���� ��ġ
#define P_POPTX		1
#define P_POPTY		1
#define P_POPSTWD	950
#define P_POPSTHT	70

//-----------------------------------------------------------------------------
// ����Ʈ�� ���ι�ư ��� 7��
//-----------------------------------------------------------------------------
/*
#define BTNX_1		5
#define BTNX_2		200
#define BTNX_3		400
#define BTNX_4		600
#define BTNX_5		797
#define BTNX_6		5
#define BTNX_7		870
#define BTNY_1		3
#define BTNY_2		95
#define BTNWD_1		200
#define BTNWD_2		120
#define BTNHT_1		95
#define BTNHT_2		70
*/
#define BTNX_1		0
#define BTNX_2		200
#define BTNX_3		400
#define BTNX_4		600
#define BTNX_5		800
#define BTNX_6		5
#define BTNX_7		870
#define BTNY_1		0
#define BTNY_2		95
#define BTNWD_1		200
#define BTNWD_2		120
#define BTNHT_1		95
#define BTNHT_2		70


#define P_BTNX		870
#define P_BTNY		0
#define P_BTNWD		125
#define P_BTNHD		55
/*
#define P_BTNX		925
#define P_BTNY		5
#define P_BTNWD		54
#define P_BTNHD		45
*/
//-----------------------------------------------------------------------------
// ����Ʈ�� �޴���ư
//-----------------------------------------------------------------------------
//1�� ��ư
#define BTNMNWD		490
#define BTNMNHT		140

//2�� ��ư
//���α��̴� �����ϳ�, ���α��̴� ȭ�麰 ��ư ������ ���� ����. �� ī�� Ȯ��. ���� ��ǥ���� �� ����
#define BTNWH		499
#define BTNHT		208
#define BTNHT_SC    165

//-----------------------------------------------------------------------------
// PDA �޴���ư
//-----------------------------------------------------------------------------
#define P_BTNMNWD	670
#define P_BTNMNHT	80

//-----------------------------------------------------------------------------
// ��ư Ŭ�� ��, �޼����ڽ� ��ư �Ҹ�
//-----------------------------------------------------------------------------
#define CLICKSOUND "SCGGAS/keypress.wavv"
#define MSGSOUND "SCGGAS/message.wavv"

//-----------------------------------------------------------------------------
// üũ�ڽ� ǥ�� & ������ üũ
//-----------------------------------------------------------------------------
#define CHKOFF	   "��"
#define CHKON	   "��"

#define CHKGOOD    "��"  //����
#define CHKNOGOOD  "��"  //������

//-----------------------------------------------------------------------------
// ������� �����Ͱ���
//-----------------------------------------------------------------------------
#define LEFT  	0
#define RIGHT 	1
#define CENTER 	2

//-----------------------------------------------------------------------------
// ���� �� ���� ���� ����.
//-----------------------------------------------------------------------------
#define SIGN_BYTES_PER_LINE		20
#define SIGN_WIDTH	(SIGN_BYTES_PER_LINE * 8)
#define SIGN_HEIGHT	100
#define SIGN_HEADER	5
#define BMP_HEADER	62
#define WBMP_SIZE	2005
#define BMP_SIZE	2062

global	byte g_SignBuf[SIGN_BYTES_PER_LINE * SIGN_HEIGHT + BMP_HEADER];
global	byte g_ucSignDest[(SIGN_BYTES_PER_LINE+1) * SIGN_HEIGHT + BMP_HEADER];
global	byte g_ucSignSrc[SIGN_BYTES_PER_LINE * SIGN_HEIGHT + BMP_HEADER];

global	long g_png_getbmp(long width, long height, byte* img );
global	long BtoI (byte* pBuf, long length);
//��� �����ϱ����ؼ� base64���ڵ���.
global	void g_PhtoBase64(char* szpath, handle* Base64, char* pRst);

//�ٿ�ε� ��ũ��
#define HTTP_DownloadTR(ret, url, trcode, snd_buf, db_nm)\
		callBackfunc = TR##trcode;\
		ret = HTTP_DownloadData(url, "FR" #trcode "_IN",  "FR" #trcode , snd_buf, db_nm)

//====================================================================
/*   ****���� �� g_nWorkFlag ��****
<��ħ ����>
g_nWorkFlag = 100		�����ħ
g_nWorkFlag = 101		���ð�ħ(�˻�)
g_nWorkFlag = 102		��ħ�Ϸ� ���(����Ʈ)
g_nWorkFlag = 103		�̰�ħ ���(����Ʈ)
g_nWorkFlag = 104		����(����Ʈ)

<���� ���� ����>
g_nWorkFlag = 200		��������
g_nWorkFlag = 201		��������
g_nWorkFlag = 202		�����ǰ�
g_nWorkFlag = 203		������
g_nWorkFlag = 204		�������� ���(����Ʈ)
g_nWorkFlag = 205   	��������(�˻�)
g_nWorkFlag = 206		���˿Ϸ� ���(����Ʈ)
g_nWorkFlag = 207		���������� ���(����Ʈ)
g_nWorkFlag = 208		�켱���� ���(����Ʈ)
g_nWorkFlag = 209		�������� ���(����Ʈ)
g_nWorkFlag = 210		��������� ���(����Ʈ)

<Ư�� ���� ����>
g_nWorkFlag = 300		����Ư������ ��ü
g_nWorkFlag = 301		����Ư������ �����˸���Ʈ
g_nWorkFlag = 302		����Ư������ �켱���˸���Ʈ
g_nWorkFlag = 303		����Ư������ �Ϲ����˸���Ʈ
g_nWorkFlag = 304		�����ǰ�
g_nWorkFlag = 305		�켱Ư������ ��ü
g_nWorkFlag = 306		�켱Ư������ �����˸���Ʈ

<���� ����>
g_nWorkFlag = 400		�������
g_nWorkFlag = 410		�޸�

<������ ����>
g_nWorkFlag = 500	    ���������� �ܵ�
g_nWorkFlag = 501       ���������� �ܵ� ����Ʈ(�̰�)
g_nWorkFlag = 502       ���������� �ܵ� ����Ʈ(�� �׷�)	
g_nWorkFlag = 510	    ���������� ���� �׷츮��Ʈ ��ü
g_nWorkFlag = 511	    ���������� ���� �׷츮��Ʈ(�� �׷�)
g_nWorkFlag = 512	    ���������� ���� �󼼸���Ʈ ��ü
g_nWorkFlag = 513	    ���������� ���� �󼼸���Ʈ �̰�

<�ο�>
g_nWorkFlag = 600
g_nWorkFlag = 610:����[��, ���ұ�, ��ǰ, ��ȸ��, ��� ]
g_nWorkFlag = 620:����[��, ���ұ�, ����,  ��ȸ��, ��� ]
g_nWorkFlag = 630:����[��, ����, ����, ��ȸ��, ��� ]
g_nWorkFlag = 640:����[��, ����, ��ȸ��, ��� ]
g_nWorkFlag = 650:��ü[��, ���ұ�, �跮��, ��ȸ��, ��� ]
g_nWorkFlag = 660:����[��, ���ұ�, ����(�跮�ⱳü), ��ȸ��, ��� ]
g_nWorkFlag = 698:�ο� ��������
g_nWorkFlag = 699:�ο� ����ǻ�

<�跮�� ��ü>
g_nWorkFlag = 700		�跮�ⱳü ���ĸ���Ʈ
g_nWorkFlag = 701		�跮�ⱳü ���ĸ���Ʈ(�̽ǽ�)
g_nWorkFlag = 702		�跮�ⱳü ���ĸ���Ʈ(��ü)

g_nWorkFlag = 710		�跮�ⱳü �ο�����Ʈ
g_nWorkFlag = 711		�跮�ⱳü �ο�����Ʈ(�̽ǽ�)
g_nWorkFlag = 712		�跮�ⱳü �ο�����Ʈ(��ü)

g_nWorkFlag = 720		�跮�ⱳü ��ü�Ұ�����Ʈ
g_nWorkFlag = 721		�跮�ⱳü ��ü�Ұ�����Ʈ(�̽ǽ�)
g_nWorkFlag = 722		�跮�ⱳü ��ü�Ұ�����Ʈ(��ü)

g_nWorkFlag = 730		�跮�ⱳü ���ø���Ʈ
g_nWorkFlag = 731		�跮�ⱳü ���ø���Ʈ(�̽ǽ�)
g_nWorkFlag = 732		�跮�ⱳü ���ø���Ʈ(��ü)
g_nWorkFlag = 733		�跮�ⱳü ���ø���Ʈ(�跮��,�⹰��ȣ �˻�)
g_nWorkFlag = 734		�跮�ⱳü ���ø���Ʈ(�ּҰ˻�)

<ü��>
g_nWorkFlag = 800		ü�� �⺻ �󼼸���Ʈ(���̺� ����Ŭ��)
g_nWorkFlag = 801		ü�� ���Ȱ�� �󼼸���Ʈ
g_nWorkFlag = 802		ü�� ����Ȱ�� �󼼸���Ʈ
g_nWorkFlag = 803		ü�� ���� �󼼸���Ʈ
g_nWorkFlag = 804		ü�� �ݾ� �󼼸���Ʈ
g_nWorkFlag = 805		ü�� ü������ �󼼸���Ʈ

g_nWorkFlag = 810		ü�� ����Ȱ��

g_nWorkFlag = 820		����Ȱ��

g_nWorkFlag = 830		����Ȱ��

g_nWorkFlag = 840		�������

g_nWorkFlag = 850		����Ȯ�༭���

g_nWorkFlag = 860		ü�� ������ �󼼸���Ʈ
g_nWorkFlag = 861		ü�� ������ �ݾ� �󼼸���Ʈ
g_nWorkFlag = 862		ü�� ������ ü������ �󼼸���Ʈ

g_nWorkFlag = 870		ü�� ������ �󼼸���Ʈ
g_nWorkFlag = 871		ü�� ������ �ݾ� �󼼸���Ʈ
g_nWorkFlag = 872		ü�� ������ ü������ �󼼸���Ʈ

*/

//====================================================================
/*   ****���� �� RCV_LOG ���̺� GUBUN ��****
<��ħ ����>
GUBUN = 1

<�������� ����>
GUBUN = 2
GUBUN = 3

<���������� ����>
GUBUN = 4

<Ư������ ����>
GUBUN = 5

<���������� ����>
GUBUN = 6

<�ο� ����>
GUBUN = 7

<�跮�ⱳü ����>
GUBUN = 8

<ü�� ����>
GUBUN = 9

*/

//====================================================================

global	quad	g_HostIP;			    	//���� ���� IP
global	quad	g_HostPort;			    	//���� ���� ��Ʈ��ȣ
global	char	g_szPrintPort[11];	    	//������ ������Ʈ
global	char	g_szBarcodeSet[5];	    	//���ڵ� ���� ��(P: ī�޶���ڵ� , B: �� ���ڵ�)
global	char	g_szDEVICE_NAME[32];		//

global	char	g_szROWID[5];	        	//ROWID
global	char	g_szCHK_EXEC_NUM[13];		//���˽����ȣ (����, Ư��)
global	char	g_szSubCHK_EXEC_NUM[13];	//�������� ��ݼ��� ȭ�� ���� �ش� ���˹�ȣ
global	char	g_szUSE_CONT_NUM[15];		//������ȣ (��ħ, ����, ü��)
global	char	g_szUSE_CONT_NUM_Fee[15];	//������ȣ (��ħ �����ȸ - ��ݰ��)
global	char	g_szMTR_NUM[11];			//�跮���ȣ (��ħ, ����, Ư��,������, �跮�ⱳü, ü��)
global	char	g_szMTR_ID_NUM[20];			//�跮�� �⹰��ȣ (��ħ, ����, Ư��,������, �跮�ⱳü, ü��)
global	char	g_szCUST_NUM[15];			//����ȣ (��ħ, ����)
global	char	g_szINST_PLACE_NUM[19];		//��ġ��ҹ�ȣ (��ħ�̷�)
global	char	g_szREGTR_NUM[9];			//�������ȣ (����)
global  char    g_szIndi_Cur[20];			//�跮������ ��ħ(��ħ �����ȸ ��ħ, Ư��,��������)
global  char    g_szCHK_EXCEP_WHY[10];		//�跮������ ���ܻ���(Ư��)
global  char    g_szCREATE_YMD[9];      	//����������
global  char    g_szBURNER_NUM[7];      	//����������
global  char    g_szBLD_NUM[10];        	//����������(����) �ǹ���ȣ
global  char    g_szOBJ_CRT_YMD[9];			//����������(�跮�ⱳü)
global  char    g_szCpNum[20];				//��� �ڵ��� ��ȣ(���ڰ�ħ, �������� �����մ��)
global	char	g_szCp_ddd[6];				//��� �ڵ��� ��ȣ(���ڰ�ħ, �������� �����մ��)
global	char	g_szCp_exn[6];				//��� �ڵ��� ��ȣ(���ڰ�ħ, �������� �����մ��)
global	char	g_szCp_num[6];				//��� �ڵ��� ��ȣ(���ڰ�ħ, �������� �����մ��)
global  char    g_szCmb_Str[50];      		//�޺��ڽ� ���͸� ��(���ڰ�ħ,�ο�)

global  char    g_szphoto[128];				//������ ���ϸ�
global  void *    g_pszphoto;				//������ ���ϸ�
global  char    g_szTown[51];
global  char    g_szCurrBar[21];            //�������� ���ڵ� �˻� ���ã�� , Ư�� ���ڵ� ��ĵ�� ������ ����
global  char    g_szINS_JOIN[3];            //������ �ܵ�,���� ���谡�Կ���
global  char    g_szINS_EXPLA[3];           //������ �ܵ�,���� ���� ����
global  char    g_szMtr_Code[11];           //��ħ�ڵ�
global  char    g_szIndi_Vm[10];
global  char    g_szIndi_Va[10];
global  char    g_szIndi_Vc[10];
global  char    g_szMtr_Loc_Flag[10];       //�������� �跮�� ���� -> ��ġ����
global  char    g_szSealed_Sts[10];         //�������� �跮�� ���� -> ���ο���
global  char    g_szFuseCock[10];	        //�������� ���ұ� ���� -> ǻ����
global  char    g_szTimerCock[10];          //�������� ���ұ� ���� -> Ÿ�̸���
global  char    g_szKitsprinkler[10];       //�������� ���ұ� ���� -> �ֹ��ڵ���ȭ��ġ
global  char    g_Pipe_Bury_Yn[3];          //Ư�� �跮�� ������� ���
global  char    g_Pipe_Hide_Yn[3];          //Ư�� �跮�� ������� ���
global  char    g_szPtrn_Week[5];           //�������� �������� �޺��ڽ� ���͸� ��
global  char    g_szPtrn_Time[5];           //�������� �������� �޺��ڽ� ���͸� ��
global	char	g_szSqlWhere[512];          //�跮�� ���ñ�ü , ü�� �׷�->�� ����Ʈ �̵�, where ����
global	char	g_szCntSql[512];            //ü�� �󼼸���Ʈ rowid ���Ͽ� ��� ����.

global	long 	g_TRNUM;                    //��ſ� �÷���
global	long	g_nScrollIndex;				//Grid ��ũ�� �ε��� ���� ����
global	long 	g_lindex;                   //�����ʹ� ���ڵ��� ��ġ
global	long	g_nActIndex;                //index ��ȣ
global	long	g_nObjIndex;                //Ư������ �跮�� index ��ȣ
global	long	g_nActRow;                  //���õ� Row(�跮������ ȭ�� ���� ������ ���)
global	long	g_nChkIndex;                //������ ���� ����Ʈ index
global	long	g_nGrpIndex;                //������ ���� �׷츮��Ʈ index
global	long	g_nBackFlag;                //������ backup�� ���� flag
global  long    g_nKeyMode;                 //SetKeymode Test ����
global  long    g_nUserData;                //��ħ ���� UserData ���� , g_nUserData = 10 �跮��, g_nUserData = 40, 41 �µ��¾к�����,  g_nUserData = 20 ������(�ڼ��� ������ ��ħ���ȭ�� m_lUserData Ȯ��)

global	long	g_nWorkFlag;                //�������� �÷��� 
global	long	g_nAddrFlag;                //���ּ�&���ּ� �÷��� g_nAddrFlag = 0 -> ���ּ�    g_nAddrFlag = 1 -> ���ּ�
global  long    g_nTelFlag;                 //��ħ���,���˽��� �� ��ȭ��ȣ flag , g_nTelFlag = 0 > �ڵ��� , g_nTelFlag = 1 > ��,ȸ��
global  long    g_nNameFlag;                //��ħ���,���˽��� �� �̸�,��ȣ�� flag , g_nNameFlag = 0 > �̸�, g_nNameFlag = 1 > ȸ��,��ȣ
global  long    g_nGrpFlag;                 //��ħ �׷�,�� ����Ʈ �ε��� ���� flag
global  long    g_nGmType;                  //��ħ Ÿ�� = 0 : ��������, 1 : �簨
global  long 	g_nGmKind;					//�跮����ı�ü �跮������ ����

//g_lDataflag , 0 -> ȣ��, 1 -> ȣ��X, SetData�� �ٽ� ȣ�� ���ϵ����ϱ����� flag, ó�� ȭ�� ������ �ÿ� 1��, ����&����ȭ��, ���� �Ҷ��� ����.
//��ħ �����ȸ ��� �˻� -> SetData�� �ٽ� ȣ�� ���ϵ����ϱ����� flag, 1 -> ��ݳ���, 2 -> ��ݰ��
global	long	g_lDataflag;		
global	long	g_nMemoFlag;                //��ħ,����,������ ���� �÷���, 1:��ħ , 2:��������, 3:������, 4:Ư������ �޸�, 5:Ư������ �跮�� �޸�, 6:�跮�ⱳü �޸�, 7:�ο��ǻ� �޸�(�����ֱ��?)
global	long	g_nSmsFlag;                 //�������� ȭ�� ���� �÷���, 1:��ħ����޼��� , 2:���ڰ�ħ - ���/����, 3:�����ȸ - ��ݳ���, 4:�����ȸ - ��ݰ��, 5:���ڰ�ħ
global	long	g_lSCMoveFlag;              //���� ȭ�� ���� ȭ���̵� flag(��������,Ư������)
global	long	g_lMoveFlag;                //(����Ʈ index) ȭ�� ���� ȭ���̵� flag, g_lMoveFlag = 0 > default , g_lMoveFlag = 1 > ȭ���̵�, ���ڰ�ħ ���
global  long    g_lNewBurFlag;              //�������� ������� Ÿ��Ʋ ����, Ư������ ���ұ� �űԵ�� ���� �÷���(���Ϸ�, ���ұ�) g_lNewBurFlag = 1:���Ϸ�, 2:���ұ�
global  long    g_lConfrimFlag;             //(Ư������ ��)���� ȭ�� Ȯ�� üũ ���� Flag =0 default, =1 �̵�
global	long	g_lPAYFlag;                 //�����ȸ ��û����, ��ħ �����ȸ 0 : ��ݰ�� ���� X , 1 : ��ݰ�� ����.
global  long    g_lRfrmFlag;                //���˽��ۿ� �����չ��� �ؽ�Ʈ ���� �÷���, = 0 default, =1 �̵�
global  long    g_lGrpCmbFlag;              //������ ���� �޺��ڽ� �׷� ����Ʈ ���� index, 
global  long    g_lDtlCmbFlag;              //������ ���� �޺��ڽ� �� ����Ʈ ���� index, 
global  long    g_lPtrnFlag;                //�������� ������ flag , g_lPtrnFlag = 1 ���˵��ȭ��, g_lPtrnFlag = 2 ������ ȭ��
global  long    g_nPhotoFlag;               //�����÷���( ��ħ:1, ��������:2, ������:3, Ư������:4, ��������������:5, �ο�:6, �跮�ⱳü:7, �����ⱳü:8)
                                            //�����ȸ ȭ���̵�( ��ħ:1, ��������:2, ������:3, Ư������:4, ��������������:5)
global	long	g_nPhotoYNFlag;             //�跮�ⱳü, ���� �Կ� ���� Ȯ�� FLAG, 0 = �Կ� ����. 1 = �Կ� �Ϸ�.
global  long    g_nWorkChkFlag;             //���� �� ������ ���� ���� �÷��� , �Ʒ� ����
global  long    g_nBojungFlag;              //�跮�� ������� ���� Flag , Flag = 0 ���������, Flag = 1 ����������, Flag = 2 ���Ϻ�����
global  long    g_lNpChkFlag;               //ü��Ȱ�� �跮�� ���� ü���ݾ� ���̺� ��� chkbox üũ ���� flag , = 1 üũ, =0 üũX
global  long    g_lNpMemoChkFlag;           //ü����� �޸� Ȯ�� Flag, = 0 �޸� ���� �� �ڵ� ȣ�� , = 1 �޸� �����ص� �ѹ� ȣ��???�ڵ�ȣ�� ����
global	long	g_lChgMtr_WorkFlag;			//g_lChgMtr_WorkFlag > = 0 ������ �跮��, = 1 ��뷮 �跮��, = 2 ������

global  long    g_nCustFlag;                //�ο� ���������� �б�
global  long    g_nStopReleFlag;            //����, ���� ����÷���
global  long    g_nSmsSndFlag;              //��ħ �����޽��� �߼� Ȯ�� flag , =0 �߼�X , =1�߼�
global	long	g_nNogoodDelCnt;			//�������� ���� ���ұ�(���Ϸ�) ������ �Ǽ� ī��Ʈ 

global  char    g_history_yn[2]; 			// ����̷� ���翩��

global	long	g_lUpgradeChk;				//�α��� �� Ǫ�� vm���׷��̵� Ȯ�� ��� ȣ�� flag,  = 0 ���� , = 1 ����X

global	long	g_szCHK_PLAN_YM[6];			//���������� ���˰�ȹ���
global	long	g_szSAFE_CHK_TYPE[2];		//���������� �������� ���� flag, = 23 ����������, = 18 Ȯ������

global	char	g_szSERV_ADD_YN[2];		    //���������� YN flag, = Y ����������, = N �����������ƴ�

global  long    g_nProdMoveFlag;			//��ǰ���� ȭ�鿡�� �������ö� �̵��� ��� Flag ����, = 0 ���Ϸ�����, =1 ���ұ�����

global  long    g_lWmtrMoveFlag;            //�ο� ��ǰȭ�鿡�� ��ǰ����ȭ������ �ٷ� ���� ���� flag, flag = 1 -> ��ǰ����ȭ��

/**********************************/
/* ��������                       */
/**********************************/
/* �������� */
global  long    g_nBoil_inst_cnt;			// ���Ϸ� 10�� ��� �˸�
global  long    g_lBoil_Chk_Flag;			// �������� ���Ϸ����˿��� ������ ���Ϸ� ��Ȳ�ڿ� ��ġ ���� flag : 0 = �ƴϿ� 1 = ��
global  char    g_szRfrmComboFlag[10];		// ��������Ʈ �޺� flag 

/* ü�� */
global  long    g_nHomeLstFlag;			    // ������ : 1, ������ : 2
global	long	g_szNpMonthFlag;     	    // Ȱ�� ����Ʈ �� ���� flag, = 0 �⺻, 1 = ��������, 2 = �������� 

/* ī�� ���� ���� */
global	long	g_lGasCardFlag;     	    // ����ī����� flag, = 0 ī�����, = 1 �������
global	long	g_lGasRecevieFlag;     	    // ���������� flag, = 0 ������, = 1 ������ ���
global	long	g_lOneCardFlag;     	    // ��ȸ��ī����� flag, = 0 ī�����, = 1 �������
global	long	g_lOneRecevieFlag;     	    // ��ȸ�������� flag, = 0 ������, = 1 ������ ���
global	char	g_szGas_ApproRslt[60];      // �������_���ΰ��
global	char	g_szOne_ApproRslt[60];      // ��ȸ�����_���ΰ��
global	long	g_lOneCardPageFlag;     	// ��ȸ����� ī��flag, = 0 ī�������� ����, = 1 ī�������� ����

/* �跮�ⱳü */
global	char	g_szBartmp[128];     	    // �跮�ⱳü ���ڵ� ����

/* ����� ����༭ */
global  long    g_lCmContDocMoveFlag;		// ����� ����༭ ����ȭ�� ���� ��� flag, = 0 �ο�, = 1 ��������, = 2 ��ħ
global  char    g_szInstPlaceNum[20];		// ����� ����༭ ��ġ��ҹ�ȣ
global  char    g_szAccnameSignYn[2];		// ����� ����༭ ������ ���� YN( ��������� ��� ���� ���� �ʴ´� )

/* �̵������� */
global  char    g_szMC_InstPlaceNum[20];	// �̵������� ��ġ��ҹ�ȣ ���
global  long    g_lMC_MoveCard_Flag;		// �̵������Ϳ��� �ٸ� card�� �Ѿ�� ����ϴ� Flag, 0 = ��������, 1 = ��ħ, 2 = ������ �ܵ�, 3 = ������ ����

/* ����� ����༭ */
global  long    g_lMobile_Use_Doc_Type;			// ����� ����༭ Ÿ�� : 1 = ���Խű�, 2 = ��������, 3 = ���Ǻ���, 4 = �ű�
global  long    g_lMobile_Inflow_Path;      	// ����� ����༭ ���Ա��� : 0 = ���� �ű�, 1 = �ο� ����_�ű�, 2 = ��������, 3 = ��ħ, 4 = �跮�ⱳü, 5 = �ο� ����_����
global  char 	g_szMobile_Use_cont_num[10];	// ����� ������ȣ : ���Խű��� ��쿡 �ʿ���

/* Ư������ */
global  long    g_lGovFlag;	// ���б� ������ �ߴ��� ���ߴ��� Flag, 0 = ����, 1 = ��
global  long    g_lGovInflowPath;	// ���б� �������� ���� Path, 0 = CONFIRM, 1 = CHK_BSDTL
global  long	g_lGovBetterFlag;   // �������� ���� 0 = �����ջ� ��ư , 1 = �����ڽ� 

/*************************************************************************************************************************************************
 * g_nWorkChkFlag ���� ��
	
	1. ��������
	g_nWorkChkFlag = 10 ��ġ��� , g_nWorkChkFlag = 11 �跮��, g_nWorkChkFlag = 12 ���Ϸ�, g_nWorkChkFlag = 13 ȣ��, g_nWorkChkFlag = 14 ���ұ�
	
	2. �������� - ������ �ܵ�
	g_nWorkChkFlag = 20
	
	3. �������� - ������ ����
	g_nWorkChkFlag = 30
	
	4. Ư������
	g_nWorkChkFlag = 40 Ư���ü�
	
	5. ������
	g_nWorkChkFlag = 50 ���ұ�
	
**************************************************************************************************************************************************/

//�α��� ����
typedef struct LOGININFO
{
	char szloginday         [8  +1];
	char szemployee_id      [9  +1];
	char szpassword         [20 +1];
	char sznm_kor           [30 +1];
	char szpda_ip           [15 +1];
	char szcenter_cd        [2  +1];
	char szcenter_nm        [30 +1];
	char szbranch_cd        [6  +1];
	char szbranch_nm        [30 +1];
	char szbiz_regi_num     [30 +1];
	char szrepre_nm         [30 +1];
	char sztel              [15 +1];
	char szcellphone        [15 +1];
	char szcert_cd          [15 +1];
	char szcom_name         [30 +1];
	char szduty_appro_sts_cd[2  +1];
	char szonce_account_num [30 +1];
	char szonce_bnk_nm      [30 +1];
	char szonce_depositor_nm[30 +1];
	char szcard_term_id1    [30 +1];
	char szcard_term_id2    [30 +1];
	char szmenu_flag        [2  +1];
	char szver_num          [12 +1];
	char szaddr_sum         [300+1];
	char szlogintime        [6  +1];
	char szworkcd           [  5+1];
	char szappversion		[10 +1];
	char szguidsion			[10 +1];
	char szSos_TelNum       [30 +1];
	char szSos_SmsNum1      [30 +1];
	char szSos_SmsNum2      [30 +1];
	char szSos_SmsNum3      [30 +1];
	char szScg_repre_nm     [50 +1];
	char szNp_auth          [2  +1];
	char szLock_yn          [2  +1];
	char szNew_common_ver_num [12  +1];
	char szOld_common_ver_num [12  +1];
	char szOneCard_yn       [1  +1];
	char szRecommender_id       [9  +1];
}	LOGININFO;

global LOGININFO stUserinfo;


//����ڵ����
typedef struct BIZ
{
	char szUse_Cont_Num    [20 +1];
	char szInstPlaceNum    [20 +1];
	char szCust_Nm         [50 +1];
	char szTel_Ddd         [5  +1];
	char szTel_Exn         [5  +1];
	char szTel_Num         [5  +1];
	char szCp_Ddd          [5  +1];
	char szCp_Exn          [5  +1];
	char szCp_Num          [5  +1];
	char szEmail           [100+1];
	char Biz_Regi_Num      [20 +1];
	char szFirm_Nm         [50 +1];
	char szPhoto           [256+1];
	char szRmk             [300+1];
	char szBranch_Cd       [10 +1];
	char szCenter_Cd       [10 +1];
	char szData_Col_Type   [10 +1];

}	BIZ;

global BIZ stBiz;


//-----------------------------------------------------------------------------------------------
global	void	g_LoadGlobal(void);

enum
{
	MDM_BASE_URL,
	PUSH_BASE_URL,
	WAS_BASE_URL,
	OZ_BASE_URL
} BASE_URL_TYPE;

#define GET_URL(a)	g_GetBaseUrl(a)
global	char* 	g_GetBaseUrl(long url_alias);
global	long	g_Push_GetValue(char* pszKey);
global	long	g_Push_SetValue(char* pszKey, char* pszVal);
global	long	g_FormatPhoneNumber(char *in, char *out);
global	void	g_InitPush(void);
global	void	g_SetPushLogin(void);
global	void	g_SetPushLogout(void);
global	void	g_StartPush(void);
global	void	g_StopPush(void);

//-----------------------------------------------------------------------------------------------
//				��¥ �� �ð� ����
//-----------------------------------------------------------------------------------------------
global	long	g_ChkDay(void);
global	quad 	g_GET_IP ( char *Data );//IP�� ��ȯ�ϴ� �Լ�
global	void 	g_Str_TimeType	(char *temp,  long time );   //�ð��� int���� char������ ����
global 	void 	g_Str_DateType	(char* Dp,   char* YYMMDD);  //��¥�� ���÷��� �������� ����(YYYY.MM.DD -<YYYYMMDD)

global 	void 	g_Str_TimeForm	(char* Dp,   char* HHMMDD);   //�ð��� ���÷��� �������� ����(HH:MM:DD -<HHMMDD)

//-----------------------------------------------------------------------------------------------
//				ȭ���̵�����
//-----------------------------------------------------------------------------------------------
global	char	g_CurrentCard[33];					//���� ȭ�� Card
global	char	g_PrevCard[33];						//���� ������ ȭ�� Card
global 	void 	Card_Move		(char* Cardnm);		//
global 	void 	Card_Prev		(void);   			//���� Card

global	char	g_szAppName[32];
//-----------------------------------------------------------------------------------------------
//				��ܸ޴���ư(ȭ��,Ű����)
//-----------------------------------------------------------------------------------------------
global	void g_MOVE_DLG(long npos);
global	void g_SHOW_SIP(void);
global  void g_EditCtrl_ShowEditInput(handle h, char* sztmp);

global	long	g_Dlgflag;
global	long	g_Sipflag;

global	long	g_nTimerID;  		//���� Ÿ�̸�.
global	long	g_nDrawTimerID;  	//ȭ�� Draw Ÿ�̸�.
global	long	g_nPrinterTimerID;  //���� Ÿ�̸�.

//-----------------------------------------------------------------------------------------------
//				������
//-----------------------------------------------------------------------------------------------
global long g_Sql_Bind(char* szSql, long szBindLen, char* szBind, long Retlen, char* szRet);
global long g_Sql_RetStr(char* szSql, long Retlen, char* szRet );
global long g_Sql_RetInt(char* szSql, long* nvalue);
global long g_Sql_RetStr2(SQLITE sql, char* szSql, long Retlen, char* szRet ); // ���µǾ� �ִ� DB Ȱ��
global long g_Sql_RetInt2(SQLITE sql, char* szSql, long* nvalue); // ���µǾ� �ִ� DB Ȱ��
global long g_Sql_DirectExecute(char* szSql);
global long g_Sql_DirectExecute2(SQLITE sql, char* szSql);
global long g_Sql_SetCombo(char* szSql, long CTRLID );
global long g_Sql_SaveSeq(char* szSql, char* FSNM);
global long g_SREACHFILE_GetSeq(char *SREACHFILE, long nPos);
global long g_Get_FsIndex(long lRowid, char* FSNM);
global long g_FS_GetSrchTotCnt(char* FSNM);


//���α׷� ���� �� �ش� DB�� �ٸ� ������ ��� & ����
global void g_Db_Backup(void);		//���
global void g_Db_Restore(void);		//����

//-----------------------------------------------------------------------------------------------
//				��������
//-----------------------------------------------------------------------------------------------
//��������,Ư������ ��뵵�߿� �������� ������..�����뵥���͸� Ŭ�����Ѵ�.
global void g_Del_ScData(void); 
global void g_Del_BsData(void); 
global void g_Del_GcPhoto(void);
global void g_Exit_DelScData (void);
global void g_Exit_DelBsData (void);
global void g_Exit_DelGcData (void);
global void g_FlagClear(void);				//���� FLAG ��� 0���� �ʱ�ȭ�ϴ� �Լ�
global long g_GetUtf8Size(char* str);		//�޸� ���� üũ
global char* g_SetOzComboData(SQLITE sql, char* szWhere, char* szComboData, long convFlag); // ����༭ �޺��� ������ ������ ��Ʈ�� ����

global bool g_CheckPhoneNumber(char* type, char* szDDD, char* szEXN, char* szNUM);
global bool g_CheckPhoneNumberFormat(char* szEXN, char* szNUM);

//�ο� ����
global long g_Save_Assign_690(void);
global long g_Load_Assign_690(char* assign_seq);
global long g_Add_Bo_690(handle pj);
global long g_Add_Bur_690(handle pj);
global long g_Add_Once_690(handle pj);
global void g_Snd_RstMin_690(long flag);
global long g_Rcv_RstMIn_690(void);

//�ð� üũ
global bool g_Chk_Time( char* param_start_time, char* param_end_time );

//ComboBox Value Active
global long g_SearchStr( char *Str, CodeTable *CT);
global long g_SearchCD( char *CD, CodeTable *CT);

//SOS���ȣ��
global void g_Send_SOS( long type );
global long g_Rcv_SOS(void);

//��ȭ��ȣ ����
global void g_Fsgetitem( char* szSource, char* szTarget, int id, int len );

//����
global long g_DirFS_Count( char* pszDir, char* pszFilter );

//��ħ �ǽð� �� �ݿ�
global long g_GM_Mtr_Add_Item(handle pj);
global long g_GM_Use_Cont_Num_Add_Item(handle pj);
global void g_GM_Rcv25012(void);
global long g_GM_TR25012(void);
global bool g_GM_Etc_Update( char * mtrnum, char* code, char* vc, char* va, char* vm );
global bool g_GM_Remote_Update( char * mtrnum, char* indiVc, char* gmtrYmd);
global long g_GM_Cal_UseQty( char *szIndi_VC, char* szCode, char* szMtrnum );
global bool g_GM_Befo_Sms_Update( char * usecontnum );
global long g_GM_SetFR25012(void);
//-----------------------------------------------------------------------------------------------
//				��Ű���
//-----------------------------------------------------------------------------------------------
#define TIME_SLEEP	(5000 / 10)			// 5��

typedef long (*ResponseCallBack) (void);

//global long (*callBackfunc) ( void );	// ��������� ȣ��Ǵ� �Լ�������
global ResponseCallBack callBackfunc;	// ��������� ȣ��Ǵ� �Լ�������
global handle g_pjcomm;
global long	g_SeverConnection(void);
global void	g_Sock_Close( void );
global char* g_Chk_Code(char* pBuf, char* code, char* msg);
global long g_Chk_Json(long nservicenum);
global void* g_CreateJsonHead(void* pJson, char* szUrl ,long nservice, bool bClassName);
global void* g_CreateJsonHead_Login(void* pJson, char* szUrl, char* szid, long nservice, bool bClassName);
global long g_Save_JsonFile(char* pStrJson);
global long g_StartSession(char* szSessionKey);
global long g_EndSession(char* szSessionKey,char* szworkid);
//-----------------------------------------------------------------------------------------------
//				��ȣȭ����
//-----------------------------------------------------------------------------------------------
//2008.12.02 parkhw ��ȣȭ/��ȣȭ �Լ��߰�
#define ENCRYPT		1
#define DECRYPT		0

global long g_EncryptDecrypt(long flag, char *szData, long nFieldLen);
global void	EncodeBlock( quad i32Key, quad i32Input, quad* i32Output );
global void	DecodeBlock( quad i32Key, quad i32Input, quad* i32Output );
global BOOL	Encode (char* pszPlainText, quad unPlainTextLen, char* pszEncodedText, quad unEncodedTextLen );
global BOOL	Decode(char* pszEncodedText, quad unEncodedTextLen, char* pszPlainText, quad unPlainTextLen );
global BOOL	EncodeCore(	quad i32Key, char* pszPlainText, quad unPlainTextLen, char* pszEncodedText, quad unEncodedTextLen );
global BOOL	DecodeCore( quad i32Key, char* pszEncodedText, quad unEncodedTextLen, char* pszPlainText, quad unPlainTextLen );

//-----------------------------------------------------------------------------------------------
//		������ϻ���
//-----------------------------------------------------------------------------------------------
global long g_DirFS_Clear (char* pszDir, char* pszFilter);

//-----------------------------------------------------------------------------------------------
//		������� �����Ͱ���
//-----------------------------------------------------------------------------------------------

#define PRINTER_OK			 0
#define PRINTER_TIMEOUT		-1
#define PRINTER_NODATA		-2

typedef long (*PrinterCallBack) (void*);

global PrinterCallBack printerCallBack;
global PrinterCallBack g_printerCallBack;
global void* g_pList;
global void g_SetPrinterCallBack(PrinterCallBack pf);
global char* g_Printer_GetLastError(long code);
global long g_Printer_Start		(void* p, void* result);
global long g_Printer_Process	(void* p);
global void g_Line_Print		(void* p, char* sztmp1, char* sztmp2, char* sztmp3, long Style, long pos);
global void Line_Print			(char* sztmp1, char* sztmp2, char* sztmp3, long Style, long pos);
global bool g_IsCardReader		(void);

//-----------------------------------------------------------------------------------------------
//		�̺�Ʈ �ݹ����
//-----------------------------------------------------------------------------------------------

global void g_OnUart (long nType, long nData);
global void g_OnTask (long nType, long nData);
global void g_OnTimer(long nTimerId);
global void g_EvtSessionCallback (long wParam);
global void g_EndSessionCallback (long wParam);

//-----------------------------------------------------------------------------------------------
//		�̹��� ����
//-----------------------------------------------------------------------------------------------
global void * g_pImgMainBg;
global void * g_pImgMainExit;	
global void * g_pImgLogo;	
		
global void * g_pImgMainTtl_GM;
global void * g_pImgMainTtl;
global void * g_pImgBlankTtl;
global void * g_pImgSubTtl;
global void * g_pImgSubTtlPrev;
global void * g_pImgSubTtlClose;
//global void * g_pImgPopTtl;
global void * g_pImgPopTtlL;
global void * g_pImgPopTtlPrev;

global void * g_pImgHomeI;
global void * g_pImgKeybrdI;
global void * g_pImgScreenI;
global void * g_pImgCmmnwrkI;
global void * g_pImgExitI;

global void * g_pImgHomeA;
global void * g_pImgKeybrdA;
global void * g_pImgScreenA;
global void * g_pImgCmmnwrkA;
global void * g_pImgExitA;

global void * g_pImgGm;
global void * g_pImgSc;
global void * g_pImgBs;
global void * g_pImgBf;
global void * g_pImgMw;
global void * g_pImgGc;
global void * g_pImgNp;
global void * g_pImgCmm;
global void * g_pImgNotice;
global void * g_pImgFeeview;

global void * g_pImgMnTop;
global void * g_pImgMnMid;
global void * g_pImgMnMidpl;
global void * g_pImgMnBot;

global void * g_pImgGmBtn;
global void * g_pImgNoGmBtn;
global void * g_pImgAbsncBtn;
global void * g_pImgGmSlctBtn;
global void * g_pImgGmgoBtn;
global void * g_pImgGmDataBtn;

global void * g_pImgScBtn;
global void * g_pImgPtrnBtn;
global void * g_pImgRsrvBtn;
global void * g_pImgScDataBtn;
global void * g_pImgFrstScBtn;
global void * g_pImgRsltBtn;
global void * g_pImgRfrmBtn;
global void * g_pImgScgoBtn;
global void * g_pImgJojungBtn;
global void * g_pImgScSlctBtn;

global void * g_pImgChkI;
global void * g_pImgRadioI;
global void * g_pImgChkA;
global void * g_pImgRadioA;

//*********************************************************************
//2�� �þ� ��ư ����
//*********************************************************************

//����޴� ��ư

//��ħ ��ư
global void * g_pImgGm_Normal; // �����ħ
global void * g_pImgGm_Nogm; // �����̰�ħ
global void * g_pImgGm_Absnc; // �����ħ
global void * g_pImgGm_Sel; // ������ħ
global void * g_pImgGm_Go; // ��ħ�ٷΰ���
global void * g_pImgGm_Data; // �ڷ����
global void * g_pImgGm_Sms; // ���ڰ�ħ
global void * g_pImgGm_Feeview; // �����ȸ
global void * g_pImgGm_Regm; // ���
global void * g_pImgGm_DataRcv; // �ڷ����(�ڷ���� ȭ��)
global void * g_pImgGm_DataSnd; // �ڷ�۽�(�ڷ���� ȭ��)
global void * g_pImgGm_DataDel; // �ڷ����(�ڷ���� ȭ��)

//�������� ��ư
global void * g_pImgSc_Data;
global void * g_pImgSc_First;
global void * g_pImgSc_Go;
global void * g_pImgSc_Jojung;
global void * g_pImgSc_Normal;
global void * g_pImgSc_Ptrn;
global void * g_pImgSc_Reserve;
global void * g_pImgSc_Result;
global void * g_pImgSc_Rfrm;
global void * g_pImgSc_Sel;
global void * g_pImgSc_DataRcv;
global void * g_pImgSc_DataSnd;
global void * g_pImgSc_DayDataRcv;
global void * g_pImgSc_JojungDataRcv;
global void * g_pImgSc_JojungDataSnd;
global void * g_pImgSc_SnnDataRcv;
global void * g_pImgSc_SnnTotDataRcv;
global void * g_pImgSc_ScgsDataRcv;
global void * g_pImgSc_ScgsTotDataRcv;

//Ư������ ��ư
global void * g_pImgBs_Normal; // ����Ư������
global void * g_pImgBs_Rfrm; // �����ǰ����
global void * g_pImgBs_Data; // �ڷ� ����
global void * g_pImgBs_TotDataRcv; // �ڷ����>��ü�ڷ����
global void * g_pImgBs_DayDataRcv; // �ڷ����>�����ڷ����
global void * g_pImgBs_DataSnd; // �ڷ����>�ڷ�۽�
global void * g_pImgBs_SafeDataRcv; // �ڷ����>�����ڷ����
global void * g_pImgBs_First; // �켱Ư������

//���������� ��ư
global void * g_pImgBf_Tgt;
global void * g_pImgBf_Solo;
global void * g_pImgBf_Rfrm;
global void * g_pImgBf_Data;
global void * g_pImgBf_DataSnd;
global void * g_pImgBf_DataRcv;
global void * g_pImgBf_TgtDataRcv;

//�ο� ��ư
global void * g_pImgMw_Work; // �۾�����Ʈ(�ο��޴�ȭ��)
global void * g_pImgMw_Receipt; // �����ڷ���Ȳ(�ο��޴�ȭ��)
global void * g_pImgMw_Data; // �����ڷ����(�ο��޴�ȭ��)
global void * g_pImgMw_Snd; // ��ó���۽�(�ο��޴�ȭ��)
global void * g_pImgMw_Card; // ī����θ��(�ο��޴�ȭ��)
global void * g_pImgMw_Print; // �μ��׽�Ʈ(�ο��޴�ȭ��)
global void * g_pImgMw_DayDataRcv; // �����ڷ����
global void * g_pImgMw_Silsa; // 
global void * g_pImgMw_Report;
global void * g_pImgMw_CmmDataRcv;

//�跮�ⱳü ��ư
global void * g_pImgGc_Old;
global void * g_pImgGc_Mw;
global void * g_pImgGc_Remark;
global void * g_pImgGc_Imp;
global void * g_pImgGc_Sel;
global void * g_pImgGc_Ret;
global void * g_pImgGc_Data;
global void * g_pImgGc_BigDataRcv;
global void * g_pImgGc_DataRcv;

//ü�� ��ư
global void * g_pImgNp_Auction;
global void * g_pImgNp_Clear;
global void * g_pImgNp_Data;
global void * g_pImgNp_Normal;
global void * g_pImgNp_Part;
global void * g_pImgNp_Receipt;
global void * g_pImgNp_Stop;

//����
global void * g_pImgCm_Reflesh;

//*********************************************************************

global void * g_pImgChkOff;
global void * g_pImgChkOn;
global void * g_pImgCash;
global void * g_pImgCashDark;
global void * g_pImgAmount;

global void * g_pImgLoad1;

global  long g_Upgrade_flag;
global	void g_ImgNameChg	(void);
global	void g_GetImgLoad	(void);
global	long g_Exit			(void);
global	void g_ImgFree		(void);

global char* Get_ImgPath(char* trgpath, char* imggb, char* fsnm);
global char* Get_BasePath(char* trgpath);
global void Update_DB(char* szDate);

#endif	//	COMMON_H


