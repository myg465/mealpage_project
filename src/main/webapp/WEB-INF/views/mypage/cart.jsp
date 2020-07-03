<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css --%>
	<link rel="stylesheet" href="/css/custom/cart.css">
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
						<li><a href="/mypage/order">MY PAGE</a></li>
						<li class="last">장바구니</li>
					</ol>
				</div>
		
				<div id="outbox">
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(3,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2><strong>장바구니</strong><span>장바구니에 담긴 상품을 확인해보세요.</span></h2>
							
							<%@ include file="myinfo.jsp" %>

							<c:choose>
								<c:when test="${cartList.isEmpty()}">
									<!-- 장바구니에 상품이 없을경우 -->
									<div class="noting">
										<div class="point"><span class="orange">장바구니</span>에 담긴 상품이 없습니다.</div>

										<a href="/">쇼핑 계속하기</a>
									</div>
								</c:when>
								<c:otherwise>
									<!-- 장바구니에 상품이 있을경우 -->
									<!-- 장바구니 상품 -->
									<h3>장바구니에 담긴 상품</h3>
									<div class="orderDivNm">
										<table class="orderTable" border="1" cellspacing="0">
											<caption>장바구니 상품목록</caption>
											<colgroup>
											<col width="7%"/>
											<col width="*" />
											<col width="14%" class="tnone" />
											<col width="10%" class="tw14"/>
											<col width="14%" class="tw28"/>
											<col width="14%" class="tnone" />
											</colgroup>
											<thead>
												<th scope="col"><input type="checkbox" class="selectAll"></th>
												<th scope="col">상품명</th>
												<th scope="col" class="tnone">가격/포인트</th>
												<th scope="col">수량</th>
												<th scope="col">합계</th>
												<th scope="col" class="tnone">주문</th>
											</thead>
											<tbody>
												<c:set var="totalPrice" value="0" />
												<c:set var="totalPoint" value="0" />
												<c:forEach var="cart" items="${cartList}">
													<c:set var="totalPrice" value="${totalPrice + (cart.price * cart.quantity)}" />
													<c:set var="totalPoint" value="${totalPoint + ((cart.price * cart.quantity) / 10)}" />
													<tr>
														<td><input type="checkbox" class="select" key="${cart.seqKey}"></td>
														<td class="left">
															<p class="img">
																<img src="/files/product/${cart.detailImageFilename1}" alt="상품" width="66" height="66" />
															</p>
															<ul class="goods">
																<li>
																	<a href="/product/detail/${cart.productKey}">${cart.name}</a>
																</li>
															</ul>
														</td>
														<td class="tnone">
															<fmt:formatNumber type="number" maxFractionDigits="3" value="${cart.price}" /> 원<br/>
															<span class="pointscore">
																<fmt:formatNumber type="number" maxFractionDigits="3" value="${cart.price / 10}" /> Point
															</span>
														</td>
														<td>
															<input type="number" class="quantity" name="quantity" min=1 value="${cart.quantity}" key="${cart.seqKey}">
														</td>
														<td>
															<fmt:formatNumber type="number" maxFractionDigits="3" value="${cart.price * cart.quantity}" /> 원
														</td>
														<td class="tnone">
															<ul class="order">	
																<li>
																	<a class="obtnMini iw70 point" onclick="buyNow(${cart.seqKey})">바로구매</a>
																	</li>
																<li>
																	<a class="nbtnMini iw70 point" onclick="deleteCart(${cart.seqKey})">상품삭제</a>
																</li>
															</ul>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>

									<div class="btnArea">
										<div class="bRight">
											<ul>
												<li><a class="selectbtn point" onclick="selectAll()">전체선택</a></li>
												<li><a class="selectbtn2 point" onclick="deselectAll()">선택해제</a></li>
												<li><a class="selectbtn2 point" onclick="deleteCarts()">선택삭제</a></li>
											</ul>
										</div>
									</div>
									<!-- //장바구니 상품 -->
									
									<!-- 총 주문금액 -->
									<div class="amount">
										<h4>총 주문금액</h4>
										<ul class="info">
											<li>
												<span class="title">상품 합계금액</span>
												<span class="won">
													<strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" /></strong> 원
												</span>
											</li>
											<li>
												<c:set var="deliveryFee" value="10000" />
												<span class="title">배송비</span>
												<span class="won"><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${deliveryFee}" /></strong> 원</span>
											</li>
										</ul>
										<ul class="total">
											<li class="mileage">(적립 마일리지 <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPoint}" /></strong> Point) </li>
											<li class="txt"><strong>결제 예정 금액</strong></li>
											<li class="money"><span><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice + deliveryFee}" /></span> 원</li>
										</ul>
									</div>
									<!-- //총 주문금액 -->

									<div class="cartarea">
										<ul>
											<li><a class="ty1 point" onclick="orderSelected()">선택상품 <span>주문하기</span></a></li>
											<li><a class="ty2 point" onclick="orderAll()">전체상품 <span>주문하기</span></a></li>
											<li class="last"><a href="/" class="ty3 point">쇼핑 <span>계속하기</span></a></li>
										</ul>
									</div>
									<!-- //장바구니에 상품이 있을경우 -->
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<!-- //contents -->

				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>

  <div id="layer">
		수량을 변경하고 있습니다.
  </div>

	<%-- custom js --%>
	<script src="/js/custom/cart.js"></script>
</body>
</html>