package kr.happyjob.study.rsvrem.model;

public class BkInfoModel {
//form 에서 넘어가는 모델임.
	
		private String booking_title;
		private String user_name;
		private String booking_date;
		private String booking_stime;
		private String booking_etime;
		private String booking_color;
		private int booking_cnt;
		private String booking_cont;
		
		
		
		
		public String getBooking_title() {
			return booking_title;
		}
		public void setBooking_title(String booking_title) {
			this.booking_title = booking_title;
		}
		public String getUser_name() {
			return user_name;
		}
		public void setUser_name(String user_name) {
			this.user_name = user_name;
		}
		public String getBooking_date() {
			return booking_date;
		}
		public void setBooking_date(String booking_date) {
			this.booking_date = booking_date;
		}
		public String getBooking_stime() {
			return booking_stime;
		}
		public void setBooking_stime(String booking_stime) {
			this.booking_stime = booking_stime;
		}
		public String getBooking_etime() {
			return booking_etime;
		}
		public void setBooking_etime(String booking_etime) {
			this.booking_etime = booking_etime;
		}
		public String getBooking_color() {
			return booking_color;
		}
		public void setBooking_color(String booking_color) {
			this.booking_color = booking_color;
		}
		public int getBooking_cnt() {
			return booking_cnt;
		}
		public void setBooking_cnt(int booking_cnt) {
			this.booking_cnt = booking_cnt;
		}
		public String getBooking_cont() {
			return booking_cont;
		}
		public void setBooking_cont(String booking_cont) {
			this.booking_cont = booking_cont;
		}
		
		
		@Override
		public String toString() {
			return "BkInfoModel [booking_title=" + booking_title + ", user_name=" + user_name + ", booking_date="
					+ booking_date + ", booking_stime=" + booking_stime + ", booking_etime=" + booking_etime
					+ ", booking_color=" + booking_color + ", booking_cnt=" + booking_cnt + ", booking_cont="
					+ booking_cont + "]";
		}
		
		
		
		
}
