/*----------------------------------------------------------------------------------
	Project Name: Smart SCGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2014.10.01	dkjung		v 3.0.1		: Create 스마트폰 포팅
----------------------------------------------------------------------------------*/


#ifndef __COMDEF_H__
#define __COMDEF_H__

#include "DefType.h"

	// dkjung 2004-07-09
	// 전체 영역에 공통으로 사용하는 선언들을 모아 두는 곳
	
	#define	LAST_VERSION 	"BUILD : "__DATE__"/"__TIME__
	#define SET_IP(a,b,c,d) ( (((quad)a)<<24) | (((quad)b)<<16) | (((quad)c)<<8) | ((quad)d) )
	// 1. 코드성 선언
	// 2. 공통의 구조체 선언
	// 3. 기타 생각나는 모든 것들...

//-----------------------------------------------------------------------------
// 커스텀 색상 정의
//-----------------------------------------------------------------------------
#define 	TRANSPARENT		MAKE_RGB(255,   0, 255)			//투명색
#define		BTN_LOGINBK		MAKE_RGB(18, 131, 189)			//로그인버튼배경
#define		BTN_PDACHGBK	MAKE_RGB(112, 112, 112)			//PDA변경(비밀번호) 버튼배경
#define		BTN_BKCOLOR		MAKE_RGB(80, 80, 80)			//기본버튼배경
//#define		BTN_KEYCOLOR	MAKE_8_16(219)				//숫자 패드 버튼의 배경색
#define		BTN_FRCOLOR		MAKE_RGB(255, 255, 255)			//기본버튼글자색
#define		BTN_SUBBK		MAKE_RGB(129, 129, 129)			//서브버튼배경
//#define		BTN_CANTBK		MAKE_RGB(186, 186, 186)		//기본(서브)비활성배경
#define		BTN_IMPBK		MAKE_RGB(54, 107, 190)			//중요버튼 배경
#define		BTN_PDAIMPBK	MAKE_RGB(67, 132, 235)			//PDA중요버튼 배경
//#define		BTN_IMPNOTBK	MAKE_RGB(129, 156, 197)		//중요버튼 비활성배경
#define		BTN_IMPFR		MAKE_RGB(255, 216, 0)			//중요버튼글자색
//#define		MAINTTLBK		MAKE_RGB(2, 50, 112)	    //메인타이틀 색상

#define		TTLCTRLBK			MAKE_RGB(255,   0, 255)		//타이틀 배경 ,투명색
#define		TTLCTRLFR			MAKE_RGB(255, 255, 255)		//타이틀글자색
//#define		TXTCTRLBK			MAKE_RGB(229, 229, 229)		//텍스트 중요 배경
#define		PDATXTCTRLBK		MAKE_RGB(213, 213, 213)		//PDA텍스트 중요 배경
#define		TXTINCTRLBK			MAKE_RGB(255, 255, 255)		//텍스트 서브 배경

#define		EDTCTRLBK			MAKE_RGB(255, 251, 204)		//에디트,콤보 배경
#define		PDAEDTCTRLBK		MAKE_RGB(255, 251, 204)		//MAKE_RGB(255, 242, 0)		PDA에디트,콤보 배경

#define		TTLCTRLSUBK			MAKE_RGB(208, 208, 208)  
#define		TXTCTRLSUBK			MAKE_RGB(62,   81, 153)
#define		TXTFRCOLOR			MAKE_RGB(80, 80, 80)		//기본 글자색 - 흰 배경
#define		TXTTTLFRCOLOR		MAKE_RGB(255, 255, 255)		//기본 글자색 - 회색 배경
//#define		GRIDTTLBK			MAKE_RGB(229, 229, 229)		//테이블 제목 , <<--원본 주석 풀기!!!


//*****************************************************
//2차 시안
#define		GRIDTTLBK				MAKE_RGB(233, 242, 255)		//테이블 제목
#define		TXTCTRLBKGRAY			MAKE_RGB(177,   177, 177)
#define		TXTCTRLBKWHITE			MAKE_RGB(250,   250, 250)
#define		TXTCTRLBKBLUE			MAKE_RGB(112,   155, 230)
#define		TXTCTRLBKRED			MAKE_RGB(232,   79, 79)
#define     TXTCTRLBK				TXTCTRLBKGRAY
#define		TXTCTRLPAGEBK			MAKE_RGB(127,    181, 255)		//계량기교체리스트 페이지표시 배경
#define		TXTCTRLRSLTBK			MAKE_RGB(250,    250, 250)		//계량기교체리스트 전체,교체,미교체 텍스트 배경
#define		TXTCTRLFRCOLOR			MAKE_RGB(55,     55, 55)

#define		BTNCTRLBKBLACK			MAKE_RGB(68,    68, 68)
//#define		BTNCTRLBKCOLOR		    MAKE_RGB(255,    255, 255)	//2차 시안 버튼 배경색 - 원본
#define		BTNCTRLBKCOLOR		    MAKE_RGB(56,    128, 228)				//2차 시안 버튼 배경색 - 색상 변경 테스트
#define		BTNCTRLGRAY		        MAKE_RGB(181,   178, 181)				//계량기 민원교체 설치계량기 색깔 변경 (회색)
//#define		BTNCTRLBKCOLOR		    TABLETITLE_COLOR				//2차 시안 버튼 배경색 - 색상 변경 테스트
//#define		BTNMENUFRCOLOR			MAKE_RGB(55, 55, 55)		//2차 시안 버튼글자색 - 원본
#define		BTNCTRLFRCOLOR_NP		MAKE_RGB(255, 255, 255)			//2차 시안 버튼글자색 - 체납활동 버튼
#define		BTNMENUFRCOLOR			BTNCTRLFRCOLOR_NP			//2차 시안 버튼글자색 - 테스트


#define		LINECTRLCOLOR			MAKE_RGB(227,    227, 227)		//계량기교체메뉴 라인 컨트롤 색상

//*****************************************************

//skyblue 색상 MAKE_RGB(142, 186, 244)
//#define		BTNCTRLBKCOLOR		MAKE_RGB(80, 80, 80)			//기본버튼배경
#define		BTNCTRLSIDECOLOR	MAKE_RGB(80, 80, 80)				//버튼 테두리
#define		BTNCTRLFRCOLOR		MAKE_RGB(64, 92, 171)				
//#define		BTNCTRLBKCOLOR      MAKE_RGB(103, 176, 243)				//일반버튼배경색
//#define		BTNMENUFRCOLOR		MAKE_RGB(255, 255, 255)				//메뉴버튼글자색
#define		BTNCHKFRCOLOR		MAKE_RGB(80, 80, 80)				//콤보박스 글자색
#define		TABLEACTIVECOLOR	MAKE_RGB(255, 234, 208)				//테이블 클릭시
//#define		TABLEACTIVECOLOR	MAKE_RGB(255, 160, 60)			//테이블 클릭시 <<<--원본!!! 주석 풀기!!!!!!
#define		BTNCTRLMNBKCOLOR	MAKE_RGB(255,   0, 255)				//투명색
#define		MEGBKCOLOR			MAKE_RGB(18, 131, 189)				//팝업 배경

//#define		MEGBKCOLOR_CONFIRM		MAKE_RGB(154, 193, 66)		//알림팝업 타이틀배경
//#define		MEGBKCOLOR_CONFIRM		MEDIUMSEAGREEN				//알림팝업 타이틀배경
#define		MEGBKCOLOR_CONFIRM		LIGHTSKYBLUE					//알림팝업 타이틀배경
//#define		MEGBKCOLOR_WARNING		MAKE_RGB(255, 138, 0)		//경고팝업 타이틀배경
#define		MEGBKCOLOR_WARNING		CORAL		//경고팝업 타이틀배경
//#define		MEGBKCOLOR_ERROR		MAKE_RGB(238, 28, 36)		//에러팝업 타이틀배경
#define		MEGBKCOLOR_ERROR		CRIMSON		//에러팝업 타이틀배경

#define		MAINBKCOLOR			MAKE_RGB(255, 255, 255)

#define		TABCOLOR1		MAKE_RGB(74, 122, 182)		//고객1
#define		TABCOLOR2		MAKE_RGB(91, 113, 169)		//수납2
#define		TABCOLOR3		MAKE_RGB(111, 131, 181)		//
#define		TABCOLOR4		MAKE_RGB(146, 130, 175)		//시공비4
#define		TABCOLOR5		MAKE_RGB(172, 136, 172)		//정산5
#define		TABCOLOR6		MAKE_RGB(107, 166, 161)		//
#define		TABCOLOR7		MAKE_RGB(138, 162, 104)		//연소기7
#define		TABCOLOR8		MAKE_RGB(114, 114, 114)		//서명8
#define		TABCOLOR9		MAKE_RGB(179, 151, 114)		//해지9
#define		TABCOLOR10		MAKE_RGB(159, 128, 113)		//중지10
#define		TABCOLOR11		MAKE_RGB(111, 122, 147)		//성능검사11


// 테이블과 관련된 컬러
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
