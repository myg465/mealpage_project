<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<%@ include file="../common/head.jsp" %>
	<script type="text/javascript">
	    $(document).ready(function(){
		var searchOrder='<c:out value="${searchOrder}"/>';
		console.log(searchOrder);
		switch(searchOrder){
			case 'hot' :
				$('#hot').attr('class', 'on');
				break;
			case 'new' :
				$('#new').attr('class', 'on');
				break;
			case 'priceHigh' :
				$('#priceHigh').attr('class', 'on');
				break;
			case 'priceLow' :
				$('#priceLow').attr('class', 'on');
				break;
		}
	    });
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
						<li class="last">검색</li>
					</ol>
				</div>
							
				<!-- maxcontents -->
				<div id="maxcontents">
					
					<div class="sContents">
						<p><strong><span class="orange">‘${productSearch }’</span>에 대한 검색 결과입니다.</strong></p>
						<p>다른 상품을 검색하시려면 다시 한번 검색어를 입력하신 후 검색 버튼을 클릭하세요.</p>
		
						<div class="searchForm">
							<form action="/product/search" method="get" name="productSearchForm">
								<input type="text" name="productSearch" class="reSearchType" value="${productSearch }"
								 onfocus="this.className='reSearchfocus'" 
								 onblur="if (this.value.length==0) {this.className='reSearchType'}else {this.className='reSearchfocusnot'}" 
								 required/>
								<div class="btn"><input type="image" src="/img/temp/btn/btn_result_search.gif" alt="검색" /></div>
							</form>
						</div>
					</div>
		
					<div class="tabCategory">
						<div class="cateLeft">
							<span class="orange">‘${productSearch }’</span> 검색 결과 
							<span class="orange">${searchListCount }</span>건
						</div>
						
						
						<div class="cateRight">
							<ul>
								<li class="first"><a href="/product/search/${productSearch }/hot" id="hot">인기도순</a></li>
								<li><a href="/product/search/${productSearch }/new" id="new" >신상품순</a></li>
								<li><a href="/product/search/${productSearch }/priceHigh" id="priceHigh" >높은 가격순</a></li>
								<li class="last"><a href="/product/search/${productSearch }/priceLow" id="priceLow">낮은 가격순</a></li>
							</ul>
						</div>
					</div>
					<div class="brandList">
						<ul>
							<c:forEach var="searchResult" items="${searchResult }">
								<!-- 반복 -->
								<li>
									<a href="/product/detail/${searchResult.seqKey }">
										<div class="img">
											<img src="/files/product/${searchResult.detailImageFilename1 }" alt="${searchResult.name }" />
										</div>
										<div class="name">${searchResult.name }</div>
										<div class="price">
											<fmt:formatNumber value="${searchResult.price }" type="currency" 
											currencySymbol="" pattern="#,###,### 원" />
										</div>
									</a>
								</li>
								<!-- 반복 -->
							</c:forEach>
						</ul>
					</div>
					<!-- 페이징 -->
					<div class="btnAreaList">
						<!-- 페이징이동1 -->
						<div class="allPageMoving1">
						
						<!-- 처음페이지 이동 -->
						<a href="/product/search/${productSearch }/${searchOrder}/1" class="n">
							<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로"/>
						</a>
						
						<!-- 앞페이지 이동 -->
						<c:if test="${page<=1}">
							<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로"/>
						</c:if>
						
						<c:if test="${page>1}">
							<a href="/product/search/${productSearch }/${searchOrder}/${page-1}" class="pre">
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
									<a href="/product/search/${productSearch }/${searchOrder}/${a}">
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
							<a href="/product/search/${productSearch }/${searchOrder}/${page+1}" class="next">
								<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로"/>
							</a>
						</c:if>
						<!-- 마지막페이지 이동 -->
						<a href="/product/search/${productSearch }/${searchOrder}/${maxPage}" class="n">
							<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로"/>
						</a>
		
						</div>
						<!-- //페이징이동1 -->
					</div>
					<!-- 페이징 -->
				</div>
				<!-- //maxcontents -->
		
			</div>
			<!-- //container -->
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
</body>
</html>