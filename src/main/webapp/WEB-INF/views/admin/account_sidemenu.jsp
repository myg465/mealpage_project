<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<div id="left">
  <div id="title2">회원관리</div>
  <ul>	
    <li><a href="/admin/account/list" id="leftNavi1">회원계정관리</a></li>
    <li><a href="/admin/account/point/add" id="leftNavi2">회원포인트발급내역</a></li>
    <li><a href="/admin/account/point/used" id="leftNavi3">회원포인트사용내역</a></li>
    <li><a href="/admin/account/coupon/able" id="leftNavi4">회원유효쿠폰내역</a></li>
    <li><a href="/admin/account/coupon/disable" id="leftNavi5">회원만료쿠폰내역</a></li>
  </ul>			
</div>
