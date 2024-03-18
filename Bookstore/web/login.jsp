<%-- 
    Document   : login
    Created on : 15 thg 2, 2024, 19:11:54
    Author     : Win
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles/login.css"/>
        <script
            src="https://kit.fontawesome.com/f7f5b64900.js"
            crossorigin="anonymous"
        ></script>
    </head>
    <body>
        <style><%@include file="styles/login.css"%></style>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="form">
                <h1>Login</h1>
            <c:set var="cookie" value="${pageContext.request.cookies}"/>
            <form class="login-form" action="login" method="post">
                <p class="text-warning">${mess}</p>

                <input type="email" placeholder="Email" name="email" value="${cookie.email.value}">
                <input type="password" placeholder="Password" name="pass" value="${cookie.pass.value}"/>
                    <input type="checkbox" id="rem" name="remember" ${cookie.rem.value != null ? "checked" : ""}> 
                    <label for="rem"> Remember me</label><br>
                <a href="" class="forgot">Forgot your password?</a>
                <button type="submit">Sign in</button>
                <p class="message">Not registered? <a href="register">Create an account</a></p>
            </form>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
