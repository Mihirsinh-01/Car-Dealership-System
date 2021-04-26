<!DOCTYPE html>
<html>
<head>
    <title>Sell Car</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/dropdown.css">
    <style type="text/css">
        input:hover{
            border-color: #00ccff;
        }
        span{
            color: red;
        }
        label{
            font-weight: bold;
        }
        ::-webkit-scrollbar {
            width: 0px;  /* Remove scrollbar space */
            background: transparent;  /* Optional: just make scrollbar invisible */
        }
    </style>
</head>
<body style="font-family: 'Robosto'">
    <%@ include file="include/navigation.jsp" %>
    <%
        session.setAttribute("query","SELECT * from CAR.CARINFO WHERE STATUS=true");
    %>
    <div style="width: 100%;">
        <div class="row">
            <div><img style="margin-left: 15%; margin-top: 15%;" src="images/register.svg" width="85%"></div>
            <div style="width: 50%; padding-top: 2%; padding-left: 10%; height: 70%; ">
                <form method="post" action = "upload" enctype = "multipart/form-data">
                    <fieldset>
                        <legend>
                            <h1><font>Selling Form</font></h1>
                        </legend>
                        <div class="form-group"style="width: 500px;"><p>
                            <br>
                            </p>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Car Image to Display</label>
                            <input type = "file" class="form-control" id="file1" name = "file1" style="border: none;" accept=".png,.jpeg,.jpg"/>
                            <i><span id="msg1" style="font-size: 12px;visibility: hidden;">Only .png, .jpg, .jpeg is accepted !!!!</span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Other Car Images</label>
                            <input type = "file" class="form-control" id="file2" name = "file2" multiple style="border: none;" accept=".png,.jpeg,.jpg"/>
                            <i><span id="msg2" style="font-size: 12px;visibility: hidden;">Only .png, .jpg, .jpeg is accepted !!!!</span></i>
                        </div>                        
                        <div class="form-group" style="width: 300px; float: right;">
                            <label>Model_name</label>
                            <input type="text" class="form-control" id="model_name" name="model_name">
                            <i><span id="msg4" style="font-size: 12px;visibility: hidden;">Only Alphabets and numbers are allowed !!!</span></i>
                        </div>
                        <div class="form-group" style="width: 300px;">
                            <label>Company Name</label>
                            <input type="text" class="form-control" id="company_name" name="company_name">
                            <i><span id="msg3" style="font-size: 12px;visibility: hidden;">Only Alphabets are allowed !!!</span></i>
                        </div>
                        <div class="form-group" style="width: 300px; float: right;">
                            <label>Price</label>
                            <input type="number" min="0" step="0.01" class="form-control" id="price" name="price" required>
                            <i><span id="msg5" style="font-size: 12px;visibility: hidden;">Invalid Price</span></i>
                        </div>
                        <div class="form-group" style="width: 300px;">
                            <label>Kilometer</label>
                            <input type="number" min="0" step="0.01" class="form-control" id="kilometer" name="kilometer" required>
                            <i><span id="msg6" style="font-size: 12px;visibility: hidden;">Invalid kilometer</span></i>
                        </div>
                        <div class="form-group" style="width: 300px; float: right;">
                            <label>Number Plate</label>
                            <input type=text class="form-control" id="number_plate" name="number_plate" placeholder="GJ05AB1234">
                            <i><span id="msg7" style="font-size: 12px;visibility: hidden;">Invalid number plate</span></i>
                        </div>
                        <div class="form-group" style="width: 300px;">
                            <label>Model Year</label>
                            <input type="number" min="1111" max="9999" step="1" class="form-control" id="model_year" name="model_year" required>
                            <i><span id="msg8" style="font-size: 12px;visibility: hidden;">Invalid year</span></i>
                        </div>
                        <div class="form-group" style="width: 300px; float: right;">
                            <label>Mileage</label>
                            <input type="number" min="0" step="0.01"class="form-control" id="mileage" name="mileage" required>
                            <i><span id="msg9" style="font-size: 12px;visibility: hidden;"></span></i>
                        </div>
                        <div class="form-group" style="width: 300px;">
                            <label>Fuel Type</label><br>
                            <div class="form-check">
                                <input class="form-check-input" type="radio"  id="petrol" name="fuel_type"  value="Petrol" checked>
                                <label class="form-check-label" style="font-weight: normal;">Petrol</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio"  id="diesel" name="fuel_type"  value="Diesel">
                                <label class="form-check-label" style="font-weight: normal;">Diesel</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio"  id="cng" name="fuel_type"  value="CNG">
                                <label class="form-check-label" style="font-weight: normal;">CNG</label>
                            </div>                           
                            
                            <i><span id="msg10" style="font-size: 12px;"></span></i>
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