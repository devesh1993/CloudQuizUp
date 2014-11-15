<html lang="en">
<%@page import="com.bookstore.Register" errorPage="Error.jsp"%>


	
<div class="row">
  <div class="col-md-7 col-md-offset-3">
	<form role="form" action="AdminPage.jsp" method="post">
		<div class="form-group">
	    	<div class="input-group">
				  <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
				  <input type="text" class="form-control" name="fname" placeholder="First Name" required="required">
			</div>
	  	</div>
	  
	  <div class="form-group">
	  	<div class="input-group">
	  	<span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
	    <input type="text" class="form-control" name="lname" placeholder="Last Name" required="required">
	  	</div>
	  </div>
	  
	  <div class="input-group">
		<span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span></span>
			 <input type="email" class="form-control" name ="email" placeholder="Your Email" required="required">
	  </div>
	  <div class="form-group">   
	  </div>
	  <div class="input-group">
		<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
		<input type="password" class="form-control" name="pwd" placeholder="Password" required="required">
	  </div>
	  <br/>
	  <div class="input-group">
		<span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
	    <input type="password" class="form-control" name ="rpwd" placeholder="Re-enter Password" required="required">
	  </div>
	  <br/>
	   <button type="submit" class="btn btn-primary btn">Submit</button>
	</form>
	</div>
</div>
 
</body>
</html>