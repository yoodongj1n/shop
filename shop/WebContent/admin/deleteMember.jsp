<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import="vo.*" %>

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
	if(request.getParameter("memberNo")==null || request.getParameter("memberNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
		return;
	}
	// request 값 저장
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	// requst값 디버깅
	System.out.println(memberNo+" <-- memberNo");
	
	memberDao.deleteMemberByAdmin(memberNo);
	System.out.println("강제 탈퇴 성공");
	response.sendRedirect(request.getContextPath()+"/admin/selectMemberList.jsp");
%>