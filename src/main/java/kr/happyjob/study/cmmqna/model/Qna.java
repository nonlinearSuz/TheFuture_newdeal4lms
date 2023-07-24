package kr.happyjob.study.cmmqna.model;

import lombok.Data;
/*2023-07-11 commit 주석*/
@Data
public class Qna {
	
		private int qna_no; //Q_번호
		public int getQna_no() {
			return qna_no;
		}
		public void setQna_no(int qna_no) {
			this.qna_no = qna_no;
		}
		public String getPro_id() {
			return pro_id;
		}
		public void setPro_id(String pro_id) {
			this.pro_id = pro_id;
		}
		public String getQna_open_yn() {
			return qna_open_yn;
		}
		public void setQna_open_yn(String qna_open_yn) {
			this.qna_open_yn = qna_open_yn;
		}
		public String getQna_contents() {
			return qna_contents;
		}
		public void setQna_contents(String qna_contents) {
			this.qna_contents = qna_contents;
		}
		public String getEnr_date() {
			return enr_date;
		}
		public void setEnr_date(String enr_date) {
			this.enr_date = enr_date;
		}
		public String getEnr_user() {
			return enr_user;
		}
		public void setEnr_user(String enr_user) {
			this.enr_user = enr_user;
		}
		public String getQna_pwd() {
			return qna_pwd;
		}
		public void setQna_pwd(String qna_pwd) {
			this.qna_pwd = qna_pwd;
		}
		public String getQna_title() {
			return qna_title;
		}
		public void setQna_title(String qna_title) {
			this.qna_title = qna_title;
		}
		public int getQna_cnt() {
			return qna_cnt;
		}
		public void setQna_cnt(int qna_cnt) {
			this.qna_cnt = qna_cnt;
		}
		public int getCategory_no() {
			return category_no;
		}
		public void setCategory_no(int category_no) {
			this.category_no = category_no;
		}
		public String getCategory_name() {
			return category_name;
		}
		public void setCategory_name(String category_name) {
			this.category_name = category_name;
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
		
		
		private String pro_id; //강사
		private String qna_open_yn; //공개 or 비공개 여부
		private String qna_contents; //Q_내용
		private String enr_date; //등록일
		private String enr_user; //등록자
		private String qna_pwd; //비공개일시 open하기 위한 비밀번호
		private String qna_title; //제목
		private int qna_cnt; //조회수
		private int category_no; //카테고리번호
		private String category_name;
		private int rpy_no;
		private String rpy_contents;
		private String name;
		private String loginID;
}
