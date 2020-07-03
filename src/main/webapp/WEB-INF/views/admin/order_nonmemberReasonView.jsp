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

<c:if test="${reasonSuccess==1 }">
	<script type="text/javascript">
		alert("저장이 완료되었습니다.");
		window.close();
	</script>
</c:if>

<form action="" method="post" name="reasonReplyForm">
<input type="hidden" name="seqKey" value="${reason.seqKey }" />
<div id="layerWrap">
<div class="inputWrap">
		
	<div class="inputBody">
		<div class="title">사유 보기</div>
		<br>
		<h3>사유</h3>

		<textarea class="reasontta" readonly>
${reason.content }
		</textarea>
		<!-- 답변 안단 상태 -->
		<c:if test="${reason.reply==null or reason.reply=='' }">
			<br>
			<h3>답변</h3>
			<textarea class="reasontta" name="reply" required></textarea>
		</c:if>
		<!-- 답변 단상태( 수정 ) -->
		<c:if test="${reason.reply!=null }">
			<br>
			<h3>답변</h3>
			<textarea class="reasontta" name="replyModify" required>
${reason.reply }
			</textarea>
		</c:if>



		<div class="centerbrn pd10">
			<!-- 답변 안단 상태 -->
			<c:if test="${reason.reply==null or reason.reply=='' }">
				<input type="submit" value="등록하기" 
				onclick="javascript: form.action='/admin/order/nonmember/replyWrite';" style="width: 82px; height: 30px; cursor: pointer;">
			</c:if>
			<!-- 답변 단상태( 수정 ) -->
			<c:if test="${reason.reply!=null }">
				<input type="submit" value="수정하기" 
				onclick="javascript: form.action='/admin/order/nonmember/replyModify';" style="width: 82px; height: 30px; cursor: pointer;">
			</c:if>
			<br>
			<input type="reset" value="취소" onclick="window.close();" style="width: 82px; height: 30px; cursor: pointer; margin-top: 7px;">
		</div>

	</div>

</div>
</div>
</form>
</body>
</html>