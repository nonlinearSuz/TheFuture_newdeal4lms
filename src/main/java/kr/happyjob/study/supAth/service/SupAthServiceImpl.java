package kr.happyjob.study.supAth.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.supAth.dao.SupAthDao;
import kr.happyjob.study.supAth.model.ApproveModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Service
public class SupAthServiceImpl implements SupAthService {

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   SupAthDao supAthDao;
   
   /** 그룹코드 목록 조회 */
   public List<ApproveModel> approvalist(Map<String, Object> paramMap) throws Exception {
	   
	   return supAthDao.approvalist(paramMap);
	   
   }
   
   /** 목록 카운트 조회 */
	public int countapprovalist(Map<String, Object> paramMap) throws Exception {

		return supAthDao.countapprovalist(paramMap);
	}
 
	
	/** 승인 및 반려  */
	public int approvelecture(Map<String, Object> paramMap) throws Exception{
		
		return supAthDao.approvelecture(paramMap);
	}

	/** 강의 목록 */
	public List<ApproveModel> leclist(Map<String, Object> paramMap)throws Exception{
		
		return supAthDao.leclist(paramMap);
		
	}


}