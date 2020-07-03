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
	<%-- custom css for account board --%>
	<link rel="stylesheet" href="/css/custom/modifyAccount.css">
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="account_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(1,0);</script>
			<div id="contents">
				<div id="mypage">

					<div class="memberbd">
						<table class="memberWrite" border="1" cellspacing="0">
							<caption>회원정보 수정</caption>
							<colgroup>
							<col width="22%" class="tw30" />
							<col width="*" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><span>이름</span></th>
									<td>${accountVo.name}</td>
								</tr>
								<tr>
									<th scope="row"><span>아이디</span></th>
									<td>${accountVo.id}</td>
								</tr>
								<tr>
									<th scope="row"><span>비밀번호</span></th>
									<td>${accountVo.password}</td>
								</tr>
								<tr>
									<th scope="row"><span>이메일</span></th>
									<td>${accountVo.email}</td>
								</tr>
								<tr>
									<th scope="row"><span>이벤트 메일 수신</span></th>
									<td>${accountVo.emailReception}</td>
								</tr>
								<tr>
									<th scope="row"><span>주소</span></th>
									<td>
										<ul class="pta">
											<li><input type="button" class="nbtnMini no-outline" value="우편번호" style="width: 105px;" readonly></li>
											<li>
												<input type="text" class="w134" name="zipcode" id="zipcode" placeholder="우편번호" value="${accountVo.addressZipcode}"  readonly>&nbsp;
											</li>
											<li class="pt5">
												<input type="text" class="addressType" name="roadAddress" id="roadAddress" placeholder="도로명주소" value="${accountVo.addressNew}" style="width: 235px;" readonly>
												<input type="text" class="addressType" name="jibunAddress" id="jibunAddress" placeholder="지번주소" value="${accountVo.addressOld}" style="width: 235px;" readonly>
											</li>
											<li class="pt5">
												<input type="text" class="addressType" name="detailAddress" id="detailAddress" placeholder="상세주소" value="${accountVo.addressDetail}" style="width: 360px;" readonly>
												<input type="text" class="addressType" name="extraAddress" id="extraAddress" placeholder="참고항목" value="${accountVo.addressExtra}" style="width: 110px;" readonly>	
											</li>
										</ul>
									</td>
								</tr>
								<tr>
									<th scope="row"><span>휴대폰</span></th>
									<td>
										${accountVo.phone.substring(0,3)}-${accountVo.phone.substring(3,7)}-${accountVo.phone.substring(7,11)}
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<!-- Btn Area -->
					<div class="btnArea">
						<div class="bCenter" style="width: 360px;">
							<ul>
								<li><a href="/admin/account/list/delete/${accountVo.seqKey}/${accountVo.id}" class="nbtnbig mw" onclick="return confirm('정말로 해당 회원내역을 삭제하시겠습니까?')">회원삭제</a></li>
								<li><a href="/admin/account/list/${page}/modify/${accountVo.seqKey}" class="nbtnbig mw">회원수정</a></li>
								<c:choose>
									<c:when test="${page == '0'}">
										<li><a class="sbtnMini mw point" onclick="history.back()">이전화면</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="/admin/account/list/${page}" class="sbtnMini mw">목록으로</a></li>
									</c:otherwise>
								</c:choose>								
							</ul>
						</div>
					</div>
					<!-- //Btn Area -->

				</div>
			</div>
		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
