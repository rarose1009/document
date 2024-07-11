/*----------------------------------------------------------------------------------

	mPOP25 Application : ��Ű��� �����Լ� ���� (socket.h)

	Compiler & Virtual Machine : mPOP 25.4
	
	Copyright(c) 2004 Mobile C&C Co., Ltd.

	----------	------		------------------------------------------------------
	2003.01.29	������		v1.00		: Create
	2003.05.02	dkjung		v1.10		: CardGui.lib ��� ����ϵ��� ����.
	
	2004.02.05	dkjung		v2.0		: mPOP 25.4 ���� mPOP 25.3�� ȣȯ���� ����.
	
	2004.10.06	dkjung		v3.00		: Release ( ǥ�ظ��� : registry )
										: �� ���� ����, ��� ������ ���Ϸ� ���� ����
										: �˷� �ֱ� �ٶ� ( dkjung@mcnc.co.kr )
	----------	------		------------------------------------------------------
----------------------------------------------------------------------------------*/

// misocap 2004-10-05
// ���ø����̼ǿ� �°� ������ �� �ִ� �κ��� [APP_SET] ���� �˻��ؼ�,
// �ش�Ǵ� ��쿡�� �������ֵ��� �� �� ����.

#ifndef	__SOCKET_H__
#define	__SOCKET_H__

#define SET_DUMMY	g_SetDummy
#define SET_IP(a,b,c,d) ( (((quad)a)<<24) | (((quad)b)<<16) | (((quad)c)<<8) | ((quad)d) )

// ����
#define TIME_SEC	1000		//(1000ms = 1��)
#define TIME_SLEEP	(5000 / 10)	// 5��


#define	TIME_SOCKETOUT	20000	// ���ϻ������ð�

#ifdef VER_DEBUG
	// dkjung 2003-07-28
	// �׽�Ʈ �ϴ� ���� �뷫 5��
	#define	WAIT_TIME	5*60000	// ��Ž� ��� �ð�(60��; 1000ms = 1��)
#else
	// dkjung 2003-08-20
	// ���Ѵ��� ������.
	// ���� ��Ž� ���� ����� �������� ����.
	// �����Լ������� blocking�Ǵ� �������� ������ ó�� ���δ�.
	// #define	WAIT_TIME	0	// ���� ����.
	
	// [APP_SET]
	// ����� �õ��� �� �����κ��� ������ ��ٸ��� �ִ��� �ð��� ��������.
	// �ʹ� �����ð��� �����ϸ� ����ڰ� �ٿ�Ȱ�ó�� ������ ���� ����.
	// 60000 = 60�� = 1��
	#define	WAIT_TIME	3 * 60000	// 3������ ����
#endif // VER_DEBUG

#define RET_RETRY	-100

#define MAX_PACKET_SIZE	2048
#define STX		0x02
#define ETX 	0x03

// ��Ŷ �ε���
#define IX_STX	0		// STX
#define IX_LEN	1		// Length
#define IX_CID	3		// Company ID
#define IX_TCL	4		// TR Class
#define IX_TCD	5		// TR Code
#define IX_TTY	9		// TR Type
#define IX_IDN	10		// Identifier
#define IX_DMY	12		// Dummy
#define IX_PHN	14		// Phone Number
#define IX_CTY	18		// Client Type
#define IX_PTC	19		// PACK TOTAL COUNT
#define IX_PIC	21		// PACK INDEX COUNT
#define IX_PRC	23		// PACK ROW   COUNT
#define IX_DAT	25		// Data

/*
typedef struct _PACKET
{
	long m_nLength;
	char m_CompanyId;
	char m_TrClass[4];
	char m_TrCode[4];
	char m_TrType;
	char m_ClientId[2];
//	char m_Dummy[2];
	char m_PhonNum[4];
	char m_DeviceType;
} PACKET;
*/

#define	ID_SOCK_RETRY	GID_SOCK_RETRY	// Socket ��� ���� ��õ� Ȯ��
#define	ID_SOCK_CANCEL	GID_SOCK_CANCEL	// Socket ��� ���� ��õ� ���
#define	ID_SOCK_ERROR	GID_SOCK_ERROR	// Socket ��� ����

//Error code
#define ERR_DIR_CREATE		-1
#define ERR_RCVFILE_CREATE	-2
#define ERR_SNDFILE_FORMAT	-3
#define ERR_RCVFILE_FORMAT	-4
#define ERR_SNDFILE_OPEN	-5
#define ERR_RCVFILE_OPEN	-6
#define ERR_RCVDATA_FAIL	-7
#define ERR_DATASIZE_FAIL	-8
#define ERR_CONNECT_FAIL	-9
#define ERR_RCV_PACKET_SEQ	-10
#define ERR_COMM_FAIL		-11
#define ERR_SVR_RES_FAIL	-12		//���� ���� ����
#define ERR_SVR_CON_FAIL	-13		//���� ���� �ߴ�

global	quad	g_HostIP;		// ���� ���� IP
global	quad	g_HostPort;		// ���� ���� ��Ʈ��ȣ
global 	quad 	g_nSockTimeOut;	// ���� ��� Ÿ�� �ƿ�.
global	byte	g_DataBuffer[MAX_PACKET_SIZE];	// �������� ������ ������ ���� ����
global	long	g_nDummy;

// ��� ����
global	long	g_Sock_SetDummy ( long* pnDummy );
global	long 	g_SeverConnection(void);
global	long	g_SocketConnect(void);
global	long	g_Sock_DataSend(char CompanyID, char * TRCode, char TRClass, char TRType, byte *Buf, long BufSize, long nTimeOut );
global	long 	g_Sock_DataReceive( char* TRCode, long nTimeOut);
global	long 	g_Sock_PacketRead( byte *Buf, long BufSize, char *TRCode, long nTimeOut );
global	void 	g_Sock_Close(void);

//2005-10-11 jysim
global	void 	g_Sock_Close_Only(void);

// ��

#endif	//_SOCKET_H_
