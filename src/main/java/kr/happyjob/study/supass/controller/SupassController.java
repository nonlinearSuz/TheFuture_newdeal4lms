package kr.happyjob.study.supass.controller;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.supass.dao.SupassDao;
import kr.happyjob.study.supass.model.AssignmentModel;
import kr.happyjob.study.supass.model.LectureModel;
import kr.happyjob.study.supass.service.SupassService;
import kr.happyjob.study.supmtr.model.StudyFileModel;


@Controller
@RequestMapping("/supass/")
public class SupassController {
	@Autowired
	SupassService supassService;

	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   
	   
	   /**
	    * 초기화면
	    */
	   @RequestMapping("assignment.do")
	   public String assignment(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".assignment");
	      logger.info("   - paramMap : " + paramMap);
	  
	      String user_id = (String) session.getAttribute("loginId");
	      //System.out.println("세션에서 받은 user_id = " + user_id);
	      
	      
	      logger.info("+ End " + className + ".assignment");

	      return "supass/assignlist"; //web-inf/views/noticelist.jsp
	   }
	   
	   
	   @RequestMapping("selectList.do")	  
	   public String selectList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".selectList");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      

	      logger.info("selectList이 호출되었다.★★★★★★★★★★★★★★★★★★");
	     

	      
	     paramMap.put("loginID",(String) session.getAttribute("loginId")); //**세션에 넣을떄는 loginId
	     																	//paramMap에 넣을때는 loginID
	     logger.info("   - paramMap ????????????????????????: " + paramMap); 
	     // userType을 체크해서, 만약에 학생이면, --> select * from tb_request_list로, 
	     //  select * from tb_request_list where loginID = 'stu100' and acc_yn ='Y';
	     
	     // acc_yn 승인여부 체크해야함
	     logger.info("지금 접속한 사람의 유저타입은 = " + session.getAttribute("userType"));
	     //T, S , M에 따라 분기하면된다.
	     String userType = session.getAttribute("userType").toString();
	     
	    // if(userType.equals("T")) NullPointerException 방지하기위해서
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
	     }
	     
	
	      logger.info("+ End " + className + ".selectList");

	      return "supass/selectboxlist";  
	
	   }
	   
	   
	   
	   @RequestMapping("lecturelist.do")
	   public String lecturelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".lecturelist");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	     
	     int pageNum = Integer.parseInt((String) paramMap.get("pageNum")); //map으로 꺼내받을떄 숫자형으로 계산해야한다.
	     int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	     
	     int pageIndex = (pageNum - 1) * pageSize;

	    
	     paramMap.put("pageSize", pageSize);
	     paramMap.put("pageIndex", pageIndex);
	     
	     String userType = session.getAttribute("userType").toString();
		    
	     if( "T".equals(userType) ){
	     //************선생님일 경우에 loginId를 lec_prof라고 넣어주자*****/
		     
		     paramMap.put("loginID",(String) session.getAttribute("loginId"));
		     logger.info("   - paramMap ????????????????????????: " + paramMap); 
	    
		     List<LectureModel> lecturingList = supassService.lectureList(paramMap);		 
		     model.addAttribute("lecturingList", lecturingList);
		     int totalCnt = supassService.countLectureList(paramMap);
		     model.addAttribute("totalCnt", totalCnt);
		    
	     } else {
	     
		     //*************학생일경우에 loginId를 loginId로 넣어주자******////////
		     paramMap.put("loginID" ,(String) session.getAttribute("loginId"));
		     List<LectureModel> lecturingList = supassService.lectureListByStudent(paramMap);
		     model.addAttribute("lecturingList", lecturingList);
		     
		     int totalCnt = supassService.countLectureListByStudent(paramMap);
		     model.addAttribute("totalCnt", totalCnt);
		  }
	     
	     
	      logger.info("+ End " + className + ".lecturelist");

	      return "supass/lecturelistgrd";       //user/mngNot/noticelistgrd.jsp
	    
	   	}   
	   
	   @RequestMapping("assignmentTeacherlist.do")
	   public String assignmentTeacherlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".assignmentTeacherlist");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      logger.info("  과제목록 검색후 나오는 paramMap==========================: " + paramMap);
	     int pageNum = Integer.parseInt((String) paramMap.get("pageNum")); //map으로 꺼내받을떄 숫자형으로 계산해야한다.
	     int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	     
	     int pageIndex = (pageNum - 1) * pageSize;

	    
	     paramMap.put("pageSize", pageSize);
	     paramMap.put("pageIndex", pageIndex);
	
	     //************선생님일 경우에 loginId를 lec_prof라고 넣어주자*****/
		     
		     paramMap.put("loginID",(String) session.getAttribute("loginId"));
		     logger.info("   - paramMap ????????????????????????: " + paramMap); 
	    
		     List<AssignmentModel> assignmentList = supassService.assignmentTeacherList(paramMap);		 
		     model.addAttribute("assignmentList", assignmentList);
		     
		     int totalCnt = supassService.countAssignmentTodoList(paramMap);
		     model.addAttribute("totalCnt", totalCnt);
		    
	 
	     
	     
	     
	      logger.info("+ End " + className + ".assignmentTeacherlist");

	      String userType = session.getAttribute("userType").toString();
	      if( "T".equals(userType) ){
	      return "supass/assignTeacherlistgrd"; 
	      } else{
	      return "supass/assignStudnetlistgrd";
	      }
	  
	      
	   	}   
	   
	   @RequestMapping("assignmentStulist.do")
	   public String assignmentStulist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".assignmentStulist");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      logger.info("  과제목록 검색후 나오는 paramMap==========================: " + paramMap);
	     int pageNum = Integer.parseInt((String) paramMap.get("pageNum")); //map으로 꺼내받을떄 숫자형으로 계산해야한다.
	     int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	     
	     int pageIndex = (pageNum - 1) * pageSize;

	    
	     paramMap.put("pageSize", pageSize);
	     paramMap.put("pageIndex", pageIndex);
	     

		     
		     paramMap.put("loginID",(String) session.getAttribute("loginId"));
		     logger.info("   - paramMap ????????????????????????: " + paramMap); 
	    
		     List<AssignmentModel> assignmentList = supassService.assignmentList(paramMap);		 
		     model.addAttribute("assignmentList", assignmentList);
		     
		     int totalCnt = supassService.countAssignmentTodoList(paramMap);
		     model.addAttribute("totalCnt", totalCnt);
		    
	 
	     
	     
	     
	      logger.info("+ End " + className + ".assignmentStulist");

	      
	      String userType = session.getAttribute("userType").toString();
	      logger.info("지금 assignmentStulist 를 호출하는 유저타입은 ========== " +userType);
	      return "supass/assignStudentlistgrd";
	    }
	      
	      

	   
	   
	   
	   @RequestMapping("assignTeacherSaveFile.do")
	   @ResponseBody //json 반환타입 return타입이 map이 json으로 바뀌게된다. -- body영역에 html이 아니라 데이터를 넘겨주겠다.
	   public Map<String, Object> assignTeacherSaveFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".assignTeacherSaveFile");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      
	      //httpservletRequest 가 file타입을 못꺼낸다.
	      //request에 파일첨부된정보가 넘어오지만, request에 파일정보를꺼낼 메소드가없다.
	      
	      //paramMap 대신에 fileData가 가는게아님?
	      //MultipartHttpServletRequest	      
	      
	     
	      String action = (String) paramMap.get("action");
	     
	      paramMap.put("loginId", (String) session.getAttribute("loginId")); //쿼리문에서 필요함..

	      logger.info("=====assignTeacherSaveFile의 파라미터=====" + paramMap);
	      int returnVal = 0;
	      
	      if("I".equals(action)) {
	    	  returnVal=  supassService.assignTeacherInsertFile(paramMap, request); 
	    	  logger.info("=============stufileInsert후 returnVal값은??===" + returnVal);
	      } else if ("U".equals(action)){
	    	  returnVal=  supassService.assignTeacherUpdateFile(paramMap, request); 
	      } else if ("D".equals(action)){
	    	  returnVal=  supassService.assignTeacherDeleteFile(paramMap); 
	      }
	      

	     
	     //return할 map을 초기화해서 선언한다.
	     Map<String, Object> returnMap = new HashMap<String, Object>(); 
	     
	     
	     returnMap.put("returnVal", returnVal); 
	     
	     
	      logger.info("+ End " + className + ".assignTeacherSaveFile");

	      return returnMap;      
	   }
	
	   
	 //한건조회
	   @RequestMapping("assignTeacherSelectOne.do")
	   @ResponseBody //json 반환타입 return타입이 map이 json으로 바뀌게된다. -- body영역에 html이 아니라 데이터를 넘겨주겠다.
	   public Map<String, Object> assignTeacherSelectOne(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".assignTeacherSelectOne");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      

	      logger.info("select one이 호출되었다.★★★★★★★★★★★★★★★★★★");
	     
	   
	 
	     	AssignmentModel  assignTeacherSearch = supassService.assignTeacherSelectOne(paramMap);
	     	
	     	logger.info("한건 조회해서 온 결과 = " + assignTeacherSearch);
	     

	     
	     //return할 map을 초기화해서 선언한다.
	     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
	     
	     
	     returnMap.put("assignTeacherSearch", assignTeacherSearch); //VO 전체제이슨 안에 JSON이 또들어간 형태..
	     
	     
	      logger.info("+ End " + className + ".assignTeacherSelectOne");

	      return returnMap;       //user/mngNot/noticelistgrd.jsp
	   }
	   
	   
	   @RequestMapping("downloadnoticefile.do")
	 		public void downloadnoticefile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	 				HttpServletResponse response, HttpSession session) throws Exception {

	 		   logger.info("+ Start " + className + ".downloadnoticefile");
	 			logger.info("   - paramMap : " + paramMap);

	 			logger.info("download~~~~~~~~~~~~~~~~~~~~~~~paramMap = " + paramMap);

	 		   
	 			AssignmentModel  assTchSearch = supassService.assignTeacherSelectOne(paramMap); //file이름, 물리경로
	 		   
	 		   //noticeSearch.getPhysic_path(); //물리경로
	 		   
	 		   byte fileByte[] = FileUtils.readFileToByteArray(new File(assTchSearch.getFile_physic_path()));
	 		   response.setContentType("application/octet-stream");
	 		    response.setContentLength(fileByte.length);
	 		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(assTchSearch.getFile_name(),"UTF-8")+"\";");
	 		    response.setHeader("Content-Transfer-Encoding", "binary");
	 		    response.getOutputStream().write(fileByte);
	 		    response.getOutputStream().flush();
	 		    response.getOutputStream().close();

	 		   
	 		   //encode 한글파일명  유니코드 지정을 안해주면 파일명이이상하게 지정이된다.
	 		   // unicode 한글변환 웹에서는 유니코드를 많이쓴다.
	 		   // 우리나라 => 이상한 유니코드로 변환된다. (인코딩안해주면)
	 		   //get방식 쿼리로 한글    %EC%9A
	 		   //전 세계의 모든 문자를 다루도록 설계된 표준 문자 전산 처리 방식 : 유니코드
	 		   //URLEncoder.encode(arg0)
	 		   //encode 유니코드형태로 바꿔서 전달
	 		   
	 		   logger.info("+ End " + className + ".downloadnoticefile");
	 	   
	 	   }
	   
	   
	   @RequestMapping("downloadStufile.do")
		public void downloadStufile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {

		   logger.info("+ Start " + className + ".downloadStufile");
			logger.info("   - paramMap : " + paramMap);

		     paramMap.put("loginID",(String) session.getAttribute("loginId")); 
			logger.info("download~~~~~~~~~~~~~~~~~~~~~~~paramMap = " + paramMap);
			
		   
			AssignmentModel  assStuSearch = supassService.assignTaskSelectOne(paramMap); //file이름, 물리경로
		   
		   //noticeSearch.getPhysic_path(); //물리경로
		   
		   byte fileByte[] = FileUtils.readFileToByteArray(new File(assStuSearch.getFile_physic_path()));
		   response.setContentType("application/octet-stream");
		    response.setContentLength(fileByte.length);
		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(assStuSearch.getFile_name(),"UTF-8")+"\";");
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.getOutputStream().write(fileByte);
		    response.getOutputStream().flush();
		    response.getOutputStream().close();

		   
		   //encode 한글파일명  유니코드 지정을 안해주면 파일명이이상하게 지정이된다.
		   // unicode 한글변환 웹에서는 유니코드를 많이쓴다.
		   // 우리나라 => 이상한 유니코드로 변환된다. (인코딩안해주면)
		   //get방식 쿼리로 한글    %EC%9A
		   //전 세계의 모든 문자를 다루도록 설계된 표준 문자 전산 처리 방식 : 유니코드
		   //URLEncoder.encode(arg0)
		   //encode 유니코드형태로 바꿔서 전달
		   
		   logger.info("+ End " + className + ".downloadStufile");
	   
	   }
	   
  //학생이 제출한 파일을 선생님이 다운로드
	   @RequestMapping("downloadSubmitStufile.do")
		public void downloadSubmitStufile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {

		   logger.info("+ Start " + className + ".downloadSubmitStufile");
			logger.info("   - paramMap : " + paramMap);

		     paramMap.put("loginID",(String) session.getAttribute("loginId")); 
			logger.info("download~~~~~~~~~~~~~~~~~~~~~~~paramMap = " + paramMap);
			
		   
			AssignmentModel  assStuSearch = supassService.submitStuSelectOne(paramMap); //file이름, 물리경로
		   
		   //noticeSearch.getPhysic_path(); //물리경로
		   
		   byte fileByte[] = FileUtils.readFileToByteArray(new File(assStuSearch.getFile_physic_path()));
		   response.setContentType("application/octet-stream");
		    response.setContentLength(fileByte.length);
		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(assStuSearch.getFile_name(),"UTF-8")+"\";");
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.getOutputStream().write(fileByte);
		    response.getOutputStream().flush();
		    response.getOutputStream().close();

		   
		   //encode 한글파일명  유니코드 지정을 안해주면 파일명이이상하게 지정이된다.
		   // unicode 한글변환 웹에서는 유니코드를 많이쓴다.
		   // 우리나라 => 이상한 유니코드로 변환된다. (인코딩안해주면)
		   //get방식 쿼리로 한글    %EC%9A
		   //전 세계의 모든 문자를 다루도록 설계된 표준 문자 전산 처리 방식 : 유니코드
		   //URLEncoder.encode(arg0)
		   //encode 유니코드형태로 바꿔서 전달
		   
		   logger.info("+ End " + className + ".downloadSubmitStufile");
	   
	   }
 
	   
	   
	   //한건조회
	   @RequestMapping("taskSendSelectOne.do")
	   @ResponseBody //json 반환타입 return타입이 map이 json으로 바뀌게된다. -- body영역에 html이 아니라 데이터를 넘겨주겠다.
	   public AssignmentModel taskSendSelectOne(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".assignTeacherSelectOne");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      

	      logger.info("task_send select one이 호출되었다.★★★★★★★★★★★★★★★★★★");

		     paramMap.put("loginID",(String) session.getAttribute("loginId")); 
		     //**세션에 넣을떄는 loginId
				//paramMap에 넣을때는 loginID
		   //return할 map을 초기화해서 선언한다.
		     Map<String, Object> returnMap = new HashMap<String, Object>(); 
		     
		     
		     
		     //TODO: exist쿼리를 호출해야함.
		    int existResult = supassService.existTaskSend(paramMap);
		   
		    if(existResult == 0){
		    			    	 
		    	AssignmentModel assignTodoSearch =  supassService.assignNotExistSelectOne(paramMap);
		      	logger.info("아직 제출안한 한건 조회해서 온 결과 = " + assignTodoSearch);
	
			     
			     returnMap.put("assignTodoSearch", assignTodoSearch); //VO 전체제이슨 안에 JSON이 또들어간 형태..
			     return assignTodoSearch;

			    
		     } else {
		         
			     	AssignmentModel  assignStuSearch = supassService.assignTaskSelectOne(paramMap);
			     	
			     	logger.info("한건 조회해서 온 결과 = " + assignStuSearch);

				     
				     returnMap.put("assignStuSearch", assignStuSearch); //VO 전체제이슨 안에 JSON이 또들어간 형태..
				     return assignStuSearch;
		     } 
		     
	
		    
	   }
	   
	   @RequestMapping("assignStuSaveFile.do")
	   @ResponseBody //json 반환타입 return타입이 map이 json으로 바뀌게된다. -- body영역에 html이 아니라 데이터를 넘겨주겠다.
	   public Map<String, Object> assignStuSaveFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".assignStuSaveFile");
	      logger.info("   - paramMap : " + paramMap); 
	      
	 
	      
	     

	     //action I- insert U-update ; param에서 꺼내야함.
	      String action = (String) paramMap.get("action");
	     
	      paramMap.put("loginID", (String) session.getAttribute("loginId")); //쿼리문에서 필요함..

	      logger.info("=====assignStuSaveFile의 파라미터=====" + paramMap);
	      int returnVal = 0;
	      
	      //TODO: 기간 체크해보자..
	      String assign_due = (String) paramMap.get("assign_due");
	      String assign_start = (String) paramMap.get("assign_start");
	      
	      String start_assign = assign_start+ " 00:00:00";
	      String end_assign = assign_due+ " 24:00:00";
	      
	      logger.info("==========Date assign_due ======" + assign_due );
	      logger.info("==========Date assign_start ======" + assign_start );
	      
	      SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	      Date startDate =sDate.parse(start_assign);
	      SimpleDateFormat eDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	      Date endDate = eDate.parse(end_assign);
	      Date nowDate = new Date();
	      logger.info("시작시간보다 이른지??" +nowDate.before(startDate));
	      logger.info("마감시간보다 늦은지??" +nowDate.after(endDate));
	      if(nowDate.before(startDate) || nowDate.after(endDate) ){
	    	  returnVal = -5;	    	 
	      }
	      
	    
	      else if("I".equals(action)) {
	    	  returnVal=  supassService.assignStudentInsertFile(paramMap, request); 
	    	  logger.info("=============stufileInsert후 returnVal값은??===" + returnVal);
	      } else if ("U".equals(action)){
	    	  returnVal=  supassService.assignStudentUpdateFile(paramMap, request); 
	      } else if ("D".equals(action)){
	    	  returnVal=  supassService.assignStudentDeleteFile(paramMap); 
	      }
	      
	      //NoticeModel noticeSearch = mngNotService.noticeSave(paramMap); 
	     //insert 성공  에러 -1
	     

	     
	     //return할 map을 초기화해서 선언한다.
	     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
	     
	     
	     returnMap.put("returnVal", returnVal); //VO 전체제이슨 안에 JSON이 또들어간 형태..
	     
	     
	      logger.info("+ End " + className + ".assignStuSaveFile");

	      return returnMap;       //user/mngNot/noticelistgrd.jsp
	   }
	   
	   
	   
	   @RequestMapping("submitList.do")
	   public String submitList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".submitList");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      logger.info("  제출명단  paramMap==========================: " + paramMap);
	     int pageNum = Integer.parseInt((String) paramMap.get("pageNum")); //map으로 꺼내받을떄 숫자형으로 계산해야한다.
	     int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	     
	     int pageIndex = (pageNum - 1) * pageSize;

	    
	     paramMap.put("pageSize", pageSize);
	     paramMap.put("pageIndex", pageIndex);
	     
	 //    String userType = session.getAttribute("userType").toString();
		    
	
	     //************선생님일 경우에 loginId를 lec_prof라고 넣어주자*****/
		     
		     paramMap.put("loginID",(String) session.getAttribute("loginId"));
		     logger.info("   - paramMap ????????????????????????: " + paramMap); 
	    
		     List<AssignmentModel> submitList = supassService.assignSubmitList(paramMap);		 
		     model.addAttribute("submitList", submitList);
		     
		     int totalCnt = supassService.countAssignSubmitList(paramMap);
		     model.addAttribute("totalCnt", totalCnt);
		    
	 
	     
	     
	     
	      logger.info("+ End " + className + ".submitList");

	  
	      return "supass/submitStudentlistgrd"; 
	   	}   
	   
	   
	   
		 //한건조회
	   @RequestMapping("submitContent.do")
	   @ResponseBody //json 반환타입 return타입이 map이 json으로 바뀌게된다. -- body영역에 html이 아니라 데이터를 넘겨주겠다.
	   public Map<String, Object> submitContent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".submitContent");
	  
	      

	      logger.info("★★★★★★★★★제출명단 상세내용 selectone이 호출되었다.★★★★★★★★★");
	      paramMap.put("loginID",(String) session.getAttribute("loginId"));
	      logger.info("   - paramMap : " + paramMap); //ajax param
	  
	   
	     	AssignmentModel  submitSelectone = supassService.submitStuSelectOne(paramMap);
	     	
	     	logger.info("한건 조회해서 온 결과 = " + submitSelectone);
	
	    		 
	     //return할 map을 초기화해서 선언한다.
	     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
	     
	     
	     returnMap.put("submitSelectone", submitSelectone); //VO 전체제이슨 안에 JSON이 또들어간 형태..
	     
	     
	      logger.info("+ End " + className + ".submitContent");

	      return returnMap;       //user/mngNot/noticelistgrd.jsp
	   }
	   
	   
}
