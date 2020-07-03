<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css --%>
	<link rel="stylesheet" href="/css/custom/takeback.css">
</head>

<body>
	<div id="layerWrap">
		<div class="inputWrap">
			<div class="inputBody">
				<c:choose>
					<c:when test="${status == 'replace'}">
						<div class="title">교환요청 작성</div>
					</c:when>
					<c:otherwise>
						<div class="title">반품요청 작성</div>
					</c:otherwise>
				</c:choose>
				<p class="close">
					<a onclick="parent.$.fancybox.close()" href="javascript:;">
						<img src="/img/temp/btn/btn_input_close.gif" alt="닫기" />
					</a>
				</p>

				<form action="/takeback/${status}/${orderNumber}" name="form" method="post">
					<div style="position: relative; top: 12px;">
						<c:choose>
							<c:when test="${status == 'replace'}">
								<label>[교환 귀책]</label>
							</c:when>
							<c:otherwise>
								<label>[반품 귀책]</label>
							</c:otherwise>
						</c:choose>
						<label>
							<span style="position: relative; top: -3px;">
								<input type="radio" name="charged" value="buyer" checked>
							</span>
							구매자 귀책 (단순변심 등)
						</label>
						<label>
							<span style="position: relative; top: -3px;">
								<input type="radio" name="charged" value="seller">
							</span>
							판매자 귀책 (판매자 실수 등)
						</label>
					</div>
								
					<textarea name="content" class="reasontta" required></textarea>
					<c:choose>
						<c:when test="${status == 'replace'}">
							* 구매자 귀책으로 교환 시, 왕복 배송비가 추가 요청됩니다.
						</c:when>
						<c:otherwise>
							* 구매자 귀책으로 반품 시, 환불 비용에서 반품 배송비가 제외됩니다.
						</c:otherwise>
					</c:choose>

					<br><br>
					<div class="centerbrn pd10">
						<a class="point" onclick="checkForm()">확인</a>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script src="/js/custom/takeback.js"></script>
</body>
</html>