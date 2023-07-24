package kr.happyjob.study.supmtb.model;

public class MyTableModel {
	private String lec_prof;
	private int lec_no;
	private String lec_name;
	private String lec_contents;
	private String lec_starttime; //Datetime
	private String lec_endtime;   //Datetime
	private String lec_start;	//Date
	private String lec_end; 	//Date
	private int room_no;
	private String rm_name;
	private int startTime;
	private int endTime;
	private String yoil;
	private String name; //lec_prof의 name
	private String lecOpen_yn;
	private String acc_yn; //수강신청승인여부
	
	
	public String getLec_prof() {
		return lec_prof;
	}
	public void setLec_prof(String lec_prof) {
		this.lec_prof = lec_prof;
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
	public String getLec_contents() {
		return lec_contents;
	}
	public void setLec_contents(String lec_contents) {
		this.lec_contents = lec_contents;
	}
	public String getLec_starttime() {
		return lec_starttime;
	}
	public void setLec_starttime(String lec_starttime) {
		this.lec_starttime = lec_starttime;
	}
	public String getLec_endtime() {
		return lec_endtime;
	}
	public void setLec_endtime(String lec_endtime) {
		this.lec_endtime = lec_endtime;
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
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public String getRm_name() {
		return rm_name;
	}
	public void setRm_name(String rm_name) {
		this.rm_name = rm_name;
	}
	public int getStartTime() {
		return startTime;
	}
	public void setStartTime(int startTime) {
		this.startTime = startTime;
	}
	public int getEndTime() {
		return endTime;
	}
	public void setEndTime(int endTime) {
		this.endTime = endTime;
	}
	public String getYoil() {
		return yoil;
	}
	public void setYoil(String yoil) {
		this.yoil = yoil;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLecOpen_yn() {
		return lecOpen_yn;
	}
	public void setLecOpen_yn(String lecOpen_yn) {
		this.lecOpen_yn = lecOpen_yn;
	}
	public String getAcc_yn() {
		return acc_yn;
	}
	public void setAcc_yn(String acc_yn) {
		this.acc_yn = acc_yn;
	}
	@Override
	public String toString() {
		return "MyTableModel [lec_prof=" + lec_prof + ", lec_no=" + lec_no + ", lec_name=" + lec_name
				+ ", lec_contents=" + lec_contents + ", lec_starttime=" + lec_starttime + ", lec_endtime=" + lec_endtime
				+ ", lec_start=" + lec_start + ", lec_end=" + lec_end + ", room_no=" + room_no + ", rm_name=" + rm_name
				+ ", startTime=" + startTime + ", endTime=" + endTime + ", yoil=" + yoil + ", name=" + name
				+ ", lecOpen_yn=" + lecOpen_yn + ", acc_yn=" + acc_yn + "]";
	}
	
	
}
