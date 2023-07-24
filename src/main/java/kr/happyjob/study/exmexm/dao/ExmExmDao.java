package kr.happyjob.study.exmexm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.exmexm.service.ExmExmService;
import kr.happyjob.study.exmexm.model.ExamManageModel;

public interface  ExmExmDao {

	/**  목록 조회 */
	public List<ExamManageModel> examlist(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countexamlist(Map<String, Object> paramMap) throws Exception;
	
	/** 한건 조회 */
	public ExamManageModel examselectone(Map<String, Object> paramMap) throws Exception;
	
	/** 등록 */
	public int examinsert(Map<String, Object> paramMap) throws Exception;
	
	/** 수정 */
	public int examupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 삭제 */
	public int examdelete(Map<String, Object> paramMap) throws Exception;
	
  /** 강사의 강의목록*/ 
	public int leclist(Map<String, Object> paramMap) throws Exception;
	
	/**  시험 상세 목록 조회 */
	public List<ExamManageModel> examdetail(Map<String, Object> paramMap) throws Exception;
		
	
	/** 하나의 시험 상세 조회 */
	public ExamManageModel examdetailone(Map<String, Object> paramMap) throws Exception;
	
	/** 문항 목록 카운트 조회 */
	public int countquelist(Map<String, Object> paramMap) throws Exception;
	
	/** 문항 등록 */
	public int queinsert(Map<String, Object> paramMap) throws Exception;
	
	/** 문항  수정 */
	public int queupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 문항  삭제 */
	public int quedelete(Map<String, Object> paramMap) throws Exception;
	
	
}
