/*----------------------------------------------------------------------------------
	Project Name: Smart 
	Smart Application : SQLite ������
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
	----------	------		------------------------------------------------------
	2014.21.31	�̻���		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/

#ifndef _SQL_H_
#define _SQL_H_

#include	"pwrlove.h"

#define SQLITE_STR  0x00000001
#define SQLITE_UTF  0x00000002
#define SQLITE_BIN  0x00000003
#define SQLITE_INT  0x00000004
#define SQLITE_SEQ  0x00000005

#define SQLITE_DB "SCGGAS.db"

typedef struct _FieldInfo
{
	char* colnm;	//�ʵ��
	char* jsonnm;	//�ʵ��
	long  type;		//�ʵ� Ÿ��
	long  encrypt;	//��ȣ ����
}FieldInfo;

typedef struct _DBInfo
{
	char* szTblnm;      // DB���̺��	
	long nKeyCnt;		// �ʵ� Ű����
	long nUTotCnt;		// �ʵ� �Ѱ���
	long nITotCnt;		// �ʵ� �Ѱ���
	FieldInfo *keyinfo;
	FieldInfo *Ufldinfo; // DB �ʵ���������
	FieldInfo *Ifldinfo;
}DBInfo;

// DB �Է�//json�ʵ�, ����ʵ�, ����, Ű�ʵ�, ����, ���̺��,

//========================================================================================
//1. ��ũ�� ���𿵿�
//========================================================================================

#define	SqLite_LOCAL
#define SqLite_malloc	Mem_Alloc
#define SqLite_free		Mem_Free

//========================================================================================
//2. Ŭ���� �Ž�� ����
//========================================================================================
#define __SQLITE_CLASS_METHODS()\
		DEF_FPTR ( Open			     );	\
		DEF_FPTR ( Close			 );	\
		DEF_FPTR ( ExecDirect		 );	\
		DEF_FPTR ( CreateStatement   );	\
		DEF_FPTR ( CreateStatementI  );	\
		DEF_FPTR ( CreateStatementU  );	\
		DEF_FPTR ( DeleteStatement   );	\
		DEF_FPTR ( Bind			     );	\
		DEF_FPTR ( IBind			 );	\
		DEF_FPTR ( UBind			 );	\
		DEF_FPTR ( Execute			 );	\
		DEF_FPTR ( ExecuteI			 );	\
		DEF_FPTR ( ExecuteU			 );	\
		DEF_FPTR ( Next			     );	\
		DEF_FPTR ( GetColCount		 );	\
		DEF_FPTR ( GetColName		 );	\
		DEF_FPTR ( GetColType		 );	\
		DEF_FPTR ( GetValue		     );	\
		DEF_FPTR ( GetLastError	     );	\
		DEF_FPTR ( SetErrorFlag	     );	\
		DEF_FPTR ( Begin			 );	\
		DEF_FPTR ( Commit			 );	\
		DEF_FPTR ( Rollback		     )


#define __SQLITE_CLASS_METHODS_PROTOTYPES()\
		_TYPEDEF void* ( _X( Open			  ))	( void*     );\
		_TYPEDEF long  ( _X( Close			  ))	( void*		);\
		_TYPEDEF long  ( _X( ExecDirect		  ))	( void*, char*);\
		_TYPEDEF void* ( _X( CreateStatement  ))	( void*, char*);\
		_TYPEDEF void* ( _X( CreateStatementI ))	( void*, char*);\
		_TYPEDEF void* ( _X( CreateStatementU ))	( void*, char*);\
		_TYPEDEF long  ( _X( DeleteStatement  ))	( void*		);\
		_TYPEDEF bool  ( _X( Bind			  ))	( void*, long, char, long*, long, bool );\
		_TYPEDEF bool  ( _X( IBind			  ))	( void*, long, char, long*, long, bool );\
		_TYPEDEF bool  ( _X( UBind			  ))	( void*, long, char, long*, long, bool );\
		_TYPEDEF bool  ( _X( Execute		  ))	( void* 	);\
		_TYPEDEF bool  ( _X( ExecuteI		  ))	( void* 	);\
		_TYPEDEF bool  ( _X( ExecuteU		  ))	( void* 	);\
		_TYPEDEF bool  ( _X( Next			  ))	( void*		);\
		_TYPEDEF long  ( _X( GetColCount	  ))	( void*		);\
		_TYPEDEF char* ( _X( GetColName	      ))	( void*, long );\
		_TYPEDEF char  ( _X( GetColType		  ))	( void*, long );\
		_TYPEDEF long  ( _X( GetValue		  ))	( void*, long , char , long*, long, bool);\
		_TYPEDEF char* ( _X( GetLastError	  ))	( void*		);\
		_TYPEDEF void  ( _X( SetErrorFlag	  ))	( void*		);\
		_TYPEDEF bool  ( _X( Begin			  ))	( void*		);\
		_TYPEDEF bool  ( _X( Commit			  ))	( void*		);\
		_TYPEDEF bool  ( _X( Rollback		  ))	( void*		)

//========================================================================================
//3. �Լ� ������ ���𿵿�
//========================================================================================
#define _TYPEDEF	typedef
#define _X(f)		*SQLITE_##f

		__SQLITE_CLASS_METHODS_PROTOTYPES();

#undef _X
#undef _TYPEDEF

//========================================================================================
//4. �Լ� ����
//========================================================================================
#define _TYPEDEF	SqLite_LOCAL
#define _X(f)	SqLite_##f

		__SQLITE_CLASS_METHODS_PROTOTYPES();
		
#undef _X
#undef _TYPEDEF

//========================================================================================
//5. ����ü ���� (Ŭ����)
//========================================================================================
typedef struct _SqLite
{
	//Ŭ���� ���� ����
	handle m_hdb;
	handle m_hStmt;
	handle m_hUStmt;
	handle m_hIStmt;
	
	long m_nRetError;
	char m_szRetError[128];
	char * m_szSql;
	bool m_bTranFlag;
	bool m_bExecFlag;
	
	#define DEF_FPTR(f)	SQLITE_##f f
	//Ŭ���� �Ž�� ����
	__SQLITE_CLASS_METHODS();
	
	#undef DEF_FPTR

} SqLite, *SQLITE;

#ifdef __cplusplus
extern "C" {
#endif

SQLITE NewSqLite (void);
long DelSqLite(SQLITE p);

#ifdef __cplusplus
}
#endif

/*
global handle SqLite_GetInstance(void* p);
*/

#endif

