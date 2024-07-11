/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : HashMap

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#ifndef		__CHASHMAP_H__
#define		__CHASHMAP_H__

#include	"pwrlove.h"
#include	"Vector.h"

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
#define HashMap_LOCAL

#define	HashMap_malloc			CM_malloc
#define	HashMap_free			CM_free

#define	HashMap_memset			CM_memset
#define	HashMap_memcpy			CM_memcpy
#define	HashMap_sprintf			CM_sprintf
#define	HashMap_strcpy			CM_strcpy
#define	HashMap_strlen			CM_strlen
#define	HashMap_strcmp			CM_strcmp
#define	HashMap_atoi			CM_atoi
#define	HashMap_itoa			CM_itoa

#define HashMap_NULL			0

#define HashMap_STR				1
#define HashMap_BIN				2

#define HashMap_KEY_SIZE		30 // Key의 Max Length
#define HashMap_HASH_SIZE		97 // Prime Number

//Prime Numbers
/*
53, 97, 193, 389,
769, 1543, 3079, 6151,
12289, 24593, 49157, 98317,
196613, 393241, 786433, 1572869,
3145739, 6291469, 12582917, 25165843,
50331653, 100663319, 201326611, 402653189,
805306457, 1610612741
*/

#define HashMap_inithash(p)\
		{\
			long i;\
			for (i=0; i<HashMap_HASH_SIZE; i++) p->m_HT[i] = HashMap_NULL;\
		}

//========================================================================================
//2. 클래스 매쏘드 정의
//========================================================================================
#define __CHASHMAP_CLASS_METHODS()		\
		_DEF_FPTR ( setValue	);		\
		_DEF_FPTR ( saveValue	);		\
		_DEF_FPTR ( isEmpty		);		\
		_DEF_FPTR ( put			);		\
		_DEF_FPTR ( putInt		);		\
		_DEF_FPTR ( putStr		);		\
		_DEF_FPTR ( putBin		);		\
		_DEF_FPTR ( get			);		\
		_DEF_FPTR ( getInt		);		\
		_DEF_FPTR ( getStr		);		\
		_DEF_FPTR ( getBin		);		\
		_DEF_FPTR ( setDestroy	);		\
		_DEF_FPTR ( remove		);		\
		_DEF_FPTR ( containsKey	);		\
		_DEF_FPTR ( clear		);		\
		_DEF_FPTR ( toArray		);		\
		_DEF_FPTR ( GetKeys		);		\
		_DEF_FPTR ( size		)

#define __CHASHMAP_CLASS_METHODS_PROTOTYPES()\
		_TYPEDEF void*		( _X( setValue		))	( void*, long, void*, long	);\
		_TYPEDEF long		( _X( saveValue		))	( void*, BOOL, char*, void*	);\
		_TYPEDEF BOOL		( _X( isEmpty		))	( void*						);\
		_TYPEDEF long		( _X( put			))	( void*, char*, void*		);\
		_TYPEDEF long		( _X( putInt		))	( void*, char*, long		);\
		_TYPEDEF long		( _X( putStr		))	( void*, char*, char*		);\
		_TYPEDEF long		( _X( putBin		))	( void*, char*, void*, long );\
		_TYPEDEF void*		( _X( get			))	( void*, char*				);\
		_TYPEDEF long		( _X( getInt		))	( void*, char*				);\
		_TYPEDEF char*		( _X( getStr		))	( void*, char*				);\
		_TYPEDEF void*		( _X( getBin		))	( void*, char*				);\
		_TYPEDEF long		( _X( setDestroy	))	( void*, void*				);\
		_TYPEDEF long		( _X( remove		))	( void*, char*				);\
		_TYPEDEF BOOL		( _X( containsKey	))	( void*, char*				);\
		_TYPEDEF void		( _X( clear			))	( void*						);\
		_TYPEDEF void**		( _X( toArray		))	( void*						);\
		_TYPEDEF void*		( _X( GetKeys		))	( void*						);\
		_TYPEDEF long		( _X( size			))	( void*						)
   
//========================================================================================
//3. 함수 포인터 선언영역
//========================================================================================
#define _TYPEDEF	typedef
#define _X(f)		*CHASHMAP_##f

__CHASHMAP_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//4. 함수 원형
//========================================================================================
#define _TYPEDEF	HashMap_LOCAL
#define _X(f)	HashMap_##f

__CHASHMAP_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//5. 구조체 원형 (클래스)
//========================================================================================
typedef struct _HashMap_Value
{
	long m_nType;
	long m_nSize;
	void* m_pData;

} HashMap_Value;

typedef struct _HashMap_Node
{
	BOOL flag;		//TRUE : HashMap_Value에 값을 넣은 경우,
					//FALSE : put, get만 사용해서 포인터를 직접 연결한 경우.

	char key[HashMap_KEY_SIZE + 1];
	HashMap_Value* val;
	struct _HashMap_Node* next;

} HashMap_Node;

//노드를 가르키는 포인터 배열의 해시테이블
typedef HashMap_Node *HashMap_Hashtable[HashMap_HASH_SIZE];

typedef struct _HashMap
{
	long	m_nMagic;
	void*	m_pThis;

	//클래스 변수 영역
	HashMap_Hashtable m_HT;

	void* m_pDestroy;
	long m_nCount;

	CVECTOR m_cpKey;

	char** m_pArray;

	#define _DEF_FPTR(f)	CHASHMAP_##f f
	
	//클래스 매쏘드 영역
	__CHASHMAP_CLASS_METHODS();

	#undef _DEF_FPTR

} HashMap, *CHASHMAP;

#ifdef __cplusplus
extern "C" {
#endif

CHASHMAP NewHashMap (void);
long DelHashMap (CHASHMAP p);

#ifdef __cplusplus
}
#endif

#endif	//	__CHASHMAP_H__
