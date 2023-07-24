package kr.happyjob.study.admhrd.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.admhrd.model.TeacherModel;
import kr.happyjob.study.admhrd.service.AdmHrdService;
import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admhrd/")
public class AdmHrdController {
   
   @Autowired
   AdmHrdService admHrdService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   /**
    * 초기화면
    *  "notice.do" 요청이 발생하면 "mngNot/noticelist"라는 뷰 페이지를 표시
    *  Model model: 데이터를 뷰로 전달하기 위한 Spring의 Model 객체입니다.
    * @RequestParam Map<String, Object> paramMap: 요청에서 전달된 파라미
    * 터를 담고 있는 Map 객체입니다.
    * HttpServletRequest request: HTTP 요청 객체입니다.
    * HttpServletResponse response: HTTP 응답 객체입니다.
    * HttpSession session: HTTP 세션 객체입니다.
    */
   
   /** 초기화면*/
   @RequestMapping("teacher.do")
   public String teacher(Model model	//파라미터로 받아오는 Model,  
		   , @RequestParam Map<String, Object> paramMap	//객체와 요청 파라미터를 저장하는 Map<String, Object> 객체
		   , HttpServletRequest request, HttpServletResponse response,HttpSession session) // HTTP 요청, 응답, 세션 객체
		    throws Exception {
      
      logger.info("+ Start " + className + ".notice");	// 로그를 출력하여 메소드의 시작을 로깅
      logger.info("   - paramMap : " + paramMap);		// 전달받은 요청 파라미터 paramMap을 로깅
      logger.info("+ End " + className + ".notice");		// 로그를 출력하여 메소드의 종료를 로깅

      return "admhrd/teacherlist";
   }
       
   /** 강사 목록 조회*/
   @RequestMapping("teacherlist.do")
	public String teacherlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".teacherlist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;  
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      List<TeacherModel> teachersearchlist = admHrdService.teacherlist(paramMap);
      // 서비스의 teacherlist 메소드를 호출하여 요청 파라미터 기반으로 강사 목록을 조회
     // 조회된 강사 목록은  List<TeacherModel> 타입인 teachersearchlist 에 저장
      
      int totalcnt = admHrdService.countteacherlist(paramMap);
      // 서비스의 countteacherlist 메소드를 호출하여 강사 수를 조회
      // 조회된 강사 수는 int 타입인 totalcnt에 저장

      model.addAttribute("teachersearchlist", teachersearchlist);
      // 조회된 강사목록을 뷰 페이지로 전달하기 위해 model 객체에 teachersearchlist라는 이름으로 
      model.addAttribute("totalcnt", totalcnt);
      
      logger.info("+ End " + className + ".teacherlist");

      return "admhrd/teacherlistgrd";
   }
   
   /**회원 정보(비고) 수정*/
   @RequestMapping("userEtc.do")
   public void userEtc(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
		   HttpServletResponse response, HttpSession session) throws Exception {
	   
	      logger.info("+ Start " + className + ".notice");
	      logger.info("   - paramMap : " + paramMap);
	      logger.info("+ End " + className + ".notice");
	      
	   admHrdService.userEtc(paramMap);
   }
   
   /**승인여부 변경*/
   @RequestMapping("approval.do")
   public void approval(@RequestParam String loginID, HttpServletRequest request, 
		   HttpServletResponse response, HttpSession session) throws Exception {
	  
	   admHrdService.approval(loginID);
   }
   
   /**강사 탈퇴*/
   @RequestMapping("teacherWithdrawal.do")
   public void teacherWithdrawal(@RequestParam String loginID, HttpServletRequest request, 
		   HttpServletResponse response, HttpSession session) throws Exception {
	
	   admHrdService.teacherWithdrawal(loginID);
	   
   }
   
   /**강사 상세정보 한 건 조회 */
   @RequestMapping("teacherselectone.do")   	//  해당 메소드를 "teacherselectone.do" 요청 경로와 매핑
   public String teacherselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".teachereselectone");	//로그를 출력하여 메소드의 시작을 로깅
      logger.info("   - paramMap : " + paramMap);							// 전달받은 요청 파라미터 paramMap을 로깅
      
      TeacherModel teachersearch = admHrdService.teacherselectone(paramMap);
      //admHrdService의 teacherselectone 메소드를 호출하여 특정 강사의 상세 정보를 조회
      //조회된 정보는 TeacherModel 객체인 teachersearch에 저장
      
      List<TeacherModel> leclist = admHrdService.teacherselectonelec(paramMap);
      // 메소드를 호출하여 특정 강사의 강의 목록을 조회합니다
      // 조회된 정보는 List<TeacherModel> 타입인 leclist에 저장
      
      model.addAttribute("teachersearch",teachersearch);   
      //  조회된 강사의 상세 정보를 뷰 페이지로 전달하기 위해 
      // model 객체에 "teachersearch"라는 이름으로 teachersearch 객체를 추가
      
      model.addAttribute("leclist",leclist);
      // 조회된 강사의 강의 목록을 뷰 페이지로 전달하기 위해 
      // model 객체에 "leclist"라는 이름으로 leclist 객체를 추가
      
      logger.info("+ End " + className + ".teacherselectone");		//로그를 출력하여 메소드의 종료를 로깅

      return "admhrd/teacherleclistgrd";
   }   
}