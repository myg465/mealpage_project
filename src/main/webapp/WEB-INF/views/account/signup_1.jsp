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
								<div class="step stepon">
									<p class="web">STEP 01</p>
									<p class="txt">약관 동의</p>							
									<p class="ck"><img src="/img/temp/bg/bg_step.png" alt="현재위치" /></p>
								</div>

								<div class="step">
									<p class="web">STEP 02</p>
									<p class="txt">휴대폰/이메일 인증</p>
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
								

							<div class="attention">
								<ul>
									<li>* 회원가입을 위하여 아래의 내용을 읽고 동의해 주세요.</li>
									<li>* 아래 내용이 변동되는 경우에는 별도 공지 없이 홈페이지의 공지사항을 통해 알려드립니다.</li>
								</ul>
							</div>

							<form action="/account/signup" id="form" method="post">
								<div class="agreeWrap">
									<div class="agreeTxt">이용약관 동의 <span>(필수동의)</span></div>
									<div class="agreeBox">
										<div class="agreeContent">
											<%@ include file="signup_terms_1.jsp" %>
										</div>
									</div>

									<ul>
										<li class="chk">
											<input type="checkbox" id="agree1" /><label for="agree1">이용약관에 동의합니다.</label>
										</li>
										<li class="btn">
											<a href="#" class="nbtnMini">전체보기</a>
										</li>
									</ul>
								</div>

								<div class="agreeWrap">
									<div class="agreeTxt">개인정보 수집, 이용 동의 <span>(필수동의)</span></div>
									<div class="agreeBox">
										<div class="agreeContent">
											<%@ include file="signup_terms_2.jsp" %>
										</div>
									</div>

									<ul>
										<li class="chk">
											<input type="checkbox" id="agree2" /><label for="agree2">개인정보 보호를 위한 이용자 <span>동의사항에 동의합니다.</span></label>
										</li>
										<li class="btn">
											<a href="#" class="nbtnMini">전체보기</a>
										</li>
									</ul>
								</div>

								<div class="agreeWrap">
									<div class="agreeTxt">개인정보 취급위탁 동의 <span>(필수동의)</span></div>
									<div class="agreeBox">
										<div class="agreeContent">
											<%@ include file="signup_terms_3.jsp" %>
										</div>
									</div>

									<ul class="fn">
										<li class="chk">
											<input type="checkbox" id="agree3" /><label for="agree3">개인정보 보호를 위한 이용자 <span>동의사항에 동의합니다.</span></label>
										</li>
										<li class="btn">
											<a href="#" class="nbtnMini">전체보기</a>
										</li>
									</ul>
								</div>

								<div class="btnArea">
									<div class="bCenter">
										<ul>
											<li><a href="/" class="nbtnbig">취소하기</a></li>
											<li><button type="button" onclick="checkAgreement()" class="sbtnMini no-outline">가입하기</button></li>
										</ul>
									</div>
								</div>
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

	<%-- custom js --%>
	<script src="/js/custom/signup.js"></script>
</body>
</html>
