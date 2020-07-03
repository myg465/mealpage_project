<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<link rel="stylesheet" href="/css/custom/login.css">
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
						<li class="last">아이디/비밀번호 찾기</li>
					</ol>
				</div>
				
				<div id="outbox">		
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(3,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="member">
							<h2><strong>아이디/비밀번호 찾기</strong><span>회원님께서 가입하신 아이디와 비밀번호를 찾아드립니다.</span></h2>
							<h3>아이디 찾기</h3>
							<div class="informbox">
								<div class="inform">
									<ul>
										<li><input type="text" class="nameType" onfocus="this.className='mfocus'" onblur="if (this.value.length==0) {this.className='nameType'} else {this.className='mfocusnot'}" style="ime-mode:inactive;" name="name" placeholder="이름"></li>
										<li><input type="email" class="emailType" onfocus="this.className='mfocus'" onblur="if (this.value.length==0) {this.className='emailType'} else {this.className='mfocusnot'}" style="ime-mode:inactive;" name="email" placeholder="이메일"></li>
									</ul>

									<div class="btn"><button type="button" id="idSearchButton" class="gbtn no-outline" style="cursor: pointer;">아이디 찾기</button></div>
								</div>
							</div>

							<h3>비밀번호 찾기</h3>
							<div class="informbox">
								<div class="inform">
									<ul>
										<li><input type="text" class="loginType" onfocus="this.className='mfocus'" onblur="if (this.value.length==0) {this.className='loginType'} else {this.className='mfocusnot'}" name="id" placeholder="아이디 (5~20자)"></li>
										<li><input type="text" class="emailType" onfocus="this.className='mfocus'" onblur="if (this.value.length==0) {this.className='emailType'} else {this.className='mfocusnot'}" name="email2" placeholder="이메일"></li>
									</ul>

									<div class="btn"><button type="button" id="pwSearchButton" class="gbtn no-outline" style="cursor: pointer;">비밀번호 찾기</button></div>
								</div>
							</div>

							<p class="alert">밀페이지 온라인 쇼핑몰에서는 2012년 8월 18일로 시행되는 정보통신망 이용 촉진 및 정보 보호 등에 관한 법률 “주민등록번호의 <span>사용 제한”과 관련하여 주민등록번호를 수집하지 않습니다.</span></p>

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
	<script src="/js/custom/accountSearch.js"></script>
</body>
</html>