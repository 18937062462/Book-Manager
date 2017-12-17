package cn.tqs.easyui.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.tqs.easyui.biz.IBooksBiz;
import cn.tqs.easyui.bo.ConditionBo;
import cn.tqs.easyui.entry.TblBooksEntry;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * 
 * @author tian
 * @date 2017年11月5日
 * @description
 */
@Controller
public class EasyuiAction {
	@Autowired
	private IBooksBiz biz;

	@RequestMapping("/index")
	public String index() {
		System.out.println("00000000");
		System.out.println("SSSSSSSS");

		return "004_main";
	}

	@RequestMapping("/booklist")
	public String booklist() {
		return "003_datagrid";
	}

	@RequestMapping("/bookadd")
	public String bookadd() {
		return "005_add";
	}

	@RequestMapping("/getdata")
	@ResponseBody
	public JSONObject getData(ConditionBo condition) {
		List<TblBooksEntry> entryList = biz.query(condition);
		if (entryList.size() != 0) {
			String data = JSON.toJSONString(entryList);
			String bo = "{'total':" + entryList.get(0).getTotal() + ",'rows':"
					+ data + "}";
			return JSON.parseObject(bo);
		} else {
			return null;
		}
	}

	@RequestMapping("/chgImg")
	@ResponseBody
	public String chgImg(@RequestParam("param") String param) {

		if (param.equals("jhtp3.jpg")) {
			String str = "{'str':'没有图片'}";
			return str;
		}
		return null;
	}

	@RequestMapping("/add")
	@ResponseBody
	public JSONObject add(TblBooksEntry entry) {
		try {
			biz.add(entry);
			return JSON.parseObject("{'title':'反馈信息','msg':'添加成功'}");
		} catch (Exception e) {
			return JSON.parseObject("{'title':'反馈信息','msg':'添加失败'}");
		}
	}

	@RequestMapping("/delete")
	@ResponseBody
	public JSONObject delete(Integer[] arr) {
		try {
			biz.delete(arr);
			return JSON.parseObject("{'title':'反馈信息','msg':'删除成功'}");
		} catch (Exception e) {
			return JSON.parseObject("{'title':'反馈信息','msg':'删除失败'}");
		}
	}

	@RequestMapping("/alter")
	@ResponseBody
	public JSONObject alter(TblBooksEntry entry) {
		try {
			biz.alter(entry);
			return JSON.parseObject("{'title':'反馈信息','msg':'修改成功'}");
		} catch (Exception e) {
			return JSON.parseObject("{'title':'反馈信息','msg':'修改成功'}");
		}
	}
}
