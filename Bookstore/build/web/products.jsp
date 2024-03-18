    <%-- 
    Document   : products
    Created on : 15 thg 2, 2024, 20:35:06
    Author     : Win
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles/detail.css"/>
        <script
            src="https://kit.fontawesome.com/f7f5b64900.js"
            crossorigin="anonymous"
        ></script>
    </head>
    <body>
        <style><%@include file="styles/detail.css"%></style>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="mainproduct">
                <div class="book-image">
                    <img src="images/${book.bookImage}" alt="" />
            </div>
            <div class="book-info">
                <span style="font-size: 20px; margin: 30px 0;">${book.author}</span>
                <h1 style="margin-bottom: 50px; font-size: 35px">${book.title}</h1>
                <span style="font-size: 20px;">SKU:</span>
                <c:if test="${book.qtyInStock > 0}">
                    <span class="sku-text">In stock</span>
                </c:if>
                <c:if test="${book.qtyInStock == 0}">
                    <span class="sku-text-out">Out of stock</span>
                </c:if>
                <div class="rating" style="margin: 15px 0;">
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <span class="rating-caption"> 2 </span>
                    <a href="home.jsp"></a>
                </div>
                <h2 style="font-size: 30px">$${book.price}</h2>

                <c:if test="${book.qtyInStock > 0}">
                    <div class="btn-group">
                        <a href="cart?action=buy&id=${book.id}" ><div class="btn-shop">ADD TO CART</div></a>
                    </div>
                </c:if>

            </div>
        </div>
        <div class="container">
            <div class="tab-box">
                <button class="tab-btn active">DESCRIPTION</button>
                <div class="line"></div>
            </div>
            <div class="content-box">
                <div class="content active">
                    <p>
                        ${book.description}
                    <ul>
                        <li>Pages: ${book.pages}</li>
                        <li>Author: ${book.author}</li>
                        <li>Publisher: ${book.publisher}</li>
                        <li>Genre: ${book.genre}</li>
                        <li>Language: ${book.language}</li>
                    </ul>

                    </p>
                </div>
                <div class="bestselling">
                    <header class="bestselling-header" style="margin-top: 50px">
                        <h3 style="font-size: 40px">Bestselling</h3>
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
            </div>
        </div>

        <script>
            const QtyInput = (() => {
                const $qtyInputs = document.querySelectorAll(".qty-input");

                if (!$qtyInputs.length) {
                    return;
                }

                $qtyInputs.forEach(($qtyInput) => {
                    const $inputs = $qtyInput.querySelectorAll(".product-qty");
                    const $minusBtn = $qtyInput.querySelector(".qty-count--minus");
                    const $addBtn = $qtyInput.querySelector(".qty-count--add");
                    const qtyMin = parseInt($inputs[0].getAttribute("min"));
                    const qtyMax = parseInt($inputs[0].getAttribute("max"));

                    $inputs.forEach(($input) => {
                        $input.addEventListener("change", () => {
                            const qty = parseInt($input.value);

                            if (isNaN(qty) || qty <= qtyMin) {
                                $input.value = qtyMin;
                                $minusBtn.setAttribute("disabled", true);
                            } else {
                                $minusBtn.removeAttribute("disabled");
                            }

                            if (qty >= qtyMax) {
                                $input.value = qtyMax;
                                $addBtn.setAttribute("disabled", true);
                            } else {
                                $addBtn.removeAttribute("disabled");
                            }
                        });
                    });

                    $minusBtn.addEventListener("click", () => {
                        const $input = $minusBtn.nextElementSibling;
                        let qty = parseInt($input.value);

                        qty = qty <= qtyMin ? qtyMin : qty - 1;

                        if (qty === qtyMin) {
                            $minusBtn.setAttribute("disabled", true);
                        }

                        if (qty < qtyMax) {
                            $addBtn.removeAttribute("disabled");
                        }

                        $input.value = qty;
                    });

                    $addBtn.addEventListener("click", () => {
                        const $input = $addBtn.previousElementSibling;
                        let qty = parseInt($input.value);

                        qty += 1;

                        if (qty >= qtyMin + 1) {
                            $minusBtn.removeAttribute("disabled");
                        }

                        if (qty >= qtyMax) {
                            $addBtn.setAttribute("disabled", true);
                        }

                        $input.value = qty;
                    });
                });
            })();
            const tabs = document.querySelectorAll(".tab-btn");
            const all_content = document.querySelectorAll(".content");

            tabs.forEach((tab, index) => {
                tab.addEventListener("click", (e) => {
                    tabs.forEach((tab) => {
                        tab.classList.remove("active");
                    });
                    tab.classList.add("active");

                    var line = document.querySelector(".line");
                    line.style.width = e.target.offsetWidth + "px";
                    line.style.left = e.target.offsetLeft + "px";

                    all_content.forEach((content) => {
                        content.classList.remove("active");
                    });
                    all_content[index].classList.add("active");
                });
            });
        </script>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
