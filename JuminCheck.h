/*----------------------------------------------------------------------------------
	Project Name: Smart HYGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create 스마트폰 포팅
----------------------------------------------------------------------------------*/

bool 	check_fgnno(char *jumin) ;//외국인등록번호 체크
long	CheckJuminNumber ( char *jumin );//주민번호 체크

bool check_fgnno(char *jumin) 
{
	long i;
	long nJumin[13];
	long	keynum[12] = { 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 };
	long sum;
	long odd;
	
	//길이체크
	if ( Str_Len(jumin) != 13 )
		return FALSE;
	
	//숫자 인지 체크		
	for ( i = 0; i< 13; i++ )
	{
		if ( jumin[i] < '0' || jumin[i] > '9' )
			return FALSE;
			
		//숫자로 변환
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
	
	//길이체크
	if ( Str_Len(jumin) != 13 )
		return -1;
	
	//숫자 인지 체크		
	for ( i = 0; i< 13; i++ )
	{
		if ( jumin[i] < '0' || jumin[i] > '9' )
			return -1;
			
		//숫자로 변환
		nJumin[i] = jumin[i] - '0';
	}		

	//뒷 부분 7자리는 맨앞의 것은 성별을 나타냄.
	// 1은 남자,2는 여자
	// 2000년 출생자부터는 3이 남자, 4가 여자를 나타냄.
	if ( jumin[6] < '1' || jumin[6] > '5' )
		return -1;
		
	//다음 네 개의 숫자는 지역 코드 (무시)
	//다음 한자리는 출생신고 당일, 그 출생신고가 그 해당읍면동사무소에 몇번쨰로 
	//접수된건가를 나타냄.
	
	//마지막 숫자는 '검증번호'
	sum = 0;
	for ( i = 0; i < 12; i++ )
		sum += ( nJumin[i] * keynum[i] );

	if ( nJumin[12] != ( ( 11 - (sum%11) )%10 ) )
		return -1;			 


	return 0;
}



