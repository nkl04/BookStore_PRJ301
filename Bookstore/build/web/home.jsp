<%-- 
    Document   : home
    Created on : 15 thg 2, 2024, 19:12:17
    Author     : Win
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <script
            src="https://kit.fontawesome.com/f7f5b64900.js"
            crossorigin="anonymous"
        ></script>
    </head>
    <body>
        <style><%@include file="styles/home.css"%></style>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="banner">
                <div class="banner-image">
                    <img src="images/banner.png" alt="" />
                </div>
                <div class="banner-image-content">
                    <div class="content-box-left">
                        <h3>THE BEST OF 2024</h3>
                        <h1>Meet Your Next Favorite Book.</h1>
                        <div class="btn-group">
                            <a href="collections" class="button">
                                Shop Now
                                <span style="color: #f65d4e; margin-left: 2px"
                                      ><i class="fa-solid fa-caret-right"></i
                                    ></span>
                            </a>
                        </div>
                    </div>
                    <div class="content-box-right">
                        <img src="images/book1.png" alt="" />
                    </div>
                </div>
            </div>

            <div class="bestselling">
                <header class="bestselling-header">
                    <h3 class=>Bestselling</h3>
                </header>

                <div class="book-list">
                <c:forEach var="i" items="${bestselling}" begin="0" end="4">
                    <div class="book-item">
                        <a href="product?id=${i.id}"><img src="images/${i.bookImage}" alt="" /></a>
                        <h4>${i.title}</h4>
                        <div class="rating">
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                            <span class="rating-caption"> 2 </span>
                        </div>
                        <h5>${i.author}</h5>
                        <h2>$${i.price}</h2>
                    </div>
                </c:forEach>


            </div>
        </div>
        <div class="popular">
            <header class="popular-header">
                <h3 class="header-line">Popular Books</h3>
            </header>
            <div class="popular-content">
                <div class="popular-left">
                    <c:forEach var="i" items="${requestScope.latest}">
                        <div class="popular-item">
                            <a href="product?id=${i.id}"><img src="images/${i.bookImage}" alt="" /></a>
                            <h4>${i.title}</h4>
                            <div class="rating">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <span class="rating-caption"> 2 </span>
                            </div>
                            <h5>${i.author}</h5>
                            <h2>$${i.price}</h2>
                        </div>
                    </c:forEach>

                </div>
                <div class="popular-right">
                    <img src="images/Mask_Group.png" alt="">
                    <div class="popular-right-content">
                        <h2>Wonderful Gifts</h2>
                        <p>Give your family and friends a book</p>
                        <div class="btn-group">
                            <a href="collections" class="button-base">
                                Shop Now
                                <span style="color: white; margin-left: 2px"
                                      ><i class="fa-solid fa-caret-right"></i
                                    ></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clientsays">
            <header class="clientsays-header">
                <h3 class=>What Client Says</h3>
            </header>
            <div class="client-contents">
                <div class="client-content">
                    <div class="client-image">
                        <img src="images/reading.png" alt="">
                    </div>
                    <div class="client-quote">
                        “This is the best book store! A wide variety. The prices are great, and there is always a sale of some kind going on. You can find just what you are looking for here.”
                    </div>
                    <div class="client-name">
                        <div>PAM PRUITT / NEW YORK</div>
                    </div>
                </div>
                <div class="client-contents">
                    <div class="client-content">
                        <div class="client-image">
                            <img src="images/reading.png" alt="">
                        </div>
                        <div class="client-quote">
                            “This is the best book store! A wide variety. The prices are great, and there is always a sale of some kind going on. You can find just what you are looking for here.”
                        </div>
                        <div class="client-name">
                            <div>PAM PRUITT / NEW YORK</div>
                        </div>
                    </div>
                    <div class="client-contents">
                        <div class="client-content">
                            <div class="client-image">
                                <img src="images/reading.png" alt="">
                            </div>
                            <div class="client-quote">
                                “This is the best book store! A wide variety. The prices are great, and there is always a sale of some kind going on. You can find just what you are looking for here.”
                            </div>
                            <div class="client-name">
                                <div>PAM PRUITT / NEW YORK</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
