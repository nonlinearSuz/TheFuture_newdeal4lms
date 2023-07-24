package kr.happyjob.study.system.service;

import kr.happyjob.study.system.dao.ComnComboDao;
import kr.happyjob.study.system.model.comcombo;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ComnComboServiceImpl implements ComnComboService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ComnComboDao comnComboDao;	
	

	
	/** 로그인 사용자 강의목록 조회 */
	public List<comcombo> selectlecbyuserlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectlecbyuserlist(paramMap);
		
		return list;
	}	

  /** 사용자  목록 조회 */
  public List<comcombo> selectuserlist(Map<String, Object> paramMap) throws Exception {
    
    List<comcombo> list = comnComboDao.selectuserlist(paramMap);
    
    return list;
  } 
  
  /** 시험  목록 조회 */
  public List<comcombo> selecttestlist(Map<String, Object> paramMap) throws Exception {
	  
	  List<comcombo> list = comnComboDao.selecttestlist(paramMap);
	    
	  return list;
	  
  }
  
  /** 설문  목록 조회 */
  public List<comcombo> selectsurveylist(Map<String, Object> paramMap) throws Exception {

	  List<comcombo> list = comnComboDao.selectsurveylist(paramMap);
	    
	  return list;
	  
  }

}
