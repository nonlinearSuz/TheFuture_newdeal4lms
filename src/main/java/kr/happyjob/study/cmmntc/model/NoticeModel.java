package kr.happyjob.study.cmmntc.model;
public class NoticeModel {
	
	public int getNt_no() {
		return nt_no;
	}
	
	public void setNt_no(int nt_no) {
		this.nt_no = nt_no;
	}
	
	public String getNt_title() {
		return nt_title;
	}

	public void setNt_title(String nt_title) {
		this.nt_title = nt_title;
	}
	
	public String getNt_contents() {
		return nt_contents;
	}
	
	public void setNt_contents(String nt_contents) {
		this.nt_contents = nt_contents;
	}
	
	public int getNt_cnt() {
		return nt_cnt;
	}
	
	public void setNt_cnt(int nt_cnt) {
		this.nt_cnt = nt_cnt;
	}
	
	public String getEnr_user() {
		return enr_user;
	}
	
	public void setEnr_user(String enr_user) {
		this.enr_user = enr_user;
	}
	
	public String getEnr_date() {
		return enr_date;
	}
	
	public void setEnr_date(String enr_date) {
		this.enr_date = enr_date;
	}
	
	public String getUpd_user() {
		return upd_user;
	}
	
	public void setUpd_user(String upd_user) {
		this.upd_user = upd_user;
	}
	
	public String getUpd_date() {
		return upd_date;
	}
	
	public void setUpd_date(String upd_date) {
		this.upd_date = upd_date;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getLoginID() {
		return loginID;
	}
	
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	
	public int getRpy_no() {
		return rpy_no;
	}

	public void setRpy_no(int rpy_no) {
		this.rpy_no = rpy_no;
	}
	
	public String getRpy_contents() {
		return rpy_contents;
	}

	public void setRpy_contents(String rpy_contents) {
		this.rpy_contents = rpy_contents;
	}
	
	private int nt_no;
	private String nt_contents;
	private String nt_title;
	private int nt_cnt;
	private String enr_user;
	private String enr_date;
	private String upd_user;
	private String upd_date;
	//tb_userinfo
	private String name;
	private String loginID;
	
	private int rpy_no;
	private String rpy_contents;

	
}