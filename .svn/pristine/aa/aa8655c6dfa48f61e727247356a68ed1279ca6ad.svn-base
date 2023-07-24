package kr.happyjob.study.supntc.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.supntc.model.NoticeModel;

public interface SupNtcDao {

	/** 목록 조회 */
	public List<NoticeModel> noticelist(Map<String, Object> paramMap) throws Exception; 
	
	/** 목록 카운트 조회*/
	public int countnoticelist(Map<String, Object> paramMap) throws Exception; 

	/** 하나 조회 */
	public NoticeModel noticeselectone(Map<String, Object> paramMap) throws Exception;
	
	/* 글 등록 */
	public int insert(Map<String, Object> paramMap) throws Exception;
	
	/* 글 수정 */
	public int update(Map<String, Object> paramMap) throws Exception;
	
	/* 글 삭제 */
	public int delete(Map<String, Object> paramMap) throws Exception;
	
	/* 조회수 증가 */
	public int updateViewCnt(int nt_no) throws Exception;
	
}
