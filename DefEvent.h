/*----------------------------------------------------------------------------------
	Project Name: Smart HYGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create 스마트폰 포팅
----------------------------------------------------------------------------------*/

#ifndef __DEFEVENT_H__
#define	__DEFEVENT_H__

		//---------------------------------------------------------------
		//					사용 방법
		//      			---------
		//
		//	//	#define USE_ON_EXIT
		//	//	#define USE_ON_CHAR
		//	//	#define USE_ON_KEY
		//	//	#define USE_ON_DRAW
		//	//	#define USE_ON_TIMER
		//	//	#define USE_ON_POINTING
		//	//	#define USE_ON_SELECT
		//		#include "DefEvent.h"
		//
		//	define을 모두 막아 놓을 경우 default 사용을 하는 경우 임.
		//  각 카드에서 함수를 사용할 경우 define을 풀면 된다.
		//---------------------------------------------------------------

	#ifndef USE_ON_EXIT
		//---------------------------------------------------------------
		void	OnExit(void)
		{
		}
	#endif  //USE_ON_EXIT

	#ifndef USE_ON_CHAR
		//---------------------------------------------------------------
		void	OnChar(long nChar)
		{
		}
	#endif  //USE_ON_CHAR

	#ifndef USE_ON_KEY
		//---------------------------------------------------------------
		void	OnKey(long nKey)
		{
		}
	#endif  //USE_ON_KEY

	#ifndef USE_ON_DRAW
		//---------------------------------------------------------------
		void	OnDraw(void)
		{
		}
	#endif  //USE_ON_DRAW

	#ifndef USE_ON_TIMER
		//---------------------------------------------------------------
		void	OnTimer(long nTimerID)
		{
		}
	#endif  //USE_ON_TIMER

	#ifndef USE_ON_POINTING
		//---------------------------------------------------------------
		void	OnPointing(long nAction, long X, long Y)
		{
		}
	#endif  //USE_ON_POINTING

	#ifndef USE_ON_SELECT
		//---------------------------------------------------------------
		void	OnSelect(long Index)
		{
		}
	#endif  //USE_ON_SELECT
	
	
	#ifndef USE_ON_PROGRESS
		//---------------------------------------------------------------
		void OnProgress(long nIndex, long nToTal)
		{   
		}
	#endif  //USE_ON_PROGRESS

	
	#ifndef USE_ON_USER
		//---------------------------------------------------------------
		void	OnUser(long nEvent, long nData)
		{
		}
	#endif  //USE_ON_USER


	#ifndef USE_ON_UART		
		void	OnUart(long nEvent, long nData)
		{
		}
	#endif  //USE_ON_UART

	#ifndef USE_ON_SESSION
		//---------------------------------------------------------------
		void	OnSession(long nEvent)
		{
		}
	#endif  //USE_ON_SESSION

	#ifndef USE_ON_SENDTEXT
		//---------------------------------------------------------------
		void	OnSendtext(long nEvent)
		{
		}
	#endif  //USE_ON_SENDTEXT	
	
	#ifndef USE_ON_TASK
		//---------------------------------------------------------------
		void	OnTask(long nEvent, long nData)
		{
		}
	#endif  //USE_ON_ON_TASK

	#ifndef USE_ON_TICKER
		//---------------------------------------------------------------
		void	OnTicker(long nEvent)
		{
		}
	#endif  //USE_ON_TICKER



	#ifndef USE_ON_EDITCTRL
		//---------------------------------------------------------------
		void	OnEditctrl(long nEvent)
		{
		
		}
	#endif  //USE_ON_EDITCTRL


	#ifndef USE_ON_EXTCTRL
		//---------------------------------------------------------------
		void	OnExtctrl(long nEvent, long nData)
		{
		
		}
	#endif  //USE_ON_EXTCTRL
	
	#ifndef USE_ON_GRIDCTRL
		//---------------------------------------------------------------
		void	OnGridctrl(long nEvent, long nData)
		{
		
		}
	#endif  //USE_ON_GRIDCTRL
	
#endif // _DEFEVENT_H_
