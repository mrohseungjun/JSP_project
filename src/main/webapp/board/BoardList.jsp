<%@page import="com.board.dto.BoardDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
request.setCharacterEncoding("utf-8"); 
BoardDAO dao=BoardDAO.getInstance();
ArrayList<BoardDTO> arr=dao.boardList();
%>
</head>
<body>
	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</table>
<%
for(BoardDTO board:arr){
%><table>
	<tr>
		<td><%=board.getNum() %></td>
		<td><a href="boardview.jsp?num=<%=board.getNum() %>"><%=board.getSubject() %></td>
		<td><%=board.getWriter() %></td>
		<td><%=board.getReg_date() %></td>
		<td><%=board.getReadcount() %></td>
	</tr>
	</table>
	<%
	}
	%>
</body>
</html>