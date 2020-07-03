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
<c:if test="${nonmemberName==null }">
	<script type="text/javascript">
		alert("잘못된 접근입니다.");
		window.location.href="/account/login";
	</script>
</c:if>
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
						<li><a href="#">비회원 주문조회</a></li>
						<li class="last">비회원 주문조회</li>
					</ol>
				</div>

				<div id="outbox">
					<%@ include file="sidemenu.jsp"%>
					<script type="text/javascript">	initSubmenu(1, 0);</script>
					
					<!-- contents -->
					<div id="contents">
						<div id="mypage">
							<h2>
								<strong>비회원 주문조회</strong><span>비회원 구매하신 주문내역을 확인하실 수 있습니다.</span>
							</h2>


							<h3 class="dep">주문내역</h3>
							<div class="orderDivNm">
								<table summary="주문일자/주문번호, 상품명, 가격, 수량, 주문상태 순으로 조회를 하실수 있습니다."
									class="orderTable" border="1" cellspacing="0">
									<caption>주문게시판</caption>
									<colgroup>
										<col width="25%" class="tw28" />
										<col width="*" />
										<col width="15%" class="tnone" />
										<col width="8%" class="tnone" />
										<col width="18%" class="tw30" />
									</colgroup>
									<thead>
										<th scope="col">주문일자 <span>/ 주문번호</span></th>
										<th scope="col">상품명</th>
										
										<c:if test="${listStat == 0 }">
											<th colspan="2">총 가격</th>
										</c:if>
										<c:if test="${listStat == 1 }">
											<th scope="col" class="tnone">가격</th>
											<th scope="col" class="tnone">수량</th>
										</c:if>
										<th scope="col">주문상태</th>
									</thead>
									
									<tbody>
										<c:if test="${listStat == 0 && listSize != 0}">
											<!-- 주문번호 클릭전 리스트 전체 값 -->
											<tr>
												<td>
													<p class="day">
														<fmt:formatDate value="${nonmemberOrderList[0].getCreatedDate() }"
															pattern="YYYY-MM-dd"/>
													</p>
													<p class="orderNum"><a href="/nonmember/ordercheck/1/1">${nonmemberOrderList[0].getOrderNumber() }</a></p>
												</td>
												<td class="left">${nonmemberOrderList[0].getProductName() } 외 ${listCount-1 }종</td>
												<td colspan="2" class="tnone">
													<fmt:formatNumber value="${totalPrice }" groupingUsed="true"/> 원
												</td>
												<c:choose>
												<c:when test="${nonmemberOrderList[0].getStatus() == '배송완료' }">
													<td>
														<span class="heavygray">배송완료</span>
													</td>
												</c:when>
												<c:when test="${nonmemberOrderList[0].getStatus() == '입금대기중' }">
													<td>
														<span class="lightgray">${nonmemberOrderList[0].status }</span>
													</td>
												</c:when>
												<c:when test="${nonmemberOrderList[0].getStatus() == '입금완료' }">
													<td>
														<span class="lightgray">입금완료</span>
													</td>
												</c:when>
												<c:otherwise>
													<td>
														<span class="orange" id="nobtnstatus">${nonmemberOrderList[0].status }</span><!-- 배송중,배송완료중일경우 버튼이 활성화 되지 않음 -->
													</td>
												</c:otherwise>
												</c:choose>
											</tr>
										</c:if>	
										<!-- 전체개괄 -->
										<c:if test="${listStat == 1 }">
										<!-- 주문번호 클릭으로 리스트 펼쳤을 경우 -->
											<c:forEach var="list" items="${nonmemberOrderList }">
											
										 		<tr>
													<td>
														<p class="day">
															<fmt:formatDate value="${list.createdDate }"
																pattern="YYYY-MM-dd"/>
														</p>
														<p class="orderNum"><a href="/nonmember/ordercheck/1/0">${list.orderNumber }</a></p>
													</td>
													<td class="left">
														<a href="/product/detail/${list.productKey}"> 
															${list.productName }
														</a>
													</td>
													<td class="tnone">
														<fmt:formatNumber value="${list.productPrice }" groupingUsed="true"/> 원
													</td>
													<td class="tnone">${list.quantity } 개</td>
													
													<c:choose>
														
														<c:when test="${list.status == '배송완료' }">
															<td>
																<a href="#"
																onclick="popup('/nonmember/deliveryView/'+${list.seqKey})" style="cursor: pointer;">
																	<span class="heavygray">${list.status }</span>
																</a>
																<ul class="state">
																	<li>
																		<a href="#" onclick="buyOk(${list.seqKey })" class="nbtnMini iw83">
																			구매확정
																		</a>
																	</li>
																	<li class="r5">
																		<a href="#" class="obtnMini iw83"
																		onclick="popup('/nonmember/takebackWriteView/배송완료/'+${list.seqKey})" style="cursor: pointer;">
																			반품 등 신청
																		</a>
																	</li>
																</ul>
															</td>
														</c:when>
														<c:when test="${list.status == '입금대기' }">
															<td>
																<a href="#"
																onclick="popup('/nonmember/deliveryView/'+${list.seqKey})" style="cursor: pointer;">
																	<span class="lightgray">${list.status }</span>
																</a>
																<ul class="state">
																	<li>
																		<a href="#" onclick="orderCancel(${list.seqKey},${list.productKey},${list.quantity})" class="nbtnMini iw83" style="cursor: pointer;">
																			취소
																		</a>
																	</li><!-- 입금대기중일경우 바로취소 버튼이 활성화 -->
																</ul>
															</td>
														</c:when>
														<c:when test="${list.status == '배송준비중' }">
															<td>
																<a href="#"
																onclick="popup('/nonmember/deliveryView/'+${list.seqKey})" style="cursor: pointer;">
																	<span class="lightgray">${list.status }</span>
																</a>
																<ul class="state">
																	<li>
																		<a href="#" class="nbtnMini iw83"
																		onclick="popup('/nonmember/takebackWriteView/배송준비중/'+${list.seqKey})" style="cursor: pointer;">
																			취소
																		</a>
																	</li><!-- 입금대기중일경우 취소 버튼이 활성화 -->
																</ul>
															</td>
														</c:when>
														<c:when test="${list.status == '배송중' }">
															<td>
																<a href="#"
																onclick="popup('/nonmember/deliveryView/'+${list.seqKey})" style="cursor: pointer;">
																	<span class="lightgray">${list.status }</span>
																</a>
																<ul class="state">
																	<li>
																		<a href="#" onclick="deliveryOk(${list.seqKey })" class="nbtnMini iw83">
																			수취확인
																		</a>
																	</li>
																	<li>
																		<a href="#" class="obtnMini iw83"
																		onclick="popup('/nonmember/takebackWriteView/배송중/'+${list.seqKey})" style="cursor: pointer;">
																			반품 등 신청
																		</a>
																	</li><!-- 배송중일경우 수취확인,반품등 신청 버튼이 활성화 -->
																</ul>
															</td>
														</c:when>
														<c:otherwise>
															<td>
																<a href="#"
																onclick="popup('/nonmember/deliveryView/'+${list.seqKey})" style="cursor: pointer;">
																	<span class="orange">${list.status }</span>
																</a>
															</td>
														</c:otherwise>
													</c:choose>
												</tr>
											</c:forEach>
										</c:if>
									
									</tbody>
								</table>
								<c:if test="${listSize == 0 }">
									<div class="noData">주문내역이 없습니다.</div>		
								</c:if>
								
							</div>

							<c:if test="${listStat == 1 && listSize != 0}">
								<div class="btnAreaList">
									<!-- 페이징이동1 -->
																	
									<div class="allPageMoving1">
										<!-- 처음페이지로 -->
										<a href="/nonmember/ordercheck/1/1" class="n">
											<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로" />
										</a>
										<!-- 이전페이지로 -->
										<c:if test="${page <= 1 }">
											<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
										</c:if>
										<c:if test="${page > 1 }">
					 						<a href="/nonmember/ordercheck/${page-1 }/1" class="pre">
												<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로" />
												</a> 
										</c:if>
										
										<!-- 순차적으로 페이지 출력 -->
										<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1" >
											<c:choose>
												<c:when test="${i == page }">
													<strong>${i }</strong>
												</c:when>
												<c:when test="${i != page }">
													<a href="/nonmember/ordercheck/${i }/1">
													${i }
													</a>
												</c:when>
											</c:choose>
										
										</c:forEach>
	
										<!-- 다음페이지로 -->
										<c:if test="${page >= maxPage }">
											<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
										</c:if>
										<c:if test="${page < maxPage }">
											<a href="/nonmember/ordercheck/${page+1 }/1" class="next">
												<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로" />
											</a>
										</c:if>
										
										<!-- 마지막페이지로 -->
										<a href="/nonmember/ordercheck/${maxPage }/1" class="n">
											<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로" />
										</a>
										
										
									</div>
									<!-- //페이징이동1 -->
								</div>
							</c:if>
							

						</div>
					</div>
					<!-- //contents -->

					<script type="text/javascript" src="../js/jquery.fancybox-1.3.4.pack.js"></script>
					<link rel="stylesheet" type="text/css" href="../css/jquery.fancybox-1.3.4.css" />
					<script type="text/javascript">
					//팝업띄우기 (레이어 팝업 동작안함)
					 function popup(url_){
				            var url = url_;
				            var name = "popup test";
				            var option = "width = 750, height = 470, top = 100, left = 200, scrollbars = no, location = no, toolbars = no, status = no "
				            window.open(url, name, option);
				        }
					function orderCancel(seqKey,productKey,quantity){
						console.log(seqKey);
						if(confirm('주문을 취소하시겠습니까?')){
						$.ajax({
					        url : "/nonmember/cancel",
					        type : "POST",
					        data: JSON.stringify({seqKey:seqKey,productKey:productKey,quantity:quantity}),
					        contentType: "application/json",
					        success : function(data){
					           if(data.result == "ok"){
					        	  alert('취소가 완료되었습니다.');
					              location.reload();
					           }
					        },
					        error : function(){
					           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteError)");
					        }
					     });
						}
					}
					function deliveryOk(seqKey){
						console.log(seqKey);
						$.ajax({
					        url : "/nonmember/deliveryOk",
					        type : "POST",
					        data: JSON.stringify({seqKey:seqKey}),
					        contentType: "application/json",
					        success : function(data){
					           if(data.result == "ok"){
					        	  alert('수취확인이 완료되었습니다.');
					              location.reload();
					           }
					        },
					        error : function(){
					           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteError)");
					        }
					     });
					}
					function buyOk(seqKey){
						console.log(seqKey);
						$.ajax({
					        url : "/nonmember/buyOk",
					        type : "POST",
					        data: JSON.stringify({seqKey:seqKey}),
					        contentType: "application/json",
					        success : function(data){
					           if(data.result == "ok"){
					        	  alert('구매확정이 완료되었습니다.');
					              location.reload();
					           }
					        },
					        error : function(){
					           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteError)");
					        }
					     });
					}
					</script>
				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>

		</div>
	</div>
</body>
</html>