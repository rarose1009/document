/*----------------------------------------------------------------------------------

	Project Name : SMART Client Application Framework
	
	SMART Application : CRow Class (데이터 객체)

	Copyright(c) 2014 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2009.09.22	dkjung		v1.00		: Create
----------------------------------------------------------------------------------*/

#ifndef		__CROW_H__
#define		__CROW_H__

//========================================================================================
//1. 매크로 선언영역
//========================================================================================
#define	CRow_LOCAL	
#define	DelCRow(p)	_DelCRow(&p)

#define CRow_malloc	Mem_Alloc 
#define CRow_free	Mem_Free 
#define CRow_memset	Mem_Set
#define CRow_memcpy	Mem_Cpy

//#define	CRow_ALIGN_DWORD(a)	((((a)+3)/4) * 4)

#define CRow_COL_INT		'X'
#define CRow_COL_STR		'C'
#define CRow_COL_BIN		'B'

//========================================================================================
//2. 클래스 매쏘드 정의
//========================================================================================
#define __CROW_CLASS_METHODS()					\
		DEF_FPTR ( Create				);		\
		DEF_FPTR ( Delete				);		\
		DEF_FPTR ( GetOid				);		\
		DEF_FPTR ( SetOid				);		\
		DEF_FPTR ( GetColCount			);		\
		DEF_FPTR ( SetColCount			);		\
		DEF_FPTR ( GetColData			);		\
		DEF_FPTR ( SetColData			);		\
		DEF_FPTR ( GetColType			);		\
		DEF_FPTR ( SetColType			);		\
		DEF_FPTR ( GetColSize			);		\
		DEF_FPTR ( SetColSize			);		\
		DEF_FPTR ( GetRowBuffer			);		\
		DEF_FPTR ( SetRowBuffer			);		\
		DEF_FPTR ( toString				)

#define __CROW_CLASS_METHODS_PROTOTYPES()\
		_TYPEDEF long  ( _X( Create			))	( void*, long, long		);\
		_TYPEDEF long  ( _X( Delete			))	( void*					);\
		_TYPEDEF long  ( _X( GetOid			))	( void*					);\
		_TYPEDEF long  ( _X( SetOid			))	( void*, long			);\
		_TYPEDEF long  ( _X( GetColCount	))	( void*					);\
		_TYPEDEF long  ( _X( SetColCount	))	( void*, long			);\
		_TYPEDEF void* ( _X( GetColData		))	( void*, long			);\
		_TYPEDEF long  ( _X( SetColData		))	( void*, long, void* 	);\
		_TYPEDEF char  ( _X( GetColType		))	( void*, long			);\
		_TYPEDEF long  ( _X( SetColType		))	( void*, long, char		);\
		_TYPEDEF long  ( _X( GetColSize		))	( void*, long			);\
		_TYPEDEF long  ( _X( SetColSize		))	( void*, long, long		);\
		_TYPEDEF void* ( _X( GetRowBuffer	))	( void*					);\
		_TYPEDEF long  ( _X( SetRowBuffer	))	( void*, void*, long	);\
		_TYPEDEF char* ( _X( toString		))	( void*					)

//========================================================================================
//3. 함수 포인터 선언영역
//========================================================================================
#define _TYPEDEF	typedef
#define _X(f)		*CROW_##f

__CROW_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//4. 함수 원형
//========================================================================================
#define _TYPEDEF	CRow_LOCAL
#define _X(f)	CRow_##f

__CROW_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//5. 구조체 원형 (클래스)
//========================================================================================

//MPLUS의 FIELD 구조체와 동일 (MDF와 호환 됨)
typedef struct _Record
{
	long	m_nOff;		//필드의 구조체 시작 위치 _FPOS() 매크로 이용
	long	m_nSize;
	long	m_nType;

} Record, *RECORD;

typedef struct _CRow
{
	//클래스 변수 영역
	long	m_nColCnt;
	long 	m_nLength;
	void*	m_pBuffer;

	long	m_nOid;
	RECORD	m_pCol;

	#define DEF_FPTR(f)	CROW_##f f
	
	//클래스 매쏘드 영역
	__CROW_CLASS_METHODS();

	#undef DEF_FPTR

} CRow, *CROW;

//========================================================================================
//6. static 함수 영역
//========================================================================================

//-----------------------------------------------------------
//생성자
CRow_LOCAL CROW NewRow (long nOid, long nColCnt, long nRowLen)
{
	CROW p;

	p = (CROW) CRow_malloc ( sizeof(CRow) );
	if (p == NULL)
	{
		return NULL;
	}

	//멤버 변수 초기화
	p->m_nColCnt = 0;
	p->m_nLength = 0;
	p->m_nOid	 = 0;
	p->m_pBuffer = NULL;
	
	#define DEF_FPTR(f)	p->f = (CROW_##f) CRow_##f
	
	//매쏘드 설정
	__CROW_CLASS_METHODS();
	
	#undef DEF_FPTR

	p->SetColCount(p, nColCnt);
	p->Create(p, nOid, nRowLen);

	return p;
}

//-----------------------------------------------------------
//소멸자
CRow_LOCAL long DelRow (CROW pp[])
{
	CROW p = *pp;

	if (!p)
	{
		return -1;
	}

	CRow_free ((byte*)p);
	*pp = NULL;

	return 0;
}

//========================================================================================
//7. 매쏘드 영역
//========================================================================================

//-----------------------------------------------------------
long CRow_Create ( void* p, long nOid, long nLen )
{
	CROW pThis = (CROW)p;
	long nCol;
	
	pThis->m_pBuffer = (char*)CRow_malloc(nLen);
	if (pThis->m_pBuffer == NULL)
	{
		return (-1);
	}

	pThis->m_nLength = nLen;

	nCol = pThis->GetColCount(pThis);
	if (nCol > 0)
	{
		pThis->m_pCol = (RECORD)CRow_malloc(nCol);
		if (pThis->m_pCol == NULL)
		{
			CRow_free(pThis->m_pBuffer);
			pThis->m_pBuffer = NULL;
			return (-2);
		}
	}

	pThis->SetOid(pThis, nOid);

	return nLen;
}

//-----------------------------------------------------------
long CRow_Delete ( void* p )
{
	CROW pThis = (CROW)p;

	if (pThis->m_pCol)
	{
		CRow_free((byte*)pThis->m_pCol);
		pThis->m_pCol = NULL;
	}

	if (pThis->m_pBuffer)
	{
		CRow_free((byte*)pThis->m_pBuffer);
		pThis->m_pBuffer = NULL;
	}

	return 0;
}

//-----------------------------------------------------------
long CRow_GetOid ( void* p )
{
	CROW pThis = (CROW)p;

	return (pThis->m_nOid);
}

//-----------------------------------------------------------
long CRow_SetOid ( void* p, long nOid )
{
	CROW pThis = (CROW)p;

	return (pThis->m_nOid = nOid);
}

//-----------------------------------------------------------
long CRow_GetColCount ( void* p )
{
	CROW pThis = (CROW)p;

	return (pThis->m_nColCnt);
}

//-----------------------------------------------------------
long CRow_SetColCount ( void* p, long nColCnt )
{
	CROW pThis = (CROW)p;

	return (pThis->m_nColCnt = nColCnt);
}

//-----------------------------------------------------------
void* CRow_GetColData ( void* p, long nIndex )
{
	CROW pThis = (CROW)p;

	if ( nIndex > pThis->m_nColCnt-1 )
	{
		return NULL;
	}

	return (char*)pThis->m_pBuffer + pThis->m_pCol[nIndex].m_nOff;
}

//-----------------------------------------------------------
long CRow_SetColData ( void* p, long nIndex, void* pData )
{
	CROW pThis = (CROW)p;

	if ( nIndex > pThis->m_nColCnt-1 )
	{
		return (-1);
	}

	//pThis->m_pCol[nIndex].m_nType = (long)cType;
	//pThis->m_pCol[nIndex].m_nSize = nSize;

	if (nIndex == 0)
	{
		pThis->m_pCol[nIndex].m_nOff = 0;
	}
	else
	{
		pThis->m_pCol[nIndex].m_nOff = pThis->m_pCol[nIndex-1].m_nOff+pThis->m_pCol[nIndex-1].m_nSize;
	}

	CRow_memcpy((byte*)&pThis->m_pBuffer+pThis->m_pCol[nIndex].m_nOff, (byte*)pData, pThis->m_pCol[nIndex].m_nSize);

	return (0);
}

//-----------------------------------------------------------
char CRow_GetColType ( void* p, long nIndex )
{
	CROW pThis = (CROW)p;

	return (char)pThis->m_pCol[nIndex].m_nType;
}

//-----------------------------------------------------------
long CRow_SetColType ( void* p, long nIndex, char cType )
{
	CROW pThis = (CROW)p;

	return (pThis->m_pCol[nIndex].m_nType = (char)cType);
}

//-----------------------------------------------------------
long CRow_GetColSize ( void* p, long nIndex )
{
	CROW pThis = (CROW)p;

	return pThis->m_pCol[nIndex].m_nSize;
}

//-----------------------------------------------------------
long CRow_SetColSize ( void* p, long nIndex, long nSize )
{
	CROW pThis = (CROW)p;

	return (pThis->m_pCol[nIndex].m_nSize = nSize);
}

//-----------------------------------------------------------
void* CRow_GetRowBuffer ( void* p )
{
	CROW pThis = (CROW)p;

	return pThis->m_pBuffer;
}

//-----------------------------------------------------------
long CRow_SetRowBuffer ( void* p, void* pBuf, long nLen )
{
	CROW pThis = (CROW)p;

	memcpy(pThis->m_pBuffer, pBuf, nLen);
	pThis->m_nLength = nLen;

	return nLen;
}

//-----------------------------------------------------------
char* CRow_toString(void* p)
{
	CROW pThis = (CROW)p;

	return "";
}

#endif // __CROW_H__
