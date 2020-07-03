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
	
		.faqTab ul li a {
			width: 91px;
		}
		.faqTab ul li.last a {
			width: 94px;
		}
	
	
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
	<script type="text/javascript">
		$(document).ready(function(){
	     	var category='<c:out value="${category_}"/>';
	      	switch(category){
		         case 'account' :
		        	$('#total').attr('class', '');
		            $('#account').attr('class', 'on');
		            break;
		            
		         case 'point' :
		        	$('#total').attr('class', '');
		            $('#point').attr('class', 'on');
		            break;
	
				 case 'point' :
		        	$('#total').attr('class', '');
		            $('#order').attr('class', 'on');
		            break;
		            
		         case 'order' :
		        	$('#total').attr('class', '');
		            $('#order').attr('class', 'on');
		            break;
		            
		         case 'refund' :
		        	$('#total').attr('class', '');
		            $('#refund').attr('class', 'on');
		            break;
		            
		         case 'shipping' :
		        	$('#total').attr('class', '');
		            $('#shipping').attr('class', 'on');
		            break;
		            
		         case 'etc' :
		        	$('#total').attr('class', '');
		            $('#etc').attr('class', 'on');
		            break;
	     	 }
	     });
	</script>
</head>

<body>
	<!-- 작성된 내용이 정상적으로 DB에 저장 되었는지 알림 -->
	<c:if test="${param.insertCheck == 1}">
		<script type="text/javascript">
			alert("FAQ가 정상적으로 작성되었습니다.");
		</script>
	</c:if>
	<c:if test="${param.insertCheck != 1 && param.insertCheck != null}">
		<script type="text/javascript">
			alert("오류가 발생 했습니다. 다시 시도해 주세요.");
			history.back(-1);
		</script>
	</c:if>

	<!-- FAQ 글이 정상적으로 삭제 되었는지 알림 -->
	<c:if test="${param.deleteCheck == 1}">
		<script type="text/javascript">
			alert("FAQ가 정상적으로 삭제되었습니다.");
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
			<script type="text/javascript">initSubmenu(6,0);</script>
			<div id="contents">
				<h2>
					<strong>FAQ</strong>
				</h2>
				
				<div class="faqTab">
					<ul>
						<li><a href="/admin/customer/faq" id="total" class="on">전체</a></li>
						<li><a href="/admin/customer/faq/category/account" id="account" class="">회원관리</a></li>
						<li><a href="/admin/customer/faq/category/point" id="point" class="">포인트/쿠폰</a></li>
						<li><a href="/admin/customer/faq/category/order" id="order" class="">주문/결제</a></li>
						<li><a href="/admin/customer/faq/category/refund" id="refund" class="">환불/교환</a></li>
						<li><a href="/admin/customer/faq/category/shipping" id="shipping" class="">배송</a></li>
						<li class="last"><a href="/admin/customer/faq/category/etc" id="etc" class="">기타</a></li>
					</ul>
				</div>
				
				
				<div class="orderDivNm">
					<table class="orderTable2" border="1" cellspacing="0">
						<colgroup>
							<col width="20%" class="tnone" />
							<col width="*" />
							<col width="15%" class="tw25" />
						</colgroup>
						<thead>
							<th scope="col" class="tnone">구분</th>
							<th scope="col">제목</th>
							<th scope="col">등록일</th>
						</thead>
						<tbody>
							<c:forEach var="faqList" items="${faqList }">
								<tr>
									<td class="tnone">${faqList.getCategory() }</td>
									<td class="left">
										<a href="/admin/customer/faq/view/${faqList.getSeqKey() }/${page}">${faqList.getTitle() }</a>
									</td>	
									<td>
										<fmt:formatDate value="${faqList.getCreatedDate() }"
											pattern="YYY-MM-dd"/>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<c:if test="${listSize == 0}">
						<div class="noData">
							FAQ가 없습니다.
						</div>
					</c:if>
				</div>
				
				<!-- 전체리스트 일때 페이징 -->
				<c:if test="${faqState == 1 && listSize != 0 }">
				<div class="btnAreaList">		
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/customer/faq/1/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/customer/faq/${page - 1}/1" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/customer/faq/${i}/1" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/customer/faq/${i}/1" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != maxPage && !noticeList.isEmpty()}">
							<a href="/admin/customer/faq/${page + 1}/1" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/customer/faq/${maxPage }/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-right paging"></i>
							</a>
						</c:if>
					</div>
					<%-- 페이지 네비게이션 끝 --%>
				</div>
				</c:if>
				
				<!-- 카타고리 리스트에 대한 페이징 -->
				<c:if test="${faqState == 2 && listSize != 0 }">
				<div class="btnAreaList">		
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/customer/faq/category/${category_ }/1/2" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/customer/faq/category/${category_ }/${page - 1}/2" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/customer/faq/category/${category_ }/${i}/2" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/customer/faq/category/${category_ }/${i}/2" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != maxPage && !noticeList.isEmpty()}">
							<a href="/admin/customer/faq/category/${category_ }/${page + 1}/2" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/customer/faq/category/${category_ }/${maxPage }/2" class="page-nav-nobox">
								<i class="fas fa-angle-double-right paging"></i>
							</a>
						</c:if>
					</div>
					<%-- 페이지 네비게이션 끝 --%>
				</div>
				</c:if>
				
				<!-- 검색한 경우 -->
				<c:if test="${faqState == 3 && listSize != 0 }">
				<div class="btnAreaList">		
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/customer/faq/search/1/3/${searchClassification }/${searchInput}" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/customer/faq/search/${page - 1}/3/${searchClassification }/${searchInput}" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/customer/faq/search/${i}/3/${searchClassification }/${searchInput}" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/customer/faq/search/${i}/3/${searchClassification }/${searchInput}" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != maxPage && !noticeList.isEmpty()}">
							<a href="/admin/customer/faq/search/${page + 1}/3/${searchClassification }/${searchInput}" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/customer/faq/search/${maxPage }/3/${searchClassification }/${searchInput}" class="page-nav-nobox">
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
							<li><a href="/admin/customer/faq/write/view" class="sbtnMini mw">쓰기</a></li>
						</ul>
					</div>
				</div>
				<!-- //Btn Area -->

				<%-- 검색 폼 --%>
				<form action="/admin/customer/faq/search" method="get">
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
