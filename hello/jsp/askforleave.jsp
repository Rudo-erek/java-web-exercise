<%@ page contentType="text/html;charset=utf-8" %>
<html ng-app>
<head>
	<% String path="http://localhost:8080/hello"; %>
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap-theme.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/calendar.css" />
	<style type="text/css">
		* {
			font-size: 18px;
		}
		.form-group {
			margin-left: 20px;
			/*height: 400px;*/
		}
		.btn-default {
			width: 100px;
			height: 34px;
			font-size: 16px;
			vertical-align: middle;
			margin-left: 10px;
		}
		.glyphicon-calendar {
			vertical-align: middle;
		}
		.control-label {
			font-weight: bold;
			font-size: 14px;
		}
/*		.calender {
			position: relative;
			margin-left: 0px;
			margin-top: 0px;
			display: inline-block;
			z-index: 10;
		}*/
	</style>
	<script type="text/javascript" src="<%=path%>/js/jquery-3.2.0.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/angular.min.js"></script>
  	<script type="text/javascript" src='<%=path%>/js/calendarSelect.js'></script>
<!--     <script type="text/javascript">
    	var showCalander=function (flag) {
    		if(flag==0) {
    			$('#calendar-begin').css('display','block');
    			// $('.calendar').css('left',"110");
    		} else {
    			$('#calendar-end').css('display','block');
    			// $('.calendar').css('left',"430");
    		}
    	}
    </script> -->
    <script type="text/javascript">
    	var validate=function() {

    		// alert($('.header-left-name',parent.document).html());
    		if($("#beginDate").attr("value")==null || $("#beginDate").attr("value")==null || $("#endDate").attr("value")==null || $("#endDate").attr("value")==null) {
    			alert("必须输入正确日期！");
    			return false;
    		}
    		try{
    			var _beginDate=$("#beginDate").attr("value").split("-").join("");
    			var _endDate=$("#endDate").attr("value").split("-").join("");
    		} catch(err) {
    			alert("必须输入正确日期！");
    			return false;
    		}
    		if(parseInt(_endDate)-parseInt(_beginDate)<0) {
    			alert("终止日期必须大于起始日期！");
    			return false;
    		}
    		else {
    			var _userID=$('#userID',parent.document).html();
    			var _userName=$('#userName',parent.document).html();
    			$('#userID').attr("value",_userID);
    			$('#userName').attr("value",_userName);
    			return true;
    		} 
    	}
    </script>

</head>
<body>
	<div class="container">
		<span style="color: #6c7d92; font-weight: bold;">请假：</span><br>
		<div ng-controller="CalendarController">
			<form class="form-inline" method="post" name="writeTime" action="WriteLeaveTime"> <!-- ng-controller="CalendarController"-->
			  <div class="form-group">
			    <label class="control-label">开始日期：</label>
			      	<input class="form-control" id="beginDate" name="beginDate" type="text" placeholder="日期格式：2017-01-01" value="">
			        <span class="add-on" ng-click="showCalander(0)" ng-model="flag"><i class="glyphicon glyphicon-calendar" style="color: #6c7d92;"></i></span>
			   <div class="calendar" id="calendar" style="margin-top: 0px; left: 110px; background-color: white; display: none; z-index: 70;">
			  	<!-- <script type="text/javascript" src='../js/calendarSelectBegin.js'></script> -->
			  </div>
			  </div>
			  <div class="form-group">
			    <label class="control-label">终止日期：</label>
			      	<input class="form-control" id="endDate" name="endDate" type="text" placeholder="日期格式：2017-01-03" value="">
			        <span class="add-on" ng-click="showCalander(1)"><i class="glyphicon glyphicon-calendar" style="color: #6c7d92;"></i></span>
			  </div>
			  <button type="submit" class="btn btn-default" onclick="return validate();">请假</button>
<!-- 			  <div class="calendar" id="calendar-end" style="margin-top: 0px; left: 430px; background-color: white; display: none; z-index: 70;">
			  	<script type="text/javascript" src='../js/calendarSelectEnd.js'></script>
			  </div>
 -->
 			  <input type="hidden" id="userID" name="userID" value="">	
 			  <input type="hidden" id="userName" name="userName" value="">  
			</form>
			<%
				if(session.getAttribute("writeResult")=="1") {
			%>
			<script type="text/javascript">
				alert("请假成功！");
			</script>
			<%
				} else if(session.getAttribute("writeResult")=="2") {
			%>
			<script type="text/javascript">
				alert("值不能为空！");
			</script>
			<%
				} else if(session.getAttribute("writeResult")=="0") {
			%>
			<script type="text/javascript">
				alert("请假失败！");
			</script>
			<%
				}
				session.removeAttribute("writeResult");
			%>
 		</div>
	</div>
</body>
</html>
