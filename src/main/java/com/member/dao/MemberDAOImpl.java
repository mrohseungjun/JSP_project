package com.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.member.dto.MemberDTO;

public class MemberDAOImpl implements MemberDAO {
	private static MemberDAO instance = new MemberDAOImpl();
	public static MemberDAO getInstance() {
		return instance;
	} 
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource  ds = (DataSource)envCtx.lookup("jdbc/jsp");
		return ds.getConnection();
	}

	@Override //추가
	public void MemberInsert(MemberDTO member) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getConnection();
			// 홍길동   111 부산 010-1111-2222
			String sql = "insert into memberdb(name,userid, pwd, email, phone, admin) "
					+ " values(?,?,?,?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1, member.getName());
			ps.setString(2,member.getUserid());
			ps.setString(3,  member.getPwd());
			ps.setString(4, member.getEmail());
			ps.setString(5, member.getPhone());
			ps.setString(6, member.getAdmin());
			ps.executeUpdate();  
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConnection(con,ps, null, null);
		}
		
	}
	

	@Override //전체보기
	public ArrayList<MemberDTO> memberList() {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		ArrayList<MemberDTO> arr   = new ArrayList<MemberDTO>();
	
		try {
			con = getConnection();
			
			String	sql = "select * from memberdb "; //검색아님
			
			st = con.createStatement();
			rs= st.executeQuery(sql);
			while(rs.next()) {
				MemberDTO ad = new MemberDTO(); 
				ad.setName(rs.getString("name"));//html의 name값
				ad.setUserid(rs.getString("userid"));
				ad.setPwd(rs.getString("pwd"));
				ad.setEmail(rs.getString("email"));
				ad.setPhone(rs.getString("phone"));
				ad.setAdmin(rs.getString("admin"));
				arr.add(ad);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConnection(con, null, st, rs);
		}
		return arr;
	}

	@Override //수정
	public void memberUpade(MemberDTO member) {
		Connection con = null;
		PreparedStatement ps =null;
		try {
			con = getConnection();
			String sql="update memberdb set name=?, pwd=?, admin=?, email=?, phone=? where userid=?";
			ps= con.prepareStatement(sql);	
			ps.setString(1,member.getName());
			ps.setString(2,member.getPwd());
			ps.setString(3,member.getAdmin());
			ps.setString(4,member.getEmail());
			ps.setString(5,member.getPhone());
			ps.setString(6,member.getUserid());
			ps.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConnection(con, ps, ps, null);
		}
	}
		


	@Override //삭제
	public void memberDelete(String userid) {
		Connection con = null;
		Statement st = null;
		try {
			con =getConnection();
			String sql = "delete from memberdb where userid='"+userid+"'";
			st = con.createStatement();
			st.execute(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConnection(con, null, st, null);
		}
		
	}

	@Override // 상세보기
	public MemberDTO fineById(String userid) {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		MemberDTO dto = null;
		try {
			con=getConnection();
			String sql = "select* from memberdb where userid = '"+userid+"'";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setName(rs.getString("name"));
				dto.setUserid(rs.getString("userid"));
				dto.setPwd(rs.getString("pwd"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				dto.setAdmin(rs.getString("admin"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnection(con, null, st, rs);
		}
		return dto;
	}

	@Override// 아이디 중복확인
	public String idCheck(String userid) {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		String flag="yes";//사용가능
		try{
			con =getConnection();
			String sql = "select * from memberdb where userid ='"+userid+"'";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()) {
				flag="no";
			}
		}catch (Exception e) {
			e.printStackTrace();
	}finally {
		closeConnection(con, null, st, rs);
	}
		return  flag;
	}
	@Override //로그인 체크
	public int loginCheck(String userid, String pwd) {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		int flag=-1;// 회원아님(-1) , 회원 성공(0), 비번 오류 (2)
		
		try{
			con =getConnection();
			String sql = "select pwd,admin from memberdb where userid ='"+userid+"'";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()) {// 회원이거나 비번 오류
				if(rs.getString("pwd").equals(pwd)) {//회원 검색된 아이디의 비밀번호의 equals 비밀번호
					flag=rs.getInt("admin");
				}else {//회원이지만 비번 오류
					flag=2; //로그인안됨
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
	}finally {
		closeConnection(con, null, st, rs);
	}
		return  flag;
	}//loginCheck

	@Override// 회원수
	public int getCount() {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		int count = 0;
		
		try{
			con = getConnection();
			String sql = "select count(*) from memberdb";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConnection(con, null, st, rs);
		}
		return count;
	}
	
	// 닫기
	private void closeConnection(Connection con, PreparedStatement ps,
			Statement st, ResultSet rs) {
			try {
				if(con !=null) 			con.close();
				if(ps !=null) 				ps.close();
				if(st !=null) 				st.close();
				if(rs !=null) 				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		
	}

}


