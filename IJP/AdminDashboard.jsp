<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	if(session.getAttribute("Username_of_admin")==null){
		response.sendRedirect("AdminLogin.html");
	}  
%>
<!DOCTYPE html>
<html><head>
<meta charset="ISO-8859-1"><link rel="icon" href="Logo.png" type="image/x-icon">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="ISO-8859-1"><title> Workzoid | Admin Dashboard</title>
<style> 
::-webkit-scrollbar			{	width:7px;					}
::-webkit-scrollbar-track	{	background-color:#f2f2f2;	}
::-webkit-scrollbar-thumb	{	background-color:#ee7e4f;border-radius:50px;	}
html{
	font-family:"Nunito",sans-serif;
}
.sidenav {
  float:left;  
  height: 37em;
  width: 15em;
  margin:-0.7em 0em 0em -0.5em; 
  padding-top:4em;
  position: fixed;
  z-index: 1; 
  background-color:#ee7e4f;
}
.sidenav marquee{	color:#ffffff;font-size:1.2em;   } 
.sidenav button{
  display: block;
  width:100%;
  height:2.4em;
  margin-top:1.3em; 
  border:none;
  outline:none;
  cursor:pointer;
  font-size: 1.3em;
  padding-left:1em;
  text-align:left;
  color:#ffffff;
  background-color:inherit;
}
.dropbtn {
  margin:0.7em 0.3em 0em 0em;  
  height:1.4em;
  width:1.4em;
  font-size:1.6em;
  border: none;
  cursor: pointer;
  color:#1c1c1c;
  background-color:inherit;
}
.dropdown {
  position: relative;
  display: inline-block; 
}
.dropdown-content {
  display: none;
  position: absolute;
  right: 0;
  min-width: 160px;
  box-shadow:9px 9px 18px 9px rgba(0,0,0,0.1);
  z-index: 1;
  background-color:#ffffff;
}
.dropdown-content button {
  display: block;
  width:100%;
  height:2.6em; 
  border:none;
  outline:none;
  cursor:pointer;
  font-size:18px;
  background-color:inherit;
}
.dropdown:hover .dropdown-content {
  display: block;
}
#Suggestion_div,#Profile_div,#Dashboard_div,#Applications_div,#History_div{
  margin:4em 0em 0em 16em; 
  height:33em;
  width:67em;
  padding-bottom:3em;
  text-align:center;
  box-shadow:9px 9px 18px 9px rgba(0,0,0,0.1);
}
#Dashboard_div #NewOpenButton,#Dashboard_div #JobPostButton{
  position:absolute;
  top:27%;
  right:7%;
  text-align:center;
  padding:0.6em 1.9em;    
  border:none; 
  outline:none; 
  font-size:1em;    
  border-radius:0.2em;
  cursor:pointer;  
  background-color:#ed4904;    
  color:#ffffff; 
}
#Dashboard_div #JobPostButton{
  position:absolute;
  top:89%;
  bottom:5%;
}
#Dashboard_div label{
  float:left;
  margin-left:5em;
  font-size:1.3em; 
  color:#ee7e4f;
} 
#Dashboard_div select,#Dashboard_div textarea{
  width:25%;
  margin-left:3em;
  font-size:1.2em;
}
#Dashboard_div textarea{
  height:15em;
  width:20em;
  resize:none;
}
</style>  
</head>
<body>
<div class="sidenav">
   <marquee style="font-size:1.1em;">Last Login : </marquee><br><br>
   <button onclick="OpenDiv('Dashboard')" id="Dashboard" style="border-right:10px solid #1c1c1c;color:#1c1c1c;background-color:#ffffff;"><i class="fa fa-home" style="margin-right:1.5em;"></i>Home</button>
   <button onclick="OpenDiv('Applications')" id="Applications"><i class='fa fa-bitcoin' style="margin-right:1.5em;"></i>Applications</button>
   <button onclick="OpenDiv('History')" id="History"><i class='fa fa-bitcoin' style="margin-right:1.5em;"></i>History</button><br><br>
   <button style="padding-left:2em;">Need Help ?</button>
   <strong style="float:left;margin:5em 0em 0em 3em;font-size:1em;font-weight:1;color:#fff;">&#169; &nbsp;Workzoid 2022</strong>
</div>

<div class="dropdown" style="float:right;">
   <button class="dropbtn"><i class="fa fa-gear" style="font-weight:0;"></i></button>
   <div class="dropdown-content">
  		<button onclick="OpenDiv('Profile')" id="Profile"><i class="fa fa-user" style="margin-right:1.5em;"></i>Profile</button>
  		<button onclick="Logout()"><i class="fa fa-sign-out" style="margin-right:1.5em;"></i>Logout</button>
   </div>
</div>
 
<input type="text" onclick="OpenDiv('Suggestion')" style="margin-left:40em;" oninput="ShowResult(this.value)" onblur="document.getElementById('reply').style.display='none';">
 
<div id="Dashboard_div" style="display:block;">
	<br><h2>Internal Job Postings</h2><br>
	<button onclick="ShowJobPostForm()" id="NewOpenButton">New Opening</button>
	<div id="JobPostFormDiv" style="display:none;">
		<label>Job Title</label>
		<select name="JobTitle">
			<option value="Senior Manager">Senior Manager</option>
			<option value="Junior Manager">Junior Manager</option>
			<option value="Trainee Engineer">Trainee Engineer</option>
			<option value="Software Developer">Software Developer</option>
			<option value="Design Analyst">Design Analyst</option>
			<option value="Dept.Head">Dept.Head</option>
		</select><br><br><br>
		<label>Job Description</label>
			<textarea name="JobDescription"></textarea>
			
		<button onclick="PostJob()" id="JobPostButton">Post a Job</button>
	</div>
</div>
 
<div id="Applications_div" style="display:none;"></div>
<div id="History_div" style="display:none;"></div>
<div id="Suggestion_div" style="display:none;"></div>
<div id="Profile_div" style="display:none;"></div>

<script> 
var arr=["Suggestion","Profile","Dashboard","Applications","History"];
function OpenDiv(ele){ 
	 for (i = 0; i < arr.length; i++){
		if (arr[i] == ele)
		{
			switch(arr[i])
			{
				case 'Suggestion': document.getElementById(arr[i] + "_div").style.display = "block";
									break;
				case 'Profile'	 : document.getElementById(arr[i]).style = "border-right:10px solid #1c1c1c;color:#1c1c1c;background-color:#ffffff;";
									document.getElementById(arr[i]+"_div").style.display = "block";
									ShowProfile();
									break;
				case 'Dashboard' : document.getElementById(arr[i]).style = "border-right:10px solid #1c1c1c;color:#1c1c1c;background-color:#ffffff;";
									document.getElementById(arr[i]+"_div").style.display = "block";
							//		ShowDashboard();
									break;									
				case 'Applications' : 	document.getElementById(arr[i]).style = "border-right:10px solid #1c1c1c;color:#1c1c1c;background-color:#ffffff;";
									document.getElementById(arr[i]+"_div").style.display = "block";
									ShowApplications();
									break;
									
				case 'History'   : 	document.getElementById(arr[i]).style = "border-right:10px solid #1c1c1c;color:#1c1c1c;background-color:#ffffff;";
									document.getElementById(arr[i]+"_div").style.display = "block";
									//Showskills();
									break;
			}
		} 
		else{
			switch(arr[i])
			{
				case 'Suggestion': document.getElementById(arr[i] + "_div").style.display = "none";
									break;
				case 'Profile'	 : document.getElementById(arr[i]).style = "border:none";
									document.getElementById(arr[i]+"_div").style.display = "none";
									break;
				case 'Dashboard' : document.getElementById(arr[i]).style = "border:none";
									document.getElementById(arr[i]+"_div").style.display = "none";
									break;								
				case 'Applications' : document.getElementById(arr[i]).style = "border:none";
									document.getElementById(arr[i]+"_div").style.display = "none";
									break;
				case 'History'   : document.getElementById(arr[i]).style = "border:none";
									document.getElementById(arr[i]+"_div").style.display = "none";
									break;
			}
		} 
	}
}
function ShowResult(searchval){ 
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function()
	{
		var div=document.getElementById('Suggestion_div');
		div.style.display='block';	
		div.innerHTML=this.responseText;
	}
	xmlhttp.open("GET","SearchJob.jsp?search="+searchval);
	xmlhttp.send();  
}
function ShowProfile(){
	var xmlhttp=new XMLHttpRequest(); 
	xmlhttp.onload=function(){
		document.getElementById("Profile_div").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","Profile.jsp");
	xmlhttp.send();
}
function UpdateProfile(){
	var xmlhttp=new XMLHttpRequest(); 
	xmlhttp.onload=function(){
		document.getElementById("ProfileUpdateMessage").innerHTML=this.responseText;
	}
	var mail=document.getElementsByName("mailid")[0].value;
	var username=document.getElementsByName("username")[0].value;
	var password=document.getElementsByName("password")[0].value;
	xmlhttp.open("GET","Profile.jsp?mailid="+mail+"&username="+username+"&password="+password);
	xmlhttp.send();
}
function ShowJobPostForm(){
	document.getElementById("JobPostFormDiv").style.display="block";
	document.getElementById("NewOpenButton").style.display="none";
}
function PostJob(){
	var title=document.getElementsByName("JobTitle")[0].value;
	var desc=document.getElementsByName("JobDescription")[0].value;
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		document.getElementById("JobPostFormDiv").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","PostJob.jsp?title="+title+"&desc="+desc);
	xmlhttp.send();
}
function ShowApplications(){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		document.getElementById("Applications_div").innerHTML=this.responseText;	
	}
	xmlhttp.open("GET","Applications.jsp"); 
	xmlhttp.send();
}
function ShowApplicants(val){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		document.getElementById("ApplicantDiv").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","EmpApplied.jsp?JobId="+val);
	xmlhttp.send();
}
function ShowEmpDetails(mail){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		document.getElementById("ApplicantDiv").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","EmpDetails.jsp?Mail="+mail);
	xmlhttp.send();
}
function ScheduleInterview(mail){
	var date=document.getElementsByName("intdate")[0].value;
	var link=document.getElementsByName("intlink")[0].value;
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		document.getElementById("ApplicantDiv").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","EmpDetails.jsp?RequestMail="+mail+"&intlink="+link+"&intdate="+date);
	xmlhttp.send();
}
function Logout(){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		location.replace('AdminLogin.html');
	}
	xmlhttp.open("GET","LogOut.jsp?person=admin");
	xmlhttp.send();
}
</script>
</body>
</html>