#ifndef		ERRS_H
#define		ERRS_H

//------------------------------------------------------------------------------
//		card
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//		database
//------------------------------------------------------------------------------
#define		DB_TOO_MANY_DESCRIPTOR				0xdb01
#define		DB_INVALID_DB_NAME					0xdb02
#define		DB_INVALID_SORT_FIELD				0xdb03
#define		DB_INVALID_DB_NAME_OR_ALREAY_OPEN	0xdb04
#define		DB_INVALID_DB_HANDLE				0xdb05
#define		DB_INVALID_HANDLE_OR_OID			0xdb06
#define		DB_INVALID_FIELDID					0xdb07
#define		DB_TOO_MANY_OPEN_DATABASE			0xdb08
#define		DB_UNKNOWN_ERR						0xdb09
#define		DB_NOT_OPEN_DB						0xdb0a
#define		DB_NOT_CALLED_OPEN_RECORD			0xdb0b
#define		DB_INVALID_NAME_OR_ALREADY_OPEN_OR_FIELDID	0xdb0c

//------------------------------------------------------------------------------
//		file system
//------------------------------------------------------------------------------

#define		FS_ERR_NOT_INITIALIZED				0x0f01
#define		FS_ERR_ALREADY_OPEN					0x0f02
#define		FS_ERR_NO_SPACE						0x0f03
#define		FS_ERR_NOITEM						0x0f04
#define		FS_ERR_NOT_ENOUGH_MEMORY			0x0f05
#define		FS_ERR_INVALID_ARG					0x0f06
#define		FS_ERR_MAX_FILE						0x0f07
#define		FS_ERR_EOF							0x0f08
#define		FS_ERR_DB_OPEN_FAIL					0x0f09
#define		FS_ERR_INVALID_NAME					0x0f0a
#define		FS_ERR_NO_SUCH_FILE					0x0f0b
#define		FS_ERR_NO_PERMISSION				0x0f0c
#define		FS_ERR_UNKNOWN						0x0f0d
#define		FS_ERR_ALREADY_EXIST				0x0f0e
#define		FS_ERR_INTERNAL_ERROR				0x0f0f
#define		FS_ERR_INVALID_FD					0x0f10
#define		FS_ERR_MAX_ENUM						0x0f11
#define		FS_ERR_NOT_EMPTY_DIRECTORY			0x0f12
#define		FS_ERR_TOO_MANY_FIND_OPEN			0x0f13
#define		FS_ERR_INVALID_BUFFER				0x0f14
#define		FS_ERR_COPY_SAME_FILE				0x0f15
#define		FS_ERR_NO_MORE_ITEM					0x0f16
#define		FS_ERR_INVALID_ENUM					0x0f17
#define		FS_ERR_NOT_SUPPORTED_YET			0x0fff


//------------------------------------------------------------------------------
//		memory
//------------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//		ppp
//-----------------------------------------------------------------------------
#define		PPP_ERR_FAIL						1
#define		PPP_ERR_CREATION_FAIL				2
#define		PPP_ERR_CONNECT_FAIL				3

//-----------------------------------------------------------------------------
//		secret
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//		socket
//-----------------------------------------------------------------------------
#define		SOCK_ERR_CREATION_FAIL				2
#define		SOCK_ERR_CONNECT_FAIL				3
#define		SOCK_ERR_NOT_CONNECTED				4
#define		SOCK_ERR_DISCONNECTED				5
#define		SOCK_ERR_INVALID_PARAMETER			6


//------------------------------------------------------------------------------
//		string
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//		time
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//		timer
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//		telephony api
//------------------------------------------------------------------------------


//-----------------------------------------------------------------------------
//		uart
//-----------------------------------------------------------------------------


//------------------------------------------------------------------------------
//		print and error
//------------------------------------------------------------------------------


#endif	//	ERRS_H

