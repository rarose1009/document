/*----------------------------------------------------------------------------------
	Project Name: Smart long operation ��� (Biglong.lib)
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/


#ifndef __CARDREAD_SHARE_CARD__
#define __CARDREAD_SHARE_CARD__



	typedef long (*CardRead_Func_Type)(long*, char*);
/*
������������������������������������������������������������������������������
��																			��
��	 �� Description															��
��		      - CardRead ���� ī�忡�� CardRead Dialog�� ���� �Լ� ������	��
��		 �� Parameter														��
��			  - ī�帮�� ������� �ԷµǴ� ����: 				            ��
��		 �� Return															��
��			  -  0 : ī�帮�� ����      									��
��			  -	 2 TRACK�� �����͸� �о�´�.    							��
������������������������������������������������������������������������������*/	
		
	CardRead_Func_Type CardReadDialog;
	
	
	void Load_CardRead_Card(void)
	{
		ShareCardHandle cardHandle;
		cardHandle = ShareCard_Load("CardRead");
		if ( !cardHandle )
		{
			Print("CardRead Card not exit fail", 0, 0, 0);
			VM_AmEnd();
			return;
		}
		CardReadDialog = (CardRead_Func_Type) (GetProcAddress(cardHandle, "CardReadDialog"));
	
		if ( !CardReadDialog )
		{
			Print("CardRead Share function not exit fail", 0, 0, 0);
			VM_AmEnd();
			return;
		}
	}
		
	void Unload_CardRead_Card(void)
	{
		ShareCard_Unload("CardRead");
	}

#endif
