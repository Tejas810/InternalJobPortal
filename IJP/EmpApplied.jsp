<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
tr,th,td{
  width:5%;
}
th{
  padding-bottom:2em;
}
#DetailsButton{
  float:right;
  margin-right:0.5em;
  cursor:pointer;
  padding:0.45em 1.3em;    
  border:none; 
  outline:none;    
  border-radius:0.2em; 
  background-color:#ed4904;    
  color:#ffffff;
}
</style>
</head>
<body>
<%
	ResultSet rs;
	int i=0,j=0;
	String title="",desc="",applied="",postdate="";
	String jobid=request.getParameter("JobId"); 
	String appliedarr[];
	String fullname="";
	try{
		Class.forName("org.postgresql.Driver");
		Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
		Statement st=cn.createStatement();
		rs=st.executeQuery("select * from jobpostings where jobid='"+jobid+"'");
		while(rs.next()){
			title=rs.getString(2);
			desc=rs.getString(3); 
			postdate=rs.getString(4);
			applied=rs.getString(5);
		}
		appliedarr=applied.split(",");
		out.print("<table>");
		out.print("<tr><th>Title</th><th>Post Date</th><th>Applicants</th></tr>");
		out.print("<tr><td>"+title+"</td><td>"+postdate+"</td><td>");	
		for(j=0;j<appliedarr.length;j++){
			rs=st.executeQuery("select fullname from users where mailid='"+appliedarr[j]+"'");
			while(rs.next()){
				fullname=rs.getString(1);
			}
			%>
			<%=fullname%>
			<button onclick="ShowEmpDetails('<%=appliedarr[j] %>')" id="DetailsButton">View Details</button><br><br>
			<%
		}
		out.print("</td></tr>");
		out.print("</table>");
	}
	catch(Exception ee){
		out.print("Error  ");
	}
%>
</body>
</html>