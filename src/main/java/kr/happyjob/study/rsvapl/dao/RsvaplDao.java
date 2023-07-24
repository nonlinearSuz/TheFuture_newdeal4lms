package kr.happyjob.study.rsvapl.dao;
import java.util.List;
import java.util.Map;

import kr.happyjob.study.rsvrem.model.ReservationModel;

public interface RsvaplDao {
	List<ReservationModel> myBookingList(Map<String, Object> paramMap)throws Exception;
	
	int countMyBookingList(Map<String, Object> paramMap)throws Exception;

	int deleteMyBooking(Map<String, Object> paramMap)throws Exception;
	ReservationModel rsvSelectOne(Map<String, Object> paramMap)throws Exception;
	int deleteMeeting(Map<String, Object> paramMap)throws Exception;
}
