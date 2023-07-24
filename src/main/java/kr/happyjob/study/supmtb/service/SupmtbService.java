package kr.happyjob.study.supmtb.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.supmtb.model.MyTableModel;

public interface SupmtbService {

	List<MyTableModel> lecTimeList(Map<String, Object> paramMap)throws Exception;

}
