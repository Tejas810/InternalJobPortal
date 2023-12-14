<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	if(session.getAttribute("Username_of_user")==null){
		response.sendRedirect("UserLogin.html");
	}  
%>
<!DOCTYPE html>
<html><head>
<meta charset="ISO-8859-1"><link rel="icon" href="Logo.png" type="image/x-icon">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="ISO-8859-1"><title> Workzoid | User Dashboard</title>
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
#Suggestion_div,#Profile_div,#Dashboard_div,#Skills_div,#Interview_div,#History_div{
  margin:4em 0em 0em 16em; 
  height:33em;
  width:67em;
  padding-bottom:3em;
  text-align:center;
  box-shadow:9px 9px 18px 9px rgba(0,0,0,0.1);
}
#Skills_div input[type=file]{
  height:1.6em;
  width:6.6em; 
}
#Skills_div label{
  font-size:1.3em; 
  color:#ee7e4f; 
}
#Skills_div input[type=text]{
  width:25%;
  margin-left:3em;
  font-size:1.2em; 
}
#Skills_div button{
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
#Skills_div #AddButton{ 
  margin-left:1em;
  padding:0.3em 0.6em;    
  border-radius:50%;
  font-size:1.2em;
  font-weight:700;         
}
#SuggestedSkillPara{
  text-align:center;
  width:40%;
  height:7em;
  padding:0.3em;
  margin:auto;
  margin-top:1em;
  margin-bottom:1em;
  outline:none;
  border:none;
  overflow-x:hidden;
  overflow-y:scroll;
}
#SuggestedSkillPara span{
  float:left;
  margin:0.5em 0em 0em 0.5em;
  padding:0.5em;
  border-radius:0.4em;
  background-color:#ee7e4f;
  color:#fff;
  cursor:pointer;
}
</style>  
</head>
<body onload="ShowJobOpenings()">
<div class="sidenav">
   <marquee style="font-size:1.1em;">Last Login : </marquee><br><br>
   <button onclick="OpenDiv('Dashboard')" id="Dashboard" style="border-right:10px solid #1c1c1c;color:#1c1c1c;background-color:#ffffff;"><i class="fa fa-home" style="margin-right:1.5em;"></i>Home</button>
   <button onclick="OpenDiv('Skills')" id="Skills"><i class="fa fa-users" style="margin-right:1.5em;"></i>My Skills</button>
   <button onclick="OpenDiv('Interview')" id="Interview"><i class='fa fa-bitcoin' style="margin-right:1.5em;"></i>My Interviews</button>
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
</div>
 
<div id="Skills_div" style="display:none;">
</div> 

<div id="Interview_div" style="display:none;">
</div>

<div id="History_div" style="display:none;">
</div>

<div id="Suggestion_div" style="display:none;">
</div>

<div id="Profile_div" style="display:none;">
</div>


<script> 
var arr=["Suggestion","Profile","Dashboard","Skills","Interview","History"];
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
				case 'Skills' 	 : 	document.getElementById(arr[i]).style = "border-right:10px solid #1c1c1c;color:#1c1c1c;background-color:#ffffff;";
									document.getElementById(arr[i]+"_div").style.display = "block";
									Showskills();
									break;
				case 'Interview' : 	document.getElementById(arr[i]).style = "border-right:10px solid #1c1c1c;color:#1c1c1c;background-color:#ffffff;";
									document.getElementById(arr[i]+"_div").style.display = "block";
									ShowInterview();
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
				case 'Skills'	 : document.getElementById(arr[i]).style = "border:none";
									document.getElementById(arr[i]+"_div").style.display = "none";
									break;							
				case 'Interview' : document.getElementById(arr[i]).style = "border:none";
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
	xmlhttp.onload=function(){
		var div=document.getElementById('Suggestion_div');
		div.style.display='block';	
		div.innerHTML=this.responseText;
	}
	xmlhttp.open("GET","SearchJob.jsp?search="+searchval);
	xmlhttp.send();  
}
function ShowJobOpenings(){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
			document.getElementById("Dashboard_div").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","Jobs.jsp");
	xmlhttp.send();
}
function ApplyToJob(id){
	var xmlhttp=new XMLHttpRequest(); 
	xmlhttp.onload=function(){
		document.getElementById("Dashboard_div").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","Jobs.jsp?status=true&id="+id);
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
function Showskills(){
	var xmlhttp=new XMLHttpRequest(); 
	xmlhttp.onload=function(){
		document.getElementById("Skills_div").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","Skills.jsp");
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
function AppendSkills(){
	document.getElementById("SuggestedSkillPara").style="display:none;";
	if(document.getElementsByName("skills")[0].value==null || document.getElementsByName("skills")[0].value==""){
		document.getElementsByName("skills")[0].value=document.getElementsByName("skills")[0].value+" "+document.getElementById("suggestskillid").value;	
	}
	else
		document.getElementsByName("skills")[0].value=document.getElementsByName("skills")[0].value+","+document.getElementById("suggestskillid").value;
	event.preventDefault();
}
function SuggestSkill(str){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		document.getElementById("SuggestedSkillPara").style="display:block;";
		document.getElementById("SuggestedSkillPara").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","Skills.jsp?myskill="+str);
	xmlhttp.send();
}
function ShowInterview(){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		document.getElementById("Interview_div").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","Interview.jsp");
	xmlhttp.send();
}
function Get_Interview_Details(mail,title,desc,postdate,intdate,link){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		document.getElementById("Interview_div").innerHTML=this.responseText;
	}
	xmlhttp.open("GET","InterviewDetails.jsp?mail="+mail+"&title="+title+"&desc="+desc+"&postdate="+postdate+"&intdate="+intdate+"&link="+link);
	xmlhttp.send();
}
function Logout(){
	var xmlhttp=new XMLHttpRequest();
	xmlhttp.onload=function(){
		location.replace('UserLogin.html');
	}
	xmlhttp.open("GET","LogOut.jsp?person=user");
	xmlhttp.send();
}
</script>
</body>
</html>