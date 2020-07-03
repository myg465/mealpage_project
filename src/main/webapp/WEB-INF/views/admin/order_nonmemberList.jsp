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
	<style type="text/css">
		.orderTable2{ width: 1200px; border-left:1px dotted gray; border-right:1px dotted gray; }
		.orderTable2 thead th{ border-left:1px dotted gray; border-right:1px dotted gray;}
		.orderTable2 tbody tr td{ border-left:1px dotted gray; border-right:1px dotted gray;}
		#product_img_wrap a { float: left; margin-left: 23px;}
		#product_img_wrap a img{ width: 60px; height: 60px;}
		
		#insert_wrap{ position: relative;left:47%;}
		#insert_wrap a button{ width: 80px; height: 26px; background-color: pink; color:black;}
		
	</style>
</head>

<body>
	
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="order_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(2,0);</script>
			<div id="contents">
				<div class="orderDivNm" style="width: 1200px;">
					<h2 style="text-align: center; font-size: 30px; font-weight: bold; padding-top: 10px; height: 50px;">비회원 주문관리</h2>
					<h3 style="font-size: 15px; margin:20px 0 20px 0;">주문건수 : ${allCount } 건 </h3>
					<table class="orderTable2" border="1" cellspacing="0">
						<colgroup>
							<col width="10%" class="tnone" />
							<col width="20%" class="tw20" />
							<col width="20%" />
							<col width="10%" class="tnone" />
							<col width="20%" class="tw30" />
							<col width="10%" class="tw30" />
							<col width="10%" class="tw30" />
						</colgroup>
						<thead>
							<th scope="col" class="tnone"><a href="/admin/order/nonmember/${search}/order_number/1">주문번호</a></th>
							<th scope="col"><a href="/admin/order/nonmember/${search}/product_name/1">상품명</a></th>
							<th scope="col">주문금액</th>
							<th scope="col">주문자이름</th>
							<th scope="col"><a href="/admin/order/nonmember/${search}/status/1">결제상태 / 주문상태</a></th>
							<th scope="col">주문일</th>
							<th scope="col">상세</th>
						</thead>
						<tbody>
							<c:forEach var="list" items="${orderList}">
								<tr>
									<td class="tnone">${list.orderNumber}</td>
									<td>${list.productName} 외 ${list.orderGroup - 1 }건</td>
									<td>
										<fmt:formatNumber value="${list.amountFinal}" type="currency" pattern="#,###,### 원" />
									</td>
									<td>${list.nonmemberName}</td>
									<td>${list.pStatus} / ${list.oStatus}</td>
									<td>
										<fmt:parseDate var="createdDate" value="${list.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										<a href="/admin/order/nonmember/detail/${list.orderNumber }/${list.nonmemberName}">
											<button style="cursor: pointer; background-color: darkblue; color: #fff;">상세</button>
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<c:if test="${empty orderList}">
						<div class="noData">
							주문이 없습니다.
						</div>
					</c:if>
				</div>
				<!-- 페이징 -->
				<div class="btnAreaList" style="width: 1200px;">
					<div class="allPageMoving1">
					
					<!-- 처음페이지 이동 -->
					<a href="/admin/order/nonmember/${search}/${order}/1" class="n">
						<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로"/>
					</a>
					
					<!-- 앞페이지 이동 -->
					<c:if test="${page<=1}">
						<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로"/>
					</c:if>
					
					<c:if test="${page>1}">
						<a href="/admin/order/nonmember/${search}/${order}/${page-1}" class="pre">
							<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로"/>
						</a>
					</c:if>
					
					<!-- 순차적 페이지 번호 출력 -->
					<c:forEach var="a" begin="${startPage}" end="${endPage}" step="1">
						<c:choose>
							<c:when test="${a==page}">
								<strong>${a }</strong>
							</c:when>
							<c:when test="${a!=page}">
								<a href="/admin/order/nonmember/${search}/${order}/${a}">
									${a }
								</a>
							</c:when>
						</c:choose>
					</c:forEach>
					<!-- 다음페이지 이동 -->
					<c:if test="${page>=maxPage}">
						<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로"/>
					</c:if>
					
					<c:if test="${page<maxPage}">
						<a href="/admin/order/nonmember/${search}/${order}/${page+1}" class="next">
							<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로"/>
						</a>
					</c:if>
					<!-- 마지막페이지 이동 -->
					<a href="/admin/order/nonmember/${search}/${order}/${maxPage}" class="n">
						<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로"/>
					</a>
	
					</div>
				</div>
				<!-- 페이징 -->

				<%-- 검색 폼 --%>
				<form action="/admin/order/nonmember" method="get">
					<div class="searchWrap" style="width: 1140px; padding-left: 110px;">
						<div class="search">
							<ul>
								<li class="web"><img src="/img/temp/txt/txt_search.gif" alt="search" /></li>
								<li><input type="text" class="searchInput" name="searchtext" placeholder="제품명/주문상태" required></li>
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
