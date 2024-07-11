/*----------------------------------------------------------------------------------
	Project Name: Smart long operation 모듈 (Biglong.lib)
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create 스마트폰 포팅
----------------------------------------------------------------------------------*/


#ifndef __CARDREAD_SHARE_CARD__
#define __CARDREAD_SHARE_CARD__



	typedef long (*CardRead_Func_Type)(long*, char*);
/*
┌─────────────────────────────────────┐
│																			│
│	 ◈ Description															│
│		      - CardRead 공유 카드에서 CardRead Dialog를 띄우는 함수 포인터	│
│		 ◈ Parameter														│
│			  - 카드리드 결과값을 입력되는 버퍼: 				            │
│		 ◈ Return															│
│			  -  0 : 카드리드 성공      									│
│			  -	 2 TRACK의 데이터를 읽어온다.    							│
└─────────────────────────────────────┘*/	
		
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
