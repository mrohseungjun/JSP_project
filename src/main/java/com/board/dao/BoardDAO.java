package com.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.board.dto.BoardDTO;

public class BoardDAO {
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	} 
	
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource  ds = (DataSource)envCtx.lookup("jdbc/jsp");
		return ds.getConnection();
	}
	

//추가
	public void boradInsert(BoardDTO board ) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con =getConnection();
			String sql = "insert into board(num,writer,subject,email,content,ip,password)"
					+"values(board_seq.nextval,?,?,?,?,?,?)";
					ps = con.prepareStatement(sql);
					ps.setString(1,board.getWriter());
					ps.setString(2,board.getSubject());
					ps.setString(3,board.getEmail());
					ps.setString(4,board.getContent());
					ps.setString(5,board.getIp());
					ps.setString(6,board.getPasswd());
					ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConnection(con,ps, null, null);
		}
		
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
		
	//전체보기
		public ArrayList<BoardDTO> boardList(){
			Connection con = null;
			Statement st=null;
			ResultSet rs= null;
			ArrayList<BoardDTO> arr = new ArrayList<BoardDTO>();
			
			try {
				con = getConnection();
				String sql = "select * from board";
				st= con.createStatement();
				rs=st.executeQuery(sql);
				while(rs.next()) {
					BoardDTO board = new BoardDTO();
					board.setNum(rs.getInt("num"));
					board.setWriter(rs.getString("writer"));
					board.setSubject(rs.getString("subject"));
					board.setReg_date(rs.getString("reg_date"));
					board.setReadcount(rs.getInt("readcount"));
					arr.add(board);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeConnection(con, null, st, rs);
			}
			return arr;
			
		}
		
		//게시글수
		public int getCount() {
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		
		int count = 0 ;
		
		try {
			con = getConnection();
			String	sql = "select count(*) from board";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeConnection(con, null, st, rs);
		}
		return count;
	}
		
		
		//상세보기
		public BoardDTO findByNum(int num) {
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;
			BoardDTO board = null;
			try {
				con = getConnection();
				String sql ="select * from board where num="+num;
				st= con.createStatement();
				rs = st.executeQuery(sql);
				if(rs.next()) {
					board = new BoardDTO();
					board.setContent(rs.getString("content"));
					board.setEmail(rs.getString("email"));
					board.setIp(rs.getString("ip"));
					board.setNum(rs.getInt("num"));
					board.setPasswd(rs.getString("passwd"));
					board.setReadcount(rs.getInt("readcount"));
					board.setReg_date(rs.getString("reg_date"));
					board.setSubject(rs.getString("subject"));
					board.setWriter(rs.getString("writer"));
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				closeConnection(con, null, st, rs);
			}
			return board;
		}
		
}
