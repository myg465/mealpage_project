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
		.eventList ul li .txt {
			padding-bottom: 10px;
			margin-bottom: 30px;
			border-bottom: 1px dashed gray;
		}
		
		.subject {
			padding-top: 5px;
		}
		
		#ing_title {
			color: #000;
		}
		
		.day strong {
			font-weight: 700;
			font-size: 20px;
			margin-left: 20px;
		}
		
		.txt strong {
			margin-left: 300px;
			font-size: 20px;
		}
		.schedule {
			color: #46AAEB !important;
		}
		#event_end {
			color: #bebebe;
		}
		
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
			alert("이벤트글이 정상적으로 수정되었습니다.");
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
			<script type="text/javascript">initSubmenu(4,0);</script>
			<div id="contents">
				<h2>
					<strong>이벤트</strong>
				</h2>
				<div id="mypage">

					<div class="viewDivMt">
						<div class="viewHead">
							<div class="subject">
								<ul>
									<li>${eventView.getTitle() }</li>
								</ul>
							</div>
							<div class="day">
								<jsp:useBean id="now" class="java.util.Date" />
								<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today"/>
								<fmt:formatDate value="${eventView.getStartDate() }" pattern="yyyy-MM-dd" var="eStartDate" />
								<fmt:formatDate value="${eventView.getEndDate() }" pattern="yyyy-MM-dd" var="eEndDate" />
								<p class="txt">
									이벤트 기간<span>${eStartDate } ~ ${eEndDate }</span>
									<c:choose>
										<c:when test="${eStartDate > today }">
											<strong class="schedule">진행예정</strong>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${eventView.getNowTimeDifference() >= 0}">
													<strong>D-${eventView.getNowTimeDifference() }</strong>	
												</c:when>
												<c:otherwise>
													<strong id="event_end">END</strong>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</p>
							</div>
						</div>

						<div class="viewContents">
							<div>${eventView.getContent() }</div>
							<br /> <img
								src="/files/event/${eventView.getContentImageFilename() }"
								alt="" width="100%" />
						</div>
					</div>

					<!-- Btn Area -->
					<div class="btnArea btline" style="margin-bottom: 30px">
						<div class="bRight">
							<ul>
								<li><a href="/admin/event/event/modify/view/${eventView.getSeqKey() }/${page}" class="sbtnMini mw">수정</a></li>
								<li><a href="/admin/event/event/delete/${eventView.getSeqKey() }/${eventView.getTitleImageFilename() }/${eventView.getContentImageFilename() }" class="sbtnMini mw" 
										onclick="return confirm('삭제 하시겠습니까?\n 삭제시 복구가 어렵습니다.')">삭제</a></li>
								<li><a href="/admin/event/event" class="sbtnMini mw">목록</a></li>
							</ul>
						</div>
					</div>
					<!-- //Btn Area -->

					<div class="orderDivMt">
						<table summary="제목, 이벤트기간, 남은기간으로 이벤트을 조회 하실수 있습니다."
							class="orderTable2" border="1" cellspacing="0">
							<caption>이벤트 보기</caption>
							<colgroup>
								<col width="*" class="tnone" />
								<col width="30%" />
								<col width="10%" class="tw25" />
							</colgroup>
							<thead>
								<th scope="col" class="tnone">제목</th>
								<th scope="col">이벤트기간</th>
								<th scope="col">남은기간</th>
							</thead>
							<tbody>
								<c:forEach var="eventList" items="${eventList }">
									<tr>
										<td class="tnone">
											<c:if
												test="${eventList.getSeqKey() == seqKey}">
												<strong style="font-size: 17px;"> >
													${eventList.getTitle() } </strong>
											</c:if>
											<c:if test="${eventList.getSeqKey() != seqKey}">
												<a
													href="/admin/event/event/view/${eventList.getSeqKey() }/${page }"
													style="text-align: left;">${eventList.getTitle() }</a>
											</c:if></td>
										<td class="left">
											<fmt:formatDate value="${eventList.getStartDate() }" pattern="yyyy-MM-dd"	var="eListStartDate" />
											<fmt:formatDate value="${eventList.getEndDate() }" pattern="yyyy-MM-dd" var="eListEndDate" />
											 ${eListStartDate } ~ ${eListEndDate }
										</td>
										<td>
											<c:choose>
												<c:when test="${eListStartDate > today }">
													<strong class="schedule">진행예정</strong>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${eventList.getNowTimeDifference() >= 0}">
															<strong>D-${eventList.getNowTimeDifference() }</strong>	
														</c:when>
														<c:otherwise>
															<strong id="event_end">END</strong>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
											<%-- <c:choose>
												<c:when test="${eventView.getNowTimeDifference() >= 0}">
													<strong id="event_ing">D-${eventView.getNowTimeDifference() }</strong>
												</c:when>
												<c:otherwise>
													<strong id="event_end">END</strong>
												</c:otherwise>
											</c:choose> --%>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="btnAreaList">
						<!-- 페이징이동1 -->
						<div class="allPageMoving1">
							<!-- 처음페이지로 -->
							<a href="/admin/event/event/view/${seqKey }/1" class="n"> <img
								src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />
							</a>

							<!-- 이전페이지 -->
							<c:if test="${page <= 1 }">
								<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
							</c:if>
							<c:if test="${page > 1 }">
								<a href="/admin/event/event/view/${seqKey }/${page-1 }" class="pre">
									<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
								</a>
							</c:if>

							<!-- 순차적으로 페이지 출력 -->
							<c:forEach var="i" begin="${startPage }" end="${endPage }"
								step="1">
								<c:choose>
									<c:when test="${i == page }">
										<strong>${i }</strong>
									</c:when>
									<c:when test="${i != page }">
										<a href="/admin/event/event/view/${seqKey }/${i}"> ${i } </a>
									</c:when>
								</c:choose>
							</c:forEach>

							<!-- 다음페이지 -->
							<c:if test="${page >= maxPage }">
								<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
							</c:if>
							<c:if test="${page < maxPage }">
								<a href="/admin/event/event/view/${seqKey }/${page+1 }" class="next">
									<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
								</a>
							</c:if>

							<!-- 마지막페이지로 -->
							<a href="/admin/event/event/view/${seqKey }/${maxPage }" class="n">
								<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
							</a>

						</div>
						<!-- //페이징이동1 -->
					</div>
				</div>
			</div>
	</main>

	<%@ include file="../common/admin_footer.jsp"%>
</body>
</html>
