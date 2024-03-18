<%-- 
    Document   : orders.jsp
    Created on : 5 thg 3, 2024, 00:11:43
    Author     : Win
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <style><jsp:include page="styles/orders.css"></jsp:include></style>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container-table100">
                <div class="wrap-table100">
                    <div class="table100">
                        <table>
                            <thead>
                                <tr class="table100-head">
                                    <th class="column1">ID</th>
                                    <th class="column2">Order Date</th>
                                    <th class="column2">Order Status</th>
                                    <th class="column2">Action</th>

                                </tr>
                            </thead>
                            <tbody>

                            <c:forEach var="i" items="${requestScope.orders}">
                                <tr>
                                    <td class="column1">${i.ID}</td>
                                    <td class="column2">${i.orderDate}</td>
                                    <td class="column2">${i.orderStatus}</td>

                                    <td>
                                        <a href="orders?action=orderDetail&id=${i.ID}" style="text-decoration: none;"><div class="edit-btn book" v>Detail</div></a>
                                    </td>


                                </tr>
                            </c:forEach>


                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
