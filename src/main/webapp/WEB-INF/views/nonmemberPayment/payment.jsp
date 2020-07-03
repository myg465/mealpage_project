<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
					<form action="/nonmember/payment" name="nonPayForm" method="post" onsubmit="return nonPayCheck()">
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
											<c:forEach var="item" items="${productList}" varStatus="status">
											<input type="hidden" name="length">
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
													<td id="tot_${status.index }"><fmt:formatNumber value="${item.price * quantity[status.index]}" type="currency" pattern="#,###,### 원" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<div class="poroductTotal">
									<ul>	
										<li>
											상품 합계금액 <strong><span class="stot"></span></strong>
										</li>
										<li>
											+ 배송비 <strong><span class="del_price"></span></strong>
										</li>
										<li>= 총 합계 <strong><span class="tot"></span></strong></li>
									</ul>
								</div>
								<!-- //주문 상품 -->
								
								<!-- 주문자 주소 입력 -->
								<h3 class="diviLeft h3-fix">주문자 주소 입력</h3>
								<div class="diviRight div-fix">
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
												<td><input type="text" class="w134" name="name" required/></td>
											</tr>

											<tr>
												<th scope="row"><span>주소</span></th>
												<td>
													<ul class="pta">
														<li>
															<input type="text" class="w134" name="zipcode" id="zipcode" placeholder="우편번호" readonly required>&nbsp;
														</li>
														<li><input type="button" class="nbtnMini no-outline" onclick="daumPostcode()" value="우편번호 찾기" style="width: 102px;" readonly></li>
														<li class="pt5">
															<input type="text" class="addressType" name="roadAddress" id="roadAddress" placeholder="도로명주소" style="width: 235px;" readonly>
															<input type="text" class="addressType" name="jibunAddress" id="jibunAddress" placeholder="지번주소" style="width: 235px;" readonly>
														</li>
														<li class="pt5">
															<input type="text" class="addressType" name="detailAddress" id="detailAddress" placeholder="상세주소" style="width: 360px;" required>
															<input type="text" class="addressType" name="extraAddress" id="extraAddress" placeholder="참고항목" style="width: 110px;" readonly>	
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
															<input type="email" class="w134" name="email" required>
														</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>휴대폰</span></th>
												<td>
													<ul id="phoneInputArea" class="pta">
														<li><input type="text" class="w134" name="phone" maxlength="11"></li>
														<li class="cb"><span class="mvalign">' - '제외한 10~11자리로 입력해주세요.</span></li>
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
									<label for="infosame">주문자와 동일</label>
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
												<td><input type="text" class="w134" name="destName" required></td>
											</tr>

											<tr>
												<th scope="row"><span>주소</span></th>
												<td>
													<ul class="pta">
														<li>
															<input type="text" class="w134" name="destZipcode" id="destZipcode" placeholder="우편번호" readonly required>&nbsp;
														</li>
														<li><input type="button" class="nbtnMini no-outline" onclick="destPostcode()" value="우편번호 찾기" style="width: 102px;" readonly></li>
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
														<li><input type="text" class="w134" name="destPhone" required></li>
														<li class="cb"><span class="mvalign">' - '제외한 10~11자리로 입력해주세요.</span></li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>배송시 <u>요구사항</u></span></th>
												<td><textarea name="destRequest" class="demandtta"></textarea></td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- //수취자 주소 입력 -->

								<input type="hidden" name="totalPrice" value="" >
								<input type="hidden" name="deliveryFee" value="" >
								<input type="hidden" name="finalAmount" value="" hidden>

								<!-- 총 주문금액 -->
								<div class="amount">
									<h4 class="member">총 주문금액</h4>
									<ul class="info">
										<li>
											<span class="title">상품 합계금액</span>
											<span class="won"><strong><span class="stot"></span></strong></span>
										</li>
										<li>
											<span class="title">배송비</span>
											<span class="won" ><strong><span class="del_price"></span></strong></span>
										</li>
									</ul>

									<ul class="total">
										<li class="txt"><strong>결제 예정 금액</strong></li>
										<li class="money"><span class="tot"></span></li>
										<span id="orderInput"></span>
									</ul>
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
											<li><a href="/cart" class="nbtnbig iw0140">뒤로가기</a></li>
											<li><button type="submit" class="sbtnMini iw0140 no-outline" style="cursor: pointer;">주문 / 결제</button></a></li>								
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

	<%-- custom js --%>
	<script src="/js/custom/nonmemberPayment.js"></script>

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
