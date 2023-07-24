package kr.happyjob.study.suplct.service;

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
import kr.happyjob.study.suplct.dao.SuplctDao;
import kr.happyjob.study.suplct.model.AttendeeStuModel;
import kr.happyjob.study.suplct.model.LectureModel;
import kr.happyjob.study.suplct.model.RoomModel;


@Service
public class SuplctServiceImpl implements SuplctService {


	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	SuplctDao suplctDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;    // W:\\FileRepository
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualrootPath;  // /serverfile
	
	@Value("${fileUpload.lecturePath}")
	private String lecturePath;   // lecture
	

	/*강사 강의 리스트 */
	public List<LectureModel> proflecturelist(Map<String, Object> paramMap) throws Exception {
		
		return suplctDao.proflecturelist(paramMap);
	}
	
	/*강사 목록 카운트 리스트 */
	public int cntproflecturelist(Map<String, Object> paramMap) throws Exception {
		
		return suplctDao.cntproflecturelist(paramMap);
	}
	
	/*학생 강의 리스트 */
	public List<LectureModel> stulecturelist(Map<String, Object> paramMap) throws Exception {
		
		return suplctDao.stulecturelist(paramMap);
	}
	/*학생 목록 카운트 리스트 */
	public int cntstulecturelist(Map<String, Object> paramMap) throws Exception {
		
		return suplctDao.cntstulecturelist(paramMap);
	}

	/*관리자 강의 리스트 */
	public List<LectureModel> maslecturelist(Map<String, Object> paramMap) throws Exception {
		
		return suplctDao.maslecturelist(paramMap);
	}
	
	/*관리자 목록 카운트 리스트 */
	public int cntlecturelist(Map<String, Object> paramMap) throws Exception {
		
		return suplctDao.cntlecturelist(paramMap);
	}
	
	
	/**[관리자] 수강 학생 목록 조회  */
	public List<AttendeeStuModel> attendeesearchlist(Map<String, Object> paramMap)throws Exception{
		return suplctDao.attendeesearchlist(paramMap);
	}
	
	/**[관리자] 수강 학생  목록 카운트 조회 */
	public int countattendeelist(Map<String, Object> paramMap) throws Exception {
				
		return suplctDao.countattendeelist(paramMap);
	}
	

	/**[관리자]강의  단건 조회 - 강의 관리 */
	
	public LectureModel lectureselectone(Map<String, Object> paramMap) throws Exception {

		return suplctDao.lectureselectone(paramMap);
	}
	
	
	/**[관리자]강의  등록 */
	public int lectureinsert(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
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
			
			suplctDao.fileinsert(paramMap);
		}
		
		logger.info("=============paramMap=========" + paramMap);
		return suplctDao.lectureinsert(paramMap);
	}
	
	/**[관리자]강의 수정 */
	public int lectureupdate(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		System.out.println("==========lectureupdate=======ServiceImpl========");
		LectureModel selectone = suplctDao.lectureselectone(paramMap);
		System.out.println("==========lectureupdate=======ServiceImpl========");
		if(selectone.getFile_name() !="" && selectone.getFile_name()!= null) {
			File attfile = new File(selectone.getFile_physic_path());     
			attfile.delete(); //실제 파일 삭제
		
			suplctDao.deletefileinfo(paramMap); 
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
			
			suplctDao.fileinsert(paramMap);
		}
		
		return suplctDao.lectureupdate(paramMap);
	}
	
	/**[관리자] 삭제 */
	public int lecturedelete(Map<String, Object> paramMap) throws Exception {
		LectureModel selectone = suplctDao.lectureselectone(paramMap);
		System.out.println("==========lectureDelete======="+selectone);
		if(selectone.getFile_name() != "" && selectone.getFile_name() != null) {
			File attfile = new File(selectone.getFile_physic_path());     
			attfile.delete(); //파일정보삭제.
			
			//notice_no			
			// tb_file delete
			suplctDao.deletefileinfo(paramMap);
			
		} 
		
	
		return suplctDao.lecturedelete(paramMap);
	}

	/*[공통] 바로 삭제  --- 실질적으로는 update임. lecDel_yn을 update해서 레코드 노출 안되도록 함.  */
	public int lecturedelete_dir(Map<String, Object> paramMap) throws Exception {
		
		return suplctDao.lecturedelete_dir(paramMap);
	}

	@Override
	public int checkSameTime(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return suplctDao.checkSameTime(paramMap);
	}

	@Override
	public int checkSameTimeUpdating(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return suplctDao.checkSameTimeUpdating(paramMap);
	}

	@Override
	public int checkSameTimetoEnroll(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return suplctDao.checkSameTimetoEnroll(paramMap);
	}

	

	/** [학생 ]강의 하나 선택시 - 상세계획서 노출 */	
	public LectureModel lectureDtselectone(Map<String, Object> paramMap) throws Exception {
		return suplctDao.lectureDtselectone(paramMap);
	}

	/**[관리자] 수강신청한 학생 승인 */
	@Override
	public int stulecSignInApproveUpdate(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return suplctDao.stulecSignInApproveUpdate(paramMap);
	}
	
   @Override
   public RoomModel findRoom(Map<String, Object> paramMap) throws Exception {
      // TODO Auto-generated method stub
      return suplctDao.findRoom(paramMap);
   }
   
   @Override
   public int stuCourseInsert(Map<String, Object> paramMap) throws Exception {
      // TODO Auto-generated method stub
      return suplctDao.stuCourseInsert(paramMap);
   }

   @Override
   public int checkReEnroll(Map<String, Object> paramMap) throws Exception {
      // TODO Auto-generated method stub
      return suplctDao.checkReEnroll(paramMap);
   }

   @Override
   public int stuCourseUpdate(Map<String, Object> paramMap) throws Exception {
      // TODO Auto-generated method stub
      return suplctDao.stuCourseUpdate(paramMap);
   }
   
 //주석
   
	
	
}
