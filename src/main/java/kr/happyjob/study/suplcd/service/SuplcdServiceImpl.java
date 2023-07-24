package kr.happyjob.study.suplcd.service;

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
import kr.happyjob.study.suplcd.dao.SuplcdDao;
import kr.happyjob.study.suplcd.model.LectureDtPlanModel;



@Service
public class SuplcdServiceImpl implements SuplcdService {

	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	SuplcdDao suplcdDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;    // W:\\FileRepository
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualrootPath;  // /serverfile
	
	@Value("${fileUpload.lecturePath}")
	private String lecturePath;   // lecture
	
	
	
	/** 강의 목록  조회 */
	public List<LectureDtPlanModel> totalLecPlanList(Map<String, Object> paramMap) throws Exception {
		
		return suplcdDao.totalLecPlanList(paramMap);
	};
	

	/** 강의 목록 카운트 조회 */
	public int cntLecPlanList(Map<String, Object> paramMap)throws Exception {
		return suplcdDao.cntLecPlanList(paramMap);
	}


	/**[강사] 강의 목록 조회 */
	public List<LectureDtPlanModel> profLecPlanList(Map<String, Object> paramMap) throws Exception {
		return suplcdDao.profLecPlanList(paramMap);
	}


	/**[강사] 강의 목록 카운트 조회 */
	public int cntProfLecPlanList(Map<String, Object> paramMap) throws Exception {
		return suplcdDao.cntProfLecPlanList(paramMap);
	}


	/** [관리자] 강의 승인  */
	public int lecApprovUpdate(Map<String, Object> paramMap) throws Exception {
		return suplcdDao.lecApprovUpdate(paramMap);
	}


	/*[관리자] 강의 상세계획서 열람 */
	public LectureDtPlanModel lectureDtselectone(Map<String, Object> paramMap) throws Exception {
		
		return suplcdDao.lectureDtselectone(paramMap);
	}


	
	/*강의 상세계획서 수정 */
	@Override
	public int lectureDtUpdate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		System.out.println("==========lectureDtupdate=======ServiceImpl========");
		LectureDtPlanModel selectone =  suplcdDao.lectureDtselectone(paramMap);
		System.out.println("==========lectureDtupdate=======ServiceImpl========");
		if(selectone.getFile_name() !="" && selectone.getFile_name()!= null) {
			File attfile = new File(selectone.getFile_physic_path());     
			attfile.delete(); //실제 파일 삭제
		
			suplcdDao.deletefileinfo(paramMap);  //??
		}	
	
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		String lecturedir = File.separator + lecturePath + File.separator;
		FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest,rootPath, virtualrootPath, lecturedir);
		Map filereturn = fileup.uploadFiles();
				
		String upfile = (String) filereturn.get("file_nm");
		
		if(upfile == "" || upfile == null){
			paramMap.put("fileexist", "N");
		}else {
			paramMap.put("filereturn", filereturn);
			paramMap.put("fileexist","Y");
			
			suplcdDao.fileinsert(paramMap);
		}
		
		return suplcdDao.lectureDtUpdate(paramMap);
	}

	/*강의 상세계획서 입력*/
	@Override
	public int lectureDtInsert(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		return suplcdDao.lectureDtInsert(paramMap);
	}

	/* 강의 상세계획서 삭제  */
	@Override
	public int lectureDtDelete(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return suplcdDao.lectureDtDelete(paramMap);
	}



	

	
}
