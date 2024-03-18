<%-- 
    Document   : header
    Created on : 15 thg 2, 2024, 19:11:22
    Author     : Win
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.utils.*" %>
<%@ page import="dal.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title> 
        <script
            src="https://kit.fontawesome.com/f7f5b64900.js"
            crossorigin="anonymous"
        ></script>
    </head>
    <body>
        <style><%@include file="styles/header.css"%></style>
        <c:set var="totalCart" value="0"></c:set>
        <c:forEach var="i" items="${cart}">
            <c:set var="totalCart" value="${totalCart + i.quantity}"></c:set>
        </c:forEach>
        <c:set var="totalWish" value="0"></c:set>
        <c:if test="${!wishlist.isEmpty()}">
            <c:set var="totalWish" value="${wishlist.size()}"></c:set>
        </c:if>

        <div class="header">
            <div class="header-content">
                <div class="header-logo">
                    <img src="images/logo.png" alt="logo" width="40px" height="40px" />
                    <a href="home"><h1>BookShop</h1></a>
                </div>
                <div class="header-middle">
                    <div class="header-menu">
                        <button>
                            <div class="header-menu-title">
                                <div>
                                    <i class="fa-solid fa-list"></i>
                                </div>
                                <a href="collections" style="text-decoration: none; color: white"><div>Categories</div></a>
                            </div>
                            <i class="fa-solid fa-caret-down"></i>
                        </button>
                        <div class="categories">
                            <c:forEach items="${genreList}" var="i">
                                <a href="genre?title=${i.path}">${i.title}</a>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="search-box">
                        <form action="search" method="get">
                            <input
                                name="text"
                                value="${txt}"
                                type="text"
                                class="search-input"
                                placeholder="Start Looking For Something!"
                                />
                            <button type="submit" class="search-btn">
                                <!-- Seach Icon -->
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>
                </div>
                <div class="header-links">
                    <div class="header-icon-user">
                        <c:if test="${sessionScope.user == null}">
                            <i class="fa-regular fa-user fa-lg"></i>
                        </c:if>
                        <c:if test="${sessionScope.user != null}">
                            <img src="images/${sessionScope.user.image}" width="40" height="40" style="border-radius: 50%" alt="alt"/>
                        </c:if>
                        <div class="dropdown-content">
                            <c:if test="${sessionScope.user == null}">
                                <a href="login">Login</a>
                                <a href="register">Register</a>
                            </c:if>
                            <c:if test="${sessionScope.user != null}">
                                <a href="logout">Log out</a>
                            </c:if>
                            <c:if test="${sessionScope.user.isAdmin == 1}">
                                <a href="admin">Admin</a>
                            </c:if>
                            <c:if test="${sessionScope.user != null}">
                                <a href="profile">Profile</a>
                            </c:if>
                            <a href="orders?action=view">Orders</a>
                        </div>
                    </div>
                    <div class="header-icon-wishlist">
                        <a href="wishlist" style="text-decoration: none;"> <i class="fa-regular fa-heart fa-lg"> </i></a>
                        <span class="quantity">${totalWish}</span>
                    </div>

                    <div class="header-icon-cart">
                        <a href="cart" style="text-decoration: none;"><i class="fa-solid fa-cart-shopping fa-lg"></i></a>
                        <span class="quantity">${totalCart}</span>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
