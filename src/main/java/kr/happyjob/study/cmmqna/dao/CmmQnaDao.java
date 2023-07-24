package kr.happyjob.study.cmmqna.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cmmqna.model.Qna;
import kr.happyjob.study.cmmqna.model.QnaReply;
/*2023-07-11 commit 주석*/
public interface CmmQnaDao {
	
	//목록 조회
	public List<Qna> selectQna(Map<String, Object> paramMap) throws Exception;
	
	//목록 총 갯수 조회
	public int countQnaList(Map<String, Object> paramMap) throws Exception;
	
	//상세페이지
	public Qna detailQnaList(Map<String, Object> paramMap) throws Exception;
	
	//작성
	public int insertQna(Map<String, Object> paramMap) throws Exception;
	
	//수정
	public int updateQna(Map<String, Object> paramMap) throws Exception;
	
	//삭제
	public int deleteQna(Map<String, Object> paramMap) throws Exception;
	
	//상세조회시 조회수 증가
	public int increaseCount(int qna_no) throws Exception;
	
	//댓글
	public List<QnaReply> detailQnaRvList(Map<String, Object> paramMap) throws Exception;
	
	public int insertQnaReply(Map<String, Object> paramMap) throws Exception;
	
	public int updateQnaReply(Map<String, Object> paramMap) throws Exception;
	
	public int deleteQnaReply(Map<String, Object> paramMap) throws Exception;
	
}
