<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css --%>
	<link rel="stylesheet" href="/css/custom/order.css">
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>

	<div id="allwrap">
		<div id="wrap">
			<%@ include file="../common/header.jsp" %>
			<%@ include file="../common/nav.jsp" %>

			<!-- container -->
			<div id="container">
				<div id="location">
					<ol>
						<li><a href="/">HOME</a></li>
						<li><a href="/order">MY PAGE</a></li>
						<li class="last">반품/교환 현황</li>
					</ol>
				</div>
				
				<div id="outbox">		
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(2,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2><strong>반품/교환 현황</strong><span>회원님이 구매하신 상품의 반품/교환 신청 및 내역을 확인하실 수 있습니다.</span></h2>
							
							<%@ include file="myinfo.jsp" %>

							<div class="orderDiv">
								<table class="orderTable" border="1" cellspacing="0">
									<caption>반품/교환 현황 사유보기</caption>
									<colgroup>
									<col width="25%" class="tw30" />
									<col width="7%" class="tnone" />
									<col width="*" />
									<col width="13%" class="tnone" />
									<col width="10%" class="tw18"/>
									<col width="15%" class="tnone" />
									</colgroup>
									<thead>
										<th scope="col">주문일자 <span>/ 주문번호</span></th>
										<th scope="col" class="tnone">분류</th>
										<th scope="col">상품명</th>
										<th scope="col" class="tnone">가격</th>
										<th scope="col">상태</th>
										<th scope="col" class="tnone">사유</th>
									</thead>
									<tbody>
										<c:forEach var="order" items="${takebackList}">
											<tr>
												<td>
													<p class="day">
														<fmt:parseDate var="createdDate" value="${order.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
														<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
													</p>
													<p class="orderNum">
														<a href="/order/detail/${order.orderNumber}">${order.orderNumber}</a>
													</p>
												</td>
												<td class="tnone">
													<c:choose>
														<c:when test="${order.status == '반품요청' || order.status == '반품요청(배송중)'}">
															<span class="heavygray">반품</span>
														</c:when>
														<c:otherwise>
															<span class="heavygray">교환</span>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="left">
													<a href="/order/detail/${order.orderNumber}">${order.productName}
														<c:if test="${order.orderGroup > 1}">
															(외 ${order.orderGroup - 1}건)
														</c:if>
													</a>
												</td>
												<td class="tnone"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.orderPrice}" /> 원</td>
												<td>
													<c:choose>
														<c:when test="${order.status == '반품요청' || order.status == '반품요청(배송중)'}">
															<span class="orange">반품요청</span>
														</c:when>
														<c:otherwise>
															<span class="orange">${order.status}</span>
														</c:otherwise>
													</c:choose>
												</td>
												<td class="tnone">
													<a href="/takeback/read/${order.seqKey}" class="nbtnbig iwc80 formLayer">사유보기</a>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

								<c:if test="${takebackList.isEmpty()}">
									<div class="noData">
										반품/교환 이력이 없습니다.
									</div>
								</c:if>
							</div>

							<div class="btnAreaList">
								<%-- 페이지 네비게이션 시작 --%>
								<div class="page-nav">
									<c:if test="${page != 1}">
										<a href="/takeback/1" class="page-nav-nobox">
											<i class="fas fa-angle-double-left paging"></i>
										</a>
										<a href="/takeback/${page - 1}" class="page-nav-nobox">
											<i class="fas fa-angle-left paging"></i>
										</a>
									</c:if>

									<c:forEach var="i" begin="${startPage}" end="${endPage}">
										<c:choose>
											<c:when test="${i == page}">
												<a href="/takeback/${i}" class="page-nav-now">${i}</a>
											</c:when>
											<c:otherwise>
												<a href="/takeback/${i}" class="page-nav-box">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>

									<c:if test="${page != pages && !takebackList.isEmpty()}">
										<a href="/takeback/${page + 1}" class="page-nav-nobox">
											<i class="fas fa-angle-right paging"></i>
										</a>
										<a href="/takeback/${pages}" class="page-nav-nobox">
											<i class="fas fa-angle-double-right paging"></i>
										</a>
									</c:if>
								</div>
								<%-- 페이지 네비게이션 끝 --%>
							</div>

						</div>
					</div>
					<!-- //contents -->

				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>

	<%-- jQuery fancybox --%>
	<script type="text/javascript" src="/js/temp/jquery.fancybox-1.3.4.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/temp/jquery.fancybox-1.3.4.css" />
	<script src="/js/custom/formLayer.js"></script>

	<%-- custom js --%>
	<script src="/js/custom/order.js"></script>
</body>
</html>