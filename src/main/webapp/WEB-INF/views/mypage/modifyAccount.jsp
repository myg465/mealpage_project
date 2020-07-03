<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css --%>
	<link rel="stylesheet" href="/css/custom/modifyAccount.css">
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
						<li class="last">회원정보 수정</li>
					</ol>
				</div>
				
				<div id="outbox">
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(8,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2><strong>회원정보 수정</strong><span>회원님의 개인 정보를 수정하실 수 있습니다.</span></h2>
							
							<%@ include file="myinfo.jsp" %>

							<div class="attention">
								<ul>
									<li>* 원하는 내용을 수정 후 "수정하기" 버튼을 눌러주세요.</li>
									<li>* 이메일, 휴대폰은 수정 시 인증번호 전송 및 입력이 필요합니다.</li>
								</ul>
							</div>

							<div class="memberbd">
								<input type="number" name="authKey" value=${accountVo.authKey} hidden>
								<input type="email" class="w134" name="originalEmail" value="${accountVo.email}" hidden>
								<input type="text" class="w134" name="originalPhone" value="${accountVo.phone}" hidden>

								<table class="memberWrite" border="1" cellspacing="0">
									<caption>회원정보 수정</caption>
									<colgroup>
									<col width="22%" class="tw30" />
									<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><span>이름</span></th>
											<td><input type="text" class="w134" name="name" value="${accountVo.name}" required></td>
										</tr>
										<tr>
											<th scope="row"><span>아이디</span></th>
											<td>${accountVo.id}</td>
										</tr>
										<tr>
											<th scope="row"><span>기존 비밀번호</span></th>
											<td>
												<ul class="pta">
													<li class="r10"><input type="password" class="w134" name="currentPw" minlength=8 maxlength=20 required></li>
													<li class="cb"><span class="mvalign"> 비밀번호 변경 시 입력이 필요합니다.</span></li>
												</ul>
											</td>
										</tr>
										<tr>
											<th scope="row"><span>신규 비밀번호</span></th>
											<td>
												<ul class="pta">
													<li class="r10"><input type="password" class="w134" name="newPw" minlength=8 maxlength=20 required></li>
													<li><span class="mvalign"> 영문 / 숫자 / 특수문자 중 2가지 이상의 조합으로 8~20자까지 가능합니다.</span></li>
												</ul>
											</td>
										</tr>
										<tr>
											<th scope="row"><span>신규 비밀번호 확인</span></th>
											<td>
												<ul class="pta">
													<li class="r10"><input type="password" class="w134" name="newPwCheck" minlength=8 maxlength=20 required></li>
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
													<li>
														<button type="button" id="emailAuthButton" class="nbtnMini no-outline" style="margin-left: 4px; width: 102px;">인증번호 전송</button>
													</li>
												</ul>
											</td>
										</tr>
										<tr>
											<th scope="row"><span>이메일 인증번호</span></th>
											<td>
												<ul class="pta">
													<li><input type="number" class="w134 input-box" name="emailCode"></li>
												</ul>
											</td>
										</tr>
										<tr>
											<th scope="row"><span>이벤트 메일 수신</span></th>
											<td>
												<p>밀페이지에서 진행되는 이벤트와 쇼핑에 대한 정보를 이메일로 받아보시겠습니까?</p>
												<ul class="question">
													<c:choose>
														<c:when test="${accountVo.emailReception == 'Y'}">
															<li style="padding-bottom: 0px;">
																<input type="radio" name="receive" id="receive_yes" class="radio_t" checked="checked" value="Y"><label for="receive_yes">예</label>
															</li>
															<li style="padding-bottom: 0px;">
																<input type="radio" name="receive" id="receive_no" class="radio_t" value="N"><label for="receive_no">아니오</label>
															</li>
														</c:when>
														<c:otherwise>
															<li style="padding-bottom: 0px;">
																<input type="radio" name="receive" id="receive_yes" class="radio_t" value="Y"><label for="receive_yes">예</label>
															</li>
															<li style="padding-bottom: 0px;">
																<input type="radio" name="receive" id="receive_no" class="radio_t" checked="checked" value="N"><label for="receive_no">아니오</label>
															</li>
														</c:otherwise>
													</c:choose>
												</ul>
											</td>
										</tr>
										<tr>
											<th scope="row"><span>주소</span></th>
											<td>
												<ul class="pta">
													<li>
														<input type="text" class="w134" name="zipcode" id="zipcode" placeholder="우편번호" value="${accountVo.addressZipcode}"  readonly>&nbsp;
													</li>
													<li><input type="button" class="nbtnMini no-outline" onclick="daumPostcode()" value="우편번호 찾기" style="width: 102px;" readonly></li>
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
											<th scope="row"><span>휴대폰</span></th>
											<td>
												<ul id="phoneInputArea" class="pta">
													<li><input type="text" class="w134" name="phone" value="${accountVo.phone}"></li>
													<li>
														<button type="button" id="phoneAuthButton" class="nbtnMini no-outline" style="margin-left: 4px; width: 102px;">인증번호 전송</button>
													</li>
													<li class="cb"><span class="mvalign">숫자만 11자리로 입력해주세요.</span></li>
												</ul>
											</td>
										</tr>
										<tr>
											<th scope="row"><span>휴대폰 인증번호</span></th>
											<td>
												<ul class="pta">
													<li><input type="number" class="w134 input-box" name="phoneCode"></li>
												</ul>
											</td>
										</tr>
									</tbody>
									</table>
								</div>
								

							</div>

							<!-- Btn Area -->
							<div class="btnArea">
								<div class="bCenter">
									<ul>
										<li><button type="reset" class="nbtnbig no-outline">취소하기</a></li>
										<li><button type="button" id="modifyButton" class="sbtnMini no-outline">수정하기</a></li>
									</ul>
								</div>
							</div>
							<!-- //Btn Area -->

						</div>
					</div>
					<!-- //contents -->

				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>

	<%-- custom js --%>
	<script src="/js/custom/modifyAccount.js"></script>

	<%-- 다음 우편번호 API 시작 --%>
  <div id="postcodeLayer" style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
    <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1" onclick="closeDaumPostcode()" alt="닫기 버튼">
  </div>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="/js/custom/postcode.js"></script>
	<%--  다음 우편번호 API 끝 --%>
</body>
</html>
