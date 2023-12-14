<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" session="true"%>
<!DOCTYPE html>
<html>
<head>
<style>
label{
  color:#ee7e4f;
  font-size:1.3em;
  padding-right:2em;
}
select{
  height:2em;
  width:6em;
  outline:none;
  border-radius:0.2em;
  cursor:pointer;
  color:#ee7e4f;
  background-color:#fff;
}
</style>
</head>
<body>
<%
	ResultSet rs;
	int jobcount=0,i=0,j=0;
	try{
		Class.forName("org.postgresql.Driver");
		Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
		Statement st=cn.createStatement();
		rs=st.executeQuery("select count(jobid) from jobpostings");
		while(rs.next()){
			jobcount=rs.getInt(1);
		}
		%><br><br><label>Select Job Id  </label><select name="JobId" oninput="ShowApplicants(this.value)">
		<option disabled selected>Select</option><%
		for(i=1;i<=jobcount;i++){
			%> 
			<option value="<%=i%>"><%=i %></option>
			<%
		}
		%></select><br><br><br><br>
		<div id="ApplicantDiv"></div><%
	}
	catch(Exception ee){
		out.print("Error : "+ee);
	}
%>
</body>
</html>