<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import = "dao.*" %>

<%
	request.setCharacterEncoding("utf-8");
	//MemberDao 객체 생성
	MemberDao memberDao = new MemberDao();
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가.
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index1.jsp");
		return;	
	}
	// 입력값 방어 코드
	if(request.getParameter("memberNo")==null || request.getParameter("memberNo").equals("") || request.getParameter("memberPw")==null || request.getParameter("memberPw").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
		return;
	}

	// request 값 저장
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberNewPw = request.getParameter("memberPw");
	// requst값 디버깅
	System.out.println(memberNo+" <-- memberNo");
	System.out.println(memberNewPw+" <-- memberNewPw");
	// 객체 생성
	Member member = new Member();
	member.setMemberNo(memberNo);
	
	memberDao.updateMemberPwByAdmin(member, memberNewPw);
	System.out.println("수정 성공");
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>