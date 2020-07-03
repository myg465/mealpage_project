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
	<%-- custom css for order_detail board --%>
	<link rel="stylesheet" href="/css/custom/payment.css">
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="order_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(1,0);</script>

			<div id="contents-long">
				<div id="mypage" style="position: relative; top: -20px;">
					<!-- Btn Area -->
					<div class="btnArea">
						<div class="bRight">
							<ul>
								<li>
									<div class="order-status">
										<c:choose>
											<c:when test="${orderStatus == '반품요청(배송중)'}">
												[현재 주문상태는 '<span style="color: darkred;">반품요청</span>'입니다.]
											</c:when>
											<c:otherwise>
												[현재 주문상태는 '<span style="color: darkred;">${orderStatus}</span>'입니다.]
											</c:otherwise>
										</c:choose>
									</div>&emsp;
								</li>
								<c:choose>
									<c:when test="${orderStatus == '입금대기'}">
										<li><a href="/admin/order/user/${page}/cancel/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 주문을 취소하시겠습니까?')">주문취소</a></li>
										<li><a href="/admin/order/user/${page}/paid/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 결제금액 입금이 확인되었습니까?')">입금확인</a></li>
									</c:when>
									<c:when test="${orderStatus == '결제완료'}">
										<li><a href="/admin/order/user/${page}/cancelPayment/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 입금확인을 취소하시겠습니까?')">입금확인 취소</a></li>
										<li><a href="/admin/order/user/${page}/readyDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송준비중으로 변경하시겠습니까?')">배송준비 시작</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송준비중'}">
										<li><a href="/admin/order/user/${page}/cancelDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문의 배송준비를 취소하시겠습니까?')">배송준비중 취소</a></li>
										<li><a href="/admin/order/user/${page}/startDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송중으로 변경하시겠습니까?')">배송 시작</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송준비중(교환배송비)'}">
										<li><a href="/admin/order/user/${page}/startDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 교환배송비 입금이 확인되었습니까?')">교환배송 시작</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송준비중(교환)'}">
										<li><a href="/admin/order/user/${page}/startDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송중으로 변경하시겠습니까?')">교환배송 시작</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송중'}">
										<li><a href="/admin/order/user/${page}/stopDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문배송을 취소하시겠습니까?')">배송중 취소</a></li>
										<li><a href="/admin/order/user/${page}/deliveryOk/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송완료로 변경하시겠습니까?')">배송완료</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송완료'}">
										<li><a href="/admin/order/user/${page}/deliveryNg/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송중으로 변경하시겠습니까?')">배송완료 취소</a></li>
									</c:when>
									<c:when test="${orderStatus == '환불대기'}">
										<li><a href="/admin/order/user/${page}/refund/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 결제금액에 대한 환불이 완료되었습니까?')">환불완료</a></li>
									</c:when>
									<c:when test="${orderStatus == '환불대기(배송비제외)'}">
										<li><a href="/admin/order/user/${page}/refund/${orderNumber}" class="nbtnbig mw" onclick="return confirm('반품된 제품을 이상 없이 받았으며, (배송비를 제외하고) 고객의 결제금액에 대한 환불이 완료되었습니까?')">환불완료</a></li>
									</c:when>
									<c:when test="${orderStatus == '환불대기(반품)'}">
										<li><a href="/admin/order/user/${page}/refund/${orderNumber}" class="nbtnbig mw" onclick="return confirm('반품된 제품을 이상 없이 받았으며, 고객의 결제금액에 대한 환불이 완료되었습니까?')">환불완료</a></li>
									</c:when>
									<c:when test="${orderStatus == '반품요청' || orderStatus == '반품요청(배송중)'}">
										<li><a href="/admin/order/takeback/${orderNumber}" class="nbtnbig mw formLayer">반품회신</a></li>
									</c:when>
									<c:when test="${orderStatus == '교환요청'}">
										<li><a href="/admin/order/takeback/${orderNumber}" class="nbtnbig mw formLayer">교환회신</a></li>
									</c:when>
								</c:choose>
								<li><a href="/admin/order/user/${page}" class="sbtnMini mw">목록으로</a></li>
							</ul>
						</div>
					</div>
					<!-- //Btn Area -->

					<h3 class="dep">주문 정보</h3>
					<div class="orderDivNm">
						<table class="orderTable" border="1" cellspacing="0">
							<colgroup>
							<col width="25%" class="tw28" />
							<col width="*" />
							<col width="15%" class="tnone" />
							<col width="8%" class="tnone" />
							<col width="18%" class="tw30" />
							</colgroup>
							<thead>
								<th scope="col">결제수단</span></th>
								<th scope="col">입금은행</th>
								<th scope="col" class="tnone">총 결제금액</th>
								<th scope="col" class="tnone">주문자</th>
								<th scope="col">결제상태</th>
							</thead>
							<tbody>
									<tr>
										<td>무통장 입금</td>
										<td>
											카카오뱅크 3333-16-4743882 김우혁
										</td>
										<td class="tnone">
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${paymentVo.amountFinal}" /> 원
										</td>
										<td class="tnone">${paymentVo.ordererName}</td>
										<td>
											${paymentVo.status}
										</td>
									</tr>
							</tbody>
						</table>
					</div>

					<!-- 주문 상품 -->
					<h3 class="dep">주문 제품</h3>
					<div class="orderDivNm">
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
												<c:when test="${order.status == '배송준비중' || order.status == '배송중' || order.status == '반품요청' || order.status == '교환요청'}">
													<span class="orange">${order.status}</span>	
												</c:when>
												<c:when test="${order.status == '반품요청(배송중)'}">
													<span class="orange">반품요청</span>	
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
					</div>
					<!-- //주문 상품 -->

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

					<!-- Btn Area -->
					<div class="btnArea" style="margin-top: 20px;">
						<div class="bRight">
							<ul>
								<li>
							<div class="order-status">
								<c:choose>
									<c:when test="${orderStatus == '반품요청(배송중)'}">
										[현재 주문상태는 '<span style="color: darkred;">반품요청</span>'입니다.]
									</c:when>
									<c:otherwise>
										[현재 주문상태는 '<span style="color: darkred;">${orderStatus}</span>'입니다.]
									</c:otherwise>
								</c:choose>
							</div>&emsp;

								</li>
								<c:choose>
									<c:when test="${orderStatus == '입금대기'}">
										<li><a href="/admin/order/user/${page}/cancel/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 주문을 취소하시겠습니까?')">주문취소</a></li>
										<li><a href="/admin/order/user/${page}/paid/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 결제금액 입금이 확인되었습니까?')">입금확인</a></li>
									</c:when>
									<c:when test="${orderStatus == '결제완료'}">
										<li><a href="/admin/order/user/${page}/cancelPayment/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 입금확인을 취소하시겠습니까?')">입금확인 취소</a></li>
										<li><a href="/admin/order/user/${page}/readyDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송준비중으로 변경하시겠습니까?')">배송준비 시작</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송준비중'}">
										<li><a href="/admin/order/user/${page}/cancelDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문의 배송준비를 취소하시겠습니까?')">배송준비중 취소</a></li>
										<li><a href="/admin/order/user/${page}/startDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송중으로 변경하시겠습니까?')">배송 시작</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송준비중(교환배송비)'}">
										<li><a href="/admin/order/user/${page}/startDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 교환배송비 입금이 확인되었습니까?')">교환배송 시작</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송준비중(교환)'}">
										<li><a href="/admin/order/user/${page}/startDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송중으로 변경하시겠습니까?')">교환배송 시작</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송중'}">
										<li><a href="/admin/order/user/${page}/stopDelivery/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문배송을 취소하시겠습니까?')">배송중 취소</a></li>
										<li><a href="/admin/order/user/${page}/deliveryOk/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송완료로 변경하시겠습니까?')">배송완료</a></li>
									</c:when>
									<c:when test="${orderStatus == '배송완료'}">
										<li><a href="/admin/order/user/${page}/deliveryNg/${orderNumber}" class="nbtnbig mw" onclick="return confirm('주문상태를 배송중으로 변경하시겠습니까?')">배송완료 취소</a></li>
									</c:when>
									<c:when test="${orderStatus == '환불대기'}">
										<li><a href="/admin/order/user/${page}/refund/${orderNumber}" class="nbtnbig mw" onclick="return confirm('고객의 결제금액에 대한 환불이 완료되었습니까?')">환불완료</a></li>
									</c:when>
									<c:when test="${orderStatus == '환불대기(배송비제외)'}">
										<li><a href="/admin/order/user/${page}/refund/${orderNumber}" class="nbtnbig mw" onclick="return confirm('반품된 제품을 이상 없이 받았으며, (배송비를 제외하고) 고객의 결제금액에 대한 환불이 완료되었습니까?')">환불완료</a></li>
									</c:when>
									<c:when test="${orderStatus == '환불대기(반품)'}">
										<li><a href="/admin/order/user/${page}/refund/${orderNumber}" class="nbtnbig mw" onclick="return confirm('반품된 제품을 이상 없이 받았으며, 고객의 결제금액에 대한 환불이 완료되었습니까?')">환불완료</a></li>
									</c:when>
									<c:when test="${orderStatus == '반품요청' || orderStatus == '반품요청(배송중)'}">
										<li><a href="/admin/order/takeback/${orderNumber}" class="nbtnbig mw formLayer">반품회신</a></li>
									</c:when>
									<c:when test="${orderStatus == '교환요청'}">
										<li><a href="/admin/order/takeback/${orderNumber}" class="nbtnbig mw formLayer">교환회신</a></li>
									</c:when>
								</c:choose>
								<li><a href="/admin/order/user/${page}" class="sbtnMini mw">목록으로</a></li>
							</ul>
						</div>
					</div>
					<!-- //Btn Area -->

				</div>
			</div>

		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>

	<%-- jQuery fancybox --%>
	<script type="text/javascript" src="/js/temp/jquery.fancybox-1.3.4.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="/css/temp/jquery.fancybox-1.3.4.css" />
	<script src="/js/custom/formLayer.js"></script>
</body>
</html>
