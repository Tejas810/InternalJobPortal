<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="true" import="java.sql.*,java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<body>
<%
	String skill=request.getParameter("myskill");	
	File fp=new File("D:\\Eclipse Workspace\\IJP\\src\\main\\webapp\\Skills.txt");
	Scanner sc=new Scanner(fp);
	if(skill!=null){
		skill=skill.toLowerCase();
		while(sc.hasNext()){
			String str=sc.nextLine();
			if((str.trim()).contains(skill)){
			%>
			<span onclick="document.getElementById('suggestskillid').value=this.innerHTML;"><%=str%></span>
			<%
			}
		}
		sc.close();
	}
	else{
		%>
		<br><br><label>Upload Resume</label><br><br><br>
		<form action="UploadResume" method="POST" enctype="multipart/form-data" id="ResumeForm" target="OutputFrame">
		Your File Name : <span id="ResumeFileName"></span> &nbsp; &nbsp;(PDF File Only) &nbsp; &nbsp;
		<input type="file" name="resume" id="inputresume" oninput="document.getElementById('ResumeFileName').innerHTML=this.value;" accept=".pdf" required><br><br><br><br>
		<label>Update Skills</label><br><br><br><input type="text" placeholder="Write your skills here" id="suggestskillid" style="border:none;outline:none;border-bottom:1px solid #ed4904;" oninput="SuggestSkill(this.value)" autocomplete="off">
	 	<button id="AddButton" onclick="AppendSkills()">+</button>
		<textarea style="right:4%;position:absolute;height:15em;outline:none;border:1px solid #ee7e4f;width:13em;resize:none;" placeholder="Your Skills ..." name="skills" required></textarea>
		<br><p id="SuggestedSkillPara"></p><br>
		<button onclick="document.getElementById('ResumeForm').submit();">Save</button><br><br>
		</form>
		<iframe name="OutputFrame" id="OutputMessage" style="background-color:inherit;border:none;outline:none;height:4em;width:40em;"></iframe><br> 	
		<%
	}
%>
</body>
</html>