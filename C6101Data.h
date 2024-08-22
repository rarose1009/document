/*----------------------------------------------------------------------------------
	Project Name: Smart SCGGAS
----------------------------------------------------------------------------------*/
#ifndef		C6101DATA_H
#define		C6101DATA_H

//-----------------------------------------------------------------------------------------------	
// 	민원활동 대상
//-----------------------------------------------------------------------------------------------	
typedef struct _MWINFO
{
  char szPromise_assign_seq    [10 +1]; // 
  char szReg_flag              [2  +1]; // 
  char szBranch_cd             [6  +1]; // 
  char szCenter_cd             [2  +1]; // 
  char szAssign_empid          [9  +1]; // 
  char szCust_num              [10 +1]; // 
  char szUse_cont_num          [10 +1]; // 
  char szInst_place_num        [9  +1]; // 
  char szZip_seq               [10 +1]; // 
  char szEtc_addr              [100+1]; // 
  char szCivil_serv_class_cd   [6  +1]; // 
  char szPromise_ymd           [8  +1]; // 
  char szPromise_time          [4  +1]; // 
  char szEnd_expect_time       [4  +1]; // 
  char szJob_str_dtm           [14 +1]; // 
  char szJob_end_dtm           [14 +1]; // 
  char szPromise_assign_desc   [500+1]; // 
  char szCivil_serv_receive_num[14 +1]; // 
  char szTreat_seq             [10 +1]; // 
  char szProc_sts_cd           [2  +1]; // 
  char szPda_num               [5  +1]; // 
  char szOnce_pay              [10 +1]; // 
  char szSend_yn               [1  +1]; // 
  char szCivil_serv_class_nm   [50 +1]; // 
  char szPda_duty              [20 +1]; // 
  char szReq_tel_ddd           [4  +1]; // 
  char szReq_tel_exn           [4  +1]; // 
  char szReq_tel_num           [4  +1]; // 
  char szReq_cp_ddd            [4  +1]; // 
  char szReq_cp_exn            [4  +1]; // 
  char szReq_cp_num            [4  +1]; // 
  char szTrans_in_cust_nm      [50 +1]; // 
  char szTrans_in_soc_num      [13 +1]; // 
  char szReq_nm                [50 +1]; // 
  char szReq_soc_num           [13 +1]; // 
  char szReceive_dtm           [20 +1]; // 
  char szCust_type_cd          [2  +1]; // 
  char szCust_nm               [30 +1]; // 
  char szFirm_nm               [50 +1]; // 
  char szSoc_num               [13 +1]; // 
  char szBiz_regi_num          [10 +1]; // 
  char szCp_ddd                [4  +1]; // 
  char szCp_exn                [4  +1]; // 
  char szCp_num                [4  +1]; // 
  char szOwnhouse_tel_ddd      [4  +1]; // 
  char szOwnhouse_tel_exn      [4  +1]; // 
  char szOwnhouse_tel_num      [4  +1]; // 
  char szFirm_tel_ddd          [4  +1]; // 
  char szFirm_tel_exn          [4  +1]; // 
  char szFirm_tel_num          [4  +1]; // 
  char szScg_relat_cd          [2  +1]; // 
  char szEmail                 [50 +1]; // 
  char szFamily_cnt            [10 +1]; // 
  char szCust_trnd_cd          [2  +1]; // 
  char szChk                   [1  +1]; // 작업이관시에 여러건 선택할때 사용하는 필드임.
  char szBuilt_in_yn           [2  +1]; // 
  char szSquare_meter          [5  +1]; // 
  char szCurr_addr_union       [100+1]; // 
  char szBld_floor             [20 +1]; // 
  char szHouse_cnt             [10 +1]; // 
  char szPda_duty_flag         [10 +1]; // 
  char szPay_calu              [10 +1]; // 민원 전체받기와 추가받기 간에 소트순서를 위하여 사용(다른용으로 사용불가)
  char szPda_trans_flag        [5  +1]; // 
  char szReq_info_num          [10 +1]; // 
  char szTrans_in_cust_num     [10 +1]; // 
  char szCont_sts_cd           [2  +1]; // 계량기상태의 집계(중지:20 미중지:10  해지등록, 중지등록, 중간정산일시에 변경됨.)
  char szPda_read_dtm          [15 +1]; // 
  char szMemo                  [500+1]; // 
  char szAuto_yn               [1  +1]; // 후불처리여부
  char szCust_yn               [1  +1]; // 
  char szBur_yn                [1  +1]; // 연소기수정여부
  char szProd_yn               [1  +1]; // 상품변경여부(전입?)
  char szOnce_yn               [1  +1]; // 
  char szPrice_yn              [1  +1]; // 일회성입력구분 (1.전출이외 , 2.전출, 미입력 NULL )
  char szZip_no1               [10 +1]; // 
  char szZip_no2               [10 +1]; // 
  char szCity                  [20 +1]; // 
  char szCounty                [20 +1]; // 
  char szTown                  [20 +1]; // 
  char szVillage_ri            [20 +1]; // 
  char szVillage               [30 +1]; // 
  char szBuilding              [20 +1]; // 
  char szAddr1_m               [10 +1]; // 
  char szAddr1_s               [10 +1]; // 
  char szAccount               [10 +1]; // 가스요금 수납금액
  char szOnce_account          [10 +1]; // 일회성 요 수납금액합계
  char szChk_time_from         [16 +1]; // 작업시작시간
  char szChk_time_end          [16 +1]; // 작업종료시간
  char szMtr_chg_yn            [1  +1]; // 계량기교체여부
  char szInfo_use_agree_yn     [2  +1]; // 정보
  char szPas_use_cont_num_yn   [1  +1]; // 
  char szAdj_alt_amt           [10 +1]; // 예수금합계
  char szPas_defray_account_num[20 +1]; // 
  char szPas_cust_num          [10 +1]; // 
  char szPas_req_info_num      [10 +1]; // 
  char szAppro_num             [10 +1]; // 현금영수증 승인번호
  char szAppro_tel             [20 +1]; // 현금영수증 고객정보
  char szAdj_cause             [2  +1]; // 후불처리사유
  char szDeadline_flag         [2  +1]; // 납기구분
  char szGmtr_base_day         [2  +1]; // 검침일
  char szCard_gaspay           [10 +1]; // 카드 가스요금
  char szCard_onepay           [1  +1]; // 일회성요금 구분( 현금, 카드)
  char szCash_gaspay           [10 +1]; // 현금 가스요금
  char szInfo_use_yn           [1  +1]; // 정보활용동의
  char szUse_cont_doc_yn       [1  +1]; // 
  char szPay_method            [10 +1]; // 청구방법
  char szDefray_account_num    [20 +1]; // 
  char szDepositor_nm          [16 +1]; // 
  char szBank_nm               [10 +1]; // 
  char szDebt_amt              [10 +1]; // 
  char szLaw_etc_amt           [10 +1]; // 
  char szLaw_town              [10 +1]; // 
  char szNew_road_nm           [30 +1]; // 
  char szNew_addr_m            [10 +1]; // 
  char szNew_addr_s            [10 +1]; // 
  char szNew_addr_union        [100+1]; // 
  char szBill_gubun            [2  +1]; // 청구서구분(E:이메일, L:LMS, M:모바일)
  char szTrans_conn_yn         [1  +1]; // 연결구분
  char szConn_yn               [1  +1]; // 전입여부
  char szBar_yn                [1  +1]; // 바코드스캔여부
  char szBar_gbn               [2  +1]; // 스캔바코드구분
  char szBar_why               [2  +1]; // 바코드스캔불가사유
  char szChk_yn                [1  +1]; // 점검여부
  char szConn_gbn              [2  +1]; // 전입여부
  char szNew_addr_bld_seq	   [20 +1]; // 전출 납부확약서 등록시 필요.
  char szZero_tax_rt_apply_yn  [1  +1];
  char szSpecial_tax_exemp_yn  [1  +1];
  char szGet_spc_tax_chk       [1  +1];
  char szMtr_Photo_yn          [1  +1];
  char szPlace_Photo_yn        [1  +1];
  char szSocial_welf_disc_yn   [1  +1];
  char szAppro_status_flag     [2  +1];
  char szAppro_gubun           [2  +1];
  char szInfo_Trans_yn         [2  +1];
  char szSend_Info_Trans_yn    [2  +1];
  char szProd_chg			   [2  +1];
}	MWINFO;
global MWINFO stMw;


typedef struct _MWMTRINFO
{
	char szPromise_assign_seq     [10+1]; //
	char szMtr_num                [9 +1]; //
	char szCivil_serv_receive_num [15+1]; //
	char szTreat_seq              [10+1]; //
	char szInst_place_num         [9 +1]; //
	char szUse_cont_num           [10+1]; //
	char szMtr_id_num             [20+1]; //
	char szMtr_grd                [7 +1]; //
	char szMtr_form               [2 +1]; //
	char szMtr_form_nm            [50+1]; //
	char szMtr_type               [2 +1]; //
	char szMtr_type_nm            [50+1]; //
	char szMtr_remote_flag        [2 +1]; //
	char szMtr_remote_flag_nm     [50+1]; //
	char szMtr_kind               [2 +1]; //
	char szMtr_kind_nm            [50+1]; //
	char szMtr_digit_cnt          [10+1]; //
	char szMtr_new_fix_flag       [2 +1]; //
	char szMtr_valid_ym           [6 +1]; //
	char szMtr_appro_yn           [1 +1]; //
	char szSealed_ymd             [8 +1]; //
	char szSealed_sts             [2 +1]; //
	char szChk_bar_adhere_ymd     [8 +1]; //
	char szChk_bar_adhere_sts     [2 +1]; //
	char szMtr_deta_loc           [30+1]; //
	char szKeeper_yn              [2 +1]; //
	char szRevis_flag             [2 +1]; //
	char szMtr_loc_flag           [2 +1]; //
	char szMtr_loc_flag_nm        [50+1]; //
	char szMtr_inst_height        [20+1]; //
	char szMtr_resou_flag         [2 +1]; //
	char szMtr_supply_sts         [2 +1]; //
	char szMtr_supply_sts_nm      [50+1]; //
	char szMtr_model_cd           [5 +1]; //
	char szMtr_model_nm           [50+1]; //
	char szCompens_model_nm       [50+1]; //
	char szProd_cont_seq          [3 +1]; //
	char szProd_cont_ymd          [8 +1]; //
	char szBiz_type_cd            [6 +1]; //
	char szProd_cd                [5 +1]; //
	char szProd_nm                [50+1]; //
	char szProd_area_flag         [2 +1]; //
	char szCont_flag_cd           [2 +1]; //
	char szProd_sts_cd            [2 +1]; //
	char szCont_revis_para        [10+1]; //
	char szCut_ymd                [8 +1]; //
	char szCut_type_cd            [2 +1]; //
	char szCut_treat_empid        [9 +1]; //
	char szCut_why_cd             [2 +1]; //
	char szCut_cnl_ymd            [8 +1]; //
	char szIndi_cut_vc_after      [10+1]; //
	char szIndi_cut_va_after      [10+1]; //
	char szIndi_cut_vm_after      [10+1]; //
	char szIndi_cut_ymd           [8 +1]; //
	char szIndi_type_cd           [2 +1]; //
	char szIndi_type_nm           [50+1]; //
	char szIndi_vc_after          [10+1]; //
	char szIndi_va_after          [10+1]; //
	char szIndi_vm_after          [10+1]; //
	char szIndi_vc                [10+1]; //
	char szIndi_va                [10+1]; //
	char szIndi_vm                [10+1]; //
	char szNonpay                 [10+1]; //
	char szAccount                [9 +1]; //
	char szTotalcount             [9 +1]; //
	char szSend_yn                [1 +1]; //
	char szAdj_chk                [1 +1]; //
	char szCnl_why_cd             [2 +1]; //
	char szCut_cnl_fee_yn         [1 +1]; //
	char szCut_cnl_fee_exempt_why [2 +1]; //
	char szAdj_alt_amt            [9 +1]; //
	char szTot_use_qty            [9 +1]; //
	char szReq_ym                 [6 +1]; //
	char szDeadline_flag          [2 +1]; //
	char szChk_yn                 [1 +1]; //
	char szAdj_ymd                [8 +1]; //
	char szUse_period_str         [8 +1]; //
	char szUse_period_end         [8 +1]; //
	char szCard_yn                [1 +1]; //
	char szTot_ener_qty           [10+1]; //
	char szTot_revis_qty          [10+1]; //
	char szSupply_unit_ener       [10+1]; //
	char szBill_gubun             [2 +1]; 
	// 청구서구분(E:이메일, L:LMS, M:모바일)
}MWMTRINFO;
global  MWMTRINFO stMtr;


typedef struct _MWCHGMTR
{
	char szMtr_num               [9 +1];//
	char szRepl_treat_ymd        [8 +1];//
	char szPromise_assign_seq    [9 +1];//
	char szInst_place_num        [9 +1];//
	char szCenter_cd             [2 +1];//
	char szMtr_fee_free_flag     [1 +1];//
	char szMtr_repl_why          [3 +1];//
	char szMtr_bar               [20+1];//
	char szProd_cd               [5 +1];//
	char szAfter_mtr_id_num      [20+1];//
	char szAfter_mtr_model_cd    [5 +1];//
	char szAfter_mtr_grd         [8 +1];//
	char szAfter_mtr_type        [2 +1];//
	char szAfter_mtr_remote_flag [2 +1];//
	char szAfter_mtr_kind        [2 +1];//
	char szAfter_mtr_digit_cnt   [2 +1];//
	char szAfter_mtr_new_fix_flag[2 +1];//
	char szAfter_fix_firm_nm_cd  [2 +1];//
	char szAfter_mtr_valid_ym    [6 +1];//
	char szAfter_form_appro_yn   [1 +1];//
	char szBefo_mtr_id_num       [20+1];//
	char szBefo_mtr_model_cd     [5 +1];//
	char szBefo_mtr_grd          [8 +1];//
	char szBefo_mtr_type         [2 +1];//
	char szBefo_mtr_remote_flag  [2 +1];//
	char szBefo_mtr_kind         [2 +1];//
	char szBefo_mtr_digit_cnt    [2 +1];//
	char szBefo_mtr_new_fix_flag [2 +1];//
	char szBefo_fix_firm_nm_cd   [2 +1];//
	char szBefo_mtr_valid_ym     [6 +1];//
	char szBefo_mtr_appro_yn     [1 +1];//
	char szRemove_indi_vm        [9 +1];//
	char szRemove_indi_va        [9 +1];//
	char szRemove_indi_vc        [9 +1];//
	char szInst_indi_vm          [9 +1];//
	char szInst_indi_va          [9 +1];//
	char szInst_indi_vc          [9 +1];//
	char szSend_yn               [1 +1];//
	char szJob_dtm               [15+1];//
	char szRevis_flag			 [2 +1];//
	char szLastvc			 	 [9 +1];//
	char szMtr_supply_sts        [2 +1]; //
	char chk_buld_center_cd	     [2  +1];
    char battery_yn			     [2  +1];
    char mtrdisplay_yn		     [2  +1];
    char other_price             [10 +1];
    char old_mtr_id_num          [25 +1];
	char remote_system			 [2 +1];
	
}MWCHGMTR;
global MWCHGMTR stChgMtr;

typedef struct _MWBURINFO
{
	char szPromise_assign_seq    [10+1]; // 
	char szMtr_num               [10+1]; // 
	char szBurner_num            [10+1]; // 
	char szCivil_serv_receive_num[2 +1]; // 
	char szTreat_seq             [10+1]; // 
	char szInst_place_num        [20+1]; // 
	char szBurner_class_cd       [20+1]; // 
	char szBurner_kind_num       [20+1]; // 
	char szBurner_kind_nm        [20+1]; // 
	char szBurner_model_cd       [20+1]; // 
	char szBurner_capa           [10+1]; // 
	char szBurner_capa_unit      [20+1]; // 
	char szBurner_capa_unit_nm   [20+1]; // 
	char szBurner_inst_ymd       [8 +1]; // 
	char szBurner_remov_ymd      [8 +1]; // 
	char szBurner_model_nm       [20+1]; // 
	char szBurner_qty            [10+1]; // 
	char szMaker_nm              [20+1]; // 
	char szBoiler_form           [20+1]; // 
	char szBoiler_form_nm        [20+1]; // 
	char szMake_num              [30+1]; // 
	char szMake_ymd              [8 +1]; // 
	char szWork_docu_receive_ymd [8 +1]; // 
	char szInst_flag             [20+1]; // 
	char szInst_loc              [20+1]; // 
	char szInst_loc_nm           [20+1]; // 
	char szBoiler_inst_firm_cd   [20+1]; // 
	char szBoiler_inst_firm_nm   [20+1]; // 
	char szData_flag             [2 +1]; // 
	char szMtr_id_num            [15+1]; // 
	char szSend_yn               [1 +1]; // 
	char szMaker_num             [5 +1]; // 
	char szMtr_grd               [7 +1]; //
	char szInduc_inst_yn         [2 +1]; //	
	char szSpecial_yn            [2 +1]; //	
	
}MWBURINFO;


typedef struct _MWBILL
{
	char szMTR_NUM            [10+1]; //계량기번호
	char szUSE_CONT_NUM       [10+1]; //사용계약번호
	char szREQ_YM             [6 +1]; //검침년월
	char szADJ_YMD            [8 +1]; //정산일자
	char szDEADLINE_FLAG      [2 +1]; //납기
	char szINDI_VC            [10+1]; //지침
	char szPERIOD_DAY         [50+1]; //사용기간
	char szUSE_DAY            [10+1]; //사용일수
	char szTOT_USE_QTY        [14+1]; //사용량  
	char szTOT_BASE_CHARG     [14+1]; //기본료  
	char szTOT_CNL_CHARG      [14+1]; //해제료  
	char szSUPPLY_UNIT_ENER   [14+1]; //단위열량
	char szTOT_REVIS_QTY      [14+1]; //보정량  
	char szTOT_DISC_AMT       [14+1]; //사용료  
	char szTOT_ADJ_CHARG      [14+1]; //정산액  
	char szUSE_CHARG_DISC_AMT [14+1]; //감면액  
	char szOVERDUE_AMT        [14+1]; //연체료  
	char szTOT_REPL_COST      [14+1]; //교체비  
	char szTHIS_MM_CALCU_AMT  [14+1]; //합계액  
	char szTOT_REVIS_CHARG    [14+1]; //보정료 
	char szTOT_ENER_QTY       [14+1]; //총사용열량
	char szADJ_ALT_AMT        [14+1]; //예수금  
	char szREQ_AMT            [14+1]; //청구금액
	
	char szUSE_PERIOD_STR     [14+1]; //사용기간 시작일
	char szUSE_PERIOD_END     [14+1]; //사용기간 종료일
	
	
	
} MWBILL;
global MWBILL stBill;

typedef struct _CARDINFO
{
	char szPromise_assign_seq    [10+1]; //약속배정순번
	char szCivil_serv_receive_num[14+1]; //민원접수번호
	char szTreat_seq             [10+1]; //처리순번
	char szUse_cont_num          [10+1]; //사용번호
	char szItem_flag             [2 +1]; //항목구분
	char szRecev_seq             [3 +1]; //
	char szData_flag             [2 +1]; //
	char szTerminal_num          [10+1]; //터미널번호
	char szCard_num              [128+1]; //카드번호
	char szValid_ym              [4 +1]; //유효기간
	char szAllotment_mm          [2 +1]; //할부기간
	char szRslt_cd               [1 +1]; //승인결과
	char szCard_com              [2 +1]; //발급사코드
	char szCard_type_nm          [50+1]; //카드종류명
	char szBuying_comp           [2 +1]; //매입사코드
	char szBuying_comp_nm        [50+1]; //매입사명
	char szApproval_amt          [10+1]; //승인금액
	char szApproval_num          [12+1]; //승인번호
	char szApproval_time         [14+1]; //결제일시
	char szSend_yn               [1 +1]; //송신여부
    char szApproval_cancel_num   [12+1]; //승인취소번호
    char szApproval_cancel_date  [14+1]; //취소일시    
	char szReq_ymd               [8 +1]; //
} CARDINFO;
global CARDINFO stCardinfo;


typedef struct _CASHINFO
{
  char szPromise_assign_seq[9 +1];//민원배정번호                     
  char szUse_cont_num      [10+1];//사용계약번호                     
  char szWork_gubun        [4 +1];//7100:승인요청,  7102:승인취소요청
  char szAppro_sts         [1 +1];// 1:승인요청 2:승인취소요청       
  char szTreat_pda1        [3 +1];//
  char szTreat_pda2        [4 +1];//
  char szTreat_pda3        [4 +1];//
  char szStatus_flag       [2 +1];//
  char szCust_info         [20+1];//
  char szAmt               [15+1];//
  char szVat               [10+1];//
  char szAppronum          [20+1];//
  char szApproymd          [8+1]; //
  char szResp_cd           [4 +1];
  char szApprodate         [20+1];
  char szAppro_cancel_num  [20+1];
  char szAppro_cancel_date [20+1];
}CASHINFO;
global CASHINFO stCashinfo;


typedef struct _ONECARDINFO
{
	char szPromise_assign_seq    [10+1]; //약속배정순번
	char szCivil_serv_receive_num[14+1]; //민원접수번호
	char szTreat_seq             [10+1]; //처리순번
	char szUse_cont_num          [10+1]; //사용번호
	char szItem_flag             [2 +1]; //항목구분
	char szRecev_seq             [3 +1]; //
	char szData_flag             [2 +1]; //
	char szTerminal_num          [10+1]; //터미널번호
	char szCard_num              [128+1]; //카드번호
	char szValid_ym              [4 +1]; //유효기간
	char szAllotment_mm          [2 +1]; //할부기간
	char szRslt_cd               [1 +1]; //승인결과
	char szCard_com              [2 +1]; //발급사코드
	char szCard_type_nm          [50+1]; //카드종류명
	char szBuying_comp           [2 +1]; //매입사코드
	char szBuying_comp_nm        [50+1]; //매입사명
	char szApproval_amt          [10+1]; //승인금액
	char szApproval_num          [12+1]; //승인번호
	char szApproval_time         [14+1]; //결제일시
	char szSend_yn               [1 +1]; //송신여부
    char szApproval_cancel_num   [12+1]; //승인취소번호
    char szApproval_cancel_date  [14+1]; //취소일시    
	char szReq_ymd               [8 +1]; //
} ONECARDINFO;
global ONECARDINFO stOneCardinfo;

typedef struct _RTNCARDDATA
{
	char szCALL                  [100]; 
	char szDESC                  [100]; 
	char szRESULTCODE            [100]; 
	char szRESULTMSG             [100]; 
	char szVERIFICATIONCODE      [100]; 
	char szPAYMENTTID            [100]; 
	char szAPPROVALDATE          [100]; 
	char szAPPROVALNO            [100]; 
	char szTOTALAMOUNT           [100]; 
	char szTAX                   [100]; 
	char szSVC                   [100]; 
	char szCARDNAME              [100]; 
	char szCARDNO                [100]; 
	char szREADMODE              [100]; 
	char szPURCHASENAME          [100]; 
	char szSHOPNO                [100]; 
	char szNOTI                  [100]; 
	char szSHOPNAME              [100]; 
	char szCEONAME               [100]; 
	char szSHOPTELNO             [100]; 
	char szSHOPADDRESS           [100]; 
	char szVANNAME               [100]; 
	char szSIGNLEN               [100]; 
	char szSIGNDATA              [100]; 
	char szTYPE                  [100]; 
	char szCASHINFO              [100]; 
}	_RTNCARDDATA;
global _RTNCARDDATA stRtnCardData;

typedef struct _MWCHK
{
	char szPromise_assign_seq    [10 +1];
	char szCivil_serv_receive_num[14 +1]; 
    char szTreat_seq             [10 +1]; 
	char szAcc_take_act          [2+1]; 
	char szAcc_cause			 [2+1]; 
	char szAcc_cause_rmk		 [50+1]; 
	char szAcc_loc1              [2+1]; 
	char szAcc_loc2				 [2+1];
	char szAcc_loc_rmk			 [50+1];
	char szSend_yn               [1 +1];
} MWCHK;
global MWCHK stChk;

typedef struct _ETCCARDINFO
{
	char szItem_flag             [2 +1]; //승인:0, 취소:1
	char szTerminal_num          [10+1]; //터미널번호
	char szCard_num              [128+1]; //카드번호
	char szValid_ym              [4 +1]; //유효기간
	char szAllotment_mm          [2 +1]; //할부기간
	char szRslt_cd               [1 +1]; //승인결과
	char szCard_com              [2 +1]; //발급사코드
	char szCard_type_nm          [50+1]; //카드종류명
	char szBuying_comp           [2 +1]; //매입사코드
	char szBuying_comp_nm        [50+1]; //매입사명
	char szApproval_amt          [10+1]; //승인금액
	char szApproval_num          [12+1]; //승인번호
	char szApproval_time         [14+1]; //결제일시
    char szApproval_cancel_num   [12+1]; //승인취소번호
    char szApproval_cancel_date  [14+1]; //취소일시    

} ETCCARDINFO;
global ETCCARDINFO stEtcCardinfo;

#endif

