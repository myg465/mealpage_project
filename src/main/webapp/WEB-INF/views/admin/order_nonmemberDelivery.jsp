<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<c:if test="${deliSuccess>0 }">
		<script type="text/javascript">
			alert('저장이 완료되었습니다.');
			opener.parent.location.reload();
			window.close();
		</script>
	</c:if>
	
	<h2>발송등록</h2>
	<form action="" name="deliForm" method="post">
	<c:if test="${flag=='All' }">
		<input type="hidden" name="orderNumber" value="${orderNumber }">
	</c:if>
	<c:if test="${flag=='One' }">
		<input type="hidden" name="seqKey" value="${seqKey }">
	</c:if>
	<table border="1" style="border-collapse: collapse; margin-bottom: 10px;">
		<tr>
			<th>택배사</th>
			<td>
				<select name="deliveryCompany">
					<option value="한진택배">한진택배</option>
					<option value="롯데택배">롯데택배</option>
					<option value="GS편의점택배">GS편의점택배</option>
				</select>
			</td>
			<th>송장번호</th>
			<td>
				<input type="text" name="trackingNumber">
			</td>
		</tr>
	</table>
	<c:if test="${flag=='All' }">
		<input type="submit" value="등록" onclick="javascript: form.action='/admin/order/nonmember/deliAllInsert';" style="float: left; cursor: pointer;">
	</c:if>
	<c:if test="${flag=='One' }">
		<input type="submit" value="등록" onclick="javascript: form.action='/admin/order/nonmember/deliInsert';" style="float: left; cursor: pointer;">
	</c:if>
	</form>
	<a href="#" onclick="window.close()" >
	<button style="float: left; cursor: pointer;">취소</button>
	</a>

</body>
</html>