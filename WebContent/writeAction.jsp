<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>

<%@ page import="bbs.BbsDAO"%>

<!-- bbsdao의 클래스 가져옴 -->

<%@ page import="java.io.PrintWriter"%>

<!-- 자바 클래스 사용 -->

<%

	request.setCharacterEncoding("UTF-8");

	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.

%>



<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />

<!-- // Bbs bbs = new Bbs(); -->

<jsp:setProperty name="bbs" property="bbsTitle" /><!-- bbs.setBbsTitle(requrst) -->

<jsp:setProperty name="bbs" property="bbsContent" />



<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

 <%
 try{
	 String driverName="oracle.jdbc.driver.OracleDriver";
	 String url ="jdbc:oracle:thin:@localhost:1521:xe";
	 Class.forName(driverName);
	 Connection con = DriverManager.getConnection(url,"hr","hr");
	 out.ptintln("접속 확인");
	 
	 Statement stmt = con.createStatement();
	 String sql = "insert into bbs_Comment values(?,?,sysdate,commentcount_seq)";
 }
 %>

</body>

</html>

