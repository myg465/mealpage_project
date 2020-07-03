<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<%@ include file="../common/head.jsp" %>
<%@ include file="../common/explorer.jsp" %>
<!-- detail content -->
<div id="detailContent">
<!-- goods relation -->
<!-- 관련상품: 같은 카테고리의 상품을 뿌려줌 -->
<div class="goodsRelation disnone">
	<div class="headTitle">
		<strong>관련상품&nbsp;</strong> 이 상품을 구매하신 분들이 함께 구매한 상품입니다.
	</div>

	<div class="relationList">
		<ul>
			<c:forEach var="relation" items="${relationProduct }">
				<li>
					<a href="/product/detail/${relation.seqKey }" target="_top">
					
						<div class="img">
							<img src="/files/product/${relation.detailImageFilename1 }" alt="${relation.name }" />
						</div>
						
						<div class="name">${relation.name }</div>
						
						<div class="price">
							<fmt:formatNumber value="${relation.price }" type="currency" currencySymbol="" 
							pattern="#,###,### 원" />
						</div>
						
					</a>
				</li>
			</c:forEach>
		</ul>
	</div>
	<c:set var="relationUrl" value="${relationProduct[0].category1}/${relationProduct[0].category2}"/>
		<!-- 페이징 -->
	<div class="btnAreaList">
		<!-- 페이징이동1 -->
		<div class="allPageMoving1">
		
		<!-- 처음페이지 이동 -->
		<a href="/product/relationProduct/${relationUrl}/1" class="n">
			<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로"/>
		</a>
		
		<!-- 앞페이지 이동 -->
		<c:if test="${page<=1}">
			<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로"/>
		</c:if>
		
		<c:if test="${page>1}">
			<a href="/product/relationProduct/${relationUrl}/${page-1}" class="pre">
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
					<a href="/product/relationProduct/${relationUrl}/${a}">
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
			<a href="/product/relationProduct/${relationUrl}/${page+1}" class="next">
				<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로"/>
			</a>
		</c:if>
		<!-- 마지막페이지 이동 -->
		<a href="/product/relationProduct/${relationUrl}/${maxPage}/" class="n">
			<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로"/>
		</a>

		</div>
		<!-- //페이징이동1 -->
	</div>
	<!-- 페이징 -->

</div>
<!-- //goods relation -->
</div>