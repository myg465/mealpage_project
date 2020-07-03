<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<c:set var="modify" value="${bannerModify}" />
<html>
	<head>
		<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<c:if test="${modifySuccess==1 }">
		<script type="text/javascript">
			alert('저장이 완료되었습니다.');
			opener.parent.location.reload();
			window.close();
		</script>
		</c:if>
		<style type="text/css">
			#product_insert_wrap{ width:100%;}
			#product_insert_wrap h2{ text-align: center;}
			#product_insert_wrap table{ border-collapse: collapse;}
			#product_insert_wrap table tr{ margin-top:7px;}
			#product_insert_wrap table tr th{ width:120px; text-align: center;}
			#product_insert_wrap table tr td{ width:400px; text-align: center; padding: 10px;}
			
			#submitbtn{ width:200px; height: 50px; margin: 0 auto; margin-top: 30px;}
			#submitbtn button{ width:80px; height: 48px; font-size: 16px; font-weight: bold; text-align: center; cursor: pointer;}
			#submitbtn>button{ background-color: skyblue;}
			#submitbtn>a>button{ background-color: pink;}
		</style>
	</head>
	<body>
		<div id="product_insert_wrap">
			<h2>배너수정</h2>
			<form action="/admin/banner/modify" method="post" name="productModifyForm" enctype="multipart/form-data">
				<input type="hidden" name="seqKey" value="${modify.seqKey }">
				<table border="1">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<th>카테고리</th>
						<td>
							<select name="category" style="height: 25px;">
								<option value="main">메인</option>
								<c:forEach var="nav1" items="${nav1}">
									<c:if test="${nav1==modify.category }">
										<option value="${nav1}" selected>${nav1 }</option>
									</c:if>
									<c:if test="${nav1!=modify.category }">
										<option value="${nav1}">${nav1 }</option>
									</c:if>
								</c:forEach>
							</select>
						</td>
					<tr>
					<tr>
						<th>배너이미지</th>
						<td colspan="3">
							이전파일 : <input type="text" name="oldfile" value="${modify.filename }"/><br><br>
							<img alt="" src="/files/banner/${modify.filename }" width="200px" height="60px"><br><br>
							신규파일 : <input type="file" name="filename" style="border: 1px solid gray;">
						</td>
					</tr>
				</table>
				<div id="submitbtn">
					<button type="submit">수정</button>
					<a href="#" onclick="window.close();">
						<button>취소</button>
					</a>
				</div>
			</form>
		</div>
	</body>
</html>