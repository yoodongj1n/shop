package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.Comm;
import vo.Member;

public class MemberDao {
	// memberNo와 수정된 level을 입력하여 수정
	public void updateMemberLevelByAdmin(Member member) throws ClassNotFoundException, SQLException {
		System.out.println(member.getMemberNo()+"<<memberNo");
		System.out.println(member.getMemberLevel()+"<<memberLevel");
		//db접속 메소드 호출
		Comm comm = new Comm();
		Connection conn = comm.getConnection();
		
		String sql = "UPDATE member SET member_level=? WHERE member_no=?";
	    PreparedStatement stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, member.getMemberLevel());
	    stmt.setInt(2, member.getMemberNo());
	    ResultSet rs = stmt.executeQuery();
	    // 디버깅
	    System.out.println(stmt + " <-- stmt");
	    
 		rs.close();
 		stmt.close();
 		conn.close();
	}
	
	// memberNo와 수정된 PW를 입력하여수정
	public void updateMemberPwByAdmin(Member member, String memberNewPw) throws ClassNotFoundException, SQLException {
		System.out.println(member.getMemberNo()+"<<memberNo");
		System.out.println(member.getMemberPw()+"<<memberPw");
		
		//db접속 메서드 호출
		Comm comm = new Comm();
		Connection conn = comm.getConnection();
		String sql = "UPDATE member SET member_pw=PASSWORD(?) WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberNewPw);
		stmt.setInt(2, member.getMemberNo());
		// 디버깅
		System.out.println(stmt + "<--- stmt");
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
	}
		
	// memberNo입력하면 삭제하는 메서드(강제탈퇴)
	public void deleteMemberByAdmin(int memberNo) throws ClassNotFoundException, SQLException {
		System.out.println(memberNo+"<<memberNo");
		
		//db접속 메서드 호출
		Comm comm = new Comm();
		Connection conn = comm.getConnection();
		String sql = "DELETE FROM member WHERE member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		// 디버깅
		System.out.println(stmt + "<--- stmt");
		
		stmt.executeUpdate();
		
		stmt.close();
		conn.close();
	}
	
	// [관리자] 회원 관리  검색 목록 출력
	public ArrayList<Member> selectMemberListAllBySearchMemberId(int beginRow, int rowPerPage, String searchMemberId) throws SQLException, ClassNotFoundException {
		ArrayList<Member> list = new ArrayList<Member>();
		System.out.println(beginRow+"<<beinRow");
		System.out.println(rowPerPage+"<<rowPerPage");
		System.out.println(searchMemberId+"<<searchMemberId");
		/*
		 SELECT
		 	member_no memberNo,
		 	member_id memberId,
		 	member_level memberLevel,
		 	member_name memberName,
		 	member_age memberAge,
		 	member_gender memberGender,
		 	update_date updateDate,
		 	create_date createDate
		 	FROM member 
			WHERE member_id LIKE ?
			ORDER BY create_date DESC 
			LIMIT ?,?
		 */
		//db접속 메소드 호출
		Comm comm = new Comm();
		Connection conn = comm.getConnection();
		//쿼리 생성 및 실행
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member WHERE member_id LIKE ? ORDER BY create_date DESC LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchMemberId+"%");
		stmt.setInt(2, beginRow);
		stmt.setInt(3, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		//리스트에 값 넣기
		while(rs.next()) {
				Member member = new Member();
				member.setMemberNo(rs.getInt("memberNo"));
				member.setMemberId(rs.getString("memberId"));
				member.setMemberLevel(rs.getInt("memberLevel"));
				member.setMemberName(rs.getString("memberName"));
				member.setMemberAge(rs.getInt("memberAge"));
				member.setMemberGender(rs.getString("memberGender"));
				member.setUpdateDate(rs.getString("updateDate"));
				member.setCreateDate(rs.getString("createDate"));
				list.add(member);
		}
		//접속 종료
		rs.close();
		stmt.close();
		conn.close();
		//값 리턴
		return list;
	}
	
	
	
	
	
	// [관리자] 회원목록출력
		public ArrayList<Member> selectMemberListAllByPage(int beginRow, int rowPerPage) throws SQLException, ClassNotFoundException {
			ArrayList<Member> list = new ArrayList<Member>();
			System.out.println(beginRow + "<<beinRow");
			System.out.println(rowPerPage + "<<rowPerPage");
			/*
			 SELECT
			 	member_no memberNo,
			 	member_id memberId,
			 	member_level memberLevel,
			 	member_name memberName,
			 	member_age memberAge,
			 	member_gender memberGender,
			 	update_date updateDate,
			 	create_date createDate
			 */
			//db접속 메소드 호출
			Comm comm = new Comm();
			Connection conn = comm.getConnection();
			//쿼리 생성 및 실행
			String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, member_age memberAge, member_gender memberGender, update_date updateDate, create_date createDate FROM member ORDER BY create_date DESC LIMIT ?,?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			ResultSet rs = stmt.executeQuery();
			//리스트에 값 넣기
			while(rs.next()) {
					Member member = new Member();
					member.setMemberNo(rs.getInt("memberNo"));
					member.setMemberId(rs.getString("memberId"));
					member.setMemberLevel(rs.getInt("memberLevel"));
					member.setMemberName(rs.getString("memberName"));
					member.setMemberAge(rs.getInt("memberAge"));
					member.setMemberGender(rs.getString("memberGender"));
					member.setUpdateDate(rs.getString("updateDate"));
					member.setCreateDate(rs.getString("createDate"));
					list.add(member);
			}
			//접속 종료
			rs.close();
			stmt.close();
			conn.close();
			//값 리턴
			return list;
		}
			//총 멤버 수
			public int totalMemberCount() throws ClassNotFoundException, SQLException {
				int totalCount = 0 ;
				//db접속 메소드 호출
				Comm comm = new Comm();
				Connection conn = comm.getConnection();
				//쿼리생성, 실행
				String sql = "SELECT count(*) FROM member";
				PreparedStatement stmt = conn.prepareStatement(sql);
				
				ResultSet rs= stmt.executeQuery();
				while(rs.next()) {
					totalCount = rs.getInt("count(*)");
				}
				
				return totalCount;
			}
			public int totalMemberCount(String searchMemberId) throws ClassNotFoundException, SQLException {
				int totalCount = 0 ;
				//db접속 메소드 호출
				Comm comm = new Comm();
				Connection conn = comm.getConnection();
				//쿼리생성, 실행
				String sql = "SELECT count(*) FROM member WHERE member_id LIKE ?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%"+searchMemberId+"%");
				ResultSet rs= stmt.executeQuery();
				while(rs.next()) {
					totalCount = rs.getInt("count(*)");
				}
				
				return totalCount;
			}
		
		// 1. 회원가입
		public int insertMember(Member member) throws ClassNotFoundException, SQLException {
			// 매개변수값은 무조건! 디버깅
			System.out.println(member.getMemberId() + "<-- Member.insertMember param memberId");
			
			Comm comm = new Comm();
			Connection conn = comm.getConnection();
			String sql = "INSERT INTO member(member_id, member_pw, member_level, member_name, member_age, member_gender, update_date, create_date) VALUES(?,PASSWORD(?),0,?,?,?,NOW(),NOW())";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			
			stmt.setString(1,  member.getMemberId());
			stmt.setString(2,  member.getMemberPw());			
			stmt.setString(3,  member.getMemberName());
			stmt.setInt(4,  member.getMemberAge());
			stmt.setString(5,  member.getMemberGender());			
			int row = stmt.executeUpdate();

			stmt.close();
			conn.close();
			
			return row;
		}
	
	
		// 2. 로그인
		// 로그인 성공시 리턴값 Member : memberId + memberName
		// 로그인 실패시 리턴값 Member : null
		public Member login(Member member) throws ClassNotFoundException, SQLException {
			Member returnMembmer = null;
			// 매개변수값은 무조건! 디버깅
			System.out.println(member.getMemberId()+" <-- MemberDao.login param : memberId");
			System.out.println(member.getMemberPw()+" <-- MemberDao.login param : memberPw");
			
			Comm comm = new Comm();
			Connection conn = comm.getConnection();
			String sql = "SELECT member_no memberNo, member_id memberId, member_name memberName, member_level memberLevel  FROM member WHERE member_id=? AND member_pw=PASSWORD(?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, member.getMemberId());
			stmt.setString(2, member.getMemberPw());
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				Member returnMember = new Member();
				returnMember.setMemberNo(rs.getInt("memberNo"));
				returnMember.setMemberId(rs.getString("memberId"));
				returnMember.setMemberName(rs.getString("memberName"));
				returnMember.setMemberLevel(rs.getInt("memberLevel"));
				return returnMember;
			}
			rs.close();
			stmt.close();
			conn.close();
			
			return null;
		}
}
