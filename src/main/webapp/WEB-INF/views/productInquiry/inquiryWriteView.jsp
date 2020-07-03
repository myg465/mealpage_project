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
<c:if test="${inquirySuccess==1 }">
	<script type="text/javascript">
		alert("저장이 완료되었습니다.");
		parent.location.reload();// 작성완료시 새로고침
		parent.$.fancybox.close();
		
	</script>
</c:if>
<div id="layerWrap">

<div class="inputWrap">
	<form action="/productInquiry/inquiryWrite" name="inquiryForm" id="inquiryForm" method="post">
		<div class="inputBody">
			<div class="title">질문과 답변</div>
			<p class="close"><a onclick="parent.$.fancybox.close();" href="javascript:;"><img src="/img/temp/btn/btn_input_close.gif" alt="닫기" /></a></p>
				
			<div class="checkDivMt">
				<table summary="문의사항을 비밀번호, 제목, 내용 순으로 작성 하실수 있습니다." class="checkTable" border="1" cellspacing="0">
					<caption>질문과 답변</caption>
					<colgroup>
					<col width="19%" class="tw30" />
					<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<input type="hidden" name="accountKey" value="${accountKey}"/>
							<input type="hidden" name="productKey" value="${seqKey}" />
							
							<th scope="row"><span>잠금</span></th>
							<td>
								<input type="radio" id="public" name="secret" class="w134" value="n" checked/>
								<label for="public">공개글</label>
								<input type="radio" id="secret" name="secret" class="w134" value="y" />
								<label for="secret">비밀글</label>
							</td>
						</tr>
						<tr>
							<th scope="row"><span>내용</span></th>
							<td>
								<textarea name="content" class="tta" required></textarea>
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