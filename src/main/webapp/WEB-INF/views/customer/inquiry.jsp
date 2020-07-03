<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
	
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp"%>
	
	<!--[if lt IE 9]>
		<script type="text/javascript" src="../js/html5.js"></script>
		<script type="text/javascript" src="../js/respond.min.js"></script>
		<![endif]-->
	<script type="text/javascript" src="/js/custom/nonmemberInquiry.js"></script>
	
	<style type="text/css">
		.wShort {
			width: 30%; height:18px;
			line-height: 18px;
			background: #fff;
			border:1px #d9d9d9 solid;
			padding: 0 5px;
			font-size:12px;
		}
		
		.bCenter ul li button{
			border: 0px;
			outline: 0px;
		}
		
		.bCenter ul li button:hover{
			cursor: pointer;
		}
	</style>
</head>
<body>
	
	<!-- 로그인 되어 있는 경우 myPage -> user_inquiry 로 이동 -->
	<c:if test="${accountKey != 0 }">
		<jsp:forward page="/inquiry" />
	</c:if>
	
	<!-- 작성된 내용이 정상적으로 DB에 저장 되었는지 알림 -->
	<c:if test="${param.insertCheck == 1}">
		<script type="text/javascript">
			alert("문의가 정상적으로 접수 되었습니다.");
		</script>
	</c:if>
	<c:if test="${param.insertCheck != 1 && param.insertCheck != null}">
		<script type="text/javascript">
			alert("오류가 발생 했습니다. 다시 시도해 주세요.");
			history.back(-1);
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
						<li><a href="/">HOME</a></li>
						<li><a href="/customer/notice">CUSTOMER</a></li>
						<li class="last">1:1문의</li>
					</ol>
				</div>

				<div id="outbox">
					<%@ include file="sidemenu.jsp"%>
					<script type="text/javascript">	initSubmenu(2, 0);</script>
					
					<!-- contents -->
					<div id="contents">
						<div id="customer">
							<h2>
								<strong>1:1문의</strong><span>밀페이지에 궁금하신 사항을 남겨주시면 답변해드립니다.</span>
							</h2>
							<form action="/customer/inquiryWrite" name="nonmemberInquiryForm" id="nonmemberInquiryForm" method="post" enctype="multipart/form-data">
								<div class="checkMt">
									<table summary="이름, 이메일, 연락처, 제목, 상세내용, 첨부파일 순으로 궁금하신 점을 문의 하실수 있습니다."
										class="checkTable" border="1" cellspacing="0">
										<caption>1:1문의</caption>
										<colgroup>
											<col width="19%" class="tw30" />
											<col width="*" />
										</colgroup>
										<tbody>
											<tr>
												<th scope="row"><span>이름</span></th>
												<td><input type="text" name="nonmemberInquiryName" class="wShort" />	</td>
											</tr>
											<tr>
												<th scope="row"><span>이메일</span></th>
												<td>
													<input type="text" name="nonmemberInquiryEmailHead" class="wShort"/>
													@
													<input type="text" name="nonmemberInquiryEmailTail" id="nonmemberInquiryEmailTail" class="wShort"/>
													<select id="emailTailDropbox">
														<option selected>직접입력</option>
														<option>네이버</option>
														<option>지메일</option>
														<option>한메일(다음)</option>
														<option>네이트</option>
														<option>야후</option>
													</select>
												</td>
											</tr>
											<tr>
												<th scope="row"><span>연락처</span></th>
												<td>
													<input type="text" name="nonmemberInquiryTell" class="wShort"/>
													'-'는 생략하고 입력해 주세요.
												</td>
											</tr>
											<tr>
												<th scope="row"><span>제목</span></th>
												<td><input type="text" name="nonmemberInquiryTitle" class="wlong" /></td>
											</tr>
											<tr>
												<th scope="row"><span>상세 내용</span></th>
												<td><textarea name="nonmemberInquiryContent" class="tta"></textarea></td>
											</tr>
											<tr>
												<th scope="row"><span>첨부파일</span></th>
												<td><input type="file" name="nonmemberInquiryFileName" class="fileType" /></td>
											</tr>
										</tbody>
									</table>
								</div>
	
								<!-- Btn Area -->
								<div class="btnArea">
									<div class="bCenter">
										<ul>
											<li><button type="reset" class="nbtnbig">취소</button></li>
											<li><button onclick="nonmemberinquiryCheck(); return false;" class="sbtnMini">확인</button></li>
											<!-- <li><a href="#" class="nbtnbig">취소</a></li>
											<li><a href="#" class="sbtnMini">확인</a></li> -->
										</ul>
									</div>
								</div>
								<!-- //Btn Area	 -->
							</form>
						</div>
					</div>
					<!-- //contents -->


				</div>
			</div>
			<!-- //container -->

			<%@ include file="../common/footer.jsp" %>


		</div>
	</div>
</body>
</html>