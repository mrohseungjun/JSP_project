<%@page import="java.util.ArrayList"%>
<%@page import="com.member.dao.MemberDAOImpl"%>
<%@page import="com.member.dao.MemberDAO"%>
<%@page import="com.member.dto.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
</head>
<script src="../js/member.js"></script>
<%
	request.setCharacterEncoding("utf-8");
	String sid= (String)session.getAttribute("sUserid");
	MemberDAO dao = MemberDAOImpl.getInstance();
   ArrayList<MemberDTO>  jarr =dao.memberList();
   int count=dao.getCount();
   
%>
<body>

<div class="container mt-5">
 <div align="right">
 <a href="memberView.jsp"><%=sid %>님 반갑습니다. 
 /<a href="logout.jsp">로그아웃</a> 
 </div>
<!-- <div align="right"><a href="insert.jsp">추가하기</a></div> -->
<h2>회원 리스트(<span id="cnSpan"><%=count %> </span>)</h2>
<table class="table table-hover">
		<thead>
			<tr>
				<th>이름</th>
				<th>아이디</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>구분</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
 	<%
		for(MemberDTO a : jarr){
		
			String mode = a.getAdmin().equals("0")?"일반회원":"관리자";
		%>
		<tr>
			<td><%=a.getName() %></td>
			<td><%=a.getUserid() %></td>
			<td><%=a.getPhone() %></td>
			<td><%=a.getEmail() %></td>
			<td><%=mode %></td>
			<td><a href="javascript:del('<%=a.getUserid()%>','<%=mode %>')">삭제</a></td>
			
		</tr>
		<%
		}
		%>
		</tbody>
		</table>
		
		<!-- <select name="field" id="field">
			<option value="name">이름</option>
			<option value="addr">주소</option>
		</select>
		<input type="text" name="word" id="word">
		<input type="button" value="검색" id="btnSearch">  -->
	
</div>

</body>
</html>