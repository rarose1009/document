/*----------------------------------------------------------------------------------

	mPOP25 Application : 통신관련 전역함수 정의 (socket.h)

	Compiler & Virtual Machine : mPOP 25.4
	
	Copyright(c) 2004 Mobile C&C Co., Ltd.

	----------	------		------------------------------------------------------
	2003.01.29	서병준		v1.00		: Create
	2003.05.02	dkjung		v1.10		: CardGui.lib 모듈 사용하도록 수정.
	
	2004.02.05	dkjung		v2.0		: mPOP 25.4 적용 mPOP 25.3과 호환되지 않음.
	
	2004.10.06	dkjung		v3.00		: Release ( 표준모듈명 : registry )
										: 이 버전 이후, 모듈 수정시 메일로 수정 내용
										: 알려 주기 바람 ( dkjung@mcnc.co.kr )
	----------	------		------------------------------------------------------
----------------------------------------------------------------------------------*/

// misocap 2004-10-05
// 애플리케이션에 맞게 셋팅할 수 있는 부분은 [APP_SET] 으로 검색해서,
// 해당되는 경우에는 셋팅해주도록 할 수 있음.

#ifndef	__SOCKET_H__
#define	__SOCKET_H__

#define SET_DUMMY	g_SetDummy
#define SET_IP(a,b,c,d) ( (((quad)a)<<24) | (((quad)b)<<16) | (((quad)c)<<8) | ((quad)d) )

// 시작
#define TIME_SEC	1000		//(1000ms = 1초)
#define TIME_SLEEP	(5000 / 10)	// 5초


#define	TIME_SOCKETOUT	20000	// 소켓생성대기시간

#ifdef VER_DEBUG
	// dkjung 2003-07-28
	// 테스트 하는 동안 대략 5분
	#define	WAIT_TIME	5*60000	// 통신시 대기 시간(60초; 1000ms = 1초)
#else
	// dkjung 2003-08-20
	// 무한대의 문제점.
	// 무선 통신시 자주 끊기는 현상으로 인해.
	// 소켓함수내에서 blocking되는 현상으로 죽은것 처럼 보인다.
	// #define	WAIT_TIME	0	// 끝이 없다.
	
	// [APP_SET]
	// 통신을 시도할 때 서버로부터 응답을 기다리는 최대의 시간을 셋팅해줌.
	// 너무 오랜시간을 셋팅하면 사용자가 다운된것처럼 생각할 수도 있음.
	// 60000 = 60초 = 1분
	#define	WAIT_TIME	3 * 60000	// 3분으로 셋팅
#endif // VER_DEBUG

#define RET_RETRY	-100

#define MAX_PACKET_SIZE	2048
#define STX		0x02
#define ETX 	0x03

// 패킷 인덱스
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

#define	ID_SOCK_RETRY	GID_SOCK_RETRY	// Socket 통신 연결 재시도 확인
#define	ID_SOCK_CANCEL	GID_SOCK_CANCEL	// Socket 통신 연결 재시도 취소
#define	ID_SOCK_ERROR	GID_SOCK_ERROR	// Socket 통신 에러

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
#define ERR_SVR_RES_FAIL	-12		//서버 응답 없음
#define ERR_SVR_CON_FAIL	-13		//서버 접속 중단

global	quad	g_HostIP;		// 서버 접속 IP
global	quad	g_HostPort;		// 서버 접속 포트번호
global 	quad 	g_nSockTimeOut;	// 소켓 통신 타임 아웃.
global	byte	g_DataBuffer[MAX_PACKET_SIZE];	// 서버에서 수신한 데이터 저장 버퍼
global	long	g_nDummy;

// 통신 관련
global	long	g_Sock_SetDummy ( long* pnDummy );
global	long 	g_SeverConnection(void);
global	long	g_SocketConnect(void);
global	long	g_Sock_DataSend(char CompanyID, char * TRCode, char TRClass, char TRType, byte *Buf, long BufSize, long nTimeOut );
global	long 	g_Sock_DataReceive( char* TRCode, long nTimeOut);
global	long 	g_Sock_PacketRead( byte *Buf, long BufSize, char *TRCode, long nTimeOut );
global	void 	g_Sock_Close(void);

//2005-10-11 jysim
global	void 	g_Sock_Close_Only(void);

// 끝

#endif	//_SOCKET_H_
