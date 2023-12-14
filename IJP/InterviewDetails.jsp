<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
#BackButton{
  float:left;
  margin:1em 0em 0em 0.3em;
  border:none;
  outline:none;
  font-size:1.7em;
  cursor:pointer;
  background-color:inherit;
  transform:rotate(180deg);
}
#MeetButton{
  text-align:center;
  padding:0.5em 1.4em;  
  margin:1em;  
  border:none; 
  outline:none; 
  font-size:1em;    
  border-radius:0.2em;
  cursor:pointer;  
  background-color:#ed4904;    
  color:#ffffff;
}
</style>
</head>
<body>
<%
		String JobTitle=request.getParameter("title");
		String JobDesc=request.getParameter("desc");
		String JobPostDate=request.getParameter("postdate");
		String MailId=request.getParameter("mail");
		String intdate=request.getParameter("intdate");
		String Link=request.getParameter("link");
		String fullname="";
		try{
			Class.forName("org.postgresql.Driver");
			Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
			Statement st=cn.createStatement();
			ResultSet rs=st.executeQuery("select fullname from users where mailid='"+MailId+"'");
			while(rs.next()){
				fullname=rs.getString("fullname");
			}
			%>
			<button onclick="OpenDiv('Interview')" id="BackButton">&#10132;</button><br><br><br><br><br>
			<h3>Position : <%=JobTitle %></h3>
			<p>Description : <%=JobDesc %></p>
			<p>Job Post-date : <%=JobPostDate %></p>
			<p>Interviewee : <%=fullname %></p>
			<p>Interviewee Mail Id :<%=MailId %></p>
			<p>Interview Date : <%=intdate %></p>
			<p>Interview Link : <%=Link %></p>
			<button id="MeetButton" onclick="window.open('<%=Link%>')">Join Meet</button>
			<%
		}
		catch(Exception ee){
			out.print("Error  ");
		}
%>
</body>
</html>