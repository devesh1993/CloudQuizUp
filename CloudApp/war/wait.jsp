<!DOCTYPE html>

<html>

<head>
<style>
#mydiv {
  height: 400px;
  position: relative;
  background-color: white; /* for demonstration */
}
.ajax-loader {
  position: absolute;
  left: 50%;
  margin-left: -150px; /* -1 * image width / 2 */
  width:25%;
  
}
</style>
<br>
<br>
<br>
<h2 align="center">Wait... !!!</h2>
<div id="mydiv">
	<img src="waiting.jpg" alt="Waiting For Other Player" class="ajax-loader">
	 
</div>
<script>
window.location.assign("pollForQuestion?topic="+"<%out.print(request.getParameter("topic"));%>")
</script>
</head>
<body>



</body>
</html>
