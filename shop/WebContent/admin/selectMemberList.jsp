<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	request.setCharacterEncoding("utf-8");
	
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;	
	}
	
	//검색어
	String searchMemberId="";
	if(request.getParameter("searchMemberId")!=null){
		searchMemberId = request.getParameter("searchMemberId");
	}
	System.out.println(searchMemberId+"<==selectMemberList searchMemberId");
	//페이지
	int currentPage = 1;
	//currentPage는 값이 들어오면 1대신 그 값으로 바뀜
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println(currentPage+"<==selectMemberList currentPage");
	//상수(fianl) <== rowPerPage변수 10으로 초기화되면 끝까지 10이다(변하지 않음),대문자와 스네이크 표현식으로 표시한 이유는 다른사람에게 식별하기 쉽게 하기 위해서 사용
	final int ROW_PER_PAGE = 10;
	
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	 
	MemberDao memberDao = new MemberDao();
	//배열을 호출하는 메소드가 searchMemberId의 값에 따라 달라져야 함
	ArrayList<Member> memberList = null;
	//검색어가 없을때
	int totalCount = 0;
	if(searchMemberId.equals("")==true){
		memberList = memberDao.selectMemberListAllByPage(beginRow, ROW_PER_PAGE);
		totalCount = memberDao.totalMemberCount();
	}else{	//검색어가 있을때
		memberList = memberDao.selectMemberListAllBySearchMemberId(beginRow, ROW_PER_PAGE,searchMemberId);
		totalCount = memberDao.totalMemberCount(searchMemberId);
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자(회원) 목록</title>
</head>
<body>
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<h1>회원 목록</h1>
	<table border="1">
		<thead>
			<tr>
			 	<th>memberNo</th>
			 	<th>memberId</th>
			 	<th>memberLevel</th>
			 	<th>memberName</th>
			 	<th>memberAge</th>
			 	<th>memberGender</th>
			 	<th>updateDate</th>
			 	<th>createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Member m : memberList){
			%>
					<tr>
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberId()%></td>
						<td>
							<%=m.getMemberLevel() %>
							<%	//level이 0,1로 출력되니 일반 회원,관리자 계정으로 출력되도록 함
								if(m.getMemberLevel()==0){
							%>
									<span>일반 회원</span>
							<%
								}else if(m.getMemberLevel()==1){
							%>
									<span>관리자 계정</span>
							<%
								}
							%>
						</td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getMemberAge()%></td>
						<td><%=m.getMemberGender()%></td>
						<td><%=m.getUpdateDate()%></td>
						<td><%=m.getCreateDate()%></td>
					</tr>
			<%	
				}
			%>
		</tbody>
	</table>
	<div>
	
	<%	//ISSUE:페이지가 잘되다가 검색후 페이징하면 안 된다 => ISSUE해결
		if (currentPage > 1) {
	%>
			<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage - 1%>&searchMemberId<%=searchMemberId %>">이전</a>
	<%
		}	
			int lastPage = totalCount / ROW_PER_PAGE;
		
			if (totalCount % ROW_PER_PAGE != 0) {
				lastPage += 1;
		}
		
		if (currentPage < lastPage) {
	%>
			<a href="<%=request.getContextPath()%>/admin/selectMemberList.jsp?currentPage=<%=currentPage+1%>&searchMemberId<%=searchMemberId %>">다음</a>
	<%
		}
	%>
	</div>
	<!-- memberId로 검색 -->
	<div>
		<form action="<%=request.getContextPath()%>/admin/selectMemberList.jsp" method="get">
			memberId:
			<input type="text" name="searchMemberId">
			<button type="submit">ID검색</button>
		</form>
	</div>
</body>
</html>