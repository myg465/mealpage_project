<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp" %>
<script type="text/javascript" src="/js/temp/common.js"></script>
</head>
<body>
<c:if test="${reviewSuccess==1 }">
	<script type="text/javascript">
		alert("저장이 완료되었습니다.");
		parent.location.reload();// 작성완료시 새로고침
		parent.$.fancybox.close();
	</script>
</c:if>
<c:if test="${noProduct=='y' }">
	<script type="text/javascript">
		alert("상품이 존재하지 않습니다.");
		parent.$.fancybox.close();
	</script>
</c:if>
<c:if test="${statusAll.status!='구매확정' or statusAll.review!='N' }">
	<script type="text/javascript">
		alert("구매확정한 회원만 1회 리뷰작성이 가능합니다.");
		parent.$.fancybox.close();
	</script>
</c:if>
<div id="layerWrap">

<div class="inputWrap">
	<form action="/review/reviewWrite/" name="reviewForm" id="reviewForm" method="post" enctype="multipart/form-data">
		<div class="inputBody">
			<div class="title">리뷰 작성하기</div>
			<p class="close"><a onclick="parent.$.fancybox.close();" href="javascript:;"><img src="/img/temp/btn/btn_input_close.gif" alt="닫기" /></a></p>
				
			<div class="checkDivMt">
				
				<table summary="분류, 구매여부, 작은이미지, 평가, 제목, 상세 내용 순으로 포토 리뷰를 작성 하실수 있습니다." class="checkTable" border="1" cellspacing="0">
					<caption>리뷰 작성</caption>
					<colgroup>
					<col width="19%" class="tw30" />
					<col width="*" />
					</colgroup>
					<tbody>
						<input type="hidden" name="accountKey" value="${accountKey}" />
						<input type="hidden" name="productKey" value="${productKey }"/>				
						
						<tr>
							<th scope="row"><span>작은이미지</span></th>
							<td>
								<input type="file" name="imageFileName" class="fileType" />
							</td>
						</tr>
						<tr>
							<th scope="row"><span>평가</span></th>
							<td>
								<ul class="pta">
									<c:forEach begin="1" end="5" varStatus="star">
										<li>
											<!-- foreach역순으로 출력하는 로직(별점이 5일경우 체크되도록 설정) -->
											<input type="radio" name="grade" id="star${6-star.count }" value="${6-star.count }"
											<c:if test="${star.count==1 }"> checked="checked" </c:if>/>
											
											<label for="star${6-star.count }" class="star">
												<c:forEach begin="1" end="${6-star.count }">
													<img src="/img/temp/ico/ico_star.gif" alt="별점" />
												</c:forEach>
											</label>
										</li>
									</c:forEach>
								</ul>
							</td>
						</tr>
						
						<tr>
							<th scope="row"><span>내용</span></th>
							<td>
								<textarea name="content" class="tta" required ></textarea>
							</td>
						</tr>								
					</tbody>
				</table>
				
			</div>
				
			<!-- Btn Area -->
			<div class="btnArea">
				<div class="bCenter">
					<ul>								
						<li><button type="submit" class="sbtnMini" style="border: none">확인</button></li>
						<li><a onclick="parent.$.fancybox.close();" href="javascript:;" class="nbtnbig">취소</a></li>
					</ul>
				</div>
			</div>
			<!-- //Btn Area -->
			
		</div>
	</form>
</div>


</div>
</body>
</html>