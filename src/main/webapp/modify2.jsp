<%@page import="java.util.ArrayList"%>
<%@page import="com.jbedu.member.dto.MemberDto"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>회원정보 수정</h2>
	<hr>
<%
	request.setCharacterEncoding("UTF-8");
	String mid = request.getParameter("memberid");
	
	String strSQL = "SELECT * FROM membertbl where memberid=?";
	
	//1. 변수 4개 선언
	String driverName = "com.mysql.jdbc.Driver";	// MySQL JDBC 드라이버 이름
	String url = "jdbc:mysql://localhost:3306/jbedu"; 
	String username = "root";
	String password = "12345";
	
	Connection conn = null ; //DB 와의 커넥션을 초기값 null 로 해서 생성
	//Statement stmt = null ;
	PreparedStatement pstmt = null;	
	ResultSet rs = null;
	
	MemberDto memberDto = new MemberDto();
	
	try {
		//2.드라이버 로딩
		Class.forName(driverName); // mysql 드라이버를 불러오기
		//3. 연동
		conn = DriverManager.getConnection(url,username,password); // DB와 프로젝트간의 커넥션 생성
		pstmt = conn.prepareStatement(strSQL);
		pstmt.setString(1, mid);
		
		rs = pstmt.executeQuery();
		
		
		
		if (!rs.next()) {
			out.println("데이터가 없습니다.");
		} else {
			do {
				memberDto.setMemberid(rs.getString("memberid"));
				memberDto.setMemberpw(rs.getString("memberpw"));
				memberDto.setMembername(rs.getString("membername"));
				memberDto.setMemberemail(rs.getString("memberemail"));
				memberDto.setMemberage(rs.getInt("memberage"));
				
			} while (rs.next());
			

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
			if(rs!=null)						
				rs.close();				
			if(pstmt!=null)						
				pstmt.close();				
			if(conn!=null)						
				conn.close();				
		} catch (SQLException e) {
			e.printStackTrace();;
		}
	}
%>
	<form action="modifyOk.jsp" method="post">
		<input type='hidden' name='memberid' value='<%= memberDto.getMemberid() %>'>
		ID : <input type='text' name='memberid' disabled="disabled" value='<%= memberDto.getMemberid() %>'><br>
		PW : <input type='password' name='memberpw' value='<%= memberDto.getMemberpw() %>' ><br>
		이름 : <input type='text' name='membername' value='<%= memberDto.getMembername() %>' ><br>
		이메일 : <input type='text' name='memberemail' value='<%= memberDto.getMemberemail() %>' ><br>
		나이 : <input type='text' name='memberage' value='<%= memberDto.getMemberage() %>' ><br>
		<input type="submit" value="회원등록">		
	</form>

</body>
</html>