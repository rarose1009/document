/*----------------------------------------------------------------------------------
	Project Name: Smart HYGAS
	Compiler & Virtual Machine : SMART 1.0.0
	Copyright(c) 2014 Value CMD Co., Ltd
	----------	------		------------------------------------------------------
	2004.07.13	dkjung		v1.00		: Create
	
	2004.10.06	dkjung		v3.00		: Release ( ǥ�ظ��� : FileMgr )
										: �� ���� ����, ��� ������ ���Ϸ� ���� ����
										: �˷� �ֱ� �ٶ� ( dkjung@mcnc.co.kr )
    2005.05.17  LSH         v3.1        : FREAD�� ���� ���ϸ��� �ڵ�� ���� 
                                          ���ð��� ����

	2014.10.01	dkjung		v 3.0.1		: Create ����Ʈ�� ����
	----------	------		------------------------------------------------------
----------------------------------------------------------------------------------*/

#ifndef		_FILEMGR_H_
#define		_FILEMGR_H_

	
	//������ ������ ���� ���� �� ��θ����
	#define DIR_DBF		"APP_DBF"    	//������ DB ����
	#define DIR_BACKDBF "APP_BACKDB" 	//���α׷� ���� �� ���DB ���� ����
	#define UP_BACKDBF  "DBF_BAK"    	//VM ���׷��̵�� DB��� ����
	#define PHOTO_GM    "PHOTO_GM"   	//��ħ ��������
	#define PHOTO_SC	"PHOTO_SC"   	//�������˻�������
	#define PHOTO_SCMTR "PHOTO_SC_MTR"	//�������� �跮�� ���� ����
	#define PHOTO_SCBUR "PHOTO_SC_BUR"	//�������� ���ұ� ���� ����
	#define PHOTO_SCBOIL "PHOTO_SC_BOIL" //�������� ���Ϸ� ���� ����
	#define PHOTO_SCBAR "PHOTO_SC_BAR"  //�������� ���ڵ� ���� ����
	#define PHOTO_SCREFUSE "PHOTO_SC_REFUSE" //�������� �ź� ���� ����
	#define PHOTO_SCABSENCE "PHOTO_SC_ABSENCE" //�������� ���� ���� ����
	#define PHOTO_JO	"PHOTO_JO"   	//�������������
	#define PHOTO_BS	"PHOTO_BS"   	//Ư������ ��������
	#define PHOTO_BSBAR	"PHOTO_BS_BAR" 	//Ư������ ���ڵ� ��������
	#define PHOTO_BF	"PHOTO_BF"   	//�������������� ��������
	#define PHOTO_MW	"PHOTO_MW"   	//�ο���������
	#define PHOTO_GC	"PHOTO_GC"   	//�跮�ⱳü��������
	#define PHOTO_NP	"PHOTO_NP"   	//ü����������
	#define PHOTO_BIZ   "PHOTO_BIZ"  	//����ڵ������������
	#define PHOTO_WORK  "PHOTO_WORK" 	//�������� ���� ����
	#define OZ_FILE		"OZ_FILE"	 	//Smart OZ����(PDF) ���� ����
	#define LC_OZ_FILE	"../LCTECH"	 	//�⺻ OZ����(PDF) ���� ����(LCTECH)
	#define PHOTO_GMMTR "PHOTO_GM_MTR" 	//��ħ�跮�� ��������
	#define PHOTO_GMCOMPENS "PHOTO_GM_COMPENS" //��ħ������ ��������
	
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
	
			
	// dkjung 2003-06-25 �߰�
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
