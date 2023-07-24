package kr.happyjob.study.exmaex.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.admmtd.model.ResourceModel;
import kr.happyjob.study.exmaex.model.AttendExamModel;




public interface  ExmAexDao {


	/**  목록 조회 */
	public List<AttendExamModel>attendtestlist(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countattendtestlist(Map<String, Object> paramMap) throws Exception;
	
	/** 시험 하나 조회 (응시) */
	public List<AttendExamModel>applytest(Map<String, Object> paramMap)throws Exception;
	
	/** 시험 결과 제출 (등록) */
	public int testsubmitsave(Map<String, Object> paramMap) throws Exception;
	
	/** 시험 결과 조회 */
	public List<AttendExamModel> testresult(Map<String, Object> paramMap) throws Exception;

	
	}






