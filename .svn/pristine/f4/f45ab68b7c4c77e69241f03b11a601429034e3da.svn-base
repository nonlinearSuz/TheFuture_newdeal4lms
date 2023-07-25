
package kr.happyjob.study.admmtd.controller;


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



import kr.happyjob.study.admmtd.model.ResourceModel;
import kr.happyjob.study.admmtd.service.AdmMtdService;

@Controller
@RequestMapping("/admmtd/")
public class AdmMtdController {
   
   @Autowired
   AdmMtdService admMtdService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 초기화면
    */
   @RequestMapping("resource.do")
   public String resource(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".resource");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".resource");

      return "admmtd/resourcelist";
   }
       
   
   
   /** 목록 리스트 */
   
   @RequestMapping("resourcelist.do")
   public String resourcelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".resourcelist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      List<ResourceModel> resourcesearchlist = admMtdService.resourcelist(paramMap);
      int totalcnt = admMtdService.countresourcelist(paramMap);
      
      model.addAttribute("resourcesearchlist", resourcesearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      logger.info("+ End " + className + ".resourcelist");

      return "admmtd/resourcelistgrd";
   }
   
   
  
  
   
   
   
   
   /** 한개의 장비 조회  */
   
   @RequestMapping("resourceselectone.do")
   @ResponseBody
   public Map<String, Object> resourceselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".resourceselectone");
      logger.info("   - paramMap : " + paramMap);
      

      ResourceModel resourcesearch = admMtdService.resourceselectone(paramMap);
      
      Map<String, Object> returnmap = new HashMap<String, Object>();
      
      returnmap.put("resourcesearch", resourcesearch);
      
      logger.info("+ End " + className + ".resourceselectone");

      return returnmap;
   }   
   
   

   
   
   /** 장비 저장 */
   
   @RequestMapping("itemsave.do")
   @ResponseBody
   public Map<String, Object> itemsave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".itemsave");
      logger.info("   - paramMap : " + paramMap);
      
      String action = (String) paramMap.get("action");
      
      paramMap.put("loginid", (String) session.getAttribute("loginId"));
           
      
      int returncval = 0;
      
      if("I".equals(action)) {
    	  returncval = admMtdService.iteminsert(paramMap);
    	  
      } else if("U".equals(action)) {
    	  returncval = admMtdService.itemupdate(paramMap);
    	  
      } else if("D".equals(action)) {
    	  returncval =admMtdService.itemdelete(paramMap);
      }      
      
      Map<String, Object> returnmap = new HashMap<String, Object>();
      
      returnmap.put("returncval", returncval);
      
      logger.info("+ End " + className + ".itemsave");

      return returnmap;
   }    
   
   
  
   
  
      
}