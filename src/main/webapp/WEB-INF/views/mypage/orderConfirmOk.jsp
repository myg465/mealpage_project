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
    alert('구매확정이 완료되었습니다.\n밀페이지를 이용해주셔서 감사합니다. :)')
    location.replace('/order')
  </script>
</body>
</html>