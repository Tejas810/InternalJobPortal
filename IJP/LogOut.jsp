<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logout | Visual Interactive</title>
</head>
<body>
<%
	if(request.getParameter("person")=="admin"){
		session.removeAttribute("Username_of_admin");
		session.removeAttribute("Email_of_admin");
	}
	else{
		session.removeAttribute("Username_of_user");
		session.removeAttribute("Email_of_user");	
	}	
%>
</body>
</html>