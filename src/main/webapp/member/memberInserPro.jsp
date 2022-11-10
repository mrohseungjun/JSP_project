<%@page import="com.member.dao.MemberDAO"%>
<%@page import="com.member.dao.MemberDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="mvo" class="com.member.dto.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="mvo"/>

<%
	MemberDAO dao = MemberDAOImpl.getInstance();
    dao.MemberInsert(mvo);
    response.sendRedirect("memberList.jsp");
    
%>