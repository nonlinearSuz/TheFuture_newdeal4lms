package kr.happyjob.study.admstd.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.admhrd.model.TeacherModel;
import kr.happyjob.study.admstd.model.StudentModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface AdmStdService {

	/**  학생 목록 조회 */
	public List<StudentModel> studentlist(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 목록 카운트 조회*/
	public int countstudentlist(Map<String, Object> paramMap) throws Exception;

	/** 회원정보(비고) 수정 */
	public void userEtc(Map<String, Object> paramMap) throws Exception;
	
	/** 승인여부 */
	public void approval(String loginID) throws Exception;
	
	/** 탈퇴 */
	public void studentWithdrawal(String loginID) throws Exception;
	
	/** 한 건 조회*/
	public StudentModel studentselectone(Map<String, Object> paramMap) throws Exception;

	/** 한 건 조회 - 강의*/
	public List<StudentModel> studentselectonelec(Map<String, Object> paramMap) throws Exception;





	
	
/*	*//** 한건 조회 *//*
	public NoticeModel noticeselectone(Map<String, Object> paramMap) throws Exception;
	
	*//** 등록 *//*
	public int noticeinsert(Map<String, Object> paramMap) throws Exception;
	
	*//** 수정 *//*
	public int noticeupdate(Map<String, Object> paramMap) throws Exception;
	
	*//** 삭제 *//*
	public int noticedelete(Map<String, Object> paramMap) throws Exception;
	
	*//** 등록 파일 *//*
	public int noticeinsertfile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	*//** 수정 파일 *//*
	public int noticeupdatefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	*//** 삭제  파일*//*
	public int noticedeletefile(Map<String, Object> paramMap) throws Exception;
	
	*/
	
}
