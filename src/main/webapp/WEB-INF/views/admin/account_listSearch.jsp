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
	<%-- custom css for account board --%>
	<link rel="stylesheet" href="/css/custom/order.css">
	<link rel="stylesheet" href="/css/custom/account.css">
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="account_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(1,0);</script>
			<div id="contents" style="position: relative; top: -35px;">
				<%-- 검색 폼 --%>
				<form action="/admin/account/list/search" method="post" onsubmit="return checkAdminSearch()">
					<div class="searchWrap">
						<div class="search">
							<ul>
								<li class="web"><img src="/img/temp/txt/txt_search.gif" alt="search" /></li>
								<li class="se">
									<select name="searchType">
										<option value="name">이름</option>
										<option value="email">이메일</option>
										<option value="phone">전화번호</option>
									</select>
								</li>
								<li><input type="text" class="searchInput" name="searchText" required></li>
								<li class="web"><button type="submit" class="no-outline"><img src="/img/temp/btn/btn_search.gif" alt="검색" /></button></li>
								<li class="mobile"><button type="submit" class="no-outline"><img src="/img/temp/btn/btn_search_m.gif" alt="검색" /></button></li>
							</ul>
						</div>
					</div>
				</form>

				<div style="position: relative; top: 20px; text-align: center;">
					[ '${keyword}' 키워드로 게시물을 검색했습니다. <a href="/admin/account/list"><button type="button">목록으로</button></a> ]
				</div>
				<div class="orderDiv">
					<table class="orderTable" border="1" cellspacing="0">
						<caption>회원목록</caption>
						<colgroup>
						<col width="5%" class="tnone" />
						<col width="10%"class="tnone" />
						<col width="13%" class="tnone" />
						<col width="*" class="tnone" />
						<col width="15%" class="tnone" />
						<col width="15%" class="tnone" />
						<col width="18%" class="tw30" />
						</colgroup>
						<thead>
							<th scope="col">NO.</span></th>
							<th scope="col">ID</th>
							<th scope="col" class="tnone">이름</th>
							<th scope="col" class="tnone">이메일</th>
							<th scope="col">전화번호</th>
							<th scope="col">가입일자</th>
							<th scope="col">회원관리</th>
						</thead>
						<tbody>
							<c:forEach var="account" items="${accountList}">
								<tr>
									<td class="tnone">
										${account.seqKey}
									</td>
									<td class="tnone">
										${account.id}
									</td>
									<td class="tnone">
										${account.name}
									</td>
									<td class="tnone">
										${account.email}
									</td>
									<td>
										${account.phone.substring(0,3)}-${account.phone.substring(3,7)}-${account.phone.substring(7,11)}
									</td>
									<td class="tnone">
										<fmt:parseDate var="createdDate" value="${account.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										<ul class="state">
											<li class="r5"><a href="/admin/account/list/0/modify/${account.seqKey}" class="obtnMini iw40">수정</a></li>
											<li><a href="/admin/account/list/delete/${account.seqKey}/${account.id}" class="nbtnMini iw40" onclick="return confirm('정말로 해당 회원내역을 삭제하시겠습니까?')">삭제</a></li>
											<li><a href="/admin/account/list/0/read/${account.seqKey}" class="decidebtn">상세보기</a></li>
										</ul>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<c:if test="${accountList.isEmpty()}">
						<div class="noData">
							회원 내역이 없습니다.
						</div>
					</c:if>
				</div>

				<div class="btnAreaList">
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/account/list/search/${type}/${keyword}/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/account/list/search/${type}/${keyword}/${page - 1}" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/account/list/search/${type}/${keyword}/${i}" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/account/list/search/${type}/${keyword}/${i}" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != pages && !accountList.isEmpty()}">
							<a href="/admin/account/list/search/${type}/${keyword}/${page + 1}" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/account/list/search/${type}/${keyword}/${pages}" class="page-nav-nobox">
								<i class="fas fa-angle-double-right paging"></i>
							</a>
						</c:if>
					</div>
					<%-- 페이지 네비게이션 끝 --%>
				</div>

			</div>
		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>

	<%-- custom js --%>
	<script src="/js/custom/accountSearch.js"></script>
</body>
</html>
