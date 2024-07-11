#ifndef		LIBSYSDEF_H
#define		LIBSYSDEF_H

//------------------------------------------------------------------------------
//		card
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//		database
//------------------------------------------------------------------------------
#define		VD_INVALID_OID				0xFFFFFFFF

// db type
#define		VD_INVALID_DBTYPE			0
#define		VD_NULL_DBTYPE				0
#define		VD_BACKUP_DBTYPE			1

// field ID
#define		VD_INVALID_FIELDID			0
#define		VD_NULL_FIELDID				0
#define		VD_DB_VALUETYPE_INT			0x01000000
#define		VD_DB_VALUETYPE_TIME		0x02000000
#define		VD_DB_VALUETYPE_STR			0x04000000
#define		VD_DB_VALUETYPE_BIN			0x08000000

// sort desc
#define		VD_DB_SORT_DESCENDING		0x01
#define		VD_DB_SORT_CASEINSENSTIVE	0x02
#define		VD_DB_SORT_UNKNOWNFIRST		0x04

// handle
#define		VD_DB_NULL_HANDLE			0x000000FC
#define		VD_DB_INVALID_HANDLE		0x000000FC

// search type
#define		VD_DB_SEARCH_SMALLER		0
#define		VD_DB_SEARCH_FIRSTEQUAL		1
#define		VD_DB_SEARCH_NEXTEQUAL		2
#define		VD_DB_SEARCH_GREATER		3

// postype
#define		VD_DB_SEQ_START				0
#define		VD_DB_SEQ_CURRENT			1
#define		VD_DB_SEQ_END				2

// search condition
#define		VD_DB_NOTEQUAL_CON			0x00000010
#define		VD_DB_EQUAL_CON				0x00000001
#define		VD_DB_GREATER_CON			0x00000002
#define		VD_DB_SMALLER_CON			0x00000008
#define		VD_DB_MATCHSTR_CON			0x00000014
#define		VD_DB_AND_CON				0x00000001
#define		VD_DB_OR_CON				0x00000002

//palm과 같이 하나의 필드만 가능한 경우의 필드 아이디
#define		VD_DB_SINGLE_FIELDID		0x0800feff

//cellvic에서 사용되는 바이너리 필드
#define		VD_DB_BINDATA_FIELDID		0x0800feff
//cellvic에서 사용되는 소트 int(4byte) 필드 아이디
#define		VD_DB_SORTINT_FIELDID		0x0100fffe
//cellvic에서 사용되는 소트 타임 필드 아이디(4byte time_t타입)
#define		VD_DB_SORTTIME_FIELDID		0x0200fffe
//cellvic에서 사용되는 소트 스트링 필드 아이디
#define		VD_DB_SORTSTRING_FIELDID	0x0400fffe

//------------------------------------------------------------------------------
//		file system
//------------------------------------------------------------------------------
// open mode
#define		FS_READ_MODE				0x01
#define		FS_WRITE_MODE				0x02

// write open flag
#define		FS_NORMAL_FLAG				0x01
#define		FS_CREATE_FLAG				0x02

// seek origin
#define		FS_SEEK_CURRENT				1
#define		FS_SEEK_FROM_END			2
#define		FS_SEEK_FROM_SET			3

//------------------------------------------------------------------------------
//		memory
//------------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//		ppp
//-----------------------------------------------------------------------------
// dkjung 2003-03-08
// ppp connection device type
#define		PPP_DIRECT					1	// PC와 연결되어 있다(연결을 끊지 않는다.)
#define		PPP_MODEM					2	// Modem과 연결되어 있다(연결을 끊는다.)

//-----------------------------------------------------------------------------
//		secret
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//		socket
//-----------------------------------------------------------------------------


//------------------------------------------------------------------------------
//		string
//------------------------------------------------------------------------------

#define		STRCHG_CONV_ZERO_TO_SPACE	0x00000001
#define		STRCHG_DEL_SPACE_TO_LEFT	0x00000002
#define		STRCHG_DEL_SPACE_TO_RIGHT	0x00000003
#define		STRCHG_DEL_RIGHT_SPACE		0x00000004
#define		STRCHG_DEL_ALL_SPACE		0x00000005
#define		STRCHG_INS_COMMA			0x00000006
#define		STRCHG_DEL_NONDIGIT			0x00000007
#define		STRCHG_DEL_NONDIGITSIGN		0x00000008

//------------------------------------------------------------------------------
//		time
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//		timer
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//		telephony api
//------------------------------------------------------------------------------

// sound
#define		SOUND_CLICK					1	
#define		SOUND_WARNING				2
#define		SOUND_ERROR					3	


//-----------------------------------------------------------------------------
//		uart
//-----------------------------------------------------------------------------
//	Uart_Open(0, 0, 0, 0); 오픈시 아래의 정의되지 않은 값이면 모두 default 처리된다.
// uart baud rate
#define		UART_BAUD_9600				1
#define		UART_BAUD_19200				2
#define		UART_BAUD_38400				3
#define		UART_BAUD_57600				4
#define		UART_BAUD_115200			5	// default
#define		UART_BUAD_4800					6
#define		UART_BUAD_2400					7
#define		UART_BUAD_1200					8
#define		UART_BUAD_600					9
#define		UART_BUAD_300					10
#define		UART_BUAD_128000				11
#define		UART_BUAD_256000				12
#define		UART_BUAD_14400					13
#define		UART_BAUD_110					14
#define		UART_BAUD_56000					15

	
// uart data bit
#define		UART_DATABIT_7				1
#define		UART_DATABIT_8				2	// default

// uart parity bit
#define		UART_PARITY_NONE			1	// default
#define		UART_PARITY_EVEN			2
#define		UART_PARITY_ODD				3

//	uart stop bit
#define		UART_STOPBIT_1				1	// default
#define		UART_STOPBIT_2				2


//------------------------------------------------------------------------------
//		print and error
//------------------------------------------------------------------------------

// jhkang: 블루버드 BIP1000 프린트 상수
#define PRINT_DEFAULT		0		//Left Alighn, Normal Size, No Emphasize
#define PRINT_EMPHASIZE		1
#define PRINT_CENTERALIGN	2
#define PRINT_RIGHTALIGN	4
#define PRINT_DOUBLEWIDTH	8
#define PRINT_DOUBLEHEIGHT	16
#define PRINT_DOUBLESIZE	24
#define PRINT_UNDERLINE		32

// dump mode
#define		DUMP_ASCII					1
#define		DUMP_HEX					2

//------------------------------------------------------------------------------
//		mpop30 messaging protocol control flags
//------------------------------------------------------------------------------

#define		SMARTNET_CTRL_CNTL				0x01	// management control flag.
#define		SMARTNET_CTRL_ENC				0x02	// encryption flag.
#define		SMARTNET_CTRL_COMP				0x04	// data compression flag.
#define		SMARTNET_CTRL_MEM				0x08	// memory storage flag.
#define		SMARTNET_CTRL_CONT				0x08	// message passing control flag.
#define		SMARTNET_CTRL_RAW				0x10	// raw longerface request.
	
#define 	SMARTNET_STATUS_NOUSE			0x00	// status is not used.
#define		SMARTNET_STATUS_ACK				0x01	// ACK response.
#define		SMARTNET_STATUS_NACK			0x02	// NACK response.
#define		SMARTNET_STATUS_ECHO			0x04	// ECHO request.
#define		SMARTNET_STATUS_CLOSE			0x08	// Shutdown this connection.

//------------------------------------------------------------------------------
//		camera capture size
//------------------------------------------------------------------------------

#define	CAPTURE_160x120		2
#define	CAPTURE_320x240		3
#define	CAPTURE_640x480		4
#define	CAPTURE_1280x1024	5


//------------------------------------------------------------------------------
//		flags about convert image
//------------------------------------------------------------------------------

// define Image Format
#define	JPGTOBIN						1
#define	BMPTOBIN						2
#define	JPGTOBMP						3


// 2008-01-30 kyryu	삼성 빅솔론 프린터 정보 추가
//------------------------------------------------------------------------------
//		PRINTER - SAMSUNG : BIXOLON
//------------------------------------------------------------------------------
//Alignment Code
#define	BXL_ALIGNMENT_LEFT		0x00000000
#define	BXL_ALIGNMENT_CENTER	0x00000001
#define	BXL_ALIGNMENT_RIGHT		0x00000002

//Text Attribute
// 8 7 6 5 4 3  2      1 
//             BOLD   FONT AorB
//Font Attribute 기본 값 : not Bold, FontA, not Underline, not reverse
#define	BXL_FT_DEFAULT		0x00000000
#define	BXL_FT_FONTB		0x00000100
#define	BXL_FT_BOLD			0x00000200
#define	BXL_FT_UNDERLINE	0x00000400
#define	BXL_FT_REVERSE		0x00000800

//Text Size Attribute(WIDTH)
#define	BXL_TS_0WIDTH	0x00000000
#define	BXL_TS_1WIDTH	0x00000010
#define	BXL_TS_2WIDTH	0x00000020
#define	BXL_TS_3WIDTH	0x00000030
#define	BXL_TS_4WIDTH	0x00000040
#define	BXL_TS_5WIDTH	0x00000050
#define	BXL_TS_6WIDTH	0x00000060
#define	BXL_TS_7WIDTH	0x00000070
//Text Size Attribute(HEIGHT)
#define	BXL_TS_0HEIGHT	0x00000000
#define	BXL_TS_1HEIGHT	0x00000001
#define	BXL_TS_2HEIGHT	0x00000002
#define	BXL_TS_3HEIGHT	0x00000003
#define	BXL_TS_4HEIGHT	0x00000004
#define	BXL_TS_5HEIGHT	0x00000005
#define	BXL_TS_6HEIGHT	0x00000006
#define	BXL_TS_7HEIGHT	0x00000007

//------------------------------------------------------------------------------
//	SSL 
//------------------------------------------------------------------------------
#define	SSL_SOCK_ENABLE					1	//사용
#define	SSL_SOCK_DISABLE				0	//미사용

#endif	//	LIBSYSDEF_H


