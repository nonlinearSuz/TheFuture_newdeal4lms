package kr.happyjob.study.exmrex.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.exmrex.model.GradeModel;

public interface ExmRexDao {

	/**  목록 조회 */
	public List<GradeModel> gradelist(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countgradelist(Map<String, Object> paramMap) throws Exception;

	/** 한건 조회 강의 */
	public List<GradeModel> gradeselectonelec(Map<String, Object> paramMap) throws Exception;

	/** 한건 카운트 조회 */
	public int countgradeleclist(Map<String, Object> paramMap) throws Exception;
	
	/** 검색용 강의 목록 */
	public List<GradeModel> getLectureList(Map<String, Object> paramMap) throws Exception;

	


	



	

	
	/*
	*//** 등록 *//*
	public int noticeinsert(Map<String, Object> paramMap) throws Exception;
	
	*//** 수정 *//*
	public int noticeupdate(Map<String, Object> paramMap) throws Exception;
	
	*//** 삭제 *//*
	public int noticedelete(Map<String, Object> paramMap) throws Exception;
	
	*//** 등록 파일 *//*
	public int noticeinsertfile(Map<String, Object> paramMap) throws Exception;
	
	*//** 수정 파일 *//*
	public int noticeupdatefile(Map<String, Object> paramMap) throws Exception;
	
	*//** 삭제  파일*//*
	public int noticedeletefile(Map<String, Object> paramMap) throws Exception;
	
	*//** 파일 등록 *//*
	public int fileinsert(Map<String, Object> paramMap) throws Exception;
	
	*//** 파일 정보 삭제 *//*
	public int deletefileinfo(Map<String, Object> paramMap) throws Exception;
	
	*/
}
