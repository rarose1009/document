/*----------------------------------------------------------------------------------

	Project Name : SMART Client Application Framework
	
	SMART Application : RowSet Class

	Copyright(c) 2014 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2009.09.22	dkjung		v1.00		: Create
----------------------------------------------------------------------------------*/

#ifndef		__ROWSET_H__
#define		__ROWSET_H__

#include	"Vector.h"
#include	"Row.h"

//========================================================================================
//1. 매크로 선언영역
//========================================================================================
#define	RowSet_LOCAL	
#define	DelRowSet(p)	_DelRowSet(&p)

#define RowSet_malloc	Mem_Alloc
#define RowSet_free		Mem_Free
#define RowSet_memset	Mem_Set
#define RowSet_memcpy	Mem_Cpy

#define RowSet_COL_INT		'X'
#define RowSet_COL_STR		'C'
#define RowSet_COL_BIN		'B'

typedef struct _Col
{
	long	m_nType;
	long	m_nSize;
	void*	m_pData;

} Col, *COL;

//========================================================================================
//2. 클래스 매쏘드 정의
//========================================================================================
#define __CROWSET_CLASS_METHODS()		\
		DEF_FPTR ( CreateRow	);		\
		DEF_FPTR ( DeleteRow	);		\
		DEF_FPTR ( OpenEnumRow	);		\
		DEF_FPTR ( CloseEnumRow	);		\
		DEF_FPTR ( GetEnumRow	);		\
		DEF_FPTR ( FindRow		);		\
		DEF_FPTR ( GetColType	);		\
		DEF_FPTR ( GetColSize	);		\
		DEF_FPTR ( GetColData	);		\
		DEF_FPTR ( ReadCol		);		\
		DEF_FPTR ( WriteCol		);		\
		DEF_FPTR ( ReadRow		);		\
		DEF_FPTR ( WriteRow		);		\
		DEF_FPTR ( toString		)

#define __CROWSET_CLASS_METHODS_PROTOTYPES()\
		_TYPEDEF long  ( _X( CreateRow	))	( void*						);\
		_TYPEDEF long  ( _X( DeleteRow	))	( void*, long				);\
		_TYPEDEF long  ( _X( OpenEnumRow))	( void*						);\
		_TYPEDEF long  ( _X( CloseEnumRow))	( void*						);\
		_TYPEDEF BOOL  ( _X( GetEnumRow	))	( void*						);\
		_TYPEDEF void* ( _X( FindRow	))	( void*, long				);\
		_TYPEDEF long  ( _X( GetColType ))	( void*, long, long			);\
		_TYPEDEF long  ( _X( GetColSize ))	( void*, long, long			);\
		_TYPEDEF long  ( _X( GetColData ))	( void*, long, long, void*	);\
		_TYPEDEF long  ( _X( ReadCol	))	( void*, long, long, COL	);\
		_TYPEDEF long  ( _X( WriteCol	))	( void*, long, long, COL	);\
		_TYPEDEF CROW  ( _X( ReadRow	))	( void*, long				);\
		_TYPEDEF long  ( _X( WriteRow	))	( void*, long, CROW			);\
		_TYPEDEF char* ( _X( toString	))	( void*						)

//========================================================================================
//3. 함수 포인터 선언영역
//========================================================================================
#define _TYPEDEF	typedef
#define _X(f)		*CROWSET_##f

__CROWSET_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//4. 함수 원형
//========================================================================================
#define _TYPEDEF	RowSet_LOCAL
#define _X(f)	RowSet_##f

__CROWSET_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//5. 구조체 원형 (클래스)
//========================================================================================

typedef struct _RowSet
{
	//클래스 변수 영역
	long		m_nColCnt;
	long		m_nRowCnt;
	long 		m_nRowLen;		//단위 레코드의 길이

	long		m_nCol;
	long		m_nOid;

	long		m_nCursor;
	BOOL		m_bOpen;
	CROW		m_cpRow;
	CVECTOR		m_cpRows;


	#define DEF_FPTR(f)	CROWSET_##f f
	
	//클래스 매쏘드 영역
	__CROWSET_CLASS_METHODS();

	#undef DEF_FPTR

} RowSet, *CROWSET;


//========================================================================================
//6. static 함수 영역
//========================================================================================

//-----------------------------------------------------------
//생성자
RowSet_LOCAL CROWSET NewRowSet (long nColCnt, long nRowLen)
{
	CROWSET p;

	p = (CROWSET) RowSet_malloc ( sizeof(RowSet) );
	if (p == NULL)
	{
		return NULL;
	}

	//멤버 변수 초기화
	p->m_nColCnt = nColCnt;
	p->m_nRowCnt = 0;
	p->m_nRowLen = nRowLen;

	p->m_nCol = 0;

	//p->m_pRowMeta = NULL;

	p->m_nOid = 0;
	p->m_bOpen = FALSE;
	p->m_cpRow = NULL;
	p->m_cpRows = NULL;
	
	#define DEF_FPTR(f)	p->f = (CROWSET_##f) RowSet_##f
	
	//매쏘드 설정
	__CROWSET_CLASS_METHODS();
	
	#undef DEF_FPTR

	//[주의] CRow의 크기를 초기화 해야 한다.
	p->m_cpRows = NewVector(sizeof(CRow), Vector_CAPACITY);
	if (p->m_cpRows == NULL)
	{
		RowSet_free ((byte*)p);
		return NULL;
	}

	return p;
}

//-----------------------------------------------------------
//소멸자
RowSet_LOCAL long _DelRowSet (CROWSET pp[])
{
	CROWSET p = *pp;

	if (!p)
	{
		return -1;
	}

	if (p->m_cpRows)
	{
		DelVector(p->m_cpRows);
	}

	RowSet_free ((byte*)p);
	*pp = NULL;

	return 0;
}

//========================================================================================
//7. 매쏘드 영역
//========================================================================================
//-----------------------------------------------------------
long RowSet_CreateRow ( void* p )
{
	CROWSET pThis = (CROWSET)p;
	CVECTOR v = pThis->m_cpRows;
	long nOid = pThis->m_nOid;

	CROW pRow = NewRow(nOid, pThis->m_nColCnt, pThis->m_nRowLen);
	if (pRow == NULL)
	{
		return (-1);
	}

	v->AddElement (v, pRow);

	DelRow(&pRow);

	pThis->m_nRowCnt++;

	//Object id를 생성한다.
	pThis->m_nOid++;
	return nOid;
}

//-----------------------------------------------------------
long RowSet_DeleteRow ( void* p, long nOid )
{
	CROWSET pThis = (CROWSET)p;
	CVECTOR v = pThis->m_cpRows;
	CROW pRow = NULL;
	long i;
	long n = v->Size(v);

	for (i=0; i<n; i++)
	{
		pRow = (CROW)v->ElementAt(v, i);
		if (pRow->GetOid(pRow) == nOid)
		{
			//일치되는 Object id를 삭제.
			v->Remove(v, i);
			pThis->m_nRowCnt--;
			return 0;
		}
	}

	return -1;
}

//-----------------------------------------------------------
long RowSet_GetColCount ( void* p )
{
	CROWSET pThis = (CROWSET)p;

	return (pThis->m_nColCnt);
}

//-----------------------------------------------------------
long RowSet_GetRowCount ( void*	p )
{
	CROWSET pThis = (CROWSET)p;

	return (pThis->m_nRowCnt);
}

//-----------------------------------------------------------
long RowSet_OpenEnumRow ( void* p )
{
	CROWSET pThis = (CROWSET)p;

	pThis->m_nCursor = 0;
	pThis->m_cpRow = NULL;

	pThis->m_bOpen = TRUE;

	return 0;
}

//-----------------------------------------------------------
long RowSet_CloseEnumRow ( void* p )
{
	CROWSET pThis = (CROWSET)p;

	pThis->m_nCursor = 0;
	pThis->m_cpRow = NULL;

	pThis->m_bOpen = FALSE;

	return 0;
}

//-----------------------------------------------------------
BOOL RowSet_GetEnumRow ( void* p )
{
	CROWSET pThis = (CROWSET)p;

	if (pThis->m_bOpen)
	{
		CVECTOR v = pThis->m_cpRows;

		pThis->m_cpRow = (CROW)v->ElementAt(v, pThis->m_nCursor++);

		if (pThis->m_cpRow)
		{
			return TRUE;
		}
	}

	return FALSE;
}

//-----------------------------------------------------------
void* RowSet_FindRow ( void* p, long nOid )
{
	CROWSET pThis = (CROWSET)p;
	CVECTOR v = pThis->m_cpRows;
	CROW pRow = NULL;

	long i;
	long n = v->Size(v);

	for (i=0; i<n; i++)
	{
		pRow = (CROW)v->ElementAt(v, i);
		if (pRow->GetOid(pRow) == nOid)
		{
			return pRow;
		}
	}
	return NULL;
}

//-----------------------------------------------------------
long RowSet_GetColType ( void* p, long nOid, long nCol )
{
	CROWSET pThis = (CROWSET)p;
	CROW pRow = NULL;

	pRow = (CROW)pThis->FindRow(pThis, nOid);
	if (pRow)
	{
		return pRow->GetColType(pRow, nCol);
	}

	return -1;
}

//-----------------------------------------------------------
long RowSet_GetColSize ( void* p, long nOid, long nCol )
{
	CROWSET pThis = (CROWSET)p;
	CROW pRow = NULL;

	pRow = (CROW)pThis->FindRow(pThis, nOid);
	if (pRow)
	{
		return pRow->GetColSize(pRow, nCol);
	}

	return 0;
}

//-----------------------------------------------------------
long RowSet_GetColData ( void* p, long nOid, long nCol, void* pData )
{
	CROWSET pThis = (CROWSET)p;
	CROW pRow = NULL;
	long nSize = 0;

	pRow = (CROW)pThis->FindRow(pThis, nOid);
	if (pRow)
	{
		nSize = pRow->GetColSize(pRow, nCol);
		memcpy(pData, pRow->GetColData(pRow, nCol), nSize);
		return nSize;
	}

	return 0;
}

//-----------------------------------------------------------
long RowSet_ReadCol ( void* p, long nOid, long nCol, COL pCol )
{
	CROWSET pThis = (CROWSET)p;
	CROW pRow = NULL;

	pRow = (CROW)pThis->FindRow(pThis, nOid);
	if (pRow)
	{
		pCol->m_nType = pRow->GetColType(pRow, nCol);
		pCol->m_nSize = pRow->GetColSize(pRow, nCol);
		memcpy(pCol->m_pData, pRow->GetColData(pRow, nCol), pCol->m_nSize);
		return pCol->m_nSize;
	}

	return 0;
}

//-----------------------------------------------------------
long RowSet_WriteCol ( void* p, long nOid, long nCol, COL pCol )
{
	CROWSET pThis = (CROWSET)p;
	CROW pRow = NULL;

	pRow = (CROW)pThis->FindRow(pThis, nOid);
	if (pRow)
	{
		pRow->SetColType(pRow, nCol, (char)pCol->m_nType);
		pRow->SetColSize(pRow, nCol, pCol->m_nSize);
		pRow->SetColData(pRow, nCol, pCol->m_pData);
		return pCol->m_nSize;
	}

	return 0;
}

//-----------------------------------------------------------
CROW RowSet_ReadRow ( void* p, long nOid )
{
	CROWSET pThis = (CROWSET)p;

	return (CROW)pThis->FindRow(pThis, nOid);
}

//-----------------------------------------------------------
long RowSet_WriteRow ( void* p, long nOid, CROW pRow )
{
	CROWSET pThis = (CROWSET)p;
	CROW r = NULL;

	r = (CROW)pThis->FindRow(pThis, nOid);
	if (r)
	{
		*r = *pRow;
		return 0;
	}

	return -1;
}

//-----------------------------------------------------------
char* RowSet_toString(void* p)
{
	CROWSET pThis = (CROWSET)p;

	return "";
}


#endif // __CROWSET_H__
