<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//	컨트롤러에서 넘어오는 수정 후 돌아갈 페이지 번호를 받음
	int currentPage = Integer.parseInt(request.getParameter("currentPage"));
//	컨트롤러에게 수정한 글이 있던 1페이지 분량의 글 목록을 얻어오는 요청을 함
	response.sendRedirect("list.kbs?currentPage=" + currentPage);
%>

</body>
</html>