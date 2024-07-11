/*----------------------------------------------------------------------------------
	Project Name: Smart HYGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2003.06.04	dkjung		v1.00		: Create
	
	2004.02.05	dkjung		v2.0		: mPOP 25.4 ���� mPOP 25.3�� ȣȯ���� ����
	2004.02.13	dkjung					: COMM_nS1R Ÿ�� �߰�
	2004.07.01	chan		v2.1		: COMM_nSnRZIP Ÿ�� �߰�
	
	2004.10.06	dkjung		v3.00		: Release ( ǥ�ظ��� : Comm )
										: �� ���� ����, ��� ������ ���Ϸ� ���� ����
										: �˷� �ֱ� �ٶ� ( dkjung@mcnc.co.kr )
	----------	------		------------------------------------------------------
	2004.12.09	dkjung		v3.01		: Tr �ڵ� ���� �κ� �и� ��.
	2014.10.01	dkjung		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/

#ifndef	__COMM_H__
#define	__COMM_H__

#include "Trdef.h"

	//-----------------------------------------------------------------------------
	//	TRCODE
	//-----------------------------------------------------------------------------
	#define BEGIN_TRCODE() 		enum {
	#define DEF_TRCODE(Code) 	TRC_##Code, 
	#define END_TRCODE() 		TRC_END};
	
	#ifndef ARR_TRCODE
		#error "Tr code should be decleared!"
	#endif // ARR_TRCODE

	//{COMM_1S1R, "9000", 'R', 'N', 20, 0, 17, 0, 0, 0, 0, 0, TRUE },
	#define DEF_TABLE( CommType, Code, TrClass, TrType, SndInfSiz, SndDatSiz, \
	                   RcvInfSiz, RcvDatSiz, MaxInfoPos, MaxInfoSiz, MaxRecNum, \
	                   PacketRecNum, InMsgDisplay, comment) \
	        {CommType, #Code, TrClass, TrType, SndInfSiz, SndDatSiz, \
             RcvInfSiz, RcvDatSiz, MaxInfoPos, MaxInfoSiz, MaxRecNum, \
             PacketRecNum, InMsgDisplay},

	#define DEF_INDEX( CommType, Code, TrClass, TrType, SndInfSiz, SndDatSiz, \
	                   RcvInfSiz, RcvDatSiz, MaxInfoPos, MaxInfoSiz, MaxRecNum, \
	                   PacketRecNum, InMsgDisplay, comment) \
			DEF_TRCODE ( Code )

	BEGIN_TRCODE()
	
		ARR_TRCODE (DEF_INDEX)
		
	END_TRCODE()

	//-----------------------------------------------------------------------------
	//	Definition & Macros
	//-----------------------------------------------------------------------------

	// ������Ʈ�� �����Ǿ�� �� �͵�...
	//----------------------------------------------------------------------------
	// [APP_SET]
	// ȸ�� ���̵�
	#define FIRM_ID			'H'		// COMPANY_ID
	
	// �������� �������� ���� �޽��� ������ �ִ� ����
	#define MAXLEN_MSG		150		// ���� �޽����� ���۸� �Ѿ�� ����� ���� ó�� ����.
	#define MAXLINE_MSG		18	

	// ��Ŷ�� ���� ������ ����Ͻ� �ڵ带 ������ ���.
	// g_Sock_SetDummy( long* pnDummy )
	#define COMM_SET_DUMMY(p)  g_Sock_SetDummy( (long*)&(p) )

	// dkjung 2003-06-07
	// ����� �ƴ� ��� ���ƾ� �Ѵ�.
	// ��Ŷ ��� ��� ������ ���� ���� �ʴ´�.
	// ���� �������� ��� ���ƾ� �Ѵ�.
	// [APP_SET]
	// ������ ��Ű�� ������ ������ ���� ��쿡�� (APP_COMM ���丮�� ����Ǵ� TR��� ����)
	// _COMM_DEBUG ���·� �״�� �ε��� ��.
	// ������ ���� , VER_RELEASE �ּ��� Ǯ���ָ� ��. �ϴ��� ������ �ʴ� ������ ó��.
	//#ifndef VER_RELEASE
		#define _COMM_DEBUG
	//#endif // VER_RELEASE

	#ifndef MessageBox
		#ifdef	_MESSAGE_H_
			#define	MessageBox(a,b,c,d,e,f)\
					{\
						g_MessageBox(a,b,c,d,e,f);\
						Dialog_Draw(g_hSubDlg, TRUE);\
						GrDev_Refresh();\
					}
					
			#define CloseMessageBox() g_Close_SubDlg()
		#else
			#error "MessageBox module(MessageBox.h) should be included."
		#endif // _MESSAGE_H_
	#endif // MessageBox

	#ifndef MAX
		#define MAX(a, b) (((a) > (b)) ? (a) : (b))
	#endif
	
	#ifndef MIN
		#define MIN(a, b) (((a) < (b)) ? (a) : (b))
	#endif

	// m_ucDbFlag
	#define DB_CREATE	0x01	// ���� �����ϴ� ���
	#define DB_APPEND	0x02	// ������ �����ϴ� ��� �߰��ϴ� ���.
	#define DB_USEIDX	0x10	// �ε��� �ʵ带 ��� ��. -> �ε��� �ʵ�� �׻� 0��° ��Ʈ
								// �ʵ�� �Ѵ�.

	typedef struct _stDataInfo
	{
		byte	m_ucDbFlag;
		char 	m_szDbTitle[32];
		char 	m_szDbName[32];
		long 	m_nTrCode;
		char 	m_szDatFile[32];
		long 	m_nSortFieldNum;
		long 	m_SortField[4];
		byte 	m_SortOrder[4];
		Record  m_stRec;
	} stDataInfo;	

	// ��� ���� ����
	#define	COMM_1S0R	 '0'		// 1 Packet Send.
	#define	COMM_1S1R	 '1'		// 1 Packet Send 1 Packet Recv.
	#define	COMM_nS0R	 '2'		// n Packet Send.
	#define	COMM_1SnR	 '3'		// 1 Packet Send n Packet Recv.
	#define	COMM_nS1R	 '4'		// n Packet Send 1 Packet Recv.
	#define	COMM_SZIP	 '6'		// ���� �۽�.
	#define	COMM_RZIP	 '7'		// ���� ����.
	
	typedef struct _TR_INFO
	{
		byte 	m_ucCommType;		// ��� ���� 
		char 	m_szCode[5];		// TR �ڵ�
		char 	m_chTrClass;		// TR Ŭ����
		char 	m_chTrType;			// TR Ÿ��
		word	m_wSndInfSiz;		// �۽� ��� ����
		word	m_wSndDatSiz;		// �۽� �ݺ� ������ ����
		word	m_wRcvInfSiz;		// ���� ��� ����
		word	m_wRcvDatSiz;		// ���� �ݺ� ������ ����
		long	m_nMaxInfoPos;		// ���������� �� ������ ������ ��ġ
		long	m_nMaxInfoSiz;		// ���������� �� ������ ǥ�� ����
		long	m_nMaxRecNum;		// TR�� �ִ� ���ڵ� ����
		long	m_nPacketRecNum;	// ��Ŷ�� �ִ� ���ڵ� ����
		char	m_bInMsgDisplay;	// ������ ���ſ����� ���θ޽����� ����Ұ����� ����(default�� TRUE�����ؾ� ��)	
	} TR_INFO;

	global const TR_INFO TrInfo[];

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
	#define ERR_NO_RESULT		-14		//���� ��� ����, ��� üũ ���� ����.
	

	//#define PACK_SIZE			21
	#define PACK_SIZE			27
	#define	DATASIZE			(2048-PACK_SIZE)
	#define	ZIPDATASIZE			(DATASIZE)

	//��Ŷ ��ſ� �ӽ� ���� ��� ũ��
	#define	COMM_ADD_INFO_SIZE 	32
	#define COMM_HEAD_SIZE		(80+COMM_ADD_INFO_SIZE)					//112
	#define COMM_HEAD_INFO		(16+COMM_ADD_INFO_SIZE)					//48
	#define	COMM_ADD_INFO 		(COMM_HEAD_INFO-(COMM_ADD_INFO_SIZE))	//16
	#define COMM_MSG_SIZE		(COMM_HEAD_SIZE-(COMM_HEAD_INFO))		//64
	
	// dkjung 2003-06-24
	// [APP_SET]
	// ���丮 ������ ������ ������.
	#define DIR_COMM_STR		"APP_COMM"
	#define DIR_COMM			DIR_COMM_STR "\\"

	#define SNDFILE				"SndDat.dat"
	#define SNDTMPFILE			"SndDat.tmp"
	#define SNDTMPZIPFILE		"SndZipDat.tmp"
	#define SNDZIPFILE			"SndDat.zip"
	#define REQUEST_FILE		DIR_COMM_STR "\\SndDat.dat"
	
	#define GET_DATA_POS(offset) ( COMM_HEAD_SIZE+(offset) )
	#define SET_DATA_POS(fd, offset) {FS_Seek (fd, COMM_HEAD_SIZE+offset, FS_SEEK_FROM_SET);}
	
	#define GET_RESULT_FILE		GET_RESULT_FILE_INDEX

	#define GET_RESULT_FILE_BY(func, file, nTr)	GET_RESULT_FILE_##func(file, nTr)
	#define GET_RESULT_FILE_CODE(file, nTrCode)\
			{\
				if (nTrCode < 1000)\
					Str_Printf (file, "%sRcv0%d", (quad)DIR_COMM, (quad)nTrCode, 0);\
				else\
					Str_Printf (file, "%sRcv%s", (quad)DIR_COMM, (quad)szTrCode, 0);\
			}
	#define GET_RESULT_FILE_INDEX(file, nTrIndex)\
			{\
				Str_Printf (file, "%sRcv%s", (quad)DIR_COMM, (quad)TrInfo[nTrIndex].m_szCode, 0);\
			}

	#define SET_RESULT_OK(fd)\
			{\
				FS_Seek (fd, COMM_HEAD_INFO, FS_SEEK_FROM_SET);\
				FS_Write (fd, (byte*)"SUCCESS", 7);\
			}
			
	#define IS_RESULT_OK(buf) (Str_Cmp ("SUCCESS", buf)==0)

	// Header Format
	#define HEAD_STR	"COM_FILE"
	#define COMFILE_SET_HEAD(fd, TrCode, TrClass, TrType)								\
			{																			\
				FS_Write (fd, (byte*)HEAD_STR,	8);										\
				FS_Write (fd, (byte*)TrCode,	4);										\
				FS_Write (fd, (byte*)&TrClass,	1);										\
				FS_Write (fd, (byte*)&TrType,	1);										\
				FS_Seek (fd, COMM_HEAD_SIZE, FS_SEEK_FROM_SET);							\
			}
			
	#define COMFILE_GET_HEAD(file, TrCode, TrClass, TrType)								\
			{																			\
				long	fd;																\
				char	szBuf[9];														\
				if ((fd = FS_Open (file, FS_READ_MODE, FS_NORMAL_FLAG)) >= 0)			\
				{																		\
					FS_Read (fd, (byte*)szBuf, 8);										\
					szBuf[8] = '\0';													\
					if (Str_Cmp (HEAD_STR, szBuf)==0)									\
					{																	\
						FS_Read (fd, (byte*)TrCode,		4);								\
						TrCode[4] = '\0';												\
						FS_Read (fd, (byte*)&TrClass,	1);								\
						FS_Read (fd, (byte*)&TrType,	1);								\
					}    \
					FS_Flush(fd);																	\
					FS_Close (fd);														\
					FS_Delete (file);													\
				}																		\
			}

	// TR CODE�� �ε����� ����
	#define GET_TRCODE(TrCode) TRC_##TrCode
	#define GET_TRINDEX(TrStr) GetTrIndex (TrStr)
	
	// dkjung 2003-08-04 �߰�
	// TR CODE�� �ִ� ���ڵ� ���� ����
	#define GET_MAX_RECNUM(TrCode)		TrInfo[TRC_##TrCode].m_nMaxRecNum
	#define GET_PACKET_RECNUM(TrCode)	TrInfo[TRC_##TrCode].m_nPacketRecNum
	#define GET_RCV_RECLEN(TrCode) 		TrInfo[TRC_##TrCode].m_wRcvDatSiz;

	// ���� �߰��Ǵ� API
	// dkjung 2004-02-15 
	#define RD	0
	#define WR	1
	#define COMM_FOPEN 		OpenCommFile
	#define COMM_FWRITE(fd, ofs, pBuf, size)										\
			{																		\
				if (comm_chMode == WR)												\
				{																	\
					COMFILE_WRITE(fd, ofs, (byte*)pBuf, size);						\
					ofs += size;													\
				}																	\
				else MessageBoxEx (ERROR_OK, "���� ������ ����!");				\
			}
			
	#define COMM_FREAD(fd, ofs, pBuf, size)											\
			{																		\
				if (comm_chMode == RD)												\
				{																	\
					FS_Seek (fd, COMM_HEAD_SIZE+ofs, FS_SEEK_FROM_SET);				\
					FS_Read (fd, (byte*)pBuf, size);								\
					ofs += size;													\
				}																	\
				else MessageBoxEx (ERROR_OK, "���� �б��� ����!");				\
			}

	#define COMM_FSEEK(fd, ofs) FS_Seek (fd, COMM_HEAD_SIZE+ofs, FS_SEEK_FROM_SET)
	#define COMM_FCLOSE 	COMFILE_CLOSE


	// ���� ������ ȣȯ�Ǵ� API
	#define COMFILE_OPEN	COMFILE_OPEN_CODE
	#define COMFILE_OPEN_BY(func, Tr, nDataNum)	COMFILE_OPEN_##func(Tr, nDataNum)
	#define COMFILE_OPEN_CODE(TrCode, nDataNum) CreateCommFile((TR_INFO*)&TrInfo[TRC_##TrCode], nDataNum)
	#define COMFILE_OPEN_INDEX(TrIndex, nDataNum) CreateCommFile((TR_INFO*)&TrInfo[TrIndex], nDataNum)

	#define COMFILE_WRITE(fd, ofs, pBuf, size)											\
			{																			\
				FS_Seek (fd, COMM_HEAD_SIZE+ofs, FS_SEEK_FROM_SET);						\
				FS_Write (fd, (byte*)pBuf, size);										\
			}

	#define COMFILE_CLOSE(fd)															\
			{																			\
				if (fd >= 0) {															\
				  FS_Flush(fd);																	\
					FS_Close (fd);	}													\
				fd = -1;																\
			}

	#define COMM_DATA	COMM_DATA_CODE
	#define COMM_DATA_BY(func, Tr, Title)	COMM_DATA_##func(Tr, Title)
	#define COMM_DATA_CODE(TrCode, Title) 	Comm_Data((TR_INFO*)&TrInfo[TRC_##TrCode], Title)
	#define COMM_DATA_INDEX(TrIndex, Title) Comm_Data((TR_INFO*)&TrInfo[TrIndex], Title)
	
//	#define COMDB_WRITE		Comm_SaveDB

	// dkjung 2003-06-13
	// ��Ž� �߻��� ������ ó���ؼ� ����� �ش�.
	#define	COMM_MSGBOX		Comm_GetMsg

	//-----------------------------------------------------------------------------
	//	Variables
	//-----------------------------------------------------------------------------
	global char comm_chMode;							// ��� ���� ���� ���
	global char m_MsgStr[MAXLEN_MSG];					// �޽��� ����.
	global char m_szReqTitle[32];						// ������Ʈ Ÿ��Ʋ.
	global char m_szReqFileName[42];					// ������Ʈ ���ϸ�.
	global char m_szResultFile[42];						// ���ŵ� �����͸� �����ϴ� ����.
	global byte m_DataBuf[DATASIZE+6];
	global TR_INFO m_stTr;
	
	//-----------------------------------------------------------------------------
	//	Functions
	//-----------------------------------------------------------------------------
	global	long OpenCommFile 		( char* pszTrCode, long nDataNum, long nMode );
	global  long GetTrIndex 		( char* pszTrCode );
	global	long CreateCommFile		( TR_INFO* pTr, long nDataNum );
	global	long Comm_Data 			( TR_INFO* pTr, char* pszTitle);
	global	void Comm_GetMsg		( long nErrCode );
//	global	bool Comm_SaveDB 		( stDataInfo* pstInfo );


#endif	//_COMM_H_
