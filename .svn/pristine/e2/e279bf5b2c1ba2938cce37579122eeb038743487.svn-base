package kr.happyjob.study.supmtb.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.happyjob.study.supmtb.dao.SupmtbDao;
import kr.happyjob.study.supmtb.model.MyTableModel;

@Service
public class SupmtbServiceImpl implements SupmtbService {

	// Set logger // 로그를 남기기 위해 logger 객체 생성. 현재 클래스의 logger를 가져옴
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger //현재 클래스의 이름을 가져와 문자열로 정렬
	private final String className = this.getClass().toString();
	
	// 의존성 주입을 위해 MngNotDao 인터페이스의 구현체를 자동으로 주입
	@Autowired
	SupmtbDao supmtbDao;

	@Override
	public List<MyTableModel> lecTimeList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return supmtbDao.lecTimeList(paramMap);
	}

}
