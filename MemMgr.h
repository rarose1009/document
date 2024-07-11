/*----------------------------------------------------------------------------------
	Project Name: Smart
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create 스마트폰 포팅
----------------------------------------------------------------------------------*/

#ifndef		_MEMMGR_H_
#define		_MEMMGR_H_

// dkjung 2003-11-05
// 메모리 할당 검증
// 항상 모든 메모리가 해제될경우
// 카운터는 0
#ifdef VER_DEBUG
	#define MEM_VERIFY
#else
	#undef MEM_VERIFY
#endif 	// VER_DEBUG
	
#ifdef MEM_VERIFY
	long s_nMemCount = 0;
#endif

//메모리 매니저가 관리할 수 있는
//메모리 할당 최대 개수
#define MAX_MEM_MGR		51
#define MAX_MEMMSG_LEN  32

// 데이터의 구조화.
// 각 카드간에 공유하는 데이터 선언.

// param 사용 영역

// dkjung 2003-06-18
// 레지스터 처럼 사용하는 변수?
// 필요하면 사용한다.
// 완전한 임시 변수들.
/*	
typedef struct _REG
{
	quad m_ax;
	quad m_bx;
	quad m_cx;
	quad m_dx;

	quad m_si;
	quad m_di;
	quad m_bp;
	quad m_sp;
	
	quad m_cs;
	quad m_ds;
	quad m_ss;
	quad m_es;
} REG;

global REG cpu;
*/

typedef union _PACK_QUAD
{
	byte b[4];
	word w[2];
	quad q; 
} PACK_QUAD;

global PACK_QUAD g_unQuad;

#define TYPE_BYTE	1
#define TYPE_WORD	2
#define TYPE_QUAD	4
typedef struct _PARAM
{
	char	m_chFlag;
	quad 	m_qType;
	quad 	m_qSize;
	void* 	m_pBuf;
} PARAM;

global PARAM g_Param;

#define WRITE_PARAM(flag, type, pBuf, size)												\
		{																				\
			g_Param.m_pBuf = (byte*)g_CreateData ((byte*)pBuf, size*type, size*type);	\
			if (g_Param.m_pBuf)															\
			{																			\
				g_Param.m_chFlag = flag;												\
				g_Param.m_qType	= type;													\
				g_Param.m_qSize	= size;													\
			}																			\
			else																		\
			{																			\
				g_Param.m_chFlag = 0;													\
				g_Param.m_qType	= 0;													\
				g_Param.m_qSize	= 0;													\
			}																			\
		}

#define READ_PARAM(flag, type, pBuf, size)												\
		{																				\
			flag = 	g_Param.m_chFlag;													\
			type = g_Param.m_qType;														\
			size = g_Param.m_qSize;														\
			pBuf = g_Param.m_pBuf;														\
		}
		
#define FREE_PARAM()																	\
		{																				\
			g_Delete(&g_Param.m_pBuf);													\
			g_Param.m_chFlag=0;															\
		}
		
#define CHK_PARAM(flag) ((flag==g_Param.m_chFlag)? 1:0)


/////////////////////////////////////////////////////////
// 		상태 플래그들의 정의
/////////////////////////////////////////////////////////

#define IS_FLAG(flag)  flag
#define SET_FLAG(flag) {flag = 1;}
#define CLR_FLAG(flag) {flag = 0;}
	

// 카드간의 공유 데이터의 할당된 포인터를 저장하는 임시포인터.
global void*	g_pInfo;		
global bool		g_bSaveFlag; 	// 이전 화면의 저장된 데이터를 복구하기 위한 플래그.
global long		g_nSaveNum;		// 이전 화면의 저장된 데이터 개수.

global long		g_nPageIndex;	// 현재의 페이지 인덱스
global long		g_nSelIndex;	// 현재 페이지의 선택된 인덱스

// dkjung 2003-06-11
// 현재 화면의 입력된 데이터를 개수와 함께 저장한다.

#define SET_SAVE_FLAG() 	{g_bSaveFlag = TRUE;}
#define CLR_SAVE_FLAG() 	{g_bSaveFlag = FALSE;}
// 저장된 화면의 데이터가 존재하는지?
#define IS_DATA()			g_bSaveFlag
// 이전에 저장되었던 화면 데이터의 개수를 얻어 옴.
#define GET_DATA_NUM()		g_nSaveNum
#define SAVE_DATA(p, num)					\
		{									\
			g_pInfo = p;					\
			p = NULL;						\
			g_nSaveNum = num;				\
			SET_SAVE_FLAG();				\
		}
// 이전에 저장되었던 화면 데이터의 복구를 완료 함.
#define LOAD_DATA(p, num)					\
		{									\
			if (IS_DATA())					\
			{								\
				p = g_pInfo;				\
				g_pInfo = NULL;				\
				num = g_nSaveNum;			\
				g_nSaveNum = 0;				\
				CLR_SAVE_FLAG();			\
			}								\
			else							\
			{								\
				p = NULL;					\
				num = 0;					\
			}								\
		}

// 저장된 정보를 모두 해제.
#define FREE_SAVE_DATA()					\
		{									\
			if (IS_DATA())					\
			{								\
				free(g_pInfo);				\
				CLR_SAVE_FLAG();			\
			}								\
			g_pInfo = NULL;					\
			g_nSaveNum = 0;					\
		}

// 페이지의 정보도 함께 저장 함.
#define SAVE_PAGE_DATA(p, num, pidx, sidx)	\
		{									\
			g_pInfo = p;					\
			p = NULL;						\
			g_nSaveNum = num;				\
			g_nPageIndex = pidx;			\
			g_nSelIndex = sidx;				\
			SET_SAVE_FLAG();				\
		}
// 이전에 저장되었던 화면 데이터의 복구를 완료 함.
#define LOAD_PAGE_DATA(p, num, pidx, sidx)	\
		{									\
			if (IS_DATA())					\
			{								\
				p = g_pInfo;				\
				g_pInfo = NULL;				\
				num = g_nSaveNum;			\
				pidx = g_nPageIndex;		\
				sidx = g_nSelIndex;			\
				g_nSaveNum = 0;				\
				g_nPageIndex = 0;			\
				g_nSelIndex = 0;			\
				CLR_SAVE_FLAG();			\
			}								\
			else							\
			{								\
				p = NULL;					\
				num = 0;					\
				pidx = 0;					\
				sidx = 0;					\
			}								\
		}

// 저장되었던 데이터와 페이지를 모두 해제. 
#define FREE_SAVE_PAGE_DATA()				\
		{									\
			FREE_SAVE_DATA ();				\
			g_nPageIndex = 0;				\
			g_nSelIndex = 0;				\
		}
		
#ifndef DATA_TYPE
	#define DATA_TYPE byte
#endif // DATA_TYPE

// dkjung 2003-06-11
// 매크로를 통하여만 사용한다.
#define CREATE_INFO(p, nOld, nNew) g_CreateData ((DATA_TYPE*)p, nOld, nNew)
#define DELETE_INFO(p) g_Delete((DATA_TYPE**)&p)

#define MMGR_CREATE(hMem, nOld, nNew, msg) g_CreateMemMgr (hMem, nOld, nNew, msg)
#define MMGR_DELETE(hMem) 	g_DeleteMemMgr (hMem)
#define MMGR_DELETE_ALL 	g_DeleteMemMgrAll

#define MMGR_GET_LEAKSIZE	g_GetMemLeakSize
#define MMGR_GET_LEAKINFO(i, msg, size, pMem) g_GetMemLeakInfo (i, msg, size, pMem)	

typedef struct _MEM_MGR_INFO
{
	long		m_nSize;
	char		m_szName[MAX_MEMMSG_LEN];
	DATA_TYPE*	m_pMem;
} MEM_MGR_INFO;

global  MEM_MGR_INFO g_stMemMgr[ MAX_MEM_MGR ];

global	DATA_TYPE*	g_CreateData 	(DATA_TYPE* pOld, quad nOldSize, quad nNewSize);
global	long g_New 					(DATA_TYPE* p[], long nSize);
global	long g_Delete 				(DATA_TYPE* p[]);

global long g_CreateMemMgr ( long hMem, quad nOldSize, quad nNewSize, char* pszMsg );
global long g_DeleteMemMgr ( long hMem );
global void g_DeleteMemMgrAll ( void );
global long g_GetMemLeakSize ( void );
global long g_GetMemLeakInfo ( long hMem, char* pszMsg, long* pSize, long* pMem );


#endif	//	_MEMMGR_H_

