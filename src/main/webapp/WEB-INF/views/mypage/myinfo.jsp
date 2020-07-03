<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>

<div class="myInfo">
  <ul>
    <li class="info"><strong>${nameInfo}</strong> 님의 정보를 한눈에 확인하세요.</li>
    <li>보유 쿠폰<br/><span class="num">${couponInfo}</span> <span class="unit">장</span></li>
    <li class="point">내 포인트<br/><span class="num"><fmt:formatNumber type="number" maxFractionDigits="3" value="${pointInfo}" /></span> <span class="unit">P</span></li>
    <li class="last">진행중인 주문<br/><span class="num">${orderInfo}</span> <span class="unit">건</span></li>
  </ul>
</div>
