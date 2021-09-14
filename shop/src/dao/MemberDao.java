package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.Comm;
import vo.Member;
public class MemberDao {
		
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
