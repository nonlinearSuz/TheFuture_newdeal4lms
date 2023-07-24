package kr.happyjob.study.suplcd.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.suplcd.model.LectureDtPlanModel;

/*import kr.happyjob.study.suplct.model.AttendeeStuModel;
import kr.happyjob.study.suplct.model.LectureModel;*/

public interface SuplcdService {

	/**[관리자] 강의 목록 조회 */
	public List<LectureDtPlanModel> totalLecPlanList(Map<String, Object> paramMap)throws Exception;

	/**[관리자] 강의 목록 카운트 조회 */
	public int cntLecPlanList(Map<String, Object> paramMap)throws Exception;

	
	
	/**[강사] 강의 목록 조회 */
	public List<LectureDtPlanModel> profLecPlanList(Map<String, Object> paramMap)throws Exception;
	
	
	/**[강사] 강의 목록 카운트 조회 */
	public int cntProfLecPlanList(Map<String, Object> paramMap)throws Exception;
	
	
	/** [관리자] 강의 승인  */
	public int lecApprovUpdate(Map<String, Object> paramMap)throws Exception;

	
	/*[관리자] 강의 상세계획서 열람 */
	public LectureDtPlanModel lectureDtselectone(Map<String, Object> paramMap) throws Exception;

	/* 강의 상세계획서 수정  */
	public int lectureDtUpdate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	/* 강의 상세계획서 입력  */
	public int lectureDtInsert(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	/* 강의 상세계획서 삭제  */
	public int lectureDtDelete(Map<String, Object> paramMap) throws Exception;
	
}
