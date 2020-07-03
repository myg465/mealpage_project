<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<%@ include file="../common/head.jsp" %>
<%@ include file="../common/explorer.jsp" %>
<script>
	function deletecheck(seqKey,reply){
		
		if(reply!='n'){
			alert("답변이 있을경우 삭제할수 없습니다.");
			return false;
		}
		
		var url= '/productInquiry/inquiryDelete/'+'<c:out value="${productKey}"/>'+'/'+seqKey;
		var result=confirm("정말로 삭제하시겠습니까?\n 삭제시 복구가 어렵습니다.");
		if(result==true){
			window.location.href=url;
		}else{
			alert("삭제취소");
		}
	}
</script>
<!-- detail content -->
<div id="detailContent">
<!-- 상품문의 -->
<!-- goods qna -->
<div class="goodsQna disnone">
	<div class="headTitle depth">
		<strong>질문과 답변&nbsp;</strong>상품과 관련된 문의와 답변을 하는 공간입니다. (로그인 후 문의가능)
		<c:if test="${accountKey!=null }">
			<p class="btn"><a href="/productInquiry/inquiryWriteView/${productKey}" class="popBtn">문의하기</a></p>
		</c:if>
	</div>

	<!-- 질문과 답변 -->
	<div class="accordion">
		<ul>
			<c:forEach var="inquiryList" items="${productInquiryList}">
				<li>
					<div class="headArea">
						<div class="subject">
							<a href="javascript:;" class="accbtn">
								<c:out value="${fn:substring(inquiryList.content,0,12)}"/>...
								<c:if test="${inquiryList.secret=='y' }">
									<img src="/img/temp/ico/ico_lock.gif" alt="비밀글" />
								</c:if>
							</a>
						</div>
						<div class="writer"><c:out value="${fn:substring(inquiryList.id,0,4)}"/>****</div>
						<div class="day">
							<p><fmt:formatDate value="${inquiryList.createdDate}" pattern="YYYY-MM-dd"/></p>
							<c:if test="${inquiryList.reply=='n'}">
								<p><span class="nbtnMini iw70">답변대기</span></p>
							</c:if>
							
							<c:if test="${inquiryList.reply!='n'}">
								<p><span class="obtnMini iw70">답변완료</span></p>
							</c:if>
						</div>
					</div>
					<!-- 잠금이 안되있을 경우 -->
					<c:if test="${inquiryList.secret=='n' }">
						<div class="hideArea">
							<div class="bodyArea">
								${inquiryList.content }
							</div>
							<c:if test="${inquiryList.reply!='n'}">
								<!-- 답변 -->
								<div class="answer">
									<div class="inbox">
										<div class="aname">
											<p>담당자</p>
										</div>
			
										<div class="atxt">
											${inquiryList.reply } 
										</div>
									</div>
								</div>
								<!-- //답변 -->
							</c:if>
							<c:if test="${accountKey==inquiryList.accountKey or authority=='admin'}">
								<div class="modify">
									<a href="/productInquiry/inquiryModifyView/${inquiryList.seqKey }" class="popBtn">수정</a>
									<a onclick="deletecheck('<c:out value="${inquiryList.seqKey}"/>',
									'<c:out value="${inquiryList.reply}"/>')"
									style="cursor: pointer;">삭제</a>
								</div>
							</c:if>
						</div>
					</c:if>
					<!-- 비밀글 설정시 보기 설정  -->
					<c:if test="${(inquiryList.secret=='y' and accountKey==inquiryList.accountKey) 
					or (inquiryList.secret=='y' and authority=='admin')}">
						<div class="hideArea">
							<div class="bodyArea">
								${inquiryList.content }
							</div>
							<c:if test="${inquiryList.reply!='n'}">
								<!-- 답변 -->
								<div class="answer">
									<div class="inbox">
										<div class="aname">
											<p>담당자</p>
										</div>
			
										<div class="atxt">
											${inquiryList.reply } 
										</div>
									</div>
								</div>
								<!-- //답변 -->
							</c:if>
							<c:if test="${accountKey==inquiryList.accountKey or authority=='admin'}">
								<div class="modify">
									<a href="/productInquiry/inquiryModifyView/${inquiryList.seqKey }" class="popBtn">수정</a>
									<a onclick="deletecheck('<c:out value="${inquiryList.seqKey}"/>',
									'<c:out value="${inquiryList.reply}"/>')"
									style="cursor: pointer;">삭제</a>
								</div>
							</c:if>
						</div>
					</c:if>
					
				</li>
			</c:forEach>

		</ul>
	</div>
	<!-- //질문과 답변 -->

	<!-- 페이징 -->
	<div class="btnAreaList">
		<!-- 페이징이동1 -->
		<div class="allPageMoving1">
		
		<!-- 처음페이지 이동 -->
		<a href="/productInquiry/inquiryList/${productKey}/1" class="n">
			<img src="/img/temp/btn/btn_pre2.gif" alt="처음으로"/>
		</a>
		
		<!-- 앞페이지 이동 -->
		<c:if test="${page<=1}">
			<img src="/img/temp/btn/btn_pre1.gif" alt="앞페이지로"/>
		</c:if>
		
		<c:if test="${page>1}">
			<a href="/productInquiry/inquiryList/${productKey}/${page-1}" class="pre">
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
					<a href="/productInquiry/inquiryList/${productKey}/${a}">
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
			<a href="/productInquiry/inquiryList/${productKey}/${page+1}" class="next">
				<img src="/img/temp/btn/btn_next1.gif" alt="뒤페이지로"/>
			</a>
		</c:if>
		<!-- 마지막페이지 이동 -->
		<a href="/productInquiry/inquiryList/${productKey}/${maxPage}" class="n">
			<img src="/img/temp/btn/btn_next2.gif" alt="마지막페이지로"/>
		</a>

		</div>
		<!-- //페이징이동1 -->
	</div>
	<!-- 페이징 -->
</div>
<!-- //goods qna -->
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script type="text/javascript" src="/js/temp/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="/js/custom/productInquiry.js"></script>
<link rel="stylesheet" type="text/css" href="/css/temp/jquery.fancybox-1.3.4.css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<style type="text/css">
.ui-corner-all{border-bottom-right-radius:0 !important; border-bottom-left-radius:0 !important; border-top-left-radius:0 !important; border-top-right-radius:0 !important;}
.ui-widget-content{border:0;}
.ui-spinner-input{width:70px; margin:0; border:1px #ddd solid; padding:2px 0 2px 5px; font-family:'Nanum Gothic' !important; font-size:12px !important;}
</style>
</div>


