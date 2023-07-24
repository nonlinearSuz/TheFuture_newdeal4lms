package kr.happyjob.study.login.controller;

import java.util.Collections;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.login.model.UsrMnuAtrtModel;
import kr.happyjob.study.login.service.LoginService;
import kr.happyjob.study.login.service.MailSendService;
import kr.happyjob.study.system.model.ComnCodUtilModel;



@Controller

public class LoginController {
   
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   LoginService loginService;
   
   @Autowired
   MailSendService mailSendService;


   /**
* index 접속 시 로그인 페이지로 이동한다.
* 
* @param   Model result - Spring model object
* @param   Map paramMap - Request Param object
* @param   HttpServletRequest request - Servlet request object
* @param   HttpServletResponse response - Servlet response object
* @param   HttpSession session - Http session Object
* @return   String - page navigator
* @throws Exception
*/

   
   
   
   @RequestMapping("login.do")
   public String index(Model result, @RequestParam Map<String, String> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

  logger.info("+ Start LoginController.login.do");
  List<ComnCodUtilModel> listOfcDvsCod = ComnCodUtil.getComnCod("OFC_DVS_COD","M");   // 오피스 구분 코드 (M제외)
  Collections.reverse(listOfcDvsCod); // 오피스 구분 역순으로
  	  result.addAttribute("listOfcDvsCod", listOfcDvsCod);   // 오피스 구분 코드
      logger.info("+ End LoginController.login.do");

  return "/login/login";
   }

   /**
* 사용자 로그인을 처리한다.
* 
* @param   Model result - Spring model object
* @param   Map paramMap - Request Param object
* @param   HttpServletRequest request - Servlet request object
* @param   HttpServletResponse response - Servlet response object
* @param   HttpSession session - Http session Object
* @return   String - page navigator
* @throws Exception
*/
   @RequestMapping("loginProc.do")
   @ResponseBody
   public Map<String, Object> loginProc(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start LoginController.loginProc.do");
	  logger.info("   - ParamMap : " + paramMap);
	    
	  // 사용자 로그인
	  LgnInfoModel lgnInfoModel = loginService.loginProc(paramMap);
	  
	  String result;
	  String resultMsg;
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  
	  if (lgnInfoModel != null) {
	     result = "SUCCESS";
	     resultMsg = "사용자 로그인 정보가 일치 합니다.";
	     
	     String lec_yn = lgnInfoModel.getLec_yn();
	     String user_active = lgnInfoModel.getUser_active();
	     
	     if("N".equals(lec_yn)) {
	    	 result = "FALSE";
	         resultMsg = lgnInfoModel.getLgn_id() + "는 승인 받지 않은 사용자 입니다.";
	     } else if("N".equals(user_active)) {
	    	 result = "FALSE";
	         resultMsg = lgnInfoModel.getLgn_id() + "는 탈퇴한 사용자입니다.";
	     } else {
		     
		     System.out.println("asdf" + lgnInfoModel.getApproval_cd());
		     System.out.println("y".equals(lgnInfoModel.getApproval_cd()));
		     System.out.println("asdf" + lgnInfoModel.getApproval_cd());
		     System.out.println("n".equals(lgnInfoModel.getApproval_cd()));
		     // 사용자 메뉴 권한 조회
		     paramMap.put("usr_sst_id", lgnInfoModel.getUsr_sst_id());
		     paramMap.put("userType",lgnInfoModel.getMem_author());
		     // 메뉴 목록 조회 0depth
		     List<UsrMnuAtrtModel> listUsrMnuAtrtModel = loginService.listUsrMnuAtrt(paramMap);
		     // 메뉴 목록 조회 1depth
		     for(UsrMnuAtrtModel list : listUsrMnuAtrtModel){
		        Map<String, Object> resultMapSub = new HashMap<String, Object>();
		        resultMapSub.put("lgn_Id", paramMap.get("lgn_Id")); 
		        resultMapSub.put("hir_mnu_id", list.getMnu_id());
		        resultMapSub.put("userType",lgnInfoModel.getMem_author());
		        list.setNodeList(loginService.listUsrChildMnuAtrt(resultMapSub));
		     }
		     
		     session.setAttribute("loginId",lgnInfoModel.getLgn_id());                     
		     session.setAttribute("userNm",lgnInfoModel.getUsr_nm());                  
		     session.setAttribute("usrMnuAtrt", listUsrMnuAtrtModel);
		     session.setAttribute("userType", lgnInfoModel.getMem_author());           
		     session.setAttribute("serverName", request.getServerName());
		
		     resultMap.put("loginId",lgnInfoModel.getLgn_id()); 
		     resultMap.put("userNm",lgnInfoModel.getUsr_nm()); 
		     resultMap.put("usrMnuAtrt", listUsrMnuAtrtModel);
		     resultMap.put("userType", lgnInfoModel.getMem_author());
		     resultMap.put("serverName", request.getServerName());	    	 
	     }
	     
	     
	} else {

         result = "FALSE";
         resultMsg = "사용자 로그인 정보가 일치하지 않습니다.";
    }
   
            
    
    resultMap.put("result", result);
    resultMap.put("resultMsg", resultMsg);
    resultMap.put("serverName", request.getServerName());
  
  
  
  
  logger.info("+ End LoginController.loginProc.do");

      return resultMap;
   }
   
   
   /**
* 로그아웃
* @param request
* @param response
* @param session
* @return
*/
   @RequestMapping(value = "/loginOut.do")
   public ModelAndView loginOut(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
                  
      ModelAndView mav = new ModelAndView();
      session.invalidate();
      mav.setViewName("redirect:/login.do");
      
      return mav;
   }
   
   
   
   
   /*회원가입*/
   @RequestMapping("register.do")
   @ResponseBody
   public Map<String, Object> registerUser(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
	   logger.info("+ Start " + className + ".registerUser");
	   logger.info("   - paramMap회원가입 : " + paramMap);
		
	   String action = (String)paramMap.get("action");
	   String result = "SUCCESS";
	   String resultMsg;
	   
	   int returnvalue = 0;
	   
	   if("I".equals(action)) {
		   returnvalue = loginService.registerUser(paramMap, request);
		   resultMsg = "가입 요청 완료";
	   } else {
		   result = "FAIL";
		   resultMsg = "가입 요청 실패";
	   }
	   
	   
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   resultMap.put("returnvalue", returnvalue);
	   resultMap.put("result", result);
	   resultMap.put("resultMsg", resultMsg);
	   
	   logger.info("+ End " + className + ".registerUser");
	   
	   return resultMap;
   }
   
   
   
   /*loginID 중복체크*/
   @RequestMapping(value="check_loginID", method=RequestMethod.POST)
   @ResponseBody
   public int check_loginID(LgnInfoModel model) throws Exception{
	   
	   logger.info("+ Start " + className + ".loginID_check");
	   int result = loginService.check_loginID(model);
	   logger.info("+ End " + className + ".loginID_check");
	   return result;
   }
   
   
   
   /*이메일 중복체크*/
   @RequestMapping(value="check_email", method=RequestMethod.POST)
   @ResponseBody
   public int check_email(LgnInfoModel model) throws Exception{
	   logger.info("+ Start " + className + ".loginID_check");
	   int result = loginService.check_email(model);
	   logger.info("+ End " + className + ".loginID_check");
	   return result;
   }
   
   
   
  
   
   /**사용자 PW 찾기 ID 체크*/
   @RequestMapping("registerIdCheck.do")
   @ResponseBody
   public Map<String, Object> registerIdCheck(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	   
	   logger.info("+ Start " + className + ".registerIdCheck");
	   
	   logger.info("   - paramMap : " + paramMap);

	  String result;
	  String resultMsg;
	  LgnInfoModel registerIdCheck= loginService.registerIdCheck(paramMap);
	  
	  if (registerIdCheck != null) {  
		  result = "SUCCESS";
		  resultMsg = "조회 성공";

		}else {
		      result = "FALSE";
		      resultMsg = "조회 실패";
		  	  }
	  
	  Map<String, Object> resultMap = new HashMap<String, Object>();

	  resultMap.put("result", result);
	  resultMap.put("resultMsg", resultMsg);
	  resultMap.put("resultModel", registerIdCheck);
	  
	  
	  logger.info("+ End " + className + ".registerIdCheck");
	   
	   return resultMap;
   }
   

   
   @RequestMapping("ResetPwd.do")
   @ResponseBody
   public Map<String, Object> ResetPwd(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".resetpwd");
      logger.info("   - paramMap : " + paramMap);


      int returnvalue = 0;

      returnvalue = loginService.resetpwd(paramMap);      

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("returnvalue", returnvalue);

      logger.info("+ End " + className + ".resetpwd");

      return returnmap;
   }
   
	   
	   

   @RequestMapping("checklist.do")
   @ResponseBody
   public Map<String, Object> checklist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start LoginController.checklist.do");
      logger.info("   - ParamMap : " + paramMap);
   
      //전문기술 공통코드 
      List<ComnCodUtilModel> listlistCod = ComnCodUtil.getComnCod("LanguageCD");
      List<ComnCodUtilModel> weblistCod = ComnCodUtil.getComnCod("webCD");
      List<ComnCodUtilModel> dblistCod = ComnCodUtil.getComnCod("DBCD");
      List<ComnCodUtilModel> wslistCod = ComnCodUtil.getComnCod("WSCD");
      List<ComnCodUtilModel> sklcdlistCod = ComnCodUtil.getComnCod("SKLCD"); //등급
      List<ComnCodUtilModel> areacdlistCod = ComnCodUtil.getComnCod("areaCD"); //희망근무지역
      
      Map<String, Object> resultMap = new HashMap<String, Object>();
      resultMap.put("listlistCod", listlistCod);
      resultMap.put("weblistCod", weblistCod);
      resultMap.put("dblistCod", dblistCod);
      resultMap.put("wslistCod", wslistCod);
      resultMap.put("sklcdlistCod", sklcdlistCod);
      resultMap.put("areacdlistCod", areacdlistCod);
  
      logger.info("+ End LoginController.checklist.do");
      logger.info("확인 weblistCod:"+weblistCod);
      logger.info("확인 sklcdlistCod:"+sklcdlistCod);
      return resultMap;
   }   
   
}