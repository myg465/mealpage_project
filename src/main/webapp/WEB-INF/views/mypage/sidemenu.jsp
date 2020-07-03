<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<div id="left">
  <div id="title">MY PAGE<span>마이페이지</span></div>
  <ul>	
    <li><a href="/order" id="leftNavi1">주문/배송 조회</a></li>
    <li><a href="/takeback" id="leftNavi2">반품/교환 현황</a></li>
    <li><a href="/cart" id="leftNavi3">장바구니</a></li>
    <li><a href="/wishlist" id="leftNavi4">찜한 상품</a></li>
    <li><a href="/coupon" id="leftNavi5">나의 쿠폰</a></li>
    <li><a href="/point" id="leftNavi6">나의 포인트</a></li>
    <li><a href="/inquiry" id="leftNavi7">1:1문의</a></li>
    <li><a href="/account/modify" id="leftNavi8">회원정보 수정</a></li>
    <li class="last"><a href="/account/quit" id="leftNavi9">회원 탈퇴</a></li>
  </ul>			
</div>
