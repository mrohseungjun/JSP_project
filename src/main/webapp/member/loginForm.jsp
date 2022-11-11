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

<script >
$(function(){
	$("#loginBtn").click(function(){
		if($("#userid").val()==""){
		alert("아이디를 입력하세요");
		$("#userid").focus(); 
		return false;
	}//userid
    if($("#pwd").val()==""){
    alert("비밀번호를 입력하세여");
    $("#pwd").focus();
    return false;
	    }//pwd
	    
	    $.ajax({
	    	type:"post",
	    	url:"loginPro.jsp",
	    	data:{
	    		userid : $("#userid").val(),
	    		 pwd : $("#pwd").val()
	    	},
	    success:function(resp){
	    	if(resp.trim()==-1){
	    		alert("회원이 아닙니다. 회원가입 하세요")
	    	}else if(resp.trim()==0){
	    		alert("일반회원로그인 성공") // 일반 회원이면 ==>memberViwe.jsp 관리자면 memberList.jsp로
				$(location).attr("href","memberView.jsp")
	    	}else if(resp.trim()==1){
	    		alert("관리자 로그인 성공")
	    		$(location).attr("href","memberList.jsp")
	    	}else if(resp.trim()==2){
	    	
	    		alert("비밀번호가 틀립니다. 비밀 번호를 다시 확인하세요")
	    	}
	    },
	    	error:function(e){
	    		alert(e+"error")
	    	}
	    })//ajsx
	})//loginBtn
})//function


</script>
</head>
<body>
<div class="container mt-3">
<div align="right">
<a href ="memberForm.jsp">회원가입</a>
</div>
  <h2>로그인</h2>
    <div class="form-group">
      <label for="userid">Name:</label>
      <input type="text" class="form-control" id="userid" placeholder="Enter name" name="userid">
    </div>
    
    
    
     <div class="form-group">
      <label for="pwd">Password:</label>
      <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd">
    </div>
    
    <button type="button" class="btn btn-primary" id="loginBtn">Login</button>
 
</div>




</body>
</html>