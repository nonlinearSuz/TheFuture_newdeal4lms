package kr.happyjob.study.exmrex.controller;

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
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.exmrex.model.GradeModel;
import kr.happyjob.study.exmrex.service.ExmRexService;

@Controller
@RequestMapping("/exmrex/")
public class ExmRexController {
   
   @Autowired
   ExmRexService exmRexService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();

   @RequestMapping("grade.do")
   public String grade(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".notice");
      logger.info("   - paramMap : " + paramMap);
      logger.info("+ End " + className + ".notice");
      
      String loginID = (String) session.getAttribute("loginId");
      paramMap.put("loginID", loginID);
      
      List<GradeModel> lectureList = exmRexService.getLectureList(paramMap);
      model.addAttribute("lectureList", lectureList);

      return "exmrex/gradelist";
   }
       
/*    gradelit.do 요청을 처리하여 성적조회에 필요한 데이터를 조회하고
    조회 결과와 총 개수를 모델에 담아 gradelistgrd.jsp로 전달하는 역할*/
   @RequestMapping("gradelist.do")
   public String gradelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".gradelist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;  
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // Controller  Service  Dao  SQL
      List<GradeModel> gradesearchlist = exmRexService.gradelist(paramMap);
      int totalcnt = exmRexService.countgradelist(paramMap);
      System.out.println("totalcnt : " + totalcnt);
      model.addAttribute("gradesearchlist", gradesearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      logger.info("+ End " + className + ".gradelist");

      return "exmrex/gradelistgrd";
   }
   

   
   // 한 건 조회
   @RequestMapping("gradeselectone.do")   public String gradeselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".gradeselectone");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;  
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // Controller  Service  Dao  SQL
    /* GradeModel gradesearch = exmRexService.gradeselectone(paramMap);*/
      List<GradeModel> gradesearchlist = exmRexService.gradeselectonelec(paramMap);
      
      int totalleccnt = exmRexService.countgradeleclist(paramMap);
      System.out.println("totalleccnt : " + totalleccnt);
      model.addAttribute("totalleccnt", totalleccnt);
      // 강의목록  LIST    leclist 
      model.addAttribute("gradesearchlist",gradesearchlist);
      
      logger.info("+ End " + className + ".gradeselectone");
      System.out.println("totalleccnt : " + totalleccnt);
      System.out.println("pagenum : " + pagenum);
      System.out.println("pageindex : " + pageindex);
      return "exmrex/gradestdlistgrd";
   }   
   
      
}