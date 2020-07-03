<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
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
						<li><a href="/order">MY PAGE</a></li>
						<li class="last">나의 쿠폰</li>
					</ol>
				</div>
				
				<div id="outbox">		
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(5,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2><strong>나의 쿠폰</strong><span>회원님께서 보유하신 쿠폰을 확인해보세요.</span></h2>
							
							<%@ include file="myinfo.jsp" %>

							<div class="otherTab">
								<ul>
									<li><a href="javascript:;" onclick="return false;" id="tab_serviceable">사용 가능 쿠폰</a></li>
									<li class="last"><a href="javascript:;" onclick="return false;" id="tab_usage">쿠폰 사용내역</a></li>
								</ul>						
							</div>
							<script type="text/javascript">
								$(function(){$(".otherTab ul li a:eq(0)").click();});
							</script>
						
							<!-- Serviceable -->
							<div class="tab_serviceable couponnone">
								<div class="shortTxt">현재 사용 가능한 쿠폰은 <span class="orange">${couponCount}</span>장입니다.</div>
								<div class="orderDivNm">
									<table class="orderTable2" border="1" cellspacing="0">
										<caption>사용 가능 쿠폰 보기</caption>
										<colgroup>
											<col width="9%" class="tnone" />
											<col width="25%" class="tw28" />
											<col width="25%" class="tnone"/>
											<col width="*" />
											<col width="14%" class="tw20" />
										</colgroup>
										<thead>
											<th scope="col" class="tnone">NO.</th>
											<th scope="col">쿠폰명</th>
											<th scope="col" class="tnone">사용조건</th>
											<th scope="col">사용기한</th>
											<th scope="col">상태</th>
										</thead>
										<tbody>
											<c:set var="couponNum" value="0" />
											<c:forEach var="coupon" items="${couponList}">
												<c:set var="couponNum" value="${couponNum + 1}" />
												<tr>
													<td class="tnone">${couponNum}</td>
													<td>${coupon.name}</td>
													<td class="tnone">
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${coupon.minimumPrice}" /> 원 이상 구매
													</td>
													<td>
														<fmt:parseDate var="startDate" value="${coupon.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
														<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>
															~ 
														<fmt:parseDate var="endDate" value="${coupon.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
														<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>
													</td>
													<td><span class="heavygray">사용가능</span></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>

									<c:if test="${couponList.isEmpty()}">
										<div class="noData">
											사용 가능한 쿠폰이 없습니다.
										</div>
									</c:if>
								</div>								
							</div>
							<!-- //Serviceable -->

							<!-- Usage -->
							<div class="tab_usage couponnone">
								<div class="shortTxt">쿠폰 사용 내역입니다.</div>
								<div class="orderDivNm">
									<table class="orderTable2" border="1" cellspacing="0">
										<caption>쿠폰 사용내역</caption>
										<colgroup>
										<col width="9%" class="tnone" />
										<col width="20%" class="tw28" />
										<col width="30%" class="tnone"/>
										<col width="*" />
										<col width="14%" class="tw20" />
										</colgroup>
										<thead>
											<th scope="col" class="tnone">NO.</th>
											<th scope="col">쿠폰명</th>
											<th scope="col" class="tnone">사용조건</th>
											<th scope="col">사용기한</th>
											<th scope="col">상태</th>
										</thead>
										<tbody>
											<c:set var="couponNum" value="0" />
											<c:forEach var="coupon" items="${disableList}">
												<tr>
													<c:set var="couponNum" value="${couponNum + 1}" />
													<td class="tnone">${couponNum}</td>
													<td>${coupon.name}</td>
													<td class="tnone">
														<fmt:formatNumber type="number" maxFractionDigits="3" value="${coupon.minimumPrice}" /> 원 이상 구매
													</td>
													<td>
														<fmt:parseDate var="startDate" value="${coupon.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
														<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd"/>
															~ 
														<fmt:parseDate var="endDate" value="${coupon.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
														<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>
													</td>
													<td><span class="heavygray">${coupon.status}</span></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>

									<c:if test="${disableList.isEmpty()}">
										<div class="noData">
											사용했거나 기간만료된 쿠폰이 없습니다.
										</div>
									</c:if>
								</div>
							</div>	
							<!-- //Usage -->

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