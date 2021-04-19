<%-- 
    Document   : fetch
    Created on : 19-Apr-2021, 1:13:43 pm
    Author     : virad
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            out.println(request.getParameter("name"));
            %>
    </body>
</html>
