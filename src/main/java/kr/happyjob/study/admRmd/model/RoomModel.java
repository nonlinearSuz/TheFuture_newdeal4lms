package kr.happyjob.study.admRmd.model;

public class RoomModel {



	
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getRm_max() {
		return rm_max;
	}
	public void setRm_max(String rm_max) {
		this.rm_max = rm_max;
	}
	public String getRm_size() {
		return rm_size;
	}
	public void setRm_size(String rm_size) {
		this.rm_size = rm_size;
	}
	public String getRm_name() {
		return rm_name;
	}
	public void setRm_name(String rm_name) {
		this.rm_name = rm_name;
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
	public String getRm_yn() {
		return rm_yn;
	}
	public void setRm_yn(String rm_yn) {
		this.rm_yn = rm_yn;
	}
	
	
	
	
	public String getLec_no() {
		return lec_no;
	}
	public void setLec_no(String lec_no) {
		this.lec_no = lec_no;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public String getLec_start() {
		return lec_start;
	}
	public void setLec_start(String lec_start) {
		this.lec_start = lec_start;
	}
	public String getLec_end() {
		return lec_end;
	}
	public void setLec_end(String lec_end) {
		this.lec_end = lec_end;
	}

	public String getStarttime() {
		return starttime;
	}
	public void setStarttime(String starttime) {
		this.starttime = starttime;
	}
	public String getEndtime() {
		return endtime;
	}
	public void setEndtime(String endtime) {
		this.endtime = endtime;
	}
	public String getLecDel_yn() {
		return lecDel_yn;
	}
	public void setLecDel_yn(String lecDel_yn) {
		this.lecDel_yn = lecDel_yn;
	}
	public String getLecOpen_yn() {
		return lecOpen_yn;
	}
	public void setLecOpen_yn(String lecOpen_yn) {
		this.lecOpen_yn = lecOpen_yn;
	}
	public String getItem_no() {
		return item_no;
	}
	public void setItem_no(String item_no) {
		this.item_no = item_no;
	}
	public String getItem_nm() {
		return item_nm;
	}
	public void setItem_nm(String item_nm) {
		this.item_nm = item_nm;
	}
	public String getItem_vol() {
		return item_vol;
	}
	public void setItem_vol(String item_vol) {
		this.item_vol = item_vol;
	}
	public String getItem_etc() {
		return item_etc;
	}
	public void setItem_etc(String item_etc) {
		this.item_etc = item_etc;
	}



	private int room_no;  //강의실 번호
	private String loginID; //로그인 아이디
	private String rm_max;  //허용인원
	private String rm_size; //강의실 크기
	private String rm_name; //강의실 이름 (호)
	private String enr_user; //최초 등록자
	private String enr_date; //최초 등록일
	private String upd_user; //수정자
	private String upd_date; //수정일자
	private String rm_yn; //사용여부
	private String lec_no; //강의 번호
	private String lec_name; //강의 이름
	private String lec_start; //강의 시작일
	private String lec_end; //강의 종강일
	private String starttime; //강의 시작 시간
	private String endtime; //강의 종료 시간
	private String lecDel_yn; //강의 삭제 여부 Y:삭제
	private String lecOpen_yn; //강의 개설 여부 Y: 승인
	private String item_no; //물품 번호
	private String item_nm; //물품명
	private String item_vol; //수량
	private String item_etc; //비고
	
    
   

	
}
