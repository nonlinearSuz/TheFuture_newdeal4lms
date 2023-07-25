package kr.happyjob.study.exmrex.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.exmrex.model.GradeModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface ExmRexService {

	/**  목록 조회 */
	public List<GradeModel> gradelist(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countgradelist(Map<String, Object> paramMap) throws Exception;
	
	/** 한건 조회 */
	public List<GradeModel> gradeselectonelec(Map<String, Object> paramMap) throws Exception;

	/** 한건 카운트 조회 */
	public int countgradeleclist(Map<String, Object> paramMap) throws Exception;
	
	/** 검색용 강의 목록 */
	public List<GradeModel> getLectureList(Map<String, Object> paramMap) throws Exception;
	
}
