/*----------------------------------------------------------------------------------
	Project Name: Smart SCGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create ����Ʈ�� ����
----------------------------------------------------------------------------------*/


#ifndef __COMDEF_H__
#define __COMDEF_H__

#include "DefType.h"

	// dkjung 2004-07-09
	// ��ü ������ �������� ����ϴ� ������� ��� �δ� ��
	
	#define	LAST_VERSION 	"BUILD : "__DATE__"/"__TIME__
	#define SET_IP(a,b,c,d) ( (((quad)a)<<24) | (((quad)b)<<16) | (((quad)c)<<8) | ((quad)d) )
	// 1. �ڵ强 ����
	// 2. ������ ����ü ����
	// 3. ��Ÿ �������� ��� �͵�...

//-----------------------------------------------------------------------------
// Ŀ���� ���� ����
//-----------------------------------------------------------------------------
#define 	TRANSPARENT		MAKE_RGB(255,   0, 255)			//�����
#define		BTN_LOGINBK		MAKE_RGB(18, 131, 189)			//�α��ι�ư���
#define		BTN_PDACHGBK	MAKE_RGB(112, 112, 112)			//PDA����(��й�ȣ) ��ư���
#define		BTN_BKCOLOR		MAKE_RGB(80, 80, 80)			//�⺻��ư���
//#define		BTN_KEYCOLOR	MAKE_8_16(219)				//���� �е� ��ư�� ����
#define		BTN_FRCOLOR		MAKE_RGB(255, 255, 255)			//�⺻��ư���ڻ�
#define		BTN_SUBBK		MAKE_RGB(129, 129, 129)			//�����ư���
//#define		BTN_CANTBK		MAKE_RGB(186, 186, 186)		//�⺻(����)��Ȱ�����
#define		BTN_IMPBK		MAKE_RGB(54, 107, 190)			//�߿��ư ���
#define		BTN_PDAIMPBK	MAKE_RGB(67, 132, 235)			//PDA�߿��ư ���
//#define		BTN_IMPNOTBK	MAKE_RGB(129, 156, 197)		//�߿��ư ��Ȱ�����
#define		BTN_IMPFR		MAKE_RGB(255, 216, 0)			//�߿��ư���ڻ�
//#define		MAINTTLBK		MAKE_RGB(2, 50, 112)	    //����Ÿ��Ʋ ����

#define		TTLCTRLBK			MAKE_RGB(255,   0, 255)		//Ÿ��Ʋ ��� ,�����
#define		TTLCTRLFR			MAKE_RGB(255, 255, 255)		//Ÿ��Ʋ���ڻ�
//#define		TXTCTRLBK			MAKE_RGB(229, 229, 229)		//�ؽ�Ʈ �߿� ���
#define		PDATXTCTRLBK		MAKE_RGB(213, 213, 213)		//PDA�ؽ�Ʈ �߿� ���
#define		TXTINCTRLBK			MAKE_RGB(255, 255, 255)		//�ؽ�Ʈ ���� ���

#define		EDTCTRLBK			MAKE_RGB(255, 251, 204)		//����Ʈ,�޺� ���
#define		PDAEDTCTRLBK		MAKE_RGB(255, 251, 204)		//MAKE_RGB(255, 242, 0)		PDA����Ʈ,�޺� ���

#define		TTLCTRLSUBK			MAKE_RGB(208, 208, 208)  
#define		TXTCTRLSUBK			MAKE_RGB(62,   81, 153)
#define		TXTFRCOLOR			MAKE_RGB(80, 80, 80)		//�⺻ ���ڻ� - �� ���
#define		TXTTTLFRCOLOR		MAKE_RGB(255, 255, 255)		//�⺻ ���ڻ� - ȸ�� ���
//#define		GRIDTTLBK			MAKE_RGB(229, 229, 229)		//���̺� ���� , <<--���� �ּ� Ǯ��!!!


//*****************************************************
//2�� �þ�
#define		GRIDTTLBK				MAKE_RGB(233, 242, 255)		//���̺� ����
#define		TXTCTRLBKGRAY			MAKE_RGB(177,   177, 177)
#define		TXTCTRLBKWHITE			MAKE_RGB(250,   250, 250)
#define		TXTCTRLBKBLUE			MAKE_RGB(112,   155, 230)
#define		TXTCTRLBKRED			MAKE_RGB(232,   79, 79)
#define     TXTCTRLBK				TXTCTRLBKGRAY
#define		TXTCTRLPAGEBK			MAKE_RGB(127,    181, 255)		//�跮�ⱳü����Ʈ ������ǥ�� ���
#define		TXTCTRLRSLTBK			MAKE_RGB(250,    250, 250)		//�跮�ⱳü����Ʈ ��ü,��ü,�̱�ü �ؽ�Ʈ ���
#define		TXTCTRLFRCOLOR			MAKE_RGB(55,     55, 55)

#define		BTNCTRLBKBLACK			MAKE_RGB(68,    68, 68)
//#define		BTNCTRLBKCOLOR		    MAKE_RGB(255,    255, 255)	//2�� �þ� ��ư ���� - ����
#define		BTNCTRLBKCOLOR		    MAKE_RGB(56,    128, 228)				//2�� �þ� ��ư ���� - ���� ���� �׽�Ʈ
#define		BTNCTRLGRAY		        MAKE_RGB(181,   178, 181)				//�跮�� �ο���ü ��ġ�跮�� ���� ���� (ȸ��)
//#define		BTNCTRLBKCOLOR		    TABLETITLE_COLOR				//2�� �þ� ��ư ���� - ���� ���� �׽�Ʈ
//#define		BTNMENUFRCOLOR			MAKE_RGB(55, 55, 55)		//2�� �þ� ��ư���ڻ� - ����
#define		BTNCTRLFRCOLOR_NP		MAKE_RGB(255, 255, 255)			//2�� �þ� ��ư���ڻ� - ü��Ȱ�� ��ư
#define		BTNMENUFRCOLOR			BTNCTRLFRCOLOR_NP			//2�� �þ� ��ư���ڻ� - �׽�Ʈ


#define		LINECTRLCOLOR			MAKE_RGB(227,    227, 227)		//�跮�ⱳü�޴� ���� ��Ʈ�� ����

//*****************************************************

//skyblue ���� MAKE_RGB(142, 186, 244)
//#define		BTNCTRLBKCOLOR		MAKE_RGB(80, 80, 80)			//�⺻��ư���
#define		BTNCTRLSIDECOLOR	MAKE_RGB(80, 80, 80)				//��ư �׵θ�
#define		BTNCTRLFRCOLOR		MAKE_RGB(64, 92, 171)				
//#define		BTNCTRLBKCOLOR      MAKE_RGB(103, 176, 243)				//�Ϲݹ�ư����
//#define		BTNMENUFRCOLOR		MAKE_RGB(255, 255, 255)				//�޴���ư���ڻ�
#define		BTNCHKFRCOLOR		MAKE_RGB(80, 80, 80)				//�޺��ڽ� ���ڻ�
#define		TABLEACTIVECOLOR	MAKE_RGB(255, 234, 208)				//���̺� Ŭ����
//#define		TABLEACTIVECOLOR	MAKE_RGB(255, 160, 60)			//���̺� Ŭ���� <<<--����!!! �ּ� Ǯ��!!!!!!
#define		BTNCTRLMNBKCOLOR	MAKE_RGB(255,   0, 255)				//�����
#define		MEGBKCOLOR			MAKE_RGB(18, 131, 189)				//�˾� ���

//#define		MEGBKCOLOR_CONFIRM		MAKE_RGB(154, 193, 66)		//�˸��˾� Ÿ��Ʋ���
//#define		MEGBKCOLOR_CONFIRM		MEDIUMSEAGREEN				//�˸��˾� Ÿ��Ʋ���
#define		MEGBKCOLOR_CONFIRM		LIGHTSKYBLUE					//�˸��˾� Ÿ��Ʋ���
//#define		MEGBKCOLOR_WARNING		MAKE_RGB(255, 138, 0)		//����˾� Ÿ��Ʋ���
#define		MEGBKCOLOR_WARNING		CORAL		//����˾� Ÿ��Ʋ���
//#define		MEGBKCOLOR_ERROR		MAKE_RGB(238, 28, 36)		//�����˾� Ÿ��Ʋ���
#define		MEGBKCOLOR_ERROR		CRIMSON		//�����˾� Ÿ��Ʋ���

#define		MAINBKCOLOR			MAKE_RGB(255, 255, 255)

#define		TABCOLOR1		MAKE_RGB(74, 122, 182)		//��1
#define		TABCOLOR2		MAKE_RGB(91, 113, 169)		//����2
#define		TABCOLOR3		MAKE_RGB(111, 131, 181)		//
#define		TABCOLOR4		MAKE_RGB(146, 130, 175)		//�ð���4
#define		TABCOLOR5		MAKE_RGB(172, 136, 172)		//����5
#define		TABCOLOR6		MAKE_RGB(107, 166, 161)		//
#define		TABCOLOR7		MAKE_RGB(138, 162, 104)		//���ұ�7
#define		TABCOLOR8		MAKE_RGB(114, 114, 114)		//����8
#define		TABCOLOR9		MAKE_RGB(179, 151, 114)		//����9
#define		TABCOLOR10		MAKE_RGB(159, 128, 113)		//����10
#define		TABCOLOR11		MAKE_RGB(111, 122, 147)		//���ɰ˻�11


// ���̺�� ���õ� �÷�
#ifndef	TITLEBAR_HEIGHT
	#define	TITLEBAR_HEIGHT	TITLE_HEIGHT
#endif


#ifndef	TABLEACTIVE_COLOR
	#define	TABLEACTIVE_COLOR	TABLEACTIVECOLOR
#endif

#ifndef	TABLETITLE_COLOR
	#define	TABLETITLE_COLOR	GRIDTTLBK //MAKE_8_16(254)
	//#define	TABLETITLE_COLOR	BTNCTRLBKCOLOR //MAKE_8_16(254)
#endif

	
#endif // _COMDEF_H_
