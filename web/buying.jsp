<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buy this Car</title>
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
        <style>
            .right{
                position: absolute;
                right: 1%;
                top: 25%;
            }
            .left{
                position: absolute;
                left: 1%;
                top: 25%;
            }
            td{
                padding: 40px;
                font-size: 30px;
            }
            .pr{
                float: right;
                font-size: 30px;
                padding-right: 10%;
                padding-top: 5%;
            }
            .bttt{
                background-color: red;
                font-size: 30px;
                border-radius: 20px;
                margin-top: 10%;
                width: 250px;
            }
        </style>
    </head>
    <body style="font-family:'Robosto';">
        <%@ include file="include/navigation.jsp" %>
        <div style="width: available; height: 50%; background: linear-gradient(to bottom, #ffffff 0%, #ff0000 100%); padding: 20px;">            
            <div class="right"><a onclick="change(1)"><img src="https://img.icons8.com/ios/50/000000/forward-arrow.png"/></a></div>
            <div class="left"><a onclick="change(-1)"><img src="https://img.icons8.com/ios/50/000000/reply-arrow.png"/></a></div>
            <sql:setDataSource var="db" driver="org.apache.derby.jdbc.ClientDriver"  
            url="jdbc:derby://localhost:1527/CarDealership"  
            user="car"  password="car"/>
            <sql:query dataSource="${db}" var="rs">  
                SELECT * from CAR.CARINFO WHERE NUMBER_PLATE='<c:out value="${param.number_plate}"/>'
            </sql:query>
            <c:forEach var="table" items="${rs.rows}">
                <c:forTokens items = "${table.CAR_IMAGE}" delims = ";" var = "name">                    
                    <div class="imgs">
                        <center><img src='files/${name}' alt="Car image"height="500px;"></center>
                    </div>
                </c:forTokens>           
            </c:forEach>
        </div>
        <div style="padding-left: 50px;">
            <table style="width: 70%;" border="1">
                <sql:query dataSource="${db}" var="rs">
                    SELECT * from CAR.CARINFO WHERE NUMBER_PLATE='<c:out value="${param.number_plate}"/>'
                </sql:query>
                <c:forEach var="table" items="${rs.rows}">
                    <b style="font-size: 40px;">
                        <c:out value="${table.NUMBER_PLATE}"/> &nbsp;&nbsp;
                        <c:out value="${table.COMPANY_NAME}"/>
                        &nbsp;<c:out value="${table.MODEL_NAME}"/>
                    </b><span style="font-size: 25px;">(<c:out value="${table.FUEL_TYPE}"/>)</span>
                    <tr>
                        <td>
                            <b>Car Seller </b><c:out value="${table.USERNAME}"/>
                        </td>
                        <td>
                            <b>Model Year </b><c:out value="${table.MODEL_YEAR}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Mileage </b><c:out value="${table.MILEAGE}"/> Km/L
                        </td>
                        <td>
                            <b>Total Kilometers </b><c:out value="${table.KILOMETER}"/> Km.
                        </td>
                    </tr>
                    <div class="pr">
                        <b>Price: </b>₹ <c:out value="${table.PRICE}"/> <br>
                        <a class="btn bttt"style="color: white;" href="confirmbuy.jsp?number_plate=<c:out value='${table.NUMBER_PLATE}'/>">Confirm Buy</a>
                    </div>
                </c:forEach>
            </table>
                
        </div>
        
        <script>
            var slide=0;
            viewChanges(slide);
            function change(n){
                slide+=n;            
                viewChanges(slide);
            }
            function viewChanges(n){
                var i;
                var x=document.getElementsByClassName("imgs");
                if(n<0) {n=0;slide=0;}
                if(n>=x.length) {n=x.length-1;slide=n;}
                for(i=0;i<x.length;i++){
                    x[i].style.display="none";
                }
                x[n].style.display="inline";
            }
        </script>
    </body>
</html>
