package kr.happyjob.study.supsvy.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.supsvy.dao.SupsvyDao;
import kr.happyjob.study.supsvy.model.SurveyModel;

/*커밋 용 임시 주석*/

@Service
public class SupsvyServiceImpl implements SupsvyService {

	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	SupsvyDao supsvyDao;
	
	
	/*[관리자] 강사 리스트  */
	public List<SurveyModel> totProfList(Map<String, Object> paramMap)throws Exception {
		return supsvyDao.totProfList(paramMap);
	}
	
	/*[관리자] 강사 리스트 카운트 */
	public int cntProfList(Map<String, Object> paramMap) throws Exception {

		return supsvyDao.cntProfList(paramMap);
	}
	
	

	/*[관리자] 설문조사 대상 전체 강의 리스트 -- 강의 개설 승인 받은 강의 */
	public List<SurveyModel> totLecList(Map<String, Object> paramMap) throws Exception {
		
		return supsvyDao.totLecList(paramMap);
	}

	/*[관리자] 설문조사 대상 전체 강의 리스트 카운트   */
	public int cntLecList(Map<String, Object> paramMap) throws Exception {
		
		return supsvyDao.cntLecList(paramMap);
	}

	/*[학생] 설문조사 대상 전체 강의 리스트 -- 자신이 신청한 강의  */
	public List<SurveyModel> stusurveyLecList(Map<String, Object> paramMap) throws Exception {
		
		return supsvyDao.stusurveyLecList(paramMap);
	}

	/*[학생] 설문조사 대상 전체 강의 리스트  카운트  */
	public int cntStusurveyLecList(Map<String, Object> paramMap) throws Exception {
		
		return supsvyDao.cntStusurveyLecList(paramMap);
	}

	
	public SurveyModel lecDtInfo(Map<String, Object> paramMap) throws Exception {

		return supsvyDao.lecDtInfo(paramMap);
	}

	/* 설문조사 리스트 */
	public List<SurveyModel> svyQList(Map<String, Object> paramMap) throws Exception {
		
		return supsvyDao.svyQList(paramMap);
	}

	/* 설문조사 리스트 카운트 */
	public int cntSvyQList(Map<String, Object> paramMap)throws Exception {
		
		return supsvyDao.cntSvyQList(paramMap);
	};

	/* 설문조사 답변 예시(오지선다)  set 를 만들 모델  */
	public List<SurveyModel> svyQsetExList(Map<String, Object> paramMap ) throws Exception {
		
		return supsvyDao.svyQsetExList(paramMap);
	}

	/* 학생의 설문 제출 */
	public int surveySubmit(Map<String, Object> paramMap) throws Exception {
		
		return supsvyDao.surveySubmit(paramMap);
	}


	/* 설문조사 차트 데이터 조회 */
	   public List<SurveyModel> surveyChartModel(Map<String, Object> paramMap) throws Exception {
	      return supsvyDao.surveyChartModel(paramMap);
	   }
	
	   /* 설문조사 문항 목록 조회 */
	   public List<SurveyModel> exContentList() throws Exception {
	      return supsvyDao.exContentList();
	   };


}
