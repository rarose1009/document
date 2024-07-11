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

//[주의] setDestroy
//컬렉션에서 객체 포인터일 경우, 소멸자를 정확히 호출해 주어야 함.
//따라서, setDestroy 매쏘드에 저장된 각 객체의 해당되는 소멸자 포인터를 설정해 주어야 한다.
//그렇지 않을 경우, 객체는 제거되지만, 객체내의 생성된 연결 객체들은 메모리 릭으로 남게 된다.
//이 부분이 CPP을 사용하지 않는 결정적 불편한 점이다.
//따라서 가급적 C를 이용한 범용 컬렉션 객체를 사용할 경우, 
//1)컬렉션 객체의 각 원소들을 직접 접근하여 해당 소멸자를 통해 해제하거나,
//2)setDestroy에 사용된 객체 원소들의 소멸자 함수 포인터를 설정해서 일괄적으로 제거(remove, removeAll)
//  해야만 한다.
//========================================================================================
//1. 매크로 선언영역
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

#define ArrayList_Type_Const	0	//addStr("text"); 	=> 상수로 입력, ArrayList_free가 안됨.
#define ArrayList_Type_Alloc	1	//addStr(ptr); 		=> 할당 후, 포인터로 넘겨 줌 ArrayList_free 해야 됨.

//========================================================================================
//2. 클래스 매쏘드 정의
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
//3. 함수 포인터 선언영역
//========================================================================================
#define _TYPEDEF	typedef
#define _X(f)		*CARRAYLIST_##f

		__CARRAYLIST_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//4. 함수 원형
//========================================================================================
#define _TYPEDEF	ArrayList_LOCAL
#define _X(f)	ArrayList_##f

		__CARRAYLIST_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//5. 구조체 원형 (클래스)
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

	//클래스 변수 영역
	Element* head;
	Element* lastElement;

	Element* iterator;

	void*	m_pDestroy;
	long	count;
	
	long	type;		//0 : 상수참조 타입, 1: 할당타입

	#define _DEF_FPTR(f)	CARRAYLIST_##f f
	
	//클래스 매쏘드 영역
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
