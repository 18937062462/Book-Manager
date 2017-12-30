package cn.tqs.easyui.dao;

import java.util.List;

import cn.tqs.easyui.bo.ConditionBo;
import cn.tqs.easyui.entry.TblBooksEntry;

public interface TblBooksEntryMapper {
	int deleteByPrimaryKey(int id);

	int insert(TblBooksEntry record);

	int insertSelective(TblBooksEntry record);

	TblBooksEntry selectByPrimaryKey(int id);

	int updateByPrimaryKeySelective(TblBooksEntry record);

	int updateByPrimaryKey(TblBooksEntry record);

	List<TblBooksEntry> query(ConditionBo condition);
}