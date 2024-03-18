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
        <style><%@include file="styles/cart.css"%></style>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="shoppingcart">
                <h1>Shopping Cart</h1>
            <c:set var="total" value="0"></c:set>
            <c:set var="totalCart" value="0"></c:set>
            <c:forEach var="i" items="${cart}">
                <c:set var="totalCart" value="${totalCart + i.quantity}"></c:set>
            </c:forEach>
            <div class="cart-content">
                <div class="cart-content-left">

                    <h3>${totalCart} Books in Cart</h3>
                    <c:forEach var="i" items="${cart}" varStatus="idx">
                        <c:set var="total" value="${total + i.book.price * i.quantity}"></c:set>
                            <div class="cart-item">
                                <img src="images/${i.book.bookImage}" alt="" />
                            <div class="cart-description">
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
                            </div>
                            <div class="qty-input">
                                <form action="cart?action=update&index=${idx.index}" method="post">
                                    <div><label for="">Quantity</label></div>

                                    <div class="form-input">
                                        <input name="quantity" type="number" style="max-width: 34px" min="1" max="${i.book.qtyInStock}" value="${i.quantity}"/>
                                        <button class="" type="submit">
                                            <i class="fa-regular fa-floppy-disk"></i>
                                        </button>
                                    </div>
                                    <span  style="display: inline-block ;margin: 10px 0; font-size: 18px;">Stock: ${i.book.qtyInStock}</span>
                                </form>
                            </div>
                            <div class="cart-action">
                                <div class="action-button">
                                    <a href="cart?action=remove&index=${idx.index}"><button>Remove</button></a>
                                </div>
                                <div class="action-button"><a href="wishlist?action=move&index=${idx.index}&id=${i.book.id}"><button>Move to Wishlist</button></a></div>
                            </div>
                            <div class="cart-price"><h2>$${i.book.price}</h2></div>
                        </div>
                    </c:forEach>
                </div>
                <div class="cart-content-right">
                    <div>
                        <div class="total">Total:</div>
                        <div class="total-price">$<fmt:formatNumber type = "number" 
                                          maxFractionDigits = "2" value = "${total}" /></div>
                    </div>
                    <a href="cart?action=checkout" style="text-decoration: none"><div class="checkout-btn">Checkout</div></a>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
