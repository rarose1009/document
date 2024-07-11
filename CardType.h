/*----------------------------------------------------------------------------------
	Project Name: Smart HYGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/

#ifndef __CARDTYPE_H__
#define __CARDTYPE_H__

#define _GO(name)		TXT_##name	

#define	TYP_BASE		0x0100
#define TYP_MAIN		TYP_BASE

//------------------------------------------------------
#define	TXT_MAINMENU	"MainMenu"		// ���θ޴�
#define	TXT_LOGIN		"Login"			// �α���
#define TXT_IPCHANGE	"IPChange"		// �����Ǻ���

enum
{
	// �Ϲ����� ī��
	MAINMENU = TYP_MAIN,	// Main Card Ÿ�� 
	LOGIN,
	IPCHANGE,
	
//	CARDLOADER,
	TYP_SAME,
	TYP_POPUP
};

#endif	// _CARDTYPE_H_
