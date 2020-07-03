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
						<li class="last">주문/배송 조회</li>
					</ol>
				</div>
				
				<div id="outbox">
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(1,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2>
								<strong>주문/배송 조회</strong>
								<span>
									상품명을 클릭하시면 주문 상세내역을 확인하실 수 있습니다.<br>
									(여러 상품을 주문한 경우, 주문 상세 페이지에서 각 상품 별로 리뷰를 남기실 수 있습니다.)
								</span>
							</h2>

							<%@ include file="myinfo.jsp" %>
							
							<div class="orderDiv">
								<table class="orderTable" border="1" cellspacing="0">
									<caption>주문게시판</caption>
									<colgroup>
									<col width="25%" class="tw28" />
									<col width="*" />
									<col width="15%" class="tnone" />
									<col width="8%" class="tnone" />
									<col width="18%" class="tw30" />
									</colgroup>
									<thead>
										<th scope="col">주문일자 <span>/ 주문번호</span></th>
										<th scope="col">상품명</th>
										<th scope="col" class="tnone">주문총액</th>
										<th scope="col" class="tnone">총 수량</th>
										<th scope="col">주문상태</th>
									</thead>
									<tbody>
										<c:forEach var="order" items="${orderList}">
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
												<td class="left">
													<a href="/order/detail/${order.orderNumber}">${order.productName}
														<c:if test="${order.orderGroup > 1}">
															(외 ${order.orderGroup - 1}건)
														</c:if>
													</a>
												</td>
												<td class="tnone"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.orderPrice}" /> 원</td>
												<td class="tnone"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.orderQuantity}" /> 개</td>
												<td>
													<c:choose>
														<c:when test="${order.status == '입금대기'}">
															<span class="lightgray">입금대기</span>
															<ul class="state">
																<li><a href="/order/cancel/${order.orderNumber}" class="nbtnMini iw83" onclick="return confirm('주문을 취소하시겠습니까?\n (주문 시 사용한 쿠폰은 반환되지 않습니다)')">취소</a></li>
															</ul>										
														</c:when>
														<c:when test="${order.status == '결제완료'}">
															<span class="lightgray">결제완료</span>
															<ul class="state">
																<li><a href="/order/cancel/${order.orderNumber}" class="nbtnMini iw83" onclick="return confirm('주문을 취소하시겠습니까?\n (주문 시 사용한 쿠폰은 반환되지 않습니다)')">취소</a></li>
															</ul>										
														</c:when>
														<c:when test="${order.status == '배송준비중'}">
															<span class="orange">배송준비중</span>	
															<ul class="state">
																<li><a href="/order/cancel/${order.orderNumber}" class="nbtnMini iw83" onclick="return confirm('주문을 취소하시겠습니까?\n (주문 시 사용한 쿠폰은 반환되지 않습니다)')">취소</a></li>
															</ul>										
														</c:when>
														<c:when test="${order.status == '배송중'}">
															<span class="orange">배송중</span>	
															<ul class="state">
																<li><a href="/takeback/write/early-return/${order.orderNumber}" class="nbtnMini iw83 formLayer">반품요청</a></li>
																<li><a href="/order/confirm/${order.orderNumber}" class="decidebtn">구매확정</a></li>
															</ul>
														</c:when>
														<c:when test="${order.status == '배송완료'}">
															<span class="heavygray">배송완료</span>
															<ul class="state">
																<li class="r5"><a href="/takeback/write/replace/${order.orderNumber}" class="obtnMini iw40 formLayer">교환</a></li>
																<li><a href="/takeback/write/return/${order.orderNumber}" class="nbtnMini iw40 formLayer">반품</a></li>
																<li><a href="/order/confirm/${order.orderNumber}" class="decidebtn">구매확정</a></li>
															</ul>
														</c:when>
														<c:when test="${order.status == '구매확정'}">
															<span class="heavygray">구매확정</span>
															<c:choose>
																<c:when test="${order.orderGroup == 1 && order.review == 'N'}">
																	<ul class="state">
																	<li><a href="/review/reviewWriteView/${order.productKey}/${order.seqKey}" class="reviewbtn formLayer">리뷰작성</a></li>
																	</ul>
																</c:when>
															</c:choose>							
														</c:when>
														<c:when test="${order.status == '반품요청(배송중)'}">
															<span class="heavygray">반품요청</span>
															<ul class="state">
																<li><a href="/takeback/cancel/${order.orderNumber}" class="nbtnMini iw83">요청취소</a></li>
															</ul>
														</c:when>
														<c:when test="${order.status == '교환요청' || order.status == '반품요청'}">
															<span class="heavygray">${order.status}</span>
															<ul class="state">
																<li><a href="/takeback/cancel/${order.orderNumber}" class="nbtnMini iw83">요청취소</a></li>
															</ul>
														</c:when>
														<c:when test="${order.status == '배송준비중(교환배송비)' || order.status == '배송준비중(교환)'}">
															<span class="heavygray">교환배송 준비중</span>
														</c:when>
														<c:when test="${order.status == '환불대기(반품)' || order.status == '환불대기(배송비제외)'}">
															<span class="heavygray">환불대기</span>
														</c:when>
														<c:otherwise>
															<span class="heavygray">${order.status}</span>
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

								<c:if test="${orderList.isEmpty()}">
									<div class="noData">
										구매 이력이 없습니다.
									</div>
								</c:if>
							</div>

							<div class="btnAreaList">
								<%-- 페이지 네비게이션 시작 --%>
								<div class="page-nav">
									<c:if test="${page != 1}">
										<a href="/order/1" class="page-nav-nobox">
											<i class="fas fa-angle-double-left paging"></i>
										</a>
										<a href="/order/${page - 1}" class="page-nav-nobox">
											<i class="fas fa-angle-left paging"></i>
										</a>
									</c:if>

									<c:forEach var="i" begin="${startPage}" end="${endPage}">
										<c:choose>
											<c:when test="${i == page}">
												<a href="/order/${i}" class="page-nav-now">${i}</a>
											</c:when>
											<c:otherwise>
												<a href="/order/${i}" class="page-nav-box">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>

									<c:if test="${page != pages && !orderList.isEmpty()}">
										<a href="/order/${page + 1}" class="page-nav-nobox">
											<i class="fas fa-angle-right paging"></i>
										</a>
										<a href="/order/${pages}" class="page-nav-nobox">
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