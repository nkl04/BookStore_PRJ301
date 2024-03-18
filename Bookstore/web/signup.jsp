<%-- 
    Document   : signup
    Created on : 15 thg 2, 2024, 19:12:02
    Author     : Win
--%>

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
                <h1>Create account</h1>
                <form class="register-form" action="register" method="post">
                    <div class="text-warning">${mess}</div>
                <input type="text" placeholder="First name" name="firstName"/>
                <input type="text" placeholder="Last name" name="lastName"/>
                <input type="text" placeholder="Address" name="address"/>
                <input type="text" placeholder="Email" name="email"/>
                <input type="password" placeholder="Password" name="pass"/>

                <button>create</button>
            </form>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
