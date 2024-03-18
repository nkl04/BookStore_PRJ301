<%-- 
    Document   : orderdetail
    Created on : 5 thg 3, 2024, 00:23:09
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
    </head>
    <body>
        <style><jsp:include page="styles/orderdetail.css"></jsp:include></style>
        <jsp:include page="header.jsp"></jsp:include>
            <h2>Customer Info</h2>
            <hr>
            <div class="container-table100">
                <div class="wrap-table100">
                    <div class="table100">
                        <table>

                            <tbody>
                                <tr>
                                    <td class="column1">ID</td>
                                    <td class="column2">${sessionScope.user.id}</td>
                            </tr>
                            <tr>
                                <td class="column1">First Name</td>
                                <td class="column2">${sessionScope.user.firstName}</td>
                            </tr>
                            <tr>
                                <td class="column1">Last Name</td>
                                <td class="column2">${sessionScope.user.lastName}</td>
                            </tr>
                            <tr>
                                <td class="column1">Email</td>
                                <td class="column2">${sessionScope.user.email}</td>
                            </tr>
                            <tr>
                                <td class="column1">Address</td>
                                <td class="column2">${sessionScope.user.address}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <h2>Order Info</h2>
        <hr>
        <div class="container-table100">
            <div class="wrap-table100">
                <div class="table100">
                    <table>
                        <tbody>
                            <tr>
                                <td class="column1">ID</td>
                                <td class="column2">${orders.ID}</td>
                            </tr>
                            <tr>
                                <td class="column1">Order Date</td>
                                <td class="column2">${orders.orderDate}</td>
                            </tr>

                            <tr>
                                <td class="column1">Order Status</td>
                                <td class="column2">${orders.orderStatus}</td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <h2>Book List</h2>
        <hr>
        <div class="container-table100">
            <div class="wrap-table100">
                <div class="table100">
                    <table>
                        <thead>
                            <tr class="table100-head">
                                <th class="column1">ID</th>
                                <th class="column2">Title</th>
                                <th class="column2">Image</th>
                                <th class="column2">Price</th>
                                <th class="column2">Quantity</th>                                                           
                                <th class="column2">Sub Total</th>

                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="total" value="0"></c:set>
                            <c:forEach var="i" items="${orderLine}">
                                <c:set var="total" value="${total + i.price * i.quantity}"></c:set>
                                    <tr>
                                        <td class="column1">${i.orderID}</td>
                                    <td class="column2">${i.book.title}</td>
                                    <td class="column2"><img src="images/${i.book.bookImage}" alt="" width="80" height="120"/></td>
                                    <td class="column2">${i.price}</td>
                                    <td class="column2">${i.quantity}</td>
                                    <td class="column2">$<fmt:formatNumber type = "number" 
                                                      maxFractionDigits = "2" value = "${i.price * i.quantity}"></fmt:formatNumber></td>


                                    </tr>
                            </c:forEach>
                            <tr >
                                <td colspan="5" align="right">Total</td>
                                <td>$<fmt:formatNumber type = "number" 
                                                  maxFractionDigits = "2" value = "${total}"></fmt:formatNumber></td>
                            </tr>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </body>
</html>
