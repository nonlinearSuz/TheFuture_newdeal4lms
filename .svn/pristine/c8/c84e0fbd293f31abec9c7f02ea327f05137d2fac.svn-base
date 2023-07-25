package kr.happyjob.study.supntc.controller;

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

import kr.happyjob.study.supntc.model.NoticeModel;
import kr.happyjob.study.supntc.service.SupNtcService;

@Controller
@RequestMapping("/supntc/")
public class SupNtcController {
	
	@Autowired
	SupNtcService supNtcService;
	
	//logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	private final String className = this.getClass().toString();
	
	//화면
	@RequestMapping("notice.do")
	public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".notice");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".notice");

		return "supntc/noticelist";
	}
	
		@RequestMapping("noticelist.do")
	   public String noticelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      logger.info("+ Start " + className + ".noticelist");
	      logger.info("   - paramMap : " + paramMap);
	      
	      // page 기능 부분 - noticelistgrd가 담당
	      int pagenum = Integer.parseInt((String) paramMap.get("pagenum")); // 1
	      int pageSize = Integer.parseInt((String) paramMap.get("pageSize")); // 10
	      int pageindex = (pagenum - 1) * pageSize;
	      
	      paramMap.put("pageSize", pageSize);
	      paramMap.put("pageindex", pageindex);
	      
	      // 동작 순서 : Controller  -> Service  -> Dao  -> SQL
	      List<NoticeModel> noticesearchlist = supNtcService.noticelist(paramMap);
	      int totalCnt = supNtcService.countnoticelist(paramMap);
	      
	      //model에 data 담기 위해 addAttribute 사용
	      model.addAttribute("noticesearchlist", noticesearchlist); 
	      model.addAttribute("totalCnt", totalCnt);
	        
	      logger.info("+ End " + className + ".noticelist");

	      return "supntc/noticelistgrd";
	   }
		
		// 상세 조회
		@RequestMapping("noticeselectone.do")
		@ResponseBody
		public Map<String, Object> noticeselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".noticeselectone");
			logger.info(" -paramMap : " + paramMap);
			
			// 공지사항 조회
			NoticeModel noticesearch = supNtcService.noticeselectone(paramMap);
			
			String loginID = (String) session.getAttribute("loginId");
			model.addAttribute("loginId", loginID);
			
			// 조회수 증가
			if(noticesearch != null) {
				supNtcService.updateViewCnt(noticesearch.getNt_no());
			}
			
			Map<String, Object> returnMap = new HashMap<String, Object> ();
			
			returnMap.put("noticesearch", noticesearch);
			
			logger.info("+ End " + className + ".noticeselectone");
			
			return returnMap;
		}
		
		
		//게시글 save
		@RequestMapping("noticesave.do")
		@ResponseBody
		public Map<String, Object> noticeSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".noticeSave");
			logger.info(" - paramMap : " + paramMap);
			
			String action = (String) paramMap.get("action");
			
			paramMap.put("loginId", (String) session.getAttribute("loginId"));
			
			int returnval = 0;
			
			if("I".equals(action)) {
				returnval = supNtcService.insert(paramMap);
			} else if("U".equals(action)) {
				returnval = supNtcService.update(paramMap);
			} else if("D".equals(action)) {
				returnval = supNtcService.delete(paramMap);
			}
			
			Map<String, Object> returnMap = new HashMap<String, Object> ();
			
			returnMap.put("returnval", returnval);
			
			logger.info("+ End " + className + ".noticeSave");
			
			return returnMap;
		}
}
