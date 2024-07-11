	/*----------------------------------------------------------------------------------

	Project Name :
	
	mPOP25 Application : ���� �ڵ� Pack (TrPack.h)

	Compiler & Virtual Machine : mPOP 25.4
~
	Copyright(c) 2004 Mobile C&C Co., Ltd.

	----------	------		--------------------------------------------------------------------
	2004.02.16	dkjung		v1.00		: Create
	2004.02.18	dkjung					: �� ��� ��� ���� ī�� ���� ������ ����
										: ���� pack ���� ó�� �ڵ� ����
	2004.08.16	dkjung		v1.10		: Argument���� ��ũ�� �߰�

	2004.10.06	dkjung		v3.00		: Release ( ǥ�ظ��� : TrPack )
										: �� ���� ����, ��� ������ ���Ϸ� ���� ����
										: �˷� �ֱ� �ٶ� ( dkjung@mcnc.co.kr )
	----------	------		------------------------------------------------------
------------------------------------------------------------------------------------------------*/

#ifndef	__TRPACK_H__
#define	__TRPACK_H__

#include "Comm.h"
#include "globalcard.h"

//---------------------------------------------------------------
//					��� ���
//      			---------
//
//	//	#define USE_TRC_0000
//
//	#define�� �̿��Ͽ� ����ϰ��� �ϴ� ���� ��ȣ�� ����.
//  �� ī�忡�� �Լ��� ����� ��� define�� Ǯ�� �ȴ�.
//
//  ���� : ������ ���� ������ ó�� �۾��� �� ���� ��Ƽ� �ϱ� ����.
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


// �� ī�忡�� ȣ�� �Ҷ�
// ����ü ����
// nRet = RunTrPack (FALSE, TR_FUNC(0000), TR�� ����ü ������);
// if (nRet < 0)
// {
//		// ���� ó��
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
			MessageBoxEx (ERROR_OK, "��� ���� ���� ���� ����.");
			return -1;
		}
	}

	nRet = COMM_DATA_INDEX (_TrPack_stArg.m_nIndex, _TrPack_stArg.m_szMsg);
	if (nRet < 0)
	{
		// chan 2004-09-10
		// �޽����� ó�����ִ� ���� Display���� FALSE�� �����Ǿ��ְ�,
		// �޽��� ������ ERR_SVR_RES_FAIL�ų� ERR_SVR_CON_FAIL �� ��� ��.
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
//					����� ���ø����̼� �߰� ����...
//
////////////////////////////////////////////////////////////////////////////


	//---------------------------------------------------------------
	//					�� TR �ڵ庰 ����ü ���� ����
	//      			-----------------------------
	//
	//	�� TR�� ���Ǵ� ����ü TR ���� ������ ���� ���� �� ��.
	//---------------------------------------------------------------
	
//-------------------------------------------------------------------
#ifdef USE_TRC_1000		// ���������		
	long TrPack_1000 ( PARG pArg )
	{
		long fd;
		long nOfs = 0;
		
		fd = COMM_FOPEN ( "1000", 1, WR );
		if (fd < 0)	return -1;	

		//�޽����� �ѱ涧
		Str_Cpy (pArg->m_szMsg, "�� �� �� �� ��");

		//����� ����� TR�� ����ü �����͸� �޾Ƽ� ó��
		//����ü pst = (����ü*)pArg->m_pData;
		//����ü ���

		COMM_FWRITE (fd, nOfs, m_szSnd,  	25);	// �α���ID
		//PRINT("$ ID:[%s], PWD:[%s] ", g_LoginID,EditCtrl_GetStr(Get_hDlgCtrlByID(EDT_PWD)), 0);	
		COMM_FCLOSE(fd);
		
		//������ �ε����� ����
		return GET_TRCODE (1000);
	}
#endif // USE_TRC_1000

//-------------------------------------------------------------------
#ifdef USE_TRC_9999		// SSL �׽�Ʈ
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

		//�޽����� �ѱ涧
		Str_Cpy (pArg->m_szMsg, "SSL�׽�Ʈ");
		
		COMM_FCLOSE(fd);
		
		//������ �ε����� ����
		return GET_TRCODE (9999);
	}
#endif // USE_TRC_9999

#endif	// _TRPACK_H_
