package kr.happyjob.study.admstd.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.admhrd.model.TeacherModel;
import kr.happyjob.study.admstd.model.StudentModel;
import kr.happyjob.study.admstd.service.AdmStdService;
import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.system.model.ComnDtlCodModel;

@Controller
@RequestMapping("/admstd/")
public class AdmStdController {
   
   @Autowired
   AdmStdService admStdService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   /**
    * 초기화면
    *  "student.do" 요청이 발생하면 "admstd/studentlist"라는 뷰 페이지를 표시
    *  Model model: 데이터를 뷰로 전달하기 위한 Spring의 Model 객체입니다.
    * @RequestParam Map<String, Object> paramMap: 요청에서 전달된 파라미
    * 터를 담고 있는 Map 객체입니다.
    * HttpServletRequest request: HTTP 요청 객체입니다.
    * HttpServletResponse response: HTTP 응답 객체입니다.
    * HttpSession session: HTTP 세션 객체입니다.
    */
   @RequestMapping("student.do")
   public String student(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      return "admstd/studentlist";
   }
   
   // 학생 목록 
   @RequestMapping("studentlist.do")
   public String studentlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;  
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      List<StudentModel> studentsearchlist = admStdService.studentlist(paramMap);
      int totalcnt = admStdService.countstudentlist(paramMap);
      
      model.addAttribute("studentsearchlist", studentsearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      return "admstd/studentlistgrd";
   }
   
   // 한 건 조회
   @RequestMapping("studentselectone.do")   
   public String studentselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      StudentModel studentsearch = admStdService.studentselectone(paramMap);
	      List<StudentModel> stdleclist = admStdService.studentselectonelec(paramMap);
	      // 강의목록  LIST    leclist 
	      model.addAttribute("studentsearch",studentsearch);   
	      model.addAttribute("stdleclist",stdleclist);
	      
	      return "admstd/studentleclistgrd";
	   }   
   
   // 회원정보(비고) 수정 
   @RequestMapping("userEtc.do")
   public void userEtc(@RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
	   
	      logger.info("+ Start " + className + ".notice");
	      logger.info("   - paramMap : " + paramMap);
	      logger.info("+ End " + className + ".notice");
	      
	   admStdService.userEtc(paramMap);
   }
   
   //승인여부
   @RequestMapping("approval.do")
   public void approval(@RequestParam String loginID, HttpServletRequest request, 
		   HttpServletResponse response, HttpSession session) throws Exception {
	   admStdService.approval(loginID);
   }
   
   // 회원탈퇴
   @RequestMapping("studentWithdrawal.do")
   public void teacherWithdrawal(@RequestParam String loginID, HttpServletRequest request, 
		   HttpServletResponse response, HttpSession session) throws Exception {
	  
	   admStdService.studentWithdrawal(loginID);
   }
}