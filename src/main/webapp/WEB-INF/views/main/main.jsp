<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<script type="text/javascript" src="/js/custom/main.js"></script>
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>

	<div id="allwrap">
		<div id="wrap">
			<%@ include file="../common/header.jsp" %>
			<%@ include file="../common/nav.jsp" %>

			<!-- mainSection -->
			<div id="mainSection">

				<!-- main rolling(배너 등록 영역) -->
				<div id="mainRoll">
					<div class="swiper-wrapper">
						<c:forEach var="banner" items="${banner}"> 
							<div class="swiper-slide">
								<a href="event/event"><img src="/files/banner/${banner}" alt="배너" width="1920px" height="370px"/></a>
							</div>
						</c:forEach>
					</div>
					<div id="mainThum" style="margin-top:90px;"></div>
				</div>
				<!-- //main rolling -->

				
				<!-- main contents -->
				<div id="mainContents">

					<!-- Best seller -->
					<div class="mtitle"><h2>MEALPAGE HOT ITEM</h2></div>
					<div id="bestseller">
						<div class="swiper-wrapper">
							<c:forEach var="best" items="${best}">
								<div class="swiper-slide">
									<div class="img">
										<a href="/product/detail/${best.seqKey }">
											<img src="/files/product/${best.detailImageFilename1 }" alt="Best seller 상품" width="220px" height="220px"/>
										</a>
									</div>
									<div class="name">${best.name }</div>
									<div class="price">
										<fmt:formatNumber value="${best.price }" type="currency" pattern="#,###,### 원" />
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="rollbtn">
						<a class="arrowLeft" href="#"></a> 
						<a class="arrowRight" href="#"></a>
					</div>

					<!-- new goods -->
					<div class="mtitle"></div>
					<div id="newGoods">
						<div class="newcoffee">
							<h3>NEW ITEM</h3>
							<ul>
								<li class="name">${newProduct.name }</li>
								<c:if test="${newProduct.contentText!='0' and newProduct.contentText!=null }">
									<li class="txt">${newProduct.contentText }</li>
								</c:if>
								<li class="price">
									<fmt:formatNumber value="${newProduct.price }" type="currency" pattern="#,###,### 원" />
								</li>
							</ul>
							<div class="abimg">
								<a href="/product/detail/${newProduct.seqKey }">
									<img src="/files/product/${newProduct.detailImageFilename1 }" alt="NEW 상품" width="180px" height="180px" style="position:relative; top:40px;"/>
								</a>
							</div>
						</div>

						<div class="mdchoice">
							<div class="one">
								<h3>MD CHOICE</h3>
								<ul>
									<li class="name">${recommend[0].name }</li>
									<c:if test="${recommend[0].contentText!='0' and recommend[0].contentText!=null }">
										<li class="txt">${recommend[0].contentText }</li>
									</c:if>
									<li class="price">
										<fmt:formatNumber value="${recommend[0].price }" type="currency" pattern="#,###,### 원" />
									</li>
								</ul>
								<div class="img">
									<a href="/product/detail/${recommend[0].seqKey }">
										<img src="/files/product/${recommend[0].detailImageFilename1 }" alt="MD CHOICE 상품" width="106px" height="120px" style="position: relative; top:-50px;"/>
									</a>
								</div>
							</div>

							<div class="two">
								<ul>
									<li class="name">${recommend[1].name }</li>
									<c:if test="${recommend[1].contentText!='0' and recommend[1].contentText!=null}">
										<li class="txt">${recommend[1].contentText }</li>
									</c:if>
									<li class="price">
										<fmt:formatNumber value="${recommend[1].price }" type="currency" pattern="#,###,### 원" />
									</li>
								</ul>
								<div class="img">
									<a href="/product/detail/${recommend[1].seqKey }">
										<img src="/files/product/${recommend[1].detailImageFilename1 }" alt="MD CHOICE 상품" width="106px" height="120px"/>
									</a>
								</div>
							</div>
						</div>
					</div>
					<!-- new goods -->

					<!-- sale -->
					<div class="mtitle"><h2>SALE</h2></div>
					<div id="mainSale">
						<div class="swiper-wrapper">
							<c:forEach var="nowSale" items="${nowSale }">
								<div class="swiper-slide">
									<div class="img" style="width: 160px; margin-bottom: 10px;">
										<a href="/product/detail/${nowSale.seqKey }">
											<img src="/files/product/${nowSale.detailImageFilename1 }" alt="sale 상품"  width="160px" height="160px"/>
										</a>
									</div>
									<div class="name">${nowSale.name }</div>
									<div class="price">
										<fmt:formatNumber value="${nowSale.price }" type="currency" pattern="#,###,### 원" />
									</div>
									<div class="discount">${nowSale.salePercent } %</div>
								</div>
							</c:forEach>
						</div>
					</div>	
					<div class="rollbtn">
						<a class="saleLeft" href="#"></a> 
						<a class="saleRight" href="#"></a>
					</div>
					<!-- //sale -->
			
					<!-- brand -->
					<div class="mtitle"></div>
					<c:set var="token" value="${fn:split('left,right,nor,nor rewidth,nor fn',',')}" />
					<div id="mainBrand">
						<ul>
							<li class="center">
								<div class="banner">
									<img src="/img/temp/img/brand.jpg" alt="brand_banner" />
									<p style="margin:60px 0 0 -17px; color: #101010;">Soylent
										<span style="margin-top:7px; line-height:1.6em; color: #101010;  border: none;"><u>이젠 밀페이지에서<br> 쉽게 구매하세요</u></span>
									</p>
								</div>
							</li>
							<c:forEach var="pList" items="${productList}" varStatus="status" begin="0" end="4">
							<li class="${token[status.index] }">
								<div class="img">
									<a href="/product/detail/${pList.seqKey }">
										<img src="/files/product/${pList.detailImageFilename1 }" alt="Brand 상품" width="150px" height="150px"/>
									</a>
								</div>
								<div class="name">${pList.name }</div>
								<div class="price">
									<fmt:formatNumber value="${pList.price }" type="currency" pattern="#,###,### 원" />
								</div>
							</li>
							</c:forEach>
						</ul>
					</div>

					<!-- //brand -->

					<!-- notice -->
					<div class="mtitle"></div>
					<div id="noticeBLock">
						<ul>
							<li class="first">
								<h3>NOTICE</h3>
								<div class="img"><img src="/img/temp/img/notice.jpg" alt="notice image" /></div>
								<ul>
									<c:forEach var="noticeList" items="${noticeList }">
										<li>
											<a href="/customer/noticeView/${noticeList.seqKey }/1">
												ㆍ<c:out value="${fn:substring(noticeList.title,0,20)}"/>…
											</a>
										</li>
									</c:forEach>
								</ul>
							</li>
							<li class="cln">
								<h3 class="cen">CUSTOMER CENTER</h3>
								<div class="custCenter">
									<p class="phone">00.000.0000</p>
									<p class="day">오전 9시 ~ 오후 7시<br/>토/일요일 및 공휴일 제외</p>
									<p class="link">
										<a href="/customer/guide">이용안내</a> <!-- 이용안내 구축되면 링크추가 -->
										<a href="/customer/faq">FAQ</a>
										<a href="/customer/inquiry">1:1문의</a>							
									</p>
								</div>
							</li>
							<li class="last">
								<h3>EVENT</h3>
								<a href="/event/event">
									<div class="img"><img src="/img/temp/img/event.jpg" alt="event" /></div>
									<p class="txt">MEALPAGE의 다양한 이벤트 소식을 전해드립니다!</p>
								</a>
							</li>
						</ul>
					</div>
					<!-- //notice -->

					<!-- quickmenu -->
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
													<img src="/files/product/${wishList.detailImageFilename1 }" alt="" width="90px" height="80px;"/>
												</a>
											</li>
										</c:forEach>
									</c:if>
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
					
					</script>
					<!-- //quickmenu -->

				</div>
				<!-- //main contents -->

			</div>
			<!-- //mainSection -->

			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</body>
</html>
