<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<% String path="http://localhost:8080/hello"; %>
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap-theme.css">
	<style type="text/css">
		* {
			font-size: 18px;
		}
		.todo-table {
			margin-left: 20px;
			/*height: 400px;*/
			/*margin-top: 20px;*/
		}
		.btn-default {
			width: 100px;
			height: 34px;
			font-size: 16px;
			vertical-align: middle;
			margin-left: 10px;
		}
		.control-label {
			font-weight: bold;
			font-size: 14px;
		}
		.btn {
			position: absolute;
			right: 90px;
			top: 10px;
			width: 80px; 
		}
		.todo-table th,td {
			text-align: center!important;
			vertical-align: middle!important;
		}
	</style>
	<script type="text/javascript" src="<%=path%>/js/jquery-3.2.0.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/angular.min.js"></script>
</head>
<body>
	<div class="container">
		<div style="height: 50px;">
		<span style="color: #6c7d92; font-weight: bold; top: 20px; position: absolute;">我的待办 <span class="badge">	
		<%=session.getAttribute("toDoNum")%>	
		<%
				session.removeAttribute("Result");
		%>
		</span></span><br>
		<form class="refresh-list" method="post" name="refresh-list" action="GetToDoList">
	 		<button type="submit" id="refresh" class="btn btn-default">刷新</button>
	 		<%! int i=0; %>
	 		<%
	 			if(i==0) {
	 		%>
	 		<script type="text/javascript">
	 			$('#refresh').click();
	 		</script>
	 		<%
	 			i++;
	 			}
	 		%>
	    </form>
	    </div>
		<div class="todo-table">
			<table class="table table-hover">
				<tr>
					<th>#</th>
					<th>ID</th>
					<th>申请人</th>
					<th>开始时间</th>
					<th>结束时间</th>
					<th>提交时间</th>
					<th>操作</th>
				</tr>
				<s:iterator value="#request.LeaveArray" status="status">
				<tr class="active">
					<td>
						<s:property value="#status.count" />
					</td>
					<td>
						<s:property value="userID" />
					</td>
					<td>
						<s:property value="userName" />
					</td>
					<td>
						<s:property value="beginDate"/>
					</td>
					<td>
						<s:property value="endDate" />
					</td>
					<td>
						<s:property value="writeTime" />
					</td>
					<td>
						<a href="GetToDoList?action=agree&to_do_Id=<s:property value="to_do_Id"/>">允许</a>&nbsp&nbsp<a href="#">驳回</a>
					</td>
				</tr>
				</s:iterator>
			</table>
			<%
				if(session.getAttribute("Result")=="1") {
			%>
<!-- 			<script type="text/javascript">
				alert("请求成功！");
			</script>
			<span><%=session.getAttribute("Result")%></span> -->
			<%
				} else if(session.getAttribute("Result")=="3"){
			%>
			<script type="text/javascript">
				alert("数据库问题！");
			</script>
			<%
				}
			%>
			<%
				session.removeAttribute("Result");
			%>

		</div>
	</div>
</body>
</html>
