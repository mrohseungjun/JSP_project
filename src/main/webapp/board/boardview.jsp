<%@page import="com.board.dto.BoardDTO"%>
<%@page import="com.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function del(){
	if(confirm("정말 삭제할까요?")){
		location.gref="deletePro.jsp"
	}
}
</script>
<%
request.setCharacterEncoding("utf-8");
BoardDAO dao = BoardDAO.getInstance();
int num =Integer.parseInt(request.getParameter("num"));
BoardDTO board = dao.findByNum(num);
%>
</head>
<body>
<h2>글 내용 보기</h2>
<table border=1>
	<tr>
		<td>글번호</td>
		<td><%=board.getNum() %></td>
		<td>조회수</td>
		<td><%=board.getReadcount() %></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><%=board.getWriter() %></td>
		<td>작성일</td>
		<td><%=board.getReg_date() %></td>
	</tr>
	<tr>
		<td>글제목</td>
		<td colspan="3"><%=board.getSubject() %></td>
	</tr>
	<tr>
		<td>글내용</td>
		<td colspan="3"><%=board.getContent() %></td>
	</tr>
	<tr>
		<td colspan="4">
			<input type="button" value="글수정폼" />
			<input type="button" value="삭제" onclick="del()" />
		
		</td>
	</tr>

</table>

</body>
</html>