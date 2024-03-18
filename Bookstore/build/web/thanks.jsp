<%-- 
    Document   : cart
    Created on : 15 thg 2, 2024, 20:35:31
    Author     : Win
--%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles/cart.css"/>
        <script
            src="https://kit.fontawesome.com/f7f5b64900.js"
            crossorigin="anonymous"
        ></script>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <h2 style="text-align: center; margin: 40px 0; font-size: 35px" >Thank you for Shopping</h2>
            <div style="display: flex;justify-content: center; margin: 50px 0">
                <a style="font-size: 20px;display: inline-block; background-color: #f65d4e; padding: 20px 30px; text-decoration: none; color: white;" href="home">
                    Continue Shopping
                </a> 
            </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
