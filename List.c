/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : List

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#include "List.h"

//========================================================================================
//6. static �Լ� ����
//========================================================================================

//-----------------------------------------------------------
//������
CLIST NewList (void)
{
	CLIST p;

	p = (CLIST) List_malloc ( sizeof(List) );
	if (p == 0)
	{
		return 0;
	}

	//��� ���� �ʱ�ȭ
	//������ ��� �ʱ�ȭ �� �ش�.
	p->m_head = 0;
	p->m_last = 0;
	p->m_nCount = 0;
	p->m_pDestory = 0;
	
	#define _DEF_FPTR(f)	p->f = (CLIST_##f) List_##f
	
	//�Ž�� ����
	__CLIST_CLASS_METHODS();
	
	#undef _DEF_FPTR

	//CM_NEW_CHECK(p);

	return p;
}

//-----------------------------------------------------------
//�Ҹ���
long DelList (CLIST p)
{
	//CM_DEL_CHECK(p, DelList);

	p->RemoveAll(p);

	List_free ((byte*)p);

	return 0;
}

//========================================================================================
//7. �Ž�� ����
//========================================================================================

//-----------------------------------------------------------
long List_GetCount ( void* p )
{
	CLIST pThis = (CLIST)p;

	return pThis->m_nCount;
}

//-----------------------------------------------------------
void* List_Peek ( void* p, long index )
{
	CLIST pThis = (CLIST)p;
	long i;

	if (index > pThis->m_nCount-1)
	{
		return NULL;
	}

	if (index < 0)
	{
		return NULL;
	}

	pThis->m_iterator = pThis->m_head;
	if (pThis->m_iterator == NULL)
		return NULL;

	i = index;
	while(i--)
	{
		pThis->m_iterator = pThis->m_iterator->next;
		if (pThis->m_iterator == NULL)
			return NULL;
	}

	if (pThis->m_iterator == NULL)
		return NULL;

	return pThis->m_iterator->ptr;
}

//-----------------------------------------------------------
long List_Add ( void* p, void* ptr )
{
	CLIST pThis = (CLIST)p;

	List_Item* t = (List_Item*)List_malloc (sizeof(List_Item));
	if (t == NULL)
	{
		//LOG_ERROR ("List:: Add: List_Item Allocation Failure.", 0, 0, 0);
		return -1;
	}

	t->next = NULL;
	t->ptr = ptr;

	if (pThis->m_nCount == 0)
	{
		pThis->m_head = t;
	}
	else
	{
		pThis->m_last->next = t;
	}

	pThis->m_last = t;
	pThis->m_nCount++;
	
	return 0;
}

//-----------------------------------------------------------
long List_SetDestroy ( void* p, void* pDestroy )
{
	CLIST pThis = (CLIST)p;
	pThis->m_pDestory = pDestroy;
	return 0;
}

//-----------------------------------------------------------
long List_RemoveAt ( void* p, long index )
{
	CLIST pThis = (CLIST)p;

	List_Item* h = pThis->m_head;
	List_Item* t = h;
	long i;

	if (index > pThis->m_nCount-1)
	{
		return (-1);
	}

	if (index < 0)
	{
		return (-2);
	}

	i = index;

	while (i--)
	{
		if (t == NULL)
		{
			return (-2);
		}

		h = t;
		t = t->next;
	}

	//ù ���
	//head �����Ϳ� ���� ����� next �����͸� �����ϰ�, ���� ��带 ����.
	if (index == 0)
	{
		t = h;
		pThis->m_head = h->next; 
	}
	//�� ���
	//���� ����� next �����Ϳ� NULL�� �ִ´�.
	else if (index == pThis->m_nCount-1)
	{
		h->next = NULL;	
	}
	//�߰� ���
	//�ճ���� next �����Ϳ� ���� ����� next�� �����ϰ� ���� ��带 ����.
	else
	{
		h->next = t->next;
	}

	//��ü�� ����� ���, �Ҹ��� ȣ���� ���� �ʴ´�.
	//�Ҹ��ڸ� �Լ� �����ͷ� ������ �ֵ��� �ؾ� �Ѵ�.
	if(pThis->m_pDestory)
	{
		pDestroy pDes = (pDestroy)pThis->m_pDestory;
		pDes(t->ptr);
	}
	else
	{
		//LOG_DEBUG("RemoveAt : 0x%x = %s", t->ptr, t->ptr, 0);

		List_free ((byte*)t->ptr);
		t->ptr = NULL;
	}

	List_free((byte*)t);

    pThis->m_nCount--;

	if (pThis->m_nCount == 0)
	{
		pThis->m_head = NULL;
		pThis->m_last = NULL;
	}

	return 0;
}

//-----------------------------------------------------------
long List_Remove ( void* p )
{
	CLIST pThis = (CLIST)p;

	List_Item* h = pThis->m_head;
	List_Item* t = h;
	
	if (h == NULL)
	{
		return (-1);
	}

	pThis->m_head = h->next;

	//üũ�ϸ� �ȵ�.
	//������ �Ѱ��� ���Ű� �ȵȴ�.
	//if(pThis->m_head == NULL)
	//	return (-2);

	if(pThis->m_pDestory)
	{
		pDestroy pDes = (pDestroy)pThis->m_pDestory;
		pDes(t->ptr);
	}
	else
	{
		//LOG_DEBUG("Remove : 0x%x = %s", t->ptr, t->ptr, 0);
		List_free ((byte*)t->ptr);
		t->ptr = NULL;
	}

	List_free((byte*)t);

	pThis->m_nCount--;
	if (pThis->m_nCount == 0)
	{
		pThis->m_head = NULL;
		pThis->m_last = NULL;
	}

	return 0;
}

//-----------------------------------------------------------
long List_RemoveAll( void* p )
{
	CLIST pThis = (CLIST)p;

	while (pThis->m_head != NULL)
	{
		pThis->Remove(pThis);
	}

	return 0;
}

//-----------------------------------------------------------
void* List_First( void* p )
{
	CLIST pThis = (CLIST)p;

	return ((void*)pThis->m_head);
}

//-----------------------------------------------------------
long List_Print( void* p )
{
	CLIST pThis = (CLIST)p;

	List_Item* h = pThis->m_head;
	List_Item* t = h;

	while (t != NULL)
	{
		//LOG_LOW ("List:: buf = %s", t->ptr, 0, 0);
		t = t->next;
	}

	return 0;
}
