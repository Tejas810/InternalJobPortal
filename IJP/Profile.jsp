<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*" session="true"%>
<%
	if(session.getAttribute("Username_of_user")==null){
		response.sendRedirect("UserLogin.html");
	}  
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
<style>
#Profile_div{
	text-align:center;
}
#Profile_div label{
	font-size:1.3em; 
	color:#ee7e4f; 
	float:left;
	margin-left:17em;
}
#Profile_div input[type=text],#Profile_div input[type=password],#Profile_div input[type=email]{
	outline:none;
	border:none;
	border-bottom:0.8px solid #1c1c1c;
	font-size:1.2em;
	width:19em;
	background-color:inherit;
}
#Profile_div input[type=text]:hover,#Profile_div input[type=password]:hover,,#Profile_div input[type=email]:hover{
	border-bottom:1.5px solid #1c1c1c;
}
#Profile_div button{ 
  float:right;
  margin-right:5em;
  padding:0.6em 1.9em;    
  border:none; 
  outline:none; 
  font-size:1em;    
  border-radius:0.2em;
  cursor:pointer;  
  background-color:#ed4904;  /*#ee7e4f;  */    
  color:#ffffff;   
}
#ProfileUpdateMessage{
  text-align:center;
  color:red;
  font-size:1.2em;
}
</style>
</head>
<body>
<%
		String username_of_user=(String)session.getAttribute("Username_of_user");
		String Request_Mail=request.getParameter("mailid");
		String Request_Username=request.getParameter("username");
		String Request_Password=request.getParameter("password");
		
		String Mail="",Username="",Password="";
	try{
		Class.forName("org.postgresql.Driver");
		Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
		Statement st=cn.createStatement();
		
		if(Request_Mail!=null)
		{
			String sql=("update users set username='"+Request_Username+"',password='"+Request_Password+"' where mailid='"+Request_Mail+"'");
			int flag=st.executeUpdate(sql);
			if(flag>=1){
				out.print("Profile Updated Successfully ...!");
			}
			else
				out.print("Cannot Update Profile ...!");
		}
		else
		{
			ResultSet rs=st.executeQuery("select * from users where username='"+username_of_user+"'");
			while(rs.next()){
				Mail=rs.getString(1);
				Username=rs.getString(2);
				Password=rs.getString(3);
			}			
			%>
			<br><h2>My Profile</h2><br><br>
				<label>Mail Id  </label><br><br>
				<input type="email" name="mailid" value="<%=Mail%>" disabled> <br><br><br>
				<label>Username  </label><br><br>
				<input type="text" name="username" value="<%=Username%>"> <br><br><br>
				<label>Password  </label><br><br>
				<input type="password" name="password" value="<%=Password%>"> <br><br><br><br><br>
				<button onclick="UpdateProfile()">Update</button>
				<p id="ProfileUpdateMessage"></p>
				<script>
				
				</script>
			<%
		}
	}
	catch(Exception ee){
		out.print(ee);
	}
%>
</body>
</html>