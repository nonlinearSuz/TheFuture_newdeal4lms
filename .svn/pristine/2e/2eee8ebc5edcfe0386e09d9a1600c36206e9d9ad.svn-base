package kr.happyjob.study.supntc.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.supntc.dao.SupNtcDao;
import kr.happyjob.study.supntc.model.NoticeModel;

@Service
public class SupNtcServiceImpl implements SupNtcService {
	
	//logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private final String className = this.getClass().toString();
	
	@Autowired
	SupNtcDao supNtcDao;
	
	/** 목록 조회 */
	public List<NoticeModel> noticelist(Map<String, Object> paramMap) throws Exception {
		
		return supNtcDao.noticelist(paramMap);
	}
	
	/** 목록 카운트 조회 */
	public int countnoticelist(Map<String, Object> paramMap) throws Exception {
		
		return supNtcDao.countnoticelist(paramMap);
	}

	
	/** 한건 조회 */
	public NoticeModel noticeselectone (Map<String, Object> paramMap) throws Exception {
		
		return supNtcDao.noticeselectone(paramMap);
	}

	/** 글 등록 */
	public int insert (Map<String, Object> paramMap) throws Exception {
		
		return supNtcDao.insert(paramMap);
	}
	
	/** 수정 */
	public int update (Map<String, Object> paramMap) throws Exception {
		
		paramMap.put("fileprc", "N");
		return supNtcDao.update(paramMap);
	}
	
	/** 삭제 */
	public int delete (Map<String, Object> paramMap) throws Exception {
		
		return supNtcDao.delete(paramMap); 
	}
	
	/* 조회수 증가 */
	@Override
	public int updateViewCnt(int nt_no) throws Exception {
		return supNtcDao.updateViewCnt(nt_no);
	}
	

}	