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
<title>Insert title here</title>

 <script src="../js/member.js"></script> 
 
<!-- <script src="/JSP_Project/webapp/js/member.js"></script> -->
</head>
<body>
<div class="container mt-3">
<div align="right">
<a href ="loginForm.jsp">로그인</a>
</div>
  <h2>회원가입</h2>
  <form action="memberInserPro.jsp" method="post" id="frm"> <!-- js에서 타고 옴  -->
    <div class="form-group">
      <label for="name">Name:</label>
      <input type="text" class="form-control" id="name" placeholder="Enter name" name="name">
    </div>
    
    
  	<div class="row">
    <div class="col">
      <label for="userid">UserId:</label>
      <input type="text" class="form-control" id="userid" placeholder="Enter UserId" 
      name="userid" readonly="readonly">
    </div>
    <div class="col align-self-end"> <!-- self-end 는 자기 자신 끝으로 주는 코드  -->
      <button type="button" class="btn btn-secondary" id="idChekBtn">중복확인</button>
    </div>
  </div>
 
    
     <div class="form-group">
      <label for="pwd">Password:</label>
      <input type="text" class="form-control" id="pwd" placeholder="Enter password" name="pwd">
    </div>
    
     <div class="form-group">
      <label for="pwd_check">Password_check:</label>
      <input type="password" class="form-control" id="pwd_check" placeholder="Enter password" name="pwd_check">
    </div>
    
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="text" class="form-control" id="email" placeholder="Enter Email" name="email">
    </div>
    
    <div class="form-group">
      <label for="phone">Phone_check:</label>
      <input type="text" class="form-control" id="phone" placeholder="Enter Phone" name="phone">
    </div>
    
    <div class="form-check-inline">
  <label class="form-check-label">
    <input type="radio" class="form-check-input" name="admin" value = "0"  checked>일반회원
  </label>
  </div>
  <div class="form-check-inline">
   <label class="form-check-label">
    <input type="radio" class="form-check-input" name="admin" value = "1"   >관리자
    </label>
   </div><br/><br/>

    <button type="button" class="btn btn-primary" id="sendBtn">Submit</button>
  </form>
</div>




</body>
</html>