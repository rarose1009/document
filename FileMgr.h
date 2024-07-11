/*----------------------------------------------------------------------------------
	Project Name: Smart HYGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2004.07.13	dkjung		v1.00		: Create
	
	2004.10.06	dkjung		v3.00		: Release ( 표준모듈명 : FileMgr )
										: 이 버전 이후, 모듈 수정시 메일로 수정 내용
										: 알려 주기 바람 ( dkjung@mcnc.co.kr )
    2005.05.17  LSH         v3.1        : FREAD을 변경 파일명에서 핸들로 수정 
                                          도시가스 전용

	2014.10.01	dkjung		v 3.0.1		: Create 스마트폰 포팅
	----------	------		------------------------------------------------------
----------------------------------------------------------------------------------*/

#ifndef		_FILEMGR_H_
#define		_FILEMGR_H_

	
	//업무용 데이터 폴더 생성 및 경로만들기
	#define DIR_DBF		"APP_DBF"    	//업무용 DB 폴더
	#define DIR_BACKDBF "APP_BACKDB" 	//프로그램 종료 시 백업DB 저장 폴더
	#define UP_BACKDBF  "DBF_BAK"    	//VM 업그레이드시 DB백업 폴더
	#define PHOTO_GM    "PHOTO_GM"   	//검침 사진폴더
	#define PHOTO_SC	"PHOTO_SC"   	//안전점검사진폴더
	#define PHOTO_SCMTR "PHOTO_SC_MTR"	//안전점검 계량기 사진 폴더
	#define PHOTO_SCBUR "PHOTO_SC_BUR"	//안전점검 연소기 사진 폴더
	#define PHOTO_SCBOIL "PHOTO_SC_BOIL" //안전점검 보일러 사진 폴더
	#define PHOTO_SCBAR "PHOTO_SC_BAR"  //안전점검 바코드 사진 폴더
	#define PHOTO_SCREFUSE "PHOTO_SC_REFUSE" //안전점검 거부 사진 폴더
	#define PHOTO_SCABSENCE "PHOTO_SC_ABSENCE" //안전점검 부재 사진 폴더
	#define PHOTO_JO	"PHOTO_JO"   	//조정기사진폴더
	#define PHOTO_BS	"PHOTO_BS"   	//특정점검 사진폴더
	#define PHOTO_BSBAR	"PHOTO_BS_BAR" 	//특정점검 바코드 사진폴더
	#define PHOTO_BF	"PHOTO_BF"   	//공급전안전점검 사진폴더
	#define PHOTO_MW	"PHOTO_MW"   	//민원사진폴더
	#define PHOTO_GC	"PHOTO_GC"   	//계량기교체사진폴더
	#define PHOTO_NP	"PHOTO_NP"   	//체납사진폴더
	#define PHOTO_BIZ   "PHOTO_BIZ"  	//사업자등록증사진폴더
	#define PHOTO_WORK  "PHOTO_WORK" 	//업무보고 사진 폴더
	#define OZ_FILE		"OZ_FILE"	 	//Smart OZ파일(PDF) 저장 폴더
	#define LC_OZ_FILE	"../LCTECH"	 	//기본 OZ파일(PDF) 저장 폴더(LCTECH)
	#define PHOTO_GMMTR "PHOTO_GM_MTR" 	//검침계량기 사진폴더
	#define PHOTO_GMCOMPENS "PHOTO_GM_COMPENS" //검침보정기 사진폴더
	
	#define DIR_IMG		"APP_IMG"
	
	#define CONVERT_WD 384
	#define CONVERT_HT 512
	//#define CONVERT_WD 288
	//#define CONVERT_HT 384	
	
	#define GET_FILENM(buf, dbName)\
	{\
		SPRINT (buf, "%s/%s",  DIR_DBF, dbName, 0);\
	}
	
	#define GET_COMMN(buf, dbName)\
	{\
		SPRINT (buf, "%s/%s/%s",  "system", "comm", dbName);\
	}
	
			
	// dkjung 2003-06-25 추가
	#define	F_WRITE		0			// File write only mode
	#define	F_CREATE	1			// File create and write mode
	#define FREAD(fd, pos, buf, len)	g_File_Read( fd, pos, (byte*)buf, len)	
	#define FWRITE(fd, pos, buf, len)	g_File_Write(fd, pos, (byte*)buf, len)

	global 	bool g_File_Read  ( long fd, long startPos, byte *Buf, long length );
	global 	bool g_File_Write ( long fd, long startPos, byte *Buf, long length);
	global 	void g_Str_trimcpy(char* dest,char* source,long size);
	global 	long g_ClearFiles (char* pszDir, char* pszFilter );
	global 	long g_FindFiles (char* pszDir, char* pszFilter, char* pzfinefile );
	
	
#endif	//	_FILEMGR_H_
