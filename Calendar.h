/*----------------------------------------------------------------------------------
	Project Name: Smart long operation 모듈 (Biglong.lib)
	Smart Application : 카드 기본폼
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create 스마트폰 포팅
----------------------------------------------------------------------------------*/


#ifndef __CALENDAR_SHARE_CARD__
#define __CALENDAR_SHARE_CARD__



	typedef long (*Calendar_Func_Type)(long *);
/*
┌─────────────────────────────────────┐
│																			│
│	 ◈ Description															│
│		      - Calendar 공유 카드에서 Calendar Dialog를 띄우는 함수 포인터	│
│		 ◈ Parameter														│
│			  - dayOfWeek : 요일을 받아 온다.								│
│			  - 0:일, 1:월, 2:화, 3:수, 4:목, 5:금, 6:토					│												│
│		 ◈ Return															│
│			  -  0 : 날짜가 선택되지 않음									│
│			  - >0 : 선택된 날짜를 yyyymmdd형식으로 리턴					│						        │
│				♣  long Calendar(long* dayOfWeek) 함수와 비슷한 기능		│											│
│				    														│
└─────────────────────────────────────┘*/	
		
	Calendar_Func_Type CalendarDialog;
	
	
	void Load_Calendar_Card(void)
	{
		ShareCardHandle cardHandle;
		cardHandle = ShareCard_Load("Calendar");
		if ( !cardHandle )
		{
			Print("Calendar Card not exit fail", 0, 0, 0);
			VM_AmEnd();
			return;
		}
		CalendarDialog = (Calendar_Func_Type) (GetProcAddress(cardHandle, "CalendarDialog"));
	
		if ( !CalendarDialog )
		{
			Print("Calendar Share function not exit fail", 0, 0, 0);
			VM_AmEnd();
			return;
		}
	}
		
	void Unload_Calendar_Card(void)
	{
		ShareCard_Unload("Calendar");
	}

#endif
