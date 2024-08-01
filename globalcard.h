/*----------------------------------------------------------------------------------
	Project Name: Smart SCGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
----------------------------------------------------------------------------------*/

#ifndef		__GLOBALCRAD_H__
#define		__GLOBALCRAD_H__

#define PNG_EXIT		"pngi"
#define IMG_DIR 		"IMG\\"

#define WQHD_DIR 		"WQHD\\"
#define FHD_DIR 		"FHD\\"
#define HD720_DIR 		"HD720\\"
#define PDA_DIR 		"PDA\\"
#define SMART_DIR 		"SMART\\"

#define IODEV_WOOSIM	"WOOSIM"
#define IODEV_PM80		"PM80"
#define IODEV_DEFAULT	IODEV_PM80
#define PHOTO_BARCODE	"P"
#define BEAM_BARCODE	"B"
//#define CHG_OPTION			//셋팅 바코드 설정

#include	"ComDef.h"

#include	"FileMgr.h"	
#include 	"CardGui.h"
#include 	"SQL.h"
#include	"ChkCode.h"		//업무 코드
#include	"GmData.h"		//검침
#include	"ScData.h"		//안전점검
#include	"BsData.h"		//안전점검
#include	"BfData.h"		//공급전
#include	"C6202Data.h"	//체납
#include	"C6301Data.h"	//계량기교체
#include	"C6101Data.h"	//민원
#include	"McData.h"		//이동고객센터
#include    "MudData.h"		//모바일사용계약서

//┌─────────────────────────────────────┐
//│ 		로그인정보파일 및 검침, 안전점검정보 파일                        │
//└─────────────────────────────────────┘

#define SERVER_IP		1
#define SERVER_PORT		2
#define DEFAULT_FONT	3
#define LARGE_FONT		4
#define PRINT_PORT		5
#define DB_CHGDATE		6

//-----------------------------------------------------------------------------
// 이벤트 체크시간(엔진 100ms-> 1, 20ms->5, 10ms->10 )
// 
//-----------------------------------------------------------------------------
#define TIMERPERIOD		1000


#define SYSTEM_COMM      	"system/comm/"
#define SREACH_FILE	 		"SREACHFILE.dat"
#define CMBFILTER_FILE 		"CMBFILTER.dat"		//콤보박스 필터링 시 index저장을 위한 모든 대상 저장 파일
#define GROUP_FILE			"GROUPFILE.dat"		//체납 그룹리스트 그룹 테이블 ROW 갯수 파악을 위한 파일.
#define SRCH_FS_SIZE		10
#define SRCH_FS_INDEX_POS   0

//-----------------------------------------------------------------------------
// 다이얼로그 타이틀 높이
//-----------------------------------------------------------------------------
#define TITLE_HEIGHT 	72

#define CWD			25
#define CHT			40
#define COMWD		70
//#define STARTX		5
#define STARTX		0
#define	STARTY		100
#define	STARTPOPY	80

//-----------------------------------------------------------------------------
// 스마트폰 타이틀(화면명) 높이
//-----------------------------------------------------------------------------
//메인
#define TX			0
#define TY			95
#define STWD		1000
#define STHT		70

//스마트폰 팝업 이전 버튼
#define POPTX		0
#define POPTY		0
#define POPSTWD		995
#define POPSTHT		70

//-----------------------------------------------------------------------------
// PDA 타이틀(화면명) 높이
//-----------------------------------------------------------------------------
//메인
#define P_TX		2
#define P_TY		2
#define P_STWD		985
#define P_STHT		55

//팝업
#define P_TTLTX		0			//PDA 타이틀 이미지 X 시작 위치
#define P_POPTX		1
#define P_POPTY		1
#define P_POPSTWD	950
#define P_POPSTHT	70

//-----------------------------------------------------------------------------
// 스마트폰 메인버튼 상단 7개
//-----------------------------------------------------------------------------
/*
#define BTNX_1		5
#define BTNX_2		200
#define BTNX_3		400
#define BTNX_4		600
#define BTNX_5		797
#define BTNX_6		5
#define BTNX_7		870
#define BTNY_1		3
#define BTNY_2		95
#define BTNWD_1		200
#define BTNWD_2		120
#define BTNHT_1		95
#define BTNHT_2		70
*/
#define BTNX_1		0
#define BTNX_2		200
#define BTNX_3		400
#define BTNX_4		600
#define BTNX_5		800
#define BTNX_6		5
#define BTNX_7		870
#define BTNY_1		0
#define BTNY_2		95
#define BTNWD_1		200
#define BTNWD_2		120
#define BTNHT_1		95
#define BTNHT_2		70


#define P_BTNX		870
#define P_BTNY		0
#define P_BTNWD		125
#define P_BTNHD		55
/*
#define P_BTNX		925
#define P_BTNY		5
#define P_BTNWD		54
#define P_BTNHD		45
*/
//-----------------------------------------------------------------------------
// 스마트폰 메뉴버튼
//-----------------------------------------------------------------------------
//1차 버튼
#define BTNMNWD		490
#define BTNMNHT		140

//2차 버튼
//가로길이는 일정하나, 세로길이는 화면별 버튼 갯수에 따라 가변. 각 카드 확인. 가장 대표적인 값 정의
#define BTNWH		499
#define BTNHT		208
#define BTNHT_SC    165

//-----------------------------------------------------------------------------
// PDA 메뉴버튼
//-----------------------------------------------------------------------------
#define P_BTNMNWD	670
#define P_BTNMNHT	80

//-----------------------------------------------------------------------------
// 버튼 클릭 시, 메세지박스 버튼 소리
//-----------------------------------------------------------------------------
#define CLICKSOUND "SCGGAS/keypress.wavv"
#define MSGSOUND "SCGGAS/message.wavv"

//-----------------------------------------------------------------------------
// 체크박스 표시 & 부적합 체크
//-----------------------------------------------------------------------------
#define CHKOFF	   "□"
#define CHKON	   "▣"

#define CHKGOOD    "□"  //적합
#define CHKNOGOOD  "▣"  //부적합

//-----------------------------------------------------------------------------
// 블루투스 프린터관련
//-----------------------------------------------------------------------------
#define LEFT  	0
#define RIGHT 	1
#define CENTER 	2

//-----------------------------------------------------------------------------
// 서명 및 사진 관련 내역.
//-----------------------------------------------------------------------------
#define SIGN_BYTES_PER_LINE		20
#define SIGN_WIDTH	(SIGN_BYTES_PER_LINE * 8)
#define SIGN_HEIGHT	100
#define SIGN_HEADER	5
#define BMP_HEADER	62
#define WBMP_SIZE	2005
#define BMP_SIZE	2062

global	byte g_SignBuf[SIGN_BYTES_PER_LINE * SIGN_HEIGHT + BMP_HEADER];
global	byte g_ucSignDest[(SIGN_BYTES_PER_LINE+1) * SIGN_HEIGHT + BMP_HEADER];
global	byte g_ucSignSrc[SIGN_BYTES_PER_LINE * SIGN_HEIGHT + BMP_HEADER];

global	long g_png_getbmp(long width, long height, byte* img );
global	long BtoI (byte* pBuf, long length);
//디비에 저장하기위해서 base64인코딩함.
global	void g_PhtoBase64(char* szpath, handle* Base64, char* pRst);

//다운로드 매크로
#define HTTP_DownloadTR(ret, url, trcode, snd_buf, db_nm)\
		callBackfunc = TR##trcode;\
		ret = HTTP_DownloadData(url, "FR" #trcode "_IN",  "FR" #trcode , snd_buf, db_nm)

//====================================================================
/*   ****업무 별 g_nWorkFlag 값****
<검침 업무>
g_nWorkFlag = 100		정상검침
g_nWorkFlag = 101		선택검침(검색)
g_nWorkFlag = 102		검침완료 목록(리스트)
g_nWorkFlag = 103		미검침 목록(리스트)
g_nWorkFlag = 104		부재(리스트)

<안전 점검 업무>
g_nWorkFlag = 200		안전점검
g_nWorkFlag = 201		실적관리
g_nWorkFlag = 202		개선권고
g_nWorkFlag = 203		조정기
g_nWorkFlag = 204		예약점검 목록(리스트)
g_nWorkFlag = 205   	지정점검(검색)
g_nWorkFlag = 206		점검완료 목록(리스트)
g_nWorkFlag = 207		순수미점검 목록(리스트)
g_nWorkFlag = 208		우선점검 목록(리스트)
g_nWorkFlag = 209		선택점검 목록(리스트)
g_nWorkFlag = 210		부재미점검 목록(리스트)

<특정 점검 업무>
g_nWorkFlag = 300		정기특정점검 전체
g_nWorkFlag = 301		정기특정점검 미점검리스트
g_nWorkFlag = 302		정기특정점검 우선점검리스트
g_nWorkFlag = 303		정기특정점검 일반점검리스트
g_nWorkFlag = 304		개선권고
g_nWorkFlag = 305		우선특정점검 전체
g_nWorkFlag = 306		우선특정점검 미점검리스트

<공통 업무>
g_nWorkFlag = 400		공통업무
g_nWorkFlag = 410		메모

<공급전 점검>
g_nWorkFlag = 500	    공급전점검 단독
g_nWorkFlag = 501       공급전점검 단독 리스트(미검)
g_nWorkFlag = 502       공급전점검 단독 리스트(동 그룹)	
g_nWorkFlag = 510	    공급전점검 공동 그룹리스트 전체
g_nWorkFlag = 511	    공급전점검 공동 그룹리스트(동 그룹)
g_nWorkFlag = 512	    공급전점검 공동 상세리스트 전체
g_nWorkFlag = 513	    공급전점검 공동 상세리스트 미검

<민원>
g_nWorkFlag = 600
g_nWorkFlag = 610:전입[고객, 연소기, 상품, 일회성, 요금 ]
g_nWorkFlag = 620:전출[고객, 연소기, 정산,  일회성, 요금 ]
g_nWorkFlag = 630:중지[고객, 정산, 중지, 일회성, 요금 ]
g_nWorkFlag = 640:해제[고객, 해제, 일회성, 요금 ]
g_nWorkFlag = 650:교체[고객, 연소기, 계량기, 일회성, 요금 ]
g_nWorkFlag = 660:점검[고객, 연소기, 점검(계량기교체), 일회성, 요금 ]
g_nWorkFlag = 698:민원 업무보고
g_nWorkFlag = 699:민원 현장실사

<계량기 교체>
g_nWorkFlag = 700		계량기교체 노후리스트
g_nWorkFlag = 701		계량기교체 노후리스트(미실시)
g_nWorkFlag = 702		계량기교체 노후리스트(교체)

g_nWorkFlag = 710		계량기교체 민원리스트
g_nWorkFlag = 711		계량기교체 민원리스트(미실시)
g_nWorkFlag = 712		계량기교체 민원리스트(교체)

g_nWorkFlag = 720		계량기교체 교체불가리스트
g_nWorkFlag = 721		계량기교체 교체불가리스트(미실시)
g_nWorkFlag = 722		계량기교체 교체불가리스트(교체)

g_nWorkFlag = 730		계량기교체 선택리스트
g_nWorkFlag = 731		계량기교체 선택리스트(미실시)
g_nWorkFlag = 732		계량기교체 선택리스트(교체)
g_nWorkFlag = 733		계량기교체 선택리스트(계량기,기물번호 검색)
g_nWorkFlag = 734		계량기교체 선택리스트(주소검색)

<체납>
g_nWorkFlag = 800		체납 기본 상세리스트(테이블 더블클릭)
g_nWorkFlag = 801		체납 경매활동 상세리스트
g_nWorkFlag = 802		체납 중지활동 상세리스트
g_nWorkFlag = 803		체납 정상 상세리스트
g_nWorkFlag = 804		체납 금액 상세리스트
g_nWorkFlag = 805		체납 체납월수 상세리스트

g_nWorkFlag = 810		체납 개별활동

g_nWorkFlag = 820		해제활동

g_nWorkFlag = 830		중지활동

g_nWorkFlag = 840		경매정보

g_nWorkFlag = 850		납부확약서대상

g_nWorkFlag = 860		체납 가정용 상세리스트
g_nWorkFlag = 861		체납 가정용 금액 상세리스트
g_nWorkFlag = 862		체납 가정용 체납월수 상세리스트

g_nWorkFlag = 870		체납 비가정용 상세리스트
g_nWorkFlag = 871		체납 비가정용 금액 상세리스트
g_nWorkFlag = 872		체납 비가정용 체납월수 상세리스트

*/

//====================================================================
/*   ****업무 별 RCV_LOG 테이블 GUBUN 값****
<검침 업무>
GUBUN = 1

<안전점검 업무>
GUBUN = 2
GUBUN = 3

<조정기점검 업무>
GUBUN = 4

<특정점검 업무>
GUBUN = 5

<공급전점검 업무>
GUBUN = 6

<민원 업무>
GUBUN = 7

<계량기교체 업무>
GUBUN = 8

<체납 업무>
GUBUN = 9

*/

//====================================================================

global	quad	g_HostIP;			    	//서버 접속 IP
global	quad	g_HostPort;			    	//서버 접속 포트번호
global	char	g_szPrintPort[11];	    	//프린터 연결포트
global	char	g_szBarcodeSet[5];	    	//바코드 설정 값(P: 카메라바코드 , B: 빔 바코드)
global	char	g_szDEVICE_NAME[32];		//

global	char	g_szROWID[5];	        	//ROWID
global	char	g_szCHK_EXEC_NUM[13];		//점검시행번호 (점검, 특정)
global	char	g_szSubCHK_EXEC_NUM[13];	//안전점검 요금수신 화면 갈때 해당 점검번호
global	char	g_szUSE_CONT_NUM[15];		//사용계약번호 (검침, 점검, 체납)
global	char	g_szUSE_CONT_NUM_Fee[15];	//사용계약번호 (검침 요금조회 - 요금계산)
global	char	g_szMTR_NUM[11];			//계량기번호 (검침, 점검, 특정,공급전, 계량기교체, 체납)
global	char	g_szMTR_ID_NUM[20];			//계량기 기물번호 (검침, 점검, 특정,공급전, 계량기교체, 체납)
global	char	g_szCUST_NUM[15];			//고객번호 (검침, 점검)
global	char	g_szINST_PLACE_NUM[19];		//설치장소번호 (검침이력)
global	char	g_szREGTR_NUM[9];			//조정기번호 (점검)
global  char    g_szIndi_Cur[20];			//계량기점검 지침(검침 요금조회 지침, 특정,안전점검)
global  char    g_szCHK_EXCEP_WHY[10];		//계량기점검 제외사유(특정)
global  char    g_szCREATE_YMD[9];      	//공급전점검
global  char    g_szBURNER_NUM[7];      	//공급전점검
global  char    g_szBLD_NUM[10];        	//공급전점검(공동) 건물번호
global  char    g_szOBJ_CRT_YMD[9];			//대상생성일자(계량기교체)
global  char    g_szCpNum[20];				//대상 핸드폰 번호(문자검침, 안전점검 부적합대상)
global	char	g_szCp_ddd[6];				//대상 핸드폰 번호(문자검침, 안전점검 부적합대상)
global	char	g_szCp_exn[6];				//대상 핸드폰 번호(문자검침, 안전점검 부적합대상)
global	char	g_szCp_num[6];				//대상 핸드폰 번호(문자검침, 안전점검 부적합대상)
global  char    g_szCmb_Str[50];      		//콤보박스 필터링 값(문자검침,민원)

global  char    g_szphoto[128];				//부적합 파일명
global  void *    g_pszphoto;				//부적합 파일명
global  char    g_szTown[51];
global  char    g_szCurrBar[21];            //안전점검 바코드 검색 대상찾기 , 특정 바코드 스캔시 데이터 저장
global  char    g_szINS_JOIN[3];            //공급전 단독,공동 보험가입여부
global  char    g_szINS_EXPLA[3];           //공급전 단독,공동 설명 여부
global  char    g_szMtr_Code[11];           //검침코드
global  char    g_szIndi_Vm[10];
global  char    g_szIndi_Va[10];
global  char    g_szIndi_Vc[10];
global  char    g_szMtr_Loc_Flag[10];       //안전점검 계량기 점검 -> 위치구분
global  char    g_szSealed_Sts[10];         //안전점검 계량기 점검 -> 봉인여부
global  char    g_szFuseCock[10];	        //안전점검 연소기 점검 -> 퓨즈콕
global  char    g_szTimerCock[10];          //안전점검 연소기 점검 -> 타이머콕
global  char    g_szKitsprinkler[10];       //안전점검 연소기 점검 -> 주방자동소화장치
global  char    g_Pipe_Bury_Yn[3];          //특정 계량기 배관점검 결과
global  char    g_Pipe_Hide_Yn[3];          //특정 계량기 배관점검 결과
global  char    g_szPtrn_Week[5];           //안전점검 선택점검 콤보박스 필터링 값
global  char    g_szPtrn_Time[5];           //안전점검 선택점검 콤보박스 필터링 값
global	char	g_szSqlWhere[512];          //계량기 선택교체 , 체납 그룹->상세 리스트 이동, where 조건
global	char	g_szCntSql[512];            //체납 상세리스트 rowid 파일에 담는 쿼리.

global	long 	g_TRNUM;                    //통신용 플래그
global	long	g_nScrollIndex;				//Grid 스크롤 인덱스 저장 변수
global	long 	g_lindex;                   //데이터는 레코드의 위치
global	long	g_nActIndex;                //index 번호
global	long	g_nObjIndex;                //특정점검 계량기 index 번호
global	long	g_nActRow;                  //선택된 Row(계량기점검 화면 같은 곳에서 사용)
global	long	g_nChkIndex;                //부적합 점검 리스트 index
global	long	g_nGrpIndex;                //공급전 공동 그룹리스트 index
global	long	g_nBackFlag;                //업무중 backup을 위한 flag
global  long    g_nKeyMode;                 //SetKeymode Test 변수
global  long    g_nUserData;                //검침 업무 UserData 저장 , g_nUserData = 10 계량기, g_nUserData = 40, 41 온도온압보정기,  g_nUserData = 20 보정기(자세한 정보는 검침등록화면 m_lUserData 확인)

global	long	g_nWorkFlag;                //업무구분 플래그 
global	long	g_nAddrFlag;                //구주소&신주소 플래그 g_nAddrFlag = 0 -> 구주소    g_nAddrFlag = 1 -> 신주소
global  long    g_nTelFlag;                 //검침등록,점검시작 등 전화번호 flag , g_nTelFlag = 0 > 핸드폰 , g_nTelFlag = 1 > 집,회사
global  long    g_nNameFlag;                //검침등록,점검시작 등 이름,상호명 flag , g_nNameFlag = 0 > 이름, g_nNameFlag = 1 > 회사,상호
global  long    g_nGrpFlag;                 //검침 그룹,상세 리스트 인덱스 관련 flag
global  long    g_nGmType;                  //검침 타입 = 0 : 정기점검, 1 : 재감
global  long 	g_nGmKind;					//계량기노후교체 계량기종류 구분

//g_lDataflag , 0 -> 호출, 1 -> 호출X, SetData를 다시 호출 안하도록하기위한 flag, 처음 화면 들어왔을 시에 1번, 이전&다음화면, 저장 할때만 실행.
//검침 요금조회 대상 검색 -> SetData를 다시 호출 안하도록하기위한 flag, 1 -> 요금내역, 2 -> 요금계산
global	long	g_lDataflag;		
global	long	g_nMemoFlag;                //검침,점검,조정기 구분 플래그, 1:검침 , 2:안전점검, 3:조정기, 4:특정점검 메모, 5:특정점검 계량기 메모, 6:계량기교체 메모, 7:민원실사 메모(보여주기용?)
global	long	g_nSmsFlag;                 //문자전송 화면 구분 플래그, 1:검침부재메세지 , 2:문자검침 - 등록/변경, 3:요금조회 - 요금내역, 4:요금조회 - 요금계산, 5:문자검침
global	long	g_lSCMoveFlag;              //점검 화면 관련 화면이동 flag(안전점검,특정점검)
global	long	g_lMoveFlag;                //(리스트 index) 화면 관련 화면이동 flag, g_lMoveFlag = 0 > default , g_lMoveFlag = 1 > 화면이동, 문자검침 사용
global  long    g_lNewBurFlag;              //안전점검 삭제취소 타이틀 구분, 특정점검 연소기 신규등록 구분 플래그(보일러, 연소기) g_lNewBurFlag = 1:보일러, 2:연소기
global  long    g_lConfrimFlag;             //(특정점검 등)업무 화면 확인 체크 관련 Flag =0 default, =1 이동
global	long	g_lPAYFlag;                 //요금조회 요청여부, 검침 요금조회 0 : 요금계산 실행 X , 1 : 요금계산 실행.
global  long    g_lRfrmFlag;                //점검시작에 부적합발행 텍스트 구분 플래그, = 0 default, =1 이동
global  long    g_lGrpCmbFlag;              //공급전 공동 콤보박스 그룹 리스트 관련 index, 
global  long    g_lDtlCmbFlag;              //공급전 공동 콤보박스 상세 리스트 관련 index, 
global  long    g_lPtrnFlag;                //안전점검 고객패턴 flag , g_lPtrnFlag = 1 점검등록화면, g_lPtrnFlag = 2 고객정보 화면
global  long    g_nPhotoFlag;               //포토플래그( 검침:1, 안전점검:2, 조정기:3, 특정점검:4, 공급전안전점검:5, 민원:6, 계량기교체:7, 보정기교체:8)
                                            //요금조회 화면이동( 검침:1, 안전점검:2, 조정기:3, 특정점검:4, 공급전안전점검:5)
global	long	g_nPhotoYNFlag;             //계량기교체, 사진 촬영 여부 확인 FLAG, 0 = 촬영 안함. 1 = 촬영 완료.
global  long    g_nWorkChkFlag;             //업무 별 부적합 점검 구분 플래그 , 아래 참고
global  long    g_nBojungFlag;              //계량기 보정기기 유무 Flag , Flag = 0 보정기없음, Flag = 1 보정기있음, Flag = 2 단일보정기
global  long    g_lNpChkFlag;               //체납활동 계량기 월별 체납금액 테이블 헤더 chkbox 체크 여부 flag , = 1 체크, =0 체크X
global  long    g_lNpMemoChkFlag;           //체납대상 메모 확인 Flag, = 0 메모 존재 시 자동 호출 , = 1 메모가 존재해도 한번 호출???자동호출 안함
global	long	g_lChgMtr_WorkFlag;			//g_lChgMtr_WorkFlag > = 0 가정용 계량기, = 1 대용량 계량기, = 2 보정기

global  long    g_nCustFlag;                //민원 이전고객정보 읽기
global  long    g_nStopReleFlag;            //중지, 해지 등록플래그
global  long    g_nSmsSndFlag;              //검침 개별메시지 발송 확인 flag , =0 발송X , =1발송
global	long	g_nNogoodDelCnt;			//안전점검 삭제 연소기(보일러) 부적합 건수 카운트 

global  char    g_history_yn[2]; 			// 상담이력 존재여부

global	long	g_lUpgradeChk;				//로그인 시 푸시 vm업그레이드 확인 기능 호출 flag,  = 0 실행 , = 1 실행X

global	long	g_szCHK_PLAN_YM[6];			//조정기점검 점검계획년월
global	long	g_szSAFE_CHK_TYPE[2];		//조정기점검 안전점검 유형 flag, = 23 조정기점검, = 18 확인점검

global	char	g_szSERV_ADD_YN[2];		    //사전접수고객 YN flag, = Y 사전접수고객, = N 사전접수고객아님

global  long    g_nProdMoveFlag;			//상품변경 화면에서 빠져나올때 이동할 대상 Flag 관리, = 0 보일러점검, =1 연소기점검

global  long    g_lWmtrMoveFlag;            //민원 상품화면에서 상품변경화면으로 바로 들어갈지 묻는 flag, flag = 1 -> 상품변경화면

/**********************************/
/* 유지보수                       */
/**********************************/
/* 안전점검 */
global  long    g_nBoil_inst_cnt;			// 보일러 10년 경과 알림
global  long    g_lBoil_Chk_Flag;			// 안전점검 보일러점검에서 현장의 보일러 현황자원 일치 문의 flag : 0 = 아니오 1 = 예
global  char    g_szRfrmComboFlag[10];		// 개선리스트 콤보 flag 

/* 체납 */
global  long    g_nHomeLstFlag;			    // 가정용 : 1, 비가정용 : 2
global	long	g_szNpMonthFlag;     	    // 활동 리스트 월 필터 flag, = 0 기본, 1 = 오름차순, 2 = 내림차순 

/* 카드 결재 관련 */
global	long	g_lGasCardFlag;     	    // 가스카드승인 flag, = 0 카드승인, = 1 승인취소
global	long	g_lGasRecevieFlag;     	    // 가스직수납 flag, = 0 직수납, = 1 직수납 취소
global	long	g_lOneCardFlag;     	    // 일회성카드승인 flag, = 0 카드승인, = 1 승인취소
global	long	g_lOneRecevieFlag;     	    // 일회성직수납 flag, = 0 직수납, = 1 직수납 취소
global	char	g_szGas_ApproRslt[60];      // 가스요금_승인결과
global	char	g_szOne_ApproRslt[60];      // 일회성요금_승인결과
global	long	g_lOneCardPageFlag;     	// 일회성요금 카드flag, = 0 카드페이지 존재, = 1 카드페이지 없음

/* 계량기교체 */
global	char	g_szBartmp[128];     	    // 계량기교체 바코드 저장

/* 모바일 사용계약서 */
global  long    g_lCmContDocMoveFlag;		// 모바일 사용계약서 공통화면 유입 경로 flag, = 0 민원, = 1 안전점검, = 2 검침
global  char    g_szInstPlaceNum[20];		// 모바일 사용계약서 설치장소번호
global  char    g_szAccnameSignYn[2];		// 모바일 사용계약서 예금주 서명 YN( 사전등록인 경우 서명 받지 않는다 )

/* 이동고객센터 */
global  char    g_szMC_InstPlaceNum[20];	// 이동고객센터 설치장소번호 사용
global  long    g_lMC_MoveCard_Flag;		// 이동고객센터에서 다른 card로 넘어갈때 사용하는 Flag, 0 = 안전점검, 1 = 검침, 2 = 공급전 단독, 3 = 공급전 공동

/* 모바일 사용계약서 */
global  long    g_lMobile_Use_Doc_Type;			// 모바일 사용계약서 타입 : 1 = 전입신규, 2 = 명의유지, 3 = 명의병경, 4 = 신규
global  long    g_lMobile_Inflow_Path;      	// 모바일 사용계약서 유입구분 : 0 = 전입 신규, 1 = 민원 정보_신규, 2 = 안전점검, 3 = 검침, 4 = 계량기교체, 5 = 민원 정보_유지
global  char 	g_szMobile_Use_cont_num[10];	// 모바일 사용계약번호 : 전입신규인 경우에 필요함

/* 특정점검 */
global  long    g_lGovFlag;	// 정압기 점검을 했는지 안했는지 Flag, 0 = 안함, 1 = 함
global  long    g_lGovInflowPath;	// 정압기 분해점검 인입 Path, 0 = CONFIRM, 1 = CHK_BSDTL
global  long	g_lGovBetterFlag;   // 개선일자 구분 0 = 부적합상세 버튼 , 1 = 라디오박스 

/*************************************************************************************************************************************************
 * g_nWorkChkFlag 구분 값
	
	1. 안전점검
	g_nWorkChkFlag = 10 설치장소 , g_nWorkChkFlag = 11 계량기, g_nWorkChkFlag = 12 보일러, g_nWorkChkFlag = 13 호스, g_nWorkChkFlag = 14 연소기
	
	2. 안전점검 - 조정기 단독
	g_nWorkChkFlag = 20
	
	3. 안전점검 - 조정기 공동
	g_nWorkChkFlag = 30
	
	4. 특정점검
	g_nWorkChkFlag = 40 특정시설
	
	5. 공급전
	g_nWorkChkFlag = 50 연소기
	
**************************************************************************************************************************************************/

//로그인 정보
typedef struct LOGININFO
{
	char szloginday         [8  +1];
	char szemployee_id      [9  +1];
	char szpassword         [20 +1];
	char sznm_kor           [30 +1];
	char szpda_ip           [15 +1];
	char szcenter_cd        [2  +1];
	char szcenter_nm        [30 +1];
	char szbranch_cd        [6  +1];
	char szbranch_nm        [30 +1];
	char szbiz_regi_num     [30 +1];
	char szrepre_nm         [30 +1];
	char sztel              [15 +1];
	char szcellphone        [15 +1];
	char szcert_cd          [15 +1];
	char szcom_name         [30 +1];
	char szduty_appro_sts_cd[2  +1];
	char szonce_account_num [30 +1];
	char szonce_bnk_nm      [30 +1];
	char szonce_depositor_nm[30 +1];
	char szcard_term_id1    [30 +1];
	char szcard_term_id2    [30 +1];
	char szmenu_flag        [2  +1];
	char szver_num          [12 +1];
	char szaddr_sum         [300+1];
	char szlogintime        [6  +1];
	char szworkcd           [  5+1];
	char szappversion		[10 +1];
	char szguidsion			[10 +1];
	char szSos_TelNum       [30 +1];
	char szSos_SmsNum1      [30 +1];
	char szSos_SmsNum2      [30 +1];
	char szSos_SmsNum3      [30 +1];
	char szScg_repre_nm     [50 +1];
	char szNp_auth          [2  +1];
	char szLock_yn          [2  +1];
	char szNew_common_ver_num [12  +1];
	char szOld_common_ver_num [12  +1];
	char szOneCard_yn       [1  +1];
	char szRecommender_id       [9  +1];
}	LOGININFO;

global LOGININFO stUserinfo;


//사업자등록증
typedef struct BIZ
{
	char szUse_Cont_Num    [20 +1];
	char szInstPlaceNum    [20 +1];
	char szCust_Nm         [50 +1];
	char szTel_Ddd         [5  +1];
	char szTel_Exn         [5  +1];
	char szTel_Num         [5  +1];
	char szCp_Ddd          [5  +1];
	char szCp_Exn          [5  +1];
	char szCp_Num          [5  +1];
	char szEmail           [100+1];
	char Biz_Regi_Num      [20 +1];
	char szFirm_Nm         [50 +1];
	char szPhoto           [256+1];
	char szRmk             [300+1];
	char szBranch_Cd       [10 +1];
	char szCenter_Cd       [10 +1];
	char szData_Col_Type   [10 +1];

}	BIZ;

global BIZ stBiz;


//-----------------------------------------------------------------------------------------------
global	void	g_LoadGlobal(void);

enum
{
	MDM_BASE_URL,
	PUSH_BASE_URL,
	WAS_BASE_URL,
	OZ_BASE_URL
} BASE_URL_TYPE;

#define GET_URL(a)	g_GetBaseUrl(a)
global	char* 	g_GetBaseUrl(long url_alias);
global	long	g_Push_GetValue(char* pszKey);
global	long	g_Push_SetValue(char* pszKey, char* pszVal);
global	long	g_FormatPhoneNumber(char *in, char *out);
global	void	g_InitPush(void);
global	void	g_SetPushLogin(void);
global	void	g_SetPushLogout(void);
global	void	g_StartPush(void);
global	void	g_StopPush(void);

//-----------------------------------------------------------------------------------------------
//				날짜 및 시간 관련
//-----------------------------------------------------------------------------------------------
global	long	g_ChkDay(void);
global	quad 	g_GET_IP ( char *Data );//IP로 변환하는 함수
global	void 	g_Str_TimeType	(char *temp,  long time );   //시간을 int에서 char형으로 변경
global 	void 	g_Str_DateType	(char* Dp,   char* YYMMDD);  //날짜를 디스플레이 형식으로 변경(YYYY.MM.DD -<YYYYMMDD)

global 	void 	g_Str_TimeForm	(char* Dp,   char* HHMMDD);   //시간을 디스플레이 형식으로 변경(HH:MM:DD -<HHMMDD)

//-----------------------------------------------------------------------------------------------
//				화면이동관련
//-----------------------------------------------------------------------------------------------
global	char	g_CurrentCard[33];					//현재 화면 Card
global	char	g_PrevCard[33];						//전에 열었던 화면 Card
global 	void 	Card_Move		(char* Cardnm);		//
global 	void 	Card_Prev		(void);   			//이전 Card

global	char	g_szAppName[32];
//-----------------------------------------------------------------------------------------------
//				상단메뉴버튼(화면,키보드)
//-----------------------------------------------------------------------------------------------
global	void g_MOVE_DLG(long npos);
global	void g_SHOW_SIP(void);
global  void g_EditCtrl_ShowEditInput(handle h, char* sztmp);

global	long	g_Dlgflag;
global	long	g_Sipflag;

global	long	g_nTimerID;  		//종료 타이머.
global	long	g_nDrawTimerID;  	//화면 Draw 타이머.
global	long	g_nPrinterTimerID;  //종료 타이머.

//-----------------------------------------------------------------------------------------------
//				디비관련
//-----------------------------------------------------------------------------------------------
global long g_Sql_Bind(char* szSql, long szBindLen, char* szBind, long Retlen, char* szRet);
global long g_Sql_RetStr(char* szSql, long Retlen, char* szRet );
global long g_Sql_RetInt(char* szSql, long* nvalue);
global long g_Sql_RetStr2(SQLITE sql, char* szSql, long Retlen, char* szRet ); // 오픈되어 있는 DB 활용
global long g_Sql_RetInt2(SQLITE sql, char* szSql, long* nvalue); // 오픈되어 있는 DB 활용
global long g_Sql_DirectExecute(char* szSql);
global long g_Sql_DirectExecute2(SQLITE sql, char* szSql);
global long g_Sql_SetCombo(char* szSql, long CTRLID );
global long g_Sql_SaveSeq(char* szSql, char* FSNM);
global long g_SREACHFILE_GetSeq(char *SREACHFILE, long nPos);
global long g_Get_FsIndex(long lRowid, char* FSNM);
global long g_FS_GetSrchTotCnt(char* FSNM);


//프로그램 종료 시 해당 DB를 다른 폴더에 백업 & 복원
global void g_Db_Backup(void);		//백업
global void g_Db_Restore(void);		//복원

//-----------------------------------------------------------------------------------------------
//				업무관련
//-----------------------------------------------------------------------------------------------
//안전점검,특정점검 사용도중에 업무에서 나갈때..업무용데이터를 클리어한다.
global void g_Del_ScData(void); 
global void g_Del_BsData(void); 
global void g_Del_GcPhoto(void);
global void g_Exit_DelScData (void);
global void g_Exit_DelBsData (void);
global void g_Exit_DelGcData (void);
global void g_FlagClear(void);				//업무 FLAG 모두 0으로 초기화하는 함수
global long g_GetUtf8Size(char* str);		//메모 길이 체크
global char* g_SetOzComboData(SQLITE sql, char* szWhere, char* szComboData, long convFlag); // 사용계약서 콤보에 제공할 데이터 스트링 생성

global bool g_CheckPhoneNumber(char* type, char* szDDD, char* szEXN, char* szNUM);
global bool g_CheckPhoneNumberFormat(char* szEXN, char* szNUM);

//민원 전출
global long g_Save_Assign_690(void);
global long g_Load_Assign_690(char* assign_seq);
global long g_Add_Bo_690(handle pj);
global long g_Add_Bur_690(handle pj);
global long g_Add_Once_690(handle pj);
global void g_Snd_RstMin_690(long flag);
global long g_Rcv_RstMIn_690(void);

//시간 체크
global bool g_Chk_Time( char* param_start_time, char* param_end_time );

//ComboBox Value Active
global long g_SearchStr( char *Str, CodeTable *CT);
global long g_SearchCD( char *CD, CodeTable *CT);

//SOS긴급호출
global void g_Send_SOS( long type );
global long g_Rcv_SOS(void);

//전화번호 형식
global void g_Fsgetitem( char* szSource, char* szTarget, int id, int len );

//파일
global long g_DirFS_Count( char* pszDir, char* pszFilter );

//검침 실시간 값 반영
global long g_GM_Mtr_Add_Item(handle pj);
global long g_GM_Use_Cont_Num_Add_Item(handle pj);
global void g_GM_Rcv25012(void);
global long g_GM_TR25012(void);
global bool g_GM_Etc_Update( char * mtrnum, char* code, char* vc, char* va, char* vm );
global bool g_GM_Remote_Update( char * mtrnum, char* indiVc, char* gmtrYmd);
global long g_GM_Cal_UseQty( char *szIndi_VC, char* szCode, char* szMtrnum );
global bool g_GM_Befo_Sms_Update( char * usecontnum );
global long g_GM_SetFR25012(void);
//-----------------------------------------------------------------------------------------------
//				통신관련
//-----------------------------------------------------------------------------------------------
#define TIME_SLEEP	(5000 / 10)			// 5초

typedef long (*ResponseCallBack) (void);

//global long (*callBackfunc) ( void );	// 통신종료후 호출되는 함수포인터
global ResponseCallBack callBackfunc;	// 통신종료후 호출되는 함수포인터
global handle g_pjcomm;
global long	g_SeverConnection(void);
global void	g_Sock_Close( void );
global char* g_Chk_Code(char* pBuf, char* code, char* msg);
global long g_Chk_Json(long nservicenum);
global void* g_CreateJsonHead(void* pJson, char* szUrl ,long nservice, bool bClassName);
global void* g_CreateJsonHead_Login(void* pJson, char* szUrl, char* szid, long nservice, bool bClassName);
global long g_Save_JsonFile(char* pStrJson);
global long g_StartSession(char* szSessionKey);
global long g_EndSession(char* szSessionKey,char* szworkid);
//-----------------------------------------------------------------------------------------------
//				암호화관련
//-----------------------------------------------------------------------------------------------
//2008.12.02 parkhw 암호화/복호화 함수추가
#define ENCRYPT		1
#define DECRYPT		0

global long g_EncryptDecrypt(long flag, char *szData, long nFieldLen);
global void	EncodeBlock( quad i32Key, quad i32Input, quad* i32Output );
global void	DecodeBlock( quad i32Key, quad i32Input, quad* i32Output );
global BOOL	Encode (char* pszPlainText, quad unPlainTextLen, char* pszEncodedText, quad unEncodedTextLen );
global BOOL	Decode(char* pszEncodedText, quad unEncodedTextLen, char* pszPlainText, quad unPlainTextLen );
global BOOL	EncodeCore(	quad i32Key, char* pszPlainText, quad unPlainTextLen, char* pszEncodedText, quad unEncodedTextLen );
global BOOL	DecodeCore( quad i32Key, char* pszEncodedText, quad unEncodedTextLen, char* pszPlainText, quad unPlainTextLen );

//-----------------------------------------------------------------------------------------------
//		통신파일삭제
//-----------------------------------------------------------------------------------------------
global long g_DirFS_Clear (char* pszDir, char* pszFilter);

//-----------------------------------------------------------------------------------------------
//		블루투스 프린터관련
//-----------------------------------------------------------------------------------------------

#define PRINTER_OK			 0
#define PRINTER_TIMEOUT		-1
#define PRINTER_NODATA		-2

typedef long (*PrinterCallBack) (void*);

global PrinterCallBack printerCallBack;
global PrinterCallBack g_printerCallBack;
global void* g_pList;
global void g_SetPrinterCallBack(PrinterCallBack pf);
global char* g_Printer_GetLastError(long code);
global long g_Printer_Start		(void* p, void* result);
global long g_Printer_Process	(void* p);
global void g_Line_Print		(void* p, char* sztmp1, char* sztmp2, char* sztmp3, long Style, long pos);
global void Line_Print			(char* sztmp1, char* sztmp2, char* sztmp3, long Style, long pos);
global bool g_IsCardReader		(void);

//-----------------------------------------------------------------------------------------------
//		이벤트 콜백관련
//-----------------------------------------------------------------------------------------------

global void g_OnUart (long nType, long nData);
global void g_OnTask (long nType, long nData);
global void g_OnTimer(long nTimerId);
global void g_EvtSessionCallback (long wParam);
global void g_EndSessionCallback (long wParam);

//-----------------------------------------------------------------------------------------------
//		이미지 관련
//-----------------------------------------------------------------------------------------------
global void * g_pImgMainBg;
global void * g_pImgMainExit;	
global void * g_pImgLogo;	
		
global void * g_pImgMainTtl_GM;
global void * g_pImgMainTtl;
global void * g_pImgBlankTtl;
global void * g_pImgSubTtl;
global void * g_pImgSubTtlPrev;
global void * g_pImgSubTtlClose;
//global void * g_pImgPopTtl;
global void * g_pImgPopTtlL;
global void * g_pImgPopTtlPrev;

global void * g_pImgHomeI;
global void * g_pImgKeybrdI;
global void * g_pImgScreenI;
global void * g_pImgCmmnwrkI;
global void * g_pImgExitI;

global void * g_pImgHomeA;
global void * g_pImgKeybrdA;
global void * g_pImgScreenA;
global void * g_pImgCmmnwrkA;
global void * g_pImgExitA;

global void * g_pImgGm;
global void * g_pImgSc;
global void * g_pImgBs;
global void * g_pImgBf;
global void * g_pImgMw;
global void * g_pImgGc;
global void * g_pImgNp;
global void * g_pImgCmm;
global void * g_pImgNotice;
global void * g_pImgFeeview;

global void * g_pImgMnTop;
global void * g_pImgMnMid;
global void * g_pImgMnMidpl;
global void * g_pImgMnBot;

global void * g_pImgGmBtn;
global void * g_pImgNoGmBtn;
global void * g_pImgAbsncBtn;
global void * g_pImgGmSlctBtn;
global void * g_pImgGmgoBtn;
global void * g_pImgGmDataBtn;

global void * g_pImgScBtn;
global void * g_pImgPtrnBtn;
global void * g_pImgRsrvBtn;
global void * g_pImgScDataBtn;
global void * g_pImgFrstScBtn;
global void * g_pImgRsltBtn;
global void * g_pImgRfrmBtn;
global void * g_pImgScgoBtn;
global void * g_pImgJojungBtn;
global void * g_pImgScSlctBtn;

global void * g_pImgChkI;
global void * g_pImgRadioI;
global void * g_pImgChkA;
global void * g_pImgRadioA;

//*********************************************************************
//2차 시안 버튼 모음
//*********************************************************************

//공통메뉴 버튼

//검침 버튼
global void * g_pImgGm_Normal; // 정상검침
global void * g_pImgGm_Nogm; // 순수미검침
global void * g_pImgGm_Absnc; // 부재검침
global void * g_pImgGm_Sel; // 지정검침
global void * g_pImgGm_Go; // 검침바로가기
global void * g_pImgGm_Data; // 자료관리
global void * g_pImgGm_Sms; // 문자검침
global void * g_pImgGm_Feeview; // 요금조회
global void * g_pImgGm_Regm; // 재검
global void * g_pImgGm_DataRcv; // 자료수신(자료관리 화면)
global void * g_pImgGm_DataSnd; // 자료송신(자료관리 화면)
global void * g_pImgGm_DataDel; // 자료삭제(자료관리 화면)

//안전점검 버튼
global void * g_pImgSc_Data;
global void * g_pImgSc_First;
global void * g_pImgSc_Go;
global void * g_pImgSc_Jojung;
global void * g_pImgSc_Normal;
global void * g_pImgSc_Ptrn;
global void * g_pImgSc_Reserve;
global void * g_pImgSc_Result;
global void * g_pImgSc_Rfrm;
global void * g_pImgSc_Sel;
global void * g_pImgSc_DataRcv;
global void * g_pImgSc_DataSnd;
global void * g_pImgSc_DayDataRcv;
global void * g_pImgSc_JojungDataRcv;
global void * g_pImgSc_JojungDataSnd;
global void * g_pImgSc_SnnDataRcv;
global void * g_pImgSc_SnnTotDataRcv;
global void * g_pImgSc_ScgsDataRcv;
global void * g_pImgSc_ScgsTotDataRcv;

//특정점검 버튼
global void * g_pImgBs_Normal; // 정기특정점검
global void * g_pImgBs_Rfrm; // 개선권고관리
global void * g_pImgBs_Data; // 자료 관리
global void * g_pImgBs_TotDataRcv; // 자료관리>전체자료수신
global void * g_pImgBs_DayDataRcv; // 자료관리>일일자료수신
global void * g_pImgBs_DataSnd; // 자료관리>자료송신
global void * g_pImgBs_SafeDataRcv; // 자료관리>개선자료수신
global void * g_pImgBs_First; // 우선특정점검

//공급전점검 버튼
global void * g_pImgBf_Tgt;
global void * g_pImgBf_Solo;
global void * g_pImgBf_Rfrm;
global void * g_pImgBf_Data;
global void * g_pImgBf_DataSnd;
global void * g_pImgBf_DataRcv;
global void * g_pImgBf_TgtDataRcv;

//민원 버튼
global void * g_pImgMw_Work; // 작업리스트(민원메뉴화면)
global void * g_pImgMw_Receipt; // 수납자료현황(민원메뉴화면)
global void * g_pImgMw_Data; // 일일자료수신(민원메뉴화면)
global void * g_pImgMw_Snd; // 미처리송신(민원메뉴화면)
global void * g_pImgMw_Card; // 카드승인목록(민원메뉴화면)
global void * g_pImgMw_Print; // 인쇄테스트(민원메뉴화면)
global void * g_pImgMw_DayDataRcv; // 일일자료수신
global void * g_pImgMw_Silsa; // 
global void * g_pImgMw_Report;
global void * g_pImgMw_CmmDataRcv;

//계량기교체 버튼
global void * g_pImgGc_Old;
global void * g_pImgGc_Mw;
global void * g_pImgGc_Remark;
global void * g_pImgGc_Imp;
global void * g_pImgGc_Sel;
global void * g_pImgGc_Ret;
global void * g_pImgGc_Data;
global void * g_pImgGc_BigDataRcv;
global void * g_pImgGc_DataRcv;

//체납 버튼
global void * g_pImgNp_Auction;
global void * g_pImgNp_Clear;
global void * g_pImgNp_Data;
global void * g_pImgNp_Normal;
global void * g_pImgNp_Part;
global void * g_pImgNp_Receipt;
global void * g_pImgNp_Stop;

//공통
global void * g_pImgCm_Reflesh;

//*********************************************************************

global void * g_pImgChkOff;
global void * g_pImgChkOn;
global void * g_pImgCash;
global void * g_pImgCashDark;
global void * g_pImgAmount;

global void * g_pImgLoad1;

global  long g_Upgrade_flag;
global	void g_ImgNameChg	(void);
global	void g_GetImgLoad	(void);
global	long g_Exit			(void);
global	void g_ImgFree		(void);

global char* Get_ImgPath(char* trgpath, char* imggb, char* fsnm);
global char* Get_BasePath(char* trgpath);
global void Update_DB(char* szDate);

#endif	//	COMMON_H


