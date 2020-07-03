<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description" content="MEALPAGE" />
<meta name="keywords" content="MEALPAGE" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scaleable=no" />
<link rel="stylesheet" type="text/css" href="/css/temp/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/temp/content.css" />
<script type="text/javascript" src="/js/tempjquery.min.js"></script>
</head>
<body>
<c:if test="${replyModifySuccess==1 or replyInsertSuccess==1}">
	<script type="text/javascript">
		alert("저장이 완료되었습니다.");
		opener.parent.location.reload();
		window.close();
	</script>
</c:if>

<c:set var="replyView" value="${inquiryModifyView }" />

<form action="" method="post" name="replyForm">

<input type="hidden" name="seqKey" value="${replyView.seqKey }" />

<div id="layerWrap">
<div class="inputWrap">
	<div class="inputBody">
		<div class="title">상품문의 상세</div>
		<br>
		<h3>문의내용</h3>
		<h5>작성자 : ${replyView.id }</h5>
		<h5>작성일 : <fmt:formatDate value="${replyView.createdDate }" dateStyle="full"/> </h5>
		<textarea class="reasontta" readonly>
${replyView.content }
		</textarea>

		<c:if test="${replyView.reply!=null }">
			<br>
			<h3>답변수정</h3>
			<textarea class="reasontta" name="replyModify" required>
${replyView.reply }
			</textarea>
		</c:if>
		<c:if test="${replyView.reply==null }">
			<br>
			<h3>답변입력</h3>
			<textarea class="reasontta" name="replyContent" required></textarea>
		</c:if>



		<div class="centerbrn pd10">
			<c:if test="${replyView.reply!=null }">
				<button type="submit" onclick="javascript: form.action='/admin/productInquiry/replyModify'" style="cursor: pointer;">수정하기</button>
			</c:if>
			<c:if test="${replyView.reply==null }">
				<button type="submit" onclick="javascript:form.action='/admin/productInquiry/replyInsert'" style="cursor: pointer;">답변하기</button>
			</c:if>
			<br>
			<button onclick="javascript:window.close()" style="cursor: pointer; width: 62px; margin-top:10px;">취소</button>
		</div>

	</div>

</div>
</div>
</form>
</body>
</html>