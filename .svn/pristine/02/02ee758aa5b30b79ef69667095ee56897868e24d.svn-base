package kr.happyjob.study.login.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
/*import kr.happyjob.study.common.comnUtils.AESCryptoHelper;
import kr.happyjob.study.common.comnUtils.ComnUtil;*/
import kr.happyjob.study.login.dao.LoginDao;
import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.login.model.UsrMnuAtrtModel;
import kr.happyjob.study.login.model.UsrMnuChildAtrtModel;

@Service("loginService")
public class LoginServiceImpl implements LoginService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	@Autowired
	private LoginDao loginDao;
	
	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.virtualRootPath}")
	private String virtualrootPath;

	@Value("${fileUpload.certificatePath}")
	private String certificatePath;

	/** 사용자 로그인 체크*/
	public String checkLogin(Map<String, Object> paramMap) throws Exception {
		return loginDao.checkLogin(paramMap);
	}

	/** 사용자 로그인 */
	public LgnInfoModel loginProc(Map<String, Object> paramMap) throws Exception {
		String password = paramMap.get("pwd").toString();

		paramMap.put("pwd", password);
		return loginDao.selectLogin(paramMap);
	}


	/**  사용자 메뉴 권한 */
	public List<UsrMnuAtrtModel> listUsrMnuAtrt(Map<String, Object> paramMap) throws Exception {
		return loginDao.listUsrMnuAtrt(paramMap);
	}


	/**  사용자 자식 메뉴 권한 */
	public List<UsrMnuChildAtrtModel> listUsrChildMnuAtrt(Map<String, Object> paramMap) throws Exception{
		return loginDao.listUsrChildMnuAtrt(paramMap);

	}

	/**사용자 회원가입*/
	@Override
	public int registerUser(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		
		String filedir = File.separator + certificatePath + File.separator;
		
		FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest, rootPath, certificatePath, filedir);
		Map filereturn = fileup.uploadFiles();
	
		
		String upfile = (String) filereturn.get("file_nm");

		if(upfile == "" || upfile == null){
			paramMap.put("fileexist", "N");
		}else {
			paramMap.put("filereturn", filereturn);
			paramMap.put("fileexist", "Y");

			loginDao.insertfile(paramMap);
		}

		return loginDao.registerUser(paramMap);
	};
	

	/**loginID 중복체크*/
	@Override
	public int check_loginID(LgnInfoModel model) throws Exception {
		int result = loginDao.check_loginID(model);
		return result;
	}
	
	/**email 중복체크*/
	@Override
	public int check_email(LgnInfoModel model) throws Exception {
		int result = loginDao.check_email(model);
		return result;
	}

	/** 사용자 PW 찾기 ID 체크*/
	@Override
	public LgnInfoModel registerIdCheck(Map<String, Object> paramMap) throws Exception {

		return loginDao.registerIdCheck(paramMap);
	}
	
	/**비밀번호 리셋*/
	public int resetpwd(Map<String, Object> paramMap)throws Exception{
		return loginDao.resetpwd(paramMap);
		
	};



}
