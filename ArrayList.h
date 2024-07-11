/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : ArrayList

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#ifndef		__CARRAYLIST_H__
#define		__CARRAYLIST_H__

#include	"pwrlove.h"

//[����] setDestroy
//�÷��ǿ��� ��ü �������� ���, �Ҹ��ڸ� ��Ȯ�� ȣ���� �־�� ��.
//����, setDestroy �Ž�忡 ����� �� ��ü�� �ش�Ǵ� �Ҹ��� �����͸� ������ �־�� �Ѵ�.
//�׷��� ���� ���, ��ü�� ���ŵ�����, ��ü���� ������ ���� ��ü���� �޸� ������ ���� �ȴ�.
//�� �κ��� CPP�� ������� �ʴ� ������ ������ ���̴�.
//���� ������ C�� �̿��� ���� �÷��� ��ü�� ����� ���, 
//1)�÷��� ��ü�� �� ���ҵ��� ���� �����Ͽ� �ش� �Ҹ��ڸ� ���� �����ϰų�,
//2)setDestroy�� ���� ��ü ���ҵ��� �Ҹ��� �Լ� �����͸� �����ؼ� �ϰ������� ����(remove, removeAll)
//  �ؾ߸� �Ѵ�.
//========================================================================================
//1. ��ũ�� ���𿵿�
//========================================================================================
#define ArrayList_LOCAL

#define ArrayList_malloc	CM_malloc
#define ArrayList_free		CM_free

#define ArrayList_memset	CM_memset
#define ArrayList_memcpy	CM_memcpy
#define ArrayList_strlen	CM_strlen
#define ArrayList_strcpy	CM_strcpy

#define ArrayList_STR		1
#define ArrayList_BIN		2
#define ArrayList_PTR		3
#define ArrayList_INT		4

#define ArrayList_Type_Const	0	//addStr("text"); 	=> ����� �Է�, ArrayList_free�� �ȵ�.
#define ArrayList_Type_Alloc	1	//addStr(ptr); 		=> �Ҵ� ��, �����ͷ� �Ѱ� �� ArrayList_free �ؾ� ��.

//========================================================================================
//2. Ŭ���� �Ž�� ����
//========================================================================================
#define __CARRAYLIST_CLASS_METHODS()		\
		_DEF_FPTR ( setElement		);		\
		_DEF_FPTR ( isEmpty			);		\
		_DEF_FPTR ( add				);		\
		_DEF_FPTR ( addAt			);		\
		_DEF_FPTR ( addInt			);		\
		_DEF_FPTR ( addStr			);		\
		_DEF_FPTR ( addBin			);		\
		_DEF_FPTR ( append			);		\
		_DEF_FPTR ( get				);		\
		_DEF_FPTR ( getInt			);		\
		_DEF_FPTR ( getStr			);		\
		_DEF_FPTR ( getType			);		\
		_DEF_FPTR ( getSize			);		\
		_DEF_FPTR ( getBuffer		);		\
		_DEF_FPTR ( setDestroy		);		\
		_DEF_FPTR ( removeAt		);		\
		_DEF_FPTR ( removeAll		);		\
		_DEF_FPTR ( front			);		\
		_DEF_FPTR ( last			);		\
		_DEF_FPTR ( next			);		\
		_DEF_FPTR ( prev			);		\
		_DEF_FPTR ( back			);		\
		_DEF_FPTR ( size			);		\
		_DEF_FPTR ( clone			);		\
		_DEF_FPTR ( print			) 
	
#define __CARRAYLIST_CLASS_METHODS_PROTOTYPES()\
		_TYPEDEF  void* ( _X( setElement	)) ( void*, long, void*, long	);\
		_TYPEDEF  BOOL  ( _X( isEmpty		)) ( void*						);\
		_TYPEDEF  long  ( _X( add			)) ( void*, void*				);\
		_TYPEDEF  long  ( _X( addAt			)) ( void*, long, void*			);\
		_TYPEDEF  long  ( _X( addInt		)) ( void*, long				);\
		_TYPEDEF  long  ( _X( addStr		)) ( void*, char*				);\
		_TYPEDEF  long  ( _X( addBin		)) ( void*, void*, long			);\
		_TYPEDEF  long  ( _X( append		)) ( void*, char*				);\
		_TYPEDEF  void* ( _X( get			)) ( void*, long				);\
		_TYPEDEF  long  ( _X( getInt		)) ( void*, long				);\
		_TYPEDEF  char* ( _X( getStr		)) ( void*, long				);\
		_TYPEDEF  long  ( _X( getType		)) ( void*, void*				);\
		_TYPEDEF  long  ( _X( getSize		)) ( void*, void*				);\
		_TYPEDEF  void* ( _X( getBuffer		)) ( void*, void*				);\
		_TYPEDEF  long	( _X( setDestroy	)) ( void*, void*				);\
		_TYPEDEF  long  ( _X( removeAt		)) ( void*, long				);\
		_TYPEDEF  long  ( _X( removeAll		)) ( void*						);\
		_TYPEDEF  void* ( _X( front			)) ( void*						);\
		_TYPEDEF  void* ( _X( last			)) ( void*						);\
		_TYPEDEF  void* ( _X( next			)) ( void*						);\
		_TYPEDEF  void* ( _X( prev			)) ( void*						);\
		_TYPEDEF  void* ( _X( back			)) ( void*						);\
		_TYPEDEF  long  ( _X( size			)) ( void*						);\
		_TYPEDEF  void* ( _X( clone			)) ( void*						);\
		_TYPEDEF  long  ( _X( print			)) ( void*						)

//========================================================================================
//3. �Լ� ������ ���𿵿�
//========================================================================================
#define _TYPEDEF	typedef
#define _X(f)		*CARRAYLIST_##f

		__CARRAYLIST_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//4. �Լ� ����
//========================================================================================
#define _TYPEDEF	ArrayList_LOCAL
#define _X(f)	ArrayList_##f

		__CARRAYLIST_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//5. ����ü ���� (Ŭ����)
//========================================================================================
typedef struct _ArrayElement
{
	long m_nType;
	//void* m_pKey;
	long m_nSize;
	void* m_pData;

} ArrayElement;

struct _Element
{
	ArrayElement* e;		// the element value
	struct _Element* n;		// the next element (NULL for the latest)
};

typedef struct _Element	Element;

typedef struct _ArrayList
{
	long	m_nMagic;
	void*	m_pThis;

	//Ŭ���� ���� ����
	Element* head;
	Element* lastElement;

	Element* iterator;

	void*	m_pDestroy;
	long	count;
	
	long	type;		//0 : ������� Ÿ��, 1: �Ҵ�Ÿ��

	#define _DEF_FPTR(f)	CARRAYLIST_##f f
	
	//Ŭ���� �Ž�� ����
	__CARRAYLIST_CLASS_METHODS();

	#undef _DEF_FPTR

} ArrayList, *CARRAYLIST;

#ifdef __cplusplus
extern "C" {
#endif

CARRAYLIST NewArrayList (void);
CARRAYLIST NewArrayListAlloc (void);
CARRAYLIST NewArrayListEx (long type);

#define DelArrayList(p) _DelArrayList(&p)
long _DelArrayList (CARRAYLIST pp[]);

#ifdef __cplusplus
}
#endif

#endif	//	__CARRAYLIST_H__
