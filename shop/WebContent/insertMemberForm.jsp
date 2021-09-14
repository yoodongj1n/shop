<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		// 로그인 상태에서는 페이지 접근불가
		if(session.getAttribute("loginMember") != null) {
			// 다시 브라우즈에게 다른곳을 요청하도록 하는 메서드
			response.sendRedirect("./index.jsp"); // 잘못왔으니 다시갔다가 가야할 곳으로 가라
			// 메서드를 끝냄
			return;
		}
%>
	<h1>회원가입</h1>
	<form method = "post" action="./insertMemberAction.jsp">
		<!-- memberId -->
		<div>memberId : </div>
		<div><input type="text" name="memberId"></div>
		<!-- memberPw -->
		<div>memberPw : </div>
		<div><input type="password" name="memberPw"></div>
		<!-- memberName -->
		<div>memberName : </div>
		<div><input type="text" name="memberName"></div>
		<!-- memberAge -->
		<div>memberAge : </div>
		<div><input type="text" name="memberAge"></div>
		<!-- memberGender -->
		<div>memberGender : </div>
		<div>
			<input type="radio" name="memberGender" value="남">남
			<br>
			<input type="radio" name="memberGender" value="여">여
		</div>
		<div><button type="submit">회원가입</button></div>
	</form>
</body>
</html>