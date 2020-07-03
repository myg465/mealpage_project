<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css for admin page --%>
	<link rel="stylesheet" href="/css/custom/admin.css">
	<%-- custom css for order_detail board --%>
	<link rel="stylesheet" href="/css/custom/payment.css">
	<script src="/js/custom/nonmemberOrderAdmin.js"></script>
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox" >
			<%@ include file="order_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(2,0);</script>
			<h1 style="text-align:left; font-size: 30px; padding-bottom: 18px;">주문관리</h1>
			<div id="contents-long">
				<div id="mypage" style="position: relative; top: -20px;">
					<!-- Btn Area -->
					<div class="btnArea">
						<div class="bRight">
							<ul>
								<c:if test="${payment.status == '입금대기'}">
									<li><a href="#" class="nbtnbig mw" onclick="depositOk('${orderList[0].orderNumber}')">입금확인</a></li>
								</c:if>
									<li id="deliAll"><a href="#" onclick="popup('/admin/order/nonmember/deliAll/${orderList[0].orderNumber}')" class="nbtnbig mw">일괄배송처리</a></li>
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
										<td>${payment.method }</td>
										<td>
											${payment.detail }
										</td>
										<td class="tnone">
											<fmt:formatNumber type="number" maxFractionDigits="3" value="${payment.amountFinal}" /> 원
										</td>
										<td class="tnone">${payment.ordererName}</td>
										<td>
											${payment.status}
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
									<input type="hidden" name="status" class="status" value="${order.status }">
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
												<c:when test="${order.status == '입금대기'}">
													<span class="lightgray">${order.status}</span>
												</c:when>
												<c:when test="${order.status == '배송준비중'}">
													<span class="orange">${order.status}</span>
													<ul class="state">	
														<li><a href="#" onclick="popup('/admin/order/nonmember/deliOne/${order.seqKey}')" class="reviewbtn">배송처리</a></li>
													</ul>
												</c:when>
												<c:when test="${order.status == '배송중'}">
													<span class="orange">${order.status}</span>									
												</c:when>
												<c:when test="${order.status == '취소신청' or order.status == '반품신청' or order.status == '환불신청' or order.status == '교환신청'}">
													<span class="heavygray">${order.status}</span>
													<ul class="state">	
														<li>
															<a href="#" onclick="popup('/admin/order/nonmember/reasonView/${order.seqKey }')" class="reviewbtn">
																사유보기
															</a>
														</li>
														<li>
															<a href="#" onclick="returnApproval('${order.seqKey}','${fn:substring(order.status,0,2)}')" class="reviewbtn">
																<c:out value="${fn:substring(order.status,0,2)}"/>승인
															</a>
														</li>
														<li>
															<a href="#" onclick="popup('/admin/order/nonmember/rejectView/${order.seqKey}/${fn:substring(order.status,0,2)}')" class="reviewbtn">
																<c:out value="${fn:substring(order.status,0,2)}"/>거부
															</a>
														</li>
													</ul>
												</c:when>
												<c:when test="${order.status == '취소승인' or order.status == '반품승인' or order.status == '환불승인'}">
													<span class="heavygray">${order.status}</span>
													<ul class="state">	
														<li>
															<a href="#" onclick="popup('/admin/order/nonmember/reasonView/${order.seqKey }')" class="reviewbtn">
																사유보기
															</a>
														</li>
															<li>
																<a href="#" 
																onclick="returnSubmit('${order.seqKey}','${fn:substring(order.status,0,2)}','${order.productKey}','${order.productPrice}','${order.quantity}')" 
																class="reviewbtn">완료처리
															</a>
														</li>
													</ul>
												</c:when>
												<c:when test="${order.status == '교환승인'}">
													<span class="heavygray">${order.status}</span>
													<ul class="state">
														<li>
															<a href="#" onclick="popup('/admin/order/nonmember/reasonView/${order.seqKey }')" class="reviewbtn">
																사유보기
															</a>
														</li>	
														<li>
															<a href="#" onclick="popup('/admin/order/nonmember/exchangeDeliView/${order.seqKey}/${fn:substring(order.status,0,2)}')" class="reviewbtn">교환발송</a>
														</li>
													</ul>
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
									<td>${payment.ordererName}</td>
									<th scope="row"><span>이메일</span></th>
									<td>${payment.ordererEmail}</td>
								</tr>

								<tr>
									<th scope="row"><span>주소</span></th>
									<td>
										<c:if test="${payment.ordererAddressNew==null }">
											${payment.ordererAddressOld}
										</c:if>
										<c:if test="${payment.ordererAddressNew!=null }">
											${payment.ordererAddressNew}
										</c:if>
										<br/>
										${payment.ordererAddressDetail}
									</td>
									<th scope="row"><span>휴대폰 <u>번호</u></span></th>
									<td>${payment.ordererPhone.substring(0,3)}-${payment.ordererPhone.substring(3,7)}-${payment.ordererPhone.substring(7,11)}</td>
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
									<td colspan="3">${payment.recipientName}</td>
								</tr>

								<tr>
									<th scope="row"><span>주소</span></th>
									<td>
										<c:if test="${payment.recipientAddressNew==null }">
											${payment.ordererAddressOld}
										</c:if>
										<c:if test="${payment.recipientAddressNew!=null }">
											${payment.recipientAddressNew}
										</c:if>
										<br/>
										${payment.recipientAddressDetail}
									</td>
									<th scope="row"><span>휴대폰 <u>번호</u></span></th>
									<td>${payment.recipientPhone.substring(0,3)}-${payment.recipientPhone.substring(3,7)}-${payment.recipientPhone.substring(7,11)}</td>
								</tr>

								<tr>
									<th scope="row"><span>배송시 <u>요구사항</u></span></th>
									<td colspan="3">${payment.recipientRequest}</td>
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
							<col width="17%" class="tw20" />
							</colgroup>
							<tbody>
								<tr>
									<th><span>총 주문<u>금액</u></span></th>
									<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${payment.amountTotal}" /> 원</td>
								</tr>

								<tr>
									<th><span>배송비</span></th>
									<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${payment.amountDelivery}" /> 원 (선불)</td>
								</tr>

								<tr>
									<th><span>총 결제<u>금액</u></span></th>
									<td colspan="3"><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${payment.amountFinal}" /> 원</strong></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- //결제금액 확인 -->

					<!-- Btn Area -->
					<div class="btnArea2">
						<a href="/admin/order/nonmember"  class="nbtnbig iw0140">확인</a>
					</div>
					<!-- //Btn Area -->

				</div>
			</div>

		</div>
	</main>
	<script type="text/javascript">
	 function popup(url_){
            var url = url_;
             option;
            var name = "popup test";
            var	option = "width = 500, height = 400, top = 0, left = 400, location = no, toolbars = no, status = no ";
            window.open(url, name, option);
        }
	</script>
	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
