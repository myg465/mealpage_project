<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
  <title>MEALPAGE</title>
</head>

<body>
  <script>
    alert('정상적으로 로그아웃 되었습니다.\n밀페이지를 이용해주셔서 감사합니다. :)')
    location.replace('/account/login')
  </script>
</body>
</html>