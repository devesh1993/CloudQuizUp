

<script>
var data = "";
var qid = 1;
function loadXMLDoc()
{
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
  
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    	data=JSON.parse(xmlhttp.responseText);
    	document.getElementById("question").style.visibility="hidden"; 
    	document.getElementById("question").innerHTML = data.question;
    	document.getElementById("option1").innerHTML = data.opt1;
    	document.getElementById("option2").innerHTML = data.opt2;
    	document.getElementById("option3").innerHTML = data.opt3;
    	document.getElementById("option4").innerHTML = data.opt4;
    	
    }
  }
xmlhttp.open("GET","/pollForQuestion",true);
xmlhttp.send();
}
function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) != -1) return c.substring(name.length,c.length);
    }
    return "";
} 
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + "; " + expires;
} 
function onAnswerSelected(option)
{
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    	
	    	document.getElementById("option4").innerHTML = data.opt4;
	    	
	    }
	  }
	xmlhttp.open("GET","/getNextQuestion?qid="+qid+"/userAns=" + option,true);
	xmlhttp.send();
}

</script>
<p id="wait">wait!!!</p>
<p id="question"></p>
<button id = "option1" onclick="onAnswerSelected(1)"></button>
<button id = "option2" onclick="onAnswerSelected(2)"></button>
<button id = "option3" onclick="onAnswerSelected(3)"></button>
<button id = "option4" onclick="onAnswerSelected(4)"></button>
