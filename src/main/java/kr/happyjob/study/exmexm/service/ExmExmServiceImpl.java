package kr.happyjob.study.exmexm.service;

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

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.exmexm.dao.ExmExmDao;
import kr.happyjob.study.exmexm.model.ExamManageModel;



@Service
public class ExmExmServiceImpl implements ExmExmService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ExmExmDao exmExmDao;
	

		
	
	/** 목록 조회 */
	public List<ExamManageModel>examlist(Map<String, Object> paramMap) throws Exception {
		
		return exmExmDao.examlist(paramMap);
	}
	
	/** 목록 카운트 조회 */
	public int countexamlist(Map<String, Object> paramMap) throws Exception {
				
		return exmExmDao.countexamlist(paramMap);
	}
	
	/** 한건 조회 */
	public ExamManageModel examselectone(Map<String, Object> paramMap) throws Exception {
		
		return exmExmDao.examselectone(paramMap);
	}
	
	public ExamManageModel examQselectone(Map<String, Object> paramMap) throws Exception {
		return exmExmDao.examselectone(paramMap);
	}
	
	/** 등록 */
	public int examinsert(Map<String, Object> paramMap) throws Exception {

		return exmExmDao.examinsert(paramMap);
	}
	
	/** 수정 */
	public int examupdate(Map<String, Object> paramMap) throws Exception {

		return exmExmDao.examupdate(paramMap);
	}
	
	/** 삭제 */
	public int examdelete(Map<String, Object> paramMap) throws Exception {
		return exmExmDao.examdelete(paramMap);
	}
	
	  /** 강사의 강의목록*/ 
		public int leclist(Map<String, Object> paramMap) throws Exception{
			
			return exmExmDao.leclist(paramMap);
		}
		
		/**  상세 목록 조회 */
		public List<ExamManageModel> examdetail(Map<String, Object> paramMap) throws Exception{
			return exmExmDao.examdetail(paramMap);
		}



		
		/** 하나의 시험 상세 조회 */
		public ExamManageModel examdetailone(Map<String, Object> paramMap) throws Exception{
			return exmExmDao.examdetailone(paramMap);	
			
		}
		
		/** 문항 목록 카운트 조회 */
		public int countquelist(Map<String, Object> paramMap) throws Exception{
			return exmExmDao.countquelist(paramMap);	
		}
		
		/** 문항 등록 */
		public int queinsert(Map<String, Object> paramMap) throws Exception{
			return exmExmDao.queinsert(paramMap);	 
		}
		
		/** 문항  수정 */
		public int queupdate(Map<String, Object> paramMap) throws Exception{
			return exmExmDao.queupdate(paramMap);	 
		}
		
		/** 문항  삭제 */
		public int quedelete(Map<String, Object> paramMap) throws Exception{
			return exmExmDao.quedelete(paramMap);	 
		}
		
			
}
