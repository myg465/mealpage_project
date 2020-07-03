<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
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
						<li class="last">1:1문의</li>
					</ol>
				</div>
				
				<div id="outbox">
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(7,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2><strong>1:1문의</strong><span>밀페이지에 궁금하신 사항을 남겨주시면 답변해드립니다.</span></h2>
							
							<%@ include file="myinfo.jsp" %>

							<form action="/inquiry/write" method="post" enctype="multipart/form-data" onsubmit="return checkForm()">
								<div class="checkDiv">
									<table class="checkTable" border="1" cellspacing="0">
										<caption>1:1 문의</caption>
										<colgroup>
											<col width="19%" class="tw30" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><span>분류</span></th>
												<td>
													<select name="category">
														<option value="이용문의">이용문의</option>
														<option value="배송">배송</option>
														<option value="환불/반품/교환">환불/반품/교환</option>
														<option value="주문/결제">주문/결제</option>
														<option value="영수증/기타">영수증/기타</option>
													</select>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>제목</span></th>
												<td>
													<input type="text" class="wlong" name="title" required>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>상세 내용</span></th>
												<td>
													<textarea class="tta" name="content" maxlength=10000 required></textarea>
												</td>
											</tr>
											<tr style="height: 50px;">
												<th scope="row"><span>첨부파일</span><br><span style="position: relative; top: 3px; left: -8px;">(최대 1MB)</span></th>
												<td>
													<input type="file" name="file" class="fileType" style="height: 21px;">
												</td>
											</tr>
										</tbody>
									</table>
								</div>

								<!-- Btn Area -->
								<div class="btnArea">
									<div class="bCenter">
										<ul>																
											<li><button type="reset" class="nbtnbig no-outline">취소</a></li>
											<li><button type="submit" class="sbtnMini no-outline">확인</a></li>
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

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
	<%-- custom js --%>
	<script src="/js/custom/inquiry.js"></script>
</body>
</html>