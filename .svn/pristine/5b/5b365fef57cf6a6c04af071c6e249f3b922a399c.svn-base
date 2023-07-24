package kr.happyjob.study.admRmd.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admRmd.dao.AdmRmdDao;
import kr.happyjob.study.system.dao.ComnCodDao;
import kr.happyjob.study.admRmd.model.RoomModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Service
public class AdmRmdServiceImpl implements AdmRmdService {
	
	@Autowired
	private AdmRmdDao admRmdDao;
	
	@Autowired
	ComnCodDao comnCodDao;


	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
		private final String className = this.getClass().toString();


		/** 목록 조회 */
		public List<RoomModel> roomlist(Map<String, Object> paramMap) throws Exception {

			return admRmdDao.roomlist(paramMap);
		}

		/** 목록 카운트 조회 */
		public int countroomlist(Map<String, Object> paramMap) throws Exception {

			return admRmdDao.roomcountlist(paramMap);
		}
		
		/** 한건 조회 */
		 public RoomModel selectoneroom(Map<String, Object> paramMap) throws Exception{
			 return admRmdDao.selectoneroom(paramMap);
			 
		 }
		 
		
		
		/** 등록 */
		public int insertroom(Map<String, Object> paramMap) throws Exception {
			
			
			admRmdDao.insertroom(paramMap);
			
			/** 최대 key값 */
			//int max_num = admRmdDao.max_num(paramMap);
			 
			paramMap.put("dtl_grp_cod", "room_no");
			paramMap.put("dtl_cod", admRmdDao.max_num(paramMap) );
			//paramMap.put("dtl_cod", paramMap.get("room_no"));  //max+1 넣어주기 select max(room_no) from tb_room
			paramMap.put("dtl_cod_nm",  paramMap.get("rm_name"));
			paramMap.put("dtl_cod_eplti", "");
			paramMap.put("dtl_use_poa", "Y");
			paramMap.put("fst_rgst_sst_id",  paramMap.get("enr_user1"));  
			paramMap.put("fnl_mdfr_sst_id",  paramMap.get("enr_user1"));
			
			
			return comnCodDao.insertComnDtlCod(paramMap);
		}

		/** 수정 */
		public int updateroom(Map<String, Object> paramMap) throws Exception {
			
			paramMap.put("dtl_grp_cod", "room_no");
			paramMap.put("dtl_cod", paramMap.get("room_no"));  
			paramMap.put("dtl_cod_nm",  paramMap.get("rm_name"));
			paramMap.put("dtl_cod_eplti", "");
			paramMap.put("dtl_use_poa", "Y");
			paramMap.put("fst_rgst_sst_id",  paramMap.get("enr_user1"));  
			paramMap.put("fnl_mdfr_sst_id",  paramMap.get("enr_user1"));
			
			comnCodDao.updateComnDtlCod(paramMap);
			
			return admRmdDao.updateroom(paramMap);
			
		}

		public int deleteroom(Map<String, Object> paramMap) throws Exception {
			
			paramMap.put("dtl_grp_cod", "room_no");
			paramMap.put("dtl_cod", paramMap.get("room_no"));  
			
			comnCodDao.deleteComnDtlCod(paramMap);
			
			return admRmdDao.deleteroom(paramMap);
		}
		
		
		//** 물품 목록 조회 *//*
		public List<RoomModel> itemlist(Map<String, Object> paramMap)throws Exception{
			
			return admRmdDao.itemlist(paramMap);
		};
			   
		//** 물품 목록 카운트 조회 *//*
		public int itemcountlist(Map<String, Object> paramMap)throws Exception{
			return admRmdDao.itemcountlist(paramMap);
			
		};
		
		
		
		
		
		////////////////////////////////////////////////////////////////////////////////////////
		 /** optional lecview */
		public RoomModel usability(Map<String, Object> paramMap) throws Exception{
			return admRmdDao.usability(paramMap);
			
		}
		
		

}