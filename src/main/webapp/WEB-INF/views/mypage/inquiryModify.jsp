<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css --%>
	<link rel="stylesheet" href="/css/custom/inquiry.css">
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
							<h2><strong>1:1문의</strong><span>밀페이지에 남긴 문의사항을 수정하실 수 있습니다.</span></h2>
							
							<%@ include file="myinfo.jsp" %>

							<form action="/inquiry/${page}/modify/${inquiry.seqKey}" method="post" enctype="multipart/form-data" onsubmit="return checkForm()">
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
														<c:choose>
															<c:when test="${inquiry.category == '이용문의'}">
																<option value="이용문의" selected>이용문의</option>
																<option value="배송">배송</option>
																<option value="환불/반품/교환">환불/반품/교환</option>
																<option value="주문/결제">주문/결제</option>
																<option value="영수증/기타">영수증/기타</option>
															</c:when>
															<c:when test="${inquiry.category == '배송'}">
																<option value="이용문의">이용문의</option>
																<option value="배송" selected>배송</option>
																<option value="환불/반품/교환">환불/반품/교환</option>
																<option value="주문/결제">주문/결제</option>
																<option value="영수증/기타">영수증/기타</option>
															</c:when>
															<c:when test="${inquiry.category == '환불/반품/교환'}">
																<option value="이용문의">이용문의</option>
																<option value="배송">배송</option>
																<option value="환불/반품/교환" selected>환불/반품/교환</option>
																<option value="주문/결제">주문/결제</option>
																<option value="영수증/기타">영수증/기타</option>
															</c:when>
															<c:when test="${inquiry.category == '주문/결제'}">
																<option value="이용문의">이용문의</option>
																<option value="배송">배송</option>
																<option value="환불/반품/교환">환불/반품/교환</option>
																<option value="주문/결제" selected>주문/결제</option>
																<option value="영수증/기타">영수증/기타</option>
															</c:when>
															<c:otherwise>
																<option value="이용문의">이용문의</option>
																<option value="배송">배송</option>
																<option value="환불/반품/교환">환불/반품/교환</option>
																<option value="주문/결제">주문/결제</option>
																<option value="영수증/기타" selected>영수증/기타</option>
															</c:otherwise>
														</c:choose>
													</select>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>제목</span></th>
												<td>
													<input type="text" class="wlong" name="title" value="${inquiry.title}" required>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>상세 내용</span></th>
												<td>
													<textarea class="tta" name="content" maxlength=10000 required>${inquiry.content}</textarea>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>기존 첨부파일</span></th>
												<td>
													<input type="text" name="filename" value="${filename}" hidden>
													<c:choose>
														<c:when test="${inquiry.filename == null || inquiry.filename == ''}">
															<input type="text" class="wlong" value="(없음)" class="fileType" readonly>
														</c:when>
														<c:otherwise>
															<input type="text" class="wlong" value="${inquiry.filename}" class="fileType" readonly>
														</c:otherwise>
													</c:choose>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>첨부파일 편집</span></th>
												<td>
													<input type="radio" name="attached" id="hold" value="hold" class="attached" checked><label for="hold" class="attached-label">유지</label>
													<input type="radio" name="attached" id="delete" class="attached" value="delete"><label for="delete" class="attached-label">삭제</label>
													<input type="radio" name="attached" id="change" class="attached" value="change"><label for="change" class="attached-label">변경</label>
													<input type="file" name="file" class="fileType">
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