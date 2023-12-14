<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*,java.io.*,java.util.*" session="true"%>
<!DOCTYPE html>
<html>
<head>
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
#InterviewScheduleButton{
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
#resumebutton{
  background-color:inherit;
  color:#ed4904;
  cursor:pointer;
  border:none;
  outline:none;
}
</style>
</head>
<body>
<button onclick="OpenDiv('Applications')" id="BackButton">&#10132;</button><br><br><br><br>
<%
	String mail=request.getParameter("Mail");
	int flag1=0,flag2=0,flag3=0;
	ResultSet rs;
	String doi="",dateofinterview="",Link="",InterviewLink="";
	boolean status=false;
	String Request_mail=request.getParameter("RequestMail");
	try
	{
		Class.forName("org.postgresql.Driver");
		Connection cn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/ijp","postgres","Tej@s");
		cn.setAutoCommit(false);
		Statement st=cn.createStatement();
		if(Request_mail==null)
		{
			rs=st.executeQuery("select * from users where mailid='"+mail+"'");
			while(rs.next()){
				out.print("<br><br><b>Fullname : </b>"+rs.getString(4));
				out.print("<br><br><b>Mail Id : </b>"+rs.getString(1));
				out.print("<br><br><b>Skills : </b>"+rs.getString(5));
				status=rs.getBoolean(6);
			}
			rs=st.executeQuery("select resume from users where mailid='"+mail+"'");
			if(!rs.next()){
				out.print("No Resume Uploaded");
			}
			else
			{
				while(rs.next()){
					Blob blob=rs.getBlob("resume");
					 InputStream inputStream = blob.getBinaryStream();
	             	OutputStream outputStream = new FileOutputStream("D:\\Eclipse Workspace\\IJP\\src\\main\\webapp\\ResumeFile.pdf");
	
		             int bytesRead = -1;
	             	byte[] buffer = new byte[80000];
	             	while ((bytesRead = inputStream.read(buffer)) != -1) {
	                 	outputStream.write(buffer, 0, bytesRead);
	             	}
	             	inputStream.close();
	             	outputStream.close();
				}
					cn.commit();
			}
			%><br><br><b>Resume : </b><button onclick="window.open('http://localhost:8080/IJP/ResumeFile.pdf')" id='resumebutton' class='fa fa-file-pdf-o'> View</button><%
			out.print("<br><br><textarea name='intlink' placeholder='Paste Meeting Code Here'></textarea>");
			out.print("<br><br><b>Interview Date :</b> <input type='date' name='intdate'>");
			%>
				<br><br><br><button onclick="ScheduleInterview('<%=mail %>')" id="InterviewScheduleButton">Schedule Interview</button>
			<%
		}
		else
		{
			String IntLink=request.getParameter("intlink"); 
			String intdate=request.getParameter("intdate");
			String sql1="update users set intschedule='true' where mailid='"+Request_mail+"'";
			flag1=st.executeUpdate(sql1);
			rs=st.executeQuery("select doi,intlinks from users where mailid='"+Request_mail+"'");
			while(rs.next()){
				InterviewLink=rs.getString("intlinks");
				doi=rs.getString("doi");
			}
			if(InterviewLink==null){
				Link=IntLink;
			}
			else
				Link=InterviewLink+","+IntLink;
			
			if(doi==null){
				dateofinterview=intdate;
			}
			else
				dateofinterview=doi+","+intdate;		
			
			String sql2="update users set intlinks ='"+Link+"',doi='"+dateofinterview+"' where mailid='"+Request_mail+"'";
			flag2=st.executeUpdate(sql2);
			
			if(flag1>0 && flag2>0){
				cn.commit();
				out.print("Interview Scheduled");
			}
			else
				out.print("Unable to schedule interview ");
		}
	}
	catch(Exception ee){
		out.print("Error : "+ee);
	}
%>
</body>
</html>