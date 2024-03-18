<%-- 
    Document   : wishlist
    Created on : 15 thg 2, 2024, 20:35:24
    Author     : Win
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles/wishlist.css"/>
        <script
            src="https://kit.fontawesome.com/f7f5b64900.js"
            crossorigin="anonymous"
        ></script>
    </head>
    <body>
        <style><%@include file="styles/wishlist.css"%></style>
        <jsp:include page="header.jsp"></jsp:include>
            <div>
                <div class="heading">
                    <div class="heading-title">WISHLIST</div>
                </div>
                <div class="list">
                <c:forEach var="i" items="${wishlist}">
                    <div class="book-item">
                        <img src="images/${i.book.bookImage}" alt="" />
                        <h4>${i.book.title}</h4>
                        <div class="rating">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <span class="rating-caption"> 2 </span>
                        </div>
                        <h5>${i.book.author}</h5>
                        <h2>$${i.book.price}</h2>
                    </div>
                </c:forEach>


            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
