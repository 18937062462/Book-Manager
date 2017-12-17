package cn.tqs.easyui.biz.impl;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.tqs.easyui.bo.ConditionBo;
import cn.tqs.easyui.dao.TblBooksEntryMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/applicationContext.xml" })
public class BooksBizImplTest {

	@Autowired
	private TblBooksEntryMapper mapper;

	@Test
	public void testQuery() {
		ConditionBo condition = new ConditionBo();
		condition.setIsbn("01");
		condition.setOffset(0);
		condition.setRows(10);
		System.out.println(mapper.query(condition));
	}

}
