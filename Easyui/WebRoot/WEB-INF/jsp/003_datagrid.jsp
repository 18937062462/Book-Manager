<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="/Easyui/jquery-easyui-1.3.2/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="/Easyui/jquery-easyui-1.3.2/themes/icon.css"/>
	<script type="text/javascript" src="/Easyui/jquery-easyui-1.3.2/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="/Easyui/jquery-easyui-1.3.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="/Easyui/jquery-easyui-1.3.2/locale/easyui-lang-zh_CN.js"></script> 
	<script type="text/javascript">
 	$(function(){
 		//添加修改标志
 		var flag;
		$('#dg').datagrid({
			idField:'id',
			remoteSort:false,//这个必须设置为false排序字段才会起作用
			width:1366,
		    height:'auto',
		    striped:true,
		    //singleSelect:true,
		    pagination:true,
		    rownumbers:true,
		    title: '图书列表',
		    rowStyler:function(index,record){
		    	if(record.price>100){
		    		return "background:red";
		    	}
		    },
		    url: '/Easyui/getdata.do',
		    toolbar:[
						{text:'添加用户信息',iconCls: 'icon-add',handler: function(){
							flag='add';
							$('#myDialog').dialog({
								title:'添加用户信息'
							});
							$('#myDialog').dialog('open');
						}},
						{text:'删除用户信息',iconCls: 'icon-remove',handler: function(){
							var rows = $('#dg').datagrid('getSelections');			
							if(rows.length<1){
								alert("请至少选择一条记录！");	
							}else{
								var ids = new Array();
								for(var index in rows){
									ids.push(rows[index].id);
								}
								$.ajax({
									type:"post",
									url:"/Easyui/delete.do",
									data:{arr:ids},
									traditional:true,
									success:function(result){
											$.messager.show({
												title:'删除返回信息',
												msg:result.msg,
												timeout:5000
											});
											$('#dg').datagrid('reload');
											$('#dg').datagrid('unselectAll');
										}
								});
							} 
						}},
						{text:'修改用户信息',iconCls: 'icon-edit',handler: function(){
							flag='alter';
							var row=$('#dg').datagrid('getSelections');
							if(row.length==1){
								$('#myDialog').dialog({
									title:'修改用户信息'
								});
								$('#myDialog').dialog('open');
								$('#addForm').form('load',{
									id:row[0].id,
									isbn:row[0].isbn,
									title:row[0].title,
									editionnumber:row[0].editionnumber,
									copyright:row[0].copyright,
									publisherid:row[0].publisherid,
									imagefile:row[0].imagefile,
									price:row[0].price
								});
							}else{
								alert("请选择且紧选择一条数据");
							}
							
						}}
		            ],
		    frozenColumns:[[
		                {field:'ck', width:30,checkbox:true}
		            ]],
		    columns:[[   
		              {field:'id', hidden:true},   
		              {field:'isbn',title:'编号',width:100,sortable:true},   
		              {field:'title',title:'名称',width:100,formatter:function(value,record,index){
		            	  return '<span title = '+record.title+'>'+record.title+'</span>';
		              }},
		              {field:'editionnumber',title:'版本号',width:100},   
		              {field:'copyright',title:'发行年份',width:100},
		              {field:'publisherid',title:'发布者',width:100},   
		              {field:'imagefile',title:'图片',width:100,formatter:function(value,record,index){
		            	  var str='';
		            	  $.ajax({
		            		  type:"post",
		            		  url:"/Easyui/chgImg.do",
		            		  data:{param:value},
		            		  async:false,//必须加上同步请求
		            		  dataType:"json",
		            		  success:function(result){
		            			if(result!=null){
		            				console.info(result.str);
			            			str = result.str;
		            			}
		            		  }
		            	  }); 
		            	  return str;
		              }},
		              {field:'price',title:'价格',width:100,sortable:true}   
		          ]]  
		});
		$('#btn').bind('click',function(){
			var url;
			if(flag=='add'){
				url="/Easyui/add.do";
			}else if(flag=='alter'){
				url="/Easyui/alter.do";
			}
			$.ajax({
				type:"POST",
				data:$('#addForm').serialize(),
				dataType:'json',
				url:url,
				success:function(result){
					$.messager.show({
						title:result.title,
						msg:result.msg,
						showType:'slide',
						timeout:5000
					});
					$('#dg').datagrid('reload');
				}
			});
			$('#myDialog').dialog('close');
		});
		$('#reset').bind('click',function(){
			$('#addForm').get(0).reset();
		});
		$('#clear').bind('click',function(){
			$('#NF input').val('');
		});
		
		$('#search').bind('click',function(){
			$('#dg').datagrid('load',
					 {isbn:$('#is').val(),
					 title:$('#tt').val()});
		});
	});
	</script>
</head>
<body class='easyui-layout' style='width:100%; height:100%'>

	<div id='NF' region="north" style="height:50px" splite='false'>
		<label style='width:60px'>书 名:</label><input id='tt' type="text"/>
		<label style='width:60px'>编 号:</label><input id='is' type="text"/>
		<a id="search" class="easyui-linkbutton">查 询</a>
		<a id="clear" class="easyui-linkbutton">重 置 </a>
	</div>
	<div region="center">
		<div id="dg" fit='true'></div>
	</div>
	<div id="myDialog" class="easyui-dialog" closed="true" style="width:360px; height:480px" >
		<form id="addForm" method="post" style="padding-top: 80px;padding-left: 40px;">
			<table>
			
				<tr>
					<td><input type="hidden" name="id"/></td>
				</tr>
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
				
			</table>
		</form>
		<br>
		<div align="center">
			<a id="btn" class="easyui-linkbutton" >提 交 </a>
			<a id='reset' class='easyui-linkbutton'>重置</a>
		</div>
	</div>
	
	
</body>
</html>