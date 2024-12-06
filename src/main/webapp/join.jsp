<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원가입</h2>
	<hr>
	<form action="joinOk.jsp" method="post">
		ID : <input type='text' name='memberid'><br>
		PW : <input type='password' name='memberpw'><br>
		이름 : <input type='text' name='membername'><br>
		이메일 : <input type='text' name='memberemail'><br>
		나이 : <input type='text' name='memberage'><br>
		<input type="submit" value="회원등록">		
	</form>
</body>
</html>