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
        <h1>404 Not Found</h1>
        <hr><br>
        요청하신 페이지를 찾을 수 없습니다.

        <br><br><br><br><br>
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
