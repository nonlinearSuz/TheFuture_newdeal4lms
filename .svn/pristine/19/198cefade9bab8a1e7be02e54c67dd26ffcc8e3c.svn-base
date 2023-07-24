package kr.happyjob.study.supmtb.controller;

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

import kr.happyjob.study.supmtb.model.MyTableModel;
import kr.happyjob.study.supmtb.service.SupmtbService;

@Controller
@RequestMapping("/supmtb/")
public class SupmtbController {
	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   @Autowired
	   SupmtbService supmtbService;
	   
	   /**
	    * 초기화면
	    */
	   @RequestMapping("mytable.do")
	   public String mytable(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".mytable");
	      logger.info("   - paramMap : " + paramMap);
	  
	      String user_id = (String) session.getAttribute("loginId");

	      
	      
	      logger.info("+ End " + className + ".mytable");

	      return "supmtb/mytblist"; 
	   }
	   
	   @RequestMapping("/mytablelist") 
	   @ResponseBody
		public Map<String, Object> mytablelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception {

			
		      logger.info("+ Start " + className + ".mytablelist");
		      paramMap.put("loginID", (String) session.getAttribute("loginId"));
		      logger.info("   - paramMap : " + paramMap); 
		      
	
			List<MyTableModel> timeTblLists = supmtbService.lecTimeList(paramMap);
		
			
			System.out.println(timeTblLists);
			for(int i=0; i<timeTblLists.size(); i++){
				logger.info("===출력====" +(timeTblLists.get(i)));
				int startTime = timeTblLists.get(i).getStartTime();
				int endTime = timeTblLists.get(i).getEndTime();
			}
	
			logger.info("갖고 온 데이터 = " + timeTblLists);
			 Map<String, Object> returnMap = new HashMap<String, Object>(); //new Map<>(); 로 초기화가 불가능하다??
			  returnMap.put("timeTblLists", timeTblLists);
			
			  logger.info("+ End " + className + ".mytablelist");
			return returnMap;
		}
	   
}
