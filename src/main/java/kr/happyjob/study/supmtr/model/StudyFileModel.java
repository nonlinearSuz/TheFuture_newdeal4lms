package kr.happyjob.study.supmtr.model;

public class StudyFileModel {

	   //주석!!
	private String loginID;
	private int lec_no;
	private String lec_name;
	private String lec_prof;

	private int study_file_no;
	private int file_no;
	private String study_file_title;
	private String study_file_cont;
	private String enr_user; //loginID는 아니다! 다른컬럼임
	private String enr_date; //형을 Date로 해야하는지, String으로 해야하는지
	
	private String file_name;
	private String file_logic_path;
	private String file_physic_path;
	private int file_size;
	private String file_ext;
	
	
	
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
	public int getStudy_file_no() {
		return study_file_no;
	}
	public void setStudy_file_no(int study_file_no) {
		this.study_file_no = study_file_no;
	}
	public int getFile_no() {
		return file_no;
	}
	public void setFile_no(int file_no) {
		this.file_no = file_no;
	}
	public String getStudy_file_title() {
		return study_file_title;
	}
	public void setStudy_file_title(String study_file_title) {
		this.study_file_title = study_file_title;
	}
	public String getStudy_file_cont() {
		return study_file_cont;
	}
	public void setStudy_file_cont(String study_file_cont) {
		this.study_file_cont = study_file_cont;
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
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public int getFile_size() {
		return file_size;
	}
	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}
	public String getFile_logic_path() {
		return file_logic_path;
	}
	public void setFile_logic_path(String file_logic_path) {
		this.file_logic_path = file_logic_path;
	}
	public String getFile_physic_path() {
		return file_physic_path;
	}
	public void setFile_physic_path(String file_physic_path) {
		this.file_physic_path = file_physic_path;
	}
	public String getFile_ext() {
		return file_ext;
	}
	public void setFile_ext(String file_ext) {
		this.file_ext = file_ext;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	
	
	public String getLec_prof() {
		return lec_prof;
	}
	public void setLec_prof(String lec_prof) {
		this.lec_prof = lec_prof;
	}
	@Override
	public String toString() {
		return "StudyFileModel [loginID=" + loginID + ", lec_no=" + lec_no + ", lec_name=" + lec_name + ", lec_prof="
				+ lec_prof + ", study_file_no=" + study_file_no + ", file_no=" + file_no + ", study_file_title="
				+ study_file_title + ", study_file_cont=" + study_file_cont + ", enr_user=" + enr_user + ", enr_date="
				+ enr_date + ", file_name=" + file_name + ", file_logic_path=" + file_logic_path + ", file_physic_path="
				+ file_physic_path + ", file_size=" + file_size + ", file_ext=" + file_ext + "]";
	}





	
}
