package kr.happyjob.study.admmtd.dao;

import java.util.List;
import java.util.Map;



import kr.happyjob.study.admmtd.model.ResourceModel;

public interface AdmMtdDao {

	/**  목록 조회 */
	public List<ResourceModel>resourcelist(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countresourcelist(Map<String, Object> paramMap) throws Exception;

	/** 한건 조회 */
	public ResourceModel resourceselectone(Map<String, Object> paramMap) throws Exception;
	
	/** 등록 */
	public int iteminsert(Map<String, Object> paramMap) throws Exception;
	
	/** 수정 */
	public int itemupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 삭제 */
	public int itemdelete(Map<String, Object> paramMap) throws Exception;
	

	
}
