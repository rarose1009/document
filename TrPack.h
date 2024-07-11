	/*----------------------------------------------------------------------------------

	Project Name :
	
	mPOP25 Application : 전문 코드 Pack (TrPack.h)

	Compiler & Virtual Machine : mPOP 25.4
~
	Copyright(c) 2004 Mobile C&C Co., Ltd.

	----------	------		--------------------------------------------------------------------
	2004.02.16	dkjung		v1.00		: Create
	2004.02.18	dkjung					: 재 통신 사용 변수 카드 전역 변수로 변경
										: 전문 pack 에러 처리 코드 삽입
	2004.08.16	dkjung		v1.10		: Argument관련 매크로 추가

	2004.10.06	dkjung		v3.00		: Release ( 표준모듈명 : TrPack )
										: 이 버전 이후, 모듈 수정시 메일로 수정 내용
										: 알려 주기 바람 ( dkjung@mcnc.co.kr )
	----------	------		------------------------------------------------------
------------------------------------------------------------------------------------------------*/

#ifndef	__TRPACK_H__
#define	__TRPACK_H__

#include "Comm.h"
#include "globalcard.h"

//---------------------------------------------------------------
//					사용 방법
//      			---------
//
//	//	#define USE_TRC_0000
//
//	#define을 이용하여 사용하고자 하는 전문 번호를 정의.
//  각 카드에서 함수를 사용할 경우 define을 풀면 된다.
//
//  목적 : 전문에 대한 데이터 처리 작업을 한 곳에 모아서 하기 위함.
//---------------------------------------------------------------

typedef struct _ARG
{
	long m_nIndex;
	char m_szMsg[64];
	void* m_pData;
} ARG, *PARG;

#define TR_FUNC(code)	TrPack_##code

long (*_pfTrPack) ( PARG );
ARG		_TrPack_stArg;
long RunTrPack (bool bRetryFlag, void* pfunc, void* pData);


// 각 카드에서 호출 할때
// 구조체 선언
// nRet = RunTrPack (FALSE, TR_FUNC(0000), TR별 구조체 포인터);
// if (nRet < 0)
// {
//		// 에러 처리
// }
//---------------------------------------------------------------
long RunTrPack (bool bRetryFlag, void* pfunc, void* pData)
{
	long nRet;
	
	_pfTrPack = ( long (*)( PARG ) ) pfunc;

	if (bRetryFlag == FALSE)
	{
		_TrPack_stArg.m_pData = pData;
		_TrPack_stArg.m_nIndex = _pfTrPack ( &_TrPack_stArg );
		
		if (_TrPack_stArg.m_nIndex < 0)
		{
			MessageBoxEx (ERROR_OK, "통신 전문 파일 생성 실패.");
			return -1;
		}
	}

	nRet = COMM_DATA_INDEX (_TrPack_stArg.m_nIndex, _TrPack_stArg.m_szMsg);
	if (nRet < 0)
	{
		// chan 2004-09-10
		// 메시지를 처리해주는 경우는 Display값이 FALSE로 설정되어있고,
		// 메시지 종류가 ERR_SVR_RES_FAIL거나 ERR_SVR_CON_FAIL 인 경우 임.
		if (!TrInfo[_TrPack_stArg.m_nIndex].m_bInMsgDisplay)
		{
			if (nRet == ERR_SVR_RES_FAIL || nRet == ERR_SVR_CON_FAIL)
				return nRet;
		} 
		COMM_MSGBOX (nRet);
		return -1;
	}

	return 0;
}

////////////////////////////////////////////////////////////////////////////
//
//					사용자 어플리케이션 추가 영역...
//
////////////////////////////////////////////////////////////////////////////


	//---------------------------------------------------------------
	//					각 TR 코드별 구조체 선언 영역
	//      			-----------------------------
	//
	//	각 TR별 사용되는 구조체 TR 선언 영역에 직접 선언 할 것.
	//---------------------------------------------------------------
	
//-------------------------------------------------------------------
#ifdef USE_TRC_1000		// 사용자인증		
	long TrPack_1000 ( PARG pArg )
	{
		long fd;
		long nOfs = 0;
		
		fd = COMM_FOPEN ( "1000", 1, WR );
		if (fd < 0)	return -1;	

		//메시지를 넘길때
		Str_Cpy (pArg->m_szMsg, "사 용 자 인 증");

		//헤더에 선언된 TR별 구조체 포인터를 받아서 처리
		//구조체 pst = (구조체*)pArg->m_pData;
		//구조체 사용

		COMM_FWRITE (fd, nOfs, m_szSnd,  	25);	// 로그인ID
		//PRINT("$ ID:[%s], PWD:[%s] ", g_LoginID,EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PWD)), 0);	
		COMM_FCLOSE(fd);
		
		//전문의 인덱스를 리턴
		return GET_TRCODE (1000);
	}
#endif // USE_TRC_1000

//-------------------------------------------------------------------
#ifdef USE_TRC_9999		// SSL 테스트
	long TrPack_9999 ( PARG pArg )
	{
		long fd,fd1;
		long nOfs = 0;
		char temp[1];
		char *pdata;
		long i = 0;
		long ltotsize;
		
		fd = COMM_FOPEN ( "9999", 1, WR );
		if (fd < 0)	return -1;	

		//메시지를 넘길때
		Str_Cpy (pArg->m_szMsg, "SSL테스트");
		
		COMM_FCLOSE(fd);
		
		//전문의 인덱스를 리턴
		return GET_TRCODE (9999);
	}
#endif // USE_TRC_9999

#endif	// _TRPACK_H_
