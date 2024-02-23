<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변하기</title>
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

<div class="mt-5">
	<table class="table table-dark table-hover table-bordered" style="width: 600px; margin-left: auto; margin-right: auto;">
		<tr>
			<thead>
				<th class="align-middle text-center" colspan="4" style="font-size: 20px;">
					질문글 보기
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
				<input id="name" type="text" class="form-control form-control-sm" value="${vo.name}" name="name" readonly="readonly" style="width: 250px; height: 25px; resize: none;"/>
			</td>
		</tr>
		<tr>
			<th class="align-middle text-center">
				<label for="subject">제목</label>
			</th>
			<td colspan="3">
				<input id="subject" type="text" class="form-control form-control-sm" value="${vo.subject}" name="subject" readonly="readonly" style="height: 25px; resize: none;"/>
			</td>
		</tr>
		<tr>
			<th class="align-middle text-center">
				<label for="content">내용</label>
			</th>
			<td colspan="3">
				<textarea id="content" rows="10" type="text" class="form-control form-control-sm" name="content" readonly="readonly" style="resize: none;">${vo.content}</textarea>
			</td>
		</tr>
	</table>
</div>

<!-- 답글을 입력하는 테이블 -->
<form class="mt-5" action="replyInsert.kbs" method="post">
	<table class="table table-dark table-hover table-bordered" style="width: 600px; margin-left: auto; margin-right: auto;">
		<tr style="display: none;">
			<td>
				<input type="text" name="idx" value="${vo.idx}"/> <!-- 질문글의 글번호 -->
				<input type="text" name="currentPage" value="${currentPage}"/> <!-- 답글 입력 후 돌아갈 페이지 번호 -->
				<input type="text" name="gup" value="${vo.gup}"/> <!-- 글 그룹 -->
				<input type="text" name="lev" value="${vo.lev}"/> <!-- 글 레벨 -->
				<input type="text" name="seq" value="${vo.seq}"/> <!-- 같은 글 그룹에서 글 출력 순서 -->
			</td>
		</tr>
		<thead>
		<tr>
			<th colspan="2" class="align-middle text-center" style="font-size: 20px;"> <%-- align이 안 먹힐 경우 style 사용 --%>
				답글 입력
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
				<input class="btn btn-outline-secondary btn-sm" type="button" value="목록보기" onclick="location.href='list.kbs?currentPage=${currentPage}'"/>
			</th>
		</tr>
	</table>
	<input type="hidden" name="ip" value="${pageContext.request.remoteAddr}">
</form>

</body>
</html>