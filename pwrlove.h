#ifndef		__PWRLOVE_H__
#define		__PWRLOVE_H__

//--------------------------------------------------------------------------
//  CORE_VERSION definition
//--------------------------------------------------------------------------
#if defined (SATURN_CORE_VERSION)
#undef  SATURN_CORE_VERSION
#endif

//dkjung 2012-05-01 버전관리 시작

//[Version Histroy]
#define SATURN_CORE_VERSION       2000    // CORE v2.0.0 2012년 5월 일 배포.

//--------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//		data type for common use
//
//		!!!!! NOTICE !!!!!!
//		1. Do not use other type
//		2. Do no use "typedef"
//-----------------------------------------------------------------------------
#ifndef		byte
#define		byte	unsigned char
#endif	//	byte

#ifndef		word
#define     word    unsigned short
#endif	//	word

#ifndef		quad
#define		quad	unsigned long
#endif	//	quad

#ifndef		bool
#define		bool	int
#endif	//	bool

#ifndef		BYTE
#define		BYTE	unsigned char
#endif	//	BYTE

#ifndef		WORD
#define     WORD    unsigned short
#endif	//	WORD

#ifndef		QUAD
#define		QUAD	unsigned long
#endif	//	QUAD

#ifndef		BOOL
#define		BOOL	int
#endif	//	BOOL

//-----------------------------------------------------------------------------
//		commonly used macros
//-----------------------------------------------------------------------------

#ifndef		TRUE
#define		TRUE	1
#endif	//	TRUE

#ifndef		FALSE
#define		FALSE	0
#endif	//	FALSE

#ifndef		SUCCESS
#define		SUCCESS	0
#endif	//	SUCCESS

#ifndef		FAIL
#define		FAIL	-1
#endif	//	FAIL

#ifndef		NULL
#define		NULL	0
#endif	//	NULL


//-----------------------------------------------------------------------------
//		commonly used macro functins
//-----------------------------------------------------------------------------

#ifndef		MAX
#define		MAX(x, y)		(((x) > (y)) ? (x) : (y))
#endif	//	MAX

#ifndef		MIN
#define		MIN(x, y)		(((x) < (y)) ? (x) : (y))
#endif	//	MIN

#define		ALIGN_DWORD(a)	((((a)+3)/4) * 4)

#ifndef		NULL_STR
#define		NULL_STR		0x00000001		//무조건 "" 로 저장
#endif	//	NULL_STR

#ifndef		NULL_INT
#define		NULL_INT		0x00000002		//무조건 0  로 저장	
#endif	//	NULL_INT

#ifndef		STR
#define		STR				0x00000003		//버퍼 값 저장			
#endif	//	STR

#ifndef		INT
#define		INT				0x00000004		//long 값저장
#endif	//	INT

#ifndef		BIN
#define		BIN				0x00000005		//버퍼 값 저장
#endif	//	BIN

#ifndef		FPOS
#define		FPOS(type, member)	((quad) &(((type *) 0)->member))
#endif //FPOS

#ifndef		FSIZ
#define		FSIZ(type, member)	sizeof(((type *) 0)->member)
#endif //FSIZ

// 필드 타입
#ifndef		FD_INT
#define		FD_INT		0x01000000
#endif //FD_INT

#ifndef		FD_TIME
#define		FD_TIME		0x02000000
#endif //FD_TIME

#ifndef		FD_STR
#define		FD_STR		0x04000000
#endif //FD_STR

#ifndef		FD_BIN
#define		FD_BIN		0x08000000
#endif //FD_BIN

// 소트 필드
#ifndef		FD_SORT
#define		FD_SORT		0x00800000
#endif //FD_SORT

#ifndef		XX_XXXX
#define		XX_XXXX		0x00000000
#endif //XX_XXXX

#ifndef		DBID
#define		DBID(id)		( ((id) << 16) & 0x007F0000 )
#endif //DBID

#ifndef		GET_DBID
#define		GET_DBID(field)	((field & 0x007F0000) >> 16)	
#endif //GET_DBID

#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif


typedef long ( *pDestroy )	( void* );

#define		CM_malloc		malloc
#define		CM_free			free
#define		CM_ISDANGLE(p)	(FALSE)
#define		CM_ISNULL(p)	(p == NULL || CM_ISDANGLE(p))	
#define		SERVICE_LEAK_PRINT(h)
#define		CM_CHECK()		{}

#define		CM_memset		Mem_Set
#define		CM_memcpy		Mem_Cpy

#define		CM_strlen		Str_Len
#define		CM_strcpy		Str_Cpy
#define		CM_strncpy		Str_NCpy
//#define		CM_strstr		strstr
#define		CM_strcat		Str_Cat
#define		CM_sprintf		sprintf
#define		CM_strcmp		Str_Cmp
#define		CM_strncmp		Str_NCmp
//#define		CM_stricmp		stricmp
#define		CM_atoi			Str_AtoI
#define		CM_itoa			Str_ItoA
//#define		CM_atof			atof
#define		CM_Sleep		VmSleep

#define		LOG_ERROR(fmt,a,b,c)
#define		LOG_DEBUG(fmt,a,b,c)
#define		assert(a)
#define		CM_NEW_CHECK(p)


#endif		// __COMDEF_H__


