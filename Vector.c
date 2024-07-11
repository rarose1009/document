/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : Vector

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#include "Vector.h"

//========================================================================================
//6. static �Լ� ����
//========================================================================================

//-----------------------------------------------------------
//������
CVECTOR NewVector (long nObjSize, long nCapacity)
{
	CVECTOR p;

	p = (CVECTOR) Vector_malloc ( sizeof(Vector) );
	if (p == NULL)
	{
		return NULL;
	}

	//��� ���� �ʱ�ȭ
	p->m_nObjSize = nObjSize;
	p->m_nCapacity = nCapacity;
	p->m_nCount = 0;

	p->m_pIndex = NULL;
	p->m_cpList = NULL;
	
	#define _DEF_FPTR(f)	p->f = (CVECTOR_##f) Vector_##f
	
	//�Ž�� ����
	__CVECTOR_CLASS_METHODS();
	
	#undef _DEF_FPTR

	if (nCapacity == 0)
	{
		p->m_nCapacity = Vector_CAPACITY;
	}

	p->m_pIndex = (long*)Vector_malloc (sizeof(long) * p->m_nCapacity);
	if (p->m_pIndex == NULL)
	{
		Vector_free((byte*)p);
		return NULL;
	}

	Vector_memset((byte*)p->m_pIndex, 0, sizeof(long) * p->m_nCapacity);

	p->m_cpList = NewArrayList();
	if (p->m_cpList == NULL)
	{
		Vector_free((byte*)p->m_pIndex);
		Vector_free((byte*)p);
		return NULL;
	}

	CM_NEW_CHECK(p);

	return p;
}

//-----------------------------------------------------------
//�Ҹ���
long _DelVector (CVECTOR pp[])
{
	CVECTOR p = *pp;

	//CM_DEL_CHECK(p, DelVector);

	p->RemoveAll(p);

	if (p->m_pIndex)
	{
		Vector_free((byte*)p->m_pIndex);
		p->m_pIndex = NULL;
	}

	if (p->m_cpList)
	{
		DelArrayList(p->m_cpList);
		p->m_cpList = NULL;
	}

	Vector_free ((byte*)*pp);
	*pp = NULL;

	return 0;
}

//========================================================================================
//7. �Ž�� ����
//========================================================================================
//-----------------------------------------------------------
long Vector_Capacity( void* p )
{
	CVECTOR pThis = (CVECTOR)p;

	return (pThis->m_nCapacity);
}

//-----------------------------------------------------------
long Vector_Size( void* p )
{
	CVECTOR pThis = (CVECTOR)p;

	return (pThis->m_nCount);
}

//-----------------------------------------------------------
BOOL Vector_IsEmpty( void* p )
{
	CVECTOR pThis = (CVECTOR)p;

	return (pThis->m_nCount==0)? TRUE: FALSE;
}

//-----------------------------------------------------------
long Vector_Add ( void* p, long index, void* pObj )
{
	CVECTOR pThis = (CVECTOR)p;
	CARRAYLIST al = pThis->m_cpList;
	long n = pThis->m_nCapacity;
	long nSize = (n + Vector_CAPACITY) * sizeof(long);
	long nPos = index * pThis->m_nObjSize;

//	if ( index < pThis->m_nCount-1 || pThis->m_pIndex[index] != NULL)
//	{
		//�� ���� ������ �Ҵ�� ������Ʈ�� �����ϴ� ���.
		//�����ϰų�, ���� �� �ϵ��� �ؾ� �Ѵ�.
		//insert ����� �������� �ʴ´�.
		//�׻� �� ���� �߰��ϴ� �ɷ� ó��.
//		LOG_ERROR("Vector:: Add: Already exist in this index(%d)",index,0,0);
//		return -1;
//	}

	if (index > pThis->m_nCapacity-1)
	{
		//10���� �÷�������.
		long* pIndex = (long*)Vector_malloc(nSize);

		if (pThis->m_pIndex)
		{
			memset(pIndex, 0, nSize);
			memcpy(pIndex, pThis->m_pIndex, pThis->m_nCapacity * sizeof(long));
			Vector_free((byte*)pThis->m_pIndex);
		}

		pThis->m_pIndex = pIndex;
		pThis->m_nCapacity = n + Vector_CAPACITY;
	}

	al->addBin(al, pObj, pThis->m_nObjSize);

	//�߰��� element�� �����͸� �� �ε����� ������ �д�. ���?
	//�׻� �������� �߰��ǹǷ�, ������ �����͸� ������ �ȴ�.
	pThis->m_pIndex[index] = (long)al->last(al);

	return (pThis->m_nCount++);
}

//-----------------------------------------------------------
long Vector_AddElementAt ( void* p, long index, void* pObj )
{
	CVECTOR pThis = (CVECTOR)p;

	return pThis->Add(pThis, index, pObj); 
}

//-----------------------------------------------------------
long Vector_AddElement ( void* p, void* pObj )
{
	CVECTOR pThis = (CVECTOR)p;

	return pThis->Add(pThis, pThis->m_nCount, pObj); 
}

//-----------------------------------------------------------
long Vector_IndexOf (void* p, void* pObj, long index)
{
	CVECTOR pThis = (CVECTOR)p;
	long i;

	if ( CM_ISNULL(pObj) )
	{
		for (i=index; i<pThis->m_nCount; i++)
		{
			if (pThis->m_pIndex[i] == 0)
				return i;
		}
	}
	else
	{
		for (i=index; i<pThis->m_nCount; i++)
		{
			if (pThis->m_pIndex[i] == (long)pObj)
				return i;
		}
	}

	return -1;
}

//-----------------------------------------------------------
long Vector_AddInt ( void* p, long index, long nVal )
{
	CVECTOR pThis = (CVECTOR)p;
	CARRAYLIST al = pThis->m_cpList;
	long n = pThis->m_nCapacity;
	long nSize = (n + Vector_CAPACITY) * sizeof(long);
	long nPos = index * pThis->m_nObjSize;

	if (index > pThis->m_nCapacity-1)
	{
		//10���� �÷�������.
		long* pIndex = (long*)Vector_malloc(nSize);

		if (pThis->m_pIndex)
		{
			memset(pIndex, 0, nSize);
			memcpy(pIndex, pThis->m_pIndex, pThis->m_nCapacity * sizeof(long));
			Vector_free((byte*)pThis->m_pIndex);
		}

		pThis->m_pIndex = pIndex;
		pThis->m_nCapacity = n + Vector_CAPACITY;
	}

	al->addInt(al, nVal);

	//�߰��� element�� �����͸� �� �ε����� ������ �д�. ���?
	//�׻� �������� �߰��ǹǷ�, ������ �����͸� ������ �ȴ�.
	pThis->m_pIndex[index] = (long)al->last(al);

	return (pThis->m_nCount++);
}

//-----------------------------------------------------------
long Vector_LastIndexOf (void* p, void* pObj, long index)
{
	CVECTOR pThis = (CVECTOR)p;
	long i;

	if ( CM_ISNULL(pObj) )
	{
		for (i=index; i>=0; i--)
		{
			if (pThis->m_pIndex[i] == 0)
				return i;
		}
	}
	else
	{
		for (i=index; i>=0; i--)
		{
			if (pThis->m_pIndex[i] == (long)pObj)
				return i;
		}
	}

	return -1;
}

//-----------------------------------------------------------
void* Vector_Get ( void* p, long index )
{
	CVECTOR pThis = (CVECTOR)p;
	ArrayElement* e = NULL;

	if (index > pThis->m_nCount-1)
	{
		//�������� ��Ȳ���� ��µǴ� �޽��� ��.
		//LOG_ERROR ("Vector:: Get : index out of range(%d)", index,0,0 );
		return NULL;
	}

	e = (ArrayElement*)pThis->m_pIndex[index];

	//����� �뵵�θ� �����ϴ�.
	//���� �ѹ� (MS�� ��밡��)
	//if (e == (ArrayElement*)0xFDFDFDFD ||	// �Ҵ�� �޸��� ���� ����� ����Ʈ�� ä������ ��
	//	e == (ArrayElement*)0xFEEEFEEE ||	// ���� ������ ��, ä������ ��
	//	e == (ArrayElement*)0xDDDDDDDD )	// ������ free�� �޸�.
	//{
	//	LOG_ERROR ("Vector:: Get: memory pointer failure(0x%x).", e,0,0 );
	//	return NULL;
	//}

	if ( !CM_ISNULL(e) )
	{
		return e->m_pData;
	}
	
	return NULL;
}

//-----------------------------------------------------------
long Vector_GetInt ( void* p, long index )
{
	CVECTOR pThis = (CVECTOR)p;
	CARRAYLIST al = pThis->m_cpList;
	void* ptr = (void*)pThis->m_pIndex[index];

	return (long)al->getBuffer(al, ptr);
}

//-----------------------------------------------------------
void* Vector_ElementAt ( void* p, long index )
{
	CVECTOR pThis = (CVECTOR)p;
	ArrayElement* e = NULL;
	
	if (index > pThis->m_nCount-1)
	{
		//LOG_ERROR ("Vector:: ElementAt : index out of range(%d)", index,0,0 );
		return NULL;
	}

	e = (ArrayElement*)pThis->m_pIndex[index];

	//����� �뵵�θ� �����ϴ�.
	//���� �ѹ� (MS�� ��밡��)
	//if (e == (ArrayElement*)0xFDFDFDFD ||	// �Ҵ�� �޸��� ���� ����� ����Ʈ�� ä������ ��
	//	e == (ArrayElement*)0xFEEEFEEE ||	// ���� ������ ��, ä������ ��
	//	e == (ArrayElement*)0xDDDDDDDD )	// ������ free�� �޸�.
	//{
	//	LOG_ERROR ("Vector:: ElementAt: memory pointer failure(0x%x).", e,0,0 );
	//	return NULL;
	//}

	if ( !CM_ISNULL(e) )
	{
		return e->m_pData;
	}

	return NULL;
}

//-----------------------------------------------------------
void* Vector_FirstElement ( void* p )
{
	CVECTOR pThis = (CVECTOR)p;

	ArrayElement* e = (ArrayElement*)pThis->m_pIndex[0];

	//����� �뵵�θ� �����ϴ�.
	//���� �ѹ� (MS�� ��밡��)
	//if (e == (ArrayElement*)0xFDFDFDFD ||	// �Ҵ�� �޸��� ���� ����� ����Ʈ�� ä������ ��
	//	e == (ArrayElement*)0xFEEEFEEE ||	// ���� ������ ��, ä������ ��
	//	e == (ArrayElement*)0xDDDDDDDD )	// ������ free�� �޸�.
	//{
	//	LOG_ERROR ("Vector:: FirstElement: memory pointer failure(0x%x).", e,0,0 );
	//	return NULL;
	//}

	if ( !CM_ISNULL(e) )
	{
		return e->m_pData;
	}

	return NULL;
}

//-----------------------------------------------------------
void* Vector_LastElement ( void* p )
{
	CVECTOR pThis = (CVECTOR)p;

	ArrayElement* e = (ArrayElement*)pThis->m_pIndex[pThis->m_nCount];

	//����� �뵵�θ� �����ϴ�.
	//���� �ѹ� (MS�� ��밡��)
	//if (e == (ArrayElement*)0xFDFDFDFD ||	// �Ҵ�� �޸��� ���� ����� ����Ʈ�� ä������ ��
	//	e == (ArrayElement*)0xFEEEFEEE ||	// ���� ������ ��, ä������ ��
	//	e == (ArrayElement*)0xDDDDDDDD )	// ������ free�� �޸�.
	//{
	//	LOG_ERROR ("Vector:: LastElement: memory pointer failure(0x%x).", e,0,0 );
	//	return NULL;
	//}

	if ( !CM_ISNULL(e) )
	{
		return e->m_pData;
	}

	return NULL;
}

//-----------------------------------------------------------
long Vector_Remove ( void* p, long index )
{
	CVECTOR pThis = (CVECTOR)p;
	CARRAYLIST al = pThis->m_cpList;
	long i;

	if (index > pThis->m_nCount-1)
	{
		//LOG_ERROR ("Vector:: Remove: index out of range(%d)", index,0,0 );
		return (-1);
	}

	if (pThis->m_pIndex)
	{
		//capacity�� ������ ����, �ε��� ���۸� �����Ѵ�.
		for (i=index; i<pThis->m_nCount; i++)
		{
			pThis->m_pIndex[i] = pThis->m_pIndex[i+1];
		}

		//�� ������ �ε����� Ŭ����.
		pThis->m_pIndex[i] = 0;

		//�� ������ �Ѱ� ���δ�.
		pThis->m_nCount--;

		//����Ʈ�� ��带 �����Ѵ�.
		al->removeAt(al, index);
	}

	return (0);
}

//�÷��� ��ü�� Remove ����� ����ϱ� ���ؼ� �Ʒ��� �Ž�带
//����ؾ� �Ѵ�. �׷��� ���� ���, ��Ȯ�� ��ü�� �Ҹ��ڰ� ȣ����� �ʴ´�.
//�� ��쿡 ���� ������ ��Ȯ���� ���� ���� Remove, RemoveAll�� ������
//������� �ʾƾ� �Ѵ�, ��� �� ���Ҹ� ���� �׼����Ͽ� �ϳ��� ������ �Ѵ�.
//-----------------------------------------------------------
long Vector_SetDestroy ( void* p, void* pDel )
{
	CVECTOR pThis = (CVECTOR)p;
	CARRAYLIST al = pThis->m_cpList;

	if ( !CM_ISNULL(al) )
	{
		al->setDestroy(al, pDel);
	}

	return 0;
}

//-----------------------------------------------------------
long Vector_RemoveAll ( void* p )
{
	CVECTOR pThis = (CVECTOR)p;
	CARRAYLIST al = pThis->m_cpList;

	if (pThis->m_pIndex)
	{
		if ( !CM_ISNULL(al) )
		{
			al->removeAll(al);
		}

		Vector_free((byte*)pThis->m_pIndex);
		pThis->m_pIndex = NULL;
		pThis->m_nCount = 0;
		pThis->m_nCapacity = 0;
	}

	return 0;
}

//-----------------------------------------------------------
char* Vector_toString(void* p)
{
	CVECTOR pThis = (CVECTOR)p;

	return "";
}
