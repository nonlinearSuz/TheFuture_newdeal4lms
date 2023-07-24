package kr.happyjob.study.admtbl.model;

public class RoomModel {
	//주석주석삭제	
	private int room_no;
	private int rm_max;
	private int rm_size;
	private String rm_name;
	private String rm_yn;
	
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public int getRm_max() {
		return rm_max;
	}
	public void setRm_max(int rm_max) {
		this.rm_max = rm_max;
	}
	public int getRm_size() {
		return rm_size;
	}
	public void setRm_size(int rm_size) {
		this.rm_size = rm_size;
	}
	public String getRm_name() {
		return rm_name;
	}
	public void setRm_name(String rm_name) {
		this.rm_name = rm_name;
	}
	public String getRm_yn() {
		return rm_yn;
	}
	public void setRm_yn(String rm_yn) {
		this.rm_yn = rm_yn;
	}
	@Override
	public String toString() {
		return "RoomModel [room_no=" + room_no + ", rm_max=" + rm_max + ", rm_size=" + rm_size + ", rm_name=" + rm_name
				+ ", rm_yn=" + rm_yn + "]";
	}

	
	
}
