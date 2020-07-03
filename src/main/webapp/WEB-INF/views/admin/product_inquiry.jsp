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
</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="product_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(3,0);</script>
			<div id="contents">
				<div class="orderDivNm" style="width: 1200px;">
					<table class="orderTable2" border="1" cellspacing="0" style="width: 1200px;">
						<colgroup>
							<col width="9%" class="tnone" />
							<col width="14%" class="tw20" />
							<col width="36%" class="tnone" />
							<col width="13%" class="tw30" />
							<col width="10%" class="tw30" />
							<col width="9%" class="tw30" />
							<col width="9%" class="tw30" />
						</colgroup>
						<thead>
							<th scope="col" class="tnone">NO.</th>
							<th scope="col"><a href="/admin/productInquiry/${search}/name/1">상품명</a></th>
							<th scope="col">문의내용</th>
							<th scope="col">아이디</th>
							<th scope="col" class="tnone"><a href="/admin/productInquiry/${search}/created_date/1">등록일</a></th>
							<th scope="col"><a href="/admin/productInquiry/${search}/replyYes/1">답변여부</th>
							<th scope="col">삭제</th>
						</thead>
						<tbody>
							<c:forEach var="list" items="${inquiryList}">
								<tr>
									<td class="tnone">${list.seqKey}</td>
									<td>${list.name}</td>
									<td>
										${list.content}
										<c:if test="${list.secret=='y' }">
											<img alt="잠금" src="/img/temp/ico/ico_lock.gif">
										</c:if>
									</td>
									<td>${list.id}</td>
									<td class="tnone">
										<fmt:parseDate var="createdDate" value="${list.createdDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
										<fmt:formatDate value="${createdDate}" pattern="yyyy-MM-dd"/>
									</td>
									<td>
										<c:if test="${list.reply!='n' }">
											<a href="#" onclick="popup('/admin/productInquiry/reply/${list.seqKey}')">
												<button style="background-color: lightblue; color: black; cursor: pointer;">답변보기</button>
											</a>
										</c:if>
										<c:if test="${list.reply=='n' }">
											<a href="#" onclick="popup('/admin/productInquiry/reply/${list.seqKey}')">
												<button style="background-color: pink; color: black; cursor: pointer;">답변작성</button>
											</a>
										</c:if>
									</td>
									<td>
										<a href="/admin/productInquiry/delete/${list.seqKey}" 
										onclick="return confirm('삭제하시겠습니까?\n 삭제시 복구가 어렵습니다.')" >
										<button style="cursor: pointer;">삭제</button>
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<c:if test="${empty inquiryList}">
						<div class="noData">
							문의가 없습니다.
						</div>
					</c:if>
				</div>
				<!-- 페이징 -->
				<div class="btnAreaList" style="width: 1200px;">
					<div class="allPageMoving1">
					
					<!-- 처음페이지 이동 -->
					<a href="/admin/productInquiry/${search}/${order}/1" class="n">
						<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로"/>
					</a>
					
					<!-- 앞페이지 이동 -->
					<c:if test="${page<=1}">
						<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로"/>
					</c:if>
					
					<c:if test="${page>1}">
						<a href="/admin/productInquiry/${search}/${order}/${page-1}" class="pre">
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
								<a href="/admin/productInquiry/${search}/${order}/${a}">
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
						<a href="/admin/productInquiry/${search}/${order}/${page+1}" class="next">
							<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로"/>
						</a>
					</c:if>
					<!-- 마지막페이지 이동 -->
					<a href="/admin/productInquiry/${search}/${order}/${maxPage}" class="n">
						<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로"/>
					</a>
	
					</div>
				</div>
				<!-- 페이징 -->

				<%-- 검색 폼 --%>
				<form action="/admin/productInquiry" method="get">
					<div class="searchWrap" style="width: 1200px; padding-left: 70px;">
						<div class="search">
							<ul>
								<li class="web"><img src="/img/temp/txt/txt_search.gif" alt="search" /></li>
								<li><input type="text" class="searchInput" name="searchtext" placeholder="제품명" required></li>
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
            var url = url_;
            var name = "popup test";
            var option = "width = 750, height = 470, top = 100, left = 200, scrollbars = no, location = no, toolbars = no, status = no "
            window.open(url, name, option);
        }
	</script>

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
