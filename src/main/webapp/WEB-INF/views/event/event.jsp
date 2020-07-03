<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp"%>
	<!--[if lt IE 9]>
		<script type="text/javascript" src="../js/html5.js"></script>
		<script type="text/javascript" src="../js/respond.min.js"></script>
		<![endif]-->
	<script type="text/javascript">
		$(document).ready(function() {
	
		});
	</script>
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
			margin-left : 20px;
		}
		.schedule {
			color: #46AAEB;
		}
		#event_end {
			color: #bebebe;
		}
		
		
		#webSearchBtn {
			width: 60px; height: 20px;
			background: url("/img/temp/btn/btn_search.gif") no-repeat center;
			border: 0px;
		}
		#webSearchBtn:hover {
			cursor: pointer;
		}
		#mobileSearchBtn {
			width: 20px; height: 20px;
			background: url("/img/temp/btn/btn_search_m.gif") no-repeat center;
			border: 0px;
		}
		#mobileSearchBtn:hover {
			cursor: pointer;
		}
	</style>

</head>
<body>

	<!--익스레이어팝업-->
	<%@ include file="../common/explorer.jsp"%>

	<div id="allwrap">
		<div id="wrap">

			<%@ include file="../common/header.jsp"%>
			<%@ include file="../common/nav.jsp"%>

			<!-- container -->
			<div id="container">

				<div id="location">
					<ol>
						<li><a href="/">HOME</a></li>
						<li><a href="/event/event">EVENT</a></li>
						<li class="last">이벤트</li>
					</ol>
				</div>

				<div id="outbox">
					<%@ include file="sidemenu.jsp"%>
					<script type="text/javascript">	initSubmenu(1, 0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2>
								<strong>이벤트</strong>
								<span>밀페이지의 특별한 혜택이 가득한 이벤트에 참여해 보세요.</span>
							</h2>

							<!-- list -->
							<div class="eventList">
								<ul>
									<!-- 반복 -->
									<li>
										<c:forEach var="eventList" items="${eventList }" varStatus="vs">
										
										
										<div class="img">
											<a href="/event/eventView/${eventList.getSeqKey() }/${page}"><img src="/files/event/${eventList.getTitleImageFilename() }"
												alt="이벤트 썸네일" /></a>
										</div>
										<c:if test="${!vs.last }">
										<div class="txt">
										</c:if>
										<c:if test="${vs.last }">
										<div class="txt" style="border-bottom: 0px;">
										</c:if>
											<c:choose>
												<c:when test="${eventList.getNowTimeDifference() >= 0}">
													<div class="subject">
														<a href="/event/eventView/${eventList.getSeqKey() }/${page}" id="ing_title">${eventList.getTitle() }</a>
													</div>
												</c:when>
												<c:otherwise>
													<div class="subject" >
														<a href="/event/eventView/${eventList.getSeqKey() }/${page}" >${eventList.getTitle() }</a>
													</div>
												</c:otherwise>
											</c:choose>
											
											<div class="day">
												<jsp:useBean id="now" class="java.util.Date" />
												<fmt:formatDate value="${now }" pattern="yyyy-MM-dd" var="today"/>
												<fmt:formatDate value="${eventList.getStartDate() }" pattern="yyyy-MM-dd" var="eStartDate"/>
												<fmt:formatDate value="${eventList.getEndDate() }" pattern="yyyy-MM-dd" var="eEndDate"/>
												이벤트 기간 : ${eStartDate } ~ ${eEndDate }
												<c:choose>
													<c:when test="${eStartDate > today }">
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
												
												
																			
											</div>
										</div>
										
										</c:forEach>
									</li>
									<!-- //반복 -->

									
								</ul>
							</div>
							<!-- //list -->
							
							<!-- 전체리스트의 경우 페이징 -->
							<c:if test="${eventState == 1 && listSize != 0 }">
							<div class="btnAreaList">
								<!-- 페이징이동1 -->
								<div class="allPageMoving1">

									<a href="/event/event/1/1" class="n">
										<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />									
									</a>
									
									<!-- 이전페이지 -->
									<c:if test="${page <= 1 }">
										<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
									</c:if>
									<c:if test="${page > 1 }">
										<a href="/event/event/${page-1 }/1" class="pre" > 
											<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
										</a>
									</c:if>
									
									<!-- 순차적으로 페이지 출력 -->
									<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
										<c:choose>
											<c:when test="${i == page }">
												<strong>${i }</strong>
											</c:when>
											<c:when test="${i != page }">
												<a href="/event/event/${i}/1" >
												${i }
												</a>
											</c:when>
										</c:choose>
									</c:forEach>
									
									<!-- 다음페이지 -->
									<c:if test="${page >= maxPage }">
										<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
									</c:if>
									<c:if test="${page < maxPage }">
										<a href="/event/event/${page+1 }/1" class="next">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</a>
									</c:if>
									
									<!-- 마지막페이지로 -->
									<a href="/event/event/${maxPage }/1" class="n">
										<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
									</a>

								</div>
								<!-- //페이징이동1 -->
							</div>
							</c:if>
							
							<!-- 검색한 경우 페이징 -->
							<c:if test="${eventState == 2 && listSize != 0 }">
							<div class="btnAreaList">
								<!-- 페이징이동1 -->
								<div class="allPageMoving1">

									<a href="/event/eventSearch/1/2/${searchClassification }/${searchInput}" class="n">
										<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />									
									</a>
									
									<!-- 이전페이지 -->
									<c:if test="${page <= 1 }">
										<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
									</c:if>
									<c:if test="${page > 1 }">
										<a href="/event/eventSearch/${page-1 }/2/${searchClassification }/${searchInput}" class="pre" > 
											<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
										</a>
									</c:if>
									
									<!-- 순차적으로 페이지 출력 -->
									<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
										<c:choose>
											<c:when test="${i == page }">
												<strong>${i }</strong>
											</c:when>
											<c:when test="${i != page }">
												<a href="/event/eventSearch/${i}/2/${searchClassification }/${searchInput}" >
												${i }
												</a>
											</c:when>
										</c:choose>
									</c:forEach>
									
									<!-- 다음페이지 -->
									<c:if test="${page >= maxPage }">
										<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
									</c:if>
									<c:if test="${page < maxPage }">
										<a href="/event/eventSearch/${page+1 }/2/${searchClassification }/${searchInput}" class="next">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</a>
									</c:if>
									
									<!-- 마지막페이지로 -->
									<a href="/event/eventSearch/${maxPage }/2/${searchClassification }/${searchInput}" class="n">
										<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
									</a>

								</div>
								<!-- //페이징이동1 -->
							</div>
							</c:if>

							<!-- 검색 -->
							<div class="searchWrap">
								<div class="search">
									<form action="/event/eventSearch" name="noticeSearch" method="get">
									<ul>
										<li class="web"><img src="/img/temp/txt/txt_search.gif"
											alt="search" /></li>
										<li class="se">
											<select name="searchClassification">
												<option value="title" >제목</option>
												<option value="content">내용</option>
												<option value="all">제목+내용</option>
											</select>
										</li>
										<li>
											<input type="text" class="searchInput" name="searchInput"/>
										</li>
										<li class="web">
											<input type="submit" value="" id="webSearchBtn"/>
										</li>
										<li class="mobile">
											<input type="submit" value="" id="mobileSearchBtn"/>
										</li>
									</ul>
									</form>
								</div>
							</div>
							<!-- //검색 -->

						</div>
					</div>
					<!-- //contents -->

				</div>

			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp"%>

		</div>
	</div>
</body>
</html>