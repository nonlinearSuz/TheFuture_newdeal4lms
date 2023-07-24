package kr.happyjob.study.admstd.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.admstd.dao.AdmStdDao;
import kr.happyjob.study.admstd.model.StudentModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.system.model.ComnDtlCodModel;


@Service
public class AdmStdServiceImpl implements AdmStdService {

	// Set logger // 로그를 남기기 위해 logger 객체 생성. 현재 클래스의 logger를 가져옴
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger //현재 클래스의 이름을 가져와 문자열로 정렬
	private final String className = this.getClass().toString();
	
	// 의존성 주입을 위해 MngNotDao 인터페이스의 구현체를 자동으로 주입
	@Autowired
	AdmStdDao admStdDao;
	
	/** 학생 목록 조회 */
	public List<StudentModel> studentlist(Map<String, Object> paramMap) throws Exception {
		return admStdDao.studentlist(paramMap);
	}
	
	/** 학생 목록 카운트 조회 */
	public int countstudentlist(Map<String, Object> paramMap) throws Exception {
		return admStdDao.countstudentlist(paramMap);
	}

	/** 회원정보(비고) 수정 */
	public void userEtc(Map<String, Object> paramMap) throws Exception {
		admStdDao.userEtc(paramMap);
	}
	
	/** 승인여부 */
	public void approval(String loginID) throws Exception {
		admStdDao.approval(loginID);
	}	

	/** 탈퇴 */
	public void studentWithdrawal(String loginID)  throws Exception {
		admStdDao.studentWithdrawal(loginID);
	}
	
	/** 한 건 조회 */
	public StudentModel studentselectone(Map<String, Object> paramMap) throws Exception {
		return admStdDao.studentselectone(paramMap);
	}
	
	/** 한 건 조회 강의*/
	public List<StudentModel> studentselectonelec(Map<String, Object> paramMap) throws Exception {
		return admStdDao.studentselectonelec(paramMap);
	}
}
