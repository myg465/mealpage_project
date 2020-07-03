<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>

<%@ include file="../common/head.jsp" %>
<%@ include file="../common/explorer.jsp" %>
<!-- detail content -->
<div id="detailContent">

<!-- detail info -->
<div class="detailInfo disnone">
	<c:if test="${productDetail.contentImageFilename!=null}">
		<img src="/files/product/${productDetail.contentImageFilename }" class="web" alt="제품상세 정보" />
		<img src="/files/product/${productDetail.contentImageFilename }" class="mobile" alt="제품상세 정보" style="width:290px;"/>
	</c:if>
	<div class="checkInfoDiv">
		<table summary="제품의 정보를 알 수 있는 표로 제품명, 내용량, 제조원, 포장재질, 유통기한, 고객상담실, 식품의 유형, 유통전문판매원, 영양성분, 원재료명 및 함량, 업소명 및 소재지 순으로 나열되어 있습니다." class="checkTable" border="1" cellspacing="0">
			<caption>제품의 정보</caption>
			<colgroup>
			<col width="26%" class="tw22" />
			<col width="*" />
			<col width="26%" class="tw22" />
			<col width="*" class="tw25" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" class="info"><span>제품명</span></th>
					<td>${productDetail.name }</td>
					<th scope="row" class="info"><span>포장단위별 용량</u></span></th>
					<td>${productDetail.volume }</td>
				</tr>

				<tr>
					<th scope="row" class="info"><span>식품의 <u>유형</u></span></th>
					<td>${productDetail.type }</td>
					<th scope="row" class="info"><span>칼로리</span></th>
					<td><fmt:formatNumber value="${productDetail.calorie }" pattern="#,###,###" />kcal</td>
				</tr>

				<tr>
					<th scope="row" class="info"><span>제조연월일 및 유통기한</span></th>
					<td>${productDetail.useByDate }</td>
					<th scope="row" class="info"><span>고객<u>상담실</u></span></th>
					<td>${productDetail.csPhone }</td>
				</tr>

				<tr>
					<th scope="row" class="info"><span>수입자<u>표시</u></span></th>
					<td>${productDetail.importer }</td>
					<th scope="row" class="info"><span>수입신고필 정보</span></th>
					<td>${productDetail.importDeclaration }</td>
				</tr>
				
				<tr>
					<th scope="row" class="info"><span><u>유전자재조합</u> 식품 여부</span></th>
					<td>${productDetail.gmFood }</td>
				</tr>

				<tr>
					<th scope="row" class="info"><span>영양성분</span></th>
					<td colspan="3">${productDetail.nutrients }</td>
				</tr>

				<tr>
					<th scope="row" class="info"><span>원재료명 <u>및 함량</u></span></th>
					<td colspan="3">${productDetail.rawMaterials }</td>
				</tr>

				<tr>
					<th scope="row" class="info"><span>생산자 <u>및 소재지</u></span></th>
					<td colspan="3">${productDetail.productor }</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<!-- detail info -->
</div>