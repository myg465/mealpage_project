<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css for admin page --%>
	<link rel="stylesheet" href="/css/custom/admin.css">
	<%-- custom css for inquiry board --%>
	<link rel="stylesheet" href="/css/custom/inquiry.css">
	<style type="text/css">
		.orderTable2{ width: 1200px; border-left:1px dotted gray; border-right:1px dotted gray; }
		.orderTable2 thead th{ border-left:1px dotted gray; border-right:1px dotted gray;}
		.orderTable2 tbody tr td{ border-left:1px dotted gray; border-right:1px dotted gray;}
		#product_img_wrap a { float: left; margin-left: 23px;}
		#product_img_wrap a img{ width: 60px; height: 60px;}
		
		#insert_wrap{ position: relative;left:47%;}
		#insert_wrap a button{ width: 80px; height: 26px; background-color: pink; color:black;}
		
	</style>
	<script type="text/javascript">
		function delCheck(seqKey){
			if(confirm("상품을 삭제하시겠습니까?")){
				$.ajax({
			        url : "/admin/product/delete",
			        type : "POST",
			        data: JSON.stringify({seqKey:seqKey}),
			        contentType: "application/json",
			        success : function(data){
			           if(data.result == "ok"){
			              location.reload();
			           }
			        },
			        error : function(){
			           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteError)");
			        }
			     });
			}
		}
	</script>
</head>

<body>
	
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="product_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(1,0);</script>
			<div id="contents">
				<div class="orderDivNm" style="width: 1200px;">
					<table class="orderTable2" border="1" cellspacing="0">
						<colgroup>
							<col width="5%" class="tnone" />
							<col width="10%" class="tw20" />
							<col width="10%" />
							<col width="20%" class="tnone" />
							<col width="10%" class="tw30" />
							<col width="7%" class="tw30" />
							<col width="5%" class="tw30" />
							<col width="5%" class="tw30" />
							<col width="7%" class="tw30" />
							<col width="5%" class="tw30" />
						</colgroup>
						<thead>
							<th scope="col" class="tnone"><a href="/admin/product/${search}/seq_key/1">NO.</a></th>
							<th scope="col"><a href="/admin/product/${search}/name/1">상품명</a></th>
							<th scope="col"><a href="/admin/product/${search}/category/1">카테고리</a></th>
							<th scope="col">상세이미지</th>
							<th scope="col">판매가격</th>
							<th scope="col">재고</th>
							<th scope="col">추천</th>
							<th scope="col">신규</th>
							<th scope="col">세일</th>
							<th scope="col">수정/삭제</th>
						</thead>
						<tbody>
							<c:forEach var="list" items="${productList}">
								<tr>
									<td class="tnone">${list.seqKey}</td>
									<td>${list.name}</td>
									<td>${list.category1} /<br> ${list.category2 }</td>
									<td id="product_img_wrap">
										<!-- 상세이미지 1 -->
										<c:if test="${list.detailImageFilename1!=null }">
											<a href="#" onclick="popup('/admin/product/imgpop/${list.detailImageFilename1}')" >
												<img alt="상세1" src="/files/product/${list.detailImageFilename1 }">
											</a>
										</c:if>
										<!-- 상세이미지 2 -->
										<c:if test="${list.detailImageFilename2!=null }">
											<a href="#" onclick="popup('/admin/product/imgpop/${list.detailImageFilename2}')">
												<img alt="상세2" src="/files/product/${list.detailImageFilename2 }">
											</a>
										</c:if>
										<!-- 상세이미지 3 -->
										<c:if test="${list.detailImageFilename3!=null }">
											<a href="#" onclick="popup('/admin/product/imgpop/${list.detailImageFilename3}')">
												<img alt="상세3" src="/files/product/${list.detailImageFilename3 }">
											</a>
										</c:if>
									</td>
									<td>
										<fmt:formatNumber value="${list.price}" type="currency" pattern="#,###,### 원" />
									</td>
									<td>${list.stock} 개</td>
									<td>
										<c:if test="${list.recommend=='Y'}">
											<img alt="추천" src="/img/temp/ico/ico_check.png" width="20px;" height="20px;">
										</c:if>										
									</td>
									<td>
										<c:if test="${list.newProduct=='Y'}">
											<img alt="신규" src="/img/temp/ico/ico_check.png" width="20px;" height="20px;">
										</c:if>
									</td>
									<td>
										<c:if test="${list.salePercent!=null}">
											${list.salePercent} %
										</c:if>
									</td>
									<td>
										<a href="#"
										onclick="popup('/admin/product/modifyView/${list.seqKey}')">
											<button style="cursor: pointer;">수정</button>
										</a>
										<br>
										<a href="#" 
										onclick="delCheck('<c:out value="${list.seqKey }"/>')">
											<button style="margin-top:8px; cursor: pointer; background-color: pink; color: black;">삭제</button>
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<c:if test="${empty productList}">
						<div class="noData">
							상품이 없습니다.
						</div>
					</c:if>
				</div>
				<!-- 페이징 -->
				<div class="btnAreaList" style="width: 1200px;">
					<div class="allPageMoving1">
					
					<!-- 처음페이지 이동 -->
					<a href="/admin/product/${search}/${order}/1" class="n">
						<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로"/>
					</a>
					
					<!-- 앞페이지 이동 -->
					<c:if test="${page<=1}">
						<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로"/>
					</c:if>
					
					<c:if test="${page>1}">
						<a href="/admin/product/${search}/${order}/${page-1}" class="pre">
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
								<a href="/admin/product/${search}/${order}/${a}">
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
						<a href="/admin/product/${search}/${order}/${page+1}" class="next">
							<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로"/>
						</a>
					</c:if>
					<!-- 마지막페이지 이동 -->
					<a href="/admin/product/${search}/${order}/${maxPage}" class="n">
						<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로"/>
					</a>
	
					</div>
					<div id="insert_wrap">
						<a href="#" onclick="popup('/admin/product/insertView')" >
							<button>상품등록</button>
						</a>
					</div>
				</div>
				<!-- 페이징 -->

				<%-- 검색 폼 --%>
				<form action="/admin/product" method="get">
					<div class="searchWrap" style="width: 1140px; padding-left: 110px;">
						<div class="search">
							<ul>
								<li class="web"><img src="/img/temp/txt/txt_search.gif" alt="search" /></li>
								<li><input type="text" class="searchInput" name="searchtext" placeholder="제품/카테고리명" required></li>
								<li class="web"><button type="submit" class="no-outline"><img src="/img/temp/btn/btn_search.gif" alt="검색" /></button></li>
								<li class="mobile"><button type="submit" class="no-outline"><img src="/img/temp/btn/btn_search_m.gif" alt="검색" /></button></li>
							</ul>
						</div>
					</div>
				</form>
			</div>
		</div>
	</main>
	<script type="text/javascript">
	 function popup(url_){
		 	var img = 'imgpop';
            var url = url_;
            var option;
            var name = "popup test";
            if(url.indexOf(img)!=-1){
            	option = "width = 750, height = 470, top = 100, left = 200, scrollbars = no, location = no, toolbars = no, status = no ";
            }
            else{
            	option = "width = 1200, height = 700, top = 0, left = 400, location = no, toolbars = no, status = no ";
            }
            window.open(url, name, option);
        }
	</script>
	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
