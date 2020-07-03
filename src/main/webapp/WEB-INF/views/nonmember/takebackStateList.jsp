<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp" %>
</head>
<body>
<%@ include file="../common/explorer.jsp" %>
<c:if test="${nonmemberName==null }">
	<script type="text/javascript">
		alert("잘못된 접근입니다.");
		window.location.href="/account/login";
	</script>
</c:if>
<div id="allwrap">
<div id="wrap">
	<%@ include file="../common/header.jsp" %>
	<%@ include file="../common/nav.jsp" %>

	<!-- container -->
	<div id="container">

		<div id="location">
			<ol>
				<li><a href="#">HOME</a></li>
				<li><a href="#">비회원 주문조회</a></li>
				<li class="last">반품/교환 현황</li>
			</ol>
		</div>
		
		<div id="outbox">	
			<%@ include file="sidemenu.jsp"%>	
			<script type="text/javascript">initSubmenu(2,0);</script>


			<!-- contents -->
			<div id="contents">
				<div id="mypage">
					<h2><strong>반품/교환 현황</strong><span>비회원 구매하신 주문내역을 확인하실 수 있습니다.</span></h2>
					
			
					<h3 class="dep">반품/교환 상품정보</h3>
					<div class="orderDivNm">
						<table summary="주문일자/주문번호, 분류, 상품명, 가격, 상태, 사유 순으로 반품/교환 현황을 조회 하실수 있습니다." class="orderTable" border="1" cellspacing="0">
							<caption>반품/교환 현황 사유보기</caption>
							<colgroup>
							<col width="25%" class="tw30" />
							<col width="7%" class="tnone" />
							<col width="*" />
							<col width="13%" class="tnone" />
							<col width="10%" class="tw18"/>
							<col width="15%" class="tnone" />
							</colgroup>
							<thead>
								<th scope="col">주문일자 <span>/ 주문번호</span></th>
								<c:if test="${listStat == 0 }">
									<th scope="col" colspan="2">상품명</th>
									<th colspan="3">총 가격</th>
								</c:if>
								<c:if test="${listStat == 1 }">
									<th scope="col" class="tnone">분류</th>
									<th scope="col" >상품명</th>
									<th scope="col" class="tnone">가격</th>
									<th scope="col">상태</th>
									<th scope="col" class="tnone">사유</th>
								</c:if>
							</thead>
							<c:set var="takeTot" value="${takebackStateList }" />
							<tbody>
								<c:if test="${listStat == 0 && takebackStateList!=null }">
								<!-- 주문번호 클릭전 리스트 전체 값 -->
									<tr>
										<td>
											<p class="day">
												<fmt:formatDate value="${takeTot.createdDate }"
												pattern="YYYY-MM-dd"/>
											</p>
											<p class="orderNum">
												<a href="/nonmember/takebackStateList/1/1">
													${takeTot.orderNumber }
												</a>
											</p>
										</td>
										<!-- <td class="tnone"><span class="heavygray">반품</span></td>-->
										<td class="left" colspan="2" style="text-align: center;">
											${takeTot.productName } 외 ${takebackListCount-1 } 종
										</td>
										<td class="tnone" colspan="3">
											<fmt:formatNumber value="${totalTakebackPrice }" groupingUsed="true"/> 원
										</td>
									</tr>
								</c:if>
								<!-- 전체개괄 -->
								<c:if test="${listStat == 1 }">
								<!-- 주문번호 클릭으로 리스트 펼쳤을 경우 -->
									<c:forEach var="list" items="${takebackStateListAll }">
										<tr>
											<td>
												<p class="day">
													<fmt:formatDate value="${list.createdDate }"
														pattern="YYYY-MM-dd"/>
												</p>
												<p class="orderNum"><a href="/nonmember/takebackStateList">${list.orderNumber }</a></p>
											</td>
											<td class="tnone">
												<span class="heavygray">
													<c:out value="${fn:substring(list.status,0,2)}"/>
												</span>
											</td>
											<td class="left" style="text-align: center;">
												${list.productName }
											</td>
											<td class="tnone">
												<fmt:formatNumber value="${list.productPrice * list.quantity }" groupingUsed="true"/> 원
											</td>
											<td>
											<a href="#"
											onclick="popup('/nonmember/refundView/'+${list.seqKey})" style="cursor: pointer;">
												<span class="orange">${list.status }</span>
											</a>
											</td>
											<td class="tnone">
												<a href="/nonmember/takebackReasonView/${list.seqKey }" class="nbtnbig iwc80">사유보기</a>
											</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
						<c:if test="${takebackStateList == null and listSize == null }">
							<div class="noData">
								등록된 상품이 없습니다.
							</div>
						</c:if>
					</div>
					

					<c:if test="${listStat == 1 && listSize != 0}">
						<div class="btnAreaList">
							<!-- 페이징이동1 -->
															
							<div class="allPageMoving1">
								<!-- 처음페이지로 -->
								<a href="/nonmember/takebackStateList/1/1" class="n">
									<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />
								</a>
								<!-- 이전페이지로 -->
								<c:if test="${page <= 1 }">
									<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
								</c:if>
								<c:if test="${page > 1 }">
			 						<a href="/nonmember/takebackStateList/${page-1 }/1" class="pre">
										<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
										</a> 
								</c:if>
								
								<!-- 순차적으로 페이지 출력 -->
								<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1" >
									<c:choose>
										<c:when test="${i == page }">
											<strong>${i }</strong>
										</c:when>
										<c:when test="${i != page }">
											<a href="/nonmember/takebackStateList/${i }/1">
											${i }
											</a>
										</c:when>
									</c:choose>
								
								</c:forEach>

								<!-- 다음페이지로 -->
								<c:if test="${page >= maxPage }">
									<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
								</c:if>
								<c:if test="${page < maxPage }">
									<a href="/nonmember/takebackStateList/${page+1 }/1" class="next">
										<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
									</a>
								</c:if>
								
								<!-- 마지막페이지로 -->
								<a href="/nonmember/takebackStateList/${maxPage }/1" class="n">
									<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
								</a>
								
								
							</div>
							<!-- //페이징이동1 -->
						</div>
					</c:if>
					

<script type="text/javascript" src="/js/temp/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="/css/temp/jquery.fancybox-1.3.4.css" />
<script type="text/javascript">
$(function(){

	$(".iwc80").fancybox({
		'autoDimensions'    : false,
		'showCloseButton'	: false,
		'width' : 486,
		'padding' : 0,
		'type'			: 'iframe',
		'onComplete' : function() {
			$('#fancybox-frame').load(function() { // wait for frame to load and then gets it's height
			$('#fancybox-content').height($(this).contents().find('body').height());
			});
		}
	});

});

//팝업띄우기
function popup(url_){
       var url = url_;
       var name = "popup test";
       var option = "width = 750, height = 470, top = 100, left = 200, scrollbars = no, location = no, toolbars = no, status = no "
       window.open(url, name, option);
   }
</script>

				</div>
			</div>
			<!-- //contents -->


		</div>
	</div>
	<!-- //container -->

</div>
<!-- wrap -->
</div>
<!-- allwrap -->
<%@ include file="../common/footer.jsp" %>
</body>
</html>