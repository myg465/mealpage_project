<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<body>
<%@ include file="../common/head.jsp"%>
<c:if test="${takebackWriteSuccess=='ok' }">
	<script type="text/javascript">
		alert("신청이 완료 되었습니다.");
		opener.parent.location.reload();
		window.close();
	</script>
</c:if>
<div id="allwrap">
<div id="wrap">
	<!-- container -->
	<div id="container">
		<div id="outbox">
			<!-- contents -->
			<div id="contents">
				<div id="mypage">
					<h3 class="dep">반품 등 사유 입력</h3>
						<form action="/nonmember/takebackWrite" method="post">
							<div class="checkDiv">
								<table summary="분류, 자세한 이유 순으로 반품/교환 사유를 작성 하실수 있습니다." class="checkTable" border="1" cellspacing="0">
									<caption>반품/교환 사유</caption>
									<colgroup>
									<col width="22%" class="tw30" />
									<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row"><span>분류</span></th>
											<td>
												<input type="hidden" name="seqKey" value="${seqKey }" />
												<select name="category">
													<c:if test="${status!='배송준비중'}">
														<option value="반품신청">반품</option>
														<option value="교환신청">교환</option>
														<option value="환불신청">환불</option>
													</c:if>
													<c:if test="${status=='배송준비중' }">
														<option value="취소신청" checked >취소</option>
													</c:if>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row"><span>자세한 이유</span></th>
											<td>
												<textarea class="tta" name="content" required></textarea>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
				
							<!-- Btn Area -->
							<div class="btnArea">
								<div class="bCenter">
									<ul>								
										<li><button type="submit" class="sbtnMini" style="border: none">신청</button></li>
										<li><a href="#" class="nbtnbig" onclick="javascript:window.close()">취소</a></li>
									</ul>
								</div>
							</div>
							<!-- //Btn Area -->
						</form>
				</div>
			</div>
			<!-- //contents -->
		</div>
	</div>
<!-- //container -->
</div>
</div>
</body>
</html>