package kr.happyjob.study.cmmntc.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmmntc.model.NoticeModel;
import kr.happyjob.study.cmmntc.model.NoticeReply;

public interface CmmNtcService {
	
	public List<NoticeModel> noticelist(Map<String, Object> paramMap) throws Exception;
	
	public int countnoticelist(Map<String, Object> paramMap) throws Exception;
	
	public NoticeModel noticeselectone(Map<String, Object> paramMap) throws Exception;
	
	/** 글 등록 */
	public int insert(Map<String, Object> paramMap) throws Exception;
	
	/** 글 수정 */
	public int update(Map<String, Object> paramMap) throws Exception;
	
	/** 글 삭제 */
	public int delete(Map<String, Object> paramMap) throws Exception;
	
	/** 조회수 증가 */
	public int updateViewCnt(int nt_no) throws Exception;
	
	//댓글
	public List<NoticeReply> noticeReply(int nt_no) throws Exception;
	
	public int insertRp(Map<String, Object> paramMap) throws Exception;
	
	public int updateRp(Map<String, Object> paramMap) throws Exception;
	
	public int deleteRp(Map<String, Object> paramMap) throws Exception;
	
}