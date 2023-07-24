package kr.happyjob.study.exmrex.service;

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

import kr.happyjob.study.exmrex.dao.ExmRexDao;
import kr.happyjob.study.exmrex.model.GradeModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;


@Service
public class ExmRexServiceImpl implements ExmRexService {

	// Set logger // 로그를 남기기 위해 logger 객체 생성. 현재 클래스의 logger를 가져옴
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger //현재 클래스의 이름을 가져와 문자열로 정렬
	private final String className = this.getClass().toString();
	
	// 의존성 주입을 위해 MngNotDao 인터페이스의 구현체를 자동으로 주입
	@Autowired
	ExmRexDao exmRexDao;
	
	/** 목록 조회 */
	public List<GradeModel> gradelist(Map<String, Object> paramMap) throws Exception {
		return exmRexDao.gradelist(paramMap);
	}
	
	/** 목록 카운트 조회 */
	public int countgradelist(Map<String, Object> paramMap) throws Exception {
		return exmRexDao.countgradelist(paramMap);
	}
	
	/* 한건 조회 강의 */
	public List<GradeModel> gradeselectonelec(Map<String, Object> paramMap) throws Exception {
		return exmRexDao.gradeselectonelec(paramMap);
	}
	
	/** 목록 카운트 조회 */
	public int countgradeleclist(Map<String, Object> paramMap) throws Exception {
		return exmRexDao.countgradeleclist(paramMap);
	}

	/** 검색용 강의 목록 */
	public List<GradeModel> getLectureList(Map<String, Object> paramMap) throws Exception {
	       return exmRexDao.getLectureList(paramMap);
	   }

}
