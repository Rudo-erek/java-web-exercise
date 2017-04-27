var LeftMenuListController=function($scope) {

	$scope.getLeftMenuList = function(obj) {
		var s1="";
		var leftMenuList=$.ajax ({
			async: true,
			cache: false,
			timeout: 1000,
			url: "GetLeftMenuList?userName="+$('.header-left-name').html(),
			type: "POST",
			dataType: 'json',
			contentType: "application/json;charset=utf-8",
			success: function(data1) {
				$scope.menu=eval(data1);
				var i=0;
				$.each(data1, function(index,item) {
					s1+="<span onclick='dire(this)'><a href='#'>"+item+"</a></span>";
					i++;
				});
				$("#list").html(s1);
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

	$scope.dire= function() {
		var obj="请假";
		// $('.toDoData').attr('ng-include',"'jsp/askforleave.jsp'");
		var s="<div class='toDoData' ng-include=\"'jsp/askforleave.jsp'\">"+"</div>";
		$("#main").html(s);
	}
}

var dire= function(obj) {
	if($(obj).find('a').html()=="请假") {
		$(obj).find('a').attr("target","main");
		$(obj).find('a').attr("href","jsp/askforleave.jsp");
		// $('#main').find('iframe').attr('src','jsp/askforleave.jsp');
	} 
	else if($(obj).find('a').html()=="我的待办") {
		$(obj).find('a').attr("target","main");
		$(obj).find('a').attr("href","GetToDoList");
		// $('#main').find('iframe').attr('src','jsp/todolist.jsp');
	}
	else if($(obj).find('a').html()=="请假统计") {
		$(obj).find('a').attr("target","main");
		$(obj).find('a').attr("href","GetAlreadyDoneList?action=already_agree");
		// $('#main').find('iframe').attr('src','jsp/todolist.jsp');
	}
}
