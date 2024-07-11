#ifndef		GRSYSDEF_H
#define		GRSYSDEF_H

//------------------------------------------------------------------------------
//		box title height pixel
//------------------------------------------------------------------------------
#define		BOX_TITLE_HEIGHT		15				//	제목줄의 높이, 경계선은 포함하지 않음

//------------------------------------------------------------------------------
//		box style (ModalBox::Frame.Base.Style)
//------------------------------------------------------------------------------
#define		BOXSTY_BORDER			0x80000000		//	영역에 테두리를 그림
#define		BOXSTY_THICKBORDER		0x40000000		//	두꺼운 선으로 테두리를 그림
#define		BOXSTY_ROUNDBORDER		0x20000000		//	모서리가 둥근 테두리를 그림
#define		BOXSTY_TITLE			0x08000000		//	제목을 표시함
#define		BOXSTY_LEFTTITLE		0x04000000		//	제목을 상단의 왼쪽에 표시함
#define		BOXSTY_INVERSETITLE		0x02000000		//	제목을 반전시켜 표시함 (검정바탕에 흰색글씨)
#define		BOXSTY_BOLDTITLE		0x01000000		//	제목문자열을 볼드체로 사용함
#define		BOXSTY_HSCROLLBAR		0x00800000		//	수평 스크롤바를 표시함
#define		BOXSTY_VSCROLLBAR		0x00400000		//	수직 스크롤바를 표시함
#define		BOXSTY_WIDESCRLBAR		0x00200000		//	폭이 넓은 스크롤바를 사용함
#define		BOXSTY_ALWAYSSHOWSB		0x00100000		//	스크롤바를 항상 보여줌
//#define		BOXSTY_SOFTMENU			0x00080000		//	소프트메뉴를 사용함
#define		BOXSTY_GRAYBACKGROUND	0x00040000		//	배경을 흐릿하게 만듦


//-------------------------------------------------------------------------------------------------
//	FrmCtrl 스타일의 종류 (stFrmCtrl::Base.Style)
//-------------------------------------------------------------------------------------------------
#define		FRMSTY_BORDER				0x80000000			//	영역에 테두리를 그림
#define		FRMSTY_THICKBORDER			0x40000000			//	두꺼운 선으로 테두리를 그림
#define		FRMSTY_ROUNDBORDER			0x20000000			//	모서리가 둥근 테두리를 그림
#define		FRMSTY_TITLE				0x08000000			//	제목을 표시함
#define		FRMSTY_LEFTTITLE			0x04000000			//	제목을 상단의 왼쪽에 표시함
#define		FRMSTY_INVERSETITLE			0x02000000			//	제목을 반전시켜 표시함 (검정바탕에 흰색글씨)
#define		FRMSTY_BOLDTITLE			0x01000000			//	제목문자열을 볼드체로 사용함
#define		FRMSTY_HSCROLLBAR			0x00800000			//	수평 스크롤바를 표시함
#define		FRMSTY_VSCROLLBAR			0x00400000			//	수직 스크롤바를 표시함
#define		FRMSTY_WIDESCRLBAR			0x00200000			//	폭이 넓은 스크롤바를 사용함
#define		FRMSTY_VARSCROLLBAR			0x10000000			//	가변 길이 스크롤 바
#define		FRMSTY_ALWAYSSHOWSB			0x00100000			//	스크롤바를 항상 보여줌

//------------------------------------------------------------------------------
//		button control style (ButCtrl::Frame.Base.Style)
//------------------------------------------------------------------------------
#define		BUTSTY_BORDER			0x80000000		//	영역에 테두리를 그림
#define		BUTSTY_THICKBORDER		0x40000000		//	두꺼운 선으로 테두리를 그림
#define		BUTSTY_ROUNDBORDER		0x20000000		//	모서리가 둥근 테두리를 그림
#define		BUTSTY_TITLE			0x08000000		//	제목을 표시함
#define		BUTSTY_LEFTTITLE		0x04000000		//	제목을 상단의 왼쪽에 표시함
#define		BUTSTY_INVERSETITLE		0x02000000		//	제목을 반전시켜 표시함 (검정바탕에 흰색글씨)
#define		BUTSTY_BOLDTITLE		0x01000000		//	제목문자열을 볼드체로 사용함
#define		BUTSTY_HSCROLLBAR		0x00800000		//	수평 스크롤바를 표시함
#define		BUTSTY_VSCROLLBAR		0x00400000		//	수직 스크롤바를 표시함
#define		BUTSTY_WIDESCRLBAR		0x00200000		//	폭이 넓은 스크롤바를 사용함
#define		BUTSTY_VARSCROLLBAR		FRMSTY_VARSCROLLBAR	//	0x10000000	가변 길이 스크롤 바
#define		BUTSTY_ALWAYSSHOWSB		0x00100000		//	스크롤바를 항상 보여줌
#define		BUTSTY_DEFAULT_BUTTON	0x00080000		//	디폴트 버튼
#define		BUTSTY_BOLD				0x00040000		//	볼드체로 그림

#define		BUTSTY_INVERSE			0x00020000		//	역상 타입
#define		BUTSTY_INACTIVE			0x00010000		//	인액티브 타입

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
#define		DLGRET_ERROR			0x80000000		//	오류 발생
#define		DLGRET_DONE		  		0x40000000		//	다이알로그의 컨트롤이 키처리를 하였음
#define		DLGRET_POPUP			0x20000000		//	팝업리스트를 사용중임
#define		DLGRET_POPUPSELECT		0x10000000		//	팝업리스트 항목을 선택하였음
#define		DLGRET_POPUPSUBSTART	0x08000000
#define		DLGRET_INDEXMASK		0x0000FFFF

//------------------------------------------------------------------------------
//		dialog style
//------------------------------------------------------------------------------
#define		DLGSTY_BORDER			0x80000000		//	영역에 테두리를 그림
#define		DLGSTY_THICKBORDER		0x40000000		//	두꺼운 선으로 테두리를 그림
#define		DLGSTY_ROUNDBORDER		0x20000000		//	모서리가 둥근 테두리를 그림
#define		DLGSTY_TITLE			0x08000000		//	제목을 표시함
#define		DLGSTY_LEFTTITLE		0x04000000		//	제목을 상단의 왼쪽에 표시함
#define		DLGSTY_INVERSETITLE		0x02000000		//	제목을 반전시켜 표시함 (검정바탕에 흰색글씨)
#define		DLGSTY_BOLDTITLE		0x01000000		//	제목문자열을 볼드체로 사용함
#define		DLGSTY_HSCROLLBAR		0x00800000		//	수평 스크롤바를 표시함
#define		DLGSTY_VSCROLLBAR		0x00400000		//	수직 스크롤바를 표시함
#define		DLGSTY_WIDESCRLBAR		0x00200000		//	폭이 넓은 스크롤바를 사용함
#define		DLGSTY_VARSCROLLBAR		FRMSTY_VARSCROLLBAR	//	0x10000000	가변 길이 스크롤 바
#define		DLGSTY_ALWAYSSHOWSB		0x00100000		//	스크롤바를 항상 보여줌
//#define		DLGSTY_SOFTMENU			0x00080000		//	소프트 메뉴를 표시함
#define		DLGSTY_CIRCULAR			0x00010000		//	첫번째 아이템과 마지막 아이템의 이동을 가능하게 함

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
#define		EDITMODE_HANGUL			0x8000			//	한글입력 가능
#define		EDITMODE_NUMBER			0x4000			//	숫자입력 가능
#define		EDITMODE_SMALLENG		0x2000			//	영소입력 가능
#define		EDITMODE_LARGEENG		0x1000			//	영대입력 가능
#define		EDITMODE_SYMBOL			0x0800			//	기호입력 가능
 
//------------------------------------------------------------------------------
//		edit state
//------------------------------------------------------------------------------
#define		EDITSTAT_WAIT			0				//	새로운 문자의 입력을 기다리는 중
#define		EDITSTAT_INPUT			1				//	문자를 만들고 있는 중

//------------------------------------------------------------------------------
//		edit control stype (EidtCtrl::Frame.Base.Style)
//------------------------------------------------------------------------------
#define		EDITSTY_BORDER			0x80000000		//	영역에 테두리를 그림
#define		EDITSTY_THICKBORDER		0x40000000		//	두꺼운 선으로 테두리를 그림
#define		EDITSTY_ROUNDBORDER		0x20000000		//	모서리가 둥근 테두리를 그림
#define		EDITSTY_TITLE			0x08000000		//	제목을 표시함
#define		EDITSTY_LEFTTITLE		0x04000000		//	제목을 상단의 왼쪽에 표시함
#define		EDITSTY_INVERSETITLE	0x02000000		//	제목을 반전시켜 표시함 (검정바탕에 흰색글씨)
#define		EDITSTY_BOLDTITLE		0x01000000		//	제목문자열을 볼드체로 사용함
#define		EDITSTY_HSCROLLBAR		0x00800000		//	수평 스크롤바를 표시함
#define		EDITSTY_VSCROLLBAR		0x00400000		//	수직 스크롤바를 표시함
#define		EDITSTY_WIDESCRLBAR		0x00200000		//	폭이 넓은 스크롤바를 사용함
#define		EDITSTY_ALWAYSSHOWSB	0x00100000		//	스크롤바를 항상 보여줌
#define		EDITSTY_VARSCROLLBAR	FRMSTY_VARSCROLLBAR	//	0x10000000	가변 길이 스크롤 바
#define		EDITSTY_NOCURSOR		0x00080000		//	커서를 보여주지 않음
#define		EDITSTY_KEYBOARD		0x00040000		//	키보드의 입력을 직접 처리함
#define		EDITSTY_AUTOCURSORMOVE	0x00020000		//	영문입력할 때 2초후 자동으로 커서이동함
#define		EDITSTY_BOLD			0x00010000		//	항상 볼드체로 출력함
#define		EDITSTY_ENDSYMBOL		0x00008000		//	활성화된 경우 줄의 끝에 CR표시를 함
#define		EDITSTY_RIGHT			0x00004000		//	오른쪽에서 입력. (숫자모드만 가능)
#define		EDITSTY_COMMA			0x00002000		//	3자리마다 ','표시
#define		EDITSTY_HIDDEN			0x00001000		//	'*'로 표시
#define		EDITSTY_READONLY		0x00000800		//	읽기전용
#define		EDITSTY_MULTILINE		0x00000400		//	여러줄 편집
#define		EDITSTY_ACTIVEINVERSE	0x00000200		//	선택되면 영역을 반전시킴
#define		EDITSTY_ACTIVEBOLD		0x00000100		//	선택되면 볼드체로 출력함
#define		EDITSTY_INVERSE			0x00000080		//	영역을 반전시킴
#define		EDITSTY_UNDERLINE		0x00000040		//	밑줄을 그림
#define		EDITSTY_UNDERLINEDOT	0x00000020		//	점선밑줄을 그림

//dkjung 2009-10-21
#define		EDITSTY_TICKER			0x00000010		//	Ticker 처리

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
//nexio를 위해 추가된 큰 아이콘들
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
#define		LISTSTY_BORDER			0x80000000		//	영역에 테두리를 그림
#define		LISTSTY_THICKBORDER		0x40000000		//	두꺼운 선으로 테두리를 그림
#define		LISTSTY_ROUNDBORDER		0x20000000		//	모서리가 둥근 테두리를 그림	
#define		LISTSTY_TITLE			0x08000000		//	제목을 표시함
#define		LISTSTY_LEFTTITLE		0x04000000		//	제목을 상단의 왼쪽에 표시함
#define		LISTSTY_INVERSETITLE	0x02000000		//	제목을 반전시켜 표시함 (검정바탕에 흰색글씨)
#define		LISTSTY_BOLDTITLE		0x01000000		//	제목문자열을 볼드체로 사용함
#define		LISTSTY_HSCROLLBAR		0x00800000		//	수평 스크롤바를 표시함
#define		LISTSTY_VSCROLLBAR		0x00400000		//	수직 스크롤바를 표시함
#define		LISTSTY_WIDESCRLBAR		0x00200000		//	폭이 넓은 스크롤바를 사용함
#define		LISTSTY_ALWAYSSHOWSB	0x00100000		//	스크롤바를 항상 보여줌
#define		LISTSTY_VARSCROLLBAR	FRMSTY_VARSCROLLBAR	//	0x10000000	가변 길이 스크롤 바
#define		LISTSTY_RADIO			0x00080000		//	라디오버튼을 포함하고, 항상 한개만이 선택됨
#define		LISTSTY_CHECK			0x00040000		//	체크박스를 포함함
#define		LISTSTY_RIGHTCHECK		0x00020000		//	체크박스를 오른쪽에 표시함
#define		LISTSTY_CIRCULAR		0x00010000		//	첫항목과 마지막항목을 연속적으로 이동함
#define		LISTSTY_PAGEUPDOWN		0x00008000		//	좌우키를 페이지업다운키로 사용
#define		LISTSTY_VSCROLL			0x00004000		//	수직스크롤을 가능하게 함
#define		LISTSTY_HSCROLL			0x00002000		//	수평스크롤을 가능하게 함
#define		LISTSTY_ICON			0x00001000		//	왼쪽에 아이콘을 가짐
#define		LISTSTY_GRAYICON		0x00000800		//	선택되지 않은 항목의 아이콘을 회색으로 출력함
#define		LISTSTY_DETAIL			0x00000400		//	상세문자열을 가짐
#define		LISTSTY_INVERSE			0x00000200		//	선택된 항목을 반전시킴
#define		LISTSTY_ROUNDINVERSE	0x00000100		//	선택된 항목을 둥글게 반전시킴
#define		LISTSTY_BOLD			0x00000080		//	선택된 항목의 문자열을 볼드체로 출력함
#define		LISTSTY_UNDERLINE		0x00000040		//	선택된 항목에 밑줄을 그림
#define		LISTSTY_BOLDTEXT		0x00000020		//	모든 문자열을 BOLD로
#define		LISTSTY_CURSOR			0x00000010		//	선택된 항목에 지정된 색상을 칠한다.
    
//------------------------------------------------------------------------------
//		list item status (stListItem::Status)
//------------------------------------------------------------------------------
#define		LISTITEM_HASICON		0x8000			//	아이콘을 가지고 있음. 왼쪽에 표시.
#define		LISTITEM_HASARROW		0x4000			//	오른쪽 화살표를 가짐. 오른쪽에 표시. 팝업등에서 이용
#define		LISTITEM_HASSEPARATOR	0x2000			//	아래에 구분자를 가짐.
#define		LISTITEM_DISABLE		0x0080			//	비활성화되어있는 아이템임을 표시.
#define		LISTITEM_CHECKED		0x0040			//	RADIO/CHECK 속성을 가진 경우 선택되어있음을 표시.

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
#define		GRDSTY_STRIPE			0x00000001			//	스트라이프 스타일

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

// MSG_TASK WP 정의
#define		TASK_SYS_CALL			1
#define		TASK_WEB_VIEW			2
#define		TASK_PUSH				3	//PUSH 메시지
#define		TASK_PUSH_CONFIG		4
#define		TASK_PUSH_APPEXIT		5	//APP 종료
#define		TASK_PUSH_LOCK			6	//원격 잠금
#define		TASK_PUSH_UNLOCK		7	//원격 잠금 해제
#define		TASK_PUSH_RESET			8	//원격 리셋

// MSG_UART WP 정의
#define		UART_BARCODE			1
#define		UART_PRINTER			2
#define		UART_CARD				3
#define		UART_CAMERA				4

//TASK_SYS_CALL 이벤트의 LP 정의
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

//외부연동 리스트 컨트롤
#define		EXTCTRL_EDIT			1
#define		EXTCTRL_LIST			2

//바코드 타입
#define		BARCODE_BASIC			1
#define		BARCODE_IMAGE			2

//페이지 업/다운 이벤트
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
#define		KEY_LSOFT_K					10  // BlackJack jysim 2007-06-05 키액션코드값 추가
#define		KEY_RSOFT_K					11  // BlackJack jysim 2007-06-05 키액션코드값 추가
#define		KEY_CANCEL_K				12  // BlackJack jysim 2007-06-05 키액션코드값 추가
#define		KEY_HOME_K					13  // BlackJack jysim 2007-06-06 키액션코드값 추가
#define		KEY_RETURN_K				14  // BlackJack jysim 2007-06-06 키액션코드값 추가
#define		KEY_WRETURN_K				15  // BlackJack jysim 2007-06-07 키액션코드값 추가
#define		KEY_QRETURN_K				16  // BlackJack jysim 2007-06-07 키액션코드값 추가

//dkjung 2007-09-12
#define		KEY_MODE_K					17  // Mode key (0:영문, 1:한글, 2:숫자)
#define		KEY_SHIFT_K					18  // Shift key
#define		KEY_SYMBOL_K				19  // Symbol key

#define		KEY_FACE_BASE				160						
#define		KEY_FACE(X)					(KEY_FACE_BASE+X)		//전면에 붙은 외부버턴
#define		KEY_LEFT_SIDE_BASE			192
#define		KEY_LEFT_SIDE(X)			(KEY_LEFT_SIDE_BASE+X)	//왼쪽에 있는 외부 버턴
#define		KEY_RIGHT_SIDE_BASE			224
#define		KEY_RIGHT_SIDE(X)			(KEY_RIGHT_SIDE_BASE+X)	//오른쪽에 있는 외부 버턴

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
#define		POPSTY_PARENT			0x80000000		//	다른 팝업컨트롤을 가지고 있는 컨트롤이다.
#define		POPSTY_CHILD			0x40000000		//	다른 팝업컨트롤에 소속되어있는 컨트롤이다.
#define		POPSTY_TOP				0x00800000		//	BaseY를 Y1으로 여긴다.
#define		POPSTY_MIDDLE			0x00400000		//	BaseY를 Y1과 Y2의 중간으로 여긴다.
#define		POPSTY_BOTTOM			0x00200000		//	BaseY를 Y2로 여긴다.
#define		POPSTY_LEFT				0x00100000		//	BaseX를 X1으로 여긴다.
#define		POPSTY_CENTER			0x00080000		//	BaseX를 X1과 X2의 중간으로 여긴다.
#define		POPSTY_RIGHT			0x00040000		//	BaseX를 X2로 여긴다.
#define		POPSTY_TITLE			0x00020000		//	제목을 사용한다.
#define		POPSTY_GRAYBACKGROUND	0x00010000		//	배경을 흐리게 만든다.
//#define		POPSTY_SOFTMENU			0x00008000		//	소프트메뉴를 갖는다.

#define		POPSTY_SUBMENU			0x40300000		// 	[POPSTY_CHILD | POPSTY_BOTTOM | POPSTY_LEFT)

//------------------------------------------------------------------------------
//		key process result of popup control
//------------------------------------------------------------------------------
#define		POPRET_NONE				0				//	팝업리스트가 동작하고 있지 않음
#define		POPRET_SUBSTART			1				//	서브메뉴를 시작함
#define		POPRET_SELECT			2				//	팝업리스트에서 항목을 선택하였음
#define		POPRET_CANCEL			3				//	팝업리스트를 취소함
#define		POPRET_DONE				4				//	커서이동등 팝업리스트가 키처리를 하였음
#define		POPRET_ERROR			5				//	키처리 중 오류가 발생하였음

//------------------------------------------------------------------------------
//		whether normal item or sub item in popup control
//------------------------------------------------------------------------------
#define		POPITEM_NORMAL			0
#define		POPITEM_SUBMENU			1

//------------------------------------------------------------------------------
//		select control style (SelCtrl::Frame.Base.Style)
//------------------------------------------------------------------------------
#define		SELSTY_BORDER			0x80000000		//	영역에 테두리를 그림
#define		SELSTY_THICKBORDER		0x40000000		//	두꺼운 선으로 테두리를 그림
#define		SELSTY_ROUNDBORDER		0x20000000		//	모서리가 둥근 테두리를 그림
#define		SELSTY_TITLE			0x08000000		//	제목을 표시함
#define		SELSTY_LEFTTITLE		0x04000000		//	제목을 상단의 왼쪽에 표시함
#define		SELSTY_INVERSETITLE		0x02000000		//	제목을 반전시켜 표시함 (검정바탕에 흰색글씨)
#define		SELSTY_BOLDTITLE		0x01000000		//	제목문자열을 볼드체로 사용함
#define		SELSTY_HSCROLLBAR		0x00800000		//	수평 스크롤바를 표시함
#define		SELSTY_VSCROLLBAR		0x00400000		//	수직 스크롤바를 표시함
#define		SELSTY_WIDESCRLBAR		0x00200000		//	폭이 넓은 스크롤바를 사용함
#define		SELSTY_ALWAYSSHOWSB		0x00100000		//	스크롤바를 항상 보여줌
#define		SELSTY_VARSCROLLBAR		FRMSTY_VARSCROLLBAR	//	0x10000000	가변 길이 스크롤 바
#define		SELSTY_UNDERLINE		0x00080000		//	밑줄을 그림
#define		SELSTY_UNDERLINEDOT		0x00040000		//	점선밑줄을 그림
#define		SELSTY_HORIZONTAL		0x00020000
#define		SELSTY_VERTICAL			0x00010000
#define		SELSTY_SHORTNUM			0x00008000
#define		SELSTY_CIRCULAR			0x00004000
#define		SELSTY_HASTAG			0x00002000
#define		SELSTY_LEFTTAG			0x00001000
#define		SELSTY_ARROW			0x00000800
#define		SELSTY_CENTERALIGN		0x00000400		//	가운데 정렬
#define		SELSTY_RIGHTALIGN		0x00000200
#define		SELSTY_INVERSE			0x00000100		//	활성화 되어있을 때 반전시킴
#define		SELSTY_BOLD				0x00000080

//-----------------------------------------------------------------------------
//	포인팅 프로세서의 리턴값 종류 (PointingProcess Return value)
//-----------------------------------------------------------------------------
#define		PPRET_NONE					0x00000000			//	리턴값 없음 (오류포함)
#define		PPRET_DONE					0x00000001			//	더 이상 처리할 필요가 없음
#define		PPRET_UP					0x00000002			//	포인팅 디바이스를 띄워졌음
#define		PPRET_DOWN					0x00000004			//	포인팅 디바이스가 눌려졌음
#define		PPRET_MOVE					0x00000008			//	포인팅 디바이스가 움직였음
#define		PPRET_SB_UP					0x00000010			//	스크롤바의 위화살표에 위치함
#define		PPRET_SB_DOWN				0x00000020			//	스크롤바의 아래화살표에 위치함
#define		PPRET_SB_LEFT				0x00000030			//	스크롤바의 왼쪽화살표에 위치함
#define		PPRET_SB_RIGHT				0x00000040			//	스크롤바의 오른쪽 화살표에 위치함
#define		PPRET_SB_PAGEUP				0x00000050			//	스크롤바의 페이지업 영역에 위치함
#define		PPRET_SB_PAGEDOWN			0x00000060			//	스크롤바의 페이지다운 영역에 위치함
#define		PPRET_SB_PAGELEFT			0x00000070			//	스크롤바의 페이지레프트 영역에 위치함
#define		PPRET_SB_PAGERIGHT			0x00000080			//	스크롤바의 페이지라이트 영역에 위치함
#define		PPRET_SB_HBAR				0x00000090			//	수평 스크롤바 위에 위치함
#define		PPRET_SB_VBAR				0x000000A0			//	수직 스크롤바 위에 위치함
#define		PPRET_SB_MASK				0x000000F0			//	스크롤바 마스크
#define		PPRET_OUT_OF_RANGE			0x00000100			//	캡쳐영역 밖에 있음..

//------------------------------------------------------------------------------
//		select control flag (SelCtrl::Flag)
//------------------------------------------------------------------------------
#define		SELFLAG_ASSIGNSTRSET	0x80			//	StringSet을 직접 지정하여 사용함

#endif	//	GRSYSDEF_H


