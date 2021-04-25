<!DOCTYPE html>
<html>
<head>
    <title>Filter your choices</title>
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
    </style>
</head>
<body style="font-family: 'Robosto'">
    <%@ include file="include/navigation.jsp" %>
    <div style="width: 100%;">
        <div class="row">
            <div><img style="margin-left: 15%; margin-top: 10%;" src="images/register.svg" width="85%"></div>
            <div style="width: 50%; padding-top: 5%; padding-left: 10%; height: 70%; ">
                <form method="post" action = "filtering">
                    <fieldset>
                        <legend>
                            <h1><font>Selling Form</font></h1>
                        </legend>
                        <p>
                            <br>
                        </p>
                        <div class="form-group" style="width: 500px;">
                            <label>Company Name</label>
                            <input type="text" class="form-control" id="company_name" name="company_name">
                            <i><span id="msg3" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Model_name</label>
                            <input type="text" class="form-control" id="model_name" name="model_name">
                            <i><span id="msg4" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Price with upperlimit</label>
                            <input type="number" min="0" step="0.01" class="form-control" id="price" name="price">
                            <i><span id="msg5" style="font-size: 12px;"></span></i>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label class="radio radio-info radio-inline"><input type="radio"  id="ascending" name="price_sort"  value="ascending" checked>Ascending</label>
                            <label class="radio radio-info radio-inline"><input type="radio"  id="descending" name="price_sort" value="descending">Descending</label>
                        </div>
                        <div class="form-group" style="width: 500px;">
                            <label>Fuel Type</label><br>
                            <label class="checkbox checkbox-info checkbox-inline"><input type="checkbox"  id="petrol" name="fuel_type"  value="Petrol">Petrol</label>
                            <label class="checkbox checkbox-info checkbox-inline"><input type="checkbox"  id="diesel" name="fuel_type" value="Diesel">Diesel</label>
                            <label class="checkbox checkbox-info checkbox-inline"><input type="checkbox"  id="cng" name="fuel_type" value="CNG">CNG</label>
                            
                        </div><br>
                        <div class="form-actions">
                            <button type="submit" name="submit" style="padding-top: 0px;">
                                Filter
                            </button>
                        </div><br><br>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</body>
</html>