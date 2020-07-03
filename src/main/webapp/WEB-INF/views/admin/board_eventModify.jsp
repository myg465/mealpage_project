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
		function adminEventModifyCheck() {
			// 제목 유효성 검사
			if(adminEventModifyForm.adminEventModifyTitle.value == "") {
				alert("제목을 입력해 주세요.");
				adminEventModifyForm.adminEventModifyTitle.focus();
				return false;
			}
			
			// 상세 내용 유효성 검사
			if(adminEventModifyForm.adminEventModifyContent.value == "") {
				alert("상세 내용을 입력해 주세요.");
				adminEventModifyForm.adminEventModifyContent.focus();
				return false;
			}
			
			// 시작일 유효성 검사
			if(adminEventModifyForm.adminEventModifyStartDate.value == "") {
				alert("시작일을 선택해 주세요.");
				adminEventModifyForm.adminEventModifyStartDate.focus();
				return;
			}
			
			// 종료일 유효성 검사
			if(adminEventModifyForm.adminEventModifyEndDate.value == "") {
				alert("종료일을 선택해 주세요.");
				adminEventModifyForm.adminEventModifyEndDate.focus();
				return;
			}
			
			// 시작일이 종료일보다 늦은 경우
			if(adminEventModifyForm.adminEventModifyStartDate.value > adminEventModifyForm.adminEventModifyEndDate.value) {
				alert("시작일이 종료일 보다 늦습니다. 다시 선택해 주세요.");
				adminEventModifyForm.adminEventModifyStartDate.focus();
				return;
			}
						
			return adminEventModifyForm.submit();
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
					<strong>이벤트 수정</strong>
				</h2>
				
				<form action="/admin/event/event/modify/${eventVo.getSeqKey() }/${page}" name="adminEventModifyForm" id="adminEventModifyForm" method="post" enctype="multipart/form-data">
						<div class="checkMt">
							<input type="hidden" name="seqKey" value="${eventVo.getSeqKey() }" />
							<input type="hidden" name="originTitleFileName" value="${eventVo.getTitleImageFilename() }" />
							<input type="hidden" name="originCotentFileName" value="${eventVo.getContentImageFilename() }" />
							<table summary="제목, 상세내용, 시작일, 종료일, 섬네일 이미지파일, 상세내용 이미지파일 순으로 입력하여 공지사항을 작성 할 수 있습니다."
								class="checkTable" border="1" cellspacing="0">
								<caption>이벤트 작성</caption>
								<colgroup>
									<col width="30%" class="tw30" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><span>제목</span></th>
										<td><input type="text" name="adminEventModifyTitle" class="wlong" value="${eventVo.getTitle() }"/></td>
									</tr>
									<tr>
										<th scope="row"><span>상세 내용</span></th>
										<td><textarea name="adminEventModifyContent" class="tta">${eventVo.getContent() }</textarea></td>
									</tr>
									<tr>
										<fmt:formatDate value="${eventVo.getStartDate() }" pattern="yyyy-MM-dd" var="startDate" />
										<th scope="row"><span>시작일</span></th>
										<td><input type="date" name="adminEventModifyStartDate" value="${startDate }"/></td>
									</tr>
									<tr>
										<fmt:formatDate value="${eventVo.getEndDate() }" pattern="yyyy-MM-dd" var="endDate" />
										<th scope="row"><span>종료일</span></th>
										<td><input type="date" name="adminEventModifyEndDate" value="${endDate }" /></td>
									</tr>
									<tr>
										<th scope="row"><span>섬네일 이미지파일</span></th>
										<td><input type="file" name="adminEventModifyTitleFileName" class="fileType" /></td>
									</tr>
									<tr>
										<th scope="row"><span>기존 섬네일 이미지파일</span></th>
										<td>${eventVo.getTitleImageFilename() }</td>
									</tr>
									<tr>
										<th scope="row"><span>상세 내용 이미지파일</span></th>
										<td><input type="file" name="adminEventModifyContentFileName" class="fileType" /></td>
									</tr>
									<tr>
										<th scope="row"><span>기존 상세 내용 이미지파일</span></th>
										<td>${eventVo.getContentImageFilename() }</td>
									</tr>
								</tbody>
							</table>
						</div>

						<!-- Btn Area -->
						<div class="btnArea">
							<div class="bCenter">
								<ul>
									<li><button onclick="javascript:history.back()" class="nbtnbig">취소</button></li>
									<li><button onclick="adminEventModifyCheck(); return false;" class="sbtnMini">확인</button></li>
									<!-- <li><a href="#" class="nbtnbig">취소</a></li>
									<li><a href="#" class="sbtnMini">확인</a></li> -->
								</ul>
							</div>
						</div>
						<!-- //Btn Area	 -->
					</form>
					
			</div>
		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
