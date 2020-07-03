<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<c:if test="${error != null}">
	<script>
		alert('재고가 부족한 상품이 있어 주문에 실패하였습니다.\n상품명: <c:out value="${productName}" />\n재고량: <c:out value="${quantity}" />\n주문수량: <c:out value="${stock}" />')
		location.replace('/cart')
	</script>
</c:if>
<head>
	<%@ include file="../common/head.jsp" %>
	<link rel="stylesheet" href="/css/custom/payment.css">
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
						<li class="last">주문/결제</li>
					</ol>
				</div>
				
				<div id="outbox">		
					<!-- maxcontents -->
					<div id="maxcontents">
						<div id="mypage">
							<h2><strong>주문/결제</strong></h2>
							
							<!-- 주문 상품 -->
							<h3 class="dep">주문 제품 확인</h3>
							<div class="orderDivNm">
								<table class="orderTable" border="1" cellspacing="0">
									<caption>주문 제품 확인</caption>
									<colgroup>
									<col width="*" />
									<col width="16%" class="tnone" />
									<col width="14%" />
									<col width="16%" class="tw28"/>
									</colgroup>
									<thead>
										<th scope="col">상품명</th>
										<th scope="col" class="tnone">가격/포인트</th>
										<th scope="col">수량</th>
										<th scope="col">합계</th>
									</thead>
									<tbody>
										<c:forEach var="item" items="${orderItemList}">
											<tr>
												<td class="left">
													<p class="img"><img src="/files/product/${item.detailImageFilename1}" alt="상품" width="66" height="66" /></p>

													<ul class="goods">
														<li>
															<a href="/product/detail/${item.productKey}">${item.name}</a>
														</li>
													</ul>
												</td>
												<td class="tnone">
													<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.price}" /> 원<br/>
													<span class="pointscore">
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${item.price / 10}" /> Point
													</span>
												</td>
												<td>${item.quantity} 개</td>
												<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.price * item.quantity}" /> 원</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="poroductTotal">
								<ul>	
									<li>상품 합계금액 <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountTotal}" /></strong> 원</li>
									<li>+ 배송비 <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountDelivery}" /></strong> 원</li>
									<li>= 총 합계 <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountTotal + paymentVo.amountDelivery}" /></strong> 원</li>
								</ul>
							</div>
							<!-- //주문 상품 -->


					<!-- 총 주문금액 -->
							<div class="amount">
								<h4 class="member">총 주문금액</h4>
								<ul class="info">
									<li>
										<span class="title">상품 합계금액</span>
										<span class="won"><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountTotal}" /></strong> 원</span>
									</li>
									<li>
										<span class="title">배송비</span>
										<span class="won"><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountDelivery}" /></strong> 원</span>
									</li>
									<li>
										<span class="title">쿠폰 할인</span>
										<span class="won"><strong>- <fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountDiscountCoupon}" /></strong> 원</span>
									</li>
									<li>
										<span class="title">포인트 할인</span>
										<span class="won"><strong>- <fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountDiscountPoint}" /></strong> P</span>
									</li>
								</ul>

								<ul class="total">
									<c:choose>
										<c:when test="${paymentVo.amountFinal > 0}">
											<li class="mileage">(적립 예정 포인트 <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountFinal / 10}" /></strong> Point) </li>
										</c:when>
										<c:otherwise>
											<li class="mileage">(적립 포인트 <strong>0</strong> Point) </li>
										</c:otherwise>
									</c:choose>
									<li class="txt"><strong>결제 예정 금액</strong></li>
									<li class="money"><span><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountFinal}" /></span> 원</li>
								</ul>
								<div style="position: relative; top: 25px; left: 495px;">* 쿠폰/포인트로 할인받은 금액에 대해서는 포인트가 적립되지 않습니다.</div>
							</div>
					<!-- //총 주문금액 -->

					<!-- 주문자 정보확인 -->
							<h3 class="dep">주문자 정보</h3>
							<div class="checkDiv">
								<table class="checkTable" border="1" cellspacing="0">
									<caption>주문자 정보확인</caption>
									<colgroup>
									<col width="17%" class="tw20" />
									<col width="*" />
									<col width="17%" class="tw20" />
									<col width="*" class="tw25" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><span>이름</span></th>
											<td>${paymentVo.ordererName}</td>
											<th scope="row"><span>이메일</span></th>
											<td>${paymentVo.ordererEmail}</td>
										</tr>

										<tr>
											<th scope="row"><span>주소</span></th>
											<td>${paymentVo.ordererAddressNew}<br/>${paymentVo.ordererAddressDetail}</td>
											<th scope="row"><span>휴대폰 <u>번호</u></span></th>
											<td>${paymentVo.ordererPhone.substring(0,3)}-${paymentVo.ordererPhone.substring(3,7)}-${paymentVo.ordererPhone.substring(7,11)}</td>
										</tr>
									</tbody>
								</table>
							</div>
					<!-- //주문자 정보확인 -->

					<!-- 수취자 정보확인 -->
							<h3 class="dep">수취자 정보</h3>
							<div class="checkDiv">
								<table class="checkTable" border="1" cellspacing="0">
									<caption>수취자 정보확인</caption>
									<colgroup>
									<col width="17%" class="tw20" />
									<col width="*" />
									<col width="17%" class="tw20" />
									<col width="*" class="tw25" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><span>이름</span></th>
											<td colspan="3">${paymentVo.recipientName}</td>
										</tr>

										<tr>
											<th scope="row"><span>주소</span></th>
											<td>${paymentVo.recipientAddressNew}<br/>${paymentVo.recipientAddressDetail}</td>
											<th scope="row"><span>휴대폰 <u>번호</u></span></th>
											<td>${paymentVo.recipientPhone.substring(0,3)}-${paymentVo.recipientPhone.substring(3,7)}-${paymentVo.recipientPhone.substring(7,11)}</td>
										</tr>

										<tr>
											<th scope="row"><span>배송시 <u>요구사항</u></span></th>
											<td colspan="3">${paymentVo.recipientRequest}</td>
										</tr>
									</tbody>
								</table>
							</div>
					<!-- //주문자 정보확인 -->


					<!-- 결제금액 확인 -->
							<h3 class="dep">결제금액</h3>
							<div class="checkDiv">
								<table class="checkTable" border="1" cellspacing="0">
									<caption>결제금액확인</caption>
									<colgroup>
									<col width="17%" class="tw20" />
									<col width="*" />
									<col width="17%" class="tw20" />
									<col width="*" class="tw25" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><span>총 주문<u>금액</u></span></th>
											<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountTotal}" /> 원</td>
											<th scope="row"><span>쿠폰 <u>할인</u></span></th>
											<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountDiscountCoupon}" /> 원</td>
										</tr>

										<tr>
											<th scope="row"><span>배송비</span></th>
											<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountDelivery}" /> 원 (선불)</td>
											<th scope="row"><span>포인트 <u>사용</u></span></th>
											<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountDiscountPoint}" /> Point</td>
										</tr>

										<tr>
											<th scope="row"><span>총 결제<u>금액</u></span></th>
											<td colspan="3"><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountFinal}" /> 원</strong></td>
										</tr>
									</tbody>
								</table>
							</div>
					<!-- //결제금액 확인 -->

					<!-- 주문 정보 확인 -->
							<h3 class="dep">주문 정보</h3>
							<div class="checkDiv">
								<table class="checkTable" border="1" cellspacing="0">
									<caption>주문 정보</caption>
									<colgroup>
									<col width="17%" class="tw20" />
									<col width="*" />
									<col width="17%" class="tw20" />
									<col width="*" class="tw25" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><span>주문번호</span></th>
											<td>${orderNumber}</td>
											<th scope="row"><span>결제수단</span></th>
											<td>무통장 입금</td>
										</tr>

										<tr>
											<th scope="row"><span>주문일</span></th>
											<td>${today}</td>
											<th scope="row"><span>입금은행</span></th>
											<td>카카오뱅크 3333-16-4743882 김우혁</td>
										</tr>

										<tr>
											<th scope="row"><span>주문상태</span></th>
											<td colspan="3">${paymentVo.status}</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- //주문 정보 확인 -->

							<!-- Btn Area -->
							<div class="btnArea2">
								<a href="/order" class="nbtnbig iw0140">확인</a>
							</div>
							<!-- //Btn Area -->

						</div>
					</div>
					<!-- //maxcontents -->

				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</body>
</html>
