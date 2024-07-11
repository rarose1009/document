#ifndef		LIBSYSCALL_H
#define		LIBSYSCALL_H

//------------------------------------------------------------------------------
//		card
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		현재 실행 중인 카드를 지우고 새로운 카드를 메모리에 올린다
//	Return
//		없음
//	Parameters
//		pCardName(in)	: 로드할 카드 이름
//-----------------------------------------------------------------------------
syscall void	Card_Load (char* pCardName);

//-----------------------------------------------------------------------------
//	Description
//		현재 실행 중인 카드를 지우지 않고 새로운 카드를 메모리에 올린다
//	Return
//		없음
//	Parameters
//		pCardName(in)	: 로드할 카드 이름
//-----------------------------------------------------------------------------
syscall void	Card_Insert (char* pCardName);

//-----------------------------------------------------------------------------
//	Description
//		메모리에 있는 카드를 강제적으로 지운다
//	Return
//		없음
//	Parameters
//		pCardName(in)	: 지울 카드 이름
//-----------------------------------------------------------------------------
syscall void	Card_Delete (char* pCardName);

//------------------------------------------------------------------------------
//		database
//------------------------------------------------------------------------------

//winCE에서 사용되는 Database volume mounting mode : dkjung 2003-01-03
#define DB_VOLUM_CREATE_NEW				0x00000001
#define DB_VOLUM_CREATE_ALWAYS			0x00000002
#define DB_VOLUM_OPEN_EXISTING			0x00000003
#define DB_VOLUM_OPEN_ALWAYS			0x00000004
#define DB_VOLUM_TRUNCATE_EXISTING		0x00000005

//winCE에서 사용되는 Database volume GUID : dkjung 2003-01-03
typedef struct  _DBGUID
{
    quad Data1;
    quad Data2;
    quad Data3;
    quad Data4;
} DBGUID;

//-----------------------------------------------------------------------------
//	Description
//		외부 메모리 카드등에 데이타 베이스를 생성 가능하도록.
//		데이타 베이스 Volume을 Mounting 한다.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pGuid (out)			: Mounting된 데이타베이스 Volume의 GUID.
//		pszMountName (in)	: 데이타 베이스 Volume 이름
//		nMode (in)			: Mounting 모드
//			DB_VOLUM_CREATE_NEW			: 새 볼륨을 생성, 있으면 실패.
//			DB_VOLUM_CREATE_ALWAYS		: 새 볼륨을 생성, 있으면 덮어 씌움.
//			DB_VOLUM_OPEN_EXISTING		: 이미 생성된 볼륨을 연다, 없으면 실패.
//			DB_VOLUM_OPEN_ALWAYS		: 이미 생성된 볼륨을 연다, 없으면 새로 생성.
//			DB_VOLUM_TRUNCATE_EXISTING	: 이미 생성된 볼륨을 열고, 내용을 비운다, 없으면 실패.
//	support : Win CE
//-----------------------------------------------------------------------------
syscall long DB_MountVol (DBGUID* pGuid, char* pszMountName, long nMode);

//-----------------------------------------------------------------------------
//	Description
//		데이타 베이스 Volume을 Unmounting 한다.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pGuid (in)	: Mounting된 데이타베이스 Volume의 GUID
//	support : Win CE
//-----------------------------------------------------------------------------
syscall long DB_UnmountVol (DBGUID* pGuid);

//-----------------------------------------------------------------------------
//	Description
//		데이타 베이스를 만든다.
//	Return
//		success	: 만들어진 데이타베이스의 OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		pcName (in)		: 데이타 베이스 이름
//		nDatabaseType	: 데이타 베이스 타입 (상수에서 (2)DB type 참조)
//		nNumSpec		: 소트될 필드의 개수
//		pFieldID (in)	: 소트되는 필드의 아이디 배열 (상수 (3)Field ID 참조)
//		pSortOrder (in)	: 각 필드의 소팅 방법 (상수 (4)Sort Desc 참조)
//-----------------------------------------------------------------------------
syscall long	DB_CreateDatabase (char *pcName, long nDatabaseType, long nNumSpec, long* pFieldID, byte* pSortOrder);

//-----------------------------------------------------------------------------
//	Description
//		데이타베이스 OID로 데이타베이스를 삭제한다.
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
//		데이타베이스 OID를 데이타베이스를 오픈한다.
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
//		데이타 베이스를 닫는다.
//	Return
//		success	: true
//		fail	: false
//	Param
//		hDatabase	: 데이타베이스 핸들
//-----------------------------------------------------------------------------
syscall long 	DB_CloseDatabase (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		새로운 레코드를 생성한다.
//	Return
//		success	: 만들어진 레코드의 OID
//		fail	: VD_DB_INVALID_OID
//	Param
//		hDatabase	: 데이타베이스 핸들
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_CreateRecord (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		레코드를 삭제한다.
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
//		필드를 삭제한다.
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
//		바이너리 필드 값을 기록한다.
//	Return
//		success	: true
//		fail	: false
//	Param
//		hDatabase	: database handle
//		nOidRecord	: record oid
//		nFieldID	: field id
//		pBuffer (in): 적을 값
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
//		디비의 레코드 OID를 순차적으로 가져온다.
//		DB_OpenEnumRecord()호출후 사용해야 한다.
//		커서가 다음 레코드로 이동
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
//		디비의 레코드 OID를 순차적으로 가져온다.
//		디비의 첫번째 레코드를 커서를 이동한다.
//	Return
//		success	: 1
//		fail	: 0
//	Param
//		hDatabase	: database handle
//	Notice
//		2.0에서는 핸들을 리턴받았지만 2.5에서는 핸들을 리턴하는 것이 아니다.
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_OpenEnumRecord (long hDatabase);

//-----------------------------------------------------------------------------
//	Description
//		디비의 레코드 OID를 순차적으로 가져오는 것을 중지한다.
//		커서를 첫번째 레코드로 이동시킨다.
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
//		이름으로 데이타 베이스를 오픈한다.
//	Retur
//		success	: 오픈된 데이타 베이스의 핸들
//		fail	: VD_DB_INVALID_HANDLE (상수 (5)handle참조)
//	Param
//		pcName (in)	: 오픈할 데이타베이스 이름
//		keyField	: 오픈했을 때 소트될 필드 아이디,
//					  DB_Create시에 소트 될 것이라고 명기한 필드만 된다.
//					  그냥 오픈 할 경우 NULL_FILEDID 사용
//-----------------------------------------------------------------------------
syscall long	DB_OpenDatabaseByName (char *pcName, long nKeyField);

//-----------------------------------------------------------------------------
//	Description
//		pcName에 해당하는 데이타 베이스를 삭제한다.
//	Return
//		success	: true
//		fail	: false
//	Param
//		pcName (in)	: 데이타 베이스 이름
//	support : PALM, Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_DeleteDatabaseByName (char *pcName);

//-----------------------------------------------------------------------------
//	Description
//		이름으로 데이타베이스 OID를 구한다
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
//		남은 공간을 구한다.
//	Return
//		free space
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long 	DB_GetFreeStorage (void);

//-----------------------------------------------------------------------------
//	Description
//		필드의 크기를 구한다.
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
//		접근할 파일을 연다
//	Return
//		success		: 파일 핸들
//		fail		: -1
//	Parameters
//		pName(in)	: 파일 이름
//		nMode		: 파일 속성
//		nCreateFlag	: 생성 플래그
//			FS_READ_MODE	: 읽기 전용 속성
//				FS_NORMAL_FLAG	: 사용되지 않음
//				FS_CREATE_FLAG	: 사용되지 않음
//
//			FS_WRITE_MODE	: 읽기, 쓰기 속성
//				FS_NORMAL_FLAG	: 파일이 있으면 파일 핸들, 없으면 fail
//				FS_CREATE_FLAG	: 파일이 없으면 생성, 있으면 지우고 생성
// 주) FS_Open에 의해 열인 파일의 파일 포인터는 무조건 처음에 위치한다
//-----------------------------------------------------------------------------
syscall long 	FS_Open (char* pName, long nMode, long nCreateFlag);

//-----------------------------------------------------------------------------
//	Description
//		열린 파일을 닫음
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//-----------------------------------------------------------------------------
syscall long	FS_Close (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		열린 파일의 파일 포인터를 이동한다
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//		nOffset	: 이동할 위치
//		nOrigin	: 시작 위치
//			FS_SEEK_CURRENT		: 현재 위치한 파일 포인터에서 시작하여 앞으로 이동
//			FS_SEEK_FROM_END	: 파일의 마지막에서 시작하여 뒤로 이동
//			FS_SEEK_FROM_SET	: 파일의 처음에서 시작하여 앞으로 이동
//-----------------------------------------------------------------------------
syscall long 	FS_Seek (long nFd, long nOffset, long nOrigin);

//-----------------------------------------------------------------------------
//	Description
//		파일에서 데이타를 읽어내낸다
//	Return
//		success : 실제 읽은 데이타 크기
//		fail	: -1
//	Param
//		nFd			: 파일 핸들
//		pBuffer(out): 읽은 데이타를 저장할 버퍼 포인터
//		nBufLen		: 읽어낼 데이타 크기
// 주) 읽은 테이타의 크기는 nBufLen보다 작을수도 0이 될수도 있다
//-----------------------------------------------------------------------------
syscall long 	FS_Read (long nFd, byte* pBuffer, long nBufLen);

//-----------------------------------------------------------------------------
//	Description
//		파일에 데이타를 저장한다
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd			: 파일 핸들
//		pBuffer(in)	: 저장할 데이타 버퍼 포인터
//		nBufLen		: 저장할 데이타 크기
//-----------------------------------------------------------------------------
syscall long	FS_Write (long nFd, byte* pBuffer, long nBufLen);

//-----------------------------------------------------------------------------
//	Description
//		파일의 끝인지를 알아낸다
//	Return
//		success	: 파일 포인터가 파일의 끝이면 TRUE 아니면 FALSE
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//-----------------------------------------------------------------------------
syscall long	FS_Eof (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		현재 파일 포인터의 위치를 알아낸다
//	Return
//		success	: 현재 파일 포이터의 위치
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//-----------------------------------------------------------------------------
syscall long 	FS_Tell (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		파일의 크기를 알아낸다
//	Return
//		success	: 파일의 크기
//		fail	: -1
//	Param
//		pName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall long 	FS_GetSize (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		파일을 삭제한다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall long 	FS_Delete (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		파일 버퍼의 내용을 파일에 저장한다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//-----------------------------------------------------------------------------
syscall long	FS_Flush (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		파일이 존재하는지 알아낸다
//	Return
//		success	: 파일이 존재하면 TRUE, 아니면 FALSE
//		fail	: -1
//	Param
//		pName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall	long	FS_Exist (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		파일의 이름을 변경한다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: 파일 이름
//		pDestName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall long	FS_Rename (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		파일을 복사한다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: 파일 이름
//		pDestName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall long	FS_Copy (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		디렉토리를 만든다
//	Return
//		success	: 0
//		fail	: -1 (이 경우 GetApiError()로 아래의 에러코드를 확인해야 한다.)
//			FS_ERR_INTERNAL_ERROR : 시스템에서 디렉토리가 생성되지 않은 경우.
//			FS_ERR_ALREADY_EXIST : 이미 존재하는 디렉토리를 다시 생성할 경우.	
//	Param
//		pName(in)	: 디렉토리 이름
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_CreateDir (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		디렉토리를 삭제한다
//	Return
//		success	: 0
//		fail	: -1 (이 경우 GetApiError()로 아래의 에러코드를 확인해야 한다.)
//			FS_ERR_INTERNAL_ERROR : 시스템에서 디렉토리가 삭제가 실패한 경우.
//			FS_ERR_NO_SUCH_FILE : 존재하지 않는 디렉토리를 지우려고 할 경우.
//	Param
//		pName(in)	: 디렉토리 이름
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_RemoveDir (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		디렉토리내에서 지정된 조건의 파일 핸들과 처음 검색된 파일이름을 리턴한다.
//	Return
//		success	: File Handle, 검색된 파일명
//		fail	: -1 
//	Param
//		pFilter(in)	: 디렉토리및 파일 이름 (wildcard characters (* and ?))
//		pGetName(out): 검색된 파일명
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_FindFirst (char* pFilter, char* pGetName);

//-----------------------------------------------------------------------------
//	Description
//		디렉토리내에서 지정된 파일 핸들의 조건에 대한 파일이름을 리턴한다.
//	Return
//		success	: TRUE, 검색된 파일명
//		fail	: FALSE
//	Param
//		Fh(in)	: FS_FindFirst에서 리턴된 File Handle
//		pGetName(out): 검색된 파일명
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_FindNext (long Fh, char* pGetName);

//-----------------------------------------------------------------------------
//	Description
//		지정된 파일 핸들을 닫는다.
//	Return
//		success	: 1
//		fail	: 0
//
//	Param
//		Fh(in)	: FS_FindFirst에서 리턴된 File Handle
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FS_FindClose (long Fh);


//-----------------------------------------------------------------------------
//	Description
//		접근할 파일을 연다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success		: 파일 핸들
//		fail		: -1
//	Parameters
//		pName(in)	: 파일 이름
//		nMode		: 파일 속성
//		nCreateFlag	: 생성 플래그
//			FS_READ_MODE	: 읽기 전용 속성
//				FS_NORMAL_FLAG	: 사용되지 않음
//				FS_CREATE_FLAG	: 사용되지 않음
//
//			FS_WRITE_MODE	: 읽기, 쓰기 속성
//				FS_NORMAL_FLAG	: 파일이 있으면 파일 핸들, 없으면 fail
//				FS_CREATE_FLAG	: 파일이 없으면 생성, 있으면 지우고 생성
// 주) FS_Open에 의해 열인 파일의 파일 포인터는 무조건 처음에 위치한다
//-----------------------------------------------------------------------------
syscall long 	FFS_Open (char* pName, long nMode, long nCreateFlag);

//-----------------------------------------------------------------------------
//	Description
//		열린 파일을 닫음
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//-----------------------------------------------------------------------------
syscall long	FFS_Close (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		열린 파일의 파일 포인터를 이동한다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//		nOffset	: 이동할 위치
//		nOrigin	: 시작 위치
//			FS_SEEK_CURRENT		: 현재 위치한 파일 포인터에서 시작하여 앞으로 이동
//			FS_SEEK_FROM_END	: 파일의 마지막에서 시작하여 뒤로 이동
//			FS_SEEK_FROM_SET	: 파일의 처음에서 시작하여 앞으로 이동
//-----------------------------------------------------------------------------
syscall long 	FFS_Seek (long nFd, long nOffset, long nOrigin);

//-----------------------------------------------------------------------------
//	Description
//		파일에서 데이타를 읽어내낸다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success : 실제 읽은 데이타 크기
//		fail	: -1
//	Param
//		nFd			: 파일 핸들
//		pBuffer(out): 읽은 데이타를 저장할 버퍼 포인터
//		nBufLen		: 읽어낼 데이타 크기
// 주) 읽은 테이타의 크기는 nBufLen보다 작을수도 0이 될수도 있다
//-----------------------------------------------------------------------------
syscall long 	FFS_Read (long nFd, byte* pBuffer, long nBufLen);

//-----------------------------------------------------------------------------
//	Description
//		파일에 데이타를 저장한다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success : 0
//		fail	: -1
//	Param
//		nFd			: 파일 핸들
//		pBuffer(in)	: 저장할 데이타 버퍼 포인터
//		nBufLen		: 저장할 데이타 크기
//-----------------------------------------------------------------------------
syscall long	FFS_Write (long nFd, byte* pBuffer, long nBufLen);

//-----------------------------------------------------------------------------
//	Description
//		파일의 끝인지를 알아낸다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 파일 포인터가 파일의 끝이면 TRUE 아니면 FALSE
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//-----------------------------------------------------------------------------
syscall long	FFS_Eof (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		현재 파일 포인터의 위치를 알아낸다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 현재 파일 포이터의 위치
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//-----------------------------------------------------------------------------
syscall long 	FFS_Tell (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		파일의 크기를 알아낸다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 파일의 크기
//		fail	: -1
//	Param
//		pName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall long 	FFS_GetSize (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		파일을 삭제한다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall long 	FFS_Delete (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		파일 버퍼의 내용을 파일에 저장한다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		nFd		: 파일 핸들
//-----------------------------------------------------------------------------
syscall long	FFS_Flush (long nFd);

//-----------------------------------------------------------------------------
//	Description
//		파일이 존재하는지 알아낸다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 파일이 존재하면 TRUE, 아니면 FALSE
//		fail	: -1
//	Param
//		pName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall	long	FFS_Exist (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		파일의 이름을 변경한다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: 파일 이름
//		pDestName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall long	FFS_Rename (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		파일을 복사한다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: 파일 이름
//		pDestName(in)	: 파일 이름
//-----------------------------------------------------------------------------
syscall long	FFS_Copy (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		디렉토리를 만든다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 0
//		fail	: -1 (이 경우 GetApiError()로 아래의 에러코드를 확인해야 한다.)
//			FS_ERR_INTERNAL_ERROR : 시스템에서 디렉토리가 생성되지 않은 경우.
//			FS_ERR_ALREADY_EXIST : 이미 존재하는 디렉토리를 다시 생성할 경우.	
//	Param
//		pName(in)	: 디렉토리 이름
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_CreateDir (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		디렉토리를 삭제한다
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 0
//		fail	: -1 (이 경우 GetApiError()로 아래의 에러코드를 확인해야 한다.)
//			FS_ERR_INTERNAL_ERROR : 시스템에서 디렉토리가 삭제가 실패한 경우.
//			FS_ERR_NO_SUCH_FILE : 존재하지 않는 디렉토리를 지우려고 할 경우.
//	Param
//		pName(in)	: 디렉토리 이름
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_RemoveDir (char* pName);

//-----------------------------------------------------------------------------
//	Description
//		디렉토리내에서 지정된 조건의 파일 핸들과 처음 검색된 파일이름을 리턴한다.
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: File Handle, 검색된 파일명
//		fail	: -1 
//	Param
//		pFilter(in)	: 디렉토리및 파일 이름 (wildcard characters (* and ?))
//		pGetName(out): 검색된 파일명
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_FindFirst (char* pFilter, char* pGetName);

//-----------------------------------------------------------------------------
//	Description
//		디렉토리내에서 지정된 파일 핸들의 조건에 대한 파일이름을 리턴한다.
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: TRUE, 검색된 파일명
//		fail	: FALSE
//	Param
//		Fh(in)	: FS_FindFirst에서 리턴된 File Handle
//		pGetName(out): 검색된 파일명
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_FindNext (long Fh, char* pGetName);

//-----------------------------------------------------------------------------
//	Description
//		지정된 파일 핸들을 닫는다.
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 파일 연산이 이루어진다.
//	Return
//		success	: 1
//		fail	: 0
//
//	Param
//		Fh(in)	: FS_FindFirst에서 리턴된 File Handle
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall long	FFS_FindClose (long Fh);

//------------------------------------------------------------------------------
//현재 가상머신의 실행 디렉토리를 리턴한다.
//------------------------------------------------------------------------------
syscall char*	FFS_GetWorkDir	(void);

//------------------------------------------------------------------------------
//		memory
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		메모리를 복사한다
//	Return
//		없음
//	Param
//		pMem1(in)	: 대상 메모리 포인터
//		pMem2(in)	: 원본 메모리 포인터
//		nLength		: 복사할 메모리 크기
//
//	support : Win CE, M2000
//-----------------------------------------------------------------------------
syscall void	Mem_Cpy (byte* pMem1, byte* pMem2, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		메모리에 일정한 값을 저장한다
//	Return
//		없음
//	Param
//		pMem1(in)	: 메모리 포인터
//		c			: 저장할 값
//		nLength		: 메모리 크기
//-----------------------------------------------------------------------------
syscall void	Mem_Set (byte* pMem1, byte c, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		메모리를 비교한다
//	Return
//		비교할 메모리가 동일하면 0 아니면 몰라....
//	Param
//		pMem1(in)	: 원본 메모리 포인터
//		pMem2(in)	: 대상 메모리 포인터
//		nLength		: 비교할 메모리 크기
//-----------------------------------------------------------------------------
syscall long	Mem_Cmp (byte* pMem1, byte* pMem2, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		메모리를 할당한다
//	Return
//		할당된 메모리의 포인터
//	Param
//		nLength	: 할당할 메모리 크기
//-----------------------------------------------------------------------------
syscall void*	Mem_Alloc (long nLength);

//-----------------------------------------------------------------------------
//	Description
//		할당된 메모리를 없앤다
//	Return
//		없음
//	Param
//		pMem1(in)	: 할당된 메모리 포인터
//-----------------------------------------------------------------------------
syscall void	Mem_Free (byte* pMem1);

//-----------------------------------------------------------------------------
//		ppp
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		전화를 걸어 PPP 접속을 시도한다
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		nMode	: TRUE이면 데이타 모드, FALSE이면 음성 모드
//-----------------------------------------------------------------------------
syscall long	Ppp_Connect (void);

//-----------------------------------------------------------------------------
//	Description
//		PPP연결을 해제한다
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Ppp_Disconnect (void);

//-----------------------------------------------------------------------------
//	Description
//		PPP연결이 되어 있는지를 확인한다
//	Return
//		연결이 되어 있으면 TRUE 그렇지 않으면 FALSE
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Ppp_IsConnected (void);

//-----------------------------------------------------------------------------
//	Description
//		PPP연결이 되어 있는 디바이스의 종류를 알아낸다.
//	Return
//		PPP_DIRECT	: PC와 연결되어 있다(연결을 끊지 않는다.)
//		PPP_MODEM	: Modem과 연결되어 있다(연결을 끊는다.)
//		FAIL		: -1 (연결된 디바이스가 확인되지 않음.) 
//	Param
//		없음
//
//	support : Win CE
//-----------------------------------------------------------------------------
syscall long	Ppp_GetConnectedType (void);

//-----------------------------------------------------------------------------
//		secret
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		주어진 데이터를 암호화한다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pBuf(in)		: 암호화할 데이타
//		nBufSize		: 암호화할 데이타의 크기
//		npMsgSize(out)	: 암호화된 데이타의 크기
//-----------------------------------------------------------------------------
syscall long	Secret_Encrypt (byte *pBuf, long nBufSize, long *npMsgSize);

//-----------------------------------------------------------------------------
//	Description
//		암호화된 데이타를 해제한다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pBuf				: 암호화된 데이타
//		npMsgSize(in/out)	: 암호화된 데이타 및 해제된 데이타의 크기
//-----------------------------------------------------------------------------
syscall long	Secret_Decrypt (byte *pBuf, long *npMsgSize);

//-----------------------------------------------------------------------------
//		socket
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		URL 또는 IP 문자열을 IP 주소로 바꾸어준다 (host order)
//	Return
//		success	: IP 주소
//		fail	: -1
//	Param
//		pHostName(in)	: URL 문자열
//		pIpName(in)		: IP 주소 문자열
//		nTimeOut		: 타임 아웃 (ms)
// 예)	"a.b.c.d"	-> 0x01020304
//		"1.2.3.4"	-> 0x01020304
//-----------------------------------------------------------------------------
syscall quad	Sock_Resolve (char* pHostName, char* pIpName, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		TCP/IP로 연결을 시도한다
//	Return
//		success	: 0
//		fail	: 0xFFFFFFFF
//	Param
//		nHostIp		: IP 주소 (host order)
//		nPort		: 포트 번호
//		nTimeOut	: 타임 아웃 (ms)
//-----------------------------------------------------------------------------
syscall long	Sock_Connect (quad nHostIp, long nPort, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		TCP/IP로 연결을 해제한다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Sock_Close (void);

//-----------------------------------------------------------------------------
//	Description
//		연결된 소켓을 통해 데이타를 보낸다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pBuffer(in)	: 보낼 데이타 버퍼 포인터
//		nLenght		: 보낼 데이타의 크기
//		nTimeOut	: 타임 아웃 (ms)
//-----------------------------------------------------------------------------
syscall long	Sock_Write (byte *pBuffer, long nLength, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		연결된 소켓을 통해 받은 데이타를 읽는다
//	Return
//		success	:  실제 받은 데이타의 크기
//		fail	: -1
//	Param
//		pBuffer(in)	: 받은 데이타를 저장할 버퍼 포인터
//		nMaxLength	: 버퍼의 크기
//		nTimeOut	: 타임 아웃 (ms)
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
//		문자열의 크기를 알아낸다
//	Return
//		문자열의 크기
//	Param
//		pStr1(in)	: 문자열 포인터
//-----------------------------------------------------------------------------
syscall long	Str_Len (char* pStr1);

//-----------------------------------------------------------------------------
//	Description
//		두 문자열을 비교한다
//	Return
//		두 문자열이 동일하면 0 아니면 몰라...
//	Param
//		pStr1(in)	: 문자열 포인터
//		pStr2(in)	: 문자열 포인터
//-----------------------------------------------------------------------------
syscall long	Str_Cmp (char* pStr1, char* pStr2);

//-----------------------------------------------------------------------------
//	Description
//		두 문자열에서 일정 크기만큼만을 비교한다
//	Return
//		일정 크기까지가 동일하면 0 아니면 몰라...
//	Param
//		pStr1(in)	: 문자열 포인터
//		pStr2(in)	: 문자열 포인터
//		nLength		: 메모리 크기
//-----------------------------------------------------------------------------
syscall long	Str_NCmp (char* pStr1, char* pStr2, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		문자열을 복사한다
//	Return
//		없음
//	Param
//		pStr1(in)	: 원본 문자열 포인터
//		pStr2(in)	: 대상 문자열 포인터
//-----------------------------------------------------------------------------
syscall void	Str_Cpy (char* pStr1, char* pStr2);

//-----------------------------------------------------------------------------
//	Description
//		두 문자열을 합친다
//	Return
//		없음
//	Param
//		pStr1(in)	: 원본 문자열 포인터
//		pStr2(in)	: 대상 문자열 포인터
//-----------------------------------------------------------------------------
syscall void	Str_Cat (char* pStr1, char* pStr2);

//-----------------------------------------------------------------------------
//	Description
//		정수값을 문자열로 변환한다
//	Return
//		없음
//	Param
//		nVal		: 변환할 값
//		pStr1(out)	: 저장할 메모리
//		nRadix		: X진수 (2진수, 8진수, 10진수 등)
//-----------------------------------------------------------------------------
syscall void	Str_ItoA (long nVal, char* pStr1, long nRadix);

//-----------------------------------------------------------------------------
//	Description
//		문자열을 정수값으로 변환한다
//	Return
//		변환된 정수값
//	Param
//		pStr1(in)	: 메모리 포인터
//-----------------------------------------------------------------------------
syscall long	Str_AtoI (char* pStr1);

//-----------------------------------------------------------------------------
//	Description
//		문자열을 변환하여 버퍼에 저장한다
//	Return
//		없음
//	Param
//		pStr1(in)	: 메모리 포인터
//		pStr2(in)	: 메모리 포인터
//		nArg1		: 인자
//		nArg2		: 인자
//		nArg3		: 인자
//-----------------------------------------------------------------------------
syscall void	Str_Printf (char* pStr1, char* pStr2, quad nArg1, quad nArg2, quad nArg3);

//-----------------------------------------------------------------------------
//	Description
//		문자열을 지정된 포맷으로 변환한다.
//
//	Return
//		없음
//	Param
//		nFlag(in)	: 변환되는 포맷을 지정하는 플래그.
//		- STRCHG_CONV_ZERO_TO_SPACE : 숫자 왼쪽에 위치한 0을 공백으로 바꾼다. (00001234 -> ____1234)
//		- STRCHG_DEL_SPACE_TO_RIGHT : 숫자 왼쪽에 위치한 공백을 오른쪽으로 지운다.(+___1234->___+1234)
//		- STRCHG_DEL_RIGHT_SPACE : 문자열 오른쪽에 있는 공백을 지운다.  (abcd____ -> abcd)
//		- STRCHG_DEL_SPACE_TO_LEFT : 숫자 왼쪽에 위치한 공백을 왼쪽으로 지운다. (+___1234->+1234)
//		- STRCHG_DEL_ALL_SPACE : 문자열에 포함된 모든 공백을 지우고 왼쪽으로 정렬시킨다.
//		- STRCHG_INS_COMMA : 숫자 문자열로 가정하고 3자리마다 ,를 찍고 왼쪽의 '0'은 공백으로 만든다.
//		- STRCHG_DEL_NONDIGIT : '0' ~ '9' 가 아닌 문자는 모두 지우고 왼쪽으로 모은다.
//		- STRCHG_DEL_NONDIGITSIGN : '0' ~ '9', '-', '+' 가 아닌 문자는 모두 지우고 왼쪽으로 모은다.
//-----------------------------------------------------------------------------
syscall void	Str_Chg (char* pStr1, long nFlag);

//------------------------------------------------------------------------------
//		time
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		년,월,일을 알아낸다
//	Return
//		2001년 1월 1일 -> 20010101
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Time_GetDate (void);

//-----------------------------------------------------------------------------
//	Description
//		년을 알아낸다
//	Return
//		2001년 -> 2001
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Time_GetYear (void);

//-----------------------------------------------------------------------------
//	Description
//		월을 알아낸다
//	Return
//		1월 -> 1
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Time_GetMonth (void);

//-----------------------------------------------------------------------------
//	Description
//		일을 알아낸다
//	Return
//		1일 -> 1
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Time_GetDay (void);

//-----------------------------------------------------------------------------
//	Description
//		주를 알아낸다
//	Return
//		일요일 -> 0, 월요일 -> 1
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Time_GetWeek (void);

//-----------------------------------------------------------------------------
//	Description
//		시간, 분, 초를 알아낸다
//	Return
//		23시 30분 30초 -> 233030
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Time_GetTime (void);

//-----------------------------------------------------------------------------
//	Description
//		시간을 알아낸다
//	Return
//		23시 -> 23
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Time_GetHour (void);

//-----------------------------------------------------------------------------
//	Description
//		분을 알아낸다
//	Return
//		23분 -> 23
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Time_GetMinute (void);

//-----------------------------------------------------------------------------
//	Description
//		초를 알아낸다
//	Return
//		23초 -> 23
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Time_GetSecond (void);

//-----------------------------------------------------------------------------
//	Description
//		박범성 팀장한테 물어보시오
//-----------------------------------------------------------------------------
syscall long	Time_NumberOfDates (long nDateFrom, long nDateTo);

//-----------------------------------------------------------------------------
//	Description
//		박범성 팀장한테 물어보시오
//-----------------------------------------------------------------------------
syscall long	Time_ValidateDate (long nDate);

//-----------------------------------------------------------------------------
//	Description
//		박범성 팀장한테 물어보시오
//-----------------------------------------------------------------------------
syscall	long	Time_DateUpDown (quad Date, long DateDigit);

//------------------------------------------------------------------------------
//		timer
//------------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//	Description
//		시스템을 타임 만큼 sleep한다.
//	Return
//		없음
//	Param
//		t	: sleep 단위 (10ms)
//-----------------------------------------------------------------------------
syscall void	VmSleep (long t);

//-----------------------------------------------------------------------------
//	Description
//		타이머를 세팅한다
//	Return
//		success	: 타이머 아이디
//		fail	: -1
//	Param
//		nInterval	: 타이머 간격 (ms)
//		nCount		: 타이머가 작동할 횟수 (0이면 무한대)
//-----------------------------------------------------------------------------
syscall long	Timer_Set (long nInterval, long nCount);

//-----------------------------------------------------------------------------
//	Description
//		타이머를 없앤다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		nId		: 없앨 타이머 아이디
//-----------------------------------------------------------------------------
syscall long	Timer_Kill (long nId);

//------------------------------------------------------------------------------
//		telephony api
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		자신의 전화 번호를 알아낸다
//	Return
//		없음
//	Param
//		pPhoneNum(out)	: 전화 번호를 저장할 버퍼
//		nType			: 0이면 문자열 전화 번호, 0이 아니면 정수형 전화 번호
// 예)
//		0162345678	-> type이 0일 경우 "0162345678"
//					   type이 0이 아닐 경우 6-0234-5678
//		01612345678	-> type이 0일 경우 "01612345678"
//					   type이 0이 아닐 경우 6-1234-5678
//-----------------------------------------------------------------------------
syscall void	Tapi_GetPhoneNum (byte* pPhoneNum, long nType);

//-----------------------------------------------------------------------------
//	Description
//		SMS 메시지를 보낸다. deprecated. 사용하지 말 것
//	Return
//		없음
//	Param
//		pDst(in)		: 상대 전화 번호
//		pSrc(in)		: 자기 전화 번호
//		pContents(in)	: 보낼 내용을 저장한 버퍼 포인터
//		nLenght(in)	: 보낼 내용 크기
//-----------------------------------------------------------------------------
syscall void	Tapi_SendSms (byte* pDst, byte* pSrc, byte* pContents, long nLength);

/////////////////////////////////////////////////////////////
//	Description
//		SMS를 보낸다.
//	Parameters
//		destPhone : 메시지를 받을 전화번호. 숫자로만 이루어져야 한다.기타 문자는 안됨.
//		srcPhone : 응답을 받을 전화번호. null일 경우 현재 단말기 전화 번호. 숫자로만 구성
//		content : 메시지 내용. 최대 길이 80bytes
//		level :   <= 10 보통, <= 20 빠른, 20 < 긴급
//	Return
//		성공 : 0
//		실패 : 0보다 작은 값. 에러코드는 아래와 같다.
//				-1 : 메시지 받을 전화 번호가 잘못되었다.
//				-2 : 응답을 받을 전화번호가 잘못되었다.
//				-3 : 내용이 비었음
//				-4 : 내용이 너무 길다
//				-5 : 전송 실패
syscall unsigned long	Tapi_SendSmsEx(char* destPhone, char* srcPhone, char* content, int level);


//-----------------------------------------------------------------------------
//	Description
//		전화를 건다
//	Return
//		없음
//	Param
//		pPhoneNumber(out)	: 상대 전화 번호
//-----------------------------------------------------------------------------
syscall void	Tapi_MakeCall (byte* pPhoneNumber);

//-----------------------------------------------------------------------------
//	Description
//		전화를 끊는다
//	Return
//		없음
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall void	Tapi_CloseCall (void);

//-----------------------------------------------------------------------------
//	Description
//		소리를 낸다
//	Return
//		없음
//	Param
//		nSound	: 소리의 타입
//			SOUND_CLICK		: 버튼 등을 눌렀을 때 나는 소리
//			SOUND_WARNING	: 경고음
//			SOUND_ERROR		: 에러음
//-----------------------------------------------------------------------------
syscall void	Tapi_PlaySound (long nSound);

//-----------------------------------------------------------------------------
//	Description
//		플립의 기능을 해제한다
//	Return
//		없음
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall void	Tapi_SetFlipDisable (void);

//-----------------------------------------------------------------------------
//	Description
//		플립의 기능을 가능하게 한다
//	Return
//		없음
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall void	Tapi_SetFlipEnable (void);

//-----------------------------------------------------------------------------
//		uart
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		직렬 포트를 연다
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		nBaudRate	: 전송 속도
//		nDataBit	: 데이타 비트 크기
//		nParityBit	: 패러티 비트 크기
//		nStopBit	: 정지 비트 크기
//-----------------------------------------------------------------------------
syscall long	Uart_Open (long nPortNum, long nBaudRate, long nDataBit, long nParityBit, long nStopBit);
//-----------------------------------------------------------------------------
//	Description
//		직렬 포트를 닫는다
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long	Uart_Close (void);

//-----------------------------------------------------------------------------
//	Description
//		직렬 포트를 통해 데이타를 전송한다
//	Return
//		success	: 0
//		fail	: -1 
//	Param
//		pBuffer(out)	: 전송할 데이타 버퍼
//		nLength 	: 데이타 크기
//-----------------------------------------------------------------------------
syscall long	Uart_Write (byte* pBuffer, long nLength);

//-----------------------------------------------------------------------------
//	Description
//		직렬 포트를 통해 받은 데이타를 읽는다
//	Return
//		success	: 읽은 데이타 크기
//		fail	: -1 
//	Param
//		pBuffer(in)	: 받은 데이타를 저장할 버퍼
//		nLength 	: 버퍼의 최대 크기
//-----------------------------------------------------------------------------
syscall long	Uart_Read (byte* pBuffer, long nMaxLength);

//------------------------------------------------------------------------------
//		print and error
//------------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//	Description
//		문자열을 출력한다
//	Return
//		없음
//	Param
//		pStr(out)	: 문자열
//		nArg1 		: 인자
//		nArg2 		: 인자
//		nArg3 		: 인자
//-----------------------------------------------------------------------------
syscall void 	Print (char* pStr, quad nArg1, quad nArg2, quad nArg3);

//-----------------------------------------------------------------------------
//	Description
//		메모리의 내용을 출력한다
//	Return
//		없음
//	Param
//		pPtr(out)	: 메모리 시작 번지
//		nLength		: 메모리 크기
//		nMode 		: DUMP_ASCII 모드일 경우 문자열로, DUMP_HEX 모드일 경우 헥사값으로 출력
//-----------------------------------------------------------------------------
syscall void 	Dump (byte* pPtr, long nLength, long nMode);

//-----------------------------------------------------------------------------
//	Description
//		가장 최근의 에러 코드를 알아낸다
//	Return
//		에러코드
//	Param
//		없음
//-----------------------------------------------------------------------------
syscall long 	GetApiError (void);

//-----------------------------------------------------------------------------
//	Description
//		파일을 압축한다 lzss 이용
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: 압축할 파일 이름
//		pDestName(in)	: 압축된 결과가 저장될 파일 이름
//-----------------------------------------------------------------------------
syscall long	Compress (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		압축된 파일을 해제한다 lzss 이용
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: 압축된 파일 이름
//		pDestName(in)	: 압축이 풀린 결과가 저장될 파일 이름
//-----------------------------------------------------------------------------
syscall long	Uncompress (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		압축된 파일을 해제한다 lzss 이용
//		플래시를 지원하는 WINCE 디바이스에서 플래시 영역 밑에서 압축을 해제한다.
//		AM(Upgrade.mc)에서 압축풀때만을 고려한 것이다.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: 압축된 파일 이름
//		pDestName(in)	: 압축이 풀린 결과가 저장될 파일 이름
//-----------------------------------------------------------------------------
syscall long	FFS_Uncompress (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		파일을 압축한다 Zip 알고리즘 이용
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: 압축된 파일 이름
//		pDestName(in)	: 압축이 풀린 결과가 저장될 파일 이름
//-----------------------------------------------------------------------------
syscall long	Compress_Zip(char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		압축된 파일을 해제한다 zip 이용
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		pSrcName(in)	: 압축된 파일 이름
//		pDestName(in)	: 압축이 풀린 결과가 저장될 파일 이름
//-----------------------------------------------------------------------------
syscall long	Uncompress_Zip (char* pSrcName, char* pDestName);

//-----------------------------------------------------------------------------
//	Description
//		외부 프로그램을 실행한다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		szCmdName(in)	: 커맨드 라인 명령어
//		bWait			: 사용되지 않음
//		dwTimeout		: 사용되지 않음
//-----------------------------------------------------------------------------
syscall long	RunApp (char* szCmd, char* scArg);

//-----------------------------------------------------------------------------
//	Description
//		다른 어플리케이션을 실행한다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		nAppId	: 어플리케이션 ID
//-----------------------------------------------------------------------------
syscall long	VM_AppStart (long nAppId);

//-----------------------------------------------------------------------------
//	Description
//		실행 중인 어플리케이션을 종료하고 AM으로 돌아간다
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	VM_AppEnd (void);

//-----------------------------------------------------------------------------
//	Description
//		AM을 종료한다. 즉 mpop을 종료한다.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	VM_AmEnd (void);

//-----------------------------------------------------------------------------
//	Description
//		Application의 헤더 정보를 읽어온다.
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
//		서명 보드의 이미지를 가져온다.
//	Return
//		success	: 1
//		cancel	: 0
//		fail	: -1
//	Param
//		Width			: 폭
//		Height			: 너비
//		pBufSign(out)	: 데이타
//-----------------------------------------------------------------------------
syscall long	GetSignImg (long Width, long Height, char* pBufSign);

//-----------------------------------------------------------------------------
//	Description
//		서명 보드의 이미지를 가져온다 (option 기능 추가).
//	Return
//		success	: 1
//		cancel	: 0
//		fail	: -1
//		empty	: 2
//	Param
//		Width			: 폭
//		Height			: 너비
//		pBufSign(out)	: 데이타
//		option			: 사인보드 옵션 (0, 1)
//-----------------------------------------------------------------------------
//option
#define SIGN_OPT_NONE		0	//기존에 사용하던 사인보드
#define SIGN_OPT_CHECK		1	//옵션에 따라 EMPTY 결과를 리턴 함.

#define SIGN_RET_CANCEL		0
#define SIGN_RET_SUCCESS	1
#define SIGN_RET_EMPTY		2
#define SIGN_RET_FAIL		-1

syscall long	GetSignImgTitleWithOpt (long Width, long Height, char* pBufSign, char* title, long option);

//-----------------------------------------------------------------------------
//	Description
//		mpop 3.0 프로토콜 관련 API
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
//		무선 업그레이드와 무선 설치에 사용되는 API
//		일반 사용자는 사용하지 말것 !!!!
//	Return
//		success	:
//		fail	:
//	Param
//-----------------------------------------------------------------------------

// dkjung 2003-04-11
// 서버상의 부하발생으로 인해서 일시적으로 서비스를 중단하는 경우 처리.
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
//		카드리더가 읽은 데이터를 가져온다
//	Return
//		success	: 읽은 문자열의 개수
//		fail	: -1
//	Param
//		pBufSign(out)	: 데이타
//-----------------------------------------------------------------------------
//syscall long	Barcode_Init (void);
//syscall long	Barcode_Exit (void);
//syscall long	Barcode_Read (char* ptr);

//-----------------------------------------------------------------------------
//	Description
//		스풀을 비운다
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
//		인쇄할 데이타를 스풀로 보낸다
//	Param
//		strData(in)	: 문자열 데이타
//		mode		: 카드 리더 매뉴얼 참조
//	Return
//		실제 보내진 데이타의 크기
//	Param
//-----------------------------------------------------------------------------
syscall long	Printer_SendToSpool (char* strData, long mode);

//-----------------------------------------------------------------------------
//	Description
//		스풀의 데이타를 인쇄한다
//	Param
//		flag	: FALSE이면 인쇄한 후 스풀 내용 삭제 TRUE이면 내용 남아 있음
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	Printer_PrintData (long flag);

//-----------------------------------------------------------------------------
//	Description
//		읽은 데이타를 가져온다
//	Param
//		strNum(out)		: 카드 번호
//		strYear(out)	: 유효 기간 년
//		strMonth(out)	: 유효 기간 월
//		strType(out)	: 카드 타입
//		nTimeOut		: 타임 아웃 (초 단위)
//	Return
//		success	: 0
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	CardReader_Read (char* strNum, char* strYear, char* strMonth, char* strType, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		지정된 시간동안 아무런 이벤트가 없으면 어플리케이션을 종료한다.
//	Param
//		quad qTimeOut   : 타임 아웃 (분 단위)
//	Return
//	Param
//-----------------------------------------------------------------------------
syscall void	ExitIdleDuring (quad qTimeOut);


//-----------------------------------------------------------------------------
//	Description
//		블루버드단말기의 카드리더기에서 nTrack데이터를 가져온다.
//		변환하지 않은 형태이다. 
//	Param
//		strRawData(out)	: 읽은 데이터
//		nTrack(in)		: 읽을 트랙
//		nTimeOut(in)	: 타임 아웃 (초 단위)
//	Return
//		success	: 읽은 데이터의 Length
//		fail	: -1
//	Param
//-----------------------------------------------------------------------------
syscall long	CardReader_GetRawData(char* strRawData, long nTrack, long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		블루버드단말기의 카드리더기에서 2번째 Track에서 데이터를 가져온다.
//		자주 사용되는 정보를 파싱한다.
//	Param
//		strNum(out)			: 카드번호
//		strValidDate(out)	: 유효기간 ("YYMM"형태)
//		nTimeOut(in)		: 타임 아웃 (초 단위)
//	Return
//		success	: 0
//		fail	: -1
//	Param

//-----------------------------------------------------------------------------
syscall long	CardReader_GetParsedData(char* strNum, char* strValidDate, long nTimeOut);


//-----------------------------------------------------------------------------
//	Description
//		Standard Input Panel을 나타나게 하거나 사라지게 한다.
//	Param
//		BOOL bFlag   : SIP를 동작시키는 플래그.
//			TRUE	: SIP를 나타나게 한다.
//			FALSE	: SIP를 사라지게 한다.
//	Return
//		success	: 0
//		fail	: -1
//
//	support : Win CE
//-----------------------------------------------------------------------------
syscall long	ShowSip (BOOL bFlag);

//-----------------------------------------------------------------------------
//	Description
//		Battery의 현재 상태를 읽어 온다.
//
//	Param
//		PSYSTEM_POWER_STATUS pSps   : Battery의 상태를 가진 구조체.
//									  구조체의 세부내역 Win CE 매뉴얼 참조.
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
//		카드 모듈을 초기화 한다.
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
//		카드 결제 정보를 셋팅한다.
//
//	Param
//		s : 필드 이름
//		t : 필드 값
//	Return
//		success	: 1
//		fail	: 0
//
//	support : POZ
//-----------------------------------------------------------------------------
syscall int CardPay_SetField(char* s, char* t);

//-----------------------------------------------------------------------------
//	Description
//		카드 결제를 요청한다. 호출하기 전에 반드시 PPP가 연결되어 있어야 한다.
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
//		카드 결제 정보를 가져온다.
//
//	Param
//		s : 필드 이름
//		t : 값을 가져올 버퍼
//	Return
//		success	: 1
//		fail	: 0
//
//	support : POZ
//-----------------------------------------------------------------------------
syscall int CardPay_GetField(char* s, char* t);

//-----------------------------------------------------------------------------
//	Description
//		카드 결제가 끝이 나면 리소스를 놓아주는 일을 한다.
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
//		System Time을 주어진 날짜와 시간으로 맞춘다.
//	Param 
//		Date는 YYYYMMDD형식의 long이고, 
//		Time은 HHMMSS형식의 long이다.
//		예) 2003년 5월 4일, 10시 10분 10초에 맞추려고 한다.
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
//		프린터의 serial port를 연다. 프린터와 카드리더는 같은 포트를 사용하므로,
//		동시에 사용할 수 없다. 프린터는 배터리를 많이 사용하므로 필요한 경우에만
//		연다.
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
//		프린터 농도를 설정한다. 
//	Param : 0 - 8 사이 값을 가진다. 0 = 60%, 4 = 100%, 8 = 140%, default 4.
//	Return
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall void	Printer_SetDensity(unsigned long density);


//-----------------------------------------------------------------------------
//	Description
//		프린터 라인간격을 설정한다.
//	Param : 0 - 255 사이 값을 가진다. default 24 = 1/6 inch.
//	Return
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall void	Printer_SetLineSpacing(unsigned long lineSpacing);


//-----------------------------------------------------------------------------
//	Description
//		프린터를 초기화한다. Printer_Print(..)를 부르기전에 한번 불려져야한다.
//		이것이 불려진 후, 라인간격과 농도가 적용된다.
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
//		주어진 옵션에 따라서 프린트한다.
//	Param 
//		string : 프린트할 텍스트
//		option : 프린트 옵션 : 가령 PRINT_EMPHASIZE | PRINT_DOUBLEWIDTH 
//				 libsysdef.h 참고.
//	Return
//		success	: 0
//		fail	: -1 : serial communication error
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall long	Printer_Print(char* string, unsigned long option);


//-----------------------------------------------------------------------------
//	Description
//		프린트가 끝날 때까지 기다린다.
//	Param 
//	Return
//		success	: 0
//		fail	: 1 : 용지 부족
//				 -1 : serial communication error
//
//	support : BLUEBIRD
//-----------------------------------------------------------------------------
syscall long	Printer_WaitUntilPrintEnd(void);


//-----------------------------------------------------------------------------
//	Description
//		프린터의 serial port를 닫는다.
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
//		바코드 스캐너를 동작 시킨다.
//	Param
//	Return
//		success	: 1
//		fail	: -1(스캐너가 없다.)
//				  -2(스캐닝 중)
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
//		이벤트 큐에서 메시지를 가져온다.
//		MSG_EXIT이 나오는 경우 이 이벤트를 적절히 처리하고 같은 카드 안에서 
//		더 이상 Handler_GetMessage()나 Handler_PeekMessage()를 호출해서는 안 된다.
//	Param
//		pMsg : message를 받아온다.
//	Return
//		success	: 0
//		fail	: -1
//
//-----------------------------------------------------------------------------
syscall long	Handler_GetMessage(HandlerMsg* pMsg);

//-----------------------------------------------------------------------------
//	Description
//		이벤트 큐에서 메시지를 가져오지만 제거하지는 않는다.
//	Param
//		pMsg : message를 받아온다.
//	Return
//		success	: 0
//		fail	: -1
//
//-----------------------------------------------------------------------------
syscall long	Handler_PeekMessage(HandlerMsg* pMsg);

//-----------------------------------------------------------------------------
//	Description
//		이벤트 큐에서 메시지를 넣는다.
//	Param
//		pMsg : 집어 넣을 메시지
//	Return
//		success	: 0
//		fail	: -1
//
//-----------------------------------------------------------------------------
syscall long	Handler_PostMessage(HandlerMsg* pMsg);

typedef void* ShareCardHandle;
//-----------------------------------------------------------------------------
//	Description
//		공유 카드를 로드 한다.
//	Param
//		cardName : 로드할 공유 카드 이름
//	Return
//		fail	: 0. 카드가 존재하지않거나 공유 카드가 아닌 경우.
//		success	: 로드된 카드의 main() 함수 주소
//
//-----------------------------------------------------------------------------
syscall ShareCardHandle	ShareCard_Load(char* cardName);

//-----------------------------------------------------------------------------
//	Description
//		공유 카드를 언로드 한다. 
//		카드는 ShareCard_Load()만큼 ShareCard_Unload()가 호출 되어야 메모리에서 사라진다.
//	Param
//		cardName : 언로드할 공유 카드 이름
//	Return
//		none
//
//-----------------------------------------------------------------------------
syscall void	ShareCard_Unload(char* cardName);

typedef long (*ShareCardMainFuncType)(long, long, long);

#define GetProcAddress(X,Y) (((ShareCardMainFuncType)(X))((long) Y, 0, 0))

//-----------------------------------------------------------------------------
//	Description
//		타이틀을 변경 가능한 서명 보드의 이미지를 가져온다.
//	Return
//		success	: 0
//		fail	: -1
//	Param
//		Width			: 폭
//		Height			: 너비
//		pBufSign(out)	: 데이타
//		title			: 사인 보드 타이틀
//-----------------------------------------------------------------------------
syscall long	GetSignImgTitle (long Width, long Height, char* pBufSign, char* title);

//-----------------------------------------------------------------------------
//	Description
//		파일에 특정 오프레이션을 할 수 있게 해준다.
//		일반적으로 확장자에 등록된 어플리케이션을 실행시켜서 보여주거나 편집하는 일을 한다
//		WinCE만 지원한다.
//	Return
//		success	: 1
//		fail	: 0
//	Param
//		operation		: 실행할 오퍼레이션 
//							"open" - 파일을 열어서 보여준다. 실행 파일이면 실행이 된다.
//							"edit" - 파일을 편집할수 있게 해준다.
//							"explore" - 폴더를 탐색할수 있게 해준다.
//							"print" - 출력 해준다
//		file			: 대상 파일
//		parameter		: 해당 어플리케이션에 넘겨줄 패러미터
//		dir				: 실행될 위치
//	example
//		VM_ShellExecute("open", "file://index.html", 0, 0);//IE에 해당 파일을 연다
//		VM_ShellExecute("open", "http://www.mcnc.co.kr/index.html", 0, 0);//IE에 해당 URL을 연다
//-----------------------------------------------------------------------------
syscall long	VM_ShellExecute (char* operation, char* file, char* parameter, char* dir);

/////////////////////////////////////////////////////////////////////////////////
//	Description
//		Windows와 WinC만 지원
//		UART에 입력이 있으면 이벤트를 발생키게 한다.
//		입력이 있으면 지정된 event와 wParam에 읽은 한 바이트를 넣어준다.
//		스캐너와 같은 저속 장치에 적합하고 고속 입력이 있을 경우 사용은 적합하지 않다
//	paramter 
//		event : 입력이 있을 경우 발생시킬 이벤트 MSG_USER이상이어야 한다
//	return
//		0 : success
//		-1 : 포트가 오픈되지 않앗다.
//		-2 : 잘못된 이벤트 
//		-3 : internal error
syscall long Uart_SetInputEvent(long event);

//////////////////////////////////////////////////////////////
//	Description
//		Card Reader를 오픈한다. 현재 BlueBird에서만 지원 
//		블루 버드의 프린터와 동시 사용 불가
//	return
//		1 : 성공
//		0 : 실패
syscall long	CardReader_Open(char* pszDeviceName);

//////////////////////////////////////////////////////////////
//	Description
//		Card Reader를 닫는다.
//	return
//		1 : 성공
//		0 : 실패
syscall long	CardReader_Close(void);

///////////////////////////////////////////////////////////////////////
//	Description
//		카드 리더에서 읽혀진 값을 가져온다.
//	Parameters
//		track : track 번호
//		buffer : 데이타를 읽어 올 버퍼
//		buf_len : 버퍼 길이
//	return
//		-1 : 실패
//		>0 : 읽은 길이
syscall long	CardReader_ReadRawData(long track, char* buffer, int buf_len);

////////////////////////////////////////////////////////////////////
//	Description
//		카드 리더에서 읽혀진 트랙을 가져온다
//	return
//		데이타가 있는 트랙
//		0x01(TRACK1), 0x02(TRACK3), 0x04(TRACK3)의 조합으로 구성 
syscall long	CardReader_GetReadTrack(void);

////////////////////////////////////////////////////////////////////
//	Description
//		카드 리더에 카드가 읽혀지면 발생시킬 이벤트를 지정한다
//		wParam에 읽혀진 데이타 문자열 포인터를 넣어준다.
//	Paramter 
//		event : 카드가 읽혀 졌을 때 발생시킬 이벤트 WM_USER보다 커야 한다.
//	return
//		0 : 성공
//		-1 : not open
//		-2 : invalid event
//		-3 : internal error
syscall long	CardReader_StartEvent(long event);

/////////////////////////////////////////////////////////////////////////
//	Description
//		더이상 카드 리더 이벤트가 발생하지 않게 한다.
//	return
//		1 : 성공
//		0 : 실패
syscall long	CardReader_StopEvent(void);

//-----------------------------------------------------------------
//	MC-6000S 블루투스 프린터
//-----------------------------------------------------------------

///////////////////////////////////////////////////////////////////
//	Description
//		프린터를 초기화 한다.
//	Parameters
//		sPortName : 포트 이름 MC-6000s에서는 "BSP2:"
//		BuadRate : 보드 레이트. MC-6000에서는 9600
//		Protocol : 프로토콜 사용여부, 반드시 0
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
//		프린터를 닫는다.
//	Return
//		Success : TRUE
//		Fail : FALSE
syscall long BT_Close_Printer(void);

#define BT_Close_Card() BT_Close_Printer()

////////////////////////////////////////////////////////////////
//	Description
//		프린터에 제어 명령어를 보낸다.
//		예) {0x1b,0x20,0x00} => Line Space
//	Parameters
//		Cmd : 명령어
//		Length : 길이
//	Return
//		SUCCESS : 보낸 명령어 길이
//		FAIL	: 0 보다 작은 값
syscall long BT_Control_Command(char *Cmd, int Length); 

///////////////////////////////////////////////////////////////////
//	Description
//		프린터 스풀에 데이타를 보낸다
//	Parameters
//		strData : 출력할 문자열
//		FontValue : 출력 폰트 
//					0 - Normal
//					1 - Double Height
//					2 - Double Width
//					3 - Double Height and Width
//		Empahsis : 강조 TRUE면 강조, FALSE면 보통
//	Return
//		Success : 저장된 바이트 수
//		Fail	: -1
syscall long BT_Save_Spool(char* strData, long FontValue, long Emphasis);					


///////////////////////////////////////////////////////////////////////
//	Description
//		스풀 내용을 프린터로 출력한다.
//	Parameters
//		Delete_Spool : 스풀 내용을 삭제할지를 지정 
//	Return
//		성공하면 TRUE, 실패하면 FALSE
syscall long BT_Print_Spool(long Delete_Spool);

///////////////////////////////////////////////////////////////////////////
//	Description
//		Spool내용 삭제 
syscall void BT_Clear_Spool(void);

////////////////////////////////////////////////////////////////////////////
//	Description
//		카드 리더를 동작 시킨다.
//		카드 데이타는 지정된 이벤트의 wParam에 문자열로 들어오고 포맷은 아래와 같다.
//		BNNNNNNNNNNNNNNNNBYYMM(N:카드번호, Y:유효년, M:유효달)
//	Parameters
//		evet : 카드를 읽었을때 발생하는 이벤트
syscall void BT_Card_Read(long evt);

//////////////////////////////////////////////////////////////////////////////
//	Description
//		카드 리더 동작을 중지 시킨다.
syscall void BT_Card_Read_Cancel(void);

//-----------------------------------------------------------------------------
//	Description
//		사진 보드를 실행하고 사진 파일을 저장한다.
//	Return
//		성공 : 1, 취소 : 0, 지원하지 않는 모드 : -1, 파일명 에러: -2
//	Parameters
//		capturesize	: 저장할 파일 크기
//
//		pathstd	: 저장할 패스 기준. 
//			  1: 메모리 영역에 저장 ( 방전 혹은 하드리셋시 지워짐 )
//			  2: 플래쉬 영역이 있을 경우 플래쉬 영역에 저장
//		file	: 패스를 포함한 파일명
//-----------------------------------------------------------------------------

syscall long ShootPhoto ( long capturesize, long pathstd, char *file );


//-----------------------------------------------------------------------------
//	Description
//		JPG나 BMP 이미지를 mPOP 용 이미지로 변환한다.
//	Return
//		성공 : 0, 실패 : -1
//	Parameters
//		ImageFormat	: BMP : 1, JPG : 2, PNG : 3
//		nDestWidth		: 변경할 이미지 파일의 가로 사이즈
//		nDestHeight		: 변경할 이미지 파일의 세로 사이즈
//		pDestImg			: 변경할 이미지 파일명
//		nTimeout			: 변경하는데 소요되는 최대시간( msec )
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
//		한PDA에서 여러 카드프로그램에 서로 메모리를 공유할 경우 사용한다.
//		VM단에서 메모리를 선언함.
//	Return
//		
//	Parameters
//-----------------------------------------------------------------------------
syscall	void*	VM_MemAlloc(long nLength);
syscall	void*	VM_GetMem(void);
syscall	void	VM_MemFree(void);


//-----------------------------------------------------------------------------
//	Description
//		바코드 초기화가기, 기본으로 6번 포트를 사용하여 바코드를 OPEN함(M3Plus용)
//							M470. KDC 스캐너 : 6번포트 고정
//	Return
//		성공 : 0, 실패 : -1
//	Parameters
//		
//-----------------------------------------------------------------------------
syscall	long	Barcode_Init (void);

//-----------------------------------------------------------------------------
//	Description
//		바코드 닫기(M3Plus, M470)
//	Return
//		성공 : 0, 실패 : -1
//	Parameters
//		
//-----------------------------------------------------------------------------
syscall	long	Barcode_Exit (void);

//-----------------------------------------------------------------------------
//	Description
//		바코드 값 읽기(M3Plus, M470)
//	Return
//		성공 : 0, 실패 : -1
//	Parameters
//		char *ptr : ptr은 ptr[128] 배열의 포인터임.
//					** 반드시 128 배열의 포인터로 선언함.
//-----------------------------------------------------------------------------
syscall	long	Barcode_Read (char* ptr);

//-----------------------------------------------------------------------------
//	Module Name : Barcode_InitEx
//	Description
//		바코드 초기화가기, 초기화값을 입력한다.
//	Return
//		성공 : 0, 실패 : -1
//	Parameters	int port : 포트번호( 8 )
//				int baud : Baud( 57600 )
//				char *sProt : 포트 스트링( "COM8:)
//-----------------------------------------------------------------------------
syscall	long	Barcode_InitEx(int port, int baud, char *sPort);

//-----------------------------------------------------------------------------
//	Module Name : Barcode_GetStatus
//	Description
//		바코드의 상태를 읽음.. 꺼짐/ 켜짐(
//	Return
//		성공 : 0, 실패 : -1
//	Parameters	
//-----------------------------------------------------------------------------
syscall	long	Barcode_GetStatus(void);

//-----------------------------------------------------------------------------
//	Module Name : Barcode_SendCommand
//	Description
//		바코드에 직접 컴멘드를 보냄(M470, KDC바코드에 사용됨)
//	Return
//		성공 : 0, 실패 : -1
//	Parameters	
//-----------------------------------------------------------------------------
syscall	long	Barcode_SendCommand(char* cmd);

//-----------------------------------------------------------------------------
//	Module Name : Barcode_SendCommandGetString
//	Description
//		바코드에 직접 컴멘드를 보내서 문자열 결과를 얻어옴.(M470, KDC바코드에 사용됨)
//	Return
//		성공 : 0, 실패 : -1
//	Parameters	
//-----------------------------------------------------------------------------
syscall	long Barcode_SendCommandGetString( char* cmd, char *bfr );

//-----------------------------------------------------------------------------
//	Description
//		현재 설정된 키 모드 알아 내기.
//	Return
//		성공 : 키 모드 값 (0:영문, 1:한글, 2:숫자)
//	Parameters
//-----------------------------------------------------------------------------
#define		KEYMODE_ENGLISH			0			//	영문입력 가능
#define		KEYMODE_HANGUL			1			//	한글입력 가능
#define		KEYMODE_NUMBER			2			//	숫자입력 가능

syscall	long GetKeyMode (void);

//-----------------------------------------------------------------------------
//	Description
//		키 모드를 원하는 상태로 전환 한다.
//	Return
//		성공 : 0, 실패 : -1
//	Parameters
//      nMode : 키 모드 값 (0:영문, 1:한글, 2:숫자)
//
//-----------------------------------------------------------------------------
syscall	long SetKeyMode ( long nMode );


#define		BTH_POWER_OFF			0 //(전원을 OFF 시킴)전원이 꺼지거나, 장치가 없음.
#define		BTH_CONNECTABLE			1 //(전원을 ON 시킴)정상인 상태
#define		BTH_DISCOVERABLE		2 //(여기서 사용안함)정상이고, 연결이 가능한 상태

#define		BTH_REG_SEARCH_FAIL		-1 //레지스트리 조회 실패.
#define		BTH_REG_REG_FAIL		-2 //레지스트리 등록 실패.
#define		BTH_NOT_REG_DEVICE		-3 //등록된 단말기가 존재하지 않음.
#define		BTH_NOT_REG_PORT		-4 //단말기는 등록되었으나, 포트가 등록되지 않음.
#define		BTH_ALREADY_REG_DEVICE	-5 //이미 등록된 단말기임.
#define		BTH_NOT_SUPPORT_DEVICE	-10 //지원하는 단말기가 아님.

//-----------------------------------------------------------------------------
//	Module Name : Bth_GetMode
//	Description
//		블루투스 상태를 조회함.
//	Return
//		성공 : 0 
//		실패 : -1
//			-10(BTH_NOT_SUPPORT_DEVICE) : 지원하는 단말기가 아님.
//	Parameters
//		unsigned long * pdwMode : 상태값을 저장할 pdwMode.
//				0 (BTH_POWER_OFF) : 전원이 꺼지거나, 장치가 없음.
//				1 (BTH_CONNECTABLE) : 정상인 상태
//				2 (BTH_DISCOVERABLE) : 정상이고, 연결이 가능한 상태
//-----------------------------------------------------------------------------
syscall	long	Bth_GetMode(unsigned long* pdwMode);

//-----------------------------------------------------------------------------
//	Module Name : Bth_SetMode
//	Description
//		블루투스를 해당 상태로 변경함(On / Off).
//	Return
//		성공 : 0
//		실패 : -1
//			-10(BTH_NOT_SUPPORT_DEVICE) : 지원하는 단말기가 아님.
//	Parameters
//		unsigned long pdwMode : 상태값을 저장할 dwMode.
//				0 (BTH_POWER_OFF) : (전원을 OFF 시킴)전원이 꺼지거나, 장치가 없음.
//				1 (BTH_CONNECTABLE) : (전원을 ON 시킴)정상인 상태
//				2 (BTH_DISCOVERABLE) : (여기서 사용안함)정상이고, 연결이 가능한 상태
//-----------------------------------------------------------------------------
syscall	long	Bth_SetMode(unsigned long pdwMode);

//-----------------------------------------------------------------------------
//	Module Name : Bth_DoPairring
//	Description
//		szDeviceName과 동일한 장치와 페어링을 진행함.
//	Return
//		성공 : 0, 
//		실패 : -1 : szDeviceName Device의 장치가 없음.
//			-2 : 장치에 소켓 연결 실패.
//			-10 (BTH_NOT_SUPPORT_DEVICE) : 지원하는 단말기가 안님.
//	Parameters
//		char* szDeviceName : 페어링 할 장비이름.
//-----------------------------------------------------------------------------
syscall	long	Bth_DoPairring(char* szDeviceName );

//-----------------------------------------------------------------------------
//	Module Name : Bth_ComPortReg
//	Description
//		szDeviceName의 장비를 szPort로 등록함.
//	Return
//		리턴 : 0 : 레지스트 등록 성공
//			   -1(BTH_REG_SEARCH_FAIL) : 레지스트리 조회 실패.
//			   -2(BTH_REG_REG_FAIL) : 레지스트리 등록 실패.
//			   -3(BTH_NOT_REG_DEVICE) : 등록된 단말기가 존재하지 않음.
//			   -5(BTH_ALREADY_REG_DEVICE) : 이미 등록된 단말기임.
//			   -10(BTH_NOT_SUPPORT_DEVICE) : 지원하는 단말기가 아님.
//	Parameters
//		char* szDeviceName : 페어링 할 장비이름.
//		char* szPort : 등록할 PORT 이름 (ex. "COM8")
//-----------------------------------------------------------------------------
syscall	long	Bth_ComPortReg(char* szDeviceName, char* szPort );

//-----------------------------------------------------------------------------
//	Module Name : Bth_ComPortIsReg
//	Description
//		szDeviceName의 등록여부와 szPort의 등록여부
//	Return
//		리턴 : 
//			   -3(BTH_NOT_REG_DEVICE) : 등록된 단말기가 존재하지 않음.
//			   -4(BTH_NOT_REG_PORT) : 단말기는 등록되었으나, 포트가 등록되지 않음.
//			   -5(BTH_ALREADY_REG_DEVICE) : 이미 등록된 단말기임.
//			   -10(BTH_NOT_SUPPORT_DEVICE) : 지원하는 단말기가 아님.
//	Parameters
//		char* szDeviceName : 페어링 할 장비이름.
//		char* szPort : 등록할 PORT 이름 (ex. "COM8")
//-----------------------------------------------------------------------------
syscall	long	Bth_ComPortIsReg (char* szDeviceName, char* szPort );

//-----------------------------------------------------------------------------
//	Module Name : Warm_Reboot
//	Description
//		단말기를 소프트 리셋함.
//	Return
//		성공 : 1 (TRUE)
//		실패 : 0 (FALSE)
//			-10 (BTH_NOT_SUPPORT_DEVICE) : 지원하지 않는 단말기.
//	Parameters
//		없음.
//-----------------------------------------------------------------------------
syscall	long	Warm_Reboot( void );

//-----------------------------------------------------------------------------
//	Module Name : VM_PlaySound
//	Description
//		Wave file play.
//	Return
//	Parameters
//		없음.
//-----------------------------------------------------------------------------
syscall	void	VM_PlaySound(char *cWaveFileName);

//-----------------------------------------------------------------------------
//	Module Name : SSL_SetEnable
//	Description
//		기존 Socket에서 SSL사용여부를 세팅함
//	Return
//		성공 : 0, 실패 : -1
//	Parameters
//		nMode : SSL_SOCK_ENABLE : 1 사용
//				SSL_SOCK_DISABLE : 0 미사용
//-----------------------------------------------------------------------------
syscall	long	SSL_SetEnable		(long nMode);

//-----------------------------------------------------------------------------
//	Module Name : SSL_IsEnable
//	Description
//		기존 Socket에서 SSL사용여부를 조회함
//	Return
//		SSL 사용 : 1 SSL_SOCK_ENABLE
//		SSL 미사용 : 0 SSL_SOCK_DISABLE
//	Parameters
//-----------------------------------------------------------------------------
syscall	long	SSL_IsEnable		(void);

//-----------------------------------------------------------------------------
//	Module Name : SSL_Sock_Connect
//	Description
//		소켓 연결시 SSL을 사용하여 연결한다. SSL을 초기화하는 코드가 추가됨
//	Return
//
//	Parameters
//
//-----------------------------------------------------------------------------
syscall	long	SSL_Sock_Connect	(quad nHostIp, long nPort, long nTimeOut);

//-----------------------------------------------------------------------------
//	Module Name : SSL_Sock_Close
//	Description
//		SSL 소켓의 사용을 종료한다. 사용되던 리소스를 해제 한다.
//	Return
//
//	Parameters
//
//-----------------------------------------------------------------------------
syscall	long	SSL_Sock_Close		(void);

//-----------------------------------------------------------------------------
//	Module Name : SSL_Sock_Write
//	Description
//		SSL을 이용해서 Sock_Write 한다.
//	Return
//
//	Parameters
//
//-----------------------------------------------------------------------------
syscall	long	SSL_Sock_Write		(byte *pBuffer, long nLength, long nTimeOut);

//-----------------------------------------------------------------------------
//	Module Name : SSL_Sock_Read
//	Description
//		SSL을 이용해서 Sock_Read 한다.
//	Return
//
//	Parameters
//
//-----------------------------------------------------------------------------
syscall	long	SSL_Sock_Read		(byte *pBuffer, long nMaxLength,  long nTimeOut);

//-----------------------------------------------------------------------------
//	Description
//		윈도우 화면을 최소화 또는 최대화 한다. (HTC)
//	Return
//		성공 : 0, 실패 : -1
//	Parameters
//      bFlag : TRUE or FALSE (최소화)
//-----------------------------------------------------------------------------
syscall	long VM_ShowWindow ( BOOL bFlag );

//-----------------------------------------------------------------------------
//	Description
//		VM_SipEnumIMNumber : 설치된 IM의 갯수를 조회함
//	Parameters
//		
//	Return
//		long				: 설치된 IM 갯수  숫자
//	Remark
//		** MAX 20개로 20개 이상 조회시 20을 리턴함.
//-----------------------------------------------------------------------------
syscall long VM_SipEnumIMNumber( void );
//-----------------------------------------------------------------------------
//	Description
//		VM_SipEnumIM : 설치된 IM의 이름을 조회함
//	Parameters
//		char pIm_Name[20][260] : 설치된 IM의 이름을 리턴함.
//	Return
//		SUCCESS		: 성공
//		FAIL		: 실패
//	Remark
//-----------------------------------------------------------------------------
syscall long VM_SipEnumIM(char pIm_Name[20][260]);

//-----------------------------------------------------------------------------
//	Description
//		VM_SipGetCurrentIM : 현재 선택된 IM정보를 얻음
//	Parameters
//		char *szIMName : 현재 선택된 IM의 이름을 리턴함.
//						 Name : max 260 byte
//	Return
//		SUCCESS		: 성공
//		FAIL		: 실패
//	Remark
//-----------------------------------------------------------------------------
syscall long VM_SipGetCurrentIM( char * szIMName );

//-----------------------------------------------------------------------------
//	Description
//		VM_SipSetCurrentIM : 입력된 IM을 입력 IM으로 세팅함.
//	Parameters
//		char *szIMName : 선택할 IM의 이름.
//						 Name : max 260 byte
//	Return
//		SUCCESS		: 성공
//		FAIL		: 실패
//	Remark
//-----------------------------------------------------------------------------
syscall long VM_SipSetCurrentIM( char * szIMName );

//-----------------------------------------------------------------------------
//	Description
//		시스템 메모리 힙 누수 개수를 리턴한다.
//	Return
//		성공 : leak count
//	Parameters
//-----------------------------------------------------------------------------
syscall long Mem_GetLeakCheck (void);

//고 수준 힙 관리 API
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
//		고 수준 시스템 메모리 힙 관리 클래스를 초기화하거나 제거한다.
//	Return
//		성공 : 0
//	Parameters
//-----------------------------------------------------------------------------
syscall long Mem_NewHeapMgr (void);
syscall long Mem_DelHeapMgr (void);

//-----------------------------------------------------------------------------
//	Description
//		고 수준 시스템 메모리 힙을 할당한다(메모리 할당 정보를 생성한다.).
//	Return
//		성공 : 힙 포인터
//	Parameters
//      nLength : 메모리 할당 크기
//      szFile  : API 호출 소스 경로 및 파일 명
//      nLine   : API 호출 소스의 라인 번호
//-----------------------------------------------------------------------------
syscall void* Mem_New (long nLength, char* szFile, long nLine);

//-----------------------------------------------------------------------------
//	Description
//		고 수준 시스템 메모리 힙을 해제한다(메모리 할당 정보를 해제한다.).
//	Return
//	Parameters
//      pMem1  : 메모리 할당 포인터
//-----------------------------------------------------------------------------
syscall void Mem_Delete (byte* pMem1);

//-----------------------------------------------------------------------------
//	Description
//		고 수준 시스템 메모리 힙의 릭 카운트를 개수를 알아낸다.
//	Return : 메모리 릭 카운트
//	Parameters
//-----------------------------------------------------------------------------
syscall long Mem_GetLeakCount (void);

//-----------------------------------------------------------------------------
//	Description
//		고 수준 시스템 메모리 힙의 릭 포인터 정보를 리턴한다.
//	Return : HeapInf 구조체 포인터
//	Parameters
//      index  : 메모리 할당 리스트 인덱스(리턴이 NULL이 될때까지..)
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
//		멀티 타스크 서비스를 요청한다.
//	Return
//		성공 : 0
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

//비동기 함수
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
//	HTTP API (cURL 기반)
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
#define VPN_NOT_INSTALLED		-1	// VPN Client가 현재 설치되지 않은 상태
#define VPN_CLOSED				0	// VPN Client가 실행되지 않은 상태
#define VPN_CONNECTED			1	// VPN Client가 실행되어 연결된 상태
#define VPN_TRY_TO_CONNECT		2	// VPN Client가 현재 연결 중인 상태
#define VPN_INSTALLED			3	// VPN Client가 현재 설치된 상태

#define VPN_STATUS_CHK_INSTALLED	0	//VPN 설치 여부 확인
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
//비동기 프로그레스 표시 (쓰레드로 동작됨)
syscall void	PROGRESS_Start			(void);
syscall void	PROGRESS_Stop			(void);

//(x,y) 텍스트 중심좌표.
syscall long	PROGRESS_DrawText		(long x, long y, long FrColor, long BkColor, long font_type, long nCur, long nMax);

//(x,y) bar left-top 좌표.
syscall long	PROGRESS_DrawBar		(long x, long y, long w, long h, long FrColor, long font_type, long nCur, long nMax);

//(x,y) arc 중심좌표, r : 반지름, thickness : 바 표시두께.
syscall long	PROGRESS_DrawArc		(long x, long y, long r, long thickness, long FrColor, long font_type, long nCur, long nMax);

//nTotal : 전체 카운트 수
syscall void	PROGRESS_SetStart		(long nTotal);

//nValue : 현재 진행 카운트 수 (화면에는 계산을 통해 백분율로 표시 됨)
syscall void	PROGRESS_SetUpdate		(long nValue);

//이벤트(MSG_PROGRESS)로 프로그레스 진행값/전체값을 받음.
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
//상대경로를 지정.
syscall long Camera_Shoot(char* pszPath);
//flag = 1 (on), flag = 0 (off)
syscall long Camera_Flash(long flag);

syscall long SetRemoteLog (long flag);

#endif	//	LIBSYSCALL_H

