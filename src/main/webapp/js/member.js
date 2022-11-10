$(document).ready(function(){
	var exp = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/                  /*/^=>시작  [0-9]{3}-[0-9]{4}-[0-9]{4} $/=>끝*/
	$("#sendBtn").click(function(){
		if($("#name").val()==""){
			alert("이름을 입력하세요");
			$("#name").focus();
			return false;
		}
		if($("#userid").val()==""){
			alert("이름을 입력하세요");
			$("#usserid").focus();
			return false;
			}
			if($("#pwd").val()==""){
			alert("비밀번호를 입려하세요");
			$("#pwd").focus();
			return false;
			}
			if($("#pwd").val()!=$('#pwd_check').val()){
				$("#pwd_check").focus();
				return false;
			}
			if($("#email").val()==""){
			alert("이메일을 입려하세요");
			$("#email").focus();
			return false;
			}
		/*	alert("전화번호를 입려하세요");    패턴이 아니면 전화번호 입력 알림 출력
			$("#phone").focus();
			return false;
			}*/
			
			if(!exp.test($('#phone').val())){   
			alert("전화번호를 입려하세요");
			$("#phone").focus();
			return false;
			}
			$("#frm").submit()
		
	})//sendBtn
	/*"idCheckBtn" 클릭하면 팝업인 idCheckjsp 띄우기*/
	$("#idChekBtn").click(function(){
	    window.open("idCheck.jsp","","width=700 height=400" );
		
	})
	//idUseBtn 클릭하면 유효성 검사
	$("#idUseBtn").click(function(){
		if($("#userid").val()==""){
			alert("아이디를 입력하세요")
			return;
		}
		$.ajax({
			type:'post',
			url:"idCheckPro.jsp",
			data:{"userid":$("#userid").val()},
			success:function(resp){
				//alert(resp.trim().length)
				if(resp.trim()=="yes"){
					alert("사용가능한 아이디 입니다.")
					$(opener.document).find('#userid').val($("#userid").val()) //부모의 창을 $ 객체 선택
					self.close()
				}else{
					alert("사용불가능한 아이디 입니다.")
					$("#userid").val();
					$("#userid").focus(); //focus() 함수는 트리거 함수인가?
				}
			},
			error:function(e){
				alert(e+"error");
			}
		})//ajax
	})//idUseBtn
	
})//document


function del(userid,mode){
	if(mode=="관리자"){
		alert("관리자는 삭제할 수 없습니다.")
		return;
	}
	if(confirm('정말 삭제할까요?')){
		$.getJSON("memberDeletePro.jsp",
					{"userid":userid},
					function(resp){
						var str = "";
						
						$.each(resp.jarrObj,function(key,val){
							str+="<tr>"
							str+="<td>"+val.name+"</td>"
							str+="<td>"+val.userid+"</td>"
							str+="<td>"+val.phone+"</td>"
							str+="<td>"+val.email+"</td>"
							str+="<td>"+val.admin+"</td>"
							str+="<td><a href=javascript:del('"+val.userud+"','"+val.admin+"')>삭제</a></td>"
							str+="</tr>"
							
						})//each
						//alert(str);
						alert(resp)
						$("table tbody").html(str);
						$("cntSpan").text(resp.countObj.count)
						
					})
					
	}
}