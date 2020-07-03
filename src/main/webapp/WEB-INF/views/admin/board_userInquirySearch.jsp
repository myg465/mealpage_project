<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css for admin page --%>
	<link rel="stylesheet" href="/css/custom/admin.css">
	<%-- custom css for inquiry board --%>
	<link rel="stylesheet" href="/css/custom/inquiry.css">
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="board_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(1,0);</script>
			<div id="contents">
				<div style="text-align: center;">
					[ '${keyword}' 키워드로 게시물을 검색했습니다. <a href="/admin/board/inquiry"><button type="button">목록으로</button></a> ]
				</div>
				<div class="orderDivNm">
					<table class="orderTable2" border="1" cellspacing="0">
						<colgroup>
							<col width="5%" class="tnone" />
							<col width="12%" class="tnone" />
							<col width="15%" class="tnone" />
							<col width="*" />
							<col width="15%" class="tw30" />
							<col width="15%" class="tw30" />
						</colgroup>
						<thead>
							<th scope="col" class="tnone">NO.</th>
							<th scope="col">회원명</th>
							<th scope="col">분류</th>
							<th scope="col">제목</th>
							<th scope="col" class="tnone">등록일</th>
							<th scope="col">처리상태</th>
						</thead>
						<tbody>
							<c:forEach var="inquiry" items="${inquiryList}">
								<tr>
									<td class="tnone">${inquiry.seqKey}</td>
									<td>
										${inquiry.name}<br>
										(${inquiry.id})
									</td>
									<td>${inquiry.category}</td>
									<td class="left"><a href="/admin/board/inquiry/search/${type}/${keyword}/${page}/read/${inquiry.seqKey}">${inquiry.title}</a></td>
									<td class="tnone">
										<fmt:parseDate var="createdDate" value="${inquiry.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										<ul class="state">
											<li>
												<c:choose>
													<c:when test="${inquiry.replyCreatedDate == null}">
														<div class="nbtnMini iw83">답변대기</div>
													</c:when>
													<c:otherwise>
														<div class="obtnMini iw83">답변완료</div>
													</c:otherwise>
												</c:choose>	
											</li>
										</ul>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<c:if test="${inquiryList.isEmpty()}">
						<div class="noData">
							문의 하신 내용이 없습니다.
						</div>
					</c:if>
				</div>
				<div class="btnAreaList">		
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/board/inquiry/search/${type}/${keyword}/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/board/inquiry/search/${type}/${keyword}/${page - 1}" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/board/inquiry/search/${type}/${keyword}/${i}" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/board/inquiry/search/${type}/${keyword}/${i}" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != pages && !inquiryList.isEmpty()}">
							<a href="/admin/board/inquiry/search/${type}/${keyword}/${page + 1}" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/board/inquiry/search/${type}/${keyword}/${pages}" class="page-nav-nobox">
								<i class="fas fa-angle-double-right paging"></i>
							</a>
						</c:if>
					</div>
					<%-- 페이지 네비게이션 끝 --%>
				</div>

				<%-- 검색 폼 --%>
				<form action="/admin/board/inquiry/search" method="post">
					<div class="searchWrap">
						<div class="search">
							<ul>
								<li class="web"><img src="/img/temp/txt/txt_search.gif" alt="search" /></li>
								<li class="se">
									<select name="searchType">
										<option value="title">제목</option>
										<option value="content">내용</option>
										<option value="reply">회신</option>
									</select>
								</li>
								<li><input type="text" class="searchInput" name="searchText" required></li>
								<li class="web"><button type="submit" class="no-outline"><img src="/img/temp/btn/btn_search.gif" alt="검색" /></button></li>
								<li class="mobile"><button type="submit" class="no-outline"><img src="/img/temp/btn/btn_search_m.gif" alt="검색" /></button></li>
							</ul>
						</div>
					</div>
				</form>
			</div>
		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
