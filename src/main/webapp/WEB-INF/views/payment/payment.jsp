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
					<c:choose>
						<c:when test="${wishlist == 'yes'}">
							<form action="/payment/wishlist" name="form" method="post">
						</c:when>
						<c:otherwise>
							<form action="/payment" name="form" method="post">
						</c:otherwise>
					</c:choose>
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
											<c:set var="totalPrice" value="0" />
											<c:forEach var="item" items="${orderItemList}">
												<c:set var="totalPrice" value="${totalPrice + (item.price * item.quantity)}" />
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
										<li>
											상품 합계금액 <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" /></strong> 원
										</li>
										<li>
											<c:set var="deliveryFee" value="10000" />
											+ 배송비 <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${deliveryFee}" /></strong> 원
										</li>
										<li>= 총 합계 <strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice + deliveryFee}" /></strong> 원</li>
									</ul>
								</div>
								<!-- //주문 상품 -->
								
								<!-- 주문자 주소 입력 -->
								<h3 class="diviLeft h3-fix">주문자 주소 입력</h3>
								<div class="diviRight div-fix">
									<ul >
										<li class="padding-left">이름/주소의 수정 내용을 회원정보에도 반영합니다.&nbsp;&nbsp;</li>
										<li><a class="point" onclick="updateDestination()">회원정보반영</a></li>
										<li>(이메일/휴대폰은 [마이페이지 &gt; 회원정보수정] 메뉴에서 인증 후 수정 가능합니다.)</li>
									</ul>
								</div>

								<div class="checkDiv">
									<table class="checkTable" border="1" cellspacing="0">
										<caption>주문자 주소 입력</caption>
										<colgroup>
										<col width="22%" class="tw30" />
										<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><span>이름</span></th>
												<td><input type="text" class="w134" name="name" value="${accountVo.name}" /></td>
											</tr>

											<tr>
												<th scope="row"><span>주소</span></th>
												<td>
													<ul class="pta">
														<li>
															<input type="text" class="w134" name="zipcode" id="zipcode" placeholder="우편번호" value="${accountVo.addressZipcode}" readonly>&nbsp;
														</li>
														<li><input type="button" class="nbtnMini no-outline" onclick="daumPostcode()" value="우편번호 찾기" style="width: 102px; cursor: pointer;" readonly></li>
														<li class="pt5">
															<input type="text" class="addressType" name="roadAddress" id="roadAddress" placeholder="도로명주소" value="${accountVo.addressNew}" style="width: 235px;" readonly>
															<input type="text" class="addressType" name="jibunAddress" id="jibunAddress" placeholder="지번주소" value="${accountVo.addressOld}" style="width: 235px;" readonly>
														</li>
														<li class="pt5">
															<input type="text" class="addressType" name="detailAddress" id="detailAddress" placeholder="상세주소" value="${accountVo.addressDetail}" style="width: 360px;" required>
															<input type="text" class="addressType" name="extraAddress" id="extraAddress" placeholder="참고항목" value="${accountVo.addressExtra}" style="width: 110px;" readonly>	
														</li>
														<li class="cb">
															<span class="mvalign">"우편번호 찾기" 버튼을 눌러 주소 검색 후, 상세주소를 기입해주세요.</span>
														</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>이메일</span></th>
												<td>
													<ul id="emailInputArea" class="pta">
														<li>
															<input type="email" class="w134" name="email" value="${accountVo.email}">
														</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>휴대폰</span></th>
												<td>
													<ul id="phoneInputArea" class="pta">
														<li><input type="text" class="w134" name="phone" value="${accountVo.phone}"></li>
														<li class="cb"><span class="mvalign">숫자만 11자리로 입력해주세요.</span></li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- //주문자 주소 입력 -->

								<!-- 수취자 주소 입력 -->
								<h3 class="dep">
									수취자 주소 입력
									
									<input type="checkbox" id="infosame"/>
									<label for="infosame">회원정보와 동일</label>
								</h3>
								<div class="checkDiv">
									<table class="checkTable" border="1" cellspacing="0">
										<caption>수취자 주소 입력</caption>
										<colgroup>
										<col width="22%" class="tw30" />
										<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><span>이름</span></th>
												<td><input type="text" class="w134" name="destName"></td>
											</tr>

											<tr>
												<th scope="row"><span>주소</span></th>
												<td>
													<ul class="pta">
														<li>
															<input type="text" class="w134" name="destZipcode" id="destZipcode" placeholder="우편번호" readonly>&nbsp;
														</li>
														<li><input type="button" class="nbtnMini no-outline" onclick="destPostcode()" value="우편번호 찾기" style="width: 102px; cursor: pointer;" readonly></li>
														<li class="pt5">
															<input type="text" class="addressType" name="destRoadAddress" id="destRoadAddress" placeholder="도로명주소" style="width: 235px;" readonly>
															<input type="text" class="addressType" name="destJibunAddress" id="destJibunAddress" placeholder="지번주소" style="width: 235px;" readonly>
														</li>
														<li class="pt5">
															<input type="text" class="addressType" name="destDetailAddress" id="destDetailAddress" placeholder="상세주소" style="width: 360px;" required>
															<input type="text" class="addressType" name="destExtraAddress" id="destExtraAddress" placeholder="참고항목" style="width: 110px;" readonly>	
														</li>
														<li class="cb">
															<span class="mvalign">"우편번호 찾기" 버튼을 눌러 주소 검색 후, 상세주소를 기입해주세요.</span>
														</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>휴대폰</span></th>
												<td>
													<ul id="phoneInputArea" class="pta">
														<li><input type="text" class="w134" name="destPhone"></li>
														<li class="cb"><span class="mvalign">숫자만 11자리로 입력해주세요.</span></li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>배송시 <u>요구사항</u></span></th>
												<td><textarea name="destRequest" class="demandtta" maxlength=200></textarea></td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- //수취자 주소 입력 -->

								<input name="totalPrice" value="${totalPrice}" hidden>
								<input name="deliveryFee" value="${deliveryFee}" hidden>

								<!-- 쿠폰 및 포인트 사용 -->
								<h3 class="dep">쿠폰 및 포인트 사용</h3>
								<div class="checkDiv">
									<table class="checkTable" border="1" cellspacing="0">
										<caption>쿠폰 및 포인트 사용</caption>
										<colgroup>
										<col width="22%" class="tw30" />
										<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><span>총 주문금액</span></th>
												<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" /> 원</td>
											</tr>
											<tr>
												<th scope="row"><span>배송비</span></th>
												<td><span id="deliveryFee"><fmt:formatNumber type="number" maxFractionDigits="3" value="${deliveryFee}" /></span> 원 (직접배송 / 선불)</td>
											</tr>
											<tr>
												<th scope="row"><span>쿠폰 할인</span></th>
												<td>
													<ul class="pta">
														<c:choose>
															<c:when test="${couponList.isEmpty()}">
																<li class="r10">
																	적용 가능한 쿠폰이 없습니다.
																</li>
															</c:when>
															<c:otherwise>
																<li class="r10">
																	<select name="coupon" id="coupon">
																		<option value="none" selected>-- 쿠폰을 선택하세요 --</option>
																		<c:forEach var="coupon" items="${couponList}">
																			<c:choose>
																				<c:when test="${coupon.minimumPrice <= totalPrice}">
																					<option value="${coupon.seqKey}" discount="${coupon.discountPrice}" percent="${coupon.discountPercent}">${coupon.name}</option>
																				</c:when>
																				<c:otherwise>
																					<option value="disable">${coupon.name} (사용조건: <fmt:formatNumber type="number" maxFractionDigits="3" value="${coupon.minimumPrice}" /> 원 이상 주문)</option>
																				</c:otherwise>
																			</c:choose>
																		</c:forEach>
																	</select>
																</li>
																<li>
																	<span id="couponArea" class="valign">
																		</span>
																</li>
															</c:otherwise>
														</c:choose>
													</ul>
												</td>
											</tr>

											<tr>
												<th scope="row"><span>포인트 사용</span></th>
												<td>
													<ul class="pta">
														<li class="r10">
															<span id="pointArea">
																<input type="number" name="usedPoint" class="w134">
															</span>
															<span class="valign"><strong>P</strong>
															</span>
														<span>
															<input type="button" class="nbtnMini no-outline point-use" onclick="usePoint()" value="사용"  style="cursor: pointer;" readonly>
														</span>
															<br>
															<input name="accountPoint" value="${accountVo.point}" hidden>
															<span class="valign">( 사용 가능 포인트 : </span>
															<span class="orange">
																<fmt:formatNumber type="number" maxFractionDigits="3" value="${accountVo.point}" />
															</span>
															<span class="valign"> Point)</span>															
														</li>
													</ul>
												</td>
											</tr>

											<tr>
												<th scope="row"><span>총 결제금액</span></th>
												<td>
													<ul class="pta">
														<li><span class="valign"><strong id="finalAmount"></strong> (= 총주문금액 <span id="totalPriceAmount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" /></span>원 + 배송비 <span id="deliveryFeeAmount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${deliveryFee}" /></span>원<span id="couponDiscountAmount"></span><span id="usedPointAmount"></span>)</li>
													</ul>
												</td>
											</tr>

										</tbody>
									</table>
								</div>
								<!-- //쿠폰 및 포인트 사용 -->

								<!-- 총 주문금액 -->
								<div class="amount">
									<h4 class="member">총 주문금액</h4>
									<ul class="info">
										<li>
											<span class="title">상품 합계금액</span>
											<span class="won"><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalPrice}" /></strong> 원</span>
										</li>
										<li>
											<span class="title">배송비</span>
											<span class="won" ><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${deliveryFee}" /></strong> 원</span>
										</li>
										<li>
											<span class="title">쿠폰 할인</span>
											<span class="won"><strong id="orderCouponAmount"></strong> 원</span>
										</li>
										<li>
											<span class="title">포인트 할인</span>
											<span class="won"><strong id="orderPointAmount"></strong> P</span>
										</li>
									</ul>

									<ul class="total">
										<li class="mileage">(적립 포인트 <strong id="totalPoint"></strong> Point) </li>

										<li class="txt"><strong>결제 예정 금액</strong></li>
										<li class="money"><span id="orderAmount"></span> 원</li>
										<span id="orderInput"></span>
									</ul>
									<div style="position: relative; top: 25px; left: 495px;">* 쿠폰/포인트로 할인받은 금액에 대해서는 포인트가 적립되지 않습니다.</div>
								</div>

								<!-- //총 주문금액 -->

								<!-- 결제수단 선택 -->
								<h3 class="dep">결제수단 선택</h3>
								<div class="checkDiv">
									<table border="1" class="checkTable" cellspacing="0">
										<caption>결제수단 선택</caption>
										<colgroup>
										<col width="22%" class="tw30" />
										<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><span>결제수단</span></th>
												<td>
													<ul class="pta">
														<li>
															<input type="radio" id="method" name="method" value="무통장 입금" checked><label for="method">무통장 입금 (계좌이체)</label>
														</li>
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div>

								<!-- //결제수단 선택 -->
								<div class="method">
									<p class="orderalert"><strong>[무통장 입금]</strong> 쇼핑몰의 대표 계좌로 구매대금을 직접 송금합니다. (계좌이체 가능)</p>

									<div class="checkDiv">
										<table class="checkTable" border="1" cellspacing="0">
											<caption>결제수단 선택</caption>
											<colgroup>
											<col width="22%" class="tw30" />
											<col width="*" />
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><span>은행명</span></th>
													<td>카카오뱅크</td>
												</tr>
												<tr>
													<th scope="row"><span>계좌번호</span></th>
													<td>3333-16-4743882</td>
												</tr>
												<tr>
													<th scope="row"><span>예금주</span></th>
													<td>김우혁</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>

								<!-- Btn Area -->
								<div class="btnArea">
									<div class="orderCenter">
										<ul>
											<li><a href="/cart" class="nbtnbig iw0140 point">뒤로가기</a></li>
											<li><button type="button" class="sbtnMini iw0140 no-outline point" onclick="submitOrder()">주문 / 결제</a></li>								
										</ul>
									</div>
								</div>
								<!-- //Btn Area -->
							
							</div>
						</div>
					</form>
				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>

  <div id="layer">
		주문을 처리하고 있습니다.
  </div>

	<%-- custom js --%>
	<script src="/js/custom/payment.js"></script>

	<%-- 다음 우편번호 API 시작 --%>
  <div id="postcodeLayer" style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
    <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1" onclick="closeDaumPostcode()" alt="닫기 버튼">
  </div>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="/js/custom/postcode.js"></script>
  <script src="/js/custom/postcode_dest.js"></script>
	<%--  다음 우편번호 API 끝 --%>
</body>
</html>
