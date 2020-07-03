<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/head.jsp" %>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description" content="MEALPAGE" />
<meta name="keywords" content="MEALPAGE" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scaleable=no" />
<link rel="stylesheet" type="text/css" href="/css/temp/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/temp/content.css" />
<script type="text/javascript" src="/js/temp/jquery.min.js"></script>
<script type="text/javascript" src="/js/temp/common.js"></script>

<!-- 파일라벨 css -->
<style type="text/css">
.newFileLabel{ width:33px !important; height:20px; line-height:20px;
              background:#eee; border:1px #c0c0c0 solid; padding:2px 0 0 2px !important; }
.oldfile{ width: 300px !important; border:none;}
</style>
</head>
<body>
<c:if test="${modifySuccess==1 }">
	<script type="text/javascript">
		alert("저장이 완료되었습니다.");
		parent.location.reload();// 작성완료시 새로고침
		parent.$.fancybox.close();
	</script>
</c:if>
<div id="layerWrap">
<c:set var="modify" value="${reviewModifyView }" />
<div class="inputWrap">
	<form action="/review/reviewModify/" name="reviewModifyForm" id="reviewModifyForm" method="post" enctype="multipart/form-data">
		<div class="inputBody">
			<div class="title">리뷰 수정하기</div>
			<p class="close"><a onclick="parent.$.fancybox.close();" href="javascript:;"><img src="/img/temp/btn/btn_input_close.gif" alt="닫기" /></a></p>
				
			<div class="checkDivMt">
				
				<table summary="분류, 구매여부, 작은이미지, 평가, 제목, 상세 내용 순으로 포토 리뷰를 작성 하실수 있습니다." class="checkTable" border="1" cellspacing="0">
					<caption>리뷰 수정</caption>
					<colgroup>
					<col width="20%" class="tw30" />
					<col width="60%" />
					<col width="20%" />
					</colgroup>
					<tbody>
						<input type="hidden" name="seqKey" value="${modify.seqKey }"/>
						<input type="hidden" name="originFileName" value="${modify.imageFileName }"/>
						<tr>
							<th scope="row"><span>작은이미지</span></th>
							<td>
					               기존 파일 : <input type="text" name="oldfile" id="oldfile" class="oldfile" value="${modify.imageFileName }" readonly /><br><br>
					            <span style="line-height: 21px; margin-right: 3px;">새 파일 </span><input type="file" name="imageFileName" id="newFile" class="newFile"/>
							</td>
							<td>
					            <img alt="" src="/files/review/${modify.imageFileName }" width="60px" height="60px"><br>
							</td>
						</tr>
						<tr>
							<th scope="row"><span>평가</span></th>
							<td colspan="2">
								<ul class="pta">
									<c:forEach begin="1" end="5" varStatus="star">
										<li>
											<!-- foreach역순으로 출력하는 로직(별점 5부터 출력) -->
											<input type="radio" name="grade" id="star${6-star.count }" value="${6-star.count }"
											<c:if test="${(6-star.count)==modify.grade }"> checked="checked" </c:if>/>
											
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
							<td colspan="2">
								<textarea name="content" class="tta" required>${modify.content }</textarea>
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