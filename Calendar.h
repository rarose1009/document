/*----------------------------------------------------------------------------------
	Project Name: Smart long operation ��� (Biglong.lib)
	Smart Application : ī�� �⺻��
	Smart Version : Smart 1.0
	Copyright(c) 2014  ValueCMD Co., Ltd.
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/


#ifndef __CALENDAR_SHARE_CARD__
#define __CALENDAR_SHARE_CARD__



	typedef long (*Calendar_Func_Type)(long *);
/*
������������������������������������������������������������������������������
��																			��
��	 �� Description															��
��		      - Calendar ���� ī�忡�� Calendar Dialog�� ���� �Լ� ������	��
��		 �� Parameter														��
��			  - dayOfWeek : ������ �޾� �´�.								��
��			  - 0:��, 1:��, 2:ȭ, 3:��, 4:��, 5:��, 6:��					��												��
��		 �� Return															��
��			  -  0 : ��¥�� ���õ��� ����									��
��			  - >0 : ���õ� ��¥�� yyyymmdd�������� ����					��						        ��
��				��  long Calendar(long* dayOfWeek) �Լ��� ����� ���		��											��
��				    														��
������������������������������������������������������������������������������*/	
		
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
