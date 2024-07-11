
//---------------------------------------------------------------------------
//민원 만족도 조사 ShareCard
//
//
//
//---------------------------------------------------------------------------


#ifndef __CUSTINFO_SHARE_CARD__
#define __CUSTINFO_SHARE_CARD__



	typedef long (*CustInfo_Func_Type)(void);
		
	CustInfo_Func_Type CustInfoDialog;
	
	
	void Load_CustInfo_Card(void)
	{
		ShareCardHandle cardHandle;
		cardHandle = ShareCard_Load("CUST_INFO");
		if ( !cardHandle )
		{
			VM_AmEnd();
			return;
		}
		CustInfoDialog = (CustInfo_Func_Type) (GetProcAddress(cardHandle, "CustInfoDialog"));
	
		if ( !CustInfoDialog )
		{
			VM_AmEnd();
			return;
		}
	}
		
	void Unload_CustInfo_Card(void)
	{
		ShareCard_Unload("CUST_INFO");
	}

#endif
