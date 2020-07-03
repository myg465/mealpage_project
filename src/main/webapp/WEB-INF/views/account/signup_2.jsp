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

								<div class="step stepon">
									<p class="web">STEP 02</p>
									<p class="txt">휴대폰/이메일 인증</p>
									<p class="ck"><img src="/img/temp/bg/bg_step.png" alt="현재위치" /></p>
								</div>

								<div class="step">
									<p class="web">STEP 03</p>
									<p class="txt"><span>회원정보</span> <span>입력</span></p>
								</div>

								<div class="step">
									<p class="web">STEP 04</p>
									<p class="txt"><span>회원가입</span> <span>완료</span></p>
								</div>
							</div>
							<!-- //STEP -->

							<h3>인증코드 전송</h3>

							<div class="alertBox">
								<ul>
									<li>회원님의 휴대폰 및 이메일을 인증하는 절차입니다.</li>
									<li>휴대폰 번호 및 이메일 주소 입력 후 전송 버튼을 클릭해주세요.</li>
								</ul>
							</div>

							<div class="informbox">
								<div id="phoneInputArea" class="inform">
									<ul>
										<li><input type="number" class="input-box" name="phone" placeholder="휴대폰 번호 (숫자만 입력)" /></li>
										<li><input type="email" class="input-box" name="email" placeholder="이메일 주소" /></li>
									</ul>

									<div class="btn"><button type="button" id="sendButton1" class="gbtn no-outline">전송</button></div>
								</div>
							</div>

							<h3>인증번호 입력</h3>

							<div class="alertBox">
								<ul>
									<li>휴대폰 및 이메일로 전송된 번호를 입력 후 인증 버튼을 클릭해주세요.</li>
								</ul>
							</div>

							<div class="informbox">
								<div class="inform">
									<ul>
										<li><input type="number" class="input-box" name="phoneCode" placeholder="휴대폰 인증코드" /></li>
										<li><input type="email" class="input-box" name="emailCode" placeholder="이메일 인증코드" /></li>
									</ul>

									<div class="btn"><button type="button" id="sendButton2" class="gbtn no-outline">인증</button></div>
								</div>
							</div>

`							<p class="alert">밀페이지 온라인 쇼핑몰에서는 2012년 8월 18일로 시행되는 정보통신망 이용 촉진 및 정보 보호 등에 관한 법률 “주민등록번호의 <span>사용 제한”과 관련하여 주민등록번호를 수집하지 않습니다.</span></p>

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
	<script src="/js/custom/signup.js"></script>
</body>
</html>
