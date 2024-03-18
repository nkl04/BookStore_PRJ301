<%-- 
    Document   : collections
    Created on : 15 thg 2, 2024, 20:34:20
    Author     : Win
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--        <link rel="stylesheet" href="styles/collections.css"/>-->
        <script
            src="https://kit.fontawesome.com/f7f5b64900.js"
            crossorigin="anonymous"
        ></script>
        <link
            href="https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css"
            rel="stylesheet"
            />
    </head>
    <body>
        <style><%@include file="styles/collections.css"%></style>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="collections-banner">
                <img src="images/categories-banner.png" alt="" />
                <div class="banner-title">Categories</div>
            </div>
            <div class="container">
                <div class="left-bar">
                    <div class="title-heading">Book Categories</div>
                    <div class="categories-list">
                    <c:forEach items="${genreList}" var="i">
                        <a href="genre?title=${i.path}" class="${tag == i.title ? "active" : ""}">${i.title}</a>
                    </c:forEach>

                </div>
                <div class="title-heading">Filters</div>
                <div class="filter-item">
                    <button>
                        Availability
                        <img src="" alt="" />
                    </button>
                    <div class="availability-input">
                        <div>
                            <input type="radio" name="availability" id="instock" />
                            <label for="instock">In stock</label>
                        </div>
                        <div>
                            <input type="radio" name="availability" id="outstock" />
                            <label for="outstock">Out of stock</label>
                        </div>
                    </div>
                </div>
                <div class="filter-item">
                    <button>
                        Price
                        <img src="" alt="" />
                    </button>
                    <div class="price-input">
                        <div class="field">
                            <span>Min</span>
                            <input type="number" class="input-min" name="minprice" value="" />
                        </div>
                        <div class="separator">to</div>
                        <div class="field">
                            <span>Max</span>
                            <input type="number" class="input-max" name="maxprice" value="" />
                        </div>
                    </div>
                    <div class="slider">
                        <div class="progress"></div>
                    </div>
                    <div class="range-input">
                        <input type="range" class="range-min" min="0" max="" value="" />
                        <input type="range" class="range-max" min="0" max="" value="" />
                    </div>
                </div>
            </div>
            <div class="right-bar">
                <div class="bar">
                    <span class="count-item" style="font-size: 18px">50 products</span>
                    <div class="select-menu">
                        <div style="margin-right: 20px; padding: 5px; font-size: 18px">
                            Sort by
                        </div>
                        <div class="select-btn">
                            <span class="sBtn-text">${sort}</span>
                            <i class="bx bx-chevron-down"></i>
                        </div>
                        <ul class="options">
                            <li class="option">
                                <span class="option-text"
                                      ><a href="collections?sort=title-ascending" style="text-decoration: none; color: black"
                                    >Alphabetically, A-Z</a
                                    ></span
                                >
                            </li>
                            <li class="option">
                                <span class="option-text"
                                      ><a href="collections?sort=title-descending" style="text-decoration: none; color: black"
                                    >Alphabetically, Z-A</a
                                    ></span
                                >
                            </li>
                            <li class="option">
                                <span class="option-text"
                                      ><a href="collections?sort=price-ascending" style="text-decoration: none; color: black"
                                    >Price, low to high</a
                                    ></span
                                >
                            </li>
                            <li class="option">
                                <span class="option-text"
                                      ><a href="collections?sort=price-descending" style="text-decoration: none; color: black"
                                    >Price, high to low</a
                                    ></span
                                >
                            </li>
                            <li class="option">
                                <span class="option-text"
                                      ><a href="collections?sort=date-ascending" style="text-decoration: none; color: black"
                                    >Date, old to new</a
                                    ></span
                                >
                            </li>
                            <li class="option">
                                <span class="option-text"
                                      ><a href="collections?sort=date-descending" style="text-decoration: none; color: black"
                                    >Date, new to old</a
                                    ></span
                                >
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="booklist">
                    <c:forEach items="${bookList}" var="i">
                        <div class="bookitem">
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
                            <c:set var="exist" value="${false}"></c:set>
                                <div class="book-service">
                                <c:if test="${wishlist.size() == 0}">
                                    <a href="wishlist?action=add&id=${i.id}"><button><i class="fa-regular fa-heart"></i></button></a>
                                            </c:if>
                                            <c:if test="${wishlist.size() != 0}">
                                                <c:forEach var="t" items="${wishlist}">
                                                    <c:if test="${t.book.id == i.id}">
                                            <a href="wishlist?action=remove&id=${i.id}"><button><i class="fa-solid fa-heart"></i></button></a>
                                                        <c:set var="exist" value="${true}"></c:set>
                                                    </c:if>
                                                </c:forEach>   
                                            </c:if>
                                            <c:if test="${!exist}">
                                    <a href="wishlist?action=add&id=${i.id}"><button><i class="fa-regular fa-heart"></i></button></a>            
                                            </c:if>

                                <!--                                <a href=""><button><i class="fa-solid fa-heart"></i></button></a>-->

                                <a href="cart?action=buy&id=${i.id}"><button><i class="fa-solid fa-bag-shopping"></i></button></a>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="paging">
                        <c:forEach begin="1" end="${endP}" var="i">
                            <div>
                                <c:if test="${param.title != null}">
                                    <c:if test="${param.sort == null}">
                                        <a href="genre?title=${param.title}&index=${i}">${i}</a>
                                    </c:if>
                                    <c:if test="${param.sort != null}">
                                        <a href="genre?title=${param.title}&index=${i}&sort=${param.sort}">${i}</a>
                                    </c:if>
                                </c:if>
                                <c:if test="${param.title == null}">
                                    <c:if test="${param.sort == null}">
                                        <a href="collections?index=${i}">${i}</a>
                                    </c:if>
                                    <c:if test="${param.sort != null}">
                                        <a href="collections?index=${i}&sort=${param.sort}">${i}</a>
                                    </c:if>
                                </c:if>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        <script>
            const rangeInput = document.querySelectorAll(".range-input input"),
                    priceInput = document.querySelectorAll(".price-input input"),
                    range = document.querySelector(".slider .progress");
            range.style.left = 0 + "%";
            range.style.right = 0 + "%";
            let priceGap = 5;
            priceInput.forEach((input) => {
                input.addEventListener("input", (e) => {
                    let minPrice = parseInt(priceInput[0].value),
                            maxPrice = parseInt(priceInput[1].value);

                    if (
                            maxPrice - minPrice >= priceGap &&
                            maxPrice <= rangeInput[1].max
                            ) {
                        if (e.target.className === "input-min") {
                            rangeInput[0].value = minPrice;
                            range.style.left = (minPrice / rangeInput[0].max) * 100 + "%";
                        } else {
                            rangeInput[1].value = maxPrice;
                            range.style.right =
                                    100 - (maxPrice / rangeInput[1].max) * 100 + "%";
                        }
                    }
                });
            });
            rangeInput.forEach((input) => {
                input.addEventListener("input", (e) => {
                    let minVal = parseInt(rangeInput[0].value),
                            maxVal = parseInt(rangeInput[1].value);
                    if (maxVal - minVal < priceGap) {
                        if (e.target.className === "range-min") {
                            rangeInput[0].value = maxVal - priceGap;
                        } else {
                            rangeInput[1].value = minVal + priceGap;
                        }
                    } else {
                        priceInput[0].value = minVal;
                        priceInput[1].value = maxVal;
                        range.style.left = (minVal / rangeInput[0].max) * 100 + "%";
                        range.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
                    }
                });
            });
            const optionMenu = document.querySelector(".select-menu"),
                    selectBtn = optionMenu.querySelector(".select-btn"),
                    options = optionMenu.querySelectorAll(".option"),
                    sBtn_text = optionMenu.querySelector(".sBtn-text");

            selectBtn.addEventListener("click", () =>
                optionMenu.classList.toggle("sactive")
            );

            options.forEach((option) => {
                option.addEventListener("click", () => {
                    let selectedOption = option.querySelector(".option-text").innerText;
                    sBtn_text.innerText = selectedOption;

                    optionMenu.classList.remove("sactive");
                });
            });
        </script>
    </body>
</html>
