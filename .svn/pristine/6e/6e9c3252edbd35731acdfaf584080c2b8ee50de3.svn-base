package kr.happyjob.study.admtbl.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.admtbl.dao.AdmtblDao;
import kr.happyjob.study.admtbl.model.RoomModel;
import kr.happyjob.study.admtbl.model.TimetableModel;


@Service
public class AdmtblServiceImpl implements AdmtblService{
	//주석주석삭제	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdmtblDao admtbldao;

	@Override
	public List<TimetableModel> timeList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return admtbldao.timeList(paramMap);
	}

	@Override
	public List<RoomModel> roomList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return admtbldao.roomList(paramMap);
	}
}
