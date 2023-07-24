package kr.happyjob.study.rsvrem.model;

public class ReservationModel {
	
	private int book_no;
	private String loginID; // 예약개설자
	
	private int sturm_no;
	private int book_per_cnt; //예약 최대 허용인원수
	private int startTime;
	private int endTime;
	
	private String book_start;
	private String book_end;
	
	private String book_date;
	private String book_title;
	private String book_cont;
	private String name; //예약자이름(host name)
	private String bgcolor; 
	
	private String rm_name; //스터디룸이름.
	private int rm_max; //스터디룸시설의 최대 허용인원수
	
	private String book_cd; //예약상태 : 진행예정, 진행중, 진행완료
	

	private int cnt; //현재 예약방에 참여자인 수( cnt/book_per_cnt)
	//host인지 여부....: sb.loginID 인사람이 host
	
	private String concatloginID;
	private String concatname;
	
	// 안쓰면 삭제예정
	private String hostID; //예약개설자 **
	private String smloginID; //참여중인 로그인아이디 (현재세션) **
	private String smhostyn; //참여자가 지금 host인지여부
	//** 그냥 loginID == 작성자 (주최자인경우) 그렇게해결하고
	// 참석여부 확인은 concatloginID, concatname 있는지없는지 확인하자.
	
	
	
	
	
	
	
	public String getHostID() {
		return hostID;
	}
	public String getConcatloginID() {
		return concatloginID;
	}
	public void setConcatloginID(String concatloginID) {
		this.concatloginID = concatloginID;
	}
	public String getConcatname() {
		return concatname;
	}
	public void setConcatname(String concatname) {
		this.concatname = concatname;
	}
	public void setHostID(String hostID) {
		this.hostID = hostID;
	}
	public String getSmloginID() {
		return smloginID;
	}
	public void setSmloginID(String smloginID) {
		this.smloginID = smloginID;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getSmhostyn() {
		return smhostyn;
	}
	public void setSmhostyn(String smhostyn) {
		this.smhostyn = smhostyn;
	}
	public String getBook_cd() {
		return book_cd;
	}
	public void setBook_cd(String book_cd) {
		this.book_cd = book_cd;
	}
	public int getBook_no() {
		return book_no;
	}
	public void setBook_no(int book_no) {
		this.book_no = book_no;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getSturm_no() {
		return sturm_no;
	}
	public void setSturm_no(int sturm_no) {
		this.sturm_no = sturm_no;
	}
	public int getBook_per_cnt() {
		return book_per_cnt;
	}
	public void setBook_per_cnt(int book_per_cnt) {
		this.book_per_cnt = book_per_cnt;
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
	public String getBook_date() {
		return book_date;
	}
	public void setBook_date(String book_date) {
		this.book_date = book_date;
	}
	public String getBook_title() {
		return book_title;
	}
	public void setBook_title(String book_title) {
		this.book_title = book_title;
	}
	public String getBook_cont() {
		return book_cont;
	}
	public void setBook_cont(String book_cont) {
		this.book_cont = book_cont;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBgcolor() {
		return bgcolor;
	}
	public void setBgcolor(String bgcolor) {
		this.bgcolor = bgcolor;
	}
	
	public String getRm_name() {
		return rm_name;
	}
	public void setRm_name(String rm_name) {
		this.rm_name = rm_name;
	}
	public int getRm_max() {
		return rm_max;
	}
	public void setRm_max(int rm_max) {
		this.rm_max = rm_max;
	}
	public String getBook_start() {
		return book_start;
	}
	public void setBook_start(String book_start) {
		this.book_start = book_start;
	}
	public String getBook_end() {
		return book_end;
	}
	public void setBook_end(String book_end) {
		this.book_end = book_end;
	}
	@Override
	public String toString() {
		return "ReservationModel [book_no=" + book_no + ", loginID=" + loginID + ", sturm_no=" + sturm_no
				+ ", book_per_cnt=" + book_per_cnt + ", startTime=" + startTime + ", endTime=" + endTime
				+ ", book_start=" + book_start + ", book_end=" + book_end + ", book_date=" + book_date + ", book_title="
				+ book_title + ", book_cont=" + book_cont + ", name=" + name + ", bgcolor=" + bgcolor + ", rm_name="
				+ rm_name + ", rm_max=" + rm_max + ", book_cd=" + book_cd + ", cnt=" + cnt + ", concatloginID="
				+ concatloginID + ", concatname=" + concatname + ", hostID=" + hostID + ", smloginID=" + smloginID
				+ ", smhostyn=" + smhostyn + "]";
	}


	
	

}