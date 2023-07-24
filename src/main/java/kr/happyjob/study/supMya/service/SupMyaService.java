package kr.happyjob.study.supMya.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.supMya.model.EnrollModel;

public interface SupMyaService {

   /** 그룹코드 목록 조회 */
   public List<EnrollModel> myLecturelist(Map<String, Object> paramMap) throws Exception;
   
   /** 목록 카운트 조회 */
	public int countmyLecturelist(Map<String, Object> paramMap) throws Exception;
	
	/** 취소 */
	public int cancelmylecture(Map<String, Object> paramMap) throws Exception;
	
	/** 재신청 */
	public int applymylecture(Map<String, Object> paramMap) throws Exception;

}