<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 자바 클래스 사용 -->

<%

	request.setCharacterEncoding("UTF-8");

	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.

%>



<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->



<!-- // Bbs bbs = new Bbs(); -->





<!DOCTYPE html>

<html>

<head>



<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>jsp 게시판 웹사이트</title>

</head>

<body>

	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}  
		int bbsID = 0;
        if (request.getParameter("bbsID") != null){
        	bbsID = Integer.parseInt(request.getParameter("bbsID"));
        }
        if (bbsID == 0){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('유효하지 않은 글입니다.')");
        	script.println("location.href = 'bbs.jsp'");
        	script.println("</script>");
			
        }
        Bbs bbs = new BbsDAO().getBbs(bbsID);
        if(!userID.equals(bbs.getUserID())) {
        PrintWriter script = response.getWriter();
    	script.println("<script>");
    	script.println("alert('권한이 없습니다.')");
    	script.println("location.href = 'bbs.jsp'");
    	script.println("</script>");
        } else {
				BbsDAO BbsDAO = new BbsDAO();
				int result = BbsDAO.delete(bbsID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글삭제에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='bbs.jsp'");
					//script.println("history.back()");
					script.println("</script>");

				}



			}



		

	%>

</body>

</html>
