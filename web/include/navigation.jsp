<nav class="navbar navbar-light bg-dark navbar-expand">
  <div class="container-fluid" style=" margin-left: 6%;">
    <a class="navbar-brand" href="dashboard.jsp">	    	
      <font color="white" style="font-size: 30px; font-family: 'Robosto'"><i class="fa fa-car" style="color:#FF6363"></i>&nbsp;&nbsp;&nbsp;CarDealership</font>
    </a>
  </div>
  <div class="dropdown">
  	<a class="dropbtn" style="font-size: 30px; padding-right: 100px;">
  		<i class="fa fa-user" aria-hidden="true">	  	
                    <%=session.getAttribute("username")%>                    
                </i>
  	</a>
  	<div class="dropdown-content" style="z-index: 2;">
  		<a href="myaccount.jsp" class="btn" style="color:black;">My Profile</a>
  		<a href="logout" class="btn" style="color: black;">Logout</a>
  	</div>
  </div>
</nav>