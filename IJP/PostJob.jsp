<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true" import="java.sql.*,java.time.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		String JobTitle=request.getParameter("title");
		String JobDescription=request.getParameter("desc");
		int JobId=0;
	try{	
		Class.forName("org.postgresql.Driver");
		Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
		Statement st=cn.createStatement();
		ResultSet rs=st.executeQuery("select jobid from jobpostings order by jobid desc limit 1");
		while(rs.next()){
			JobId=rs.getInt(1);
		}
		JobId++;
		String sql="insert into jobpostings values('"+JobId+"','"+JobTitle+"','"+JobDescription+"','"+java.time.LocalDate.now()+"')";
		int flag=st.executeUpdate(sql);
		if(flag>=1){
			out.println("Job Posted Successfully...!");
		}
		else
			out.println("Unable to Post a Job...!");
	}
	catch(Exception ee){
		out.print("Error : "+ee);
	}
%>
</body>
</html>