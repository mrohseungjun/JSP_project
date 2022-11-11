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

	@Override //�߰�
	public void MemberInsert(MemberDTO member) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = getConnection();
			// ȫ�浿   111 �λ� 010-1111-2222
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
	

	@Override //��ü����
	public ArrayList<MemberDTO> memberList() {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		ArrayList<MemberDTO> arr   = new ArrayList<MemberDTO>();
	
		try {
			con = getConnection();
			
			String	sql = "select * from memberdb "; //�˻��ƴ�
			
			st = con.createStatement();
			rs= st.executeQuery(sql);
			while(rs.next()) {
				MemberDTO ad = new MemberDTO(); 
				ad.setName(rs.getString("name"));//html�� name��
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

	@Override //����
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
		


	@Override //����
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

	@Override // �󼼺���
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

	@Override// ���̵� �ߺ�Ȯ��
	public String idCheck(String userid) {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		String flag="yes";//��밡��
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
	@Override //�α��� üũ
	public int loginCheck(String userid, String pwd) {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		int flag=-1;// ȸ���ƴ�(-1) , ȸ�� ����(0), ��� ���� (2)
		
		try{
			con =getConnection();
			String sql = "select pwd,admin from memberdb where userid ='"+userid+"'";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()) {// ȸ���̰ų� ��� ����
				if(rs.getString("pwd").equals(pwd)) {//ȸ�� �˻��� ���̵��� ��й�ȣ�� equals ��й�ȣ
					flag=rs.getInt("admin");
				}else {//ȸ�������� ��� ����
					flag=2; //�α��ξȵ�
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
	}finally {
		closeConnection(con, null, st, rs);
	}
		return  flag;
	}//loginCheck

	@Override// ȸ����
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
	
	// �ݱ�
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


