<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
						<li class="last">로그인</li>
					</ol>
				</div>
				
				<div id="outbox">		
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(1,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="member">
							<h2><strong>로그인</strong><span>로그인 후 주문하시면 다양한 혜택을 받으실 수 있습니다.</span></h2>
							<h3>회원 로그인</h3>

							<div class="informbox">
								<div class="inform">
									<ul>
										<li><input type="text" class="loginType" onfocus="this.className='mfocus'" onblur="if (this.value.length==0) {this.className='loginType'} else {this.className='mfocusnot'}" style="ime-mode:inactive;" name="id" placeholder="아이디 (5~20자)" value="${id}" minlength=5 maxlength=20 required></li>
										<li><input type="password" class="passType" onfocus="this.className='mfocus'" onblur="if (this.value.length==0) {this.className='passType'} else {this.className='mfocusnot'}" style="ime-mode:inactive;" name="password" placeholder="비밀번호 (8~20자)" minlength=8 maxlength=20 required></li>
									</ul>

									<div class="btn"><button type="button" id="loginButton" class="sbtn no-outline" style="cursor: pointer;">로그인</button></div>

									<c:choose>
										<c:when test="${id != null}">
											<div class="chk"><input type="checkbox" id="idsave" checked><label for="idsave">아이디 저장</label></div>
										</c:when>
										<c:otherwise>
											<div class="chk"><input type="checkbox" id="idsave"><label for="idsave">아이디 저장</label></div>
										</c:otherwise>
									</c:choose>

									<div class="point">
										<p>아이디와 비밀번호를 잊으셨나요?</p>
										<a href="/account/search" class="nbtn">아이디/비밀번호 찾기</a>
									</div>
								</div>
							</div>

							<h3>비회원 주문 조회</h3>

							<div class="informbox">
								<div class="inform">
									<ul>
										<li><input type="text" class="ordererType" onfocus="this.className='mfocus'" onblur="if (this.value.length==0) {this.className='ordererType'} else {this.className='mfocusnot'}" name="orderName"></li>
										<li><input type="text" class="ordernumType" onfocus="this.className='mfocus'" onblur="if (this.value.length==0) {this.className='ordernumType'} else {this.className='mfocusnot'}" name="orderNumber"></li>
									</ul>

									<div class="btn"><button type="button" class="gbtn no-outline" id="orderCheckButton" style="cursor: pointer;">조회하기</button></div>
									<div class="point">
										<p>아직 밀페이지 회원이 아니신가요? <span>회원가입하시고 다양한 혜택을 받으세요.</span></p>
										<a href="/account/signup" class="nbtn">회원가입</a>
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
	<script src="/js/custom/login.js"></script>
</body>
</html>
