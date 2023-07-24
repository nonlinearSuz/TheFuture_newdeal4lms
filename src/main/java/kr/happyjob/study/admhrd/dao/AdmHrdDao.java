package kr.happyjob.study.admhrd.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.admhrd.model.TeacherModel;

public interface AdmHrdDao {

	/**  목록 조회 */
	public List<TeacherModel> teacherlist(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countteacherlist(Map<String, Object> paramMap) throws Exception;

	/** 한건 조회 */
	public TeacherModel teacherselectone(Map<String, Object> paramMap) throws Exception;

	/** 한건 조회 강의 */
	public List<TeacherModel> teacherselectonelec(Map<String, Object> paramMap) throws Exception;
	
	/** 회원정보(비고) 수정 */
	public void userEtc(Map<String, Object> paramMap) throws Exception;
	
	/** 승인여부 */
	public void approval(String loginID) throws Exception;
	
	/** 강사 회원탈퇴 */
	public void teacherWithdrawal(String loginID) throws Exception;
	
}
