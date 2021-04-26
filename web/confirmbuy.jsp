<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Buy</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.9.2/html2pdf.bundle.js"></script>
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/dropdown.css">
        <style>
            #print{
                position: absolute;
                top: 80%;
                left: 48%;
            }
            #download{
                position: absolute;
                bottom:20%;
                left: 48%;
            }
        </style>
    </head>
    <body style="font-family:'Robosto';">
        <%@ include file="include/navigation.jsp" %>
        <div style="width: available; height: 100vh; background: linear-gradient(to bottom, #ffffff 0%, #ff0000 100%); padding: 20px;">
            <sql:setDataSource var="db" driver="org.apache.derby.jdbc.ClientDriver"  
            url="jdbc:derby://localhost:1527/CarDealership"  
            user="car"  password="car"/>
            <sql:query dataSource="${db}" var="rs">  
                SELECT * from CAR.CARINFO WHERE NUMBER_PLATE='<c:out value="${param.number_plate}"/>'
            </sql:query>
            
                <center>
                    <div><table id="invoice" style="background-color: white; height: 60%; width: 50%; margin-top: 5%;" border="1" >
                    <tr style="height: 100px;">
                    <td colspan="4" style="font-size: 40px; font-weight: bold; color: #F56363">
                    <center>
                        Car Dealership System
                    </center>
                    </td>
                </tr>
                <c:forEach var="table" items="${rs.rows}">
                    <c:set var="seller_name" value="${table.username}"/>
                    
                    
                    
                    <tr style="height: 60px; font-size: 20px;">
                        <th style="padding: 10px; "> Seller </th>
                        <td style="padding: 10px;"><c:out value="${table.username}"/></td>
                        <th style="padding: 10px;"> Buyer </th>
                        <td style="padding: 10px;"><%=session.getAttribute("username")%></td>
                    </tr>
                    <tr style="height: 300px;">
                        <td colspan="3">
                            <table style="font-size:20px; width: 90%;">
                                <tr><th colspan="2">Car Details</th></tr>
                                <tr><th>Company Name</th><td><c:out value="${table.company_name}"/></td></tr>
                                <tr><th>Model Name</th><td><c:out value="${table.model_name}"/></td></tr>
                                <tr><th>Number Plate</th><td><c:out value="${table.number_plate}"/></td></tr>
                                <tr><th>Model Year</th><td><c:out value="${table.model_year}"/></td></tr>
                                <tr><th>Fuel Type</th><td><c:out value="${table.fuel_type}"/></td></tr>
                                <tr><th>Number Plate</th><td><c:out value="${table.number_plate}"/></td></tr>
                                <tr><th>Total Kilometers</th><td><c:out value="${table.kilometer}"/></td></tr>
                            </table>
                        </td>
                        <td>
                            <table style="font-size: 30px; float: bottom;" >
                                <tr><th>Total Price: </th></tr>
                                <tr><td><c:out value="${table.price}"/></td></tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4"><center>In case of any query contact <a href="#">support.cardealership@gmail.com</a></center></td>
                    </tr>
                </c:forEach>
                
                    
                    </table>
                    </div></center>
                <sql:update dataSource="${db}" var="count">  
                    INSERT INTO CAR.HISTORY VALUES('<c:out value="${param.number_plate}"/>','<%=session.getAttribute("username") %>','<c:out value="${seller_name}"/>')  
                </sql:update>
                <sql:update dataSource="${db}" var="count">  
                    UPDATE CAR.CARINFO SET STATUS = false WHERE NUMBER_PLATE = '<c:out value="${param.number_plate}"/>' and STATUS=true
                </sql:update>
                
                <a class="btn btn-primary" style="color: white;" id="download">Print Receipt</a>                    
        </div>
            <script>
                window.onload = function () {
                    document.getElementById("download")
                        .addEventListener("click", () => {
                            const invoice = this.document.getElementById("invoice");
                            console.log(invoice);
                            console.log(window);
                            var opt = {
                                margin: 50,
                                filename: 'CarDealershipBillReceipt.pdf',
                                html2canvas: { scale: 1 },
                                jsPDF: { unit: 'pt', format: 'a4', orientation: 'landscape' }
                            };
                            html2pdf().from(invoice).set(opt).save();
                        })
                }
            </script>
    </body>
</html>
