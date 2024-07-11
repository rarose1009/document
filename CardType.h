/*----------------------------------------------------------------------------------
	Project Name: Smart HYGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create 스마트폰 포팅
----------------------------------------------------------------------------------*/

#ifndef __CARDTYPE_H__
#define __CARDTYPE_H__

#define _GO(name)		TXT_##name	

#define	TYP_BASE		0x0100
#define TYP_MAIN		TYP_BASE

//------------------------------------------------------
#define	TXT_MAINMENU	"MainMenu"		// 메인메뉴
#define	TXT_LOGIN		"Login"			// 로그인
#define TXT_IPCHANGE	"IPChange"		// 아이피변경

enum
{
	// 일반적인 카드
	MAINMENU = TYP_MAIN,	// Main Card 타입 
	LOGIN,
	IPCHANGE,
	
//	CARDLOADER,
	TYP_SAME,
	TYP_POPUP
};

#endif	// _CARDTYPE_H_
