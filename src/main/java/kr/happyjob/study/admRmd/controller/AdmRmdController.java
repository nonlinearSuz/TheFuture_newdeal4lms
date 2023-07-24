package kr.happyjob.study.admRmd.controller;

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
import kr.happyjob.study.admRmd.model.RoomModel;
import kr.happyjob.study.admRmd.service.AdmRmdService;

@Controller
@RequestMapping("/admrmd/")
public class AdmRmdController {
   
	@Autowired
	AdmRmdService admRmdService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 공통코드 관리 초기화면
    */
   @RequestMapping("room.do")
   public String room(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".room");
      logger.info("   - paramMap : " + paramMap);
      
      
      
      logger.info("+ End " + className + ".room");

      return "admRmd/roomlist";
   }
     

   /**
    * 그룹코드 목록조회
    */
   @RequestMapping("roomlist.do")
   public String roomlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".roomlist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;

      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);

      // Controller  Service  Dao  SQL
      List<RoomModel> roomsearchlist = admRmdService.roomlist(paramMap);
      int totalcnt = admRmdService.countroomlist(paramMap);

      model.addAttribute("roomsearchlist", roomsearchlist);
      model.addAttribute("totalcnt", totalcnt);


      
      logger.info("+ End " + className + ".roomlist");

      return "admRmd/roomlistgrd";
   } 

   
   @RequestMapping("selectoneroom.do")
   @ResponseBody
   public Map<String, Object> selectoneroom(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".selectoneroom");
      logger.info("   - paramMap : " + paramMap);

      // Controller  Service  Dao  SQL
      RoomModel roomsearch = admRmdService.selectoneroom(paramMap);
      logger.info("===============================1================================" + paramMap);

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("roomsearch", roomsearch);

      logger.info("+ End " + className + ".selectoneroom");
      logger.info("===============================2================================" + returnmap);

      return returnmap;
   }
   
   @RequestMapping("roomsave.do")
   @ResponseBody
   public Map<String, Object> roomsave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".roomsave");
      logger.info("   - paramMap : " + paramMap);

      String action = (String) paramMap.get("action");


      int returnval = 0;

      if("I".equals(action)) {
    	  returnval = admRmdService.insertroom(paramMap);
      } else if("U".equals(action)) {
    	  returnval = admRmdService.updateroom(paramMap);
      } else if("D".equals(action)) {
    	  returnval = admRmdService.deleteroom(paramMap);
      }
      
      
      Map<String, Object> returnmap = new HashMap<String, Object>();


      returnmap.put("returnval", returnval);
  

      logger.info("+ End " + className + ".roomsave");

      return returnmap;
   }
   
   /**
    * 그룹코드 목록조회
    */
   @RequestMapping("itemlist.do")
   public String itemlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".itemlist");
      logger.info("   - paramMap : " + paramMap);
      
      int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (currentPage - 1) * pageSize;

      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      logger.info("111111111111111111111111111111111111111111111111111111"+ paramMap);
      // Controller  Service  Dao  SQL
      List<RoomModel> itemsearchlist = admRmdService.itemlist(paramMap);
      int totalcount = admRmdService.itemcountlist(paramMap);
    
    		  
      model.addAttribute("itemsearchlist", itemsearchlist);
      model.addAttribute("totalcount", totalcount);

      model.addAttribute("pageSize", pageSize);
      model.addAttribute("currentPageitem", currentPage);


      logger.info("22222222222222222222222222222222222222222222222222222"+ paramMap);

      logger.info("+ End " + className + ".itemlist");

      return "admRmd/itemlistgrd";
   } 

   
   
   ////////////////////////////////////////////////////////////////////////////////////////////////////////
 @RequestMapping("usability.do")
   @ResponseBody
   public Map<String, Object> usability(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".usability");
      logger.info("   - paramMap : " + paramMap);

      // Controller  Service  Dao  SQL
      RoomModel lecview = admRmdService.usability(paramMap);

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("lecview", lecview);

      logger.info("+ End " + className + ".usability");

      return returnmap;
   }
  
   
   
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  
      
}