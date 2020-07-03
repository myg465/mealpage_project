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

<c:if test="${rejectSuccess==1 }">
	<script type="text/javascript">
		alert("저장이 완료되었습니다.");
		opener.parent.location.reload();
		window.close();
	</script>
</c:if>

<form action="/admin/order/nonmember/reject" method="post" name="rejectForm">
<input type="hidden" name="seqKey" value="${seqKey}" />
<input type="hidden" name="status" value="${status}" />
<div id="layerWrap">
<div class="inputWrap">
		
	<div class="inputBody">
		<div class="title">거절 사유 입력</div>
		<br>
		<h3>${status}거절사유</h3>
		<textarea class="reasontta" name="rejectReason" required></textarea>

		<div class="centerbrn pd10">
			<input type="submit" value="등록하기" style="width: 82px; height: 30px; cursor: pointer;">
			<br>
			<input type="reset" value="취소" onclick="window.close();" style="width: 82px; height: 30px; cursor: pointer; margin-top: 7px;">
		</div>
	</div>

</div>
</div>
</form>
</body>
</html>