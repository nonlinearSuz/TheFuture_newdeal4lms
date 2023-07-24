package kr.happyjob.study.exmaex.service;

import java.util.List;
import java.util.Map;


import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import kr.happyjob.study.exmaex.dao.ExmAexDao;
import kr.happyjob.study.exmaex.model.AttendExamModel;





@Service
public class ExmAexServiceImpl implements ExmAexService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ExmAexDao exmAexDao;
	
	/**  목록 조회 */
	public List<AttendExamModel> attendtestlist(Map<String, Object> paramMap) throws Exception{
		
		return exmAexDao.attendtestlist(paramMap);
	}
	
	/** 목록 카운트 조회 */
	public int countattendtestlist(Map<String, Object> paramMap) throws Exception{
		
		return exmAexDao.countattendtestlist(paramMap);
	}
	
	
	/** 시험 하나 조회 (응시) */
	public List<AttendExamModel>applytest(Map<String, Object> paramMap)throws Exception{
		
		return exmAexDao.applytest(paramMap);
	}
	
	/** 시험 결과 제출 (등록) */
	public int testsubmitsave(Map<String, Object> paramMap) throws Exception{
		
		return exmAexDao.testsubmitsave(paramMap);
	}
		
	

	/** 시험 결과 조회 */
	public List<AttendExamModel> testresult(Map<String, Object> paramMap) throws Exception {
		return exmAexDao.testresult(paramMap);
	}

}







