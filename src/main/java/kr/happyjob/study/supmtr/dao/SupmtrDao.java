package kr.happyjob.study.supmtr.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.supmtr.model.LectureModel;
import kr.happyjob.study.supmtr.model.StudyFileModel;

public interface SupmtrDao {

	   //주석!!
	List<LectureModel> selectBoxSet(Map<String, Object> paramMap) throws Exception;
	
	List<LectureModel> selectBoxSetStudent(Map<String, Object> paramMap) throws Exception;
	
	List<StudyFileModel> stufileList(Map<String, Object> paramMap) throws Exception;
	List<StudyFileModel> stufileListByStudent(Map<String, Object> paramMap) throws Exception;
	
	int countStufileList(Map<String, Object> paramMap) throws Exception;
	int countStufileListByStudent(Map<String, Object> paramMap)throws Exception;
	StudyFileModel stufileSelectOne(Map<String, Object> paramMap) throws Exception;
	
	int stufileInsertFile(Map<String, Object> paramMap) throws Exception;

	int stufileUpdateFile(Map<String, Object> paramMap) throws Exception;

	int stufileDeleteFile(Map<String, Object> paramMap) throws Exception;
	
	
	//파일 등록
	public int fileInsert(Map<String, Object> paramMap) throws Exception;
	
	//파일정보삭제
	public void deleteFileInfo(Map<String, Object> paramMap);
}
