package kr.happyjob.study.supMya.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.supMya.model.EnrollModel;
import kr.happyjob.study.supMya.service.SupMyaService;

@Controller
@RequestMapping("/supmya/")
public class SupMyaController {
   
   @Autowired
   SupMyaService supMyaService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   
   
   /*
    나의 수강 내역 초기화면
    */
   @RequestMapping("myLecture.do")
   public String myLecture(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".myLecture");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".myLecture");

      return "supMya/myLecturelist";
   }
     

   	/*
     	수강목록조회
    */
   @RequestMapping("myLecturelist.do")
   public String myLecturelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".myLecturelist");
      logger.info("   - paramMap : " + paramMap);

      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;

      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      paramMap.put("loginid", (String) session.getAttribute("loginId"));

      // Controller  Service  Dao  SQL
      List<EnrollModel> myLecturesearchlist = supMyaService.myLecturelist(paramMap);
      int totalcnt = supMyaService.countmyLecturelist(paramMap);
     

    		  
    		  
      model.addAttribute("myLecturesearchlist", myLecturesearchlist);
      model.addAttribute("totalcnt", totalcnt);


      logger.info("+ End " + className + ".myLecturelist");

      return "supMya/myLecturelistgrd";
   }

   
   
   @RequestMapping("cancelmylecture.do")
   @ResponseBody
   public Map<String, Object> cancelmylecture(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".cancelmylecture");
      logger.info("   - paramMap : " + paramMap);


      paramMap.put("loginid", (String) session.getAttribute("loginId"));


      int returnvalue = 0;

      returnvalue = supMyaService.cancelmylecture(paramMap);      

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("returnvalue", returnvalue);

      logger.info("+ End " + className + ".cancelmylecture");

      return returnmap;
   }
   
   
   
   
   @RequestMapping("applymylecture.do")
   @ResponseBody
   public Map<String, Object> applymylecture(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".applymylecture");
      logger.info("   - paramMap : " + paramMap);


      paramMap.put("loginid", (String) session.getAttribute("loginId"));


      int returnvalue = 0;

      returnvalue = supMyaService.applymylecture(paramMap);      

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("returnvalue", returnvalue);

      logger.info("+ End " + className + ".applymylecture");

      return returnmap;
   }
}