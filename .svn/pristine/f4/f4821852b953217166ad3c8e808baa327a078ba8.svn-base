package kr.happyjob.study.supAth.controller;

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
import kr.happyjob.study.supAth.model.ApproveModel;
import kr.happyjob.study.supAth.service.SupAthService;

@Controller
@RequestMapping("/supath/")
public class SupAthController {
   
   @Autowired
   SupAthService supAthService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   
   
   /*
    나의 수강 내역 초기화면
    */
   @RequestMapping("approval.do")
   public String approve(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".approval");
    
      
      paramMap.put("loginid", (String) session.getAttribute("loginId"));
      List<ApproveModel> lecsearchlist = supAthService.leclist(paramMap);
      
      model.addAttribute("lecsearchlist", lecsearchlist);
      logger.info("+ End " + className + ".approval");

      return "supAth/approvelist";
   }
     

   	/*
     	수강목록조회
    */
   @RequestMapping("approvalist.do")
   public String approvalist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".approvalist");
      logger.info("   - paramMap : " + paramMap);

      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;

      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      paramMap.put("loginid", (String) session.getAttribute("loginId"));

      // Controller  Service  Dao  SQL
      List<ApproveModel> approvalsearchlist = supAthService.approvalist(paramMap);
      int totalcnt = supAthService.countapprovalist(paramMap);
      
      model.addAttribute("approvalsearchlist", approvalsearchlist);
      model.addAttribute("totalcnt", totalcnt);


      logger.info("+ End " + className + ".approvalist");

      return "supAth/approvelistgrd";
   }
   
     

   /*수강 신청 승인 및 반려*/   
   @RequestMapping("approvelecture.do")
   @ResponseBody
   public Map<String, Object> approvelecture(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".approvemylecture");
      logger.info("   - paramMap : " + paramMap);


      paramMap.put("loginid", (String) session.getAttribute("loginId"));


      int returnvalue = 0;

      returnvalue = supAthService.approvelecture(paramMap);      

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("returnvalue", returnvalue);

      logger.info("+ End " + className + ".approvemylecture");

      return returnmap;
   }


   

   
   
}