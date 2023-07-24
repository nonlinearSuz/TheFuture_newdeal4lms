package kr.happyjob.study.rsvrem.dao;

import java.util.List;
import java.util.Map;


import kr.happyjob.study.rsvrem.model.ReservationModel;
import kr.happyjob.study.rsvrem.model.StudyroomModel;

public interface RsvremDao {

	List<ReservationModel> bookingList(Map<String, Object> paramMap)throws Exception;
	List<StudyroomModel> selectBoxSet(Map<String, Object> paramMap) throws Exception;
	int checksameTime(Map<String, Object> paramMap) throws Exception;
	List<ReservationModel> myBookingList(Map<String, Object> paramMap)throws Exception;
	int countMyBookingList(Map<String, Object> paramMap)throws Exception;
	int bookInsert(Map<String, Object> paramMap)throws Exception;

	int bookUpdate(Map<String, Object> paramMap)throws Exception;

	int bookDelete(Map<String, Object> paramMap)throws Exception;
	
	List<StudyroomModel> roomList(Map<String, Object> paramMap)throws Exception;
	int check_sameTime_otherRoom(Map<String, Object> paramMap)throws Exception;
	int countMyRsvOne(Map<String, Object> paramMap)throws Exception;
	int checksameTimeNotMine(Map<String, Object> paramMap)throws Exception;
	int check_sameTime_otherRoom_notMine(Map<String, Object> paramMap)throws Exception;
	int makeMeeting(Map<String, Object> paramMap) throws Exception;
	int attendMeeting(Map<String, Object> paramMap)throws Exception;
	int existAtMeeting(Map<String, Object> paramMap)throws Exception;
	
	int check_sameTime_otherMeeting(Map<String, Object> paramMap)throws Exception;
	List<ReservationModel> bookingAndMeetList(Map<String, Object> paramMap)throws Exception;
	StudyroomModel confirmMaxCnt(Map<String, Object> paramMap)throws Exception;
	int check_sameTime_otherMeetingNotMine(Map<String, Object> paramMap)throws Exception;
	int meetingDelete(Map<String, Object> paramMap)throws Exception;

	int outMeeting(Map<String, Object> paramMap)throws Exception;
	ReservationModel selectOne(Map<String, Object> paramMap)throws Exception;
}
