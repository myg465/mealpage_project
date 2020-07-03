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
	
	<script type="text/javascript">
			
		/* function cancle() {
			histroy.go(-2);
		}  */
	
		function adminEventWriteCheck() {
			// 제목 유효성 검사
			if(adminEventWriteForm.adminEventWriteTitle.value == "") {
				alert("제목을 입력해 주세요.");
				adminEventWriteForm.adminEventWriteTitle.focus();
				return false;
			}
			
			// 상세 내용 유효성 검사
			if(adminEventWriteForm.adminEventWriteContent.value == "") {
				alert("상세 내용을 입력해 주세요.");
				adminEventWriteForm.adminEventWriteContent.focus();
				return false;
			}
			
			// 시작일 유효성 검사
			if(adminEventWriteForm.adminEventWriteStartDate.value == "") {
				alert("시작일을 선택해 주세요.");
				adminEventWriteForm.adminEventWriteStartDate.focus();
				return;
			}
			
			// 종료일 유효성 검사
			if(adminEventWriteForm.adminEventWriteEndDate.value == "") {
				alert("종료일을 선택해 주세요.");
				adminEventWriteForm.adminEventWriteEndDate.focus();
				return;
			}
			
			// 시작일이 종료일보다 늦은 경우
			if(adminEventWriteForm.adminEventWriteStartDate.value > adminEventWriteForm.adminEventWriteEndDate.value) {
				alert("시작일이 종료일 보다 늦습니다. 다시 선택해 주세요.");
				adminEventWriteForm.adminEventWriteStartDate.focus();
				return;
			}
			
			// 섬네일 이미지파일 유효성 검사
			if(adminEventWriteForm.adminEventWriteTitleFileName.value == "") {
				alert("섬네일 이미지파일을 선택해 주세요.");
				return false;
			}
			
			
			return adminEventWriteForm.submit();
		}
	
	</script>
	
	<style type="text/css">

	</style>
</head>

<body>
	
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="board_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(4,0);</script>
			<div id="contents">
				<h2>
					<strong>이벤트 작성</strong>
				</h2>
				
				<form action="/admin/event/event/write" name="adminEventWriteForm" id="adminEventWriteForm" method="post" enctype="multipart/form-data">
						<div class="checkMt">
							<table summary="제목, 상세내용, 시작일, 종료일, 섬네일 이미지파일, 상세내용 이미지파일 순으로 입력하여 공지사항을 작성 할 수 있습니다."
								class="checkTable" border="1" cellspacing="0">
								<caption>이벤트 작성</caption>
								<colgroup>
									<col width="25%" class="tw30" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><span>제목</span></th>
										<td><input type="text" name="adminEventWriteTitle" class="wlong" /></td>
									</tr>
									<tr>
										<th scope="row"><span>상세 내용</span></th>
										<td><textarea name="adminEventWriteContent" class="tta"></textarea></td>
									</tr>
									<tr>
										<th scope="row"><span>시작일</span></th>
										<td><input type="date" name="adminEventWriteStartDate" /></td>
									</tr>
									<tr>
										<th scope="row"><span>종료일</span></th>
										<td><input type="date" name="adminEventWriteEndDate" /></td>
									</tr>
									<tr>
										<th scope="row"><span>섬네일 이미지파일</span></th>
										<td><input type="file" name="adminEventWriteTitleFileName" class="fileType" /></td>
									</tr>
									<tr>
										<th scope="row"><span>상세 내용 이미지파일</span></th>
										<td><input type="file" name="adminEventWriteContentFileName" class="fileType" /></td>
									</tr>
								</tbody>
							</table>
						</div>

					</form>
						<!-- Btn Area -->
						<div class="btnArea">
							<div class="bCenter">
								<ul>
									<!-- <li><button type="reset" class="nbtnbig">취소</button></li> -->
									<li><button onclick="javascript:history.back()" class="nbtnbig">취소</button></li>
									<li><button onclick="adminEventWriteCheck(); return false;" class="sbtnMini">확인</button></li>
									<!-- <li><a href="#" class="nbtnbig">취소</a></li>
									<li><a href="#" class="sbtnMini">확인</a></li> -->
								</ul>
							</div>
						</div>
						<!-- //Btn Area	 -->
					
					<script type="text/javascript">
						
					</script>
					
					
			</div>
		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
