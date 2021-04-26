<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Account</title>
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
            ::-webkit-scrollbar {
		    width: 0px;  /* Remove scrollbar space */
		    background: transparent;  /* Optional: just make scrollbar invisible */
		}
            .usr{
                color: white;
                font-size: 50px;
                font-weight: bold;
                margin-left: 50px;
                margin-top: 2%;
            }
        </style>
    </head>
    <body style="font-family:'Robosto';">
        <%@ include file="include/navigation.jsp" %>
        <sql:setDataSource var="db" driver="org.apache.derby.jdbc.ClientDriver"  
        url="jdbc:derby://localhost:1527/CarDealership"  
        user="car"  password="car"/>
        
        <div style="width: available; height: 20vh; background: linear-gradient(to bottom, #ffffff 0%, #ff0000 100%);">          
            <sql:query dataSource="${db}" var="rs">  
                SELECT * FROM LOGIN WHERE USERNAME='<%=session.getAttribute("username")%>'
            </sql:query>
            <c:forEach var="table" items="${rs.rows}"> 
                <div class="row">
                    <div class="usr">
                        Username:
                        <c:out value="${table.username}"/>
                    </div>
                    <div class="usr">
                        Email Id:
                        <c:out value="${table.email}"/>
                    </div>
                    <div class="usr">
                        Total Transactions:
                        <sql:query dataSource="${db}" var="cnt">  
                            SELECT COUNT(BUYER) FROM HISTORY WHERE BUYER='<%=session.getAttribute("username")%>' OR SELLER='<%=session.getAttribute("username")%>'
                        </sql:query>
                        <c:forEach var="table1" items="${cnt.rows}">
                            <c:out value="${table1.values()}" />
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
            
            <table class="table">
                <thead>
                <th>Number Plate</th>
                <th>Car Name</th>
                <th>Seller Name</th>
                <th>Buyer Name</th>
                <th>Status</th>
                </thead>
                <tbody>
            <sql:query dataSource="${db}" var="rs">  
                SELECT * FROM CARINFO WHERE USERNAME='<%=session.getAttribute("username")%>' AND STATUS=true
            </sql:query>
            <c:forEach var="table" items="${rs.rows}">
                <tr>
                    <td>
                        <c:out value="${table.number_Plate}"/>
                    </td>
                    <td>
                        <c:out value="${table.Company_Name}"/>
                        <c:out value="${table.Model_Name}"/>
                    </td>
                    <td>
                        <c:out value="${table.Username}"/>
                    </td>
                    <td> - </td>
                    <td> To Be Sold</td>
                </tr>
            </c:forEach>
            <sql:query dataSource="${db}" var="rs">  
                SELECT * FROM CARINFO WHERE NUMBER_PLATE=(SELECT NUMBER_PLATE FROM HISTORY WHERE BUYER='<%=session.getAttribute("username")%>')
            </sql:query>
            <c:forEach var="table" items="${rs.rows}">
                <tr>
                    <td>
                        <c:out value="${table.number_Plate}"/>
                    </td>
                    <td>
                        <c:out value="${table.Company_Name}"/>
                        <c:out value="${table.Model_Name}"/>
                    </td>
                    <td>
                        <c:out value="${table.Username}"/>
                    </td>
                    <td>
                        <%=session.getAttribute("username")%>
                    </td>
                    <td> Bought</td>
                </tr>
            </c:forEach>
            <sql:query dataSource="${db}" var="rs">  
                SELECT * FROM CAR.HISTORY WHERE SELLER='<%=session.getAttribute("username")%>'
            </sql:query>
            <c:forEach var="table" items="${rs.rows}">
                <tr>
                    <td>
                        <c:out value="${table.number_Plate}"/>
                    </td>
                    <td>
                        <sql:query dataSource="${db}" var="rs1">  
                            SELECT * FROM CAR.CARINFO WHERE NUMBER_PLATE='<c:out value="${table.number_Plate}"/>'
                        </sql:query>
                        <c:forEach var="table1" items="${rs1.rows}">
                            <c:out value="${table1.Company_Name}"/>
                            <c:out value="${table1.Model_Name}"/>
                        </c:forEach>
                    </td>
                    <td>
                        <c:out value="${table.Seller}"/>
                    </td>
                    <td>
                        <c:out value="${table.Buyer}"/>
                    </td>
                    <td>Sold</td>
                </tr>
            </c:forEach>
                </tbody>
            </table>
        <div>
            
        </div>
    </body>
</html>