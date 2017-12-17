<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script type="text/javascript" src="/Easyui/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="/Easyui/jquery-easyui-1.3.2/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/Easyui/jquery-easyui-1.3.2/themes/icon.css">
	<script type="text/javascript" src="/Easyui/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="/Easyui/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script>
	<title>Insert title here</title>
	<script type="text/javascript">
	$(function(){
		$('#nb').numberbox({
	 		min:1,  
	 		max:3,
	 	    precision:2,
	 	    required:true,
	 	    missingMessage:"版本号必填"
	 	});
		
		$('#btn').click(function (){
			console.info("$('#addForm').serialize()");
			console.info($('#addForm').serialize());
			if($('#addForm').form('validate')){
				$.ajax({
					type:'post',
					url:'add.do?',
					cache:false,
					data:$('#addForm').serialize(),
					dataType:'json',
					success:function(result){
						$.messager.show({
							title:result.title,
							msg:result.msg
						});
					},
					error:function(result){
						$.messager.show({
							title:result.title,
							msg:result.msg
						});
					}
				});
			} else {
				$.messager.show({
					title:"提示信息",
					msg:"校验不通过！"
				});
				return;
			}
			
		});
	});
	
	$.extend($.fn.validatebox.defaults.rules, {   
	    nameLength: {   
	        validator: function(value, param){   
	            return value.length >= param[0] && value.length <= param[1];   
	        },   
	        message: '书名必须是2到5个字符！'  
	    }   
	});
</script>
</head>
<body>
	<div id="mypanel" class="easyui-panel" fit="true">
		<form id="addForm" action="" method="post">
			<table>
				<tr>
					<td>书编号：</td>
					<td><input type="text" name="isbn" /></td>
				</tr>
				<tr>
					<td>书名：</td>
					<td><input type="text" name="title" class="easyui-validatebox" required=true validType="nameLength[2,5]" /></td>
				</tr>
				<tr>
					<td>版本号：</td>
					<td><input id="nb" type="text" name="editionnumber"/></td>
				</tr>
				<tr>
					<td>版权：</td>
					<td><input type="text" name="copyright" /></td>
				</tr>
				<tr>
					<td>发行者：</td>
					<td><input type="text" name="publisherid" /></td>
				</tr>
				<tr>
					<td>图片：</td>
					<td><input type="text" name="imagefile" /></td>
				</tr>
				<tr>
					<td>价格：</td>
					<td><input type="text" name="price" /></td>
				</tr>
				<tr align="center">
					<td colspan="2"><a id="btn" class="easyui-linkbutton" >提 交</a></td>
				</tr>
				
			</table>
		</form>
	</div>
</body>
</html>