<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title></title>
<style>
#Interview_div div{
  display:inline-block;
  height:12em;
  width:27em;
  margin:0.3em;
  padding:0.8em;
  border-radius:0.2em;
  background-color:#ffffff;
  box-shadow:7px 7px 14px 7px rgba(0,0,0,0.1);
}
#Interview_div button{
  text-align:center;
  padding:0.5em 8%;  
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
<br><h2>Interviews Scheduled</h2><br><br>
<%	
			String MailId=(String)session.getAttribute("Email_of_user");
			String intdate="";
			String intlink="";
			boolean intstatus=true;
			int i=0;
			try{
				Class.forName("org.postgresql.Driver");
				Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
				Statement st=cn.createStatement();
				ResultSet rs=st.executeQuery("select * from users where mailid='"+MailId+"'");
				while(rs.next()){
					intstatus=rs.getBoolean(6);
					intdate=rs.getString(7);
					intlink=rs.getString(8); 
				}
				if(intstatus){
					String datearr[]=intdate.split(",");
					String linkarr[]=intlink.split(",");
					String JobTitle="",JobDesc="",JobPostDate="";
					for(i=0;i<datearr.length;i++){
						linkarr[i]="https://"+linkarr[i];
						rs=st.executeQuery("select * from jobpostings where empapplied like '%"+MailId+"%' order by jobid asc limit '"+i+1+"'");
						while(rs.next()){
							JobTitle=rs.getString("jobtitle"); 
							JobDesc=rs.getString("jobdescription");  
							JobPostDate=rs.getString("postdate"); 
						}
						%>
						<div>
						<h3>Position : <%=JobTitle %></h3>
						<p>Interview Date : <%=datearr[i] %></p><br>
						<button style="float:left;" onclick="Get_Interview_Details('<%=MailId%>','<%=JobTitle%>','<%=JobDesc%>','<%=JobPostDate%>','<%=datearr[i]%>','<%=linkarr[i]%>')">Interview Details</button>
						<button style="float:right;" onclick="window.open('<%=linkarr[i] %>')">Join Interview</button>
						</div>
						<%
						}
				}
				else
					out.print("<h4>No Interviews Scheduled</h4>");
				}
			catch(Exception ee){
				out.print(ee);
			}
%>
</body>
</html>