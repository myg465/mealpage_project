<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
			alert("공지사항이 정상적으로 수정되었습니다.");
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
			<script type="text/javascript">initSubmenu(3,0);</script>
			<div id="contents">
				<div id="outbox">
					<!-- contents -->
					<div id="contents">
						<div id="customer">
							<div class="viewDivMt" style="border-bottom: 1px solid #918277">
								<div class="viewHead">
									<div class="subject">
										<ul>
											<li>${customerNoticeVo.getTitle() }</li>
										</ul>
									</div>
									<div class="day">
										<p class="txt">
											작성일 <span> <fmt:formatDate
													value="${customerNoticeVo.getCreatedDate() }"
													pattern="YYYY-MM-dd" />
											</span>
										</p>
									</div>
								</div>

								<div class="viewContents">
									${customerNoticeVo.getContent() }<br />


									<c:if
										test="${customerNoticeVo.getContentImageFilename() != null && customerNoticeVo.getContentImageFilename() != ''}">
										<img alt="공지사항 내용 이미지"
											src="/files/customer/notice/${customerNoticeVo.getContentImageFilename()}"
											style="width: 100%">
									</c:if>
								</div>
							</div>

							<!-- Btn Area -->
							<div class="btnArea btline" style="margin-bottom: 30px">
								<div class="bRight">
									<ul>
										<li><a href="/admin/customer/notice/modifyView/${customerNoticeVo.getSeqKey() }/${page}" class="sbtnMini mw">수정</a></li>
										<li><a href="/admin/customer/notice/delete/${customerNoticeVo.getSeqKey() }/${customerNoticeVo.getContentImageFilename()}" class="sbtnMini mw" 
												onclick="return confirm('삭제 하시겠습니까?\n 삭제시 복구가 어렵습니다.')">삭제</a></li>
										<li><a href="/admin/customer/notice" class="sbtnMini mw">목록</a></li>
									</ul>
								</div>
							</div>


							<div class="orderDivMt">
								<table summary="NO, 제목, 등록일 순으로 공지사항을 조회 하실수 있습니다."
									class="orderTable2" border="1" cellspacing="0">
									<caption>공지사항 보기</caption>
									<colgroup>
										<col width="10%" class="tnone" />
										<col width="*" />
										<col width="14%" class="tw25" />
									</colgroup>
									<thead>
										<th scope="col" class="tnone">NO.</th>
										<th scope="col">제목</th>
										<th scope="col">등록일</th>
									</thead>
									<tbody>
										<c:forEach var="noticeList" items="${noticelist }">
											<tr>
												<td class="tnone">${noticeList.getSeqKey() }</td>
												<td class="left">
													<c:if
														test="${noticeList.getSeqKey() == seqKey}">
														<strong style="font-size: 17px"> >
															${noticeList.getTitle() } </strong>
													</c:if> <c:if test="${noticeList.getSeqKey() != seqKey}">
														<a	href="/admin/customer/notice/view/${noticeList.getSeqKey() }/${page }">${noticeList.getTitle() }</a>
													</c:if> <c:if
														test="${noticeList.getNowTimeDifference() >= 0 && noticeList.getNowTimeDifference() <= 7}">
														<img src="/img/temp/ico/ico_new.gif" alt="NEW" />
													</c:if>
												</td>
												<td>
													<fmt:formatDate value="${noticeList.getCreatedDate() }" pattern="YYY-MM-dd" />
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
										<a href="/admin/customer/notice/view/${seqKey }/1" class="page-nav-nobox">
											<i class="fas fa-angle-double-left paging"></i>
										</a>
										<a href="/admin/customer/notice/view/${seqKey }/${page - 1}" class="page-nav-nobox">
											<i class="fas fa-angle-left paging"></i>
										</a>
									</c:if>
			
									<c:forEach var="i" begin="${startPage }" end="${endPage }">
										<c:choose>
											<c:when test="${i == page}">
												<a href="/admin/customer/notice/view/${seqKey }/${i}" class="page-nav-now">${i}</a>
											</c:when>
											<c:otherwise>
												<a href="/admin/customer/notice/view/${seqKey }/${i}" class="page-nav-box">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
			
									<c:if test="${page != maxPage && !noticeList.isEmpty()}">
										<a href="/admin/customer/notice/view/${seqKey }/${page + 1}" class="page-nav-nobox">
											<i class="fas fa-angle-right paging"></i>
										</a>
										<a href="/admin/customer/notice/view/${seqKey }/${maxPage }" class="page-nav-nobox">
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
