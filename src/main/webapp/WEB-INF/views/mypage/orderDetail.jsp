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
							<h2><strong>주문 상세 확인</strong><span>회원님의 주문내역 상세정보를 확인하실 수 있습니다.</span></h2>

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
										<th scope="col" class="tnone">가격</th>
										<th scope="col" class="tnone">수량</th>
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
														${order.orderNumber}
													</p>
												</td>
												<td class="left">
													<a href="/product/detail/${order.productKey}">${order.productName}</a>
												</td>
												<td class="tnone"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.productPrice}" /> 원</td>
												<td class="tnone"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.quantity}" /> 개</td>
												<td>
													<c:choose>
														<c:when test="${order.status == '입금대기' || order.status == '결제완료'}">
															<span class="lightgray">${order.status}</span>
														</c:when>
														<c:when test="${order.status == '배송준비중' || order.status == '배송중'}">
															<span class="orange">${order.status}</span>	
														</c:when>
														<c:when test="${order.status == '구매확정'}">
															<span class="heavygray">구매확정</span>
															<c:if test="${order.review == 'N'}">
																<ul class="state">	
																	<li><a href="/review/reviewWriteView/${order.productKey}/${order.seqKey}" class="reviewbtn formLayer">리뷰작성</a></li>
																</ul>
															</c:if>
														</c:when>
														<c:when test="${order.status == '반품요청(배송중)'}">
															<span class="heavygray">반품요청</span>
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
										<tr>
											<c:set var="deliveryFee" value="10000" />
											<td colspan="2">배송비</td>
											<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${deliveryFee}" /> 원</td>
											<td colspan="2"></td>
										</tr>
										<tr>
											<td colspan="2" class="black">합계</td>
											<td class="black"><fmt:formatNumber type="number" maxFractionDigits="3" value="${orderPrice}" /> 원</td>
											<td colspan="2"></td>
										</tr>
									</tbody>
								</table>

								<c:if test="${orderList.isEmpty()}">
									<div class="noData">
										해당하는 주문이 없습니다.
									</div>
								</c:if>
							</div>

							<div class="btnArea">
								<div class="bCenter button-fix">
									<ul>
										<li><a href="/order" class="sbtnMini">확인</a></li>
									</ul>
								</div>
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
</body>
</html>