<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp"%>
	<!--[if lt IE 9]>
	<script type="text/javascript" src="../js/html5.js"></script>
	<script type="text/javascript" src="../js/respond.min.js"></script>
	<![endif]-->
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
	<style type="text/css">
		.faqTab ul li a {
			width: 91px;
		}
		.faqTab ul li.last a {
			width: 94px;
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
						<li><a href="/">HOME</a></li>
						<li><a href="/customer/notice">CUSTOMER</a></li>
						<li class="last">FAQ</li>
					</ol>
				</div>

				<div id="outbox">
					<%@ include file="sidemenu.jsp"%>
					<script type="text/javascript">	initSubmenu(3, 0);</script>


					<!-- contents -->
					<div id="contents">
						<div id="customer">
							<h2>
								<strong>FAQ</strong><span>회원님들께서 자주 묻는 질문들을 모아 놓았습니다.</span>
							</h2>
							
							
							<div class="faqTab">
								<ul>
									<li><a href="/customer/faq" id="total" class="on">전체</a></li>
									<li><a href="/customer/faqCategory/account" id="account" class="">회원관리</a></li>
									<li><a href="/customer/faqCategory/point" id="point" class="">포인트/쿠폰</a></li>
									<li><a href="/customer/faqCategory/order" id="order" class="">주문/결제</a></li>
									<li><a href="/customer/faqCategory/refund" id="refund" class="">환불/교환</a></li>
									<li><a href="/customer/faqCategory/shipping" id="shipping" class="">배송</a></li>
									<li class="last"><a href="/customer/faqCategory/etc" id="etc" class="">기타</a></li>
								</ul>
							</div>
							
							<!-- FAQ -->
							<div class="faqList">
								<ul>
								<c:forEach var="faqList" items="${faqList }">
									<!-- list -->
									<li><a href="javascript:;" class="faqbtn">
											<div class="question">
												<div class="blet">Q</div>
												<div class="category">${faqList.getCategory() }</div>
												<div class="title">${faqList.getTitle() }</div>
											</div>
									</a>

										<div class="faqanswer">
											<div class="faqbox">
												<div class="blet">A</div>
												<div class="text">
													${faqList.getContent() }
												</div>
											</div>
										</div></li>
									<!-- //list -->
								</c:forEach>
								</ul>
							</div>
							<!-- //FAQ -->
							
							<!-- 전체리스트 일때 페이징 -->
							<c:if test="${faqState == 1}">
								<div class="btnAreaList">
									<!-- 페이징이동1 -->
									<div class="allPageMoving1">
						
										<!-- 처음페이지로 -->
										<a href="/customer/faq/1/1" class="n">
											<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />									
										</a>
										
										<!-- 이전페이지 -->
										<c:if test="${page <= 1 }">
											<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
										</c:if>
										<c:if test="${page > 1 }">
											<a href="/customer/faq/${page-1 }/1" class="pre" > 
												<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
											</a>
										</c:if>
										
										<!-- 순차적으로 페이지 출력 -->
										<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
											<c:choose>
												<c:when test="${i == page }">
													<strong>${i }</strong>
												</c:when>
												<c:when test="${i != page }">
													<a href="/customer/faq/${i}/1" >
													${i }
													</a>
												</c:when>
											</c:choose>
										</c:forEach>
										
										<!-- 다음페이지 -->
										<c:if test="${page >= maxPage }">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</c:if>
										<c:if test="${page < maxPage }">
											<a href="/customer/faq/${page+1 }/1" class="next">
												<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
											</a>
										</c:if>
										
										<!-- 마지막페이지로 -->
										<a href="/customer/faq/${maxPage }/1" class="n">
											<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
										</a>
	
									</div>
									<!-- //페이징이동1 -->
								</div>
							</c:if>
							
							<!-- 카타고리 리스트에 대한 페이징 -->
							<c:if test="${faqState == 2 && listSize != 0}">
								<div class="btnAreaList">
									<!-- 페이징이동1 -->
									<div class="allPageMoving1">
						
										<!-- 처음페이지로 -->
										<a href="/customer/faqCategory/${category_ }/1/2" class="n">
											<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />									
										</a>
										
										<!-- 이전페이지 -->
										<c:if test="${page <= 1 }">
											<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
										</c:if>
										<c:if test="${page > 1 }">
											<a href="/customer/faqCategory/${category_ }/${page-1 }/2" class="pre" > 
												<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
											</a>
										</c:if>
										
										<!-- 순차적으로 페이지 출력 -->
										<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
											<c:choose>
												<c:when test="${i == page }">
													<strong>${i }</strong>
												</c:when>
												<c:when test="${i != page }">
													<a href="/customer/faqCategory/${category_ }/${i}/2" >
													${i }
													</a>
												</c:when>
											</c:choose>
										</c:forEach>
										
										<!-- 다음페이지 -->
										<c:if test="${page >= maxPage }">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</c:if>
										<c:if test="${page < maxPage }">
											<a href="/customer/faqCategory/${category_ }/${page+1 }/2" class="next">
												<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
											</a>
										</c:if>
										
										<!-- 마지막페이지로 -->
										<a href="/customer/faqCategory/${category_ }/${maxPage }/2" class="n">
											<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
										</a>
	
									</div>
									<!-- //페이징이동1 -->
								</div>
							</c:if>

							<!-- 검색에 대한 페이징 -->
							<c:if test="${faqState == 3 && listSize != 0}">
								<div class="btnAreaList">
									<!-- 페이징이동1 -->
									<div class="allPageMoving1">
						
										<!-- 처음페이지로 -->
										<a href="/customer/faqSearch/1/3/${searchClassification }/${searchInput}" class="n">
											<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />									
										</a>
										
										<!-- 이전페이지 -->
										<c:if test="${page <= 1 }">
											<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
										</c:if>
										<c:if test="${page > 1 }">
											<a href="/customer/faqSearch/${page-1 }/3/${searchClassification }/${searchInput}" class="pre" > 
												<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
											</a>
										</c:if>
										
										<!-- 순차적으로 페이지 출력 -->
										<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
											<c:choose>
												<c:when test="${i == page }">
													<strong>${i }</strong>
												</c:when>
												<c:when test="${i != page }">
													<a href="/customer/faqSearch/${i}/3/${searchClassification }/${searchInput}" >
													${i }
													</a>
												</c:when>
											</c:choose>
										</c:forEach>
										
										<!-- 다음페이지 -->
										<c:if test="${page >= maxPage }">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</c:if>
										<c:if test="${page < maxPage }">
											<a href="/customer/faqSearch/${page+1 }/3/${searchClassification }/${searchInput}" class="next">
												<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
											</a>
										</c:if>
										
										<!-- 마지막페이지로 -->
										<a href="/customer/faqSearch/${maxPage }/3/${searchClassification }/${searchInput}" class="n">
											<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
										</a>
	
									</div>
									<!-- //페이징이동1 -->
								</div>
							</c:if>
							
							<!-- 카테고리 클릭 및 검색 시 FAQ가 없는 경우 -->
							<c:if test="${listSize == 0 }">
								<div class="noData">해당 FAQ가 없습니다.</div>
							</c:if>
														
							<div class="searchWrap">
								<div class="search">
									<form action="/customer/faqSearch" name="faqSearch" method="get">
									<ul>
										<li class="web"><img src="/img/temp/txt/txt_search.gif"
											alt="search" /></li>
										<li class="se">
											<select name="searchClassification">
												<option value="title" >제목</option>
												<option value="content">내용</option>
												<option value="all">제목+내용</option>
											</select>
										</li>
										<li>
											<input type="text" class="searchInput" name="searchInput"/>
										</li>
										<li class="web">
											<input type="submit" value="" id="webSearchBtn"/>
										</li>
										<li class="mobile">
											<input type="submit" value="" id="mobileSearchBtn"/>
										</li>
									</ul>
									</form>
								</div>
							</div>

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