<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            session.setAttribute("query","SELECT * from CAR.CARINFO WHERE STATUS=true");
            response.sendRedirect("dashboard.jsp");
        %>
    </body>
</html>
