<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.member.dto.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.member.dao.MemberDAO"%>
<%@page import="com.member.dao.MemberDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="../js/member.js"></script> 

<%
    request.setCharacterEncoding("utf-8");
	String userid = (String)session.getAttribute("sUserid");
	
    MemberDAO dao = MemberDAOImpl.getInstance();
	session.invalidate();
	dao.memberDelete(userid);
	response.sendRedirect("memberForm.jsp");
%>

