<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index1.jsp</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
%>
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/submenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<h1>메인페이지</h1>
<%
	if(session.getAttribute("loginMember") == null) {
%>
	<div>
		<!-- 로그인 전  -->
		<div><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></div>
		<div><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></div>
	</div>
		<%
			} else {
				Member loginMember = (Member)session.getAttribute("loginMember");
		%>
		<!-- 로그인 -->
		<div><%=loginMember.getMemberName()%>님 반갑습니다.<a href="./logout.jsp">로그아웃</a></div>
		<div><a href="./selectMemberOne.jsp">회원정보</a></div>
<%	
	}
%>
	
</body>
</html>