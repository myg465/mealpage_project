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
						<li class="last">회원약관</li>
					</ol>
				</div>
				
				<div id="outbox">
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(4,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="member">
							<h2><strong>회원약관</strong><span>밀페이지의 회원약관을 확인하실 수 있습니다.</span></h2>
							
							<div class="agreeWrap">
								<div class="agreeTxt">이용약관</div>
								<div class="agreeBox" style="height: auto !important;">
									<div class="agreeContent">
										<%@ include file="signup_terms_1.jsp" %>
									</div>
								</div>
							</div>

							<a name="privacy"></a>
							<div class="agreeWrap">
								<div class="agreeTxt">개인정보 수집, 이용 동의</div>
								<div class="agreeBox" style="height: auto !important;">
									<div class="agreeContent">
										<%@ include file="signup_terms_2.jsp" %>
									</div>
								</div>
							</div>

							<div class="agreeWrap">
								<div class="agreeTxt">개인정보 취급위탁 동의</div>
								<div class="agreeBox" style="height: auto !important;">
									<div class="agreeContent">
										<%@ include file="signup_terms_3.jsp" %>
									</div>
								</div>
							</div>
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
