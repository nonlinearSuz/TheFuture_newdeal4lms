package kr.happyjob.study.login.model;


public class LgnInfoModel {


	//사용자 이메일
	private String user_email;
	
	//로그인 ID
	private String loginID;
	
	//비밀번호
	private String password;
	
	//은행 코드
	private String detail_name;
	private String detail_code;
	
	//승인 코드
	private String approval_cd;
	
	
	/*// 게시판 글 번호
	private int row_num;
	
	// 오피스 ID
	private String ofc_id;
	
	// 오피스 명
	private String ofc_nm;
	
	// 오피스 구분 코드
	private String ofc_dvs_cod;
	*/
	
	// 사용자 로그인 ID
	private String lgn_id;
	
	// 사용자 로그인 PW
	private String pwd;
	
	// 사용자 시스템 ID
	private String usr_sst_id;
	
	// 사용자 성명
	private String usr_nm;
	
	// 로그린 사용자 권란       mng: 관리자       gnr: 일반
	private String mem_author;
	
	//파일 번호
	private String file_no;	
	//파일 이름
	private String file_name;
	//파일 물리 경로
	private String file_physic_path;	
	//파일 논리 경로
	private String file_logic_path;		
	//파일 사이즈
	private String file_size;		
	//확장자
	private String file_ext;
		
	private String lec_yn;
	
	private String user_active;
	

	public String getLec_yn() {
		return lec_yn;
	}

	public void setLec_yn(String lec_yn) {
		this.lec_yn = lec_yn;
	}

	public String getUser_active() {
		return user_active;
	}

	public void setUser_active(String user_active) {
		this.user_active = user_active;
	}

	public String getFile_no() {
		return file_no;
	}

	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}
	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_physic_path() {
		return file_physic_path;
	}

	public void setFile_physic_path(String file_physic_path) {
		this.file_physic_path = file_physic_path;
	}

	public String getFile_logic_path() {
		return file_logic_path;
	}

	public void setFile_logic_path(String file_logic_path) {
		this.file_logic_path = file_logic_path;
	}

	public String getFile_size() {
		return file_size;
	}

	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}

	public String getFile_ext() {
		return file_ext;
	}

	public void setFile_ext(String file_ext) {
		this.file_ext = file_ext;
	}
		
	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDetail_name() {
		return detail_name;
	}

	public void setDetail_name(String detail_name) {
		this.detail_name = detail_name;
	}

	public String getDetail_code() {
		return detail_code;
	}

	public void setDetail_code(String detail_code) {
		this.detail_code = detail_code;
	}

	public String getApproval_cd() {
		return approval_cd;
	}

	public void setApproval_cd(String approval_cd) {
		this.approval_cd = approval_cd;
	}

	public String getLgn_id() {
		return lgn_id;
	}

	public void setLgn_id(String lgn_id) {
		this.lgn_id = lgn_id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getUsr_sst_id() {
		return usr_sst_id;
	}

	public void setUsr_sst_id(String usr_sst_id) {
		this.usr_sst_id = usr_sst_id;
	}

	public String getUsr_nm() {
		return usr_nm;
	}

	public void setUsr_nm(String usr_nm) {
		this.usr_nm = usr_nm;
	}

	public String getMem_author() {
		return mem_author;
	}

	public void setMem_author(String mem_author) {
		this.mem_author = mem_author;
	}

	
	

}
