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
<h2>회원목록</h2>
<hr>
<%
	request.setCharacterEncoding("UTF-8");
	
	String strSQL = "SELECT * FROM membertbl ";
	
	//1. 변수 4개 선언
	String driverName = "com.mysql.jdbc.Driver";	// MySQL JDBC 드라이버 이름
	String url = "jdbc:mysql://localhost:3306/jbedu"; 
	String username = "root";
	String password = "12345";
	
	Connection conn = null ; //DB 와의 커넥션을 초기값 null 로 해서 생성
	//Statement stmt = null ;
	PreparedStatement pstmt = null;	
	ResultSet rs = null;
				
	try {
		//2.드라이버 로딩
		Class.forName(driverName); // mysql 드라이버를 불러오기
		//3. 연동
		conn = DriverManager.getConnection(url,username,password); // DB와 프로젝트간의 커넥션 생성
		pstmt = conn.prepareStatement(strSQL);
		rs = pstmt.executeQuery();
		
		List<MemberDto> memberDtos = new ArrayList<MemberDto>();

		if (!rs.next()) {
			out.println("데이터가 없습니다.");
		} else {
			do {
				MemberDto memberDto = new MemberDto();
				memberDto.setMemberid(rs.getString("memberid"));
				memberDto.setMemberpw(rs.getString("memberpw"));
				memberDto.setMembername(rs.getString("membername"));
				memberDto.setMemberemail(rs.getString("memberemail"));
				memberDto.setMemberage(rs.getInt("memberage"));
				
				memberDtos.add(memberDto);
			} while (rs.next());
			
			for (MemberDto memDto : memberDtos ){
				out.println( memDto.getMemberid() + "/");
				out.println( memDto.getMembername() + "/");
				out.println( memDto.getMemberemail() + "/");
				out.println( memDto.getMemberage() + "<br>");
			}
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
</body>
</html>