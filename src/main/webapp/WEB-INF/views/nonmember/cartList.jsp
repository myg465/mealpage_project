<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp"%>

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
						<li><a href="#">HOME</a></li>
						<li class="last">장바구니</li>
					</ol>
				</div>
		
				<div id="outbox">		
					
					<!-- maxcontents -->
					<div id="maxcontents">
						<div id="mypage">
							<h2><strong>장바구니</strong></h2>
							
						<!-- 장바구니에 상품이 있을경우 -->
							<!-- 장바구니 상품 -->
							<form action="/nonmember/orderCart" name="cartForm" method="post" >
								<c:if test="${!empty productList }">
									<h3 class="dep">장바구니에 담긴 상품</h3>
									<div class="orderDivNm">
										<table summary="장바구니에 담긴 상품들을 전체선택, 상품명, 가격, 수량, 합계, 주문 순으로 조회 및 주문을 하실수 있습니다." class="orderTable" border="1" cellspacing="0">
											<caption>장바구니 상품목록</caption>
											<colgroup>
											<col width="7%"/>
											<col width="*" />
											<col width="14%" class="tnone" />
											<col width="10%" class="tw14"/>
											<col width="14%" class="tw28"/>
											<col width="14%" class="tnone" />
											</colgroup>
											<thead>
												<th scope="col"><input type="checkbox" id="checkAll"/></th>
												<th scope="col">상품명</th>
												<th scope="col" class="tnone">가격</th>
												<th scope="col">수량</th>
												<th scope="col">합계</th>
												<th scope="col" class="tnone">주문</th>
											</thead>
											<tbody>
												<c:forEach var="productList" items="${productList}" varStatus="status">
													<tr>
														<td><input type="checkbox" name="chk" class="chk" id="chk_${status.index }" value="${status.index }" onclick="itemSum();" /></td>
														<td class="left">
															<p class="img"><img src="/files/product/${productList.detailImageFilename1 }" alt="상품" width="66" height="66" /></p>
					
															<ul class="goods">
																<li>
																	<a href="/product/detail/${productList.seqKey }">${productList.name }</a>
																</li>
															</ul>
														</td>
														<input type="hidden" name="pri" id="pri_${status.index }" value="${productList.price }" />
														
														<td class="tnone"><fmt:formatNumber value="${productList.price }" type="currency" pattern="#,###,### 원" /></td>
														
														<td><input type="number" id="num_${status.index }" min="1" value="${quantityList[status.index] }" maxlength="3" style="width:40px;"
														onchange="ch1(${status.index })"/></td>
														
														<td>
															<span id="stot_${status.index }"><fmt:formatNumber value="${productList.price*quantityList[status.index] }" type="currency" pattern="#,###,### 원" /></span>
														</td><!-- 합계 -->
														
														<td class="tnone">
															<ul class="order">	
																<li><a href="#" class="obtnMini iw70" onclick="buyNow('${status.index }')">바로구매</a></li>
																<li><a href="#" onclick="cart_del('${status.index}')" class="nbtnMini iw70">상품삭제</a></li>
															</ul>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
				
									<div class="btnArea">
										<div class="bRight">
											<ul>
												<li><a href="#"  class="selectbtn">전체선택</a></li>
												<li><a href="#" onclick="chk_del();" class="selectbtn2">선택삭제</a></li>
											</ul>
										</div>
									</div>
									<!-- //장바구니 상품 -->
									
				
									<!-- 총 주문금액 -->
									<div class="amount">
										<h4>총 주문금액</h4>
										<ul class="info">
											<li>
												<span class="title">상품 합계금액</span>
												<strong><span class="won" id="sum1">0 원</span></strong>
											</li>
											<li>
												<span class="title">배송비</span>
												<strong><span class="won" id="del_price">0 원</span></strong>
											</li>
										</ul>
										<ul class="total">
											<li class="txt"><strong>결제 예정 금액</strong></li>
											<li class="money"><span id="tot">0 원</span></li>
										</ul>
									</div>
									<!-- //총 주문금액 -->
				
									<div class="cartarea">
										<ul>
											<li><a href="#" class="ty1" onclick="cartForm.submit();">선택상품 <span>주문하기</span></a></li>
											<li><a href="#" class="ty2" onclick="orderAll();">전체상품 <span>주문하기</span></a></li>
											<li class="last"><a href="/" class="ty3">쇼핑 <span>계속하기</span></a></li>
										</ul>
									</div>
								</c:if>
							</form>
						<!-- //장바구니에 상품이 없을경우 -->
		
		
							<c:if test="${empty productList }">
								<div class="noting">
									<div class="point"><span class="orange">장바구니</span>에 담긴 상품이 없습니다.</div>
			
									<a href="/">쇼핑 계속하기</a>
								</div>
						 	</c:if>
		
		
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<style type="text/css">
.ui-corner-all{border-bottom-right-radius:0 !important; border-bottom-left-radius:0 !important; border-top-left-radius:0 !important; border-top-right-radius:0 !important;}
.ui-widget-content{border:0;}
.ui-spinner-input{width:44px; margin:0; border:1px #ddd solid; padding:2px 0 2px 5px; font-family:'Nanum Gothic' !important; font-size:12px !important;}
</style>
<script type="text/javascript" src="/js/custom/nonmember.js"></script>
		
		
						</div>
					</div>
					<!-- //maxcontents -->
		
		
				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>


		</div>
	</div>
</body>
</html>