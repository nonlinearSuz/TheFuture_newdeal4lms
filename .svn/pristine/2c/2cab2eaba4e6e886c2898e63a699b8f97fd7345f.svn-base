package kr.happyjob.study.exmexm.controller;


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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import kr.happyjob.study.exmexm.model.ExamManageModel;
import kr.happyjob.study.exmexm.service.ExmExmService;

@Controller
@RequestMapping("/exmexm/")

public class ExmExmController {
   
   @Autowired
   ExmExmService exmexmService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   
   
   
   
   /**
    * 초기화면
    */
   @RequestMapping("examManage.do")
   public String exam(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".exam");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".exam");

      return "exmexm/testlist";
   }
       
   
   
   /** 시험 목록 리스트 조회 */
   
   @RequestMapping("testlist.do")
   public String examlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".examlist");
      logger.info("   - paramMap : " + paramMap);
      
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
      
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
      
      List<ExamManageModel> examsearchlist = exmexmService.examlist(paramMap);	
      int totalexam = exmexmService.countexamlist(paramMap);
      
      model.addAttribute("examsearchlist", examsearchlist);
      model.addAttribute("totalexam", totalexam);
      
      
      logger.info("+ End " + className + ".examlist");

      return "exmexm/testlistgrd";
   }
   
   
   
   
   /** 한개의 시험 조회  */
   
   @RequestMapping("examselectone.do")
   @ResponseBody
   public Map<String, Object> examselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
   HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".examselectone");
      logger.info("   - paramMap : " + paramMap);
           

      ExamManageModel examsearch = exmexmService.examselectone(paramMap);
      
      Map<String, Object> returnmap = new HashMap<String, Object>();
      
      returnmap.put("examsearch", examsearch);
      
      logger.info("+ End " + className + ".examselectone");

      return returnmap;
   }   
   
   
   
   
   /** 시험 저장 */
   
   @RequestMapping("examsave.do")
   @ResponseBody
   public Map<String, Object> examsave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".examsave");
      logger.info("   - paramMap : " + paramMap);
      
      String action = (String) paramMap.get("action");
      
      paramMap.put("loginid", (String) session.getAttribute("loginId"));
           
      
      int returncval = 0;
      
      if("I".equals(action)) {
    	  returncval = exmexmService.examinsert(paramMap);
    	  
      } else if("U".equals(action)) {
    	  returncval = exmexmService.examupdate(paramMap);
    	  
      } else if("D".equals(action)) {
    	  returncval =exmexmService.examdelete(paramMap);
      }      
      
      Map<String, Object> returnmap = new HashMap<String, Object>();
      
      returnmap.put("returncval", returncval);
      
      logger.info("+ End " + className + ".examsave");

      return returnmap;
   }    
   
   
   
   
   
   /** 시험 상세 목록 리스트 조회 */
   
   @RequestMapping("examdetail.do")
   public String examdetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".examdetail");
      logger.info("   - paramMap : " + paramMap);
      
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
      
      List<ExamManageModel> examdetaillist = exmexmService.examdetail(paramMap);	
      int totalque = exmexmService.countquelist(paramMap);
      
      model.addAttribute("examdetaillist", examdetaillist);
      model.addAttribute("totalque", totalque);
      
      
      logger.info("+ End " + className + ".examdetail");

      return "exmexm/testdetailgrd";
   }
   
   
   
   /** 한개의 상세 시험 조회  */
   
   @RequestMapping("examdetailone.do")
   @ResponseBody
   
   public Map<String, Object> examdetailone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".examdetailone");
      logger.info("   - paramMap : " + paramMap);
      

      ExamManageModel examdetailsearch = exmexmService.examdetailone(paramMap);
      
      Map<String, Object> returnmap = new HashMap<String, Object>();
      
      returnmap .put("examdetailsearch", examdetailsearch); 
      
      logger.info("+ End " + className + ".examdetailone");

      return returnmap ;
   }   
   
   
   /** 시험 문항 저장 */
   
   @RequestMapping("quesave.do")
   @ResponseBody
   public Map<String, Object> quesave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".quesave");
      logger.info("   - paramMap : " + paramMap);
      
      String action = (String) paramMap.get("action");
      
      paramMap.put("loginid", (String) session.getAttribute("loginId"));
           
      
      int returnvalQ = 0;
      
      if("I".equals(action)) {
    	  returnvalQ = exmexmService.queinsert(paramMap);
    	  
		      } else if("U".equals(action)) {
		    	  returnvalQ = exmexmService.queupdate(paramMap);
		    	  
		      } else if("D".equals(action)) {
		    	  returnvalQ =exmexmService.quedelete(paramMap);
		      }      
		      
		      Map<String, Object> returnmap = new HashMap<String, Object>();
		      
		      returnmap.put("returnvalQ", returnvalQ);
		      
		      logger.info("+ End " + className + ".quesave");
		
		      return returnmap;
   }    
   

 
   
   
   
   
}
   




   