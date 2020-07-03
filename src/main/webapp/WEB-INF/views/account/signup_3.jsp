<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css --%>
	<link rel="stylesheet" href="/css/custom/signup.css">
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
						<li><a href="/account/login">MEMBERSHIP</a></li>
						<li class="last">회원가입</li>
					</ol>
				</div>
				
				<div id="outbox">
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(2,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="member">
							<h2><strong>회원가입</strong><span>회원으로 가입하시면 보다 더 다양한 혜택을 누리실 수 있습니다.</span></h2>
							
							<!-- STEP -->
							<div class="stepWrap">
								<div class="step">
									<p class="web">STEP 01</p>
									<p class="txt">약관 동의</p>
								</div>

								<div class="step">
									<p class="web">STEP 02</p>
									<p class="txt">휴대폰/이메일 인증</p>
								</div>

								<div class="step stepon">
									<p class="web">STEP 03</p>
									<p class="txt"><span>회원정보</span> <span>입력</span></p>
									<p class="ck"><img src="/img/temp/bg/bg_step.png" alt="현재위치" /></p>
								</div>

								<div class="step">
									<p class="web">STEP 04</p>
									<p class="txt"><span>회원가입</span> <span>완료</span></p>
								</div>
							</div>
							<!-- //STEP -->

							<div class="attention">
								<ul> 
									<li>* 회원가입 완료를 위해 아래 필수항목을 기입해주세요.</li>
								</ul>
							</div>

							<form action="/account/signup/detail" name="form" method="post" onsubmit="return checkSignup()">
								<div class="memberbd">
									<table class="memberWrite" border="1" cellspacing="0">
										<caption>회원가입 입력</caption>
										<colgroup>
											<col width="22%" class="tw30" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><span>이름</span></th>
												<td><input type="text" class="w134" name="name" required></td>
											</tr>
											<tr>
												<th scope="row"><span>아이디</span></th>
												<td>
													<ul id="idInputArea" class="pta">
														<li class="r10"><input type="text" class="w134" name="id" minlength=5 maxlength=20 required></li>
														<li><button type="button" id="sendButton3" class="nbtnMini no-outline" style="cursor: pointer;">중복확인</button></li>
														<li class="pt5"><span class="mvalign">5~20자의 영문 소문자, 숫자만 사용 가능합니다.</span></li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>비밀번호</span></th>
												<td>
													<ul class="pta">
														<li class="r10"><input type="password" class="w134" name="password" minlength=8 maxlength=20 required></li>
														<li><span class="mvalign"> 영문 / 숫자 / 특수문자 중 2가지 이상의 조합으로 8~20자까지 가능합니다.</span></li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>비밀번호 확인</span></th>
												<td>
													<ul class="pta">
														<li class="r10"><input type="password" class="w134" name="passwordCheck" minlength=8 maxlength=20 required></li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>이메일</span></th>
												<td>
													<ul class="pta">
														<li>${email}</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>이벤트 메일 수신</span></th>
												<td>
													<p>밀페이지에서 진행되는 이벤트와 쇼핑에 대한 정보를 이메일로 받아보시겠습니까?</p>
													<ul class="question">
														<li style="padding-bottom: 0px;">
															<input type="radio" name="receive" id="receive_yes" class="radio_t" checked="checked" value="Y"><label for="receive_yes">예</label>
														</li>
														<li style="padding-bottom: 0px;">
															<input type="radio" name="receive" id="receive_no" class="radio_t" value="N"><label for="receive_no">아니오</label>
														</li>
													</ul>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>주소</span></th>
												<td>
													<ul class="pta">
														<li>
															<input type="text" class="w134" name="zipcode" id="zipcode" placeholder="우편번호" readonly>&nbsp;
														</li>
														<li><input type="button" class="nbtnMini no-outline" onclick="daumPostcode()" value="우편번호 찾기" style="width: 102px; cursor: pointer;" readonly></li>
														<li class="pt5">
															<input type="text" class="addressType" name="roadAddress" id="roadAddress" placeholder="도로명주소" style="width: 235px;" readonly>
															<input type="text" class="addressType" name="jibunAddress" id="jibunAddress" placeholder="지번주소" style="width: 235px;" readonly>
														</li>
														<li class="pt5">
															<input type="text" class="addressType" name="detailAddress" id="detailAddress" placeholder="상세주소" maxlength=255 style="width: 360px;"  required>
															<input type="text" class="addressType" name="extraAddress" id="extraAddress" placeholder="참고항목" style="width: 110px;" readonly>	
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
													<ul class="pta">
														${phone.substring(0,3)}-${phone.substring(3,7)}-${phone.substring(7,11)}
													</ul>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
		
								<!-- Btn Area -->
								<div class="btnArea">
									<div class="bCenter">
										<ul>
											<li><button type="reset" class="nbtnbig no-outline">취소하기</button></li>
											<li><button type="submit" class="sbtnMini no-outline">가입하기</button></li>
										</ul>
									</div>
								</div>
								<!-- //Btn Area -->
							</form>

						</div>
					</div>
					<!-- //contents -->

				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>

	<script src="/js/custom/signup.js"></script>

	<%-- 다음 우편번호 API 시작 --%>
  <div id="postcodeLayer" style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
    <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1" onclick="closeDaumPostcode()" alt="닫기 버튼">
  </div>
	<%-- custom js --%>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="/js/custom/postcode.js"></script>
	<%--  다음 우편번호 API 끝 --%>
</body>
</html>
