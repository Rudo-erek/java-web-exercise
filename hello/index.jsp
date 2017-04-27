<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html ng-app>
<head>
	<title>首页</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta charset="utf-8">
	<link rel="icon" href="images/UNIVERSE.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="images/UNIVERSE.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" href="css/calendar.css" />
    <link rel="stylesheet" type="text/css" href="css/left-pattern.css">
	<script type="text/javascript" src="js/head.js"></script>
	<script type="text/javascript" src="js/leftmenulist.js"></script>
	<script type="text/javascript" src="js/ctrl.js"></script>
	<script type="text/javascript" src="js/angular.min.js"></script>
	<script type="text/javascript" src="js/jquery-1.7.2.js"></script>
	<!-- <link rel="stylesheet" type="text/css" href="css/fond-head-menu.css"> -->
	<link rel="stylesheet" type="text/css" href="css/head.css">
	<link rel="stylesheet" type="text/css" href="css/dialog.css">
</head>
<body>
<div class="hidePage" id="hidePage">

<div class="header" ng-controller="MainController">
	<div id="topUserName" class="topUser" ng-mouseover="showUserMenu(1)" ng-mouseleave="showUserMenu(0)">
		<img src="images/top_male.png" class="header-left-pic"/>
		<span class="header-left-name" id="userName"><%=session.getAttribute("adminusername")%></span>
		<span id="userID" style="display: none;"><%=request.getParameter("userID")%></span>
		<div id="usermenu" class="userPop" js-userMenu style="display: none;">
			<ul>
				<li id="changePassword" class="menu-li password" ng-click="changePassword()">
					<span></span><a>修改密码</a>
				</li>
				<li class="menu-li cancel" ng-click="logOut()">
					<span></span><a>注销</a>
				</li>
			</ul>
		</div>
	</div>
	<div id="menuList" class="menuList" ng-click="getMenuList('#menuList')">
		<script type="text/javascript">
			window.onload= function() {
				$('#menuList').click();
				$('#leftPattern').find('div').click();
			}
		</script>
	</div>
</div>

<div class="calendar" id="calendar">
</div>
<script type="text/javascript" src='js/calendar.js'></script>

<div id="leftPattern" class="left-pattern" ng-controller="LeftMenuListController">
	<!-- <span ng-click="dire()">请假了</span> -->
	<div ng-click="getLeftMenuList('#leftPattern')">
	</div>
	<div id="list"></div>
</div>

<div id="main" class="main" ng-controller="LeftMenuListController">
	<iframe class="toDoData" src="jsp/alreadydonelist.jsp" frameborder="0" scrolling="no" name="main"></iframe>  
</div>

</div>

<div id="dialog-changePassword" class="dialog-box dialog-changePassword" ng-controller="MainController">
	<div class="dialog-title-box">
		<span class="dialog-title-box-left">
			修改密码
		</span>
		<span class="dialog-title-box-right" ng-click="closeDialog()">
			X
		</span>
	</div>
	<div class="dialog-main">
		<form method="post" action="changePassword">
			<input type="text" name="oldPassword"/>
			<input type="text" name="newPassword"/>
		</form>
	</div>
</div>


</body>
</html>
