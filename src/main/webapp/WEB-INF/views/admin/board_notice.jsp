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

	<style type="text/css">
		.page-nav { 
			margin:30px 0 0 0; 
		}
		.page-nav * { 
			vertical-align:top; 
		}
		.page-nav-box { 
			display:inline-block; 
			width:25px; height:25px; 
			line-height:23px; 
			color:#888; 
			text-decoration:none;  
			border:1px #c0c0c0 solid; 
			background:#fff; 
			font-size:12px;
		 }
		.page-nav-nobox { 
			display:inline-block; 
			width:25px; height:25px; 
			color:#888; 
			font-size: 16px; 
			position: relative; 
			top: 5px;
		}
		.page-nav-now { 
			display:inline-block; 
			width:25px; height:25px; 
			line-height:23px; 
			color:steelblue; 
			text-decoration:none; 
			border:1px steelblue solid; 
			background:#fff; 
			font-size:12px; 
			font-weight:normal; 
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
	<!-- 작성된 내용이 정상적으로 DB에 저장 되었는지 알림 -->
	<c:if test="${param.insertCheck == 1}">
		<script type="text/javascript">
			alert("공지사항이 정상적으로 작성되었습니다.");
		</script>
	</c:if>
	<c:if test="${param.insertCheck != 1 && param.insertCheck != null}">
		<script type="text/javascript">
			alert("오류가 발생 했습니다. 다시 시도해 주세요.");
			history.back(-1);
		</script>
	</c:if>
	
	<!-- 공지사항글이 정상적으로 삭제 되었는지 알림 -->
	<c:if test="${param.deleteCheck == 1}">
		<script type="text/javascript">
			alert("공지사항이 정상적으로 삭제되었습니다.");
		</script>
	</c:if>
	<c:if test="${param.deleteCheck != 1 && param.deleteCheck != null}">
		<script type="text/javascript">
			alert("오류가 발생 했습니다. 다시 시도해 주세요.");
			history.back(-1);
		</script>
	</c:if>

	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="board_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(3,0);</script>
			<div id="contents">
				<h2>
					<strong>공지사항</strong>
				</h2>
				<div class="orderDivNm">
					<table class="orderTable2" border="1" cellspacing="0">
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
										<a href="/admin/customer/notice/view/${noticeList.getSeqKey() }/${page}">${noticeList.getTitle() }</a>
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

					<c:if test="${listSize == 0}">
						<div class="noData">
							공지사항이 없습니다.
						</div>
					</c:if>
				</div>
				
				<!-- 검색이 아닌 경우(일반적인 경우) -->
				<c:if test="${nomalOrSearch == 1 && listSize != 0 }">
				<div class="btnAreaList">		
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/customer/notice/1/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/customer/notice/${page - 1}/1" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/customer/notice/${i}/1" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/customer/notice/${i}/1" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != maxPage && !noticeList.isEmpty()}">
							<a href="/admin/customer/notice/${page + 1}/1" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/customer/notice/${maxPage }/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-right paging"></i>
							</a>
						</c:if>
					</div>
					<%-- 페이지 네비게이션 끝 --%>
				</div>
				</c:if>
				
				<!-- 검색한 경우 -->
				<c:if test="${nomalOrSearch == 2 && listSize != 0 }">
				<div class="btnAreaList">		
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/customer/notice/search/1/2/${searchClassification }/${searchInput}" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/customer/notice/search/${page - 1}/2/${searchClassification }/${searchInput}" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/customer/notice/search/${i}/2/${searchClassification }/${searchInput}" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/customer/notice/search/${i}/2/${searchClassification }/${searchInput}" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != maxPage && !noticeList.isEmpty()}">
							<a href="/admin/customer/notice/search/${page + 1}/2/${searchClassification }/${searchInput}" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/customer/notice/search/${maxPage }/2/${searchClassification }/${searchInput}" class="page-nav-nobox">
								<i class="fas fa-angle-double-right paging"></i>
							</a>
						</c:if>
					</div>
					<%-- 페이지 네비게이션 끝 --%>
				</div>
				</c:if>
				
				<!-- Btn Area -->
				<div class="btnArea btline">
					<div class="bRight">
						<ul>
							<li><a href="/admin/customer/notice/write/view" class="sbtnMini mw">쓰기</a></li>
						</ul>
					</div>
				</div>
				<!-- //Btn Area -->

				<%-- 검색 폼 --%>
				<form action="/admin/customer/notice/search" method="get">
					<div class="searchWrap">
						<div class="search">
							<ul>
								<li class="web"><img src="/img/temp/txt/txt_search.gif" alt="search" /></li>
								<li class="se">
									<select name="searchClassification">
										<option value="title">제목</option>
										<option value="content">내용</option>
										<option value="all">제목+내용</option>
									</select>
								</li>
								<li><input type="text" class="searchInput" name="searchInput" required></li>
								<li class="web">
									<input type="submit" value="" id="webSearchBtn"/>
								</li>
								<li class="mobile">
									<input type="submit" value="" id="mobileSearchBtn"/>
								</li>
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
