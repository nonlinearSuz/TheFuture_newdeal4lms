package kr.happyjob.study.admRmd.service;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.happyjob.study.admRmd.model.RoomModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
@Service public interface AdmRmdService {

  //** 목록 조회 *//*
   public List<RoomModel> roomlist(Map<String, Object> paramMap) throws Exception;
   
   //** 그룹코드 목록 카운트 조회 *//*
   public int countroomlist(Map<String, Object> paramMap) throws Exception;
   
   /** 한건 조회 */
   public RoomModel selectoneroom(Map<String, Object> paramMap) throws Exception;
   
  	
	/** 등록 */
	public int insertroom(Map<String, Object> paramMap) throws Exception;
	
	/** 수정 */
	public int updateroom(Map<String, Object> paramMap) throws Exception;
	
	/** 삭제 */
	public int deleteroom(Map<String, Object> paramMap) throws Exception;
   
	
	//** 물품 목록 조회 *//*
	public List<RoomModel> itemlist(Map<String, Object> paramMap)throws Exception;
		   
	//** 물품 목록 카운트 조회 *//*
	public int itemcountlist(Map<String, Object> paramMap)throws Exception;
	
	
	
	
	/** optional lecview */
	public RoomModel usability(Map<String, Object> paramMap) throws Exception;
	
}
	