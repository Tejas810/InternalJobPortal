<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true" import="java.sql.*,java.io.*,java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
/*	
	req_skills="Java DMW Php"; 
	try{
		Class.forName("org.postgresql.Driver");
		Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
		Statement st=cn.createStatement(); 
		String FilePath="C:\\Users\\LENOVO\\Downloads\\Sample.pdf";
		InputStream inputStream = new FileInputStream(FilePath);
		String sql="update users set skills=?,resume=? where mailid='tejas8102001@gmail.com'"; 
		PreparedStatement ps=cn.prepareStatement(sql);
		ps.setString(1,req_skills);
		ps.setBlob(2,inputStream);
		int flag=ps.executeUpdate();
		if(flag>0){
			out.print("Skills Saved & resume uploaded...");
		}
		else
			out.print("Unable to save...");
		
		ResultSet rs=st.executeQuery("select resume from users where username='Tejas'");
		while(rs.next()){
			Blob blob=rs.getBlob("resume");
			 inputStream = blob.getBinaryStream();
             OutputStream outputStream = new FileOutputStream("C:\\Users\\LENOVO\\Downloads\\Sample.pdf");

             int bytesRead = -1;
             byte[] buffer = new byte[80000];
             while ((bytesRead = inputStream.read(buffer)) != -1) {
                 outputStream.write(buffer, 0, bytesRead);
             }

             inputStream.close();
             outputStream.close();
		}
	}
	catch(Exception ee){
		out.print("Error : "+ee);
	} */
%>
</body>
</html>