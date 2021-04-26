<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>Forgot Passsword</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
	<link rel="stylesheet" href="css/styles.css">
	<style type="text/css">
            ::-webkit-scrollbar {
		    width: 0px;  /* Remove scrollbar space */
		    background: transparent;  /* Optional: just make scrollbar invisible */
		}
		input:hover{
			border-color: #00ccff;
		}
	</style>
</head>
<body style="font-family: 'Robosto'">
	<nav class="navbar navbar-light bg-dark navbar-expand">
        <div class="container-fluid" style=" margin-left: 10%;">
        <a class="navbar-brand">
            <font color="white" style="font-size: 30px; font-family: 'Robosto'"><i class="fa fa-car" style="color:#FF6363"></i>&nbsp;&nbsp;&nbsp;CarDealership</font>
        </a>
        </div>
    </nav>
	<div style="width: 100%;">
		<div class="row">
			<div><img style="margin-left: 15%; margin-top: 10%;" src="images/forgot.png" width="900px"></div>
			<div style="padding-top: 13%; height: 70%; padding-left: 20%;">
                            <form method="POST" name="registration" action="forgotpassword">
                                <div>
                                    <fieldset>
                                            <legend>
                                                    <h1><font style="font-size: 50px;">Reset Password</font></h1>
                                            </legend>
                                            <p>
                                                    <br>
                                            </p>
                                            <div class="form-group">
                                                    <label style="font-size: 30px;">Enter Email Id</label><br>
                                                    <input type="text" class="form-control" name="username" id="username"/>
                                                    <i><span id="msg1" style="font-size: 15px; color: red;"></span></i>
                                            </div>
                                            <br>
                                            <div class="form-actions">
                                                    <button type="submit" name="submit" style="padding-top: 0px; width: 50%">
                                                            Send OTP
                                                    </button>
                                            </div><br><br>
                                    </fieldset>
                                </div>
                            </form>
			</div>
		</div>
	</div>
</body>
</html>

