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

#define HashMap_KEY_SIZE		30 // Key�� Max Length
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
//2. Ŭ���� �Ž�� ����
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
//3. �Լ� ������ ���𿵿�
//========================================================================================
#define _TYPEDEF	typedef
#define _X(f)		*CHASHMAP_##f

__CHASHMAP_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//4. �Լ� ����
//========================================================================================
#define _TYPEDEF	HashMap_LOCAL
#define _X(f)	HashMap_##f

__CHASHMAP_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//5. ����ü ���� (Ŭ����)
//========================================================================================
typedef struct _HashMap_Value
{
	long m_nType;
	long m_nSize;
	void* m_pData;

} HashMap_Value;

typedef struct _HashMap_Node
{
	BOOL flag;		//TRUE : HashMap_Value�� ���� ���� ���,
					//FALSE : put, get�� ����ؼ� �����͸� ���� ������ ���.

	char key[HashMap_KEY_SIZE + 1];
	HashMap_Value* val;
	struct _HashMap_Node* next;

} HashMap_Node;

//��带 ����Ű�� ������ �迭�� �ؽ����̺�
typedef HashMap_Node *HashMap_Hashtable[HashMap_HASH_SIZE];

typedef struct _HashMap
{
	long	m_nMagic;
	void*	m_pThis;

	//Ŭ���� ���� ����
	HashMap_Hashtable m_HT;

	void* m_pDestroy;
	long m_nCount;

	CVECTOR m_cpKey;

	char** m_pArray;

	#define _DEF_FPTR(f)	CHASHMAP_##f f
	
	//Ŭ���� �Ž�� ����
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
