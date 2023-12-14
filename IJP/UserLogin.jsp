<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String username=request.getParameter("username_of_user");
	String password=request.getParameter("password_of_user");
	String email="";
		try
		{		
			Class.forName("org.postgresql.Driver");
			Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
			Statement st=cn.createStatement();
			ResultSet rs=st.executeQuery("select mailid from users where username='"+username+"'");
			while(rs.next()){
				email=rs.getString("mailid");
			}
			rs=st.executeQuery("select * from users where username='"+username+"' and password='"+password+"'");
			if(rs.next()){
				session.setAttribute("Username_of_user",username);
				session.setAttribute("Email_of_user",email);
				response.sendRedirect("UserDashboard.jsp");	
			}
			else{
				%><script>alert('Invalid Credentials');location.replace("UserLogin.html");</script><%	
			}
		} 
		catch(Exception ee){
			out.print(ee);
		}
%>
</body>
</html>