<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.member.dto.MemberDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.member.dao.MemberDAO"%>
<%@page import="com.member.dao.MemberDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("utf-8");
    MemberDAO dao = MemberDAOImpl.getInstance();
	String userid = request.getParameter("userid");
	dao.memberDelete(userid);
	
	ArrayList<MemberDTO> arr = dao.memberList();
	int count = dao.getCount();
	//자바 ==> JSON
	
	//메인 루트		
	JSONObject mainObj = new JSONObject();
	
	//arr
	JSONArray jarr = new JSONArray();
	for(MemberDTO member:arr){
		String mode = member.getAdmin().equals("0")?"일반회원":"관리자";
		JSONObject obj = new JSONObject();
		obj.put("name",member.getName());
		obj.put("userid",member.getUserid());
		obj.put("email",member.getEmail());
		obj.put("phone",member.getPhone());
		obj.put("pwd",member.getPwd());
		obj.put("mode",member.getAdmin());
		jarr.add(obj);
	}
	JSONObject countObj = new JSONObject();
	countObj.put("count",count);
	
	//메인에 추가
	mainObj.put("jarrObj",jarr);
	mainObj.put("countObj",countObj);
	out.println(mainObj.toString());
%>