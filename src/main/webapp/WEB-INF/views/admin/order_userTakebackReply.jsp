<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
					<c:when test="${takeback.status == '교환요청'}">
						<div class="title">교환요청 회신</div>
					</c:when>
					<c:otherwise>
						<div class="title">반품요청 회신</div>
					</c:otherwise>
				</c:choose>
				<p class="close">
					<a class="point" onclick="parent.$.fancybox.close()">
						<img src="/img/temp/btn/btn_input_close.gif" alt="닫기" />
					</a>
				</p>

				<div style="position: relative; top: 12px;">
					<c:choose>
						<c:when test="${takeback.status == '교환요청'}">
							<label>[교환 귀책]</label>
						</c:when>
						<c:otherwise>
							<label>[반품 귀책]</label>
						</c:otherwise>
					</c:choose>

					<c:choose>
						<c:when test="${takeback.charged == '구매자'}">
							<label>구매자 귀책 (단순변심 등)</label>
						</c:when>
						<c:otherwise>
							<label>판매자 귀책 (판매자 실수 등)</label>
						</c:otherwise>
					</c:choose>
				</div>
							
				<div class="reasontta">${takeback.content}</div>
				<c:choose>
					<c:when test="${status == 'replace'}">
						* 구매자 귀책으로 교환 시, 왕복 배송비가 추가 요청됩니다.
					</c:when>
					<c:otherwise>
						* 구매자 귀책으로 반품 시, 환불 비용에서 반품 배송비가 제외됩니다.
					</c:otherwise>
				</c:choose>

				<br><br>
				<!-- 답변 -->
				<form action="/admin/order/takeback/${takeback.seqKey}" name="form" method="post">
					<input type="text" name="orderNumber" value="${takeback.orderNumber}" hidden>
					<input type="text" name="charged" value="${takeback.charged}" hidden>
					<input type="text" name="status" value="${takeback.status}" hidden>
					<input type="text" name="accountKey" value="${takeback.accountKey}" hidden>
					<div style="position: relative; top: 12px;">
						<c:choose>
							<c:when test="${status == 'replace'}">
								<label>[교환 여부]</label>
							</c:when>
							<c:otherwise>
								<label>[반품 여부]</label>
							</c:otherwise>
						</c:choose>
						<label>
							<span style="position: relative; top: -3px;">
								<input type="radio" name="acceptation" value="yes" checked>
							</span>
							승인
						</label>
						<label>
							<span style="position: relative; top: -3px;">
								<input type="radio" name="acceptation" value="no">
							</span>
							거절
						</label>
					</div>

					<textarea name="reply" class="reasontta reply" required autofocus></textarea>
				</form>
				<!-- //답변 -->

				<br>
				<div class="centerbrn pd10">
					<a class="point" onclick="checkReplyForm()">확인</a>
				</div>
			</div>
		</div>
	</div>

	<script src="/js/custom/takeback.js"></script>
</body>
</html>