<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<div id="left">
  <div id="title2">게시판관리</div>
  <ul>	
    <li><a href="/admin/board/inquiry" id="leftNavi1">회원문의관리</a></li>
    <li><a href="/admin/customer/nonmemberInquiry" id="leftNavi2">비회원문의관리</a></li>
    <li><a href="/admin/customer/notice" id="leftNavi3">공지사항관리</a></li>
    <li><a href="/admin/event/event" id="leftNavi4">이벤트관리</a></li>
    <li><a href="/admin/customer/faq" id="leftNavi6">FAQ관리</a></li>
    <li class="last"><a href="/admin/customer/guide" id="leftNavi7">이용안내관리</a></li>
  </ul>			
</div>
