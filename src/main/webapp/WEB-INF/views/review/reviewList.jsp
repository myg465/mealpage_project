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
<!-- goods review -->
<div class="goodsReview disnone">
	<div class="headTitle">
		
		<strong>상품리뷰&nbsp;</strong>상품리뷰는 주문조회 페이지에서 작성하실 수 있습니다.
		<c:if test="${accountKey!=null }">
			<p class="btn"><a href="/order" target="_top">상품평 작성</a></p>
		</c:if>
	</div>


	<!-- 구매후기 -->
	<div class="imgListType">
		<ul>
			<c:forEach var="reviewList" items="${reviewList}">
				<!-- List -->
				<!-- 사진이 있을때 -->
				<c:if test="${reviewList.imageFileName!='' and reviewList.imageFileName!=null}">
					<li>
						<div class="txt" style="width: 500px;">
							
							<div class="conf">
								${reviewList.content}
							</div>
							<div class="data">
								<p>작성자 <span> <c:out value="${fn:substring(reviewList.id,0,4)}"/>****</span></p>
								<p>등록일 <span><fmt:formatDate value="${reviewList.createdDate}" pattern="YYYY-MM-dd"/>  </span></p>
								<p>평점 
									<span class="ty">
										<c:forEach begin="1" end="${reviewList.grade}">
											<img src="/img/temp/ico/ico_star.gif" alt="별점" />
										</c:forEach>
									</span>
								</p>
							</div>
							<c:if test="${reviewList.accountKey==accountKey}">
								<div class="modify" >
										<a href="/review/reviewModifyView/${reviewList.seqKey }" class="popBtn">수정</a>
										<a href="/review/reviewDelete/${productKey}/${reviewList.seqKey}/${reviewList.imageFileName}"
										onclick="return confirm('삭제하시겠습니까?\n 삭제시 복구가 어렵습니다.')">삭제</a>
								</div>
							</c:if>
						</div>
						<a href="/review/reviewImageView/${reviewList.imageFileName }" class="popBtn"> 
							<div class="img"><img src="/files/review/${reviewList.imageFileName}" width="155" height="160" alt="" /></div>
						</a>
					</li>
				</c:if>
				<!-- 사진이 없을때 -->
				<c:if test="${reviewList.imageFileName=='' or reviewList.imageFileName==null}">
					<li>
						<div class="txt" style="width: 500px;">
							
							<div class="conf">
								${reviewList.content}
							</div>
							<div class="data">
								<p>작성자 <span> <c:out value="${fn:substring(reviewList.id,0,4)}"/>****</span></p>
								<p>등록일 <span><fmt:formatDate value="${reviewList.createdDate}" pattern="YYYY-MM-dd"/>  </span></p>
								<p>평점 
									<span class="ty">
										<c:forEach begin="1" end="${reviewList.grade}">
											<img src="/img/temp/ico/ico_star.gif" alt="별점" />
										</c:forEach>
									</span>
								</p>
							</div>
							<c:if test="${reviewList.accountKey==accountKey}">
								<div class="modify" >
										<a href="/review/reviewModifyView/${reviewList.seqKey }" class="popBtn">수정</a>
										<a href="/review/reviewDelete/${productKey}/${reviewList.seqKey}/${reviewList.imageFileName}"
										onclick="return confirm('삭제하시겠습니까?\n 삭제시 복구가 어렵습니다.')">삭제</a>
								</div>
							</c:if>
						</div>
					</li>
				</c:if>
			</c:forEach>
		</ul>
	</div>


	<!-- 페이징 -->
	<div class="btnAreaList">
		<!-- 페이징이동1 -->
		<div class="allPageMoving1">
		
		<!-- 처음페이지 이동 -->
		<a href="/review/reviewList/${productKey}/1" class="n">
			<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로"/>
		</a>
		
		<!-- 앞페이지 이동 -->
		<c:if test="${page<=1}">
			<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로"/>
		</c:if>
		
		<c:if test="${page>1}">
			<a href="/review/reviewList/${productKey}/${page-1}" class="pre">
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
					<a href="/review/reviewList/${productKey}/${a}">
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
			<a href="/review/reviewList/${productKey}/${page+1}" class="next">
				<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로"/>
			</a>
		</c:if>
		<!-- 마지막페이지 이동 -->
		<a href="/review/reviewList/${productKey}/${maxPage}" class="n">
			<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로"/>
		</a>

		</div>
		<!-- //페이징이동1 -->
	</div>
	<!-- 페이징 -->
<!-- 구매후기 -->
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script type="text/javascript" src="/js/temp/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="/js/custom/review.js"></script>
<link rel="stylesheet" type="text/css" href="/css/temp/jquery.fancybox-1.3.4.css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
</div>


