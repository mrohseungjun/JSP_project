<%@page import="com.member.dto.MemberDTO"%>
<%@page import="com.member.dao.MemberDAOImpl"%>
<%@page import="com.member.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script   src="https://code.jquery.com/jquery-3.6.1.min.js" ></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../js/member.js"></script>
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String sid= (String)session.getAttribute("sUserid");
	MemberDAO dao = MemberDAOImpl.getInstance();
	MemberDTO member=dao.fineById(sid);
%>
<body>
<div class="container mt-3">
<div align="right">
  <%=sid %>님 반갑습니다. 
  /<a href="logout.jsp">로그아웃</a> 
</div>

  <h2>회원정보 수정</h2>
  <form action="memberUpdatePro.jsp" method="post" id="frm">
   <input type="hidden" class="form-control" id="userid" name="userid" value="<%=member.getUserid()%>">
    
    
    <div class="form-group">
      <label for="name">Name:</label>
  	<input type="text" class="form-control" id="name" name="name" value="<%=member.getName()%>">
    </div>
    
    
     <div class="form-group">
      <label for="pwd">Password:</label>
      <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd" value="<%=member.getPwd()%>">
    </div>
    
     <div class="form-group">
      <label for="pwd_check">Password_check:</label>
      <input type="password" class="form-control" id="pwd_check" placeholder="Enter password" name="pwd_check">
    </div>
    
    
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="text" class="form-control" id="email"  name="email" value="<%=member.getEmail()%>">
    </div>
    
    <div class="form-group">
      <label for="phone">Phone:</label>
      <input type="text" class="form-control" id="phone"  name="phone" value="<%=member.getPhone()%>">
    </div>
    
    <div class="form-check-inline">
  <label class="form-check-label">
    <input type="radio" class="form-check-input" name="admin" value = "0"  >일반회원
  </label>
  </div>
  <div class="form-check-inline">
   <label class="form-check-label">
    <input type="radio" class="form-check-input" name="admin" value = "1"   >관리자
    </label>
   </div>
   <script>
   $("input:radio[value=<%=member.getAdmin()%>]").attr("checked",true)
   </script>
   <br/><br/>

    <button type="button" class="btn btn-primary" id="sendBtn">수정하기</button>
     <button type="reset" class="btn btn-secondary" >취소하기</button>
     <button type="button" class="btn btn-danger" onclick="location.href='userDeletePro.jsp'">탈퇴하기</button>
  </form>
</div>
</body>
</html>