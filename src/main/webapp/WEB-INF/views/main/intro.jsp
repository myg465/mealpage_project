<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="../common/head.jsp" %>
  <%-- custom csss --%>
  <link rel="stylesheet" href="/css/custom/error.css">
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<div id="allwrap">
		<div id="wrap">
			<%@ include file="../common/header.jsp" %>
			<%@ include file="../common/nav.jsp" %>

			<!-- container -->
			<div id="container">
        <h1>밀페이지 소개</h1>
        <hr>
				<div id="member">
					<div class="agreeWrap">
						<div class="agreeTxt">이 사이트에 대하여</div>
						<div class="agreeBox" style="position: relative; left: 150px; width: 600px; height: auto !important;">
							<div class="agreeContent" style="font-size: 13px;">
								이 웹사이트는 한국아이티인재개발원 1강의실 4팀의 협동 프로젝트로 만들어졌으며,<br>
								실제로 상품을 판매하는 쇼핑몰이 아닙니다.<br>
								<br>
								(미래식사 애용자로서, 각 브랜드의 미래식품을<br>
								통합 유통/판매하는 쇼핑몰을 컨셉으로 잡아 제작하였습니다.)<br>
								<br><br>
								해당 사이트에 진열된 상품에 대해 관심이 있으신 분은<br>
								아래의 공식 사이트에서 구매하실 수 있습니다.<br>
								<br>
								[인테이크] <a href="https://href.li/?https://www.shopintake.com/">https://www.shopintake.com/</a><br>
								[휴얼] <a href="https://href.li/?https://uk.huel.com/">https://uk.huel.com/</a><br>
								[컴프] <a href="https://href.li/?http://www.comp.jp/">http://www.comp.jp/</a><br>
								[소일렌트] <a href="https://href.li/?https://soylent.com/">https://soylent.com/</a><br>
								<br><br>
								이 사이트는 상기 공식 사이트의 상품, 이벤트 이미지 등을 차용하고 있습니다.
							</div>
						</div>
					</div>

					<div class="agreeWrap">
						<div class="agreeTxt">공식 사이트 관계자 분께</div>
						<div class="agreeBox" style="position: relative; left: 150px; width: 600px; height: auto !important;">
							<div class="agreeContent" style="font-size: 13px;">
								저희 컨셉 사이트를 통해 원내 학생들 및 저희 포트폴리오를 보게 될 분들에게<br>
								미래식사 및 관련 브랜드를 홍보하는 효과가 있다고 생각합니다.<br>
								<br>
								(블로거들이 블로그에 홍보용으로 공식 이미지를 올리는 것처럼<br>
								좋게 봐주시면 감사하겠습니다. ^^;)<br>
								<br><br>
								혹시 공식 사이트 관계자 분께서 자사 제품 표시, 이미지 차용 등에 대하여 불편을 느끼신다면<br>
								<a href="mailto:mail@lang.kr">mail@lang.kr</a> 로 연락주시면 즉시 대응토록 하겠습니다.
							</div>
						</div>
					</div>
				</div>

        <br><br><br><br>
        <a href="/" class="sbtn">확인</a>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>

	<%-- custom js --%>
	<script src="/js/custom/login.js"></script>
</body>
</html>
