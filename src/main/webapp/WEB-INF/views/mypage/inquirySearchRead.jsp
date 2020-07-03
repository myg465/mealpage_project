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
							<h2><strong>1:1문의</strong><span>밀페이지에 궁금하신 사항을 남겨주시면 답변해드립니다.</span></h2>
							
							<%@ include file="myinfo.jsp" %>

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

							<!-- 답변 -->
							<div class="answer">
								<div class="inbox">
									<c:choose>
										<c:when test="${inquiry.replyCreatedDate == null}">
											<div class="atxt">
												현재 답변대기 중입니다. 고객님의 문의에 최대한 빨리 답변드릴 수 있도록 노력하겠습니다.
											</div>
										</c:when>
										<c:otherwise>
											<div class="aname">
												<p>담당자
													<span>
														<fmt:parseDate var="replyCreatedDate" value="${inquiry.replyCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"/>	
														[<fmt:formatDate value="${replyCreatedDate}" pattern="yyyy-MM-dd HH:mm"/>]	
													</span>
												</p>
											</div>
											<div class="atxt">
												${inquiry.reply}
											</div>
										</c:otherwise>
									</c:choose>	
								</div>
							</div>
							<!-- //답변 -->

							<!-- Btn Area -->
							<div class="btnArea">
								<div class="bRight">
									<ul>
										<c:if test="${inquiry.replyCreatedDate == null}">
											<li><a href="/inquiry/0/modify/${inquiry.seqKey}" class="nbtnbig mw">수정</a></li>
											<li><a href="/inquiry/delete/${inquiry.seqKey}" class="nbtnbig mw" onclick="return confirm('삭제하시겠습니까?')">삭제</a></li>
										</c:if>
										<li><a href="/inquiry" class="sbtnMini mw">목록</a></li>
									</ul>
								</div>
							</div>
							<!-- //Btn Area -->
							
							<br><br>
							<div style="text-align: center;">
								[ '${keyword}' 키워드로 게시물을 검색했습니다. <a href="/inquiry"><button type="button">목록으로</button></a> ]
							</div>
							<div class="orderDivNm">
								<table class="orderTable2" border="1" cellspacing="0">
									<colgroup>
										<col width="9%" class="tnone" />
										<col width="14%" class="tw20" />
										<col width="*" />
										<col width="15%" class="tnone" />
										<col width="15%" class="tw30" />
									</colgroup>
									<thead>
										<th scope="col" class="tnone">NO.</th>
										<th scope="col">분류</th>
										<th scope="col">제목</th>
										<th scope="col" class="tnone">등록일</th>
										<th scope="col">처리상태</th>
									</thead>
									<tbody>
										<c:set var="inquiryNum" value="${count + 1}" />
										<c:if test="${page > 1}">
											<c:set var="inquiryNum" value="${count - ((page-1)*10) + 1}" />
										</c:if>
										<c:forEach var="inquiry" items="${inquiryList}">
											<c:set var="inquiryNum" value="${inquiryNum - 1}" />
											<tr>
												<td class="tnone">${inquiryNum}</td>
												<td>${inquiry.category}</td>
												<td class="left"><a href="/inquiry/search/${type}/${keyword}/${page}/read/${inquiry.seqKey}">${inquiry.title}</a></td>
												<td class="tnone">
													<fmt:parseDate var="createdDate" value="${inquiry.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
													<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
												</td>
												<td>
													<ul class="state">
														<li>
															<c:choose>
																<c:when test="${inquiry.replyCreatedDate == null}">
																	<div class="nbtnMini iw83">답변대기</div>
																</c:when>
																<c:otherwise>
																	<div class="obtnMini iw83">답변완료</div>
																</c:otherwise>
															</c:choose>	
														</li>
													</ul>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>

								<c:if test="${inquiryList.isEmpty()}">
									<div class="noData">
										검색된 내용이 없습니다.
									</div>
								</c:if>
							</div>

							<div class="btnAreaList">							
								<div class="bwright">
									<ul>
										<li><a href="/inquiry/write" class="writeBtn">글쓰기</a></li>
									</ul>
								</div>

								<%-- 페이지 네비게이션 시작 --%>
								<div class="page-nav">
									<c:if test="${page != 1}">
										<a href="/inquiry/search/${type}/${keyword}/1" class="page-nav-nobox">
											<i class="fas fa-angle-double-left paging"></i>
										</a>
										<a href="/inquiry/search/${type}/${keyword}/${page - 1}" class="page-nav-nobox">
											<i class="fas fa-angle-left paging"></i>
										</a>
									</c:if>

									<c:forEach var="i" begin="${startPage}" end="${endPage}">
										<c:choose>
											<c:when test="${i == page}">
												<a href="/inquiry/search/${type}/${keyword}/${i}" class="page-nav-now">${i}</a>
											</c:when>
											<c:otherwise>
												<a href="/inquiry/search/${type}/${keyword}/${i}" class="page-nav-box">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>

									<c:if test="${page != pages && !inquiryList.isEmpty()}">
										<a href="/inquiry/search/${type}/${keyword}/${page + 1}" class="page-nav-nobox">
											<i class="fas fa-angle-right paging"></i>
										</a>
										<a href="/inquiry/search/${type}/${keyword}/${pages}" class="page-nav-nobox">
											<i class="fas fa-angle-double-right paging"></i>
										</a>
									</c:if>

									<%-- 검색 폼 --%>
									<form action="/inquiry/search" method="post">
										<div class="searchWrap">
											<div class="search">
												<ul>
													<li class="web"><img src="/img/temp/txt/txt_search.gif" alt="search" /></li>
													<li class="se">
														<select name="searchType">
															<option value="title">제목</option>
															<option value="content">내용</option>
															<option value="reply">회신</option>
														</select>
													</li>
													<li><input type="text" class="searchInput" name="searchText" required></li>
													<li class="web"><button type="submit" class="no-outline"><img src="/img/temp/btn/btn_search.gif" alt="검색" /></button></li>
													<li class="mobile"><button type="submit" class="no-outline"><img src="/img/temp/btn/btn_search_m.gif" alt="검색" /></button></li>
												</ul>
											</div>
										</div>
									</form>

								</div>
								<%-- 페이지 네비게이션 끝 --%>
							</div>
							
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