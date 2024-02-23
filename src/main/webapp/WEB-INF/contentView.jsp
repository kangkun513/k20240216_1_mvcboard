<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 보기</title>
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
<fmt:requestEncoding value="UTF-8"/>
<jsp:useBean id="date" class="java.util.Date"/>
<fmt:formatDate var="today" value="${date}" pattern="yy/MM/dd"/>

<form class="mt-5" action="update.kbs" method="post">
	<table class="table table-dark table-hover table-bordered" style="width: 600px; margin-left: auto; margin-right: auto;">
		<tr>
			<thead>
				<th class="align-middle text-center" colspan="4" style="font-size: 20px;">
					게시글 보기
				</th>
			</thead>
		</tr>
		<tr>
			<th class="align-middle text-center" style="width: 80px;">글번호</th>
			<td class="align-middle text-center">${vo.idx}</td>
			<th class="align-middle text-center" style="width: 80px;">이름</th>
			<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
			<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
			<td class="align-middle text-center">${name}</td>
		</tr>
		<tr>
			<th class="align-middle text-center"  style="width: 80px;">작성일</th>
			<td class="align-middle text-center" style="width: 270px;">
				<fmt:formatDate value="${vo.writedate}" pattern="yyyy/MM/dd a hh:mm:ss"/>							
			</td>
			<th class="align-middle text-center"  style="width: 80px;">조회수</th>
			<td class="align-middle text-center">${vo.hit}</td>
		</tr>
		<tr>
			<th class="align-middle text-center" style="width: 80px;">
				<label for="name">이름</label>
			</th>
			<td colspan="3">
				<input id="name" type="text" class="form-control form-control-sm" value="${vo.name}" name="name" style="width: 250px; height: 25px; resize: none;"/>
			</td>
		</tr>
		<tr>
			<th class="align-middle text-center">
				<label for="subject">제목</label>
			</th>
			<td colspan="3">
				<input id="subject" type="text" class="form-control form-control-sm" value="${vo.subject}" name="subject" style="height: 25px; resize: none;"/>
			</td>
		</tr>
		<tr>
			<th class="align-middle text-center">
				<label for="content">내용</label>
			</th>
			<td colspan="3">
				<textarea id="content" rows="10" type="text" class="form-control form-control-sm" name="content" style="resize: none;">${vo.content}</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input class="btn btn-outline-secondary btn-sm" type="submit" value="수정하기"/>
				<input class="btn btn-outline-secondary btn-sm" type="button" value="삭제하기" onclick="location.href='delete.kbs?idx=${vo.idx}&currentPage=${currentPage}'"/>
				<input class="btn btn-outline-secondary btn-sm" type="button" value="답변하기" onclick="location.href='reply.kbs?idx=${vo.idx}&currentPage=${currentPage}'"/>
				<!-- 
					history.back() 또는 history.go(-1)을 사용하는 단순히 전에 봤던 화면으로 돌아감
					증가된 조회수가 반영되지 않은 상태가 브라우저에 보여짐
					list.jsp를 요청해서 변경된 내용을 다시 얻어와서 출력해야 함
				 -->
				<input class="btn btn-outline-secondary btn-sm" type="button" value="돌아가기" onclick="location='list.kbs?currentPage=${currentPage}'"/>
			</td>
		</tr>
	</table>
	<input type="hidden" name="idx" value="${vo.idx}"/>
	<input type="hidden" name="currentPage" value="${currentPage}"/>
</form>

</body>
</html>