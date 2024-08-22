/*----------------------------------------------------------------------------------

	Smart Application : SQLITE table migration (migration.h)
	Smart Version : Smart 1.0
	Copyright(c) 2024  ValueCMD Co., Ltd.

	----------	------		------------------------------------------------------
	2024.08.08	dkjung		v1.00		: Create
	----------	------		------------------------------------------------------
----------------------------------------------------------------------------------*/

#ifndef	__MIGRATION_H__
#define	__MIGRATION_H__

// #define __USE_DB_SAVE__

#define __INSERT_TEST__(seq, gkey, desc) \
		memset((byte*)__szSql__ ,0x00, sizeof(__szSql__) ); \
		sprintf(__szSql__, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(%d,'" gkey "','" desc "')", seq); \
		PRINT("@migration test _szSql ==> %s", __szSql__,0,0)

#ifdef __USE_DB_SAVE__

	#define __INSERT__(seq, gkey, desc) \
			memset((byte*)__szSql__ ,0x00, sizeof(__szSql__) ); \
			sprintf(__szSql__, "INSERT INTO TBL_REGIST (SEQ, GKEY, TXTDETAIL) VALUES(%d,'" gkey "','" desc "')", seq); \
			g_Sql_DirectExecute( __szSql__ )

#else

	#define __INSERT__	__INSERT_TEST__

#endif //__USE_DB_SAVE__

char __szSql__[1024];

// 20240610 진광언
// 새로운 Table이나 Column 생성시에는 Alter_Table()을 이용하여 생성 진행.
// 현재 case 99 까지 생성되어있는상태. 
// TBL_REGIST 테이블에 +1 값 INSERT 진행

// 20240809 dkjung
// 마이그레이션 모듈로 분리 함. => 기존 코드를 프리징하기 위함.

//-----------------------------------------------
void Migration(long i)
{
	long index = i;

	switch(index)
	{
		case 104:
			index++;
			// PRINT("@dkjung new index => %d", index, 0, 0);
			__INSERT__(index, "20240814", "한글테스트...");
			break;
	}
}

#undef __INSERT_TEST__
#undef __INSERT__
#undef __USE_DB_SAVE__

#endif	//__MIGRATION_H__
