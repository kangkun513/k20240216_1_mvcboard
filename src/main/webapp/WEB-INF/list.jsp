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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"/>
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

<div class="mt-5">
	<table class="table table-dark table-hover table-bordered" style="width: 800px; margin-left: auto; margin-right: auto;">
		<thead>
		<tr>
			<th class="align-middle text-center" colspan="5" style="font-size: 20px;">
				보드게시판
			</th>
		</tr>
		</thead>
		<tr>
			<td class="align-middle text-center"  style="width: 80px;">글번호</td>
			<td class="align-middle text-center"  style="width: 120px;">이름</td>
			<td class="align-middle text-center"  style="width: 360px;">제목</td>
			<td class="align-middle text-center"  style="width: 160px;">작성일</td>
			<td class="align-middle text-center"  style="width: 80px;">조회수</td>
		</tr>
		
		<!-- mvcboardList에서 1페이지 분량의 글 목록만 꺼냄 -->
		<c:set var="list" value="${mvcboardList.list}"/>
		<c:if test="${list.size() == 0}">
			<thead>
			<tr>
				<td class="align-middle" colspan="5" style="font-size: 16px;"><b><marquee>게시글이 없습니다</marquee></b></td>
			</tr>
			</thead>
		</c:if>
		<!-- 글이 있으면 글 목록을 출력함 -->
		<c:if test="${list.size() != 0}">
			<!-- 컴퓨터 시스템의 현재 날짜를 얻어옴 -->
			<jsp:useBean id="date" class="java.util.Date"/>
			<!-- 현재 날짜와 작성일의 날짜를 비교하기 위해 현재 날짜의 서식을 지정함 -->
			<c:forEach var="vo" items="${list}">
			<fmt:formatDate var="today" value="${date}" pattern="yy/MM/dd"/> <!-- 오늘 날짜 서식 지정 -->
			<!-- 현재 날짜와 작성일의 날짜를 비교하기 위해 작성일의 서식을 지정함 -->
			<fmt:formatDate var="writeDate" value="${vo.writedate}" pattern="yy/MM/dd"/> <!-- 글 작성 날짜 서식 지정 -->
				<tr>
					<td class="align-middle text-center">${vo.idx}</td>
					<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
					<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
					<td class="align-middle text-center">${name}</td>
					<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"/>
					<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"/>
					<td class="align-middle text-start">
						<c:if test="${vo.lev == 0}">
							<c:if test="${today == writeDate}">
								<span class="badge bg-dark">NEW</span>		
							</c:if>
						</c:if>
						<c:if test="${vo.lev >= 1}">
							<c:forEach var="i" begin="1" end="${vo.lev}" step="1">
								&nbsp;&nbsp;&nbsp;
							</c:forEach>
							<i class="bi bi-arrow-return-right"/>
						</c:if>
						<a class="link-light link-offset-2 link-underline-opacity-25 link-underline-opacity-100-hover"
						href="increment.kbs?idx=${vo.idx}&currentPage=${mvcboardList.currentPage}">
							${subject}
						</a>
						<c:if test="${vo.hit >= 10}">
							<span class="badge bg-danger">HOT</span>
						</c:if>
					</td>
					<td class="align-middle text-center">
						<c:if test="${today == writeDate}">
							<fmt:formatDate value="${vo.writedate}" pattern="a hh:mm:ss"/>							
						</c:if>
						<c:if test="${today != writeDate}">
							<fmt:formatDate value="${vo.writedate}" pattern="yyyy/MM/dd"/>							
						</c:if>
					</td>
					<td class="align-middle text-center">${vo.hit}</td>
				</tr>
			</c:forEach>
		</c:if>
		
		<tr>
			<td class="align-middle text-center" colspan="5">
				<!-- 처음으로 -->
				<c:if test="${mvcboardList.currentPage > 1}">
					<button class="btn btn-outline-secondary btn-sm" type="button" title="첫 페이지로 이동" onclick="location.href='?currentPage=1'">
					첫 페이지</button>
				</c:if>
				<c:if test="${mvcboardList.currentPage <= 1}">
					<button class="btn btn-outline-secondary btn-sm" type="button" title="첫 페이지입니다" disabled="disabled">
					첫 페이지</button>
				</c:if>
				<!-- 10페이지 앞으로 -->
				<c:if test="${mvcboardList.startPage > 1}">
					<button class="btn btn-outline-secondary btn-sm" type="button" title="이전 10페이지로 이동" onclick="location.href='?currentPage=${mvcboardList.startPage - 1}'">
					이전</button>
				</c:if>
				<c:if test="${mvcboardList.startPage <= 1}">
					<button class="btn btn-outline-secondary btn-sm" type="button" title="첫 10페이지입니다" disabled="disabled">
					이전</button>
				</c:if>
				<!-- 페이지 이동 버튼 -->
				<c:forEach var="i" begin="${mvcboardList.startPage}" end="${mvcboardList.endPage}" step="1">
					<c:if test="${mvcboardList.currentPage == i}">
						<button class="btn btn-outline-secondary btn-sm" type="button" title="현재 ${i}페이지입니다" disabled="disabled">
						${i}</button>
					</c:if>
					<c:if test="${mvcboardList.currentPage != i}">
						<button class="btn btn-outline-secondary btn-sm" type="button" title="${i}페이지로 이동" onclick="location.href='?currentPage=${i}'">
						${i}</button>		
					</c:if>
				</c:forEach>
				<!-- 10페이지 뒤로 -->
				<c:if test="${mvcboardList.endPage < mvcboardList.totalPage}">
						<button class="btn btn-outline-secondary btn-sm" type="button" title="다음 10페이지로 이동" onclick="location.href='?currentPage=${mvcboardList.endPage + 1}'">
						다음</button>
				</c:if>
				<c:if test="${mvcboardList.endPage >= mvcboardList.totalPage}">
						<button class="btn btn-outline-secondary btn-sm" type="button" title="마지막 10페이지입니다" disabled="disabled">
						다음</button>			
				</c:if>
				<!-- 끝으로 -->
				<c:if test="${mvcboardList.currentPage < mvcboardList.totalPage}">
						<button class="btn btn-outline-secondary btn-sm" type="button" title="마지막 페이지로 이동" onclick="location.href='?currentPage=${mvcboardList.totalPage}'">
						끝 페이지</button>
				</c:if>
				<c:if test="${mvcboardList.currentPage >= mvcboardList.totalPage}">
						<button class="btn btn-outline-secondary btn-sm" type="button" title="마지막 페이지입니다" disabled="disabled">
						끝 페이지</button>			
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="5" class="align-middle text-center">
				<input class="btn btn-outline-secondary btn-sm" type="button" value="글쓰기" onclick="location.href='insert.kbs'" style="width: 25%;"/>
			</td>
		</tr>
		<thead>
			<tr>
				<td colspan="5" class="align-middle text-end">
					총 ${mvcboardList.totalCount}개 글 ( ${mvcboardList.currentPage} / ${mvcboardList.totalPage} 페이지 )
				</td>
			</tr>
		</thead>
		
	</table>
</div>

</body>
</html>