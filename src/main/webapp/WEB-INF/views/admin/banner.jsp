<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css for admin page --%>
	<link rel="stylesheet" href="/css/custom/admin.css">
	<%-- custom css for inquiry board --%>
	<link rel="stylesheet" href="/css/custom/inquiry.css">
	<style type="text/css">
		#outbox{width: 1000px; margin:0 auto;}
		#outbox>h2{ text-align: center; font-size: 30px; margin-bottom: 30px;}
		#contents{width: 1000px;}
		.orderDivNm{width: 1000px;}
		.orderTable2{ width: 1000px; border-left:1px dotted gray; border-right:1px dotted gray; }
		.orderTable2 thead th{ border-left:1px dotted gray; border-right:1px dotted gray;}
		.orderTable2 tbody tr td{ border-left:1px dotted gray; border-right:1px dotted gray;}
		#banner_img_wrap img{ width: 250px; height: 60px;}
		
		#bannerInsertWrap{border: 2px dotted green;}
		#bannerInsertWrap>h2{height:20px; text-align: center; font-size: 20px; margin-bottom: 10px; margin-top: 10px; padding: 6px 0 6px 0; }
		#bannerInsertWrap>table{ margin:20px 0 20px 0;}
		
		#submitbtn{ text-align: right; padding-right: 10px; padding-top: 20px;}
		#submitbtn input{ width: 70px; height: 40px; font-size: 15px;}
		#submitbtn input:nth-child(1) {background-color: skyblue; color: black; }
		#submitbtn input:nth-child(2) {background-color: pink; color: black; }
		
	</style>
	<script type="text/javascript">
		function delCheck(seqKey,filename){
			if(confirm("배너를 삭제하시겠습니까?")){
				$.ajax({
			        url : "/admin/banner/delete",
			        type : "POST",
			        data: JSON.stringify({seqKey:seqKey,filename:filename}),
			        contentType: "application/json",
			        success : function(data){
			           if(data.result == "ok"){
			              location.reload();
			           }
			        },
			        error : function(){
			           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteError)");
			        }
			     });
			}
		}
	</script>
</head>

<body>
	<c:if test="${bannerSuccess==1 }">
		<script type="text/javascript">
			alert("저장이 완료되었습니다.");
		</script>
	</c:if>
	
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
		<h2>배너관리</h2>
			<div id="contents">
				<div class="orderDivNm" >
					<table class="orderTable2" border="1" cellspacing="0">
						<colgroup>
							<col width="10%"/>
							<col width="20%"/>
							<col width="30%"/>
							<col width="30%"/>
							<col width="10%"/>
						</colgroup>
						<thead>
							<th scope="col">No.</th>
							<th scope="col">카테고리</th>
							<th scope="col">파일명</th>
							<th scope="col">미리보기</th>
							<th scope="col">수정/삭제</th>
						</thead>
						<tbody>
							<c:forEach var="list" items="${navList}">
								<tr>
									<td class="tnone">${list.seqKey}</td>
									<td>${list.category}</td>
									<td>${list.filename}</td>
									<td id="banner_img_wrap">
										<img alt="배너" src="/files/banner/${list.filename }">
									</td>
									<td>
										<a href="#"
										onclick="popup('/admin/banner/modifyView/${list.seqKey}')">
											<button style="cursor: pointer;">수정</button>
										</a>
										<br>
										<a href="#" 
										onclick="delCheck('<c:out value="${list.seqKey }"/>','<c:out value="${list.filename }"/>')">
											<button style="margin-top:8px; cursor: pointer; background-color: pink; color: black;">삭제</button>
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<c:if test="${empty navList}">
						<div class="noData">
							상품이 없습니다.
						</div>
					</c:if>
				</div>

				<%-- 삽입 --%>
				<form action="/admin/banner/insert" method="post" enctype="multipart/form-data">
					<div id="bannerInsertWrap">
						<h2>배너등록</h2>
						<span>여러개의 배너가 등록된 경우 제일 최근에 등록된 배너로 적용됩니다.</span>
						<table>
							<tr>
								<th>카테고리</th>
								<td>
									<select name="category">
										<option value="main">메인</option>
										<c:forEach var="nav1" items="${nav1}">
											<option value="${nav1}">${nav1}</option>
										</c:forEach>
									</select>
								</td>
								<th>배너파일</th>
								<td>
									<input type="file" name="filename" required>
								</td>
							<tr>
							<tr>
								<td colspan="4" id="submitbtn">
									<input type="submit" value="등록" />
									<input type="reset" value="취소" />
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
	</main>
	<script type="text/javascript">
	 function popup(url_){
            var url = url_;
            var name = "popup test";
            var	option = "width = 1200, height = 700, top = 0, left = 400, location = no, toolbars = no, status = no ";
            window.open(url, name, option);
        }
	</script>
	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
