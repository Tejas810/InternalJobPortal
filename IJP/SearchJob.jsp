<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<html>
<style>
table{
	text-align:center;
	margin:1em 0em 0em 0em;
}
th{
	padding:2em;
	width:42.5%;
}
td{
	width:42.5%;
}
</style>
</html>
<%  
	String search=request.getParameter("search");
	int i=0;
	
	String username_of_user=(String)session.getAttribute("username_of_user");
	try{
		Class.forName("org.postgresql.Driver");
		Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
		Statement st=cn.createStatement();
		ResultSet rs=st.executeQuery("select * from users where username='"+search+"'");
		out.print("<table>");
		out.print("<tr><th>Mail</th><th>Username</th><th>Password</th></tr>");
			while(rs.next()){
				out.print("<tr><td>"+rs.getString(1)+"</td>"); 
				out.print("<td>"+rs.getString(2)+"</td>");
				out.print("<td>"+rs.getString(3)+"</td></tr>");
			}
			out.print("</table>");
	}
	catch(Exception ee){
		out.print(ee);
	}
%>
