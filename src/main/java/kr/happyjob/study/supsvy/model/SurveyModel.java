package kr.happyjob.study.supsvy.model;

import java.util.List;

/*커밋 용 임시 주석*/

public class SurveyModel {

	/** 기본 정보 */
	
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getLec_prof() {
		return lec_prof;
	}
	public void setLec_prof(String lec_prof) {
		this.lec_prof = lec_prof;
	}
	public String getLec_yn() {
		return lec_yn;
	}
	public void setLec_yn(String lec_yn) {
		this.lec_yn = lec_yn;
	}

	public int getLec_no() {
		return lec_no;
	}
	public void setLec_no(int lec_no) {
		this.lec_no = lec_no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUser_hp() {
		return user_hp;
	}
	public void setUser_hp(String user_hp) {
		this.user_hp = user_hp;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getLec_enr() {
		return lec_enr;
	}
	public void setLec_enr(String lec_enr) {
		this.lec_enr = lec_enr;
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
	public int getSv_res_cnt() {
		return sv_res_cnt;
	}
	public void setSv_res_cnt(int sv_res_cnt) {
		this.sv_res_cnt = sv_res_cnt;
	}
	public int getLec_signcnt() {
		return lec_signcnt;
	}
	public void setLec_signcnt(int lec_signcnt) {
		this.lec_signcnt = lec_signcnt;
	}
	public int getLec_dateProgress() {
		return lec_dateProgress;
	}
	public void setLec_dateProgress(int lec_dateProgress) {
		this.lec_dateProgress = lec_dateProgress;
	}
	public String getLecOpen_yn() {
		return lecOpen_yn;
	}
	public void setLecOpen_yn(String lecOpen_yn) {
		this.lecOpen_yn = lecOpen_yn;
	}
	
	
	public int getMax_no() {
		return max_no;
	}
	public void setMax_no(int max_no) {
		this.max_no = max_no;
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
	public String getLec_contents() {
		return lec_contents;
	}
	public void setLec_contents(String lec_contents) {
		this.lec_contents = lec_contents;
	}
	public String getLec_goal() {
		return lec_goal;
	}
	public void setLec_goal(String lec_goal) {
		this.lec_goal = lec_goal;
	}

	/** 설문조사 정보 gett/sett */
	public int getSv_no() {
		return sv_no;
	}
	public void setSv_no(int sv_no) {
		this.sv_no = sv_no;
	}
	public String getSv_upd_date() {
		return sv_upd_date;
	}
	public void setSv_upd_date(String sv_upd_date) {
		this.sv_upd_date = sv_upd_date;
	}
	public String getSv_enr_date() {
		return sv_enr_date;
	}
	public void setSv_enr_date(String sv_enr_date) {
		this.sv_enr_date = sv_enr_date;
	}
	public String getSv_writer() {
		return sv_writer;
	}
	public void setSv_writer(String sv_writer) {
		this.sv_writer = sv_writer;
	}
	public String getSv_name() {
		return sv_name;
	}
	public void setSv_name(String sv_name) {
		this.sv_name = sv_name;
	}
	public int getSv_qst_no() {
		return sv_qst_no;
	}
	public void setSv_qst_no(int sv_qst_no) {
		this.sv_qst_no = sv_qst_no;
	}
	public String getQst_content() {
		return qst_content;
	}
	public void setQst_content(String qst_content) {
		this.qst_content = qst_content;
	}
	public int getEx_num() {
		return ex_num;
	}
	public void setEx_num(int ex_num) {
		this.ex_num = ex_num;
	}
	public String getEx_content() {
		return ex_content;
	}
	public void setEx_content(String ex_content) {
		this.ex_content = ex_content;
	}
	public int getRes_no() {
		return res_no;
	}
	public void setRes_no(int res_no) {
		this.res_no = res_no;
	}
	public String getRes_regdate() {
		return res_regdate;
	}
	public void setRes_regdate(String res_regdate) {
		this.res_regdate = res_regdate;
	}
	public String getRes_long() {
		return res_long;
	}
	public void setRes_long(String res_long) {
		this.res_long = res_long;
	}
	public int getRes_short() {
		return res_short;
	}
	public void setRes_short(int res_short) {
		this.res_short = res_short;
	}

	
	public int getSvySubmitcnt() {
		return svySubmitcnt;
	}
	public void setSvySubmitcnt(int svySubmitcnt) {
		this.svySubmitcnt = svySubmitcnt;
	}

	
	
	

	/* 최대 수용 인원 */
	private int max_no;
	
	/*유저 ID*/
	private String loginID;
	/*강사ID*/
	private String lec_prof;
	
	/*강사 승인 여부 */
	private String lec_yn;
	/*강의번호*/
	private int lec_no;
	/*이름*/
	private String name;
	/*전화번호*/
	private String user_hp;
	/*이메일*/
	private String user_email;
	/*강의 등록일*/
	private String lec_enr;
	/*과목*/
	private String lec_name;
	/*강의 시작일*/
	private String lec_start;
	/*강의 종료일*/ 
	private String lec_end;
	/*설문인원*/
	private int sv_res_cnt;
	/*수강인원*/
	private int lec_signcnt;
	/*진도율*/
	private int lec_dateProgress;
	/*강의  개설 허용여부  */
	private String lecOpen_yn;
	
	/*강의실 번호*/
	private int room_no;
	
	/*강의실 이름*/
	private String rm_name;
	
	/*강의 내용*/
	private String lec_contents;
	
	/*강의 목표 */
	private String lec_goal;
	
	public String getQst_type() {
		return qst_type;
	}
	public void setQst_type(String qst_type) {
		this.qst_type = qst_type;
	}

	/*문제유형  1 : 주관식   2 : 객관식  */
	private String qst_type;
	

	/** 설문조사 정보 */
	/* 설문지번호 */
	private int sv_no;	
	/* 수정 날짜 */
	private String sv_upd_date;	
	/* 등록 날짜 */
	private String sv_enr_date;
	/* 등록자 */
	private String sv_writer;	
	/* 설문지이름 */
	private String sv_name;	
	
	/* 설문 응답 인원 체크 */
	private int svySubmitcnt;
	/* 설문문제번호 */
	private int sv_qst_no;	
	/* 설문내용 */
	private String qst_content;	
	/* 설문 보기번호 */
	private int ex_num;	
	/* 설문 보기내용 */
	private String ex_content;	
	/* 응답번호 */
	private int res_no;	
	/* 응답날짜 */
	private String res_regdate;	
	/* 서술형응답 */
	private String res_long;	
	/* 객관식응답 */
	private int res_short;	
	
	
	/* 설문조사 답변 예시(오지선다)  set 를 만들 모델을 만듬  */
	public List<SurveyModel> getExList() {
		return exList;
	}
	
	public void setExList(List<SurveyModel> exList) {
		this.exList = exList;
	}

	private List<SurveyModel> exList;
	
	
	
	   /** 설문조사 차트 */

    private int count1;         /* 매우만족 */
    private int count2;         /* 만족 */
    private int count3;         /* 보통 */
    private int count4;         /* 불만족 */
    private int count5;         /* 매우 불만족 */

	 public int getCount1() {
	    return count1;
	 }
	 public void setCount1(int count1) {
	    this.count1 = count1;
	 }
	 public int getCount2() {
	    return count2;
	 }
	 public void setCount2(int count2) {
	    this.count2 = count2;
	 }
	 public int getCount3() {
	    return count3;
	 }
	 public void setCount3(int count3) {
	    this.count3 = count3;
	 }
	 public int getCount4() {
	    return count4;
	 }
	 public void setCount4(int count4) {
	    this.count4 = count4;
	 }
	 public int getCount5() {
	    return count5;
	 }
	 public void setCount5(int count5) {
	    this.count5 = count5;
	 }
		
	
}
	
