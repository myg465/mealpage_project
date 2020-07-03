<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<div id="gnb" style="z-index: 9;">
	<div id="title">
		<a href="/">
			<span class="meal">MEAL</span><span class="page">PAGE</span>
		</a>
	</div>
	<div id="top">
		<ul>
			<li class="brand t1"><a href="/admin" id="topNavi1">관리자 페이지</a></li>
			<li class="t2"><a href="/admin/product" id="topNavi2">상품관리</a>
				<ul id="topSubm2">
					<li><a href="/admin/product">상품관리</a></li>
					<li><a href="/admin/productReview">상품리뷰관리</a></li>
					<li><a href="/admin/productInquiry">상품문의관리</a></li>
				</ul>
			</li>
			<li class="t1"><a href="/admin/account/list" id="topNavi3">회원관리</a>
				<ul id="topSubm3">
					<li><a href="/admin/account/list">회원계정관리</a></li>
					<li><a href="/admin/account/point/add">회원포인트발급내역</a></li>
					<li><a href="/admin/account/point/used">회원포인트사용내역</a></li>
					<li><a href="/admin/account/coupon/able">회원유효쿠폰내역</a></li>
					<li><a href="/admin/account/coupon/disable">회원만료쿠폰내역</a></li>
				</ul>
			</li>
			<li class="t2"><a href="/admin/order/user" id="topNavi4">주문관리</a>
				<ul id="topSubm4">
					<li><a href="/admin/order/user">회원주문관리</a></li>
					<li><a href="/admin/order/nonmember">비회원주문관리</a></li>
				</ul>
			</li>
			<li class="t1"><a href="/admin/board/inquiry" id="topNavi5">게시판관리</a>
				<ul id="topSubm5">
					<li><a href="/admin/board/inquiry">회원문의관리</a></li>
					<li><a href="/admin/customer/nonmemberInquiry">비회원문의관리</a></li>
					<li><a href="/admin/customer/notice">공지사항관리</a></li>
					<li><a href="/admin/event/event">이벤트관리</a></li>
					<li><a href="/admin/customer/faq">FAQ관리</a></li>
					<li><a href="/admin/customer/guide">이용안내관리</a></li>
				</ul>
			</li>
			<li class="t2"><a href="/admin/banner" id="topNavi6">배너관리</a>
				<ul id="topSubm6">
					<li><a href="/admin/banner">배너관리</a></li>
				</ul>
			</li>
		</ul>
	</div>

	<script type="text/javascript">initTopMenu();</script>
</div>
