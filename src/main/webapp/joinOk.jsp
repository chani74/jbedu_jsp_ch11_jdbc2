<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 성공</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	String mid = request.getParameter("memberid");
	String mpw = request.getParameter("memberpw");
	String mname = request.getParameter("membername");
	String memail = request.getParameter("memberemail");
	String mage = request.getParameter("memberage");
	
	String strSQL = "INSERT INTO membertbl (memberid, memberpw, membername, memberemail, memberage) "
				+   " VALUES ('"+mid+"','"+mpw+"','"+mname+"','"+memail+"','"+mage+"')" ;
	
	//1. 변수 4개 선언
	String driverName = "com.mysql.jdbc.Driver";	// MySQL JDBC 드라이버 이름
	String url = "jdbc:mysql://localhost:3306/jbedu"; 
	String username = "root";
	String password = "12345";
	
	Connection conn = null ; //DB 와의 커넥션을 초기값 null 로 해서 생성
	Statement stmt = null ;
	
	try {
		//2.드라이버 로딩
		Class.forName(driverName); // mysql 드라이버를 불러오기
		//3. 연동
		conn = DriverManager.getConnection(url,username,password); // DB와 프로젝트간의 커넥션 생성
		stmt = conn.createStatement();
		//4. 사용
		
		int count = stmt.executeUpdate(strSQL);
		if ( count == 1 ) {
			out.println("회원가입 성공");		
		} else {
			out.println("회원가입 실패!!"+strSQL);
		}
		
		
	} catch(ClassNotFoundException e){
		out.println(">>연결실패 : 드라이버 복사 필요!");
	} catch(SQLException e ) {
		out.println(">>연결실패 : SQL 명령문 확인 필요"+strSQL);
		e.printStackTrace();
	} catch(Exception e ) {
		out.println(">>연결실패 : 오류 발생");
		e.printStackTrace();
	} finally {
		//5. 닫기 
		try {
			if(stmt!=null)						
				stmt.close();				
			if(conn!=null)						
				conn.close();				
		} catch (SQLException e) {
			e.printStackTrace();;
		}
	}
		
%>
</body>
</html>