package kr.happyjob.study.supMya.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.supMya.dao.SupMyaDao;
import kr.happyjob.study.supMya.model.EnrollModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Service
public class SupMyaServiceImpl implements SupMyaService {

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   SupMyaDao supMyaDao;
   
   /** 그룹코드 목록 조회 */
   public List<EnrollModel> myLecturelist(Map<String, Object> paramMap) throws Exception {
      
      return supMyaDao.myLecturelist(paramMap);
   }
   
   /** 목록 카운트 조회 */
	public int countmyLecturelist(Map<String, Object> paramMap) throws Exception {

		return supMyaDao.countmyLecturelist(paramMap);
	}
   
	/** 취소 */
	public int cancelmylecture(Map<String, Object> paramMap) throws Exception{
		
		return supMyaDao.cancelmylecture(paramMap);
				
	}
	
	/** 취소 */
	public int applymylecture(Map<String, Object> paramMap) throws Exception{
		
		return supMyaDao.applymylecture(paramMap);
				
	}

}