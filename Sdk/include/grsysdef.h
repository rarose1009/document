#ifndef		GRSYSDEF_H
#define		GRSYSDEF_H

//------------------------------------------------------------------------------
//		box title height pixel
//------------------------------------------------------------------------------
#define		BOX_TITLE_HEIGHT		15				//	�������� ����, ��輱�� �������� ����

//------------------------------------------------------------------------------
//		box style (ModalBox::Frame.Base.Style)
//------------------------------------------------------------------------------
#define		BOXSTY_BORDER			0x80000000		//	������ �׵θ��� �׸�
#define		BOXSTY_THICKBORDER		0x40000000		//	�β��� ������ �׵θ��� �׸�
#define		BOXSTY_ROUNDBORDER		0x20000000		//	�𼭸��� �ձ� �׵θ��� �׸�
#define		BOXSTY_TITLE			0x08000000		//	������ ǥ����
#define		BOXSTY_LEFTTITLE		0x04000000		//	������ ����� ���ʿ� ǥ����
#define		BOXSTY_INVERSETITLE		0x02000000		//	������ �������� ǥ���� (���������� ����۾�)
#define		BOXSTY_BOLDTITLE		0x01000000		//	�����ڿ��� ����ü�� �����
#define		BOXSTY_HSCROLLBAR		0x00800000		//	���� ��ũ�ѹٸ� ǥ����
#define		BOXSTY_VSCROLLBAR		0x00400000		//	���� ��ũ�ѹٸ� ǥ����
#define		BOXSTY_WIDESCRLBAR		0x00200000		//	���� ���� ��ũ�ѹٸ� �����
#define		BOXSTY_ALWAYSSHOWSB		0x00100000		//	��ũ�ѹٸ� �׻� ������
//#define		BOXSTY_SOFTMENU			0x00080000		//	����Ʈ�޴��� �����
#define		BOXSTY_GRAYBACKGROUND	0x00040000		//	����� �帴�ϰ� ����


//-------------------------------------------------------------------------------------------------
//	FrmCtrl ��Ÿ���� ���� (stFrmCtrl::Base.Style)
//-------------------------------------------------------------------------------------------------
#define		FRMSTY_BORDER				0x80000000			//	������ �׵θ��� �׸�
#define		FRMSTY_THICKBORDER			0x40000000			//	�β��� ������ �׵θ��� �׸�
#define		FRMSTY_ROUNDBORDER			0x20000000			//	�𼭸��� �ձ� �׵θ��� �׸�
#define		FRMSTY_TITLE				0x08000000			//	������ ǥ����
#define		FRMSTY_LEFTTITLE			0x04000000			//	������ ����� ���ʿ� ǥ����
#define		FRMSTY_INVERSETITLE			0x02000000			//	������ �������� ǥ���� (���������� ����۾�)
#define		FRMSTY_BOLDTITLE			0x01000000			//	�����ڿ��� ����ü�� �����
#define		FRMSTY_HSCROLLBAR			0x00800000			//	���� ��ũ�ѹٸ� ǥ����
#define		FRMSTY_VSCROLLBAR			0x00400000			//	���� ��ũ�ѹٸ� ǥ����
#define		FRMSTY_WIDESCRLBAR			0x00200000			//	���� ���� ��ũ�ѹٸ� �����
#define		FRMSTY_VARSCROLLBAR			0x10000000			//	���� ���� ��ũ�� ��
#define		FRMSTY_ALWAYSSHOWSB			0x00100000			//	��ũ�ѹٸ� �׻� ������

//------------------------------------------------------------------------------
//		button control style (ButCtrl::Frame.Base.Style)
//------------------------------------------------------------------------------
#define		BUTSTY_BORDER			0x80000000		//	������ �׵θ��� �׸�
#define		BUTSTY_THICKBORDER		0x40000000		//	�β��� ������ �׵θ��� �׸�
#define		BUTSTY_ROUNDBORDER		0x20000000		//	�𼭸��� �ձ� �׵θ��� �׸�
#define		BUTSTY_TITLE			0x08000000		//	������ ǥ����
#define		BUTSTY_LEFTTITLE		0x04000000		//	������ ����� ���ʿ� ǥ����
#define		BUTSTY_INVERSETITLE		0x02000000		//	������ �������� ǥ���� (���������� ����۾�)
#define		BUTSTY_BOLDTITLE		0x01000000		//	�����ڿ��� ����ü�� �����
#define		BUTSTY_HSCROLLBAR		0x00800000		//	���� ��ũ�ѹٸ� ǥ����
#define		BUTSTY_VSCROLLBAR		0x00400000		//	���� ��ũ�ѹٸ� ǥ����
#define		BUTSTY_WIDESCRLBAR		0x00200000		//	���� ���� ��ũ�ѹٸ� �����
#define		BUTSTY_VARSCROLLBAR		FRMSTY_VARSCROLLBAR	//	0x10000000	���� ���� ��ũ�� ��
#define		BUTSTY_ALWAYSSHOWSB		0x00100000		//	��ũ�ѹٸ� �׻� ������
#define		BUTSTY_DEFAULT_BUTTON	0x00080000		//	����Ʈ ��ư
#define		BUTSTY_BOLD				0x00040000		//	����ü�� �׸�

#define		BUTSTY_INVERSE			0x00020000		//	���� Ÿ��
#define		BUTSTY_INACTIVE			0x00010000		//	�ξ�Ƽ�� Ÿ��

//------------------------------------------------------------------------------
//		check control style
//------------------------------------------------------------------------------
#define		CHKSTY_ACTIVEBORDER		0x40000000
#define		CHKSTY_RIGHTICON		0x80000000
#define		CHKSTY_BOLD				0x20000000 

//------------------------------------------------------------------------------
//	dialog control type
//------------------------------------------------------------------------------
#define		DCTYPE_NONE					0
#define		DCTYPE_BUTCTRL				1
#define		DCTYPE_CHKCTRL				2
#define		DCTYPE_EDITCTRL				3
#define		DCTYPE_ICONCTRL				4
#define		DCTYPE_LINECTRL				5
#define		DCTYPE_LISTCTRL				6
#define		DCTYPE_SELCTRL				7
#define		DCTYPE_SLOTCTRL				8
#define		DCTYPE_TEXTCTRL				9
#define		DCTYPE_GRIDCTRL				10

//------------------------------------------------------------------------------
//		return value from Dialog_KeyProcess()
//------------------------------------------------------------------------------
#define		DLGRET_ERROR			0x80000000		//	���� �߻�
#define		DLGRET_DONE		  		0x40000000		//	���̾˷α��� ��Ʈ���� Űó���� �Ͽ���
#define		DLGRET_POPUP			0x20000000		//	�˾�����Ʈ�� �������
#define		DLGRET_POPUPSELECT		0x10000000		//	�˾�����Ʈ �׸��� �����Ͽ���
#define		DLGRET_POPUPSUBSTART	0x08000000
#define		DLGRET_INDEXMASK		0x0000FFFF

//------------------------------------------------------------------------------
//		dialog style
//------------------------------------------------------------------------------
#define		DLGSTY_BORDER			0x80000000		//	������ �׵θ��� �׸�
#define		DLGSTY_THICKBORDER		0x40000000		//	�β��� ������ �׵θ��� �׸�
#define		DLGSTY_ROUNDBORDER		0x20000000		//	�𼭸��� �ձ� �׵θ��� �׸�
#define		DLGSTY_TITLE			0x08000000		//	������ ǥ����
#define		DLGSTY_LEFTTITLE		0x04000000		//	������ ����� ���ʿ� ǥ����
#define		DLGSTY_INVERSETITLE		0x02000000		//	������ �������� ǥ���� (���������� ����۾�)
#define		DLGSTY_BOLDTITLE		0x01000000		//	�����ڿ��� ����ü�� �����
#define		DLGSTY_HSCROLLBAR		0x00800000		//	���� ��ũ�ѹٸ� ǥ����
#define		DLGSTY_VSCROLLBAR		0x00400000		//	���� ��ũ�ѹٸ� ǥ����
#define		DLGSTY_WIDESCRLBAR		0x00200000		//	���� ���� ��ũ�ѹٸ� �����
#define		DLGSTY_VARSCROLLBAR		FRMSTY_VARSCROLLBAR	//	0x10000000	���� ���� ��ũ�� ��
#define		DLGSTY_ALWAYSSHOWSB		0x00100000		//	��ũ�ѹٸ� �׻� ������
//#define		DLGSTY_SOFTMENU			0x00080000		//	����Ʈ �޴��� ǥ����
#define		DLGSTY_CIRCULAR			0x00010000		//	ù��° �����۰� ������ �������� �̵��� �����ϰ� ��

//------------------------------------------------------------------------------
//		align type
//------------------------------------------------------------------------------
#define		EDITALIGN_LEFT			0x00
#define		EDITALIGN_CENTER		0x08
#define		EDITALIGN_RIGHT			0x04
#define		EDITALIGN_TOP			0x00
#define		EDITALIGN_MIDDLE		0x02
#define		EDITALIGN_BOTTOM		0x01
 
//------------------------------------------------------------------------------
//		cursor type
//------------------------------------------------------------------------------
#define		EDITCSR_NONE			0
#define		EDITCSR_VERTICAL		1
#define		EDITCSR_FULLBOX			2
#define		EDITCSR_HALFBOX			3
#define		EDITCSR_MINIBOX			4
#define		EDITCSR_CHARBLINKING	0x80
 
//------------------------------------------------------------------------------
//		edit mode
//------------------------------------------------------------------------------
#define		EDITMODE_HANGUL			0x8000			//	�ѱ��Է� ����
#define		EDITMODE_NUMBER			0x4000			//	�����Է� ����
#define		EDITMODE_SMALLENG		0x2000			//	�����Է� ����
#define		EDITMODE_LARGEENG		0x1000			//	�����Է� ����
#define		EDITMODE_SYMBOL			0x0800			//	��ȣ�Է� ����
 
//------------------------------------------------------------------------------
//		edit state
//------------------------------------------------------------------------------
#define		EDITSTAT_WAIT			0				//	���ο� ������ �Է��� ��ٸ��� ��
#define		EDITSTAT_INPUT			1				//	���ڸ� ����� �ִ� ��

//------------------------------------------------------------------------------
//		edit control stype (EidtCtrl::Frame.Base.Style)
//------------------------------------------------------------------------------
#define		EDITSTY_BORDER			0x80000000		//	������ �׵θ��� �׸�
#define		EDITSTY_THICKBORDER		0x40000000		//	�β��� ������ �׵θ��� �׸�
#define		EDITSTY_ROUNDBORDER		0x20000000		//	�𼭸��� �ձ� �׵θ��� �׸�
#define		EDITSTY_TITLE			0x08000000		//	������ ǥ����
#define		EDITSTY_LEFTTITLE		0x04000000		//	������ ����� ���ʿ� ǥ����
#define		EDITSTY_INVERSETITLE	0x02000000		//	������ �������� ǥ���� (���������� ����۾�)
#define		EDITSTY_BOLDTITLE		0x01000000		//	�����ڿ��� ����ü�� �����
#define		EDITSTY_HSCROLLBAR		0x00800000		//	���� ��ũ�ѹٸ� ǥ����
#define		EDITSTY_VSCROLLBAR		0x00400000		//	���� ��ũ�ѹٸ� ǥ����
#define		EDITSTY_WIDESCRLBAR		0x00200000		//	���� ���� ��ũ�ѹٸ� �����
#define		EDITSTY_ALWAYSSHOWSB	0x00100000		//	��ũ�ѹٸ� �׻� ������
#define		EDITSTY_VARSCROLLBAR	FRMSTY_VARSCROLLBAR	//	0x10000000	���� ���� ��ũ�� ��
#define		EDITSTY_NOCURSOR		0x00080000		//	Ŀ���� �������� ����
#define		EDITSTY_KEYBOARD		0x00040000		//	Ű������ �Է��� ���� ó����
#define		EDITSTY_AUTOCURSORMOVE	0x00020000		//	�����Է��� �� 2���� �ڵ����� Ŀ���̵���
#define		EDITSTY_BOLD			0x00010000		//	�׻� ����ü�� �����
#define		EDITSTY_ENDSYMBOL		0x00008000		//	Ȱ��ȭ�� ��� ���� ���� CRǥ�ø� ��
#define		EDITSTY_RIGHT			0x00004000		//	�����ʿ��� �Է�. (���ڸ�常 ����)
#define		EDITSTY_COMMA			0x00002000		//	3�ڸ����� ','ǥ��
#define		EDITSTY_HIDDEN			0x00001000		//	'*'�� ǥ��
#define		EDITSTY_READONLY		0x00000800		//	�б�����
#define		EDITSTY_MULTILINE		0x00000400		//	������ ����
#define		EDITSTY_ACTIVEINVERSE	0x00000200		//	���õǸ� ������ ������Ŵ
#define		EDITSTY_ACTIVEBOLD		0x00000100		//	���õǸ� ����ü�� �����
#define		EDITSTY_INVERSE			0x00000080		//	������ ������Ŵ
#define		EDITSTY_UNDERLINE		0x00000040		//	������ �׸�
#define		EDITSTY_UNDERLINEDOT	0x00000020		//	���������� �׸�

//dkjung 2009-10-21
#define		EDITSTY_TICKER			0x00000010		//	Ticker ó��

//------------------------------------------------------------------------------
//		separator type of edit control
//------------------------------------------------------------------------------
#define		EDITSEP_NONE			0x00
#define		EDITSEP_LINE			0xFF
#define		EDITSEP_DASHLINE		0xEE
#define		EDITSEP_DOTLINE			0xAA

//------------------------------------------------------------------------------
//		error code when stop
//------------------------------------------------------------------------------
#define		ERROR_NULL_POINTER			100
#define		ERROR_DEFHEAP_FULL			101
#define		ERROR_INDEX_OUT_OF_BOUNDS	102

//------------------------------------------------------------------------------
//		error code but do not stop
//------------------------------------------------------------------------------
#define		ERROR_ILLIGAL_ARGUMENT		1000
#define		ERROR_MSG_QUEUE_FULL		1001
#define		ERROR_MSG_NULL_HANDLER		1002
#define		ERROR_MSG_ILLIGAL_HANDLER	1003
#define		ERROR_MSG_PROC_FULL			1004

//------------------------------------------------------------------------------
//		font type
//------------------------------------------------------------------------------

//dkjung 2014-11-19
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#define __DEF_FONT__(__X) \
		__X(  8),		\
		__X(  9),		\
		__X( 10),		\
		__X( 11),		\
		__X( 12),		\
		__X( 14),		\
		__X( 16),		\
		__X( 18),		\
		__X( 20),		\
		__X( 22),		\
		__X( 24),		\
		__X( 26),		\
		__X( 28),		\
		__X( 30),		\
		__X( 32),		\
		__X( 34),		\
		__X( 36),		\
		__X( 38),		\
		__X( 40),		\
		__X( 42),		\
		__X( 44),		\
		__X( 46),		\
		__X( 48),		\
		__X( 50),		\
		__X( 52),		\
		__X( 54),		\
		__X( 56),		\
		__X( 58),		\
		__X( 60),		\
		__X( 62),		\
		__X( 64),		\
		__X( 66),		\
		__X( 68),		\
		__X( 72),		\
		__X( 76),		\
		__X( 80),		\
		__X( 88),		\
		__X( 84),		\
		__X( 92),		\
		__X( 96),		\
		__X(100),		\
		__X(104),		\
		__X(108),		\
		__X(114),		\
		__X(120)

typedef enum
{
	#define __DEF_FONT_ENUM(size) FONT_##size

			__DEF_FONT__(__DEF_FONT_ENUM),

	#undef  __DEF_FONT_ENUM

	FONT_10x12,
	FONT_8x10,
	ENGFONT_5x8,
	ENGFONT_7x12,
	ENGFONT_7x12B,
	ENGFONT_13x24,
	NUMFONT_7x14,
	NUMFONT_10x16

} enFont;

//------------------------------------------------------------------------------
//		graphic devicd type
//------------------------------------------------------------------------------
#define		GRDEV_SOLID				0xFF
#define		GRDEV_DOT				0xAA
#define		GRDEV_DOTDOT			0xCC
#define		GRDEV_DASH				0xF0

//------------------------------------------------------------------------------
//		icon type 
//------------------------------------------------------------------------------
#define		ICON_NONE				0xFFFF
#define		ICON_UPARROW_5x5		0x8001
#define		ICON_DOWNARROW_5x5		0x8002
#define		ICON_RIGHTARROW_5x5		0x8003
#define		ICON_LEFTARROW_5x5		0x8004
#define		ICON_LEFTARROW_4x7		0x8005
#define		ICON_RIGHTARROW_4x7		0x8006
#define		ICON_UPDOWNARROW_5x11	0x8007
#define		ICON_UPARROW_7x7		0x8008
#define		ICON_DOWNARROW_7x7		0x8009
#define		ICON_LEFTARROW_7x7		0x800A
#define		ICON_RIGHTARROW_7x7		0x800B
#define		ICON_FILLCIRCLE_5x5		0x800C
#define		ICON_SELBOXOFF_12x12_4	0x800D
#define		ICON_SELBOXON_12x12_4	0x800E
#define		ICON_CHECKBOXOFF_12x12	0x800F
#define		ICON_CHECKBOXON_12x12	0x8010		
//nexio�� ���� �߰��� ū �����ܵ�
#define		ICON_CHECKBOXOFF_16x16	0x8011
#define		ICON_CHECKBOXON_16x16	0x8012
#define		ICON_DOWNARROW_13x13	0x8013
#define		ICON_DOWNARROW_9x9		0x8014
#define		ICON_FILLCIRCLE_9x9		0x8015
#define		ICON_LEFTARROW_13x13	0x8016
#define		ICON_LEFTARROW_8x13		0x8017
#define		ICON_LEFTARROW_9x9		0x8018
#define		ICON_RIGHTARROW_13x13	0x8019
#define		ICON_RIGHTARROW_8x13	0x801A
#define		ICON_RIGHTARROW_9x9		0x801B
#define		ICON_SELBOXOFF_16x16	0x801C
#define		ICON_SELBOXON_16x16		0x801D
#define		ICON_UPARROW_13x13		0x801E
#define		ICON_UPARROW_9x9		0x801F
#define		ICON_UPDOWNARROW_9x12	0x8020
 				
//------------------------------------------------------------------------------
//		list control style
//------------------------------------------------------------------------------
#define		LISTSTY_BORDER			0x80000000		//	������ �׵θ��� �׸�
#define		LISTSTY_THICKBORDER		0x40000000		//	�β��� ������ �׵θ��� �׸�
#define		LISTSTY_ROUNDBORDER		0x20000000		//	�𼭸��� �ձ� �׵θ��� �׸�	
#define		LISTSTY_TITLE			0x08000000		//	������ ǥ����
#define		LISTSTY_LEFTTITLE		0x04000000		//	������ ����� ���ʿ� ǥ����
#define		LISTSTY_INVERSETITLE	0x02000000		//	������ �������� ǥ���� (���������� ����۾�)
#define		LISTSTY_BOLDTITLE		0x01000000		//	�����ڿ��� ����ü�� �����
#define		LISTSTY_HSCROLLBAR		0x00800000		//	���� ��ũ�ѹٸ� ǥ����
#define		LISTSTY_VSCROLLBAR		0x00400000		//	���� ��ũ�ѹٸ� ǥ����
#define		LISTSTY_WIDESCRLBAR		0x00200000		//	���� ���� ��ũ�ѹٸ� �����
#define		LISTSTY_ALWAYSSHOWSB	0x00100000		//	��ũ�ѹٸ� �׻� ������
#define		LISTSTY_VARSCROLLBAR	FRMSTY_VARSCROLLBAR	//	0x10000000	���� ���� ��ũ�� ��
#define		LISTSTY_RADIO			0x00080000		//	������ư�� �����ϰ�, �׻� �Ѱ����� ���õ�
#define		LISTSTY_CHECK			0x00040000		//	üũ�ڽ��� ������
#define		LISTSTY_RIGHTCHECK		0x00020000		//	üũ�ڽ��� �����ʿ� ǥ����
#define		LISTSTY_CIRCULAR		0x00010000		//	ù�׸�� �������׸��� ���������� �̵���
#define		LISTSTY_PAGEUPDOWN		0x00008000		//	�¿�Ű�� ���������ٿ�Ű�� ���
#define		LISTSTY_VSCROLL			0x00004000		//	������ũ���� �����ϰ� ��
#define		LISTSTY_HSCROLL			0x00002000		//	����ũ���� �����ϰ� ��
#define		LISTSTY_ICON			0x00001000		//	���ʿ� �������� ����
#define		LISTSTY_GRAYICON		0x00000800		//	���õ��� ���� �׸��� �������� ȸ������ �����
#define		LISTSTY_DETAIL			0x00000400		//	�󼼹��ڿ��� ����
#define		LISTSTY_INVERSE			0x00000200		//	���õ� �׸��� ������Ŵ
#define		LISTSTY_ROUNDINVERSE	0x00000100		//	���õ� �׸��� �ձ۰� ������Ŵ
#define		LISTSTY_BOLD			0x00000080		//	���õ� �׸��� ���ڿ��� ����ü�� �����
#define		LISTSTY_UNDERLINE		0x00000040		//	���õ� �׸� ������ �׸�
#define		LISTSTY_BOLDTEXT		0x00000020		//	��� ���ڿ��� BOLD��
#define		LISTSTY_CURSOR			0x00000010		//	���õ� �׸� ������ ������ ĥ�Ѵ�.
    
//------------------------------------------------------------------------------
//		list item status (stListItem::Status)
//------------------------------------------------------------------------------
#define		LISTITEM_HASICON		0x8000			//	�������� ������ ����. ���ʿ� ǥ��.
#define		LISTITEM_HASARROW		0x4000			//	������ ȭ��ǥ�� ����. �����ʿ� ǥ��. �˾���� �̿�
#define		LISTITEM_HASSEPARATOR	0x2000			//	�Ʒ��� �����ڸ� ����.
#define		LISTITEM_DISABLE		0x0080			//	��Ȱ��ȭ�Ǿ��ִ� ���������� ǥ��.
#define		LISTITEM_CHECKED		0x0040			//	RADIO/CHECK �Ӽ��� ���� ��� ���õǾ������� ǥ��.

#define		LISTCTRL_PLAIN			1
#define		LISTCTRL_QUERY			2

//------------------------------------------------------------------------------
//		grid control
//------------------------------------------------------------------------------
#define		GCTYPE_NONE				DCTYPE_NONE
#define		GCTYPE_BUTCTRL			DCTYPE_BUTCTRL
#define		GCTYPE_CHKCTRL			DCTYPE_CHKCTRL
#define		GCTYPE_EDITCTRL			DCTYPE_EDITCTRL
#define		GCTYPE_ICONCTRL			DCTYPE_ICONCTRL
#define		GCTYPE_LINECTRL			DCTYPE_LINECTRL
#define		GCTYPE_LISTCTRL			DCTYPE_LISTCTRL
#define		GCTYPE_SELCTRL			DCTYPE_SELCTRL
#define		GCTYPE_SLOTCTRL			DCTYPE_SLOTCTRL
#define		GCTYPE_TEXTCTRL			DCTYPE_TEXTCTRL
#define		GRDSTY_STRIPE			0x00000001			//	��Ʈ������ ��Ÿ��

//-----------------------------------------------------------------------------
//		messages : vm ==> card
//-----------------------------------------------------------------------------
#define		MSG_INIT				0
#define		MSG_EXIT				1
#define		MSG_DRAW				2
#define		MSG_CHAR				3
#define		MSG_KEY					4
#define		MSG_BUTTON				5
#define		MSG_SELECT				6
#define		MSG_POINTING			7
#define		MSG_TIMER				8
#define		MSG_SOCKET				9
#define		MSG_UART				10
#define		MSG_BATTERY				11
#define		MSG_TASK				12
#define		MSG_TICKER				13
#define		MSG_EDITCTRL			14
#define		MSG_PROGRESS			15
#define		MSG_USER				16
#define		MSG_SESSION				17	//wparam => 1: session open, 0: session close
#define		MSG_SENDTEXT			18
#define		MSG_EXTCTRL				19
#define		MSG_GRIDCTRL			20

//-----------------------------------------------------------------------------
//		sub-parameter for MSG_POINTING
//-----------------------------------------------------------------------------
#define		POINTING_DOWN			0
#define		POINTING_UP				1
#define		POINTING_MOVE			2

//-----------------------------------------------------------------------------
//		messages : param definitions
//-----------------------------------------------------------------------------
#define		SESSION_CLOSE			0
#define		SESSION_OPEN			1

#define		SESSION_PATCH_CLOSE		2
#define		SESSION_PATCH_OPEN		3

#define		SESSION_SQL_BEGIN		4
#define		SESSION_SQL_END			5
#define		SESSION_SQL_ERROR		6

// MSG_TASK WP ����
#define		TASK_SYS_CALL			1
#define		TASK_WEB_VIEW			2
#define		TASK_PUSH				3	//PUSH �޽���
#define		TASK_PUSH_CONFIG		4
#define		TASK_PUSH_APPEXIT		5	//APP ����
#define		TASK_PUSH_LOCK			6	//���� ���
#define		TASK_PUSH_UNLOCK		7	//���� ��� ����
#define		TASK_PUSH_RESET			8	//���� ����

// MSG_UART WP ����
#define		UART_BARCODE			1
#define		UART_PRINTER			2
#define		UART_CARD				3
#define		UART_CAMERA				4

//TASK_SYS_CALL �̺�Ʈ�� LP ����
#define		TASK_BARCODE			100
#define		TASK_PRINTER			101
#define		TASK_CARD				102
#define		TASK_CAMERA				103
#define		TASK_GRID_CHECK			104
#define		TASK_GRID_RESUME		105
#define		TASK_IC_CARD			106

//VPN
#define		USER_VPN_READY			100
#define		USER_VPN_REQUEST		101
#define		USER_VPN_LOGIN			102

//�ܺο��� ����Ʈ ��Ʈ��
#define		EXTCTRL_EDIT			1
#define		EXTCTRL_LIST			2

//���ڵ� Ÿ��
#define		BARCODE_BASIC			1
#define		BARCODE_IMAGE			2

//������ ��/�ٿ� �̺�Ʈ
#define		PAGE_UP					0
#define		PAGE_DOWN				1

//-----------------------------------------------------------------------------
//		Key messages 
//-----------------------------------------------------------------------------
#define		KEY_CLR_K					5	//same value as defined in keydef.h
#define		KEY_UP_K					6
#define		KEY_DOWN_K					7
#define		KEY_LEFT_K					8
#define		KEY_RIGHT_K					9
#define		KEY_LSOFT_K					10  // BlackJack jysim 2007-06-05 Ű�׼��ڵ尪 �߰�
#define		KEY_RSOFT_K					11  // BlackJack jysim 2007-06-05 Ű�׼��ڵ尪 �߰�
#define		KEY_CANCEL_K				12  // BlackJack jysim 2007-06-05 Ű�׼��ڵ尪 �߰�
#define		KEY_HOME_K					13  // BlackJack jysim 2007-06-06 Ű�׼��ڵ尪 �߰�
#define		KEY_RETURN_K				14  // BlackJack jysim 2007-06-06 Ű�׼��ڵ尪 �߰�
#define		KEY_WRETURN_K				15  // BlackJack jysim 2007-06-07 Ű�׼��ڵ尪 �߰�
#define		KEY_QRETURN_K				16  // BlackJack jysim 2007-06-07 Ű�׼��ڵ尪 �߰�

//dkjung 2007-09-12
#define		KEY_MODE_K					17  // Mode key (0:����, 1:�ѱ�, 2:����)
#define		KEY_SHIFT_K					18  // Shift key
#define		KEY_SYMBOL_K				19  // Symbol key

#define		KEY_FACE_BASE				160						
#define		KEY_FACE(X)					(KEY_FACE_BASE+X)		//���鿡 ���� �ܺι���
#define		KEY_LEFT_SIDE_BASE			192
#define		KEY_LEFT_SIDE(X)			(KEY_LEFT_SIDE_BASE+X)	//���ʿ� �ִ� �ܺ� ����
#define		KEY_RIGHT_SIDE_BASE			224
#define		KEY_RIGHT_SIDE(X)			(KEY_RIGHT_SIDE_BASE+X)	//�����ʿ� �ִ� �ܺ� ����

//-----------------------------------------------------------------------------
//		PUSH Event Type
//-----------------------------------------------------------------------------
#define		P_MAIL					1
#define		P_PIM					2
#define		P_CALL					3
#define		P_USER					4

//------------------------------------------------------------------------------
//		popup control style (PopupCtrl::Style)
//------------------------------------------------------------------------------
#define		POPSTY_PARENT			0x80000000		//	�ٸ� �˾���Ʈ���� ������ �ִ� ��Ʈ���̴�.
#define		POPSTY_CHILD			0x40000000		//	�ٸ� �˾���Ʈ�ѿ� �ҼӵǾ��ִ� ��Ʈ���̴�.
#define		POPSTY_TOP				0x00800000		//	BaseY�� Y1���� �����.
#define		POPSTY_MIDDLE			0x00400000		//	BaseY�� Y1�� Y2�� �߰����� �����.
#define		POPSTY_BOTTOM			0x00200000		//	BaseY�� Y2�� �����.
#define		POPSTY_LEFT				0x00100000		//	BaseX�� X1���� �����.
#define		POPSTY_CENTER			0x00080000		//	BaseX�� X1�� X2�� �߰����� �����.
#define		POPSTY_RIGHT			0x00040000		//	BaseX�� X2�� �����.
#define		POPSTY_TITLE			0x00020000		//	������ ����Ѵ�.
#define		POPSTY_GRAYBACKGROUND	0x00010000		//	����� �帮�� �����.
//#define		POPSTY_SOFTMENU			0x00008000		//	����Ʈ�޴��� ���´�.

#define		POPSTY_SUBMENU			0x40300000		// 	[POPSTY_CHILD | POPSTY_BOTTOM | POPSTY_LEFT)

//------------------------------------------------------------------------------
//		key process result of popup control
//------------------------------------------------------------------------------
#define		POPRET_NONE				0				//	�˾�����Ʈ�� �����ϰ� ���� ����
#define		POPRET_SUBSTART			1				//	����޴��� ������
#define		POPRET_SELECT			2				//	�˾�����Ʈ���� �׸��� �����Ͽ���
#define		POPRET_CANCEL			3				//	�˾�����Ʈ�� �����
#define		POPRET_DONE				4				//	Ŀ���̵��� �˾�����Ʈ�� Űó���� �Ͽ���
#define		POPRET_ERROR			5				//	Űó�� �� ������ �߻��Ͽ���

//------------------------------------------------------------------------------
//		whether normal item or sub item in popup control
//------------------------------------------------------------------------------
#define		POPITEM_NORMAL			0
#define		POPITEM_SUBMENU			1

//------------------------------------------------------------------------------
//		select control style (SelCtrl::Frame.Base.Style)
//------------------------------------------------------------------------------
#define		SELSTY_BORDER			0x80000000		//	������ �׵θ��� �׸�
#define		SELSTY_THICKBORDER		0x40000000		//	�β��� ������ �׵θ��� �׸�
#define		SELSTY_ROUNDBORDER		0x20000000		//	�𼭸��� �ձ� �׵θ��� �׸�
#define		SELSTY_TITLE			0x08000000		//	������ ǥ����
#define		SELSTY_LEFTTITLE		0x04000000		//	������ ����� ���ʿ� ǥ����
#define		SELSTY_INVERSETITLE		0x02000000		//	������ �������� ǥ���� (���������� ����۾�)
#define		SELSTY_BOLDTITLE		0x01000000		//	�����ڿ��� ����ü�� �����
#define		SELSTY_HSCROLLBAR		0x00800000		//	���� ��ũ�ѹٸ� ǥ����
#define		SELSTY_VSCROLLBAR		0x00400000		//	���� ��ũ�ѹٸ� ǥ����
#define		SELSTY_WIDESCRLBAR		0x00200000		//	���� ���� ��ũ�ѹٸ� �����
#define		SELSTY_ALWAYSSHOWSB		0x00100000		//	��ũ�ѹٸ� �׻� ������
#define		SELSTY_VARSCROLLBAR		FRMSTY_VARSCROLLBAR	//	0x10000000	���� ���� ��ũ�� ��
#define		SELSTY_UNDERLINE		0x00080000		//	������ �׸�
#define		SELSTY_UNDERLINEDOT		0x00040000		//	���������� �׸�
#define		SELSTY_HORIZONTAL		0x00020000
#define		SELSTY_VERTICAL			0x00010000
#define		SELSTY_SHORTNUM			0x00008000
#define		SELSTY_CIRCULAR			0x00004000
#define		SELSTY_HASTAG			0x00002000
#define		SELSTY_LEFTTAG			0x00001000
#define		SELSTY_ARROW			0x00000800
#define		SELSTY_CENTERALIGN		0x00000400		//	��� ����
#define		SELSTY_RIGHTALIGN		0x00000200
#define		SELSTY_INVERSE			0x00000100		//	Ȱ��ȭ �Ǿ����� �� ������Ŵ
#define		SELSTY_BOLD				0x00000080

//-----------------------------------------------------------------------------
//	������ ���μ����� ���ϰ� ���� (PointingProcess Return value)
//-----------------------------------------------------------------------------
#define		PPRET_NONE					0x00000000			//	���ϰ� ���� (��������)
#define		PPRET_DONE					0x00000001			//	�� �̻� ó���� �ʿ䰡 ����
#define		PPRET_UP					0x00000002			//	������ ����̽��� �������
#define		PPRET_DOWN					0x00000004			//	������ ����̽��� ��������
#define		PPRET_MOVE					0x00000008			//	������ ����̽��� ��������
#define		PPRET_SB_UP					0x00000010			//	��ũ�ѹ��� ��ȭ��ǥ�� ��ġ��
#define		PPRET_SB_DOWN				0x00000020			//	��ũ�ѹ��� �Ʒ�ȭ��ǥ�� ��ġ��
#define		PPRET_SB_LEFT				0x00000030			//	��ũ�ѹ��� ����ȭ��ǥ�� ��ġ��
#define		PPRET_SB_RIGHT				0x00000040			//	��ũ�ѹ��� ������ ȭ��ǥ�� ��ġ��
#define		PPRET_SB_PAGEUP				0x00000050			//	��ũ�ѹ��� �������� ������ ��ġ��
#define		PPRET_SB_PAGEDOWN			0x00000060			//	��ũ�ѹ��� �������ٿ� ������ ��ġ��
#define		PPRET_SB_PAGELEFT			0x00000070			//	��ũ�ѹ��� ����������Ʈ ������ ��ġ��
#define		PPRET_SB_PAGERIGHT			0x00000080			//	��ũ�ѹ��� ����������Ʈ ������ ��ġ��
#define		PPRET_SB_HBAR				0x00000090			//	���� ��ũ�ѹ� ���� ��ġ��
#define		PPRET_SB_VBAR				0x000000A0			//	���� ��ũ�ѹ� ���� ��ġ��
#define		PPRET_SB_MASK				0x000000F0			//	��ũ�ѹ� ����ũ
#define		PPRET_OUT_OF_RANGE			0x00000100			//	ĸ�Ŀ��� �ۿ� ����..

//------------------------------------------------------------------------------
//		select control flag (SelCtrl::Flag)
//------------------------------------------------------------------------------
#define		SELFLAG_ASSIGNSTRSET	0x80			//	StringSet�� ���� �����Ͽ� �����

#endif	//	GRSYSDEF_H


