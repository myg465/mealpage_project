<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

<c:if test="${reasonModifySuccess==1 }">
	<script type="text/javascript">
		alert("저장이 완료되었습니다.");
		parent.location.reload();// 작성완료시 새로고침
		parent.$.fancybox.close();
	</script>
</c:if>

<c:set var="reason" value="${takebackReasonView}" />
<form action="/nonmember/takebackReasonModify" method="post" name="reasonModifyForm">
<input type="hidden" name="seqKey" value="${reason.seqKey }" />
<div id="layerWrap">
<div class="inputWrap">
		
	<div class="inputBody">
		<div class="title">사유 보기</div>
		<p class="close"><a onclick="parent.$.fancybox.close();" href="javascript:;"><img src="/img/temp/btn/btn_input_close.gif" alt="닫기" /></a></p>
		<br>
		<h3>사유</h3>

		<textarea class="reasontta" name="Modifycontent" required>
${reason.content }
		</textarea>

		<c:if test="${reason.reply!=null }">
			<br>
			<h3>답변</h3>
			<textarea class="reasontta" readonly>
${reason.reply }
			</textarea>

		</c:if>



		<div class="centerbrn pd10">
			<a href="javascript:reasonModifyForm.submit();" >수정하기</a>
			<br>
			<a href="#" onclick="parent.$.fancybox.close();" style="cursor: pointer;">취소</a>
		</div>

	</div>

</div>
</div>
</form>
</body>
</html>