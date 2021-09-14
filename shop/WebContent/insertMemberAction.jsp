<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%	
	request.setCharacterEncoding("utf-8");

	//로그인 상태에서는 페이지 접근불가
	if(session.getAttribute("loginMember") != null) {
		// 다시 브라우즈에게 다른곳을 요청하도록 하는 메서드
		response.sendRedirect("./index1.jsp"); // 잘못왔으니 다시갔다가 가야할 곳으로 가라
		// 메서드를 끝냄
		return;
	}
	// 회원가입 입력값 유효성 검사
	if(request.getParameter("memberId")== null || request.getParameter("memberPw")== null || request.getParameter("memberName")== null || request.getParameter("memberAge")== null || request.getParameter("memberGender")== null) {
		// 다시 브라우즈에게 다른곳을 요청하도록 하는 메서드
		response.sendRedirect("./index1.jsp"); // 잘못왔으니 다시갔다가 가야할 곳으로 가라
		// 메서드를 끝냄
		return;
	}
	if(request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("") || request.getParameter("memberAge").equals("") || request.getParameter("memberGender").equals("")) {
		// 다시 브라우즈에게 다른곳을 요청하도록 하는 메서드
		response.sendRedirect("./insertMemberForm.jsp"); // 잘못왔으니 다시갔다가 가야할 곳으로 가라
		// 메서드를 끝냄
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	// request 매개값 디버깅
	System.out.println(memberId + " <-- memberId");
	System.out.println(memberPw + " <-- memberPw");
	System.out.println(memberName + " <-- memberName");
	System.out.println(memberAge + " <-- memberAge");
	System.out.println(memberGender + " <-- memberGender");
	
	Member member = new Member();
	member.setMemberId(memberId);
    member.setMemberPw(memberPw);
  	member.setMemberName(memberName);
   	member.setMemberAge(memberAge);
   	member.setMemberGender(memberGender);

	// 객체 생성
    MemberDao memberDao = new MemberDao();
   
    int row = memberDao.insertMember(member);
 	// 입력성공	
	if(row == 1) { 
		// 디버깅
		System.out.println("입력성공"); 
		response.sendRedirect("./loginForm.jsp");
	 //입력실패
	} else {
		System.out.println("입력실패");
		response.sendRedirect("./insertMemberForm.jsp");
	}
%>