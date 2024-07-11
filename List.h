/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : List

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#ifndef		__CLIST_H__
#define		__CLIST_H__

#include	"pwrlove.h"

//========================================================================================
//1. ��ũ�� ���𿵿�
//========================================================================================
#define List_LOCAL

#define List_malloc		CM_malloc
#define List_free		CM_free

#define List_memset		CM_memset
#define List_memcpy		CM_memcpy

//========================================================================================
//2. Ŭ���� �Ž�� ����
//========================================================================================
#define __CLIST_CLASS_METHODS()			\
		_DEF_FPTR ( GetCount	);		\
		_DEF_FPTR ( Peek		);		\
		_DEF_FPTR ( Add			);		\
		_DEF_FPTR ( SetDestroy	);		\
		_DEF_FPTR ( Remove		);		\
		_DEF_FPTR ( RemoveAt	);		\
		_DEF_FPTR ( First		);		\
		_DEF_FPTR ( RemoveAll	);		\
		_DEF_FPTR ( Print		) 
	
#define __CLIST_CLASS_METHODS_PROTOTYPES()\
		_TYPEDEF  long  ( _X( GetCount	)) ( void*				);\
		_TYPEDEF  void* ( _X( Peek		)) ( void*, long		);\
		_TYPEDEF  long  ( _X( Add		)) ( void*, void*		);\
		_TYPEDEF  long  ( _X( SetDestroy)) ( void*, void*		);\
		_TYPEDEF  long  ( _X( Remove	)) ( void*				);\
		_TYPEDEF  long  ( _X( RemoveAt	)) ( void*, long		);\
		_TYPEDEF  void* ( _X( First		)) ( void*				);\
		_TYPEDEF  long  ( _X( RemoveAll	)) ( void*				);\
		_TYPEDEF  long  ( _X( Print		)) ( void*				)
								   
//========================================================================================
//3. �Լ� ������ ���𿵿�
//========================================================================================
#define _TYPEDEF	typedef
#define _X(f)		*CLIST_##f

		__CLIST_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//4. �Լ� ����
//========================================================================================
#define _TYPEDEF	List_LOCAL
#define _X(f)	List_##f

		__CLIST_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//5. ����ü ���� (Ŭ����)
//========================================================================================
struct _List_Item
{
	void* ptr;
	struct _List_Item* next;
};

typedef struct _List_Item	List_Item;

typedef struct _List
{
	long	m_nMagic;
	void*	m_pThis;

	//Ŭ���� ���� ����
	List_Item* m_head;
	List_Item* m_last;
	List_Item* m_iterator;

	void* m_pDestory;
	long m_nCount;

	#define _DEF_FPTR(f)	CLIST_##f f
	
	//Ŭ���� �Ž�� ����
	__CLIST_CLASS_METHODS();

	#undef _DEF_FPTR

} List, *CLIST;

#ifdef __cplusplus
extern "C" {
#endif

CLIST NewList (void);
long DelList (CLIST p);

#ifdef __cplusplus
}
#endif

#endif	//	__CLIST_H__
