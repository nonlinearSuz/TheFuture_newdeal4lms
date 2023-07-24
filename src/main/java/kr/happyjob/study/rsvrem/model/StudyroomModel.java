package kr.happyjob.study.rsvrem.model;
//주석삭제
public class StudyroomModel {
	private int sturm_no;
	private String rm_name;
	private int rm_max;
	public int getSturm_no() {
		return sturm_no;
	}
	public void setSturm_no(int sturm_no) {
		this.sturm_no = sturm_no;
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
	@Override
	public String toString() {
		return "StudyroomModel [sturm_no=" + sturm_no + ", rm_name=" + rm_name + ", rm_max=" + rm_max + "]";
	}
	
}
