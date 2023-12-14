<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,java.time.*" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
#JobDiv{
  display:inline-block;
  height:9em;
  width:15em;
  margin:2em;
  padding:0.8em;
  border-radius:0.2em;
  background-color:#ffffff;
  box-shadow:4px 4px 10px 4px rgba(0,0,0,0.1);
}
#JobDiv button{
  text-align:center;
  padding:0.5em 1.4em;    
  border:none; 
  outline:none; 
  font-size:1em;    
  border-radius:0.2em;
  cursor:pointer;  
  background-color:#ed4904;    
  color:#ffffff;
}
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
</style>
</head>
<body>
<%
		String Mailid=(String)session.getAttribute("Email_of_user");
		String status=request.getParameter("status");
		if(status==null)
		{
			try{	
				Class.forName("org.postgresql.Driver");
				Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
				Statement st=cn.createStatement();
				ResultSet rs=st.executeQuery("select * from jobpostings where postdate>='"+java.time.LocalDate.now()+"'");
				while(rs.next()){
				%>
						<div id="JobDiv">
						<p>Title : <%=rs.getString(2) %></p>
						<p>Description : <%=rs.getString(3) %></p>
						<button onclick="ApplyToJob('<%= rs.getString(1)%>')">Apply</button>
						</div>
				<%
				}
			}
			catch(Exception ee){
				out.println("Error ");
			}
		}
		else{
			int flag=0;
			String JId=request.getParameter("id");
			String applied="";
			try{	
				Class.forName("org.postgresql.Driver");
				Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
				Statement st=cn.createStatement();
				ResultSet rs=st.executeQuery("select empapplied from jobpostings where jobid='"+JId+"'");
				while(rs.next()){
					applied=rs.getString("empapplied");
				}
				if(applied==null)
				{
					applied=Mailid;
					String sql="update jobpostings set empapplied='"+applied+"' where jobid='"+JId+"'";
					flag=st.executeUpdate(sql);
					if(flag>=1){
						
						%>
						<button onclick="ShowJobOpenings()" id="BackButton">&#10132;</button><br><br><br><br><%
						out.print("<h2>Applied Successfully ...!</h2>");
					}
					else{%>
						<button onclick="ShowJobOpenings()" id="BackButton">&#10132;</button><br><br><br><br><%
						out.print("<h2>Unable to apply ...!</h2>");
					}
				}
				else
				{	 
						if(applied.contains(Mailid)){
							%><button onclick="ShowJobOpenings()" id="BackButton">&#10132;</button><br><br><br><br><%
							out.println("<h2>You have already applied for this job ...!</h2>");
						}
						else{
							applied=applied+","+Mailid;
								String sql="update jobpostings set empapplied='"+applied+"' where jobid='"+JId+"'";
								flag=st.executeUpdate(sql);
								if(flag>=1){%>
								<button onclick="ShowJobOpenings()" id="BackButton">&#10132;</button><br><br><br><br><%
								out.print("<h2>Applied Successfully  ...!</h2>");
								}
								else{%>
									<button onclick="ShowJobOpenings()" id="BackButton">&#10132;</button><br><br><br><br><%
									out.print("<h2>Unable to apply ...!</h2>");
								}
						}
				 }
			}
			catch(Exception ee){
				out.print("Error : "+ee);
			}
		}
%>
</body>
</html>