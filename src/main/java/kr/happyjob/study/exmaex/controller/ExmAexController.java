package kr.happyjob.study.exmaex.controller;



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

import kr.happyjob.study.exmaex.dao.ExmAexDao;
import kr.happyjob.study.exmaex.model.AttendExamModel;
import kr.happyjob.study.exmaex.service.ExmAexService;



@Controller
@RequestMapping("/exmaex/")
public class ExmAexController {
   
   @Autowired
   ExmAexService exmaexService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   

   
   /**
    * 초기화면
    * 
    */
   @RequestMapping("/attendExam.do")
   public String attendexam(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".attendexam");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".attendexam");

      return "/exmaex/attendtestlist";
   }
       
   
   
   
   /** 시험 목록 리스트 조회 */
   
   @RequestMapping("/attendtestlist.do")
   public String attendtestlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".attendtestlist");
      logger.info("   - paramMap : " + paramMap);
      
		paramMap.put("loginID", session.getAttribute("loginId"));
		
        int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));	
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));		
		int pageIndex = (pagenum-1)*pageSize;												
      
		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
      
      List<AttendExamModel> testsearchlist = exmaexService.attendtestlist(paramMap);	
      
       
      
      int totalcnt = exmaexService.countattendtestlist(paramMap);
   
      
      model.addAttribute("testsearchlist", testsearchlist);

      model.addAttribute("totalcnt", totalcnt);

      logger.info("+ End " + className + ".attendtestlist");

      return "exmaex/attendtestlistgrd";
   }
   
   
   
   
   
   /** 한개의 시험 응시 클릭시 문제 조회  */
   
	@RequestMapping("/applytest.do")
	public String applytest(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	HttpServletResponse response, HttpSession session)throws Exception{
		
		
		List<AttendExamModel> applytestList = exmaexService.applytest(paramMap);
		
		model.addAttribute("applytestList", applytestList);
		
		String qlist = "";
		
		for(AttendExamModel item : applytestList) {
			int qno = item.getQue_no();
			qlist += String.valueOf(qno) + ",";
		} 
		//예1,2,3,4,6,
		
		model.addAttribute("applytestcnt", applytestList.size());
		model.addAttribute("qlist", qlist);
		

		return "exmaex/applytestlist";
	}
	
	
   
   
   
   /** 시험 응시 결과 제출 */
	@RequestMapping("/testsubmit.do")
	@ResponseBody
	public Map<String, Object> testsubmit(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	HttpServletResponse response, HttpSession session)throws Exception{
	   
		
	      logger.info("+ Start " + className + ".testsubmit");
	      logger.info("   - paramMap : " + paramMap);
	      
	      String action = (String) paramMap.get("action");
	      
	      String answer = (String) paramMap.get("answer");
	      
		paramMap.put("loginID", session.getAttribute("loginId"));
		
		paramMap.put("answer", answer);
		
		
		int qcnt = Integer.parseInt((String) paramMap.get("applytestcnt"));
		
		
		int submit = 0;
		
	    if("I".equals(action)) {
			for(int i=0;i<qcnt;i++) {
				String anstitle = "test" + String.valueOf(i+1);
				
				if(paramMap.get(anstitle)  == null || paramMap.get(anstitle)  == "" ) {
					qcnt++;
					continue;
				}
				
				paramMap.put( "que_no",i+1);
			    paramMap.put( "res_ans",Integer.parseInt((String) paramMap.get("test" + String.valueOf(i+1))));
			    
		    	submit = exmaexService.testsubmitsave(paramMap);
			}
	    }
	    
	      Map<String, Object> returnmap = new HashMap<String, Object>();
	      
	      returnmap.put("submit", submit);
	      returnmap.put("answer", answer);
	      
	      logger.info("+ End " + className + ".testsubmit");

	      return returnmap;		
	}
	
	
	
	
	
	// 시험 결과 조회
	@RequestMapping("/resultTest.do")
	public String checkResult(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session)throws Exception{
		
	      logger.info("+ Start " + className + ".resultTest");
	      logger.info("   - paramMap : " + paramMap);
		
			paramMap.put("loginID", session.getAttribute("loginId"));
		
		// 기존 정답을 조회!
		List<AttendExamModel> applytestList = exmaexService.applytest(paramMap);
		
		// 나의 답을 조회!
		List<AttendExamModel>  testresultList = exmaexService.testresult(paramMap);
				

		//기존 리스트
		model.addAttribute("applytestList", applytestList);
		model.addAttribute("testresultList", testresultList);
		
	      logger.info("+ End " + className + ".resultTest");


		return "exmaex/resultlist";
	}
	

	
   
}



   