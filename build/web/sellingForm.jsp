<!DOCTYPE html>
<html>
<head>
    <title>Register Account</title>
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
        input:hover{
            border-color: #00ccff;
        }
        span{
            color: red;
        }
    </style>
</head>
<body style="font-family: 'Robosto'">
    <nav class="navbar navbar-light bg-dark navbar-expand">
      <div class="container-fluid" style=" margin-left: 10%;">
        <a class="navbar-brand" href="index.html">
            <font color="white" style="font-size: 30px; font-family: 'Robosto'"><i class="fa fa-car" style="color:#FF6363;"></i>&nbsp;&nbsp;&nbsp;CarDealership</font>
        </a>
      </div>
    </nav>
    <div style="width: 100%;">
        <div class="row">
            <div><img style="margin-left: 15%; margin-top: 10%;" src="images/register.svg" width="85%"></div>
            <div style="width: 50%; padding-top: 5%; padding-left: 10%; height: 70%; ">
                <form method="post" action = "upload" enctype = "multipart/form-data">
                    <fieldset>
                        <legend>
                            <h1><font>Selling Form</font></h1>
                        </legend>
                        <p>
                            <br>
                        </p>
                        <div class="form-group" style="width: 500px;">
                            <!--<label>Enter Username</label>-->
                            <input type = "file" class="form-control" id="file" name = "file" multiple/>
                            <i><span id="msg1" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Company Name</label>
                            <input type="text" class="form-control" id="company_name" name="company_name">
                            <i><span id="msg2" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Model_name</label>
                            <input type="text" class="form-control" id="model_name" name="model_name">
                            <i><span id="msg3" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Price</label>
                            <input type="number" min="0" step="0.01" class="form-control" id="price" name="price">
                            <i><span id="msg4" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Kilometer</label>
                            <input type="number" min="0" step="0.01" class="form-control" id="kilometer" name="kilometer">
                            <i><span id="msg5" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Number Plate</label>
                            <input type=text class="form-control" id="number_plate" name="number_plate">
                            <i><span id="msg6" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Model Year</label>
                            <input type="number" step="1" class="form-control" id="model_year" name="model_year">
                            <i><span id="msg7" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Mileage</label>
                            <input type="number" min="0" step="0.01"class="form-control" id="mileage" name="mileage">
                            <i><span id="msg8" style="font-size: 12px;"></span></i>
                        </div><br>
                        <div class="form-actions">
                            <button type="submit" name="submit" style="padding-top: 0px;">
                                Sell
                            </button>
                        </div><br><br>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</body>
</html>

<!--      <form action = "upload" method = "post"
         enctype = "multipart/form-data">
          <input type = "file" name = "file" multiple/>
         <br />
         <input type = "submit" value = "Upload File" />
      </form>
      <form action="fetch.jsp">
          <input type = "text" name = "name" /><br/>
          <input type = "submit" value = "Fill the data" />
      </form>
     
   </body>
   
</html>-->