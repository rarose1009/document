/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		__CHKCODE_H__
#define		__CHKCODE_H__

//-----------------------------------------------------------------------------------------------
//				
//-----------------------------------------------------------------------------------------------

	typedef struct _CodeTable
	{		char 	Code[50];
			char	Str[50];
			char	title[30];
	} CodeTable;
	

//-----------------------------------------------------------------------------------------------
//				공통 코드
//-----------------------------------------------------------------------------------------------
	
	// 시간
	CodeTable TIME_HOUR[] = { 
		{"1", "00",   0 },
		{"2", "01",   0 },
		{"3", "02",   0 },
		{"4", "03",	  0 },
		{"5", "04",   0 },
		{"6", "05",   0 },
		{"7", "06",   0 },
		{"8", "07",   0 },
		{"9", "08",   0 },
		{"10","09",   0 },
		{"11","10",   0 },
		{"12","11",   0 },
		{"13","12",   0 },
		{"14","13",   0 },
		{"15","14",   0 },
		{"16","15",   0 },
		{"17","16",   0 },
		{"18","17",	  0 },
		{"19","18",   0 },
		{"20","19",   0 },
		{"21","20",   0 },
		{"22","21",   0 },
		{"23","22",   0 },
		{"24","23",   0 },
		0
	};
	
	// 고객센터
	CodeTable CODE_CENTER[] = { 
		{ "11", "서부1", 0 },
		{ "12", "서부2", 0 },
		{ "13", "서부3", 0 },
		{ "14", "서부4", 0 },
		{ "15", "서부5", 0 },
		{ "16", "서부6", 0 },
		{ "21", "남부1", 0 },
		{ "22", "남부2", 0 },
		{ "23", "남부3", 0 },
		{ "24", "남부4", 0 },
		{ "25", "남부5", 0 },
		{ "31", "강북1", 0 },
		{ "32", "강북2", 0 },
		{ "33", "강북3", 0 },
		{ "34", "강북4", 0 },
		{ "35", "강북5", 0 },
		{ "41", "경기1", 0 },
		{ "42", "경기2", 0 },
		{ "43", "경기3", 0 },
		{ "44", "경기4", 0 },
		{ "45", "경기5", 0 },
		{ "46", "경기6", 0 },
		{ "91", "본사" , 0 },
		{ "92", "서부지사", 0 },
		{ "93", "남부지사", 0 },
		{ "94", "강북지사", 0 },
		{ "95", "경기지사", 0 },
		{ "98", "에스씨지솔루션즈", 0 },
		{ "99", "협력사", 0 },
		0
	};

//-----------------------------------------------------------------------------------------------
//				검침 코드
//-----------------------------------------------------------------------------------------------

	CodeTable GM_CODE[] = { 
		{"1","1:정상",   0 },
		{"G","G:대문",   0 },
		{"T","T:전화",   0 },
		{"N","N:지시부", 0 },
		{"2","2:부재",   0 },
		{"3","3:교체",   0 },
		{"A","A:미입주", 0 },
		{"B","B:미사용", 0 },
		{"C","C:없음",   0 },
		{"D","D:미기타", 0 },
		{"5","5:순회",   0 },
		{"6","6:고장",   0 },
		{"7","7:해가",   0 },
		{"L","L:문자발송",   0 },
		0
	};
	
	CodeTable GM_CODE_ORI[] = { 
		{"1","1:정상",     0 },
		{"2","2:부재",     0 },
		{"3","3:교체",     0 },
		{"5","5:순회",     0 },
		{"6","6:고장",     0 },
		{"7","7:해가",     0 },
		{"A","A:미입주",   0 },
		{"B","B:미사용",   0 },
		{"C","C:없음",     0 },
		{"D","D:미기타",   0 },
		{"G","G:대문",     0 },
		{"H","H:홈페이지", 0 },
		{"M","M:모바일",   0 },
		{"N","N:지시부",   0 },
		{"P","P:일괄지침", 0 },
		{"T","T:전화",     0 },
		{"V","V:사전문자", 0 },
		{"W","W:사후문자", 0 },
		{"X","X:2차조정",  0 },
		{"L","L:문자발송", 0 },
		0
	};
	
	CodeTable RE_GM_CODE[] = { 
		{"1","1:정상",   0 },
		{"G","G:대문",   0 },
		{"T","T:전화",   0 },
		{"N","N:지시부", 0 },
		{"2","2:부재",   0 },
		{"3","3:교체",   0 },
		{"A","A:미입주", 0 },
		{"B","B:미사용", 0 },
		{"C","C:없음",   0 },
		{"D","D:미기타", 0 },
		{"5","5:순회",   0 },
		{"6","6:고장",   0 },
		{"7","7:해가",   0 },
		0
	};
	
	//고객상태
	CodeTable GMCUST_STS[] = { 
		{"10","정상", 0 },
		{"20","해지", 0 },
		{"30","중지", 0 },
		0
	};

	//문자검침 번호변경 사유
	CodeTable GM_TELCHG_WHY[] = { 
		{"110","고객요청", 0 },
		{"120","전출", 0 },
		{"130","핸드폰번호상이", 0 },
		{"140","기타", 0 },
		0
	};
	
	//문자검침 상태 목록(콤보박스용)
	CodeTable GM_SEND_STS[] = { 
		{"0" ,"전체",     0 },
		{"10","대상선정", 0 },
		{"20","발송중",   0 },
		{"30","예약",     0 },
		{"40","발송완료", 0 },
		{"50","발송실패", 0 },
		{"60","회신완료", 0 },
		{"70","회신오류", 0 },
		{"80","검침적용", 0 },
		{"90","취소",     0 },
		{"99","오류",     0 },
		0
	};

	//문자검침 발송 타입
	CodeTable GM_SEND_TYPE[] = { 
		{"1","즉시발송", 0 },
		{"2","예약발송", 0 },
		0

	};
	
//-----------------------------------------------------------------------------------------------
//				안전점검 코드
//-----------------------------------------------------------------------------------------------

	//점검 결과, CHK_RSLT
	CodeTable SCCHK_RSLT[] = { 
		{"10","미점검", 0 },
		{"20","적합", 0 },
		{"21","부적합", 0 },
		{"40","제외", 0 },
		{"50","미실시", 0 },
		0
	};

	//(입상관,내관,외관)배관점검, 점검항목코드 : 40
	CodeTable SC_PIPECHK[] = { 
		{"10","입상관배관부식", 0 },
		{"20","차단장치작동",   0 },
		{"30","배관고정불량",   0 },
		0
	};
	
	//SMS신청
	CodeTable SCSMSTEL[] = { 
		{"010","010", 0 },
		{"011","011", 0 },
		{"016","016", 0 },
		{"017","017", 0 },
		{"018","018", 0 },
		{"019","019", 0 },
		0
	};
		
	//배관도색
	CodeTable SCCOLOR[] = { 
		{"Y","정상", 0 },
		{"N","불량", 0 },
		0
	};

	//co감지기&누출차단
	CodeTable SCLK_CO[] = { 
		{"Y","설치", 0 },
		{"N","미설치", 0 },
		{"U","제외", 0 },
		0
	};

	//자율점검
	CodeTable SCSELF[] = { 
		{"Y","실시", 0 },
		{"N","미실시", 0 },
		0
	};

	//홍보물
	CodeTable SCADV[] = { 
		{"Y","배포", 0 },
		{"N","미배포", 0 },
		0
	};
	
	//CO경보기
	CodeTable SCCOALARM[] = { 
		{"Y","설치", 0 },
		{"N","미설치", 0 },
		0
	};
	
	//주방자동소화장치
	CodeTable SCKITAUTOSPRIN[] = { 
		{"Y","설치", 0 },
		{"N","미설치", 0 },
		0
	};
	
	//매립배관점검 점검항목코드:10
	CodeTable SCHKPIPE_BURY[] = { 
		{"10","가스누기", 0 },
		{"20","다기능가스계량기", 0 },
		{"30","배관위치표시(스티커)", 0 },
		0
	};
	
	//은폐배관점검 점검항목코드:20
	CodeTable SCHKPIPE_HIDE[] = { 
		{"10","가스누기", 0 },
		{"20","다기능가스계량기", 0 },
		{"30","보호관및점검구", 0 },
		{"40","누출자동차단장치및점검구", 0 },
		{"50","배관위치표시(스티커)", 0 },
		0
	};
	
	//2차 개발(2017-03-05) : 계량기 -> 연소기점검으로 변경
	//퓨즈콕, 점검항목코드 : 50 , 
	CodeTable SC_MTRFUSE[] = { 
		{"Y","설치",         0 },
		{"N","미설치"      , 0 },
		{"U","설치대상아님", 0 },
		0
	};
	
	//2차 개발(2017-03-05) : 계량기 -> 연소기점검으로 변경(가스누출)
	//가스누출, 플러그마감미비(연소기점검 추가)
	CodeTable SC_GASCHK[] = { 
		{"Y","적합",         0 },
		{"N","부적합"      , 0 },
		0
	};

	//계량기점검, 점검항목코드 : 50
	CodeTable SC_MTRCHK[] = { 
		{"10","내관배관부식",           0 },
		{"20","전기,화기 이격거리미비",  0 },
		{"30","실내배관매몰",           0 },
		{"40","설치장소불량",           0 },
		{"50","가스누출",               0 },
		{"60","계량기매몰(없음)",       0 },
		{"70","계량기용량초과",       0 },

		0
	};
	
	//2차 개발(2017-03-05) : 계량기 -> 연소기점검으로 변경
	//호스, 점검항목코드 : 60
	CodeTable SC_HOSECHK[] = { 
		{"10","호스 3M 초과",   0 },
		{"20","호스 \"T\" 사용",  0 },
		{"30","호스재질불량",   0 },
		{"40","휴즈콕 작동 불량",   0 },
		{"50","휴즈콕 미설치",   0 },
		{"60","가스누출",   0 },
		0
	};
	
	//연소기, 점검항목코드 : 51
	CodeTable SC_BURCHK[] = { 
		{"70","온수기 등 배기통 연결 기준",   0 },
		{"80","빌트인 설치불량",   0 },
		{"90","연소기 불량",   0 },
		{"91","무단시공(연소기)",  0},
		0
	};
		
	//보일러위치 점검, 점검항목코드 : 10
	CodeTable SC_BOILPLCCHK[] = { 
		{"10","보일러실내설치",       0 },
		{"20","목욕탕설치",           0 },
		{"30","전용보일러개구부설치", 0 },
		{"40","보일러베란다(93.11.28이후)", 0 },
		{"50","보일러베란다(17.8.24이후,실내)", 0 },
		{"60","전용보일러실설치", 0 },
		0
	};
	
	//급/환기구점검, 점검항목코드 : 20
	CodeTable SC_HWANCHK[] = { 
		{"10","급환기구막힘", 0 },
		{"20","급기구미비", 0 },
		{"30","환기구미비", 0 },
		{"40","급환기구미비", 0 },
		{"50","동력환기팬설치", 0 },
		{"60","공동배기구불량", 0 },
		0
	};
	
	//배기통/톱 점검, 점검항목코드 : 30
	CodeTable SC_BEGICHK[] = { 
		{"10","배기통노후", 0 },
		{"11","배기통고정불량", 0 },
		{"12","하향구배불량", 0 },
		{"13","연결부접속불량", 0 },
		{"14","연통재질불량", 0 },
		{"15","굴곡수초과", 0 },
		{"16","배기통외부로노출불량", 0 },
		{"17","배기통톱이격거리", 0 },
		{"18","방조망(16mm 이하) 미설치", 0 },
		{"19","배기통재질(알루미늄주름관)", 0 },
		{"20","배기통재질(스테인레스주름관)", 0 },
		{"21","급기통이탈", 0 },
		{"22","급기구최초흡입구 1CM 미만", 0 },
		{"23","배기통톱개구부로부터 60CM 미비", 0 },
		{"24","배기통관통부유입방지미비", 0 },
		{"25","배기통길이초과", 0 },
		{"26","배기통이탈", 0 },
		{"27","배기통재질(스테인 98.3 이후)", 0 },
		{"28","배기통재질(스테인 98.3 이전)", 0 },
		{"29","배기통이격거리/좌우30,상하150CM", 0 },
		{"30","배기통관통부 그을음여부", 0 },
		{"31","실내전용배기통 미사용", 0 },
		{"32","배기통인증품설치여부", 0 },
		0
	};
	
	//보일러/기타점검, 점검항목코드 : 90
	CodeTable SBBREVFLAG[] = {				
		{"10","보일러실내가연성방치", 0 },
		{"20","주변가연성물질방치", 0 },
		{"30","보일러상부 CASE 없음", 0 },
		{"40","보일러고정불량", 0 },
		{"50","보일러설치 (FF->FE) 불량", 0 },
		{"60","보일러설치 (FE->FF) 불량", 0 },
		{"70","보일러설치상태불량", 0 },
		{"80","보일러서류미접수(공급전안전점검)", 0 },
		{"90","CO경보기미설치", 0 },
		{"91","CO경보기설치불량", 0 },	
		{"92","가스누출", 0 },				
		{"93","안전점검 실시 불가(지장물 등)", 0 },				
		0
	};
	
	// 교체구분(CHG_FLAG)
	CodeTable SCCHG_FLAG[] = { 
		{"1","신규", 0 },
		{"2","수정", 0 },
		{"3","삭제", 0 },
		0
	};
	
	// 보일러 형식
	CodeTable SCBOIL_FORM[] = { 
		{"CF","자연배기식(CF)", 0 },
		{"CP","강제배기식(CF+FAN,CP)", 0 },
		{"FE","강제배기식(FE)", 0 },
		{"FF","강제급배기식(FF)", 0 },
		0
	};
	
	// 보일러 용량
	CodeTable SCBOIL_CAPA[] = { 
		{"10","Kcal/h", 0 },
		{"20","Ton", 0 },
		{"30","KW", 0 },
		{"40","Kg/h", 0 },
		{"50","RT", 0 },
		{"60","USRT", 0 },
		{"70","BTU", 0 },
		0
	};
	
	//연소기 용도
	CodeTable BURNERCLASS[] = { 
		{"10","취사용", 0 },
		{"20","급탕및기타 기기", 0 },
		{"30","난방용", 0 },
		{"40","냉방용", 0 },
		{"50","충전용", 0 },
		{"90","기타", 0 },
		0
	};

	// 설치구분
	CodeTable SCINST_FLAG[] = { 
		{"10","신규", 0 },
		{"20","교체", 0 },
		{"30","철거", 0 },
		0
	};

	//중지불가사유
	CodeTable SCNOSTOP_WHY[] = { 
		{"10","부재로인한중단불가", 0 },
		{"11","부재로인한개선확인불가", 0 },
		{"20","거부로인한중단불가", 0 },
		{"30","중단불가항목", 0 },
		0
	};

	//점검등록화면의 방문이력 , decode(NO_CHK_WHY,'10','부재','11','공가','12','미입주','13','폐업','14','거부')
	CodeTable VISIT_RSLT[] = { 
		{"10","부재", 0 },
		{"11","공가", 0 },
		{"12","미입주", 0 },
		{"13","폐업", 0 },
		{"14","거부", 0 },
		0
	};

	//미점검사유 & 방문이력 화면
	CodeTable SCNOCHK_WHY[] = { 
		{"10","(장기)부재", 0 },
		{"11","공가", 0 },
		{"12","미입주", 0 },
		{"13","폐업", 0 },
		0
	};

	//공급상태코드
	CodeTable SCCONTSTS[] = { 
		{"10","정상", 0 },
		{"20","중지", 0 },
		{"30","해지", 0 },
		0
	};

	//유형
	CodeTable SCTYPE_CD[] = { 
		{"10","일반(개인)", 0 },
		{"13","사업자(개인)", 0 },
		{"14","사업자(법인)", 0 },
		{"18","외국인", 0 },
		{"99","임시", 0 },
		0
	};

	//성향
	CodeTable SCTRND_CD[] = { 
		{"10","학생", 0 },
		{"20","주부", 0 },
		{"30","맞벌이", 0 },
		{"40","노약자", 0 },
		{"50","주의", 0 },
		{"60","주말방문", 0 },
		{"70","야간방문", 0 },
		{"80","불법사용", 0 },
		0
	};

	//전화국번(핸드폰,자택,회사,팩스)
	CodeTable SCTEL_DDD[] = { 
		{"1","010", 0 },
		{"2","011", 0 },
		{"3","016", 0 },
		{"4","017", 0 },
		{"5","018", 0 },
		{"6","019", 0 },
		{"7","02", 0 },
		{"8","031", 0 },
		{"9","070", 0 },
		0
	};

	//당사관계
	CodeTable SCRELAT[] = { 
		{"10","직원", 0 },
		{"20","계열사직원", 0 },
		{"30","고객센터직원", 0 },
		{"40","시공사직원", 0 },
		0
	};
	
	//면적
	CodeTable SCSQUARE[] = { 
		{"10","33.05㎡이하", 0 },
		{"20","33.05㎡초과 ~ 66.10㎡이하", 0 },
		{"30","66.10㎡초과 ~ 82.63㎡이하", 0 },
		{"40","82.63㎡초과 ~ 99.15㎡이하", 0 },
		{"50","99.15㎡초과 ~ 132.20㎡이하", 0 },
		{"60","132.20㎡초과", 0 },
		0
	};
	
	//상호명
	CodeTable FIRM_CD[] = { 
		{"교회","교회", 0 },
		{"천주교","천주교", 0 },
		{"불교","불교", 0 },
		{"어린이집","어린이집", 0 },
		{"유치원","유치원", 0 },
		{"학교","학교", 0 },
		{"학원","학원", 0 },
		{"병원","병원", 0 },
		{"경로당","경로당", 0 },
		{"목욕탕","목욕탕", 0 },
		{"식당","식당", 0 },
		{"사무실","사무실", 0 },
		0
	};
	
	//메일주소
	CodeTable SCEMAIL[] = { 
		{"1", "naver.com", 0 },
		{"2", "hanmail.net", 0 },
		{"3", "kakao.com", 0 },
		{"4", "lycos.co.kr", 0 },
		{"5", "yahoo.co.kr", 0 },
		{"6", "chol.com", 0 },
		{"7", "dreamwiz.com", 0 },
		{"8", "empal.com", 0 },
		{"9", "freechal.com", 0 },
		{"10", "hanafos.com", 0 },
		{"11","hanmir.com", 0 },
		{"12","hitel.net", 0 },
		{"13","hotmail.com", 0 },
		{"14","korea.com", 0 },
		{"15","nate.com", 0 },
		{"16","netian.com", 0 },
		{"17","paran.com", 0 },
		0
	};
	
	//빌트인여부
	CodeTable SCBUILT_IN[] = { 
		{"N","아니오", 0 },
		{"Y","예", 0 },
		0
	};
	
	//완성검사여부
	CodeTable SCCOMP_CHK[] = { 
		{"N","미대상", 0 },
		{"Y","대상", 0 },
		0
	};

	//필터교체유무(조정기)
	CodeTable SINGLECOLIVECD[] = { 
		{"10","단독", 0 },
		{"20","공동", 0 },
		0
	};
	
	//필터교체유무(조정기)
	CodeTable SCFLTCHG[] = { 
		{"20","미교체", 0 },
		{"30","교체", 0 },
		0
	};

	//특이사항(조정기)
	CodeTable SCRMK[] = { 
		{"F","특이사항없음", 0 },
		{"B","조정기박스없음", 0 },
		{"A","조정기없음", 0 },
		{"C","필터박스 뒤집힘", 0 },
		{"D","부식이심함", 0 },
		{"E","벤트 상향", 0 },
		0
	};

	//조정기점검 항목코드
	CodeTable SCJJCHKCD[] = { 
		{"10","조정기안전점검(단독)", 0 },
		{"20","작동상태", 0 },
		{"30","가스누출여부", 0 },
		{"40","조정기안전점검(공동)", 0 },
		0
	};
	
	//조정기점검(단독)
	CodeTable SCJJCHKSL[] = { 
		{"11","유니언연결부위", 0 },
		{"12","필터부위", 0 },
		{"13","벤트부분", 0 },
		{"14","가스누출여부", 0 },
		0
	};
	
	//작동상태(조정기공동)
	CodeTable SCJJWRKSTT[] = { 
		{"21","이상압력발생", 0 },
		{"22","소음발생", 0 },
		0
	};

	//가스누출여부(조정기공동)
	CodeTable SCJJGAS[] = { 
		{"31","본체", 0 },
		{"32","벤트", 0 },
		{"33","유니언부위", 0 },
		0
	};

	//조정기(조정기공동)
	CodeTable SCJJCHKTGT[] = { 
		{"41","필터스트레이나상태", 0 },
		{"42","조정기 설치 위치", 0 },
		{"43","가스방출구 위치", 0 },
		{"44","박스설치상태", 0 },
		{"45","조정기부식여부", 0 },
		{"46","절연유니온상태", 0 },
		{"47","조정기 입상관", 0 },
		{"48","기타", 0 },
		0
	};
	
	//조정기 작업구분
	CodeTable SCWORK[] = { 
		{"10","정기점검", 0 },
		{"21","필터점검(1인치)", 0 },
		{"22","필터점검(2인치)", 0 },
		0
	};

	//조정기 타입
	CodeTable SCJJTYPE[] = { 
		{"10","좌타입", 0 },
		{"20","우타입", 0 },
		0
	};

	//필터교체FLAG
	CodeTable SCFLTCHGFLAG[] = { 
		{"10","1 inch", 0 },
		{"20","2 inch", 0 },
		{"30","3 inch", 0 },
		{"40","4 inch", 0 },
		0
	};
	
	//특정 정압기점검, 점검항목코드 : 21
	CodeTable SCHKGOV[] = {
		{"10","차단밸브 작동상태", "밸브" },
		{"20","압력기록장치 작동상태", "압력" },
		{"30","이상압력통보 작동상태", "전기" },
		{"40","가스누출통보 작동상태", "전기" },
		{"50","분해점검 미실시", "분해" },
		{"60","긴급차단장치 작동상태", "전기" },
		{"70","정압기 작동 상태", "전기" },
		{"80","위해 예방조치", "기타" },
		{"90","가스 누출", "기타" },
		0 
	};

	//특정 조정기점검, 점검항목코드 : 23
	CodeTable SCHKREGTR[] = { 
		{"10","조정기 작동상태", "10" },
		{"20","격납상자 설치상태", "20" },
		{"30","차량추돌 방호조치", "30" },
		{"40","필터청소 미실시", "40" },
		{"50","차단밸브 작동상태", "50" },
		{"60","가스 누출", "60" },
		0 
	};

	//특정 배관점검, 점검항목코드 : 10
	CodeTable SCHKPIPE[] = { 
		{"10","배관 부식", "10" },
		{"20","배관 도색/표시 미비", "20" },
		{"30","전기설비 이격거리 미비", "30" },
		{"40","입상배관 보호 미비", "40" },
		{"50","배관고정 미비", "50" },
		{"60","전기방식 미비", "60" },
		{"70","마감조치 미비", "70" },
		{"80","차단밸브 상태", "80" },
		{"90","가스 누출", "90" },
		0 
	};
	
	//특정 배관점검외, 점검항목코드 : 70
	CodeTable SCHKPIPEEX[] = { 
		{"10","가스사고 배상책임보험", "10" },
		{"20","안전관리자 선임", "20" },
		{"30","검사 승인", "30" },
		{"40","정기검사 수검", "40" },
		0 
	};

	//특정 계량기점검, 점검항목코드 : 22
	CodeTable SCHKGM[] = { 
		{"10","설치장소 불량", 0 },
		{"20","전기설비 이격거리 미비", 0 },
		{"30","설치높이 불량", 0 },
		{"40","검사 승인", 0 },
		{"50","가스 누출", 0 },
		{"60","마감조치 미비", 0 },
		0 
	};

	//특정 보정기점검	(대용량계량기), 점검항목코드 : 60
	CodeTable SCHKCOMPENS[] = { 
		{"10","계량기몸체", "0" },
		{"20","보정기몸체", "0" },
		{"30","봉인상태", "0" },
		{"40","보정기연결상태", "0" },
		{"50","LCD계기판", "0" },
		0 
	};
	
	//특정 차단장치점검, 점검항목코드 : 24
	CodeTable SCHKGASALARM[] = { 
		{"10","차단장치 작동상태 불량", 0 },
		{"20","차단장치 미설치", 0 },
		0 
	};
	
	//특정 연소기점검
	CodeTable SCHKBUR[] = { 
		{"10","연소기 연결/마감 상태", 0 },
		{"20","마감조치 미비", 0 },
		{"30","보일러 설치불량", 0 },
		{"40","보일러 배기통 불량", 0 },
		{"50","CO경보기 미설치", 0 },
		{"60","연소기 설치불량", 0 },
		{"70","가스 누출", 0 },
		{"80","빌트인 불량", 0 },
		0 
	};

	//바코드사유제외(특정)
	CodeTable CHKBAR_WHY[] = { 
		{"10","훼손", 0 },
		{"20","미부착", 0 },
		{"30","인식불가", 0 },
		{"40","기타", 0 },
		0 
	};	
		
	//특정정보 회사번호
	CodeTable OFFICE_TEL[] = { 
		{"02","02", 0 },
		{"031","031", 0 },
		{"070","070", 0 },
		0
	};
		
	//특정정보 핸드폰번호
	CodeTable HP_NUM[] = { 
		{"010","010", 0 },
		{"011","011", 0 },
		{"016","016", 0 },
		{"018","018", 0 },
		{"017","017", 0 },
		{"019","019", 0 },
		{"02","02", 0 },
		{"031","031", 0 },
		{"070","070", 0 },
		0
	};

	//특정점검 서명 관계 코드
	CodeTable SIGN_RLT[] = { 
		{"10","본인", 0 },
		{"20","부모", 0 },
		{"30","자녀", 0 },
		{"90","기타", 0 },
		0
	};

	//바코드(점검쪽)
	CodeTable SCBARWHY[] = { 
		{"10","훼손", 0 },
		{"20","미부착", 0 },
		{"30","인식불가", 0 },
		{"40","기타", 0 },
		0
	};
	
	//2차 개발(2017-03-05) : 계량기 -> 연소기점검으로 변경
	//타이머콕
	CodeTable SCTIMER_COCK[] = { 
		{"Y","설치", 0 },
		{"N","미설치", 0 },
		0
	};
	
	//계량기봉인여부
	CodeTable CHKMTR_SEAL[] = { 
		{"10","부착", 0 },
		{"20","미부착", 0 },
		{"30","훼손", 0 },
		{"40","미대상", 0 },
		0 
	};
	
	//메모코드
	CodeTable CHK_MEMO[] = { 
		{"10","깨끗한집", 0 },
		{"11","주인집열쇠", 0 },
		{"12","점검거부", 0 },
		{"13","주인집남자", 0 },
		{"14","출장", 0 },
		{"15","주말점검", 0 },
		{"16","야간점검", 0 },
		{"17","동물조심", 0 },
		{"18","할머니거주", 0 },
		0 
	};
	
	//무적신고 불법유형
	CodeTable CHK_ILLGAL[] = { 
		{"10","계량기탈부착", 0 },
		{"11","중지지침차이", 0 },
		{"12","무적자원", 0 },
		{"13","봉인스티커훼손", 0 },
		0 
	};
	
	//지사코드(특정 수신)
	CodeTable JISA_CD[] = { 
		{"100584","서부지사", 0 },
		{"100591","남부지사", 0 },
		{"100664","강북지사", 0 },
		{"101500","경기지사", 0 },
		0 
	};
	
	//사회복지시설
	CodeTable SOCIAL_FACI_STS_CD[] = { 
		{"1","운영", 0 },
		{"2","휴업", 0 },
		{"3","폐업", 0 },
		0
	};
	
	
	// 개선리스트 콤보박스 항목
	CodeTable RFRM_COMBO[] = { 
		{"1","전체", 0 },
		{"2","부적합사항", 0 },
		{"3","권고사항", 0 },
		0
	};

//-----------------------------------------------------------------------------------------------
//				공급전 안전점검 코드
//-----------------------------------------------------------------------------------------------

	//공급전 점검 보험
	CodeTable INS_JOIN[] = { 
		{"Y","가입", 0 },
		{"N","미가입", 0 },
		0 
	};

	//공급전 점검 설명
	CodeTable INS_EXPLA[] = { 
		{"Y","설명", 0 },
		{"N","미설명", 0 },
		0 
	};

	//공급전 점검 보일러 구분 , Decode(INST_FLAG,'10','신규','20','교체','기존')
	CodeTable BFBOIL_INST[] = { 
		{"10","신규", 0 },
		{"20","교체", 0 },
		{"","기존", 0 },
		0 
	};
	
	//공급전 점검 보일러 결과 , Decode(CHK_RSLT,'Y','적합','N','부적합','E',' ','미확인')
	CodeTable BFBOIL_RSLT[] = { 
		{"Y","적합", 0 },
		{"N","부적합", 0 },
		{"E"," ", 0 },
		{"","미확인", 0 },
		0 
	};

	//공급전점검 , 보일러 위치 점검
	CodeTable BF_BOILCHK[] = { 
		{"10","보일러실내설치", 0 },
		{"20","목욕탕설치", 0 },
		{"30","전용보일러개구부설치", 0 },
		{"60","전용보일러실설치", 0 },
		0
	};
	
	//공급전점검 , 급/환기구 점검
	CodeTable BF_HWANCHK[] = { 
		{"10","급환기구막힘", 0 },
		{"20","급기구 미비", 0 },
		{"30","환기구 미비", 0 },
		{"40","급환기구 미비", 0 },
		{"50","동력환기팬 설치", 0 },
		{"60","공동 배기구 불량", 0 },
		0
	};
	
	//공급전점검 , 배기통톱 점검
	CodeTable BF_BEGICHK[] = { 
		{"10","배기통노후", 0 },
		{"11","배기통고정불량", 0 },
		{"12","하향구배 불량", 0 },
		{"13","연결부접속불량", 0 },
		{"14","연통재질불량", 0 },
		{"15","굴곡수초과", 0 },
		{"16","배기통외부로노출불량", 0 },
		{"17","배기통톱이격거리", 0 },
		{"18","방조망(16mm이하) 미설치", 0 },
		{"19","배기통재질(알루미늄주름관)", 0 },
		{"20","배기통재질(스테인레스주름관)", 0 },
		{"21","급기통이탈", 0 },
		{"22","급기구최초흡입구 1CM미만", 0 },
		{"23","배기통톱개구부로부터60CM미비", 0 },
		{"24","배기통관통유입방지미비", 0 },
		{"25","배기통길이 초과", 0 },
		{"26","배기통이탈", 0 },
		{"27","배기통재질", 0 },
		{"29","배기통이격거리/좌우30,상하150CM", 0 },
		{"30","배기통관통부 그을음여부", 0 },
		{"31","실내전용배기통 미사용", 0 },
		{"32","배기통인증품설치여부", 0 },
		0
	};
	
	//공급전점검 , 기타점검
	CodeTable BF_ETCCHK[] = { 
		{"10","보일러실내가연성방치", 0 },
		{"20","주변가연성물질방치", 0 },
		{"30","보일러상부 CASE없음", 0 },
		{"40","보일러고정불량", 0 },
		{"50","보일러설치 (FF->FE)불량", 0 },
		{"90","CO경보기미설치", 0 },
		{"91","CO경보기설치불량", 0 },	
		{"92","가스누출", 0 },
		0
	};

	//보일러 설치위치
	CodeTable BOIL_LOC[] = { 
		{"10","전용보일러실", 0 },
		{"20","베란다", 0 },
		{"30","실내", 0 },
		{"40","실외", 0 },
		{"50","목욕탕", 0 },
		{"60","다용도실", 0 },
		0
	};
	
	//지사코드
	CodeTable BLANCH_CD[] = { 
		{"100584","서부지사", 0 },
		{"100591","남부지사", 0 },
		{"100664","강북지사", 0 },
		{"101500","경기지사", 0 },
		0
	};
	
	//고객패턴 요일
	CodeTable PTRN_DAY[] = { 
		{"0","모두", 0 },
		{"1","월", 0 },
		{"2","화", 0 },
		{"3","수", 0 },
		{"4","목", 0 },
		{"5","금", 0 },
		{"6","토", 0 },
		{"7","일", 0 },
		0
	};
	
	//고객패턴 시간
	CodeTable PTRN_TIME[] = { 
		{"0","모두", 0 },
		{"1","출근전", 0 },
		{"2","오전", 0 },
		{"3","오후", 0 },
		{"4","퇴근후", 0 },
		0
	};

//-----------------------------------------------------------------------------------------------
//				체납 코드
//-----------------------------------------------------------------------------------------------

	//개별활동 검색조건
	CodeTable NP_PARTSRCH[] = { 
		{"1","고객번호", 0 },
		{"2","사용계약번호", 0 },
		{"3","전화(유선)", 0 },
		{"4","전화(무선)", 0 },
		{"5","주민번호", 0 },
		{"6","사업자번호", 0 },
		{"7","기물번호", 0 },
		0
	};

//-----------------------------------------------------------------------------------------------
//				민원 코드
//-----------------------------------------------------------------------------------------------

	//미확인코드
	CodeTable NORSTCD[] = { 
		{"10","예약취소", 0 },
		{"20","고객부재", 0 },
		{"30","기처리완료", 0 },
		{"40","접수착오", 0 },
		{"50","배경변경", 0 },
		{"60","예약일변경", 0 },
		{"70","주소변경", 0 },
		{"80","타업체처리완료", 0 },
		{"90","기타", 0 },
		0
	};

	//현금영수증
	CodeTable CASH_GBN[] = { 
		{"0","소비자소득공제", 0 },
		{"1","사업자지출공제", 0 },
		0
	};
	
	CodeTable BARGBN[] = { 
		{"10","바코드", 0 },
		{"20","계량기", 0 },
		0
	};

	CodeTable BAR_WHY[] = { 
		{"10","훼손", 0 },
		{"20","위치불량", 0 },
		{"30","인식불가", 0 },
		{"40","기타", 0 },
		0 
	};
	
	CodeTable CK_CARDMM[] = 
	{
		{"00", "일시불",0 },
		{"02", "2개월",0 },
		{"03", "3개월",0 },
		{"04", "4개월",0 },
		{"05", "5개월",0 },
		{"06", "6개월",0 },
		{"07", "7개월",0 },
		{"08", "8개월",0 },
		{"09", "9개월",0 },
		{"10", "10개월",0 },
		{"11", "11개월",0 },
		{"12", "12개월",0 },
		0
	};
	
//-----------------------------------------------------------------------------------------------
//				이동고객센터 코드
//-----------------------------------------------------------------------------------------------
	CodeTable MC_BILL_SEND_METHOD[] = 
	{
		{"10", "가스앱",0 },
		{"20", "LMS",0 },
		{"30", "메일",0 },
		{"60", "송달",0 },
		0
	};
	
	CodeTable MC_REFUSE[] = 
	{
		{"10", "핸드폰불가능",0 },
		{"20", "현재유지",0 },
		{"60", "기타",0 },
		{"70", "검토",0 },
		{"80", "부재",0 },
		0
	};
	
	CodeTable MC_PAY_METHOD[] = 
	{
		{"10", "등록",0 },
		{"20", "서면",0 },
		{"30", "거부",0 },
		0
	};
	
	CodeTable MC_SELF_GMTR[] = 
	{
		{"10", "등록",0 },
		{"30", "거부",0 },
		0
	};
	
	CodeTable MC_USE_CONT[] = 
	{
		{"10", "작성",0 },
		{"20", "거부",0 },
		{"30", "해당없음",0 },
		0
	};
	
	CodeTable MC_EMAIL_ADDR[] = 
	{
		{"naver.com", "naver.com",0 },
		{"hanmail.net", "hanmail.net",0 },
		{"daum.net", "daum.net",0 },
		{"kakao.com", "kakao.com",0 },
		{"nate.com", "nate.com",0 },
		{"empal.com", "empal.com",0 },
		{"hotmail.com", "hotmail.com",0 },
		{"yahoo.com", "yahoo.com",0 },
		{"yahoo.co.kr", "yahoo.co.kr",0 },
		{"gmail.com", "gmail.com",0 },
		0
	};
	
	CodeTable MC_CURR_ADDR[] = 
	{
		{"서울 강서구"			, "서울 강서구",0 },
		{"서울 관악구"			, "서울 관악구",0 },
		{"서울 동작구"			, "서울 동작구",0 },
		{"서울 마포구"			, "서울 마포구",0 },
		{"서울 서대문구"		, "서울 서대문구",0 },
		{"서울 서초구"			, "서울 서초구",0 },
		{"서울 양천구"			, "서울 양천구",0 },
		{"서울 영등포구"		, "서울 영등포구",0 },
		{"서울 용산구"			, "서울 용산구",0 },
		{"서울 은평구"			, "서울 은평구",0 },
		{"서울 종로구"			, "서울 종로구",0 },
		{"경기 고양시 덕양구"	, "고양시 덕양구",0 },
		{"경기 고양시 일산동구"	, "고양시 일산동구",0 },
		{"경기 고양시 일산서구"	, "고양시 일산서구",0 },
		{"경기 김포시"			, "김포시",0 },
		{"경기 파주시"			, "파주시",0 },
		0
	};
	
	CodeTable MC_NEW_ADDR[] = 
	{
		{"서울특별시 강서구"		, "서울 강서구",0 },
		{"서울특별시 관악구"		, "서울 관악구",0 },
		{"서울특별시 동작구"		, "서울 동작구",0 },
		{"서울특별시 마포구"		, "서울 마포구",0 },
		{"서울특별시 서대문구"		, "서울 서대문구",0 },
		{"서울특별시 서초구"		, "서울 서초구",0 },
		{"서울특별시 양천구"		, "서울 양천구",0 },
		{"서울특별시 영등포구"		, "서울 영등포구",0 },
		{"서울특별시 용산구"		, "서울 용산구",0 },
		{"서울특별시 은평구"		, "서울 은평구",0 },
		{"서울특별시 종로구"		, "서울 종로구",0 },
		{"경기도 고양시 덕양구"		, "고양시 덕양구",0 },
		{"경기도 고양시 일산동구"	, "고양시 일산동구",0 },
		{"경기도 고양시 일산서구"	, "고양시 일산서구",0 },
		{"경기도 김포시"			, "김포시",0 },
		{"경기도 파주시"			, "파주시",0 },
		0
	};

//-----------------------------------------------------------------------------------------------
//				모바일사용계약서 코드
//-----------------------------------------------------------------------------------------------
	CodeTable MUD_BILL_SEND_METHOD[] = 
	{
		{"10"		, "고지서",0 },
		{"40"		, "이메일",0 },
		{"70"		, "문자(LMS)",0 },
		{"80"		, "모바일",0 },
		0
	};

	CodeTable MUD_BILL_SEND_METHOD_DOUBLE[] = 
	{	
		{"14"		, "이메일+송달"},
		{"17"		, "LMS+송달"},
		{"18"		, "모바일+송달"},
		{"47"		, "이메일+LMS"},
		{"48"		, "모바일+이메일"},
		{"78"		, "모바일+LMS"},
		0
	};
	
	CodeTable MUD_PAY_METHOD[] = 
	{
		{"10"		, "지로",0 },
		{"20"		, "은행이체",0 },
		{"30"		, "카드이체",0 },
		0
	};

	//교체소요비용_ YN
	CodeTable C6301_BATTERY_YN[] = { 
		{"Y","설치", 0 },
		{"N","미설치", 0 },
		0
	};

	CodeTable C6301_MTRDISPLAY_YN[] = { 
		{"Y","설치", 0 },
		{"N","미설치", 0 },
		0
	};
#endif

