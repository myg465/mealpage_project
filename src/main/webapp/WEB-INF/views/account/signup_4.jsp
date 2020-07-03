<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
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
									<p class="txt">실명확인</p>							
								</div>

								<div class="step">
									<p class="web">STEP 02</p>
									<p class="txt">약관 동의</p>
								</div>

								<div class="step">
									<p class="web">STEP 03</p>
									<p class="txt"><span>회원정보</span> <span>입력</span></p>
								</div>

								<div class="step stepon">
									<p class="web">STEP 04</p>
									<p class="txt"><span>회원가입</span> <span>완료</span></p>
									<p class="ck"><img src="/img/temp/bg/bg_step.png" alt="현재위치" /></p>
								</div>
							</div>
							<!-- //STEP -->
							
							<div class="celebrate">	
								<p class="thx">감사합니다. <span>회원가입이 완료되었습니다.</span></p>
								<p class="txt">
									저희 가족이 되어주셔서 감사합니다.<br/>
									가입 시 입력하신 이메일로 가입 완료 메일이 전송되었습니다.<br/>
									언제나 고객님께 즐겁고 소중한 시간이 되도록 최선을 다 하겠습니다.<br/><br/>
									가입 시 입력하신 정보는 마이페이지에서 수정하실 수 있습니다.
								</p>
							</div>

							<!-- Btn Area -->
							<div class="btnArea">
								<div class="bCenter">
									<ul>
										<li><a href="/" class="nbtnbig">메인으로</a></li>
										<li><a href="/account/login" class="sbtnMini">로그인</a></li>
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
</body>
</html>
