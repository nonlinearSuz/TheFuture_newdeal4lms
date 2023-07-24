package kr.happyjob.study.rsvapl.controller;

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

import kr.happyjob.study.rsvapl.service.RsvaplService;
import kr.happyjob.study.rsvrem.model.ReservationModel;

@Controller
@RequestMapping("/rsvapl/")
public class RsvaplController {
	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   @Autowired
	   RsvaplService rsvaplService;
	   
	   /**
	    * 초기화면
	    */
	   /**
	    * 초기화면
	    */
	   @RequestMapping("myBooking.do")
	   public String myBooking(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".myBooking");
	      logger.info("   - paramMap : " + paramMap);
	  
	      String user_id = (String) session.getAttribute("loginId");
	      //System.out.println("세션에서 받은 user_id = " + user_id);
	      
	      
	      logger.info("+ End " + className + ".myBooking");

	      return "rsvapl/myrsv"; //web-inf/views/noticelist.jsp
	   }
	   
	   //myrsvlist
	   
	   @RequestMapping("myrsvlist.do")
	   public String myrsvlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".myrsvlist");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	     
	     int pageNum = Integer.parseInt((String) paramMap.get("pageNum")); //map으로 꺼내받을떄 숫자형으로 계산해야한다.
	     int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	     
	     int pageIndex = (pageNum - 1) * pageSize;

	    
	     paramMap.put("pageSize", pageSize);
	     paramMap.put("pageIndex", pageIndex);
	     
	     String userType = session.getAttribute("userType").toString();
	     
	     
	     //*************학생일경우에 loginId를 loginId로 넣어주자******////////
	     paramMap.put("loginID" ,(String) session.getAttribute("loginId"));
	     List<ReservationModel> myRsvList = rsvaplService.myBookingList(paramMap);
	     model.addAttribute("myRsvList", myRsvList);
	     
	     int totalCnt = rsvaplService.countMyBookingList(paramMap);
	     model.addAttribute("totalCnt", totalCnt);
	     
	     
	     
		    
	    // if( "T".equals(userType) ){
	     //************선생님일 경우에 loginId를 lec_prof라고 넣어주자*****/
		  
	    
	  //   int totalCnt = mngNotService.countNoticeList(paramMap);
	     
	  
	  
	     
	     
	     
	      logger.info("+ End " + className + ".myrsvlist");

	      return "rsvapl/myrsvlistgrd";       //user/mngNot/noticelistgrd.jsp
	    
	   	}   
	   //myBookDelete
		//   예약저장
	   @RequestMapping(value="myBookDelete.do", method=RequestMethod.POST)
	   @ResponseBody
	   public Map<String, Object> myBookDelete(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception{
		   
		   logger.info("+ Start " + className + ".myBookDelete");
		   logger.info("파라미터로 넘어온 모델은 무엇인지~~ " + paramMap);
		   //booking_date=2023.06.28  booking_stime=12, booking_etime=16,
		   //book_start  2023.06.28 + 12
		   //book_end 2023.06.28 + 16
		   paramMap.put("loginID",(String) session.getAttribute("loginId"));
		   int returnVal = 0;
		   int returnValMeeting = 0;
		   //참석자 수가 따로 존재하면 삭제불가.
		   int cnt=	Integer.parseInt((String)paramMap.get("cnt"));
		   if(cnt>1){
			 returnVal = -2;   
		   } else{
			   returnValMeeting =rsvaplService.deleteMeeting(paramMap);
		   returnVal = rsvaplService.deleteMyBooking(paramMap);
		   }
		   
		     //insert 성공  에러 -1
		     
		    		 
//		    		 MngNotService mngNotService = new MngNotServiceImpl();
		    		 //매번만들어줘야함 (상속?)
		    		 //@Autowired 하면 전역변수로 선언한다.
		     
		     //return할 map을 초기화해서 선언한다.
		     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
		     
		     returnMap.put("returnValMeeting", returnValMeeting); //VO 전체제이슨 안에 JSON이 또들어간 형태..
		     returnMap.put("returnVal", returnVal); //VO 전체제이슨 안에 JSON이 또들어간 형태..
		     
		  
		
		   
		   logger.info("+ End " + className + ".myBookDelete");
		   return returnMap;
	   }
	   
	   
	   
	   //예약 상세조회 -- rsvrem Selectone이랑 동일해서 삭제예정.
	   @RequestMapping(value="rsvInfo.do", method=RequestMethod.POST)
	   @ResponseBody
	   public Map<String, Object> rsvInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception{
		   
		   logger.info("+ Start " + className + ".rsvInfo");
		   logger.info("파라미터로 넘어온 모델은 무엇인지~~ " + paramMap);
	
		   paramMap.put("loginID",(String) session.getAttribute("loginId"));
		   int returnVal = 0;
		   
		   ReservationModel myRsvInfo = rsvaplService.rsvSelectOne(paramMap);
		   
		   
		   //참석자 수가 따로 존재하면 삭제불가.
		   int cnt=	Integer.parseInt((String)paramMap.get("cnt"));
		   if(cnt>1){
			 returnVal = -2;   
		   } else{
		   
		   returnVal = rsvaplService.deleteMyBooking(paramMap);
		   }
		   

		     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
		     
		     
		     returnMap.put("returnVal", returnVal); //VO 전체제이슨 안에 JSON이 또들어간 형태..
		     
		  
		
		   
		   logger.info("+ End " + className + ".rsvInfo");
		   return returnMap;
	   }
	   

}
