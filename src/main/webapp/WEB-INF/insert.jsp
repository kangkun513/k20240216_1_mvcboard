<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style type="text/css">
	body {
		background-color: black;
	}
	
	a:hover {
		background-color: gray;
	}
</style>
</head>
<body>

<form class="mt-5" action="insertOK.kbs" method="post">
	<table class="table table-dark table-hover table-bordered" style="width: 600px; margin-left: auto; margin-right: auto;">
		<thead>
		<tr>
			<th colspan="2" class="align-middle text-center" style="font-size: 20px;"> <%-- align이 안 먹힐 경우 style 사용 --%>
				답변형 게시판 글 입력
			</th>
		</tr>
		</thead>
		<tr>
			<th class="align-middle text-center" style="width: 80px;">
				<label for="name">이름</label>
			</th>
			<td>
				<input id="name" type="text" class="form-control form-control-sm" name="name" style="width: 250px; height: 25px; resize: none;"/>
			</td>
		</tr>
		<tr>
			<th class="align-middle text-center" style="width: 80px;">
				<label for="subject">제목</label>
			</th>
			<td>
				<input id="subject" type="text" class="form-control form-control-sm" name="subject" style="height: 25px; resize: none;"/>
			</td>
		</tr>
		<tr>
			<th class="align-middle text-center" style="width: 80px;">
				<label for="content">내용</label>
			</th>
			<td>
				<textarea id="content" rows="10" type="text" class="form-control form-control-sm" name="content" style="resize: none;"></textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2" class="align-middle text-center">
				<input class="btn btn-outline-secondary btn-sm" type="submit" value="저장하기"/>
				<input class="btn btn-outline-secondary btn-sm" type="reset" value="리셋하기"/>
				<input class="btn btn-outline-secondary btn-sm" type="button" value="돌아가기" onclick="history.back()"/>
			</th>
		</tr>
	</table>
	<input type="hidden" name="ip" value="${pageContext.request.remoteAddr}">
</form>

</body>
</html>