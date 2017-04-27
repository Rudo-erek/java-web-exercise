	var MainController = function($scope) {
		// $scope.showUserMenu = function(tag) {

		// }

	$scope.showUserMenu = function (tag) {
		var usermenu = $('.userPop[js-userMenu]');
		var uesrWidth= 0 ;
		if (tag == 1){
			usermenu.show();
			usermenu.find("ul li").each(function(){
				var Lwidth = parseInt( $(this).css("padding-right").replace("px","" ) ) + parseInt( $(this).css("padding-left").replace("px","" ) );
				var Swidth = $(this).find("span").width() + parseInt( $(this).find("span").css("margin-right").replace("px","" ) ) + 5;
				var Awidth = $(this).find("a").width();
				var newWidth = (Lwidth + Swidth + Awidth);
				uesrWidth =( newWidth > uesrWidth ) ? newWidth : uesrWidth ; //获取最宽一个
			});
			usermenu.css({width:uesrWidth+"px"});
		}else{
			usermenu.hide();
		};
	};

	$scope.changePassword = function() {
		var hidePage=$('#hidePage');
		hidePage.css("filter","alpha(opacity:30)");
		hidePage.css("opacity","0.3")
		var changePa=$('#dialog-changePassword');
		changePa.css("display","block");
	};

	$scope.closeDialog = function() {
		var hidePage=$('#hidePage');
		hidePage.css("filter","alpha(opacity:100)");
		hidePage.css("opacity","1")
		var changePa=$('#dialog-changePassword');
		changePa.css("display","none");
	};

	$scope.logOut = function() {
		window.location.href="http://localhost:8080/hello/login.jsp";
	};

	$scope.get = function() {
		alert("00");
	}

	$scope.getMenuList = function(obj) {
		var s="";
		var menuList=$.ajax ({
			async: true,
			cache: false,
			timeout: 1000,
			url: "GetMenuList?userName="+$('.header-left-name').html(),//+$(obj).attr("class"),
			type: "POST",
			dataType: 'json',
			contentType: "application/json;charset=utf-8",
			success: function(data) {
				$scope.menu=eval(data);
				// console.log(data);
				var i=0;
				$.each(data, function(index,item) {
				s+="<span><a href='#'>"+item+"</a></span>";
				i++;
				});
				$(obj).html(s);
				var meLi=$(obj).find('span');	
				if(obj=="#menuList") {
					$(obj).css("left",window.innerWidth?(window.innerWidth-(i+1)*(meLi.width()+parseInt(meLi.css('margin-left'))))/2-2*parseInt(meLi.css('margin-left')):
						(document.body.clientWidth-(i+1)*(meLi.width()+parseInt(meLi.css('margin-left'))))/2)-2*parseInt(meLi.css('margin-left'));					
				}
			},
			error: function() {
				alert("菜单请求失败！");
			}
		});
		return;
	};
}
