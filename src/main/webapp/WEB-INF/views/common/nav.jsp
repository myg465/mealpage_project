<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="dev.localhost.koitt14.product.ProductService"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("utf-8"); %>

<!-- GNB -->

<div id="gnb">
	<c:if test="${empty nav1 }">
	
	<% 
	   ServletContext servletContext = this.getServletContext();
	   WebApplicationContext wac = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
       ProductService productService = (ProductService)wac.getBean("productService");
       productService.setNav(session);
    %>
    
	</c:if>
	<div id="top" style="max-width: 100%;">
		<ul style="max-width:100%; display: table; margin-left: auto; margin-right: auto;">
			<li class="brand t1"><a href="/intro" id="topNavi1">밀페이지 소개</a></li>
			
			<%
			   String[]nav1 = (String[])session.getAttribute("nav1"); /* 세션에서 nav1(대분류를 얻어옴) */
			   ArrayList[]nav2 = (ArrayList[])session.getAttribute("nav2"); /* 세션에서 nav2(중분류를 얻어옴) */ 
			   for(int i=0;i<nav1.length;i++) { %> <%-- nav1 (대분류)의 갯수만큼 for문이 돌아감 --%> 
			   
			<li class="t2"><a href="/product/<%= nav1[i] %>/All" id="topNavi2"><%= nav1[i] %></a> <%-- 대분류를 표시 --%>
				<ul id="topSubm2">
				
			<% for(int j=0;j<nav2[i].size();j++) { %> <%-- nav2 (중분류배열의 i번째 arraylist 사이즈 만큼 for문이 돌아감--%>
					<%-- 주소에 들어가는 검색조건과 중분류의 이름을 뿌려줌 --%>
					
					<li><a href="/product/<%=nav1[i] %>/<%=nav2[i].get(j).toString()%>"><%=nav2[i].get(j).toString()%></a></li> 
					
			<% } %> <%--for문 1 끝 --%>
			
				</ul>
			</li>
			
			<%} %> <%-- for문 2 끝 --%>
		</ul>
	</div>

	<script type="text/javascript">initTopMenu();</script>
</div>
<!-- //GNB -->
