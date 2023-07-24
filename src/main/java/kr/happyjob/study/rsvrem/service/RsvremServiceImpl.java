package kr.happyjob.study.rsvrem.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import kr.happyjob.study.rsvrem.dao.RsvremDao;
import kr.happyjob.study.rsvrem.model.BkInfoModel;
import kr.happyjob.study.rsvrem.model.ReservationModel;
import kr.happyjob.study.rsvrem.model.StudyroomModel;

@Service
public class RsvremServiceImpl implements RsvremService{
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	RsvremDao rsvremDao;

	

	@Override
	public List<ReservationModel> bookingList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.bookingList(paramMap);
	}



	@Override
	public List<StudyroomModel> selectBoxSet(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.selectBoxSet(paramMap);
	}






	@Override
	public int check_sameTime(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.checksameTime(paramMap);
	}



	@Override
	public List<ReservationModel> myBookingList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.myBookingList(paramMap);
	}



	@Override
	public int countMyBookingList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.countMyBookingList(paramMap);
	}



	@Override
	public int bookInsert(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.bookInsert(paramMap);
	}



	@Override
	public int bookUpdate(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.bookUpdate(paramMap);
	}



	@Override
	public int bookDelete(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.bookDelete(paramMap);
	}



	@Override
	public List<StudyroomModel> roomList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.roomList(paramMap);
	}



	@Override
	public int check_sameTime_otherRoom(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.check_sameTime_otherRoom(paramMap);
	}



	@Override
	public int countMyRsvOne(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.countMyRsvOne(paramMap);
	}



	@Override
	public int checksameTimeNotMine(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.checksameTimeNotMine(paramMap);
	}



	@Override
	public int check_sameTime_otherRoom_notMine(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.check_sameTime_otherRoom_notMine(paramMap);
	}



	@Override
	public int makeMeeting(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.makeMeeting(paramMap);
	}



	@Override
	public int attendMeeting(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.attendMeeting(paramMap);
	}



	@Override
	public int existAtMeeting(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.existAtMeeting(paramMap);
	}



	@Override
	public int check_sameTime_otherMeeting(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.check_sameTime_otherMeeting(paramMap);
	}



	@Override
	public List<ReservationModel> bookingAndMeetList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.bookingAndMeetList(paramMap);
	}



	@Override
	public StudyroomModel confirmMaxCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.confirmMaxCnt(paramMap);
	}



	@Override
	public int check_sameTime_otherMeetingNotMine(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.check_sameTime_otherMeetingNotMine(paramMap);
	}



	@Override
	public int meetingDelete(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.meetingDelete(paramMap);
	}



	@Override
	public int outMeeting(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.outMeeting(paramMap);
	}



	@Override
	public ReservationModel selectOne(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return rsvremDao.selectOne(paramMap);
	}
}
