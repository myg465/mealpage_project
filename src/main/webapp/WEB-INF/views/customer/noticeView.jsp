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
						<li><a href="#">HOME</a></li>
						<li><a href="#">CUSTOMER</a></li>
						<li class="last">NOTICE</li>
					</ol>
				</div>

				<div id="outbox">
					<%@ include file="sidemenu.jsp"%>
					<script type="text/javascript">	initSubmenu(1, 0);</script>
					<!-- contents -->
					<div id="contents">
						<div id="customer">
							<h2>
								<strong>NOTICE</strong><span>밀페이지 소식을 전해드립니다.</span>
							</h2>

							<div class="viewDivMt" style="border-bottom : 1px solid #918277" >
								<div class="viewHead">
									<div class="subject">
										<ul>
											<li>${customerNoticeVo.getTitle() }</li>
										</ul>
									</div>
									<div class="day">
										<p class="txt">
											작성일
											<span>
												<fmt:formatDate value="${customerNoticeVo.getCreatedDate() }"
															pattern="YYYY-MM-dd"/>
											</span>
										</p>
									</div>
								</div>

								<div class="viewContents" >
									${customerNoticeVo.getContent() }<br/>
									
									
									<c:if test="${customerNoticeVo.getContentImageFilename() != null && customerNoticeVo.getContentImageFilename() != ''}">
										<img alt="공지사항 내용 이미지" src="/files/customer/notice/${customerNoticeVo.getContentImageFilename()}" style="width: 100%">
									</c:if>
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
													
													<c:if test="${noticeList.getSeqKey() == seqKey}">
														<strong style="font-size:17px"> > ${noticeList.getTitle() }	</strong>
													</c:if>
													<c:if test="${noticeList.getSeqKey() != seqKey}">
														<a href="/customer/noticeView/${noticeList.getSeqKey() }/${page }">${noticeList.getTitle() }</a>
													</c:if>
													
													<c:if test="${noticeList.getNowTimeDifference() >= 0 && noticeList.getNowTimeDifference() <= 7}">
														<img src="/img/temp/ico/ico_new.gif" alt="NEW" />
													</c:if>
												</td>	
												<td>
													<fmt:formatDate value="${noticeList.getCreatedDate() }"
														pattern="YYY-MM-dd"/>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

							<%-- <!-- 이전다음글 -->
							<div class="pnDiv web">
								<table summary="이전다음글을 선택하여 보실 수 있습니다." class="preNext"
									border="1" cellspacing="0">
									<caption>이전다음글</caption>
									<colgroup>
										<col width="100px" />
										<col width="*" />
									</colgroup>
									<tbody>
										<tr>
											<th class="pre">PREV</th>
											<td><a href="#">상품 재입고는 언제 되나요?</a></td>
										</tr>

										<tr>
											<th class="next">NEXT</th>
											<td>다음 글이 없습니다.</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- //이전다음글 --> --%>



							<div class="btnAreaList">
								<!-- 페이징이동1 -->
								<div class="allPageMoving1">
									<!-- 처음페이지로 -->
									<a href="/customer/noticeView/${seqKey }/1" class="n">
										<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />									
									</a>
									
									<!-- 이전페이지 -->
									<c:if test="${page <= 1 }">
										<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
									</c:if>
									<c:if test="${page > 1 }">
										<a href="/customer/noticeView/${seqKey }/${page-1 }" class="pre" > 
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
												<a href="/customer/noticeView/${seqKey }/${i}" >
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
										<a href="/customer/noticeView/${seqKey }/${page+1 }" class="next">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</a>
									</c:if>
									
									<!-- 마지막페이지로 -->
									<a href="/customer/noticeView/${seqKey }/${maxPage }" class="n">
										<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
									</a>
									

								</div>
								<!-- //페이징이동1 -->
							</div>



							<!-- Btn Area -->
							<div class="btnArea btline">
								<div class="bRight">
									<ul>
										<li><a href="/customer/notice" class="sbtnMini mw">목록</a></li>
									</ul>
								</div>
							</div>
							<!-- //Btn Area -->

						</div>
					</div>
					<!-- //contents -->


				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>


			



		</div>
	</div>
</body>
</html>