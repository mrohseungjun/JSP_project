<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="writePro.jsp" method="post">
<table>
<tr>
	<td>이름</td>
	<td><input type="text" name="writer"></td>
</tr>
<tr>
	<td>제목</td>
	<td><input type="text" name="subject"></td>
</tr>
<tr>
	<td>Email</td>
	<td><input type="text" name="email"></td>
</tr>
<tr>
	<td>내용</td>
	<td><textarea cols="50" rows="10" name="content"></textarea></td>
</tr>
<tr>
	<td>비밀번호</td>
	<td><input type="password" name="passwd"></td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit" value="글쓰기">
		<input type="reset" value="다시작성">
	</td>
</tr>
</table>
</form>

</body>
</html>