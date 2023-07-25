package kr.happyjob.study.cmmntc.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cmmntc.dao.CmmNtcDao;
import kr.happyjob.study.cmmntc.model.NoticeModel;
import kr.happyjob.study.cmmntc.model.NoticeReply;

@Service
public class CmmNtcServiceImpl implements CmmNtcService {
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private final String className = this.getClass().toString();
	
	@Autowired
	CmmNtcDao cmmNtcDao;
	
	public List<NoticeModel> noticelist(Map<String, Object> paramMap) throws Exception {
		
		return cmmNtcDao.noticelist(paramMap);
	}
	
	public int countnoticelist(Map<String, Object> paramMap) throws Exception {
		return cmmNtcDao.countnoticelist(paramMap);
	}
	
	public NoticeModel noticeselectone(Map<String, Object> paramMap) throws Exception {
		return cmmNtcDao.noticeselectone(paramMap);
	}
	
	/** 글 등록 */
	public int insert (Map<String, Object> paramMap) throws Exception {
		
		return cmmNtcDao.insert(paramMap);
	}
	
	/** 수정 */
	public int update (Map<String, Object> paramMap) throws Exception {
		
		return cmmNtcDao.update(paramMap);
	}
	
	/** 삭제 */
	public int delete (Map<String, Object> paramMap) throws Exception {
		
		return cmmNtcDao.delete(paramMap); 
	}
	
	/* 조회수 증가 */
	@Override
	public int updateViewCnt(int nt_no) throws Exception {
		return cmmNtcDao.updateViewCnt(nt_no);
	}
	
	//댓글
	public List<NoticeReply> noticeReply(int nt_no) throws Exception {
		
		return cmmNtcDao.noticeReply(nt_no);
	}
	
	public int insertRp(Map<String, Object> paramMap) throws Exception {
		
		return cmmNtcDao.insertRp(paramMap);
	}
	
	public int updateRp(Map<String, Object> paramMap) throws Exception {
		
		return cmmNtcDao.updateRp(paramMap);
	}
	
	public int deleteRp(Map<String, Object> paramMap) throws Exception {
		
		return cmmNtcDao.deleteRp(paramMap);
	}
}