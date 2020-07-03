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
								회원명
								<span>${name} (${id})</span>
							</p>
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
							<c:choose>
								<c:when test="${inquiry.replyCreatedDate == null}">
									<li><a href="/admin/board/inquiry/delete/${inquiry.seqKey}" class="nbtnbig mw" onclick="return confirm('삭제하시겠습니까?')">문의삭제</a></li>
									<li><a href="/admin/board/inquiry/${page}/reply/${inquiry.seqKey}" class="nbtnbig mw">답변하기</a></li>
								</c:when>
								<c:otherwise>
									<li><a href="/admin/board/inquiry/delete/${inquiry.seqKey}" class="nbtnbig mw" onclick="return confirm('삭제하시겠습니까?')">문의삭제</a></li>
									<li><a href="/admin/board/inquiry/${page}/deleteReply/${inquiry.seqKey}" class="nbtnbig mw" onclick="return confirm('삭제하시겠습니까?')">답변삭제</a></li>
									<li><a href="/admin/board/inquiry/0/modifyReply/${inquiry.seqKey}" class="nbtnbig mw">답변수정</a></li>
								</c:otherwise>
							</c:choose>
							<li><a href="/admin/board/inquiry/${page}" class="sbtnMini mw">목록</a></li>
						</ul>
					</div>
				</div>
				<!-- //Btn Area -->
				
				<br><br>
				<div style="text-align: center;">
					[ '${keyword}' 키워드로 게시물을 검색했습니다. <a href="/admin/board/inquiry"><button type="button">목록으로</button></a> ]
				<div class="orderDivNm">
					<table class="orderTable2" border="1" cellspacing="0">
						<colgroup>
							<col width="5%" class="tnone" />
							<col width="12%" class="tnone" />
							<col width="15%" class="tnone" />
							<col width="*" />
							<col width="15%" class="tw30" />
							<col width="15%" class="tw30" />
						</colgroup>
						<thead>
							<th scope="col" class="tnone">NO.</th>
							<th scope="col">회원명</th>
							<th scope="col">분류</th>
							<th scope="col">제목</th>
							<th scope="col" class="tnone">등록일</th>
							<th scope="col">처리상태</th>
						</thead>
						<tbody>
							<c:forEach var="inquiry" items="${inquiryList}">
								<tr>
									<td class="tnone">${inquiry.seqKey}</td>
									<td>
										${inquiry.name}<br>
										(${inquiry.id})
									</td>
									<td>${inquiry.category}</td>
									<td class="left"><a href="/admin/board/inquiry/search/${type}/${keyword}/${page}/read/${inquiry.seqKey}">${inquiry.title}</a></td>
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
							문의 하신 내용이 없습니다.
						</div>
					</c:if>
				</div>
				<div class="btnAreaList">		
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/board/inquiry/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/board/inquiry/${page - 1}" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/board/inquiry/${i}" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/board/inquiry/${i}" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != pages && !inquiryList.isEmpty()}">
							<a href="/admin/board/inquiry/${page + 1}" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/board/inquiry/${pages}" class="page-nav-nobox">
								<i class="fas fa-angle-double-right paging"></i>
							</a>
						</c:if>
					</div>
					<%-- 페이지 네비게이션 끝 --%>
				</div>

				<%-- 검색 폼 --%>
				<form action="/admin/board/inquiry/search" method="post">
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
		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
