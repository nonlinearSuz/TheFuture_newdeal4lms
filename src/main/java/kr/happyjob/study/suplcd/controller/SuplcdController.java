package kr.happyjob.study.suplcd.controller;

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

import kr.happyjob.study.suplcd.model.LectureDtPlanModel;
import kr.happyjob.study.suplcd.service.SuplcdService;
import kr.happyjob.study.suplct.model.LectureModel;
import kr.happyjob.study.suplct.service.SuplctService;




@Controller
@RequestMapping("/suplcd/")
public class SuplcdController {
   
	@Autowired
	SuplcdService suplcdService;
	@Autowired
	SuplctService suplctService;
	
	//Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	//Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 *강의 계획서 초기화면
	 */
	@RequestMapping("lecturePlan.do")
	public String lecturePlan(Model model, @RequestParam Map<String,Object> paramMap, HttpServletRequest request,
		HttpServletResponse response, HttpSession session) throws Exception{
	
		
		logger.info("+ Start " + className + ".lecturePlan");
        logger.info("   - paramMap : " + paramMap);
      
        logger.info("+ End " + className + ".lecturePlan");
		
		
		return "suplcd/lecturePlanList";
	}
	
	/** 자신의 강의 리스트 화면*/
	@RequestMapping("lecturePlanList.do")
	public String totalLecPlanList(Model model,@RequestParam Map<String,Object> paramMap,HttpServletRequest request,
			HttpServletResponse response,HttpSession session) throws Exception {
		
		  paramMap.put("prof_id",session.getAttribute("loginId"));
		  
		  logger.info("+ Start " + className + ".lecturePlanListlist");
	      logger.info("   - paramMap : " + paramMap);
	      logger.info("★★★★★★★★★현재 접속한 사람의 유저타입 : "+ session.getAttribute("userType")); // T: 강사 || S: 학생 || M :관리자
	      
	      
	      /**공통 페이징 처리 */
	      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
	      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
	      int pageindex = (pagenum - 1) * pageSize;
	      
	      paramMap.put("pageSize", pageSize);
	      paramMap.put("pageindex", pageindex);
	      
	      
	     /** 리턴 페이지 처리 */
			String returnpage = "";
			
		 /**유저타입 세션에서 가져와서 선언 */
		 String userType = session.getAttribute("userType").toString();   
		
		 /** 로그인 아이디 세션에서 가져와서 선언 */
		 String loginID = (String) session.getAttribute("loginId");
		
			
		     if("T".equals(userType)){ //강사일 경우 
		    	 paramMap.put("loginID", loginID);
		    	 
		    	 logger.info(" ++++ 강사 입니다.++++");
		    	  paramMap.put("loginID",loginID);  
		    	  List<LectureDtPlanModel> profLecPlanList = suplcdService.profLecPlanList(paramMap);
			      int totalcnt = suplcdService.cntProfLecPlanList(paramMap);
			      
			      model.addAttribute("profLecPlanList", profLecPlanList);
			      model.addAttribute("totalcnt", totalcnt);
			      logger.info("+ totalcnt " + totalcnt + "개 가져옴~ " +".lecturePlanList");
			      
			      returnpage = "suplcd/proflectureListgrd";
		    	
		      }else { // "M" 관리자일경우
		    	  paramMap.put("loginID", loginID);
		    	  
		    	  logger.info(" ++++ 관리자 입니다.++++");
		    	  paramMap.put("loginID",loginID);  
		    	  List<LectureDtPlanModel> masLecPlanList = suplcdService.totalLecPlanList(paramMap);
			      int totalcnt = suplcdService.cntLecPlanList(paramMap);
			      
			      model.addAttribute("masLecPlanList", masLecPlanList);
			      model.addAttribute("totalcnt", totalcnt);
			      logger.info("+ totalcnt " + totalcnt + "개 가져옴~ " +".lecturePlanList");
			      
			      returnpage = "suplcd/lecturePlanListgrd";
		      }
	
	    
	      logger.info("+ End " + className + ".lecturePlanList");
	      

	      return returnpage;  
	}
	
	/**강의 하나 선택시 - 상세계획서 노출 */
	   @RequestMapping("lectureSelectOne.do")
	   @ResponseBody
	   	public Map<String, Object> lectureselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
		   		logger.info("+ Start " + className + ".lectureDtSelectOne");
		   		logger.info("   - paramMap : " + paramMap);
		   		logger.info("lectureSelectOne paramMap================="+ paramMap);
	      
	      // Controller  Service  Dao  SQL
	      LectureDtPlanModel lectureDtInfor = suplcdService.lectureDtselectone(paramMap);
	      
	      Map<String, Object> returnmap = new HashMap<String, Object>();
	      
	      returnmap.put("lectureDtInfor", lectureDtInfor);
	      
	      
	      logger.info("+ End " + className + ".lectureDtSelectOne");

	      return returnmap;
	   } 
	
	
	   /** 강의 상세 계획서 수정 등록  */
	   @RequestMapping("lectureDtSave.do")
	   @ResponseBody
	    public Map<String, Object> lectureAdd(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	       HttpServletResponse response, HttpSession session) throws Exception {
	   
	 	   logger.info("+ Start " + className + ".lectureDtSave(withFile)");
	 	   logger.info("   - paramMap : " + paramMap);
	 	   logger.info("============paramMap lectureDtSave=============" + paramMap);
	 	   
	 	   String action = (String) paramMap.get("action");
	 	   
	 	   paramMap.put("loginid", (String) session.getAttribute("loginId"));
	 	   
	 	   
	 	   int returnCheckVal = 0;
	 	   
	 	   if("U".equals(action)) {
	 		  returnCheckVal = suplcdService.lectureDtUpdate(paramMap,request); 
	 	   } else if("I".equals(action)) {
	 		  returnCheckVal = suplcdService.lectureDtInsert(paramMap,request);
	 	   } else if("D".equals(action)) {
	 		  returnCheckVal = suplcdService.lectureDtDelete(paramMap);  
	 	   }      
	 	   
	 	   Map<String, Object> returnmap = new HashMap<String, Object>();
	 	   
	 	   returnmap.put("returnCheckVal", returnCheckVal);
	 	   
	 	   logger.info("+ End " + className + ".lectureDtSave(withFile)");
	 	
	 	   return returnmap;
	   }    
	
	
	
	/*[관리자]강의 승인 */
	   @RequestMapping("lecApprove.do")
		@ResponseBody
		public Map<String, Object> del_lec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".delLec");
			logger.info("   - paramMap : " + paramMap);
			logger.info("==========del Lec.do Controller ===");

		   paramMap.put("loginid", (String) session.getAttribute("loginId"));
		
		
		      int returnvalue = 0;
		
		      returnvalue = suplcdService.lecApprovUpdate(paramMap);      
		
		      Map<String, Object> returnmap = new HashMap<String, Object>();
		
		      returnmap.put("returnvalue", returnvalue);

			
			logger.info("+ End " + className + ".delLec");
			
			return returnmap;
		}
	   
	   /**파일 다운로드 */
	   @RequestMapping("downloadLectureFile.do")
		public void downloadBbsAtmtFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
		
			logger.info("+ Start " + className + ".downloadBbsAtmtFil");
			logger.info("   - paramMap : " + paramMap);
			
			// 첨부파일 조회
			LectureDtPlanModel lectureDtInfor = suplcdService.lectureDtselectone(paramMap); // file 이름    , 물리경로
			
			byte fileByte[] = FileUtils.readFileToByteArray(new File(lectureDtInfor.getFile_physic_path())); // 다운로드 하기 위해서 fileByte[]
			
			response.setContentType("application/octet-stream");// hearder에 넣는 값으로 
		    response.setContentLength(fileByte.length);
		    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(lectureDtInfor.getFile_name(),"UTF-8")+"\";");
		    response.setHeader("Content-Transfer-Encoding", "binary");
		    response.getOutputStream().write(fileByte);
		     
		    response.getOutputStream().flush();
		    response.getOutputStream().close();

			logger.info("+ End " + className + ".downloadBbsAtmtFil");
		}
	   //approveCondition
		/*[관리자]강의 승인반려 조건 검사 */
	   @RequestMapping("approveCondition.do")
		@ResponseBody
		public Map<String, Object> approveCondition(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".approveCondition");
			logger.info("   - paramMap : " + paramMap);
			logger.info("==========del Lec.do Controller ===");

		   paramMap.put("loginid", (String) session.getAttribute("loginId"));
		
		   //paramMap : lec_no
		    int lec_no = Integer.parseInt((String)paramMap.get("lec_no"));
		    //강의시작시간 조회
		    LectureModel lectureSelectOne=suplctService.lectureselectone(paramMap);
		    String lec_start = lectureSelectOne.getLec_start();//문자열
		    logger.info("강의시작시간 ==" + lec_start); //2023-06-12
		    //현재시간 비교
		  
		    SimpleDateFormat eDate = new SimpleDateFormat("yyyy-MM-dd");
			 
			   Date startDate =eDate.parse(lec_start); //Sun Jul 02 00:00:00 KST 2023
			   Date nowDate = new Date();  
			   logger.info(" //지금시간이 시작날짜보다 늦은지" + nowDate.after(startDate)); 
			   //늦으면 승인반려불가.
			   
			   int returnvalue = 0;
			   
			   if(nowDate.after(startDate)){ // 상태변경 불가
				   logger.info("강의 상태 변경 불가"); 
				   returnvalue = -2;
			   } else if(nowDate.before(startDate) || nowDate.equals(startDate)){ //상태 변경 가능
				 	returnvalue = suplcdService.lecApprovUpdate(paramMap);      
									   
			   }
			   Map<String, Object> returnmap = new HashMap<String, Object>();
				
			     returnmap.put("returnvalue", returnvalue); 
		    
			logger.info("+ End " + className + ".approveCondition");
			
			return returnmap;
		}
	
}