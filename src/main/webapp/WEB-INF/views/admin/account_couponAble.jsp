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
			<script type="text/javascript">initSubmenu(4,0);</script>
			<div id="contents">
				<div id="mypage">
					<!-- Serviceable -->
					<div class="tab_serviceable couponnone">
						<div class="shortTxt">유효한 쿠폰은 총 <span class="orange">${count}</span>장입니다.</div>
						<div class="orderDivNm">
							<table class="orderTable2" border="1" cellspacing="0">
								<caption>유효 쿠폰 보기</caption>
								<colgroup>
									<col width="5%" class="tnone" />
									<col width="10%" class="tnone" />
									<col width="10%" class="tnone" />
									<col width="15%" class="tw28" />
									<col width="22%" class="tnone"/>
									<col width="*" />
									<col width="10%" class="tw20" />
								</colgroup>
								<thead>
									<th scope="col" class="tnone">NO.</th>
									<th scope="col" class="tnone">아이디</th>
									<th scope="col" class="tnone">이름</th>
									<th scope="col">쿠폰명</th>
									<th scope="col" class="tnone">사용조건</th>
									<th scope="col">사용기한</th>
									<th scope="col">상태</th>
								</thead>
								<tbody>
									<c:forEach var="coupon" items="${couponList}">
										<tr>
											<td class="tnone">${coupon.seqKey}</td>
											<td class="tnone">${coupon.id}</td>
											<td class="tnone">${coupon.accountName}</td>
											<td>${coupon.name}</td>
											<td class="tnone">
												<fmt:formatNumber type="number" maxFractionDigits="3" value="${coupon.minimumPrice}" /> 원 이상 구매
											</td>
											<td>
												<fmt:parseDate var="startDate" value="${coupon.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
												<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>
													~ 
												<fmt:parseDate var="endDate" value="${coupon.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
												<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>
											</td>
											<td><span class="heavygray">사용가능</span></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>

							<c:if test="${couponList.isEmpty()}">
								<div class="noData">
									사용 가능한 쿠폰이 없습니다.
								</div>
							</c:if>
						</div>								
					</div>
					<!-- //Serviceable -->
				</div>

				<div class="btnAreaList">
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/account/coupon/able/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/account/coupon/able/${page - 1}" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/account/coupon/able/${i}" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/account/coupon/able/${i}" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != pages && !orderList.isEmpty()}">
							<a href="/admin/account/coupon/able/${page + 1}" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/account/coupon/able/${pages}" class="page-nav-nobox">
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
