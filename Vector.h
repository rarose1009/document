/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : Vector

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#ifndef		__CVECTOR_H__
#define		__CVECTOR_H__

#include	"pwrlove.h"
#include	"ArrayList.h"

//========================================================================================
//1. 매크로 선언영역
//========================================================================================
#define	Vector_LOCAL

#define Vector_malloc	CM_malloc
#define Vector_free		CM_free
#define Vector_memset	CM_memset
#define Vector_memcpy	CM_memcpy

#define Vector_BYTE		1
#define Vector_WORD		2
#define Vector_QUAD		4

#define Vector_CAPACITY	10

//========================================================================================
//2. 클래스 매쏘드 정의
//========================================================================================
#define __CVECTOR_CLASS_METHODS()				\
		_DEF_FPTR ( Capacity			);		\
		_DEF_FPTR ( Size				);		\
		_DEF_FPTR ( IsEmpty				);		\
		_DEF_FPTR ( Add					);		\
		_DEF_FPTR ( AddInt				);		\
		_DEF_FPTR ( AddElementAt		);		\
		_DEF_FPTR ( AddElement			);		\
		_DEF_FPTR ( Get					);		\
		_DEF_FPTR ( GetInt				);		\
		_DEF_FPTR ( ElementAt			);		\
		_DEF_FPTR ( IndexOf				);		\
		_DEF_FPTR ( LastIndexOf			);		\
		_DEF_FPTR ( FirstElement		);		\
		_DEF_FPTR ( LastElement			);		\
		_DEF_FPTR ( SetDestroy			);		\
		_DEF_FPTR ( Remove				);		\
		_DEF_FPTR ( RemoveAll			);		\
		_DEF_FPTR ( toString			)

#define __CVECTOR_CLASS_METHODS_PROTOTYPES()\
		_TYPEDEF long  ( _X( Capacity		))	( void*					);\
		_TYPEDEF long  ( _X( Size			))	( void*					);\
		_TYPEDEF BOOL  ( _X( IsEmpty		))	( void*					);\
		_TYPEDEF long  ( _X( Add			))	( void*, long, void*	);\
		_TYPEDEF long  ( _X( AddInt			))	( void*, long, long		);\
		_TYPEDEF long  ( _X( AddElementAt	))	( void*, long, void*	);\
		_TYPEDEF long  ( _X( AddElement		))	( void*, void*			);\
		_TYPEDEF void* ( _X( Get			))	( void*, long			);\
		_TYPEDEF long  ( _X( GetInt			))	( void*, long			);\
		_TYPEDEF void* ( _X( ElementAt		))	( void*, long			);\
		_TYPEDEF long  ( _X( IndexOf		))	( void*, void*, long	);\
		_TYPEDEF long  ( _X( LastIndexOf	))	( void*, void*, long	);\
		_TYPEDEF void* ( _X( FirstElement	))	( void*					);\
		_TYPEDEF void* ( _X( LastElement	))	( void*					);\
		_TYPEDEF long  ( _X( SetDestroy		))	( void*, void*			);\
		_TYPEDEF long  ( _X( Remove			))	( void*, long			);\
		_TYPEDEF long  ( _X( RemoveAll		))	( void*					);\
		_TYPEDEF char* ( _X( toString		))	( void*					)

//========================================================================================
//3. 함수 포인터 선언영역
//========================================================================================
#define _TYPEDEF	typedef
#define _X(f)		*CVECTOR_##f

__CVECTOR_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//4. 함수 원형
//========================================================================================
#define _TYPEDEF	Vector_LOCAL
#define _X(f)	Vector_##f

__CVECTOR_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//5. 구조체 원형 (클래스)
//========================================================================================
typedef struct _Vector
{
	long	m_nMagic;
	void*	m_pThis;

	//클래스 변수 영역
	long		m_nObjSize;
	long		m_nCapacity;
	long		m_nCount;

	long*		m_pIndex;
	CARRAYLIST	m_cpList;

	#define _DEF_FPTR(f)	CVECTOR_##f f
	
	//클래스 매쏘드 영역
	__CVECTOR_CLASS_METHODS();

	#undef _DEF_FPTR

} Vector, *CVECTOR;

#ifdef __cplusplus
extern "C" {
#endif

CVECTOR NewVector (long nObjSize, long nCapacity);

#define DelVector(p) _DelVector(&p)
long _DelVector (CVECTOR pp[]);

#ifdef __cplusplus
}
#endif

#endif // __CVECTOR_H__
