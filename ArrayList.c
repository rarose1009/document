/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : ArrayList

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#include "ArrayList.h"

//========================================================================================
//6. static �Լ� ����
//========================================================================================

//-----------------------------------------------------------
//������
CARRAYLIST NewArrayList (void)
{
	CARRAYLIST p;

	p = (CARRAYLIST) ArrayList_malloc ( sizeof(ArrayList) );
	if (p == 0)
	{
		return 0;
	}

	//��� ���� �ʱ�ȭ
	//������ ��� �ʱ�ȭ �� �ش�.
	p->head = 0;
	p->lastElement = 0;
	p->iterator = 0;
	p->count = 0;
	p->m_pDestroy = 0;
	p->type = ArrayList_Type_Const;
	
	#define _DEF_FPTR(f)	p->f = (CARRAYLIST_##f) ArrayList_##f
	
	//�Ž�� ����
	__CARRAYLIST_CLASS_METHODS();
	
	#undef _DEF_FPTR

	CM_NEW_CHECK(p);

	return p;
}

//-----------------------------------------------------------
//������
CARRAYLIST NewArrayListEx (long type)
{
	CARRAYLIST p = NewArrayList();
	if (p == 0)
	{
		return 0;
	}
	
	p->type = type;
	
	return p;
}

//-----------------------------------------------------------
//������
CARRAYLIST NewArrayListAlloc (void)
{
	CARRAYLIST p;

	p = (CARRAYLIST) ArrayList_malloc ( sizeof(ArrayList) );
	if (p == 0)
	{
		return 0;
	}

	//��� ���� �ʱ�ȭ
	//������ ��� �ʱ�ȭ �� �ش�.
	p->head = 0;
	p->lastElement = 0;
	p->iterator = 0;
	p->count = 0;
	p->m_pDestroy = 0;
	p->type = ArrayList_Type_Alloc;
	
	#define _DEF_FPTR(f)	p->f = (CARRAYLIST_##f) ArrayList_##f
	
	//�Ž�� ����
	__CARRAYLIST_CLASS_METHODS();
	
	#undef _DEF_FPTR

	CM_NEW_CHECK(p);

	return p;
}

//-----------------------------------------------------------
//�Ҹ���
long _DelArrayList (CARRAYLIST pp[])
{
	CARRAYLIST p = *pp;

	//CM_DEL_CHECK(p, DelArrayList);

	p->removeAll(p);
	ArrayList_free ((byte*)*pp);
	*pp = NULL;

	return 0;
}

//========================================================================================
//7. �Ž�� ����
//========================================================================================

//-----------------------------------------------------------
void*  ArrayList_setElement	( void* p, long nType, void* pData, long nSize )
{
	//CARRAYLIST pThis = (CARRAYLIST)p;

	ArrayElement* pElement;

	if (pData == NULL || nSize <= 0)
	{
		return NULL;
	}
	
	pElement = (ArrayElement*)ArrayList_malloc ( sizeof(ArrayElement) );
	if (pElement == NULL)
	{
		return NULL;
	}

	pElement->m_nType = nType;

	/*
	if (nType == ArrayList_INT)
	{
		long* ptr = (long*)pData;
		long nVal = (long)(*ptr);
		pElement->m_nSize = nSize;
		pElement->m_pData = (void*)nVal;
		return pElement;
	}
	else if (nType == ArrayList_STR)
	{
		//NULL ����.
		pElement->m_pData = (void*)ArrayList_malloc (nSize+1);
		pElement->m_nSize = nSize; //NULL ����
		ArrayList_memset (pElement->m_pData, 0x00, nSize+1);
	}
	else
	{
		pElement->m_pData = (void*)ArrayList_malloc (nSize);
		pElement->m_nSize = nSize;
	}

	if (pElement->m_pData == NULL)
	{
		ArrayList_free ((byte*)pElement);
		return NULL;
	}

	ArrayList_memcpy (pElement->m_pData, pData, nSize);
	*/

	//��� composition�� ������� �ʴ´�.
	pElement->m_nSize = nSize;
	pElement->m_pData = pData;

	//LOG_DEBUG("ArrayList_setElement (%s)", pData,0,0);

	return pElement;
}

//-----------------------------------------------------------
BOOL  ArrayList_isEmpty	( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

    return (pThis->head == NULL);
}

//-----------------------------------------------------------
long  ArrayList_addInt		( void* p, long nVal )
{
	CARRAYLIST pThis = (CARRAYLIST)p;
	void* e = NULL;

	e = pThis->setElement(pThis, ArrayList_INT, &nVal, sizeof(long));

	//������ �� �ڿ� �߰��Ѵ�.
	return pThis->add(pThis, e);
}

//-----------------------------------------------------------
long  ArrayList_addStr		( void* p, char* pszStr )
{
	CARRAYLIST pThis = (CARRAYLIST)p;
	long n = 0;
	void* e = NULL;

	if (pszStr == NULL)
	{
		return (-1);
	}
	
	n = ArrayList_strlen(pszStr);

	e = pThis->setElement(pThis, ArrayList_STR, pszStr, n);

	//������ �� �ڿ� �߰��Ѵ�.
	return pThis->add(pThis, e);
}

//-----------------------------------------------------------
long  ArrayList_addBin		( void* p, void* pBuf, long nLen )
{
	CARRAYLIST pThis = (CARRAYLIST)p;
	void* e = NULL;

	if (pBuf == NULL)
	{
		return (-1);
	}
	
	e = pThis->setElement(pThis, ArrayList_BIN, pBuf, nLen);

	//������ �� �ڿ� �߰��Ѵ�.
	return pThis->add(pThis, e);
}

//-----------------------------------------------------------
long  ArrayList_append	( void* p, char* pszStr )
{
	CARRAYLIST pThis = (CARRAYLIST)p;
	long n = 0;
	void* e = NULL;
	char* ptr = NULL;

	if (pszStr == NULL)
	{
		return (-1);
	}
	
	pThis->type = ArrayList_Type_Alloc;
	
	n = ArrayList_strlen(pszStr);
	ptr = ArrayList_malloc(n+1);
	if(ptr == NULL)
	{
		return (-2);
	}
	
	ArrayList_strcpy(ptr, pszStr);

	e = pThis->setElement(pThis, ArrayList_STR, ptr, n+1);

	//������ �� �ڿ� �߰��Ѵ�.
	return pThis->add(pThis, e);
}

//-----------------------------------------------------------
long  ArrayList_add		( void* p, void* element )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

	//������ �� �ڿ� �߰��Ѵ�.
	return pThis->addAt(pThis, pThis->size(pThis), element);
}

//-----------------------------------------------------------
long  ArrayList_addAt		( void* p, long index, void* element )
{
	CARRAYLIST pThis = (CARRAYLIST)p;
    long s = pThis->size(pThis);
    Element* e;
	Element* newElement;

	assert((int) index >= 0);

    if (index < 0)
	{
        return -1;
    }

    if (index > s)
	{
        index = s;
    }

    newElement = (Element*)ArrayList_malloc (sizeof (Element));
	if (newElement == NULL)
	{
		//LOG_ERROR("ArrayList:: addAt: Element Allocation Failure.", 0,0,0);
		return -2;
	}

    newElement->e = (ArrayElement*)element;
    newElement->n = NULL;

    if (index == s)
	{
        // Inserting the new element at the end
        e = pThis->lastElement;
    }
    else
	{
		// Inserting the new element at the index-th position
		long i;

        e = pThis->head;
		for (i=0; i<index-1; i++)
		{
			e = e->n;
		}
    }

    if (e == NULL || index == 0)
	{
        //
        // Insertion at the beginning of the array
        //
        newElement->n = pThis->head;
        pThis->head = newElement;

        if (e == NULL)
		{
            pThis->lastElement = newElement;
        }

        pThis->count++;
        return index;
    }

    if (e->n)
	{
        //
        // Insertion in the middle of the array
        //
        newElement->n = e->n;
        e->n = newElement;
    }
	else
	{
        //
        // Insertion at the end of the array
        //
        e->n = newElement;
        pThis->lastElement = newElement;
    }

    pThis->count++;

    return index;
}

//-----------------------------------------------------------
void* ArrayList_get		( void* p, long index )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

	long i;
	Element* e = pThis->head;

	assert((int) index >= 0);

	if ( index < 0 )
	{
		return NULL;
	}

	for(i=0; e && i<index; i++)
	{
		e = e->n;
	}

	if(!e)
		return NULL;

	return e->e;
}

//-----------------------------------------------------------
long ArrayList_getInt		( void* p, long index )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

	long i;
	Element* e = pThis->head;
	ArrayElement* val;

	assert((int) index >= 0);

	if ( index < 0 )
	{
		return -1;
	}

	for(i=0; e && i<index; i++)
	{
		e = e->n;
	}

	if(!e)
		return -2;

	val = e->e;

	if (val->m_nType != ArrayList_INT)
	{
		return -3;
	}

	return (long)val->m_pData;
}

//-----------------------------------------------------------
char* ArrayList_getStr		( void* p, long index )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

	long i;
	Element* e = pThis->head;
	ArrayElement* val;

	assert((int) index >= 0);

	if ( index < 0 )
	{
		return NULL;
	}

	for(i=0; e && i<index; i++)
	{
		e = e->n;
	}

	if(!e)
		return NULL;

	val = e->e;

	return val->m_pData;
}

//-----------------------------------------------------------
long ArrayList_getType	( void* p, void* element )
{
	//CARRAYLIST pThis = (CARRAYLIST)p;
	ArrayElement* e = (ArrayElement*)element;
	if (e == NULL)
	{
		return 0;
	}

	return e->m_nType;
}

//-----------------------------------------------------------
long ArrayList_getSize	( void* p, void* element )
{
	//CARRAYLIST pThis = (CARRAYLIST)p;
	ArrayElement* e = (ArrayElement*)element;
	if (e == NULL)
	{
		return 0;
	}

	return e->m_nSize;
}

//-----------------------------------------------------------
void* ArrayList_getBuffer	( void* p, void* element )
{
	CARRAYLIST pThis = (CARRAYLIST)p;
	ArrayElement* e = (ArrayElement*)element;
	if (e == NULL)
	{
		return NULL;
	}

	return e->m_pData;
}

//-----------------------------------------------------------
long ArrayList_setDestroy ( void* p, void* pDestroy )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

	pThis->m_pDestroy = pDestroy;

	return 0;
}
//-----------------------------------------------------------
long  ArrayList_removeAt	( void* p, long index )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

	long i;
	Element* e;
    Element* before = NULL;

    long s = pThis->size(pThis) - 1;

	//LOG_DEBUG("ArrayList_removeAt (index=%d)", index,0,0);

    if (index > s)
	{
        index = s;
    }

    if (index < 0)
	{
        return -1;
    }

    //
    // deleting the existing element at the index-th position
    //
    e = pThis->head;

    for (i=0; i<index; i++)
	{
        before = e;
        e = e->n;
    }

    if (before)
	{
        before->n = e->n;
    }
	else
	{
        assert(index == 0);
        pThis->head = e->n;
    }
    
	if (e == pThis->lastElement)
	{
        assert(index == count - 1);
        pThis->lastElement = before;
    }

	//���� ����.
	if (e->e->m_pData)
	{
		if (pThis->m_pDestroy)
		{
			pDestroy pDes = (pDestroy)pThis->m_pDestroy;
			pDes (e->e->m_pData);
		}
		else
		{
			if(pThis->type != ArrayList_Type_Const)
			{
				ArrayList_free ((byte*)e->e->m_pData);
			}
		}
		
		e->e->m_pData = NULL;
	}

	if (e->e)
	{
		ArrayList_free ((byte*)e->e);
		e->e = NULL;
		e->n = NULL;
	}

	if (e)
	{
		//LOG_DEBUG("ArrayList_removeAt => Element ���� ArrayList_malloc(0x%x)", e,0,0);
		ArrayList_free ((byte*)e);
		e = NULL;
	}

    pThis->count--;
  	if (pThis->count == 0)
	{
		pThis->head = NULL;
		pThis->lastElement = NULL;
	}

	return index;
}

//-----------------------------------------------------------
long  ArrayList_removeAll	( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

    Element* e = pThis->head;
    while (e)
	{
		//���� ����.

		//INT Ÿ���� �޸� �Ҵ��� ���� �ʴ´�.
		if (ArrayList_INT != e->e->m_nType)
		{
			//��ü�� ��� �ξ��� ���, �Ҹ��ڰ� ȣ���� ���� �ʴ´�.
			//����� �����Ϳ��� ������ �����.
			//�� ��츦 ���ؼ�...
			if (e->e->m_pData)
			{
				//PRINT("ArrayList_removeAll => Element ���� ArrayList_free(%s)", e->e->m_pData,0,0);

				if (pThis->m_pDestroy)
				{
					pDestroy pDes = (pDestroy)pThis->m_pDestroy;
					pDes (e->e->m_pData);
				}
				else
				{
					if(pThis->type != ArrayList_Type_Const)
					{
						ArrayList_free ((byte*)e->e->m_pData);
					}
				}
				e->e->m_pData = NULL;
			}
		}

		if (e->e)
		{
			ArrayList_free ((byte*)e->e);
			e->e = NULL;
		}

        pThis->head = e->n;

		//PRINT("ArrayList_removeAll => Element ���� ArrayList_free(0x%x)", e,0,0);

		ArrayList_free ((byte*)e);
        e = pThis->head;
    }

    pThis->count = 0;
    pThis->head = NULL;
    pThis->lastElement = NULL;

	return (0);
}

//-----------------------------------------------------------
void* ArrayList_front		( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

    pThis->iterator = pThis->head;
    return (pThis->iterator) ? pThis->iterator->e : 0 ;
}

//-----------------------------------------------------------
void* ArrayList_last		( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

    pThis->iterator = pThis->lastElement;
    return (pThis->iterator) ? pThis->iterator->e : 0 ;
}

//-----------------------------------------------------------
void* ArrayList_next		( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

    if(!pThis->iterator)
	{
        return 0;
    }

    pThis->iterator = pThis->iterator->n;
    return (pThis->iterator) ? pThis->iterator->e : 0 ;
}

//-----------------------------------------------------------
void* ArrayList_prev		( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

    Element *e = NULL;

    if( !pThis->iterator )
        return 0;

    if( pThis->iterator == pThis->head )
        return 0;

    for(e = pThis->head; e->n == pThis->iterator; e = e->n)
	{
        if(!e)
            return 0;
    }

    return e->e;
}

//-----------------------------------------------------------
void* ArrayList_back		( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

    for (
			pThis->iterator = pThis->head;
			pThis->iterator->n;
			pThis->iterator = pThis->iterator->n
		);
    
	return pThis->iterator->e;
}

//-----------------------------------------------------------
long  ArrayList_size		( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

    return pThis->count;
}

//-----------------------------------------------------------
void*  ArrayList_clone		( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

    CARRAYLIST ret = NewArrayList();

	long i;
    long dim = pThis->size(pThis);

    for (i = 0; i < dim; i++)
	{
        ret->addAt(ret, pThis->size(pThis), pThis->get(pThis, i));
    }

    return ret;
}

//-----------------------------------------------------------
long  ArrayList_print		( void* p )
{
	CARRAYLIST pThis = (CARRAYLIST)p;

	Element* h = pThis->head;
	Element* t = h;

	while (t != NULL)
	{
		//print here...
		//LOG_LOW ("ArrayList:: ArrayElement e->m_pData = %s", t->e->m_pData, 0, 0);
		t = t->n;
	}

	return 0;
}
