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
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="board_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(1,0);</script>
			<div id="contents">
				<div class="viewDiv">
					<div class="viewHead">
						<div class="subject">
							<ul>
								<li class="cate">[${inquiry.category}]</li>
								<li>${inquiry.title}</li>
							</ul>
						</div>
						<div class="day">
							<p class="txt">
								등록일
								<span>
									<fmt:parseDate var="createdDate" value="${inquiry.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>	
									<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
								</span>
							</p>
							<c:if test="${inquiry.filename != null && inquiry.filename != ''}">
								<p class="txt">
									첨부파일
									<span>
										<a href="/files/inquiry/${inquiry.filename}">${inquiry.filename}</a>
									</span>
								</p>
							</c:if>
							<p class="btn">
								<c:choose>
									<c:when test="${inquiry.replyCreatedDate == null}">
										<span class="nbtnMini">답변대기</span>
									</c:when>
									<c:otherwise>
										<span class="obtnMini">답변완료</span>
									</c:otherwise>
								</c:choose>	
							</p>
						</div>
					</div>

					<div class="viewContents">
						${inquiry.content}
					</div>
				</div>

				<form action="/admin/board/inquiry/${page}/modifyReply/${key}" method="post">
					<!-- 답변 -->
					<div class="answer">
						<div class="inbox">
							<div class="atxt">
								<textarea class="tta" name="reply" maxlength=10000 required>${inquiry.reply}</textarea>
							</div>
						</div>
					</div>
					<!-- //답변 -->

					<!-- Btn Area -->
					<div class="btnArea">
						<div class="bCenter">
							<ul>
								<li><button type="reset" class="nbtnbig mw no-outline">취소</a></li>
								<li><button type="submit" class="sbtnMini mw no-outline">확인</a></li>
							</ul>
						</div>
					</div>
					<!-- //Btn Area -->
				</form>
				
			</div>
		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
