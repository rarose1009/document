/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : HashMap

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#include "HashMap.h"

//========================================================================================
//6. static 함수 영역
//========================================================================================

//-----------------------------------------------------------
HashMap_LOCAL long HashMap_hash (char *str)
{
	long v;
	long h = 0;

	while (*str)
	{
		h += *str++;
	}

	v = (h % HashMap_HASH_SIZE);
	if (v >= 0)
	{
		return v;
	}

	return -v;
}

//-----------------------------------------------------------
HashMap_LOCAL void HashMap_insert(void* p, HashMap_Node* node)
{
	CHASHMAP pThis = (CHASHMAP)p;
	HashMap_Node *Nodeptr;
	long h;

	Nodeptr = (HashMap_Node*)HashMap_malloc (sizeof (HashMap_Node));
	if (Nodeptr == NULL)
	{
		//LOG_ERROR("HashMap:: insert: Nodeptr Allocation Failure.", 0, 0, 0);
		return;
	}

	*Nodeptr = *node;

	h = HashMap_hash (Nodeptr->key);

	Nodeptr->next = pThis->m_HT[h];
	pThis->m_HT[h] = Nodeptr;
}

//-----------------------------------------------------------
//생성자
CHASHMAP NewHashMap (void)
{
	CHASHMAP p;

	p = (CHASHMAP) HashMap_malloc ( sizeof(HashMap) );
	if (p == HashMap_NULL)
	{
		return HashMap_NULL;
	}

	//멤버 변수 초기화

	//hash table 초기화.
	HashMap_inithash (p);
	p->m_nCount = 0;
	p->m_pDestroy = 0;
	p->m_cpKey = NULL;
	p->m_pArray = NULL;
	
	#define _DEF_FPTR(f)	p->f = (CHASHMAP_##f) HashMap_##f
	
	//매쏘드 설정
	__CHASHMAP_CLASS_METHODS();
	
	#undef _DEF_FPTR

	CM_NEW_CHECK(p);

	return p;
}

//-----------------------------------------------------------
//소멸자
long DelHashMap (CHASHMAP p)
{
	//CM_DEL_CHECK(p, DelHashMap);

	if (p->m_pArray)
	{
		HashMap_free ((byte*)p->m_pArray);
		p->m_pArray = NULL;
	}

	if (p->m_cpKey)
	{
		DelVector(p->m_cpKey);
		p->m_cpKey = NULL;
	}

	p->clear(p);
	HashMap_free ((byte*)p);

	return 0;
}

//========================================================================================
//7. 매쏘드 영역
//========================================================================================

//-----------------------------------------------------------
void*  HashMap_setValue	( void* p, long nType, void* pData, long nSize )
{
	//CARRAYLIST pThis = (CARRAYLIST)p;

	HashMap_Value* pVal;

	if (pData == HashMap_NULL || nSize <= 0)
	{
		return HashMap_NULL;
	}
	
	pVal = (HashMap_Value*)HashMap_malloc ( sizeof(HashMap_Value) );
	if (pVal == HashMap_NULL)
	{
		return HashMap_NULL;
	}

	pVal->m_nType = nType;

	/*
	if (nType == HashMap_STR)
	{
		pVal->m_pData = HashMap_malloc (nSize+1);
		pVal->m_nSize = nSize; //HashMap_NULL 제외
		HashMap_memset ((byte*)pVal->m_pData, 0x00, nSize+1);
	}
	else
	{
		pVal->m_pData = HashMap_malloc (nSize);
		pVal->m_nSize = nSize;
	}

	if (pVal->m_pData == HashMap_NULL)
	{
		HashMap_free ((byte*)pVal);
		return HashMap_NULL;
	}

	HashMap_memcpy ((byte*)pVal->m_pData, (byte*)pData, nSize);
	*/

	pVal->m_nSize = nSize;
	pVal->m_pData = pData;

	return pVal;
}

//-----------------------------------------------------------
long  HashMap_saveValue		( void* p, BOOL flag, char* key, void* value )
{
	CHASHMAP pThis = (CHASHMAP)p;

	HashMap_Node node;

	if (HashMap_strlen(key) > HashMap_KEY_SIZE)
	{
		return (-1);
	}

	//중복 조건 체크
	//완전히 일치하는 키는 허용하지 않는다.
	if (pThis->get(pThis, key) != HashMap_NULL)
	{
		return (-2);
	}

	node.flag = flag;
	strcpy (node.key, key);
	node.val = (HashMap_Value*)value;

	//HashMap_insert (pThis, &node);
	{
		HashMap_Node *Nodeptr;
		long h;
	
		Nodeptr = (HashMap_Node*)HashMap_malloc (sizeof (HashMap_Node));
		if (Nodeptr == NULL)
		{
			//LOG_ERROR("HashMap:: insert: Nodeptr Allocation Failure.", 0, 0, 0);
			return (-3);
		}
	
		*Nodeptr = node;
	
		h = HashMap_hash (Nodeptr->key);
	
		Nodeptr->next = pThis->m_HT[h];
		pThis->m_HT[h] = Nodeptr;
	}

	//카운트 증가
	pThis->m_nCount++;

	return (0);
}

//-----------------------------------------------------------
BOOL  HashMap_isEmpty		( void* p )
{
	CHASHMAP pThis = (CHASHMAP)p;

	return (pThis->m_nCount==0)? TRUE: FALSE;
}

//-----------------------------------------------------------
long  HashMap_put			( void* p, char* key, void* value )
{
	CHASHMAP pThis = (CHASHMAP)p;
	return pThis->saveValue(pThis, FALSE, key, value);
}

//-----------------------------------------------------------
long  HashMap_putInt		( void* p, char* key, long value )
{
	CHASHMAP pThis = (CHASHMAP)p;

	void* pVal = pThis->setValue(pThis, HashMap_BIN, &value, sizeof(long));

	return pThis->saveValue (pThis, TRUE, key, pVal);
}

//-----------------------------------------------------------
long  HashMap_putStr		( void* p, char* key, char* value )
{
	CHASHMAP pThis = (CHASHMAP)p;
	long nSize;
	void* pVal;

	if (value == HashMap_NULL)
	{
		return (-1);
	}

	nSize = HashMap_strlen(value);
	pVal = pThis->setValue(pThis, HashMap_STR, value, nSize);

	return pThis->saveValue (pThis, TRUE, key, pVal);
}

//-----------------------------------------------------------
long  HashMap_putBin		( void* p, char* key, void* value, long len )
{
	CHASHMAP pThis = (CHASHMAP)p;

	void* pVal = pThis->setValue(pThis, HashMap_BIN, value, len);

	return pThis->saveValue (pThis, TRUE, key, pVal);
}

//-----------------------------------------------------------
void* HashMap_get			( void* p, char* key )
{
	CHASHMAP pThis = (CHASHMAP)p;

	HashMap_Node *Nodeptr;
	long h;

	if (HashMap_strlen(key) > HashMap_KEY_SIZE)
	{
		return HashMap_NULL;
	}

	h = HashMap_hash (key);
	Nodeptr = pThis->m_HT[h];

	while(Nodeptr)
	{
		if (HashMap_strcmp(Nodeptr->key, key) == 0)
		{
			return Nodeptr->val;
		}

		Nodeptr = Nodeptr->next;
	}

	return HashMap_NULL;
}

//-----------------------------------------------------------
long HashMap_getInt			( void* p, char* key )
{
	CHASHMAP pThis = (CHASHMAP)p;
	HashMap_Value* pVal;

	pVal = (HashMap_Value*)pThis->get(pThis, key);

	if (pVal == HashMap_NULL)
		return (-1);

	if (pVal->m_nType == HashMap_STR)
	{
		return (-2);
	}

	if (pVal->m_nSize != 4)
	{
		return (-3);
	}

	return (long)pVal->m_pData;
}

//-----------------------------------------------------------
char* HashMap_getStr			( void* p, char* key )
{
	CHASHMAP pThis = (CHASHMAP)p;
	HashMap_Value* pVal;

	pVal = (HashMap_Value*)pThis->get(pThis, key);

	if (pVal == HashMap_NULL)
		return HashMap_NULL;

	if (pVal->m_nType != HashMap_STR)
	{
		return HashMap_NULL;
	}

	return (char*)pVal->m_pData;
}

//-----------------------------------------------------------
void* HashMap_getBin			( void* p, char* key )
{
	CHASHMAP pThis = (CHASHMAP)p;
	HashMap_Value* pVal;

	pVal = (HashMap_Value*)pThis->get(pThis, key);

	if (pVal == HashMap_NULL)
		return HashMap_NULL;

	if (pVal->m_nType != HashMap_BIN)
	{
		return HashMap_NULL;
	}

	return pVal->m_pData;
}

//-----------------------------------------------------------
long HashMap_setDestroy ( void* p, void* pDestroy )
{
	CHASHMAP pThis = (CHASHMAP)p;

	pThis->m_pDestroy = pDestroy;

	return 0;
}

//-----------------------------------------------------------
long  HashMap_remove		( void* p, char* key )
{
	CHASHMAP pThis = (CHASHMAP)p;

	HashMap_Node *PrevNodeptr = HashMap_NULL;
	HashMap_Node *Nodeptr = HashMap_NULL;
	long h;

	if (HashMap_strlen(key) > HashMap_KEY_SIZE)
	{
		return -1;
	}

	h = HashMap_hash (key);
	Nodeptr = pThis->m_HT[h];

	while(Nodeptr)
	{
		if (HashMap_strcmp(Nodeptr->key, key) == 0)
		{
			//연결 작업 정보 처리 빠졌음.
			//먼저 앞의 항목을 알아낸 다음, 연결해야 한다.

			//1) 첫번째 노드 조건
			if (PrevNodeptr == HashMap_NULL)
			{
				//다음 노드의 포인터를 해시테이블에 바꿔 넣음.
				pThis->m_HT[h] = Nodeptr->next;
			}
			//2) 중간 노드 조건
			else if (Nodeptr->next)
			{
				//이전 노드의 넥스트 포인터를 현재 노드의 값으로 바꿔 넣음.
				PrevNodeptr->next = Nodeptr->next;
			}
			//3) 마지막 노드 조건
			else
			{
				//이전 노드가 끝이 되므로, next 포인터에 널을 채워 넣음.
				PrevNodeptr->next = HashMap_NULL;
			}

			//value 정보 해제
			if (Nodeptr->val)
			{
				if (Nodeptr->flag == TRUE && Nodeptr->val->m_pData)
				{
					//[오류] 이런 방식으로 해제를 하면
					//객체를 저장했을 경우는 소멸자가 호출이 되지 않는다.
					//결국 메모리 릭이 발생한다.
					if (pThis->m_pDestroy)
					{
						pDestroy pDes = (pDestroy)pThis->m_pDestroy;
						pDes (Nodeptr->val->m_pData);
					}
					else
					{
						HashMap_free((byte*)Nodeptr->val->m_pData);
					}

					Nodeptr->val->m_pData = NULL;
				}

				HashMap_free((byte*)Nodeptr->val);
				Nodeptr->val = NULL;
			}

			HashMap_free((byte*)Nodeptr);
			Nodeptr = NULL;

			//카운트 감소
			pThis->m_nCount--;

			return (0);
		}

		//앞의 노드를 저장해 둔다.
		PrevNodeptr = Nodeptr;

		Nodeptr = Nodeptr->next;
	}

	return (-2);
}

//-----------------------------------------------------------
BOOL  HashMap_containsKey	( void* p, char* key )
{
	CHASHMAP pThis = (CHASHMAP)p;

	if (pThis->get(pThis, key) == HashMap_NULL)
	{
		return FALSE;
	}

	return TRUE;
}

//-----------------------------------------------------------
// 모든 데이터를 초기화한다.
void  HashMap_clear		( void* p )
{
	CHASHMAP pThis = (CHASHMAP)p;

	long i;
	HashMap_Node *Nodeptr = HashMap_NULL;
	HashMap_Node t;

	for (i=0; i<HashMap_HASH_SIZE; i++)
	{
		Nodeptr = pThis->m_HT[i];
		while(Nodeptr)
		{
			t = *Nodeptr;

			//value 정보 해제
			if (Nodeptr->val)
			{
				//put으로 포인터만 저장한 경우는 이 곳을 실행하면 안됨.
				if (Nodeptr->flag == TRUE && Nodeptr->val->m_pData)
				{
					if (pThis->m_pDestroy)
					{
						pDestroy pDes = (pDestroy)pThis->m_pDestroy;
						pDes (Nodeptr->val->m_pData);
					}
					else
					{
						//LOG_DEBUG("HashMap 해제 tag=[0x%x] %s", Nodeptr->val->m_pData,Nodeptr->val->m_pData,0);
						HashMap_free((byte*)Nodeptr->val->m_pData);
						Nodeptr->val->m_pData = HashMap_NULL;
					}
				}

				HashMap_free((byte*)Nodeptr->val);
				Nodeptr->val = HashMap_NULL;
			}

			// 키값을 초기화
			HashMap_free((byte*)Nodeptr);
			Nodeptr = t.next;
		}

		// Hash값을 초기화함.
		pThis->m_HT[i] = HashMap_NULL;
	}

	//카운트 해제
	pThis->m_nCount = 0;

	return;
}

//-----------------------------------------------------------
long  HashMap_size			( void* p )
{
	CHASHMAP pThis = (CHASHMAP)p;

	return pThis->m_nCount;
}

/*
//향후에 제공을 한다.
//-----------------------------------------------------------
void*  HashMap_clone		( void* p )
{
	CHASHMAP pThis = (CHASHMAP)p;

	CHASHMAP ret = NewHashMap();
	long i;
	HashMap_Node *Nodeptr = HashMap_NULL;
	HashMap_Node t;

	for (i=0; i<HashMap_HASH_SIZE; i++)
	{
		Nodeptr = pThis->m_HT[i];
		while(Nodeptr)
		{
			t = *Nodeptr;

			//value 정보 해제
			if (Nodeptr->val)
			{
				if (Nodeptr->val->m_pData)
				{
					HashMap_free((byte*)Nodeptr->val->m_pData);
				}

				HashMap_free((byte*)Nodeptr->val);
			}

			// 키값을 초기화
			HashMap_free((byte*)Nodeptr);
			Nodeptr = t.next;

			// Hash값을 초기화함.
			pThis->m_HT[i] = HashMap_NULL;
		}
	}

    return ret;
}
*/

//포인터만 참조로 가지고 오도록 해야 한다.
void** HashMap_toArray		( void* p )
{
	CHASHMAP pThis = (CHASHMAP)p;
	char** pArray = NULL;
	HashMap_Node *Nodeptr;
	long i, j;
	long count;
	long size;

	for (i=0; i<HashMap_HASH_SIZE; i++)
	{
		//기본 정보를 알기 위해
		//어디에 값이 들어 있는지 찾아야 한다.
		//[가정] 서로다른 크기의 객체를 넣을 경우 문제가 된다.
		//toArray 매쏘드를 사용하지 않도록 한다.
		Nodeptr = pThis->m_HT[i];

		if (Nodeptr)
		{
			break;
		}
	}

	if (Nodeptr == 0)
		return 0;

	count = pThis->m_nCount;
	size = Nodeptr->val->m_nSize;
	if (size <= 0)
	{
		size = sizeof(long);
	}

	pArray = (char**)HashMap_malloc(size * count);
	if (pArray == 0)
		return 0;

	for (i=0, j=0; i<HashMap_HASH_SIZE; i++)
	{
		Nodeptr = pThis->m_HT[i];

		while(Nodeptr)
		{
			pArray[j++] = (char*)Nodeptr->val->m_pData;
			Nodeptr = Nodeptr->next;
		}
	}

	if (pThis->m_pArray != NULL)
	{
		HashMap_free((byte*)pThis->m_pArray);
		pThis->m_pArray = NULL;
	}

	//반드시 저장해야 한다.
	pThis->m_pArray = pArray;

	return (void**)pArray;
}

//포인터만 참조로 가지고 오도록 해야 한다.
void* HashMap_GetKeys ( void* p )
{
	CHASHMAP pThis = (CHASHMAP)p;
	HashMap_Node *Nodeptr;
	long i;
	CVECTOR v = NewVector(30, 50);

	if (v == NULL)
	{
		return NULL;
	}

	for (i=0; i<HashMap_HASH_SIZE; i++)
	{
		Nodeptr = pThis->m_HT[i];

		while (Nodeptr)
		{
			long n = HashMap_strlen(Nodeptr->key)+1;

			if (n > 1)
			{
				char* pKey = (char*)HashMap_malloc(n);
				if (pKey != NULL)
				{
					HashMap_strcpy(pKey, Nodeptr->key);
					v->AddElement(v, pKey);
					pKey = NULL;
				}
				else
				{
					LOG_ERROR("HashMap:: GetKeys: Key Extraction Failure." ,0,0,0);
				}
			}

			Nodeptr = Nodeptr->next;
		}
	}

	if (pThis->m_cpKey)
	{
		DelVector(pThis->m_cpKey);
		pThis->m_cpKey = NULL;
	}

	pThis->m_cpKey = v;
	return v;
}
