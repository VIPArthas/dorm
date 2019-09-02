<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%String flag = (String)request.getParameter("flag"); %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>修改密码</title>
<link rel="stylesheet" type="text/css" href="${ctx}/static/bootstrap-3.3.4-dist/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/change-password-style.css" />
<script type="text/javascript" src="${ctx}/static/js/jquery/jquery-1.9.1.min.js"></script>
<script type="text/javascript" >
$(function(){
	var username=getQueryString("username");
	$("#username").val(username);
	if(<%=flag%> == '0'){
		
		$("#oneLi").removeClass("active");
		$("#sendMail").removeClass("active");
		$("#updateLi").addClass("active");
		$('.change-paword-01').animate({"left":"90%","opacity":"0","z-index":"0"},500);
		$('.change-paword-04').animate({"left":"90%","opacity":"0","z-index":"0"},500);
		$('.change-paword-02').animate({"left":"50%","margin-left":"-210"+"px","opacity":"1","z-index":"1"},500);
	}
});
function next04(){
	$("#updateLi").addClass("active");
	$("#sendMail").removeClass("active");
	$('.change-paword-04').animate({"left":"90%","opacity":"0","z-index":"0"},500);
	$('.change-paword-02').animate({"left":"50%","margin-left":"-210"+"px","opacity":"1","z-index":"1"},500);
}
function next01(){
	$("#sendMail").addClass("active");
	$("#oneLi").removeClass("active");
	$('.change-paword-01').animate({"left":"90%","opacity":"0","z-index":"0"},500);
	$('.change-paword-04').animate({"left":"50%","margin-left":"-210"+"px","opacity":"1","z-index":"1"},500);
}
function next02(){
	$("#succLi").addClass("active");
	$("#updateLi").removeClass("active");
	$('.change-paword-02').animate({"left":"90%","opacity":"0","z-index":"0"},500);
	$('.change-paword-03').animate({"left":"50%","margin-left":"-210"+"px","opacity":"1","z-index":"1"},500);
}
function prev02(){
	$("#oneLi").addClass("active");
	$("#sendMail").removeClass("active");
	$('.change-paword-04').animate({"left":"0","opacity":"0","z-index":"0"},500);
	$('.change-paword-01').animate({"left":"50%","margin-left":"-210"+"px","opacity":"1","z-index":"1"},500);
	clearPwd();
}
var clearPwd=function(){
	$("#oldpwd").val("");
	$("#newpwd1").val("");
	$("#newpwd2").val("");
	$("#oldpwdSpan").css("display","none");
	$("#newpwd1Span").css("display","none");
	$("#newpwd2Span").css("display","none");
};
var checkNewPwd=function(){
	if($("#newpwd1").val()!=""&&$("#newpwd2").val()!=""&&$("#newpwd1").val()!=$("#newpwd2").val()){
		$("#newpwd2Span").html("两次密码不同");
		$("#newpwd2Span").css("display","inline");
	}else{
		$("#newpwd1Span").css("display","none");
		$("#newpwd2Span").css("display","none");
	}
}
var checkOldPwd=function(){
	var errString="该字段不能为空";
	if($("#oldpwd").val()==""){
		$("#oldpwdSpan").html(errString);
		$("#oldpwdSpan").css("display","inline");
		pwdFlag=false;
	}else{
		$("#oldpwdSpan").css("display","none");
	}
}
var checkmail = function(changeb){
	//验证邮箱
	var chekcEmail=true;
	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$");
	if($("#email").val()==""){
		$("#userspan1").html("邮箱不能为空");
		$("#userspan1").css("display","inline");
		chekcEmail=false;
	}else if(!reg.test($("#email").val())){ //正则验证不通过，格式不对
		$("#userspan1").html("邮箱格式不对");
		$("#userspan1").css("display","inline");
		chekcEmail=false;
	}
	//发送邮件
	if(chekcEmail){
		$("#userspan1").css("display","none");
		$.ajax({
			 type: "POST",
		     async:true,
		     url:"${ctx}/sendMail",
		     data:{username:$("#username").val(),email:$("#email").val()},
		     success: function(data){
		    	 if(data == 'true'){
		    		 $("#userspan1").html("邮件发送成功，请注意查收");
		    		 $("#userspan1").css("display","inline");
		    	 }else{
		    		 $("#userspan1").html("邮件发送失败，请重新发送");
		    		 $("#userspan1").css("display","inline");
		    	 }
		     }
		});
	}
}
var chekcUser=function(changeb){
	var chekcUserFlag=true;
	var chekcIdCard=true;
	$('#idcard').attr("disabled",false);
	if($("#username").val()==""){
		$("#userspan").html("账号不能为空");
		$("#userspan").css("display","inline");
		chekcUserFlag=false;
	}
	if($("#username").val()=="admin"){
		$("#userspan").html("抱歉，暂不能操作admin用户");
		$("#userspan").css("display","inline");
		$('#idcard').attr("disabled",true);
		chekcUserFlag=false;
	}else{
		$('#idcard').attr("disabled",false);
		if($("#idcard").val()==""){
			$("#useridcard").html("身份证号不能为空");
			$("#useridcard").css("display","inline");
			chekcIdCard=false;
		}
	}
	if(chekcUserFlag){$("#userspan").css("display","none");}
	if(chekcIdCard){$("#useridcard").css("display","none");}
	if(chekcUserFlag && chekcIdCard){
		
		$(changeb).attr("disabled","disabled")	;
		$.ajax({
			     type: "POST",
			     async:true,
			     url:"${ctx}/checkUser",
			     data:{username:$("#username").val(),
			    	 idcard:$("#idcard").val()},
			     success: function(data){
			    	 var list = JSON.parse(data);
			    	$(changeb).removeAttr("disabled");
			    	if(list[0] == 'true'){
			    		
			    		next01();
			    		$("#userspan").css("display","none");
			    		$("#useridcard").css("display","none");
			    		$("#userspan1").css("display","none");
			    	
			    		
			    	}else{
			    		if(list[0] == 'nouser'){
				    		$("#userspan").html("账号不存在");
				    		$("#userspan").css("display","inline");
				    	}
			    		if($("#username").val()!='admin'){
					    	if(list[0] == 'noidcard'){
					    		$("#useridcard").html("系统未录入您的身份证号，请联系管理员");
					    		$("#useridcard").css("display","inline");
					    		
					    	}else if(list[0] == 'false'){
					    		$("#useridcard").html("您输入的身份证号与系统录入的不一致，请确认");
					    		$("#useridcard").css("display","inline");
					    	} 
			    		}
			    	} 
			    	
			     }
		});
	} 
}
function getQueryString(name) { 
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
	var r = window.location.search.substr(1).match(reg); 
	if (r != null) return unescape(r[2]); return null; 
	} 
var changePwd=function(changeb){
	var pwdFlag=true;
	var errString="该字段不能为空";
	if($("#newpwd1").val()==""){
		$("#newpwd1Span").html(errString);
		$("#newpwd1Span").css("display","inline");
		pwdFlag=false;
	}else{
		$("#newpwd1Span").css("display","none");
	}
	if($("#newpwd2").val()==""){
		$("#newpwd2Span").html(errString);
		$("#newpwd2Span").css("display","inline");
		pwdFlag=false;
	}else{
		$("#newpwd2Span").css("display","none");
	}
	var changing=function(){
		$(changeb).val("正在修改...");
		$(changeb).attr("disabled","disabled")	;
		$(changeb).prev().attr("disabled","disabled")	;
		}
	var nochanging=function(){
		$(changeb).val("修改");
		$(changeb).prev().removeAttr("disabled");
		$(changeb).removeAttr("disabled");
	}
	changing();
	if(pwdFlag){
		if($("#newpwd1").val()!=$("#newpwd2").val()){
			$("#newpwd2Span").css("display","inline");
		}else{
			$("#oldpwdSpan").css("display","none");
			changing();
			$.ajax({
			     type: "POST",
			     async:true,
			     url:"${ctx}/changePwd",
			     data:{username:$("#username").val(), newpwd:$("#newpwd1").val()},
			     success: function(data){
			    	if(data == 'true'){
			    		var casLogoutUrl="${ctx}/logout";
			    		var sec=3;
			    		var reload=function(){
			    			$("#reloadSec").text(sec);
			    			if(sec==0){
			    				window.location.href=casLogoutUrl;	
			    			}else{
			    				sec--;
			    			}
			    		}
			    		setInterval(reload,1000);
			    		$("#loginCas").click(function(){
			    			window.location.href=casLogoutUrl;	
			    		});
			    		next02();
			    		clearPwd();
			    	}else{
			    		nochanging();
			    		$("#oldpwdSpan").html(data.name);
			    		$("#oldpwdSpan").css("display","inline");
			    	}
			    	
			     }
			 });
		}
	}
}
</script>
</head>
<body>
<div class="change-psword-box container">
		<div class="change-psword-head">
			<ol class="list-unstyled">
				<li id="oneLi" class="active"><div>确认<br>用户名</div><span>1</span></li>
				<li id="sendMail"><div>发送<br>邮件</div><span>2</span></li>
				<li id="updateLi"><div>修改<br>新密码</div><span>3</span></li>
				<li id="succLi"><div>完成</div><span>4</span></li>
			</ol>
		</div>
        <div>
		<div class="change-paword-con change-paword-01" style="width: 420px;">
			<form action="">
            	<div class="text-center" style="margin-top:10px;margin-bottom:53px;">
					<span class="user-img"><img src="${ctx}/images/user-round.jpg" alt=""></span>
                </div>
                <div class="form-group mar-tb-30 clearfix">
                	<div class="wid-20 text-right"><span class="lab-img"></span></div>
                    <div class="wid-80">
                    	<div class="wid-75">
                    		<input type="text" id="username" class="form-control bg-gray-input1" placeholder="请输入您的账号">
                        </div>
                        <div class="color-red" style="display: none" id="userspan"></div>
                    </div>
                                
                </div>
                <div class="form-group mar-tb-30 clearfix">
                	<div class="wid-20 text-right"><span class="lab-img"></span></div>
                    <div class="wid-80">
                    	<div class="wid-75">
                    		<input type="text" id="idcard" class="form-control bg-gray-input1" placeholder="请输入您的身份证号">
                        </div>
                        <div class="color-red" style="display: none" id="useridcard"></div>
                    </div>
                                
                </div>
                <div class="form-group mar-t-30 clearfix">
                	<div class="wid-20"></div>
                    <div class="wid-60"><input type="button" class="btn form-control btn-blue" onClick="chekcUser(this);" value="下一步" /></div>
                    <div class="wid-20"></div>
                </div>
			</form>
		</div>
		<!--第一步 end-->
		<div class="change-paword-con change-paword-04" style="width: 420px;">
			<form action="">
            	<div class="text-center" style="margin-top:10px;margin-bottom:53px;">
					<span class="user-img"><img src="${ctx}/images/user-round.jpg" alt=""></span>
                </div>
                <div class="form-group mar-tb-30 clearfix">
                	<div class="wid-20 text-right"><span class="lab-img"></span></div>
                    <div class="wid-80">
                    	<div class="wid-75">
                    		<input type="text" id="email" class="form-control bg-gray-input1" placeholder="请输入您的可用邮箱">
                        </div>
                        <div class="color-red" style="display: none" id="userspan1"></div>
                    </div>             
                </div>
                <div class="form-group mar-t-58 clearfix">
                	<div class="wid-20"></div>
                    <div class="wid-60">
                    <input type="button" class="btn form-control btn-blue wid-49 pull-left" onClick="prev02();" value="返回" />
                        <input type="button" id="sendbutton" class="btn form-control btn-blue wid-49 pull-right" onClick="checkmail(this);" value="发送邮件" />
                    </div>
                    <div class="wid-20"></div>
                </div>
			</form>
		</div>
            <!--第二步 end-->
        <div class="change-paword-con change-paword-02" style="width: 420px;">
            <form action="">
            
                <div class="form-group mar-tb-30 clearfix">
                	<div class="wid-20 text-right"><span class="lab-img lab-img-two new-pawrd"></span></div>
                    <div class="wid-80">
                    	<div class="wid-75">
                    		<input type="password" class="form-control bg-gray-input1" id="newpwd1" placeholder="新密码" onblur="checkNewPwd();" autocomplete="off" />
                        </div>
                        <div class="color-red" display: none;" id="newpwd1Span"></div>
                    </div>    
                </div>
                <div class="form-group mar-tb-30 clearfix">
                	<div class="wid-20 text-right"><span class="lab-img lab-img-two new-pawrd-again"></span></div>
                    <div class="wid-80">
                    	<div class="wid-75">
                    		<input type="password" class="form-control bg-gray-input1" id="newpwd2" placeholder="确认密码" onblur="checkNewPwd();" autocomplete="off" />
                        </div>
                        <div class="color-red" display: none;" id="newpwd2Span"></div>
                    </div>    
                </div>
                <div class="form-group mar-t-58 clearfix">
                	<div class="wid-20"></div>
                    <div class="wid-60">
                    	<!-- <input type="button" class="btn form-control btn-blue wid-49 pull-left" onClick="prev02();" value="返回" /> -->
                        <input type="button" class="btn form-control btn-blue" onClick="changePwd(this);" value="修改" />
                    </div>
                    <div class="wid-20"></div>
                </div>
			</form>
		</div>
        <!--第三步 end-->
        <div class="change-paword-con change-paword-03" style="width: 420px;">
            <form action="">
                <div class="text-center" style="margin-top:90px;margin-bottom:108px;"><img src="${ctx}/images/change-password-ok.png" alt=""></div>
                <div class="form-group mar-t-58 clearfix">
                	<p class="text-center"><span id="reloadSec"></span>秒后，将自动进入跳转页面...</p>
                	<div class="wid-20"></div>
                    <div class="wid-60">	
                    	<input type="button" class="btn form-control btn-blue" id="loginCas" value="立即登录" />
                    </div>
                    <div class="wid-20"></div>
                </div>
			</form>
		</div>
        <!--第四步 end-->
        </div>
	</div>
</body>
</html>