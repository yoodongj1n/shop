<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가.
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index1.jsp");
		return;	
	}
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberPw=request.getParameter("memberPw");	
	
	Member member = new Member();
	member.setMemberNo(memberNo);
	member.setMemberPw(memberPw);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 비밀번호 수정</h1>
	<form method="post" action="./updateMemberPwAction.jsp">
		<div>memberNo : </div>
			<input type="text" name="memberNo" value="<%=member.getMemberNo()%>" readonly="readonly">
		<div>memberPw : </div>
			<input type="password" name="memberPw">					
		<button type="submit">수정</button>
	</form>
</body>
</html>