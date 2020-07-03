<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp"%>
	
	<!--[if lt IE 9]>
	<script type="text/javascript" src="../js/html5.js"></script>
	<script type="text/javascript" src="../js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
		$(document).ready(function() {
	
		});
	</script>
	<style type="text/css">
		#guideList ul {
			padding: 15px 10px 0px;
		}
		#guideList ul h5 {
			color: #4682B4;
			font-size: 15px;
			padding-bottom: 5px;
		}
		#guideList ul li {
			font-size: 13px;
			padding: 0px 0px 15px 10px;
			border-bottom : 1px dashed #666;
			line-height: 18px;
		}
		#guideList ul #last {
			border-bottom : 0px;
		}
	
	</style>
	
</head>
<body>



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
						<li class="last">이용안내</li>
					</ol>
				</div>

				<div id="outbox">
					<%@ include file="sidemenu.jsp"%>
					<script type="text/javascript">	initSubmenu(4, 0);</script>


					<!-- contents -->
					<div id="contents">
						<div id="customer">
							<h2>
								<strong>이용안내</strong><span>이용안내 페이지 입니다.</span>
							</h2>

							<div id="guideList">
								<c:forEach var="guideList" items="${guideList }" varStatus="vs">
									<ul>
										<h5>${guideList.getTitle() }</h5>
										<c:if test="${!vs.last }">
											<li>${guideList.getContent() }</li>
										</c:if>
										<c:if test="${vs.last }">
											<li id="last">${guideList.getContent() }</li>
										</c:if>
										
									</ul>
									
								
								</c:forEach>
								
							
							</div>



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