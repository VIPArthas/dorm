<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License.  You may obtain a
    copy of the License at the following location:

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<%@ page session="false" %>
<%@ page language="java" import="com.jhnu.util.common.PropertiesUtils" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String casname = "统一身份认证平台";
%>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>
<c:set var="ctxImg" value="${pageContext.request.contextPath}/login/img"/>
<c:set var="sysSize"  value="${fn:length(sys)}"/>
<c:set var="sysrows" value="${sysSize%4>0?sysSize/4:sysSize/4-1}"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/login/css/tip.css">
<jsp:directive.include file="includes/top.jsp" />


<div class="container">
	<div class="login-header login-mar-t50">
		<h3><a><img src="${ctxImg }/logo.png"/></a></h3>
		<a class="login-header-infor" title="<%=PropertiesUtils.getDBPropertiesByName("sys.version")%>"><%=casname %></a>
		<nav>
	      <a >你好，${name }</a> 
	      <span style="color:#999;">|</span> 
	      <a href="<%=PropertiesUtils.getDBPropertiesByName("sys.dmmUrl")%>/user/changepwd/page?username=${user }">修改密码</a>
	      <span style="color:#999;">|</span>
	      <a href="${ctx }/logout">退出</a>
	    </nav>
	</div>
</div>
<!-- 提示 -->
<div class="login-bgcolor-tip">
  <div class="login-tip-box">
  	<h3>登录成功</h3>
  	<p>您已经成功登录<%=casname %>。<br>出于安全考虑，一旦您访问过那些需要您提供凭证信息的应用时，请操作完成之后关闭浏览器。 </p>
  </div>
</div>
