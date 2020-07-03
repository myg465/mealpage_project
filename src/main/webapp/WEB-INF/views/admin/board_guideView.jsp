<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp"%>
	<%-- custom css for admin page --%>
	<link rel="stylesheet" href="/css/custom/admin.css">
	
	<style type="text/css">
	.page-nav {
		margin: 30px 0 0 0;
	}
	
	.page-nav * {
		vertical-align: top;
	}
	
	.page-nav-box {
		display: inline-block;
		width: 25px;
		height: 25px;
		line-height: 23px;
		color: #888;
		text-decoration: none;
		border: 1px #c0c0c0 solid;
		background: #fff;
		font-size: 12px;
	}
	
	.page-nav-nobox {
		display: inline-block;
		width: 25px;
		height: 25px;
		color: #888;
		font-size: 16px;
		position: relative;
		top: 5px;
	}
	
	.page-nav-now {
		display: inline-block;
		width: 25px;
		height: 25px;
		line-height: 23px;
		color: steelblue;
		text-decoration: none;
		border: 1px steelblue solid;
		background: #fff;
		font-size: 12px;
		font-weight: normal;
	}
	</style>
</head>

<body>
	<!-- 작성된 내용이 정상적으로 수정이 되었는지 알림 -->
	<c:if test="${param.updateCheck == 1}">
		<script type="text/javascript">
			alert("이용안내 글이 정상적으로 수정되었습니다.");
		</script>
	</c:if>
	<c:if test="${param.updateCheck != 1 && param.updateCheck != null}">
		<script type="text/javascript">
			alert("오류가 발생 했습니다. 다시 시도해 주세요.");
			history.back(-1);
		</script>
	</c:if>


	<%@ include file="../common/explorer.jsp"%>
	<%@ include file="../common/admin_nav.jsp"%>

	<main>
		<div id="outbox">
			<%@ include file="board_sidemenu.jsp"%>
			<script type="text/javascript">initSubmenu(7,0);</script>
			<div id="contents">
				<div id="outbox">
					<!-- contents -->
					<div id="contents">
						<div id="customer">
							<div class="viewDivMt" style="border-bottom: 1px solid #918277">
								<div class="viewHead">
									<div class="subject">
										<ul>
											<li>${guideAdminView.getTitle() }</li>
										</ul>
									</div>
									<div class="day">
										<p class="txt">
											최초작성일 <span> <fmt:formatDate
													value="${guideAdminView.getCreatedDate() }"
													pattern="YYYY-MM-dd" />
											</span>
										</p>
									</div>
									<div class="day">
										<p class="txt">
											최근수정일 <span> <fmt:formatDate
													value="${guideAdminView.getModifiedDate() }"
													pattern="YYYY-MM-dd" />
											</span>
										</p>
									</div>
								</div>
								
								<div class="viewContents">
									${guideAdminView.getContent() }<br />
								</div>
							</div>

							<!-- Btn Area -->
							<div class="btnArea btline" style="margin-bottom: 30px">
								<div class="bRight">
									<ul>
										<li><a href="/admin/customer/guide/modify/view/${guideAdminView.getSeqKey() }/${page}" class="sbtnMini mw">수정</a></li>
										<li><a href="/admin/customer/guide/delete/${guideAdminView.getSeqKey() }" class="sbtnMini mw" 
												onclick="return confirm('삭제 하시겠습니까?\n 삭제시 복구가 어렵습니다.')">삭제</a></li>
										<li><a href="/admin/customer/guide" class="sbtnMini mw">목록</a></li>
									</ul>
								</div>
							</div>


							<div class="orderDivMt">
								<table summary="제목, 내용 순으로 이용안내를 조회 하실수 있습니다."
									class="orderTable2" border="1" cellspacing="0">
									<colgroup>
										<col width="30%" class="tnone" />
										<col width="*" />
									</colgroup>
									<thead>
										<th scope="col" class="tnone">제목</th>
										<th scope="col">내용</th>
									</thead>
									<tbody>
										<c:forEach var="guideList" items="${guideList }">
											<tr>
												<td class="tnone">${guideList.getTitle() }</td>
												<td class="left" title="${guideList.getContent() }">
													<c:if test="${guideList.getSeqKey() == seqKey}">
														<c:if test="${fn:length(guideList.getContent()) > 35}">
															<strong style="font-size: 15px"> > ${fn:substring(guideList.getContent(), 0, 34) }...</strong>
														</c:if>
														<c:if test="${fn:length(guideList.getContent()) <= 35}">
															<strong style="font-size: 15px"> > ${guideList.getContent()}</strong>
														</c:if>
													</c:if>
													
													<c:if test="${guideList.getSeqKey() != seqKey}">
														<c:choose>
															<c:when test="${fn:length(guideList.getContent()) > 35}">
																<a href="/admin/customer/guide/view/${guideList.getSeqKey() }/${page}">${fn:substring(guideList.getContent(), 0, 34) }...</a>
															</c:when>
															<c:otherwise>
																<a href="/admin/customer/guide/view/${guideList.getSeqKey() }/${page}">${guideList.getContent()}</a>
															</c:otherwise>
														</c:choose>
													</c:if>
												</td>	
											</tr>
										</c:forEach>
									</tbody>								
								</table>
							</div>
							<div class="btnAreaList">		
								<%-- 페이지 네비게이션 시작 --%>
								<div class="page-nav">
									<c:if test="${page != 1}">
										<a href="/admin/customer/guide/view/${seqKey }/1" class="page-nav-nobox">
											<i class="fas fa-angle-double-left paging"></i>
										</a>
										<a href="/admin/customer/guide/view/${seqKey }/${page - 1}" class="page-nav-nobox">
											<i class="fas fa-angle-left paging"></i>
										</a>
									</c:if>
			
									<c:forEach var="i" begin="${startPage }" end="${endPage }">
										<c:choose>
											<c:when test="${i == page}">
												<a href="/admin/customer/guide/view/${seqKey }/${i}" class="page-nav-now">${i}</a>
											</c:when>
											<c:otherwise>
												<a href="/admin/customer/guide/view/${seqKey }/${i}" class="page-nav-box">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
			
									<c:if test="${page != maxPage && !noticeList.isEmpty()}">
										<a href="/admin/customer/guide/view/${seqKey }/${page + 1}" class="page-nav-nobox">
											<i class="fas fa-angle-right paging"></i>
										</a>
										<a href="/admin/customer/guide/view/${seqKey }/${maxPage }" class="page-nav-nobox">
											<i class="fas fa-angle-double-right paging"></i>
										</a>
									</c:if>
								</div>
								<%-- 페이지 네비게이션 끝 --%>
							</div>
						</div>
					</div>
				</div>
			</div>
	</main>

	<%@ include file="../common/admin_footer.jsp"%>
</body>
</html>
