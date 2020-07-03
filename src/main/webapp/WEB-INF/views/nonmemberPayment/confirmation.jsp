<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<link rel="stylesheet" href="/css/custom/payment.css">
</head>

<body>
<c:if test="${payCheck=='fail' }">
	<script type="text/javascript">
		alert('재고수량이 부족하여 결제가 완료되지 않았습니다. 재결제 해주시기 바랍니다.');
		window.location.href="/nonmember/cartList";
	</script>
</c:if>
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
										<th scope="col" class="tnone">가격</th>
										<th scope="col">수량</th>
										<th scope="col">합계</th>
									</thead>
									<tbody>
											<c:forEach var="item" items="${orderList}" varStatus="status">
												<tr>
													<td class="left">
														<p class="img"><img src="/files/product/${item.detailImageFilename1}" alt="상품" width="66" height="66" /></p>

														<ul class="goods">
															<li>
																<a href="/product/detail/${item.seqKey}">${item.name}</a>
															</li>
														</ul>
													</td>
													<td class="tnone">
														<fmt:formatNumber value="${item.price}" type="currency" pattern="#,###,### 원" /><br/>
													</td>
													<td>${quantity[status.index]} 개</td>
													<td><fmt:formatNumber value="${item.price * quantity[status.index]}" type="currency" pattern="#,###,### 원" /></td>
												</tr>
											</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="poroductTotal">
								<ul>	
									<li>상품 합계금액 <strong><fmt:formatNumber value="${paymentVo.amountTotal}" type="currency" pattern="#,###,### 원" /></strong></li>
									<li>+ 배송비 <strong><fmt:formatNumber value="${paymentVo.amountDelivery}" type="currency" pattern="#,###,### 원" /></strong></li>
									<li>= 총 합계 <strong><fmt:formatNumber value="${paymentVo.amountFinal}" type="currency" pattern="#,###,### 원" /></strong></li>
								</ul>
							</div>
							<!-- //주문 상품 -->


					<!-- 총 주문금액 -->
							<div class="amount">
								<h4 class="member">총 주문금액</h4>
								<ul class="info">
									<li>
										<span class="title">상품 합계금액</span>
										<span class="won"><strong><fmt:formatNumber value="${paymentVo.amountTotal}" type="currency" pattern="#,###,### 원" /></strong></span>
									</li>
									<li>
										<span class="title">배송비</span>
										<span class="won"><strong><fmt:formatNumber value="${paymentVo.amountDelivery}" type="currency" pattern="#,###,### 원" /></strong></span>
									</li>
								</ul>

								<ul class="total">
									<li class="txt"><strong>결제 예정 금액</strong></li>
									<li class="money"><span><fmt:formatNumber value="${paymentVo.amountFinal}" type="currency" pattern="#,###,### 원" /></span></li>
								</ul>
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
											<td><fmt:formatNumber value="${paymentVo.amountTotal}" type="currency" pattern="#,###,### 원" /></td>
										</tr>

										<tr>
											<th scope="row"><span>배송비</span></th>
											<td><fmt:formatNumber value="${paymentVo.amountDelivery}" type="currency" pattern="#,###,### 원" /> (선불)</td>
										</tr>

										<tr>
											<th scope="row"><span>총 결제<u>금액</u></span></th>
											<td colspan="3"><strong><fmt:formatNumber value="${paymentVo.amountFinal}" type="currency" pattern="#,###,### 원" /></strong></td>
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
											<td>${paymentVo.method }</td>
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
								<a href="/" class="nbtnbig iw0140">확인</a>
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
