<%@page import="com.member.dto.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.member.dao.MemberDAO"%>
<%@page import="com.member.dao.MemberDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 	
request.setCharacterEncoding("utf-8"); 
String userid = request.getParameter("userid"); //userid
String pwd = request.getParameter("pwd"); //pwd 
MemberDAO dao=MemberDAOImpl.getInstance();


//로그인 체크
int flag = dao.loginCheck(userid,pwd);
if(flag==0 || flag==1){
	session.setAttribute("sUserid",userid);
}
out.println(flag);
%>