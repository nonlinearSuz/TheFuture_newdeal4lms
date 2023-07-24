package kr.happyjob.study.supmtr.service;

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

import kr.happyjob.study.supmtr.dao.SupmtrDao;
import kr.happyjob.study.supmtr.model.LectureModel;
import kr.happyjob.study.supmtr.model.StudyFileModel;

//주석!!
@Service
public class SupmtrServiceImpl implements SupmtrService{
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	SupmtrDao supmtrDao;
	
	//property값을 읽어오기위해서
	@Value("${fileUpload.rootPath}") //W:\\FileRepository
	private String rootPath;
	@Value("${fileUpload.virtualRootPath}") // /serverfile
	private String virtualrootPath;
	//@Value("${fileUpload.noticePath}") // notice
	//private String noticePath;
	@Value("${fileUpload.studyfilePath}")
	private String studyfilePath;
	
	
	@Override
	public List<LectureModel> selectBoxSet(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		logger.info("ServiceImpl의 paramMap = " + paramMap);
		
		return supmtrDao.selectBoxSet(paramMap);
	}

	@Override
	public List<LectureModel> selectBoxSetStudent(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return supmtrDao.selectBoxSetStudent(paramMap);
	}

	@Override
	public List<StudyFileModel> stufileList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return supmtrDao.stufileList(paramMap);
	}
	@Override
	public List<StudyFileModel> stufileListByStudent(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return supmtrDao.stufileListByStudent(paramMap);
	}

	@Override
	public int countStufileList(Map<String, Object> paramMap)  throws Exception{
		// TODO Auto-generated method stub
		return supmtrDao.countStufileList(paramMap);
	}

	@Override
	public int countStufileListByStudent(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return supmtrDao.countStufileListByStudent(paramMap);
	}
	@Override
	public StudyFileModel stufileSelectOne(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return supmtrDao.stufileSelectOne(paramMap);
	}

	@Override
	public int stufileInsertFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
	//common FileUtil.java 파일여러개 fileutilcho. 파일한개
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		//파일정보를 꺼낼수있는 상태
//		multipartHttpServletRequest.getFiles(name)
		
		//윈도우 \   리눅스 /  구분자가 다름..
		//
//		String noticedir = "\" + noticePath
		String studyfiledir = File.separator + studyfilePath + File.separator;
		FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualrootPath,studyfiledir );
		// 실제저장경로 rootFilePath + itemFilePath
		// W 드라이브 파일리포지토리 + notice라는 디렉토리
		// W:\FileRepository
		//resousrce happyjob.properiy
	
		//private String rootPath;   // W:\\FileRepository
		//private String virtualRootPath;   // /serverfile
		//private String noticePath; // notice
		
		
		Map fileReturn = fileup.uploadFiles();
//		리턴되는 값들
//        map.put("file_nm", file_nm);
//        map.put("file_size", file_Size);
//        map.put("file_loc", file_loc);
//        map.put("vrfile_loc", vrfile_loc);
//        map.put("fileExtension", fileExtension);
		//////////////////////파일처리 끝
		
		
		String upfile = (String) fileReturn.get("file_nm");
	//	paramMap.put("fileprc", "Y"); //파일처리하는것이다라고 알려줌
		
		if(upfile =="" || upfile == null){
			//첨부를 하지않은경우
			paramMap.put("fileexist", "N");
		}else{
			
			paramMap.put("fileexist", "Y");
			//DB처리
			paramMap.put("fileReturn", fileReturn);
			//map안에 map을 집어덤긴다.
			//#{fileReturn.file_nm}

			//
			
			supmtrDao.fileInsert(paramMap); //tb_file에 먼저 insert해야 그 번호가지고 notice에 파일일련번호를 넣는다.
		}
		
		
		
		
		
		return supmtrDao.stufileInsertFile(paramMap);
	}

	@Override
	public int stufileUpdateFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		System.out.println("==========stufileUpdateFile=======ServiceImpl========");
		System.out.println(paramMap);
		System.out.println("==========stufileUpdateFile=======ServiceImpl========");

			//{notice_title=, totalCnt=15, pageno=1, study_file_title=1234, leclist=, action=U, lecselect=1, study_file_no=10, study_file_cont=1234, lec_no=1, notice_cont=, empty=empty, loginId=teacher1005}
		//*****수정하는 경우 ***********//
				//같은 study_file_no번호 + lec_no임.
				
				//A파일삭제
				//한건조회  ->첨부가 됬니안됫니 따지고, 첨부o ->파일정보 날리고,
				StudyFileModel selectone = 	supmtrDao.stufileSelectOne(paramMap);
			//	NoticeModel selectone = mngNotDao.noticeSelectOne(paramMap);
				if(selectone.getFile_name() != "" && selectone.getFile_name() != null ){
					//첨부된경우
					//파일객체 생성
					File attFile = new File(selectone.getFile_physic_path()); //물리경로 들어가야함 (W디렉토리)
						//꺼내고나서 파일핸들링가능
					attFile.delete(); //실제파일날라감
					//파일정보삭제
					//tb_file delete -> file_no를 알아야한다.
					int file_no = selectone.getFile_no(); //이거는무엇?
					paramMap.put("file_no", file_no);
					
					//paramMap
					//notice_no (ajax call당시 param안에들어있음) 우리가 갖고있는건 notice_no
					//delete from tb_file where file_no = ( select file_no from tb_notice where = #{notice_no} )
					
					supmtrDao.deleteFileInfo(paramMap);					
				} 
				
				MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
				//파일정보를 꺼낼수있는 상태
//				multipartHttpServletRequest.getFiles(name)
				System.out.println("multipartHttpServletRequest = " +multipartHttpServletRequest);
				
				//윈도우 \   리눅스 /  구분자가 다름..
				//
//				String noticedir = "\" + noticePath
				String studyfiledir = File.separator + studyfilePath + File.separator;
				FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualrootPath,studyfiledir );
				// 실제저장경로 rootFilePath + itemFilePath
				// W 드라이브 파일리포지토리 + notice라는 디렉토리
				// W:\FileRepository
				//resousrce happyjob.properiy
			
				//private String rootPath;   // W:\\FileRepository
				//private String virtualRootPath;   // /serverfile
				//private String noticePath; // notice
				
				
				Map fileReturn = fileup.uploadFiles();
//				리턴되는 값들
//		        map.put("file_nm", file_nm);
//		        map.put("file_size", file_Size);
//		        map.put("file_loc", file_loc);
//		        map.put("vrfile_loc", vrfile_loc);
//		        map.put("fileExtension", fileExtension);
				//////////////////////파일처리 끝
				
				
				String upfile = (String) fileReturn.get("file_nm");
		
				
				if(upfile =="" || upfile == null){
					//첨부를 하지않은경우
					paramMap.put("fileexist", "N");
				}else{
					
					paramMap.put("fileexist", "Y");
					//DB처리
					paramMap.put("fileReturn", fileReturn);
					//map안에 map을 집어덤긴다.
					//#{fileReturn.file_nm}

					//
					
					supmtrDao.fileInsert(paramMap); //tb_file에 먼저 insert해야 그 번호가지고 notice에 파일일련번호를 넣는다.
				}
		return supmtrDao.stufileUpdateFile(paramMap);
	}

	@Override
	public int stufileDeleteFile(Map<String, Object> paramMap) throws Exception {
		System.out.println("==========stufileDeleteFile=======ServiceImpl========");
		System.out.println(paramMap);
		System.out.println("==========stufileDeleteFile=======ServiceImpl========");
		//A파일삭제
		//한건조회  ->첨부가 됬니안됫니 따지고, 첨부o ->파일정보 날리고,
		StudyFileModel selectone = 	supmtrDao.stufileSelectOne(paramMap);
	//	NoticeModel selectone = mngNotDao.noticeSelectOne(paramMap);
		if(selectone.getFile_name() != "" && selectone.getFile_name() != null ){
			//첨부된경우
			//파일객체 생성
			File attFile = new File(selectone.getFile_physic_path()); //물리경로 들어가야함 (W디렉토리)
				//꺼내고나서 파일핸들링가능
			attFile.delete(); //실제파일날라감
			//파일정보삭제
			//tb_file delete -> file_no를 알아야한다.
			int file_no = selectone.getFile_no(); //이거는무엇?
			paramMap.put("file_no", file_no);
			
			//paramMap
			//notice_no (ajax call당시 param안에들어있음) 우리가 갖고있는건 notice_no
			//delete from tb_file where file_no = ( select file_no from tb_notice where = #{notice_no} )
			
			supmtrDao.deleteFileInfo(paramMap);					
		} 
		return supmtrDao.stufileDeleteFile(paramMap);
	}





}
