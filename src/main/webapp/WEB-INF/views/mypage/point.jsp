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
						<li class="last">나의 포인트</li>
					</ol>
				</div>
				
				<div id="outbox">
					<%@ include file="sidemenu.jsp" %>
					<script type="text/javascript">initSubmenu(6,0);</script>

					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2><strong>나의 포인트</strong><span>회원님께서 보유하신 포인트를 확인해보세요.</span></h2>

							<%@ include file="myinfo.jsp" %>

							<div class="otherTab">
								<ul>
									<li><a href="javascript:;" onclick="return false;" id="tab_saving">적립내역</a></li>
									<li class="last"><a href="javascript:;" onclick="return false;" id="tab_usage">사용내역</a></li>
								</ul>						
							</div>
							<script type="text/javascript">$(function(){$(".otherTab ul li a:eq(0)").click();});</script>
						
							<!-- Saving -->
							<div class="tab_saving couponnone">
								<c:set var="totalAddPoint" value="0" />
								<c:forEach var="point" items="${pointAddList}">
									<c:set var="totalAddPoint" value="${totalAddPoint + point.point}" />		
								</c:forEach>
								<div class="shortTxt">지금까지 총 <span class="orange"><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalAddPoint}" /></span> 포인트가 누적되었습니다.</div>
								<div class="orderDivNm">
									<table class="orderTable2" border="1" cellspacing="0">
										<caption>적립내역 보기</caption>
										<colgroup>
										<col width="9%" class="tnone" />
										<col width="*" />
										<col width="15%" class="tw20" />
										<col width="15%" class="tnone" />
										</colgroup>
										<thead>
											<th scope="col" class="tnone">NO.</th>
											<th scope="col">내역</th>
											<th scope="col">적립 <span>포인트</span></th>
											<th scope="col" class="tnone">적립날짜</th>
										</thead>
										<tbody>
											<c:set var="pointNum" value="${pointAddList.size() + 1}" />
											<c:forEach var="point" items="${pointAddList}">
												<c:set var="pointNum" value="${pointNum - 1}" />
												<tr>
													<td class="tnone">${pointNum}</td>
													<td class="left">${point.content}</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${point.point}" /></td>
													<td class="tnone">
														<fmt:parseDate var="createdDate" value="${point.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
														<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>

									<c:if test="${pointAddList.isEmpty()}">
										<div class="noData">
											포인트 적립 내역이 없습니다.
										</div>
									</c:if>
								</div>
							</div>
							<!-- //Serviceable -->

							<!-- Usage -->
							<div class="tab_usage couponnone">
								<c:set var="totalUsedPoint" value="0" />
								<c:forEach var="point" items="${pointUsedList}">
									<c:set var="totalUsedPoint" value="${totalUsedPoint + point.point}" />		
								</c:forEach>
								<div class="shortTxt">지금까지 누적된 포인트 중 총 <span class="orange"><fmt:formatNumber type="number" maxFractionDigits="3" value="${totalUsedPoint}" /></span> 포인트를 사용하였습니다.</div>
								<div class="orderDivNm">
									<table class="orderTable2" border="1" cellspacing="0">
										<caption>사용내역 보기</caption>
										<colgroup>
										<col width="9%" class="tnone" />
										<col width="*" />
										<col width="15%" class="tw20" />
										<col width="15%" class="tnone" />
										</colgroup>
										<thead>
											<th scope="col" class="tnone">NO.</th>
											<th scope="col">내역</th>
											<th scope="col">사용 <span>포인트</span></th>
											<th scope="col" class="tnone">사용날짜</th>
										</thead>
										<tbody>
											<c:set var="pointNum" value="${pointUsedList.size() + 1}" />
											<c:forEach var="point" items="${pointUsedList}">
												<c:set var="pointNum" value="${pointNum - 1}" />
												<tr>
													<td class="tnone">${pointNum}</td>
													<td class="left">${point.content}</td>
													<td><fmt:formatNumber type="number" maxFractionDigits="3" value="${point.point}" /></td>
													<td class="tnone">
														<fmt:parseDate var="createdDate" value="${point.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
														<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
													</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>

									<c:if test="${pointUsedList.isEmpty()}">
										<div class="noData">
											포인트 사용 내역이 없습니다.
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