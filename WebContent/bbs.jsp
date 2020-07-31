<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
 <%@ page import="java.io.PrintWriter" %>
 <%@ page import="bbs.BbsDAO" %>
 <%@ page import="bbs.Bbs" %>
 <%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">

<title>Insert title here</title>
<style type="text/css">
  a, a:hover {
      color: #000000;
      text-decoration: none;
  }
</style>

</head>
<body>

<%
   String userID = null;
   if(session.getAttribute("userID") != null) {
	   userID =(String) session.getAttribute("userID");
   }
   int pageNumber =1 ;
   if(request.getParameter("pageNumber") != null ){
	   pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
   }

%>
 <nav class="navbar navbar-default">
 <div class="navbar-header">
 <button type="button" class="navbar-toggle collaspsed"
 data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
 aria-expanded="false">
 <span class="icon-bar"></span>
 <span class="icon-bar"></span>
 <span class="icon-bar"></span>
 
 </button>
 <a class="navbar-brand" href="main.jsp">jsp �Խ��� ��</a>
 </div>
 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
  <ul class="nav navbar-nav">
  <li><a href="main.jsp">����</a></li>
  <li class="active"><a href="bbs.jsp">�Խ���</a></li>
  </ul>
  <%
    if(userID == null) {
  
  %>
  <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
   <a href="#" class="dropdown-toggle"
   data-toggle="dropdown" role="button" aria-haspopup="true"
   aria-expanded="false">�����ϱ�<span class="caret"></span></a>
   <ul class="dropdown-menu ">
      <li><a href="login.jsp">�α���</a></li>
      <li><a href="join.jsp">ȸ������</a></li>
   </ul>
   </li>
  </ul>
  <%
    } else {
  %>
  <ul class="nav navbar-nav navbar-right">
   <li class="dropdown">
   <a href="#" class="dropdown-toggle"
   data-toggle="dropdown" role="button" aria-haspopup="true"
   aria-expanded="false">ȸ������<span class="caret"></span></a>
   <ul class="dropdown-menu ">
      <li><a href="logoutAction.jsp">�α׾ƿ�</a></li>   
   </ul>
   </li>
  </ul>
  <%
    }
  %>
  <div class="container">
   <div class="row">
    <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
    <thead>
     <tr>
      <th style="background-color: #eeeeee; text-align: center;">��ȣ</th>
      <th style="background-color: #eeeeee; text-align: center;">����</th>
      <th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
      <th style="background-color: #eeeeee; text-align: center;">�ۼ���</th>
      </tr>
      </thead>
       <tbody>
       <%
         BbsDAO bbsDAO = new BbsDAO();
         ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
         for(int i = 0; i < list.size(); i++) {
        %>
        <tr>
         <td><%= list.get(i).getBbsID() %></td>
         <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle() %></a></td>
         <td><%= list.get(i).getUserID() %></td>
         <td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13) + "��" + list.get(i).getBbsDate().substring(14,16) + "��" %></td>
        </tr>
       <% 	 
         }
       %>
       </tbody>
       </table>
       <%
          if(pageNumber !=1) {
       %>
          <a href="bbs.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn=success btn-arraw-left">����</a>
       <%
          } if(bbsDAO.nextPage(pageNumber + 1)) {
       %> 
           <a href="bbs.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn=success btn-arraw-left">����</a>  
       <%
          }
       %>
       <a href="write.jsp" class="btn btn-primary pull-right">�۾���</a>
   </div>
  </div>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src="js/bootstrap.js"></script>
</body>
</html>