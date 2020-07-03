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
		
		function adminNoticeWriteCheck() {
			// 제목 유효성 검사
			if(adminNoticeWriteForm.adminNoticeWriteTitle.value == "") {
				alert("제목을 입력해 주세요.");
				adminNoticeWriteForm.adminNoticeWriteTitle.focus();
				return false;
			}
			
			// 상세 내용 유효성 검사
			if(adminNoticeWriteForm.adminNoticeWriteContent.value == "") {
				alert("상세 내용을 입력해 주세요.");
				adminNoticeWriteForm.adminNoticeWriteContent.focus();
				return false;
			}
			
			adminNoticeWriteForm.submit();
		}
	
	</script>
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="board_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(3,0);</script>
			<div id="contents">
				<div id="customer">
					<h2>
						<strong>공지사항 작성</strong>
					</h2>
					<form action="/admin/customer/notice/write" name="adminNoticeWriteForm" id="adminNoticeWriteForm" method="post" enctype="multipart/form-data">
						<div class="checkMt">
							<table summary="제목, 상세내용, 첨부파일 순으로 입력하여 공지사항을 작성 할 수 있습니다."
								class="checkTable" border="1" cellspacing="0">
								<caption>공지사항 작성</caption>
								<colgroup>
									<col width="25%" class="tw30" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><span>제목</span></th>
										<td><input type="text" name="adminNoticeWriteTitle" class="wlong" /></td>
									</tr>
									<tr>
										<th scope="row"><span>상세 내용</span></th>
										<td><textarea name="adminNoticeWriteContent" class="tta"></textarea></td>
									</tr>
									<tr>
										<th scope="row"><span>상세 내용 이미지파일</span></th>
										<td><input type="file" name="adminNoticeWriteFileName" class="fileType" /></td>
									</tr>
								</tbody>
							</table>
						</div>
						
					</form>
					
					<!-- Btn Area -->
					<div class="btnArea">
						<div class="bCenter">
							<ul>
								<li><button onclick="javascript:history.back()" class="nbtnbig">취소</button></li>
								<li><button onclick="adminNoticeWriteCheck(); return false;" class="sbtnMini">확인</button></li>
								<!-- <li><a href="#" class="nbtnbig">취소</a></li>
								<li><a href="#" class="sbtnMini">확인</a></li> -->
							</ul>
						</div>
					</div>
					<!-- //Btn Area	 -->
				</div>
			
			</div>	
		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
