<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<script src="https://code.jquery.com/jquery-2.2.1.min.js"></script>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script type="text/javascript">
			function nav1_insert() {
				var nav1 = $("#cate1 option:selected").val();
				$("#category1").val(nav1);
			};
			function nav2_insert() {
				var nav2 = $("#cate2 option:selected").val();
				$("#category2").val(nav2);
			}
			function insertCheck(){
				var tel_check=/^\d{2,3}-\d{3,4}-\d{4}$/;
				if(!tel_check.test($('#csPhone').val())){
					alert("전화번호를 다시 입력하세요");
					return false;
				}
				return true;
			}
		</script>
		<c:if test="${productSuccess==1 }">
		<script type="text/javascript">
			alert('저장이 완료되었습니다.');
			opener.parent.location.reload();
			window.close();
		</script>
		</c:if>
		<style type="text/css">
			#product_insert_wrap{ width:100%;}
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
			<h2>상품등록</h2>
			<form action="/admin/product/insert" method="post" name="productInsertForm" onsubmit="return insertCheck()" enctype="multipart/form-data">
				<table border="1">
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<th>대분류</th>
						<td>
							<c:if test="${navNum <= 7 }">
								<input type="text" name="category1" id="category1" required/>
							</c:if>
							<c:if test="${navNum > 7 }">
								<input type="text" name="category1" id="category1" readonly/>
							</c:if>
							<select id="cate1" onchange="nav1_insert();" style="height: 25px;">
								<c:if test="${navNum <= 7 }">
									<option value="">직접입력</option>
								</c:if>
								<c:forEach var="cate1" items="${nav1 }">
									<option value="${cate1 }">${cate1 }</option>
								</c:forEach>
							</select>
						</td>
						<th>소분류</th>
						<td>
							<input type="text" name="category2" id="category2" readonly/>
							<select id="cate2" onchange="nav2_insert();" style="height: 25px;">
								<c:forEach var="cate2" items="${nav2 }">
									<option value="${cate2 }">${cate2 }</option>
								</c:forEach>
							</select>
						</td>
					<tr>
					<tr>
						<th>상품명</th>
						<td>
							<input type="text" name="name" required/>
						</td>
						<th>가격</th>
						<td>
							<input type="number" name="price" placeholder="8자리 이하 입력가능" min="0" max="9999999" maxlength="9" required/>
						</td>
					</tr>
					<tr>
						<th>재고량</th>
						<td>
							<input type="number" name="stock" min="0" max="99999999" maxlength="9"  required/>
						</td>
						<th>칼로리</th>
						<td>
							<input type="number" name="calorie" placeholder="4자리 이하 입력가능" min="0" max="9999" maxlength="4" required/>
						</td>
					</tr>
					<tr>
						<th>상품타입</th>
						<td>
							<input type="text" name="type" required/>
						</td>
						<th>함량</th>
						<td>
							<input type="text" name="volume" required/>
						</td>
					</tr>
					<tr>
						<th>수입자</th>
						<td colspan="3">
							<input type="text" name="importer" style="width: 750px;">
						</td>
					</tr>
					<tr>
						<th>수입정보</th>
						<td colspan="3">
							<input type="text" name="importDeclaration" style="width: 750px;">
						</td>
					</tr>
					<tr>
						<th>생산자</th>
						<td colspan="3">
							<input type="text" name="productor" placeholder="회사명,주소기재" style="width: 750px;" required>
						</td>
					</tr>
					<tr>
						<th>유통기한</th>
						<td>
							<input type="text" name="useByDate" required>
						</td>
						<th>할인율</th>
						<td>
							<input type="number" name="salePercent" min="0" max="100" value="0" placeholder="%단위로 정수만 입력" required>
						</td>
					</tr>
					<tr>
						<th>원재료</th>
						<td colspan="3">
							<textarea rows="5" cols="120" name="rawMaterials" required></textarea>
						</td>
					</tr>
					<tr>
						<th>영양정보</th>
						<td colspan="3">
							<textarea rows="5" cols="120" name="nutrients"></textarea>
						</td>
					</tr>
					<tr>
						<th>유전자재조합<br>식품여부</th>
						<td>
							<input type="text" name="gmFood">
						</td>
						<th>소비자상담<br>전화번호</th>
						<td>
							<input type="text" name="csPhone" id="csPhone" required>
						</td>
					</tr>
					<tr>
						<th>추천상품여부</th>
						<td>
							<input type="radio" name="recommend" value="Y" id="reYes" checked>
							<label for="reYes">예</label>
							<input type="radio" name="recommend" value="N" id="reNo">
							<label for="reNo">아니요</label>
						</td>
						<th>신상품여부</th>
						<td>
							<input type="radio" name="newProduct" value="Y" id="newYes" checked>
							<label for="newYes">예</label>
							<input type="radio" name="newProduct" value="N" id="newNo">
							<label for="newNo">아니요</label>
						</td>
						
					</tr>
					<tr>
						<th>상세이미지1<br>(대표이미지)</th>
						<td colspan="3">
							<input type="file" name="detailImageFilename1" required>
						</td>
					</tr>
					<tr>
						<th>상세이미지2</th>
						<td colspan="3">
							<input type="file" name="detailImageFilename2">
						</td>
					</tr>
					<tr>
						<th>상세이미지3</th>
						<td colspan="3">
							<input type="file" name="detailImageFilename3">
						</td>
					</tr>
					<tr>
						<th>상세설명</th>
						<td colspan="3">
							<textarea rows="20" cols="120" name="contentText"></textarea>
						</td>
					</tr>
					<tr>
						<th>설명이미지</th>
						<td colspan="3">
							<input type="file" name="contentImageFilename" required>
						</td>
					</tr>
				</table>
				<div id="submitbtn">
					<button type="submit">등록</button>
					<a href="#" onclick="window.close();">
						<button>취소</button>
					</a>
				</div>
			</form>
		</div>
	</body>
</html>