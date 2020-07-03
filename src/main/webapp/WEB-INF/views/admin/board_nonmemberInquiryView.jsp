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
	
	<script type="text/javascript">
		function replyOn() {
			$("#replytxt").css('display','block');
			$("#replySubmitBtn").css('display','block');
			$("#replyBtn").css('display','none');
		}	
	
		function replyOff() {
			$("#replytxt").css('display','none');
			$("#replySubmitBtn").css('display','none');
			$("#replyBtn").css('display','block');
		}
		
		function nonmemberInquiryCheck() {
			if(nonmemberInquiryForm.reply.value == "") {
				alert("답글을 입력해 주세요.");
				return false;
			}
			
			nonmemberInquiryForm.submit();
		}
		
	</script>
	
	<style type="text/css">
		.orderDivNm {
			margin-top: 20px;
		}
		.inbox {
			font-size: 13px;
			line-height: 20px;
		}
	
	</style>
</head>

<body>
	<c:if test="${param.updateCheck == 1}">
		<script type="text/javascript">
			alert("답변이 정상적으로 수행되었습니다.");
		</script>
	</c:if>
	<c:if test="${param.updateCheck != 1 && param.updateCheck != null}">
		<script type="text/javascript">
			alert("오류가 발생 했습니다. 다시 시도해 주세요.");
			history.back(-1);
		</script>
	</c:if>


	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<div id="outbox">
			<%@ include file="board_sidemenu.jsp" %>
			<script type="text/javascript">initSubmenu(2,0);</script>
			<div id="contents">
				<div class="viewDiv">
					<div class="viewHead">
						<div class="subject">
							<ul>
								<li>${nonmemberInquiryAdminView.getTitle()}</li>
							</ul>
						</div>
						<div class="day">
							<p class="txt">
								등록일
								<span>
									<fmt:formatDate value="${nonmemberInquiryAdminView.getCreatedDate() }"
											pattern="YYY-MM-dd"/>
								</span>
							</p>
							<p class="btn">
								<c:choose>
									<c:when test="${nonmemberInquiryAdminView.getReplied() == 'N'}">
										<span class="nbtnMini">답변대기</span>
									</c:when>
									<c:otherwise>
										<span class="obtnMini">답변완료</span>
									</c:otherwise>
								</c:choose>	
							</p>
						</div>
						<div class="day">
							<p class="txt">
								이름
								<span>
									${nonmemberInquiryAdminView.getName() }
								</span>
							</p>
						</div>
						<div class="day">
							<p class="txt">
								이메일
								<span>
									${nonmemberInquiryAdminView.getEmail() }
								</span>
							</p>
						</div>
						<div class="day">
							<p class="txt">
								연락처
								<span>
									${nonmemberInquiryAdminView.getPhone() }
								</span>
							</p>
						</div>
					</div>

					<div class="viewContents">
						${nonmemberInquiryAdminView.getContent()}
						<br/><br/>
						<c:if test="${nonmemberInquiryAdminView.getFileName() != null && nonmemberInquiryAdminView.getFileName() != ''}">
							<img alt="비회원 1:1 문의 내용 이미지"
								src="/files/customer/nonmemberInquiry/${nonmemberInquiryAdminView.getFileName()}"
								style="width: 100%">
						</c:if>
					</div>
				</div>

				<!-- Btn Area -->
				<div class="btnArea btline" style="margin-bottom: 30px">
					<div class="bRight">
						<ul>
							<c:if test="${nonmemberInquiryAdminView.getReplied() == 'N'}">
								<li><a href="#" class="nbtnbig mw" id="replyBtn" onclick="replyOn()">답변하기</a></li>
							</c:if>
							<li><a href="/admin/customer/nonmemberInquiry/delete/${nonmemberInquiryAdminView.getSeqKey() }/${nonmemberInquiryAdminView.getFileName() }" class="nbtnbig mw" 
									onclick="return confirm('삭제 하시겠습니까?\n 삭제시 복구가 어렵습니다.')">문의삭제</a></li>
							<li><a href="/admin/customer/nonmemberInquiry" class="sbtnMini mw">목록</a></li>
						</ul>
					</div>
				</div>

				<c:if test="${nonmemberInquiryAdminView.getReplied() == 'N'}">
					<form action="/admin/customer/nonmemberInquiry/reply/${nonmemberInquiryAdminView.getSeqKey() }/${page}" name="nonmemberInquiryForm" id="nonmemberInquiryForm" method="post">
						<!-- 답변 -->
						<div class="answer" id="replytxt" style="display: none">
							<div class="inbox">
								<div class="atxt">
									<textarea class="tta" name="reply" id="reply" maxlength=10000 required></textarea>
								</div>
							</div>
						</div>
						<!-- //답변 -->
	
					</form>
					
					<!-- Btn Area -->
					<div class="btnArea" id="replySubmitBtn" style="display: none">
						<div class="bCenter">
							<ul>
								<li><button onclick="replyOff()" class="nbtnbig">취소</button></li>
								<li><button onclick="nonmemberInquiryCheck(); return false;" class="sbtnMini">확인</button></li>
								<!-- <li><a href="#" class="nbtnbig">취소</a></li>
								<li><a href="#" class="sbtnMini">확인</a></li> -->
							</ul>
						</div>
					</div>
					<!-- //Btn Area	 -->
				</c:if>
				<c:if test="${nonmemberInquiryAdminView.getReplied() == 'Y'}">
					<div class="viewHead" style="border-top : 1px solid gray">
						<div class="day">
							<p class="txt">
								답변일
								<span>
									<fmt:formatDate value="${nonmemberInquiryAdminView.getReplyCreatedDate() }"
											pattern="YYY-MM-dd"/>
								</span>
							</p>
						</div>
					</div>
					<div class="answer">
						<div class="inbox">
							${nonmemberInquiryAdminView.getReply() }
						</div>
					</div>
				</c:if>
				
				
				<div class="orderDivNm">
					<table class="orderTable2" border="1" cellspacing="0">
						<colgroup>
							<col width="9%" class="tnone" />
							<col width="14%" class="tw20" />
							<col width="*" />
							<col width="15%" class="tnone" />
							<col width="15%" class="tw30" />
						</colgroup>
						<thead>
							<th scope="col" class="tnone">NO.</th>
							<th scope="col">이름</th>
							<th scope="col">제목</th>
							<th scope="col" class="tnone">등록일</th>
							<th scope="col">처리상태</th>
						</thead>
						<tbody>
							<c:forEach var="nonmemverInquiryList" items="${nonmemverInquiryList}">
								<tr>
									<td class="tnone">${nonmemverInquiryList.getSeqKey()}</td>
									<td>${nonmemverInquiryList.getName() }</td>
									<td class="left">
										<c:if test="${nonmemverInquiryList.getSeqKey() == seqKey}">
											<strong style="font-size: 17px"> >	${nonmemverInquiryList.getTitle() } </strong>
										</c:if>
										<c:if test="${nonmemverInquiryList.getSeqKey() != seqKey}">
											<a href="/admin/customer/nonmemberInquiry/view/${nonmemverInquiryList.getSeqKey()}/${page}">${nonmemverInquiryList.getTitle()}</a>
										</c:if>
									</td>
									<td class="tnone">
										<fmt:formatDate value="${nonmemverInquiryList.getCreatedDate() }"
											pattern="YYY-MM-dd"/>
									</td>
									<td>
										<ul class="state">
											<li>
												<c:choose>
													<c:when test="${nonmemverInquiryList.getReplied() == 'N'}">
														<div class="nbtnMini iw83">답변대기</div>
													</c:when>
													<c:otherwise>
														<div class="obtnMini iw83">답변완료</div>
													</c:otherwise>
												</c:choose>	
											</li>
										</ul>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="btnAreaList">		
					<%-- 페이지 네비게이션 시작 --%>
					<div class="page-nav">
						<c:if test="${page != 1}">
							<a href="/admin/customer/nonmemberInquiry/view/${seqKey }/1" class="page-nav-nobox">
								<i class="fas fa-angle-double-left paging"></i>
							</a>
							<a href="/admin/customer/nonmemberInquiry/view/${seqKey }/${page - 1}" class="page-nav-nobox">
								<i class="fas fa-angle-left paging"></i>
							</a>
						</c:if>

						<c:forEach var="i" begin="${startPage }" end="${endPage }">
							<c:choose>
								<c:when test="${i == page}">
									<a href="/admin/customer/nonmemberInquiry/view/${seqKey }/${i}" class="page-nav-now">${i}</a>
								</c:when>
								<c:otherwise>
									<a href="/admin/customer/nonmemberInquiry/view/${seqKey }/${i}" class="page-nav-box">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:if test="${page != maxPage && !noticeList.isEmpty()}">
							<a href="/admin/customer/nonmemberInquiry/view/${seqKey }/${page + 1}" class="page-nav-nobox">
								<i class="fas fa-angle-right paging"></i>
							</a>
							<a href="/admin/customer/nonmemberInquiry/view/${seqKey }/${maxPage }" class="page-nav-nobox">
								<i class="fas fa-angle-double-right paging"></i>
							</a>
						</c:if>
					</div>
					<%-- 페이지 네비게이션 끝 --%>
				</div>
				
			</div>
		</div>
	</main>

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
