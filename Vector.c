/*----------------------------------------------------------------------------------

	Project Name : Power Application Framework
	
	Class Name : Vector

	Copyright(c) 2011 Value CMD Co., Ltd.

	----------	------		------------------------------------------------------
	2011.04.20	pwrlove		v1.00		: Create
----------------------------------------------------------------------------------*/

#include "Vector.h"

//========================================================================================
//6. static 함수 영역
//========================================================================================

//-----------------------------------------------------------
//생성자
CVECTOR NewVector (long nObjSize, long nCapacity)
{
	CVECTOR p;

	p = (CVECTOR) Vector_malloc ( sizeof(Vector) );
	if (p == NULL)
	{
		return NULL;
	}

	//멤버 변수 초기화
	p->m_nObjSize = nObjSize;
	p->m_nCapacity = nCapacity;
	p->m_nCount = 0;

	p->m_pIndex = NULL;
	p->m_cpList = NULL;
	
	#define _DEF_FPTR(f)	p->f = (CVECTOR_##f) Vector_##f
	
	//매쏘드 설정
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
//소멸자
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
//7. 매쏘드 영역
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
		//이 경우는 기존에 할당된 엘러먼트가 존재하는 경우.
		//제거하거나, 넣지 못 하도록 해야 한다.
		//insert 기능은 지원하지 않는다.
		//항상 맨 끝에 추가하는 걸로 처리.
//		LOG_ERROR("Vector:: Add: Already exist in this index(%d)",index,0,0);
//		return -1;
//	}

	if (index > pThis->m_nCapacity-1)
	{
		//10개씩 늘려나간다.
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

	//추가된 element의 포인터를 얻어서 인덱스에 저장해 둔다. 어떻게?
	//항상 마지막에 추가되므로, 마지막 포인터를 얻으면 된다.
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
		//10개씩 늘려나간다.
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

	//추가된 element의 포인터를 얻어서 인덱스에 저장해 둔다. 어떻게?
	//항상 마지막에 추가되므로, 마지막 포인터를 얻으면 된다.
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
		//정상적인 상황에서 출력되는 메시지 임.
		//LOG_ERROR ("Vector:: Get : index out of range(%d)", index,0,0 );
		return NULL;
	}

	e = (ArrayElement*)pThis->m_pIndex[index];

	//디버깅 용도로만 가능하다.
	//매직 넘버 (MS만 사용가능)
	//if (e == (ArrayElement*)0xFDFDFDFD ||	// 할당된 메모리의 전후 가드용 바이트에 채워지는 값
	//	e == (ArrayElement*)0xFEEEFEEE ||	// 힙을 해제한 후, 채워지는 값
	//	e == (ArrayElement*)0xDDDDDDDD )	// 힙에서 free된 메모리.
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

	//디버깅 용도로만 가능하다.
	//매직 넘버 (MS만 사용가능)
	//if (e == (ArrayElement*)0xFDFDFDFD ||	// 할당된 메모리의 전후 가드용 바이트에 채워지는 값
	//	e == (ArrayElement*)0xFEEEFEEE ||	// 힙을 해제한 후, 채워지는 값
	//	e == (ArrayElement*)0xDDDDDDDD )	// 힙에서 free된 메모리.
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

	//디버깅 용도로만 가능하다.
	//매직 넘버 (MS만 사용가능)
	//if (e == (ArrayElement*)0xFDFDFDFD ||	// 할당된 메모리의 전후 가드용 바이트에 채워지는 값
	//	e == (ArrayElement*)0xFEEEFEEE ||	// 힙을 해제한 후, 채워지는 값
	//	e == (ArrayElement*)0xDDDDDDDD )	// 힙에서 free된 메모리.
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

	//디버깅 용도로만 가능하다.
	//매직 넘버 (MS만 사용가능)
	//if (e == (ArrayElement*)0xFDFDFDFD ||	// 할당된 메모리의 전후 가드용 바이트에 채워지는 값
	//	e == (ArrayElement*)0xFEEEFEEE ||	// 힙을 해제한 후, 채워지는 값
	//	e == (ArrayElement*)0xDDDDDDDD )	// 힙에서 free된 메모리.
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
		//capacity는 줄이지 말고, 인덱스 버퍼만 조정한다.
		for (i=index; i<pThis->m_nCount; i++)
		{
			pThis->m_pIndex[i] = pThis->m_pIndex[i+1];
		}

		//맨 마지막 인덱스는 클리어.
		pThis->m_pIndex[i] = 0;

		//총 개수를 한개 줄인다.
		pThis->m_nCount--;

		//리스트의 노드를 제거한다.
		al->removeAt(al, index);
	}

	return (0);
}

//컬렉션 객체의 Remove 기능을 사용하기 위해선 아래의 매쏘드를
//사용해야 한다. 그렇지 않을 경우, 정확한 객체의 소멸자가 호출되지 않는다.
//그 경우에 대한 대응이 정확하지 않을 경우는 Remove, RemoveAll을 가급적
//사용하지 않아야 한다, 대신 각 원소를 직접 액세스하여 하나씩 지워야 한다.
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
