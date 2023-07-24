package kr.happyjob.study.exmaex.model;

public class AttendExamModel {



	public int getTest_no() {
		return test_no;
	}
	public void setTest_no(int test_no) {
		this.test_no = test_no;
	}
	public String getTest_name() {
		return test_name;
	}
	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}
	public int getQue_no() {
		return que_no;
	}
	public void setQue_no(int que_no) {
		this.que_no = que_no;
	}
	public String getQue_content() {
		return que_content;
	}
	public void setQue_content(String que_content) {
		this.que_content = que_content;
	}
	public String getOpt_1() {
		return opt_1;
	}
	public void setOpt_1(String opt_1) {
		this.opt_1 = opt_1;
	}
	public String getOpt_2() {
		return opt_2;
	}
	public void setOpt_2(String opt_2) {
		this.opt_2 = opt_2;
	}
	public String getOpt_3() {
		return opt_3;
	}
	public void setOpt_3(String opt_3) {
		this.opt_3 = opt_3;
	}
	public String getOpt_4() {
		return opt_4;
	}
	public void setOpt_4(String opt_4) {
		this.opt_4 = opt_4;
	}

	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public int getLec_no() {
		return lec_no;
	}
	public void setLec_no(int lec_no) {
		this.lec_no = lec_no;
	}
	public int getGet_score() {
		return get_score;
	}
	public void setGet_score(int get_score) {
		this.get_score = get_score;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getCor_yn() {
		return cor_yn;
	}
	public void setCor_yn(String cor_yn) {
		this.cor_yn = cor_yn;
	}
	public String getRes_regdate() {
		return res_regdate;
	}
	public void setRes_regdate(String res_regdate) {
		this.res_regdate = res_regdate;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public String getTest_start() {
		return test_start;
	}
	public void setTest_start(String test_start) {
		this.test_start = test_start;
	}
	public String getTest_end() {
		return test_end;
	}
	public void setTest_end(String test_end) {
		this.test_end = test_end;
	}
	
	public String getLec_prof() {
		return lec_prof;
	}
	public void setLec_prof(String lec_prof) {
		this.lec_prof = lec_prof;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	

	
	private String name;
	private int test_no;
	private String test_name;
	private int que_no;
	private String que_content;
	private String opt_1;
	private String opt_2;
	private String opt_3;
	private String opt_4;
	private String answer;
	private int score;



	private int lec_no;
	private int get_score;
	private String user_id;
	private String res_ans;
	private String cor_yn;
	private String res_regdate;
	private String lec_name;
	private String test_start;
	private String test_end;

	private String lec_prof;
	
	  private int total_score;

	public int getTotal_score() {
		return total_score;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getRes_ans() {
		return res_ans;
	}
	public void setRes_ans(String res_ans) {
		this.res_ans = res_ans;
	}
	public void setTotal_score(int total_score) {
		this.total_score = total_score;
	} 
	
	private boolean test_completed;


	public boolean isTest_completed() {
		return test_completed;
	}
	public void setTest_completed(boolean test_completed) {
		this.test_completed = test_completed;
	}
	
	
	
}

