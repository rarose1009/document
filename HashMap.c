/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : HashMap

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#include "HashMap.h"

//========================================================================================
//6. static �Լ� ����
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
//������
CHASHMAP NewHashMap (void)
{
	CHASHMAP p;

	p = (CHASHMAP) HashMap_malloc ( sizeof(HashMap) );
	if (p == HashMap_NULL)
	{
		return HashMap_NULL;
	}

	//��� ���� �ʱ�ȭ

	//hash table �ʱ�ȭ.
	HashMap_inithash (p);
	p->m_nCount = 0;
	p->m_pDestroy = 0;
	p->m_cpKey = NULL;
	p->m_pArray = NULL;
	
	#define _DEF_FPTR(f)	p->f = (CHASHMAP_##f) HashMap_##f
	
	//�Ž�� ����
	__CHASHMAP_CLASS_METHODS();
	
	#undef _DEF_FPTR

	CM_NEW_CHECK(p);

	return p;
}

//-----------------------------------------------------------
//�Ҹ���
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
//7. �Ž�� ����
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
		pVal->m_nSize = nSize; //HashMap_NULL ����
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

	//�ߺ� ���� üũ
	//������ ��ġ�ϴ� Ű�� ������� �ʴ´�.
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

	//ī��Ʈ ����
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
			//���� �۾� ���� ó�� ������.
			//���� ���� �׸��� �˾Ƴ� ����, �����ؾ� �Ѵ�.

			//1) ù��° ��� ����
			if (PrevNodeptr == HashMap_NULL)
			{
				//���� ����� �����͸� �ؽ����̺� �ٲ� ����.
				pThis->m_HT[h] = Nodeptr->next;
			}
			//2) �߰� ��� ����
			else if (Nodeptr->next)
			{
				//���� ����� �ؽ�Ʈ �����͸� ���� ����� ������ �ٲ� ����.
				PrevNodeptr->next = Nodeptr->next;
			}
			//3) ������ ��� ����
			else
			{
				//���� ��尡 ���� �ǹǷ�, next �����Ϳ� ���� ä�� ����.
				PrevNodeptr->next = HashMap_NULL;
			}

			//value ���� ����
			if (Nodeptr->val)
			{
				if (Nodeptr->flag == TRUE && Nodeptr->val->m_pData)
				{
					//[����] �̷� ������� ������ �ϸ�
					//��ü�� �������� ���� �Ҹ��ڰ� ȣ���� ���� �ʴ´�.
					//�ᱹ �޸� ���� �߻��Ѵ�.
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

			//ī��Ʈ ����
			pThis->m_nCount--;

			return (0);
		}

		//���� ��带 ������ �д�.
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
// ��� �����͸� �ʱ�ȭ�Ѵ�.
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

			//value ���� ����
			if (Nodeptr->val)
			{
				//put���� �����͸� ������ ���� �� ���� �����ϸ� �ȵ�.
				if (Nodeptr->flag == TRUE && Nodeptr->val->m_pData)
				{
					if (pThis->m_pDestroy)
					{
						pDestroy pDes = (pDestroy)pThis->m_pDestroy;
						pDes (Nodeptr->val->m_pData);
					}
					else
					{
						//LOG_DEBUG("HashMap ���� tag=[0x%x] %s", Nodeptr->val->m_pData,Nodeptr->val->m_pData,0);
						HashMap_free((byte*)Nodeptr->val->m_pData);
						Nodeptr->val->m_pData = HashMap_NULL;
					}
				}

				HashMap_free((byte*)Nodeptr->val);
				Nodeptr->val = HashMap_NULL;
			}

			// Ű���� �ʱ�ȭ
			HashMap_free((byte*)Nodeptr);
			Nodeptr = t.next;
		}

		// Hash���� �ʱ�ȭ��.
		pThis->m_HT[i] = HashMap_NULL;
	}

	//ī��Ʈ ����
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
//���Ŀ� ������ �Ѵ�.
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

			//value ���� ����
			if (Nodeptr->val)
			{
				if (Nodeptr->val->m_pData)
				{
					HashMap_free((byte*)Nodeptr->val->m_pData);
				}

				HashMap_free((byte*)Nodeptr->val);
			}

			// Ű���� �ʱ�ȭ
			HashMap_free((byte*)Nodeptr);
			Nodeptr = t.next;

			// Hash���� �ʱ�ȭ��.
			pThis->m_HT[i] = HashMap_NULL;
		}
	}

    return ret;
}
*/

//�����͸� ������ ������ ������ �ؾ� �Ѵ�.
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
		//�⺻ ������ �˱� ����
		//��� ���� ��� �ִ��� ã�ƾ� �Ѵ�.
		//[����] ���δٸ� ũ���� ��ü�� ���� ��� ������ �ȴ�.
		//toArray �Ž�带 ������� �ʵ��� �Ѵ�.
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

	//�ݵ�� �����ؾ� �Ѵ�.
	pThis->m_pArray = pArray;

	return (void**)pArray;
}

//�����͸� ������ ������ ������ �ؾ� �Ѵ�.
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
