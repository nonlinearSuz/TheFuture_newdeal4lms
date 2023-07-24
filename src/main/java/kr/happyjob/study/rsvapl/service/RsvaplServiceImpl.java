package kr.happyjob.study.rsvapl.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.rsvapl.dao.RsvaplDao;

import kr.happyjob.study.rsvrem.model.ReservationModel;

@Service
public class RsvaplServiceImpl implements RsvaplService{
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	RsvaplDao rsvaplDao;



	@Override
	public List<ReservationModel> myBookingList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvaplDao.myBookingList(paramMap);
	}



	@Override
	public int countMyBookingList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvaplDao.countMyBookingList(paramMap);
	}



	@Override
	public int deleteMyBooking(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvaplDao.deleteMyBooking(paramMap);
	}



	@Override
	public ReservationModel rsvSelectOne(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvaplDao.rsvSelectOne(paramMap);
	}



	@Override
	public int deleteMeeting(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvaplDao.deleteMeeting(paramMap);
	}

	
	
}
