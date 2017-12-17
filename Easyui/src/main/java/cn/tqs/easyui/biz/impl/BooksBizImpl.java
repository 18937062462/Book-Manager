package cn.tqs.easyui.biz.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.tqs.easyui.biz.IBooksBiz;
import cn.tqs.easyui.bo.ConditionBo;
import cn.tqs.easyui.dao.TblBooksEntryMapper;
import cn.tqs.easyui.entry.TblBooksEntry;

@Service
public class BooksBizImpl implements IBooksBiz {

	@Autowired
	private TblBooksEntryMapper mapper;

	@Override
	public List<TblBooksEntry> query(ConditionBo condition) {
		condition.setOffset(condition.getRows() * (condition.getPage() - 1));
		return mapper.query(condition);
	}

	@Override
	public String add(TblBooksEntry entry) {
		if (entry != null) {
			mapper.insert(entry);
			return "success";
		}
		return "faile";
	}

	@Override
	public void delete(Integer[] arr) {

		for (int i = 0; i < arr.length; i++) {
			mapper.deleteByPrimaryKey(arr[i]);
		}
	}

	@Override
	public void alter(TblBooksEntry entry) {
		mapper.updateByPrimaryKeySelective(entry);
	}
}
