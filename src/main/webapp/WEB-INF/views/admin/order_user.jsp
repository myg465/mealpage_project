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
	<%-- custom css for order board --%>
	<link rel="stylesheet" href="/css/custom/order.css">
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="order_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(1,0);</script>
			<div style="position: relative; left: 10px; font-size: 14px; margin-bottom: 5px;">
				<c:choose>
					<c:when test="${status == null}">
						<b>전체</b>&nbsp; |&nbsp;
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user">전체</a>&nbsp; |&nbsp;
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${status == '결제완료'}">
						<b>결제완료</b>&nbsp; |&nbsp;
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user/status/결제완료">결제완료</a>&nbsp; |&nbsp;
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${status == '배송준비중'}">
						<b>배송준비중</b>&nbsp; |&nbsp;
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user/status/배송준비중">배송준비중</a>&nbsp; |&nbsp;
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${status == '배송중'}">
						<b>배송중</b>&nbsp; |&nbsp;
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user/status/배송중">배송중</a>&nbsp; |&nbsp;
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${status == '배송완료'}">
						<b>배송완료</b>&nbsp; |&nbsp;
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user/status/배송완료">배송완료</a>&nbsp; |&nbsp;
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${status == '구매확정'}">
						<b>구매확정</b>&nbsp; |&nbsp;
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user/status/구매확정">구매확정</a>&nbsp; |&nbsp;
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${status == '교환요청'}">
						<b>교환요청</b>&nbsp; |&nbsp;
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user/status/교환요청">교환요청</a>&nbsp; |&nbsp;
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${status == '반품요청'}">
						<b>반품요청</b>&nbsp; |&nbsp;
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user/status/반품요청">반품요청</a>&nbsp; |&nbsp;
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${status == '환불대기'}">
						<b>환불대기</b>&nbsp; |&nbsp;
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user/status/환불대기">환불대기</a>&nbsp; |&nbsp;
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${status == '기타'}">
						<b>기타</b>
					</c:when>
					<c:otherwise>
						<a href="/admin/order/user/status/기타">기타</a>&nbsp;
					</c:otherwise>
				</c:choose>
			</div>
			<div id="contents">
				<div class="orderDiv">
					<table class="orderTable" border="1" cellspacing="0">
						<caption>회원주문관리</caption>
						<colgroup>
						<col width="25%" class="tw28" />
						<col width="*" />
						<col width="15%" class="tnone" />
						<col width="8%" class="tnone" />
						<col width="12%" class="tw30" />
						<col width="12%" class="tw30" />
						</colgroup>
						<thead>
							<th scope="col">주문일자 <span>/ 주문번호</span></th>
							<th scope="col">상품명</th>
							<th scope="col" class="tnone">주문총액</th>
							<th scope="col" class="tnone">총 수량</th>
							<th scope="col">주문상태</th>
							<th scope="col">주문자</th>
						</thead>
						<tbody>
							<c:forEach var="order" items="${orderList}">
								<tr>
									<td>
										<p class="day">
											<fmt:parseDate var="createdDate" value="${order.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
										</p>
										<p class="orderNum">
											<a href="/admin/order/user/${page}/detail/${order.orderNumber}">${order.orderNumber}</a>
										</p>
									</td>
									<td class="left">
										<a href="/admin/order/user/${page}/detail/${order.orderNumber}">${order.productName}
											<c:if test="${order.orderGroup > 1}">
												(외 ${order.orderGroup - 1}건)
											</c:if>
										</a>
									</td>
									<td class="tnone"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.orderPrice}" /> 원</td>
									<td class="tnone"><fmt:formatNumber type="number" maxFractionDigits="3" value="${order.orderQuantity}" /> 개</td>
									<td>
										<c:choose>
											<c:when test="${order.status == '결제완료' || order.status == '환불대기' || order.status == '교환요청' || order.status == '반품요청'}">
												<span style="color: darkred;"><b>${order.status}</b></span>
											</c:when>
											<c:when test="${order.status == '반품요청(배송중)'}">
												<span style="color: darkred;"><b>반품요청</b></span>
											</c:when>
											<c:when test="${order.status == '배송준비중' || order.status == '배송중'}">
												<span class="orange">${order.status}</span>	
											</c:when>
											<c:otherwise>
												<span class="heavygray">${order.status}</span>
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										${order.ordererName}<br>
										(${order.id})
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<c:if test="${orderList.isEmpty()}">
						<div class="noData">
							회원 구매 이력이 없습니다.
						</div>
					</c:if>
				</div>

				<div class="btnAreaList">
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/order/user/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/order/user/${page - 1}" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/order/user/${i}" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/order/user/${i}" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != pages && !orderList.isEmpty()}">
							<a href="/admin/order/user/${page + 1}" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/order/user/${pages}" class="page-nav-nobox">
								<i class="fas fa-angle-double-right paging"></i>
							</a>
						</c:if>
					</div>
					<%-- 페이지 네비게이션 끝 --%>
				</div>

				<%-- 검색 폼 --%>
				<form action="/admin/order/user/search" method="post">
					<div class="searchWrap">
						<div class="search">
							<ul>
								<li class="web"><img src="/img/temp/txt/txt_search.gif" alt="search" /></li>
								<li class="se">
									<select name="searchType">
										<option value="name">주문자</option>
										<option value="number">주문번호</option>
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
