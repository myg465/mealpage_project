<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("utf-8"); %>
<div id="header">
  <div id="snbBox">
    <h1 id="title">
      <a href="/">
        <span class="meal">MEAL</span><span class="page">PAGE</span>
      </a>
    </h1>
    <div id="quickmenu">
      <div id="mnaviOpen"><img src="/img/temp/btn/btn_mnavi.gif" width="33" height="31" alt="메뉴열기" /></div>
      <div id="mnaviClose"><img src="/img/temp/btn/btn_mnavi_close.gif" width="44" height="43" alt="메뉴닫기" /></div>
      <ul>
        <li><a href="/event/event">이벤트</a></li>
        <li><a href="/customer/notice">고객센터</a></li>
        <li><a href="/customer/guide">이용안내</a></li>
        <c:if test="${sessionScope.authority == 'admin'}">
          <li><a href="/admin">관리자 페이지</a></li>
        </c:if>
      </ul>
    </div>
    <div id="snb">
      <ul>
        <c:choose>
          <c:when test="${sessionScope.accountKey > 0}">
            <li><a href="/account/logout">로그아웃</a></li>
            <li><a href="/order">마이페이지</a></li>
          </c:when>
          <c:when test="${sessionScope.nonmemberName != null }">
          	<li></li>
          	<li><a href="/nonmember/logout">로그아웃</a></li>
          </c:when>
          <c:otherwise>
            <li><a href="/account/login">로그인</a></li>
            <li><a href="/account/signup">회원가입</a></li>
          </c:otherwise>
        </c:choose>
        <li><a href="/cart">장바구니</a></li>
      </ul>

      <div id="search">
      	<form action="/product/search" method="get" name="productSearchForm">
	        <input type="text" name="productSearch" class="searchType" />
	        <input type="image" src="/img/temp/btn/btn_main_search.gif" 
	        width="23" height="20" alt="검색하기" />
        </form>
      </div>
    </div>
  </div>
</div>
