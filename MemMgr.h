/*----------------------------------------------------------------------------------
	Project Name: Smart
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/

#ifndef		_MEMMGR_H_
#define		_MEMMGR_H_

// dkjung 2003-11-05
// �޸� �Ҵ� ����
// �׻� ��� �޸𸮰� �����ɰ��
// ī���ʹ� 0
#ifdef VER_DEBUG
	#define MEM_VERIFY
#else
	#undef MEM_VERIFY
#endif 	// VER_DEBUG
	
#ifdef MEM_VERIFY
	long s_nMemCount = 0;
#endif

//�޸� �Ŵ����� ������ �� �ִ�
//�޸� �Ҵ� �ִ� ����
#define MAX_MEM_MGR		51
#define MAX_MEMMSG_LEN  32

// �������� ����ȭ.
// �� ī�尣�� �����ϴ� ������ ����.

// param ��� ����

// dkjung 2003-06-18
// �������� ó�� ����ϴ� ����?
// �ʿ��ϸ� ����Ѵ�.
// ������ �ӽ� ������.
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
// 		���� �÷��׵��� ����
/////////////////////////////////////////////////////////

#define IS_FLAG(flag)  flag
#define SET_FLAG(flag) {flag = 1;}
#define CLR_FLAG(flag) {flag = 0;}
	

// ī�尣�� ���� �������� �Ҵ�� �����͸� �����ϴ� �ӽ�������.
global void*	g_pInfo;		
global bool		g_bSaveFlag; 	// ���� ȭ���� ����� �����͸� �����ϱ� ���� �÷���.
global long		g_nSaveNum;		// ���� ȭ���� ����� ������ ����.

global long		g_nPageIndex;	// ������ ������ �ε���
global long		g_nSelIndex;	// ���� �������� ���õ� �ε���

// dkjung 2003-06-11
// ���� ȭ���� �Էµ� �����͸� ������ �Բ� �����Ѵ�.

#define SET_SAVE_FLAG() 	{g_bSaveFlag = TRUE;}
#define CLR_SAVE_FLAG() 	{g_bSaveFlag = FALSE;}
// ����� ȭ���� �����Ͱ� �����ϴ���?
#define IS_DATA()			g_bSaveFlag
// ������ ����Ǿ��� ȭ�� �������� ������ ��� ��.
#define GET_DATA_NUM()		g_nSaveNum
#define SAVE_DATA(p, num)					\
		{									\
			g_pInfo = p;					\
			p = NULL;						\
			g_nSaveNum = num;				\
			SET_SAVE_FLAG();				\
		}
// ������ ����Ǿ��� ȭ�� �������� ������ �Ϸ� ��.
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

// ����� ������ ��� ����.
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

// �������� ������ �Բ� ���� ��.
#define SAVE_PAGE_DATA(p, num, pidx, sidx)	\
		{									\
			g_pInfo = p;					\
			p = NULL;						\
			g_nSaveNum = num;				\
			g_nPageIndex = pidx;			\
			g_nSelIndex = sidx;				\
			SET_SAVE_FLAG();				\
		}
// ������ ����Ǿ��� ȭ�� �������� ������ �Ϸ� ��.
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

// ����Ǿ��� �����Ϳ� �������� ��� ����. 
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
// ��ũ�θ� ���Ͽ��� ����Ѵ�.
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

