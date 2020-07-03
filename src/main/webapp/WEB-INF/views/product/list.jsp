<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {});
	</script>
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
					<li><a href="#">HOME</a></li>
					<c:if test="${category2=='All' }">
						<li class="last">${productList[0].category1 }</li>
					</c:if>
					<c:if test="${category2!='All' }">
						<li>${productList[0].category1 }</li>
						<li class="last">${productList[0].category2 }</li>
					</c:if>
				</ol>
			</div>
						
			<!-- maxcontents -->
			<div id="maxcontents">
				<div class="banner">
					<img src="/files/banner/${banner[0] }" alt="카테고리별 배너" class="mobile" />
					<img src="/files/banner/${banner[0] }" alt="카테고리별 배너" class="web" />
				</div>
				
				<h2 class="brand">${productList[0].category1 }</h2>
	
				<div class="brandTab">
					<ul>
						<c:if test="${category2=='All' }">
							<li><a href="/product/${productList[0].category1 }/All/1" class="hover">전체</a></li>
						</c:if>
						<c:if test="${category2!='All' }">
							<li><a href="/product/${productList[0].category1 }/All/1">전체</a></li>
						</c:if>
						<c:forEach var="categoryList" items="${categoryList }">
							<!-- 지금의 카테고리가 접속한 카테고리일경우 hover클래스 적용 -->
							<c:if test="${category2==categoryList }">
								<li><a href="/product/${productList[0].category1 }/${categoryList}/1" class="hover">${categoryList }</a></li>
							</c:if>
							<c:if test="${category2!=categoryList }">
								<li><a href="/product/${productList[0].category1 }/${categoryList}/1">${categoryList }</a></li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
	
				<div class="brandList">
					<ul>
						<!-- 반복 -->
						<c:forEach var="productList" items="${productList }">
						<li>
							<a href="/product/detail/${productList.seqKey}">
								<div class="img"><img src="/files/product/${productList.detailImageFilename1 }" alt="${productList.name }" /></div>
								<div class="name">${productList.name }</div>
								<div class="price">
									<fmt:formatNumber value="${productList.price }" type="currency" currencySymbol="" pattern="#,###,### 원" /> 
								</div>
							</a>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!-- 페이징 -->
				<div class="btnAreaList">
					<div class="allPageMoving1">
					
					<!-- 처음페이지 이동 -->
					<a href="/product/${category1 }/${category2 }/1" class="n">
						<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로"/>
					</a>
					
					<!-- 앞페이지 이동 -->
					<c:if test="${page<=1}">
						<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로"/>
					</c:if>
					
					<c:if test="${page>1}">
						<a href="/product/${category1 }/${category2 }/${page-1}" class="pre">
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
								<a href="/product/${category1 }/${category2 }/${a}">
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
						<a href="/product/${category1 }/${category2 }/${page+1}" class="next">
							<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로"/>
						</a>
					</c:if>
					<!-- 마지막페이지 이동 -->
					<a href="/product/${category1 }/${category2 }/${maxPage}" class="n">
						<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로"/>
					</a>
	
					</div>
				</div>
				<!-- 페이징 -->
	
				<!-- quickmenu -->
				<!-- 세션 추가후 수정처리 -->
				<div id="quick">
					<c:if test="${accountKey==null }">
						<div class="cart"><a href="/nonmember/cartList">장바구니</a></div>
					</c:if>
					<c:if test="${accountKey!=null }">
						<div class="cart"><a href="/cart">장바구니</a></div>
					</c:if>
					<div class="wish">
						<c:if test="${accountKey==null }">
							<p class="title">찜한목록</p>
						</c:if>
						<c:if test="${accountKey!=null }">
							<p class="title"><a href="/wishlist">찜한목록</a></p>
						</c:if>
						<div class="list">
							<ul>
								<!-- wishlist 표시  -->
								<c:if test="${!empty wishList }">
									<c:forEach var="wishList" items="${wishList}">	
										<li>
											<a href="/product/detail/${wishList.productKey }">
												<img src="/files/product/${wishList.detailImageFilename1 }" alt="" width="90px" height="80px"/>
											</a>
										</li>
									</c:forEach>
								</c:if>
								<!-- wishlist가 비어있을경우 -->
								<c:if test="${empty wishList }">
									<li>
										<a href="#">
											<img src="/img/temp/img/sample_wish.gif" alt="" width="90px" height="80px"/>
										</a>
									</li>
								</c:if>
							</ul>
						</div>
	
						<div class="total">
							<a href="#none" class="wishLeft"><img src="/img/temp/btn/wish_left.gif" alt="" /></a>
							 <span class="page">1</span> / <span class="sum">3</span>
							<a href="#none" class="wishRight"><img src="/img/temp/btn/wish_right.gif" alt="" /></a>
						</div>
	
					</div>
	
					<div class="top"><a href="#">TOP&nbsp;&nbsp;<img src="/img/temp/ico/ico_top.gif" alt="" /></a></div>
				</div>
				<script type="text/javascript">
				$(function(){
					
					$(window).scroll(function(){
						var tg = $("div#quick");
						var xg = $("div#maxcontents");
						var limit = xg.height()- 165;
						var tmp = $(window).scrollTop();
	
						if (tmp > limit) {
							tg.css({"position" : "absolute","right" : "-150px","bottom" : "208px","top" : "auto"});
						}
						else {
							tg.css({"position" : "fixed","top" : "208px" , "margin-left" : "940px","right" : "auto"});
						}
					});
	
				});
				</script>
				<!-- //quickmenu -->
	
			</div>
			<!-- //maxcontents -->
	
		</div>
		<!-- //container -->
	
		<%@ include file="../common/footer.jsp" %>
	
	</div>
</div>
</body>
</html>