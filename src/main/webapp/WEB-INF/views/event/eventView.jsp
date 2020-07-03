<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp"%>>
	
	<!--[if lt IE 9]>
	<script type="text/javascript" src="../js/html5.js"></script>
	<script type="text/javascript" src="../js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
		$(document).ready(function() {
	
		});
	</script>
	<style type="text/css">
		.txt strong {
			margin-left: 300px;
			font-size: 20px;
		}
		.schedule {
			color: #46AAEB;
		}
		#event_end {
			color: #bebebe;
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
						<li class="last">진행중 이벤트</li>
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
										<fmt:formatDate value="${eventView.getStartDate() }" pattern="yyyy-MM-dd" var="eStartDate"/>
										<fmt:formatDate value="${eventView.getEndDate() }" pattern="yyyy-MM-dd" var="eEndDate"/>
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
									<br/>
									<img src="/files/event/${eventView.getContentImageFilename() }" alt="" width="100%"/>
								</div>
							</div>



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
													<c:if test="${eventList.getSeqKey() == seqKey}">
														<strong style="font-size:17px;"> > ${eventList.getTitle() }	</strong>
													</c:if>
													<c:if test="${eventList.getSeqKey() != seqKey}">
														<a href="/event/eventView/${eventList.getSeqKey() }/${page }" style="text-align: left;">${eventList.getTitle() }</a>
													</c:if>
												
												</td>
												<td class="left">
													<fmt:formatDate value="${eventList.getStartDate() }" pattern="yyyy-MM-dd" var="eListStartDate"/>
													<fmt:formatDate value="${eventList.getEndDate() }" pattern="yyyy-MM-dd" var="eListEndDate"/>
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
									<a href="/event/eventView/${seqKey }/1" class="n">
										<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />									
									</a>
									
									<!-- 이전페이지 -->
									<c:if test="${page <= 1 }">
										<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
									</c:if>
									<c:if test="${page > 1 }">
										<a href="/event/eventView/${seqKey }/${page-1 }" class="pre" > 
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
												<a href="/event/eventView/${seqKey }/${i}" >
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
										<a href="/event/eventView/${seqKey }/${page+1 }" class="next">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</a>
									</c:if>
									
									<!-- 마지막페이지로 -->
									<a href="/event/eventView/${seqKey }/${maxPage }" class="n">
										<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
									</a>
									

								</div>
								<!-- //페이징이동1 -->
							</div>
						
							<!-- 이전다음글 -->
							<%-- <div class="pnDiv web">
								<table summary="이전다음글을 선택하여 보실 수 있습니다." class="preNext"
									border="1" cellspacing="0">
									<caption>이전다음글</caption>
									<colgroup>
										<col width="100px" />
										<col width="*" />
										<col width="100px" />
									</colgroup>
									<tbody>
										<tr>
											<th class="pre">PREV</th>
											<td><a href="#">상품 재입고는 언제 되나요?</a></td>
											<td>&nbsp;</td>
										</tr>

										<tr>
											<th class="next">NEXT</th>
											<td>다음 글이 없습니다.</td>
											<td>&nbsp;</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- //이전다음글 -->


							<!-- 댓글-->
							<div class="replyWrite">
								<ul>
									<li class="in">
										<p class="txt">
											총 <span class="orange">3</span> 개의 댓글이 달려있습니다.
										</p>
										<p class="password">
											비밀번호&nbsp;&nbsp;<input type="password" class="replynum" />
										</p> <textarea class="replyType"></textarea>
									</li>
									<li class="btn"><a href="#" class="replyBtn">등록</a></li>
								</ul>
								<p class="ntic">※ 비밀번호를 입력하시면 댓글이 비밀글로 등록 됩니다.</p>
							</div>

							<div class="replyBox">
								<ul>
									<li class="name">jjabcde <span>[2014-03-04&nbsp;&nbsp;15:01:59]</span></li>
									<li class="txt"><textarea class="replyType"></textarea></li>
									<li class="btn"><a href="#" class="rebtn">수정</a> <a
										href="#" class="rebtn">삭제</a></li>
								</ul>

								<ul>
									<li class="name">jjabcde <span>[2014-03-04&nbsp;&nbsp;15:01:59]</span></li>
									<li class="txt">대박!!! 이거 저한테 완전 필요한 이벤트였어요!!</li>
									<li class="btn"><a href="#" class="rebtn">수정</a> <a
										href="#" class="rebtn">삭제</a></li>
								</ul>

								<ul>
									<li class="name">jjabcde <span>[2014-03-04&nbsp;&nbsp;15:01:59]</span></li>
									<li class="txt"><a href="password.html"
										class="passwordBtn"><span class="orange">※ 비밀글입니다.</span></a>
									</li>
								</ul>
							</div>
							<!-- //댓글 -->


							<!-- Btn Area -->
							<div class="btnArea">
								<div class="bRight">
									<ul>
										<li><a href="#" class="sbtnMini mw">목록</a></li>
									</ul>
								</div>
							</div>
							<!-- //Btn Area -->
							--%>
						</div> 
					</div>
					<!-- //contents -->


					<!-- <script type="text/javascript"
						src="../js/jquery.fancybox-1.3.4.pack.js"></script>
					<link rel="stylesheet" type="text/css"
						href="../css/jquery.fancybox-1.3.4.css" />
					<script type="text/javascript">
						$(function() {

							var winWidth = $(window).width();
							if (winWidth > 767) {
								var layerCheck = 540;
							} else {
								var layerCheck = 320;
							}

							$(".passwordBtn")
									.fancybox(
											{
												'autoDimensions' : false,
												'showCloseButton' : false,
												'width' : layerCheck,
												'padding' : 0,
												'type' : 'iframe',
												'onComplete' : function() {
													$('#fancybox-frame')
															.load(
																	function() { // wait for frame to load and then gets it's height
																		$(
																				'#fancybox-content')
																				.height(
																						$(
																								this)
																								.contents()
																								.find(
																										'body')
																								.height());
																	});
												}
											});

						});
					</script> -->

				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp"%>

		</div>
	</div>
</body>
</html>