<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>MEALPAGE</title>
</head>

<body>
  <script>
    const orderCount = '<c:out value="${orderCount}" />'
    alert(`해당 회원은 진행 중인 주문이 ${orderCount}건 있어 삭제(강제탈퇴)할 수 없습니다.`)
    location.replace('/admin/account/list')
  </script>
</body>
</html>