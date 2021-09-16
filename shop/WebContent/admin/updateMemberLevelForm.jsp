<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="commons.*" %>
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
	// 입력값 방어코드
	if(request.getParameter("memberNo")==null || request.getParameter("memberNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
		return;
	}
	
	// request 값 저장
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// requst값 디버깅
	System.out.println(memberNo+" <-- memberNo");
	
	Member member = new Member();
	member.setMemberNo(memberNo);	
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<h1>등급수정</h1>
	<form method="post" action="./updateMemberLevelAction.jsp">
		<div>memberNo : </div>
			<input type="text" name="memberNo" value="<%=member.getMemberNo()%>" readonly="readonly">		
		<div>
			memberLevel : 
			<select name="memberLevel">
				<option value="0">0 (일반회원)</option>
				<option value="1">1 (관리자)</option>				
			</select>
		</div>		
		<button type="submit">수정</button>
	</form>
</body>
</html>