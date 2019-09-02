<%@ page language="java"  pageEncoding="UTF-8"%>
<% /* String msg = request.getAttribute("msg"); */
 String msg1 = (String)request.getAttribute("msg");%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<h2><%=msg1 %></h2>
</body>
</html>