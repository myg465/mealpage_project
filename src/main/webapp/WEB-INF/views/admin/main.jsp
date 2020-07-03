<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<%-- custom css for admin page --%>
	<link rel="stylesheet" href="/css/custom/admin.css">

	<style type="text/css">
		h1 {
			width: 1100px;
			font-size: 30px;
			text-align: center;
		}
		
		main h3 {
			font-size: 15px;
			margin: 20px 0px 10px;
		}
			
		.tableDiv {
			float: left;
		}
		.tableDiv table {
			
			font-size: 13px;
			text-align: center;
			border: 1px solid #d6dce7;
			border-collapse: collapse;
			border-spacing: 0;
		}
		.tableDiv table tr th {
			height: 20px;
			font-size : 0.92em;
			font-weight: normal;
			color: #fff;
			background: #6f809a;
			padding: 8px 5px;
			border: 1px solid #60718b;
		}
		.tableDiv table tr td {
			height: 20px;
			border: 1px solid #bebebe;
		}
		.tableDiv table tr:nth-of-type(2n) {
			background: #eff3f9;
		}
	
		.inquiryDiv {
			width: 324px;
			margin-left: 40px;
		}
	
		.orderDiv {
			width: 1050px;
			margin-left: 40px;
		}
		.adminMainPageOrderTable {
			width: 700px;
			float: left;
		}
		
		.exrereTable{
			width: 350px; height: 76px;
			float: left;

			border: 5px solid steelblue !important;
		}
	</style>

</head>

<body>
	<%@ include file="../common/explorer.jsp" %>
	<%@ include file="../common/admin_nav.jsp" %>

	<main>
		<h1>문의/주문 현황</h1>
				
		<div class="tableDiv inquiryDiv">
			<h3>회원 1:1 문의</h3>
			<table border="1">
				<tr>
					<th>문의 상태</th>
					<td>전체</td>
					<td>답변대기</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<th>건수</th>
					<td>${userInquriyTotal }</td>
					<td>${userInquiryWatingForAnswer }</td>
					<td>${userInquiryAnswerCompleted }</td>
				</tr>
			</table>
			<!-- Btn Area -->
			<div class="btnArea btline" style="margin-bottom: 30px">
				<div class="bRight">
					<ul>
						<li><a href="/admin/board/inquiry" class="sbtnMini mw">상세보기</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="tableDiv inquiryDiv">
			<h3>비회원 1:1 문의</h3>
			<table border="1">
				<tr>
					<th>문의 상태</th>
					<td>전체</td>
					<td>답변대기</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<th>건수</th>
					<td>${nonmemberInquiryTotal }</td>
					<td>${nonmemeberInquiryWatingForAnswer }</td>
					<td>${nonmemeberInquiryAnswerCompleted }</td>
				</tr>
			</table>
			<!-- Btn Area -->
			<div class="btnArea btline" style="margin-bottom: 30px">
				<div class="bRight">
					<ul>
						<li><a href="/admin/customer/nonmemberInquiry" class="sbtnMini mw">상세보기</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="tableDiv inquiryDiv">
			<h3>상품 문의(질문과 답변)</h3>
			<table border="1">
				<tr>
					<th>문의 상태</th>
					<td>전체</td>
					<td>답변대기</td>
					<td>답변완료</td>
				</tr>
				<tr>
					<th>건수</th>
					<td>${productInquiryTotal }</td>
					<td>${productInquiryWatingForAnswer }</td>
					<td>${productInquiryAnswerCompleted }</td>
				</tr>
			</table>
			<!-- Btn Area -->
			<div class="btnArea btline" style="margin-bottom: 30px">
				<div class="bRight">
					<ul>
						<li><a href="/admin/productInquiry" class="sbtnMini mw">상세보기</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="tableDiv orderDiv">
			<h3>회원 주문상태</h3>
			<table border="1" class="adminMainPageOrderTable">
				<tr>
					<th>주문 상태</th>
					<td>전체</td>
					<td>결제완료</td>
					<td>배송준비중</td>
					<td>배송중</td>
					<td>배송완료</td>
					<td>구매확정</td>
				</tr>
				<tr>
					<th>건수</th>
					<td>${userOrderTotal }</td>
					<td>${userOrderPaymentCompleted }</td>
					<td>${userOrderPreparingForDelivery }</td>
					<td>${userOrderShipping }</td>
					<td>${userOrderDeliveryCompleted }</td>
					<td>${userOrderConfirmPurchase }</td>
				</tr>
			</table>
			<table class="exrereTable">
				<tr>
					<td>교환요청</td>
					<td>반품요청</td>
					<td>환불대기</td>
					<td>기타</td>
				</tr>
				<tr>
					<td>${userOrderExchangeRequest }</td>
					<td>${userOrderReturnRequest }</td>
					<td>${userOrderWaitForRefund }</td>
					<td>${userOrderEtc }</td>
				</tr>
			</table>
			<!-- Btn Area -->
			<div class="btnArea btline" style="margin-bottom: 30px">
				<div class="bRight">
					<ul>
						<li><a href="/admin/order/user" class="sbtnMini mw">상세보기</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="tableDiv orderDiv">
			<h3>비회원 주문상태</h3>
			<table border="1" class="adminMainPageOrderTable">
				<tr>
					<th>주문 상태</th>
					<td>전체</td>
					<td>입금대기</td>
					<td>배송준비중</td>
					<td>배송중</td>
					<td>배송완료</td>
					<td>구매확정</td>
				</tr>
				<tr>
					<th>건수</th>
					<td>${nonmemberOrderTotal }</td>
					<td>${nonmemberOrderDepositWaiting }</td>
					<td>${nonmemberOrderPreparingForDelivery }</td>
					<td>${nonmemberOrderShipping }</td>
					<td>${nonmemberOrderDeliveryCompleted }</td>
					<td>${nonmemberOrderConfirmPurchase }</td>
				</tr>
			</table>
			<table class="exrereTable">
				<tr>
					<td>교환요청</td>
					<td>반품요청</td>
					<td>환불대기</td>
					<td>기타</td>
				</tr>
				<tr>
					<td>${nonmemberOrderExchangeRequest }</td>
					<td>${nonmemberOrderReturnRequest }</td>
					<td>${nonmemberOrderWaitForRefund }</td>
					<td>${nonmemberOrderEtc }</td>
				</tr>
			</table>
			<!-- Btn Area -->
			<div class="btnArea btline" style="margin-bottom: 30px">
				<div class="bRight">
					<ul>
						<li><a href="/admin/order/nonmember" class="sbtnMini mw">상세보기</a></li>
					</ul>
				</div>
			</div>
		</div>
		
	</main>

	

	<%@ include file="../common/admin_footer.jsp" %>
</body>
</html>
