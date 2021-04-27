<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.js"></script>
        <link rel="stylesheet" href="css/styles.css">   
        <link rel="stylesheet" href="css/dropdown.css">
        <style>
            ::-webkit-scrollbar {
		    width: 0px;  /* Remove scrollbar space */
		    background: transparent;  /* Optional: just make scrollbar invisible */
		}
            body{
                background: linear-gradient(to bottom, #ffffff 0%, #ff0000 100%);
                height: 100vh;
                background-size: cover;
                font-family: 'Robosto';
            }
            .right{
                position: absolute;
                right: 1%;
                top: 50%;
            }
            .left{
                position: absolute;
                left: 1%;
                top: 50%;
            }
            .upp{
                width: 100%;
                height: 7%;
                background-color: #ffffff;
                margin-top: 2%;
                padding-top: 10px;
                font-size: 40px;
            }
            .no-js #loader { display: none;  }
            .js #loader { display: block; position: absolute; left: 100px; top: 0; }
            .se-pre-con {
                    position: fixed;
                    left: 0px;
                    top: 0px;
                    width: 100%;
                    height: 100%;
                    z-index: 9999;
                    background: url("images/loading.gif") center no-repeat #fff;
            }
        </style>
    </head>
    <body>
        <%@ include file="include/navigation.jsp" %>
        <div class="se-pre-con"></div>
        <div class="right"><a onclick="change(3)"><i style="font-size: 6vh; color: #fff;" class="fa fa-arrow-circle-right"></i></a></div>
        <div class="left"><a onclick="change(-3)"><i style="font-size: 6vh; color: #fff;" class="fa fa-arrow-circle-left"></i></a></div>
        <div class="upp" >
            <a class="btn" href="filtering.jsp" style="width:200px; font-size: 20px; float: left; background-color: #F56363; color: white; border-radius: 20px; margin-bottom: 18px;margin-left: 2%;">
                Filter &nbsp;
                <i class="fa fa-search"></i>
            </a>
            <a href="clear.jsp" style="font-size: 20px; border: 1px solid; border-radius: 5px;color: black; margin-left: 10px;"><i class="fa fa-times"> Clear Filters</i></a>
            <div style="float:right">
                <b>Want to Sell Car ?? &nbsp;&nbsp;&nbsp;</b>
                <a class="btn" href="sellingForm.jsp" style="background-color: red; color: white; border-radius: 20px; margin-bottom: 18px; margin-right: 50px;">Click Here</a>
            </div>
        </div>
        
        <sql:setDataSource var="db" driver="org.apache.derby.jdbc.ClientDriver"  
        url="jdbc:derby://localhost:1527/CarDealership"  
        user="car"  password="car"/>
        <sql:query dataSource="${db}" var="rs">  
            <%=session.getAttribute("query")%>
        </sql:query> 
        <div class="row" style="margin-left: 4%; margin-top: 5%;">
        <c:forEach var="table" items="${rs.rows}">  
            <div class="card" style="width: 30%; margin: 1%">
                <img class="card-img-top" src='files/<c:out value="${table.DISPLAY_IMAGE}"/>' height="450px" onerror="javascript: location.reload();">
            <div class="card-body">
                <h5 class="card-title"><b><c:out value="${table.Company_Name}"/>&nbsp; <c:out value="${table.Model_Name}"/></b></h5>
              <p class="card-text">
              <table style="width:100%">
                  <tr>
                      <td>
                          MODEL: <c:out value="${table.MODEL_YEAR}"/>
                      </td>
                      <td>
                          MILEAGE: <c:out value="${table.MILEAGE}"/>
                      </td>
                  </tr>
                  <tr>
                      <td>
                          KILOMETER <c:out value="${table.KILOMETER}"/>
                      </td>
                      <td>
                          PRICE: <c:out value="${table.PRICE}"/>
                      </td>
                  </tr>
              </table>
                      <br>
              <a href="buying.jsp?number_plate=<c:out value='${table.NUMBER_PLATE}'/>" class="btn btn-primary">Buy</a>
            </div>
          </div>
        </c:forEach>              
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
                var x=document.getElementsByClassName("card");
                if(x.length<4){
                    return;
                }
                if(n<0) {n=0;slide=0;}
                if(n>x.length-3) {n=x.length-3;slide=n;}
//                if(n>x.length) {slide=0;}
                for(i=0;i<x.length;i++){
                    x[i].style.display="none";
                }
                var pos=n%x.length;
                pos=(pos+x.length)%x.length;
                x[pos].style.display="inline";
                x[(pos+1)%x.length].style.display="inline";
                x[(pos+2)%x.length].style.display="inline";
            }
            $(window).load(function() {
                    // Animate loader off screen
                    $(".se-pre-con").fadeOut("slow");;
            });
        </script>
    </body>
</html>
