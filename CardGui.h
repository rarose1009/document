/*----------------------------------------------------------------------------------
	Project Name: Smart Common middle ware
	Compiler & Virtual Machine : SMART 2.x.x
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create ����Ʈ�� ����
	2017.04.03	dkjung		v 3.1.0		: grid control ����
	2017.04.25				v 3.2.0		: MessageBox loading ���α׷��� ��� �߰�.
	2017.05.01				v 3.3.0		: tightly coupled modules ����.
	2017.05.01				v 3.4.0		: MessageBox ���� �� ����.
	2017.05.02				v 3.5.0		: �׸��� ��Ʈ�� ó�� �Ϸ�.
	2017.05.02				v 3.5.1		: �޽����ڽ� ���α׷��� ���� ����.
	2017.05.04				v 3.5.2		: �׸�����Ʈ�� �÷� ���� �ڵ� ��� ó��.
										: ��Ÿ�� ��ü ���� �߰�
	2017.05.05				v 3.5.3		: �׸�����Ʈ�� ������ ��/�ٿ� �̺�Ʈ ó��.
	2017.05.08				v 3.5.4		: �׸�����Ʈ�� ���� GridCtrl_SetIndex �Լ� �߰�.
	2017.05.12				v 3.5.5		: �׸�����Ʈ�� ���� GridCtrl_SetTitleBkColor �Լ� �߰�.
	2017.05.13				v 3.5.6		: �ؽ�Ʈ��Ʈ�� �ؽ�Ʈ EDITALIGN_MIDDLE ����Ʈ ����.
	2017.05.13				v 3.5.7		: �޽����ڽ� �ؽ�Ʈ ó�� �Լ� �߰�.
	2017.05.14				v 3.5.8		: �޽����ڽ� �ܻ� ���� ����.
	2017.05.14				v 3.5.9		: ���� �޽����ڽ� �����̴� ���� ����.
	2017.05.15				v 3.6.0		: ���� �޽����ڽ� �������� �ʵ��� oneshot ��� �߰�.
	2017.05.16				v 3.6.1		: ��� �޽��� ��� �߰�.
	2017.05.16				v 3.6.2		: PUSH ��� �޽��� ����.
	2017.05.17				v 3.6.3		: PUSH ��� �޽��� �޽����˾��� ���� ó��.
	2017.05.17				v 3.6.4		: UART �̺�Ʈ ���� ó��(������� ������ ����).
	2017.05.18				v 3.6.5		: ��� �޽��� ������ �ܻ󳲴� ���� ����.
	2017.05.22				v 3.6.7		: ��� �޽��� ����ũ��: 256 -> 1024 ����.
	2017.05.22				v 3.6.8		: ��� �޽��� Ÿ�̸� �ʱⰪ ���� ����.
	2017.05.26				v 3.6.9		: �ý��� ��ư ������ ���� �ƴѰ�쵵 ��ο�ó��.
										  (g_SysBut_PointProcess)
	2017.06.07				v 3.6.11	: �׸�����Ʈ�� ��Ʈ������ ��� �� ���� ���� �߰�.
	2017.07.23				v 3.6.13	: �׸�����Ʈ�� �ε��� ��� ��� �߰�.
	2017.08.14				v 3.6.14	: ���̺���Ʈ�� ����Ŀ�� ��Ŀ�� �̵��� ����� ���� ����.
	2017.08.17				v 3.6.15	: ���̺���Ʈ�� ������ �� �ε��� ���� api �߰�.
----------------------------------------------------------------------------------*/

#ifndef __CARDGUI_H__
#define __CARDGUI_H__

//---------------------------------------------------------------
// 		For Debugging 
//---------------------------------------------------------------

//���߽� ����>�����Ͽɼ�>Definitions�� _DEBUG ���� �� ��.
#ifndef _DEBUG

	#define VER_DEBUG
	//#define _TRACE
	
#else

	#undef VER_DEBUG
	//#error "������...."
	
#endif //Debug

//---------------------------------------------------------------
// 		Version Definitions
//---------------------------------------------------------------
#define	CG_NAME			"CardGui"
#define	CG_VERSION		"3.6.15"
#define	CG_version		3006015
#define	CG_BUILDDATE	__DATE__
#define	CG_BUILDTIME	__TIME__

//---------------------------------------------------------------
// 		Very Important Definitions 
//---------------------------------------------------------------
// dkjung 2003-08-09
// ���⿡ ����� ������� GUI ������Ʈ�� �����ϴµ�
// �ſ� �߿��� �����Դϴ�.
// ������Ʈ ���� ����. ������ ���� ũ�⸦ �����Ͻÿ�.

// �ý��� ��ư�� 10�� �̸����� ����. �ִ� ������ ���� 30���� �ø�
// miscap 2003-10-11 10->11�� ����
#define MAX_SYS_BUT			30

// ���� ī����� ��ũ�� �����ϴ� ����
#define MAX_PREV_CARD_NUM	10

// �ϴ� �켱 �ִ� ������Ʈ ������ 500 ���� ����...
#define MAX_OBJ_NUM			500

#define MAX_CARD_NAME_LEN	32

// �޽��� �ڽ� ����
#define	MESSAGE				0x00000001
#define	CONFIRM_YESNO		0x00000002
#define	CONFIRM_OK			0x00000004
#define	WARNING_YESNO		0x00000008
#define	WARNING_OK			0x00000010
#define	ERROR_YESNO			0x00000020
#define	ERROR_OK			0x00000040
#define	PROGRESS_TEXT		0x00000080
#define	PROGRESS_BAR		0x00000100
#define	PROGRESS_LOADING	0x00000200
#define	PUSH_OK				0x00000400

#define	TITLE_MESSAGE		0x00000101
#define	TITLE_CONFIRM_YESNO	0x00000102
#define	TITLE_CONFIRM_OK	0x00000104
#define	TITLE_WARNING_YESNO	0x00000108
#define	TITLE_WARNING_OK	0x00000110
#define	TITLE_ERROR_YESNO	0x00000120
#define TITLE_ERROR_OK		0x00000140


#define	ERROR_MSG			0x00000020
#define	CONFIRM_PRINTNO		0x00000040
// ���� ǥ�� �ڽ��� X, Y, Width, Height
#define	BAR_X				DMS_X(500)
#define	BAR_Y				DMS_Y(550)
#define	BAR_WIDTH			DMS_X(250)
#define	BAR_HEIGHT			DMS_Y(50)
#define	DRAW_PROGRESS_TOT   10

#define BASE_ID				(MAX_OBJ_NUM + 100)


//�޼����ڽ� �Ҹ� ���� �� sleep �ð�
#define MSG_SLEEP 20

//ȭ�齺Ÿ�� ���̾�α�, �ؽ�Ʈ, ��ư
#define  PDA_BORDERTHICKNESS  1

// Global �������� ���Ǵ� ���̵�.
// SYSTEM ����...
enum
{
	GLOBAL_BASE = BASE_ID,
	
	// �޽��� �ڽ�
	MB_OK,
	MB_EXIT,
	
	// �ý��� ��ư
	GID_EXIT,
	
	// ���� ���
	GID_SOCK_RETRY,
	GID_SOCK_CANCEL,
	GID_SOCK_ERROR,
	//���� �ý��۹�ư
	GID_HOME,
	GID_MENU,
	GID_KEYBOARD,
	GID_SCREEN,
	GID_CMMNWK,
	GID_PREV,
	GID_VMEXIT,

	//...,
	
	// ������ ��ġ�� �� �� �ִ�.
	GLOBAL_END	
} GLOBAL_ID_TYPE;

// Local �������� ���Ǵ� ���̵�.
#define LOCAL_BASE			(GLOBAL_END + 100)
#define USER_BASE			(LOCAL_BASE + 0)
#define USER_ID				(USER_BASE  + 1)

// USER ����...
// �׻� ��ư ���̵� ���� ����Ǿ�� �Ѵ�.
// ī�峻���� ���� ��ư ���̵� ����
#define BEGIN_BUTTON_ID()					\
		enum								\
		{									\
			BUT_ID_STRAT = USER_ID+1,
			
#define DEF_BUTTON_ID(id) id,
#define END_BUTTON_ID()						\
			BUT_ID_END						\
		};

// ī�峻���� ���� ������Ʈ(��Ʈ��) ���̵� ����
#define BEGIN_OBJECT_ID()					\
		enum								\
		{									\
			OBJ_ID_STRAT = BUT_ID_END+1,
#define DEF_OBJECT_ID(id) id,	
#define END_OBJECT_ID()						\
			OBJ_ID_END						\
		};

/*
	// <��� ���>
	
	// ���� 1
	//---------------------------------------------------------------
	// �׻� ��ư ���̵� ���� ����Ǿ�� �Ѵ�.
	
	// ī�峻���� ���� ��ư ���̵� ����
	BEGIN_BUTTON_ID()
		DEF_BUTTON_ID ( ID_YES )
		DEF_BUTTON_ID ( ID_NO )
		DEF_BUTTON_ID ( ID_HOME )
		DEF_BUTTON_ID ( ID_EXIT )
		DEF_BUTTON_ID ( ID_SR_SOCK_RETRY )
		DEF_BUTTON_ID ( ID_COMM_FAIL )
	END_BUTTON_ID()
	
	// ī�峻���� ���� ��Ʈ�� ���̵� ����
	BEGIN_OBJECT_ID()
		DEF_OBJECT_ID ( EDT_ID )
		DEF_OBJECT_ID ( EDT_PW )
	END_OBJECT_ID()

	// ���� 2
	//---------------------------------------------------------------
	// ī�峻���� ���� ��ư ���̵� ����
	enum
	{
		ID_OK = USER_ID+1,
		ID_EXIT,
		
		//...,
		
		ID_END	// ���� ���̴�.
	};
	
	// ī�峻���� ���� ��Ʈ�� ���̵� ����
	enum
	{
		EDT_ID = ID_END+1,
		EDT_PW,

		//...,
		
		CTR_ID_END	// ���� ���̴�.
	};
*/

#define FREE(x) \
		{\
			if(x)\
			{\
				MEM_DEL((void*)x);\
				x = NULL;\
			}\
		}

//debug and trace
#ifdef VER_DEBUG

	#define	M(msg) Print(#msg,0,0,0)
	#define	PRINT(fmt,a,b,c) Print(fmt,(quad)(a),(quad)(b),(quad)(c))

	#define _MSG_ASSERT_
	#ifdef  _MSG_ASSERT_	
		#define ASSERT(a)	\
		{					\
			if(!(a))		\
			{				\
				char szMsgStr[64];\
				SPRINT(szMsgStr, "\"%s\"\n%d ���ο��� ���� �߻�.",__FILE__,__LINE__,0);\
				MessageBoxEx (ERROR_OK, szMsgStr);\
				VM_AppEnd();\
			}\
		}
	#else
		#define ASSERT(a)	\
		{					\
			if(!(a))		\
			{				\
				Print("[+]##################[ ASSERT ]##################[+]",0,0,0);\
				Print("ASSERT : \" %s - %d \" ���� ���� �߻�.",(quad)__FILE__,(quad)__LINE__,0);\
				Print("[+]##################[ ASSERT ]##################[+]",0,0,0);\
				VM_AppEnd();\
			}\
		}
	#endif // 
			
	#ifdef _TRACE
		#define	TRACE(a,b,c,d) Print("TRACE :: " #a,(quad)(b),(quad)(c),(quad)(d))
	#else
		#define	TRACE(a, b, c, d)
	#endif //_TRACE
	
	#define PROGRESS_DUMP(a)	PROGRESS_SetDumpFile(a)
	
#else

	#define	M(msg)
	#define	PRINT(fmt,a,b,c)
	
	#define	TRACE(a, b, c, d)
	#define	ASSERT(a)
	#define PROGRESS_DUMP(a)
	
#endif //VER_DEBUG

//������ ��Ÿ�ӿ� ��� ��.
#define VERIFY(a)	\
{					\
	if(!(a))		\
	{				\
		Print("[+]##################[ VERIFY ]##################[+]",0,0,0);\
		Print("VERIFY : \" %s - %d \" ���� ���� �߻�.",(quad)__FILE__,(quad)__LINE__,0);\
		Print("[+]##################[ VERIFY ]##################[+]",0,0,0);\
		VM_AppEnd();\
	}\
}

#define	SPRINT(buf,fmt,a,b,c) Str_Printf((buf),fmt,(quad)(a),(quad)(b),(quad)(c))

//---------------------------------------------------------------
// 		stdio.h
//---------------------------------------------------------------
#define malloc 				Mem_Alloc
#define free 				Mem_Free
#define memcpy(a, b, c)		Mem_Cpy ((byte*)(a), (byte*)(b), (c))
#define memcmp(a, b, c)		Mem_Cmp ((byte*)(a), (byte*)(b), (c))
#define memset(a, b, c)		Mem_Set ((byte*)(a), (b), (c))
#define strcpy				Str_Cpy
#define strcat				Str_Cat
#define strcmp				Str_Cmp
#define strlen				Str_Len
#define strncmp 			Str_NCmp
#define itoa				Str_ItoA
#define atoi				Str_AtoI
#define sprintf				g_Sprintf

#define _ALNUM   			0x00000001
#define _ALPHA   			0x00000002
#define _CNTRL   			0x00000004
#define _DIGIT   			0x00000008
#define _GRAPH   			0x00000010
#define _LOWER   			0x00000020
#define _PRINT   			0x00000040
#define _PUNCT   			0x00000080
#define _BLANK   			0x00000100
#define _UPPER   			0x00000200
#define _HEX  	 			0x00000400

const quad _ctype[128] =
{
	0x004, 0x004, 0x004, 0x004, 0x004, 0x004, 0x004, 0x004,
	0x004, 0x104, 0x104, 0x104, 0x104, 0x104, 0x004, 0x004,
	0x004, 0x004, 0x004, 0x004, 0x004, 0x004, 0x004, 0x004,
	0x004, 0x004, 0x004, 0x004, 0x004, 0x004, 0x004, 0x004,
	0x140, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0,
	0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0,
	0x459, 0x459, 0x459, 0x459, 0x459, 0x459, 0x459, 0x459,
	0x459, 0x459, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0,
	0x0D0, 0x653, 0x653, 0x653, 0x653, 0x653, 0x653, 0x253,
	0x253, 0x253, 0x253, 0x253, 0x253, 0x253, 0x253, 0x253,
	0x253, 0x253, 0x253, 0x253, 0x253, 0x253, 0x253, 0x253,
	0x253, 0x253, 0x253, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x0D0,
	0x0D0, 0x473, 0x473, 0x473, 0x473, 0x473, 0x473, 0x073,
	0x073, 0x073, 0x073, 0x073, 0x073, 0x073, 0x073, 0x073,
	0x073, 0x073, 0x073, 0x073, 0x073, 0x073, 0x073, 0x073,
	0x073, 0x073, 0x073, 0x0D0, 0x0D0, 0x0D0, 0x0D0, 0x004
};

#define isalnum(c) (_ctype[c] & _ALNUM ) // 'a'-'z', 'A'-'Z', '0'-'9'
#define isalpha(c) (_ctype[c] & _ALPHA ) // 'a'-'z', 'A'-'Z'
#define iscntrl(c) (_ctype[c] & _CNTRL ) // 0-31, 127
#define isdigit(c) (_ctype[c] & _DIGIT ) // '0'-'9'
#define isgraph(c) (_ctype[c] & _GRAPH ) // '!'-'~'
#define islower(c) (_ctype[c] & _LOWER ) // 'a'-'z'
#define isprint(c) (_ctype[c] & _PRINT ) // ' '-'~'
#define ispunct(c) (_ctype[c] & _PUNCT ) // !alnum && !cntrl && !space
#define isspace(c) (_ctype[c] & _BLANK ) // HT, LF, VT, FF, CR, ' '
#define isupper(c) (_ctype[c] & _UPPER ) // 'A'-'Z'
#define isxdigit(c)(_ctype[c] & _HEX )   // '0'-'9', 'a'-'f', 'A'-'F'
#define isascii(c) (c < 128)
#define toupper(c) ((c >= 'a' && c <= 'z') ? c - 32: c)
#define tolower(c) ((c >= 'A' && c <= 'Z') ? c + 32: c)

/*
#define isalpha(c) ((c >= 'a' & c <= 'z') | (c >= 'A' & c <= 'Z'))
#define isupper(c) (c >= 'A' & c <= 'Z')
#define islower(c) (c >= 'a' & c <= 'z')
#define isdigit(c) (c >= '0' & c <= '9')
#define isspace(c) (c == ' ' | c == '\t' | c == '\n')
*/

//---------------------------------------------------------------
// 		Useful Macros 
//---------------------------------------------------------------
#define MAX(a, b) 			(((a) > (b)) ? (a) : (b))
#define MIN(a, b) 			(((a) < (b)) ? (a) : (b))
#define SWAP(a, b)			{a^=b; b^=a; a^=b;}
#define MATCH(a, b)			(strcmp((char*)(a), (char*)(b))==0)
#define LMATCH(a, b, n)		(memcmp((byte*)(a), (byte*)(b), (n))==0)
#define IS_NULL(a)			((a)[0]=='\0')

// This macro computes the offset, in bytes, of a specified member
// of a specified structure or union type.
#define FPOS(type, member)	((quad) &(((type *) 0)->member))

// This macro computes the size, in bytes, of a specified member
// of a specified structure or union type.
#define FSIZ(type, member)	sizeof(((type *) 0)->member)

#define FLIPW(a) 			( (((word)(a)[0]) * 256) + (a)[1] )
#define FLOPW(a, val)		{(a)[0] = ((val) / 256); (a)[1] = ((val) & 0xFF)}
							
// RND rounds a number up to the nearest multiful of n.							
#define RND(x, n)			((((x) + ((n)-1)) / (n)) * (n))

// Increment a value, but saturate it at its maximum positive value, do not
// let it wrap back to 0 (unsigned) or negative (signed).
#define INC_SAT(val)		( val = ((val)+1 > (val))? (val)+1 : (val) )

// Increment a value, but return to zero at its maximum positive value.
#define INC_MAX(val, max)	( val = ( ((val)+1)%(max) ) )

#define MAX_NUM(x, n) 		( (quad)((x) % (n))? ( ((x) / (n)) + 1 ) : ( (x) / (n) ) )

// Return the number of element in an array.
#define ARR_SIZE(a)			( sizeof( (a) ) / sizeof( ((a)[0]) ) )

#define	LO_WORD(X)			(byte)((X)&0x00FF)
#define	HI_WORD(X)			(byte)(((X)&0xFF00)>>8)
#define	LO_QUAD(X)			(word)((X)&0x0000FFFF)
#define	HI_QUAD(X)			(word)(((X)&0xFFFF0000)>>16)
#define	MK_WORD(A,B)		(word)((B<<8)&0xFF00|LO_WORD(A)) 
#define	MK_QUAD(A,B,C,D)	((quad)(((quad)MK_WORD((A),(B)))<<16|LO_QUAD(MK_WORD((C),(D)))))

#define	MAKE_RGB(r, g, b) ( ( ( (unsigned long)r << 8 ) & 0x0000f800) | \
							( ( (unsigned long)g << 3 ) & 0x000007e0) | \
							( ( (unsigned long)b >> 3 ) & 0x0000001f)  )

#define MAKE_8_16(B) 	( ((((long)B << 8) & 0xc000 ) | ( B & 0x20 ?  0x3800 : 0x0000) ) | \
						( ( ((long)B << 6) & 0x0600 ) | ( B & 0x04 ?  0x01e0 : 0x0000) ) | \
						( ( ((long)B << 3) & 0x0010 ) | ( B & 0x01 ?  0x000f : 0x0000) ) )
						
#define QUAD_TO_VM_QUAD(X)	(	(( (unsigned long)(X) & 0x000000ff)<<24) |	\
								(( (unsigned long)(X) & 0x0000ff00)<<8)  |	\
								(( (unsigned long)(X) & 0x00ff0000)>>8)  |	\
								(( (unsigned long)(X) & 0xff000000)>>24)	\
							)

#define VM_QUAD_TO_QUAD(X)	QUAD_TO_VM_QUAD(X)

#define WORD_TO_VM_WORD(X)	(	(( (unsigned short)(X) & 0x00ff) <<8) |		\
								(( (unsigned short)(X) & 0xff00) >>8)		\
							)

#define VM_WORD_TO_WORD(X)	WORD_TO_VM_WORD(X)
					

//---------------------------------------------------------------
//		Color Codes (16 bit)
//		http://www.rapidtables.com/web/color ����
//---------------------------------------------------------------
#define		BLACK			MAKE_RGB(0, 0, 0)
#define		DEEPBLUE		MEDIUMBLUE
#define		CYAN			MAKE_RGB(0, 255, 255)
#define		TEAL			MAKE_RGB(0,128,128)
//#define		DLG_TBKCOLOR	MAKE_8_16(71)
#define		LIGHTCYAN		MAKE_RGB(224,255,255)
//#define		LIGHTRED		MAKE_8_16(228)
//#define		LIGHTMAGENTA	MAKE_8_16(235)
//#define		LIGHTORANGE		MAKE_8_16(250)
#define		WHITE			MAKE_RGB(255, 255, 255)
//#define		BATANG			MAKE_8_16(222)
#define		BACKTAP			MAKE_RGB(98, 94, 59)
#define		OUTLINE			MAKE_RGB(163, 175, 145)
#define		THINMAGENTA		MAKE_RGB(218, 212, 194)
#define		TABTWO			MAKE_RGB(171, 220, 65)
#define		TABTHREE		MAKE_RGB(255, 230, 157)
#define		TABFOUR			MAKE_RGB(255, 255, 99)
#define		THICKGREEN		MAKE_RGB(23, 39, 8)
#define		HWANGTO 		MAKE_RGB(255, 153, 0)
#define		SHINNYBLUE 		MAKE_RGB(232, 242, 247)
#define		BRIGHTGRAY 		MAKE_RGB(221, 221, 221)
#define		BRIGHTPINK 		MAKE_RGB(255, 215, 178)
#define		BRIGTHSKY 		MAKE_RGB(224, 244, 255)
#define		PINKLADY 		MAKE_RGB(255, 102, 255)
#define		BLUEOCEAN 		MAKE_RGB(144, 217, 255)
#define		REDSHINE 		MAKE_RGB(255, 204, 204)
#define		GRAYTONE 		MAKE_RGB(68, 68, 68)
#define		THICKBLUE 		MAKE_RGB(0, 146, 224)
#define		THEBLUE     	MAKE_RGB(0, 0, 255)

#define 	DARKCYAN		MAKE_RGB(0, 139, 139)
#define 	AQUA			CYAN

//white
#define		MINTCREAM		MAKE_RGB(245,255,250)

//red
#define		LIGHTSALMON		MAKE_RGB(255,160,122)
#define		SALMON			MAKE_RGB(250,128,114)
#define		DARKSALMON		MAKE_RGB(233,150,122)
#define		LIGHTCORAL		MAKE_RGB(240,128,128)
#define		INDIANRED		MAKE_RGB(205,92,92)
#define		CRIMSON			MAKE_RGB(220,20,60)
#define		FIREBRICK		MAKE_RGB(178,34,34)
#define		RED				MAKE_RGB(255,0,0)
#define		DARKRED			MAKE_RGB(139,0,0)
//#define		TOMATO			MAKE_RGB(255,99,71)
//#define		ORANGERED		MAKE_RGB(255,69,0)
//#define		PALEVIOLETRED	MAKE_RGB(219,112,147)

//blue
#define		ALICEBLUE		MAKE_RGB(240,248,255)
#define		POWDERBLUE		MAKE_RGB(176,224,230)
#define		LIGHTBLUE		MAKE_RGB(173,216,230)
#define		LIGHTSKYBLUE	MAKE_RGB(135,206,250)
#define		SKYBLUE			MAKE_RGB(135,206,235)
#define		DEEPSKYBLUE		MAKE_RGB(0,191,255)
#define		LIGHTSTEELBLUE	MAKE_RGB(176,196,222)
#define		DODGERBLUE		MAKE_RGB(30,144,255)
#define		CORNFLOWERBLUE	MAKE_RGB(100,149,237)
#define		STEELBLUE		MAKE_RGB(70,130,180)
#define		CADETBLUE		MAKE_RGB(95,158,160)
#define		MEDIUMSLATEBLUE	MAKE_RGB(123,104,238)
#define		SLATEBLUE		MAKE_RGB(106,90,205)
#define		DARKSLATEBLUE	MAKE_RGB(72,61,139)
#define		ROYALBLUE		MAKE_RGB(65,105,225)
#define		BLUE			MAKE_RGB(0,0,255)
#define		MEDIUMBLUE		MAKE_RGB(0,0,205)
#define		DARKBLUE		MAKE_RGB(0,0,139)
#define		NAVY			MAKE_RGB(0,0,128)
#define		MIDNIGHTBLUE	MAKE_RGB(25,25,112)
#define		BLUEVIOLET		MAKE_RGB(138,43,226)
//#define		INDIGO			MAKE_RGB(75,0,130)

//green
#define		LAWNGREEN			MAKE_RGB(124,252,0)
#define		CHARTREUSE			MAKE_RGB(127,255,0)
#define		LIMEGREEN			MAKE_RGB(50,205,50)
#define		LIME				MAKE_RGB(0.255.0)
#define		FORESTGREEN			MAKE_RGB(34,139,34)
#define		GREEN				MAKE_RGB(0,128,0)
#define		DARKGREEN			MAKE_RGB(0,100,0)
#define		GREENYELLOW			MAKE_RGB(173,255,47)
//#define		YELLOWGREEN			MAKE_RGB(154,205,50)
#define		SPRINGGREEN			MAKE_RGB(0,255,127)
#define		MEDIUMSPRINGGREEN	MAKE_RGB(0,250,154)
#define		LIGHTGREEN			MAKE_RGB(144,238,144)
#define		PALEGREEN			MAKE_RGB(152,251,152)
#define		DARKSEAGREEN		MAKE_RGB(143,188,143)
#define		MEDIUMSEAGREEN		MAKE_RGB(60,179,113)
#define		LIGHTSEAGREEN		MAKE_RGB(32,178,170)
#define		SEAGREEN			MAKE_RGB(46,139,87)
//#define		OLIVE				MAKE_RGB(128,128,0)
#define		DARKOLIVEGREEN		MAKE_RGB(85,107,47)
#define		OLIVEDRAB			MAKE_RGB(107,142,35)

//yellow
#define		YELLOW			MAKE_RGB(255,255,0)
#define		LIGHTYELLOW		MAKE_RGB(255,255,224)
//#define		GREENYELLOW		MAKE_RGB(173,255,47)
#define		YELLOWSKIN		MAKE_RGB(242,223,269)
#define		YELLOWPUPP		MAKE_RGB(255,204,99)
#define		YELLOWORANGE    MAKE_RGB(255,204,153)
#define		YELLOWGREEN     MAKE_RGB(154,205,50)
#define		OLIVE     		MAKE_RGB(128,128,0)
#define		LEMONCHIFFON	MAKE_RGB(255,250,205)

//orange
#define		CORAL			MAKE_RGB(255,127,80)
#define		TOMATO			MAKE_RGB(255,99,71)
#define		ORANGERED		MAKE_RGB(255,69,0)
#define		GOLD			MAKE_RGB(255,215,0)
#define		ORANGE			MAKE_RGB(255,165,0)
#define		DARKORANGE		MAKE_RGB(255,140,0)
#define		LIGHTORANGE		MAKE_RGB(255,200,120)

//gray/grey
#define		GRAY	 		MAKE_RGB(128, 128, 128)
#define		DARKGRAY		MAKE_RGB(169,169,169)
#define		LIGHTGRAY		MAKE_RGB(211,211,211)
#define		GAINSBORO		MAKE_RGB(220,220,220)
#define		SILVER		    MAKE_RGB(192,192,192)
#define		DIMGRAY		    MAKE_RGB(105,105,105)
#define		LIGHTSLATEGRAY  MAKE_RGB(119,136,153)
#define		SLATEGRAY  		MAKE_RGB(112,128,144)
#define		DARKSLATEGRAY  	MAKE_RGB(47,79,79)

//purple
#define		LAVENDER		MAKE_RGB(230,230,250)
#define		LAVENDERBLUSH	MAKE_RGB(255,240,245)
#define		THISTLE			MAKE_RGB(216,191,216)
#define		PLUM			MAKE_RGB(221,160,221)
#define		VIOLET			MAKE_RGB(238,130,238)
#define		ORCHID			MAKE_RGB(218,112,214)
#define		FUCHSIA			MAKE_RGB(255,0,255)
#define		MAGENTA			MAKE_RGB(255,0,255)
#define		MEDIUMORCHID	MAKE_RGB(186,85,211)
#define		MEDIUMPURPLE	MAKE_RGB(147,112,219)
//#define		BLUEVIOLET		MAKE_RGB(138,43,226)
#define		DARKVIOLET		MAKE_RGB(148,0,211)
#define		DARKORCHID		MAKE_RGB(153,50,204)
#define		DARKMAGENTA		MAKE_RGB(139,0,139)
#define		PURPLE			MAKE_RGB(128,0,128)
#define		INDIGO			MAKE_RGB(75,0,130)

//brown
#define		CORNSILK		MAKE_RGB(255,248,220)
#define		BLANCHEDALMOND	MAKE_RGB(255,235,205)
#define		BISQUE			MAKE_RGB(255,228,196)
#define		NAVAJOWHITE		MAKE_RGB(255,222,173)
#define		WHEAT			MAKE_RGB(245,222,179)
#define		BURLYWOOD		MAKE_RGB(222,184,135)
#define		TAN				MAKE_RGB(210,180,140)
#define		ROSYBROWN		MAKE_RGB(188,143,143)
#define		SANDYBROWN		MAKE_RGB(244,164,96)
#define		GOLDENROD		MAKE_RGB(218,165,32)
#define		PERU			MAKE_RGB(205,133,63)
#define		CHOCOLATE		MAKE_RGB(210,105,30)
#define		SADDLEBROWN		MAKE_RGB(139,69,19)
#define		SIENNA			MAKE_RGB(160,82,45)
#define		BROWN			MAKE_RGB(165,42,42)
#define		MAROON			MAKE_RGB(128,0,0)

//pink
#define		PINK				MAKE_RGB(255,192,203)
#define		LIGHTPINK			MAKE_RGB(255,182,193)
#define		HOTPINK				MAKE_RGB(255,105,180)
#define		DEEPPINK			MAKE_RGB(255,20,147)
#define		PALEVIOLETRED		MAKE_RGB(219,112,147)
#define		MEDIUMVIOLETRED		MAKE_RGB(199,21,133)

//----------------------------------------
//		Macro function For CardGui
//----------------------------------------
#define hCurDlg					theApp.m_hDlg
#define hChildDlg				theApp.m_hChildDlg
#define nDlgCtrlSeq				theApp.m_nDlgObjCurId
#define nDlgCtrlNum				theApp.m_nDlgObjNum
#define nSlfCtrlNum				theApp.m_nSlfObjNum
#define GetObjIndex()			nDlgCtrlSeq
#define IsMessageBox()			(theApp.m_hMsgboxDlg != 0)
#define IsNormalMessageBox()	(theApp.m_bNormalMsgFlag == TRUE)
#define IsPopup()				IsNormalMessageBox()

#define SetCtrlIndex(a)\
		{\
			long nId=0;\
			nId = (((a)<<16)&0xFFFF0000);\
			nId |= (nDlgCtrlSeq&0x0000FFFF);\
			a = nId;\
		}

#define GetCtrlIndex(a) ((a)&0x0000FFFF)
		
#define GetCurhDlg()	hCurDlg
#define GetChildDlg()	hChildDlg

#define CHILD_FR_MODE	0		// ���׶��� ���
#define CHILD_BK_MODE	1		// ��׶��� ���
#define SetChildDlgMode(mode)												\
		{																	\
			if (theApp.m_hChildDlg!=0 || theApp.m_hChildDlgBak!=0)			\
			{																\
				switch (mode)												\
				{															\
					case CHILD_FR_MODE:										\
						theApp.m_hChildDlg = theApp.m_hChildDlgBak;			\
						theApp.m_hChildDlgBak = 0;							\
						break;												\
					case CHILD_BK_MODE:										\
						theApp.m_hChildDlgBak = theApp.m_hChildDlg;			\
						theApp.m_hChildDlg = 0;								\
				}															\
			}																\
		}
		
#define CREATE_CHILD_DLG()													\
		{																	\
			theApp.m_hChildDlg = Dialog_CreateObject();						\
			theApp.m_hChildDlgBak = 0;										\
		} 
		
#define DELETE_CHILD_DLG() 													\
		{																	\
			if (theApp.m_hChildDlg)											\
				Dialog_DeleteObject ( theApp.m_hChildDlg );					\
			else if (theApp.m_hChildDlgBak)									\
				Dialog_DeleteObject ( theApp.m_hChildDlgBak );				\
			theApp.m_hChildDlg = 0;											\
			theApp.m_hChildDlgBak = 0;										\
		}
		
#define	REVERSE(a,b)	g_Reverse((char*)a,b)
#define Sleep(time)		VmSleep(time/10)

#ifndef MessageBox

/*
	#define	MessageBox(a,b,c,d,e,f)\
			{\
				g_MessageBox(a,b,c,d,e,f);\
				Dialog_Draw(theApp.m_hMsgboxDlg, TRUE);\
				GrDev_Refresh();\
			}
			
	#define CloseMessageBox()	g_Close_SubDlg()
	#define TimeMessage(time, message)\
			{\
				MessageBox(MESSAGE, message, 0, 0, 0, 0);\
				VmSleep((time)/10);\
				g_Close_SubDlg ();\
			}
*/

	#define	MessageBox(a,b,c,d,e,f)		MessageBoxEx(a,b)
	#define CloseMessageBox 			CloseMessageBoxEx
	#define Toast(time, message)\
			{\
				MessageBox(MESSAGE, message, 0, 0, 0, 0);\
				VmSleep((time)/10);\
				g_Close_SubDlg ();\
			}

	// dkjung 2004-02-05
	// ���� �߰��� ��� ����� �Ǵ� �޽��� �ڽ�
	#define MessageBoxExPos(Dy, Type, Msg) 		MsgBox(Dy, Type, Msg)
	#define MessageBoxEx(Type, Msg) 			MsgBox(0, Type, Msg)
	#define MessageBoxTitle(Type, Ttl, Msg) 	MsgBoxEx(0, Type, Ttl, Msg)
	
	#define CloseMessageBoxEx 		g_Close_SubDlg
	#define SetMessageBoxText(txt)	g_SetMessgeText(txt)
	
	//arc progress and % text													WHITE	LIGHTGREEN
	#define DRAW_PROGRESS(x, y, w, h, nCur, nMax) PROGRESS_DrawArc(x, y, w, h, DEEPBLUE, theDevInfo.m_nFontType, nCur, nMax)
	

	#define DRAW_TXT_PROGRESS(x, y, w, h, nCur, nMax, TextX, Text, TextColor, FillColor)\
			{\
				GrDev_ClearRect (x, y, ((x)+(w)), ((y)+(h)));\
				GrDev_DrawRect ( x, y, ((x)+(w)), ((y)+(h)), BLUE );\
				GrDev_FillRect ( ((x)+2), ((y)+2), ((x)+2+((nCur)*((w)-4))/(nMax)), ((y)+(h)-2), FillColor );\
				GrDev_DrawRect ( ((x)+2), ((y)+2), ((x)+2+((nCur)*((w)-4))/(nMax)), ((y)+(h)-2), BLACK );\
				GrDev_SetBkMode (1);\
				GrDev_SetTextColor (TextColor);\
				GrDev_WriteStr ( ((x)+(TextX)), ((y)+((h)-11)/2), Text, theDevInfo.m_nFontType );\
				GrDev_Refresh ();\
			}

	// dkjung 2003-07-15
	// �÷��� �ؽ�Ʈ ��ġ�� ���Ҷ� ���.
	#define TEST_PROGRESS(Text, TextColor, FillColor)\
			{\
				long i, n;\
				char szStr[32];\
				MessageBoxEx (MESSAGE, "���α׷����� �׽���.");\
				n = 10000;\
				if (Text != NULL)\
					for (i=0; i<n; i++)\
					{\
						SPRINT (szStr, "%d/%d %s", i+1, n, Text);\
						DRAW_TXT_PROGRESS (BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, i+1, n, 30, szStr, TextColor, FillColor);\
					}else\
					for (i=0; i<n; i++)\
					{\
						SPRINT (szStr, "%d%%", (((i+1)*100)/(n)), 0, 0);\
						DRAW_TXT_PROGRESS (BAR_X, BAR_Y, BAR_WIDTH, BAR_HEIGHT, i+1, n, BAR_WIDTH/2, szStr, TextColor, FillColor);\
					}\
				CloseMessageBox ();\
			}
#else
		#error "MessageBox module(MessageBox.h) is included already."
#endif // MessageBox

// ������Ʈ �޸� ���� �Ҵ�
#define DLGOBJ_NEW_MEM(a, b) 	NewDlgObj (&a, b) 
#define DLGOBJ_DEL_MEM(a) 		{DelDlgObj (&a); a=NULL;} 

#define SET_DLG_RES(f, nId,nType,x,y,w,h,dx,dy,Rem,Add,FrColor,BkColor,nVal,pBuf0,pBuf1,pBuf2)\
		{\
			SetDlgRes (&f, nType,x,y,w,h,dx,dy,Rem,Add,FrColor,BkColor,((nVal<<16)|nId),pBuf0,pBuf1,pBuf2);\
		}
		
#define SIZEOF(a) ( sizeof( (a) ) / sizeof( ((a)[0]) ) )
#define CREATE_DIALOG_OBJECT(pObj, nObjNum) {InitDialog();CreateDlgObject(pObj, nObjNum);} 
#define CREATE_GLOBAL_BUTTON(a) 	SysButCreate((sizeof(a)/sizeof(a[0])), a)
#define CREATE_DIALOG(pObj) CREATE_DIALOG_OBJECT(pObj, SIZEOF(pObj))

// ���̾�α׿� ���ӵ� ��Ʈ���� ������ ��� ��.
#define Get_hDlgCtrlByIndex(idx)	DlgCtrl_GetHandle(GetCurhDlg(), idx)
#define Get_hDlgCtrlByID(id)		Get_hDlgCtrlFromID(id)
#define Get_iDlgCtrlByID(id)		Get_iDlgCtrlFromID(id)

// ���̾�α׿� ���ӵ��� ���� ��Ʈ���� �ڵ��� ��� ��.
#define Get_hSlfCtrlByID(id)		Get_hSlfCtrlFromID(id)

#define SET_EVENT(msg,wp,lp)\
		{\
			theApp.m_MsgType = msg;\
			theApp.m_wParam = wp;\
			theApp.m_lParam = lp;\
		}
		
#define CLR_EVENT() theApp.m_MsgType = 0

#define EVENT_HANDLER(msg,wp,lp)\
		{\
			PreDispatchEvent(msg,wp,lp);\
			switch (theApp.m_MsgType)\
			{\
				case MSG_INIT:OnInit(theApp.m_wParam);GrDev_Refresh();break;\
				case MSG_CHAR:OnChar(theApp.m_wParam);EvtDraw();break;\
				case MSG_KEY:OnKey(theApp.m_wParam);EvtDraw();break;\
				case MSG_TIMER:OnTimer(theApp.m_wParam);break;\
				case MSG_POINTING:\
					 OnPointing(theApp.m_wParam,(long)(theApp.m_lParam & 0xFFFF),(long)(theApp.m_lParam >> 16));\
					 GrDev_Refresh();\
					 break;\
				case MSG_BUTTON:OnButton(theApp.m_wParam);EvtDraw();break;\
				case MSG_DRAW:OnDraw();break;\
				case MSG_SELECT:OnSelect(theApp.m_lParam);EvtDraw();break;\
				case MSG_EXIT:OnExit();break;\
				case MSG_PROGRESS:OnProgress (theApp.m_wParam,theApp.m_lParam);break;\
				case MSG_USER:OnUser(theApp.m_wParam, theApp.m_lParam);break;\
				case MSG_UART:OnUart(theApp.m_wParam, theApp.m_lParam);break;\
				case MSG_SESSION:OnSession(theApp.m_wParam);break;\
				case MSG_SENDTEXT:OnSendtext(theApp.m_wParam);break;\
				case MSG_TASK:OnTask(theApp.m_wParam,theApp.m_lParam);break;\
				case MSG_TICKER:OnTicker(theApp.m_wParam);break;\
				case MSG_EDITCTRL:OnEditctrl(theApp.m_wParam);break;\
				case MSG_GRIDCTRL:OnGridctrl(theApp.m_wParam,theApp.m_lParam);break;\
				case MSG_EXTCTRL:OnExtctrl(theApp.m_wParam,theApp.m_lParam);break;\
			}\
		}
	

#define ON_INIT(a)			{OnInit(a);}
#define ON_BUTTON(a) 		{EvtButton(a);OnButton(a);}
#define ON_CHAR(a) 			{EvtChar(a);OnChar(a);}
#define ON_KEY(a) 			{EvtKey(a);OnKey(a);}
#define ON_DRAW() 			{EvtDraw();OnDraw();}
#define ON_TIMER(a) 		{EvtTimer(a);OnTimer(a);}
#define ON_SELECT(a)		{EvtSelect(a);OnSelect(a);}
#define ON_PROGRESS(a,b) 	{EvtProgress(a,b);OnProgress(a,b);}
#define ON_EXIT() 			{EvtExit();OnExit();}
#define ON_USER(a,b) 		{EvtUser(a,b);OnUser(a,b);}
#define ON_UART(a,b) 		{EvtUart(a,b);OnUart(a,b);}
#define ON_SESSION(a) 		{EvtSession(a);OnSession(a);}
#define ON_SENDTEXT(a) 		{EvtSendtext(a);OnSendtext(a);}
#define ON_TASK(a,b) 		{EvtTask(a,b);OnTask(a,b);}
#define ON_TICKER(a) 		{EvtTicker(a);OnTicker(a);}
#define ON_EDITCTRL(a) 		{EvtEditctrl(a);OnEditctrl(a);}
#define ON_EXTCTRL(a,b) 	{EvtExtctrl(a,b);OnExtctrl(a,b);}
#define ON_GRIDCTRL(a,b) 	{EvtGridctrl(a,b);OnGridctrl(a,b);}


// ����̽� ȭ�� ũ�� �з�
enum
{
	FAMILY_PDA,
	FAMILY_SMART,
	FAMILY_SMALL,
	FAMILY_MIDDLE,
	FAMILY_LARGE,
	FAMILY_SUPER
} DisplayType;

#define SIZE_PDA		240*320		// QVGA (PDA �迭)
#define SIZE_SMART		400*840		// PDA  (PDA �迭)
#define SIZE_SMALL		720*1280	// small (galaxy phone�迭)
#define SIZE_MIDDLE		1080*1920	// middle  (galaxy note �迭)
#define SIZE_LARGE		1440*2560	// large  (galaxy pad  �迭)
#define SIZE_SUPER		1440*2560	// super  (galaxy pad  �迭)

typedef struct _stDevInfo
{
	long	m_nType;				// ����̽� Ÿ��
	long	m_nMx;					// ȭ�� ���� �ִ� ũ��
	long	m_nMy;					// ȭ�� ���� �ִ� ũ��
	long	m_nFontSmallType;		// ��Ʈ Ÿ��	
	long	m_nFontType;			// ��Ʈ Ÿ��	
	long	m_nFontLageType;		// ��Ʈ Ÿ��	
	long	m_nFontLageType2;		// ��Ʈ Ÿ��
	long	m_nFontSize;			// ��Ʈ ũ��
	long	m_nLix;					// ���� ������ ����ũ��
	long	m_nLiy;					// ���� ������ ����ũ��
	long	m_nSix;					// ���� ������ ����ũ��
	long	m_nSiy;					// ���� ������ ����ũ��
} Device;

typedef struct _stRect
{
	long	Right;
	long	Left;
	long	Top;
	long	Bottom;
} RECT;

typedef struct _stPoint
{
	long	x;
	long	y;
	long	width;
	long	height;
} POINT;

// ��Ʈ���� �⺻ ��ġ ����.
typedef struct _stRange
{
	long	x;						// ���� ��ġ x
	long	y;						// ���� ��ġ y
	long	width;					// ���� ũ��
	long	height;					// ���� ũ��
	long	dx;						// delta x
	long	dy;						// delta y
} RANGE;

typedef struct _stImage
{
	word	width;					//	�̹����� �����ȼ� ��
	word	height;					//	�̹����� �����ȼ� ��
	byte	ColorBit;				//	�̹������� ����ϴ� �����Ʈ�� �� (ex: 2 -> 4 color)
	byte	Data[1];				//	�̹��� ����Ÿ (�� ����ü�� Ÿ�Ժ�ȯ�� ���ؼ��� ���ȴ�.)
} IMAGE;

//�� ��Ÿ�Ͽ� ���õ� ��� ����
//CardGui�� �Ѱܼ� Ŀ���� ����¡ �ǵ���...
typedef struct _stStyle
{
	//---------------
	//��Ÿ�� ���� �ý��� features
	//��Ʈ Ÿ�� (������ alias�� ����)
	//---------------
	long	m_nFontType_VS;	//Very Small
	long	m_nFontType_S;	//Small
	long	m_nFontType_SM;	//Small Medium
	long	m_nFontType_M;	//Medium
	long	m_nFontType_ML;	//Medium Large
	long	m_nFontType_L;	//Large
	long	m_nFontType_VL;	//Very Large
	long	m_nFontType_XL; //eXtra Large
	
	//---------------
	//messagebox style ���� ����
	//---------------

	//---------------
	//grid style ���� ����
	//---------------
	long	m_nGridTitleColor;		//�׸��� Ÿ��Ʋ ����
	long	m_nGridSelectedColor;	//�׸��� ���ý� ����
	long	m_nGridStripedColor;	//�׸��� ��Ʈ������ ����
	
	//---------------
	//etc style ���� ����
	//---------------
	
} STYLE;

global	void g_GetDeviceInfo (void);
global	void g_GetSysInfo 	(void);

global long DMS_X( long x ); 
global long DMS_Y( long y );

//---------------------------------------------------------------
// ��Ʈ�� ����
//---------------------------------------------------------------
#define DLG_CTRL	0x00000000	// ���̾�α׿� ���� ��Ʈ��
#define SLF_CTRL	0x10000000	// �������� ��Ʈ��

//---------------------------------------------------------------
// ��Ʈ�� Ÿ��
//---------------------------------------------------------------
#define OBJ_END		0x00000000	// ��ü����Ʈ ���� ǥ��
#define OBJ_DLG		0x00000001	// ���̾�α�
#define OBJ_BUT		0x00000002	// ��ư
#define OBJ_IBT		0x00000003	// �̹��� ��ư
#define OBJ_TXT		0x00000004	// �ؽ�Ʈ
#define OBJ_EDT		0x00000005	// ����Ʈ
#define OBJ_LST		0x00000006	// ����Ʈ
#define OBJ_SEL		0x00000007	// ����Ʈ
#define OBJ_CHK		0x00000008	// üũ
#define OBJ_ICO		0x00000009	// ������
#define OBJ_LNE		0x0000000A	// ����
#define OBJ_TBL		0x0000000B	// ���̺�
#define OBJ_CMB		0x0000000C	// �޺��ڽ�
#define OBJ_PNG		0x0000000D	// PNG IMAGE (�����ϰ� �޸𸮿� �ø�)
#define OBJ_ABT		0x0000000E	// ��Ƽ�� �̹�����ư
#define OBJ_GRD		0x0000000F	// �׸���

#define OBJ_DBT		0x00000100	// ���� ���� ��ư
#define OBJ_DTX		0x00000101  // ���� ���� �ؽ�Ʈ
#define OBJ_DED		0x00000102	// ���� ���� ����Ʈ

// ��Ʈ�� Ÿ�� ���� ����
typedef struct _stBaseCtrl
{
	RANGE	m_Range;			// ��Ʈ�� ����
	quad	m_nRemStyle;		// Remove ��Ÿ��
	quad	m_nAddStyle;		// Add ��Ÿ��
	quad	m_nFrColor;			// �����																			| h_height
	quad	m_nBkColor;			// ����																			| b_height
								//|DlgCtrl	 |ButCtrl	 |TxtCtrl|EditCtrl	 |ChkCtrl	 |Line	   |PNG				| Grid
	long	m_nVal;				//|TitleHeigt|Bid		 |-		 |Text Length|Check Value|nTickness|png type		| scroll_delta
	void*	m_pBuf[3];			//|Title	 |Text, Image|Text	 |-		     |Text		 |-		   |png file path	| [0]:scroll_thick, [1]:selected_color, [2]:grid_title
} BaseCtrl;

// ������Ʈ�� Action ���
#define NORM_CARD	0			// �Ϲ����� ī������ ����.
#define MAIN_CARD	1			// ī�尡 �������� �˸���. ����ī�带 ���Ѵ�.
#define CALL_CARD	2			// ī�带 �ٷ� ȣ�� ��.
#define CALL_FUNC	3			// Ư���� �Լ��� ����, �⺻������ OnButton()�� ȣ���Ѵ�.
#define CALL_CTRL	4			// Ư���� ��Ʈ�� Action�� ó�� �Ѵ�.

typedef struct _stDlgObject
{
	handle		m_h;			// Object �ڵ�
	long		m_nId;			// ������Ʈ ������ ���� ���� �ε���
								// ���̾�α� �����ô� ��ü ���� �����ϴµ� ���
	long		m_nIdNum;		// ���� ������Ʈ�� �� ������ ����(���̺�).
	long		m_nType;		// ������Ʈ�� ����
	long		m_nActType;		// ������Ʈ�� Action ���
	char*		m_pAct;			// ������Ʈ�� �ؾ� ����
	char*		m_pExitCard; 	// ���� ī�� ����� ������ ī��
	BaseCtrl	m_stCtrl;		// ��Ʈ�� �Ӽ� ����ü
} DlgObject;

//---------------------------------------------------------------
// �ý��� ��ư ����...
// ��ư�� ������ �ʵ��� �����ϴ� �÷���
//---------------------------------------------------------------
#define BUT_OFF	0x10000000
enum
{
	BUT_PREV =	0x00000001,
	BUT_EXIT,
	
	//...,
	
	BUT_USER					// User Definition Type
};

typedef struct _stSysButCtrl
{
	handle		m_h;			// �ڽ��� �ڵ�
	long		m_nId;			// ��ư ���̵�
	long		m_nType;		// ��ư�� ���� : ��ư�� ���̰ų�, �Ⱥ��̰�...
	BaseCtrl	m_stCtrl;
} SysButCtrl;

typedef struct _stAppCard
{
	handle 	m_hDlg;							// ���� �������� ���̾�α�
	handle 	m_hSubDlg;						// ���� ���̾�α�
	handle	m_hChildDlg;					// ���ϵ� ���̾�α� -> ���� ���̾�α׿� ����.
	handle	m_hChildDlgBak;					// ��׶��� ���� ��ȯ�� ��� �ڵ��� ���.

	//------------�޽��� �ڽ�---------------//
	handle	m_hMsgboxDlg;					// �޽����ڽ� ���̾�α�
	handle	m_hTxtMsg;						// �޽����ڽ� ������
	char 	m_szTxtMsg[1024+1];				// �޽����ڽ� ������ ����
	handle 	m_hMsgboxIco;					// �޽����ڽ� ������
	handle 	m_hImgBuf[15];					// �޽����ڽ� ������ ����
	long	m_nMsgboxTimerId;
	long	m_nMsgboxIcoIndex;
	long	m_nMsboxIcoCount;
	long	m_nMsgboxInActiveFlag;
	char	m_szMsgboxImgPath[32];
	bool	m_bNormalMsgFlag;				// �Ϲݸ޽����� Ǫ�ø޽����� �����ؾ� �Ѵ�.
	bool	m_bPushMsgFlag;
	handle	m_hBtnPush;
	bool	m_bUpgradeFlag;					// ���� ���׷��̵尡 �������� ����
	
	
	//------------�׸�����Ʈ�� ����---------------//
	handle	m_hGrid;
	long	m_bSaveStateFlag;				// �׸��� ���¸� �����ϴ� �÷���
	long	m_nSelectedIndex;				// ����� �׸����� ���� �ε���
	long	m_nScrollY;						// ����� ScrollY�� ��
	long	m_nMaxRow;
	long*	m_pCurPage;
	long*	m_pTotalPage;
	handle	m_pCallback;

	long	m_nDlgObjCurId;					// ������� ������ ������Ʈ ���̵�
											// ���� ������Ʈ ������ �ʿ�
	long	m_nDlgObjNum;					// ���� ī�忡�� ������ ������Ʈ ��
											// theDlgCtrl ������ �ε����� ���ȴ�.
	long	m_nSlfObjNum;					// �������� ������Ʈ ��.
											// theSlfCtrl ������ �ε����� ���ȴ�.
											// �޽��� ť
	quad	m_MsgType;						// �޽��� Ÿ��
	quad 	m_wParam;						// wParam
	quad 	m_lParam;						// lParam
	
	char 	m_szMainCard[MAX_CARD_NAME_LEN];	// ���� ���ø����̼��� ���� ī��
	char 	m_szCurCard[MAX_CARD_NAME_LEN];		// ���� �������� ī��
	char 	m_szPrvCard[MAX_CARD_NAME_LEN];		// ���� ī��
	char 	m_szExitCard[MAX_CARD_NAME_LEN];	// ����� �̵��ϰ��� �ϴ� ī��
	
	STYLE	m_style;							// ���ø����̼� ��Ÿ���� �����Ѵ�.
} App;

global DlgObject* g_pDlgRes;
global bool 	g_bGlobalFlag;
global Device 	theDevInfo;
global App 		theApp;
global App*		this;			// ������ ī�忡���� this ������

global long 	theSysButNum;
global handle	theSysBut[MAX_SYS_BUT+1];
global handle 	theDlgCtrl[MAX_OBJ_NUM+1];
global handle 	theSlfCtrl[MAX_OBJ_NUM+1];

global quad g_nDlgResNum;

// ���� ī�� ������ ������ �ִ� ����
// MAX_PREV_CARD_NUM���� �����Ѵ�. MAX_PREV_CARD_NUM��
// ���� ��� ���� ������ ī�� ���� ���� �ȴ�.
typedef struct 	_tagCardStack
{
	char	m_szCardName[MAX_CARD_NAME_LEN];
	quad	m_qCardType;
} CardStack;

//---------------------------------------------------------------
// 2003-06-09 misocap (�ڼ���)
// ī�� Ÿ�� ������ App ����ü�� �߰�
//---------------------------------------------------------------
global long g_nDlgTitleHeight;		// ���̾�α� Ÿ��Ʋ ����
global long	g_nCurCardType;			// ���� ī�� Ÿ��
global long g_nPrvCardType; 		// ī�� Ÿ���� �����ϱ� ���� ���� Ÿ���� �����ϴ� ����

global CardStack	theCardStack[MAX_PREV_CARD_NUM];

global void	EvtExit					(void);
global void	EvtUser					(long nEvent, long nData);
global void	EvtChar					(long nChar);
global void	EvtKey 					(long nKey);
global void	EvtDraw					(void);
global void	EvtTimer				(long nTimerID);
global void	EvtPointing				(long nAction,long X, long Y);
global void	EvtButton				(long ID);
global void	EvtSelect				(long Index);
global void	EvtProgress				(long nValue, long nTotal);
global void	EvtSession				(long wParam);
global void	EvtSendText				(long wParam);
global void EndSession				(void);
global void EvtUart					(long nType, long nData);
global void EvtTask					(long nType, long nData);
global void EvtTicker				(long nType);
global void EvtEditctrl				(long nType);
global void EvtExtctrl				(long nEvent, long nData);
global void EvtGridctrl				(long nEvent, long nData);

global bool PreDispatchEvent 		(quad MsgType, quad wParam, quad lParam);
global void InitDialog 				(void);	
global void LoadCardGui				(void);

global	void g_Reverse				(char* s, int n);
global	void g_Sprintf 				(char* d, char* fmt, ...);

global	long Is_ActiveCtrlID 		(long nID);
global	long Get_iDlgCtrlFromID 	(long nID);
global	handle Get_hDlgCtrlFromID 	(long nID);
global	handle Get_hSlfCtrlFromID 	(long nID);
global	long PushDlgCtrl			(DlgObject* pObj);
global	long PushSlfCtrl			(DlgObject* pObj);
global	handle CreateDlgObject 		(DlgObject* pObj, long nObjNum);
global	void SetDlgRes 				(DlgObject* pObj, long nType, long x, long y,long w,long h,long dx,long dy,
										quad Rem, quad Add, byte FrColor,byte BkColor,long nVal,
										void* pBuf0, void* pBuf1, void* pBuf2);

global  handle DlgDynObj_Create 	(DlgObject* pObj,long gx,long gy,long nDispCnt,
										long nNum,long nTextLen,char** pText);
global	long NewDlgObj	 			(DlgObject* pObj[], long nObjNum);
global	long DelDlgObj 				(DlgObject* pObj[]);


//-----------------------------------------------------------------------------
//	Variables
//-----------------------------------------------------------------------------
global long	g_nTimerId;  //�ڵ����� Timer  30�� ������
global long	g_nTimerCnt; //���ð� �ں��� 30�д����� üũ�Ͽ� ��¥ ������ ����

//-----------------------------------------------------------------------------
//	Functions
//-----------------------------------------------------------------------------
global void g_MessageBoxEx			(long Type, char* Title ,char* TextStr, char* LBottomStr, char* RBottomStr, long LBottomID, long RBottomID);
global void g_MessageBox			(long Type, char* TextStr, char* LBottomStr, char* RBottomStr, long LBottomID, long RBottomID);
global void g_Progress				(long Type, char* Title, char* TextStr);
global void g_SetMessgeText 		(char* TextStr);
global void g_Close_SubDlg			(void);
global long MsgBox 					(long nDy, long Type, char* Msg);
global long MsgBoxEx 				(long nDy, long Type, char* Title, char* Msg);

global long	SysButCreate 			(long nButNum, SysButCtrl* pBut);
global void	g_SysBut_Create 		(SysButCtrl* pBut);
global void	g_SysBut_Draw 			(void);
global long	g_SysBut_PointProcess 	(long nAction, long X, long Y);
global void	g_SysBut_Delete 		(void);
global handle GetSysButHandle 		(long nId);
global void g_SetProgressIcoPath	(char* pszImgPath);
global void g_PostMessage 			(long msg, long wp, long lp);
global void g_Gridctrl_SetTitleBkColor (handle hGrid, long nCols);

#define GridCtrl_SetIndex(index)				g_PostMessage(MSG_SELECT,0,index)
#define GridCtrl_PageEvent(event,index)			g_PostMessage(MSG_GRIDCTRL,event,index)
#define GridCtrl_SetTitleBkColor(h, columns)	g_Gridctrl_SetTitleBkColor(h,ARR_SIZE(columns))


// �ý��� ��ư ��ũ�� �Լ�.
#define SYS_BUT_GET_HANDLE(nId) GetSysButHandle(nId)
		
#define SYS_BUT_ON(nId)\
		{\
			long i;\
			SysButCtrl* pBut;\
			for (i=0; i<theSysButNum; i++)\
			{\
				pBut = (SysButCtrl*)theSysBut[i];\
				if (pBut->m_nId == nId)\
				{\
					pBut->m_nType &= 0xEFFFFFFF;\
				}\
			}\
		}

#define SYS_BUT_OFF(nId)\
		{\
			long i;\
			SysButCtrl* pBut;\
			for (i=0; i<theSysButNum; i++)\
			{\
				pBut = (SysButCtrl*)theSysBut[i];\
				if (pBut->m_nId == nId)\
				{\
					pBut->m_nType |= 0x10000000;\
				}\
			}\
		}

// �ý��� ��ư
#define SYS_BUT_IMG(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ButType, Id, Image)\
		{0, Id, ButType, {{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, OBJ_IBT, Image, "", ""}}
		
#define SYS_BUT_TXT(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ButType, Id, Text)\
		{0, Id, ButType, {{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, OBJ_BUT, Text, "", ""}}

// ������Ʈ �ʱ�ȭ�� ���� ��ũ�� �Լ�.
#define MAIN_DLG(MainCardName, ExitCardName,\
				 Rem, Add, BkColor, TitleFrColor, TitleBkColor, TitleHeight, Tiltle)\
		{0, BkColor, 0, OBJ_DLG, MAIN_CARD, MainCardName, ExitCardName,\
		{{ 0, 0, 0, 0, 0, 0}, Rem, Add, TitleFrColor, TitleBkColor, TitleHeight, Tiltle}}

#define NORM_DLG(MainCardName, ExitCardName,\
				 Rem, Add, BkColor, TitleFrColor, TitleBkColor, TitleHeight, Tiltle)\
		{0, BkColor, 0, OBJ_DLG, NORM_CARD, MainCardName, ExitCardName,\
		{{ 0, 0, 0, 0, 0, 0}, Rem, Add, TitleFrColor, TitleBkColor, TitleHeight, Tiltle}}

// ���̾�α׿� ���� ��Ʈ��.
#define DLG_TEXT(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id, Text)\
		{0, Id, 0, OBJ_TXT, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, 0, Text}}

#define DLG_EDIT(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id, TextLen, Text)\
		{0, Id, 0, OBJ_EDT, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, TextLen, Text}}
	
#define DLG_BUTTON(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ActType, Act, Id, Text)\
		{0, Id, 0, OBJ_BUT, ActType, Act, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, Id, Text}}
	
#define DLG_IBUTTON(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ActType, Act, Id, Image, Text)\
		{0, Id, 0, OBJ_IBT, ActType, Act, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, Id, {Text, Image, 0}}}

#define DLG_AIBUT(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ActType, Act, Id, Image_Id, ActImage_Id, Text)\
		{0, Id, 0, OBJ_ABT, ActType, Act, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, Id, {Text, (void*)Image_Id, (void*)ActImage_Id}}}

#define DLG_ACTBUT(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ActType, Act, Id, Image, ActImage, Text)\
		{0, Id, 0, OBJ_IBT, ActType, Act, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, Id, {Text, Image, ActImage}}}

#define DLG_LINE(x1, y1, x2, y2, nColor, nThickness, Id)\
		{0, Id, 0, OBJ_LNE, 0, 0, 0, {{x1, y1, x2, y2, 0, 0}, 0, 0, nColor, 0, nThickness, 0}}
		
#define DLG_LIST(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id)\
		{0, Id, 0, OBJ_LST, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, 0, 0}}
		
#define DLG_SELECT(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id)\
		{0, Id, 0, OBJ_SEL, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, 0, 0}}
		
#define DLG_ICON(x, y, Id, Image)\
		{0, Id, 0, OBJ_ICO, 0, 0, 0, {{x, y, 0, 0, 0, 0}, 0, 0, 0, 0, 0, Image}}
		
#define DLG_CHECK(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ChkValue, Id, Text)\
		{0, Id, 0, OBJ_CHK, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, ChkValue, Text}}

#define DLG_TABLE(x, y, rownum, colnum, multi_gab, height, key,\
					title_height, RowFlag, maxchar, ColTitle, Id, szBuf)\
		{0, Id, 0, OBJ_TBL, 0, 0, 0,\
		{{x, y, colnum, rownum, multi_gab, height}, key, 0,\
		title_height, RowFlag, maxchar, {ColTitle, szBuf}}}

//colnum�� grid_title���� �ڵ����� ����Ѵ�.	
#define DLG_GRID(x, y, width, height, Rem, Add, Id, rownum, head_height, body_height, scroll_delta, scroll_thick, selected_color, grid_title)\
		{0, Id, 0, OBJ_GRD, 0, 0, 0,\
		{{x, y, width, height, rownum, ARR_SIZE(grid_title)}, Rem, Add, head_height, body_height, scroll_delta, {(void*)scroll_thick, (void*)selected_color, grid_title}}}

#define DLG_EDITEX(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id, TextLen, Text)\
		DLG_BUTTON( x, y, width, height, 2, 2, BUTSTY_BOLD|BUTSTY_BORDER, 0, TRANSPARENT, TRANSPARENT, CALL_CTRL, "OBJ_EDIT", Id+1, ""),\
		DLG_EDIT  (x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id, TextLen, Text)\
		

/*����
#define DLG_COMBO(x, y, width, height, ButWidth, ButHeight, FrColor, BkColor, ActType, Act, Id, TextLen)\
		DLG_TEXT   ( x, y, ((width)-(ButWidth)), ButHeight, 1, 1, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, Id, ""),\
		DLG_BUTTON (((x)+(width)-(ButWidth)), y, ButWidth, ButHeight, 2, 2, BUTSTY_ROUNDBORDER|BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CALL_CTRL, "OBJ_CMB", Id+1, "��"),\
		DLG_LIST   (x, (y)+(ButHeight), width, ((height)-(ButHeight)), 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, Id+2)
*/
//2���þ�
#define DLG_COMBO(x, y, width, height, ButWidth, ButHeight, FrColor, BkColor, ActType, Act, Id, TextLen)\
		DLG_TEXT   ( x, y, ((width)-(ButWidth)), ButHeight, 1, 1, 0, EDITSTY_BORDER, TXTFRCOLOR, TXTINCTRLBK, Id, ""),\
		DLG_BUTTON (((x)+(width)-(ButWidth)), y, ButWidth, ButHeight, 2, 2, BUTSTY_ROUNDBORDER|BUTSTY_BOLD, BUTSTY_BORDER, TXTCTRLFRCOLOR, TXTINCTRLBK, CALL_CTRL, "OBJ_CMB", Id+1, "��"),\
		DLG_LIST   (x, (y)+(ButHeight), width, ((height)-(ButHeight)), 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, Id+2)

#define DLG_COMBO2(x, y, width, height, ButWidth, ButHeight, FrColor, BkColor, ActType, Act, Id, TextLen)\
		DLG_TEXT   ( x, y, ((width)-(ButWidth)), ButHeight, 1, 1, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, Id, ""),\
		DLG_BUTTON (((x)+(width)-(ButWidth)), y, ButWidth, ButHeight, 2, 2, BUTSTY_ROUNDBORDER|BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CALL_CTRL, "OBJ_CMB", Id+1, "��"),\
		DLG_LIST   (x, (y)+(ButHeight), width, ((height)-(ButHeight)), 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, Id+2)

//ü�� �󼼸���Ʈ, ���̺� ���� �޺��ڽ�. ���� �޺��ڽ����� ���� ����
#define DLG_COMBO_LIST(x, y, width, height, ButWidth, ButHeight, FrColor, BkColor, ActType, Act, Id, TextLen)\
		DLG_TEXT   ( x, y, ((width)-(ButWidth)), ButHeight, 1, 1, 0, EDITSTY_BORDER, TXTCTRLFRCOLOR, TABLETITLE_COLOR, Id, ""),\
		DLG_BUTTON (((x)+(width)-(ButWidth)), y, ButWidth, ButHeight, 2, 2, BUTSTY_ROUNDBORDER|BUTSTY_BOLD, BUTSTY_BORDER, BLACK, TABLETITLE_COLOR, CALL_CTRL, "OBJ_CMB", Id+1, "��"),\
		DLG_LIST   (x, (y)+(ButHeight), width, ((height)-(ButHeight)), 0, 0, 0, 0, BLACK, EDTCTRLBK, Id+2)


#define DLG_COMBO_UP(x, y, width, height, ButWidth, ButHeight, FrColor, BkColor, ActType, Act, Id, TextLen)\
		DLG_TEXT   ( x, y, ((width)-(ButWidth)), ButHeight, 1, 1, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, Id, ""),\
		DLG_BUTTON (((x)+(width)-(ButWidth)), y, ButWidth, ButHeight, 2, 2, BUTSTY_ROUNDBORDER|BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CALL_CTRL, "OBJ_CMB", Id+1, "��"),\
		DLG_LIST   (x, (y)-((height)-(ButHeight)), width, ((height)-(ButHeight)), 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, Id+2)

// aza 2004-07-12
// SK-Enron : �޺��� ����Ʈ �Ӽ��� ������.
#define DLG_COMBO_DWE(x, y, width, height, ButWidth, ButHeight, FrColor, BkColor, ActType, Act, Id, TextLen)\
		DLG_EDIT   ( x, y, ((width)-(ButWidth)), ButHeight, 1, 1, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, Id, TextLen, ""),\
		DLG_BUTTON (((x)+(width)-(ButWidth)), y, ButWidth, ButHeight, 2, 2, BUTSTY_ROUNDBORDER|BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CALL_CTRL, "OBJ_CMB", Id+1, "��"),\
		DLG_LIST   (x, (y)+(ButHeight), width, ((height)-(ButHeight)), 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, Id+2)

#define DLG_COMBO_UPE(x, y, width, height, ButWidth, ButHeight, FrColor, BkColor, ActType, Act, Id, TextLen)\
		DLG_EDIT   ( x, y, ((width)-(ButWidth)), ButHeight, 1, 1, 0, EDITSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, Id, TextLen, ""),\
		DLG_BUTTON (((x)+(width)-(ButWidth)), y, ButWidth, ButHeight, 2, 2, BUTSTY_ROUNDBORDER|BUTSTY_BOLD, BUTSTY_BORDER, TXTFRCOLOR, EDTCTRLBK, CALL_CTRL, "OBJ_CMB", Id+1, "��"),\
		DLG_LIST   (x, (y)-((height)-(ButHeight)), width, ((height)-(ButHeight)), 0, 0, 0, 0, TXTFRCOLOR, EDTCTRLBK, Id+2)

//�޼����ڽ��� ��ư
handle DLG_NTEXT(handle hDlg, long nIndex, long X, long Y, long nWidth, long nHeight, quad foreClr, quad align, quad font, char *szStr);
handle DLG_NBUTTON(handle hDlg, long nIndex, long X, long Y, long nWidth, long nHeight, void *pImg, void * pActImg, long nBtnId, char* szStr);
handle DLG_NBUTTON_STR(handle hDlg, long nIndex, long X, long Y, long nWidth, long nHeight, void *pImg, void * pActImg, long nBtnId, quad foreClr, quad font, char *szText);
handle DLG_NICON(handle hDlg, long nIndex, long X, long Y, void *pImg);		
		
//�ű� �߰� ������Ʈ
//---------------------------------------------------------------
//	DLG_IMGCMB_XXX	//�̹��� �޺��ڽ�
//	CTR_IMGTAB(x, y, width, height, id, TabCount) //��ư�� TabCount ������ŭ �����ϰ� �̹����� ������.
//---------------------------------------------------------------

// ���̾�α׿� ������ �ʴ� ��Ʈ��.
#define CTR_TEXT(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id, Text)\
		{0, Id, 0, SLF_CTRL|OBJ_TXT, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, 0, Text}}
		
#define CTR_EDIT(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id, TextLen, Text)\
		{0, Id, 0, SLF_CTRL|OBJ_EDT, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, TextLen, Text}}
	
#define CTR_BUTTON(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ActType, Act, Id, Text)\
		{0, Id, 0, SLF_CTRL|OBJ_BUT, ActType, Act, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, Id, Text}}
	
#define CTR_IBUTTON(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ActType, Act, Id, Image, Text)\
		{0, Id, 0, SLF_CTRL|OBJ_IBT, ActType, Act, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, Id, {Text, Image}}}

#define CTR_LINE(x1, y1, x2, y2, nColor, nThickness, Id)\
		{0, Id, 0, SLF_CTRL|OBJ_LNE, 0, 0, 0, {{x1, y1, x2, y2, 0, 0}, nColor, 0, 0, 0, nThickness, 0}}
		
#define CTR_LIST(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id)\
		{0, Id, 0, SLF_CTRL|OBJ_LST, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, 0, 0}}
		
#define CTR_SELECT(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, Id)\
		{0, Id, 0, SLF_CTRL|OBJ_SEL, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, 0, 0}}
		
#define CTR_ICON(x, y, Image, Id)\
		{0, Id, 0, SLF_CTRL|OBJ_ICO, 0, 0, 0, {{x, y, 0, 0, 0, 0}, 0, 0, 0, 0, 0, Image}}
		
#define CTR_CHECK(x, y, width, height, dx, dy, Rem, Add, FrColor, BkColor, ChkValue, Id, Text)\
		{0, Id, 0, SLF_CTRL|OBJ_CHK, 0, 0, 0,\
		{{x, y, width, height, dx, dy}, Rem, Add, FrColor, BkColor, ChkValue, Text}}

#define CTR_PNG(Id, PngType, PngPath)\
		{0, Id, 0, SLF_CTRL|OBJ_PNG, 0, 0, 0,\
		{{0, 0, 0, 0, 0, 0}, 0, 0, 0, 0, PngType, PngPath, 0, 0}}

//---------------------------------------------------------------
//	Resource Mapping
//---------------------------------------------------------------
//			{OBJ_END,0,0,0,0,0,0,0,0,0,0,0,0,0,0}		\


#define BEGIN_DIALOG_MAP(objs)							\
		DlgObject objs[] =								\
		{

#define END_DIALOG_MAP()								\
		};

#define BEGIN_SYSBUT_MAP(objs)							\
		SysButCtrl objs[] =								\
		{

#define END_SYSBUT_MAP()								\
		};

//main entry mapping		
#define CARD_ENTRY_MAP()								\
		bool main (quad MsgType, quad wParam, quad lParam)\
		{\
			EVENT_HANDLER (MsgType, wParam, lParam);\
			return TRUE;\
		}
		
//---------------------------------------------------------------
// �׸��� ��Ʈ���� Ÿ��Ʋ ��� ������ �����Ѵ�.
//---------------------------------------------------------------
//h 				: �׸�����Ʈ�� �ڵ�
//grid_title_array 	: �׸��� Ÿ��Ʋ ���� �迭
//color 			: ���� �ڵ�
//---------------------------------------------------------------
#define GridCtrl_SetTitleColor(h, grid_title_array, color)\
		{\
			long ii;\
			for(ii=0; ii<ARR_SIZE(grid_title_array); ii++)\
				EditCtrl_SetBkColorEx( GridCtrl_GetCellHandle(h, ii, 0), color );\
		}

//---------------------------------------------------------------
// �׸��� ��Ʈ���� ����¡ ����� �����Ѵ�.
//---------------------------------------------------------------
//h 		: �׸�����Ʈ�� �ڵ�
//max_row 	: �� �ִ밳��
//page 		: ���� ������ �ε���
//total 	: ������ ��ü ����
//callback 	: ������ �̵� �ݹ� �Լ�
//---------------------------------------------------------------
#define GridCtrl_SetPageInfo(h, max_row, page, total, callback)\
		{\
			theApp.m_hGrid=h;\
			theApp.m_pCurPage=&page;\
			theApp.m_pTotalPage=&total;\
			theApp.m_pCallback=callback;\
			theApp.m_nMaxRow=max_row;\
		}
		
//---------------------------------------------------------------
// ���̺� ��Ʈ�� ���� ��ũ��
//---------------------------------------------------------------
#define		TABLE_EDIT				0x01
#define		TABLE_TEXT				0x02

#define 	TBL_FRCOLOR				0
#define 	TBL_BKCOLOR				1

#define		CONV_ZERO_TO_SPACE 		STRCHG_CONV_ZERO_TO_SPACE		// ���ڿ��� '0'�� �������� ��ȯ.
#define		DEL_SPACE_TO_LEFT		STRCHG_DEL_SPACE_TO_LEFT		// ���ڿ��� ������ ����.
#define		DEL_SPACE_TO_RIGHT		STRCHG_DEL_SPACE_TO_RIGHT		// ���ڿ��� ������ ���������� �̵�.
#define		DEL_RIGHT_SPACE			STRCHG_DEL_RIGHT_SPACE			// ���ڿ��� �պκ��� ������ ����.
#define		DEL_ALL_SPACE			STRCHG_DEL_ALL_SPACE			// ���ڿ��� ������ ����.
#define		INS_COMMA				STRCHG_INS_COMMA				// ���ڿ��� �ڿ��� 3�ڸ����� �޸��� ��� '0'�� �������� ��ȯ.
#define		DEL_NONDIGIT			STRCHG_DEL_NONDIGIT				// ���ڿ� �� ���� ���ڰ� �ƴ� ���� ����.
#define		DEL_NONDIGITSIGN		STRCHG_DEL_NONDIGITSIGN			// ���ڿ� �� ���� ��ȣ�� ������ ���� ���ڰ� �ƴ� ���� ����. 

#define		SEL_NONE				0		// ���̺��� ���õ��� ���ϰ� ����
#define		SEL_ROW					1		// ���̺��� �ٴ����� �����ϰ� ����
#define		SEL_COL					2		// ���̺��� �������� �����ϰ� ����
#define		DlgTbl_SetStrChg(a,b,c)\
			{\
				char szBuf[15];\
				Str_Cpy (szBuf, (b));\
				Str_Chg (szBuf, (c));\
				DlgTbl_SetStr ((a), szBuf);\
			}

#define		TBL_CELL(max_row, row, col) ( (col) + (max_row) * ( (row) + 1 ) )
#define		TBL_SIZE(max_str, row, col)	( (max_str) * (col) * ((row) + 1) )

#define		SET_UPGRADE_FLAG(flag)	theApp.m_bUpgradeFlag = flag
			
#ifndef	DLGBORDER_WIDTH
	#define	DLGBORDER_WIDTH		2
#endif

#ifndef	TABLEACTIVE_COLOR
	#define	TABLEACTIVE_COLOR	MAKE_RGB(255, 215, 178)
#endif

#ifndef	TABLETITLE_COLOR
	#define	TABLETITLE_COLOR	219
#endif

	
typedef struct _Column 
{
	char title[30]; 
	long width;
	quad mode;
	long ctrltype;
	long maxchar;
} Column;

#define DlgTbl_SetActive	DlgTbl_SetActiveRow

global	long	DlgTbl_Create		( DlgObject* pObj );
global	void	DlgTbl_RowValueClear( long nId, long row );
global	void 	DlgTbl_SetRowColor2 ( long nId, long row, quad color, quad color2);

global	void	DlgTbl_SetRowColor	( long nId, long row, quad color );
global	void	DlgTbl_SetCellColor	( long nMode, long nId, long row, long col, quad color );
global	char* 	DlgTbl_GetStr 		( long nId, long nRow, long nCol );
global	handle 	DlgTbl_GetHandle 	( long nId, long nRow, long nCol );
global	void	DlgTbl_SetStr 		( long nId,  long nRow, long nCol, char* pStr );
global  long	DlgTbl_IsSelect 	( long nId );
global  void	DlgTbl_UnSelect 	( long nId );
global	long	DlgTbl_Delete 		( void );

global	long 	DlgTbl_GetActiveRow ( long nId );
global  void	DlgTbl_SetActiveRow	( long nId, long ActiveIndex );

global	long	DlgTbl_GetActivePage( long nId );
global	long	DlgTbl_SetActivePage( long nId, long ActivePage );

//---------------------------------------------------------------
// �̺�Ʈ �Լ�
// �̰��� �����ؼ�, ī�忡 ������ ���� �ʾƵ� �ȴ�.
//---------------------------------------------------------------
void	OnInit						(char bFirst);
void	OnExit						(void);
void	OnChar						(long nChar);
void	OnKey 						(long nKey);
void	OnDraw						(void);
void	OnTimer						(long nTimerID);
void	OnPointing					(long nAction, long X, long Y);
void	OnButton					(long ID);
void	OnSelect					(long Index);

void	OnUser						(long nEvent, long nData);
void	OnUart						(long nEvent, long nData);
void	OnProgress					(long nIndex, long nToTal);
void	OnSession					(long nEvent);
void	OnSendtext					(long nEvent);
void	OnTask						(long nEvent, long nData);
void	OnTicker					(long nEvent);
void	OnEditctrl					(long nEvent);
void	OnExtctrl					(long nEvent, long nData);
void	OnGridctrl					(long nEvent, long nData);

//---------------------------------------------------------------
// �ݹ� �Լ� ����
//---------------------------------------------------------------
typedef void (*BaseCallback)		(void);
typedef void (*ExtLoadModule)		(void);
typedef void (*ExtEvtTask)			(long, long);
typedef void (*ExtEvtUart)			(long, long);
typedef void (*ExtEvtTimer)			(long);
typedef void (*ExtEvtSession)		(long);

global	ExtLoadModule				g_pExtLoadModule;
global	ExtEvtTask					g_pEvtTask;
global	ExtEvtUart					g_pEvtUart;
global	ExtEvtTimer					g_pEvtTimer;
global	ExtEvtSession				g_pEvtSession;
global	ExtEvtSession				g_pEvtEndSession;

global	void 	SetExtLoadModule	(void* p);
global	void 	SetExtEvtTask		(void* p);
global	void 	SetExtEvtUart		(void* p);
global	void 	SetExtEvtTimer		(void* p);
global	void 	SetExtSession		(void* p);
global	void 	SetExtEndSession	(void* p);

#endif // __CARDGUI_H__
