<%-- 
    Document   : profile
    Created on : 24 thg 2, 2024, 11:02:22
    Author     : Win
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="styles/profile.css"/>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <body>
            <div class="profile-panel">
                <form action="profile" method="post" class="form" enctype="multipart/form-data">
                    <div class="avatar-area">
                        <div class="avatar-content">
                            <c:if test="${(sessionScope.user.image == null)}">
                                <img src="images/user.png" alt="" width="100px" height="100px" />
                            </c:if>
                            <c:if test="${sessionScope.user.image.length() > 0}">
                                <img src="images/${sessionScope.user.image}" alt="" width="100px" height="100px" />
                            </c:if>
                            <div class="choose-btn">
                                <input type="file" name="photo" id="uploadBtn" />
                                <label for="uploadBtn">Choose File</label>
                            </div>
                        </div>
                    </div>
                <div class="form-input">
                    <label for="firstname">First Name</label>
                    <input type="text" name="fname" id="firstname" value="${sessionScope.user.firstName}"/>
                </div>
                <div class="form-input">
                    <label for="lastname">Last Name</label>
                    <input type="text" name="lname" id="lastname" value="${sessionScope.user.lastName}"/>
                </div>
                <div class="form-input">
                    <label for="email">Email</label>
                    <input type="text" name="email" id="email" value="${sessionScope.user.email}"/>
                </div>
                <div class="form-input">
                    <label for="address">Address</label>
                    <input type="text" name="address" id="address" value="${sessionScope.user.address}"/>
                </div>
                <div class="btn-area">
                    <input type="submit" value="Save" class="save-btn" />
                </div>
            </form>
        </div>
    </body>
    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
