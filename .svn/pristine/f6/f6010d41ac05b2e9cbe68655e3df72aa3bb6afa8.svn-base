package kr.happyjob.study.admmtd.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;


import kr.happyjob.study.admmtd.dao.AdmMtdDao;
import kr.happyjob.study.admmtd.model.ResourceModel;





@Service
public class AdmMtdServiceImpl implements AdmMtdService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdmMtdDao admMtdDao;
	

	/** 목록 조회 */
	public List<ResourceModel>resourcelist(Map<String, Object> paramMap) throws Exception {
		
		return admMtdDao.resourcelist(paramMap);
	}
	
	/** 목록 카운트 조회 */
	public int countresourcelist(Map<String, Object> paramMap) throws Exception {
				
		return admMtdDao.countresourcelist(paramMap);
	}
	

	
	/** 한건 조회 */
	public ResourceModel resourceselectone(Map<String, Object> paramMap) throws Exception {
		
		return admMtdDao.resourceselectone(paramMap);
	}
	
	/** 등록 */
	public int iteminsert(Map<String, Object> paramMap) throws Exception {

		return admMtdDao.iteminsert(paramMap);
	}
	
	/** 수정 */
	public int itemupdate(Map<String, Object> paramMap) throws Exception {

		return admMtdDao.itemupdate(paramMap);
	}
	
	/** 삭제 */
	public int itemdelete(Map<String, Object> paramMap) throws Exception {
		
		return admMtdDao.itemdelete(paramMap);
	}


	
	}



	
	

