package cn.tqs.easyui.biz;

import java.util.List;

import cn.tqs.easyui.bo.ConditionBo;
import cn.tqs.easyui.entry.TblBooksEntry;

public interface IBooksBiz {
	List<TblBooksEntry> query(ConditionBo condition);

	/**
	 * 
	 * @param entry
	 * @return
	 */
	String add(TblBooksEntry entry);

	void delete(Integer[] arr);

	void alter(TblBooksEntry entry);
}
