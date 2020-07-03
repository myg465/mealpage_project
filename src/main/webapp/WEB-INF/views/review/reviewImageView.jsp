<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<%@ include file="../common/head.jsp" %>
</head>
<body>
	<div id="layerWrap">
		<div class="inputBody">
			<div class="inputWrap">
				<p class="close"><a onclick="parent.$.fancybox.close();" href="javascript:;"><img src="/img/temp/btn/btn_input_close.gif" alt="닫기" /></a></p>
				<img alt="" src="/files/review/${imageFileName }" class="reviewImg" style="max-width: 100%; max-height: 100%;">
			</div>
		</div>
	</div>
</body>
</html>