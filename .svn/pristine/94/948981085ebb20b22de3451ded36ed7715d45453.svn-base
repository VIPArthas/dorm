<%@ page pageEncoding="UTF-8" session="false"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:directive.include file="includes/top.jsp" />

<div class="login-footer"></div>
<div style="text-align: center;">授权成功！正在转接中，本页面将在<span id="_closetime">2</span>秒后自动关闭！</div>
<div class="login-footer"></div>
<a href="javascript:window.close();">关闭</a>

<jsp:directive.include file="includes/bottom.jsp" />

<script type="text/javascript">
<!--
var t;
var close = function(){
	var i = Number(document.getElementById("_closetime").innerText);
	if(i <= 1){
		clearInterval(t);
	}else{
		document.getElementById("_closetime").innerText = i-1;
	}
// 	window.opener=null;
// 	window.open('','_self');
// 	window.close();
}
t = setInterval(close,1000);
//-->
</script>