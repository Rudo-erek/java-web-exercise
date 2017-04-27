<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.Object" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow: scroll!importamt;">
<head>
	<title>hello</title>
	<link rel="icon" href="images/UNIVERSE.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="images/UNIVERSE.ico" type="image/x-icon" />
	<%
		out.println("<link type=\"text/css\" rel=\"stylesheet\" href=\"css/login.css\" />");
		out.println("<link type=\"text/css\" rel=\"stylesheet\" href=\"css/basic.css\" />");
		out.println("<link type=\"text/css\" rel=\"stylesheet\" href=\"css/frameset.css\" />");
		out.println("<link type=\"text/css\" rel=\"stylesheet\" href=\"css/universe/foundation_meta.css\" />");
	%>
	<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
	<script type="text/javascript">
		// window.onload=setInterval(function() {
		// 	var date_arr=new Array("日","一","二","三","四","五","六");
		// 	var tag_span=document.getElementsByTagName('span');
		// 	var date=new Date();
		// 	var year=date.getFullYear();
		// 	var month=date.getMonth()+1;
		// 	var day=date.getDay();
		// 	var date1=date.getDate();
		// 	var hour=handleNumber(date.getHours());
		// 	var minute=handleNumber(date.getMinutes());
		// 	var second=handleNumber(date.getSeconds());
		// 	tag_span[0].innerHTML=year+"-"+month+"-"+date1+"  "+ "星期" + date_arr[day] +" " +hour +":"+minute+":"+second;
		// },1000)

		function handleNumber(num) {
			if(num<10) return '0'+num.toString();
			else return num;
		}


		function on_submit() {
			var userID=document.getElementById('userID');
			var passw=document.getElementById('userPassword');
			if(userID.value=="") {
				alert("用户名不能为空！");
				return false;
			}
			if(passw.value=="") {
				alert("密码不能为空！");
				return false;
			}
			return true;
		}
	</script>

</head>
<body style="position: relative; background-color: #ccbbaa; height: 1200px;">
	<div style="width:100%; min-width: 1240px;">
		<div class="loginPageFrame">
			<div class="log-header">
<!-- 				<span class="currDate" style="font-style: italic; color: #91989e;"></span>
 -->			</div>
			<div class="loginPageCore">
				<div>
					<div class="login-logo-warp">
						<span class="login-logo"></span><span class="login-title">Hello</span>
					</div>
					<div id="loginErrorMsg" class="errTips LoginFont" style="height: 20px; float: left;">
						<s:fielderror/><s:property value="errormsg"/>
					</div>
				</div>
				<!-- <form  method="post" name="log_in" action="jsp/verify.jsp" onsubmit="return on_submit()"> -->
				<form  method="post" name="log_in" action="Login">
				<input type="text" id="userID" name="userID" placeholder="用户名" class="loginUsername" />
				<input type="password" id="userPassword" name="userPassword" autocomplete="off" class="loginPassword" onPaste="return false" onCopy="return false" placeholder="密码" onCut="return false" />
				<input type="submit" value="登录" class="loginSubmitNoValidate LoginFont" id="submitBtn" style="margin-top: 20px;" onclick="return on_submit()" />
				<input type="hidden" name="action" value="login"/>
				</form>
				<img src="images/logo0.png" alt="" style="margin-bottom: -40px;">
			</div>
			<div style="position: absolute; display: block; width: 100%; height: 36px; ">
				<span style="position: absolute; width: 100px; right: -10px; bottom: -50px; text-decoration: none; outline: none;"><a href="jsp/NewUserRegist.jsp" style="font-size: 14px; color: #91989e;">新用户注册</a></span>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function center() 
		{
			var height = (window.innerHeight - 1080) / 2;
			var width = (window.innerWidth - 1920) / 2;
			$('body').css({
				marginTop: height,
				marginLeft: width
			});
		}
		center();
		$(window).on('resize', function(event) {
			event.preventDefault();
			center();
		});
	</script>
</body>
</html>
