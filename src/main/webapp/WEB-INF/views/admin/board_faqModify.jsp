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
		function OnloadCategorySelect() {
			$("#adminFaqModifyCategory").val('<c:out value="${customerFaqVo.getCategory() }"/>').attr("selected", "selected");
		}
	
		window.onload=OnloadCategorySelect;
	
		function adminFaqWriteCheck() {
			// 질문 유효성 검사
			if(adminFaqModifyForm.adminFaqModifyQuestion.value == "") {
				alert("질문을 입력해 주세요.");
				adminFaqModifyForm.adminFaqModifyQuestion.focus();
				return false;
			}
			
			// 답변 유효성 검사
			if(adminFaqModifyForm.adminFaqModifyAnswer.value == "") {
				alert("답변을 입력해 주세요.");
				adminFaqModifyForm.adminFaqModifyAnswer.focus();
				return false;
			}
			
			adminFaqModifyForm.submit();
		}
			
	</script>
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="board_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(6,0);</script>
			<div id="contents">
				<div id="customer">
					<h2>
						<strong>FAQ 수정</strong>
					</h2>
					<form action="/admin/customer/faq/modify/${customerFaqVo.getSeqKey() }/${page}" name="adminFaqModifyForm" id="adminFaqModifyForm" method="post">
						<div class="checkMt">
							<table summary="구분, 질문, 답변 순으로 입력하여 FAQ를 수정 할 수 있습니다."
								class="checkTable" border="1" cellspacing="0">
								<caption>FAQ 수정</caption>
								<colgroup>
									<col width="25%" class="tw30" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><span>구분</span></th>
										<td>
											<select name="adminFaqModifyCategory" id="adminFaqModifyCategory">
												<option value="회원관리">회원관리</option>
												<option value="포인트/쿠폰">포인트/쿠폰</option>
												<option value="주문/결제">주문/결제</option>
												<option value="환불/교환">환불/교환</option>
												<option value="배송">배송</option>
												<option value="기타">기타</option>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="row"><span>질문</span></th>
										<td><input type="text" name="adminFaqModifyQuestion" class="wlong" value="${customerFaqVo.getTitle() }"/></td>
									</tr>
									<tr>
										<th scope="row"><span>답변</span></th>
										<td><textarea name="adminFaqModifyAnswer" class="tta">${customerFaqVo.getContent() }</textarea></td>
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
								<li><button onclick="adminFaqWriteCheck(); return false;" class="sbtnMini">확인</button></li>
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
