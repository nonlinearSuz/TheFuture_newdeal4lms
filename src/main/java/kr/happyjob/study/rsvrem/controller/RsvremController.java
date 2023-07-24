package kr.happyjob.study.rsvrem.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.rsvrem.model.BkInfoModel;
import kr.happyjob.study.rsvrem.model.ReservationModel;
import kr.happyjob.study.rsvrem.model.StudyroomModel;
import kr.happyjob.study.rsvrem.service.RsvremService;


@Controller
@RequestMapping("/rsvrem/")
public class RsvremController {

	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   @Autowired
	   RsvremService rsvremService;
	   
	   /**
	    * 초기화면
	    */
	   @RequestMapping("booking.do")
	   public String booking(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".booking");
	      logger.info("   - paramMap : " + paramMap);
	  
	      String user_id = (String) session.getAttribute("loginId");
	      //System.out.println("세션에서 받은 user_id = " + user_id);
	      
	      
	      logger.info("+ End " + className + ".booking");

	      return "rsvrem/rsvlist"; //web-inf/views/noticelist.jsp
	   }
	   
	   
		
	   @RequestMapping("/daylist") //하루에 있는 예약목룍록 출력하기
	   @ResponseBody
		public Map<String, Object> daytolist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception {
		//	log.info("todaylist post화면호출");
			
		      logger.info("+ Start " + className + ".daylist");
		      paramMap.put("loginID", (String) session.getAttribute("loginId"));
		      logger.info("   - paramMap : " + paramMap); 
			//현재 날짜를 기준으로 데이터를 받아온다.
			//JS에서 넘겨줄지, Controller에서 설정할지 선택한다.
			//JS input ajax통신으로 받아온다.
			//Controller 날짜포맷형식을 받아온다.
			//일단
			//List<ReservationModel> booklists = rsvremService.bookingList(paramMap);
			List<ReservationModel> booklists =rsvremService.bookingAndMeetList(paramMap);
		
			System.out.println(booklists);
			for(int i=0; i<booklists.size(); i++){
				logger.info("===출력====" +(booklists.get(i)));
				int startTime = booklists.get(i).getStartTime();
				int endTime = booklists.get(i).getEndTime();
			}
			//배열을 넣으면........ js에서는 어떻게가져옴?
			logger.info("갖고 온 데이터 = " + booklists);
			 Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
			  returnMap.put("booklists", booklists);
			
			  logger.info("+ End " + className + ".daylist");
			return returnMap;
		}
	   
		
	   @RequestMapping("/roomlist")
	   @ResponseBody
		public Map<String, Object> roomlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception {
		//	log.info("todaylist post화면호출");
			
		      logger.info("+ Start " + className + ".roomlist");
		      logger.info("   - paramMap : " + paramMap); 
			//현재 날짜를 기준으로 데이터를 받아온다.
			//JS에서 넘겨줄지, Controller에서 설정할지 선택한다.
			//JS input ajax통신으로 받아온다.
			//Controller 날짜포맷형식을 받아온다.
			//일단
			List<StudyroomModel> roomlists = rsvremService.roomList(paramMap);
		
			System.out.println(roomlists);
			for(int i=0; i<roomlists.size(); i++){
				logger.info("===출력====" +(roomlists.get(i)));
//				int startTime = booklists.get(i).getStartTime();
//				int endTime = booklists.get(i).getEndTime();
			}
			//배열을 넣으면........ js에서는 어떻게가져옴?
			logger.info("갖고 온 데이터 = " + roomlists);
			 Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
			  returnMap.put("roomlists", roomlists);
			
			  logger.info("+ End " + className + ".roomlist");
			return returnMap;
		}
	   
	   
	   
	   
	   @RequestMapping("selectList.do")	  
	   public String selectList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".selectList");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      

	      logger.info("selectList이 호출되었다.★★★★★★★★★★★★★★★★★★");
	     
	     // controller service dao sql
	      
	     paramMap.put("loginID",(String) session.getAttribute("loginId")); //**세션에 넣을떄는 loginId
	     																	//paramMap에 넣을때는 loginID
	     logger.info("   - paramMap ????????????????????????: " + paramMap); 
	     // userType을 체크해서, 만약에 학생이면, --> select * from tb_request_list로, 
	     //  select * from tb_request_list where loginID = 'stu100' and acc_yn ='Y';
	     
	     // acc_yn 승인여부 체크해야함
	     logger.info("지금 접속한 사람의 유저타입은 = " + session.getAttribute("userType"));
	     //T, S , M에 따라 분기하면된다.
	     String userType = session.getAttribute("userType").toString();
	     
	/*    // if(userType.equals("T")) NullPointerException 방지하기위해서
	     if( "T".equals(userType) ){ //(userType == "T" ) 자바가 잘 비교하지못한다.
	        List<LectureModel> selectBoxList = supassService.selectBoxSet(paramMap); 
	 	     logger.info("==========selectBoxList" + selectBoxList);
	 	     for(LectureModel list : selectBoxList){
	 	    	 
	 	    	 logger.info("조회해온 list = " + list);
	 	     }
	 	    model.addAttribute("selectBoxList", selectBoxList);
	     } else {
	    	 logger.info("============학생인 경우에============selectBoxSetStudent====");
	    	List<LectureModel> selectBoxList = supassService.selectBoxSetStudent(paramMap);
	    	model.addAttribute("selectBoxList", selectBoxList);
	     }*/
	     
	     List<StudyroomModel> selectBoxList = rsvremService.roomList(paramMap); 
 	     logger.info("==========selectBoxList" + selectBoxList);
 	     for(StudyroomModel list : selectBoxList){
 	    	 
 	    	 logger.info("조회해온 list = " + list);
 	     }
 	    model.addAttribute("selectBoxList", selectBoxList);
	     
	     
	   
	    		 
//	    		 MngNotService mngNotService = new MngNotServiceImpl();
	    		 //매번만들어줘야함 (상속?)
	    		 //@Autowired 하면 전역변수로 선언한다.
	     
	     //return할 map을 초기화해서 선언한다.
	     //Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
	  
	     
	     //returnMap.put("selectBoxList", selectBoxList); //VO 전체제이슨 안에 JSON이 또들어간 형태..
	     
	     
	      logger.info("+ End " + className + ".selectList");

	      return "rsvrem/selectboxlist";  
	      //user/mngNot/noticelistgrd.jsp
	   }
	   
	   
	//   loginID 중복체크
	   @RequestMapping(value="sameTimeChecking.do", method=RequestMethod.POST)
	   @ResponseBody
	   public int check_sameTime(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception{
		   
		   logger.info("+ Start " + className + ".check_sameTime");
		   logger.info("파라미터로 넘어온 모델은 무엇인지~~ " + paramMap);
		   //booking_date=2023.06.28  booking_stime=12, booking_etime=16,
		   //book_start  2023.06.28 + 12
		   //book_end 2023.06.28 + 16
		   String date = (String) paramMap.get("booking_date"); 
		   String stime = (String) paramMap.get("booking_stime");
		   String etime = (String) paramMap. get("booking_etime");
		   String roomNo=(String) paramMap.get("room_no");
		   paramMap.put("loginID",(String) session.getAttribute("loginId"));
		   
		   paramMap.put("startTime", (date+" "+stime));
		   paramMap.put("endTime", (date+" "+etime));
		   logger.info("다시 세팅해서 넘길파라미터는?? " + paramMap);
		   //{room_no=3, booking_date=2023-07-02, booking_stime=9, booking_etime=13, 
		   //book_no=30, loginID=stu300, startTime=2023-07-02 9, endTime=2023-07-02 13}
		   
		   //자기가 자신의 것을 수정하는 경우
		   int myval = 0;
		   myval = rsvremService.countMyRsvOne(paramMap);
		   logger.info("myval===="+ myval);
		   //myval = 0 이면 원래대로 진행하고
		   //myval = 1이면 자신의 것을 제외해야함.;.;;
		   //select * from tb_study_booking where book_no not like 30;
		   
		   
		   
		   
		   
		   
		   
		   
		   int result = 0;
		   int cnt = 0;
		  //TODO: date 와 today날짜비교해서 result날려주기
		   //booking_date=2023-06-30  booking_date=2023-06-30, booking_stime=10, booking_etime=14}
		   //지금 11시 30분인데 시작시간이 10시야. 그걸cut?  종료시간 11시야 그걸cut?
		   //종료시간 기준 <현재시간
		   //10시 <11시 인경우 시간재설정
//		   SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//		   logger.info("new Date의 정체는 ??? "+sDate.format(new Date()));
		   //String m = sDate.format(new Date());
		   
		   
		   String bookEndTime = date+ " " + etime+":00:00";
		   SimpleDateFormat sDate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   logger.info("★★★★" + bookEndTime); //★★★★2023-07-02 12:00:00
		   
		 //  Date bDate =sDate2.parse(bookEndTime); //Sun Jul 02 00:00:00 KST 2023
		/*   Date bDate = null;
		   try {
		   	bDate = sDate2.parse(bookEndTime);
		   } catch (ParseException e) {
		   	// TODO Auto-generated catch block
		   	e.printStackTrace();
		   }*/
		  
		   
		
		   //늦는다면~ result = -3 cutting
		   
		  
		   //TODO: book_no가 존쟂하는 경우 check_sameTime_otherRoom 가 아니라, 다른쿼리를타야함
		   String bookNo=(String) paramMap.get("book_no");
		   if("".equals(bookNo)){
			   
		   }
		   
		   
		   
		   if ("".equals(stime) || "".equals(etime)){
			   result = -1;
		   }  else{
			   Date bDate =sDate2.parse(bookEndTime);
			   logger.info("bookDate이란?? " + bDate); 
			   Date nowDate = new Date();
			   logger.info("nowDate = " + nowDate);
			   logger.info(nowDate.after(bDate)); //지금시간이 book시간보다 늦은지
			   String bookStartTime = date + " " + stime +":00:00";
			   SimpleDateFormat sDate3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   Date bsDate =sDate3.parse(bookStartTime); //"2023-06-30 15"
			   logger.info("예약시간이 이미 현재시간 이후이니? "+nowDate.after(bsDate));
			   // 예약시간 10시<현재시간 11시 risk를 물어봐야하는데;?? prompt창으로 띄워서 yes -> 중복컬럼검사 okXX(세모) 아니면 false로 하자.
			   
			   
			   
			   if(Integer.parseInt(stime) >= Integer.parseInt(etime)){
				   result = -1;
				   
			   } else if("".equals(roomNo)){
				   result = -2;
			   } else if(nowDate.after(bDate)){
				   result = -3;
			  } else if(myval == 0){ //새로 예약을 작성할때
				   
				   if(rsvremService.check_sameTime_otherRoom(paramMap)>0)
				   {result = -5;//이미 다른 스터디룸에 중복된 시간이 존재하는지 (동일한 아이디)}
				   
				   }else if (rsvremService.check_sameTime_otherMeeting(paramMap)>0) {
					   result = -4; //이미 참여하고 있는 meeting이 있는지..
				   }
				   
				   else{
					   logger.info("중복제거안한 평범한 중복검사");
					   result = rsvremService.check_sameTime(paramMap);
				   }
				   
			   }else{		  //수정할때(myval = 1)
				   
				   if(rsvremService.check_sameTime_otherRoom_notMine(paramMap)>0){
					   result = -5;
				   } else if (rsvremService.check_sameTime_otherMeetingNotMine(paramMap)>0) {
					   result = -4; //이미 참여하고 있는 meeting이 있는지..
				   }
				   
				   else{
					   logger.info("중복제거한 중복검사..");
					   result =rsvremService.checksameTimeNotMine(paramMap);
				   }
				   
				   
				
			   
			   
			  
			
			   }
		   
		   }
		   
		   logger.info("+ End " + className + ".check_sameTime");  
		   return result;
		 }
	   
	   

	   
	   
	   
	   @RequestMapping("tableinit.do")	  
	   public String tableinit(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".tableinit");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      

	
	      logger.info("+ End " + className + ".tableinit");

	      return "rsvrem/tablegrd";  
	    
	   }
	   
	   @RequestMapping("myBookList.do")	  
	   public String myBookList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".myBookList");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      paramMap.put("loginID",(String) session.getAttribute("loginId")); //**세션에 넣을떄는 loginId
			//paramMap에 넣을때는 loginID
	      logger.info("   - paramMap ????????????????????????: " + paramMap); 
	      	List<ReservationModel> myBookList = rsvremService.myBookingList(paramMap);
	        model.addAttribute("myBookList", myBookList);
		     
		     int totalCnt = rsvremService.countMyBookingList(paramMap);
		     model.addAttribute("totalCnt", totalCnt);
	
	      logger.info("+ End " + className + ".myBookList");

	      return "rsvrem/tablegrd";  
	    
	   }
	   
		//   예약저장
	   @RequestMapping(value="bookSave.do", method=RequestMethod.POST)
	   @ResponseBody
	   public Map<String, Object> bookSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception{
		   
		   logger.info("+ Start " + className + ".bookSave");
		   logger.info("파라미터로 넘어온 모델은 무엇인지~~ " + paramMap);
		   //booking_date=2023.06.28  booking_stime=12, booking_etime=16,
		   //book_start  2023.06.28 + 12
		   //book_end 2023.06.28 + 16
		   paramMap.put("loginID",(String) session.getAttribute("loginId"));
		   int returnVal = 0;
		   int cnt= 0;
		   //TODO: 허용인원수 넘는지 확인하기
		   int userSetCnt = Integer.parseInt((String) paramMap.get("booking_cnt"));
		  // int userRoomNumber = Integer.parseInt((String) paramMap.get("roomlist"));
		   
		   StudyroomModel confirmRoomCnt = rsvremService.confirmMaxCnt(paramMap);
		  int RoomMaxCnt = confirmRoomCnt.getRm_max();
		   if(userSetCnt > RoomMaxCnt ){
			   returnVal = -2;
		   }
		   int sameTimecheck = Integer.parseInt((String) paramMap.get("sameTimecheck"));
		   
		   
		   String date = (String) paramMap.get("booking_date");
		   String stime = (String) paramMap.get("booking_stime");
		   String etime = (String) paramMap. get("booking_etime");
		   String roomNo=(String) paramMap.get("room_no");
		   
		   logger.info("시작시간 다시 세팅" + (date+stime));
		   paramMap.put("startTime", (date+" "+stime));
		   paramMap.put("endTime", (date+" "+etime));
		   logger.info("다시 세팅해서 넘길파라미터는?? " + paramMap);
		
		   String action = (String) paramMap.get("action");
		   if(userSetCnt > RoomMaxCnt ){
			   returnVal = -2;
		   
		   } else if(sameTimecheck == 0){
			   returnVal = -4;
		   }
		   
		   else{
		      if("I".equals(action)) {
		    	  returnVal=  rsvremService.bookInsert(paramMap); 
		    	  cnt = rsvremService.makeMeeting(paramMap);
		      } else if ("U".equals(action)){
		    	  returnVal=  rsvremService.bookUpdate(paramMap); 
		      } else if ("D".equals(action)){
		    	  //TODO: loginID를 따로 param으로 넘겨서 세션에서 얻은값과 일치하거나, param의 타입이 M이면
		    	  //삭제를 허용해야하고, 그렇지않으면 불허용을 해야한다.
		    	  if(Integer.parseInt((String)paramMap.get("cnt_now"))==1){
		    		  cnt = rsvremService.meetingDelete(paramMap);
		    	  returnVal=  rsvremService.bookDelete(paramMap); 
		    	  } else{
		    		  returnVal = -3;
		    	  }
		      }
		   }  

		     //insert 성공  에러 -1
		     
	
		     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
		     
		     
		     returnMap.put("returnVal", returnVal); //VO 전체제이슨 안에 JSON이 또들어간 형태..
		     returnMap.put("cnt", cnt);
		  
		
		   
		   logger.info("+ End " + className + ".bookSave");
		   return returnMap;
	   }
	   
	   
	   
	//////////////////////////////////////////////////////참여하기   
	//   참여하기 버튼 중복검사
		   @RequestMapping(value="sameTimeCheckingGathering.do", method=RequestMethod.POST)
		   @ResponseBody
		   public int check_sameTime_Gathering(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			         HttpServletResponse response, HttpSession session) throws Exception{
			   
			   logger.info("+ Start " + className + ".check_sameTime_Gathering");
			   logger.info("파라미터로 넘어온 모델은 무엇인지~~ " + paramMap);
			   //booking_date=2023.06.28  booking_stime=12, booking_etime=16,
			   //book_start  2023.06.28 + 12
			   //book_end 2023.06.28 + 16
			   String date = (String) paramMap.get("booking_date"); 
			   String stime = (String) paramMap.get("booking_stime");
			   String etime = (String) paramMap. get("booking_etime");
			   String roomNo=(String) paramMap.get("room_no");
			   paramMap.put("loginID",(String) session.getAttribute("loginId"));
			   
			   paramMap.put("startTime", (date+" "+stime));
			   paramMap.put("endTime", (date+" "+etime));
			   logger.info("다시 세팅해서 넘길파라미터는?? " + paramMap);
			   //{room_no=3, booking_date=2023-07-02, booking_stime=9, booking_etime=13, 
			   //book_no=30, loginID=stu300, startTime=2023-07-02 9, endTime=2023-07-02 13}
			   
			   //자기가 자신의 것을 수정하는 경우
			   int myval = 0;
			   myval = rsvremService.countMyRsvOne(paramMap);
			   logger.info("myval===="+ myval);
			   //myval = 0 이면 원래대로 진행하고
			   //myval = 1이면 자신의 것을 제외해야함.;.;;
			   //select * from tb_study_booking where book_no not like 30;
			   
			   
			   int cnt_now = Integer.parseInt((String) paramMap.get("cnt_now"));
			   int cnt_max = Integer.parseInt((String) paramMap.get("booking_cnt"));
			   
			   
			   
			   
			   int result = 0;
			   int cnt = 0;
			  //TODO: date 와 today날짜비교해서 result날려주기
			   //booking_date=2023-06-30  booking_date=2023-06-30, booking_stime=10, booking_etime=14}			   
			   //종료시간 기준 <현재시간
			   //10시 <11시 인경우 시간재설정			   
			   
			   String bookEndTime = date+ " " + etime+":00:00";
			   SimpleDateFormat sDate2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   logger.info("★★★★" + bookEndTime); //★★★★2023-07-02 12:00:00
			   
			   Date bDate =sDate2.parse(bookEndTime); //Sun Jul 02 00:00:00 KST 2023
			  
			   
			   logger.info("bookDate이란?? " + bDate); 
			   Date nowDate = new Date();
			   logger.info("nowDate = " + nowDate);
			   logger.info(nowDate.after(bDate)); //지금시간이 book시간보다 늦은지		
			   
			   String bookStartTime = date + " " + stime +":00:00";
			   SimpleDateFormat sDate3 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			   Date bsDate =sDate3.parse(bookStartTime); //"2023-06-30 15"
			   logger.info("예약시간이 이미 현재시간 이후이니? "+nowDate.after(bsDate));
		   
			   //TODO: book_no가 존쟂하는 경우 check_sameTime_otherRoom 가 아니라, 다른쿼리를타야함
			   String bookNo=(String) paramMap.get("book_no");
			   if("".equals(bookNo)){
				   
			   }
			   
			   
			   
			   if ("".equals(stime) || "".equals(etime)){
				   result = -1;
			   } else if(Integer.parseInt(stime) >= Integer.parseInt(etime)){
				   result = -1;
				   
			   } else if("".equals(roomNo)){
				   result = -2;
			   } else if(nowDate.after(bDate)){
				   result = -3;
			//   }else if (nowDate.after(bsDate)){
			//	   result = -4;
			   }else if(cnt_now>=cnt_max){
				result = -4;
				   
			   } else {
				   result = rsvremService.check_sameTime_otherRoom(paramMap);
	
			   }
			   
			   
			   
			   logger.info("+ End " + className + ".check_sameTime_Gathering");  
			   return result;
	}
		   
		   
			//   참석하기.
		   @RequestMapping(value="attendMeeting.do", method=RequestMethod.POST)
		   @ResponseBody
		   public Map<String, Object> MeetingSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			         HttpServletResponse response, HttpSession session) throws Exception{
			   
			   logger.info("+ Start " + className + ".MeetingSave");
			   logger.info("파라미터로 넘어온 모델은 무엇인지~~ " + paramMap);
			   //booking_date=2023.06.28  booking_stime=12, booking_etime=16,
			   //book_start  2023.06.28 + 12
			   //book_end 2023.06.28 + 16
			   paramMap.put("loginID",(String) session.getAttribute("loginId"));
			   
			   String date = (String) paramMap.get("booking_date");
			   String stime = (String) paramMap.get("booking_stime");
			   String etime = (String) paramMap. get("booking_etime");
			   String roomNo=(String) paramMap.get("room_no");
			   
			   logger.info("시작시간 다시 세팅" + (date+stime));
			   paramMap.put("startTime", (date+" "+stime));
			   paramMap.put("endTime", (date+" "+etime));
			   logger.info("다시 세팅해서 넘길파라미터는?? " + paramMap);
			   int returnVal = 0;
			   int cnt =0;
			   //TODO: 이미 존재하는지확인하기
			   cnt = rsvremService.existAtMeeting(paramMap);
			   if(cnt>0){
				   returnVal = -2;
			   }else{
			   returnVal = rsvremService.attendMeeting(paramMap);
			   }
			   
			   
		
			     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
			     
			     
			     returnMap.put("returnVal", returnVal); //VO 전체제이슨 안에 JSON이 또들어간 형태..

			   logger.info("+ End " + className + ".MeetingSave");
			   return returnMap;
		   }
		   
		   
		   
		   
			// 탈퇴하기
		   @RequestMapping(value="outMeeting.do", method=RequestMethod.POST)
		   @ResponseBody
		   public Map<String, Object> MeetingOut(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			         HttpServletResponse response, HttpSession session) throws Exception{
			   
			   logger.info("+ Start " + className + ".MeetingOut");
			   logger.info("파라미터로 넘어온 모델은 무엇인지~~ " + paramMap);
			   //booking_date=2023.06.28  booking_stime=12, booking_etime=16,
			   //book_start  2023.06.28 + 12
			   //book_end 2023.06.28 + 16
			   paramMap.put("loginID",(String) session.getAttribute("loginId"));
			
			
			   logger.info("다시 세팅해서 넘길파라미터는?? " + paramMap);
			   int returnVal = 0;
			   int cnt =0;
			   
			   returnVal = rsvremService.outMeeting(paramMap);
			   
			     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
			     
			     
			     returnMap.put("returnVal", returnVal); 
			  
			  
			
			   
			   logger.info("+ End " + className + ".MeetingOut");
			   return returnMap;
		   }	   
		   
	
		   
		   
			// 한건조회
		   @RequestMapping(value="selectOne.do", method=RequestMethod.POST)
		   @ResponseBody
		   public Map<String, Object> selectOne(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			         HttpServletResponse response, HttpSession session) throws Exception{
			   
			   logger.info("+ Start " + className + ".selectOne");
			   logger.info("파라미터로 넘어온 모델은 무엇인지~~ " + paramMap);
	
			   paramMap.put("loginID",(String) session.getAttribute("loginId"));
			
			
			   logger.info("다시 세팅해서 넘길파라미터는?? " + paramMap);
			   int returnVal = 0;
			   int cnt =0;
			   
			   ReservationModel oneBook = rsvremService.selectOne(paramMap);
			   
		
			     Map<String, Object> returnMap = new HashMap<String, Object>();
			     
			     returnMap.put("oneBook", oneBook); 
			  
			
			   
			   logger.info("+ End " + className + ".selectOne");
			   return returnMap;
		   }	   
	
}
