<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
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
						<li><a href="/customer/notice">CUSTOMER</a></li>
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

							<div class="orderDivMt">
								<table summary="NO, 제목, 등록일, 조회수 순으로 공지사항을 조회 하실수 있습니다."
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
													<a href="/customer/noticeView/${noticeList.getSeqKey() }/${page}">${noticeList.getTitle() }</a>
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

							<c:if test="${nomalOrSearch == 1 && listSize != 0 }">
							<div class="btnAreaList">
								<!-- 페이징이동1 -->
								<div class="allPageMoving1">
									<!-- 처음페이지로 -->
									<a href="/customer/notice/1/1" class="n">
										<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />									
									</a>
									
									<!-- 이전페이지 -->
									<c:if test="${page <= 1 }">
										<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
									</c:if>
									<c:if test="${page > 1 }">
										<a href="/customer/notice/${page-1 }/1" class="pre" > 
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
												<a href="/customer/notice/${i}/1" >
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
										<a href="/customer/notice/${page+1 }/1" class="next">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</a>
									</c:if>
									
									<!-- 마지막페이지로 -->
									<a href="/customer/notice/${maxPage }/1" class="n">
										<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
									</a>
									

								</div>
								<!-- //페이징이동1 -->
							</div>
							</c:if>
							
							<!-- 검색한 경우 -->
							<c:if test="${nomalOrSearch == 2 && listSize != 0 }">
							<div class="btnAreaList">
								<!-- 페이징이동1 -->
								<div class="allPageMoving1">
									<!-- 처음페이지로 -->
									<a href="/customer/noticeSearch/1/2/${searchClassification }/${searchInput}" class="n">
										<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />									
									</a>
									
									<!-- 이전페이지 -->
									<c:if test="${page <= 1 }">
										<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
									</c:if>
									<c:if test="${page > 1 }">
										<a href="/customer/noticeSearch/${page-1 }/2/${searchClassification }/${searchInput}" class="pre" > 
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
												<a href="/customer/noticeSearch/${i}/2/${searchClassification }/${searchInput}" >
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
										<a href="/customer/noticeSearch/${page+1 }/2/${searchClassification }/${searchInput}" class="next">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</a>
									</c:if>
									
									<!-- 마지막페이지로 -->
									<a href="/customer/noticeSearch/${maxPage }/2/${searchClassification }/${searchInput}" class="n">
										<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
									</a>
									

								</div>
								<!-- //페이징이동1 -->
							</div>
							</c:if>
							<c:if test="${listSize == 0 }">
									<div class="noData">검색된 결과가 없습니다.</div>		
							</c:if>

							<div class="searchWrap">
								<div class="search">
									<form action="/customer/noticeSearch" name="noticeSearch" method="get">
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
							<!-- //포토 구매후기 -->


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