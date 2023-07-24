package kr.happyjob.study.supsvy.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.supsvy.model.SurveyModel;

/*커밋 용 임시 주석*/

public interface SupsvyService {

	/*[관리자] 강사 리스트  */
	public List<SurveyModel> totProfList(Map<String, Object> paramMap)throws Exception;
	
	/*[관리자] 강사 리스트 카운트 */
	public int cntProfList(Map<String, Object> paramMap)throws Exception;
	
	
	/*[관리자] 설문조사 대상 전체 강의 리스트 -- 강의 개설 승인 받은 강의 */
	public List<SurveyModel> totLecList(Map<String, Object> paramMap)throws Exception;

	/*[관리자] 설문조사 대상 전체 강의 리스트 카운트   */	
	public int cntLecList(Map<String, Object> paramMap)throws Exception ;

	

	/*[학생] 설문조사 대상 전체 강의 리스트 -- 자신이 신청한 강의  */
	public List<SurveyModel> stusurveyLecList(Map<String, Object> paramMap) throws Exception;

	/*[학생] 설문조사 대상 전체 강의 리스트  카운트  */
	public int cntStusurveyLecList(Map<String, Object> paramMap) throws Exception;

	/*[학생] 신청한 강의 상세 정보*/
	public SurveyModel lecDtInfo(Map<String, Object> paramMap)throws Exception;

	
	/* 설문조사  리스트 */
	public List<SurveyModel> svyQList(Map<String, Object> paramMap) throws Exception;

	/* 설문조사 리스트 카운트 */
	public int cntSvyQList(Map<String, Object> paramMap ) throws Exception;

	/* 설문조사 답변 예시(오지선다)  set 를 만들 모델  */
	public List<SurveyModel> svyQsetExList(Map<String, Object> paramMap ) throws Exception;

	/* 설문지 제출 */
	public int surveySubmit(Map<String, Object> paramMap) throws Exception;
	

	
	/* 설문조사 차트 데이터 조회 */
	   public List<SurveyModel> surveyChartModel(Map<String, Object> paramMap) throws Exception;
	
	   /* 설문조사 문항 목록 조회 */
	   public List<SurveyModel> exContentList() throws Exception;
	
}
