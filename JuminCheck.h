/*----------------------------------------------------------------------------------
	Project Name: Smart HYGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/

bool 	check_fgnno(char *jumin) ;//�ܱ��ε�Ϲ�ȣ üũ
long	CheckJuminNumber ( char *jumin );//�ֹι�ȣ üũ

bool check_fgnno(char *jumin) 
{
	long i;
	long nJumin[13];
	long	keynum[12] = { 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 };
	long sum;
	long odd;
	
	//����üũ
	if ( Str_Len(jumin) != 13 )
		return FALSE;
	
	//���� ���� üũ		
	for ( i = 0; i< 13; i++ )
	{
		if ( jumin[i] < '0' || jumin[i] > '9' )
			return FALSE;
			
		//���ڷ� ��ȯ
		nJumin[i] = jumin[i] - '0';
	}		

	odd = nJumin[7]*10 + jumin[8];
	
	if(odd%2 != 0)  
		return FALSE;
	
	if( (nJumin[11]!=6) && (nJumin[11]!=7) && (nJumin[11]!=8) && (nJumin[11]!=9) ) 
	{
		return FALSE;
	}
	
	
	
	for(i=0, sum=0; i<12; i++) 
	{
		sum += (nJumin[i] *= keynum[i]); 
	}
	sum = 11 - (sum%11);
	if(sum >= 10) 
	{ 
		sum -= 10; 
	}
	sum += 2;
	if(sum >= 10) 
	{ 
		sum -= 10; 
	}
	if(sum != nJumin[12]) 
	{ 
		return FALSE; 
	}
	return TRUE;
}


long	CheckJuminNumber ( char *jumin )
{
	long i;
	long nJumin[13];
	long keynum[12] = { 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 };
	long sum;
	
	//����üũ
	if ( Str_Len(jumin) != 13 )
		return -1;
	
	//���� ���� üũ		
	for ( i = 0; i< 13; i++ )
	{
		if ( jumin[i] < '0' || jumin[i] > '9' )
			return -1;
			
		//���ڷ� ��ȯ
		nJumin[i] = jumin[i] - '0';
	}		

	//�� �κ� 7�ڸ��� �Ǿ��� ���� ������ ��Ÿ��.
	// 1�� ����,2�� ����
	// 2000�� ����ں��ʹ� 3�� ����, 4�� ���ڸ� ��Ÿ��.
	if ( jumin[6] < '1' || jumin[6] > '5' )
		return -1;
		
	//���� �� ���� ���ڴ� ���� �ڵ� (����)
	//���� ���ڸ��� ����Ű� ����, �� ����Ű� �� �ش����鵿�繫�ҿ� ������� 
	//�����Ȱǰ��� ��Ÿ��.
	
	//������ ���ڴ� '������ȣ'
	sum = 0;
	for ( i = 0; i < 12; i++ )
		sum += ( nJumin[i] * keynum[i] );

	if ( nJumin[12] != ( ( 11 - (sum%11) )%10 ) )
		return -1;			 


	return 0;
}



