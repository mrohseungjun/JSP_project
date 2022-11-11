<%@page import="com.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="board" class="com.board.dto.BoardDTO"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>

<%
	request.setCharacterEncoding("utf-8"); 
	BoardDAO dao=BoardDAO.getInstance();
	
	String ip = request.getRemoteAddr();
	
	board.setIp(ip);
	
	dao.boradInsert(board);
	response.sendRedirect("BoardList.jsp");
	
%>