package kr.happyjob.study.cmmqna.controller;

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

import kr.happyjob.study.cmmntc.model.NoticeModel;
import kr.happyjob.study.cmmqna.model.Qna;
import kr.happyjob.study.cmmqna.model.QnaReply;
import kr.happyjob.study.cmmqna.service.CmmQnaService;
/*2023-07-11 commit 주석*/
@Controller
@RequestMapping("/cmmqna/")
public class CmmQnaController {
	
	@Autowired
	CmmQnaService cmmQnaService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	private final String className = this.getClass().toString();
	
	@RequestMapping("qnaList.do")
	public String qnaList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info(" + Start " + className + ".qnaList");
		logger.info(" - paramMap : " + paramMap);
		
		logger.info(" + End " + className + ".qnaList");
		
		return "cmmqna/qnalist";
	}
	
	@RequestMapping("qnalist.do")
	public String qnalist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnalist");
		logger.info(" - paramMap: " + paramMap);
		
		int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageindex = (pagenum - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("pageindex", pageindex);
		
		List<Qna> noticesearchlist = cmmQnaService.selectQna(paramMap);
		model.addAttribute("noticesearchlist", noticesearchlist);
		
		int totalcnt = cmmQnaService.countQnaList(paramMap);
		model.addAttribute("totalcnt", totalcnt);
	
		logger.info(" + End " + className + ".qnaList");
		
		return "cmmqna/qnaListGrd";
	}
	
	//상세조회
	@RequestMapping("detailQnaList.do")
	public String detailQnaList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		int qna_no = Integer.parseInt(((String)paramMap.get("qna_no")).trim());
		
		logger.info("+ Start " + className + ".detailQnaList");
		logger.info(" - paramMapkjhkjkjkjjk : " + paramMap);
		
		//qna 조회
		Qna qnasearch = cmmQnaService.detailQnaList(paramMap);
		logger.info(" - qnasearch : " + qnasearch);
/*		//카테고리 역할
		String categoryName =(String) paramMap.get("category_name");
		if(categoryName != null) {
			int categoryNo = remodelCategoryNo(categoryName);
			paramMap.put("category_no", categoryNo);
		}*/
		
		//조회수 증가
		if(qnasearch != null) {
			cmmQnaService.increaseCount(qnasearch.getQna_no());
		}
		
		String loginID = (String) session.getAttribute("loginId");
		model.addAttribute("loginId", loginID);
		
		String name = (String) session.getAttribute("name");
		model.addAttribute("name", name);
		
		logger.info(" - qna_nohhhhhh : " + paramMap);
		logger.info(" - paramMapkjhkjkjkjjk 111111: " + paramMap);
		//댓글 기능 
		List<QnaReply> qnaRvList = cmmQnaService.detailQnaRvList(paramMap);
		
		/*Map<String, Object> returnMap = new HashMap<String , Object> ();*/
		model.addAttribute("qnasearch", qnasearch);
		model.addAttribute("qnaRvList", qnaRvList);
		model.addAttribute("loginID", loginID);
		
		logger.info(" - qnasearch : " + qnasearch);
		logger.info(" - qnaRvList : " + qnaRvList); // []
		logger.info(" + End " + className + ".detailQnaList");
		
		return "cmmqna/qnadetailpopup";
	}
	
/*	private int remodelCategoryNo(String categoryName) {
		//공통코드에선 category가 name으로 잡혀 있고 db에선 category가 no로 pk 되있어서 category_no로 가져와야 name이 뜨는데 
		//parameter로 가져올때 category_name으로 가져오면 공통코드가 적용되고 db로는 못찾는다.
		//그렇다면 db를 따라서 category_name을 category_no로 인식하게 만들어야 되는데
		//return 0;
	}*/

	//글 등록
	@RequestMapping("qnaSave.do")
	@ResponseBody
	public Map<String, Object> qnaSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnaSave");
		logger.info(" - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		
		int returnval = 0;
		
		if("I".equals(action)) {
			returnval = cmmQnaService.insertQna(paramMap);
		} else if("U".equals(action)) {
			returnval = cmmQnaService.updateQna(paramMap);
		} else if("D".equals(action)) {
			returnval = cmmQnaService.deleteQna(paramMap);
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object> ();
		
		returnMap.put("returnval", returnval);
		
		logger.info("+ End " + className + ".noticeSave");
		
		return returnMap;
	}
	
	//댓글 등록
	@RequestMapping("insertQnaRp.do")
	@ResponseBody
	public Map<String, Object> insertQnaRp(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
				HttpServletResponse response, HttpSession session) throws Exception {
		
		String reaction = (String) paramMap.get("reaction");
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		
		int returnval = 0;
		
		if("I".equals(reaction)) {
			returnval = cmmQnaService.insertQnaReply(paramMap);
		} else if ("U".equals(reaction)) {
			returnval = cmmQnaService.updateQnaReply(paramMap);
		} else if("D".equals(reaction)) {
			returnval = cmmQnaService.deleteQnaReply(paramMap);
		}
		
		Map<String, Object> returnMap = new HashMap<String, Object> ();
		returnMap.put("returnval", returnval);
		
		return returnMap;
	}
	
}
