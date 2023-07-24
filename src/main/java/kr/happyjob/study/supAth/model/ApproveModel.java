package kr.happyjob.study.supAth.model;

public class ApproveModel {



	
	
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getLec_no() {
		return lec_no;
	}
	public void setLec_no(int lec_no) {
		this.lec_no = lec_no;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLec_prof() {
		return lec_prof;
	}
	public void setLec_prof(String lec_prof) {
		this.lec_prof = lec_prof;
	}
	public String getStud_id() {
		return stud_id;
	}
	public void setStud_id(String stud_id) {
		this.stud_id = stud_id;
	}
	public String getStud_name() {
		return stud_name;
	}
	public void setStud_name(String stud_name) {
		this.stud_name = stud_name;
	}
	public String getAcc_yn() {
		return acc_yn;
	}
	public void setAcc_yn(String acc_yn) {
		this.acc_yn = acc_yn;
	}
	public String getLec_period() {
		return lec_period;
	}
	public void setLec_period(String lec_period) {
		this.lec_period = lec_period;
	}
	public String getAcc_yn_code() {
		return acc_yn_code;
	}
	public void setAcc_yn_code(String acc_yn_code) {
		this.acc_yn_code = acc_yn_code;
	}
	
	
	
	private String loginID; //로그인 아이디
	private int lec_no; //강의 번호
	private String lec_name;  //강의명
	private String name; //사용자 이름
	private String lec_prof; //담당교수
	private String stud_id; //학생 아이디
	private String stud_name; //학생 이름
	private String acc_yn; //승인여부
	private String lec_period; //강의 기간
	private String acc_yn_code; // 승인여부 코드
	
	
}
