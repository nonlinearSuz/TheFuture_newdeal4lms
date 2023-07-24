package kr.happyjob.study.suplcd.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.suplcd.model.LectureDtPlanModel;


public interface SuplcdDao {
	
	/** 강의 목록 조회 */
	public List<LectureDtPlanModel> totalLecPlanList(Map<String, Object> paramMap)throws Exception ;
	
	/** 강의 목록 카운트 조회 */
	public int cntLecPlanList(Map<String, Object> paramMap)throws Exception ;

	
	
	/**[관리자] 강의 목록 조회 */
	public List<LectureDtPlanModel> profLecPlanList(Map<String, Object> paramMap)throws Exception;
	/**[관리자] 강의 목록 카운트 조회 */
	public int cntProfLecPlanList(Map<String, Object> paramMap)throws Exception ;

	/** [관리자] 강의 승인  */
	public int lecApprovUpdate(Map<String, Object> paramMap);

	/*[관리자] 강의 상세계획서 열람 */
	public LectureDtPlanModel lectureDtselectone(Map<String, Object> paramMap) throws Exception;


	
	/* 강의 상세계획서 수정  */
	public int lectureDtUpdate(Map<String, Object> paramMap) throws Exception;
	/*  강의 상세계획서 입력*/
	public int lectureDtInsert(Map<String, Object> paramMap) throws Exception;
	/* 강의 상세계획서 삭제 */
	public int lectureDtDelete(Map<String, Object> paramMap) throws Exception;


	/**파일 입력*/
	public int fileinsert(Map<String, Object> paramMap);

	/**파일 삭제*/
	public int deletefileinfo(Map<String, Object> paramMap);
	
}
