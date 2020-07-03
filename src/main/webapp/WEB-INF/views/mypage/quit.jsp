<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css --%>
	<link rel="stylesheet" href="/css/custom/quit.css">
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>

	<div id="allwrap">
		<div id="wrap">
			<%@ include file="../common/header.jsp" %>
			<%@ include file="../common/nav.jsp" %>

			<!-- container -->
			<div id="container">

				<div id="location">
					<ol>
						<li><a href="/">HOME</a></li>
						<li><a href="/mypage/order">MY PAGE</a></li>
						<li class="last">회원 탈퇴</li>
					</ol>
				</div>
				
				<div id="outbox">
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(9,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2><strong>회원 탈퇴</strong><span>회원 탈퇴 전 다음의 안내 사항을 꼭 숙지하시기 바랍니다.</span></h2>
							
							<%@ include file="myinfo.jsp" %>

							<div class="alertBox">
								<p class="chk">탈퇴 전 숙지사항</p>
								<ul>
									<li>그동안 밀페이지샵을 이용해 주신 고객님께 진심으로 감사드립니다.</li>
									<li>회원 탈퇴 시 포인트와 쿠폰은 즉시 삭제 처리되어 환급되지 않으며, 재가입 하셔도 복구되지 않습니다.</li>
									<li>진행중인 거래(주문) 내역이 존재하는 경우 회원탈퇴가 불가능하며, 거래 종료 후 회원탈퇴 하실 수 있습니다.</li>
								</ul>
							</div>

							<c:choose>
								<c:when test="${orderInfo > 0}">
									<h3 class="dep center">진행중인 주문이 있어 탈퇴할 수 없습니다.</h3>
									<div class="btnArea">
										<div class="bCenter button-fix">
											<ul>
												<li><a href="/" class="sbtnMini">확인</a></li>
											</ul>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<h3 class="dep">회원정보 입력</h3>
									<div class="checkDiv">
										<table class="checkTable" border="1" cellspacing="0">
											<caption>주문/배송 조회</caption>
											<colgroup>
											<col width="22%" class="tw30" />
											<col width="*" />
											</colgroup>
											<tbody>
												<tr>
													<th scope="row"><span>아이디</span></th>
													<td><input type="text" class="w186" name="id"></td>
												</tr>
												<tr>
													<th scope="row"><span>비밀번호</span></th>
													<td><input type="password" class="w186" name="password"></td>
												</tr>
												<tr>
													<th scope="row"><span>탈퇴사유</span></th>
													<td>
														<select id="quitReason" name="quitReason">
															<option value="">선택해주세요.</option>
															<option value="가격이 너무 비싸요.">가격이 너무 비싸요.</option>
															<option value="배송이 너무 느려요.">배송이 너무 느려요.</option>
															<option value="원하는 상품이 없습니다.">원하는 상품이 없습니다.</option>
															<option value="input">직접입력</option>
															<input type="text" class="w186" id="quitReasonInput" name="quitReasonInput">
														</select>
													</td>
												</tr>
											</tbody>
										</table>

										<div class="btnArea">
											<div class="bCenter">
												<ul>
													<li><a href="/" class="nbtnbig">취소하기</a></li>
													<li><button type="button" id="quitButton" class="sbtnMini no-outline">탈퇴하기</button></li>
												</ul>
											</div>
										</div>

									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					<!-- //contents -->


				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>

	<%-- custom js --%>
	<script src="/js/custom/quit.js"></script>
</body>
</html>