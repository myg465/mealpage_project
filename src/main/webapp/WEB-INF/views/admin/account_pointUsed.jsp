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
			<script type="text/javascript">initSubmenu(3,0);</script>
			<div id="contents">
				<div id="mypage">
					<!-- Usage -->
					<div class="tab_usage couponnone">
						<c:set var="totalUsedPoint" value="0" />
						<c:forEach var="point" items="${pointUsedList}">
							<c:set var="totalUsedPoint" value="${totalUsedPoint + point.point}" />		
						</c:forEach>
						<div class="shortTxt">지금까지 발급된 포인트 중 총 <span class="orange"><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalUsedPoint}" /></span> 포인트가 사용되었습니다.</div>
						<div class="orderDivNm">
							<table class="orderTable2" border="1" cellspacing="0">
								<caption>사용내역 보기</caption>
								<colgroup>
								<col width="9%" class="tnone" />
								<col width="12%" class="tnone" />
								<col width="12%" class="tnone" />
								<col width="*" />
								<col width="15%" class="tw20" />
								<col width="15%" class="tnone" />
								</colgroup>
								<thead>
									<th scope="col" class="tnone">NO.</th>
									<th scope="col" class="tnone">아이디</th>
									<th scope="col" class="tnone">이름</th>
									<th scope="col">내역</th>
									<th scope="col">사용 <span>포인트</span></th>
									<th scope="col" class="tnone">사용날짜</th>
								</thead>
								<tbody>
									<c:forEach var="point" items="${pointUsedList}">
										<tr>
											<td class="tnone">${point.seqKey}</td>
											<td class="tnone">${point.id}</td>
											<td class="tnone">${point.name}</td>
											<td class="left">${point.content}</td>
											<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${point.point}" /></td>
											<td class="tnone">
												<fmt:parseDate var="createdDate" value="${point.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
												<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

							<c:if test="${pointUsedList.isEmpty()}">
								<div class="noData">
									포인트 사용 내역이 없습니다.
								</div>
							</c:if>
						</div>
					</div>	
					<!-- //Usage -->

				</div>

				<div class="btnAreaList">
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/account/point/used/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/account/point/used/${page - 1}" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/account/point/used/${i}" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/account/point/used/${i}" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != pages && !orderList.isEmpty()}">
							<a href="/admin/account/point/used/${page + 1}" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/account/point/used/${pages}" class="page-nav-nobox">
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
</body>
</html>
