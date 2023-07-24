package kr.happyjob.study.supAth.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

import kr.happyjob.study.supAth.model.ApproveModel;

public interface SupAthDao {

   /** 목록 조회 */
   public List<ApproveModel> approvalist(Map<String, Object> paramMap);
   
   /** 목록 카운트 조회 */
   public int countapprovalist(Map<String, Object> paramMap);
   	
	/** 승인 및 반려 */
	public int approvelecture(Map<String, Object> paramMap) throws Exception;
	
	/** 강의 목록 */
	public List<ApproveModel> leclist(Map<String, Object> paramMap);

   
}