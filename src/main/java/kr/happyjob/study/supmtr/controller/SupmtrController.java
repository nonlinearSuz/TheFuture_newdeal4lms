package kr.happyjob.study.supmtr.controller;

import java.io.File;
import java.net.URLEncoder;
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

import kr.happyjob.study.login.model.UsrMnuAtrtModel;

import kr.happyjob.study.supmtr.model.LectureModel;
import kr.happyjob.study.supmtr.model.StudyFileModel;
import kr.happyjob.study.supmtr.service.SupmtrService;

@Controller
@RequestMapping("/supmtr/")
public class SupmtrController {

	@Autowired
	SupmtrService supmtrService;
	
	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   
	   //주석!!
	   
	   /**
	    * 초기화면
	    */
	   @RequestMapping("studySupport.do")
	   public String studySupport(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".studySupport");
	      logger.info("   - paramMap : " + paramMap);
	  
	      String user_id = (String) session.getAttribute("loginId");
	      //System.out.println("세션에서 받은 user_id = " + user_id);
	      
	      
	      logger.info("+ End " + className + ".studySupport");

	      return "supmtr/supportlist"; //web-inf/views/noticelist.jsp
	   }
	   
	   @RequestMapping("studySupportvue.do")
	   public String studySupportvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".studySupportvue");
	      logger.info("   - paramMap : " + paramMap);
	  
	      String user_id = (String) session.getAttribute("loginId");
	      //System.out.println("세션에서 받은 user_id = " + user_id);
	      
	      
	      logger.info("+ End " + className + ".studySupportvue");

	      return "supmtr/supportlistvue"; //web-inf/views/noticelist.jsp
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
	     
	    // if(userType.equals("T")) NullPointerException 방지하기위해서
	     if( "T".equals(userType) ){ //(userType == "T" ) 자바가 잘 비교하지못한다.
	        List<LectureModel> selectBoxList = supmtrService.selectBoxSet(paramMap); 
	 	     logger.info("==========selectBoxList" + selectBoxList);
	 	     for(LectureModel list : selectBoxList){
	 	    	 
	 	    	 logger.info("조회해온 list = " + list);
	 	     }
	 	    model.addAttribute("selectBoxList", selectBoxList);
	     } else {
	    	 logger.info("============학생인 경우에============selectBoxSetStudent====");
	    	List<LectureModel> selectBoxList = supmtrService.selectBoxSetStudent(paramMap);
	    	model.addAttribute("selectBoxList", selectBoxList);
	     }
	     
	     
	     
	     
	      logger.info("+ End " + className + ".selectList");

	      return "supmtr/selectboxlist";  
	      //user/mngNot/noticelistgrd.jsp
	   }
	   
	   
	   @RequestMapping("studyfilelist.do")
	   public String studyfilelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".studyfilelist");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	     
	     int pageNum = Integer.parseInt((String) paramMap.get("pageNum")); //map으로 꺼내받을떄 숫자형으로 계산해야한다.
	     int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	     
	     int pageIndex = (pageNum - 1) * pageSize;

	    
	     paramMap.put("pageSize", pageSize);
	     paramMap.put("pageIndex", pageIndex);
	     
	     String userType = session.getAttribute("userType").toString();
		    
	     if( "T".equals(userType) ){
	     //************선생님일 경우에 loginId를 lec_prof라고 넣어주자*****/
	     
	     paramMap.put("lec_prof",(String) session.getAttribute("loginId"));
	     logger.info("   - paramMap ????????????????????????: " + paramMap); 
    
	     List<StudyFileModel> stufileSearchList = supmtrService.stufileList(paramMap);		 
	     model.addAttribute("stufileSearchList", stufileSearchList);
	     int totalCnt = supmtrService.countStufileList(paramMap);
	     model.addAttribute("totalCnt", totalCnt);
	     } else {
	     
	     //*************학생일경우에 loginId를 loginId로 넣어주자******////////
	     paramMap.put("loginId" ,(String) session.getAttribute("loginId"));
	     List<StudyFileModel> stufileSearchList = supmtrService.stufileListByStudent(paramMap);
	     model.addAttribute("stufileSearchList", stufileSearchList);
	     
	     int totalCnt = supmtrService.countStufileListByStudent(paramMap);
	     model.addAttribute("totalCnt", totalCnt);
	     }
	     
  
	     
	      logger.info("+ End " + className + ".studyfilelist");

	      return "supmtr/supportlistgrd";       //user/mngNot/noticelistgrd.jsp
	    
	   	}   
	   
	   @RequestMapping("studyfilelistvue.do")
	   @ResponseBody
	   public Map<String, Object> studyfilelistvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".studyfilelistvue");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	     
	     int pageNum = Integer.parseInt((String) paramMap.get("pageNum")); //map으로 꺼내받을떄 숫자형으로 계산해야한다.
	     int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	     
	     int pageIndex = (pageNum - 1) * pageSize;

	    
	     paramMap.put("pageSize", pageSize);
	     paramMap.put("pageIndex", pageIndex);
	     
	     Map<String, Object> returnmap = new HashMap<String, Object>();
	     
	     String userType = session.getAttribute("userType").toString();
		    
	     if( "T".equals(userType) ){
		     //************선생님일 경우에 loginId를 lec_prof라고 넣어주자*****/
		     
		     paramMap.put("lec_prof",(String) session.getAttribute("loginId"));
		     logger.info("   - paramMap ????????????????????????: " + paramMap); 
	    
		     List<StudyFileModel> stufileSearchList = supmtrService.stufileList(paramMap);		 
		     returnmap.put("stufileSearchList", stufileSearchList);
		     int totalCnt = supmtrService.countStufileList(paramMap);
		     returnmap.put("totalCnt", totalCnt);
	     } else {
		     
		     //*************학생일경우에 loginId를 loginId로 넣어주자******////////
		     paramMap.put("loginId" ,(String) session.getAttribute("loginId"));
		     List<StudyFileModel> stufileSearchList = supmtrService.stufileListByStudent(paramMap);
		     returnmap.put("stufileSearchList", stufileSearchList);
		     
		     int totalCnt = supmtrService.countStufileListByStudent(paramMap);
		     returnmap.put("totalCnt", totalCnt);
	     }
	     
	      logger.info("+ End " + className + ".studyfilelistvue");

	      return returnmap;       //user/mngNot/noticelistgrd.jsp
	    
	   	}   	   
	   
	   //한건조회
	   @RequestMapping("studyfileSelectOne.do")
	   @ResponseBody //json 반환타입 return타입이 map이 json으로 바뀌게된다. -- body영역에 html이 아니라 데이터를 넘겨주겠다.
	   public Map<String, Object> studyfileSelectOne(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".studyfileSelectOne");
	      logger.info("   - paramMap : " + paramMap); //ajax param
	      

	      logger.info("select one이 호출되었다.★★★★★★★★★★★★★★★★★★");
	     
 
	     	StudyFileModel  stufileSearch = supmtrService.stufileSelectOne(paramMap);
	     	
	     	logger.info("한건 조회해서 온 결과 = " + stufileSearch);
	     

	     //return할 map을 초기화해서 선언한다.
	     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
	     
	     
	     returnMap.put("stufileSearch", stufileSearch); //VO 전체제이슨 안에 JSON이 또들어간 형태..
	     
	     
	      logger.info("+ End " + className + ".studyfileSelectOne");

	      return returnMap;       //user/mngNot/noticelistgrd.jsp
	   }
	   
	   
	   
	   
	   
	   
	   
	   @RequestMapping("studyfileSaveFile.do")
	   @ResponseBody //json 반환타입 return타입이 map이 json으로 바뀌게된다. -- body영역에 html이 아니라 데이터를 넘겨주겠다.
	   public Map<String, Object> studyfileSaveFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".studyfileSaveFile");
	      logger.info("   - paramMap : " + paramMap); //ajax param

	     

	     //action I- insert U-update ; param에서 꺼내야함.
	      String action = (String) paramMap.get("action");
	     
	      paramMap.put("loginId", (String) session.getAttribute("loginId")); //쿼리문에서 필요함..

	      logger.info("=====studyfileSaveFile의 파라미터=====" + paramMap);
	      int returnVal = 0;
	      
	      if("I".equals(action)) {
	    	  returnVal=  supmtrService.stufileInsertFile(paramMap, request); 
	    	  logger.info("=============stufileInsert후 returnVal값은??===" + returnVal);
	      } else if ("U".equals(action)){
	    	  returnVal=  supmtrService.stufileUpdateFile(paramMap, request); 
	      } else if ("D".equals(action)){
	    	  returnVal=  supmtrService.stufileDeleteFile(paramMap); 
	      }
	 
	     //return할 map을 초기화해서 선언한다.
	     Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
	     
	     
	     returnMap.put("returnVal", returnVal); //VO 전체제이슨 안에 JSON이 또들어간 형태..
	     
	     
	      logger.info("+ End " + className + ".studyfileSaveFile");

	      return returnMap;       //user/mngNot/noticelistgrd.jsp
	   }
	   
	   
	   @RequestMapping("downloadnoticefile.do")
		public void downloadnoticefile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {

		   logger.info("+ Start " + className + ".downloadnoticefile");
			logger.info("   - paramMap : " + paramMap);

			logger.info("download~~~~~~~~~~~~~~~~~~~~~~~paramMap = " + paramMap);

		   
			StudyFileModel  stufileSearch = supmtrService.stufileSelectOne(paramMap); //file이름, 물리경로
		   
		   //noticeSearch.getPhysic_path(); //물리경로
		   
		   byte fileByte[] = FileUtils.readFileToByteArray(new File(stufileSearch.getFile_physic_path()));
		   response.setContentType("application/octet-stream");
		    response.setContentLength(fileByte.length);
		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(stufileSearch.getFile_name(),"UTF-8")+"\";");
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
	   // notice no 넘어가면 map으로 받아옴
	   //한건조회 select one 부른다.
	      
	   
	   
	   
	   
	
}
