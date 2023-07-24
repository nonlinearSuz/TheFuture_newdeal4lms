package kr.happyjob.study.admstd.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.admhrd.model.TeacherModel;
import kr.happyjob.study.admstd.model.StudentModel;

public interface AdmStdDao {

	/**  목록 조회 */
	public List<StudentModel> studentlist(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countstudentlist(Map<String, Object> paramMap) throws Exception;
	
	/** 한 건 조회 */
	public StudentModel studentselectone(Map<String, Object> paramMap) throws Exception;
	
	/** 한건 조회 강의 */
	public List<StudentModel> studentselectonelec(Map<String, Object> paramMap) throws Exception;
	
	/** 회원정보(비고) 수정 */
	public void userEtc(Map<String, Object> paramMap) throws Exception;
	
	/** 승인여부 */
	public void approval(String loginID) throws Exception;
	
	/** 학생 회원탈퇴 */
	public void studentWithdrawal(String loginID) throws Exception;
}
