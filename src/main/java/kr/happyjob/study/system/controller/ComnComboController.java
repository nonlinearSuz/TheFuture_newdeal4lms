package kr.happyjob.study.system.controller;

import kr.happyjob.study.system.model.comcombo;
import kr.happyjob.study.system.service.ComnComboService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/system/")
public class ComnComboController {
	
	@Autowired
	ComnComboService comnComboService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 *  화면 
	 */
	@RequestMapping("comnCombo.do")
	public String initComnCod(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".initComnCod");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".initComnCod");

		return "system/comnCombo";
	}
	
	/**
	 *  공통 콤보 
	 */
	@RequestMapping("selectComCombo.do")
	@ResponseBody
	public Map<String, Object> selectComCombo (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectComCombo");
		logger.info("   - paramMap : " + paramMap);

		String ComType = (String) paramMap.get("comtype");
			
		List<comcombo> comComboModel = new ArrayList<>();
		
		logger.info("   - ComType : " + ComType);
		
		
		
		
		if("lecbyuser".equals(ComType)) {
			// 공통 콤보 조회 제품 
			paramMap.put("loginId", session.getAttribute("loginId"));
			comComboModel = comnComboService.selectlecbyuserlist(paramMap);
		} else if("usr".equals(ComType)) {
			// 공통 콤보 조회 창고 담당자 이름, LoginID
			comComboModel = comnComboService.selectuserlist(paramMap);
		} else if("test".equals(ComType)) {
			// 공통 콤보 조회 시험 시험명, test_name
			comComboModel = comnComboService.selecttestlist(paramMap);
		} else if("survey".equals(ComType)) {
			// 공통 콤보 조회 t설문 담당자 이름, sv_name
			comComboModel = comnComboService.selectsurveylist(paramMap);
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("list", comComboModel);
		
		logger.info("+ End " + className + ".selectComCombo");
		
		return resultMap;
	}
	
	

}
