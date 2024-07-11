#ifndef		LIBSYSCALL_H
#define		LIBSYSCALL_H

//------------------------------------------------------------------------------
//		card
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		���� ���� ���� ī�带 ����� ���ο� ī�带 �޸𸮿� �ø���
//	Return
//		����
//	Parameters
//		pCardName(in)	: �ε��� ī�� �̸�
//-----------------------------------------------------------------------------
syscall void	Card_Load (char* pCardName);

//-----------------------------------------------------------------------------
//	Description
//		���� ���� ���� ī�带 ������ �ʰ� ���ο� ī�带 �޸𸮿� �ø���
//	Return
//		����
//	Parameters
//		pCardName(in)	: �ε��� ī�� �̸�
//-----------------------------------------------------------------------------
syscall void	Card_Insert (char* pCardName);

//-----------------------------------------------------------------------------
//	Description
//		�޸𸮿� �ִ� ī�带 ���������� �����
//	Return
//		����
//	Parameters
//		pCardName(in)	: ���� ī�� �̸�
//-----------------------------------------------------------------------------
syscall void	Card_Delete (char* pCardName);

//------------------------------------------------------------------------------
//		database
//------------------------------------------------------------------------------

//winCE���� ���Ǵ� Database volume mounting mode : dkjung 2003-01-03
#define DB_VOLUM_CREATE_NEW				0x00000001
#define DB_VOLUM_CREATE_ALWAYS			0x00000002
#define DB_VOLUM_OPEN_EXISTING			0x00000003
#define DB_VOLUM_OPEN_ALWAYS			0x00000004
#define DB_VOLUM_TRUNCATE_EXISTING		0x00000005

//winCE���� ���Ǵ� Database volume GUID : dkjung 2003-01-03
typedef struct  _DBGUID
{
    quad Data1;
    quad Data2;
    quad Data3;
    quad Data4;
} DBGUID;

//-----------------------------------------------------------------------------
//	Description
//		�ܺ� �޸� ī�� ����Ÿ ���̽��� ���� �����ϵ���.
//		����Ÿ ���̽� Volume�� Mounting �Ѵ�.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pGuid (out)			: Mounting�� ����Ÿ���̽� Volume�� GUID.
//		pszMountName (in)	: ����Ÿ ���̽� Volume �̸�
//		nMode (in)			: Mounting ���
//			DB_VOLUM_CREATE_NEW			: �� ������ ����, ������ ����.
//			DB_VOLUM_CREATE_ALWAYS		: �� ������ ����, ������ ���� ����.
//			DB_VOLUM_OPEN_EXISTING		: �̹� ������ ������ ����, ������ ����.
//			DB_VOLUM_OPEN_ALWAYS		: �̹� ������ ������ ����, ������ ���� ����.
//			DB_VOLUM_TRUNCATE_EXISTING	: �̹� ������ ������ ����, ������ ����, ������ ����.
//	support : Win CE
//-----------------------------------------------------------------------------
syscall long DB_MountVol (DBGUID* pGuid, char* pszMountName, long nMode);

//-----------------------------------------------------------------------------
//	Description
//		����Ÿ ���̽� Volume�� Unmounting �Ѵ�.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pGuid (in)	: Mounting�� ����Ÿ���̽� Volume�� GUID
//	support : Win CE
//-----------------------------------------------------------------------------
syscall long DB_UnmountVol (DBGUID* pGuid);

//-----------------------------------------------------------------------------
//	Description
//		����Ÿ ���̽��� �����.
//	Return
//		success	: ������� ����Ÿ���̽��� OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		pcName (in)		: ����Ÿ ���̽� �̸�
//		nDatabaseType	: ����Ÿ ���̽� Ÿ�� (������� (2)DB type ����)
//		nNumSpec		: ��Ʈ�� �ʵ��� ����
//		pFieldID (in)	: ��Ʈ�Ǵ� �ʵ��� ���̵� �迭 (��� (3)Field ID ����)
//		pSortOrder (in)	: �� �ʵ��� ���� ��� (��� (4)Sort Desc ����)
//-----------------------------------------------------------------------------
syscall long	DB_CreateDatabase (char *pcName, long nDatabaseType, long nNumSpec, long* pFieldID, byte* pSortOrder);

//-----------------------------------------------------------------------------
//	Description
//		����Ÿ���̽� OID�� ����Ÿ���̽��� �����Ѵ�.
//	Return
//		success	: true
//		fail	: false
//	Param
//		nOidDatabase : Database OID
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_DeleteDatabase (long nOidDatabase);

//-----------------------------------------------------------------------------
//	Description
//		����Ÿ���̽� OID�� ����Ÿ���̽��� �����Ѵ�.
//	Return
//		success	: OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		nOidDatabase : Database OID
//		nKeyFieldId  : sort field ID
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_OpenDatabase (long nOidDatabase, long nKeyField);

//-----------------------------------------------------------------------------
//	Description
//		����Ÿ ���̽��� �ݴ´�.
//	Return
//		success	: true
//		fail	: false
//	Param
//		hDatabase	: ����Ÿ���̽� �ڵ�
//-----------------------------------------------------------------------------
syscall long 	DB_CloseDatabase (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		���ο� ���ڵ带 �����Ѵ�.
//	Return
//		success	: ������� ���ڵ��� OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase	: ����Ÿ���̽� �ڵ�
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_CreateRecord (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		���ڵ带 �����Ѵ�.
//	Return
//		success	: true
//		fail	: false
//	Param
//		hDatabase	: database handle
//		oidRecord	: oid of record
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_DeleteRecord (long hDatabase, long nOidRecord);

//-----------------------------------------------------------------------------
//	Description
//		save record
//	Return
//		success : true
//		fail	: false
//	Param
//		hDatabase : database handle
//		nOidRecord : record oid
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_SaveRecord (long hDatabase, long nOidRecord);

//-----------------------------------------------------------------------------
//	Description
//		�ʵ带 �����Ѵ�.
//	Return
//		success	: true
//		fail	: false
//	Param
//		hDatabase : database handle
//		nOidRecord : Record OID
//		nFieldID : field id
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_DeleteField (long hDatabase, long nOidRecord, long nFieldID);

//-----------------------------------------------------------------------------
//	Description
//		get int field
//	Return
//		success	: 4
//		fail	: -1
//	Param
//		hDatabase : database handle
//		nOidRecord : record oid
//		nFieldID : field id
//		pValue : return field value
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_ReadIntField (long hDatabase, long nOidRecord, long nFieldID, long* pValue);

//-----------------------------------------------------------------------------
//	Description
//		get time field
//	Return
//		success	: 4
//		fail	: -1
//	Param
//		hDatabase : database handle
//		nOidRecord : record oid
//		nFieldID : field id
//		pValue : return field value
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_ReadTimeField (long hDatabase, long nOidRecord, long nFieldID, long* pTime);

//-----------------------------------------------------------------------------
//	Description
//		get string field
//	Return
//		success	: -1
//		fail	: read length
//	Param
//		hDatabase : database handle
//		nOidRecord : record oid
//		nFieldID : field id
//		pValue : return field value
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_ReadStringField (long hDatabase, long nOidRecord, long nFieldID, byte* pBuffer, long nLen);

//-----------------------------------------------------------------------------
//	Description
//		read vinary from field
//	Return
//		succes	: size of field
//		fail	: -1
//	Param
//		hDatabase	: db handle
//		nOidRecord	: oid of record
//		nFieldID	: field id
//		pBuffer (in, out)	: buffer for string
//		nLen		: length of buffer
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_ReadBinaryField (long hDatabase, long nOidRecord, long nFieldID, byte* pBuffer, long nLen);

//-----------------------------------------------------------------------------
//	Description
//		write int field
//	Return
//		success	: true
//		fail	: false
//	Param
//		hDatabase : database handle
//		nOidRecord : record oid
//		nFieldID : field id
//		nValue : writing value
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_WriteIntField (long hDatabase, long nOidRecord, long nFieldID, long nValue);

//-----------------------------------------------------------------------------
//	Description
//		write time field
//	Return
//		success	: true
//		fail	: false
//	Param
//		hDatabase : database handle
//		nOidRecord : record oid
//		nFieldID : field id
//		nTime : writing value
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_WriteTimeField (long hDatabase, long nOidRecord, long nFieldID, long nTime);

//-----------------------------------------------------------------------------
//	Description
//		write int field
//	Return
//		success	: true
//		fail	: false
//	Param
//		hDatabase : database handle
//		nOidRecord : record oid
//		nFieldID : field id
//		pBuffer : writing value
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_WriteStringField (long hDatabase, long nOidRecord, long nFieldID, byte* pBuffer);

//-----------------------------------------------------------------------------
//	Description
//		���̳ʸ� �ʵ� ���� ����Ѵ�.
//	Return
//		success	: true
//		fail	: false
//	Param
//		hDatabase	: database handle
//		nOidRecord	: record oid
//		nFieldID	: field id
//		pBuffer (in): ���� ��
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_WriteBinaryField (long hDatabase, long nOidRecord, long nFieldID, byte* pBuffer, long nLen);

//-----------------------------------------------------------------------------
//	Description
//		search int field
//	Return
//		success	: record OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase : database handle
//		nFieldID : field id
//		nValue : searching value
//		nSearchType : VD_DB_SEARCH_SMALLER, VD_DB_SEARCH_FIRSTEQUAL, VD_DB_SEARCH_NEXTEQUAL, VD_DB_SEARHC_GREATER		= 3;
//	Remarks
//		must be opened with sort field id 
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_SearchRecordInt (long hDatabase, long nFieldID, long nValue, long nSearchType);

//-----------------------------------------------------------------------------
//	Description
//		search time field
//	Return
//		success	: record OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase : database handle
//		nFieldID : field id
//		nValue : searching value
//		nSearchType : VD_DB_SEARCH_SMALLER, VD_DB_SEARCH_FIRSTEQUAL, VD_DB_SEARCH_NEXTEQUAL, VD_DB_SEARHC_GREATER		= 3;
//	Remarks
//		must be opened with sort field id 
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_SearchRecordTime (long hDatabase, long nFieldID, long nValue, long nSearchType);

//-----------------------------------------------------------------------------
//	Description
//		search string field
//	Return
//		success	: record OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase : database handle
//		nFieldID : field id
//		pValue : searching value
//		nSearchType : VD_DB_SEARCH_SMALLER, VD_DB_SEARCH_FIRSTEQUAL, VD_DB_SEARCH_NEXTEQUAL, VD_DB_SEARHC_GREATER		= 3;
//	Remarks
//		must be opened with sort field id 
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_SearchRecordStr (long hDatabase, long nFieldID, byte* pValue, long nSearchType);

//-----------------------------------------------------------------------------
//	Description
//		search record accoring sorint order
//	Return
//		success	: record OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase : database handle
//		nFieldID : field id
//		nValue : searching value
//		nPosType : VD_DB_SEQ_START, VD_DB_SEQ_CURRENT, VD_DB_SEQ_END
//	Remarks
//		must be opened with sort field id 
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_SearchRecordSequential (long hDatabase, long nPosType, long nOffset);

//-----------------------------------------------------------------------------
//	Description
//		����� ���ڵ� OID�� ���������� �����´�.
//		DB_OpenEnumRecord()ȣ���� ����ؾ� �Ѵ�.
//		Ŀ���� ���� ���ڵ�� �̵�
//	Return
//		success	: OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase	: database handle
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_EnumRecord (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		����� ���ڵ� OID�� ���������� �����´�.
//		����� ù��° ���ڵ带 Ŀ���� �̵��Ѵ�.
//	Return
//		success	: 1
//		fail	: 0
//	Param
//		hDatabase	: database handle
//	Notice
//		2.0������ �ڵ��� ���Ϲ޾����� 2.5������ �ڵ��� �����ϴ� ���� �ƴϴ�.
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_OpenEnumRecord (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		����� ���ڵ� OID�� ���������� �������� ���� �����Ѵ�.
//		Ŀ���� ù��° ���ڵ�� �̵���Ų��.
//	Return
//		success	: 1
//		fail	: 0
//	Param
//		hDatabase	: database handle
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_CloseEnum (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		clear search condition ( DB_XXXCondXXXX() )
//	Return
//		success : true
//		fail	: false
//	Param
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_ClearCondition (void);

//-----------------------------------------------------------------------------
//	Description
//		add search condition ( DB_XXXCondXXXX() )
//	Return
//		success : true
//		fail	: false
//	Param
//		nFieldID : field id to search
//		nValue : searching value
//		nCond : VD_DB_NOTEQUAL_CON, VD_DB_EQUAL_CON	, VD_DB_GREATER_CON, VD_DB_SMALLER_CON
//		nOpt : VD_DB_AND_CON, VD_DB_OR_CON
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_AddCondValue (long nFieldID, long nValue, long nCond, long nOpt);

//-----------------------------------------------------------------------------
//	Description
//		add search condition ( DB_XXXCondXXXX() )
//	Return
//		success : true
//		fail	: false
//	Param
//		nFieldID : field id to search
//		nValue : searching value
//		nCond : VD_DB_NOTEQUAL_CON, VD_DB_EQUAL_CON	, VD_DB_GREATER_CON, VD_DB_SMALLER_CON, VD_DB_MATCHSTR_CON
//		nOpt : VD_DB_AND_CON, VD_DB_OR_CON
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_AddCondStr (long nFieldID, byte* pPtr, long nCond, long nOpt);

//-----------------------------------------------------------------------------
//	Description
//		find first record satisfying conditions
//	Return
//		success : record oid
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase : database handle
//	Remarks
//		if open with sorting field id, return oid according to sorted order
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_FirstRecordCond (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		find next record satisfying conditions
//	Return
//		success : record oid
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase : database handle
//	Remarks
//		if open with sorting field id, return oid according to sorted order
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_NextRecordCond (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		get record count satisfying condition
//	Return
//		record count satisfying condition
//	Param
//		hDatabase : database handle
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_CondRecordNum (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		search first string satisfying pattern
//	Return
//		success : record oid
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase : database handle
//		nFieldID : field id
//		pMatch : pattern string ( '*','?' )
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_SearchLikeStringFirst (long hDatabase, long nFieldID, byte* pMatch);

//-----------------------------------------------------------------------------
//	Description
//		search first string satisfying pattern
//	Return
//		success : record oid
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase : database handle
//	Remark 
//		use this function after DB_SearchLikeStringFirst()
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_SearchLikeStringNext (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		�̸����� ����Ÿ ���̽��� �����Ѵ�.
//	Retur
//		success	: ���µ� ����Ÿ ���̽��� �ڵ�
//		fail	: VD_DB_INVALID_HANDLE (��� (5)handle����)
//	Param
//		pcName (in)	: ������ ����Ÿ���̽� �̸�
//		keyField	: �������� �� ��Ʈ�� �ʵ� ���̵�,
//					  DB_Create�ÿ� ��Ʈ �� ���̶�� ����� �ʵ常 �ȴ�.
//					  �׳� ���� �� ��� NULL_FILEDID ���
//-----------------------------------------------------------------------------
syscall long	DB_OpenDatabaseByName (char *pcName, long nKeyField);

//-----------------------------------------------------------------------------
//	Description
//		pcName�� �ش��ϴ� ����Ÿ ���̽��� �����Ѵ�.
//	Return
//		success	: true
//		fail	: false
//	Param
//		pcName (in)	: ����Ÿ ���̽� �̸�
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_DeleteDatabaseByName (char *pcName);

//-----------------------------------------------------------------------------
//	Description
//		�̸����� ����Ÿ���̽� OID�� ���Ѵ�
//	Return
//		success	: OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		pcName : database name
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_GetOIDByDatabaseName (char *pcName);

//-----------------------------------------------------------------------------
//	Description
//		get record count in database
//	Return
//		success : record count
//		fail	: -1
//	Param
//		dbName : database name
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_GetCountByName (char* dbName);

//-----------------------------------------------------------------------------
//	Description
//		���� ������ ���Ѵ�.
//	Return
//		free space
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_GetFreeStorage (void);

//-----------------------------------------------------------------------------
//	Description
//		�ʵ��� ũ�⸦ ���Ѵ�.
//	Return
//		success	: field size
//		fail	: -1
//	Param
//		hDatabase : database handle
//		nOidRecord : record oid
//		nFieldID : field id
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_GetFieldValueSize (long hDatabase, long nOidRecord, long nFieldID);

//-----------------------------------------------------------------------------
//	Description
//		get record count in database
//	Return
//		record count
//	Param
//		hDatabase : database handle
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_GetCount (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		rename database
//	Return
//		success : true
//		fail	: false
//	Param
//		vmOID : database oid
//		newName : new database name
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	DB_RenDatabase (long vmOID, char* newName);


//------------------------------------------------------------------------------
//		file system 
//------------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//	Description
//		������ ������ ����
//	Return
//		success		: ���� �ڵ�
//		fail		: -1
//	Parameters
//		pName(in)	: ���� �̸�
//		nMode		: ���� �Ӽ�
//		nCreateFlag	: ���� �÷���
//			FS_READ_MODE	: �б� ���� �Ӽ�
//				FS_NORMAL_FLAG	: ������ ����
//				FS_CREATE_FLAG	: ������ ����
//
//			FS_WRITE_MODE	: �б�, ���� �Ӽ�
//				FS_NORMAL_FLAG	: ������ ������ ���� �ڵ�, ������ fail
//				FS_CREATE_FLAG	: ������ ������ ����, ������ ����� ����
// ��) FS_Open�� ���� ���� ������ ���� �����ʹ� ������ ó���� ��ġ�Ѵ�
//-----------------------------------------------------------------------------
syscall long 	FS_Open (char* pName, long nMode, long nCreateFlag);

//-----------------------------------------------------------------------------
//	Description
//		���� ������ ����
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//-----------------------------------------------------------------------------
syscall long	FS_Close (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		���� ������ ���� �����͸� �̵��Ѵ�
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//		nOffset	: �̵��� ��ġ
//		nOrigin	: ���� ��ġ
//			FS_SEEK_CURRENT		: ���� ��ġ�� ���� �����Ϳ��� �����Ͽ� ������ �̵�
//			FS_SEEK_FROM_END	: ������ ���������� �����Ͽ� �ڷ� �̵�
//			FS_SEEK_FROM_SET	: ������ ó������ �����Ͽ� ������ �̵�
//-----------------------------------------------------------------------------
syscall long 	FS_Seek (long nFd, long nOffset, long nOrigin);

//-----------------------------------------------------------------------------
//	Description
//		���Ͽ��� ����Ÿ�� �о����
//	Return
//		success : ���� ���� ����Ÿ ũ��
//		fail	: -1
//	Param
//		nFd			: ���� �ڵ�
//		pBuffer(out): ���� ����Ÿ�� ������ ���� ������
//		nBufLen		: �о ����Ÿ ũ��
// ��) ���� ����Ÿ�� ũ��� nBufLen���� �������� 0�� �ɼ��� �ִ�
//-----------------------------------------------------------------------------
syscall long 	FS_Read (long nFd, byte* pBuffer, long nBufLen);

//-----------------------------------------------------------------------------
//	Description
//		���Ͽ� ����Ÿ�� �����Ѵ�
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd			: ���� �ڵ�
//		pBuffer(in)	: ������ ����Ÿ ���� ������
//		nBufLen		: ������ ����Ÿ ũ��
//-----------------------------------------------------------------------------
syscall long	FS_Write (long nFd, byte* pBuffer, long nBufLen);

//-----------------------------------------------------------------------------
//	Description
//		������ �������� �˾Ƴ���
//	Return
//		success	: ���� �����Ͱ� ������ ���̸� TRUE �ƴϸ� FALSE
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//-----------------------------------------------------------------------------
syscall long	FS_Eof (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		���� ���� �������� ��ġ�� �˾Ƴ���
//	Return
//		success	: ���� ���� �������� ��ġ
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//-----------------------------------------------------------------------------
syscall long 	FS_Tell (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		������ ũ�⸦ �˾Ƴ���
//	Return
//		success	: ������ ũ��
//		fail	: -1
//	Param
//		pName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall long 	FS_GetSize (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		������ �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall long 	FS_Delete (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		���� ������ ������ ���Ͽ� �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//-----------------------------------------------------------------------------
syscall long	FS_Flush (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		������ �����ϴ��� �˾Ƴ���
//	Return
//		success	: ������ �����ϸ� TRUE, �ƴϸ� FALSE
//		fail	: -1
//	Param
//		pName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall	long	FS_Exist (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		������ �̸��� �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: ���� �̸�
//		pDestName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall long	FS_Rename (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		������ �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: ���� �̸�
//		pDestName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall long	FS_Copy (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		���丮�� �����
//	Return
//		success	: 0
//		fail	: -1 (�� ��� GetApiError()�� �Ʒ��� �����ڵ带 Ȯ���ؾ� �Ѵ�.)
//			FS_ERR_INTERNAL_ERROR : �ý��ۿ��� ���丮�� �������� ���� ���.
//			FS_ERR_ALREADY_EXIST : �̹� �����ϴ� ���丮�� �ٽ� ������ ���.	
//	Param
//		pName(in)	: ���丮 �̸�
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_CreateDir (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		���丮�� �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1 (�� ��� GetApiError()�� �Ʒ��� �����ڵ带 Ȯ���ؾ� �Ѵ�.)
//			FS_ERR_INTERNAL_ERROR : �ý��ۿ��� ���丮�� ������ ������ ���.
//			FS_ERR_NO_SUCH_FILE : �������� �ʴ� ���丮�� ������� �� ���.
//	Param
//		pName(in)	: ���丮 �̸�
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_RemoveDir (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		���丮������ ������ ������ ���� �ڵ�� ó�� �˻��� �����̸��� �����Ѵ�.
//	Return
//		success	: File Handle, �˻��� ���ϸ�
//		fail	: -1 
//	Param
//		pFilter(in)	: ���丮�� ���� �̸� (wildcard characters (* and ?))
//		pGetName(out): �˻��� ���ϸ�
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_FindFirst (char* pFilter, char* pGetName);

//-----------------------------------------------------------------------------
//	Description
//		���丮������ ������ ���� �ڵ��� ���ǿ� ���� �����̸��� �����Ѵ�.
//	Return
//		success	: TRUE, �˻��� ���ϸ�
//		fail	: FALSE
//	Param
//		Fh(in)	: FS_FindFirst���� ���ϵ� File Handle
//		pGetName(out): �˻��� ���ϸ�
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_FindNext (long Fh, char* pGetName);

//-----------------------------------------------------------------------------
//	Description
//		������ ���� �ڵ��� �ݴ´�.
//	Return
//		success	: 1
//		fail	: 0
//
//	Param
//		Fh(in)	: FS_FindFirst���� ���ϵ� File Handle
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_FindClose (long Fh);


//-----------------------------------------------------------------------------
//	Description
//		������ ������ ����
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success		: ���� �ڵ�
//		fail		: -1
//	Parameters
//		pName(in)	: ���� �̸�
//		nMode		: ���� �Ӽ�
//		nCreateFlag	: ���� �÷���
//			FS_READ_MODE	: �б� ���� �Ӽ�
//				FS_NORMAL_FLAG	: ������ ����
//				FS_CREATE_FLAG	: ������ ����
//
//			FS_WRITE_MODE	: �б�, ���� �Ӽ�
//				FS_NORMAL_FLAG	: ������ ������ ���� �ڵ�, ������ fail
//				FS_CREATE_FLAG	: ������ ������ ����, ������ ����� ����
// ��) FS_Open�� ���� ���� ������ ���� �����ʹ� ������ ó���� ��ġ�Ѵ�
//-----------------------------------------------------------------------------
syscall long 	FFS_Open (char* pName, long nMode, long nCreateFlag);

//-----------------------------------------------------------------------------
//	Description
//		���� ������ ����
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//-----------------------------------------------------------------------------
syscall long	FFS_Close (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		���� ������ ���� �����͸� �̵��Ѵ�
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//		nOffset	: �̵��� ��ġ
//		nOrigin	: ���� ��ġ
//			FS_SEEK_CURRENT		: ���� ��ġ�� ���� �����Ϳ��� �����Ͽ� ������ �̵�
//			FS_SEEK_FROM_END	: ������ ���������� �����Ͽ� �ڷ� �̵�
//			FS_SEEK_FROM_SET	: ������ ó������ �����Ͽ� ������ �̵�
//-----------------------------------------------------------------------------
syscall long 	FFS_Seek (long nFd, long nOffset, long nOrigin);

//-----------------------------------------------------------------------------
//	Description
//		���Ͽ��� ����Ÿ�� �о����
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success : ���� ���� ����Ÿ ũ��
//		fail	: -1
//	Param
//		nFd			: ���� �ڵ�
//		pBuffer(out): ���� ����Ÿ�� ������ ���� ������
//		nBufLen		: �о ����Ÿ ũ��
// ��) ���� ����Ÿ�� ũ��� nBufLen���� �������� 0�� �ɼ��� �ִ�
//-----------------------------------------------------------------------------
syscall long 	FFS_Read (long nFd, byte* pBuffer, long nBufLen);

//-----------------------------------------------------------------------------
//	Description
//		���Ͽ� ����Ÿ�� �����Ѵ�
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd			: ���� �ڵ�
//		pBuffer(in)	: ������ ����Ÿ ���� ������
//		nBufLen		: ������ ����Ÿ ũ��
//-----------------------------------------------------------------------------
syscall long	FFS_Write (long nFd, byte* pBuffer, long nBufLen);

//-----------------------------------------------------------------------------
//	Description
//		������ �������� �˾Ƴ���
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: ���� �����Ͱ� ������ ���̸� TRUE �ƴϸ� FALSE
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//-----------------------------------------------------------------------------
syscall long	FFS_Eof (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		���� ���� �������� ��ġ�� �˾Ƴ���
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: ���� ���� �������� ��ġ
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//-----------------------------------------------------------------------------
syscall long 	FFS_Tell (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		������ ũ�⸦ �˾Ƴ���
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: ������ ũ��
//		fail	: -1
//	Param
//		pName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall long 	FFS_GetSize (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		������ �����Ѵ�
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall long 	FFS_Delete (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		���� ������ ������ ���Ͽ� �����Ѵ�
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		nFd		: ���� �ڵ�
//-----------------------------------------------------------------------------
syscall long	FFS_Flush (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		������ �����ϴ��� �˾Ƴ���
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: ������ �����ϸ� TRUE, �ƴϸ� FALSE
//		fail	: -1
//	Param
//		pName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall	long	FFS_Exist (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		������ �̸��� �����Ѵ�
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: ���� �̸�
//		pDestName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall long	FFS_Rename (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		������ �����Ѵ�
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: ���� �̸�
//		pDestName(in)	: ���� �̸�
//-----------------------------------------------------------------------------
syscall long	FFS_Copy (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		���丮�� �����
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: 0
//		fail	: -1 (�� ��� GetApiError()�� �Ʒ��� �����ڵ带 Ȯ���ؾ� �Ѵ�.)
//			FS_ERR_INTERNAL_ERROR : �ý��ۿ��� ���丮�� �������� ���� ���.
//			FS_ERR_ALREADY_EXIST : �̹� �����ϴ� ���丮�� �ٽ� ������ ���.	
//	Param
//		pName(in)	: ���丮 �̸�
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_CreateDir (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		���丮�� �����Ѵ�
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: 0
//		fail	: -1 (�� ��� GetApiError()�� �Ʒ��� �����ڵ带 Ȯ���ؾ� �Ѵ�.)
//			FS_ERR_INTERNAL_ERROR : �ý��ۿ��� ���丮�� ������ ������ ���.
//			FS_ERR_NO_SUCH_FILE : �������� �ʴ� ���丮�� ������� �� ���.
//	Param
//		pName(in)	: ���丮 �̸�
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_RemoveDir (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		���丮������ ������ ������ ���� �ڵ�� ó�� �˻��� �����̸��� �����Ѵ�.
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: File Handle, �˻��� ���ϸ�
//		fail	: -1 
//	Param
//		pFilter(in)	: ���丮�� ���� �̸� (wildcard characters (* and ?))
//		pGetName(out): �˻��� ���ϸ�
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_FindFirst (char* pFilter, char* pGetName);

//-----------------------------------------------------------------------------
//	Description
//		���丮������ ������ ���� �ڵ��� ���ǿ� ���� �����̸��� �����Ѵ�.
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: TRUE, �˻��� ���ϸ�
//		fail	: FALSE
//	Param
//		Fh(in)	: FS_FindFirst���� ���ϵ� File Handle
//		pGetName(out): �˻��� ���ϸ�
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_FindNext (long Fh, char* pGetName);

//-----------------------------------------------------------------------------
//	Description
//		������ ���� �ڵ��� �ݴ´�.
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ���� ������ �̷������.
//	Return
//		success	: 1
//		fail	: 0
//
//	Param
//		Fh(in)	: FS_FindFirst���� ���ϵ� File Handle
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_FindClose (long Fh);

//------------------------------------------------------------------------------
//���� ����ӽ��� ���� ���丮�� �����Ѵ�.
//------------------------------------------------------------------------------
syscall char*	FFS_GetWorkDir	(void);

//------------------------------------------------------------------------------
//		memory
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		�޸𸮸� �����Ѵ�
//	Return
//		����
//	Param
//		pMem1(in)	: ��� �޸� ������
//		pMem2(in)	: ���� �޸� ������
//		nLength		: ������ �޸� ũ��
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall void	Mem_Cpy (byte* pMem1, byte* pMem2, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		�޸𸮿� ������ ���� �����Ѵ�
//	Return
//		����
//	Param
//		pMem1(in)	: �޸� ������
//		c			: ������ ��
//		nLength		: �޸� ũ��
//-----------------------------------------------------------------------------
syscall void	Mem_Set (byte* pMem1, byte c, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		�޸𸮸� ���Ѵ�
//	Return
//		���� �޸𸮰� �����ϸ� 0 �ƴϸ� ����....
//	Param
//		pMem1(in)	: ���� �޸� ������
//		pMem2(in)	: ��� �޸� ������
//		nLength		: ���� �޸� ũ��
//-----------------------------------------------------------------------------
syscall long	Mem_Cmp (byte* pMem1, byte* pMem2, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		�޸𸮸� �Ҵ��Ѵ�
//	Return
//		�Ҵ�� �޸��� ������
//	Param
//		nLength	: �Ҵ��� �޸� ũ��
//-----------------------------------------------------------------------------
syscall void*	Mem_Alloc (long nLength);

//-----------------------------------------------------------------------------
//	Description
//		�Ҵ�� �޸𸮸� ���ش�
//	Return
//		����
//	Param
//		pMem1(in)	: �Ҵ�� �޸� ������
//-----------------------------------------------------------------------------
syscall void	Mem_Free (byte* pMem1);

//-----------------------------------------------------------------------------
//		ppp
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		��ȭ�� �ɾ� PPP ������ �õ��Ѵ�
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		nMode	: TRUE�̸� ����Ÿ ���, FALSE�̸� ���� ���
//-----------------------------------------------------------------------------
syscall long	Ppp_Connect (void);

//-----------------------------------------------------------------------------
//	Description
//		PPP������ �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Ppp_Disconnect (void);

//-----------------------------------------------------------------------------
//	Description
//		PPP������ �Ǿ� �ִ����� Ȯ���Ѵ�
//	Return
//		������ �Ǿ� ������ TRUE �׷��� ������ FALSE
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Ppp_IsConnected (void);

//-----------------------------------------------------------------------------
//	Description
//		PPP������ �Ǿ� �ִ� ����̽��� ������ �˾Ƴ���.
//	Return
//		PPP_DIRECT	: PC�� ����Ǿ� �ִ�(������ ���� �ʴ´�.)
//		PPP_MODEM	: Modem�� ����Ǿ� �ִ�(������ ���´�.)
//		FAIL		: -1 (����� ����̽��� Ȯ�ε��� ����.) 
//	Param
//		����
//
//	support : Win CE
//-----------------------------------------------------------------------------
syscall long	Ppp_GetConnectedType (void);

//-----------------------------------------------------------------------------
//		secret
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		�־��� �����͸� ��ȣȭ�Ѵ�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pBuf(in)		: ��ȣȭ�� ����Ÿ
//		nBufSize		: ��ȣȭ�� ����Ÿ�� ũ��
//		npMsgSize(out)	: ��ȣȭ�� ����Ÿ�� ũ��
//-----------------------------------------------------------------------------
syscall long	Secret_Encrypt (byte *pBuf, long nBufSize, long *npMsgSize);

//-----------------------------------------------------------------------------
//	Description
//		��ȣȭ�� ����Ÿ�� �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pBuf				: ��ȣȭ�� ����Ÿ
//		npMsgSize(in/out)	: ��ȣȭ�� ����Ÿ �� ������ ����Ÿ�� ũ��
//-----------------------------------------------------------------------------
syscall long	Secret_Decrypt (byte *pBuf, long *npMsgSize);

//-----------------------------------------------------------------------------
//		socket
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		URL �Ǵ� IP ���ڿ��� IP �ּҷ� �ٲپ��ش� (host order)
//	Return
//		success	: IP �ּ�
//		fail	: -1
//	Param
//		pHostName(in)	: URL ���ڿ�
//		pIpName(in)		: IP �ּ� ���ڿ�
//		nTimeOut		: Ÿ�� �ƿ� (ms)
// ��)	"a.b.c.d"	-> 0x01020304
//		"1.2.3.4"	-> 0x01020304
//-----------------------------------------------------------------------------
syscall quad	Sock_Resolve (char* pHostName, char* pIpName, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		TCP/IP�� ������ �õ��Ѵ�
//	Return
//		success	: 0
//		fail	: 0xFFFFFFFF
//	Param
//		nHostIp		: IP �ּ� (host order)
//		nPort		: ��Ʈ ��ȣ
//		nTimeOut	: Ÿ�� �ƿ� (ms)
//-----------------------------------------------------------------------------
syscall long	Sock_Connect (quad nHostIp, long nPort, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		TCP/IP�� ������ �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Sock_Close (void);

//-----------------------------------------------------------------------------
//	Description
//		����� ������ ���� ����Ÿ�� ������
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pBuffer(in)	: ���� ����Ÿ ���� ������
//		nLenght		: ���� ����Ÿ�� ũ��
//		nTimeOut	: Ÿ�� �ƿ� (ms)
//-----------------------------------------------------------------------------
syscall long	Sock_Write (byte *pBuffer, long nLength, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		����� ������ ���� ���� ����Ÿ�� �д´�
//	Return
//		success	:  ���� ���� ����Ÿ�� ũ��
//		fail	: -1
//	Param
//		pBuffer(in)	: ���� ����Ÿ�� ������ ���� ������
//		nMaxLength	: ������ ũ��
//		nTimeOut	: Ÿ�� �ƿ� (ms)
//-----------------------------------------------------------------------------
syscall long	Sock_Read (byte *pBuffer, long nMaxLength, long nTimeOut);

//-----------------------------------------------------------------------------
//		string
//-----------------------------------------------------------------------------

//dkjung 2009-11-11
syscall void	Str_NCpy (char* pStr1, char* pStr2, long nLength);
syscall char*	Str_Str (char* pStr1, char* pStr2);

//-----------------------------------------------------------------------------
//	Description
//		���ڿ��� ũ�⸦ �˾Ƴ���
//	Return
//		���ڿ��� ũ��
//	Param
//		pStr1(in)	: ���ڿ� ������
//-----------------------------------------------------------------------------
syscall long	Str_Len (char* pStr1);

//-----------------------------------------------------------------------------
//	Description
//		�� ���ڿ��� ���Ѵ�
//	Return
//		�� ���ڿ��� �����ϸ� 0 �ƴϸ� ����...
//	Param
//		pStr1(in)	: ���ڿ� ������
//		pStr2(in)	: ���ڿ� ������
//-----------------------------------------------------------------------------
syscall long	Str_Cmp (char* pStr1, char* pStr2);

//-----------------------------------------------------------------------------
//	Description
//		�� ���ڿ����� ���� ũ�⸸ŭ���� ���Ѵ�
//	Return
//		���� ũ������� �����ϸ� 0 �ƴϸ� ����...
//	Param
//		pStr1(in)	: ���ڿ� ������
//		pStr2(in)	: ���ڿ� ������
//		nLength		: �޸� ũ��
//-----------------------------------------------------------------------------
syscall long	Str_NCmp (char* pStr1, char* pStr2, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		���ڿ��� �����Ѵ�
//	Return
//		����
//	Param
//		pStr1(in)	: ���� ���ڿ� ������
//		pStr2(in)	: ��� ���ڿ� ������
//-----------------------------------------------------------------------------
syscall void	Str_Cpy (char* pStr1, char* pStr2);

//-----------------------------------------------------------------------------
//	Description
//		�� ���ڿ��� ��ģ��
//	Return
//		����
//	Param
//		pStr1(in)	: ���� ���ڿ� ������
//		pStr2(in)	: ��� ���ڿ� ������
//-----------------------------------------------------------------------------
syscall void	Str_Cat (char* pStr1, char* pStr2);

//-----------------------------------------------------------------------------
//	Description
//		�������� ���ڿ��� ��ȯ�Ѵ�
//	Return
//		����
//	Param
//		nVal		: ��ȯ�� ��
//		pStr1(out)	: ������ �޸�
//		nRadix		: X���� (2����, 8����, 10���� ��)
//-----------------------------------------------------------------------------
syscall void	Str_ItoA (long nVal, char* pStr1, long nRadix);

//-----------------------------------------------------------------------------
//	Description
//		���ڿ��� ���������� ��ȯ�Ѵ�
//	Return
//		��ȯ�� ������
//	Param
//		pStr1(in)	: �޸� ������
//-----------------------------------------------------------------------------
syscall long	Str_AtoI (char* pStr1);

//-----------------------------------------------------------------------------
//	Description
//		���ڿ��� ��ȯ�Ͽ� ���ۿ� �����Ѵ�
//	Return
//		����
//	Param
//		pStr1(in)	: �޸� ������
//		pStr2(in)	: �޸� ������
//		nArg1		: ����
//		nArg2		: ����
//		nArg3		: ����
//-----------------------------------------------------------------------------
syscall void	Str_Printf (char* pStr1, char* pStr2, quad nArg1, quad nArg2, quad nArg3);

//-----------------------------------------------------------------------------
//	Description
//		���ڿ��� ������ �������� ��ȯ�Ѵ�.
//
//	Return
//		����
//	Param
//		nFlag(in)	: ��ȯ�Ǵ� ������ �����ϴ� �÷���.
//		- STRCHG_CONV_ZERO_TO_SPACE : ���� ���ʿ� ��ġ�� 0�� �������� �ٲ۴�. (00001234 -> ____1234)
//		- STRCHG_DEL_SPACE_TO_RIGHT : ���� ���ʿ� ��ġ�� ������ ���������� �����.(+___1234->___+1234)
//		- STRCHG_DEL_RIGHT_SPACE : ���ڿ� �����ʿ� �ִ� ������ �����.  (abcd____ -> abcd)
//		- STRCHG_DEL_SPACE_TO_LEFT : ���� ���ʿ� ��ġ�� ������ �������� �����. (+___1234->+1234)
//		- STRCHG_DEL_ALL_SPACE : ���ڿ��� ���Ե� ��� ������ ����� �������� ���Ľ�Ų��.
//		- STRCHG_INS_COMMA : ���� ���ڿ��� �����ϰ� 3�ڸ����� ,�� ��� ������ '0'�� �������� �����.
//		- STRCHG_DEL_NONDIGIT : '0' ~ '9' �� �ƴ� ���ڴ� ��� ����� �������� ������.
//		- STRCHG_DEL_NONDIGITSIGN : '0' ~ '9', '-', '+' �� �ƴ� ���ڴ� ��� ����� �������� ������.
//-----------------------------------------------------------------------------
syscall void	Str_Chg (char* pStr1, long nFlag);

//------------------------------------------------------------------------------
//		time
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		��,��,���� �˾Ƴ���
//	Return
//		2001�� 1�� 1�� -> 20010101
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Time_GetDate (void);

//-----------------------------------------------------------------------------
//	Description
//		���� �˾Ƴ���
//	Return
//		2001�� -> 2001
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Time_GetYear (void);

//-----------------------------------------------------------------------------
//	Description
//		���� �˾Ƴ���
//	Return
//		1�� -> 1
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Time_GetMonth (void);

//-----------------------------------------------------------------------------
//	Description
//		���� �˾Ƴ���
//	Return
//		1�� -> 1
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Time_GetDay (void);

//-----------------------------------------------------------------------------
//	Description
//		�ָ� �˾Ƴ���
//	Return
//		�Ͽ��� -> 0, ������ -> 1
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Time_GetWeek (void);

//-----------------------------------------------------------------------------
//	Description
//		�ð�, ��, �ʸ� �˾Ƴ���
//	Return
//		23�� 30�� 30�� -> 233030
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Time_GetTime (void);

//-----------------------------------------------------------------------------
//	Description
//		�ð��� �˾Ƴ���
//	Return
//		23�� -> 23
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Time_GetHour (void);

//-----------------------------------------------------------------------------
//	Description
//		���� �˾Ƴ���
//	Return
//		23�� -> 23
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Time_GetMinute (void);

//-----------------------------------------------------------------------------
//	Description
//		�ʸ� �˾Ƴ���
//	Return
//		23�� -> 23
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Time_GetSecond (void);

//-----------------------------------------------------------------------------
//	Description
//		�ڹ��� �������� ����ÿ�
//-----------------------------------------------------------------------------
syscall long	Time_NumberOfDates (long nDateFrom, long nDateTo);

//-----------------------------------------------------------------------------
//	Description
//		�ڹ��� �������� ����ÿ�
//-----------------------------------------------------------------------------
syscall long	Time_ValidateDate (long nDate);

//-----------------------------------------------------------------------------
//	Description
//		�ڹ��� �������� ����ÿ�
//-----------------------------------------------------------------------------
syscall	long	Time_DateUpDown (quad Date, long DateDigit);

//------------------------------------------------------------------------------
//		timer
//------------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//	Description
//		�ý����� Ÿ�� ��ŭ sleep�Ѵ�.
//	Return
//		����
//	Param
//		t	: sleep ���� (10ms)
//-----------------------------------------------------------------------------
syscall void	VmSleep (long t);

//-----------------------------------------------------------------------------
//	Description
//		Ÿ�̸Ӹ� �����Ѵ�
//	Return
//		success	: Ÿ�̸� ���̵�
//		fail	: -1
//	Param
//		nInterval	: Ÿ�̸� ���� (ms)
//		nCount		: Ÿ�̸Ӱ� �۵��� Ƚ�� (0�̸� ���Ѵ�)
//-----------------------------------------------------------------------------
syscall long	Timer_Set (long nInterval, long nCount);

//-----------------------------------------------------------------------------
//	Description
//		Ÿ�̸Ӹ� ���ش�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		nId		: ���� Ÿ�̸� ���̵�
//-----------------------------------------------------------------------------
syscall long	Timer_Kill (long nId);

//------------------------------------------------------------------------------
//		telephony api
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		�ڽ��� ��ȭ ��ȣ�� �˾Ƴ���
//	Return
//		����
//	Param
//		pPhoneNum(out)	: ��ȭ ��ȣ�� ������ ����
//		nType			: 0�̸� ���ڿ� ��ȭ ��ȣ, 0�� �ƴϸ� ������ ��ȭ ��ȣ
// ��)
//		0162345678	-> type�� 0�� ��� "0162345678"
//					   type�� 0�� �ƴ� ��� 6-0234-5678
//		01612345678	-> type�� 0�� ��� "01612345678"
//					   type�� 0�� �ƴ� ��� 6-1234-5678
//-----------------------------------------------------------------------------
syscall void	Tapi_GetPhoneNum (byte* pPhoneNum, long nType);

//-----------------------------------------------------------------------------
//	Description
//		SMS �޽����� ������. deprecated. ������� �� ��
//	Return
//		����
//	Param
//		pDst(in)		: ��� ��ȭ ��ȣ
//		pSrc(in)		: �ڱ� ��ȭ ��ȣ
//		pContents(in)	: ���� ������ ������ ���� ������
//		nLenght(in)	: ���� ���� ũ��
//-----------------------------------------------------------------------------
syscall void	Tapi_SendSms (byte* pDst, byte* pSrc, byte* pContents, long nLength);

/////////////////////////////////////////////////////////////
//	Description
//		SMS�� ������.
//	Parameters
//		destPhone : �޽����� ���� ��ȭ��ȣ. ���ڷθ� �̷������ �Ѵ�.��Ÿ ���ڴ� �ȵ�.
//		srcPhone : ������ ���� ��ȭ��ȣ. null�� ��� ���� �ܸ��� ��ȭ ��ȣ. ���ڷθ� ����
//		content : �޽��� ����. �ִ� ���� 80bytes
//		level :   <= 10 ����, <= 20 ����, 20 < ���
//	Return
//		���� : 0
//		���� : 0���� ���� ��. �����ڵ�� �Ʒ��� ����.
//				-1 : �޽��� ���� ��ȭ ��ȣ�� �߸��Ǿ���.
//				-2 : ������ ���� ��ȭ��ȣ�� �߸��Ǿ���.
//				-3 : ������ �����
//				-4 : ������ �ʹ� ���
//				-5 : ���� ����
syscall unsigned long	Tapi_SendSmsEx(char* destPhone, char* srcPhone, char* content, int level);


//-----------------------------------------------------------------------------
//	Description
//		��ȭ�� �Ǵ�
//	Return
//		����
//	Param
//		pPhoneNumber(out)	: ��� ��ȭ ��ȣ
//-----------------------------------------------------------------------------
syscall void	Tapi_MakeCall (byte* pPhoneNumber);

//-----------------------------------------------------------------------------
//	Description
//		��ȭ�� ���´�
//	Return
//		����
//	Param
//		����
//-----------------------------------------------------------------------------
syscall void	Tapi_CloseCall (void);

//-----------------------------------------------------------------------------
//	Description
//		�Ҹ��� ����
//	Return
//		����
//	Param
//		nSound	: �Ҹ��� Ÿ��
//			SOUND_CLICK		: ��ư ���� ������ �� ���� �Ҹ�
//			SOUND_WARNING	: �����
//			SOUND_ERROR		: ������
//-----------------------------------------------------------------------------
syscall void	Tapi_PlaySound (long nSound);

//-----------------------------------------------------------------------------
//	Description
//		�ø��� ����� �����Ѵ�
//	Return
//		����
//	Param
//		����
//-----------------------------------------------------------------------------
syscall void	Tapi_SetFlipDisable (void);

//-----------------------------------------------------------------------------
//	Description
//		�ø��� ����� �����ϰ� �Ѵ�
//	Return
//		����
//	Param
//		����
//-----------------------------------------------------------------------------
syscall void	Tapi_SetFlipEnable (void);

//-----------------------------------------------------------------------------
//		uart
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		���� ��Ʈ�� ����
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		nBaudRate	: ���� �ӵ�
//		nDataBit	: ����Ÿ ��Ʈ ũ��
//		nParityBit	: �з�Ƽ ��Ʈ ũ��
//		nStopBit	: ���� ��Ʈ ũ��
//-----------------------------------------------------------------------------
syscall long	Uart_Open (long nPortNum, long nBaudRate, long nDataBit, long nParityBit, long nStopBit);
//-----------------------------------------------------------------------------
//	Description
//		���� ��Ʈ�� �ݴ´�
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long	Uart_Close (void);

//-----------------------------------------------------------------------------
//	Description
//		���� ��Ʈ�� ���� ����Ÿ�� �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		pBuffer(out)	: ������ ����Ÿ ����
//		nLength 	: ����Ÿ ũ��
//-----------------------------------------------------------------------------
syscall long	Uart_Write (byte* pBuffer, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		���� ��Ʈ�� ���� ���� ����Ÿ�� �д´�
//	Return
//		success	: ���� ����Ÿ ũ��
//		fail	: -1 
//	Param
//		pBuffer(in)	: ���� ����Ÿ�� ������ ����
//		nLength 	: ������ �ִ� ũ��
//-----------------------------------------------------------------------------
syscall long	Uart_Read (byte* pBuffer, long nMaxLength);

//------------------------------------------------------------------------------
//		print and error
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		���ڿ��� ����Ѵ�
//	Return
//		����
//	Param
//		pStr(out)	: ���ڿ�
//		nArg1 		: ����
//		nArg2 		: ����
//		nArg3 		: ����
//-----------------------------------------------------------------------------
syscall void 	Print (char* pStr, quad nArg1, quad nArg2, quad nArg3);

//-----------------------------------------------------------------------------
//	Description
//		�޸��� ������ ����Ѵ�
//	Return
//		����
//	Param
//		pPtr(out)	: �޸� ���� ����
//		nLength		: �޸� ũ��
//		nMode 		: DUMP_ASCII ����� ��� ���ڿ���, DUMP_HEX ����� ��� ��簪���� ���
//-----------------------------------------------------------------------------
syscall void 	Dump (byte* pPtr, long nLength, long nMode);

//-----------------------------------------------------------------------------
//	Description
//		���� �ֱ��� ���� �ڵ带 �˾Ƴ���
//	Return
//		�����ڵ�
//	Param
//		����
//-----------------------------------------------------------------------------
syscall long 	GetApiError (void);

//-----------------------------------------------------------------------------
//	Description
//		������ �����Ѵ� lzss �̿�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: ������ ���� �̸�
//		pDestName(in)	: ����� ����� ����� ���� �̸�
//-----------------------------------------------------------------------------
syscall long	Compress (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		����� ������ �����Ѵ� lzss �̿�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: ����� ���� �̸�
//		pDestName(in)	: ������ Ǯ�� ����� ����� ���� �̸�
//-----------------------------------------------------------------------------
syscall long	Uncompress (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		����� ������ �����Ѵ� lzss �̿�
//		�÷��ø� �����ϴ� WINCE ����̽����� �÷��� ���� �ؿ��� ������ �����Ѵ�.
//		AM(Upgrade.mc)���� ����Ǯ������ ����� ���̴�.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: ����� ���� �̸�
//		pDestName(in)	: ������ Ǯ�� ����� ����� ���� �̸�
//-----------------------------------------------------------------------------
syscall long	FFS_Uncompress (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		������ �����Ѵ� Zip �˰��� �̿�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: ����� ���� �̸�
//		pDestName(in)	: ������ Ǯ�� ����� ����� ���� �̸�
//-----------------------------------------------------------------------------
syscall long	Compress_Zip(char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		����� ������ �����Ѵ� zip �̿�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: ����� ���� �̸�
//		pDestName(in)	: ������ Ǯ�� ����� ����� ���� �̸�
//-----------------------------------------------------------------------------
syscall long	Uncompress_Zip (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		�ܺ� ���α׷��� �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		szCmdName(in)	: Ŀ�ǵ� ���� ��ɾ�
//		bWait			: ������ ����
//		dwTimeout		: ������ ����
//-----------------------------------------------------------------------------
syscall long	RunApp (char* szCmd, char* scArg);

//-----------------------------------------------------------------------------
//	Description
//		�ٸ� ���ø����̼��� �����Ѵ�
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		nAppId	: ���ø����̼� ID
//-----------------------------------------------------------------------------
syscall long	VM_AppStart (long nAppId);

//-----------------------------------------------------------------------------
//	Description
//		���� ���� ���ø����̼��� �����ϰ� AM���� ���ư���
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	VM_AppEnd (void);

//-----------------------------------------------------------------------------
//	Description
//		AM�� �����Ѵ�. �� mpop�� �����Ѵ�.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	VM_AmEnd (void);

//-----------------------------------------------------------------------------
//	Description
//		Application�� ��� ������ �о�´�.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
typedef struct _VM_AppInfo
{
	byte	aHead_Str[8];					//"APP_INF"
	byte	aAppName[21];	
	byte	aAppGUID[16];					//application GUID
	word	wAppVersion;					//version
	byte	aAppProvider[10];				//provider
	byte	notUse[4];						//ip address previouse not use now
	word	wDirection;						//direction
	byte	aSicon[64];						//small icon
	byte	aLicon[256];					//large icon
	byte	aAppDesc[100];					//applicatin description
	byte	bUpdate;						//indicating update info
											// 'G' : none
											// 1 : down start
											// 2 : old backup start(copy)
											// 3 : del old files
											// 4 : copy new files
											// 5 : del useless files
											// 'I' : Install phase
	word	wCardNum;						// number of cards
	byte	aCardCheckSum[16];				//card check sum CRC 16
} VM_AppInfo;

syscall long	VM_GetAppInfo (VM_AppInfo* pstAppInfo);

//-----------------------------------------------------------------------------
//	Description
//		���� ������ �̹����� �����´�.
//	Return
//		success	: 1
//		cancel	: 0
//		fail	: -1
//	Param
//		Width			: ��
//		Height			: �ʺ�
//		pBufSign(out)	: ����Ÿ
//-----------------------------------------------------------------------------
syscall long	GetSignImg (long Width, long Height, char* pBufSign);

//-----------------------------------------------------------------------------
//	Description
//		���� ������ �̹����� �����´� (option ��� �߰�).
//	Return
//		success	: 1
//		cancel	: 0
//		fail	: -1
//		empty	: 2
//	Param
//		Width			: ��
//		Height			: �ʺ�
//		pBufSign(out)	: ����Ÿ
//		option			: ���κ��� �ɼ� (0, 1)
//-----------------------------------------------------------------------------
//option
#define SIGN_OPT_NONE		0	//������ ����ϴ� ���κ���
#define SIGN_OPT_CHECK		1	//�ɼǿ� ���� EMPTY ����� ���� ��.

#define SIGN_RET_CANCEL		0
#define SIGN_RET_SUCCESS	1
#define SIGN_RET_EMPTY		2
#define SIGN_RET_FAIL		-1

syscall long	GetSignImgTitleWithOpt (long Width, long Height, char* pBufSign, char* title, long option);

//-----------------------------------------------------------------------------
//	Description
//		mpop 3.0 �������� ���� API
//	Return
//		success	:
//		fail	:
//	Param
//-----------------------------------------------------------------------------

syscall void	SmartNet_SetServer			(const char *szServer);
syscall long	SmartNet_Send				(quad nMID, quad nPID, byte nCtrl, quad nLength, const char *pszData );
syscall long	SmartNet_SendRaw			(const char *szServer, word nPortID, const char *szPath, byte nCtrl, quad nLength, const char *pszData );
syscall long	SmartNet_Read				(void);
syscall void	SmartNet_Close				(void);
syscall long	SmartNet_URLEncode			(const char *lpSrc, char *lpDest, long nLength);
syscall long	SmartNet_URLDecode			(const char *lpSrc, char *lpDest, long nLength);
syscall long	SmartNet_DataIsReady		(void);
syscall char*	SmartNet_GetData			(quad *pMID, quad *pECode, word *pLength);
syscall quad	SmartNet_GetECode			(void);
syscall quad	SmartNet_GetMID				(void);
syscall word	SmartNet_GetLength			(void);
syscall char*	SmartNet_GetServer			(void);
syscall char*	SmartNet_GetBuffer			(void);

//-----------------------------------------------------------------------------
//	Description
//		���� ���׷��̵�� ���� ��ġ�� ���Ǵ� API
//		�Ϲ� ����ڴ� ������� ���� !!!!
//	Return
//		success	:
//		fail	:
//	Param
//-----------------------------------------------------------------------------

// dkjung 2003-04-11
// �������� ���Ϲ߻����� ���ؼ� �Ͻ������� ���񽺸� �ߴ��ϴ� ��� ó��.
#define ERR_SERVER_OVER -2

typedef struct _tagVM_PROFILE
{
	long LCD_WIDTH;
	long LCD_HEIGHT;
	long SMALL_ICON_WIDTH;
	long SMALL_ICON_HEIGHT;
	long LARGE_ICON_WIDTH;
	long LARGE_ICON_HEIGHT;
	long DEFAULT_FONT;
	long MACHINE_VERSION;
	char DEVICE_NAME[32];
} VM_PROFILE;

syscall long	GetRunAppGuid				(char* aGuid);
syscall long	DeployPrepareComm			(void);
syscall long	DeployAuthroize				(void);
syscall long	DeployGetCard				(byte* appID, quad appVer, char* cardFile, quad offset, quad size, char* buffer);
syscall long	DeployGetPatchCardList		(byte* appID, quad cVer, quad patchVer, byte* cards, quad from, quad num);
syscall long	DeployGetAppList			(long phoneNumber, long category, char* ret, quad from, quad num, quad mVer);
syscall long	DeployGetAppLastVer			(byte* appID, byte* lastVer);
syscall long	DeployGetAppHeader			(byte* appID, quad wVer, char* appHeader);
syscall long	DeployAuthorizeNLastVer		(byte* appID, word* lastVer);
syscall void	DeployEndComm				(void);
syscall void	VM_GetProfile				(VM_PROFILE* pro);

//-----------------------------------------------------------------------------
//	Description
//		ī�帮���� ���� �����͸� �����´�
//	Return
//		success	: ���� ���ڿ��� ����
//		fail	: -1
//	Param
//		pBufSign(out)	: ����Ÿ
//-----------------------------------------------------------------------------
//syscall long	Barcode_Init (void);
//syscall long	Barcode_Exit (void);
//syscall long	Barcode_Read (char* ptr);

//-----------------------------------------------------------------------------
//	Description
//		��Ǯ�� ����
//	Param
//		none
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	Printer_EmptySpool (void);

//-----------------------------------------------------------------------------
//	Description
//		�μ��� ����Ÿ�� ��Ǯ�� ������
//	Param
//		strData(in)	: ���ڿ� ����Ÿ
//		mode		: ī�� ���� �Ŵ��� ����
//	Return
//		���� ������ ����Ÿ�� ũ��
//	Param
//-----------------------------------------------------------------------------
syscall long	Printer_SendToSpool (char* strData, long mode);

//-----------------------------------------------------------------------------
//	Description
//		��Ǯ�� ����Ÿ�� �μ��Ѵ�
//	Param
//		flag	: FALSE�̸� �μ��� �� ��Ǯ ���� ���� TRUE�̸� ���� ���� ����
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	Printer_PrintData (long flag);

//-----------------------------------------------------------------------------
//	Description
//		���� ����Ÿ�� �����´�
//	Param
//		strNum(out)		: ī�� ��ȣ
//		strYear(out)	: ��ȿ �Ⱓ ��
//		strMonth(out)	: ��ȿ �Ⱓ ��
//		strType(out)	: ī�� Ÿ��
//		nTimeOut		: Ÿ�� �ƿ� (�� ����)
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	CardReader_Read (char* strNum, char* strYear, char* strMonth, char* strType, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		������ �ð����� �ƹ��� �̺�Ʈ�� ������ ���ø����̼��� �����Ѵ�.
//	Param
//		quad qTimeOut   : Ÿ�� �ƿ� (�� ����)
//	Return
//	Param
//-----------------------------------------------------------------------------
syscall void	ExitIdleDuring (quad qTimeOut);


//-----------------------------------------------------------------------------
//	Description
//		������ܸ����� ī�帮���⿡�� nTrack�����͸� �����´�.
//		��ȯ���� ���� �����̴�. 
//	Param
//		strRawData(out)	: ���� ������
//		nTrack(in)		: ���� Ʈ��
//		nTimeOut(in)	: Ÿ�� �ƿ� (�� ����)
//	Return
//		success	: ���� �������� Length
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	CardReader_GetRawData(char* strRawData, long nTrack, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		������ܸ����� ī�帮���⿡�� 2��° Track���� �����͸� �����´�.
//		���� ���Ǵ� ������ �Ľ��Ѵ�.
//	Param
//		strNum(out)			: ī���ȣ
//		strValidDate(out)	: ��ȿ�Ⱓ ("YYMM"����)
//		nTimeOut(in)		: Ÿ�� �ƿ� (�� ����)
//	Return
//		success	: 0
//		fail	: -1
//	Param

//-----------------------------------------------------------------------------
syscall long	CardReader_GetParsedData(char* strNum, char* strValidDate, long nTimeOut);


//-----------------------------------------------------------------------------
//	Description
//		Standard Input Panel�� ��Ÿ���� �ϰų� ������� �Ѵ�.
//	Param
//		BOOL bFlag   : SIP�� ���۽�Ű�� �÷���.
//			TRUE	: SIP�� ��Ÿ���� �Ѵ�.
//			FALSE	: SIP�� ������� �Ѵ�.
//	Return
//		success	: 0
//		fail	: -1
//
//	support : Win CE
//-----------------------------------------------------------------------------
syscall long	ShowSip (BOOL bFlag);

//-----------------------------------------------------------------------------
//	Description
//		Battery�� ���� ���¸� �о� �´�.
//
//	Param
//		PSYSTEM_POWER_STATUS pSps   : Battery�� ���¸� ���� ����ü.
//									  ����ü�� ���γ��� Win CE �Ŵ��� ����.
//
//	Return
//		success	: 0
//		fail	: -1
//
//	support : Win CE
//-----------------------------------------------------------------------------
typedef struct _SYSTEM_POWER_STATUS
{
	BYTE ACLineStatus;
	BYTE BatteryFlag;
	BYTE BatteryLifePercent;
	BYTE Reserved1;
	QUAD BatteryLifeTime;
	QUAD BatteryFullLifeTime;
	BYTE Reserved2;
	BYTE BackupBatteryFlag;
	BYTE BackupBatteryLifePercent;
	BYTE Reserved3;
	QUAD BackupBatteryLifeTime;
	QUAD BackupBatteryFullLifeTime;
	WORD BatteryVoltage;     
	QUAD BatteryCurrent;
	QUAD BatteryAverageCurrent;
	QUAD BatteryAverageInterval;
	QUAD BatterymAHourConsumed;
	QUAD BatteryTemperature;
	QUAD BackupBatteryVoltage;
	BYTE BatteryChemistry;
} SYSTEM_POWER_STATUS, *PSYSTEM_POWER_STATUS;

syscall long	GetSysPowerStatus	(PSYSTEM_POWER_STATUS pSps);


//-----------------------------------------------------------------------------
//	Description
//		ī�� ����� �ʱ�ȭ �Ѵ�.
//
//	Param
//
//	Return
//		success	: 1
//		fail	: 0
//
//	support : POZ
//-----------------------------------------------------------------------------
syscall long	CardPay_Init(void);

//-----------------------------------------------------------------------------
//	Description
//		ī�� ���� ������ �����Ѵ�.
//
//	Param
//		s : �ʵ� �̸�
//		t : �ʵ� ��
//	Return
//		success	: 1
//		fail	: 0
//
//	support : POZ
//-----------------------------------------------------------------------------
syscall int CardPay_SetField(char* s, char* t);

//-----------------------------------------------------------------------------
//	Description
//		ī�� ������ ��û�Ѵ�. ȣ���ϱ� ���� �ݵ�� PPP�� ����Ǿ� �־�� �Ѵ�.
//
//	Param
//	Return
//		success	: 1
//		fail	: 0
//
//	support : POZ
//-----------------------------------------------------------------------------
syscall int CardPay_Request(void);

//-----------------------------------------------------------------------------
//	Description
//		ī�� ���� ������ �����´�.
//
//	Param
//		s : �ʵ� �̸�
//		t : ���� ������ ����
//	Return
//		success	: 1
//		fail	: 0
//
//	support : POZ
//-----------------------------------------------------------------------------
syscall int CardPay_GetField(char* s, char* t);

//-----------------------------------------------------------------------------
//	Description
//		ī�� ������ ���� ���� ���ҽ��� �����ִ� ���� �Ѵ�.
//
//	Param
//	Return
//		success	: 1
//		fail	: 0
//
//	support : POZ
//-----------------------------------------------------------------------------
syscall int CardPay_Destroy(void);

//-----------------------------------------------------------------------------
//	Description
//		System Time�� �־��� ��¥�� �ð����� �����.
//	Param 
//		Date�� YYYYMMDD������ long�̰�, 
//		Time�� HHMMSS������ long�̴�.
//		��) 2003�� 5�� 4��, 10�� 10�� 10�ʿ� ���߷��� �Ѵ�.
//			Time_SetDateTime(20030504, 101010);
//	Return
//		success	: TRUE(1)
//		fail	: FALSE(0) 
//
//	support : WinCE
//-----------------------------------------------------------------------------
syscall BOOL Time_SetDateTime(long Date, long Time);



//-----------------------------------------------------------------------------
//	Description
//		�������� serial port�� ����. �����Ϳ� ī�帮���� ���� ��Ʈ�� ����ϹǷ�,
//		���ÿ� ����� �� ����. �����ʹ� ���͸��� ���� ����ϹǷ� �ʿ��� ��쿡��
//		����.
//
//	Param
//	Return
//		success	: 0
//		fail	: -1 : serial communication error
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall long	Printer_Open(void);


//-----------------------------------------------------------------------------
//	Description
//		������ �󵵸� �����Ѵ�. 
//	Param : 0 - 8 ���� ���� ������. 0 = 60%, 4 = 100%, 8 = 140%, default 4.
//	Return
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall void	Printer_SetDensity(unsigned long density);


//-----------------------------------------------------------------------------
//	Description
//		������ ���ΰ����� �����Ѵ�.
//	Param : 0 - 255 ���� ���� ������. default 24 = 1/6 inch.
//	Return
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall void	Printer_SetLineSpacing(unsigned long lineSpacing);


//-----------------------------------------------------------------------------
//	Description
//		�����͸� �ʱ�ȭ�Ѵ�. Printer_Print(..)�� �θ������� �ѹ� �ҷ������Ѵ�.
//		�̰��� �ҷ��� ��, ���ΰ��ݰ� �󵵰� ����ȴ�.
//
//	Param 
//	Return
//		success	: 0
//		fail	: -1 : serial communication error
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall long	Printer_Init(void);


//-----------------------------------------------------------------------------
//	Description
//		�־��� �ɼǿ� ���� ����Ʈ�Ѵ�.
//	Param 
//		string : ����Ʈ�� �ؽ�Ʈ
//		option : ����Ʈ �ɼ� : ���� PRINT_EMPHASIZE | PRINT_DOUBLEWIDTH 
//				 libsysdef.h ����.
//	Return
//		success	: 0
//		fail	: -1 : serial communication error
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall long	Printer_Print(char* string, unsigned long option);


//-----------------------------------------------------------------------------
//	Description
//		����Ʈ�� ���� ������ ��ٸ���.
//	Param 
//	Return
//		success	: 0
//		fail	: 1 : ���� ����
//				 -1 : serial communication error
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall long	Printer_WaitUntilPrintEnd(void);


//-----------------------------------------------------------------------------
//	Description
//		�������� serial port�� �ݴ´�.
//	Param
//	Return
//		success	: 0
//		fail	: -1 : serial communication error
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall long	Printer_Close(void);

//-----------------------------------------------------------------------------
//	Description
//		���ڵ� ��ĳ�ʸ� ���� ��Ų��.
//	Param
//	Return
//		success	: 1
//		fail	: -1(��ĳ�ʰ� ����.)
//				  -2(��ĳ�� ��)
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall long	Scanner_Trigger(void);

typedef struct 
{
	quad MsgType ;
	quad wParam;
	quad lParam;
} HandlerMsg;

//-----------------------------------------------------------------------------
//	Description
//		�̺�Ʈ ť���� �޽����� �����´�.
//		MSG_EXIT�� ������ ��� �� �̺�Ʈ�� ������ ó���ϰ� ���� ī�� �ȿ��� 
//		�� �̻� Handler_GetMessage()�� Handler_PeekMessage()�� ȣ���ؼ��� �� �ȴ�.
//	Param
//		pMsg : message�� �޾ƿ´�.
//	Return
//		success	: 0
//		fail	: -1
//
//-----------------------------------------------------------------------------
syscall long	Handler_GetMessage(HandlerMsg* pMsg);

//-----------------------------------------------------------------------------
//	Description
//		�̺�Ʈ ť���� �޽����� ���������� ���������� �ʴ´�.
//	Param
//		pMsg : message�� �޾ƿ´�.
//	Return
//		success	: 0
//		fail	: -1
//
//-----------------------------------------------------------------------------
syscall long	Handler_PeekMessage(HandlerMsg* pMsg);

//-----------------------------------------------------------------------------
//	Description
//		�̺�Ʈ ť���� �޽����� �ִ´�.
//	Param
//		pMsg : ���� ���� �޽���
//	Return
//		success	: 0
//		fail	: -1
//
//-----------------------------------------------------------------------------
syscall long	Handler_PostMessage(HandlerMsg* pMsg);

typedef void* ShareCardHandle;
//-----------------------------------------------------------------------------
//	Description
//		���� ī�带 �ε� �Ѵ�.
//	Param
//		cardName : �ε��� ���� ī�� �̸�
//	Return
//		fail	: 0. ī�尡 ���������ʰų� ���� ī�尡 �ƴ� ���.
//		success	: �ε�� ī���� main() �Լ� �ּ�
//
//-----------------------------------------------------------------------------
syscall ShareCardHandle	ShareCard_Load(char* cardName);

//-----------------------------------------------------------------------------
//	Description
//		���� ī�带 ��ε� �Ѵ�. 
//		ī��� ShareCard_Load()��ŭ ShareCard_Unload()�� ȣ�� �Ǿ�� �޸𸮿��� �������.
//	Param
//		cardName : ��ε��� ���� ī�� �̸�
//	Return
//		none
//
//-----------------------------------------------------------------------------
syscall void	ShareCard_Unload(char* cardName);

typedef long (*ShareCardMainFuncType)(long, long, long);

#define GetProcAddress(X,Y) (((ShareCardMainFuncType)(X))((long) Y, 0, 0))

//-----------------------------------------------------------------------------
//	Description
//		Ÿ��Ʋ�� ���� ������ ���� ������ �̹����� �����´�.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		Width			: ��
//		Height			: �ʺ�
//		pBufSign(out)	: ����Ÿ
//		title			: ���� ���� Ÿ��Ʋ
//-----------------------------------------------------------------------------
syscall long	GetSignImgTitle (long Width, long Height, char* pBufSign, char* title);

//-----------------------------------------------------------------------------
//	Description
//		���Ͽ� Ư�� �������̼��� �� �� �ְ� ���ش�.
//		�Ϲ������� Ȯ���ڿ� ��ϵ� ���ø����̼��� ������Ѽ� �����ְų� �����ϴ� ���� �Ѵ�
//		WinCE�� �����Ѵ�.
//	Return
//		success	: 1
//		fail	: 0
//	Param
//		operation		: ������ ���۷��̼� 
//							"open" - ������ ��� �����ش�. ���� �����̸� ������ �ȴ�.
//							"edit" - ������ �����Ҽ� �ְ� ���ش�.
//							"explore" - ������ Ž���Ҽ� �ְ� ���ش�.
//							"print" - ��� ���ش�
//		file			: ��� ����
//		parameter		: �ش� ���ø����̼ǿ� �Ѱ��� �з�����
//		dir				: ����� ��ġ
//	example
//		VM_ShellExecute("open", "file://index.html", 0, 0);//IE�� �ش� ������ ����
//		VM_ShellExecute("open", "http://www.mcnc.co.kr/index.html", 0, 0);//IE�� �ش� URL�� ����
//-----------------------------------------------------------------------------
syscall long	VM_ShellExecute (char* operation, char* file, char* parameter, char* dir);

/////////////////////////////////////////////////////////////////////////////////
//	Description
//		Windows�� WinC�� ����
//		UART�� �Է��� ������ �̺�Ʈ�� �߻�Ű�� �Ѵ�.
//		�Է��� ������ ������ event�� wParam�� ���� �� ����Ʈ�� �־��ش�.
//		��ĳ�ʿ� ���� ���� ��ġ�� �����ϰ� ��� �Է��� ���� ��� ����� �������� �ʴ�
//	paramter 
//		event : �Է��� ���� ��� �߻���ų �̺�Ʈ MSG_USER�̻��̾�� �Ѵ�
//	return
//		0 : success
//		-1 : ��Ʈ�� ���µ��� �ʾѴ�.
//		-2 : �߸��� �̺�Ʈ 
//		-3 : internal error
syscall long Uart_SetInputEvent(long event);

//////////////////////////////////////////////////////////////
//	Description
//		Card Reader�� �����Ѵ�. ���� BlueBird������ ���� 
//		��� ������ �����Ϳ� ���� ��� �Ұ�
//	return
//		1 : ����
//		0 : ����
syscall long	CardReader_Open(char* pszDeviceName);

//////////////////////////////////////////////////////////////
//	Description
//		Card Reader�� �ݴ´�.
//	return
//		1 : ����
//		0 : ����
syscall long	CardReader_Close(void);

///////////////////////////////////////////////////////////////////////
//	Description
//		ī�� �������� ������ ���� �����´�.
//	Parameters
//		track : track ��ȣ
//		buffer : ����Ÿ�� �о� �� ����
//		buf_len : ���� ����
//	return
//		-1 : ����
//		>0 : ���� ����
syscall long	CardReader_ReadRawData(long track, char* buffer, int buf_len);

////////////////////////////////////////////////////////////////////
//	Description
//		ī�� �������� ������ Ʈ���� �����´�
//	return
//		����Ÿ�� �ִ� Ʈ��
//		0x01(TRACK1), 0x02(TRACK3), 0x04(TRACK3)�� �������� ���� 
syscall long	CardReader_GetReadTrack(void);

////////////////////////////////////////////////////////////////////
//	Description
//		ī�� ������ ī�尡 �������� �߻���ų �̺�Ʈ�� �����Ѵ�
//		wParam�� ������ ����Ÿ ���ڿ� �����͸� �־��ش�.
//	Paramter 
//		event : ī�尡 ���� ���� �� �߻���ų �̺�Ʈ WM_USER���� Ŀ�� �Ѵ�.
//	return
//		0 : ����
//		-1 : not open
//		-2 : invalid event
//		-3 : internal error
syscall long	CardReader_StartEvent(long event);

/////////////////////////////////////////////////////////////////////////
//	Description
//		���̻� ī�� ���� �̺�Ʈ�� �߻����� �ʰ� �Ѵ�.
//	return
//		1 : ����
//		0 : ����
syscall long	CardReader_StopEvent(void);

//-----------------------------------------------------------------
//	MC-6000S ������� ������
//-----------------------------------------------------------------

///////////////////////////////////////////////////////////////////
//	Description
//		�����͸� �ʱ�ȭ �Ѵ�.
//	Parameters
//		sPortName : ��Ʈ �̸� MC-6000s������ "BSP2:"
//		BuadRate : ���� ����Ʈ. MC-6000������ 9600
//		Protocol : �������� ��뿩��, �ݵ�� 0
//	Return
//		Success : 1
//		FAIL	: -1 (Already open)
//				  -2 (Unable to open the port)
//				  -3 (Unable to configure the serial port)
//				  -4 (Unable to set the timeout parameters)
//				  -5 (No response from printer)
syscall long BT_Init_Printer(char* sPortName, long BaudRate,long Protocol);

#define	BT_Init_Card(a, b, c) BT_Init_Printer(a, b, c)

//////////////////////////////////////////////////////////////////
//	Description
//		�����͸� �ݴ´�.
//	Return
//		Success : TRUE
//		Fail : FALSE
syscall long BT_Close_Printer(void);

#define BT_Close_Card() BT_Close_Printer()

////////////////////////////////////////////////////////////////
//	Description
//		�����Ϳ� ���� ��ɾ ������.
//		��) {0x1b,0x20,0x00} => Line Space
//	Parameters
//		Cmd : ��ɾ�
//		Length : ����
//	Return
//		SUCCESS : ���� ��ɾ� ����
//		FAIL	: 0 ���� ���� ��
syscall long BT_Control_Command(char *Cmd, int Length); 

///////////////////////////////////////////////////////////////////
//	Description
//		������ ��Ǯ�� ����Ÿ�� ������
//	Parameters
//		strData : ����� ���ڿ�
//		FontValue : ��� ��Ʈ 
//					0 - Normal
//					1 - Double Height
//					2 - Double Width
//					3 - Double Height and Width
//		Empahsis : ���� TRUE�� ����, FALSE�� ����
//	Return
//		Success : ����� ����Ʈ ��
//		Fail	: -1
syscall long BT_Save_Spool(char* strData, long FontValue, long Emphasis);					


///////////////////////////////////////////////////////////////////////
//	Description
//		��Ǯ ������ �����ͷ� ����Ѵ�.
//	Parameters
//		Delete_Spool : ��Ǯ ������ ���������� ���� 
//	Return
//		�����ϸ� TRUE, �����ϸ� FALSE
syscall long BT_Print_Spool(long Delete_Spool);

///////////////////////////////////////////////////////////////////////////
//	Description
//		Spool���� ���� 
syscall void BT_Clear_Spool(void);

////////////////////////////////////////////////////////////////////////////
//	Description
//		ī�� ������ ���� ��Ų��.
//		ī�� ����Ÿ�� ������ �̺�Ʈ�� wParam�� ���ڿ��� ������ ������ �Ʒ��� ����.
//		BNNNNNNNNNNNNNNNNBYYMM(N:ī���ȣ, Y:��ȿ��, M:��ȿ��)
//	Parameters
//		evet : ī�带 �о����� �߻��ϴ� �̺�Ʈ
syscall void BT_Card_Read(long evt);

//////////////////////////////////////////////////////////////////////////////
//	Description
//		ī�� ���� ������ ���� ��Ų��.
syscall void BT_Card_Read_Cancel(void);

//-----------------------------------------------------------------------------
//	Description
//		���� ���带 �����ϰ� ���� ������ �����Ѵ�.
//	Return
//		���� : 1, ��� : 0, �������� �ʴ� ��� : -1, ���ϸ� ����: -2
//	Parameters
//		capturesize	: ������ ���� ũ��
//
//		pathstd	: ������ �н� ����. 
//			  1: �޸� ������ ���� ( ���� Ȥ�� �ϵ帮�½� ������ )
//			  2: �÷��� ������ ���� ��� �÷��� ������ ����
//		file	: �н��� ������ ���ϸ�
//-----------------------------------------------------------------------------

syscall long ShootPhoto ( long capturesize, long pathstd, char *file );


//-----------------------------------------------------------------------------
//	Description
//		JPG�� BMP �̹����� mPOP �� �̹����� ��ȯ�Ѵ�.
//	Return
//		���� : 0, ���� : -1
//	Parameters
//		ImageFormat	: BMP : 1, JPG : 2, PNG : 3
//		nDestWidth		: ������ �̹��� ������ ���� ������
//		nDestHeight		: ������ �̹��� ������ ���� ������
//		pDestImg			: ������ �̹��� ���ϸ�
//		nTimeout			: �����ϴµ� �ҿ�Ǵ� �ִ�ð�( msec )
//-----------------------------------------------------------------------------
#define BMP		1 
#define JPG		2
#define PNG		3 

syscall long ConvertImage ( long ImageFormat, char *pSrcImage, long nDestWidth, long nDestHeight, char *pDestImg, long nTimeout );

syscall	long DeployUpgradeOk ( unsigned char* appID, unsigned short lastVer );


typedef struct _VM_Info
{
	char szSVersion[12];	
	quad nVmVersion;	
	char szBuildDate[32];	
	char szBuildTime[32];	
	char szMachine[32];	
	char szDeviceType[64];
} VM_Info;

syscall void VM_GetVersion ( VM_Info *pstVMInfo );


//-----------------------------------------------------------------------------
//	Description
//		��PDA���� ���� ī�����α׷��� ���� �޸𸮸� ������ ��� ����Ѵ�.
//		VM�ܿ��� �޸𸮸� ������.
//	Return
//		
//	Parameters
//-----------------------------------------------------------------------------
syscall	void*	VM_MemAlloc(long nLength);
syscall	void*	VM_GetMem(void);
syscall	void	VM_MemFree(void);


//-----------------------------------------------------------------------------
//	Description
//		���ڵ� �ʱ�ȭ����, �⺻���� 6�� ��Ʈ�� ����Ͽ� ���ڵ带 OPEN��(M3Plus��)
//							M470. KDC ��ĳ�� : 6����Ʈ ����
//	Return
//		���� : 0, ���� : -1
//	Parameters
//		
//-----------------------------------------------------------------------------
syscall	long	Barcode_Init (void);

//-----------------------------------------------------------------------------
//	Description
//		���ڵ� �ݱ�(M3Plus, M470)
//	Return
//		���� : 0, ���� : -1
//	Parameters
//		
//-----------------------------------------------------------------------------
syscall	long	Barcode_Exit (void);

//-----------------------------------------------------------------------------
//	Description
//		���ڵ� �� �б�(M3Plus, M470)
//	Return
//		���� : 0, ���� : -1
//	Parameters
//		char *ptr : ptr�� ptr[128] �迭�� ��������.
//					** �ݵ�� 128 �迭�� �����ͷ� ������.
//-----------------------------------------------------------------------------
syscall	long	Barcode_Read (char* ptr);

//-----------------------------------------------------------------------------
//	Module Name : Barcode_InitEx
//	Description
//		���ڵ� �ʱ�ȭ����, �ʱ�ȭ���� �Է��Ѵ�.
//	Return
//		���� : 0, ���� : -1
//	Parameters	int port : ��Ʈ��ȣ( 8 )
//				int baud : Baud( 57600 )
//				char *sProt : ��Ʈ ��Ʈ��( "COM8:)
//-----------------------------------------------------------------------------
syscall	long	Barcode_InitEx(int port, int baud, char *sPort);

//-----------------------------------------------------------------------------
//	Module Name : Barcode_GetStatus
//	Description
//		���ڵ��� ���¸� ����.. ����/ ����(
//	Return
//		���� : 0, ���� : -1
//	Parameters	
//-----------------------------------------------------------------------------
syscall	long	Barcode_GetStatus(void);

//-----------------------------------------------------------------------------
//	Module Name : Barcode_SendCommand
//	Description
//		���ڵ忡 ���� �ĸ�带 ����(M470, KDC���ڵ忡 ����)
//	Return
//		���� : 0, ���� : -1
//	Parameters	
//-----------------------------------------------------------------------------
syscall	long	Barcode_SendCommand(char* cmd);

//-----------------------------------------------------------------------------
//	Module Name : Barcode_SendCommandGetString
//	Description
//		���ڵ忡 ���� �ĸ�带 ������ ���ڿ� ����� ����.(M470, KDC���ڵ忡 ����)
//	Return
//		���� : 0, ���� : -1
//	Parameters	
//-----------------------------------------------------------------------------
syscall	long Barcode_SendCommandGetString( char* cmd, char *bfr );

//-----------------------------------------------------------------------------
//	Description
//		���� ������ Ű ��� �˾� ����.
//	Return
//		���� : Ű ��� �� (0:����, 1:�ѱ�, 2:����)
//	Parameters
//-----------------------------------------------------------------------------
#define		KEYMODE_ENGLISH			0			//	�����Է� ����
#define		KEYMODE_HANGUL			1			//	�ѱ��Է� ����
#define		KEYMODE_NUMBER			2			//	�����Է� ����

syscall	long GetKeyMode (void);

//-----------------------------------------------------------------------------
//	Description
//		Ű ��带 ���ϴ� ���·� ��ȯ �Ѵ�.
//	Return
//		���� : 0, ���� : -1
//	Parameters
//      nMode : Ű ��� �� (0:����, 1:�ѱ�, 2:����)
//
//-----------------------------------------------------------------------------
syscall	long SetKeyMode ( long nMode );


#define		BTH_POWER_OFF			0 //(������ OFF ��Ŵ)������ �����ų�, ��ġ�� ����.
#define		BTH_CONNECTABLE			1 //(������ ON ��Ŵ)������ ����
#define		BTH_DISCOVERABLE		2 //(���⼭ ������)�����̰�, ������ ������ ����

#define		BTH_REG_SEARCH_FAIL		-1 //������Ʈ�� ��ȸ ����.
#define		BTH_REG_REG_FAIL		-2 //������Ʈ�� ��� ����.
#define		BTH_NOT_REG_DEVICE		-3 //��ϵ� �ܸ��Ⱑ �������� ����.
#define		BTH_NOT_REG_PORT		-4 //�ܸ���� ��ϵǾ�����, ��Ʈ�� ��ϵ��� ����.
#define		BTH_ALREADY_REG_DEVICE	-5 //�̹� ��ϵ� �ܸ�����.
#define		BTH_NOT_SUPPORT_DEVICE	-10 //�����ϴ� �ܸ��Ⱑ �ƴ�.

//-----------------------------------------------------------------------------
//	Module Name : Bth_GetMode
//	Description
//		������� ���¸� ��ȸ��.
//	Return
//		���� : 0 
//		���� : -1
//			-10(BTH_NOT_SUPPORT_DEVICE) : �����ϴ� �ܸ��Ⱑ �ƴ�.
//	Parameters
//		unsigned long * pdwMode : ���°��� ������ pdwMode.
//				0 (BTH_POWER_OFF) : ������ �����ų�, ��ġ�� ����.
//				1 (BTH_CONNECTABLE) : ������ ����
//				2 (BTH_DISCOVERABLE) : �����̰�, ������ ������ ����
//-----------------------------------------------------------------------------
syscall	long	Bth_GetMode(unsigned long* pdwMode);

//-----------------------------------------------------------------------------
//	Module Name : Bth_SetMode
//	Description
//		��������� �ش� ���·� ������(On / Off).
//	Return
//		���� : 0
//		���� : -1
//			-10(BTH_NOT_SUPPORT_DEVICE) : �����ϴ� �ܸ��Ⱑ �ƴ�.
//	Parameters
//		unsigned long pdwMode : ���°��� ������ dwMode.
//				0 (BTH_POWER_OFF) : (������ OFF ��Ŵ)������ �����ų�, ��ġ�� ����.
//				1 (BTH_CONNECTABLE) : (������ ON ��Ŵ)������ ����
//				2 (BTH_DISCOVERABLE) : (���⼭ ������)�����̰�, ������ ������ ����
//-----------------------------------------------------------------------------
syscall	long	Bth_SetMode(unsigned long pdwMode);

//-----------------------------------------------------------------------------
//	Module Name : Bth_DoPairring
//	Description
//		szDeviceName�� ������ ��ġ�� ���� ������.
//	Return
//		���� : 0, 
//		���� : -1 : szDeviceName Device�� ��ġ�� ����.
//			-2 : ��ġ�� ���� ���� ����.
//			-10 (BTH_NOT_SUPPORT_DEVICE) : �����ϴ� �ܸ��Ⱑ �ȴ�.
//	Parameters
//		char* szDeviceName : �� �� ����̸�.
//-----------------------------------------------------------------------------
syscall	long	Bth_DoPairring(char* szDeviceName );

//-----------------------------------------------------------------------------
//	Module Name : Bth_ComPortReg
//	Description
//		szDeviceName�� ��� szPort�� �����.
//	Return
//		���� : 0 : ������Ʈ ��� ����
//			   -1(BTH_REG_SEARCH_FAIL) : ������Ʈ�� ��ȸ ����.
//			   -2(BTH_REG_REG_FAIL) : ������Ʈ�� ��� ����.
//			   -3(BTH_NOT_REG_DEVICE) : ��ϵ� �ܸ��Ⱑ �������� ����.
//			   -5(BTH_ALREADY_REG_DEVICE) : �̹� ��ϵ� �ܸ�����.
//			   -10(BTH_NOT_SUPPORT_DEVICE) : �����ϴ� �ܸ��Ⱑ �ƴ�.
//	Parameters
//		char* szDeviceName : �� �� ����̸�.
//		char* szPort : ����� PORT �̸� (ex. "COM8")
//-----------------------------------------------------------------------------
syscall	long	Bth_ComPortReg(char* szDeviceName, char* szPort );

//-----------------------------------------------------------------------------
//	Module Name : Bth_ComPortIsReg
//	Description
//		szDeviceName�� ��Ͽ��ο� szPort�� ��Ͽ���
//	Return
//		���� : 
//			   -3(BTH_NOT_REG_DEVICE) : ��ϵ� �ܸ��Ⱑ �������� ����.
//			   -4(BTH_NOT_REG_PORT) : �ܸ���� ��ϵǾ�����, ��Ʈ�� ��ϵ��� ����.
//			   -5(BTH_ALREADY_REG_DEVICE) : �̹� ��ϵ� �ܸ�����.
//			   -10(BTH_NOT_SUPPORT_DEVICE) : �����ϴ� �ܸ��Ⱑ �ƴ�.
//	Parameters
//		char* szDeviceName : �� �� ����̸�.
//		char* szPort : ����� PORT �̸� (ex. "COM8")
//-----------------------------------------------------------------------------
syscall	long	Bth_ComPortIsReg (char* szDeviceName, char* szPort );

//-----------------------------------------------------------------------------
//	Module Name : Warm_Reboot
//	Description
//		�ܸ��⸦ ����Ʈ ������.
//	Return
//		���� : 1 (TRUE)
//		���� : 0 (FALSE)
//			-10 (BTH_NOT_SUPPORT_DEVICE) : �������� �ʴ� �ܸ���.
//	Parameters
//		����.
//-----------------------------------------------------------------------------
syscall	long	Warm_Reboot( void );

//-----------------------------------------------------------------------------
//	Module Name : VM_PlaySound
//	Description
//		Wave file play.
//	Return
//	Parameters
//		����.
//-----------------------------------------------------------------------------
syscall	void	VM_PlaySound(char *cWaveFileName);

//-----------------------------------------------------------------------------
//	Module Name : SSL_SetEnable
//	Description
//		���� Socket���� SSL��뿩�θ� ������
//	Return
//		���� : 0, ���� : -1
//	Parameters
//		nMode : SSL_SOCK_ENABLE : 1 ���
//				SSL_SOCK_DISABLE : 0 �̻��
//-----------------------------------------------------------------------------
syscall	long	SSL_SetEnable		(long nMode);

//-----------------------------------------------------------------------------
//	Module Name : SSL_IsEnable
//	Description
//		���� Socket���� SSL��뿩�θ� ��ȸ��
//	Return
//		SSL ��� : 1 SSL_SOCK_ENABLE
//		SSL �̻�� : 0 SSL_SOCK_DISABLE
//	Parameters
//-----------------------------------------------------------------------------
syscall	long	SSL_IsEnable		(void);

//-----------------------------------------------------------------------------
//	Module Name : SSL_Sock_Connect
//	Description
//		���� ����� SSL�� ����Ͽ� �����Ѵ�. SSL�� �ʱ�ȭ�ϴ� �ڵ尡 �߰���
//	Return
//
//	Parameters
//
//-----------------------------------------------------------------------------
syscall	long	SSL_Sock_Connect	(quad nHostIp, long nPort, long nTimeOut);

//-----------------------------------------------------------------------------
//	Module Name : SSL_Sock_Close
//	Description
//		SSL ������ ����� �����Ѵ�. ���Ǵ� ���ҽ��� ���� �Ѵ�.
//	Return
//
//	Parameters
//
//-----------------------------------------------------------------------------
syscall	long	SSL_Sock_Close		(void);

//-----------------------------------------------------------------------------
//	Module Name : SSL_Sock_Write
//	Description
//		SSL�� �̿��ؼ� Sock_Write �Ѵ�.
//	Return
//
//	Parameters
//
//-----------------------------------------------------------------------------
syscall	long	SSL_Sock_Write		(byte *pBuffer, long nLength, long nTimeOut);

//-----------------------------------------------------------------------------
//	Module Name : SSL_Sock_Read
//	Description
//		SSL�� �̿��ؼ� Sock_Read �Ѵ�.
//	Return
//
//	Parameters
//
//-----------------------------------------------------------------------------
syscall	long	SSL_Sock_Read		(byte *pBuffer, long nMaxLength,  long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		������ ȭ���� �ּ�ȭ �Ǵ� �ִ�ȭ �Ѵ�. (HTC)
//	Return
//		���� : 0, ���� : -1
//	Parameters
//      bFlag : TRUE or FALSE (�ּ�ȭ)
//-----------------------------------------------------------------------------
syscall	long VM_ShowWindow ( BOOL bFlag );

//-----------------------------------------------------------------------------
//	Description
//		VM_SipEnumIMNumber : ��ġ�� IM�� ������ ��ȸ��
//	Parameters
//		
//	Return
//		long				: ��ġ�� IM ����  ����
//	Remark
//		** MAX 20���� 20�� �̻� ��ȸ�� 20�� ������.
//-----------------------------------------------------------------------------
syscall long VM_SipEnumIMNumber( void );
//-----------------------------------------------------------------------------
//	Description
//		VM_SipEnumIM : ��ġ�� IM�� �̸��� ��ȸ��
//	Parameters
//		char pIm_Name[20][260] : ��ġ�� IM�� �̸��� ������.
//	Return
//		SUCCESS		: ����
//		FAIL		: ����
//	Remark
//-----------------------------------------------------------------------------
syscall long VM_SipEnumIM(char pIm_Name[20][260]);

//-----------------------------------------------------------------------------
//	Description
//		VM_SipGetCurrentIM : ���� ���õ� IM������ ����
//	Parameters
//		char *szIMName : ���� ���õ� IM�� �̸��� ������.
//						 Name : max 260 byte
//	Return
//		SUCCESS		: ����
//		FAIL		: ����
//	Remark
//-----------------------------------------------------------------------------
syscall long VM_SipGetCurrentIM( char * szIMName );

//-----------------------------------------------------------------------------
//	Description
//		VM_SipSetCurrentIM : �Էµ� IM�� �Է� IM���� ������.
//	Parameters
//		char *szIMName : ������ IM�� �̸�.
//						 Name : max 260 byte
//	Return
//		SUCCESS		: ����
//		FAIL		: ����
//	Remark
//-----------------------------------------------------------------------------
syscall long VM_SipSetCurrentIM( char * szIMName );

//-----------------------------------------------------------------------------
//	Description
//		�ý��� �޸� �� ���� ������ �����Ѵ�.
//	Return
//		���� : leak count
//	Parameters
//-----------------------------------------------------------------------------
syscall long Mem_GetLeakCheck (void);

//�� ���� �� ���� API
#ifdef __DEBUG_HEAP__

	#define	MEM_INIT()			Mem_NewHeapMgr()
	#define	MEM_EXIT()			Mem_DelHeapMgr()

	#define MEM_NEW(size)		Mem_New(size, __FILE__, __LINE__)		
	#define MEM_DEL(p)			Mem_Delete((unsigned char*)p)
	#define MEM_GET_INF(index)	Mem_GetInfo(index)
	#define MEM_LEAK_CNT()		Mem_GetLeakCount()

#else

	#define	MEM_INIT
	#define	MEM_EXIT

	#define MEM_NEW				Mem_Alloc
	#define MEM_DEL				Mem_Free
	#define MEM_GET_INF(index)
	#define MEM_LEAK_CNT()

#endif // __DEBUG_HEAP__

//-----------------------------------------------------------------------------
//	Description
//		�� ���� �ý��� �޸� �� ���� Ŭ������ �ʱ�ȭ�ϰų� �����Ѵ�.
//	Return
//		���� : 0
//	Parameters
//-----------------------------------------------------------------------------
syscall long Mem_NewHeapMgr (void);
syscall long Mem_DelHeapMgr (void);

//-----------------------------------------------------------------------------
//	Description
//		�� ���� �ý��� �޸� ���� �Ҵ��Ѵ�(�޸� �Ҵ� ������ �����Ѵ�.).
//	Return
//		���� : �� ������
//	Parameters
//      nLength : �޸� �Ҵ� ũ��
//      szFile  : API ȣ�� �ҽ� ��� �� ���� ��
//      nLine   : API ȣ�� �ҽ��� ���� ��ȣ
//-----------------------------------------------------------------------------
syscall void* Mem_New (long nLength, char* szFile, long nLine);

//-----------------------------------------------------------------------------
//	Description
//		�� ���� �ý��� �޸� ���� �����Ѵ�(�޸� �Ҵ� ������ �����Ѵ�.).
//	Return
//	Parameters
//      pMem1  : �޸� �Ҵ� ������
//-----------------------------------------------------------------------------
syscall void Mem_Delete (byte* pMem1);

//-----------------------------------------------------------------------------
//	Description
//		�� ���� �ý��� �޸� ���� �� ī��Ʈ�� ������ �˾Ƴ���.
//	Return : �޸� �� ī��Ʈ
//	Parameters
//-----------------------------------------------------------------------------
syscall long Mem_GetLeakCount (void);

//-----------------------------------------------------------------------------
//	Description
//		�� ���� �ý��� �޸� ���� �� ������ ������ �����Ѵ�.
//	Return : HeapInf ����ü ������
//	Parameters
//      index  : �޸� �Ҵ� ����Ʈ �ε���(������ NULL�� �ɶ�����..)
//-----------------------------------------------------------------------------
typedef struct _HeapInf
{
	void*	m_h;
	long	m_nSize;
	char	m_szFile[128];
	long	m_nLine;
} HeapInf;

syscall void* Mem_GetInfo ( long index );

#define	TASK_COM	1
#define	TASK_NET	2
#define	TASK_APP	3
//-----------------------------------------------------------------------------
//	Description
//		��Ƽ Ÿ��ũ ���񽺸� ��û�Ѵ�.
//	Return
//		���� : 0
//	Parameters
//      Message, wParam, lParam
//-----------------------------------------------------------------------------
syscall long Mts_PostMessage (quad Message, quad wParam, quad lParam);

//dkjung 2009-10-30
//=============================================================================
//	SQLite3 API
//=============================================================================
syscall void*	SQL_Open			(char* pszDbFile);
syscall long	SQL_Close			(handle hDb);
syscall long	SQL_ExecDirect		(handle hDb, char* pszSql);

syscall void*	SQL_CreateStatement	(handle hDb, char* pszSql);
syscall long	SQL_DeleteStatement (handle hStmt);

syscall BOOL	SQL_Bind			(handle hStmt, long index, char cType, long* pVal, long n);
syscall BOOL	SQL_Execute			(handle hStmt);
syscall BOOL	SQL_Next			(handle hStmt);

syscall long	SQL_GetColCount		(handle hStmt);
syscall char*	SQL_GetColName		(handle hStmt, long index);
syscall char	SQL_GetColType		(handle hStmt, long index);
syscall long	SQL_GetValue		(handle hStmt, long index, char cType, long* pVal);

syscall long	SQL_ConvUcStr		(char* dst, char* src);
syscall long	SQL_ConvMbStr		(char* dst, char* src);

syscall char*	SQL_GetLastError	(handle hDb);
syscall BOOL	SQL_Begin			(handle hDb);
syscall BOOL	SQL_Commit			(handle hDb);
syscall BOOL	SQL_Rollback		(handle hDb);

//�񵿱� �Լ�
syscall long	SQL_CreateStatementAsync	(handle hDb, char* pszSql);
syscall long	SQL_ExecuteAsync			(handle hStmt);

//=============================================================================
//	Dll Interface API
//=============================================================================
syscall void*	DLL_LoadObject		(const char* sofile);
syscall void*	DLL_LoadFunction	(handle h, const char* name);
syscall void	DLL_UnloadObject	(handle h);

//=============================================================================
//	HtmlViewer API
//=============================================================================
syscall void*	HtmlViewer_Create		(long x, long y, long w, long h, char*  pszHtmlFile);
syscall long	HtmlViewer_Destroy		(handle hViewer);
syscall long	HtmlViewer_SetContent	(handle hViewer, char*  pszHtmlFile);

syscall long	Netwdt_SetLife			(long nMaxSec);

//=============================================================================
//	memory pool API
//=============================================================================
syscall void*	MEMPOOL_Create			(void);
syscall void	MEMPOOL_Finalize		(handle h);
syscall void*	MEMPOOL_Alloc			(handle h, long nSize);
syscall void*	MEMPOOL_AllocWithInfo	(handle h, long nSize, long nLine, char* pszFile);
syscall void*	MEMPOOL_Attach			(handle h, void* pMem, long nSize);

//=============================================================================
//	HTTP API (cURL ���)
//=============================================================================
syscall	long	HTTP_Url2Buf			(char* pszMethod, char* pszUrl, void* pReqBuf, char* pResBuf);
syscall long	HTTP_Url2File			(char* pszMethod, char* pszUrl, void* pBuf, char* pszFileName);
syscall long	HTTP_FileDownload		(char* pszUrl, char* pszFileName);
syscall long	HTTP_FileUpload			(char* pszUrl, char* pszFileName);
syscall long	HTTP_FileFormUpload		(char* pszUrl, char* pszFormName, char* pszReqFile);

syscall long	SqliteToJsonFile (
				const char* ckey, const char* rkey,
				const char* db_nm, const char* sql,
				const char* json_file, long flag);

syscall long	HTTP_UploadData (
				char* url,
				char* className,
				char* service,
				char* req,
				char* db_nm,
				char* sql);

syscall	long	HTTP_DownloadData (
				char* url,
				char* className,
				char* service,
				char* req,
				char* db_nm);

//=============================================================================
//	JSON API
//=============================================================================
#define JSON_False		0
#define JSON_True		1
#define JSON_NULL		2
#define JSON_Number		3
#define JSON_String		4
#define JSON_Array		5
#define JSON_Object		6

syscall void*	JSON_Create				(long nType);
syscall void	JSON_Finalize			(void* h);
syscall long	JSON_GetArrayCount		(void* h);
syscall long	JSON_AddArrayItem		(void* h);
syscall long	JSON_SetArrayItem		(void* h, char  chType, char* pszKey, void* pVal);
syscall void*	JSON_GetArrayItem		(void* h, long  index, char* pszKey, char* pchType);
syscall void	JSON_SetValue			(void* h, char  pchType, char* pszKey, void* pVal);
syscall void*	JSON_GetValue			(void* h, char* pszKey, char* pchType);
syscall long	JSON_Attach				(void* h, char* pszKey, void* clazz);
syscall long	JSON_LoadFile			(void* h, char* pszJsonFile);
syscall char*	JSON_toString			(void* h);
syscall void	JSON_toJson				(void* h, char* pszJsonStr);

syscall void	JSONRPC_Query			(char* url, char* method, char* params, long id, char* pBuf);

//=============================================================================
//	MDM API
//=============================================================================
syscall char*	MDM_GetAppGuid			(void);
syscall long	MDM_IsNewAppVer			(char* pszAppName, char* url);
syscall long	MDM_GetAppVerPatch		(char* pszAppName);
syscall void	MDM_VmUpgrade			(void);
syscall void	MDM_VmInstall			(void);
syscall void	MDM_VmUpgradeUrl		(char* check_url, char* download_url);

//=============================================================================
//	WEB API
//=============================================================================
syscall long	WebView_LoadUrl			(char* url);


//=============================================================================
//	Encryption API
//=============================================================================
#define CRYPT_SHA256			1
syscall char*	CRYPT_Get				(BYTE* pszText, long nType);

//=============================================================================
//	VPN API
//=============================================================================
#define VPN_NOT_INSTALLED		-1	// VPN Client�� ���� ��ġ���� ���� ����
#define VPN_CLOSED				0	// VPN Client�� ������� ���� ����
#define VPN_CONNECTED			1	// VPN Client�� ����Ǿ� ����� ����
#define VPN_TRY_TO_CONNECT		2	// VPN Client�� ���� ���� ���� ����
#define VPN_INSTALLED			3	// VPN Client�� ���� ��ġ�� ����

#define VPN_STATUS_CHK_INSTALLED	0	//VPN ��ġ ���� Ȯ��
#define VPN_STATUS_CHK_READY		1

syscall long	VPN_Install				(void);
syscall long	VPN_Start				(void);
syscall long	VPN_Stop				(void);
syscall long	VPN_GetStatus			(long);
syscall char*	VPN_GetMsg				(void);
syscall void	VPN_Request				(char* pszUrl, char* pszId);
syscall void	VPN_Login				(char* pszUrl, char* pszId, char* pszKey);
syscall void	VPN_Logout				(void);

//=============================================================================
//	Progress Api
//=============================================================================
//�񵿱� ���α׷��� ǥ�� (������� ���۵�)
syscall void	PROGRESS_Start			(void);
syscall void	PROGRESS_Stop			(void);

//(x,y) �ؽ�Ʈ �߽���ǥ.
syscall long	PROGRESS_DrawText		(long x, long y, long FrColor, long BkColor, long font_type, long nCur, long nMax);

//(x,y) bar left-top ��ǥ.
syscall long	PROGRESS_DrawBar		(long x, long y, long w, long h, long FrColor, long font_type, long nCur, long nMax);

//(x,y) arc �߽���ǥ, r : ������, thickness : �� ǥ�õβ�.
syscall long	PROGRESS_DrawArc		(long x, long y, long r, long thickness, long FrColor, long font_type, long nCur, long nMax);

//nTotal : ��ü ī��Ʈ ��
syscall void	PROGRESS_SetStart		(long nTotal);

//nValue : ���� ���� ī��Ʈ �� (ȭ�鿡�� ����� ���� ������� ǥ�� ��)
syscall void	PROGRESS_SetUpdate		(long nValue);

//�̺�Ʈ(MSG_PROGRESS)�� ���α׷��� ���ప/��ü���� ����.
syscall void	PROGRESS_SetCallbackFlag(long flag);

syscall void	PROGRESS_SetDumpFile	(char* pFileName);

//=============================================================================
//	Dynamic SysCall API
//=============================================================================

//-----------------------------------------------------------
// System API
//-----------------------------------------------------------

syscall long System_Call		(char* pCallName, char* pInArg);
syscall long System_GetResult	(char* pBuf);

//-----------------------------------------------------------
// syscall API
//-----------------------------------------------------------

typedef struct _arg_value
{
	BYTE	flag;
	QUAD	size;
	BYTE	b;
	WORD	w;
	QUAD	q;
	void*	p;
} arg_value;

#define MEMOBJ_NULL		 0x00  // Memory value is null
#define MEMOBJ_BYTE		 0x01  // Memory value is a byte
#define MEMOBJ_WORD      0x02  // Memory value is a word
#define MEMOBJ_QUAD      0x04  // Memory value is a quad
#define MEMOBJ_HAND      0x08  // Memory value is a handle

syscall char*	SYSCALL_GetRegFunctionVer	(void);
syscall long	SYSCALL_GetRegFunctionCount (void);
syscall char*	SYSCALL_GetRegFunctionName	(long index);
syscall long	SYSCALL_ToValue				(long nSize, void* pArg);
syscall long	SYSCALL_FromValue			(long nSize, void* pArg);
syscall long	SYSCALL_BindIndex			(long index, long argc, arg_value** argv, arg_value** arg_ret);
syscall long	SYSCALL_BindName			(char* pszName, long argc, arg_value** argv, arg_value** arg_ret);

//=============================================================================
//	Collection API
//=============================================================================
//-----------------------------------------------------------------------------
//	Buffer
//-----------------------------------------------------------------------------
syscall	void*	BUFFER_Create(long nLength, void* lpBuffer);
syscall void	BUFFER_Finalize(void* h);
syscall long	BUFFER_GetLength	(void* h);
syscall char	BUFFER_GetAt		(void* h, long index);
syscall char	BUFFER_SetAt		(void* h, long index, char ch);
syscall long	BUFFER_Set			(void* h, long index, long nLength, void* lpBuffer);
syscall void*	BUFFER_GetBuffer	(void* h);
syscall void*	BUFFER_SetBuffer	(void* h, long nLength, void* lpBuffer);
syscall long	BUFFER_Append		(void* h, long nLength, void* lpBuffer);
syscall long	BUFFER_ClearBuffer	(void* h);
syscall long	BUFFER_RemoveBuffer	(void* h);

//-----------------------------------------------------------
// String
//-----------------------------------------------------------
syscall void*	STRING_Create		(char* lpsz);
syscall void	STRING_Finalize		(void* h);
syscall long	STRING_GetLength	(void* h);
syscall void*	STRING_GetBuffer	(void* h, long nPos);
syscall void*	STRING_SetBuffer	(void* h, long nLength, void* lpBuffer);
syscall long	STRING_Append		(void* h, char* pszStr);
syscall long	STRING_IsEmpty		(void* h);
syscall void	STRING_Empty		(void* h);
syscall char	STRING_GetAt		(void* h, long nPos);
syscall void	STRING_SetAt		(void* h, long nPos, char ch);
syscall long	STRING_Compare		(void* h, char* lpsz);
syscall long	STRING_CompareNoCase(void* h, char* lpsz);
syscall char*	STRING_Mid			(void* h, long nFirst, long nCount);
syscall char*	STRING_Left			(void* h, long nCount);
syscall char*	STRING_Right		(void* h, long nCount);
syscall long	STRING_MakeLower	(void* h);
syscall long	STRING_MakeUpper	(void* h);
syscall long	STRING_Insert		(void* h, long nPos, char* lpsz);
syscall long	STRING_Delete		(void* h, long nPos, long nCount);
syscall long	STRING_TrimLeft		(void* h);
syscall long	STRING_TrimRight	(void* h);
syscall long	STRING_FindStr		(void* h, char* lpsz, long nStart);
syscall long	STRING_Find			(void* h, char ch, long nStart);
syscall long	STRING_ReverseFind	(void* h, char ch);
syscall char*	STRING_MakeReverse	(void* h);
syscall char*	STRING_parseInt		(void* h, long val);
syscall char*	STRING_toString		(void* h);

//-----------------------------------------------------------
// Vector
//-----------------------------------------------------------
syscall void*	VECTOR_Create		(long nObjSize, long nCapacity);
syscall void	VECTOR_Finalize		(void* h);
syscall long	VECTOR_Capacity		(void* h);
syscall long	VECTOR_Size			(void* h);
syscall long	VECTOR_IsEmpty		(void* h);
syscall long	VECTOR_Add			(void* h, long index, void* pObj);
syscall long	VECTOR_AddInt		(void* h, long index, long nVal);
syscall long	VECTOR_AddElementAt	(void* h, long index, void* pObj);
syscall long	VECTOR_AddElement	(void* h, void*	pObj);
syscall void*	VECTOR_Get			(void* h, long index);
syscall long	VECTOR_GetInt		(void* h, long index);
syscall void*	VECTOR_ElementAt	(void* h, long index);
syscall long	VECTOR_IndexOf		(void* h, void* pObj, long index);
syscall long	VECTOR_LastIndexOf	(void* h, void* pObj, long index);
syscall void*	VECTOR_FirstElement	(void* h);
syscall void*	VECTOR_LastElement	(void* h);
syscall long	VECTOR_Remove		(void* h, long index);
syscall long	VECTOR_RemoveAll	(void* h);

//-----------------------------------------------------------
// HashMap
//-----------------------------------------------------------
syscall void*	HASHMAP_Create		(void);
syscall void	HASHMAP_Finalize	(void* h);
syscall void*	HASHMAP_setValue	(void* h, long nType, void* pData, long nSize);
syscall long	HASHMAP_saveValue	(void* h, long flag, char* key, void* value);
syscall long	HASHMAP_isEmpty		(void* h);
syscall long	HASHMAP_put			(void* h, char* key, void* value);
syscall long	HASHMAP_putInt		(void* h, char* key, long value);
syscall long	HASHMAP_putStr		(void* h, char* key, char* value);
syscall long	HASHMAP_putBin		(void* h, char* key, void* value, long len);
syscall void*	HASHMAP_get			(void* h, char* key);
syscall long	HASHMAP_getInt		(void* h, char* key);
syscall char*	HASHMAP_getStr		(void* h, char* key);
syscall void*	HASHMAP_getBin		(void* h, char* key);
syscall long	HASHMAP_remove		(void* h, char* key);
syscall long	HASHMAP_containsKey	(void* h, char* key);
syscall void	HASHMAP_clear		(void* h);
syscall void**	HASHMAP_toArray		(void* h);
syscall void*	HASHMAP_GetKeys		(void* h);
syscall long	HASHMAP_size		(void* h);

//-----------------------------------------------------------
// Base64
//-----------------------------------------------------------
syscall void*	BASE64_Create		(void);
syscall void	BASE64_Finalize		(void* h);
syscall void*	BASE64_GetResult	(void* h);
syscall long	BASE64_Encode		(void* h, void* pBuf, long nLen);
syscall long	BASE64_Decode		(void* h, void* pBuf, long nLen);
syscall void*	BASE64_toString		(void* h);

//-----------------------------------------------------------
// Camera new API
//-----------------------------------------------------------
//1(1280X1024)="D",2(1024X768)="F",3(640X480)="J",4(320X240)="K" - Default
syscall long Camera_Open(char* resolution);
syscall long Camera_Close(void);
syscall long Camera_SetScreen(long x, long y, long w, long h);
//����θ� ����.
syscall long Camera_Shoot(char* pszPath);
//flag = 1 (on), flag = 0 (off)
syscall long Camera_Flash(long flag);

syscall long SetRemoteLog (long flag);

#endif	//	LIBSYSCALL_H

